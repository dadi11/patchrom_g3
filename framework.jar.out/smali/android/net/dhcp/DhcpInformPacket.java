package android.net.dhcp;

import java.net.InetAddress;
import java.nio.ByteBuffer;

class DhcpInformPacket extends DhcpPacket {
    DhcpInformPacket(int transId, InetAddress clientIp, InetAddress yourIp, InetAddress nextIp, InetAddress relayIp, byte[] clientMac) {
        super(transId, clientIp, yourIp, nextIp, relayIp, clientMac, false);
    }

    public String toString() {
        return super.toString() + " INFORM";
    }

    public ByteBuffer buildPacket(int encap, short destUdp, short srcUdp) {
        ByteBuffer result = ByteBuffer.allocate(1500);
        fillInPacket(encap, this.mClientIp, this.mYourIp, destUdp, srcUdp, result, (byte) 1, false);
        result.flip();
        return result;
    }

    void finishPacket(ByteBuffer buffer) {
        byte[] clientId = new byte[7];
        clientId[0] = (byte) 1;
        System.arraycopy(this.mClientMac, 0, clientId, 1, 6);
        addTlv(buffer, (byte) 53, (byte) 3);
        addTlv(buffer, (byte) 55, this.mRequestedParams);
        addTlvEnd(buffer);
    }

    public void doNextOp(DhcpStateMachine machine) {
        machine.onInformReceived(this.mTransId, this.mClientMac, this.mRequestedIp == null ? this.mClientIp : this.mRequestedIp, this.mRequestedParams);
    }
}
