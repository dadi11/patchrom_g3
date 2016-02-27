package com.android.internal.telephony.dataconnection;

import android.net.LinkAddress;
import android.net.LinkProperties;
import android.net.NetworkUtils;
import android.net.RouteInfo;
import android.os.SystemProperties;
import android.telephony.Rlog;
import com.google.android.mms.pdu.PduPart;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.UnknownHostException;

public class DataCallResponse {
    private final boolean DBG;
    private final String LOG_TAG;
    public int active;
    public String[] addresses;
    public int cid;
    public String[] dnses;
    public String[] gateways;
    public String ifname;
    public int mtu;
    public String[] pcscf;
    public int status;
    public int suggestedRetryTime;
    public String type;
    public int version;

    public enum SetupResult {
        SUCCESS,
        ERR_BadCommand,
        ERR_UnacceptableParameter,
        ERR_GetLastErrorFromRil,
        ERR_Stale,
        ERR_RilError;
        
        public DcFailCause mFailCause;

        public String toString() {
            return name() + "  SetupResult.mFailCause=" + this.mFailCause;
        }
    }

    public DataCallResponse() {
        this.DBG = true;
        this.LOG_TAG = "DataCallResponse";
        this.version = 0;
        this.status = 0;
        this.cid = 0;
        this.active = 0;
        this.type = "";
        this.ifname = "";
        this.addresses = new String[0];
        this.dnses = new String[0];
        this.gateways = new String[0];
        this.suggestedRetryTime = -1;
        this.pcscf = new String[0];
        this.mtu = 0;
    }

    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("DataCallResponse: {").append("version=").append(this.version).append(" status=").append(this.status).append(" retry=").append(this.suggestedRetryTime).append(" cid=").append(this.cid).append(" active=").append(this.active).append(" type=").append(this.type).append(" ifname=").append(this.ifname).append(" mtu=").append(this.mtu).append(" addresses=[");
        for (String addr : this.addresses) {
            sb.append(addr);
            sb.append(",");
        }
        if (this.addresses.length > 0) {
            sb.deleteCharAt(sb.length() - 1);
        }
        sb.append("] dnses=[");
        for (String addr2 : this.dnses) {
            sb.append(addr2);
            sb.append(",");
        }
        if (this.dnses.length > 0) {
            sb.deleteCharAt(sb.length() - 1);
        }
        sb.append("] gateways=[");
        for (String addr22 : this.gateways) {
            sb.append(addr22);
            sb.append(",");
        }
        if (this.gateways.length > 0) {
            sb.deleteCharAt(sb.length() - 1);
        }
        sb.append("] pcscf=[");
        for (String addr222 : this.pcscf) {
            sb.append(addr222);
            sb.append(",");
        }
        if (this.pcscf.length > 0) {
            sb.deleteCharAt(sb.length() - 1);
        }
        sb.append("]}");
        return sb.toString();
    }

    public SetupResult setLinkProperties(LinkProperties linkProperties, boolean okToUseSystemPropertyDns) {
        String addr;
        String dnsAddr;
        SetupResult result;
        if (linkProperties == null) {
            linkProperties = new LinkProperties();
        } else {
            linkProperties.clear();
        }
        if (this.status == DcFailCause.NONE.getErrorCode()) {
            String propertyPrefix = "net." + this.ifname + ".";
            linkProperties.setInterfaceName(this.ifname);
            if (this.addresses == null || this.addresses.length <= 0) {
                throw new UnknownHostException("no address for ifname=" + this.ifname);
            }
            InetAddress ia;
            for (String addr2 : this.addresses) {
                addr2 = addr2.trim();
                if (!addr2.isEmpty()) {
                    try {
                        int addrPrefixLen;
                        String[] ap = addr2.split("/");
                        if (ap.length == 2) {
                            addr2 = ap[0];
                            addrPrefixLen = Integer.parseInt(ap[1].replaceAll("[\\D]", ""));
                        } else {
                            addrPrefixLen = 0;
                        }
                        ia = NetworkUtils.numericToInetAddress(addr2);
                        if (!ia.isAnyLocalAddress()) {
                            if (addrPrefixLen == 0) {
                                addrPrefixLen = ia instanceof Inet4Address ? 32 : PduPart.P_Q;
                            }
                            Rlog.d("DataCallResponse", "addr/pl=" + addr2 + "/" + addrPrefixLen);
                            linkProperties.addLinkAddress(new LinkAddress(ia, addrPrefixLen));
                        }
                    } catch (IllegalArgumentException e) {
                        throw new UnknownHostException("Non-numeric gateway addr=" + addr2);
                    } catch (IllegalArgumentException e2) {
                        throw new UnknownHostException("Non-numeric dns addr=" + dnsAddr);
                    } catch (IllegalArgumentException e3) {
                        throw new UnknownHostException("Non-numeric dns addr=" + addr2);
                    } catch (IllegalArgumentException e4) {
                        throw new UnknownHostException("Non-numeric ip addr=" + addr2);
                    } catch (UnknownHostException e5) {
                        Rlog.d("DataCallResponse", "setLinkProperties: UnknownHostException " + e5);
                        e5.printStackTrace();
                        result = SetupResult.ERR_UnacceptableParameter;
                    }
                }
            }
            if (this.dnses != null && this.dnses.length > 0) {
                for (String addr22 : this.dnses) {
                    addr22 = addr22.trim();
                    if (!addr22.isEmpty()) {
                        ia = NetworkUtils.numericToInetAddress(addr22);
                        if (!ia.isAnyLocalAddress()) {
                            linkProperties.addDnsServer(ia);
                        }
                    }
                }
            } else if (okToUseSystemPropertyDns) {
                dnsServers = new String[2];
                dnsServers[0] = SystemProperties.get(propertyPrefix + "dns1");
                dnsServers[1] = SystemProperties.get(propertyPrefix + "dns2");
                for (String dnsAddr2 : dnsServers) {
                    dnsAddr2 = dnsAddr2.trim();
                    if (!dnsAddr2.isEmpty()) {
                        ia = NetworkUtils.numericToInetAddress(dnsAddr2);
                        if (!ia.isAnyLocalAddress()) {
                            linkProperties.addDnsServer(ia);
                        }
                    }
                }
            } else {
                throw new UnknownHostException("Empty dns response and no system default dns");
            }
            if (this.gateways == null || this.gateways.length == 0) {
                String sysGateways = SystemProperties.get(propertyPrefix + "gw");
                if (sysGateways != null) {
                    this.gateways = sysGateways.split(" ");
                } else {
                    this.gateways = new String[0];
                }
            }
            for (String addr222 : this.gateways) {
                addr222 = addr222.trim();
                if (!addr222.isEmpty()) {
                    linkProperties.addRoute(new RouteInfo(NetworkUtils.numericToInetAddress(addr222)));
                }
            }
            linkProperties.setMtu(this.mtu);
            result = SetupResult.SUCCESS;
        } else if (this.version < 4) {
            result = SetupResult.ERR_GetLastErrorFromRil;
        } else {
            result = SetupResult.ERR_RilError;
        }
        if (result != SetupResult.SUCCESS) {
            Rlog.d("DataCallResponse", "setLinkProperties: error clearing LinkProperties status=" + this.status + " result=" + result);
            linkProperties.clear();
        }
        return result;
    }
}
