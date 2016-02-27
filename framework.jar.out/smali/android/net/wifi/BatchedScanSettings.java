package android.net.wifi;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.ArrayList;
import java.util.Collection;

public class BatchedScanSettings implements Parcelable {
    public static final Creator<BatchedScanSettings> CREATOR;
    public static final int DEFAULT_AP_FOR_DISTANCE = 0;
    public static final int DEFAULT_AP_PER_SCAN = 16;
    public static final int DEFAULT_INTERVAL_SEC = 30;
    public static final int DEFAULT_SCANS_PER_BATCH = 20;
    public static final int MAX_AP_FOR_DISTANCE = 16;
    public static final int MAX_AP_PER_SCAN = 16;
    public static final int MAX_INTERVAL_SEC = 500;
    public static final int MAX_SCANS_PER_BATCH = 20;
    public static final int MAX_WIFI_CHANNEL = 196;
    public static final int MIN_AP_FOR_DISTANCE = 0;
    public static final int MIN_AP_PER_SCAN = 2;
    public static final int MIN_INTERVAL_SEC = 10;
    public static final int MIN_SCANS_PER_BATCH = 2;
    private static final String TAG = "BatchedScanSettings";
    public static final int UNSPECIFIED = Integer.MAX_VALUE;
    public Collection<String> channelSet;
    public int maxApForDistance;
    public int maxApPerScan;
    public int maxScansPerBatch;
    public int scanIntervalSec;

    /* renamed from: android.net.wifi.BatchedScanSettings.1 */
    static class C05211 implements Creator<BatchedScanSettings> {
        C05211() {
        }

        public BatchedScanSettings createFromParcel(Parcel in) {
            BatchedScanSettings settings = new BatchedScanSettings();
            settings.maxScansPerBatch = in.readInt();
            settings.maxApPerScan = in.readInt();
            settings.scanIntervalSec = in.readInt();
            settings.maxApForDistance = in.readInt();
            int channelCount = in.readInt();
            if (channelCount > 0) {
                settings.channelSet = new ArrayList(channelCount);
                int channelCount2 = channelCount;
                while (true) {
                    channelCount = channelCount2 - 1;
                    if (channelCount2 <= 0) {
                        break;
                    }
                    settings.channelSet.add(in.readString());
                    channelCount2 = channelCount;
                }
            }
            return settings;
        }

        public BatchedScanSettings[] newArray(int size) {
            return new BatchedScanSettings[size];
        }
    }

    public BatchedScanSettings() {
        clear();
    }

    public void clear() {
        this.maxScansPerBatch = UNSPECIFIED;
        this.maxApPerScan = UNSPECIFIED;
        this.channelSet = null;
        this.scanIntervalSec = UNSPECIFIED;
        this.maxApForDistance = UNSPECIFIED;
    }

    public BatchedScanSettings(BatchedScanSettings source) {
        this.maxScansPerBatch = source.maxScansPerBatch;
        this.maxApPerScan = source.maxApPerScan;
        if (source.channelSet != null) {
            this.channelSet = new ArrayList(source.channelSet);
        }
        this.scanIntervalSec = source.scanIntervalSec;
        this.maxApForDistance = source.maxApForDistance;
    }

    private boolean channelSetIsValid() {
        if (this.channelSet == null || this.channelSet.isEmpty()) {
            return true;
        }
        for (String channel : this.channelSet) {
            try {
                int i = Integer.parseInt(channel);
                if (i > 0 && i <= MAX_WIFI_CHANNEL) {
                }
            } catch (NumberFormatException e) {
            }
            if (!(channel.equals("A") || channel.equals("B"))) {
                return false;
            }
        }
        return true;
    }

    public boolean isInvalid() {
        if (this.maxScansPerBatch != UNSPECIFIED && (this.maxScansPerBatch < MIN_SCANS_PER_BATCH || this.maxScansPerBatch > MAX_SCANS_PER_BATCH)) {
            return true;
        }
        if ((this.maxApPerScan != UNSPECIFIED && (this.maxApPerScan < MIN_SCANS_PER_BATCH || this.maxApPerScan > MAX_AP_PER_SCAN)) || !channelSetIsValid()) {
            return true;
        }
        if (this.scanIntervalSec != UNSPECIFIED && (this.scanIntervalSec < MIN_INTERVAL_SEC || this.scanIntervalSec > MAX_INTERVAL_SEC)) {
            return true;
        }
        if (this.maxApForDistance == UNSPECIFIED || (this.maxApForDistance >= 0 && this.maxApForDistance <= MAX_AP_PER_SCAN)) {
            return false;
        }
        return true;
    }

    public void constrain() {
        if (this.scanIntervalSec == UNSPECIFIED) {
            this.scanIntervalSec = DEFAULT_INTERVAL_SEC;
        } else if (this.scanIntervalSec < MIN_INTERVAL_SEC) {
            this.scanIntervalSec = MIN_INTERVAL_SEC;
        } else if (this.scanIntervalSec > MAX_INTERVAL_SEC) {
            this.scanIntervalSec = MAX_INTERVAL_SEC;
        }
        if (this.maxScansPerBatch == UNSPECIFIED) {
            this.maxScansPerBatch = MAX_SCANS_PER_BATCH;
        } else if (this.maxScansPerBatch < MIN_SCANS_PER_BATCH) {
            this.maxScansPerBatch = MIN_SCANS_PER_BATCH;
        } else if (this.maxScansPerBatch > MAX_SCANS_PER_BATCH) {
            this.maxScansPerBatch = MAX_SCANS_PER_BATCH;
        }
        if (this.maxApPerScan == UNSPECIFIED) {
            this.maxApPerScan = MAX_AP_PER_SCAN;
        } else if (this.maxApPerScan < MIN_SCANS_PER_BATCH) {
            this.maxApPerScan = MIN_SCANS_PER_BATCH;
        } else if (this.maxApPerScan > MAX_AP_PER_SCAN) {
            this.maxApPerScan = MAX_AP_PER_SCAN;
        }
        if (this.maxApForDistance == UNSPECIFIED) {
            this.maxApForDistance = MIN_AP_FOR_DISTANCE;
        } else if (this.maxApForDistance < 0) {
            this.maxApForDistance = MIN_AP_FOR_DISTANCE;
        } else if (this.maxApForDistance > MAX_AP_PER_SCAN) {
            this.maxApForDistance = MAX_AP_PER_SCAN;
        }
    }

    public boolean equals(Object obj) {
        if (!(obj instanceof BatchedScanSettings)) {
            return false;
        }
        BatchedScanSettings o = (BatchedScanSettings) obj;
        if (this.maxScansPerBatch != o.maxScansPerBatch || this.maxApPerScan != o.maxApPerScan || this.scanIntervalSec != o.scanIntervalSec || this.maxApForDistance != o.maxApForDistance) {
            return false;
        }
        if (this.channelSet != null) {
            return this.channelSet.equals(o.channelSet);
        }
        if (o.channelSet == null) {
            return true;
        }
        return false;
    }

    public int hashCode() {
        return (((this.maxScansPerBatch + (this.maxApPerScan * 3)) + (this.scanIntervalSec * 5)) + (this.maxApForDistance * 7)) + (this.channelSet.hashCode() * 11);
    }

    public String toString() {
        Object obj;
        StringBuffer sb = new StringBuffer();
        String none = "<none>";
        StringBuffer append = sb.append("BatchScanSettings [maxScansPerBatch: ");
        if (this.maxScansPerBatch == UNSPECIFIED) {
            obj = none;
        } else {
            obj = Integer.valueOf(this.maxScansPerBatch);
        }
        append = append.append(obj).append(", maxApPerScan: ");
        if (this.maxApPerScan == UNSPECIFIED) {
            obj = none;
        } else {
            obj = Integer.valueOf(this.maxApPerScan);
        }
        append = append.append(obj).append(", scanIntervalSec: ");
        if (this.scanIntervalSec == UNSPECIFIED) {
            obj = none;
        } else {
            obj = Integer.valueOf(this.scanIntervalSec);
        }
        StringBuffer append2 = append.append(obj).append(", maxApForDistance: ");
        if (this.maxApForDistance != UNSPECIFIED) {
            none = Integer.valueOf(this.maxApForDistance);
        }
        append2.append(none).append(", channelSet: ");
        if (this.channelSet == null) {
            sb.append("ALL");
        } else {
            sb.append("<");
            for (String channel : this.channelSet) {
                sb.append(" " + channel);
            }
            sb.append(">");
        }
        sb.append("]");
        return sb.toString();
    }

    public int describeContents() {
        return MIN_AP_FOR_DISTANCE;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.maxScansPerBatch);
        dest.writeInt(this.maxApPerScan);
        dest.writeInt(this.scanIntervalSec);
        dest.writeInt(this.maxApForDistance);
        dest.writeInt(this.channelSet == null ? MIN_AP_FOR_DISTANCE : this.channelSet.size());
        if (this.channelSet != null) {
            for (String channel : this.channelSet) {
                dest.writeString(channel);
            }
        }
    }

    static {
        CREATOR = new C05211();
    }
}
