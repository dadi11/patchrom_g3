package com.android.server.hdmi;

import android.hardware.hdmi.IHdmiControlCallback;
import android.os.RemoteException;
import android.util.Slog;

final class SystemAudioStatusAction extends HdmiCecFeatureAction {
    private static final int STATE_WAIT_FOR_REPORT_AUDIO_STATUS = 1;
    private static final String TAG = "SystemAudioStatusAction";
    private final int mAvrAddress;
    private final IHdmiControlCallback mCallback;

    /* renamed from: com.android.server.hdmi.SystemAudioStatusAction.1 */
    class C03201 implements SendMessageCallback {
        C03201() {
        }

        public void onSendCompleted(int error) {
            if (error != 0) {
                SystemAudioStatusAction.this.handleSendGiveAudioStatusFailure();
            }
        }
    }

    SystemAudioStatusAction(HdmiCecLocalDevice source, int avrAddress, IHdmiControlCallback callback) {
        super(source);
        this.mAvrAddress = avrAddress;
        this.mCallback = callback;
    }

    boolean start() {
        this.mState = STATE_WAIT_FOR_REPORT_AUDIO_STATUS;
        addTimer(this.mState, 2000);
        sendGiveAudioStatus();
        return true;
    }

    private void sendGiveAudioStatus() {
        sendCommand(HdmiCecMessageBuilder.buildGiveAudioStatus(getSourceAddress(), this.mAvrAddress), new C03201());
    }

    private void handleSendGiveAudioStatusFailure() {
        tv().setAudioStatus(false, -1);
        sendUserControlPressedAndReleased(this.mAvrAddress, tv().isSystemAudioActivated() ? HdmiCecKeycode.CEC_KEYCODE_RESTORE_VOLUME_FUNCTION : HdmiCecKeycode.CEC_KEYCODE_MUTE_FUNCTION);
        finishWithCallback(0);
    }

    boolean processCommand(HdmiCecMessage cmd) {
        if (this.mState != STATE_WAIT_FOR_REPORT_AUDIO_STATUS || this.mAvrAddress != cmd.getSource()) {
            return false;
        }
        switch (cmd.getOpcode()) {
            case 122:
                handleReportAudioStatus(cmd);
                return true;
            default:
                return false;
        }
    }

    private void handleReportAudioStatus(HdmiCecMessage cmd) {
        boolean mute;
        byte[] params = cmd.getParams();
        if ((params[0] & DumpState.DUMP_PROVIDERS) == DumpState.DUMP_PROVIDERS) {
            mute = true;
        } else {
            mute = false;
        }
        tv().setAudioStatus(mute, params[0] & 127);
        if ((tv().isSystemAudioActivated() ^ mute) == 0) {
            sendUserControlPressedAndReleased(this.mAvrAddress, 67);
        }
        finishWithCallback(0);
    }

    private void finishWithCallback(int returnCode) {
        if (this.mCallback != null) {
            try {
                this.mCallback.onComplete(returnCode);
            } catch (RemoteException e) {
                Slog.e(TAG, "Failed to invoke callback.", e);
            }
        }
        finish();
    }

    void handleTimerEvent(int state) {
        if (this.mState == state) {
            handleSendGiveAudioStatusFailure();
        }
    }
}
