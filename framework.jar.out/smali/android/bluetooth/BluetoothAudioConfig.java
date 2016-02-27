package android.bluetooth;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class BluetoothAudioConfig implements Parcelable {
    public static final Creator<BluetoothAudioConfig> CREATOR;
    private final int mAudioFormat;
    private final int mChannelConfig;
    private final int mSampleRate;

    /* renamed from: android.bluetooth.BluetoothAudioConfig.1 */
    static class C00381 implements Creator<BluetoothAudioConfig> {
        C00381() {
        }

        public BluetoothAudioConfig createFromParcel(Parcel in) {
            return new BluetoothAudioConfig(in.readInt(), in.readInt(), in.readInt());
        }

        public BluetoothAudioConfig[] newArray(int size) {
            return new BluetoothAudioConfig[size];
        }
    }

    public BluetoothAudioConfig(int sampleRate, int channelConfig, int audioFormat) {
        this.mSampleRate = sampleRate;
        this.mChannelConfig = channelConfig;
        this.mAudioFormat = audioFormat;
    }

    public boolean equals(Object o) {
        if (!(o instanceof BluetoothAudioConfig)) {
            return false;
        }
        BluetoothAudioConfig bac = (BluetoothAudioConfig) o;
        if (bac.mSampleRate == this.mSampleRate && bac.mChannelConfig == this.mChannelConfig && bac.mAudioFormat == this.mAudioFormat) {
            return true;
        }
        return false;
    }

    public int hashCode() {
        return (this.mSampleRate | (this.mChannelConfig << 24)) | (this.mAudioFormat << 28);
    }

    public String toString() {
        return "{mSampleRate:" + this.mSampleRate + ",mChannelConfig:" + this.mChannelConfig + ",mAudioFormat:" + this.mAudioFormat + "}";
    }

    public int describeContents() {
        return 0;
    }

    static {
        CREATOR = new C00381();
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeInt(this.mSampleRate);
        out.writeInt(this.mChannelConfig);
        out.writeInt(this.mAudioFormat);
    }

    public int getSampleRate() {
        return this.mSampleRate;
    }

    public int getChannelConfig() {
        return this.mChannelConfig;
    }

    public int getAudioFormat() {
        return this.mAudioFormat;
    }
}
