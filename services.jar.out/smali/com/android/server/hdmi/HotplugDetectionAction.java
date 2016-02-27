package com.android.server.hdmi;

import android.hardware.hdmi.HdmiDeviceInfo;
import android.util.Slog;
import java.util.BitSet;
import java.util.List;

final class HotplugDetectionAction extends HdmiCecFeatureAction {
    private static final int AVR_COUNT_MAX = 3;
    private static final int NUM_OF_ADDRESS = 15;
    private static final int POLLING_INTERVAL_MS = 5000;
    private static final int STATE_WAIT_FOR_NEXT_POLLING = 1;
    private static final String TAG = "HotPlugDetectionAction";
    private static final int TIMEOUT_COUNT = 3;
    private int mAvrStatusCount;
    private int mTimeoutCount;

    /* renamed from: com.android.server.hdmi.HotplugDetectionAction.1 */
    class C03091 implements DevicePollingCallback {
        C03091() {
        }

        public void onPollingFinished(List<Integer> ackedAddress) {
            HotplugDetectionAction.this.checkHotplug(ackedAddress, false);
        }
    }

    /* renamed from: com.android.server.hdmi.HotplugDetectionAction.2 */
    class C03102 implements DevicePollingCallback {
        C03102() {
        }

        public void onPollingFinished(List<Integer> ackedAddress) {
            HotplugDetectionAction.this.checkHotplug(ackedAddress, true);
        }
    }

    HotplugDetectionAction(HdmiCecLocalDevice source) {
        super(source);
        this.mTimeoutCount = 0;
        this.mAvrStatusCount = 0;
    }

    boolean start() {
        Slog.v(TAG, "Hot-plug dection started.");
        this.mState = STATE_WAIT_FOR_NEXT_POLLING;
        this.mTimeoutCount = 0;
        addTimer(this.mState, POLLING_INTERVAL_MS);
        return true;
    }

    boolean processCommand(HdmiCecMessage cmd) {
        return false;
    }

    void handleTimerEvent(int state) {
        if (this.mState == state && this.mState == STATE_WAIT_FOR_NEXT_POLLING) {
            this.mTimeoutCount = (this.mTimeoutCount + STATE_WAIT_FOR_NEXT_POLLING) % TIMEOUT_COUNT;
            pollDevices();
        }
    }

    void pollAllDevicesNow() {
        this.mActionTimer.clearTimerMessage();
        this.mTimeoutCount = 0;
        this.mState = STATE_WAIT_FOR_NEXT_POLLING;
        pollAllDevices();
        addTimer(this.mState, POLLING_INTERVAL_MS);
    }

    private void pollDevices() {
        if (this.mTimeoutCount == 0) {
            pollAllDevices();
        } else if (tv().isSystemAudioActivated()) {
            pollAudioSystem();
        }
        addTimer(this.mState, POLLING_INTERVAL_MS);
    }

    private void pollAllDevices() {
        Slog.v(TAG, "Poll all devices.");
        pollDevices(new C03091(), 65537, STATE_WAIT_FOR_NEXT_POLLING);
    }

    private void pollAudioSystem() {
        Slog.v(TAG, "Poll audio system.");
        pollDevices(new C03102(), 65538, STATE_WAIT_FOR_NEXT_POLLING);
    }

    private void checkHotplug(List<Integer> ackedAddress, boolean audioOnly) {
        BitSet currentInfos = infoListToBitSet(tv().getDeviceInfoList(false), audioOnly);
        BitSet polledResult = addressListToBitSet(ackedAddress);
        BitSet removed = complement(currentInfos, polledResult);
        int index = -1;
        while (true) {
            index = removed.nextSetBit(index + STATE_WAIT_FOR_NEXT_POLLING);
            if (index == -1) {
                break;
            }
            if (index == 5) {
                this.mAvrStatusCount += STATE_WAIT_FOR_NEXT_POLLING;
                Slog.w(TAG, "Ack not returned from AVR. count: " + this.mAvrStatusCount);
                if (this.mAvrStatusCount < TIMEOUT_COUNT) {
                }
            }
            Slog.v(TAG, "Remove device by hot-plug detection:" + index);
            removeDevice(index);
        }
        if (!removed.get(5)) {
            this.mAvrStatusCount = 0;
        }
        BitSet added = complement(polledResult, currentInfos);
        index = -1;
        while (true) {
            index = added.nextSetBit(index + STATE_WAIT_FOR_NEXT_POLLING);
            if (index != -1) {
                Slog.v(TAG, "Add device by hot-plug detection:" + index);
                addDevice(index);
            } else {
                return;
            }
        }
    }

    private static BitSet infoListToBitSet(List<HdmiDeviceInfo> infoList, boolean audioOnly) {
        BitSet set = new BitSet(NUM_OF_ADDRESS);
        for (HdmiDeviceInfo info : infoList) {
            if (!audioOnly) {
                set.set(info.getLogicalAddress());
            } else if (info.getDeviceType() == 5) {
                set.set(info.getLogicalAddress());
            }
        }
        return set;
    }

    private static BitSet addressListToBitSet(List<Integer> list) {
        BitSet set = new BitSet(NUM_OF_ADDRESS);
        for (Integer value : list) {
            set.set(value.intValue());
        }
        return set;
    }

    private static BitSet complement(BitSet first, BitSet second) {
        BitSet clone = (BitSet) first.clone();
        clone.andNot(second);
        return clone;
    }

    private void addDevice(int addedAddress) {
        sendCommand(HdmiCecMessageBuilder.buildGivePhysicalAddress(getSourceAddress(), addedAddress));
    }

    private void removeDevice(int removedAddress) {
        mayChangeRoutingPath(removedAddress);
        mayCancelDeviceSelect(removedAddress);
        mayCancelOneTouchRecord(removedAddress);
        mayDisableSystemAudioAndARC(removedAddress);
        tv().removeCecDevice(removedAddress);
    }

    private void mayChangeRoutingPath(int address) {
        HdmiDeviceInfo info = tv().getCecDeviceInfo(address);
        if (info != null) {
            tv().handleRemoveActiveRoutingPath(info.getPhysicalAddress());
        }
    }

    private void mayCancelDeviceSelect(int address) {
        List<DeviceSelectAction> actions = getActions(DeviceSelectAction.class);
        if (!actions.isEmpty() && ((DeviceSelectAction) actions.get(0)).getTargetAddress() == address) {
            removeAction(DeviceSelectAction.class);
        }
    }

    private void mayCancelOneTouchRecord(int address) {
        for (OneTouchRecordAction action : getActions(OneTouchRecordAction.class)) {
            if (action.getRecorderAddress() == address) {
                removeAction((HdmiCecFeatureAction) action);
            }
        }
    }

    private void mayDisableSystemAudioAndARC(int address) {
        if (HdmiUtils.getTypeFromAddress(address) == 5) {
            tv().setSystemAudioMode(false, true);
            if (tv().isArcEstabilished()) {
                addAndStartAction(new RequestArcTerminationAction(localDevice(), address));
            }
        }
    }
}
