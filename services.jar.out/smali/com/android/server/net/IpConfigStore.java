package com.android.server.net;

import android.net.IpConfiguration;
import android.net.IpConfiguration.IpAssignment;
import android.net.IpConfiguration.ProxySettings;
import android.net.LinkAddress;
import android.net.NetworkUtils;
import android.net.ProxyInfo;
import android.net.RouteInfo;
import android.net.StaticIpConfiguration;
import android.util.Log;
import android.util.SparseArray;
import com.android.server.net.DelayedDiskWrite.Writer;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.EOFException;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.util.Iterator;

public class IpConfigStore {
    private static final boolean DBG = true;
    protected static final String DNS_KEY = "dns";
    protected static final String EOS = "eos";
    protected static final String EXCLUSION_LIST_KEY = "exclusionList";
    protected static final String GATEWAY_KEY = "gateway";
    protected static final String ID_KEY = "id";
    protected static final int IPCONFIG_FILE_VERSION = 2;
    protected static final String IP_ASSIGNMENT_KEY = "ipAssignment";
    protected static final String LINK_ADDRESS_KEY = "linkAddress";
    protected static final String PROXY_HOST_KEY = "proxyHost";
    protected static final String PROXY_PAC_FILE = "proxyPac";
    protected static final String PROXY_PORT_KEY = "proxyPort";
    protected static final String PROXY_SETTINGS_KEY = "proxySettings";
    private static final String TAG = "IpConfigStore";
    protected final DelayedDiskWrite mWriter;

    /* renamed from: com.android.server.net.IpConfigStore.1 */
    class C03881 implements Writer {
        final /* synthetic */ SparseArray val$networks;

        C03881(SparseArray sparseArray) {
            this.val$networks = sparseArray;
        }

        public void onWriteCalled(DataOutputStream out) throws IOException {
            out.writeInt(IpConfigStore.IPCONFIG_FILE_VERSION);
            for (int i = 0; i < this.val$networks.size(); i++) {
                IpConfigStore.this.writeConfig(out, this.val$networks.keyAt(i), (IpConfiguration) this.val$networks.valueAt(i));
            }
        }
    }

    /* renamed from: com.android.server.net.IpConfigStore.2 */
    static /* synthetic */ class C03892 {
        static final /* synthetic */ int[] $SwitchMap$android$net$IpConfiguration$IpAssignment;
        static final /* synthetic */ int[] $SwitchMap$android$net$IpConfiguration$ProxySettings;

        static {
            $SwitchMap$android$net$IpConfiguration$ProxySettings = new int[ProxySettings.values().length];
            try {
                $SwitchMap$android$net$IpConfiguration$ProxySettings[ProxySettings.STATIC.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$android$net$IpConfiguration$ProxySettings[ProxySettings.PAC.ordinal()] = IpConfigStore.IPCONFIG_FILE_VERSION;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$android$net$IpConfiguration$ProxySettings[ProxySettings.NONE.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$android$net$IpConfiguration$ProxySettings[ProxySettings.UNASSIGNED.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            $SwitchMap$android$net$IpConfiguration$IpAssignment = new int[IpAssignment.values().length];
            try {
                $SwitchMap$android$net$IpConfiguration$IpAssignment[IpAssignment.STATIC.ordinal()] = 1;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$android$net$IpConfiguration$IpAssignment[IpAssignment.DHCP.ordinal()] = IpConfigStore.IPCONFIG_FILE_VERSION;
            } catch (NoSuchFieldError e6) {
            }
            try {
                $SwitchMap$android$net$IpConfiguration$IpAssignment[IpAssignment.UNASSIGNED.ordinal()] = 3;
            } catch (NoSuchFieldError e7) {
            }
        }
    }

    public IpConfigStore() {
        this.mWriter = new DelayedDiskWrite();
    }

    private boolean writeConfig(DataOutputStream out, int configKey, IpConfiguration config) throws IOException {
        boolean written = false;
        try {
            switch (C03892.$SwitchMap$android$net$IpConfiguration$IpAssignment[config.ipAssignment.ordinal()]) {
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                    out.writeUTF(IP_ASSIGNMENT_KEY);
                    out.writeUTF(config.ipAssignment.toString());
                    StaticIpConfiguration staticIpConfiguration = config.staticIpConfiguration;
                    if (staticIpConfiguration != null) {
                        if (staticIpConfiguration.ipAddress != null) {
                            LinkAddress ipAddress = staticIpConfiguration.ipAddress;
                            out.writeUTF(LINK_ADDRESS_KEY);
                            out.writeUTF(ipAddress.getAddress().getHostAddress());
                            out.writeInt(ipAddress.getPrefixLength());
                        }
                        if (staticIpConfiguration.gateway != null) {
                            out.writeUTF(GATEWAY_KEY);
                            out.writeInt(0);
                            out.writeInt(1);
                            out.writeUTF(staticIpConfiguration.gateway.getHostAddress());
                        }
                        Iterator i$ = staticIpConfiguration.dnsServers.iterator();
                        while (i$.hasNext()) {
                            InetAddress inetAddr = (InetAddress) i$.next();
                            out.writeUTF(DNS_KEY);
                            out.writeUTF(inetAddr.getHostAddress());
                        }
                    }
                    written = DBG;
                    break;
                case IPCONFIG_FILE_VERSION /*2*/:
                    out.writeUTF(IP_ASSIGNMENT_KEY);
                    out.writeUTF(config.ipAssignment.toString());
                    written = DBG;
                    break;
                case C0569H.REPORT_LOSING_FOCUS /*3*/:
                    break;
                default:
                    loge("Ignore invalid ip assignment while writing");
                    break;
            }
            switch (C03892.$SwitchMap$android$net$IpConfiguration$ProxySettings[config.proxySettings.ordinal()]) {
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                    ProxyInfo proxyProperties = config.httpProxy;
                    String exclusionList = proxyProperties.getExclusionListAsString();
                    out.writeUTF(PROXY_SETTINGS_KEY);
                    out.writeUTF(config.proxySettings.toString());
                    out.writeUTF(PROXY_HOST_KEY);
                    out.writeUTF(proxyProperties.getHost());
                    out.writeUTF(PROXY_PORT_KEY);
                    out.writeInt(proxyProperties.getPort());
                    if (exclusionList != null) {
                        out.writeUTF(EXCLUSION_LIST_KEY);
                        out.writeUTF(exclusionList);
                    }
                    written = DBG;
                    break;
                case IPCONFIG_FILE_VERSION /*2*/:
                    ProxyInfo proxyPacProperties = config.httpProxy;
                    out.writeUTF(PROXY_SETTINGS_KEY);
                    out.writeUTF(config.proxySettings.toString());
                    out.writeUTF(PROXY_PAC_FILE);
                    out.writeUTF(proxyPacProperties.getPacFileUrl().toString());
                    written = DBG;
                    break;
                case C0569H.REPORT_LOSING_FOCUS /*3*/:
                    out.writeUTF(PROXY_SETTINGS_KEY);
                    out.writeUTF(config.proxySettings.toString());
                    written = DBG;
                    break;
                case C0569H.DO_TRAVERSAL /*4*/:
                    break;
                default:
                    loge("Ignore invalid proxy settings while writing");
                    break;
            }
            if (written) {
                out.writeUTF(ID_KEY);
                out.writeInt(configKey);
            }
        } catch (NullPointerException e) {
            loge("Failure in writing " + config + e);
        }
        out.writeUTF(EOS);
        return written;
    }

    public void writeIpAndProxyConfigurations(String filePath, SparseArray<IpConfiguration> networks) {
        this.mWriter.write(filePath, new C03881(networks));
    }

    public SparseArray<IpConfiguration> readIpAndProxyConfigurations(String filePath) {
        IOException e;
        Throwable th;
        SparseArray<IpConfiguration> networks = new SparseArray();
        DataInputStream in = null;
        try {
            DataInputStream in2 = new DataInputStream(new BufferedInputStream(new FileInputStream(filePath)));
            try {
                int version = in2.readInt();
                if (version == IPCONFIG_FILE_VERSION || version == 1) {
                    while (true) {
                        int id = -1;
                        IpAssignment ipAssignment = IpAssignment.DHCP;
                        ProxySettings proxySettings = ProxySettings.NONE;
                        StaticIpConfiguration staticIpConfiguration = new StaticIpConfiguration();
                        String proxyHost = null;
                        String pacFileUrl = null;
                        int proxyPort = -1;
                        String exclusionList = null;
                        while (true) {
                            String key = in2.readUTF();
                            try {
                                if (key.equals(ID_KEY)) {
                                    id = in2.readInt();
                                } else {
                                    if (key.equals(IP_ASSIGNMENT_KEY)) {
                                        ipAssignment = IpAssignment.valueOf(in2.readUTF());
                                    } else {
                                        if (key.equals(LINK_ADDRESS_KEY)) {
                                            LinkAddress linkAddr = new LinkAddress(NetworkUtils.numericToInetAddress(in2.readUTF()), in2.readInt());
                                            if ((linkAddr.getAddress() instanceof Inet4Address) && staticIpConfiguration.ipAddress == null) {
                                                staticIpConfiguration.ipAddress = linkAddr;
                                            } else {
                                                loge("Non-IPv4 or duplicate address: " + linkAddr);
                                            }
                                        } else {
                                            if (key.equals(GATEWAY_KEY)) {
                                                LinkAddress dest = null;
                                                InetAddress gateway = null;
                                                if (version == 1) {
                                                    gateway = NetworkUtils.numericToInetAddress(in2.readUTF());
                                                    if (staticIpConfiguration.gateway == null) {
                                                        staticIpConfiguration.gateway = gateway;
                                                    } else {
                                                        loge("Duplicate gateway: " + gateway.getHostAddress());
                                                    }
                                                } else {
                                                    if (in2.readInt() == 1) {
                                                        dest = new LinkAddress(NetworkUtils.numericToInetAddress(in2.readUTF()), in2.readInt());
                                                    }
                                                    if (in2.readInt() == 1) {
                                                        gateway = NetworkUtils.numericToInetAddress(in2.readUTF());
                                                    }
                                                    RouteInfo routeInfo = new RouteInfo(dest, gateway);
                                                    if (routeInfo.isIPv4Default() && staticIpConfiguration.gateway == null) {
                                                        staticIpConfiguration.gateway = gateway;
                                                    } else {
                                                        loge("Non-IPv4 default or duplicate route: " + routeInfo);
                                                    }
                                                }
                                            } else {
                                                if (key.equals(DNS_KEY)) {
                                                    staticIpConfiguration.dnsServers.add(NetworkUtils.numericToInetAddress(in2.readUTF()));
                                                } else {
                                                    if (key.equals(PROXY_SETTINGS_KEY)) {
                                                        proxySettings = ProxySettings.valueOf(in2.readUTF());
                                                    } else {
                                                        if (key.equals(PROXY_HOST_KEY)) {
                                                            proxyHost = in2.readUTF();
                                                        } else {
                                                            if (key.equals(PROXY_PORT_KEY)) {
                                                                proxyPort = in2.readInt();
                                                            } else {
                                                                if (key.equals(PROXY_PAC_FILE)) {
                                                                    pacFileUrl = in2.readUTF();
                                                                } else {
                                                                    if (key.equals(EXCLUSION_LIST_KEY)) {
                                                                        exclusionList = in2.readUTF();
                                                                    } else {
                                                                        if (!key.equals(EOS)) {
                                                                            loge("Ignore unknown key " + key + "while reading");
                                                                        } else if (id != -1) {
                                                                            IpConfiguration config = new IpConfiguration();
                                                                            networks.put(id, config);
                                                                            switch (C03892.$SwitchMap$android$net$IpConfiguration$IpAssignment[ipAssignment.ordinal()]) {
                                                                                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                                                                                    config.staticIpConfiguration = staticIpConfiguration;
                                                                                    config.ipAssignment = ipAssignment;
                                                                                    break;
                                                                                case IPCONFIG_FILE_VERSION /*2*/:
                                                                                    config.ipAssignment = ipAssignment;
                                                                                    break;
                                                                                case C0569H.REPORT_LOSING_FOCUS /*3*/:
                                                                                    loge("BUG: Found UNASSIGNED IP on file, use DHCP");
                                                                                    config.ipAssignment = IpAssignment.DHCP;
                                                                                    break;
                                                                                default:
                                                                                    loge("Ignore invalid ip assignment while reading.");
                                                                                    config.ipAssignment = IpAssignment.UNASSIGNED;
                                                                                    break;
                                                                            }
                                                                            ProxyInfo proxyInfo;
                                                                            switch (C03892.$SwitchMap$android$net$IpConfiguration$ProxySettings[proxySettings.ordinal()]) {
                                                                                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                                                                                    proxyInfo = new ProxyInfo(proxyHost, proxyPort, exclusionList);
                                                                                    config.proxySettings = proxySettings;
                                                                                    config.httpProxy = proxyInfo;
                                                                                    break;
                                                                                case IPCONFIG_FILE_VERSION /*2*/:
                                                                                    proxyInfo = new ProxyInfo(pacFileUrl);
                                                                                    config.proxySettings = proxySettings;
                                                                                    config.httpProxy = proxyInfo;
                                                                                    break;
                                                                                case C0569H.REPORT_LOSING_FOCUS /*3*/:
                                                                                    config.proxySettings = proxySettings;
                                                                                    break;
                                                                                case C0569H.DO_TRAVERSAL /*4*/:
                                                                                    loge("BUG: Found UNASSIGNED proxy on file, use NONE");
                                                                                    config.proxySettings = ProxySettings.NONE;
                                                                                    break;
                                                                                default:
                                                                                    loge("Ignore invalid proxy settings while reading");
                                                                                    config.proxySettings = ProxySettings.UNASSIGNED;
                                                                                    break;
                                                                            }
                                                                        } else {
                                                                            log("Missing id while parsing configuration");
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            } catch (IllegalArgumentException e2) {
                                loge("Ignore invalid address while reading" + e2);
                            }
                        }
                    }
                } else {
                    loge("Bad version on IP configuration file, ignore read");
                    networks = null;
                    if (in2 != null) {
                        try {
                            in2.close();
                        } catch (Exception e3) {
                        }
                    }
                    in = in2;
                    return networks;
                }
            } catch (EOFException e4) {
                in = in2;
            } catch (IOException e5) {
                e = e5;
                in = in2;
            } catch (Throwable th2) {
                th = th2;
                in = in2;
            }
        } catch (EOFException e6) {
            if (in != null) {
                try {
                    in.close();
                } catch (Exception e7) {
                }
            }
            return networks;
        } catch (IOException e8) {
            e = e8;
            try {
                loge("Error parsing configuration: " + e);
                if (in != null) {
                    try {
                        in.close();
                    } catch (Exception e9) {
                    }
                }
                return networks;
            } catch (Throwable th3) {
                th = th3;
                if (in != null) {
                    try {
                        in.close();
                    } catch (Exception e10) {
                    }
                }
                throw th;
            }
        }
    }

    protected void loge(String s) {
        Log.e(TAG, s);
    }

    protected void log(String s) {
        Log.d(TAG, s);
    }
}
