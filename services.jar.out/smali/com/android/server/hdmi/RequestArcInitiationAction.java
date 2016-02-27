package com.android.server.hdmi;

final class RequestArcInitiationAction extends RequestArcAction {
    private static final String TAG = "RequestArcInitiationAction";

    /* renamed from: com.android.server.hdmi.RequestArcInitiationAction.1 */
    class C03131 implements SendMessageCallback {
        C03131() {
        }

        public void onSendCompleted(int error) {
            if (error != 0) {
                RequestArcInitiationAction.this.disableArcTransmission();
                RequestArcInitiationAction.this.finish();
            }
        }
    }

    RequestArcInitiationAction(HdmiCecLocalDevice source, int avrAddress) {
        super(source, avrAddress);
    }

    boolean start() {
        this.mState = 1;
        addTimer(this.mState, 2000);
        sendCommand(HdmiCecMessageBuilder.buildRequestArcInitiation(getSourceAddress(), this.mAvrAddress), new C03131());
        return true;
    }
}
