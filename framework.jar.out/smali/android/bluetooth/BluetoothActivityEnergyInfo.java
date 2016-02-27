package android.bluetooth;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class BluetoothActivityEnergyInfo implements Parcelable {
    public static final int BT_STACK_STATE_INVALID = 0;
    public static final int BT_STACK_STATE_STATE_ACTIVE = 1;
    public static final int BT_STACK_STATE_STATE_IDLE = 3;
    public static final int BT_STACK_STATE_STATE_SCANNING = 2;
    public static final Creator<BluetoothActivityEnergyInfo> CREATOR;
    private final int mBluetoothStackState;
    private final int mControllerEnergyUsed;
    private final int mControllerIdleTimeMs;
    private final int mControllerRxTimeMs;
    private final int mControllerTxTimeMs;
    private final long timestamp;

    /* renamed from: android.bluetooth.BluetoothActivityEnergyInfo.1 */
    static class C00351 implements Creator<BluetoothActivityEnergyInfo> {
        C00351() {
        }

        public BluetoothActivityEnergyInfo createFromParcel(Parcel in) {
            return new BluetoothActivityEnergyInfo(in.readInt(), in.readInt(), in.readInt(), in.readInt(), in.readInt());
        }

        public BluetoothActivityEnergyInfo[] newArray(int size) {
            return new BluetoothActivityEnergyInfo[size];
        }
    }

    public BluetoothActivityEnergyInfo(int stackState, int txTime, int rxTime, int idleTime, int energyUsed) {
        this.mBluetoothStackState = stackState;
        this.mControllerTxTimeMs = txTime;
        this.mControllerRxTimeMs = rxTime;
        this.mControllerIdleTimeMs = idleTime;
        this.mControllerEnergyUsed = energyUsed;
        this.timestamp = System.currentTimeMillis();
    }

    public String toString() {
        return "BluetoothActivityEnergyInfo{ timestamp=" + this.timestamp + " mBluetoothStackState=" + this.mBluetoothStackState + " mControllerTxTimeMs=" + this.mControllerTxTimeMs + " mControllerRxTimeMs=" + this.mControllerRxTimeMs + " mControllerIdleTimeMs=" + this.mControllerIdleTimeMs + " mControllerEnergyUsed=" + this.mControllerEnergyUsed + " }";
    }

    static {
        CREATOR = new C00351();
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeInt(this.mBluetoothStackState);
        out.writeInt(this.mControllerTxTimeMs);
        out.writeInt(this.mControllerRxTimeMs);
        out.writeInt(this.mControllerIdleTimeMs);
        out.writeInt(this.mControllerEnergyUsed);
    }

    public int describeContents() {
        return BT_STACK_STATE_INVALID;
    }

    public int getBluetoothStackState() {
        return this.mBluetoothStackState;
    }

    public int getControllerTxTimeMillis() {
        return this.mControllerTxTimeMs;
    }

    public int getControllerRxTimeMillis() {
        return this.mControllerRxTimeMs;
    }

    public int getControllerIdleTimeMillis() {
        return this.mControllerIdleTimeMs;
    }

    public int getControllerEnergyUsed() {
        return this.mControllerEnergyUsed;
    }

    public long getTimeStamp() {
        return this.timestamp;
    }

    public boolean isValid() {
        return (getControllerTxTimeMillis() == 0 && getControllerRxTimeMillis() == 0 && getControllerIdleTimeMillis() == 0) ? false : true;
    }
}
