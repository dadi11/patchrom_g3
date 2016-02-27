package android.net.wifi;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class WifiActivityEnergyInfo implements Parcelable {
    public static final Creator<WifiActivityEnergyInfo> CREATOR;
    public static final int STACK_STATE_INVALID = 0;
    public static final int STACK_STATE_STATE_ACTIVE = 1;
    public static final int STACK_STATE_STATE_IDLE = 3;
    public static final int STACK_STATE_STATE_SCANNING = 2;
    private final int mControllerEnergyUsed;
    private final int mControllerIdleTimeMs;
    private final int mControllerRxTimeMs;
    private final int mControllerTxTimeMs;
    private final int mStackState;
    private final long timestamp;

    /* renamed from: android.net.wifi.WifiActivityEnergyInfo.1 */
    static class C05291 implements Creator<WifiActivityEnergyInfo> {
        C05291() {
        }

        public WifiActivityEnergyInfo createFromParcel(Parcel in) {
            return new WifiActivityEnergyInfo(in.readInt(), in.readInt(), in.readInt(), in.readInt(), in.readInt());
        }

        public WifiActivityEnergyInfo[] newArray(int size) {
            return new WifiActivityEnergyInfo[size];
        }
    }

    public WifiActivityEnergyInfo(int stackState, int txTime, int rxTime, int idleTime, int energyUsed) {
        this.mStackState = stackState;
        this.mControllerTxTimeMs = txTime;
        this.mControllerRxTimeMs = rxTime;
        this.mControllerIdleTimeMs = idleTime;
        this.mControllerEnergyUsed = energyUsed;
        this.timestamp = System.currentTimeMillis();
    }

    public String toString() {
        return "WifiActivityEnergyInfo{ timestamp=" + this.timestamp + " mStackState=" + this.mStackState + " mControllerTxTimeMs=" + this.mControllerTxTimeMs + " mControllerRxTimeMs=" + this.mControllerRxTimeMs + " mControllerIdleTimeMs=" + this.mControllerIdleTimeMs + " mControllerEnergyUsed=" + this.mControllerEnergyUsed + " }";
    }

    static {
        CREATOR = new C05291();
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeInt(this.mStackState);
        out.writeInt(this.mControllerTxTimeMs);
        out.writeInt(this.mControllerRxTimeMs);
        out.writeInt(this.mControllerIdleTimeMs);
        out.writeInt(this.mControllerEnergyUsed);
    }

    public int describeContents() {
        return STACK_STATE_INVALID;
    }

    public int getStackState() {
        return this.mStackState;
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
