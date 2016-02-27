package com.android.server.hdmi;

import android.hardware.hdmi.IHdmiControlCallback;
import android.os.RemoteException;
import android.util.Slog;
import java.util.List;

abstract class SystemAudioAction extends HdmiCecFeatureAction {
    private static final int MAX_SEND_RETRY_COUNT = 2;
    private static final int OFF_TIMEOUT_MS = 2000;
    private static final int ON_TIMEOUT_MS = 5000;
    private static final int STATE_CHECK_ROUTING_IN_PRGRESS = 1;
    private static final int STATE_WAIT_FOR_SET_SYSTEM_AUDIO_MODE = 2;
    private static final String TAG = "SystemAudioAction";
    protected final int mAvrLogicalAddress;
    private final IHdmiControlCallback mCallback;
    private int mSendRetryCount;
    protected boolean mTargetAudioStatus;

    /* renamed from: com.android.server.hdmi.SystemAudioAction.1 */
    class C03171 implements Runnable {
        C03171() {
        }

        public void run() {
            SystemAudioAction.this.sendSystemAudioModeRequestInternal();
        }
    }

    /* renamed from: com.android.server.hdmi.SystemAudioAction.2 */
    class C03182 implements SendMessageCallback {
        C03182() {
        }

        public void onSendCompleted(int error) {
            if (error != 0) {
                HdmiLogger.debug("Failed to send <System Audio Mode Request>:" + error, new Object[0]);
                SystemAudioAction.this.setSystemAudioMode(false);
                SystemAudioAction.this.finishWithCallback(7);
            }
        }
    }

    SystemAudioAction(HdmiCecLocalDevice source, int avrAddress, boolean targetStatus, IHdmiControlCallback callback) {
        super(source);
        this.mSendRetryCount = 0;
        HdmiUtils.verifyAddressType(avrAddress, 5);
        this.mAvrLogicalAddress = avrAddress;
        this.mTargetAudioStatus = targetStatus;
        this.mCallback = callback;
    }

    protected void sendSystemAudioModeRequest() {
        List<RoutingControlAction> routingActions = getActions(RoutingControlAction.class);
        if (routingActions.isEmpty()) {
            sendSystemAudioModeRequestInternal();
            return;
        }
        this.mState = STATE_CHECK_ROUTING_IN_PRGRESS;
        ((RoutingControlAction) routingActions.get(0)).addOnFinishedCallback(this, new C03171());
    }

    private void sendSystemAudioModeRequestInternal() {
        sendCommand(HdmiCecMessageBuilder.buildSystemAudioModeRequest(getSourceAddress(), this.mAvrLogicalAddress, getSystemAudioModeRequestParam(), this.mTargetAudioStatus), new C03182());
        this.mState = STATE_WAIT_FOR_SET_SYSTEM_AUDIO_MODE;
        addTimer(this.mState, this.mTargetAudioStatus ? ON_TIMEOUT_MS : OFF_TIMEOUT_MS);
    }

    private int getSystemAudioModeRequestParam() {
        if (tv().getActiveSource().isValid()) {
            return tv().getActiveSource().physicalAddress;
        }
        int param = tv().getActivePath();
        return param == 65535 ? 0 : param;
    }

    private void handleSendSystemAudioModeRequestTimeout() {
        if (this.mTargetAudioStatus) {
            int i = this.mSendRetryCount;
            this.mSendRetryCount = i + STATE_CHECK_ROUTING_IN_PRGRESS;
            if (i < STATE_WAIT_FOR_SET_SYSTEM_AUDIO_MODE) {
                sendSystemAudioModeRequest();
                return;
            }
        }
        HdmiLogger.debug("[T]:wait for <Set System Audio Mode>.", new Object[0]);
        setSystemAudioMode(false);
        finishWithCallback(STATE_CHECK_ROUTING_IN_PRGRESS);
    }

    protected void setSystemAudioMode(boolean mode) {
        tv().setSystemAudioMode(mode, true);
    }

    final boolean processCommand(HdmiCecMessage cmd) {
        if (cmd.getSource() != this.mAvrLogicalAddress) {
            return false;
        }
        switch (this.mState) {
            case STATE_WAIT_FOR_SET_SYSTEM_AUDIO_MODE /*2*/:
                if (cmd.getOpcode() == 0 && (cmd.getParams()[0] & 255) == HdmiCecKeycode.UI_BROADCAST_DIGITAL_CABLE) {
                    HdmiLogger.debug("Failed to start system audio mode request.", new Object[0]);
                    setSystemAudioMode(false);
                    finishWithCallback(5);
                    return true;
                } else if (cmd.getOpcode() != HdmiCecKeycode.CEC_KEYCODE_F2_RED || !HdmiUtils.checkCommandSource(cmd, this.mAvrLogicalAddress, TAG)) {
                    return false;
                } else {
                    boolean receivedStatus = HdmiUtils.parseCommandParamSystemAudioStatus(cmd);
                    if (receivedStatus == this.mTargetAudioStatus) {
                        setSystemAudioMode(receivedStatus);
                        startAudioStatusAction();
                        return true;
                    }
                    HdmiLogger.debug("Unexpected system audio mode request:" + receivedStatus, new Object[0]);
                    finishWithCallback(5);
                    return false;
                }
            default:
                return false;
        }
    }

    protected void startAudioStatusAction() {
        addAndStartAction(new SystemAudioStatusAction(tv(), this.mAvrLogicalAddress, this.mCallback));
        finish();
    }

    protected void removeSystemAudioActionInProgress() {
        removeActionExcept(SystemAudioActionFromTv.class, this);
        removeActionExcept(SystemAudioActionFromAvr.class, this);
    }

    final void handleTimerEvent(int state) {
        if (this.mState == state) {
            switch (this.mState) {
                case STATE_WAIT_FOR_SET_SYSTEM_AUDIO_MODE /*2*/:
                    handleSendSystemAudioModeRequestTimeout();
                default:
            }
        }
    }

    protected void finishWithCallback(int returnCode) {
        if (this.mCallback != null) {
            try {
                this.mCallback.onComplete(returnCode);
            } catch (RemoteException e) {
                Slog.e(TAG, "Failed to invoke callback.", e);
            }
        }
        finish();
    }
}
