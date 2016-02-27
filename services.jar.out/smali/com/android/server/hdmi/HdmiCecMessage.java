package com.android.server.hdmi;

import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.util.Arrays;
import libcore.util.EmptyArray;

public final class HdmiCecMessage {
    public static final byte[] EMPTY_PARAM;
    private final int mDestination;
    private final int mOpcode;
    private final byte[] mParams;
    private final int mSource;

    static {
        EMPTY_PARAM = EmptyArray.BYTE;
    }

    public HdmiCecMessage(int source, int destination, int opcode, byte[] params) {
        this.mSource = source;
        this.mDestination = destination;
        this.mOpcode = opcode & 255;
        this.mParams = Arrays.copyOf(params, params.length);
    }

    public int getSource() {
        return this.mSource;
    }

    public int getDestination() {
        return this.mDestination;
    }

    public int getOpcode() {
        return this.mOpcode;
    }

    public byte[] getParams() {
        return this.mParams;
    }

    public String toString() {
        StringBuffer s = new StringBuffer();
        s.append(String.format("<%s> src: %d, dst: %d", new Object[]{opcodeToString(this.mOpcode), Integer.valueOf(this.mSource), Integer.valueOf(this.mDestination)}));
        if (this.mParams.length > 0) {
            s.append(", params:");
            int len$ = this.mParams.length;
            for (int i$ = 0; i$ < len$; i$++) {
                s.append(String.format(" %02X", new Object[]{Byte.valueOf(arr$[i$])}));
            }
        }
        return s.toString();
    }

    private static String opcodeToString(int opcode) {
        switch (opcode) {
            case AppTransition.TRANSIT_NONE /*0*/:
                return "Feature Abort";
            case C0569H.DO_TRAVERSAL /*4*/:
                return "Image View On";
            case C0569H.ADD_STARTING /*5*/:
                return "Tuner Step Increment";
            case C0569H.REMOVE_STARTING /*6*/:
                return "Tuner Step Decrement";
            case C0569H.FINISHED_STARTING /*7*/:
                return "Tuner Device Staus";
            case C0569H.REPORT_APPLICATION_TOKEN_WINDOWS /*8*/:
                return "Give Tuner Device Status";
            case C0569H.REPORT_APPLICATION_TOKEN_DRAWN /*9*/:
                return "Record On";
            case AppTransition.TRANSIT_TASK_TO_FRONT /*10*/:
                return "Record Status";
            case C0569H.WINDOW_FREEZE_TIMEOUT /*11*/:
                return "Record Off";
            case C0569H.APP_TRANSITION_TIMEOUT /*13*/:
                return "Text View On";
            case C0569H.FORCE_GC /*15*/:
                return "Record Tv Screen";
            case C0569H.DO_ANIMATION_CALLBACK /*26*/:
                return "Give Deck Status";
            case C0569H.DO_DISPLAY_ADDED /*27*/:
                return "Deck Status";
            case HdmiCecKeycode.CEC_KEYCODE_PREVIOUS_CHANNEL /*50*/:
                return "Set Menu Language";
            case HdmiCecKeycode.CEC_KEYCODE_SOUND_SELECT /*51*/:
                return "Clear Analog Timer";
            case HdmiCecKeycode.CEC_KEYCODE_INPUT_SELECT /*52*/:
                return "Set Analog Timer";
            case HdmiCecKeycode.CEC_KEYCODE_DISPLAY_INFORMATION /*53*/:
                return "Timer Status";
            case HdmiCecKeycode.CEC_KEYCODE_HELP /*54*/:
                return "Standby";
            case HdmiCecKeycode.CEC_KEYCODE_VOLUME_UP /*65*/:
                return "Play";
            case HdmiCecKeycode.CEC_KEYCODE_VOLUME_DOWN /*66*/:
                return "Deck Control";
            case HdmiCecKeycode.CEC_KEYCODE_MUTE /*67*/:
                return "Timer Cleared Status";
            case HdmiCecKeycode.CEC_KEYCODE_PLAY /*68*/:
                return "User Control Pressed";
            case HdmiCecKeycode.CEC_KEYCODE_STOP /*69*/:
                return "User Control Release";
            case HdmiCecKeycode.CEC_KEYCODE_PAUSE /*70*/:
                return "Give Osd Name";
            case HdmiCecKeycode.CEC_KEYCODE_RECORD /*71*/:
                return "Set Osd Name";
            case HdmiCecKeycode.CEC_KEYCODE_STOP_FUNCTION /*100*/:
                return "Set Osd String";
            case HdmiCecKeycode.CEC_KEYCODE_TUNE_FUNCTION /*103*/:
                return "Set Timer Program Title";
            case HdmiCecKeycode.UI_BROADCAST_DIGITAL_CABLE /*112*/:
                return "System Audio Mode Request";
            case HdmiCecKeycode.CEC_KEYCODE_F1_BLUE /*113*/:
                return "Give Audio Status";
            case HdmiCecKeycode.CEC_KEYCODE_F2_RED /*114*/:
                return "Set System Audio Mode";
            case 122:
                return "Report Audio Status";
            case 125:
                return "Give System Audio Mode Status";
            case 126:
                return "System Audio Mode Status";
            case DumpState.DUMP_PROVIDERS /*128*/:
                return "Routing Change";
            case 129:
                return "Routing Information";
            case 130:
                return "Active Source";
            case 131:
                return "Give Physical Address";
            case 132:
                return "Report Physical Address";
            case 133:
                return "Request Active Source";
            case 134:
                return "Set Stream Path";
            case 135:
                return "Device Vendor Id";
            case 137:
                return "Vendor Commandn";
            case 138:
                return "Vendor Remote Button Down";
            case 139:
                return "Vendor Remote Button Up";
            case 140:
                return "Give Device Vendor Id";
            case 141:
                return "Menu REquest";
            case 142:
                return "Menu Status";
            case 143:
                return "Give Device Power Status";
            case HdmiCecKeycode.UI_SOUND_PRESENTATION_SELECT_AUDIO_AUTO_REVERBERATION /*144*/:
                return "Report Power Status";
            case HdmiCecKeycode.UI_BROADCAST_DIGITAL_COMMNICATIONS_SATELLITE_2 /*145*/:
                return "Get Menu Language";
            case 146:
                return "Select Analog Service";
            case 147:
                return "Select Digital Service";
            case 151:
                return "Set Digital Timer";
            case 153:
                return "Clear Digital Timer";
            case 154:
                return "Set Audio Rate";
            case 157:
                return "InActive Source";
            case 158:
                return "Cec Version";
            case 159:
                return "Get Cec Version";
            case HdmiCecKeycode.UI_SOUND_PRESENTATION_SELECT_AUDIO_AUTO_EQUALIZER /*160*/:
                return "Vendor Command With Id";
            case 161:
                return "Clear External Timer";
            case 162:
                return "Set External Timer";
            case 163:
                return "Repot Short Audio Descriptor";
            case 164:
                return "Request Short Audio Descriptor";
            case 192:
                return "Initiate ARC";
            case HdmiCecKeycode.UI_SOUND_PRESENTATION_TREBLE_STEP_PLUS /*193*/:
                return "Report ARC Initiated";
            case HdmiCecKeycode.UI_SOUND_PRESENTATION_TREBLE_NEUTRAL /*194*/:
                return "Report ARC Terminated";
            case HdmiCecKeycode.UI_SOUND_PRESENTATION_TREBLE_STEP_MINUS /*195*/:
                return "Request ARC Initiation";
            case 196:
                return "Request ARC Termination";
            case 197:
                return "Terminate ARC";
            case 248:
                return "Cdc Message";
            case 255:
                return "Abort";
            default:
                return String.format("Opcode: %02X", new Object[]{Integer.valueOf(opcode)});
        }
    }
}
