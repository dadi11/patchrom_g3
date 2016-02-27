package android.net;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.Process;

public class NetworkRequest implements Parcelable {
    public static final Creator<NetworkRequest> CREATOR;
    public final int legacyType;
    public final NetworkCapabilities networkCapabilities;
    public final int requestId;

    /* renamed from: android.net.NetworkRequest.1 */
    static class C04961 implements Creator<NetworkRequest> {
        C04961() {
        }

        public NetworkRequest createFromParcel(Parcel in) {
            return new NetworkRequest((NetworkCapabilities) in.readParcelable(null), in.readInt(), in.readInt());
        }

        public NetworkRequest[] newArray(int size) {
            return new NetworkRequest[size];
        }
    }

    public static class Builder {
        private final NetworkCapabilities mNetworkCapabilities;

        public Builder() {
            this.mNetworkCapabilities = new NetworkCapabilities();
        }

        public NetworkRequest build() {
            return new NetworkRequest(this.mNetworkCapabilities, -1, 0);
        }

        public Builder addCapability(int capability) {
            this.mNetworkCapabilities.addCapability(capability);
            return this;
        }

        public Builder removeCapability(int capability) {
            this.mNetworkCapabilities.removeCapability(capability);
            return this;
        }

        public Builder addTransportType(int transportType) {
            this.mNetworkCapabilities.addTransportType(transportType);
            return this;
        }

        public Builder removeTransportType(int transportType) {
            this.mNetworkCapabilities.removeTransportType(transportType);
            return this;
        }

        public Builder setLinkUpstreamBandwidthKbps(int upKbps) {
            this.mNetworkCapabilities.setLinkUpstreamBandwidthKbps(upKbps);
            return this;
        }

        public Builder setLinkDownstreamBandwidthKbps(int downKbps) {
            this.mNetworkCapabilities.setLinkDownstreamBandwidthKbps(downKbps);
            return this;
        }

        public Builder setNetworkSpecifier(String networkSpecifier) {
            this.mNetworkCapabilities.setNetworkSpecifier(networkSpecifier);
            return this;
        }
    }

    public NetworkRequest(NetworkCapabilities nc, int legacyType, int rId) {
        if (nc == null) {
            throw new NullPointerException();
        }
        this.requestId = rId;
        this.networkCapabilities = nc;
        this.legacyType = legacyType;
    }

    public NetworkRequest(NetworkRequest that) {
        this.networkCapabilities = new NetworkCapabilities(that.networkCapabilities);
        this.requestId = that.requestId;
        this.legacyType = that.legacyType;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeParcelable(this.networkCapabilities, flags);
        dest.writeInt(this.legacyType);
        dest.writeInt(this.requestId);
    }

    static {
        CREATOR = new C04961();
    }

    public String toString() {
        return "NetworkRequest [ id=" + this.requestId + ", legacyType=" + this.legacyType + ", " + this.networkCapabilities.toString() + " ]";
    }

    public boolean equals(Object obj) {
        if (!(obj instanceof NetworkRequest)) {
            return false;
        }
        NetworkRequest that = (NetworkRequest) obj;
        if (that.legacyType != this.legacyType || that.requestId != this.requestId) {
            return false;
        }
        if ((that.networkCapabilities != null || this.networkCapabilities != null) && (that.networkCapabilities == null || !that.networkCapabilities.equals(this.networkCapabilities))) {
            return false;
        }
        return true;
    }

    public int hashCode() {
        return (this.requestId + (this.legacyType * Process.MEDIA_UID)) + (this.networkCapabilities.hashCode() * 1051);
    }
}
