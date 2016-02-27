package android.hardware.hdmi;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class HdmiPortInfo implements Parcelable {
    public static final Creator<HdmiPortInfo> CREATOR;
    public static final int PORT_INPUT = 0;
    public static final int PORT_OUTPUT = 1;
    private final int mAddress;
    private final boolean mArcSupported;
    private final boolean mCecSupported;
    private final int mId;
    private final boolean mMhlSupported;
    private final int mType;

    /* renamed from: android.hardware.hdmi.HdmiPortInfo.1 */
    static class C02871 implements Creator<HdmiPortInfo> {
        C02871() {
        }

        public HdmiPortInfo createFromParcel(Parcel source) {
            boolean cec;
            boolean arc;
            boolean mhl;
            int id = source.readInt();
            int type = source.readInt();
            int address = source.readInt();
            if (source.readInt() == HdmiPortInfo.PORT_OUTPUT) {
                cec = true;
            } else {
                cec = false;
            }
            if (source.readInt() == HdmiPortInfo.PORT_OUTPUT) {
                arc = true;
            } else {
                arc = false;
            }
            if (source.readInt() == HdmiPortInfo.PORT_OUTPUT) {
                mhl = true;
            } else {
                mhl = false;
            }
            return new HdmiPortInfo(id, type, address, cec, mhl, arc);
        }

        public HdmiPortInfo[] newArray(int size) {
            return new HdmiPortInfo[size];
        }
    }

    public HdmiPortInfo(int id, int type, int address, boolean cec, boolean mhl, boolean arc) {
        this.mId = id;
        this.mType = type;
        this.mAddress = address;
        this.mCecSupported = cec;
        this.mArcSupported = arc;
        this.mMhlSupported = mhl;
    }

    public int getId() {
        return this.mId;
    }

    public int getType() {
        return this.mType;
    }

    public int getAddress() {
        return this.mAddress;
    }

    public boolean isCecSupported() {
        return this.mCecSupported;
    }

    public boolean isMhlSupported() {
        return this.mMhlSupported;
    }

    public boolean isArcSupported() {
        return this.mArcSupported;
    }

    public int describeContents() {
        return PORT_INPUT;
    }

    static {
        CREATOR = new C02871();
    }

    public void writeToParcel(Parcel dest, int flags) {
        int i;
        int i2 = PORT_OUTPUT;
        dest.writeInt(this.mId);
        dest.writeInt(this.mType);
        dest.writeInt(this.mAddress);
        if (this.mCecSupported) {
            i = PORT_OUTPUT;
        } else {
            i = PORT_INPUT;
        }
        dest.writeInt(i);
        if (this.mArcSupported) {
            i = PORT_OUTPUT;
        } else {
            i = PORT_INPUT;
        }
        dest.writeInt(i);
        if (!this.mMhlSupported) {
            i2 = PORT_INPUT;
        }
        dest.writeInt(i2);
    }

    public String toString() {
        StringBuffer s = new StringBuffer();
        s.append("port_id: ").append(this.mId).append(", ");
        StringBuffer append = s.append("address: ");
        Object[] objArr = new Object[PORT_OUTPUT];
        objArr[PORT_INPUT] = Integer.valueOf(this.mAddress);
        append.append(String.format("0x%04x", objArr)).append(", ");
        s.append("cec: ").append(this.mCecSupported).append(", ");
        s.append("arc: ").append(this.mArcSupported).append(", ");
        s.append("mhl: ").append(this.mMhlSupported);
        return s.toString();
    }

    public boolean equals(Object o) {
        if (!(o instanceof HdmiPortInfo)) {
            return false;
        }
        HdmiPortInfo other = (HdmiPortInfo) o;
        if (this.mId == other.mId && this.mType == other.mType && this.mAddress == other.mAddress && this.mCecSupported == other.mCecSupported && this.mArcSupported == other.mArcSupported && this.mMhlSupported == other.mMhlSupported) {
            return true;
        }
        return false;
    }
}
