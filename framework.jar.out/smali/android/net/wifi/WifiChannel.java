package android.net.wifi;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class WifiChannel implements Parcelable {
    public static final Creator<WifiChannel> CREATOR;
    private static final int MAX_CHANNEL_NUM = 196;
    private static final int MAX_FREQ_MHZ = 5825;
    private static final int MIN_CHANNEL_NUM = 1;
    private static final int MIN_FREQ_MHZ = 2412;
    public int channelNum;
    public int freqMHz;
    public boolean ibssAllowed;
    public boolean isDFS;

    /* renamed from: android.net.wifi.WifiChannel.1 */
    static class C05301 implements Creator<WifiChannel> {
        C05301() {
        }

        public WifiChannel createFromParcel(Parcel in) {
            boolean z;
            boolean z2 = true;
            WifiChannel channel = new WifiChannel();
            channel.freqMHz = in.readInt();
            channel.channelNum = in.readInt();
            if (in.readInt() != 0) {
                z = true;
            } else {
                z = false;
            }
            channel.isDFS = z;
            if (in.readInt() == 0) {
                z2 = false;
            }
            channel.ibssAllowed = z2;
            return channel;
        }

        public WifiChannel[] newArray(int size) {
            return new WifiChannel[size];
        }
    }

    public boolean isValid() {
        if (this.freqMHz < MIN_FREQ_MHZ || this.freqMHz > MAX_FREQ_MHZ) {
            return false;
        }
        if (this.channelNum < MIN_CHANNEL_NUM || this.channelNum > MAX_CHANNEL_NUM) {
            return false;
        }
        return true;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        int i;
        int i2 = MIN_CHANNEL_NUM;
        out.writeInt(this.freqMHz);
        out.writeInt(this.channelNum);
        if (this.isDFS) {
            i = MIN_CHANNEL_NUM;
        } else {
            i = 0;
        }
        out.writeInt(i);
        if (!this.ibssAllowed) {
            i2 = 0;
        }
        out.writeInt(i2);
    }

    static {
        CREATOR = new C05301();
    }
}
