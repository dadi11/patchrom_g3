package android.net.dhcp;

import java.net.InetAddress;
import java.nio.ByteBuffer;

class DhcpDeclinePacket extends DhcpPacket {
    DhcpDeclinePacket(int transId, InetAddress clientIp, InetAddress yourIp, InetAddress nextIp, InetAddress relayIp, byte[] clientMac) {
        super(transId, clientIp, yourIp, nextIp, relayIp, clientMac, false);
    }

    public String toString() {
        return super.toString() + " DECLINE";
    }

    public ByteBuffer buildPacket(int encap, short destUdp, short srcUdp) {
        ByteBuffer result = ByteBuffer.allocate(1500);
        fillInPacket(encap, this.mClientIp, this.mYourIp, destUdp, srcUdp, result, (byte) 1, false);
        result.flip();
        return result;
    }

    void finishPacket(ByteBuffer buffer) {
    }

    public void doNextOp(DhcpStateMachine machine) {
        machine.onDeclineReceived(this.mClientMac, this.mRequestedIp);
    }
}
