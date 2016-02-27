package android.net;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import com.google.android.collect.Sets;
import java.util.HashSet;
import java.util.Iterator;

public class InterfaceConfiguration implements Parcelable {
    public static final Creator<InterfaceConfiguration> CREATOR;
    private static final String FLAG_DOWN = "down";
    private static final String FLAG_UP = "up";
    private LinkAddress mAddr;
    private HashSet<String> mFlags;
    private String mHwAddr;

    /* renamed from: android.net.InterfaceConfiguration.1 */
    static class C04801 implements Creator<InterfaceConfiguration> {
        C04801() {
        }

        public InterfaceConfiguration createFromParcel(Parcel in) {
            InterfaceConfiguration info = new InterfaceConfiguration();
            info.mHwAddr = in.readString();
            if (in.readByte() == 1) {
                info.mAddr = (LinkAddress) in.readParcelable(null);
            }
            int size = in.readInt();
            for (int i = 0; i < size; i++) {
                info.mFlags.add(in.readString());
            }
            return info;
        }

        public InterfaceConfiguration[] newArray(int size) {
            return new InterfaceConfiguration[size];
        }
    }

    public InterfaceConfiguration() {
        this.mFlags = Sets.newHashSet();
    }

    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("mHwAddr=").append(this.mHwAddr);
        builder.append(" mAddr=").append(String.valueOf(this.mAddr));
        builder.append(" mFlags=").append(getFlags());
        return builder.toString();
    }

    public Iterable<String> getFlags() {
        return this.mFlags;
    }

    public boolean hasFlag(String flag) {
        validateFlag(flag);
        return this.mFlags.contains(flag);
    }

    public void clearFlag(String flag) {
        validateFlag(flag);
        this.mFlags.remove(flag);
    }

    public void setFlag(String flag) {
        validateFlag(flag);
        this.mFlags.add(flag);
    }

    public void setInterfaceUp() {
        this.mFlags.remove(FLAG_DOWN);
        this.mFlags.add(FLAG_UP);
    }

    public void setInterfaceDown() {
        this.mFlags.remove(FLAG_UP);
        this.mFlags.add(FLAG_DOWN);
    }

    public LinkAddress getLinkAddress() {
        return this.mAddr;
    }

    public void setLinkAddress(LinkAddress addr) {
        this.mAddr = addr;
    }

    public String getHardwareAddress() {
        return this.mHwAddr;
    }

    public void setHardwareAddress(String hwAddr) {
        this.mHwAddr = hwAddr;
    }

    public boolean isActive() {
        try {
            if (!hasFlag(FLAG_UP)) {
                return false;
            }
            for (byte b : this.mAddr.getAddress().getAddress()) {
                if (b != null) {
                    return true;
                }
            }
            return false;
        } catch (NullPointerException e) {
            return false;
        }
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(this.mHwAddr);
        if (this.mAddr != null) {
            dest.writeByte((byte) 1);
            dest.writeParcelable(this.mAddr, flags);
        } else {
            dest.writeByte((byte) 0);
        }
        dest.writeInt(this.mFlags.size());
        Iterator i$ = this.mFlags.iterator();
        while (i$.hasNext()) {
            dest.writeString((String) i$.next());
        }
    }

    static {
        CREATOR = new C04801();
    }

    private static void validateFlag(String flag) {
        if (flag.indexOf(32) >= 0) {
            throw new IllegalArgumentException("flag contains space: " + flag);
        }
    }
}
