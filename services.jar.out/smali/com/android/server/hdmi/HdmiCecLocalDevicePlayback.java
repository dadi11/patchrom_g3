package com.android.server.hdmi;

import android.hardware.hdmi.IHdmiControlCallback;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.SystemProperties;
import android.util.Slog;
import com.android.internal.util.IndentingPrintWriter;
import com.android.server.hdmi.HdmiAnnotations.ServiceThreadOnly;

final class HdmiCecLocalDevicePlayback extends HdmiCecLocalDevice {
    private static final String TAG = "HdmiCecLocalDevicePlayback";
    private boolean mIsActiveSource;
    private WakeLock mWakeLock;

    HdmiCecLocalDevicePlayback(HdmiControlService service) {
        super(service, 4);
        this.mIsActiveSource = false;
    }

    @ServiceThreadOnly
    protected void onAddressAllocated(int logicalAddress, int reason) {
        assertRunOnServiceThread();
        this.mService.sendCecCommand(HdmiCecMessageBuilder.buildReportPhysicalAddressCommand(this.mAddress, this.mService.getPhysicalAddress(), this.mDeviceType));
        this.mService.sendCecCommand(HdmiCecMessageBuilder.buildDeviceVendorIdCommand(this.mAddress, this.mService.getVendorId()));
        startQueuedActions();
    }

    @ServiceThreadOnly
    protected int getPreferredAddress() {
        assertRunOnServiceThread();
        return SystemProperties.getInt("persist.sys.hdmi.addr.playback", 15);
    }

    @ServiceThreadOnly
    protected void setPreferredAddress(int addr) {
        assertRunOnServiceThread();
        SystemProperties.set("persist.sys.hdmi.addr.playback", String.valueOf(addr));
    }

    @ServiceThreadOnly
    void oneTouchPlay(IHdmiControlCallback callback) {
        assertRunOnServiceThread();
        if (hasAction(OneTouchPlayAction.class)) {
            Slog.w(TAG, "oneTouchPlay already in progress");
            invokeCallback(callback, 4);
            return;
        }
        OneTouchPlayAction action = OneTouchPlayAction.create(this, 0, callback);
        if (action == null) {
            Slog.w(TAG, "Cannot initiate oneTouchPlay");
            invokeCallback(callback, 5);
            return;
        }
        addAndStartAction(action);
    }

    @ServiceThreadOnly
    void queryDisplayStatus(IHdmiControlCallback callback) {
        assertRunOnServiceThread();
        if (hasAction(DevicePowerStatusAction.class)) {
            Slog.w(TAG, "queryDisplayStatus already in progress");
            invokeCallback(callback, 4);
            return;
        }
        DevicePowerStatusAction action = DevicePowerStatusAction.create(this, 0, callback);
        if (action == null) {
            Slog.w(TAG, "Cannot initiate queryDisplayStatus");
            invokeCallback(callback, 5);
            return;
        }
        addAndStartAction(action);
    }

    @ServiceThreadOnly
    private void invokeCallback(IHdmiControlCallback callback, int result) {
        assertRunOnServiceThread();
        try {
            callback.onComplete(result);
        } catch (RemoteException e) {
            Slog.e(TAG, "Invoking callback failed:" + e);
        }
    }

    @ServiceThreadOnly
    void onHotplug(int portId, boolean connected) {
        assertRunOnServiceThread();
        this.mCecMessageCache.flushAll();
        if (connected && this.mService.isPowerStandbyOrTransient()) {
            this.mService.wakeUp();
        }
        if (!connected) {
            getWakeLock().release();
        }
    }

    @ServiceThreadOnly
    void setActiveSource(boolean on) {
        assertRunOnServiceThread();
        this.mIsActiveSource = on;
        if (on) {
            getWakeLock().acquire();
            HdmiLogger.debug("active source: %b. Wake lock acquired", Boolean.valueOf(this.mIsActiveSource));
            return;
        }
        getWakeLock().release();
        HdmiLogger.debug("Wake lock released", new Object[0]);
    }

    @ServiceThreadOnly
    private WakeLock getWakeLock() {
        assertRunOnServiceThread();
        if (this.mWakeLock == null) {
            this.mWakeLock = this.mService.getPowerManager().newWakeLock(1, TAG);
            this.mWakeLock.setReferenceCounted(false);
        }
        return this.mWakeLock;
    }

    protected boolean canGoToStandby() {
        return !getWakeLock().isHeld();
    }

    @ServiceThreadOnly
    protected boolean handleActiveSource(HdmiCecMessage message) {
        assertRunOnServiceThread();
        mayResetActiveSource(HdmiUtils.twoBytesToInt(message.getParams()));
        return true;
    }

    private void mayResetActiveSource(int physicalAddress) {
        if (physicalAddress != this.mService.getPhysicalAddress()) {
            setActiveSource(false);
        }
    }

    @ServiceThreadOnly
    protected boolean handleUserControlPressed(HdmiCecMessage message) {
        assertRunOnServiceThread();
        wakeUpIfActiveSource();
        return super.handleUserControlPressed(message);
    }

    @ServiceThreadOnly
    protected boolean handleSetStreamPath(HdmiCecMessage message) {
        assertRunOnServiceThread();
        maySetActiveSource(HdmiUtils.twoBytesToInt(message.getParams()));
        maySendActiveSource(message.getSource());
        wakeUpIfActiveSource();
        return true;
    }

    @ServiceThreadOnly
    protected boolean handleRoutingChange(HdmiCecMessage message) {
        assertRunOnServiceThread();
        maySetActiveSource(HdmiUtils.twoBytesToInt(message.getParams(), 2));
        return true;
    }

    @ServiceThreadOnly
    protected boolean handleRoutingInformation(HdmiCecMessage message) {
        assertRunOnServiceThread();
        maySetActiveSource(HdmiUtils.twoBytesToInt(message.getParams()));
        return true;
    }

    private void maySetActiveSource(int physicalAddress) {
        setActiveSource(physicalAddress == this.mService.getPhysicalAddress());
    }

    private void wakeUpIfActiveSource() {
        if (!this.mIsActiveSource) {
            return;
        }
        if (this.mService.isPowerStandbyOrTransient() || !this.mService.getPowerManager().isScreenOn()) {
            this.mService.wakeUp();
        }
    }

    private void maySendActiveSource(int dest) {
        if (this.mIsActiveSource) {
            this.mService.sendCecCommand(HdmiCecMessageBuilder.buildActiveSource(this.mAddress, this.mService.getPhysicalAddress()));
            this.mService.sendCecCommand(HdmiCecMessageBuilder.buildReportMenuStatus(this.mAddress, dest, 0));
        }
    }

    @ServiceThreadOnly
    protected boolean handleRequestActiveSource(HdmiCecMessage message) {
        assertRunOnServiceThread();
        maySendActiveSource(message.getSource());
        return true;
    }

    @ServiceThreadOnly
    protected void disableDevice(boolean initiatedByCec, PendingActionClearedCallback callback) {
        super.disableDevice(initiatedByCec, callback);
        assertRunOnServiceThread();
        if (!initiatedByCec && this.mIsActiveSource) {
            this.mService.sendCecCommand(HdmiCecMessageBuilder.buildInactiveSource(this.mAddress, this.mService.getPhysicalAddress()));
        }
        setActiveSource(false);
        checkIfPendingActionsCleared();
    }

    protected void dump(IndentingPrintWriter pw) {
        super.dump(pw);
        pw.println("mIsActiveSource: " + this.mIsActiveSource);
    }
}
