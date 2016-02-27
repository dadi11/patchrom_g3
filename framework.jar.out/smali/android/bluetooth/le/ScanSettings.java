package android.bluetooth.le;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class ScanSettings implements Parcelable {
    public static final int CALLBACK_TYPE_ALL_MATCHES = 1;
    public static final int CALLBACK_TYPE_FIRST_MATCH = 2;
    public static final int CALLBACK_TYPE_MATCH_LOST = 4;
    public static final Creator<ScanSettings> CREATOR;
    public static final int SCAN_MODE_BALANCED = 1;
    public static final int SCAN_MODE_LOW_LATENCY = 2;
    public static final int SCAN_MODE_LOW_POWER = 0;
    public static final int SCAN_RESULT_TYPE_ABBREVIATED = 1;
    public static final int SCAN_RESULT_TYPE_FULL = 0;
    private int mCallbackType;
    private long mReportDelayMillis;
    private int mScanMode;
    private int mScanResultType;

    /* renamed from: android.bluetooth.le.ScanSettings.1 */
    static class C00871 implements Creator<ScanSettings> {
        C00871() {
        }

        public ScanSettings[] newArray(int size) {
            return new ScanSettings[size];
        }

        public ScanSettings createFromParcel(Parcel in) {
            return new ScanSettings(null);
        }
    }

    public static final class Builder {
        private int mCallbackType;
        private long mReportDelayMillis;
        private int mScanMode;
        private int mScanResultType;

        public Builder() {
            this.mScanMode = ScanSettings.SCAN_MODE_LOW_POWER;
            this.mCallbackType = ScanSettings.SCAN_RESULT_TYPE_ABBREVIATED;
            this.mScanResultType = ScanSettings.SCAN_MODE_LOW_POWER;
            this.mReportDelayMillis = 0;
        }

        public Builder setScanMode(int scanMode) {
            if (scanMode < 0 || scanMode > ScanSettings.SCAN_MODE_LOW_LATENCY) {
                throw new IllegalArgumentException("invalid scan mode " + scanMode);
            }
            this.mScanMode = scanMode;
            return this;
        }

        public Builder setCallbackType(int callbackType) {
            if (isValidCallbackType(callbackType)) {
                this.mCallbackType = callbackType;
                return this;
            }
            throw new IllegalArgumentException("invalid callback type - " + callbackType);
        }

        private boolean isValidCallbackType(int callbackType) {
            if (callbackType == ScanSettings.SCAN_RESULT_TYPE_ABBREVIATED || callbackType == ScanSettings.SCAN_MODE_LOW_LATENCY || callbackType == ScanSettings.CALLBACK_TYPE_MATCH_LOST || callbackType == 6) {
                return true;
            }
            return false;
        }

        public Builder setScanResultType(int scanResultType) {
            if (scanResultType < 0 || scanResultType > ScanSettings.SCAN_RESULT_TYPE_ABBREVIATED) {
                throw new IllegalArgumentException("invalid scanResultType - " + scanResultType);
            }
            this.mScanResultType = scanResultType;
            return this;
        }

        public Builder setReportDelay(long reportDelayMillis) {
            if (reportDelayMillis < 0) {
                throw new IllegalArgumentException("reportDelay must be > 0");
            }
            this.mReportDelayMillis = reportDelayMillis;
            return this;
        }

        public ScanSettings build() {
            return new ScanSettings(this.mCallbackType, this.mScanResultType, this.mReportDelayMillis, null);
        }
    }

    public int getScanMode() {
        return this.mScanMode;
    }

    public int getCallbackType() {
        return this.mCallbackType;
    }

    public int getScanResultType() {
        return this.mScanResultType;
    }

    public long getReportDelayMillis() {
        return this.mReportDelayMillis;
    }

    private ScanSettings(int scanMode, int callbackType, int scanResultType, long reportDelayMillis) {
        this.mScanMode = scanMode;
        this.mCallbackType = callbackType;
        this.mScanResultType = scanResultType;
        this.mReportDelayMillis = reportDelayMillis;
    }

    private ScanSettings(Parcel in) {
        this.mScanMode = in.readInt();
        this.mCallbackType = in.readInt();
        this.mScanResultType = in.readInt();
        this.mReportDelayMillis = in.readLong();
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mScanMode);
        dest.writeInt(this.mCallbackType);
        dest.writeInt(this.mScanResultType);
        dest.writeLong(this.mReportDelayMillis);
    }

    public int describeContents() {
        return SCAN_MODE_LOW_POWER;
    }

    static {
        CREATOR = new C00871();
    }
}
