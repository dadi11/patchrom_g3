package android.bluetooth;

import android.net.ProxyInfo;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class BluetoothHeadsetClientCall implements Parcelable {
    public static final int CALL_STATE_ACTIVE = 0;
    public static final int CALL_STATE_ALERTING = 3;
    public static final int CALL_STATE_DIALING = 2;
    public static final int CALL_STATE_HELD = 1;
    public static final int CALL_STATE_HELD_BY_RESPONSE_AND_HOLD = 6;
    public static final int CALL_STATE_INCOMING = 4;
    public static final int CALL_STATE_TERMINATED = 7;
    public static final int CALL_STATE_WAITING = 5;
    public static final Creator<BluetoothHeadsetClientCall> CREATOR;
    private final int mId;
    private boolean mMultiParty;
    private String mNumber;
    private final boolean mOutgoing;
    private int mState;

    /* renamed from: android.bluetooth.BluetoothHeadsetClientCall.1 */
    static class C00531 implements Creator<BluetoothHeadsetClientCall> {
        C00531() {
        }

        public BluetoothHeadsetClientCall createFromParcel(Parcel in) {
            boolean z = true;
            int readInt = in.readInt();
            int readInt2 = in.readInt();
            String readString = in.readString();
            boolean z2 = in.readInt() == BluetoothHeadsetClientCall.CALL_STATE_HELD;
            if (in.readInt() != BluetoothHeadsetClientCall.CALL_STATE_HELD) {
                z = false;
            }
            return new BluetoothHeadsetClientCall(readInt, readInt2, readString, z2, z);
        }

        public BluetoothHeadsetClientCall[] newArray(int size) {
            return new BluetoothHeadsetClientCall[size];
        }
    }

    public BluetoothHeadsetClientCall(int id, int state, String number, boolean multiParty, boolean outgoing) {
        this.mId = id;
        this.mState = state;
        if (number == null) {
            number = ProxyInfo.LOCAL_EXCL_LIST;
        }
        this.mNumber = number;
        this.mMultiParty = multiParty;
        this.mOutgoing = outgoing;
    }

    public void setState(int state) {
        this.mState = state;
    }

    public void setNumber(String number) {
        this.mNumber = number;
    }

    public void setMultiParty(boolean multiParty) {
        this.mMultiParty = multiParty;
    }

    public int getId() {
        return this.mId;
    }

    public int getState() {
        return this.mState;
    }

    public String getNumber() {
        return this.mNumber;
    }

    public boolean isMultiParty() {
        return this.mMultiParty;
    }

    public boolean isOutgoing() {
        return this.mOutgoing;
    }

    public String toString() {
        StringBuilder builder = new StringBuilder("BluetoothHeadsetClientCall{mId: ");
        builder.append(this.mId);
        builder.append(", mState: ");
        switch (this.mState) {
            case CALL_STATE_ACTIVE /*0*/:
                builder.append("ACTIVE");
                break;
            case CALL_STATE_HELD /*1*/:
                builder.append("HELD");
                break;
            case CALL_STATE_DIALING /*2*/:
                builder.append("DIALING");
                break;
            case CALL_STATE_ALERTING /*3*/:
                builder.append("ALERTING");
                break;
            case CALL_STATE_INCOMING /*4*/:
                builder.append("INCOMING");
                break;
            case CALL_STATE_WAITING /*5*/:
                builder.append("WAITING");
                break;
            case CALL_STATE_HELD_BY_RESPONSE_AND_HOLD /*6*/:
                builder.append("HELD_BY_RESPONSE_AND_HOLD");
                break;
            case CALL_STATE_TERMINATED /*7*/:
                builder.append("TERMINATED");
                break;
            default:
                builder.append(this.mState);
                break;
        }
        builder.append(", mNumber: ");
        builder.append(this.mNumber);
        builder.append(", mMultiParty: ");
        builder.append(this.mMultiParty);
        builder.append(", mOutgoing: ");
        builder.append(this.mOutgoing);
        builder.append("}");
        return builder.toString();
    }

    static {
        CREATOR = new C00531();
    }

    public void writeToParcel(Parcel out, int flags) {
        int i;
        int i2 = CALL_STATE_HELD;
        out.writeInt(this.mId);
        out.writeInt(this.mState);
        out.writeString(this.mNumber);
        if (this.mMultiParty) {
            i = CALL_STATE_HELD;
        } else {
            i = CALL_STATE_ACTIVE;
        }
        out.writeInt(i);
        if (!this.mOutgoing) {
            i2 = CALL_STATE_ACTIVE;
        }
        out.writeInt(i2);
    }

    public int describeContents() {
        return CALL_STATE_ACTIVE;
    }
}
