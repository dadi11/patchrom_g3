package android.net.wifi;

import android.location.SettingInjectorService;
import android.net.IpConfiguration;
import android.net.IpConfiguration.IpAssignment;
import android.net.IpConfiguration.ProxySettings;
import android.net.ProxyInfo;
import android.net.StaticIpConfiguration;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.TextUtils;
import android.text.format.DateUtils;
import java.util.ArrayList;
import java.util.BitSet;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;

public class WifiConfiguration implements Parcelable {
    public static final int AUTO_JOIN_DELETED = 200;
    public static final int AUTO_JOIN_DISABLED_NO_CREDENTIALS = 160;
    public static final int AUTO_JOIN_DISABLED_ON_AUTH_FAILURE = 128;
    public static final int AUTO_JOIN_DISABLED_USER_ACTION = 161;
    public static final int AUTO_JOIN_ENABLED = 0;
    public static final int AUTO_JOIN_TEMPORARY_DISABLED = 1;
    public static final int AUTO_JOIN_TEMPORARY_DISABLED_AT_SUPPLICANT = 64;
    public static final int AUTO_JOIN_TEMPORARY_DISABLED_LINK_ERRORS = 32;
    public static int A_BAND_PREFERENCE_RSSI_THRESHOLD = 0;
    public static int BAD_RSSI_24 = 0;
    public static int BAD_RSSI_5 = 0;
    public static final Creator<WifiConfiguration> CREATOR;
    public static final int DISABLED_ASSOCIATION_REJECT = 4;
    public static final int DISABLED_AUTH_FAILURE = 3;
    public static final int DISABLED_BY_WIFI_MANAGER = 5;
    public static final int DISABLED_DHCP_FAILURE = 2;
    public static final int DISABLED_DNS_FAILURE = 1;
    public static final int DISABLED_UNKNOWN_REASON = 0;
    public static int GOOD_RSSI_24 = 0;
    public static int GOOD_RSSI_5 = 0;
    public static int G_BAND_PREFERENCE_RSSI_THRESHOLD = 0;
    public static int HOME_NETWORK_RSSI_BOOST = 0;
    public static int INITIAL_AUTO_JOIN_ATTEMPT_MIN_24 = 0;
    public static int INITIAL_AUTO_JOIN_ATTEMPT_MIN_5 = 0;
    public static final int INVALID_NETWORK_ID = -1;
    public static int INVALID_RSSI = 0;
    public static int LOW_RSSI_24 = 0;
    public static int LOW_RSSI_5 = 0;
    public static int MAX_INITIAL_AUTO_JOIN_RSSI_BOOST = 0;
    public static int ROAMING_FAILURE_AUTH_FAILURE = 0;
    public static int ROAMING_FAILURE_IP_CONFIG = 0;
    public static final String SIMNumVarName = "sim_num";
    private static final String TAG = "WifiConfiguration";
    public static int UNBLACKLIST_THRESHOLD_24_HARD = 0;
    public static int UNBLACKLIST_THRESHOLD_24_SOFT = 0;
    public static int UNBLACKLIST_THRESHOLD_5_HARD = 0;
    public static int UNBLACKLIST_THRESHOLD_5_SOFT = 0;
    public static int UNWANTED_BLACKLIST_HARD_BUMP = 0;
    public static int UNWANTED_BLACKLIST_SOFT_BUMP = 0;
    public static int UNWANTED_BLACKLIST_SOFT_RSSI_24 = 0;
    public static int UNWANTED_BLACKLIST_SOFT_RSSI_5 = 0;
    public static final String bssidVarName = "bssid";
    public static final String frequencyVarName = "frequency";
    public static final String hiddenSSIDVarName = "scan_ssid";
    public static final String modeVarName = "mode";
    public static final String pmfVarName = "ieee80211w";
    public static final String priorityVarName = "priority";
    public static final String pskVarName = "psk";
    public static final String ssidVarName = "ssid";
    public static final String updateIdentiferVarName = "update_identifier";
    public static final String[] wepKeyVarNames;
    public static final String wepTxKeyIdxVarName = "wep_tx_keyidx";
    public String BSSID;
    public String FQDN;
    public int SIMNum;
    public String SSID;
    public BitSet allowedAuthAlgorithms;
    public BitSet allowedGroupCiphers;
    public BitSet allowedKeyManagement;
    public BitSet allowedPairwiseCiphers;
    public BitSet allowedProtocols;
    public String autoJoinBSSID;
    public boolean autoJoinBailedDueToLowRssi;
    public int autoJoinStatus;
    public int autoJoinUseAggressiveJoinAttemptThreshold;
    public long blackListTimestamp;
    public HashMap<String, Integer> connectChoices;
    public int creatorUid;
    public String defaultGwMacAddress;
    public String dhcpServer;
    public boolean didSelfAdd;
    public boolean dirty;
    public int disableReason;
    public boolean duplicateNetwork;
    public WifiEnterpriseConfig enterpriseConfig;
    public boolean ephemeral;
    public int frequency;
    public boolean hiddenSSID;
    public boolean isIBSS;
    public int lastConnectUid;
    public long lastConnected;
    public long lastConnectionFailure;
    public long lastDisconnected;
    public String lastFailure;
    public long lastRoamingFailure;
    public int lastRoamingFailureReason;
    public int lastUpdateUid;
    public HashMap<String, Integer> linkedConfigurations;
    String mCachedConfigKey;
    private IpConfiguration mIpConfiguration;
    public String naiRealm;
    public int networkId;
    public int numAssociation;
    public int numAuthFailures;
    public int numConnectionFailures;
    public int numIpConfigFailures;
    public int numNoInternetAccessReports;
    public int numScorerOverride;
    public int numScorerOverrideAndSwitchedNetwork;
    public int numTicksAtBadRSSI;
    public int numTicksAtLowRSSI;
    public int numTicksAtNotHighRSSI;
    public int numUserTriggeredJoinAttempts;
    public int numUserTriggeredWifiDisableBadRSSI;
    public int numUserTriggeredWifiDisableLowRSSI;
    public int numUserTriggeredWifiDisableNotHighRSSI;
    public String peerWifiConfiguration;
    public String preSharedKey;
    public int priority;
    public boolean requirePMF;
    public long roamingFailureBlackListTimeMilli;
    public HashMap<String, ScanResult> scanResultCache;
    public boolean selfAdded;
    public int status;
    public String updateIdentifier;
    public boolean validatedInternetAccess;
    public Visibility visibility;
    public String[] wepKeys;
    public int wepTxKeyIndex;

    /* renamed from: android.net.wifi.WifiConfiguration.1 */
    class C05311 implements Comparator {
        C05311() {
        }

        public int compare(Object o1, Object o2) {
            ScanResult a = (ScanResult) o1;
            ScanResult b = (ScanResult) o2;
            if (a.seen > b.seen) {
                return WifiConfiguration.DISABLED_DNS_FAILURE;
            }
            if (a.seen < b.seen) {
                return WifiConfiguration.INVALID_NETWORK_ID;
            }
            return a.BSSID.compareTo(b.BSSID);
        }
    }

    /* renamed from: android.net.wifi.WifiConfiguration.2 */
    class C05322 implements Comparator {
        C05322() {
        }

        public int compare(Object o1, Object o2) {
            ScanResult a = (ScanResult) o1;
            ScanResult b = (ScanResult) o2;
            if (a.numIpConfigFailures > b.numIpConfigFailures) {
                return WifiConfiguration.DISABLED_DNS_FAILURE;
            }
            if (a.numIpConfigFailures < b.numIpConfigFailures) {
                return WifiConfiguration.INVALID_NETWORK_ID;
            }
            if (a.seen > b.seen) {
                return WifiConfiguration.INVALID_NETWORK_ID;
            }
            if (a.seen < b.seen) {
                return WifiConfiguration.DISABLED_DNS_FAILURE;
            }
            if (a.level > b.level) {
                return WifiConfiguration.INVALID_NETWORK_ID;
            }
            if (a.level >= b.level) {
                return a.BSSID.compareTo(b.BSSID);
            }
            return WifiConfiguration.DISABLED_DNS_FAILURE;
        }
    }

    /* renamed from: android.net.wifi.WifiConfiguration.3 */
    static class C05333 implements Creator<WifiConfiguration> {
        C05333() {
        }

        public WifiConfiguration createFromParcel(Parcel in) {
            boolean z;
            boolean z2 = true;
            WifiConfiguration config = new WifiConfiguration();
            config.networkId = in.readInt();
            config.status = in.readInt();
            config.disableReason = in.readInt();
            config.SSID = in.readString();
            config.BSSID = in.readString();
            config.autoJoinBSSID = in.readString();
            config.FQDN = in.readString();
            config.naiRealm = in.readString();
            config.preSharedKey = in.readString();
            for (int i = WifiConfiguration.DISABLED_UNKNOWN_REASON; i < config.wepKeys.length; i += WifiConfiguration.DISABLED_DNS_FAILURE) {
                config.wepKeys[i] = in.readString();
            }
            config.wepTxKeyIndex = in.readInt();
            config.priority = in.readInt();
            config.hiddenSSID = in.readInt() != 0;
            if (in.readInt() != 0) {
                z = true;
            } else {
                z = false;
            }
            config.isIBSS = z;
            config.frequency = in.readInt();
            if (in.readInt() != 0) {
                z = true;
            } else {
                z = false;
            }
            config.requirePMF = z;
            config.updateIdentifier = in.readString();
            config.allowedKeyManagement = WifiConfiguration.readBitSet(in);
            config.allowedProtocols = WifiConfiguration.readBitSet(in);
            config.allowedAuthAlgorithms = WifiConfiguration.readBitSet(in);
            config.allowedPairwiseCiphers = WifiConfiguration.readBitSet(in);
            config.allowedGroupCiphers = WifiConfiguration.readBitSet(in);
            config.enterpriseConfig = (WifiEnterpriseConfig) in.readParcelable(null);
            config.mIpConfiguration = (IpConfiguration) in.readParcelable(null);
            config.dhcpServer = in.readString();
            config.defaultGwMacAddress = in.readString();
            config.autoJoinStatus = in.readInt();
            config.selfAdded = in.readInt() != 0;
            if (in.readInt() != 0) {
                z = true;
            } else {
                z = false;
            }
            config.didSelfAdd = z;
            if (in.readInt() != 0) {
                z = true;
            } else {
                z = false;
            }
            config.validatedInternetAccess = z;
            if (in.readInt() != 0) {
                z = true;
            } else {
                z = false;
            }
            config.ephemeral = z;
            config.creatorUid = in.readInt();
            config.lastConnectUid = in.readInt();
            config.lastUpdateUid = in.readInt();
            config.blackListTimestamp = in.readLong();
            config.lastConnectionFailure = in.readLong();
            config.lastRoamingFailure = in.readLong();
            config.lastRoamingFailureReason = in.readInt();
            config.roamingFailureBlackListTimeMilli = in.readLong();
            config.numConnectionFailures = in.readInt();
            config.numIpConfigFailures = in.readInt();
            config.numAuthFailures = in.readInt();
            config.numScorerOverride = in.readInt();
            config.numScorerOverrideAndSwitchedNetwork = in.readInt();
            config.numAssociation = in.readInt();
            config.numUserTriggeredWifiDisableLowRSSI = in.readInt();
            config.numUserTriggeredWifiDisableBadRSSI = in.readInt();
            config.numUserTriggeredWifiDisableNotHighRSSI = in.readInt();
            config.numTicksAtLowRSSI = in.readInt();
            config.numTicksAtBadRSSI = in.readInt();
            config.numTicksAtNotHighRSSI = in.readInt();
            config.numUserTriggeredJoinAttempts = in.readInt();
            config.autoJoinUseAggressiveJoinAttemptThreshold = in.readInt();
            if (in.readInt() == 0) {
                z2 = false;
            }
            config.autoJoinBailedDueToLowRssi = z2;
            config.numNoInternetAccessReports = in.readInt();
            config.SIMNum = in.readInt();
            return config;
        }

        public WifiConfiguration[] newArray(int size) {
            return new WifiConfiguration[size];
        }
    }

    public static class AuthAlgorithm {
        public static final int LEAP = 2;
        public static final int OPEN = 0;
        public static final int SHARED = 1;
        public static final String[] strings;
        public static final String varName = "auth_alg";

        private AuthAlgorithm() {
        }

        static {
            String[] strArr = new String[WifiConfiguration.DISABLED_AUTH_FAILURE];
            strArr[OPEN] = "OPEN";
            strArr[SHARED] = "SHARED";
            strArr[LEAP] = "LEAP";
            strings = strArr;
        }
    }

    public static class GroupCipher {
        public static final int CCMP = 3;
        public static final int TKIP = 2;
        public static final int WEP104 = 1;
        public static final int WEP40 = 0;
        public static final String[] strings;
        public static final String varName = "group";

        private GroupCipher() {
        }

        static {
            String[] strArr = new String[WifiConfiguration.DISABLED_ASSOCIATION_REJECT];
            strArr[WEP40] = "WEP40";
            strArr[WEP104] = "WEP104";
            strArr[TKIP] = "TKIP";
            strArr[CCMP] = "CCMP";
            strings = strArr;
        }
    }

    public static class KeyMgmt {
        public static final int IEEE8021X = 3;
        public static final int NONE = 0;
        public static final int WPA2_PSK = 4;
        public static final int WPA_EAP = 2;
        public static final int WPA_PSK = 1;
        public static final String[] strings;
        public static final String varName = "key_mgmt";

        private KeyMgmt() {
        }

        static {
            String[] strArr = new String[WifiConfiguration.DISABLED_BY_WIFI_MANAGER];
            strArr[NONE] = "NONE";
            strArr[WPA_PSK] = "WPA_PSK";
            strArr[WPA_EAP] = "WPA_EAP";
            strArr[IEEE8021X] = "IEEE8021X";
            strArr[WPA2_PSK] = "WPA2_PSK";
            strings = strArr;
        }
    }

    public static class PairwiseCipher {
        public static final int CCMP = 2;
        public static final int NONE = 0;
        public static final int TKIP = 1;
        public static final String[] strings;
        public static final String varName = "pairwise";

        private PairwiseCipher() {
        }

        static {
            String[] strArr = new String[WifiConfiguration.DISABLED_AUTH_FAILURE];
            strArr[NONE] = "NONE";
            strArr[TKIP] = "TKIP";
            strArr[CCMP] = "CCMP";
            strings = strArr;
        }
    }

    public static class Protocol {
        public static final int RSN = 1;
        public static final int WPA = 0;
        public static final String[] strings;
        public static final String varName = "proto";

        private Protocol() {
        }

        static {
            String[] strArr = new String[WifiConfiguration.DISABLED_DHCP_FAILURE];
            strArr[WPA] = "WPA";
            strArr[RSN] = "RSN";
            strings = strArr;
        }
    }

    public static class Status {
        public static final int CURRENT = 0;
        public static final int DISABLED = 1;
        public static final int ENABLED = 2;
        public static final String[] strings;

        private Status() {
        }

        static {
            String[] strArr = new String[WifiConfiguration.DISABLED_AUTH_FAILURE];
            strArr[CURRENT] = "current";
            strArr[DISABLED] = "disabled";
            strArr[ENABLED] = SettingInjectorService.ENABLED_KEY;
            strings = strArr;
        }
    }

    public final class Visibility {
        public String BSSID24;
        public String BSSID5;
        public long age24;
        public long age5;
        public int bandPreferenceBoost;
        public int currentNetworkBoost;
        public int lastChoiceBoost;
        public String lastChoiceConfig;
        public int num24;
        public int num5;
        public int rssi24;
        public int rssi5;
        public int score;

        public Visibility() {
            this.rssi5 = WifiConfiguration.INVALID_RSSI;
            this.rssi24 = WifiConfiguration.INVALID_RSSI;
        }

        public Visibility(Visibility source) {
            this.rssi5 = source.rssi5;
            this.rssi24 = source.rssi24;
            this.age24 = source.age24;
            this.age5 = source.age5;
            this.num24 = source.num24;
            this.num5 = source.num5;
            this.BSSID5 = source.BSSID5;
            this.BSSID24 = source.BSSID24;
        }

        public String toString() {
            StringBuilder sbuf = new StringBuilder();
            sbuf.append("[");
            if (this.rssi24 > WifiConfiguration.INVALID_RSSI) {
                sbuf.append(Integer.toString(this.rssi24));
                sbuf.append(",");
                sbuf.append(Integer.toString(this.num24));
                if (this.BSSID24 != null) {
                    sbuf.append(",").append(this.BSSID24);
                }
            }
            sbuf.append("; ");
            if (this.rssi5 > WifiConfiguration.INVALID_RSSI) {
                sbuf.append(Integer.toString(this.rssi5));
                sbuf.append(",");
                sbuf.append(Integer.toString(this.num5));
                if (this.BSSID5 != null) {
                    sbuf.append(",").append(this.BSSID5);
                }
            }
            if (this.score != 0) {
                sbuf.append("; ").append(this.score);
                sbuf.append(", ").append(this.currentNetworkBoost);
                sbuf.append(", ").append(this.bandPreferenceBoost);
                if (this.lastChoiceConfig != null) {
                    sbuf.append(", ").append(this.lastChoiceBoost);
                    sbuf.append(", ").append(this.lastChoiceConfig);
                }
            }
            sbuf.append("]");
            return sbuf.toString();
        }
    }

    static {
        String[] strArr = new String[DISABLED_ASSOCIATION_REJECT];
        strArr[DISABLED_UNKNOWN_REASON] = "wep_key0";
        strArr[DISABLED_DNS_FAILURE] = "wep_key1";
        strArr[DISABLED_DHCP_FAILURE] = "wep_key2";
        strArr[DISABLED_AUTH_FAILURE] = "wep_key3";
        wepKeyVarNames = strArr;
        INVALID_RSSI = WifiInfo.INVALID_RSSI;
        UNWANTED_BLACKLIST_SOFT_RSSI_24 = -80;
        UNWANTED_BLACKLIST_SOFT_RSSI_5 = -70;
        GOOD_RSSI_24 = -65;
        LOW_RSSI_24 = -77;
        BAD_RSSI_24 = -87;
        GOOD_RSSI_5 = -60;
        LOW_RSSI_5 = -72;
        BAD_RSSI_5 = -82;
        UNWANTED_BLACKLIST_SOFT_BUMP = DISABLED_ASSOCIATION_REJECT;
        UNWANTED_BLACKLIST_HARD_BUMP = 8;
        UNBLACKLIST_THRESHOLD_24_SOFT = -77;
        UNBLACKLIST_THRESHOLD_24_HARD = -68;
        UNBLACKLIST_THRESHOLD_5_SOFT = -63;
        UNBLACKLIST_THRESHOLD_5_HARD = -56;
        INITIAL_AUTO_JOIN_ATTEMPT_MIN_24 = -80;
        INITIAL_AUTO_JOIN_ATTEMPT_MIN_5 = -70;
        A_BAND_PREFERENCE_RSSI_THRESHOLD = -65;
        G_BAND_PREFERENCE_RSSI_THRESHOLD = -75;
        HOME_NETWORK_RSSI_BOOST = DISABLED_BY_WIFI_MANAGER;
        MAX_INITIAL_AUTO_JOIN_RSSI_BOOST = 8;
        ROAMING_FAILURE_IP_CONFIG = DISABLED_DNS_FAILURE;
        ROAMING_FAILURE_AUTH_FAILURE = DISABLED_DHCP_FAILURE;
        CREATOR = new C05333();
    }

    public Visibility setVisibility(long age) {
        return setVisibility(age, DISABLED_UNKNOWN_REASON);
    }

    public Visibility setVisibility(long age, int configBand) {
        boolean isNetworkFound = false;
        String profileConfigKey = configKey();
        if (this.scanResultCache == null) {
            this.visibility = null;
            return null;
        }
        Visibility status = new Visibility();
        long now_ms = System.currentTimeMillis();
        for (ScanResult result : this.scanResultCache.values()) {
            if (result.seen != 0) {
                if (result.is5GHz()) {
                    if (configBand != DISABLED_DHCP_FAILURE) {
                        status.num5 += DISABLED_DNS_FAILURE;
                    }
                } else if (result.is24GHz()) {
                    if (configBand != DISABLED_DNS_FAILURE) {
                        status.num24 += DISABLED_DNS_FAILURE;
                    }
                }
                if (now_ms - result.seen <= age) {
                    if (result.is5GHz()) {
                        if (profileConfigKey.equals(configKey(result))) {
                            isNetworkFound = true;
                        }
                        if (result.level > status.rssi5) {
                            status.rssi5 = result.level;
                            status.age5 = result.seen;
                            status.BSSID5 = result.BSSID;
                        }
                    } else if (result.is24GHz()) {
                        if (profileConfigKey.equals(configKey(result))) {
                            isNetworkFound = true;
                        }
                        if (result.level > status.rssi24) {
                            status.rssi24 = result.level;
                            status.age24 = result.seen;
                            status.BSSID24 = result.BSSID;
                        }
                    }
                }
            }
        }
        if (isNetworkFound) {
            this.visibility = status;
            return status;
        }
        this.visibility = null;
        return status;
    }

    public boolean hasNoInternetAccess() {
        return this.numNoInternetAccessReports > 0 && !this.validatedInternetAccess;
    }

    public WifiConfiguration() {
        this.roamingFailureBlackListTimeMilli = 1000;
        this.networkId = INVALID_NETWORK_ID;
        this.SSID = null;
        this.BSSID = null;
        this.FQDN = null;
        this.naiRealm = null;
        this.priority = DISABLED_UNKNOWN_REASON;
        this.hiddenSSID = false;
        this.isIBSS = false;
        this.frequency = DISABLED_UNKNOWN_REASON;
        this.disableReason = DISABLED_UNKNOWN_REASON;
        this.allowedKeyManagement = new BitSet();
        this.allowedProtocols = new BitSet();
        this.allowedAuthAlgorithms = new BitSet();
        this.allowedPairwiseCiphers = new BitSet();
        this.allowedGroupCiphers = new BitSet();
        this.wepKeys = new String[DISABLED_ASSOCIATION_REJECT];
        for (int i = DISABLED_UNKNOWN_REASON; i < this.wepKeys.length; i += DISABLED_DNS_FAILURE) {
            this.wepKeys[i] = null;
        }
        this.enterpriseConfig = new WifiEnterpriseConfig();
        this.autoJoinStatus = DISABLED_UNKNOWN_REASON;
        this.selfAdded = false;
        this.didSelfAdd = false;
        this.ephemeral = false;
        this.validatedInternetAccess = false;
        this.mIpConfiguration = new IpConfiguration();
        this.duplicateNetwork = false;
        this.SIMNum = DISABLED_UNKNOWN_REASON;
    }

    public boolean isValid() {
        if (this.allowedKeyManagement == null) {
            return false;
        }
        if (this.allowedKeyManagement.cardinality() > DISABLED_DNS_FAILURE) {
            if (this.allowedKeyManagement.cardinality() != DISABLED_DHCP_FAILURE || !this.allowedKeyManagement.get(DISABLED_DHCP_FAILURE)) {
                return false;
            }
            if (!(this.allowedKeyManagement.get(DISABLED_AUTH_FAILURE) || this.allowedKeyManagement.get(DISABLED_DNS_FAILURE))) {
                return false;
            }
        }
        return true;
    }

    public boolean isLinked(WifiConfiguration config) {
        if (config.linkedConfigurations == null || this.linkedConfigurations == null || config.linkedConfigurations.get(configKey()) == null || this.linkedConfigurations.get(config.configKey()) == null) {
            return false;
        }
        return true;
    }

    public ScanResult lastSeen() {
        ScanResult mostRecent = null;
        if (this.scanResultCache == null) {
            return null;
        }
        for (ScanResult result : this.scanResultCache.values()) {
            if (mostRecent == null) {
                if (result.seen != 0) {
                    mostRecent = result;
                }
            } else if (result.seen > mostRecent.seen) {
                mostRecent = result;
            }
        }
        return mostRecent;
    }

    public void setAutoJoinStatus(int status) {
        if (status < 0) {
            status = DISABLED_UNKNOWN_REASON;
        }
        if (status == 0) {
            this.blackListTimestamp = 0;
        } else if (status > this.autoJoinStatus) {
            this.blackListTimestamp = System.currentTimeMillis();
        }
        if (status != this.autoJoinStatus) {
            this.autoJoinStatus = status;
            this.dirty = true;
        }
    }

    public void trimScanResultsCache(int num) {
        if (this.scanResultCache != null) {
            int currenSize = this.scanResultCache.size();
            if (currenSize > num) {
                ArrayList<ScanResult> list = new ArrayList(this.scanResultCache.values());
                if (list.size() != 0) {
                    Collections.sort(list, new C05311());
                }
                for (int i = DISABLED_UNKNOWN_REASON; i < currenSize - num; i += DISABLED_DNS_FAILURE) {
                    this.scanResultCache.remove(((ScanResult) list.get(i)).BSSID);
                }
            }
        }
    }

    private ArrayList<ScanResult> sortScanResults() {
        ArrayList<ScanResult> list = new ArrayList(this.scanResultCache.values());
        if (list.size() != 0) {
            Collections.sort(list, new C05322());
        }
        return list;
    }

    public String toString() {
        long diff;
        Iterator i$;
        StringBuilder sbuf = new StringBuilder();
        if (this.status == 0) {
            sbuf.append("* ");
        } else {
            int i = this.status;
            if (r0 == DISABLED_DNS_FAILURE) {
                sbuf.append("- DSBLE ");
            }
        }
        int i2 = this.networkId;
        String str = this.SSID;
        str = this.BSSID;
        str = this.FQDN;
        str = this.naiRealm;
        sbuf.append("ID: ").append(r0).append(" SSID: ").append(r0).append(" BSSID: ").append(r0).append(" FQDN: ").append(r0).append(" REALM: ").append(r0).append(" PRIO: ").append(this.priority).append('\n');
        if (this.numConnectionFailures > 0) {
            sbuf.append(" numConnectFailures ").append(this.numConnectionFailures).append("\n");
        }
        if (this.numIpConfigFailures > 0) {
            sbuf.append(" numIpConfigFailures ").append(this.numIpConfigFailures).append("\n");
        }
        if (this.numAuthFailures > 0) {
            sbuf.append(" numAuthFailures ").append(this.numAuthFailures).append("\n");
        }
        if (this.autoJoinStatus > 0) {
            sbuf.append(" autoJoinStatus ").append(this.autoJoinStatus).append("\n");
        }
        if (this.disableReason > 0) {
            sbuf.append(" disableReason ").append(this.disableReason).append("\n");
        }
        if (this.numAssociation > 0) {
            sbuf.append(" numAssociation ").append(this.numAssociation).append("\n");
        }
        if (this.numNoInternetAccessReports > 0) {
            sbuf.append(" numNoInternetAccessReports ");
            sbuf.append(this.numNoInternetAccessReports).append("\n");
        }
        if (this.didSelfAdd) {
            sbuf.append(" didSelfAdd");
        }
        if (this.selfAdded) {
            sbuf.append(" selfAdded");
        }
        if (this.validatedInternetAccess) {
            sbuf.append(" validatedInternetAccess");
        }
        if (this.ephemeral) {
            sbuf.append(" ephemeral");
        }
        if (this.didSelfAdd || this.selfAdded || this.validatedInternetAccess || this.ephemeral) {
            sbuf.append("\n");
        }
        sbuf.append(" KeyMgmt:");
        int k = DISABLED_UNKNOWN_REASON;
        while (true) {
            if (k >= this.allowedKeyManagement.size()) {
                break;
            }
            if (this.allowedKeyManagement.get(k)) {
                sbuf.append(" ");
                if (k < KeyMgmt.strings.length) {
                    sbuf.append(KeyMgmt.strings[k]);
                } else {
                    sbuf.append("??");
                }
            }
            k += DISABLED_DNS_FAILURE;
        }
        sbuf.append(" Protocols:");
        int p = DISABLED_UNKNOWN_REASON;
        while (true) {
            if (p >= this.allowedProtocols.size()) {
                break;
            }
            if (this.allowedProtocols.get(p)) {
                sbuf.append(" ");
                if (p < Protocol.strings.length) {
                    sbuf.append(Protocol.strings[p]);
                } else {
                    sbuf.append("??");
                }
            }
            p += DISABLED_DNS_FAILURE;
        }
        sbuf.append('\n');
        sbuf.append(" AuthAlgorithms:");
        int a = DISABLED_UNKNOWN_REASON;
        while (true) {
            if (a >= this.allowedAuthAlgorithms.size()) {
                break;
            }
            if (this.allowedAuthAlgorithms.get(a)) {
                sbuf.append(" ");
                i = AuthAlgorithm.strings.length;
                if (a < r0) {
                    sbuf.append(AuthAlgorithm.strings[a]);
                } else {
                    sbuf.append("??");
                }
            }
            a += DISABLED_DNS_FAILURE;
        }
        sbuf.append('\n');
        sbuf.append(" PairwiseCiphers:");
        int pc = DISABLED_UNKNOWN_REASON;
        while (true) {
            if (pc >= this.allowedPairwiseCiphers.size()) {
                break;
            }
            if (this.allowedPairwiseCiphers.get(pc)) {
                sbuf.append(" ");
                if (pc < PairwiseCipher.strings.length) {
                    sbuf.append(PairwiseCipher.strings[pc]);
                } else {
                    sbuf.append("??");
                }
            }
            pc += DISABLED_DNS_FAILURE;
        }
        sbuf.append('\n');
        sbuf.append(" GroupCiphers:");
        int gc = DISABLED_UNKNOWN_REASON;
        while (true) {
            if (gc >= this.allowedGroupCiphers.size()) {
                break;
            }
            if (this.allowedGroupCiphers.get(gc)) {
                sbuf.append(" ");
                if (gc < GroupCipher.strings.length) {
                    sbuf.append(GroupCipher.strings[gc]);
                } else {
                    sbuf.append("??");
                }
            }
            gc += DISABLED_DNS_FAILURE;
        }
        sbuf.append('\n').append(" PSK: ");
        if (this.preSharedKey != null) {
            sbuf.append('*');
        }
        sbuf.append('\n').append(" sim_num ");
        if (this.SIMNum > 0) {
            sbuf.append('*');
        }
        sbuf.append("\nEnterprise config:\n");
        sbuf.append(this.enterpriseConfig);
        sbuf.append("IP config:\n");
        sbuf.append(this.mIpConfiguration.toString());
        if (this.creatorUid != 0) {
            sbuf.append(" uid=" + Integer.toString(this.creatorUid));
        }
        if (this.autoJoinBSSID != null) {
            sbuf.append(" autoJoinBSSID=" + this.autoJoinBSSID);
        }
        long now_ms = System.currentTimeMillis();
        if (this.blackListTimestamp != 0) {
            sbuf.append('\n');
            diff = now_ms - this.blackListTimestamp;
            if (diff <= 0) {
                sbuf.append(" blackListed since <incorrect>");
            } else {
                sbuf.append(" blackListed: ").append(Long.toString(diff / 1000)).append("sec");
            }
        }
        if (this.lastConnected != 0) {
            sbuf.append('\n');
            diff = now_ms - this.lastConnected;
            if (diff <= 0) {
                sbuf.append("lastConnected since <incorrect>");
            } else {
                sbuf.append("lastConnected: ").append(Long.toString(diff / 1000)).append("sec");
            }
        }
        if (this.lastConnectionFailure != 0) {
            sbuf.append('\n');
            diff = now_ms - this.lastConnectionFailure;
            if (diff <= 0) {
                sbuf.append("lastConnectionFailure since <incorrect>");
            } else {
                sbuf.append("lastConnectionFailure: ").append(Long.toString(diff / 1000));
                sbuf.append("sec");
            }
        }
        if (this.lastRoamingFailure != 0) {
            sbuf.append('\n');
            diff = now_ms - this.lastRoamingFailure;
            if (diff <= 0) {
                sbuf.append("lastRoamingFailure since <incorrect>");
            } else {
                sbuf.append("lastRoamingFailure: ").append(Long.toString(diff / 1000));
                sbuf.append("sec");
            }
        }
        sbuf.append("roamingFailureBlackListTimeMilli: ").append(Long.toString(this.roamingFailureBlackListTimeMilli));
        sbuf.append('\n');
        if (this.linkedConfigurations != null) {
            for (String key : this.linkedConfigurations.keySet()) {
                sbuf.append(" linked: ").append(key);
                sbuf.append('\n');
            }
        }
        if (this.connectChoices != null) {
            for (String key2 : this.connectChoices.keySet()) {
                Integer choice = (Integer) this.connectChoices.get(key2);
                if (choice != null) {
                    sbuf.append(" choice: ").append(key2);
                    sbuf.append(" = ").append(choice);
                    sbuf.append('\n');
                }
            }
        }
        if (this.scanResultCache != null) {
            sbuf.append("Scan Cache:  ").append('\n');
            ArrayList<ScanResult> list = sortScanResults();
            if (list.size() > 0) {
                i$ = list.iterator();
                while (i$.hasNext()) {
                    ScanResult result = (ScanResult) i$.next();
                    long milli = now_ms - result.seen;
                    long ageSec = 0;
                    long ageMin = 0;
                    long ageHour = 0;
                    long ageMilli = 0;
                    long ageDay = 0;
                    if (now_ms > result.seen) {
                        if (result.seen > 0) {
                            ageMilli = milli % 1000;
                            ageSec = (milli / 1000) % 60;
                            ageMin = (milli / DateUtils.MINUTE_IN_MILLIS) % 60;
                            ageHour = (milli / DateUtils.HOUR_IN_MILLIS) % 24;
                            ageDay = milli / DateUtils.DAY_IN_MILLIS;
                        }
                    }
                    str = result.BSSID;
                    sbuf.append("{").append(r0).append(",").append(result.frequency);
                    StringBuilder append = sbuf.append(",");
                    Object[] objArr = new Object[DISABLED_DNS_FAILURE];
                    objArr[DISABLED_UNKNOWN_REASON] = Integer.valueOf(result.level);
                    append.append(String.format("%3d", objArr));
                    if (result.autoJoinStatus > 0) {
                        sbuf.append(",st=").append(result.autoJoinStatus);
                    }
                    if (ageSec > 0 || ageMilli > 0) {
                        Object[] objArr2 = new Object[DISABLED_BY_WIFI_MANAGER];
                        objArr2[DISABLED_UNKNOWN_REASON] = Long.valueOf(ageDay);
                        objArr2[DISABLED_DNS_FAILURE] = Long.valueOf(ageHour);
                        objArr2[DISABLED_DHCP_FAILURE] = Long.valueOf(ageMin);
                        objArr2[DISABLED_AUTH_FAILURE] = Long.valueOf(ageSec);
                        objArr2[DISABLED_ASSOCIATION_REJECT] = Long.valueOf(ageMilli);
                        sbuf.append(String.format(",%4d.%02d.%02d.%02d.%03dms", objArr2));
                    }
                    if (result.numIpConfigFailures > 0) {
                        sbuf.append(",ipfail=");
                        sbuf.append(result.numIpConfigFailures);
                    }
                    sbuf.append("} ");
                }
                sbuf.append('\n');
            }
        }
        sbuf.append("triggeredLow: ").append(this.numUserTriggeredWifiDisableLowRSSI);
        sbuf.append(" triggeredBad: ").append(this.numUserTriggeredWifiDisableBadRSSI);
        sbuf.append(" triggeredNotHigh: ").append(this.numUserTriggeredWifiDisableNotHighRSSI);
        sbuf.append('\n');
        sbuf.append("ticksLow: ").append(this.numTicksAtLowRSSI);
        sbuf.append(" ticksBad: ").append(this.numTicksAtBadRSSI);
        sbuf.append(" ticksNotHigh: ").append(this.numTicksAtNotHighRSSI);
        sbuf.append('\n');
        sbuf.append("triggeredJoin: ").append(this.numUserTriggeredJoinAttempts);
        sbuf.append('\n');
        sbuf.append("autoJoinBailedDueToLowRssi: ").append(this.autoJoinBailedDueToLowRssi);
        sbuf.append('\n');
        sbuf.append("autoJoinUseAggressiveJoinAttemptThreshold: ");
        sbuf.append(this.autoJoinUseAggressiveJoinAttemptThreshold);
        sbuf.append('\n');
        return sbuf.toString();
    }

    public String getPrintableSsid() {
        if (this.SSID == null) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        }
        int length = this.SSID.length();
        if (length > DISABLED_DHCP_FAILURE && this.SSID.charAt(DISABLED_UNKNOWN_REASON) == '\"' && this.SSID.charAt(length + INVALID_NETWORK_ID) == '\"') {
            return this.SSID.substring(DISABLED_DNS_FAILURE, length + INVALID_NETWORK_ID);
        }
        if (length > DISABLED_AUTH_FAILURE && this.SSID.charAt(DISABLED_UNKNOWN_REASON) == 'P' && this.SSID.charAt(DISABLED_DNS_FAILURE) == '\"' && this.SSID.charAt(length + INVALID_NETWORK_ID) == '\"') {
            return WifiSsid.createFromAsciiEncoded(this.SSID.substring(DISABLED_DHCP_FAILURE, length + INVALID_NETWORK_ID)).toString();
        }
        return this.SSID;
    }

    public String getKeyIdForCredentials(WifiConfiguration current) {
        String keyMgmt = null;
        try {
            if (TextUtils.isEmpty(this.SSID)) {
                this.SSID = current.SSID;
            }
            if (this.allowedKeyManagement.cardinality() == 0) {
                this.allowedKeyManagement = current.allowedKeyManagement;
            }
            if (this.allowedKeyManagement.get(DISABLED_DHCP_FAILURE)) {
                keyMgmt = KeyMgmt.strings[DISABLED_DHCP_FAILURE];
            }
            if (this.allowedKeyManagement.get(DISABLED_AUTH_FAILURE)) {
                keyMgmt = keyMgmt + KeyMgmt.strings[DISABLED_AUTH_FAILURE];
            }
            if (TextUtils.isEmpty(keyMgmt)) {
                throw new IllegalStateException("Not an EAP network");
            }
            return trimStringForKeyId(this.SSID) + "_" + keyMgmt + "_" + trimStringForKeyId(this.enterpriseConfig.getKeyId(current != null ? current.enterpriseConfig : null));
        } catch (NullPointerException e) {
            throw new IllegalStateException("Invalid config details");
        }
    }

    private String trimStringForKeyId(String string) {
        return string.replace("\"", ProxyInfo.LOCAL_EXCL_LIST).replace(" ", ProxyInfo.LOCAL_EXCL_LIST);
    }

    private static BitSet readBitSet(Parcel src) {
        int cardinality = src.readInt();
        BitSet set = new BitSet();
        for (int i = DISABLED_UNKNOWN_REASON; i < cardinality; i += DISABLED_DNS_FAILURE) {
            set.set(src.readInt());
        }
        return set;
    }

    private static void writeBitSet(Parcel dest, BitSet set) {
        int nextSetBit = INVALID_NETWORK_ID;
        dest.writeInt(set.cardinality());
        while (true) {
            nextSetBit = set.nextSetBit(nextSetBit + DISABLED_DNS_FAILURE);
            if (nextSetBit != INVALID_NETWORK_ID) {
                dest.writeInt(nextSetBit);
            } else {
                return;
            }
        }
    }

    public int getAuthType() {
        if (!isValid()) {
            throw new IllegalStateException("Invalid configuration");
        } else if (this.allowedKeyManagement.get(DISABLED_DNS_FAILURE)) {
            return DISABLED_DNS_FAILURE;
        } else {
            if (this.allowedKeyManagement.get(DISABLED_ASSOCIATION_REJECT)) {
                return DISABLED_ASSOCIATION_REJECT;
            }
            if (this.allowedKeyManagement.get(DISABLED_DHCP_FAILURE)) {
                return DISABLED_DHCP_FAILURE;
            }
            if (this.allowedKeyManagement.get(DISABLED_AUTH_FAILURE)) {
                return DISABLED_AUTH_FAILURE;
            }
            return DISABLED_UNKNOWN_REASON;
        }
    }

    public String configKey(boolean allowCached) {
        if (allowCached && this.mCachedConfigKey != null) {
            return this.mCachedConfigKey;
        }
        String key;
        if (this.allowedKeyManagement.get(DISABLED_DNS_FAILURE)) {
            key = this.SSID + "-" + KeyMgmt.strings[DISABLED_DNS_FAILURE];
        } else if (this.allowedKeyManagement.get(DISABLED_DHCP_FAILURE) || this.allowedKeyManagement.get(DISABLED_AUTH_FAILURE)) {
            key = this.SSID + "-" + KeyMgmt.strings[DISABLED_DHCP_FAILURE];
        } else if (this.wepKeys[DISABLED_UNKNOWN_REASON] != null) {
            key = this.SSID + "-WEP";
        } else {
            key = this.SSID + "-" + KeyMgmt.strings[DISABLED_UNKNOWN_REASON];
        }
        this.mCachedConfigKey = key;
        return key;
    }

    public String configKey() {
        return configKey(false);
    }

    public static String configKey(ScanResult result) {
        String key = "\"" + result.SSID + "\"";
        if (result.capabilities.contains("WEP")) {
            return key + "-WEP";
        }
        if (result.capabilities.contains("PSK")) {
            return key + "-" + KeyMgmt.strings[DISABLED_DNS_FAILURE];
        }
        if (result.capabilities.contains("EAP") || result.capabilities.contains("IEEE8021X")) {
            return key + "-" + KeyMgmt.strings[DISABLED_DHCP_FAILURE];
        }
        return key + "-" + KeyMgmt.strings[DISABLED_UNKNOWN_REASON];
    }

    public IpConfiguration getIpConfiguration() {
        return this.mIpConfiguration;
    }

    public void setIpConfiguration(IpConfiguration ipConfiguration) {
        this.mIpConfiguration = ipConfiguration;
    }

    public StaticIpConfiguration getStaticIpConfiguration() {
        return this.mIpConfiguration.getStaticIpConfiguration();
    }

    public void setStaticIpConfiguration(StaticIpConfiguration staticIpConfiguration) {
        this.mIpConfiguration.setStaticIpConfiguration(staticIpConfiguration);
    }

    public IpAssignment getIpAssignment() {
        return this.mIpConfiguration.ipAssignment;
    }

    public void setIpAssignment(IpAssignment ipAssignment) {
        this.mIpConfiguration.ipAssignment = ipAssignment;
    }

    public ProxySettings getProxySettings() {
        return this.mIpConfiguration.proxySettings;
    }

    public void setProxySettings(ProxySettings proxySettings) {
        this.mIpConfiguration.proxySettings = proxySettings;
    }

    public ProxyInfo getHttpProxy() {
        return this.mIpConfiguration.httpProxy;
    }

    public void setHttpProxy(ProxyInfo httpProxy) {
        this.mIpConfiguration.httpProxy = httpProxy;
    }

    public void setProxy(ProxySettings settings, ProxyInfo proxy) {
        this.mIpConfiguration.proxySettings = settings;
        this.mIpConfiguration.httpProxy = proxy;
    }

    public int describeContents() {
        return DISABLED_UNKNOWN_REASON;
    }

    public WifiConfiguration(WifiConfiguration source) {
        this.roamingFailureBlackListTimeMilli = 1000;
        if (source != null) {
            this.networkId = source.networkId;
            this.status = source.status;
            this.disableReason = source.disableReason;
            this.disableReason = source.disableReason;
            this.SSID = source.SSID;
            this.BSSID = source.BSSID;
            this.FQDN = source.FQDN;
            this.naiRealm = source.naiRealm;
            this.preSharedKey = source.preSharedKey;
            this.wepKeys = new String[DISABLED_ASSOCIATION_REJECT];
            for (int i = DISABLED_UNKNOWN_REASON; i < this.wepKeys.length; i += DISABLED_DNS_FAILURE) {
                this.wepKeys[i] = source.wepKeys[i];
            }
            this.wepTxKeyIndex = source.wepTxKeyIndex;
            this.priority = source.priority;
            this.hiddenSSID = source.hiddenSSID;
            this.isIBSS = source.isIBSS;
            this.frequency = source.frequency;
            this.allowedKeyManagement = (BitSet) source.allowedKeyManagement.clone();
            this.allowedProtocols = (BitSet) source.allowedProtocols.clone();
            this.allowedAuthAlgorithms = (BitSet) source.allowedAuthAlgorithms.clone();
            this.allowedPairwiseCiphers = (BitSet) source.allowedPairwiseCiphers.clone();
            this.allowedGroupCiphers = (BitSet) source.allowedGroupCiphers.clone();
            this.enterpriseConfig = new WifiEnterpriseConfig(source.enterpriseConfig);
            this.defaultGwMacAddress = source.defaultGwMacAddress;
            this.mIpConfiguration = new IpConfiguration(source.mIpConfiguration);
            if (source.scanResultCache != null && source.scanResultCache.size() > 0) {
                this.scanResultCache = new HashMap();
                this.scanResultCache.putAll(source.scanResultCache);
            }
            if (source.connectChoices != null && source.connectChoices.size() > 0) {
                this.connectChoices = new HashMap();
                this.connectChoices.putAll(source.connectChoices);
            }
            if (source.linkedConfigurations != null && source.linkedConfigurations.size() > 0) {
                this.linkedConfigurations = new HashMap();
                this.linkedConfigurations.putAll(source.linkedConfigurations);
            }
            this.mCachedConfigKey = null;
            this.autoJoinStatus = source.autoJoinStatus;
            this.selfAdded = source.selfAdded;
            this.validatedInternetAccess = source.validatedInternetAccess;
            this.ephemeral = source.ephemeral;
            if (source.visibility != null) {
                this.visibility = new Visibility(source.visibility);
            }
            this.lastFailure = source.lastFailure;
            this.didSelfAdd = source.didSelfAdd;
            this.lastConnectUid = source.lastConnectUid;
            this.lastUpdateUid = source.lastUpdateUid;
            this.creatorUid = source.creatorUid;
            this.peerWifiConfiguration = source.peerWifiConfiguration;
            this.blackListTimestamp = source.blackListTimestamp;
            this.lastConnected = source.lastConnected;
            this.lastDisconnected = source.lastDisconnected;
            this.lastConnectionFailure = source.lastConnectionFailure;
            this.lastRoamingFailure = source.lastRoamingFailure;
            this.lastRoamingFailureReason = source.lastRoamingFailureReason;
            this.roamingFailureBlackListTimeMilli = source.roamingFailureBlackListTimeMilli;
            this.numConnectionFailures = source.numConnectionFailures;
            this.numIpConfigFailures = source.numIpConfigFailures;
            this.numAuthFailures = source.numAuthFailures;
            this.numScorerOverride = source.numScorerOverride;
            this.numScorerOverrideAndSwitchedNetwork = source.numScorerOverrideAndSwitchedNetwork;
            this.numAssociation = source.numAssociation;
            this.numUserTriggeredWifiDisableLowRSSI = source.numUserTriggeredWifiDisableLowRSSI;
            this.numUserTriggeredWifiDisableBadRSSI = source.numUserTriggeredWifiDisableBadRSSI;
            this.numUserTriggeredWifiDisableNotHighRSSI = source.numUserTriggeredWifiDisableNotHighRSSI;
            this.numTicksAtLowRSSI = source.numTicksAtLowRSSI;
            this.numTicksAtBadRSSI = source.numTicksAtBadRSSI;
            this.numTicksAtNotHighRSSI = source.numTicksAtNotHighRSSI;
            this.numUserTriggeredJoinAttempts = source.numUserTriggeredJoinAttempts;
            this.autoJoinBSSID = source.autoJoinBSSID;
            this.autoJoinUseAggressiveJoinAttemptThreshold = source.autoJoinUseAggressiveJoinAttemptThreshold;
            this.autoJoinBailedDueToLowRssi = source.autoJoinBailedDueToLowRssi;
            this.dirty = source.dirty;
            this.numNoInternetAccessReports = source.numNoInternetAccessReports;
            this.duplicateNetwork = source.duplicateNetwork;
            this.SIMNum = source.SIMNum;
        }
    }

    public void writeToParcel(Parcel dest, int flags) {
        int i;
        int i2 = DISABLED_DNS_FAILURE;
        dest.writeInt(this.networkId);
        dest.writeInt(this.status);
        dest.writeInt(this.disableReason);
        dest.writeString(this.SSID);
        dest.writeString(this.BSSID);
        dest.writeString(this.autoJoinBSSID);
        dest.writeString(this.FQDN);
        dest.writeString(this.naiRealm);
        dest.writeString(this.preSharedKey);
        String[] arr$ = this.wepKeys;
        int len$ = arr$.length;
        for (int i$ = DISABLED_UNKNOWN_REASON; i$ < len$; i$ += DISABLED_DNS_FAILURE) {
            dest.writeString(arr$[i$]);
        }
        dest.writeInt(this.wepTxKeyIndex);
        dest.writeInt(this.priority);
        dest.writeInt(this.hiddenSSID ? DISABLED_DNS_FAILURE : DISABLED_UNKNOWN_REASON);
        if (this.isIBSS) {
            i = DISABLED_DNS_FAILURE;
        } else {
            i = DISABLED_UNKNOWN_REASON;
        }
        dest.writeInt(i);
        dest.writeInt(this.frequency);
        if (this.requirePMF) {
            i = DISABLED_DNS_FAILURE;
        } else {
            i = DISABLED_UNKNOWN_REASON;
        }
        dest.writeInt(i);
        dest.writeString(this.updateIdentifier);
        writeBitSet(dest, this.allowedKeyManagement);
        writeBitSet(dest, this.allowedProtocols);
        writeBitSet(dest, this.allowedAuthAlgorithms);
        writeBitSet(dest, this.allowedPairwiseCiphers);
        writeBitSet(dest, this.allowedGroupCiphers);
        dest.writeParcelable(this.enterpriseConfig, flags);
        dest.writeParcelable(this.mIpConfiguration, flags);
        dest.writeString(this.dhcpServer);
        dest.writeString(this.defaultGwMacAddress);
        dest.writeInt(this.autoJoinStatus);
        dest.writeInt(this.selfAdded ? DISABLED_DNS_FAILURE : DISABLED_UNKNOWN_REASON);
        if (this.didSelfAdd) {
            i = DISABLED_DNS_FAILURE;
        } else {
            i = DISABLED_UNKNOWN_REASON;
        }
        dest.writeInt(i);
        if (this.validatedInternetAccess) {
            i = DISABLED_DNS_FAILURE;
        } else {
            i = DISABLED_UNKNOWN_REASON;
        }
        dest.writeInt(i);
        if (this.ephemeral) {
            i = DISABLED_DNS_FAILURE;
        } else {
            i = DISABLED_UNKNOWN_REASON;
        }
        dest.writeInt(i);
        dest.writeInt(this.creatorUid);
        dest.writeInt(this.lastConnectUid);
        dest.writeInt(this.lastUpdateUid);
        dest.writeLong(this.blackListTimestamp);
        dest.writeLong(this.lastConnectionFailure);
        dest.writeLong(this.lastRoamingFailure);
        dest.writeInt(this.lastRoamingFailureReason);
        dest.writeLong(this.roamingFailureBlackListTimeMilli);
        dest.writeInt(this.numConnectionFailures);
        dest.writeInt(this.numIpConfigFailures);
        dest.writeInt(this.numAuthFailures);
        dest.writeInt(this.numScorerOverride);
        dest.writeInt(this.numScorerOverrideAndSwitchedNetwork);
        dest.writeInt(this.numAssociation);
        dest.writeInt(this.numUserTriggeredWifiDisableLowRSSI);
        dest.writeInt(this.numUserTriggeredWifiDisableBadRSSI);
        dest.writeInt(this.numUserTriggeredWifiDisableNotHighRSSI);
        dest.writeInt(this.numTicksAtLowRSSI);
        dest.writeInt(this.numTicksAtBadRSSI);
        dest.writeInt(this.numTicksAtNotHighRSSI);
        dest.writeInt(this.numUserTriggeredJoinAttempts);
        dest.writeInt(this.autoJoinUseAggressiveJoinAttemptThreshold);
        if (!this.autoJoinBailedDueToLowRssi) {
            i2 = DISABLED_UNKNOWN_REASON;
        }
        dest.writeInt(i2);
        dest.writeInt(this.numNoInternetAccessReports);
        dest.writeInt(this.SIMNum);
    }
}
