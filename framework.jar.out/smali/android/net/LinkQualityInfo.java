package android.net;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class LinkQualityInfo implements Parcelable {
    public static final Creator<LinkQualityInfo> CREATOR;
    public static final int NORMALIZED_MAX_SIGNAL_STRENGTH = 99;
    public static final int NORMALIZED_MIN_SIGNAL_STRENGTH = 0;
    public static final int NORMALIZED_SIGNAL_STRENGTH_RANGE = 100;
    protected static final int OBJECT_TYPE_LINK_QUALITY_INFO = 1;
    protected static final int OBJECT_TYPE_MOBILE_LINK_QUALITY_INFO = 3;
    protected static final int OBJECT_TYPE_WIFI_LINK_QUALITY_INFO = 2;
    public static final int UNKNOWN_INT = Integer.MAX_VALUE;
    public static final long UNKNOWN_LONG = Long.MAX_VALUE;
    private int mDataSampleDuration;
    private long mLastDataSampleTime;
    private int mNetworkType;
    private int mNormalizedSignalStrength;
    private long mPacketCount;
    private long mPacketErrorCount;
    private int mTheoreticalLatency;
    private int mTheoreticalRxBandwidth;
    private int mTheoreticalTxBandwidth;

    /* renamed from: android.net.LinkQualityInfo.1 */
    static class C04851 implements Creator<LinkQualityInfo> {
        C04851() {
        }

        public LinkQualityInfo createFromParcel(Parcel in) {
            int objectType = in.readInt();
            if (objectType == LinkQualityInfo.OBJECT_TYPE_LINK_QUALITY_INFO) {
                LinkQualityInfo li = new LinkQualityInfo();
                li.initializeFromParcel(in);
                return li;
            } else if (objectType == LinkQualityInfo.OBJECT_TYPE_WIFI_LINK_QUALITY_INFO) {
                return WifiLinkQualityInfo.createFromParcelBody(in);
            } else {
                if (objectType == LinkQualityInfo.OBJECT_TYPE_MOBILE_LINK_QUALITY_INFO) {
                    return MobileLinkQualityInfo.createFromParcelBody(in);
                }
                return null;
            }
        }

        public LinkQualityInfo[] newArray(int size) {
            return new LinkQualityInfo[size];
        }
    }

    public LinkQualityInfo() {
        this.mNetworkType = -1;
        this.mNormalizedSignalStrength = UNKNOWN_INT;
        this.mPacketCount = UNKNOWN_LONG;
        this.mPacketErrorCount = UNKNOWN_LONG;
        this.mTheoreticalTxBandwidth = UNKNOWN_INT;
        this.mTheoreticalRxBandwidth = UNKNOWN_INT;
        this.mTheoreticalLatency = UNKNOWN_INT;
        this.mLastDataSampleTime = UNKNOWN_LONG;
        this.mDataSampleDuration = UNKNOWN_INT;
    }

    public int describeContents() {
        return NORMALIZED_MIN_SIGNAL_STRENGTH;
    }

    public void writeToParcel(Parcel dest, int flags) {
        writeToParcel(dest, flags, OBJECT_TYPE_LINK_QUALITY_INFO);
    }

    public void writeToParcel(Parcel dest, int flags, int objectType) {
        dest.writeInt(objectType);
        dest.writeInt(this.mNetworkType);
        dest.writeInt(this.mNormalizedSignalStrength);
        dest.writeLong(this.mPacketCount);
        dest.writeLong(this.mPacketErrorCount);
        dest.writeInt(this.mTheoreticalTxBandwidth);
        dest.writeInt(this.mTheoreticalRxBandwidth);
        dest.writeInt(this.mTheoreticalLatency);
        dest.writeLong(this.mLastDataSampleTime);
        dest.writeInt(this.mDataSampleDuration);
    }

    static {
        CREATOR = new C04851();
    }

    protected void initializeFromParcel(Parcel in) {
        this.mNetworkType = in.readInt();
        this.mNormalizedSignalStrength = in.readInt();
        this.mPacketCount = in.readLong();
        this.mPacketErrorCount = in.readLong();
        this.mTheoreticalTxBandwidth = in.readInt();
        this.mTheoreticalRxBandwidth = in.readInt();
        this.mTheoreticalLatency = in.readInt();
        this.mLastDataSampleTime = in.readLong();
        this.mDataSampleDuration = in.readInt();
    }

    public int getNetworkType() {
        return this.mNetworkType;
    }

    public void setNetworkType(int networkType) {
        this.mNetworkType = networkType;
    }

    public int getNormalizedSignalStrength() {
        return this.mNormalizedSignalStrength;
    }

    public void setNormalizedSignalStrength(int normalizedSignalStrength) {
        this.mNormalizedSignalStrength = normalizedSignalStrength;
    }

    public long getPacketCount() {
        return this.mPacketCount;
    }

    public void setPacketCount(long packetCount) {
        this.mPacketCount = packetCount;
    }

    public long getPacketErrorCount() {
        return this.mPacketErrorCount;
    }

    public void setPacketErrorCount(long packetErrorCount) {
        this.mPacketErrorCount = packetErrorCount;
    }

    public int getTheoreticalTxBandwidth() {
        return this.mTheoreticalTxBandwidth;
    }

    public void setTheoreticalTxBandwidth(int theoreticalTxBandwidth) {
        this.mTheoreticalTxBandwidth = theoreticalTxBandwidth;
    }

    public int getTheoreticalRxBandwidth() {
        return this.mTheoreticalRxBandwidth;
    }

    public void setTheoreticalRxBandwidth(int theoreticalRxBandwidth) {
        this.mTheoreticalRxBandwidth = theoreticalRxBandwidth;
    }

    public int getTheoreticalLatency() {
        return this.mTheoreticalLatency;
    }

    public void setTheoreticalLatency(int theoreticalLatency) {
        this.mTheoreticalLatency = theoreticalLatency;
    }

    public long getLastDataSampleTime() {
        return this.mLastDataSampleTime;
    }

    public void setLastDataSampleTime(long lastDataSampleTime) {
        this.mLastDataSampleTime = lastDataSampleTime;
    }

    public int getDataSampleDuration() {
        return this.mDataSampleDuration;
    }

    public void setDataSampleDuration(int dataSampleDuration) {
        this.mDataSampleDuration = dataSampleDuration;
    }
}
