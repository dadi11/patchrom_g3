package com.android.internal.telephony;

import java.util.BitSet;

public class HardwareConfig {
    public static final int DEV_HARDWARE_STATE_DISABLED = 2;
    public static final int DEV_HARDWARE_STATE_ENABLED = 0;
    public static final int DEV_HARDWARE_STATE_STANDBY = 1;
    public static final int DEV_HARDWARE_TYPE_MODEM = 0;
    public static final int DEV_HARDWARE_TYPE_SIM = 1;
    public static final int DEV_MODEM_RIL_MODEL_MULTIPLE = 1;
    public static final int DEV_MODEM_RIL_MODEL_SINGLE = 0;
    static final String LOG_TAG = "HardwareConfig";
    public int maxActiveDataCall;
    public int maxActiveVoiceCall;
    public int maxStandby;
    public String modemUuid;
    public BitSet rat;
    public int rilModel;
    public int state;
    public int type;
    public String uuid;

    public HardwareConfig(int type) {
    }

    public HardwareConfig(String res) {
        String[] split = res.split(",");
        this.type = Integer.parseInt(split[DEV_MODEM_RIL_MODEL_SINGLE]);
        switch (this.type) {
            case DEV_MODEM_RIL_MODEL_SINGLE /*0*/:
                assignModem(split[DEV_MODEM_RIL_MODEL_MULTIPLE].trim(), Integer.parseInt(split[DEV_HARDWARE_STATE_DISABLED]), Integer.parseInt(split[3]), Integer.parseInt(split[4]), Integer.parseInt(split[5]), Integer.parseInt(split[6]), Integer.parseInt(split[7]));
            case DEV_MODEM_RIL_MODEL_MULTIPLE /*1*/:
                assignSim(split[DEV_MODEM_RIL_MODEL_MULTIPLE].trim(), Integer.parseInt(split[DEV_HARDWARE_STATE_DISABLED]), split[3].trim());
            default:
        }
    }

    public void assignModem(String id, int state, int model, int ratBits, int maxV, int maxD, int maxS) {
        if (this.type == 0) {
            char[] bits = Integer.toBinaryString(ratBits).toCharArray();
            this.uuid = id;
            this.rilModel = model;
            this.rat = new BitSet(bits.length);
            for (int i = DEV_MODEM_RIL_MODEL_SINGLE; i < bits.length; i += DEV_MODEM_RIL_MODEL_MULTIPLE) {
                this.rat.set(i, bits[i] == '1');
            }
            this.maxActiveVoiceCall = maxV;
            this.maxActiveDataCall = maxD;
            this.maxStandby = maxS;
        }
    }

    public void assignSim(String id, int state, String link) {
        if (this.type == DEV_MODEM_RIL_MODEL_MULTIPLE) {
            this.uuid = id;
            this.modemUuid = link;
        }
    }

    public String toString() {
        StringBuilder builder = new StringBuilder();
        if (this.type == 0) {
            builder.append("Modem ");
            builder.append("{ uuid=" + this.uuid);
            builder.append(", state=" + this.state);
            builder.append(", rilModel=" + this.rilModel);
            builder.append(", rat=" + this.rat.toString());
            builder.append(", maxActiveVoiceCall=" + this.maxActiveVoiceCall);
            builder.append(", maxActiveDataCall=" + this.maxActiveDataCall);
            builder.append(", maxStandby=" + this.maxStandby);
            builder.append(" }");
        } else if (this.type == DEV_MODEM_RIL_MODEL_MULTIPLE) {
            builder.append("Sim ");
            builder.append("{ uuid=" + this.uuid);
            builder.append(", modemUuid=" + this.modemUuid);
            builder.append(", state=" + this.state);
            builder.append(" }");
        } else {
            builder.append("Invalid Configration");
        }
        return builder.toString();
    }

    public int compareTo(HardwareConfig hw) {
        return toString().compareTo(hw.toString());
    }
}
