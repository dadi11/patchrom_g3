package android.net.wifi;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.ArrayList;
import java.util.Collection;

public class ScanSettings implements Parcelable {
    public static final Creator<ScanSettings> CREATOR;
    public Collection<WifiChannel> channelSet;

    /* renamed from: android.net.wifi.ScanSettings.1 */
    static class C05261 implements Creator<ScanSettings> {
        C05261() {
        }

        public ScanSettings createFromParcel(Parcel in) {
            ScanSettings settings = new ScanSettings();
            int size = in.readInt();
            if (size > 0) {
                settings.channelSet = new ArrayList(size);
                int size2 = size;
                while (true) {
                    size = size2 - 1;
                    if (size2 <= 0) {
                        break;
                    }
                    settings.channelSet.add(WifiChannel.CREATOR.createFromParcel(in));
                    size2 = size;
                }
            }
            return settings;
        }

        public ScanSettings[] newArray(int size) {
            return new ScanSettings[size];
        }
    }

    public ScanSettings(ScanSettings source) {
        if (source.channelSet != null) {
            this.channelSet = new ArrayList(source.channelSet);
        }
    }

    public boolean isValid() {
        for (WifiChannel channel : this.channelSet) {
            if (!channel.isValid()) {
                return false;
            }
        }
        return true;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeInt(this.channelSet == null ? 0 : this.channelSet.size());
        if (this.channelSet != null) {
            for (WifiChannel channel : this.channelSet) {
                channel.writeToParcel(out, flags);
            }
        }
    }

    static {
        CREATOR = new C05261();
    }
}
