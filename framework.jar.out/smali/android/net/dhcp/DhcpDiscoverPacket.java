package android.net.dhcp;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.nio.ByteBuffer;

class DhcpDiscoverPacket extends DhcpPacket {
    DhcpDiscoverPacket(int transId, byte[] clientMac, boolean broadcast) {
        super(transId, Inet4Address.ANY, Inet4Address.ANY, Inet4Address.ANY, Inet4Address.ANY, clientMac, broadcast);
    }

    public String toString() {
        return super.toString() + " DISCOVER " + (this.mBroadcast ? "broadcast " : "unicast ");
    }

    public ByteBuffer buildPacket(int encap, short destUdp, short srcUdp) {
        ByteBuffer result = ByteBuffer.allocate(1500);
        InetAddress destIp = Inet4Address.ALL;
        fillInPacket(encap, Inet4Address.ALL, Inet4Address.ANY, destUdp, srcUdp, result, (byte) 1, true);
        result.flip();
        return result;
    }

    void finishPacket(ByteBuffer buffer) {
        addTlv(buffer, (byte) 53, (byte) 1);
        addTlv(buffer, (byte) 55, this.mRequestedParams);
        addTlvEnd(buffer);
    }

    public void doNextOp(DhcpStateMachine machine) {
        machine.onDiscoverReceived(this.mBroadcast, this.mTransId, this.mClientMac, this.mRequestedParams);
    }
}
