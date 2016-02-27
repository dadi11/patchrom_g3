package com.android.server.hdmi;

import android.util.Slog;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;

public class OneTouchRecordAction extends HdmiCecFeatureAction {
    private static final int RECORD_STATUS_TIMEOUT_MS = 120000;
    private static final int STATE_RECORDING_IN_PROGRESS = 2;
    private static final int STATE_WAITING_FOR_RECORD_STATUS = 1;
    private static final String TAG = "OneTouchRecordAction";
    private final byte[] mRecordSource;
    private final int mRecorderAddress;

    /* renamed from: com.android.server.hdmi.OneTouchRecordAction.1 */
    class C03111 implements SendMessageCallback {
        C03111() {
        }

        public void onSendCompleted(int error) {
            if (error != 0) {
                OneTouchRecordAction.this.tv().announceOneTouchRecordResult(OneTouchRecordAction.this.mRecorderAddress, 49);
                OneTouchRecordAction.this.finish();
            }
        }
    }

    OneTouchRecordAction(HdmiCecLocalDevice source, int recorderAddress, byte[] recordSource) {
        super(source);
        this.mRecorderAddress = recorderAddress;
        this.mRecordSource = recordSource;
    }

    boolean start() {
        sendRecordOn();
        return true;
    }

    private void sendRecordOn() {
        sendCommand(HdmiCecMessageBuilder.buildRecordOn(getSourceAddress(), this.mRecorderAddress, this.mRecordSource), new C03111());
        this.mState = STATE_WAITING_FOR_RECORD_STATUS;
        addTimer(this.mState, RECORD_STATUS_TIMEOUT_MS);
    }

    boolean processCommand(HdmiCecMessage cmd) {
        if (this.mState != STATE_WAITING_FOR_RECORD_STATUS || this.mRecorderAddress != cmd.getSource()) {
            return false;
        }
        switch (cmd.getOpcode()) {
            case AppTransition.TRANSIT_TASK_TO_FRONT /*10*/:
                return handleRecordStatus(cmd);
            default:
                return false;
        }
    }

    private boolean handleRecordStatus(HdmiCecMessage cmd) {
        if (cmd.getSource() != this.mRecorderAddress) {
            return false;
        }
        int recordStatus = cmd.getParams()[0];
        tv().announceOneTouchRecordResult(this.mRecorderAddress, recordStatus);
        Slog.i(TAG, "Got record status:" + recordStatus + " from " + cmd.getSource());
        switch (recordStatus) {
            case STATE_WAITING_FOR_RECORD_STATUS /*1*/:
            case STATE_RECORDING_IN_PROGRESS /*2*/:
            case C0569H.REPORT_LOSING_FOCUS /*3*/:
            case C0569H.DO_TRAVERSAL /*4*/:
                this.mState = STATE_RECORDING_IN_PROGRESS;
                this.mActionTimer.clearTimerMessage();
                break;
            default:
                finish();
                break;
        }
        return true;
    }

    void handleTimerEvent(int state) {
        if (this.mState != state) {
            Slog.w(TAG, "Timeout in invalid state:[Expected:" + this.mState + ", Actual:" + state + "]");
            return;
        }
        tv().announceOneTouchRecordResult(this.mRecorderAddress, 49);
        finish();
    }

    int getRecorderAddress() {
        return this.mRecorderAddress;
    }
}
