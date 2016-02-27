package com.android.server.hdmi;

final class SystemAudioAutoInitiationAction extends HdmiCecFeatureAction {
    private static final int STATE_WAITING_FOR_SYSTEM_AUDIO_MODE_STATUS = 1;
    private final int mAvrAddress;

    /* renamed from: com.android.server.hdmi.SystemAudioAutoInitiationAction.1 */
    class C03191 implements SendMessageCallback {
        C03191() {
        }

        public void onSendCompleted(int error) {
            if (error != 0) {
                SystemAudioAutoInitiationAction.this.tv().setSystemAudioMode(false, true);
                SystemAudioAutoInitiationAction.this.finish();
            }
        }
    }

    SystemAudioAutoInitiationAction(HdmiCecLocalDevice source, int avrAddress) {
        super(source);
        this.mAvrAddress = avrAddress;
    }

    boolean start() {
        this.mState = STATE_WAITING_FOR_SYSTEM_AUDIO_MODE_STATUS;
        addTimer(this.mState, 2000);
        sendGiveSystemAudioModeStatus();
        return true;
    }

    private void sendGiveSystemAudioModeStatus() {
        sendCommand(HdmiCecMessageBuilder.buildGiveSystemAudioModeStatus(getSourceAddress(), this.mAvrAddress), new C03191());
    }

    boolean processCommand(HdmiCecMessage cmd) {
        if (this.mState != STATE_WAITING_FOR_SYSTEM_AUDIO_MODE_STATUS || this.mAvrAddress != cmd.getSource()) {
            return false;
        }
        if (cmd.getOpcode() != 126) {
            return false;
        }
        handleSystemAudioModeStatusMessage();
        return true;
    }

    private void handleSystemAudioModeStatusMessage() {
        if (canChangeSystemAudio()) {
            addAndStartAction(new SystemAudioActionFromTv(tv(), this.mAvrAddress, tv().getSystemAudioModeSetting(), null));
            finish();
            return;
        }
        HdmiLogger.debug("Cannot change system audio mode in auto initiation action.", new Object[0]);
        finish();
    }

    void handleTimerEvent(int state) {
        if (this.mState == state) {
            switch (this.mState) {
                case STATE_WAITING_FOR_SYSTEM_AUDIO_MODE_STATUS /*1*/:
                    handleSystemAudioModeStatusTimeout();
                default:
            }
        }
    }

    private void handleSystemAudioModeStatusTimeout() {
        if (!tv().getSystemAudioModeSetting()) {
            tv().setSystemAudioMode(false, true);
        } else if (canChangeSystemAudio()) {
            addAndStartAction(new SystemAudioActionFromTv(tv(), this.mAvrAddress, true, null));
        }
        finish();
    }

    private boolean canChangeSystemAudio() {
        return (tv().hasAction(SystemAudioActionFromTv.class) || tv().hasAction(SystemAudioActionFromAvr.class)) ? false : true;
    }
}
