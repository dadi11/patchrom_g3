package com.android.server.hdmi;

import android.util.Slog;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.util.Arrays;

public class TimerRecordingAction extends HdmiCecFeatureAction {
    private static final int STATE_WAITING_FOR_TIMER_STATUS = 1;
    private static final String TAG = "TimerRecordingAction";
    private static final int TIMER_STATUS_TIMEOUT_MS = 120000;
    private final byte[] mRecordSource;
    private final int mRecorderAddress;
    private final int mSourceType;

    /* renamed from: com.android.server.hdmi.TimerRecordingAction.1 */
    class C03211 implements SendMessageCallback {
        C03211() {
        }

        public void onSendCompleted(int error) {
            if (error != 0) {
                TimerRecordingAction.this.tv().announceTimerRecordingResult(TimerRecordingAction.this.mRecorderAddress, TimerRecordingAction.STATE_WAITING_FOR_TIMER_STATUS);
                TimerRecordingAction.this.finish();
                return;
            }
            TimerRecordingAction.this.mState = TimerRecordingAction.STATE_WAITING_FOR_TIMER_STATUS;
            TimerRecordingAction.this.addTimer(TimerRecordingAction.this.mState, TimerRecordingAction.TIMER_STATUS_TIMEOUT_MS);
        }
    }

    TimerRecordingAction(HdmiCecLocalDevice source, int recorderAddress, int sourceType, byte[] recordSource) {
        super(source);
        this.mRecorderAddress = recorderAddress;
        this.mSourceType = sourceType;
        this.mRecordSource = recordSource;
    }

    boolean start() {
        sendTimerMessage();
        return true;
    }

    private void sendTimerMessage() {
        HdmiCecMessage message;
        switch (this.mSourceType) {
            case STATE_WAITING_FOR_TIMER_STATUS /*1*/:
                message = HdmiCecMessageBuilder.buildSetDigitalTimer(getSourceAddress(), this.mRecorderAddress, this.mRecordSource);
                break;
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                message = HdmiCecMessageBuilder.buildSetAnalogueTimer(getSourceAddress(), this.mRecorderAddress, this.mRecordSource);
                break;
            case C0569H.REPORT_LOSING_FOCUS /*3*/:
                message = HdmiCecMessageBuilder.buildSetExternalTimer(getSourceAddress(), this.mRecorderAddress, this.mRecordSource);
                break;
            default:
                tv().announceTimerRecordingResult(this.mRecorderAddress, 2);
                finish();
                return;
        }
        sendCommand(message, new C03211());
    }

    boolean processCommand(HdmiCecMessage cmd) {
        if (this.mState != STATE_WAITING_FOR_TIMER_STATUS || cmd.getSource() != this.mRecorderAddress) {
            return false;
        }
        switch (cmd.getOpcode()) {
            case AppTransition.TRANSIT_NONE /*0*/:
                return handleFeatureAbort(cmd);
            case HdmiCecKeycode.CEC_KEYCODE_DISPLAY_INFORMATION /*53*/:
                return handleTimerStatus(cmd);
            default:
                return false;
        }
    }

    private boolean handleTimerStatus(HdmiCecMessage cmd) {
        byte[] timerStatusData = cmd.getParams();
        if (timerStatusData.length == STATE_WAITING_FOR_TIMER_STATUS || timerStatusData.length == 3) {
            tv().announceTimerRecordingResult(this.mRecorderAddress, bytesToInt(timerStatusData));
            Slog.i(TAG, "Received [Timer Status Data]:" + Arrays.toString(timerStatusData));
        } else {
            Slog.w(TAG, "Invalid [Timer Status Data]:" + Arrays.toString(timerStatusData));
        }
        finish();
        return true;
    }

    private boolean handleFeatureAbort(HdmiCecMessage cmd) {
        byte[] params = cmd.getParams();
        int messageType = params[0] & 255;
        switch (messageType) {
            case HdmiCecKeycode.CEC_KEYCODE_INPUT_SELECT /*52*/:
            case 151:
            case 162:
                Slog.i(TAG, "[Feature Abort] for " + messageType + " reason:" + (params[STATE_WAITING_FOR_TIMER_STATUS] & 255));
                tv().announceTimerRecordingResult(this.mRecorderAddress, STATE_WAITING_FOR_TIMER_STATUS);
                finish();
                return true;
            default:
                return false;
        }
    }

    private static int bytesToInt(byte[] data) {
        if (data.length > 4) {
            throw new IllegalArgumentException("Invalid data size:" + Arrays.toString(data));
        }
        int result = 0;
        for (int i = 0; i < data.length; i += STATE_WAITING_FOR_TIMER_STATUS) {
            result |= (data[i] & 255) << ((3 - i) * 8);
        }
        return result;
    }

    void handleTimerEvent(int state) {
        if (this.mState != state) {
            Slog.w(TAG, "Timeout in invalid state:[Expected:" + this.mState + ", Actual:" + state + "]");
            return;
        }
        tv().announceTimerRecordingResult(this.mRecorderAddress, STATE_WAITING_FOR_TIMER_STATUS);
        finish();
    }
}
