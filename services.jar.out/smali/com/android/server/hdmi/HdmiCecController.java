package com.android.server.hdmi;

import android.hardware.hdmi.HdmiPortInfo;
import android.os.Handler;
import android.os.Looper;
import android.os.MessageQueue;
import android.util.Slog;
import android.util.SparseArray;
import com.android.internal.util.IndentingPrintWriter;
import com.android.internal.util.Predicate;
import com.android.server.hdmi.HdmiAnnotations.IoThreadOnly;
import com.android.server.hdmi.HdmiAnnotations.ServiceThreadOnly;
import com.android.server.wm.WindowManagerService.C0569H;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import libcore.util.EmptyArray;

final class HdmiCecController {
    private static final byte[] EMPTY_BODY;
    private static final int NUM_LOGICAL_ADDRESS = 16;
    private static final String TAG = "HdmiCecController";
    private Handler mControlHandler;
    private Handler mIoHandler;
    private final SparseArray<HdmiCecLocalDevice> mLocalDevices;
    private volatile long mNativePtr;
    private final Predicate<Integer> mRemoteDeviceAddressPredicate;
    private final HdmiControlService mService;
    private final Predicate<Integer> mSystemAudioAddressPredicate;

    /* renamed from: com.android.server.hdmi.HdmiCecController.1 */
    class C02751 implements Predicate<Integer> {
        C02751() {
        }

        public boolean apply(Integer address) {
            return !HdmiCecController.this.isAllocatedLocalDeviceAddress(address.intValue());
        }
    }

    /* renamed from: com.android.server.hdmi.HdmiCecController.2 */
    class C02762 implements Predicate<Integer> {
        C02762() {
        }

        public boolean apply(Integer address) {
            return HdmiUtils.getTypeFromAddress(address.intValue()) == 5;
        }
    }

    /* renamed from: com.android.server.hdmi.HdmiCecController.3 */
    class C02773 implements Runnable {
        final /* synthetic */ AllocateAddressCallback val$callback;
        final /* synthetic */ int val$deviceType;
        final /* synthetic */ int val$preferredAddress;

        C02773(int i, int i2, AllocateAddressCallback allocateAddressCallback) {
            this.val$deviceType = i;
            this.val$preferredAddress = i2;
            this.val$callback = allocateAddressCallback;
        }

        public void run() {
            HdmiCecController.this.handleAllocateLogicalAddress(this.val$deviceType, this.val$preferredAddress, this.val$callback);
        }
    }

    /* renamed from: com.android.server.hdmi.HdmiCecController.4 */
    class C02784 implements Runnable {
        final /* synthetic */ int val$assignedAddress;
        final /* synthetic */ AllocateAddressCallback val$callback;
        final /* synthetic */ int val$deviceType;

        C02784(AllocateAddressCallback allocateAddressCallback, int i, int i2) {
            this.val$callback = allocateAddressCallback;
            this.val$deviceType = i;
            this.val$assignedAddress = i2;
        }

        public void run() {
            this.val$callback.onAllocated(this.val$deviceType, this.val$assignedAddress);
        }
    }

    /* renamed from: com.android.server.hdmi.HdmiCecController.5 */
    class C02805 implements Runnable {
        final /* synthetic */ List val$allocated;
        final /* synthetic */ DevicePollingCallback val$callback;
        final /* synthetic */ Integer val$candidate;
        final /* synthetic */ List val$candidates;
        final /* synthetic */ int val$retryCount;
        final /* synthetic */ int val$sourceAddress;

        /* renamed from: com.android.server.hdmi.HdmiCecController.5.1 */
        class C02791 implements Runnable {
            C02791() {
            }

            public void run() {
                HdmiCecController.this.runDevicePolling(C02805.this.val$sourceAddress, C02805.this.val$candidates, C02805.this.val$retryCount, C02805.this.val$callback, C02805.this.val$allocated);
            }
        }

        C02805(int i, Integer num, int i2, List list, List list2, DevicePollingCallback devicePollingCallback) {
            this.val$sourceAddress = i;
            this.val$candidate = num;
            this.val$retryCount = i2;
            this.val$allocated = list;
            this.val$candidates = list2;
            this.val$callback = devicePollingCallback;
        }

        public void run() {
            if (HdmiCecController.this.sendPollMessage(this.val$sourceAddress, this.val$candidate.intValue(), this.val$retryCount)) {
                this.val$allocated.add(this.val$candidate);
            }
            HdmiCecController.this.runOnServiceThread(new C02791());
        }
    }

    /* renamed from: com.android.server.hdmi.HdmiCecController.6 */
    class C02816 implements Runnable {
        final /* synthetic */ Runnable val$runnable;

        C02816(Runnable runnable) {
            this.val$runnable = runnable;
        }

        public void run() {
            HdmiCecController.this.runOnServiceThread(this.val$runnable);
        }
    }

    /* renamed from: com.android.server.hdmi.HdmiCecController.7 */
    class C02837 implements Runnable {
        final /* synthetic */ SendMessageCallback val$callback;
        final /* synthetic */ HdmiCecMessage val$cecMessage;

        /* renamed from: com.android.server.hdmi.HdmiCecController.7.1 */
        class C02821 implements Runnable {
            final /* synthetic */ int val$finalError;

            C02821(int i) {
                this.val$finalError = i;
            }

            public void run() {
                C02837.this.val$callback.onSendCompleted(this.val$finalError);
            }
        }

        C02837(HdmiCecMessage hdmiCecMessage, SendMessageCallback sendMessageCallback) {
            this.val$cecMessage = hdmiCecMessage;
            this.val$callback = sendMessageCallback;
        }

        public void run() {
            int errorCode;
            int i;
            HdmiLogger.debug("[S]:" + this.val$cecMessage, new Object[0]);
            byte[] body = HdmiCecController.buildBody(this.val$cecMessage.getOpcode(), this.val$cecMessage.getParams());
            int i2 = 0;
            while (true) {
                errorCode = HdmiCecController.nativeSendCecCommand(HdmiCecController.this.mNativePtr, this.val$cecMessage.getSource(), this.val$cecMessage.getDestination(), body);
                if (errorCode == 0) {
                    break;
                }
                i = i2 + 1;
                if (i2 >= 1) {
                    break;
                }
                i2 = i;
            }
            i2 = i;
            int finalError = errorCode;
            if (finalError != 0) {
                Slog.w(HdmiCecController.TAG, "Failed to send " + this.val$cecMessage);
            }
            if (this.val$callback != null) {
                HdmiCecController.this.runOnServiceThread(new C02821(finalError));
            }
        }
    }

    interface AllocateAddressCallback {
        void onAllocated(int i, int i2);
    }

    private static native int nativeAddLogicalAddress(long j, int i);

    private static native void nativeClearLogicalAddress(long j);

    private static native int nativeGetPhysicalAddress(long j);

    private static native HdmiPortInfo[] nativeGetPortInfos(long j);

    private static native int nativeGetVendorId(long j);

    private static native int nativeGetVersion(long j);

    private static native long nativeInit(HdmiCecController hdmiCecController, MessageQueue messageQueue);

    private static native boolean nativeIsConnected(long j, int i);

    private static native int nativeSendCecCommand(long j, int i, int i2, byte[] bArr);

    private static native void nativeSetAudioReturnChannel(long j, int i, boolean z);

    private static native void nativeSetOption(long j, int i, int i2);

    static {
        EMPTY_BODY = EmptyArray.BYTE;
    }

    private HdmiCecController(HdmiControlService service) {
        this.mRemoteDeviceAddressPredicate = new C02751();
        this.mSystemAudioAddressPredicate = new C02762();
        this.mLocalDevices = new SparseArray();
        this.mService = service;
    }

    static HdmiCecController create(HdmiControlService service) {
        HdmiCecController controller = new HdmiCecController(service);
        long nativePtr = nativeInit(controller, service.getServiceLooper().getQueue());
        if (nativePtr == 0) {
            return null;
        }
        controller.init(nativePtr);
        return controller;
    }

    private void init(long nativePtr) {
        this.mIoHandler = new Handler(this.mService.getIoLooper());
        this.mControlHandler = new Handler(this.mService.getServiceLooper());
        this.mNativePtr = nativePtr;
    }

    @ServiceThreadOnly
    void addLocalDevice(int deviceType, HdmiCecLocalDevice device) {
        assertRunOnServiceThread();
        this.mLocalDevices.put(deviceType, device);
    }

    @ServiceThreadOnly
    void allocateLogicalAddress(int deviceType, int preferredAddress, AllocateAddressCallback callback) {
        assertRunOnServiceThread();
        runOnIoThread(new C02773(deviceType, preferredAddress, callback));
    }

    @IoThreadOnly
    private void handleAllocateLogicalAddress(int deviceType, int preferredAddress, AllocateAddressCallback callback) {
        int i;
        assertRunOnIoThread();
        int startAddress = preferredAddress;
        if (preferredAddress == 15) {
            for (i = 0; i < NUM_LOGICAL_ADDRESS; i++) {
                if (deviceType == HdmiUtils.getTypeFromAddress(i)) {
                    startAddress = i;
                    break;
                }
            }
        }
        int logicalAddress = 15;
        for (i = 0; i < NUM_LOGICAL_ADDRESS; i++) {
            int curAddress = (startAddress + i) % NUM_LOGICAL_ADDRESS;
            if (curAddress != 15 && deviceType == HdmiUtils.getTypeFromAddress(curAddress)) {
                int failedPollingCount = 0;
                for (int j = 0; j < 3; j++) {
                    if (!sendPollMessage(curAddress, curAddress, 1)) {
                        failedPollingCount++;
                    }
                }
                if (failedPollingCount * 2 > 3) {
                    logicalAddress = curAddress;
                    break;
                }
            }
        }
        HdmiLogger.debug("New logical address for device [%d]: [preferred:%d, assigned:%d]", Integer.valueOf(deviceType), Integer.valueOf(preferredAddress), Integer.valueOf(logicalAddress));
        if (callback != null) {
            runOnServiceThread(new C02784(callback, deviceType, assignedAddress));
        }
    }

    private static byte[] buildBody(int opcode, byte[] params) {
        byte[] body = new byte[(params.length + 1)];
        body[0] = (byte) opcode;
        System.arraycopy(params, 0, body, 1, params.length);
        return body;
    }

    HdmiPortInfo[] getPortInfos() {
        return nativeGetPortInfos(this.mNativePtr);
    }

    HdmiCecLocalDevice getLocalDevice(int deviceType) {
        return (HdmiCecLocalDevice) this.mLocalDevices.get(deviceType);
    }

    @ServiceThreadOnly
    int addLogicalAddress(int newLogicalAddress) {
        assertRunOnServiceThread();
        if (HdmiUtils.isValidAddress(newLogicalAddress)) {
            return nativeAddLogicalAddress(this.mNativePtr, newLogicalAddress);
        }
        return -1;
    }

    @ServiceThreadOnly
    void clearLogicalAddress() {
        assertRunOnServiceThread();
        for (int i = 0; i < this.mLocalDevices.size(); i++) {
            ((HdmiCecLocalDevice) this.mLocalDevices.valueAt(i)).clearAddress();
        }
        nativeClearLogicalAddress(this.mNativePtr);
    }

    @ServiceThreadOnly
    void clearLocalDevices() {
        assertRunOnServiceThread();
        this.mLocalDevices.clear();
    }

    @ServiceThreadOnly
    int getPhysicalAddress() {
        assertRunOnServiceThread();
        return nativeGetPhysicalAddress(this.mNativePtr);
    }

    @ServiceThreadOnly
    int getVersion() {
        assertRunOnServiceThread();
        return nativeGetVersion(this.mNativePtr);
    }

    @ServiceThreadOnly
    int getVendorId() {
        assertRunOnServiceThread();
        return nativeGetVendorId(this.mNativePtr);
    }

    @ServiceThreadOnly
    void setOption(int flag, int value) {
        assertRunOnServiceThread();
        HdmiLogger.debug("setOption: [flag:%d, value:%d]", Integer.valueOf(flag), Integer.valueOf(value));
        nativeSetOption(this.mNativePtr, flag, value);
    }

    @ServiceThreadOnly
    void setAudioReturnChannel(int port, boolean enabled) {
        assertRunOnServiceThread();
        nativeSetAudioReturnChannel(this.mNativePtr, port, enabled);
    }

    @ServiceThreadOnly
    boolean isConnected(int port) {
        assertRunOnServiceThread();
        return nativeIsConnected(this.mNativePtr, port);
    }

    @ServiceThreadOnly
    void pollDevices(DevicePollingCallback callback, int sourceAddress, int pickStrategy, int retryCount) {
        assertRunOnServiceThread();
        runDevicePolling(sourceAddress, pickPollCandidates(pickStrategy), retryCount, callback, new ArrayList());
    }

    @ServiceThreadOnly
    List<HdmiCecLocalDevice> getLocalDeviceList() {
        assertRunOnServiceThread();
        return HdmiUtils.sparseArrayToList(this.mLocalDevices);
    }

    private List<Integer> pickPollCandidates(int pickStrategy) {
        Predicate<Integer> pickPredicate;
        switch (pickStrategy & 3) {
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                pickPredicate = this.mSystemAudioAddressPredicate;
                break;
            default:
                pickPredicate = this.mRemoteDeviceAddressPredicate;
                break;
        }
        int iterationStrategy = pickStrategy & 196608;
        LinkedList<Integer> pollingCandidates = new LinkedList();
        int i;
        switch (iterationStrategy) {
            case 65536:
                for (i = 0; i <= 14; i++) {
                    if (pickPredicate.apply(Integer.valueOf(i))) {
                        pollingCandidates.add(Integer.valueOf(i));
                    }
                }
                break;
            default:
                for (i = 14; i >= 0; i--) {
                    if (pickPredicate.apply(Integer.valueOf(i))) {
                        pollingCandidates.add(Integer.valueOf(i));
                    }
                }
                break;
        }
        return pollingCandidates;
    }

    @ServiceThreadOnly
    private boolean isAllocatedLocalDeviceAddress(int address) {
        assertRunOnServiceThread();
        for (int i = 0; i < this.mLocalDevices.size(); i++) {
            if (((HdmiCecLocalDevice) this.mLocalDevices.valueAt(i)).isAddressOf(address)) {
                return true;
            }
        }
        return false;
    }

    @ServiceThreadOnly
    private void runDevicePolling(int sourceAddress, List<Integer> candidates, int retryCount, DevicePollingCallback callback, List<Integer> allocated) {
        assertRunOnServiceThread();
        if (!candidates.isEmpty()) {
            runOnIoThread(new C02805(sourceAddress, (Integer) candidates.remove(0), retryCount, allocated, candidates, callback));
        } else if (callback != null) {
            HdmiLogger.debug("[P]:AllocatedAddress=%s", allocated.toString());
            callback.onPollingFinished(allocated);
        }
    }

    @IoThreadOnly
    private boolean sendPollMessage(int sourceAddress, int destinationAddress, int retryCount) {
        assertRunOnIoThread();
        for (int i = 0; i < retryCount; i++) {
            if (nativeSendCecCommand(this.mNativePtr, sourceAddress, destinationAddress, EMPTY_BODY) == 0) {
                return true;
            }
        }
        return false;
    }

    private void assertRunOnIoThread() {
        if (Looper.myLooper() != this.mIoHandler.getLooper()) {
            throw new IllegalStateException("Should run on io thread.");
        }
    }

    private void assertRunOnServiceThread() {
        if (Looper.myLooper() != this.mControlHandler.getLooper()) {
            throw new IllegalStateException("Should run on service thread.");
        }
    }

    private void runOnIoThread(Runnable runnable) {
        this.mIoHandler.post(runnable);
    }

    private void runOnServiceThread(Runnable runnable) {
        this.mControlHandler.post(runnable);
    }

    @ServiceThreadOnly
    void flush(Runnable runnable) {
        assertRunOnServiceThread();
        runOnIoThread(new C02816(runnable));
    }

    private boolean isAcceptableAddress(int address) {
        if (address == 15) {
            return true;
        }
        return isAllocatedLocalDeviceAddress(address);
    }

    @ServiceThreadOnly
    private void onReceiveCommand(HdmiCecMessage message) {
        assertRunOnServiceThread();
        if (!isAcceptableAddress(message.getDestination()) || !this.mService.handleCecCommand(message)) {
            maySendFeatureAbortCommand(message, 0);
        }
    }

    @ServiceThreadOnly
    void maySendFeatureAbortCommand(HdmiCecMessage message, int reason) {
        assertRunOnServiceThread();
        int src = message.getDestination();
        int dest = message.getSource();
        if (src != 15 && dest != 15) {
            int originalOpcode = message.getOpcode();
            if (originalOpcode != 0) {
                sendCommand(HdmiCecMessageBuilder.buildFeatureAbortCommand(src, dest, originalOpcode, reason));
            }
        }
    }

    @ServiceThreadOnly
    void sendCommand(HdmiCecMessage cecMessage) {
        assertRunOnServiceThread();
        sendCommand(cecMessage, null);
    }

    @ServiceThreadOnly
    void sendCommand(HdmiCecMessage cecMessage, SendMessageCallback callback) {
        assertRunOnServiceThread();
        runOnIoThread(new C02837(cecMessage, callback));
    }

    @ServiceThreadOnly
    private void handleIncomingCecCommand(int srcAddress, int dstAddress, byte[] body) {
        assertRunOnServiceThread();
        HdmiCecMessage command = HdmiCecMessageBuilder.of(srcAddress, dstAddress, body);
        HdmiLogger.debug("[R]:" + command, new Object[0]);
        onReceiveCommand(command);
    }

    @ServiceThreadOnly
    private void handleHotplug(int port, boolean connected) {
        assertRunOnServiceThread();
        HdmiLogger.debug("Hotplug event:[port:%d, connected:%b]", Integer.valueOf(port), Boolean.valueOf(connected));
        this.mService.onHotplug(port, connected);
    }

    void dump(IndentingPrintWriter pw) {
        for (int i = 0; i < this.mLocalDevices.size(); i++) {
            pw.println("HdmiCecLocalDevice #" + i + ":");
            pw.increaseIndent();
            ((HdmiCecLocalDevice) this.mLocalDevices.valueAt(i)).dump(pw);
            pw.decreaseIndent();
        }
    }
}
