package android.net.dhcp;

import android.net.ProxyInfo;
import android.net.wifi.WifiEnterpriseConfig;
import android.view.KeyEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.AppSecurityPermissions;
import android.widget.ListPopupWindow;
import android.widget.SpellChecker;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.ShortBuffer;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

abstract class DhcpPacket {
    protected static final byte CLIENT_ID_ETHER = (byte) 1;
    protected static final byte DHCP_BOOTREPLY = (byte) 2;
    protected static final byte DHCP_BOOTREQUEST = (byte) 1;
    protected static final byte DHCP_BROADCAST_ADDRESS = (byte) 28;
    static final short DHCP_CLIENT = (short) 68;
    protected static final byte DHCP_CLIENT_IDENTIFIER = (byte) 61;
    protected static final byte DHCP_DNS_SERVER = (byte) 6;
    protected static final byte DHCP_DOMAIN_NAME = (byte) 15;
    protected static final byte DHCP_HOST_NAME = (byte) 12;
    protected static final byte DHCP_LEASE_TIME = (byte) 51;
    protected static final byte DHCP_MESSAGE = (byte) 56;
    protected static final byte DHCP_MESSAGE_TYPE = (byte) 53;
    protected static final byte DHCP_MESSAGE_TYPE_ACK = (byte) 5;
    protected static final byte DHCP_MESSAGE_TYPE_DECLINE = (byte) 4;
    protected static final byte DHCP_MESSAGE_TYPE_DISCOVER = (byte) 1;
    protected static final byte DHCP_MESSAGE_TYPE_INFORM = (byte) 8;
    protected static final byte DHCP_MESSAGE_TYPE_NAK = (byte) 6;
    protected static final byte DHCP_MESSAGE_TYPE_OFFER = (byte) 2;
    protected static final byte DHCP_MESSAGE_TYPE_REQUEST = (byte) 3;
    protected static final byte DHCP_PARAMETER_LIST = (byte) 55;
    protected static final byte DHCP_RENEWAL_TIME = (byte) 58;
    protected static final byte DHCP_REQUESTED_IP = (byte) 50;
    protected static final byte DHCP_ROUTER = (byte) 3;
    static final short DHCP_SERVER = (short) 67;
    protected static final byte DHCP_SERVER_IDENTIFIER = (byte) 54;
    protected static final byte DHCP_SUBNET_MASK = (byte) 1;
    protected static final byte DHCP_VENDOR_CLASS_ID = (byte) 60;
    public static final int ENCAP_BOOTP = 2;
    public static final int ENCAP_L2 = 0;
    public static final int ENCAP_L3 = 1;
    private static final short IP_FLAGS_OFFSET = (short) 16384;
    private static final byte IP_TOS_LOWDELAY = (byte) 16;
    private static final byte IP_TTL = (byte) 64;
    private static final byte IP_TYPE_UDP = (byte) 17;
    private static final byte IP_VERSION_HEADER_LEN = (byte) 69;
    protected static final int MAX_LENGTH = 1500;
    protected static final String TAG = "DhcpPacket";
    protected boolean mBroadcast;
    protected InetAddress mBroadcastAddress;
    protected final InetAddress mClientIp;
    protected final byte[] mClientMac;
    protected List<InetAddress> mDnsServers;
    protected String mDomainName;
    protected InetAddress mGateway;
    protected String mHostName;
    protected Integer mLeaseTime;
    protected String mMessage;
    private final InetAddress mNextIp;
    private final InetAddress mRelayIp;
    protected InetAddress mRequestedIp;
    protected byte[] mRequestedParams;
    protected InetAddress mServerIdentifier;
    protected InetAddress mSubnetMask;
    protected final int mTransId;
    protected final InetAddress mYourIp;

    public abstract ByteBuffer buildPacket(int i, short s, short s2);

    public abstract void doNextOp(DhcpStateMachine dhcpStateMachine);

    abstract void finishPacket(ByteBuffer byteBuffer);

    protected DhcpPacket(int transId, InetAddress clientIp, InetAddress yourIp, InetAddress nextIp, InetAddress relayIp, byte[] clientMac, boolean broadcast) {
        this.mTransId = transId;
        this.mClientIp = clientIp;
        this.mYourIp = yourIp;
        this.mNextIp = nextIp;
        this.mRelayIp = relayIp;
        this.mClientMac = clientMac;
        this.mBroadcast = broadcast;
    }

    public int getTransactionId() {
        return this.mTransId;
    }

    protected void fillInPacket(int encap, InetAddress destIp, InetAddress srcIp, short destUdp, short srcUdp, ByteBuffer buf, byte requestCode, boolean broadcast) {
        byte[] destIpArray = destIp.getAddress();
        byte[] srcIpArray = srcIp.getAddress();
        int ipLengthOffset = ENCAP_L2;
        int ipChecksumOffset = ENCAP_L2;
        int endIpHeader = ENCAP_L2;
        int udpHeaderOffset = ENCAP_L2;
        int udpLengthOffset = ENCAP_L2;
        int udpChecksumOffset = ENCAP_L2;
        buf.clear();
        buf.order(ByteOrder.BIG_ENDIAN);
        if (encap == ENCAP_L3) {
            buf.put(IP_VERSION_HEADER_LEN);
            buf.put(IP_TOS_LOWDELAY);
            ipLengthOffset = buf.position();
            buf.putShort((short) 0);
            buf.putShort((short) 0);
            buf.putShort(IP_FLAGS_OFFSET);
            buf.put(IP_TTL);
            buf.put(IP_TYPE_UDP);
            ipChecksumOffset = buf.position();
            buf.putShort((short) 0);
            buf.put(srcIpArray);
            buf.put(destIpArray);
            endIpHeader = buf.position();
            udpHeaderOffset = buf.position();
            buf.putShort(srcUdp);
            buf.putShort(destUdp);
            udpLengthOffset = buf.position();
            buf.putShort((short) 0);
            udpChecksumOffset = buf.position();
            buf.putShort((short) 0);
        }
        buf.put(requestCode);
        buf.put(DHCP_SUBNET_MASK);
        buf.put((byte) this.mClientMac.length);
        buf.put((byte) 0);
        buf.putInt(this.mTransId);
        buf.putShort((short) 0);
        if (broadcast) {
            buf.putShort(Short.MIN_VALUE);
        } else {
            buf.putShort((short) 0);
        }
        buf.put(this.mClientIp.getAddress());
        buf.put(this.mYourIp.getAddress());
        buf.put(this.mNextIp.getAddress());
        buf.put(this.mRelayIp.getAddress());
        buf.put(this.mClientMac);
        buf.position(((buf.position() + (16 - this.mClientMac.length)) + 64) + AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
        buf.putInt(1669485411);
        finishPacket(buf);
        if ((buf.position() & ENCAP_L3) == ENCAP_L3) {
            buf.put((byte) 0);
        }
        if (encap == ENCAP_L3) {
            short udpLen = (short) (buf.position() - udpHeaderOffset);
            buf.putShort(udpLengthOffset, udpLen);
            ByteBuffer byteBuffer = buf;
            byteBuffer = buf;
            byteBuffer.putShort(udpChecksumOffset, (short) checksum(byteBuffer, (((((ENCAP_L2 + intAbs(buf.getShort(ipChecksumOffset + ENCAP_BOOTP))) + intAbs(buf.getShort(ipChecksumOffset + 4))) + intAbs(buf.getShort(ipChecksumOffset + 6))) + intAbs(buf.getShort(ipChecksumOffset + 8))) + 17) + udpLen, udpHeaderOffset, buf.position()));
            buf.putShort(ipLengthOffset, (short) buf.position());
            buf.putShort(ipChecksumOffset, (short) checksum(buf, ENCAP_L2, ENCAP_L2, endIpHeader));
        }
    }

    private int intAbs(short v) {
        if (v < (short) 0) {
            return v + AccessibilityNodeInfo.ACTION_CUT;
        }
        return v;
    }

    private int checksum(ByteBuffer buf, int seed, int start, int end) {
        int sum = seed;
        int bufPosition = buf.position();
        buf.position(start);
        ShortBuffer shortBuf = buf.asShortBuffer();
        buf.position(bufPosition);
        short[] shortArray = new short[((end - start) / ENCAP_BOOTP)];
        shortBuf.get(shortArray);
        short[] arr$ = shortArray;
        int len$ = arr$.length;
        for (int i$ = ENCAP_L2; i$ < len$; i$ += ENCAP_L3) {
            sum += intAbs(arr$[i$]);
        }
        start += shortArray.length * ENCAP_BOOTP;
        if (end != start) {
            short b = (short) buf.get(start);
            if (b < (short) 0) {
                b = (short) (b + InputMethodManager.CONTROL_START_INITIAL);
            }
            sum += b * InputMethodManager.CONTROL_START_INITIAL;
        }
        sum = ((sum >> 16) & AppSecurityPermissions.WHICH_ALL) + (AppSecurityPermissions.WHICH_ALL & sum);
        return intAbs((short) (((((sum >> 16) & AppSecurityPermissions.WHICH_ALL) + sum) & AppSecurityPermissions.WHICH_ALL) ^ -1));
    }

    protected void addTlv(ByteBuffer buf, byte type, byte value) {
        buf.put(type);
        buf.put(DHCP_SUBNET_MASK);
        buf.put(value);
    }

    protected void addTlv(ByteBuffer buf, byte type, byte[] payload) {
        if (payload != null) {
            buf.put(type);
            buf.put((byte) payload.length);
            buf.put(payload);
        }
    }

    protected void addTlv(ByteBuffer buf, byte type, InetAddress addr) {
        if (addr != null) {
            addTlv(buf, type, addr.getAddress());
        }
    }

    protected void addTlv(ByteBuffer buf, byte type, List<InetAddress> addrs) {
        if (addrs != null && addrs.size() > 0) {
            buf.put(type);
            buf.put((byte) (addrs.size() * 4));
            for (InetAddress addr : addrs) {
                buf.put(addr.getAddress());
            }
        }
    }

    protected void addTlv(ByteBuffer buf, byte type, Integer value) {
        if (value != null) {
            buf.put(type);
            buf.put(DHCP_MESSAGE_TYPE_DECLINE);
            buf.putInt(value.intValue());
        }
    }

    protected void addTlv(ByteBuffer buf, byte type, String str) {
        if (str != null) {
            buf.put(type);
            buf.put((byte) str.length());
            for (int i = ENCAP_L2; i < str.length(); i += ENCAP_L3) {
                buf.put((byte) str.charAt(i));
            }
        }
    }

    protected void addTlvEnd(ByteBuffer buf) {
        buf.put((byte) -1);
    }

    public static String macToString(byte[] mac) {
        String macAddr = ProxyInfo.LOCAL_EXCL_LIST;
        for (int i = ENCAP_L2; i < mac.length; i += ENCAP_L3) {
            String hexString = WifiEnterpriseConfig.ENGINE_DISABLE + Integer.toHexString(mac[i]);
            macAddr = macAddr + hexString.substring(hexString.length() - 2);
            if (i != mac.length - 1) {
                macAddr = macAddr + ":";
            }
        }
        return macAddr;
    }

    public String toString() {
        return macToString(this.mClientMac);
    }

    private static InetAddress readIpAddress(ByteBuffer packet) {
        byte[] ipAddr = new byte[4];
        packet.get(ipAddr);
        try {
            return InetAddress.getByAddress(ipAddr);
        } catch (UnknownHostException e) {
            return null;
        }
    }

    private static String readAsciiString(ByteBuffer buf, int byteCount) {
        byte[] bytes = new byte[byteCount];
        buf.get(bytes);
        return new String(bytes, ENCAP_L2, bytes.length, StandardCharsets.US_ASCII);
    }

    public static DhcpPacket decodeFullPacket(ByteBuffer packet, int pktType) {
        List<InetAddress> dnsServers = new ArrayList();
        InetAddress gateway = null;
        Integer leaseTime = null;
        InetAddress serverIdentifier = null;
        InetAddress netMask = null;
        String message = null;
        byte[] expectedParams = null;
        String hostName = null;
        String domainName = null;
        InetAddress ipSrc = null;
        InetAddress bcAddr = null;
        InetAddress requestedIp = null;
        byte dhcpType = (byte) -1;
        packet.order(ByteOrder.BIG_ENDIAN);
        if (pktType == 0) {
            byte[] l2src = new byte[6];
            packet.get(new byte[6]);
            packet.get(l2src);
            if (packet.getShort() != (short) 2048) {
                return null;
            }
        }
        if (pktType == 0 || pktType == ENCAP_L3) {
            byte ipType = packet.get();
            byte ipDiffServicesField = packet.get();
            short ipTotalLength = packet.getShort();
            short ipIdentification = packet.getShort();
            byte ipFlags = packet.get();
            byte ipFragOffset = packet.get();
            byte ipTTL = packet.get();
            byte ipProto = packet.get();
            short ipChksm = packet.getShort();
            ipSrc = readIpAddress(packet);
            InetAddress ipDst = readIpAddress(packet);
            if (ipProto != 17) {
                return null;
            }
            short udpSrcPort = packet.getShort();
            short udpDstPort = packet.getShort();
            short udpLen = packet.getShort();
            short udpChkSum = packet.getShort();
            if (!(udpSrcPort == (short) 67 || udpSrcPort == (short) 68)) {
                return null;
            }
        }
        byte type = packet.get();
        byte hwType = packet.get();
        byte addrLen = packet.get();
        byte hops = packet.get();
        int transactionId = packet.getInt();
        short elapsed = packet.getShort();
        boolean broadcast = (AccessibilityNodeInfo.ACTION_PASTE & packet.getShort()) != 0;
        byte[] ipv4addr = new byte[4];
        try {
            packet.get(ipv4addr);
            InetAddress clientIp = InetAddress.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            InetAddress yourIp = InetAddress.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            InetAddress nextIp = InetAddress.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            InetAddress relayIp = InetAddress.getByAddress(ipv4addr);
            byte[] clientMac = new byte[addrLen];
            packet.get(clientMac);
            packet.position(((packet.position() + (16 - addrLen)) + 64) + AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
            if (packet.getInt() != 1669485411) {
                return null;
            }
            DhcpPacket newPacket;
            boolean notFinishedOptions = true;
            while (packet.position() < packet.limit() && notFinishedOptions) {
                byte optionType = packet.get();
                if (optionType == -1) {
                    notFinishedOptions = false;
                } else {
                    byte optionLen = packet.get();
                    byte expectedLen = (byte) 0;
                    switch (optionType) {
                        case ENCAP_L3 /*1*/:
                            netMask = readIpAddress(packet);
                            expectedLen = DHCP_MESSAGE_TYPE_DECLINE;
                            break;
                        case SetDrawableParameters.TAG /*3*/:
                            gateway = readIpAddress(packet);
                            expectedLen = DHCP_MESSAGE_TYPE_DECLINE;
                            break;
                        case SetEmptyView.TAG /*6*/:
                            expectedLen = (byte) 0;
                            while (expectedLen < optionLen) {
                                dnsServers.add(readIpAddress(packet));
                                expectedLen += 4;
                            }
                            break;
                        case BitmapReflectionAction.TAG /*12*/:
                            expectedLen = optionLen;
                            hostName = readAsciiString(packet, optionLen);
                            break;
                        case SetRemoteViewsAdapterList.TAG /*15*/:
                            expectedLen = optionLen;
                            domainName = readAsciiString(packet, optionLen);
                            break;
                        case KeyEvent.KEYCODE_CLEAR /*28*/:
                            bcAddr = readIpAddress(packet);
                            expectedLen = DHCP_MESSAGE_TYPE_DECLINE;
                            break;
                        case SpellChecker.MAX_NUMBER_OF_WORDS /*50*/:
                            requestedIp = readIpAddress(packet);
                            expectedLen = DHCP_MESSAGE_TYPE_DECLINE;
                            break;
                        case KeyEvent.KEYCODE_W /*51*/:
                            leaseTime = Integer.valueOf(packet.getInt());
                            expectedLen = DHCP_MESSAGE_TYPE_DECLINE;
                            break;
                        case KeyEvent.KEYCODE_Y /*53*/:
                            dhcpType = packet.get();
                            expectedLen = DHCP_SUBNET_MASK;
                            break;
                        case KeyEvent.KEYCODE_Z /*54*/:
                            serverIdentifier = readIpAddress(packet);
                            expectedLen = DHCP_MESSAGE_TYPE_DECLINE;
                            break;
                        case KeyEvent.KEYCODE_COMMA /*55*/:
                            expectedParams = new byte[optionLen];
                            packet.get(expectedParams);
                            expectedLen = optionLen;
                            break;
                        case KeyEvent.KEYCODE_PERIOD /*56*/:
                            expectedLen = optionLen;
                            message = readAsciiString(packet, optionLen);
                            break;
                        case KeyEvent.KEYCODE_SHIFT_RIGHT /*60*/:
                            expectedLen = optionLen;
                            String vendorId = readAsciiString(packet, optionLen);
                            break;
                        case KeyEvent.KEYCODE_TAB /*61*/:
                            packet.get(new byte[optionLen]);
                            expectedLen = optionLen;
                            break;
                        default:
                            for (byte i = (byte) 0; i < optionLen; i += ENCAP_L3) {
                                expectedLen += ENCAP_L3;
                                packet.get();
                            }
                            break;
                    }
                    if (expectedLen != optionLen) {
                        return null;
                    }
                }
            }
            DhcpPacket dhcpDeclinePacket;
            switch (dhcpType) {
                case ListPopupWindow.MATCH_PARENT /*-1*/:
                    return null;
                case ENCAP_L3 /*1*/:
                    newPacket = new DhcpDiscoverPacket(transactionId, clientMac, broadcast);
                    break;
                case ENCAP_BOOTP /*2*/:
                    newPacket = new DhcpOfferPacket(transactionId, broadcast, ipSrc, yourIp, clientMac);
                    break;
                case SetDrawableParameters.TAG /*3*/:
                    newPacket = new DhcpRequestPacket(transactionId, clientIp, clientMac, broadcast);
                    break;
                case ViewGroupAction.TAG /*4*/:
                    dhcpDeclinePacket = new DhcpDeclinePacket(transactionId, clientIp, yourIp, nextIp, relayIp, clientMac);
                    break;
                case ReflectionActionWithoutParams.TAG /*5*/:
                    newPacket = new DhcpAckPacket(transactionId, broadcast, ipSrc, yourIp, clientMac);
                    break;
                case SetEmptyView.TAG /*6*/:
                    dhcpDeclinePacket = new DhcpNakPacket(transactionId, clientIp, yourIp, nextIp, relayIp, clientMac);
                    break;
                case SetPendingIntentTemplate.TAG /*8*/:
                    dhcpDeclinePacket = new DhcpInformPacket(transactionId, clientIp, yourIp, nextIp, relayIp, clientMac);
                    break;
                default:
                    System.out.println("Unimplemented type: " + dhcpType);
                    return null;
            }
            newPacket.mBroadcastAddress = bcAddr;
            newPacket.mDnsServers = dnsServers;
            newPacket.mDomainName = domainName;
            newPacket.mGateway = gateway;
            newPacket.mHostName = hostName;
            newPacket.mLeaseTime = leaseTime;
            newPacket.mMessage = message;
            newPacket.mRequestedIp = requestedIp;
            newPacket.mRequestedParams = expectedParams;
            newPacket.mServerIdentifier = serverIdentifier;
            newPacket.mSubnetMask = netMask;
            return newPacket;
        } catch (UnknownHostException e) {
            return null;
        }
    }

    public static DhcpPacket decodeFullPacket(byte[] packet, int pktType) {
        return decodeFullPacket(ByteBuffer.wrap(packet).order(ByteOrder.BIG_ENDIAN), pktType);
    }

    public static ByteBuffer buildDiscoverPacket(int encap, int transactionId, byte[] clientMac, boolean broadcast, byte[] expectedParams) {
        DhcpPacket pkt = new DhcpDiscoverPacket(transactionId, clientMac, broadcast);
        pkt.mRequestedParams = expectedParams;
        return pkt.buildPacket(encap, DHCP_SERVER, DHCP_CLIENT);
    }

    public static ByteBuffer buildOfferPacket(int encap, int transactionId, boolean broadcast, InetAddress serverIpAddr, InetAddress clientIpAddr, byte[] mac, Integer timeout, InetAddress netMask, InetAddress bcAddr, InetAddress gateway, List<InetAddress> dnsServers, InetAddress dhcpServerIdentifier, String domainName) {
        DhcpPacket pkt = new DhcpOfferPacket(transactionId, broadcast, serverIpAddr, clientIpAddr, mac);
        pkt.mGateway = gateway;
        pkt.mDnsServers = dnsServers;
        pkt.mLeaseTime = timeout;
        pkt.mDomainName = domainName;
        pkt.mServerIdentifier = dhcpServerIdentifier;
        pkt.mSubnetMask = netMask;
        pkt.mBroadcastAddress = bcAddr;
        return pkt.buildPacket(encap, DHCP_CLIENT, DHCP_SERVER);
    }

    public static ByteBuffer buildAckPacket(int encap, int transactionId, boolean broadcast, InetAddress serverIpAddr, InetAddress clientIpAddr, byte[] mac, Integer timeout, InetAddress netMask, InetAddress bcAddr, InetAddress gateway, List<InetAddress> dnsServers, InetAddress dhcpServerIdentifier, String domainName) {
        DhcpPacket pkt = new DhcpAckPacket(transactionId, broadcast, serverIpAddr, clientIpAddr, mac);
        pkt.mGateway = gateway;
        pkt.mDnsServers = dnsServers;
        pkt.mLeaseTime = timeout;
        pkt.mDomainName = domainName;
        pkt.mSubnetMask = netMask;
        pkt.mServerIdentifier = dhcpServerIdentifier;
        pkt.mBroadcastAddress = bcAddr;
        return pkt.buildPacket(encap, DHCP_CLIENT, DHCP_SERVER);
    }

    public static ByteBuffer buildNakPacket(int encap, int transactionId, InetAddress serverIpAddr, InetAddress clientIpAddr, byte[] mac) {
        DhcpPacket pkt = new DhcpNakPacket(transactionId, clientIpAddr, serverIpAddr, serverIpAddr, serverIpAddr, mac);
        pkt.mMessage = "requested address not available";
        pkt.mRequestedIp = clientIpAddr;
        return pkt.buildPacket(encap, DHCP_CLIENT, DHCP_SERVER);
    }

    public static ByteBuffer buildRequestPacket(int encap, int transactionId, InetAddress clientIp, boolean broadcast, byte[] clientMac, InetAddress requestedIpAddress, InetAddress serverIdentifier, byte[] requestedParams, String hostName) {
        DhcpPacket pkt = new DhcpRequestPacket(transactionId, clientIp, clientMac, broadcast);
        pkt.mRequestedIp = requestedIpAddress;
        pkt.mServerIdentifier = serverIdentifier;
        pkt.mHostName = hostName;
        pkt.mRequestedParams = requestedParams;
        return pkt.buildPacket(encap, DHCP_SERVER, DHCP_CLIENT);
    }
}
