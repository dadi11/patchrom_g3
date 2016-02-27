package com.android.server.hdmi;

import android.util.Slog;

final class SetArcTransmissionStateAction extends HdmiCecFeatureAction {
    private static final int STATE_WAITING_TIMEOUT = 1;
    private static final String TAG = "SetArcTransmissionStateAction";
    private final int mAvrAddress;
    private final boolean mEnabled;

    /* renamed from: com.android.server.hdmi.SetArcTransmissionStateAction.1 */
    class C03161 implements SendMessageCallback {
        C03161() {
        }

        public void onSendCompleted(int error) {
            if (error != 0) {
                SetArcTransmissionStateAction.this.setArcStatus(false);
                HdmiLogger.debug("Failed to send <Report Arc Initiated>.", new Object[0]);
                SetArcTransmissionStateAction.this.finish();
            }
        }
    }

    SetArcTransmissionStateAction(HdmiCecLocalDevice source, int avrAddress, boolean enabled) {
        super(source);
        HdmiUtils.verifyAddressType(getSourceAddress(), 0);
        HdmiUtils.verifyAddressType(avrAddress, 5);
        this.mAvrAddress = avrAddress;
        this.mEnabled = enabled;
    }

    boolean start() {
        if (this.mEnabled) {
            setArcStatus(true);
            this.mState = STATE_WAITING_TIMEOUT;
            addTimer(this.mState, 2000);
            sendReportArcInitiated();
        } else {
            setArcStatus(false);
            finish();
        }
        return true;
    }

    private void sendReportArcInitiated() {
        sendCommand(HdmiCecMessageBuilder.buildReportArcInitiated(getSourceAddress(), this.mAvrAddress), new C03161());
    }

    private void setArcStatus(boolean enabled) {
        boolean wasEnabled = tv().setArcStatus(enabled);
        Slog.i(TAG, "Change arc status [old:" + wasEnabled + ", new:" + enabled + "]");
        if (!enabled && wasEnabled) {
            sendCommand(HdmiCecMessageBuilder.buildReportArcTerminated(getSourceAddress(), this.mAvrAddress));
        }
    }

    boolean processCommand(HdmiCecMessage cmd) {
        if (this.mState != STATE_WAITING_TIMEOUT || cmd.getOpcode() != 0 || (cmd.getParams()[0] & 255) != HdmiCecKeycode.UI_SOUND_PRESENTATION_TREBLE_STEP_PLUS) {
            return false;
        }
        HdmiLogger.debug("Feature aborted for <Report Arc Initiated>", new Object[0]);
        setArcStatus(false);
        finish();
        return true;
    }

    void handleTimerEvent(int state) {
        if (this.mState == state && this.mState == STATE_WAITING_TIMEOUT) {
            finish();
        }
    }
}
