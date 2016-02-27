package android.media.tv;

import android.net.ProxyInfo;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;
import android.view.accessibility.AccessibilityNodeInfo;

public final class TvInputHardwareInfo implements Parcelable {
    public static final Creator<TvInputHardwareInfo> CREATOR;
    static final String TAG = "TvInputHardwareInfo";
    public static final int TV_INPUT_TYPE_COMPONENT = 6;
    public static final int TV_INPUT_TYPE_COMPOSITE = 3;
    public static final int TV_INPUT_TYPE_DISPLAY_PORT = 10;
    public static final int TV_INPUT_TYPE_DVI = 8;
    public static final int TV_INPUT_TYPE_HDMI = 9;
    public static final int TV_INPUT_TYPE_OTHER_HARDWARE = 1;
    public static final int TV_INPUT_TYPE_SCART = 5;
    public static final int TV_INPUT_TYPE_SVIDEO = 4;
    public static final int TV_INPUT_TYPE_TUNER = 2;
    public static final int TV_INPUT_TYPE_VGA = 7;
    private String mAudioAddress;
    private int mAudioType;
    private int mDeviceId;
    private int mHdmiPortId;
    private int mType;

    /* renamed from: android.media.tv.TvInputHardwareInfo.1 */
    static class C04371 implements Creator<TvInputHardwareInfo> {
        C04371() {
        }

        public TvInputHardwareInfo createFromParcel(Parcel source) {
            try {
                TvInputHardwareInfo info = new TvInputHardwareInfo();
                info.readFromParcel(source);
                return info;
            } catch (Exception e) {
                Log.e(TvInputHardwareInfo.TAG, "Exception creating TvInputHardwareInfo from parcel", e);
                return null;
            }
        }

        public TvInputHardwareInfo[] newArray(int size) {
            return new TvInputHardwareInfo[size];
        }
    }

    public static final class Builder {
        private String mAudioAddress;
        private int mAudioType;
        private Integer mDeviceId;
        private Integer mHdmiPortId;
        private Integer mType;

        public Builder() {
            this.mDeviceId = null;
            this.mType = null;
            this.mAudioType = 0;
            this.mAudioAddress = ProxyInfo.LOCAL_EXCL_LIST;
            this.mHdmiPortId = null;
        }

        public Builder deviceId(int deviceId) {
            this.mDeviceId = Integer.valueOf(deviceId);
            return this;
        }

        public Builder type(int type) {
            this.mType = Integer.valueOf(type);
            return this;
        }

        public Builder audioType(int audioType) {
            this.mAudioType = audioType;
            return this;
        }

        public Builder audioAddress(String audioAddress) {
            this.mAudioAddress = audioAddress;
            return this;
        }

        public Builder hdmiPortId(int hdmiPortId) {
            this.mHdmiPortId = Integer.valueOf(hdmiPortId);
            return this;
        }

        public TvInputHardwareInfo build() {
            if (this.mDeviceId == null || this.mType == null) {
                throw new UnsupportedOperationException();
            } else if (!(this.mType.intValue() == TvInputHardwareInfo.TV_INPUT_TYPE_HDMI && this.mHdmiPortId == null) && (this.mType.intValue() == TvInputHardwareInfo.TV_INPUT_TYPE_HDMI || this.mHdmiPortId == null)) {
                TvInputHardwareInfo info = new TvInputHardwareInfo();
                info.mDeviceId = this.mDeviceId.intValue();
                info.mType = this.mType.intValue();
                info.mAudioType = this.mAudioType;
                if (info.mAudioType != 0) {
                    info.mAudioAddress = this.mAudioAddress;
                }
                if (this.mHdmiPortId != null) {
                    info.mHdmiPortId = this.mHdmiPortId.intValue();
                }
                return info;
            } else {
                throw new UnsupportedOperationException();
            }
        }
    }

    static {
        CREATOR = new C04371();
    }

    private TvInputHardwareInfo() {
    }

    public int getDeviceId() {
        return this.mDeviceId;
    }

    public int getType() {
        return this.mType;
    }

    public int getAudioType() {
        return this.mAudioType;
    }

    public String getAudioAddress() {
        return this.mAudioAddress;
    }

    public int getHdmiPortId() {
        if (this.mType == TV_INPUT_TYPE_HDMI) {
            return this.mHdmiPortId;
        }
        throw new IllegalStateException();
    }

    public String toString() {
        StringBuilder b = new StringBuilder(AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
        b.append("TvInputHardwareInfo {id=").append(this.mDeviceId);
        b.append(", type=").append(this.mType);
        b.append(", audio_type=").append(this.mAudioType);
        b.append(", audio_addr=").append(this.mAudioAddress);
        if (this.mType == TV_INPUT_TYPE_HDMI) {
            b.append(", hdmi_port=").append(this.mHdmiPortId);
        }
        b.append("}");
        return b.toString();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mDeviceId);
        dest.writeInt(this.mType);
        dest.writeInt(this.mAudioType);
        dest.writeString(this.mAudioAddress);
        if (this.mType == TV_INPUT_TYPE_HDMI) {
            dest.writeInt(this.mHdmiPortId);
        }
    }

    public void readFromParcel(Parcel source) {
        this.mDeviceId = source.readInt();
        this.mType = source.readInt();
        this.mAudioType = source.readInt();
        this.mAudioAddress = source.readString();
        if (this.mType == TV_INPUT_TYPE_HDMI) {
            this.mHdmiPortId = source.readInt();
        }
    }
}
