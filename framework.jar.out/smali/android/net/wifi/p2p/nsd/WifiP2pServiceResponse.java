package android.net.wifi.p2p.nsd;

import android.net.wifi.p2p.WifiP2pDevice;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.Toast;
import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class WifiP2pServiceResponse implements Parcelable {
    public static final Creator<WifiP2pServiceResponse> CREATOR;
    private static int MAX_BUF_SIZE;
    protected byte[] mData;
    protected WifiP2pDevice mDevice;
    protected int mServiceType;
    protected int mStatus;
    protected int mTransId;

    /* renamed from: android.net.wifi.p2p.nsd.WifiP2pServiceResponse.1 */
    static class C05601 implements Creator<WifiP2pServiceResponse> {
        C05601() {
        }

        public WifiP2pServiceResponse createFromParcel(Parcel in) {
            int type = in.readInt();
            int status = in.readInt();
            int transId = in.readInt();
            WifiP2pDevice dev = (WifiP2pDevice) in.readParcelable(null);
            int len = in.readInt();
            byte[] data = null;
            if (len > 0) {
                data = new byte[len];
                in.readByteArray(data);
            }
            if (type == 1) {
                return WifiP2pDnsSdServiceResponse.newInstance(status, transId, dev, data);
            }
            if (type == 2) {
                return WifiP2pUpnpServiceResponse.newInstance(status, transId, dev, data);
            }
            return new WifiP2pServiceResponse(type, status, transId, dev, data);
        }

        public WifiP2pServiceResponse[] newArray(int size) {
            return new WifiP2pServiceResponse[size];
        }
    }

    public static class Status {
        public static final int BAD_REQUEST = 3;
        public static final int REQUESTED_INFORMATION_NOT_AVAILABLE = 2;
        public static final int SERVICE_PROTOCOL_NOT_AVAILABLE = 1;
        public static final int SUCCESS = 0;

        public static String toString(int status) {
            switch (status) {
                case Toast.LENGTH_SHORT /*0*/:
                    return "SUCCESS";
                case SERVICE_PROTOCOL_NOT_AVAILABLE /*1*/:
                    return "SERVICE_PROTOCOL_NOT_AVAILABLE";
                case REQUESTED_INFORMATION_NOT_AVAILABLE /*2*/:
                    return "REQUESTED_INFORMATION_NOT_AVAILABLE";
                case BAD_REQUEST /*3*/:
                    return "BAD_REQUEST";
                default:
                    return "UNKNOWN";
            }
        }

        private Status() {
        }
    }

    static {
        MAX_BUF_SIZE = AccessibilityNodeInfo.ACTION_NEXT_HTML_ELEMENT;
        CREATOR = new C05601();
    }

    protected WifiP2pServiceResponse(int serviceType, int status, int transId, WifiP2pDevice device, byte[] data) {
        this.mServiceType = serviceType;
        this.mStatus = status;
        this.mTransId = transId;
        this.mDevice = device;
        this.mData = data;
    }

    public int getServiceType() {
        return this.mServiceType;
    }

    public int getStatus() {
        return this.mStatus;
    }

    public int getTransactionId() {
        return this.mTransId;
    }

    public byte[] getRawData() {
        return this.mData;
    }

    public WifiP2pDevice getSrcDevice() {
        return this.mDevice;
    }

    public void setSrcDevice(WifiP2pDevice dev) {
        if (dev != null) {
            this.mDevice = dev;
        }
    }

    public static List<WifiP2pServiceResponse> newInstance(String supplicantEvent) {
        List<WifiP2pServiceResponse> respList = new ArrayList();
        String[] args = supplicantEvent.split(" ");
        if (args.length != 4) {
            return null;
        }
        WifiP2pDevice dev = new WifiP2pDevice();
        dev.deviceAddress = args[1];
        byte[] bin = hexStr2Bin(args[3]);
        if (bin == null) {
            return null;
        }
        DataInputStream dis = new DataInputStream(new ByteArrayInputStream(bin));
        while (dis.available() > 0) {
            int length = (dis.readUnsignedByte() + (dis.readUnsignedByte() << 8)) - 3;
            int type = dis.readUnsignedByte();
            int transId = dis.readUnsignedByte();
            int status = dis.readUnsignedByte();
            if (length < 0) {
                return null;
            }
            if (length != 0) {
                try {
                    if (length > MAX_BUF_SIZE) {
                        dis.skip((long) length);
                    } else {
                        WifiP2pServiceResponse resp;
                        byte[] data = new byte[length];
                        dis.readFully(data);
                        if (type == 1) {
                            resp = WifiP2pDnsSdServiceResponse.newInstance(status, transId, dev, data);
                        } else if (type == 2) {
                            resp = WifiP2pUpnpServiceResponse.newInstance(status, transId, dev, data);
                        } else {
                            resp = new WifiP2pServiceResponse(type, status, transId, dev, data);
                        }
                        if (resp != null && resp.getStatus() == 0) {
                            respList.add(resp);
                        }
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                    return respList.size() <= 0 ? null : respList;
                }
            } else if (status == 0) {
                respList.add(new WifiP2pServiceResponse(type, status, transId, dev, null));
            }
        }
        return respList;
    }

    private static byte[] hexStr2Bin(String hex) {
        int sz = hex.length() / 2;
        byte[] b = new byte[(hex.length() / 2)];
        int i = 0;
        while (i < sz) {
            try {
                b[i] = (byte) Integer.parseInt(hex.substring(i * 2, (i * 2) + 2), 16);
                i++;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        }
        return b;
    }

    public String toString() {
        StringBuffer sbuf = new StringBuffer();
        sbuf.append("serviceType:").append(this.mServiceType);
        sbuf.append(" status:").append(Status.toString(this.mStatus));
        sbuf.append(" srcAddr:").append(this.mDevice.deviceAddress);
        sbuf.append(" data:").append(this.mData);
        return sbuf.toString();
    }

    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        if (!(o instanceof WifiP2pServiceResponse)) {
            return false;
        }
        WifiP2pServiceResponse req = (WifiP2pServiceResponse) o;
        if (req.mServiceType == this.mServiceType && req.mStatus == this.mStatus && equals(req.mDevice.deviceAddress, this.mDevice.deviceAddress) && Arrays.equals(req.mData, this.mData)) {
            return true;
        }
        return false;
    }

    private boolean equals(Object a, Object b) {
        if (a == null && b == null) {
            return true;
        }
        if (a != null) {
            return a.equals(b);
        }
        return false;
    }

    public int hashCode() {
        int i = 0;
        int hashCode = (((((((this.mServiceType + 527) * 31) + this.mStatus) * 31) + this.mTransId) * 31) + (this.mDevice.deviceAddress == null ? 0 : this.mDevice.deviceAddress.hashCode())) * 31;
        if (this.mData != null) {
            i = Arrays.hashCode(this.mData);
        }
        return hashCode + i;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mServiceType);
        dest.writeInt(this.mStatus);
        dest.writeInt(this.mTransId);
        dest.writeParcelable(this.mDevice, flags);
        if (this.mData == null || this.mData.length == 0) {
            dest.writeInt(0);
            return;
        }
        dest.writeInt(this.mData.length);
        dest.writeByteArray(this.mData);
    }
}
