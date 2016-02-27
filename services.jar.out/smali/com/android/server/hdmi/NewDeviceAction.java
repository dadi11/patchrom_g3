package com.android.server.hdmi;

import android.hardware.hdmi.HdmiDeviceInfo;
import android.util.Slog;
import java.io.UnsupportedEncodingException;

final class NewDeviceAction extends HdmiCecFeatureAction {
    static final int STATE_WAITING_FOR_DEVICE_VENDOR_ID = 2;
    static final int STATE_WAITING_FOR_SET_OSD_NAME = 1;
    private static final String TAG = "NewDeviceAction";
    private final int mDeviceLogicalAddress;
    private final int mDevicePhysicalAddress;
    private final int mDeviceType;
    private String mDisplayName;
    private int mTimeoutRetry;
    private int mVendorId;

    NewDeviceAction(HdmiCecLocalDevice source, int deviceLogicalAddress, int devicePhysicalAddress, int deviceType) {
        super(source);
        this.mDeviceLogicalAddress = deviceLogicalAddress;
        this.mDevicePhysicalAddress = devicePhysicalAddress;
        this.mDeviceType = deviceType;
        this.mVendorId = 16777215;
    }

    public boolean start() {
        requestOsdName(true);
        return true;
    }

    private void requestOsdName(boolean firstTry) {
        if (firstTry) {
            this.mTimeoutRetry = 0;
        }
        this.mState = STATE_WAITING_FOR_SET_OSD_NAME;
        if (!mayProcessCommandIfCached(this.mDeviceLogicalAddress, 71)) {
            sendCommand(HdmiCecMessageBuilder.buildGiveOsdNameCommand(getSourceAddress(), this.mDeviceLogicalAddress));
            addTimer(this.mState, 2000);
        }
    }

    public boolean processCommand(HdmiCecMessage cmd) {
        int opcode = cmd.getOpcode();
        int src = cmd.getSource();
        byte[] params = cmd.getParams();
        if (this.mDeviceLogicalAddress != src) {
            return false;
        }
        if (this.mState == STATE_WAITING_FOR_SET_OSD_NAME) {
            if (opcode == 71) {
                try {
                    this.mDisplayName = new String(params, "US-ASCII");
                } catch (UnsupportedEncodingException e) {
                    Slog.e(TAG, "Failed to get OSD name: " + e.getMessage());
                }
                requestVendorId(true);
                return true;
            } else if (opcode != 0 || (params[0] & 255) != 70) {
                return false;
            } else {
                requestVendorId(true);
                return true;
            }
        } else if (this.mState != STATE_WAITING_FOR_DEVICE_VENDOR_ID) {
            return false;
        } else {
            if (opcode == 135) {
                this.mVendorId = HdmiUtils.threeBytesToInt(params);
                addDeviceInfo();
                finish();
                return true;
            } else if (opcode != 0 || (params[0] & 255) != 140) {
                return false;
            } else {
                addDeviceInfo();
                finish();
                return true;
            }
        }
    }

    private boolean mayProcessCommandIfCached(int destAddress, int opcode) {
        HdmiCecMessage message = getCecMessageCache().getMessage(destAddress, opcode);
        if (message != null) {
            return processCommand(message);
        }
        return false;
    }

    private void requestVendorId(boolean firstTry) {
        if (firstTry) {
            this.mTimeoutRetry = 0;
        }
        this.mState = STATE_WAITING_FOR_DEVICE_VENDOR_ID;
        if (!mayProcessCommandIfCached(this.mDeviceLogicalAddress, 135)) {
            sendCommand(HdmiCecMessageBuilder.buildGiveDeviceVendorIdCommand(getSourceAddress(), this.mDeviceLogicalAddress));
            addTimer(this.mState, 2000);
        }
    }

    private void addDeviceInfo() {
        if (tv().isInDeviceList(this.mDeviceLogicalAddress, this.mDevicePhysicalAddress)) {
            if (this.mDisplayName == null) {
                this.mDisplayName = HdmiUtils.getDefaultDeviceName(this.mDeviceLogicalAddress);
            }
            HdmiDeviceInfo deviceInfo = new HdmiDeviceInfo(this.mDeviceLogicalAddress, this.mDevicePhysicalAddress, tv().getPortId(this.mDevicePhysicalAddress), this.mDeviceType, this.mVendorId, this.mDisplayName);
            tv().addCecDevice(deviceInfo);
            tv().processDelayedMessages(this.mDeviceLogicalAddress);
            if (HdmiUtils.getTypeFromAddress(this.mDeviceLogicalAddress) == 5) {
                tv().onNewAvrAdded(deviceInfo);
                return;
            }
            return;
        }
        String str = TAG;
        Object[] objArr = new Object[STATE_WAITING_FOR_DEVICE_VENDOR_ID];
        objArr[0] = Integer.valueOf(this.mDeviceLogicalAddress);
        objArr[STATE_WAITING_FOR_SET_OSD_NAME] = Integer.valueOf(this.mDevicePhysicalAddress);
        Slog.w(str, String.format("Device not found (%02x, %04x)", objArr));
    }

    public void handleTimerEvent(int state) {
        if (this.mState != 0 && this.mState == state) {
            int i;
            if (state == STATE_WAITING_FOR_SET_OSD_NAME) {
                i = this.mTimeoutRetry + STATE_WAITING_FOR_SET_OSD_NAME;
                this.mTimeoutRetry = i;
                if (i < 5) {
                    requestOsdName(false);
                } else {
                    requestVendorId(true);
                }
            } else if (state == STATE_WAITING_FOR_DEVICE_VENDOR_ID) {
                i = this.mTimeoutRetry + STATE_WAITING_FOR_SET_OSD_NAME;
                this.mTimeoutRetry = i;
                if (i < 5) {
                    requestVendorId(false);
                    return;
                }
                addDeviceInfo();
                finish();
            }
        }
    }

    boolean isActionOf(ActiveSource activeSource) {
        return this.mDeviceLogicalAddress == activeSource.logicalAddress && this.mDevicePhysicalAddress == activeSource.physicalAddress;
    }
}
