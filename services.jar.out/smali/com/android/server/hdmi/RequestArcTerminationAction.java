package com.android.server.hdmi;

final class RequestArcTerminationAction extends RequestArcAction {
    private static final String TAG = "RequestArcTerminationAction";

    /* renamed from: com.android.server.hdmi.RequestArcTerminationAction.1 */
    class C03141 implements SendMessageCallback {
        C03141() {
        }

        public void onSendCompleted(int error) {
            if (error != 0) {
                RequestArcTerminationAction.this.disableArcTransmission();
                RequestArcTerminationAction.this.finish();
            }
        }
    }

    RequestArcTerminationAction(HdmiCecLocalDevice source, int avrAddress) {
        super(source, avrAddress);
    }

    boolean start() {
        this.mState = 1;
        addTimer(this.mState, 2000);
        sendCommand(HdmiCecMessageBuilder.buildRequestArcTermination(getSourceAddress(), this.mAvrAddress), new C03141());
        return true;
    }
}
