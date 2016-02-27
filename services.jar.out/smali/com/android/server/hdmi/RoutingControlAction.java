package com.android.server.hdmi;

import android.hardware.hdmi.HdmiDeviceInfo;
import android.hardware.hdmi.IHdmiControlCallback;
import android.os.RemoteException;
import android.util.Slog;

final class RoutingControlAction extends HdmiCecFeatureAction {
    private static final int STATE_WAIT_FOR_REPORT_POWER_STATUS = 2;
    private static final int STATE_WAIT_FOR_ROUTING_INFORMATION = 1;
    private static final String TAG = "RoutingControlAction";
    private static final int TIMEOUT_REPORT_POWER_STATUS_MS = 1000;
    private static final int TIMEOUT_ROUTING_INFORMATION_MS = 1000;
    private final IHdmiControlCallback mCallback;
    private int mCurrentRoutingPath;
    private final boolean mNotifyInputChange;
    private final boolean mQueryDevicePowerStatus;

    /* renamed from: com.android.server.hdmi.RoutingControlAction.1 */
    class C03151 implements SendMessageCallback {
        C03151() {
        }

        public void onSendCompleted(int error) {
            RoutingControlAction.this.handlDevicePowerStatusAckResult(error == 0);
        }
    }

    RoutingControlAction(HdmiCecLocalDevice localDevice, int path, boolean queryDevicePowerStatus, IHdmiControlCallback callback) {
        super(localDevice);
        this.mCallback = callback;
        this.mCurrentRoutingPath = path;
        this.mQueryDevicePowerStatus = queryDevicePowerStatus;
        this.mNotifyInputChange = callback == null;
    }

    public boolean start() {
        this.mState = STATE_WAIT_FOR_ROUTING_INFORMATION;
        addTimer(this.mState, TIMEOUT_ROUTING_INFORMATION_MS);
        return true;
    }

    public boolean processCommand(HdmiCecMessage cmd) {
        int opcode = cmd.getOpcode();
        byte[] params = cmd.getParams();
        if (this.mState == STATE_WAIT_FOR_ROUTING_INFORMATION && opcode == 129) {
            int routingPath = HdmiUtils.twoBytesToInt(params);
            if (!HdmiUtils.isInActiveRoutingPath(this.mCurrentRoutingPath, routingPath)) {
                return true;
            }
            this.mCurrentRoutingPath = routingPath;
            removeActionExcept(RoutingControlAction.class, this);
            addTimer(this.mState, TIMEOUT_ROUTING_INFORMATION_MS);
            return true;
        } else if (this.mState != STATE_WAIT_FOR_REPORT_POWER_STATUS || opcode != HdmiCecKeycode.UI_SOUND_PRESENTATION_SELECT_AUDIO_AUTO_REVERBERATION) {
            return false;
        } else {
            handleReportPowerStatus(cmd.getParams()[0]);
            return true;
        }
    }

    private void handleReportPowerStatus(int devicePowerStatus) {
        if (isPowerOnOrTransient(getTvPowerStatus())) {
            tv().updateActiveInput(this.mCurrentRoutingPath, this.mNotifyInputChange);
            if (isPowerOnOrTransient(devicePowerStatus)) {
                sendSetStreamPath();
            }
        }
        finishWithCallback(0);
    }

    private int getTvPowerStatus() {
        return tv().getPowerStatus();
    }

    private static boolean isPowerOnOrTransient(int status) {
        return status == 0 || status == STATE_WAIT_FOR_REPORT_POWER_STATUS;
    }

    private void sendSetStreamPath() {
        sendCommand(HdmiCecMessageBuilder.buildSetStreamPath(getSourceAddress(), this.mCurrentRoutingPath));
    }

    private void finishWithCallback(int result) {
        invokeCallback(result);
        finish();
    }

    public void handleTimerEvent(int timeoutState) {
        if (this.mState != timeoutState || this.mState == 0) {
            Slog.w("CEC", "Timer in a wrong state. Ignored.");
            return;
        }
        switch (timeoutState) {
            case STATE_WAIT_FOR_ROUTING_INFORMATION /*1*/:
                HdmiDeviceInfo device = tv().getDeviceInfoByPath(this.mCurrentRoutingPath);
                if (device == null || !this.mQueryDevicePowerStatus) {
                    tv().updateActiveInput(this.mCurrentRoutingPath, this.mNotifyInputChange);
                    finishWithCallback(0);
                    return;
                }
                queryDevicePowerStatus(device.getLogicalAddress(), new C03151());
            case STATE_WAIT_FOR_REPORT_POWER_STATUS /*2*/:
                if (isPowerOnOrTransient(getTvPowerStatus())) {
                    tv().updateActiveInput(this.mCurrentRoutingPath, this.mNotifyInputChange);
                    sendSetStreamPath();
                }
                finishWithCallback(0);
            default:
        }
    }

    private void queryDevicePowerStatus(int address, SendMessageCallback callback) {
        sendCommand(HdmiCecMessageBuilder.buildGiveDevicePowerStatus(getSourceAddress(), address), callback);
    }

    private void handlDevicePowerStatusAckResult(boolean acked) {
        if (acked) {
            this.mState = STATE_WAIT_FOR_REPORT_POWER_STATUS;
            addTimer(this.mState, TIMEOUT_ROUTING_INFORMATION_MS);
            return;
        }
        tv().updateActiveInput(this.mCurrentRoutingPath, this.mNotifyInputChange);
        sendSetStreamPath();
        finishWithCallback(0);
    }

    private void invokeCallback(int result) {
        if (this.mCallback != null) {
            try {
                this.mCallback.onComplete(result);
            } catch (RemoteException e) {
            }
        }
    }
}
