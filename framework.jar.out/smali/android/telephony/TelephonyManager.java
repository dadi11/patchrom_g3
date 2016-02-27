package android.telephony;

import android.app.AppOpsManager;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.net.ProxyInfo;
import android.os.Bundle;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemProperties;
import android.provider.Settings.Global;
import android.provider.Settings.SettingNotFoundException;
import android.util.Log;
import android.view.MotionEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.RelativeLayout;
import com.android.internal.telecom.ITelecomService;
import com.android.internal.telephony.IPhoneSubInfo;
import com.android.internal.telephony.ITelephony;
import com.android.internal.telephony.ITelephonyRegistry;
import com.android.internal.telephony.ITelephonyRegistry.Stub;
import com.android.internal.telephony.PhoneConstants.State;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TelephonyManager {
    public static final String ACTION_PHONE_STATE_CHANGED = "android.intent.action.PHONE_STATE";
    public static final String ACTION_PRECISE_CALL_STATE_CHANGED = "android.intent.action.PRECISE_CALL_STATE";
    public static final String ACTION_PRECISE_DATA_CONNECTION_STATE_CHANGED = "android.intent.action.PRECISE_DATA_CONNECTION_STATE_CHANGED";
    public static final String ACTION_RESPOND_VIA_MESSAGE = "android.intent.action.RESPOND_VIA_MESSAGE";
    public static final int CALL_STATE_IDLE = 0;
    public static final int CALL_STATE_OFFHOOK = 2;
    public static final int CALL_STATE_RINGING = 1;
    public static final int CARRIER_PRIVILEGE_STATUS_ERROR_LOADING_RULES = -2;
    public static final int CARRIER_PRIVILEGE_STATUS_HAS_ACCESS = 1;
    public static final int CARRIER_PRIVILEGE_STATUS_NO_ACCESS = 0;
    public static final int CARRIER_PRIVILEGE_STATUS_RULES_NOT_LOADED = -1;
    public static final int DATA_ACTIVITY_DORMANT = 4;
    public static final int DATA_ACTIVITY_IN = 1;
    public static final int DATA_ACTIVITY_INOUT = 3;
    public static final int DATA_ACTIVITY_NONE = 0;
    public static final int DATA_ACTIVITY_OUT = 2;
    public static final int DATA_CONNECTED = 2;
    public static final int DATA_CONNECTING = 1;
    public static final int DATA_DISCONNECTED = 0;
    public static final int DATA_SUSPENDED = 3;
    public static final int DATA_UNKNOWN = -1;
    public static final String EXTRA_BACKGROUND_CALL_STATE = "background_state";
    public static final String EXTRA_DATA_APN = "apn";
    public static final String EXTRA_DATA_APN_TYPE = "apnType";
    public static final String EXTRA_DATA_CHANGE_REASON = "reason";
    public static final String EXTRA_DATA_FAILURE_CAUSE = "failCause";
    public static final String EXTRA_DATA_LINK_PROPERTIES_KEY = "linkProperties";
    public static final String EXTRA_DATA_NETWORK_TYPE = "networkType";
    public static final String EXTRA_DATA_STATE = "state";
    public static final String EXTRA_DISCONNECT_CAUSE = "disconnect_cause";
    public static final String EXTRA_FOREGROUND_CALL_STATE = "foreground_state";
    public static final String EXTRA_INCOMING_NUMBER = "incoming_number";
    public static final String EXTRA_PRECISE_DISCONNECT_CAUSE = "precise_disconnect_cause";
    public static final String EXTRA_RINGING_CALL_STATE = "ringing_state";
    public static final String EXTRA_STATE = "state";
    public static final String EXTRA_STATE_IDLE;
    public static final String EXTRA_STATE_OFFHOOK;
    public static final String EXTRA_STATE_RINGING;
    public static final int NETWORK_CLASS_2_G = 1;
    public static final int NETWORK_CLASS_3_G = 2;
    public static final int NETWORK_CLASS_4_G = 3;
    public static final int NETWORK_CLASS_UNKNOWN = 0;
    public static final int NETWORK_TYPE_1xRTT = 7;
    public static final int NETWORK_TYPE_CDMA = 4;
    public static final int NETWORK_TYPE_EDGE = 2;
    public static final int NETWORK_TYPE_EHRPD = 14;
    public static final int NETWORK_TYPE_EVDO_0 = 5;
    public static final int NETWORK_TYPE_EVDO_A = 6;
    public static final int NETWORK_TYPE_EVDO_B = 12;
    public static final int NETWORK_TYPE_GPRS = 1;
    public static final int NETWORK_TYPE_GSM = 16;
    public static final int NETWORK_TYPE_HSDPA = 8;
    public static final int NETWORK_TYPE_HSPA = 10;
    public static final int NETWORK_TYPE_HSPAP = 15;
    public static final int NETWORK_TYPE_HSUPA = 9;
    public static final int NETWORK_TYPE_IDEN = 11;
    public static final int NETWORK_TYPE_LTE = 13;
    public static final int NETWORK_TYPE_TD_SCDMA = 17;
    public static final int NETWORK_TYPE_UMTS = 3;
    public static final int NETWORK_TYPE_UNKNOWN = 0;
    public static final int PHONE_TYPE_CDMA = 2;
    public static final int PHONE_TYPE_GSM = 1;
    public static final int PHONE_TYPE_NONE = 0;
    public static final int PHONE_TYPE_SIP = 3;
    public static final int SIM_STATE_ABSENT = 1;
    public static final int SIM_STATE_CARD_IO_ERROR = 8;
    public static final int SIM_STATE_NETWORK_LOCKED = 4;
    public static final int SIM_STATE_NOT_READY = 6;
    public static final int SIM_STATE_PERM_DISABLED = 7;
    public static final int SIM_STATE_PIN_REQUIRED = 2;
    public static final int SIM_STATE_PUK_REQUIRED = 3;
    public static final int SIM_STATE_READY = 5;
    public static final int SIM_STATE_UNKNOWN = 0;
    private static final String TAG = "TelephonyManager";
    private static String multiSimConfig;
    private static TelephonyManager sInstance;
    private static final String sKernelCmdLine;
    private static final String sLteOnCdmaProductType;
    private static final Pattern sProductTypePattern;
    private static ITelephonyRegistry sRegistry;
    private final Context mContext;
    private SubscriptionManager mSubscriptionManager;

    /* renamed from: android.telephony.TelephonyManager.1 */
    static /* synthetic */ class C07901 {
        static final /* synthetic */ int[] $SwitchMap$android$telephony$TelephonyManager$MultiSimVariants;

        static {
            $SwitchMap$android$telephony$TelephonyManager$MultiSimVariants = new int[MultiSimVariants.values().length];
            try {
                $SwitchMap$android$telephony$TelephonyManager$MultiSimVariants[MultiSimVariants.UNKNOWN.ordinal()] = TelephonyManager.SIM_STATE_ABSENT;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$android$telephony$TelephonyManager$MultiSimVariants[MultiSimVariants.DSDS.ordinal()] = TelephonyManager.SIM_STATE_PIN_REQUIRED;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$android$telephony$TelephonyManager$MultiSimVariants[MultiSimVariants.DSDA.ordinal()] = TelephonyManager.SIM_STATE_PUK_REQUIRED;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$android$telephony$TelephonyManager$MultiSimVariants[MultiSimVariants.TSTS.ordinal()] = TelephonyManager.SIM_STATE_NETWORK_LOCKED;
            } catch (NoSuchFieldError e4) {
            }
        }
    }

    public enum MultiSimVariants {
        DSDS,
        DSDA,
        TSTS,
        UNKNOWN
    }

    public interface WifiCallingChoices {
        public static final int ALWAYS_USE = 0;
        public static final int ASK_EVERY_TIME = 1;
        public static final int NEVER_USE = 2;
    }

    static {
        multiSimConfig = SystemProperties.get("persist.radio.multisim.config");
        sInstance = new TelephonyManager();
        EXTRA_STATE_IDLE = State.IDLE.toString();
        EXTRA_STATE_RINGING = State.RINGING.toString();
        EXTRA_STATE_OFFHOOK = State.OFFHOOK.toString();
        sKernelCmdLine = getProcCmdLine();
        sProductTypePattern = Pattern.compile("\\sproduct_type\\s*=\\s*(\\w+)");
        sLteOnCdmaProductType = SystemProperties.get("telephony.lteOnCdmaProductType", ProxyInfo.LOCAL_EXCL_LIST);
    }

    public TelephonyManager(Context context) {
        Context appContext = context.getApplicationContext();
        if (appContext != null) {
            this.mContext = appContext;
        } else {
            this.mContext = context;
        }
        this.mSubscriptionManager = SubscriptionManager.from(this.mContext);
        if (sRegistry == null) {
            sRegistry = Stub.asInterface(ServiceManager.getService("telephony.registry"));
        }
    }

    private TelephonyManager() {
        this.mContext = null;
    }

    public static TelephonyManager getDefault() {
        return sInstance;
    }

    public MultiSimVariants getMultiSimConfiguration() {
        String mSimConfig = SystemProperties.get("persist.radio.multisim.config");
        if (mSimConfig.equals("dsds")) {
            return MultiSimVariants.DSDS;
        }
        if (mSimConfig.equals("dsda")) {
            return MultiSimVariants.DSDA;
        }
        if (mSimConfig.equals("tsts")) {
            return MultiSimVariants.TSTS;
        }
        return MultiSimVariants.UNKNOWN;
    }

    public int getPhoneCount() {
        switch (C07901.$SwitchMap$android$telephony$TelephonyManager$MultiSimVariants[getMultiSimConfiguration().ordinal()]) {
            case SIM_STATE_ABSENT /*1*/:
                return SIM_STATE_ABSENT;
            case SIM_STATE_PIN_REQUIRED /*2*/:
            case SIM_STATE_PUK_REQUIRED /*3*/:
                return SIM_STATE_PIN_REQUIRED;
            case SIM_STATE_NETWORK_LOCKED /*4*/:
                return SIM_STATE_PUK_REQUIRED;
            default:
                return SIM_STATE_ABSENT;
        }
    }

    public static TelephonyManager from(Context context) {
        return (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
    }

    public boolean isMultiSimEnabled() {
        return multiSimConfig.equals("dsds") || multiSimConfig.equals("dsda") || multiSimConfig.equals("tsts");
    }

    public String getDeviceSoftwareVersion() {
        return getDeviceSoftwareVersion(getDefaultSim());
    }

    public String getDeviceSoftwareVersion(int slotId) {
        String str = null;
        int[] subId = SubscriptionManager.getSubId(slotId);
        if (!(subId == null || subId.length == 0)) {
            try {
                str = getSubscriberInfo().getDeviceSvnUsingSubId(subId[SIM_STATE_UNKNOWN]);
            } catch (RemoteException e) {
            } catch (NullPointerException e2) {
            }
        }
        return str;
    }

    public String getDeviceId() {
        String str = null;
        try {
            str = getITelephony().getDeviceId();
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getDeviceId(int slotId) {
        String str = null;
        try {
            str = getSubscriberInfo().getDeviceIdForPhone(slotId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getImei() {
        return getImei(getDefaultSim());
    }

    public String getImei(int slotId) {
        String str = null;
        try {
            str = getSubscriberInfo().getImeiForSubscriber(SubscriptionManager.getSubId(slotId)[SIM_STATE_UNKNOWN]);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getNai() {
        return getNai(getDefaultSim());
    }

    public String getNai(int slotId) {
        try {
            String nai = getSubscriberInfo().getNaiForSubscriber(SubscriptionManager.getSubId(slotId)[SIM_STATE_UNKNOWN]);
            if (!Log.isLoggable(TAG, SIM_STATE_PIN_REQUIRED)) {
                return nai;
            }
            Rlog.m19v(TAG, "Nai = " + nai);
            return nai;
        } catch (RemoteException e) {
            return null;
        } catch (NullPointerException e2) {
            return null;
        }
    }

    public CellLocation getCellLocation() {
        try {
            Bundle bundle = getITelephony().getCellLocation();
            if (bundle.isEmpty()) {
                return null;
            }
            CellLocation cl = CellLocation.newFromBundle(bundle);
            if (cl.isEmpty()) {
                return null;
            }
            return cl;
        } catch (RemoteException e) {
            return null;
        } catch (NullPointerException e2) {
            return null;
        }
    }

    public void enableLocationUpdates() {
        enableLocationUpdates(getDefaultSubscription());
    }

    public void enableLocationUpdates(int subId) {
        try {
            getITelephony().enableLocationUpdatesForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
    }

    public void disableLocationUpdates() {
        disableLocationUpdates(getDefaultSubscription());
    }

    public void disableLocationUpdates(int subId) {
        try {
            getITelephony().disableLocationUpdatesForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
    }

    public List<NeighboringCellInfo> getNeighboringCellInfo() {
        List<NeighboringCellInfo> list = null;
        try {
            list = getITelephony().getNeighboringCellInfo(this.mContext.getOpPackageName());
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return list;
    }

    public int getCurrentPhoneType() {
        return getCurrentPhoneType(getDefaultSubscription());
    }

    public int getCurrentPhoneType(int subId) {
        int phoneId = SubscriptionManager.getPhoneId(subId);
        try {
            ITelephony telephony = getITelephony();
            if (telephony != null) {
                return telephony.getActivePhoneTypeForSubscriber(subId);
            }
            return getPhoneTypeFromProperty(phoneId);
        } catch (RemoteException e) {
            return getPhoneTypeFromProperty(phoneId);
        } catch (NullPointerException e2) {
            return getPhoneTypeFromProperty(phoneId);
        }
    }

    public int getPhoneType() {
        if (isVoiceCapable()) {
            return getCurrentPhoneType();
        }
        return SIM_STATE_UNKNOWN;
    }

    private int getPhoneTypeFromProperty() {
        return getPhoneTypeFromProperty(getDefaultPhone());
    }

    private int getPhoneTypeFromProperty(int phoneId) {
        String type = getTelephonyProperty(phoneId, "gsm.current.phone-type", null);
        if (type == null || type.equals(ProxyInfo.LOCAL_EXCL_LIST)) {
            return getPhoneTypeFromNetworkType(phoneId);
        }
        return Integer.parseInt(type);
    }

    private int getPhoneTypeFromNetworkType() {
        return getPhoneTypeFromNetworkType(getDefaultPhone());
    }

    private int getPhoneTypeFromNetworkType(int phoneId) {
        String mode = getTelephonyProperty(phoneId, "ro.telephony.default_network", null);
        if (mode != null) {
            return getPhoneType(Integer.parseInt(mode));
        }
        return SIM_STATE_UNKNOWN;
    }

    public static int getPhoneType(int networkMode) {
        switch (networkMode) {
            case SIM_STATE_UNKNOWN /*0*/:
            case SIM_STATE_ABSENT /*1*/:
            case SIM_STATE_PIN_REQUIRED /*2*/:
            case SIM_STATE_PUK_REQUIRED /*3*/:
            case NETWORK_TYPE_HSUPA /*9*/:
            case NETWORK_TYPE_EVDO_B /*12*/:
            case NETWORK_TYPE_LTE /*13*/:
            case NETWORK_TYPE_EHRPD /*14*/:
            case NETWORK_TYPE_HSPAP /*15*/:
            case NETWORK_TYPE_GSM /*16*/:
            case NETWORK_TYPE_TD_SCDMA /*17*/:
            case RelativeLayout.ALIGN_START /*18*/:
            case RelativeLayout.ALIGN_END /*19*/:
            case RelativeLayout.ALIGN_PARENT_START /*20*/:
                return SIM_STATE_ABSENT;
            case SIM_STATE_NETWORK_LOCKED /*4*/:
            case SIM_STATE_READY /*5*/:
            case SIM_STATE_NOT_READY /*6*/:
            case SIM_STATE_PERM_DISABLED /*7*/:
            case SIM_STATE_CARD_IO_ERROR /*8*/:
            case NETWORK_TYPE_HSPA /*10*/:
            case RelativeLayout.ALIGN_PARENT_END /*21*/:
            case MotionEvent.AXIS_GAS /*22*/:
                return SIM_STATE_PIN_REQUIRED;
            case NETWORK_TYPE_IDEN /*11*/:
                if (getLteOnCdmaModeStatic() != SIM_STATE_ABSENT) {
                    return SIM_STATE_ABSENT;
                }
                return SIM_STATE_PIN_REQUIRED;
            default:
                return SIM_STATE_ABSENT;
        }
    }

    private static String getProcCmdLine() {
        IOException e;
        Throwable th;
        String cmdline = ProxyInfo.LOCAL_EXCL_LIST;
        FileInputStream is = null;
        try {
            FileInputStream is2 = new FileInputStream("/proc/cmdline");
            try {
                byte[] buffer = new byte[AccessibilityNodeInfo.ACTION_PREVIOUS_HTML_ELEMENT];
                int count = is2.read(buffer);
                if (count > 0) {
                    cmdline = new String(buffer, SIM_STATE_UNKNOWN, count);
                }
                if (is2 != null) {
                    try {
                        is2.close();
                        is = is2;
                    } catch (IOException e2) {
                        is = is2;
                    }
                }
            } catch (IOException e3) {
                e = e3;
                is = is2;
                try {
                    Rlog.m13d(TAG, "No /proc/cmdline exception=" + e);
                    if (is != null) {
                        try {
                            is.close();
                        } catch (IOException e4) {
                        }
                    }
                    Rlog.m13d(TAG, "/proc/cmdline=" + cmdline);
                    return cmdline;
                } catch (Throwable th2) {
                    th = th2;
                    if (is != null) {
                        try {
                            is.close();
                        } catch (IOException e5) {
                        }
                    }
                    throw th;
                }
            } catch (Throwable th3) {
                th = th3;
                is = is2;
                if (is != null) {
                    is.close();
                }
                throw th;
            }
        } catch (IOException e6) {
            e = e6;
            Rlog.m13d(TAG, "No /proc/cmdline exception=" + e);
            if (is != null) {
                is.close();
            }
            Rlog.m13d(TAG, "/proc/cmdline=" + cmdline);
            return cmdline;
        }
        Rlog.m13d(TAG, "/proc/cmdline=" + cmdline);
        return cmdline;
    }

    public static int getLteOnCdmaModeStatic() {
        String productType = ProxyInfo.LOCAL_EXCL_LIST;
        int curVal = SystemProperties.getInt("telephony.lteOnCdmaDevice", DATA_UNKNOWN);
        int retVal = curVal;
        if (retVal == DATA_UNKNOWN) {
            Matcher matcher = sProductTypePattern.matcher(sKernelCmdLine);
            if (matcher.find()) {
                productType = matcher.group(SIM_STATE_ABSENT);
                if (sLteOnCdmaProductType.equals(productType)) {
                    retVal = SIM_STATE_ABSENT;
                } else {
                    retVal = SIM_STATE_UNKNOWN;
                }
            } else {
                retVal = SIM_STATE_UNKNOWN;
            }
        }
        Rlog.m13d(TAG, "getLteOnCdmaMode=" + retVal + " curVal=" + curVal + " product_type='" + productType + "' lteOnCdmaProductType='" + sLteOnCdmaProductType + "'");
        return retVal;
    }

    public String getNetworkOperatorName() {
        return getNetworkOperatorName(getDefaultSubscription());
    }

    public String getNetworkOperatorName(int subId) {
        return getTelephonyProperty(SubscriptionManager.getPhoneId(subId), "gsm.operator.alpha", ProxyInfo.LOCAL_EXCL_LIST);
    }

    public String getNetworkOperator() {
        return getNetworkOperatorForPhone(getDefaultPhone());
    }

    public String getNetworkOperatorForSubscription(int subId) {
        return getNetworkOperatorForPhone(SubscriptionManager.getPhoneId(subId));
    }

    public String getNetworkOperatorForPhone(int phoneId) {
        return getTelephonyProperty(phoneId, "gsm.operator.numeric", ProxyInfo.LOCAL_EXCL_LIST);
    }

    public boolean isNetworkRoaming() {
        return isNetworkRoaming(getDefaultSubscription());
    }

    public boolean isNetworkRoaming(int subId) {
        return Boolean.parseBoolean(getTelephonyProperty(SubscriptionManager.getPhoneId(subId), "gsm.operator.isroaming", null));
    }

    public String getNetworkCountryIso() {
        return getNetworkCountryIsoForPhone(getDefaultPhone());
    }

    public String getNetworkCountryIsoForSubscription(int subId) {
        return getNetworkCountryIsoForPhone(SubscriptionManager.getPhoneId(subId));
    }

    public String getNetworkCountryIsoForPhone(int phoneId) {
        return getTelephonyProperty(phoneId, "gsm.operator.iso-country", ProxyInfo.LOCAL_EXCL_LIST);
    }

    public int getNetworkType() {
        return getDataNetworkType();
    }

    public int getNetworkType(int subId) {
        int i = SIM_STATE_UNKNOWN;
        try {
            ITelephony telephony = getITelephony();
            if (telephony != null) {
                i = telephony.getNetworkTypeForSubscriber(subId);
            }
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return i;
    }

    public int getDataNetworkType() {
        return getDataNetworkType(getDefaultSubscription());
    }

    public int getDataNetworkType(int subId) {
        int i = SIM_STATE_UNKNOWN;
        try {
            ITelephony telephony = getITelephony();
            if (telephony != null) {
                i = telephony.getDataNetworkTypeForSubscriber(subId);
            }
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return i;
    }

    public int getVoiceNetworkType() {
        return getVoiceNetworkType(getDefaultSubscription());
    }

    public int getVoiceNetworkType(int subId) {
        int i = SIM_STATE_UNKNOWN;
        try {
            ITelephony telephony = getITelephony();
            if (telephony != null) {
                i = telephony.getVoiceNetworkTypeForSubscriber(subId);
            }
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return i;
    }

    public static int getNetworkClass(int networkType) {
        switch (networkType) {
            case SIM_STATE_ABSENT /*1*/:
            case SIM_STATE_PIN_REQUIRED /*2*/:
            case SIM_STATE_NETWORK_LOCKED /*4*/:
            case SIM_STATE_PERM_DISABLED /*7*/:
            case NETWORK_TYPE_IDEN /*11*/:
            case NETWORK_TYPE_GSM /*16*/:
                return SIM_STATE_ABSENT;
            case SIM_STATE_PUK_REQUIRED /*3*/:
            case SIM_STATE_READY /*5*/:
            case SIM_STATE_NOT_READY /*6*/:
            case SIM_STATE_CARD_IO_ERROR /*8*/:
            case NETWORK_TYPE_HSUPA /*9*/:
            case NETWORK_TYPE_HSPA /*10*/:
            case NETWORK_TYPE_EVDO_B /*12*/:
            case NETWORK_TYPE_EHRPD /*14*/:
            case NETWORK_TYPE_HSPAP /*15*/:
            case NETWORK_TYPE_TD_SCDMA /*17*/:
                return SIM_STATE_PIN_REQUIRED;
            case NETWORK_TYPE_LTE /*13*/:
                return SIM_STATE_PUK_REQUIRED;
            default:
                return SIM_STATE_UNKNOWN;
        }
    }

    public String getNetworkTypeName() {
        return getNetworkTypeName(getNetworkType());
    }

    public static String getNetworkTypeName(int type) {
        switch (type) {
            case SIM_STATE_ABSENT /*1*/:
                return "GPRS";
            case SIM_STATE_PIN_REQUIRED /*2*/:
                return "EDGE";
            case SIM_STATE_PUK_REQUIRED /*3*/:
                return "UMTS";
            case SIM_STATE_NETWORK_LOCKED /*4*/:
                return "CDMA";
            case SIM_STATE_READY /*5*/:
                return "CDMA - EvDo rev. 0";
            case SIM_STATE_NOT_READY /*6*/:
                return "CDMA - EvDo rev. A";
            case SIM_STATE_PERM_DISABLED /*7*/:
                return "CDMA - 1xRTT";
            case SIM_STATE_CARD_IO_ERROR /*8*/:
                return "HSDPA";
            case NETWORK_TYPE_HSUPA /*9*/:
                return "HSUPA";
            case NETWORK_TYPE_HSPA /*10*/:
                return "HSPA";
            case NETWORK_TYPE_IDEN /*11*/:
                return "iDEN";
            case NETWORK_TYPE_EVDO_B /*12*/:
                return "CDMA - EvDo rev. B";
            case NETWORK_TYPE_LTE /*13*/:
                return "LTE";
            case NETWORK_TYPE_EHRPD /*14*/:
                return "CDMA - eHRPD";
            case NETWORK_TYPE_HSPAP /*15*/:
                return "HSPA+";
            case NETWORK_TYPE_GSM /*16*/:
                return "GSM";
            case NETWORK_TYPE_TD_SCDMA /*17*/:
                return "TD_SCDMA";
            default:
                return "UNKNOWN";
        }
    }

    public boolean hasIccCard() {
        return hasIccCard(getDefaultSim());
    }

    public boolean hasIccCard(int slotId) {
        boolean z = false;
        try {
            z = getITelephony().hasIccCardUsingSlotId(slotId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return z;
    }

    public int getSimState() {
        return getSimState(getDefaultSim());
    }

    public int getSimState(int slotIdx) {
        int[] subId = SubscriptionManager.getSubId(slotIdx);
        if (subId != null && subId.length != 0) {
            return SubscriptionManager.getSimStateForSubscriber(subId[SIM_STATE_UNKNOWN]);
        }
        Rlog.m13d(TAG, "getSimState:- empty subId return SIM_STATE_ABSENT");
        return SIM_STATE_UNKNOWN;
    }

    public String getSimOperator() {
        return getSimOperatorNumeric();
    }

    public String getSimOperator(int subId) {
        return getSimOperatorNumericForSubscription(subId);
    }

    public String getSimOperatorNumeric() {
        int subId = SubscriptionManager.getDefaultDataSubId();
        if (!SubscriptionManager.isUsableSubIdValue(subId)) {
            subId = SubscriptionManager.getDefaultSmsSubId();
            if (!SubscriptionManager.isUsableSubIdValue(subId)) {
                subId = SubscriptionManager.getDefaultVoiceSubId();
                if (!SubscriptionManager.isUsableSubIdValue(subId)) {
                    subId = SubscriptionManager.getDefaultSubId();
                }
            }
        }
        return getSimOperatorNumericForSubscription(subId);
    }

    public String getSimOperatorNumericForSubscription(int subId) {
        return getSimOperatorNumericForPhone(SubscriptionManager.getPhoneId(subId));
    }

    public String getSimOperatorNumericForPhone(int phoneId) {
        return getTelephonyProperty(phoneId, "gsm.sim.operator.numeric", ProxyInfo.LOCAL_EXCL_LIST);
    }

    public String getSimOperatorName() {
        return getSimOperatorNameForPhone(getDefaultPhone());
    }

    public String getSimOperatorNameForSubscription(int subId) {
        return getSimOperatorNameForPhone(SubscriptionManager.getPhoneId(subId));
    }

    public String getSimOperatorNameForPhone(int phoneId) {
        return getTelephonyProperty(phoneId, "gsm.sim.operator.alpha", ProxyInfo.LOCAL_EXCL_LIST);
    }

    public String getSimCountryIso() {
        return getSimCountryIsoForPhone(getDefaultPhone());
    }

    public String getSimCountryIso(int subId) {
        return getSimCountryIsoForSubscription(subId);
    }

    public String getSimCountryIsoForSubscription(int subId) {
        return getSimCountryIsoForPhone(SubscriptionManager.getPhoneId(subId));
    }

    public String getSimCountryIsoForPhone(int phoneId) {
        return getTelephonyProperty(phoneId, "gsm.sim.operator.iso-country", ProxyInfo.LOCAL_EXCL_LIST);
    }

    public String getSimSerialNumber() {
        return getSimSerialNumber(getDefaultSubscription());
    }

    public String getSimSerialNumber(int subId) {
        String str = null;
        try {
            str = getSubscriberInfo().getIccSerialNumberForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public int getLteOnCdmaMode() {
        return getLteOnCdmaMode(getDefaultSubscription());
    }

    public int getLteOnCdmaMode(int subId) {
        int i = DATA_UNKNOWN;
        try {
            i = getITelephony().getLteOnCdmaModeForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return i;
    }

    public String getSubscriberId() {
        return getSubscriberId(getDefaultSubscription());
    }

    public String getSubscriberId(int subId) {
        String str = null;
        try {
            str = getSubscriberInfo().getSubscriberIdForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getGroupIdLevel1() {
        String str = null;
        try {
            str = getSubscriberInfo().getGroupIdLevel1();
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getGroupIdLevel1(int subId) {
        String str = null;
        try {
            str = getSubscriberInfo().getGroupIdLevel1ForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getLine1Number() {
        return getLine1NumberForSubscriber(getDefaultSubscription());
    }

    public String getLine1NumberForSubscriber(int subId) {
        String number = null;
        try {
            number = getITelephony().getLine1NumberForDisplay(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        if (number != null) {
            return number;
        }
        try {
            return getSubscriberInfo().getLine1NumberForSubscriber(subId);
        } catch (RemoteException e3) {
            return null;
        } catch (NullPointerException e4) {
            return null;
        }
    }

    public boolean setLine1NumberForDisplay(String alphaTag, String number) {
        return setLine1NumberForDisplayForSubscriber(getDefaultSubscription(), alphaTag, number);
    }

    public boolean setLine1NumberForDisplayForSubscriber(int subId, String alphaTag, String number) {
        try {
            return getITelephony().setLine1NumberForDisplayForSubscriber(subId, alphaTag, number);
        } catch (RemoteException e) {
            return false;
        } catch (NullPointerException e2) {
            return false;
        }
    }

    public String getLine1AlphaTag() {
        return getLine1AlphaTagForSubscriber(getDefaultSubscription());
    }

    public String getLine1AlphaTagForSubscriber(int subId) {
        String alphaTag = null;
        try {
            alphaTag = getITelephony().getLine1AlphaTagForDisplay(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        if (alphaTag != null) {
            return alphaTag;
        }
        try {
            return getSubscriberInfo().getLine1AlphaTagForSubscriber(subId);
        } catch (RemoteException e3) {
            return null;
        } catch (NullPointerException e4) {
            return null;
        }
    }

    public String[] getMergedSubscriberIds() {
        try {
            return getITelephony().getMergedSubscriberIds();
        } catch (RemoteException e) {
            return null;
        } catch (NullPointerException e2) {
            return null;
        }
    }

    public String getMsisdn() {
        return getMsisdn(getDefaultSubscription());
    }

    public String getMsisdn(int subId) {
        String str = null;
        try {
            str = getSubscriberInfo().getMsisdnForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getVoiceMailNumber() {
        return getVoiceMailNumber(getDefaultSubscription());
    }

    public String getVoiceMailNumber(int subId) {
        String str = null;
        try {
            str = getSubscriberInfo().getVoiceMailNumberForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getCompleteVoiceMailNumber() {
        return getCompleteVoiceMailNumber(getDefaultSubscription());
    }

    public String getCompleteVoiceMailNumber(int subId) {
        String str = null;
        try {
            str = getSubscriberInfo().getCompleteVoiceMailNumberForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public boolean setVoiceMailNumber(String alphaTag, String number) {
        return setVoiceMailNumber(getDefaultSubscription(), alphaTag, number);
    }

    public boolean setVoiceMailNumber(int subId, String alphaTag, String number) {
        try {
            return getITelephony().setVoiceMailNumber(subId, alphaTag, number);
        } catch (RemoteException e) {
            return false;
        } catch (NullPointerException e2) {
            return false;
        }
    }

    public int getVoiceMessageCount() {
        return getVoiceMessageCount(getDefaultSubscription());
    }

    public int getVoiceMessageCount(int subId) {
        int i = SIM_STATE_UNKNOWN;
        try {
            i = getITelephony().getVoiceMessageCountForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return i;
    }

    public String getVoiceMailAlphaTag() {
        return getVoiceMailAlphaTag(getDefaultSubscription());
    }

    public String getVoiceMailAlphaTag(int subId) {
        String str = null;
        try {
            str = getSubscriberInfo().getVoiceMailAlphaTagForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getIsimImpi() {
        String str = null;
        try {
            str = getSubscriberInfo().getIsimImpi();
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getIsimDomain() {
        String str = null;
        try {
            str = getSubscriberInfo().getIsimDomain();
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String[] getIsimImpu() {
        String[] strArr = null;
        try {
            strArr = getSubscriberInfo().getIsimImpu();
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return strArr;
    }

    private IPhoneSubInfo getSubscriberInfo() {
        return IPhoneSubInfo.Stub.asInterface(ServiceManager.getService("iphonesubinfo"));
    }

    public int getCallState() {
        try {
            return getTelecomService().getCallState();
        } catch (RemoteException e) {
            return SIM_STATE_UNKNOWN;
        } catch (NullPointerException e2) {
            return SIM_STATE_UNKNOWN;
        }
    }

    public int getCallState(int subId) {
        int i = SIM_STATE_UNKNOWN;
        try {
            i = getITelephony().getCallStateForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return i;
    }

    public int getDataActivity() {
        int i = SIM_STATE_UNKNOWN;
        try {
            i = getITelephony().getDataActivity();
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return i;
    }

    public int getDataState() {
        int i = SIM_STATE_UNKNOWN;
        try {
            i = getITelephony().getDataState();
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return i;
    }

    private ITelephony getITelephony() {
        return ITelephony.Stub.asInterface(ServiceManager.getService(Context.TELEPHONY_SERVICE));
    }

    private ITelecomService getTelecomService() {
        return ITelecomService.Stub.asInterface(ServiceManager.getService(Context.TELECOM_SERVICE));
    }

    public void listen(PhoneStateListener listener, int events) {
        try {
            sRegistry.listenForSubscriber(listener.mSubId, this.mContext != null ? this.mContext.getPackageName() : "<unknown>", listener.callback, events, Boolean.valueOf(getITelephony() != null).booleanValue());
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
    }

    public int getCdmaEriIconIndex() {
        return getCdmaEriIconIndex(getDefaultSubscription());
    }

    public int getCdmaEriIconIndex(int subId) {
        int i = DATA_UNKNOWN;
        try {
            i = getITelephony().getCdmaEriIconIndexForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return i;
    }

    public int getCdmaEriIconMode() {
        return getCdmaEriIconMode(getDefaultSubscription());
    }

    public int getCdmaEriIconMode(int subId) {
        int i = DATA_UNKNOWN;
        try {
            i = getITelephony().getCdmaEriIconModeForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return i;
    }

    public String getCdmaEriText() {
        return getCdmaEriText(getDefaultSubscription());
    }

    public String getCdmaEriText(int subId) {
        String str = null;
        try {
            str = getITelephony().getCdmaEriTextForSubscriber(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public boolean isVoiceCapable() {
        if (this.mContext == null) {
            return true;
        }
        return this.mContext.getResources().getBoolean(17956946);
    }

    public boolean isSmsCapable() {
        if (this.mContext == null) {
            return true;
        }
        return this.mContext.getResources().getBoolean(17956948);
    }

    public List<CellInfo> getAllCellInfo() {
        List<CellInfo> list = null;
        try {
            list = getITelephony().getAllCellInfo();
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return list;
    }

    public void setCellInfoListRate(int rateInMillis) {
        try {
            getITelephony().setCellInfoListRate(rateInMillis);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
    }

    public String getMmsUserAgent() {
        if (this.mContext == null) {
            return null;
        }
        return this.mContext.getResources().getString(17039413);
    }

    public String getMmsUAProfUrl() {
        if (this.mContext == null) {
            return null;
        }
        return this.mContext.getResources().getString(17039414);
    }

    public IccOpenLogicalChannelResponse iccOpenLogicalChannel(String AID) {
        try {
            return getITelephony().iccOpenLogicalChannel(AID);
        } catch (RemoteException e) {
            return null;
        } catch (NullPointerException e2) {
            return null;
        }
    }

    public boolean iccCloseLogicalChannel(int channel) {
        try {
            return getITelephony().iccCloseLogicalChannel(channel);
        } catch (RemoteException e) {
            return false;
        } catch (NullPointerException e2) {
            return false;
        }
    }

    public String iccTransmitApduLogicalChannel(int channel, int cla, int instruction, int p1, int p2, int p3, String data) {
        try {
            return getITelephony().iccTransmitApduLogicalChannel(channel, cla, instruction, p1, p2, p3, data);
        } catch (RemoteException e) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        } catch (NullPointerException e2) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        }
    }

    public String iccTransmitApduBasicChannel(int cla, int instruction, int p1, int p2, int p3, String data) {
        try {
            return getITelephony().iccTransmitApduBasicChannel(cla, instruction, p1, p2, p3, data);
        } catch (RemoteException e) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        } catch (NullPointerException e2) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        }
    }

    public byte[] iccExchangeSimIO(int fileID, int command, int p1, int p2, int p3, String filePath) {
        try {
            return getITelephony().iccExchangeSimIO(fileID, command, p1, p2, p3, filePath);
        } catch (RemoteException e) {
            return null;
        } catch (NullPointerException e2) {
            return null;
        }
    }

    public String sendEnvelopeWithStatus(String content) {
        try {
            return getITelephony().sendEnvelopeWithStatus(content);
        } catch (RemoteException e) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        } catch (NullPointerException e2) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        }
    }

    public String nvReadItem(int itemID) {
        try {
            return getITelephony().nvReadItem(itemID);
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "nvReadItem RemoteException", ex);
            return ProxyInfo.LOCAL_EXCL_LIST;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "nvReadItem NPE", ex2);
            return ProxyInfo.LOCAL_EXCL_LIST;
        }
    }

    public boolean nvWriteItem(int itemID, String itemValue) {
        try {
            return getITelephony().nvWriteItem(itemID, itemValue);
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "nvWriteItem RemoteException", ex);
            return false;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "nvWriteItem NPE", ex2);
            return false;
        }
    }

    public boolean nvWriteCdmaPrl(byte[] preferredRoamingList) {
        try {
            return getITelephony().nvWriteCdmaPrl(preferredRoamingList);
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "nvWriteCdmaPrl RemoteException", ex);
            return false;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "nvWriteCdmaPrl NPE", ex2);
            return false;
        }
    }

    public boolean nvResetConfig(int resetType) {
        try {
            return getITelephony().nvResetConfig(resetType);
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "nvResetConfig RemoteException", ex);
            return false;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "nvResetConfig NPE", ex2);
            return false;
        }
    }

    private static int getDefaultSubscription() {
        return SubscriptionManager.getDefaultSubId();
    }

    private static int getDefaultPhone() {
        return SubscriptionManager.getPhoneId(SubscriptionManager.getDefaultSubId());
    }

    public int getDefaultSim() {
        return SubscriptionManager.getSlotId(SubscriptionManager.getDefaultSubId());
    }

    public static void setTelephonyProperty(int phoneId, String property, String value) {
        String propVal = ProxyInfo.LOCAL_EXCL_LIST;
        String[] p = null;
        String prop = SystemProperties.get(property);
        if (value == null) {
            value = ProxyInfo.LOCAL_EXCL_LIST;
        }
        if (prop != null) {
            p = prop.split(",");
        }
        if (SubscriptionManager.isValidPhoneId(phoneId)) {
            int i = SIM_STATE_UNKNOWN;
            while (i < phoneId) {
                String str = ProxyInfo.LOCAL_EXCL_LIST;
                if (p != null && i < p.length) {
                    str = p[i];
                }
                propVal = propVal + str + ",";
                i += SIM_STATE_ABSENT;
            }
            propVal = propVal + value;
            if (p != null) {
                for (i = phoneId + SIM_STATE_ABSENT; i < p.length; i += SIM_STATE_ABSENT) {
                    propVal = propVal + "," + p[i];
                }
            }
            if (property.length() > 31 || propVal.length() > 91) {
                Rlog.m13d(TAG, "setTelephonyProperty: property to long phoneId=" + phoneId + " property=" + property + " value: " + value + " propVal=" + propVal);
                return;
            }
            Rlog.m13d(TAG, "setTelephonyProperty: success phoneId=" + phoneId + " property=" + property + " value: " + value + " propVal=" + propVal);
            SystemProperties.set(property, propVal);
            return;
        }
        Rlog.m13d(TAG, "setTelephonyProperty: invalid phoneId=" + phoneId + " property=" + property + " value: " + value + " prop=" + prop);
    }

    public static int getIntAtIndex(ContentResolver cr, String name, int index) throws SettingNotFoundException {
        String v = Global.getString(cr, name);
        if (v != null) {
            String[] valArray = v.split(",");
            if (index >= 0 && index < valArray.length && valArray[index] != null) {
                try {
                    return Integer.parseInt(valArray[index]);
                } catch (NumberFormatException e) {
                }
            }
        }
        throw new SettingNotFoundException(name);
    }

    public static boolean putIntAtIndex(ContentResolver cr, String name, int index, int value) {
        String data = ProxyInfo.LOCAL_EXCL_LIST;
        String[] valArray = null;
        String v = Global.getString(cr, name);
        if (index == ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED) {
            throw new RuntimeException("putIntAtIndex index == MAX_VALUE index=" + index);
        } else if (index < 0) {
            throw new RuntimeException("putIntAtIndex index < 0 index=" + index);
        } else {
            if (v != null) {
                valArray = v.split(",");
            }
            int i = SIM_STATE_UNKNOWN;
            while (i < index) {
                String str = ProxyInfo.LOCAL_EXCL_LIST;
                if (valArray != null && i < valArray.length) {
                    str = valArray[i];
                }
                data = data + str + ",";
                i += SIM_STATE_ABSENT;
            }
            data = data + value;
            if (valArray != null) {
                for (i = index + SIM_STATE_ABSENT; i < valArray.length; i += SIM_STATE_ABSENT) {
                    data = data + "," + valArray[i];
                }
            }
            return Global.putString(cr, name, data);
        }
    }

    public static String getTelephonyProperty(int phoneId, String property, String defaultVal) {
        String propVal = null;
        String prop = SystemProperties.get(property);
        if (prop != null && prop.length() > 0) {
            String[] values = prop.split(",");
            if (phoneId >= 0 && phoneId < values.length && values[phoneId] != null) {
                propVal = values[phoneId];
            }
        }
        Rlog.m13d(TAG, "getTelephonyProperty: return propVal='" + propVal + "' phoneId=" + phoneId + " property='" + property + "' defaultVal='" + defaultVal + "' prop=" + prop);
        return propVal == null ? defaultVal : propVal;
    }

    public int getSimCount() {
        if (isMultiSimEnabled()) {
            return SIM_STATE_PIN_REQUIRED;
        }
        return SIM_STATE_ABSENT;
    }

    public String getIsimIst() {
        String str = null;
        try {
            str = getSubscriberInfo().getIsimIst();
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String[] getIsimPcscf() {
        String[] strArr = null;
        try {
            strArr = getSubscriberInfo().getIsimPcscf();
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return strArr;
    }

    public String getIsimChallengeResponse(String nonce) {
        String str = null;
        try {
            str = getSubscriberInfo().getIsimChallengeResponse(nonce);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getIccSimChallengeResponse(int subId, int appType, String data) {
        String str = null;
        try {
            str = getSubscriberInfo().getIccSimChallengeResponse(subId, appType, data);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getIccSimChallengeResponse(int appType, String data) {
        return getIccSimChallengeResponse(getDefaultSubscription(), appType, data);
    }

    public String[] getPcscfAddress(String apnType) {
        try {
            return getITelephony().getPcscfAddress(apnType);
        } catch (RemoteException e) {
            return new String[SIM_STATE_UNKNOWN];
        }
    }

    public void setImsRegistrationState(boolean registered) {
        try {
            getITelephony().setImsRegistrationState(registered);
        } catch (RemoteException e) {
        }
    }

    public int getPreferredNetworkType() {
        try {
            return getITelephony().getPreferredNetworkType();
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "getPreferredNetworkType RemoteException", ex);
            return DATA_UNKNOWN;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "getPreferredNetworkType NPE", ex2);
            return DATA_UNKNOWN;
        }
    }

    public boolean setPreferredNetworkType(int networkType) {
        try {
            return getITelephony().setPreferredNetworkType(networkType);
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "setPreferredNetworkType RemoteException", ex);
            return false;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "setPreferredNetworkType NPE", ex2);
            return false;
        }
    }

    public boolean setPreferredNetworkTypeToGlobal() {
        return setPreferredNetworkType(NETWORK_TYPE_HSPA);
    }

    public int getTetherApnRequired() {
        try {
            return getITelephony().getTetherApnRequired();
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "hasMatchedTetherApnSetting RemoteException", ex);
            return SIM_STATE_PIN_REQUIRED;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "hasMatchedTetherApnSetting NPE", ex2);
            return SIM_STATE_PIN_REQUIRED;
        }
    }

    public boolean hasCarrierPrivileges() {
        try {
            return getITelephony().getCarrierPrivilegeStatus() == SIM_STATE_ABSENT;
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "hasCarrierPrivileges RemoteException", ex);
            return false;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "hasCarrierPrivileges NPE", ex2);
            return false;
        }
    }

    public boolean setOperatorBrandOverride(String brand) {
        try {
            return getITelephony().setOperatorBrandOverride(brand);
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "setOperatorBrandOverride RemoteException", ex);
            return false;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "setOperatorBrandOverride NPE", ex2);
            return false;
        }
    }

    public boolean setRoamingOverride(List<String> gsmRoamingList, List<String> gsmNonRoamingList, List<String> cdmaRoamingList, List<String> cdmaNonRoamingList) {
        try {
            return getITelephony().setRoamingOverride(gsmRoamingList, gsmNonRoamingList, cdmaRoamingList, cdmaNonRoamingList);
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "setRoamingOverride RemoteException", ex);
            return false;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "setRoamingOverride NPE", ex2);
            return false;
        }
    }

    public String getCdmaMdn() {
        return getCdmaMdn(getDefaultSubscription());
    }

    public String getCdmaMdn(int subId) {
        String str = null;
        try {
            str = getITelephony().getCdmaMdn(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public String getCdmaMin() {
        return getCdmaMin(getDefaultSubscription());
    }

    public String getCdmaMin(int subId) {
        String str = null;
        try {
            str = getITelephony().getCdmaMin(subId);
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return str;
    }

    public int checkCarrierPrivilegesForPackage(String pkgname) {
        try {
            return getITelephony().checkCarrierPrivilegesForPackage(pkgname);
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "checkCarrierPrivilegesForPackage RemoteException", ex);
            return SIM_STATE_UNKNOWN;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "checkCarrierPrivilegesForPackage NPE", ex2);
            return SIM_STATE_UNKNOWN;
        }
    }

    public List<String> getCarrierPackageNamesForIntent(Intent intent) {
        try {
            return getITelephony().getCarrierPackageNamesForIntent(intent);
        } catch (RemoteException ex) {
            Rlog.m16e(TAG, "getCarrierPackageNamesForIntent RemoteException", ex);
            return null;
        } catch (NullPointerException ex2) {
            Rlog.m16e(TAG, "getCarrierPackageNamesForIntent NPE", ex2);
            return null;
        }
    }

    public void dial(String number) {
        try {
            getITelephony().dial(number);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#dial", e);
        }
    }

    public void call(String callingPackage, String number) {
        try {
            getITelephony().call(callingPackage, number);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#call", e);
        }
    }

    public boolean endCall() {
        try {
            return getITelephony().endCall();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#endCall", e);
            return false;
        }
    }

    public void answerRingingCall() {
        try {
            getITelephony().answerRingingCall();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#answerRingingCall", e);
        }
    }

    public void silenceRinger() {
        try {
            getTelecomService().silenceRinger();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelecomService#silenceRinger", e);
        }
    }

    public boolean isOffhook() {
        try {
            return getITelephony().isOffhook();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#isOffhook", e);
            return false;
        }
    }

    public boolean isRinging() {
        try {
            return getITelephony().isRinging();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#isRinging", e);
            return false;
        }
    }

    public boolean isIdle() {
        try {
            return getITelephony().isIdle();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#isIdle", e);
            return true;
        }
    }

    public boolean isRadioOn() {
        try {
            return getITelephony().isRadioOn();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#isRadioOn", e);
            return false;
        }
    }

    public boolean isSimPinEnabled() {
        try {
            return getITelephony().isSimPinEnabled();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#isSimPinEnabled", e);
            return false;
        }
    }

    public boolean supplyPin(String pin) {
        try {
            return getITelephony().supplyPin(pin);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#supplyPin", e);
            return false;
        }
    }

    public boolean supplyPuk(String puk, String pin) {
        try {
            return getITelephony().supplyPuk(puk, pin);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#supplyPuk", e);
            return false;
        }
    }

    public int[] supplyPinReportResult(String pin) {
        try {
            return getITelephony().supplyPinReportResult(pin);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#supplyPinReportResult", e);
            return new int[SIM_STATE_UNKNOWN];
        }
    }

    public int[] supplyPukReportResult(String puk, String pin) {
        try {
            return getITelephony().supplyPukReportResult(puk, pin);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#]", e);
            return new int[SIM_STATE_UNKNOWN];
        }
    }

    public boolean handlePinMmi(String dialString) {
        try {
            return getITelephony().handlePinMmi(dialString);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#handlePinMmi", e);
            return false;
        }
    }

    public boolean handlePinMmiForSubscriber(int subId, String dialString) {
        try {
            return getITelephony().handlePinMmiForSubscriber(subId, dialString);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#handlePinMmi", e);
            return false;
        }
    }

    public void toggleRadioOnOff() {
        try {
            getITelephony().toggleRadioOnOff();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#toggleRadioOnOff", e);
        }
    }

    public boolean setRadio(boolean turnOn) {
        try {
            return getITelephony().setRadio(turnOn);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#setRadio", e);
            return false;
        }
    }

    public boolean setRadioPower(boolean turnOn) {
        try {
            return getITelephony().setRadioPower(turnOn);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#setRadioPower", e);
            return false;
        }
    }

    public void updateServiceLocation() {
        try {
            getITelephony().updateServiceLocation();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#updateServiceLocation", e);
        }
    }

    public boolean enableDataConnectivity() {
        try {
            return getITelephony().enableDataConnectivity();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#enableDataConnectivity", e);
            return false;
        }
    }

    public boolean disableDataConnectivity() {
        try {
            return getITelephony().disableDataConnectivity();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#disableDataConnectivity", e);
            return false;
        }
    }

    public boolean isDataConnectivityPossible() {
        try {
            return getITelephony().isDataConnectivityPossible();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#isDataConnectivityPossible", e);
            return false;
        }
    }

    public boolean needsOtaServiceProvisioning() {
        try {
            return getITelephony().needsOtaServiceProvisioning();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#needsOtaServiceProvisioning", e);
            return false;
        }
    }

    public void setDataEnabled(boolean enable) {
        setDataEnabled(SubscriptionManager.getDefaultDataSubId(), enable);
    }

    public void setDataEnabled(int subId, boolean enable) {
        try {
            AppOpsManager appOps = (AppOpsManager) this.mContext.getSystemService(Context.APP_OPS_SERVICE);
            if (!enable || appOps.noteOp(59) == 0) {
                Log.d(TAG, "setDataEnabled: enabled=" + enable);
                getITelephony().setDataEnabled(subId, enable);
                return;
            }
            Log.w(TAG, "Permission denied by user.");
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling setDataEnabled", e);
        } catch (NullPointerException npe) {
            Log.e(TAG, "Error calling setDataEnabled", npe);
        }
    }

    public boolean getDataEnabled() {
        return getDataEnabled(SubscriptionManager.getDefaultDataSubId());
    }

    public boolean getDataEnabled(int subId) {
        boolean retVal = false;
        try {
            retVal = getITelephony().getDataEnabled(subId);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#getDataEnabled", e);
        } catch (NullPointerException e2) {
        }
        Log.d(TAG, "getDataEnabled: retVal=" + retVal);
        return retVal;
    }

    public int invokeOemRilRequestRaw(byte[] oemReq, byte[] oemResp) {
        try {
            return getITelephony().invokeOemRilRequestRaw(oemReq, oemResp);
        } catch (RemoteException e) {
            return DATA_UNKNOWN;
        } catch (NullPointerException e2) {
            return DATA_UNKNOWN;
        }
    }

    public void enableVideoCalling(boolean enable) {
        try {
            getITelephony().enableVideoCalling(enable);
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#enableVideoCalling", e);
        }
    }

    public boolean isVideoCallingEnabled() {
        try {
            return getITelephony().isVideoCallingEnabled();
        } catch (RemoteException e) {
            Log.e(TAG, "Error calling ITelephony#isVideoCallingEnabled", e);
            return false;
        }
    }

    public static int getIntWithSubId(ContentResolver cr, String name, int subId, int def) {
        return Global.getInt(cr, name + subId, Global.getInt(cr, name, def));
    }

    public static int getIntWithSubId(ContentResolver cr, String name, int subId) throws SettingNotFoundException {
        int i;
        try {
            i = Global.getInt(cr, name + subId);
        } catch (SettingNotFoundException e) {
            try {
                i = Global.getInt(cr, name);
                Global.putInt(cr, name + subId, i);
                int default_val = i;
                if (name.equals("mobile_data")) {
                    if ("true".equalsIgnoreCase(SystemProperties.get("ro.com.android.mobiledata", "true"))) {
                        default_val = SIM_STATE_ABSENT;
                    } else {
                        default_val = SIM_STATE_UNKNOWN;
                    }
                } else if (name.equals(SubscriptionManager.DATA_ROAMING)) {
                    default_val = "true".equalsIgnoreCase(SystemProperties.get("ro.com.android.dataroaming", "false")) ? SIM_STATE_ABSENT : SIM_STATE_UNKNOWN;
                }
                if (default_val != i) {
                    Global.putInt(cr, name, default_val);
                }
            } catch (SettingNotFoundException e2) {
                throw new SettingNotFoundException(name);
            }
        }
        return i;
    }

    public boolean isImsRegistered() {
        boolean z = false;
        try {
            z = getITelephony().isImsRegistered();
        } catch (RemoteException e) {
        } catch (NullPointerException e2) {
        }
        return z;
    }

    public void setSimOperatorNumeric(String numeric) {
        setSimOperatorNumericForPhone(getDefaultPhone(), numeric);
    }

    public void setSimOperatorNumericForPhone(int phoneId, String numeric) {
        setTelephonyProperty(phoneId, "gsm.sim.operator.numeric", numeric);
    }

    public void setSimOperatorName(String name) {
        setSimOperatorNameForPhone(getDefaultPhone(), name);
    }

    public void setSimOperatorNameForPhone(int phoneId, String name) {
        setTelephonyProperty(phoneId, "gsm.sim.operator.alpha", name);
    }

    public void setSimCountryIso(String iso) {
        setSimCountryIsoForPhone(getDefaultPhone(), iso);
    }

    public void setSimCountryIsoForPhone(int phoneId, String iso) {
        setTelephonyProperty(phoneId, "gsm.sim.operator.iso-country", iso);
    }

    public void setSimState(String state) {
        setSimStateForPhone(getDefaultPhone(), state);
    }

    public void setSimStateForPhone(int phoneId, String state) {
        setTelephonyProperty(phoneId, "gsm.sim.state", state);
    }

    public void setBasebandVersion(String version) {
        setBasebandVersionForPhone(getDefaultPhone(), version);
    }

    public void setBasebandVersionForPhone(int phoneId, String version) {
        if (SubscriptionManager.isValidPhoneId(phoneId)) {
            SystemProperties.set("gsm.version.baseband" + (phoneId == 0 ? ProxyInfo.LOCAL_EXCL_LIST : Integer.toString(phoneId)), version);
        }
    }

    public void setPhoneType(int type) {
        setPhoneType(getDefaultPhone(), type);
    }

    public void setPhoneType(int phoneId, int type) {
        if (SubscriptionManager.isValidPhoneId(phoneId)) {
            setTelephonyProperty(phoneId, "gsm.current.phone-type", String.valueOf(type));
        }
    }

    public String getOtaSpNumberSchema(String defaultValue) {
        return getOtaSpNumberSchemaForPhone(getDefaultPhone(), defaultValue);
    }

    public String getOtaSpNumberSchemaForPhone(int phoneId, String defaultValue) {
        if (SubscriptionManager.isValidPhoneId(phoneId)) {
            return getTelephonyProperty(phoneId, "ro.cdma.otaspnumschema", defaultValue);
        }
        return defaultValue;
    }

    public boolean getSmsReceiveCapable(boolean defaultValue) {
        return getSmsReceiveCapableForPhone(getDefaultPhone(), defaultValue);
    }

    public boolean getSmsReceiveCapableForPhone(int phoneId, boolean defaultValue) {
        if (SubscriptionManager.isValidPhoneId(phoneId)) {
            return Boolean.valueOf(getTelephonyProperty(phoneId, "telephony.sms.receive", String.valueOf(defaultValue))).booleanValue();
        }
        return defaultValue;
    }

    public boolean getSmsSendCapable(boolean defaultValue) {
        return getSmsSendCapableForPhone(getDefaultPhone(), defaultValue);
    }

    public boolean getSmsSendCapableForPhone(int phoneId, boolean defaultValue) {
        if (SubscriptionManager.isValidPhoneId(phoneId)) {
            return Boolean.valueOf(getTelephonyProperty(phoneId, "telephony.sms.send", String.valueOf(defaultValue))).booleanValue();
        }
        return defaultValue;
    }

    public void setNetworkOperatorName(String name) {
        setNetworkOperatorNameForPhone(getDefaultPhone(), name);
    }

    public void setNetworkOperatorNameForPhone(int phoneId, String name) {
        if (SubscriptionManager.isValidPhoneId(phoneId)) {
            setTelephonyProperty(phoneId, "gsm.operator.alpha", name);
        }
    }

    public void setNetworkOperatorNumeric(String numeric) {
        setNetworkOperatorNumericForPhone(getDefaultPhone(), numeric);
    }

    public void setNetworkOperatorNumericForPhone(int phoneId, String numeric) {
        setTelephonyProperty(phoneId, "gsm.operator.numeric", numeric);
    }

    public void setNetworkRoaming(boolean isRoaming) {
        setNetworkRoamingForPhone(getDefaultPhone(), isRoaming);
    }

    public void setNetworkRoamingForPhone(int phoneId, boolean isRoaming) {
        if (SubscriptionManager.isValidPhoneId(phoneId)) {
            setTelephonyProperty(phoneId, "gsm.operator.isroaming", isRoaming ? "true" : "false");
        }
    }

    public void setNetworkCountryIso(String iso) {
        setNetworkCountryIsoForPhone(getDefaultPhone(), iso);
    }

    public void setNetworkCountryIsoForPhone(int phoneId, String iso) {
        if (SubscriptionManager.isValidPhoneId(phoneId)) {
            setTelephonyProperty(phoneId, "gsm.operator.iso-country", iso);
        }
    }

    public void setDataNetworkType(int type) {
        setDataNetworkTypeForPhone(getDefaultPhone(), type);
    }

    public void setDataNetworkTypeForPhone(int phoneId, int type) {
        if (SubscriptionManager.isValidPhoneId(phoneId)) {
            setTelephonyProperty(phoneId, "gsm.network.type", ServiceState.rilRadioTechnologyToString(type));
        }
    }
}
