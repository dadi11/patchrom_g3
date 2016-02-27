package com.android.server.hdmi;

import android.hardware.hdmi.HdmiDeviceInfo;
import android.hardware.input.InputManager;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.SystemClock;
import android.util.Slog;
import android.view.KeyEvent;
import com.android.internal.annotations.GuardedBy;
import com.android.internal.util.IndentingPrintWriter;
import com.android.server.hdmi.HdmiAnnotations.ServiceThreadOnly;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

abstract class HdmiCecLocalDevice {
    private static final int DEVICE_CLEANUP_TIMEOUT = 5000;
    private static final int FOLLOWER_SAFETY_TIMEOUT = 550;
    private static final int MSG_DISABLE_DEVICE_TIMEOUT = 1;
    private static final int MSG_USER_CONTROL_RELEASE_TIMEOUT = 2;
    private static final String TAG = "HdmiCecLocalDevice";
    private final ArrayList<HdmiCecFeatureAction> mActions;
    @GuardedBy("mLock")
    private int mActiveRoutingPath;
    @GuardedBy("mLock")
    protected final ActiveSource mActiveSource;
    protected int mAddress;
    protected final HdmiCecMessageCache mCecMessageCache;
    protected HdmiDeviceInfo mDeviceInfo;
    protected final int mDeviceType;
    private final Handler mHandler;
    protected int mLastKeyRepeatCount;
    protected int mLastKeycode;
    protected final Object mLock;
    protected PendingActionClearedCallback mPendingActionClearedCallback;
    protected int mPreferredAddress;
    protected final HdmiControlService mService;

    /* renamed from: com.android.server.hdmi.HdmiCecLocalDevice.1 */
    class C02851 extends Handler {
        C02851() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case HdmiCecLocalDevice.MSG_DISABLE_DEVICE_TIMEOUT /*1*/:
                    HdmiCecLocalDevice.this.handleDisableDeviceTimeout();
                case HdmiCecLocalDevice.MSG_USER_CONTROL_RELEASE_TIMEOUT /*2*/:
                    HdmiCecLocalDevice.this.handleUserControlReleased();
                default:
            }
        }
    }

    interface PendingActionClearedCallback {
        void onCleared(HdmiCecLocalDevice hdmiCecLocalDevice);
    }

    /* renamed from: com.android.server.hdmi.HdmiCecLocalDevice.2 */
    class C02862 implements PendingActionClearedCallback {
        final /* synthetic */ PendingActionClearedCallback val$origialCallback;

        C02862(PendingActionClearedCallback pendingActionClearedCallback) {
            this.val$origialCallback = pendingActionClearedCallback;
        }

        public void onCleared(HdmiCecLocalDevice device) {
            HdmiCecLocalDevice.this.mHandler.removeMessages(HdmiCecLocalDevice.MSG_DISABLE_DEVICE_TIMEOUT);
            this.val$origialCallback.onCleared(device);
        }
    }

    static class ActiveSource {
        int logicalAddress;
        int physicalAddress;

        public ActiveSource() {
            invalidate();
        }

        public ActiveSource(int logical, int physical) {
            this.logicalAddress = logical;
            this.physicalAddress = physical;
        }

        public static ActiveSource of(int logical, int physical) {
            return new ActiveSource(logical, physical);
        }

        public boolean isValid() {
            return HdmiUtils.isValidAddress(this.logicalAddress);
        }

        public void invalidate() {
            this.logicalAddress = -1;
            this.physicalAddress = 65535;
        }

        public boolean equals(int logical, int physical) {
            return this.logicalAddress == logical && this.physicalAddress == physical;
        }

        public boolean equals(Object obj) {
            if (!(obj instanceof ActiveSource)) {
                return false;
            }
            ActiveSource that = (ActiveSource) obj;
            if (that.logicalAddress == this.logicalAddress && that.physicalAddress == this.physicalAddress) {
                return true;
            }
            return false;
        }

        public int hashCode() {
            return (this.logicalAddress * 29) + this.physicalAddress;
        }

        public String toString() {
            String logicalAddressString;
            String physicalAddressString;
            StringBuffer s = new StringBuffer();
            if (this.logicalAddress == -1) {
                logicalAddressString = "invalid";
            } else {
                Object[] objArr = new Object[HdmiCecLocalDevice.MSG_DISABLE_DEVICE_TIMEOUT];
                objArr[0] = Integer.valueOf(this.logicalAddress);
                logicalAddressString = String.format("0x%02x", objArr);
            }
            s.append("logical_address: ").append(logicalAddressString);
            if (this.physicalAddress == 65535) {
                physicalAddressString = "invalid";
            } else {
                objArr = new Object[HdmiCecLocalDevice.MSG_DISABLE_DEVICE_TIMEOUT];
                objArr[0] = Integer.valueOf(this.physicalAddress);
                physicalAddressString = String.format("0x%04x", objArr);
            }
            s.append(", physical_address: ").append(physicalAddressString);
            return s.toString();
        }
    }

    protected abstract int getPreferredAddress();

    protected abstract void onAddressAllocated(int i, int i2);

    protected abstract void setPreferredAddress(int i);

    protected HdmiCecLocalDevice(HdmiControlService service, int deviceType) {
        this.mLastKeycode = -1;
        this.mLastKeyRepeatCount = 0;
        this.mActiveSource = new ActiveSource();
        this.mCecMessageCache = new HdmiCecMessageCache();
        this.mActions = new ArrayList();
        this.mHandler = new C02851();
        this.mService = service;
        this.mDeviceType = deviceType;
        this.mAddress = 15;
        this.mLock = service.getServiceLock();
    }

    static HdmiCecLocalDevice create(HdmiControlService service, int deviceType) {
        switch (deviceType) {
            case AppTransition.TRANSIT_NONE /*0*/:
                return new HdmiCecLocalDeviceTv(service);
            case C0569H.DO_TRAVERSAL /*4*/:
                return new HdmiCecLocalDevicePlayback(service);
            default:
                return null;
        }
    }

    @ServiceThreadOnly
    void init() {
        assertRunOnServiceThread();
        this.mPreferredAddress = getPreferredAddress();
    }

    protected boolean isInputReady(int deviceId) {
        return true;
    }

    protected boolean canGoToStandby() {
        return true;
    }

    @ServiceThreadOnly
    boolean dispatchMessage(HdmiCecMessage message) {
        assertRunOnServiceThread();
        int dest = message.getDestination();
        if (dest != this.mAddress && dest != 15) {
            return false;
        }
        this.mCecMessageCache.cacheMessage(message);
        return onMessage(message);
    }

    @ServiceThreadOnly
    protected final boolean onMessage(HdmiCecMessage message) {
        assertRunOnServiceThread();
        if (dispatchMessageToAction(message)) {
            return true;
        }
        switch (message.getOpcode()) {
            case C0569H.DO_TRAVERSAL /*4*/:
                return handleImageViewOn(message);
            case AppTransition.TRANSIT_TASK_TO_FRONT /*10*/:
                return handleRecordStatus(message);
            case C0569H.APP_TRANSITION_TIMEOUT /*13*/:
                return handleTextViewOn(message);
            case C0569H.FORCE_GC /*15*/:
                return handleRecordTvScreen(message);
            case HdmiCecKeycode.CEC_KEYCODE_DISPLAY_INFORMATION /*53*/:
                return handleTimerStatus(message);
            case HdmiCecKeycode.CEC_KEYCODE_HELP /*54*/:
                return handleStandby(message);
            case HdmiCecKeycode.CEC_KEYCODE_MUTE /*67*/:
                return handleTimerClearedStatus(message);
            case HdmiCecKeycode.CEC_KEYCODE_PLAY /*68*/:
                return handleUserControlPressed(message);
            case HdmiCecKeycode.CEC_KEYCODE_STOP /*69*/:
                return handleUserControlReleased();
            case HdmiCecKeycode.CEC_KEYCODE_PAUSE /*70*/:
                return handleGiveOsdName(message);
            case HdmiCecKeycode.CEC_KEYCODE_RECORD /*71*/:
                return handleSetOsdName(message);
            case HdmiCecKeycode.CEC_KEYCODE_F2_RED /*114*/:
                return handleSetSystemAudioMode(message);
            case 122:
                return handleReportAudioStatus(message);
            case 126:
                return handleSystemAudioModeStatus(message);
            case DumpState.DUMP_PROVIDERS /*128*/:
                return handleRoutingChange(message);
            case 129:
                return handleRoutingInformation(message);
            case 130:
                return handleActiveSource(message);
            case 131:
                return handleGivePhysicalAddress();
            case 132:
                return handleReportPhysicalAddress(message);
            case 133:
                return handleRequestActiveSource(message);
            case 134:
                return handleSetStreamPath(message);
            case 137:
                return handleVendorCommand(message);
            case 140:
                return handleGiveDeviceVendorId();
            case 141:
                return handleMenuRequest(message);
            case 142:
                return handleMenuStatus(message);
            case 143:
                return handleGiveDevicePowerStatus(message);
            case HdmiCecKeycode.UI_SOUND_PRESENTATION_SELECT_AUDIO_AUTO_REVERBERATION /*144*/:
                return handleReportPowerStatus(message);
            case HdmiCecKeycode.UI_BROADCAST_DIGITAL_COMMNICATIONS_SATELLITE_2 /*145*/:
                return handleGetMenuLanguage(message);
            case 157:
                return handleInactiveSource(message);
            case 159:
                return handleGetCecVersion(message);
            case HdmiCecKeycode.UI_SOUND_PRESENTATION_SELECT_AUDIO_AUTO_EQUALIZER /*160*/:
                return handleVendorCommandWithId(message);
            case 192:
                return handleInitiateArc(message);
            case 197:
                return handleTerminateArc(message);
            default:
                return false;
        }
    }

    @ServiceThreadOnly
    private boolean dispatchMessageToAction(HdmiCecMessage message) {
        assertRunOnServiceThread();
        boolean processed = false;
        Iterator i$ = new ArrayList(this.mActions).iterator();
        while (i$.hasNext()) {
            processed = processed || ((HdmiCecFeatureAction) i$.next()).processCommand(message);
        }
        return processed;
    }

    @ServiceThreadOnly
    protected boolean handleGivePhysicalAddress() {
        assertRunOnServiceThread();
        this.mService.sendCecCommand(HdmiCecMessageBuilder.buildReportPhysicalAddressCommand(this.mAddress, this.mService.getPhysicalAddress(), this.mDeviceType));
        return true;
    }

    @ServiceThreadOnly
    protected boolean handleGiveDeviceVendorId() {
        assertRunOnServiceThread();
        this.mService.sendCecCommand(HdmiCecMessageBuilder.buildDeviceVendorIdCommand(this.mAddress, this.mService.getVendorId()));
        return true;
    }

    @ServiceThreadOnly
    protected boolean handleGetCecVersion(HdmiCecMessage message) {
        assertRunOnServiceThread();
        this.mService.sendCecCommand(HdmiCecMessageBuilder.buildCecVersion(message.getDestination(), message.getSource(), this.mService.getCecVersion()));
        return true;
    }

    @ServiceThreadOnly
    protected boolean handleActiveSource(HdmiCecMessage message) {
        return false;
    }

    @ServiceThreadOnly
    protected boolean handleInactiveSource(HdmiCecMessage message) {
        return false;
    }

    @ServiceThreadOnly
    protected boolean handleRequestActiveSource(HdmiCecMessage message) {
        return false;
    }

    @ServiceThreadOnly
    protected boolean handleGetMenuLanguage(HdmiCecMessage message) {
        assertRunOnServiceThread();
        Slog.w(TAG, "Only TV can handle <Get Menu Language>:" + message.toString());
        return false;
    }

    @ServiceThreadOnly
    protected boolean handleGiveOsdName(HdmiCecMessage message) {
        assertRunOnServiceThread();
        HdmiCecMessage cecMessage = HdmiCecMessageBuilder.buildSetOsdNameCommand(this.mAddress, message.getSource(), this.mDeviceInfo.getDisplayName());
        if (cecMessage != null) {
            this.mService.sendCecCommand(cecMessage);
        } else {
            Slog.w(TAG, "Failed to build <Get Osd Name>:" + this.mDeviceInfo.getDisplayName());
        }
        return true;
    }

    protected boolean handleRoutingChange(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleRoutingInformation(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleReportPhysicalAddress(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleSystemAudioModeStatus(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleSetSystemAudioMode(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleTerminateArc(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleInitiateArc(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleReportAudioStatus(HdmiCecMessage message) {
        return false;
    }

    @ServiceThreadOnly
    protected boolean handleStandby(HdmiCecMessage message) {
        assertRunOnServiceThread();
        if (!this.mService.isControlEnabled() || this.mService.isProhibitMode() || !this.mService.isPowerOnOrTransient()) {
            return false;
        }
        this.mService.standby();
        return true;
    }

    @ServiceThreadOnly
    protected boolean handleUserControlPressed(HdmiCecMessage message) {
        assertRunOnServiceThread();
        this.mHandler.removeMessages(MSG_USER_CONTROL_RELEASE_TIMEOUT);
        if (this.mService.isPowerOnOrTransient() && isPowerOffOrToggleCommand(message)) {
            this.mService.standby();
            return true;
        } else if (this.mService.isPowerStandbyOrTransient() && isPowerOnOrToggleCommand(message)) {
            this.mService.wakeUp();
            return true;
        } else {
            long downTime = SystemClock.uptimeMillis();
            int keycode = HdmiCecKeycode.cecKeycodeAndParamsToAndroidKey(message.getParams());
            int keyRepeatCount = 0;
            if (this.mLastKeycode != -1) {
                if (keycode == this.mLastKeycode) {
                    keyRepeatCount = this.mLastKeyRepeatCount + MSG_DISABLE_DEVICE_TIMEOUT;
                } else {
                    injectKeyEvent(downTime, MSG_DISABLE_DEVICE_TIMEOUT, this.mLastKeycode, 0);
                }
            }
            this.mLastKeycode = keycode;
            this.mLastKeyRepeatCount = keyRepeatCount;
            if (keycode == -1) {
                return false;
            }
            injectKeyEvent(downTime, 0, keycode, keyRepeatCount);
            this.mHandler.sendMessageDelayed(Message.obtain(this.mHandler, MSG_USER_CONTROL_RELEASE_TIMEOUT), 550);
            return true;
        }
    }

    @ServiceThreadOnly
    protected boolean handleUserControlReleased() {
        assertRunOnServiceThread();
        this.mHandler.removeMessages(MSG_USER_CONTROL_RELEASE_TIMEOUT);
        this.mLastKeyRepeatCount = 0;
        if (this.mLastKeycode == -1) {
            return false;
        }
        injectKeyEvent(SystemClock.uptimeMillis(), MSG_DISABLE_DEVICE_TIMEOUT, this.mLastKeycode, 0);
        this.mLastKeycode = -1;
        return true;
    }

    static void injectKeyEvent(long time, int action, int keycode, int repeat) {
        KeyEvent keyEvent = KeyEvent.obtain(time, time, action, keycode, repeat, 0, -1, 0, 8, 33554433, null);
        InputManager.getInstance().injectInputEvent(keyEvent, 0);
        keyEvent.recycle();
    }

    static boolean isPowerOnOrToggleCommand(HdmiCecMessage message) {
        byte[] params = message.getParams();
        if (message.getOpcode() != 68) {
            return false;
        }
        if (params[0] == 64 || params[0] == 109 || params[0] == 107) {
            return true;
        }
        return false;
    }

    static boolean isPowerOffOrToggleCommand(HdmiCecMessage message) {
        byte[] params = message.getParams();
        if (message.getOpcode() != 68) {
            return false;
        }
        if (params[0] == 64 || params[0] == 108 || params[0] == 107) {
            return true;
        }
        return false;
    }

    protected boolean handleTextViewOn(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleImageViewOn(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleSetStreamPath(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleGiveDevicePowerStatus(HdmiCecMessage message) {
        this.mService.sendCecCommand(HdmiCecMessageBuilder.buildReportPowerStatus(this.mAddress, message.getSource(), this.mService.getPowerStatus()));
        return true;
    }

    protected boolean handleMenuRequest(HdmiCecMessage message) {
        this.mService.sendCecCommand(HdmiCecMessageBuilder.buildReportMenuStatus(this.mAddress, message.getSource(), 0));
        return true;
    }

    protected boolean handleMenuStatus(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleVendorCommand(HdmiCecMessage message) {
        if (!this.mService.invokeVendorCommandListenersOnReceived(this.mDeviceType, message.getSource(), message.getDestination(), message.getParams(), false)) {
            this.mService.maySendFeatureAbortCommand(message, MSG_DISABLE_DEVICE_TIMEOUT);
        }
        return true;
    }

    protected boolean handleVendorCommandWithId(HdmiCecMessage message) {
        byte[] params = message.getParams();
        if (HdmiUtils.threeBytesToInt(params) == this.mService.getVendorId()) {
            if (!this.mService.invokeVendorCommandListenersOnReceived(this.mDeviceType, message.getSource(), message.getDestination(), params, true)) {
                this.mService.maySendFeatureAbortCommand(message, MSG_DISABLE_DEVICE_TIMEOUT);
            }
        } else if (message.getDestination() == 15 || message.getSource() == 15) {
            Slog.v(TAG, "Wrong broadcast vendor command. Ignoring");
        } else {
            Slog.v(TAG, "Wrong direct vendor command. Replying with <Feature Abort>");
            this.mService.maySendFeatureAbortCommand(message, 0);
        }
        return true;
    }

    protected void sendStandby(int deviceId) {
    }

    protected boolean handleSetOsdName(HdmiCecMessage message) {
        return true;
    }

    protected boolean handleRecordTvScreen(HdmiCecMessage message) {
        this.mService.maySendFeatureAbortCommand(message, MSG_USER_CONTROL_RELEASE_TIMEOUT);
        return true;
    }

    protected boolean handleTimerClearedStatus(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleReportPowerStatus(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleTimerStatus(HdmiCecMessage message) {
        return false;
    }

    protected boolean handleRecordStatus(HdmiCecMessage message) {
        return false;
    }

    @ServiceThreadOnly
    final void handleAddressAllocated(int logicalAddress, int reason) {
        assertRunOnServiceThread();
        this.mPreferredAddress = logicalAddress;
        this.mAddress = logicalAddress;
        onAddressAllocated(logicalAddress, reason);
        setPreferredAddress(logicalAddress);
    }

    int getType() {
        return this.mDeviceType;
    }

    @ServiceThreadOnly
    HdmiDeviceInfo getDeviceInfo() {
        assertRunOnServiceThread();
        return this.mDeviceInfo;
    }

    @ServiceThreadOnly
    void setDeviceInfo(HdmiDeviceInfo info) {
        assertRunOnServiceThread();
        this.mDeviceInfo = info;
    }

    @ServiceThreadOnly
    boolean isAddressOf(int addr) {
        assertRunOnServiceThread();
        return addr == this.mAddress;
    }

    @ServiceThreadOnly
    void clearAddress() {
        assertRunOnServiceThread();
        this.mAddress = 15;
    }

    @ServiceThreadOnly
    void addAndStartAction(HdmiCecFeatureAction action) {
        assertRunOnServiceThread();
        this.mActions.add(action);
        if (this.mService.isPowerStandbyOrTransient()) {
            Slog.i(TAG, "Not ready to start action. Queued for deferred start:" + action);
        } else {
            action.start();
        }
    }

    @ServiceThreadOnly
    void startQueuedActions() {
        assertRunOnServiceThread();
        Iterator i$ = this.mActions.iterator();
        while (i$.hasNext()) {
            HdmiCecFeatureAction action = (HdmiCecFeatureAction) i$.next();
            if (!action.started()) {
                Slog.i(TAG, "Starting queued action:" + action);
                action.start();
            }
        }
    }

    @ServiceThreadOnly
    <T extends HdmiCecFeatureAction> boolean hasAction(Class<T> clazz) {
        assertRunOnServiceThread();
        Iterator i$ = this.mActions.iterator();
        while (i$.hasNext()) {
            if (((HdmiCecFeatureAction) i$.next()).getClass().equals(clazz)) {
                return true;
            }
        }
        return false;
    }

    @ServiceThreadOnly
    <T extends HdmiCecFeatureAction> List<T> getActions(Class<T> clazz) {
        assertRunOnServiceThread();
        List<T> actions = Collections.emptyList();
        Iterator i$ = this.mActions.iterator();
        while (i$.hasNext()) {
            HdmiCecFeatureAction action = (HdmiCecFeatureAction) i$.next();
            if (action.getClass().equals(clazz)) {
                if (actions.isEmpty()) {
                    actions = new ArrayList();
                }
                actions.add(action);
            }
        }
        return actions;
    }

    @ServiceThreadOnly
    void removeAction(HdmiCecFeatureAction action) {
        assertRunOnServiceThread();
        action.finish(false);
        this.mActions.remove(action);
        checkIfPendingActionsCleared();
    }

    @ServiceThreadOnly
    <T extends HdmiCecFeatureAction> void removeAction(Class<T> clazz) {
        assertRunOnServiceThread();
        removeActionExcept(clazz, null);
    }

    @ServiceThreadOnly
    <T extends HdmiCecFeatureAction> void removeActionExcept(Class<T> clazz, HdmiCecFeatureAction exception) {
        assertRunOnServiceThread();
        Iterator<HdmiCecFeatureAction> iter = this.mActions.iterator();
        while (iter.hasNext()) {
            HdmiCecFeatureAction action = (HdmiCecFeatureAction) iter.next();
            if (action != exception && action.getClass().equals(clazz)) {
                action.finish(false);
                iter.remove();
            }
        }
        checkIfPendingActionsCleared();
    }

    protected void checkIfPendingActionsCleared() {
        if (this.mActions.isEmpty() && this.mPendingActionClearedCallback != null) {
            PendingActionClearedCallback callback = this.mPendingActionClearedCallback;
            this.mPendingActionClearedCallback = null;
            callback.onCleared(this);
        }
    }

    protected void assertRunOnServiceThread() {
        if (Looper.myLooper() != this.mService.getServiceLooper()) {
            throw new IllegalStateException("Should run on service thread.");
        }
    }

    void onHotplug(int portId, boolean connected) {
    }

    final HdmiControlService getService() {
        return this.mService;
    }

    @ServiceThreadOnly
    final boolean isConnectedToArcPort(int path) {
        assertRunOnServiceThread();
        return this.mService.isConnectedToArcPort(path);
    }

    ActiveSource getActiveSource() {
        ActiveSource activeSource;
        synchronized (this.mLock) {
            activeSource = this.mActiveSource;
        }
        return activeSource;
    }

    void setActiveSource(ActiveSource newActive) {
        setActiveSource(newActive.logicalAddress, newActive.physicalAddress);
    }

    void setActiveSource(HdmiDeviceInfo info) {
        setActiveSource(info.getLogicalAddress(), info.getPhysicalAddress());
    }

    void setActiveSource(int logicalAddress, int physicalAddress) {
        synchronized (this.mLock) {
            this.mActiveSource.logicalAddress = logicalAddress;
            this.mActiveSource.physicalAddress = physicalAddress;
        }
        this.mService.setLastInputForMhl(-1);
    }

    int getActivePath() {
        int i;
        synchronized (this.mLock) {
            i = this.mActiveRoutingPath;
        }
        return i;
    }

    void setActivePath(int path) {
        synchronized (this.mLock) {
            this.mActiveRoutingPath = path;
        }
        this.mService.setActivePortId(pathToPortId(path));
    }

    int getActivePortId() {
        int pathToPortId;
        synchronized (this.mLock) {
            pathToPortId = this.mService.pathToPortId(this.mActiveRoutingPath);
        }
        return pathToPortId;
    }

    void setActivePortId(int portId) {
        setActivePath(this.mService.portIdToPath(portId));
    }

    @ServiceThreadOnly
    HdmiCecMessageCache getCecMessageCache() {
        assertRunOnServiceThread();
        return this.mCecMessageCache;
    }

    @ServiceThreadOnly
    int pathToPortId(int newPath) {
        assertRunOnServiceThread();
        return this.mService.pathToPortId(newPath);
    }

    protected void onStandby(boolean initiatedByCec) {
    }

    protected void disableDevice(boolean initiatedByCec, PendingActionClearedCallback origialCallback) {
        this.mPendingActionClearedCallback = new C02862(origialCallback);
        this.mHandler.sendMessageDelayed(Message.obtain(this.mHandler, MSG_DISABLE_DEVICE_TIMEOUT), 5000);
    }

    @ServiceThreadOnly
    private void handleDisableDeviceTimeout() {
        assertRunOnServiceThread();
        Iterator<HdmiCecFeatureAction> iter = this.mActions.iterator();
        while (iter.hasNext()) {
            ((HdmiCecFeatureAction) iter.next()).finish(false);
            iter.remove();
        }
    }

    protected void sendKeyEvent(int keyCode, boolean isPressed) {
        Slog.w(TAG, "sendKeyEvent not implemented");
    }

    void sendUserControlPressedAndReleased(int targetAddress, int cecKeycode) {
        this.mService.sendCecCommand(HdmiCecMessageBuilder.buildUserControlPressed(this.mAddress, targetAddress, cecKeycode));
        this.mService.sendCecCommand(HdmiCecMessageBuilder.buildUserControlReleased(this.mAddress, targetAddress));
    }

    protected void dump(IndentingPrintWriter pw) {
        pw.println("mDeviceType: " + this.mDeviceType);
        pw.println("mAddress: " + this.mAddress);
        pw.println("mPreferredAddress: " + this.mPreferredAddress);
        pw.println("mDeviceInfo: " + this.mDeviceInfo);
        pw.println("mActiveSource: " + this.mActiveSource);
        Object[] objArr = new Object[MSG_DISABLE_DEVICE_TIMEOUT];
        objArr[0] = Integer.valueOf(this.mActiveRoutingPath);
        pw.println(String.format("mActiveRoutingPath: 0x%04x", objArr));
    }
}
