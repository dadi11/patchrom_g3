package com.android.server.hdmi;

import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.ContentObserver;
import android.hardware.hdmi.HdmiDeviceInfo;
import android.hardware.hdmi.HdmiHotplugEvent;
import android.hardware.hdmi.HdmiPortInfo;
import android.hardware.hdmi.IHdmiControlCallback;
import android.hardware.hdmi.IHdmiControlCallback.Stub;
import android.hardware.hdmi.IHdmiControlService;
import android.hardware.hdmi.IHdmiDeviceEventListener;
import android.hardware.hdmi.IHdmiHotplugEventListener;
import android.hardware.hdmi.IHdmiInputChangeListener;
import android.hardware.hdmi.IHdmiMhlVendorCommandListener;
import android.hardware.hdmi.IHdmiRecordListener;
import android.hardware.hdmi.IHdmiSystemAudioModeChangeListener;
import android.hardware.hdmi.IHdmiVendorCommandListener;
import android.media.AudioManager;
import android.media.tv.TvInputManager;
import android.media.tv.TvInputManager.TvInputCallback;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.PowerManager;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.provider.Settings.Global;
import android.text.TextUtils.SimpleStringSplitter;
import android.util.ArraySet;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseIntArray;
import com.android.internal.annotations.GuardedBy;
import com.android.internal.util.IndentingPrintWriter;
import com.android.server.SystemService;
import com.android.server.hdmi.HdmiAnnotations.ServiceThreadOnly;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import libcore.util.EmptyArray;

public final class HdmiControlService extends SystemService {
    static final int INITIATED_BY_BOOT_UP = 1;
    static final int INITIATED_BY_ENABLE_CEC = 0;
    static final int INITIATED_BY_HOTPLUG = 4;
    static final int INITIATED_BY_SCREEN_ON = 2;
    static final int INITIATED_BY_WAKE_UP_MESSAGE = 3;
    static final String PERMISSION = "android.permission.HDMI_CEC";
    private static final String TAG = "HdmiControlService";
    private final Locale HONG_KONG;
    private final Locale MACAU;
    @ServiceThreadOnly
    private int mActivePortId;
    private boolean mAddressAllocated;
    private HdmiCecController mCecController;
    private CecMessageBuffer mCecMessageBuffer;
    @GuardedBy("mLock")
    private final ArrayList<DeviceEventListenerRecord> mDeviceEventListenerRecords;
    private final Handler mHandler;
    private final HdmiControlBroadcastReceiver mHdmiControlBroadcastReceiver;
    @GuardedBy("mLock")
    private boolean mHdmiControlEnabled;
    @GuardedBy("mLock")
    private final ArrayList<HotplugEventListenerRecord> mHotplugEventListenerRecords;
    @GuardedBy("mLock")
    private InputChangeListenerRecord mInputChangeListenerRecord;
    private final HandlerThread mIoThread;
    @ServiceThreadOnly
    private String mLanguage;
    @ServiceThreadOnly
    private int mLastInputMhl;
    private final List<Integer> mLocalDevices;
    private final Object mLock;
    private HdmiCecMessageValidator mMessageValidator;
    private HdmiMhlControllerStub mMhlController;
    @GuardedBy("mLock")
    private List<HdmiDeviceInfo> mMhlDevices;
    @GuardedBy("mLock")
    private boolean mMhlInputChangeEnabled;
    @GuardedBy("mLock")
    private final ArrayList<HdmiMhlVendorCommandListenerRecord> mMhlVendorCommandListenerRecords;
    private UnmodifiableSparseArray<HdmiDeviceInfo> mPortDeviceMap;
    private UnmodifiableSparseIntArray mPortIdMap;
    private List<HdmiPortInfo> mPortInfo;
    private UnmodifiableSparseArray<HdmiPortInfo> mPortInfoMap;
    private PowerManager mPowerManager;
    @ServiceThreadOnly
    private int mPowerStatus;
    @GuardedBy("mLock")
    private boolean mProhibitMode;
    @GuardedBy("mLock")
    private HdmiRecordListenerRecord mRecordListenerRecord;
    private final SettingsObserver mSettingsObserver;
    @ServiceThreadOnly
    private boolean mStandbyMessageReceived;
    private final ArrayList<SystemAudioModeChangeListenerRecord> mSystemAudioModeChangeListenerRecords;
    private TvInputManager mTvInputManager;
    @GuardedBy("mLock")
    private final ArrayList<VendorCommandListenerRecord> mVendorCommandListenerRecords;
    @ServiceThreadOnly
    private boolean mWakeUpMessageReceived;

    interface DevicePollingCallback {
        void onPollingFinished(List<Integer> list);
    }

    interface SendMessageCallback {
        void onSendCompleted(int i);
    }

    /* renamed from: com.android.server.hdmi.HdmiControlService.1 */
    class C02921 implements AllocateAddressCallback {
        final /* synthetic */ ArrayList val$allocatedDevices;
        final /* synthetic */ ArrayList val$allocatingDevices;
        final /* synthetic */ int[] val$finished;
        final /* synthetic */ int val$initiatedBy;
        final /* synthetic */ HdmiCecLocalDevice val$localDevice;

        C02921(HdmiCecLocalDevice hdmiCecLocalDevice, ArrayList arrayList, ArrayList arrayList2, int[] iArr, int i) {
            this.val$localDevice = hdmiCecLocalDevice;
            this.val$allocatedDevices = arrayList;
            this.val$allocatingDevices = arrayList2;
            this.val$finished = iArr;
            this.val$initiatedBy = i;
        }

        public void onAllocated(int deviceType, int logicalAddress) {
            if (logicalAddress == 15) {
                Slog.e(HdmiControlService.TAG, "Failed to allocate address:[device_type:" + deviceType + "]");
            } else {
                this.val$localDevice.setDeviceInfo(HdmiControlService.this.createDeviceInfo(logicalAddress, deviceType, HdmiControlService.INITIATED_BY_ENABLE_CEC));
                HdmiControlService.this.mCecController.addLocalDevice(deviceType, this.val$localDevice);
                HdmiControlService.this.mCecController.addLogicalAddress(logicalAddress);
                this.val$allocatedDevices.add(this.val$localDevice);
            }
            int size = this.val$allocatingDevices.size();
            int[] iArr = this.val$finished;
            int i = iArr[HdmiControlService.INITIATED_BY_ENABLE_CEC] + HdmiControlService.INITIATED_BY_BOOT_UP;
            iArr[HdmiControlService.INITIATED_BY_ENABLE_CEC] = i;
            if (size == i) {
                HdmiControlService.this.mAddressAllocated = true;
                if (this.val$initiatedBy != HdmiControlService.INITIATED_BY_HOTPLUG) {
                    HdmiControlService.this.onInitializeCecComplete(this.val$initiatedBy);
                }
                HdmiControlService.this.notifyAddressAllocated(this.val$allocatedDevices, this.val$initiatedBy);
                HdmiControlService.this.mCecMessageBuffer.processMessages();
            }
        }
    }

    /* renamed from: com.android.server.hdmi.HdmiControlService.2 */
    class C02932 implements Runnable {
        final /* synthetic */ IHdmiHotplugEventListener val$listener;
        final /* synthetic */ HotplugEventListenerRecord val$record;

        C02932(HotplugEventListenerRecord hotplugEventListenerRecord, IHdmiHotplugEventListener iHdmiHotplugEventListener) {
            this.val$record = hotplugEventListenerRecord;
            this.val$listener = iHdmiHotplugEventListener;
        }

        public void run() {
            synchronized (HdmiControlService.this.mLock) {
                if (HdmiControlService.this.mHotplugEventListenerRecords.contains(this.val$record)) {
                    for (HdmiPortInfo port : HdmiControlService.this.mPortInfo) {
                        HdmiHotplugEvent event = new HdmiHotplugEvent(port.getId(), HdmiControlService.this.mCecController.isConnected(port.getId()));
                        synchronized (HdmiControlService.this.mLock) {
                            HdmiControlService.this.invokeHotplugEventListenerLocked(this.val$listener, event);
                        }
                    }
                    return;
                }
            }
        }
    }

    /* renamed from: com.android.server.hdmi.HdmiControlService.3 */
    class C02943 implements PendingActionClearedCallback {
        final /* synthetic */ List val$devices;

        C02943(List list) {
            this.val$devices = list;
        }

        public void onCleared(HdmiCecLocalDevice device) {
            Slog.v(HdmiControlService.TAG, "On standby-action cleared:" + device.mDeviceType);
            this.val$devices.remove(device);
            if (this.val$devices.isEmpty()) {
                HdmiControlService.this.onStandbyCompleted();
            }
        }
    }

    /* renamed from: com.android.server.hdmi.HdmiControlService.4 */
    class C02954 implements Runnable {
        C02954() {
        }

        public void run() {
            HdmiControlService.this.disableHdmiControlService();
        }
    }

    /* renamed from: com.android.server.hdmi.HdmiControlService.5 */
    class C02975 implements PendingActionClearedCallback {

        /* renamed from: com.android.server.hdmi.HdmiControlService.5.1 */
        class C02961 implements Runnable {
            C02961() {
            }

            public void run() {
                HdmiControlService.this.mCecController.setOption(HdmiControlService.INITIATED_BY_SCREEN_ON, HdmiControlService.INITIATED_BY_ENABLE_CEC);
                HdmiControlService.this.mMhlController.setOption(HdmiCecKeycode.CEC_KEYCODE_TUNE_FUNCTION, HdmiControlService.INITIATED_BY_ENABLE_CEC);
                HdmiControlService.this.clearLocalDevices();
            }
        }

        C02975() {
        }

        public void onCleared(HdmiCecLocalDevice device) {
            HdmiControlService.this.assertRunOnServiceThread();
            HdmiControlService.this.mCecController.flush(new C02961());
        }
    }

    /* renamed from: com.android.server.hdmi.HdmiControlService.6 */
    class C02986 extends Stub {
        final /* synthetic */ int val$lastInput;

        C02986(int i) {
            this.val$lastInput = i;
        }

        public void onComplete(int result) throws RemoteException {
            HdmiControlService.this.setLastInputForMhl(this.val$lastInput);
        }
    }

    private final class BinderService extends IHdmiControlService.Stub {

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.10 */
        class AnonymousClass10 implements Runnable {
            final /* synthetic */ int val$deviceType;
            final /* synthetic */ boolean val$hasVendorId;
            final /* synthetic */ byte[] val$params;
            final /* synthetic */ int val$targetAddress;

            AnonymousClass10(int i, boolean z, int i2, byte[] bArr) {
                this.val$deviceType = i;
                this.val$hasVendorId = z;
                this.val$targetAddress = i2;
                this.val$params = bArr;
            }

            public void run() {
                HdmiCecLocalDevice device = HdmiControlService.this.mCecController.getLocalDevice(this.val$deviceType);
                if (device == null) {
                    Slog.w(HdmiControlService.TAG, "Local device not available");
                } else if (this.val$hasVendorId) {
                    HdmiControlService.this.sendCecCommand(HdmiCecMessageBuilder.buildVendorCommandWithId(device.getDeviceInfo().getLogicalAddress(), this.val$targetAddress, HdmiControlService.this.getVendorId(), this.val$params));
                } else {
                    HdmiControlService.this.sendCecCommand(HdmiCecMessageBuilder.buildVendorCommand(device.getDeviceInfo().getLogicalAddress(), this.val$targetAddress, this.val$params));
                }
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.11 */
        class AnonymousClass11 implements Runnable {
            final /* synthetic */ int val$deviceId;
            final /* synthetic */ int val$deviceType;

            AnonymousClass11(int i, int i2) {
                this.val$deviceId = i;
                this.val$deviceType = i2;
            }

            public void run() {
                HdmiMhlLocalDeviceStub mhlDevice = HdmiControlService.this.mMhlController.getLocalDeviceById(this.val$deviceId);
                if (mhlDevice != null) {
                    mhlDevice.sendStandby();
                    return;
                }
                HdmiCecLocalDevice device = HdmiControlService.this.mCecController.getLocalDevice(this.val$deviceType);
                if (device == null) {
                    Slog.w(HdmiControlService.TAG, "Local device not available");
                } else {
                    device.sendStandby(this.val$deviceId);
                }
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.12 */
        class AnonymousClass12 implements Runnable {
            final /* synthetic */ byte[] val$recordSource;
            final /* synthetic */ int val$recorderAddress;

            AnonymousClass12(int i, byte[] bArr) {
                this.val$recorderAddress = i;
                this.val$recordSource = bArr;
            }

            public void run() {
                if (HdmiControlService.this.isTvDeviceEnabled()) {
                    HdmiControlService.this.tv().startOneTouchRecord(this.val$recorderAddress, this.val$recordSource);
                } else {
                    Slog.w(HdmiControlService.TAG, "TV device is not enabled.");
                }
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.13 */
        class AnonymousClass13 implements Runnable {
            final /* synthetic */ int val$recorderAddress;

            AnonymousClass13(int i) {
                this.val$recorderAddress = i;
            }

            public void run() {
                if (HdmiControlService.this.isTvDeviceEnabled()) {
                    HdmiControlService.this.tv().stopOneTouchRecord(this.val$recorderAddress);
                } else {
                    Slog.w(HdmiControlService.TAG, "TV device is not enabled.");
                }
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.14 */
        class AnonymousClass14 implements Runnable {
            final /* synthetic */ byte[] val$recordSource;
            final /* synthetic */ int val$recorderAddress;
            final /* synthetic */ int val$sourceType;

            AnonymousClass14(int i, int i2, byte[] bArr) {
                this.val$recorderAddress = i;
                this.val$sourceType = i2;
                this.val$recordSource = bArr;
            }

            public void run() {
                if (HdmiControlService.this.isTvDeviceEnabled()) {
                    HdmiControlService.this.tv().startTimerRecording(this.val$recorderAddress, this.val$sourceType, this.val$recordSource);
                } else {
                    Slog.w(HdmiControlService.TAG, "TV device is not enabled.");
                }
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.15 */
        class AnonymousClass15 implements Runnable {
            final /* synthetic */ byte[] val$recordSource;
            final /* synthetic */ int val$recorderAddress;
            final /* synthetic */ int val$sourceType;

            AnonymousClass15(int i, int i2, byte[] bArr) {
                this.val$recorderAddress = i;
                this.val$sourceType = i2;
                this.val$recordSource = bArr;
            }

            public void run() {
                if (HdmiControlService.this.isTvDeviceEnabled()) {
                    HdmiControlService.this.tv().clearTimerRecording(this.val$recorderAddress, this.val$sourceType, this.val$recordSource);
                } else {
                    Slog.w(HdmiControlService.TAG, "TV device is not enabled.");
                }
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.16 */
        class AnonymousClass16 implements Runnable {
            final /* synthetic */ byte[] val$data;
            final /* synthetic */ int val$length;
            final /* synthetic */ int val$offset;
            final /* synthetic */ int val$portId;

            AnonymousClass16(int i, int i2, int i3, byte[] bArr) {
                this.val$portId = i;
                this.val$offset = i2;
                this.val$length = i3;
                this.val$data = bArr;
            }

            public void run() {
                if (!HdmiControlService.this.isControlEnabled()) {
                    Slog.w(HdmiControlService.TAG, "Hdmi control is disabled.");
                } else if (HdmiControlService.this.mMhlController.getLocalDevice(this.val$portId) == null) {
                    Slog.w(HdmiControlService.TAG, "Invalid port id:" + this.val$portId);
                } else {
                    HdmiControlService.this.mMhlController.sendVendorCommand(this.val$portId, this.val$offset, this.val$length, this.val$data);
                }
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.1 */
        class C02991 implements Runnable {
            final /* synthetic */ IHdmiControlCallback val$callback;
            final /* synthetic */ int val$deviceId;

            C02991(IHdmiControlCallback iHdmiControlCallback, int i) {
                this.val$callback = iHdmiControlCallback;
                this.val$deviceId = i;
            }

            public void run() {
                if (this.val$callback == null) {
                    Slog.e(HdmiControlService.TAG, "Callback cannot be null");
                    return;
                }
                HdmiCecLocalDeviceTv tv = HdmiControlService.this.tv();
                if (tv == null) {
                    Slog.w(HdmiControlService.TAG, "Local tv device not available");
                    HdmiControlService.this.invokeCallback(this.val$callback, HdmiControlService.INITIATED_BY_SCREEN_ON);
                    return;
                }
                HdmiMhlLocalDeviceStub device = HdmiControlService.this.mMhlController.getLocalDeviceById(this.val$deviceId);
                if (device == null) {
                    tv.deviceSelect(this.val$deviceId, this.val$callback);
                } else if (device.getPortId() == tv.getActivePortId()) {
                    HdmiControlService.this.invokeCallback(this.val$callback, HdmiControlService.INITIATED_BY_ENABLE_CEC);
                } else {
                    device.turnOn(this.val$callback);
                    tv.doManualPortSwitching(device.getPortId(), null);
                }
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.2 */
        class C03002 implements Runnable {
            final /* synthetic */ IHdmiControlCallback val$callback;
            final /* synthetic */ int val$portId;

            C03002(IHdmiControlCallback iHdmiControlCallback, int i) {
                this.val$callback = iHdmiControlCallback;
                this.val$portId = i;
            }

            public void run() {
                if (this.val$callback == null) {
                    Slog.e(HdmiControlService.TAG, "Callback cannot be null");
                    return;
                }
                HdmiCecLocalDeviceTv tv = HdmiControlService.this.tv();
                if (tv == null) {
                    Slog.w(HdmiControlService.TAG, "Local tv device not available");
                    HdmiControlService.this.invokeCallback(this.val$callback, HdmiControlService.INITIATED_BY_SCREEN_ON);
                    return;
                }
                tv.doManualPortSwitching(this.val$portId, this.val$callback);
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.3 */
        class C03013 implements Runnable {
            final /* synthetic */ int val$deviceType;
            final /* synthetic */ boolean val$isPressed;
            final /* synthetic */ int val$keyCode;

            C03013(int i, boolean z, int i2) {
                this.val$keyCode = i;
                this.val$isPressed = z;
                this.val$deviceType = i2;
            }

            public void run() {
                HdmiMhlLocalDeviceStub device = HdmiControlService.this.mMhlController.getLocalDevice(HdmiControlService.this.mActivePortId);
                if (device != null) {
                    device.sendKeyEvent(this.val$keyCode, this.val$isPressed);
                } else if (HdmiControlService.this.mCecController != null) {
                    HdmiCecLocalDevice localDevice = HdmiControlService.this.mCecController.getLocalDevice(this.val$deviceType);
                    if (localDevice == null) {
                        Slog.w(HdmiControlService.TAG, "Local device not available");
                    } else {
                        localDevice.sendKeyEvent(this.val$keyCode, this.val$isPressed);
                    }
                }
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.4 */
        class C03024 implements Runnable {
            final /* synthetic */ IHdmiControlCallback val$callback;

            C03024(IHdmiControlCallback iHdmiControlCallback) {
                this.val$callback = iHdmiControlCallback;
            }

            public void run() {
                HdmiControlService.this.oneTouchPlay(this.val$callback);
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.5 */
        class C03035 implements Runnable {
            final /* synthetic */ IHdmiControlCallback val$callback;

            C03035(IHdmiControlCallback iHdmiControlCallback) {
                this.val$callback = iHdmiControlCallback;
            }

            public void run() {
                HdmiControlService.this.queryDisplayStatus(this.val$callback);
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.6 */
        class C03046 implements Runnable {
            final /* synthetic */ IHdmiControlCallback val$callback;
            final /* synthetic */ boolean val$enabled;

            C03046(IHdmiControlCallback iHdmiControlCallback, boolean z) {
                this.val$callback = iHdmiControlCallback;
                this.val$enabled = z;
            }

            public void run() {
                HdmiCecLocalDeviceTv tv = HdmiControlService.this.tv();
                if (tv == null) {
                    Slog.w(HdmiControlService.TAG, "Local tv device not available");
                    HdmiControlService.this.invokeCallback(this.val$callback, HdmiControlService.INITIATED_BY_SCREEN_ON);
                    return;
                }
                tv.changeSystemAudioMode(this.val$enabled, this.val$callback);
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.7 */
        class C03057 implements Runnable {
            final /* synthetic */ int val$maxIndex;
            final /* synthetic */ int val$newIndex;
            final /* synthetic */ int val$oldIndex;

            C03057(int i, int i2, int i3) {
                this.val$oldIndex = i;
                this.val$newIndex = i2;
                this.val$maxIndex = i3;
            }

            public void run() {
                HdmiCecLocalDeviceTv tv = HdmiControlService.this.tv();
                if (tv == null) {
                    Slog.w(HdmiControlService.TAG, "Local tv device not available");
                } else {
                    tv.changeVolume(this.val$oldIndex, this.val$newIndex - this.val$oldIndex, this.val$maxIndex);
                }
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.8 */
        class C03068 implements Runnable {
            final /* synthetic */ boolean val$mute;

            C03068(boolean z) {
                this.val$mute = z;
            }

            public void run() {
                HdmiCecLocalDeviceTv tv = HdmiControlService.this.tv();
                if (tv == null) {
                    Slog.w(HdmiControlService.TAG, "Local tv device not available");
                } else {
                    tv.changeMute(this.val$mute);
                }
            }
        }

        /* renamed from: com.android.server.hdmi.HdmiControlService.BinderService.9 */
        class C03079 implements Runnable {
            C03079() {
            }

            public void run() {
                if (HdmiControlService.this.tv() == null) {
                    Slog.w(HdmiControlService.TAG, "Local tv device not available to change arc mode.");
                }
            }
        }

        private BinderService() {
        }

        public int[] getSupportedTypes() {
            HdmiControlService.this.enforceAccessPermission();
            int[] localDevices = new int[HdmiControlService.this.mLocalDevices.size()];
            for (int i = HdmiControlService.INITIATED_BY_ENABLE_CEC; i < localDevices.length; i += HdmiControlService.INITIATED_BY_BOOT_UP) {
                localDevices[i] = ((Integer) HdmiControlService.this.mLocalDevices.get(i)).intValue();
            }
            return localDevices;
        }

        public HdmiDeviceInfo getActiveSource() {
            HdmiControlService.this.enforceAccessPermission();
            HdmiCecLocalDeviceTv tv = HdmiControlService.this.tv();
            if (tv == null) {
                Slog.w(HdmiControlService.TAG, "Local tv device not available");
                return null;
            }
            ActiveSource activeSource = tv.getActiveSource();
            if (activeSource.isValid()) {
                return new HdmiDeviceInfo(activeSource.logicalAddress, activeSource.physicalAddress, -1, -1, HdmiControlService.INITIATED_BY_ENABLE_CEC, "");
            }
            int activePath = tv.getActivePath();
            if (activePath == 65535) {
                return null;
            }
            HdmiDeviceInfo info = tv.getSafeDeviceInfoByPath(activePath);
            if (info == null) {
                info = new HdmiDeviceInfo(activePath, tv.getActivePortId());
            }
            return info;
        }

        public void deviceSelect(int deviceId, IHdmiControlCallback callback) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new C02991(callback, deviceId));
        }

        public void portSelect(int portId, IHdmiControlCallback callback) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new C03002(callback, portId));
        }

        public void sendKeyEvent(int deviceType, int keyCode, boolean isPressed) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new C03013(keyCode, isPressed, deviceType));
        }

        public void oneTouchPlay(IHdmiControlCallback callback) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new C03024(callback));
        }

        public void queryDisplayStatus(IHdmiControlCallback callback) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new C03035(callback));
        }

        public void addHotplugEventListener(IHdmiHotplugEventListener listener) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.addHotplugEventListener(listener);
        }

        public void removeHotplugEventListener(IHdmiHotplugEventListener listener) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.removeHotplugEventListener(listener);
        }

        public void addDeviceEventListener(IHdmiDeviceEventListener listener) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.addDeviceEventListener(listener);
        }

        public List<HdmiPortInfo> getPortInfo() {
            HdmiControlService.this.enforceAccessPermission();
            return HdmiControlService.this.getPortInfo();
        }

        public boolean canChangeSystemAudioMode() {
            HdmiControlService.this.enforceAccessPermission();
            HdmiCecLocalDeviceTv tv = HdmiControlService.this.tv();
            if (tv == null) {
                return false;
            }
            return tv.hasSystemAudioDevice();
        }

        public boolean getSystemAudioMode() {
            HdmiControlService.this.enforceAccessPermission();
            HdmiCecLocalDeviceTv tv = HdmiControlService.this.tv();
            if (tv == null) {
                return false;
            }
            return tv.isSystemAudioActivated();
        }

        public void setSystemAudioMode(boolean enabled, IHdmiControlCallback callback) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new C03046(callback, enabled));
        }

        public void addSystemAudioModeChangeListener(IHdmiSystemAudioModeChangeListener listener) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.addSystemAudioModeChangeListner(listener);
        }

        public void removeSystemAudioModeChangeListener(IHdmiSystemAudioModeChangeListener listener) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.removeSystemAudioModeChangeListener(listener);
        }

        public void setInputChangeListener(IHdmiInputChangeListener listener) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.setInputChangeListener(listener);
        }

        public List<HdmiDeviceInfo> getInputDevices() {
            List<HdmiDeviceInfo> mergeToUnmodifiableList;
            HdmiControlService.this.enforceAccessPermission();
            HdmiCecLocalDeviceTv tv = HdmiControlService.this.tv();
            synchronized (HdmiControlService.this.mLock) {
                mergeToUnmodifiableList = HdmiUtils.mergeToUnmodifiableList(tv == null ? Collections.emptyList() : tv.getSafeExternalInputsLocked(), HdmiControlService.this.getMhlDevicesLocked());
            }
            return mergeToUnmodifiableList;
        }

        public List<HdmiDeviceInfo> getDeviceList() {
            List<HdmiDeviceInfo> emptyList;
            HdmiControlService.this.enforceAccessPermission();
            HdmiCecLocalDeviceTv tv = HdmiControlService.this.tv();
            synchronized (HdmiControlService.this.mLock) {
                emptyList = tv == null ? Collections.emptyList() : tv.getSafeCecDevicesLocked();
            }
            return emptyList;
        }

        public void setSystemAudioVolume(int oldIndex, int newIndex, int maxIndex) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new C03057(oldIndex, newIndex, maxIndex));
        }

        public void setSystemAudioMute(boolean mute) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new C03068(mute));
        }

        public void setArcMode(boolean enabled) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new C03079());
        }

        public void setProhibitMode(boolean enabled) {
            HdmiControlService.this.enforceAccessPermission();
            if (HdmiControlService.this.isTvDevice()) {
                HdmiControlService.this.setProhibitMode(enabled);
            }
        }

        public void addVendorCommandListener(IHdmiVendorCommandListener listener, int deviceType) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.addVendorCommandListener(listener, deviceType);
        }

        public void sendVendorCommand(int deviceType, int targetAddress, byte[] params, boolean hasVendorId) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new AnonymousClass10(deviceType, hasVendorId, targetAddress, params));
        }

        public void sendStandby(int deviceType, int deviceId) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new AnonymousClass11(deviceId, deviceType));
        }

        public void setHdmiRecordListener(IHdmiRecordListener listener) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.setHdmiRecordListener(listener);
        }

        public void startOneTouchRecord(int recorderAddress, byte[] recordSource) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new AnonymousClass12(recorderAddress, recordSource));
        }

        public void stopOneTouchRecord(int recorderAddress) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new AnonymousClass13(recorderAddress));
        }

        public void startTimerRecording(int recorderAddress, int sourceType, byte[] recordSource) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new AnonymousClass14(recorderAddress, sourceType, recordSource));
        }

        public void clearTimerRecording(int recorderAddress, int sourceType, byte[] recordSource) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new AnonymousClass15(recorderAddress, sourceType, recordSource));
        }

        public void sendMhlVendorCommand(int portId, int offset, int length, byte[] data) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.runOnServiceThread(new AnonymousClass16(portId, offset, length, data));
        }

        public void addHdmiMhlVendorCommandListener(IHdmiMhlVendorCommandListener listener) {
            HdmiControlService.this.enforceAccessPermission();
            HdmiControlService.this.addHdmiMhlVendorCommandListener(listener);
        }

        protected void dump(FileDescriptor fd, PrintWriter writer, String[] args) {
            HdmiControlService.this.getContext().enforceCallingOrSelfPermission("android.permission.DUMP", HdmiControlService.TAG);
            IndentingPrintWriter pw = new IndentingPrintWriter(writer, "  ");
            pw.println("mHdmiControlEnabled: " + HdmiControlService.this.mHdmiControlEnabled);
            pw.println("mProhibitMode: " + HdmiControlService.this.mProhibitMode);
            if (HdmiControlService.this.mCecController != null) {
                pw.println("mCecController: ");
                pw.increaseIndent();
                HdmiControlService.this.mCecController.dump(pw);
                pw.decreaseIndent();
            }
            pw.println("mMhlController: ");
            pw.increaseIndent();
            HdmiControlService.this.mMhlController.dump(pw);
            pw.decreaseIndent();
            pw.println("mPortInfo: ");
            pw.increaseIndent();
            for (HdmiPortInfo hdmiPortInfo : HdmiControlService.this.mPortInfo) {
                pw.println("- " + hdmiPortInfo);
            }
            pw.decreaseIndent();
            pw.println("mPowerStatus: " + HdmiControlService.this.mPowerStatus);
        }
    }

    private final class CecMessageBuffer {
        private List<HdmiCecMessage> mBuffer;

        /* renamed from: com.android.server.hdmi.HdmiControlService.CecMessageBuffer.1 */
        class C03081 implements Runnable {
            final /* synthetic */ HdmiCecMessage val$message;

            C03081(HdmiCecMessage hdmiCecMessage) {
                this.val$message = hdmiCecMessage;
            }

            public void run() {
                HdmiControlService.this.handleCecCommand(this.val$message);
            }
        }

        private CecMessageBuffer() {
            this.mBuffer = new ArrayList();
        }

        public void bufferMessage(HdmiCecMessage message) {
            switch (message.getOpcode()) {
                case HdmiControlService.INITIATED_BY_HOTPLUG /*4*/:
                case C0569H.APP_TRANSITION_TIMEOUT /*13*/:
                    bufferImageOrTextViewOn(message);
                case 130:
                    bufferActiveSource(message);
                default:
            }
        }

        public void processMessages() {
            for (HdmiCecMessage message : this.mBuffer) {
                HdmiControlService.this.runOnServiceThread(new C03081(message));
            }
            this.mBuffer.clear();
        }

        private void bufferActiveSource(HdmiCecMessage message) {
            if (!replaceMessageIfBuffered(message, 130)) {
                this.mBuffer.add(message);
            }
        }

        private void bufferImageOrTextViewOn(HdmiCecMessage message) {
            if (!replaceMessageIfBuffered(message, HdmiControlService.INITIATED_BY_HOTPLUG) && !replaceMessageIfBuffered(message, 13)) {
                this.mBuffer.add(message);
            }
        }

        private boolean replaceMessageIfBuffered(HdmiCecMessage message, int opcode) {
            for (int i = HdmiControlService.INITIATED_BY_ENABLE_CEC; i < this.mBuffer.size(); i += HdmiControlService.INITIATED_BY_BOOT_UP) {
                if (((HdmiCecMessage) this.mBuffer.get(i)).getOpcode() == opcode) {
                    this.mBuffer.set(i, message);
                    return true;
                }
            }
            return false;
        }
    }

    private final class DeviceEventListenerRecord implements DeathRecipient {
        private final IHdmiDeviceEventListener mListener;

        public DeviceEventListenerRecord(IHdmiDeviceEventListener listener) {
            this.mListener = listener;
        }

        public void binderDied() {
            synchronized (HdmiControlService.this.mLock) {
                HdmiControlService.this.mDeviceEventListenerRecords.remove(this);
            }
        }
    }

    private class HdmiControlBroadcastReceiver extends BroadcastReceiver {
        private HdmiControlBroadcastReceiver() {
        }

        @ServiceThreadOnly
        public void onReceive(Context context, Intent intent) {
            HdmiControlService.this.assertRunOnServiceThread();
            String action = intent.getAction();
            Object obj = -1;
            switch (action.hashCode()) {
                case -2128145023:
                    if (action.equals("android.intent.action.SCREEN_OFF")) {
                        obj = null;
                        break;
                    }
                    break;
                case -1454123155:
                    if (action.equals("android.intent.action.SCREEN_ON")) {
                        obj = HdmiControlService.INITIATED_BY_BOOT_UP;
                        break;
                    }
                    break;
                case 158859398:
                    if (action.equals("android.intent.action.CONFIGURATION_CHANGED")) {
                        obj = HdmiControlService.INITIATED_BY_SCREEN_ON;
                        break;
                    }
                    break;
            }
            switch (obj) {
                case HdmiControlService.INITIATED_BY_ENABLE_CEC /*0*/:
                    if (HdmiControlService.this.isPowerOnOrTransient()) {
                        HdmiControlService.this.onStandby();
                    }
                case HdmiControlService.INITIATED_BY_BOOT_UP /*1*/:
                    if (HdmiControlService.this.isPowerStandbyOrTransient()) {
                        HdmiControlService.this.onWakeUp();
                    }
                case HdmiControlService.INITIATED_BY_SCREEN_ON /*2*/:
                    String language = getMenuLanguage();
                    if (!HdmiControlService.this.mLanguage.equals(language)) {
                        HdmiControlService.this.onLanguageChanged(language);
                    }
                default:
            }
        }

        private String getMenuLanguage() {
            Locale locale = Locale.getDefault();
            if (locale.equals(Locale.TAIWAN) || locale.equals(HdmiControlService.this.HONG_KONG) || locale.equals(HdmiControlService.this.MACAU)) {
                return "chi";
            }
            return locale.getISO3Language();
        }
    }

    private class HdmiMhlVendorCommandListenerRecord implements DeathRecipient {
        private final IHdmiMhlVendorCommandListener mListener;

        public HdmiMhlVendorCommandListenerRecord(IHdmiMhlVendorCommandListener listener) {
            this.mListener = listener;
        }

        public void binderDied() {
            HdmiControlService.this.mMhlVendorCommandListenerRecords.remove(this);
        }
    }

    private class HdmiRecordListenerRecord implements DeathRecipient {
        private final IHdmiRecordListener mListener;

        public HdmiRecordListenerRecord(IHdmiRecordListener listener) {
            this.mListener = listener;
        }

        public void binderDied() {
            synchronized (HdmiControlService.this.mLock) {
                HdmiControlService.this.mRecordListenerRecord = null;
            }
        }
    }

    private final class HotplugEventListenerRecord implements DeathRecipient {
        private final IHdmiHotplugEventListener mListener;

        public HotplugEventListenerRecord(IHdmiHotplugEventListener listener) {
            this.mListener = listener;
        }

        public void binderDied() {
            synchronized (HdmiControlService.this.mLock) {
                HdmiControlService.this.mHotplugEventListenerRecords.remove(this);
            }
        }

        public boolean equals(Object obj) {
            if (!(obj instanceof HotplugEventListenerRecord)) {
                return false;
            }
            if (obj == this || ((HotplugEventListenerRecord) obj).mListener == this.mListener) {
                return true;
            }
            return false;
        }

        public int hashCode() {
            return this.mListener.hashCode();
        }
    }

    private final class InputChangeListenerRecord implements DeathRecipient {
        private final IHdmiInputChangeListener mListener;

        public InputChangeListenerRecord(IHdmiInputChangeListener listener) {
            this.mListener = listener;
        }

        public void binderDied() {
            synchronized (HdmiControlService.this.mLock) {
                HdmiControlService.this.mInputChangeListenerRecord = null;
            }
        }
    }

    private class SettingsObserver extends ContentObserver {
        public SettingsObserver(Handler handler) {
            super(handler);
        }

        public void onChange(boolean selfChange, Uri uri) {
            String option = uri.getLastPathSegment();
            boolean enabled = HdmiControlService.this.readBooleanSetting(option, true);
            boolean z = true;
            switch (option.hashCode()) {
                case -2009736264:
                    if (option.equals("hdmi_control_enabled")) {
                        z = false;
                        break;
                    }
                    break;
                case -1262529811:
                    if (option.equals("mhl_input_switching_enabled")) {
                        z = true;
                        break;
                    }
                    break;
                case -885757826:
                    if (option.equals("mhl_power_charge_enabled")) {
                        z = true;
                        break;
                    }
                    break;
                case 726613192:
                    if (option.equals("hdmi_control_auto_wakeup_enabled")) {
                        z = true;
                        break;
                    }
                    break;
                case 1628046095:
                    if (option.equals("hdmi_control_auto_device_off_enabled")) {
                        z = true;
                        break;
                    }
                    break;
            }
            switch (z) {
                case HdmiControlService.INITIATED_BY_ENABLE_CEC /*0*/:
                    HdmiControlService.this.setControlEnabled(enabled);
                case HdmiControlService.INITIATED_BY_BOOT_UP /*1*/:
                    if (HdmiControlService.this.isTvDeviceEnabled()) {
                        HdmiControlService.this.tv().setAutoWakeup(enabled);
                    }
                    HdmiControlService.this.setCecOption(HdmiControlService.INITIATED_BY_BOOT_UP, HdmiControlService.toInt(enabled));
                case HdmiControlService.INITIATED_BY_SCREEN_ON /*2*/:
                    if (HdmiControlService.this.isTvDeviceEnabled()) {
                        HdmiControlService.this.tv().setAutoDeviceOff(enabled);
                    }
                case HdmiControlService.INITIATED_BY_WAKE_UP_MESSAGE /*3*/:
                    HdmiControlService.this.setMhlInputChangeEnabled(enabled);
                case HdmiControlService.INITIATED_BY_HOTPLUG /*4*/:
                    HdmiControlService.this.mMhlController.setOption(HdmiCecKeycode.CEC_KEYCODE_RESTORE_VOLUME_FUNCTION, HdmiControlService.toInt(enabled));
                default:
            }
        }
    }

    private final class SystemAudioModeChangeListenerRecord implements DeathRecipient {
        private final IHdmiSystemAudioModeChangeListener mListener;

        public SystemAudioModeChangeListenerRecord(IHdmiSystemAudioModeChangeListener listener) {
            this.mListener = listener;
        }

        public void binderDied() {
            synchronized (HdmiControlService.this.mLock) {
                HdmiControlService.this.mSystemAudioModeChangeListenerRecords.remove(this);
            }
        }
    }

    class VendorCommandListenerRecord implements DeathRecipient {
        private final int mDeviceType;
        private final IHdmiVendorCommandListener mListener;

        public VendorCommandListenerRecord(IHdmiVendorCommandListener listener, int deviceType) {
            this.mListener = listener;
            this.mDeviceType = deviceType;
        }

        public void binderDied() {
            synchronized (HdmiControlService.this.mLock) {
                HdmiControlService.this.mVendorCommandListenerRecords.remove(this);
            }
        }
    }

    public HdmiControlService(Context context) {
        super(context);
        this.HONG_KONG = new Locale("zh", "HK");
        this.MACAU = new Locale("zh", "MO");
        this.mIoThread = new HandlerThread("Hdmi Control Io Thread");
        this.mLock = new Object();
        this.mHotplugEventListenerRecords = new ArrayList();
        this.mDeviceEventListenerRecords = new ArrayList();
        this.mVendorCommandListenerRecords = new ArrayList();
        this.mSystemAudioModeChangeListenerRecords = new ArrayList();
        this.mHandler = new Handler();
        this.mHdmiControlBroadcastReceiver = new HdmiControlBroadcastReceiver();
        this.mPowerStatus = INITIATED_BY_BOOT_UP;
        this.mLanguage = Locale.getDefault().getISO3Language();
        this.mStandbyMessageReceived = false;
        this.mWakeUpMessageReceived = false;
        this.mActivePortId = -1;
        this.mMhlVendorCommandListenerRecords = new ArrayList();
        this.mLastInputMhl = -1;
        this.mAddressAllocated = false;
        this.mCecMessageBuffer = new CecMessageBuffer();
        this.mLocalDevices = getIntList(SystemProperties.get("ro.hdmi.device_type"));
        this.mSettingsObserver = new SettingsObserver(this.mHandler);
    }

    private static List<Integer> getIntList(String string) {
        ArrayList<Integer> list = new ArrayList();
        SimpleStringSplitter splitter = new SimpleStringSplitter(',');
        splitter.setString(string);
        Iterator i$ = splitter.iterator();
        while (i$.hasNext()) {
            String item = (String) i$.next();
            try {
                list.add(Integer.valueOf(Integer.parseInt(item)));
            } catch (NumberFormatException e) {
                Slog.w(TAG, "Can't parseInt: " + item);
            }
        }
        return Collections.unmodifiableList(list);
    }

    public void onStart() {
        this.mIoThread.start();
        this.mPowerStatus = INITIATED_BY_SCREEN_ON;
        this.mProhibitMode = false;
        this.mHdmiControlEnabled = readBooleanSetting("hdmi_control_enabled", true);
        this.mMhlInputChangeEnabled = readBooleanSetting("mhl_input_switching_enabled", true);
        this.mCecController = HdmiCecController.create(this);
        if (this.mCecController != null) {
            this.mCecController.setOption(INITIATED_BY_SCREEN_ON, INITIATED_BY_BOOT_UP);
            if (this.mHdmiControlEnabled) {
                initializeCec(INITIATED_BY_BOOT_UP);
            }
            this.mMhlController = HdmiMhlControllerStub.create(this);
            if (!this.mMhlController.isReady()) {
                Slog.i(TAG, "Device does not support MHL-control.");
            }
            this.mMhlDevices = Collections.emptyList();
            initPortInfo();
            this.mMessageValidator = new HdmiCecMessageValidator(this);
            publishBinderService("hdmi_control", new BinderService());
            if (this.mCecController != null) {
                IntentFilter filter = new IntentFilter();
                filter.addAction("android.intent.action.SCREEN_OFF");
                filter.addAction("android.intent.action.SCREEN_ON");
                filter.addAction("android.intent.action.CONFIGURATION_CHANGED");
                getContext().registerReceiver(this.mHdmiControlBroadcastReceiver, filter);
                registerContentObserver();
            }
            this.mMhlController.setOption(HdmiCecKeycode.CEC_KEYCODE_SELECT_MEDIA_FUNCTION, INITIATED_BY_BOOT_UP);
            return;
        }
        Slog.i(TAG, "Device does not support HDMI-CEC.");
    }

    public void onBootPhase(int phase) {
        if (phase == SystemService.PHASE_SYSTEM_SERVICES_READY) {
            this.mTvInputManager = (TvInputManager) getContext().getSystemService("tv_input");
            this.mPowerManager = (PowerManager) getContext().getSystemService("power");
        }
    }

    TvInputManager getTvInputManager() {
        return this.mTvInputManager;
    }

    void registerTvInputCallback(TvInputCallback callback) {
        if (this.mTvInputManager != null) {
            this.mTvInputManager.registerCallback(callback, this.mHandler);
        }
    }

    void unregisterTvInputCallback(TvInputCallback callback) {
        if (this.mTvInputManager != null) {
            this.mTvInputManager.unregisterCallback(callback);
        }
    }

    PowerManager getPowerManager() {
        return this.mPowerManager;
    }

    private void onInitializeCecComplete(int initiatedBy) {
        if (this.mPowerStatus == INITIATED_BY_SCREEN_ON) {
            this.mPowerStatus = INITIATED_BY_ENABLE_CEC;
        }
        this.mWakeUpMessageReceived = false;
        if (isTvDeviceEnabled()) {
            this.mCecController.setOption(INITIATED_BY_BOOT_UP, toInt(tv().getAutoWakeup()));
        }
        int reason = -1;
        switch (initiatedBy) {
            case INITIATED_BY_ENABLE_CEC /*0*/:
                reason = INITIATED_BY_BOOT_UP;
                break;
            case INITIATED_BY_BOOT_UP /*1*/:
                reason = INITIATED_BY_ENABLE_CEC;
                break;
            case INITIATED_BY_SCREEN_ON /*2*/:
            case INITIATED_BY_WAKE_UP_MESSAGE /*3*/:
                reason = INITIATED_BY_SCREEN_ON;
                break;
        }
        if (reason != -1) {
            invokeVendorCommandListenersOnControlStateChanged(true, reason);
        }
    }

    private void registerContentObserver() {
        ContentResolver resolver = getContext().getContentResolver();
        String[] arr$ = new String[]{"hdmi_control_enabled", "hdmi_control_auto_wakeup_enabled", "hdmi_control_auto_device_off_enabled", "mhl_input_switching_enabled", "mhl_power_charge_enabled"};
        int len$ = arr$.length;
        for (int i$ = INITIATED_BY_ENABLE_CEC; i$ < len$; i$ += INITIATED_BY_BOOT_UP) {
            resolver.registerContentObserver(Global.getUriFor(arr$[i$]), false, this.mSettingsObserver, -1);
        }
    }

    private static int toInt(boolean enabled) {
        return enabled ? INITIATED_BY_BOOT_UP : INITIATED_BY_ENABLE_CEC;
    }

    boolean readBooleanSetting(String key, boolean defVal) {
        if (Global.getInt(getContext().getContentResolver(), key, toInt(defVal)) == INITIATED_BY_BOOT_UP) {
            return true;
        }
        return false;
    }

    void writeBooleanSetting(String key, boolean value) {
        Global.putInt(getContext().getContentResolver(), key, toInt(value));
    }

    private void initializeCec(int initiatedBy) {
        this.mAddressAllocated = false;
        this.mCecController.setOption(INITIATED_BY_WAKE_UP_MESSAGE, INITIATED_BY_BOOT_UP);
        this.mCecController.setOption(5, HdmiUtils.languageToInt(this.mLanguage));
        initializeLocalDevices(initiatedBy);
    }

    @ServiceThreadOnly
    private void initializeLocalDevices(int initiatedBy) {
        assertRunOnServiceThread();
        ArrayList<HdmiCecLocalDevice> localDevices = new ArrayList();
        for (Integer intValue : this.mLocalDevices) {
            int type = intValue.intValue();
            HdmiCecLocalDevice localDevice = this.mCecController.getLocalDevice(type);
            if (localDevice == null) {
                localDevice = HdmiCecLocalDevice.create(this, type);
            }
            localDevice.init();
            localDevices.add(localDevice);
        }
        clearLocalDevices();
        allocateLogicalAddress(localDevices, initiatedBy);
    }

    @ServiceThreadOnly
    private void allocateLogicalAddress(ArrayList<HdmiCecLocalDevice> allocatingDevices, int initiatedBy) {
        assertRunOnServiceThread();
        this.mCecController.clearLogicalAddress();
        ArrayList<HdmiCecLocalDevice> allocatedDevices = new ArrayList();
        int[] finished = new int[INITIATED_BY_BOOT_UP];
        this.mAddressAllocated = allocatingDevices.isEmpty();
        Iterator i$ = allocatingDevices.iterator();
        while (i$.hasNext()) {
            HdmiCecLocalDevice localDevice = (HdmiCecLocalDevice) i$.next();
            this.mCecController.allocateLogicalAddress(localDevice.getType(), localDevice.getPreferredAddress(), new C02921(localDevice, allocatedDevices, allocatingDevices, finished, initiatedBy));
        }
    }

    @ServiceThreadOnly
    private void notifyAddressAllocated(ArrayList<HdmiCecLocalDevice> devices, int initiatedBy) {
        assertRunOnServiceThread();
        Iterator i$ = devices.iterator();
        while (i$.hasNext()) {
            HdmiCecLocalDevice device = (HdmiCecLocalDevice) i$.next();
            device.handleAddressAllocated(device.getDeviceInfo().getLogicalAddress(), initiatedBy);
        }
    }

    @ServiceThreadOnly
    private void initPortInfo() {
        assertRunOnServiceThread();
        HdmiPortInfo[] cecPortInfo = null;
        if (this.mCecController != null) {
            cecPortInfo = this.mCecController.getPortInfos();
        }
        if (cecPortInfo != null) {
            int i$;
            HdmiPortInfo info;
            SparseArray<HdmiPortInfo> portInfoMap = new SparseArray();
            SparseIntArray portIdMap = new SparseIntArray();
            SparseArray<HdmiDeviceInfo> portDeviceMap = new SparseArray();
            HdmiPortInfo[] arr$ = cecPortInfo;
            int len$ = arr$.length;
            for (i$ = INITIATED_BY_ENABLE_CEC; i$ < len$; i$ += INITIATED_BY_BOOT_UP) {
                info = arr$[i$];
                portIdMap.put(info.getAddress(), info.getId());
                portInfoMap.put(info.getId(), info);
                portDeviceMap.put(info.getId(), new HdmiDeviceInfo(info.getAddress(), info.getId()));
            }
            this.mPortIdMap = new UnmodifiableSparseIntArray(portIdMap);
            this.mPortInfoMap = new UnmodifiableSparseArray(portInfoMap);
            this.mPortDeviceMap = new UnmodifiableSparseArray(portDeviceMap);
            HdmiPortInfo[] mhlPortInfo = this.mMhlController.getPortInfos();
            ArraySet<Integer> mhlSupportedPorts = new ArraySet(mhlPortInfo.length);
            arr$ = mhlPortInfo;
            len$ = arr$.length;
            for (i$ = INITIATED_BY_ENABLE_CEC; i$ < len$; i$ += INITIATED_BY_BOOT_UP) {
                info = arr$[i$];
                if (info.isMhlSupported()) {
                    mhlSupportedPorts.add(Integer.valueOf(info.getId()));
                }
            }
            if (mhlSupportedPorts.isEmpty()) {
                this.mPortInfo = Collections.unmodifiableList(Arrays.asList(cecPortInfo));
                return;
            }
            ArrayList<HdmiPortInfo> arrayList = new ArrayList(cecPortInfo.length);
            arr$ = cecPortInfo;
            len$ = arr$.length;
            for (i$ = INITIATED_BY_ENABLE_CEC; i$ < len$; i$ += INITIATED_BY_BOOT_UP) {
                info = arr$[i$];
                if (mhlSupportedPorts.contains(Integer.valueOf(info.getId()))) {
                    arrayList.add(new HdmiPortInfo(info.getId(), info.getType(), info.getAddress(), info.isCecSupported(), true, info.isArcSupported()));
                } else {
                    arrayList.add(info);
                }
            }
            this.mPortInfo = Collections.unmodifiableList(arrayList);
        }
    }

    List<HdmiPortInfo> getPortInfo() {
        return this.mPortInfo;
    }

    HdmiPortInfo getPortInfo(int portId) {
        return (HdmiPortInfo) this.mPortInfoMap.get(portId, null);
    }

    int portIdToPath(int portId) {
        HdmiPortInfo portInfo = getPortInfo(portId);
        if (portInfo != null) {
            return portInfo.getAddress();
        }
        Slog.e(TAG, "Cannot find the port info: " + portId);
        return 65535;
    }

    int pathToPortId(int path) {
        return this.mPortIdMap.get(path & 61440, -1);
    }

    boolean isValidPortId(int portId) {
        return getPortInfo(portId) != null;
    }

    Looper getIoLooper() {
        return this.mIoThread.getLooper();
    }

    Looper getServiceLooper() {
        return this.mHandler.getLooper();
    }

    int getPhysicalAddress() {
        return this.mCecController.getPhysicalAddress();
    }

    int getVendorId() {
        return this.mCecController.getVendorId();
    }

    @ServiceThreadOnly
    HdmiDeviceInfo getDeviceInfo(int logicalAddress) {
        assertRunOnServiceThread();
        return tv() == null ? null : tv().getCecDeviceInfo(logicalAddress);
    }

    @ServiceThreadOnly
    HdmiDeviceInfo getDeviceInfoByPort(int port) {
        assertRunOnServiceThread();
        HdmiMhlLocalDeviceStub info = this.mMhlController.getLocalDevice(port);
        if (info != null) {
            return info.getInfo();
        }
        return null;
    }

    int getCecVersion() {
        return this.mCecController.getVersion();
    }

    boolean isConnectedToArcPort(int physicalAddress) {
        int portId = pathToPortId(physicalAddress);
        if (portId != -1) {
            return ((HdmiPortInfo) this.mPortInfoMap.get(portId)).isArcSupported();
        }
        return false;
    }

    void runOnServiceThread(Runnable runnable) {
        this.mHandler.post(runnable);
    }

    void runOnServiceThreadAtFrontOfQueue(Runnable runnable) {
        this.mHandler.postAtFrontOfQueue(runnable);
    }

    private void assertRunOnServiceThread() {
        if (Looper.myLooper() != this.mHandler.getLooper()) {
            throw new IllegalStateException("Should run on service thread.");
        }
    }

    @ServiceThreadOnly
    void sendCecCommand(HdmiCecMessage command, SendMessageCallback callback) {
        assertRunOnServiceThread();
        if (this.mMessageValidator.isValid(command) == 0) {
            this.mCecController.sendCommand(command, callback);
            return;
        }
        HdmiLogger.error("Invalid message type:" + command, new Object[INITIATED_BY_ENABLE_CEC]);
        if (callback != null) {
            callback.onSendCompleted(INITIATED_BY_WAKE_UP_MESSAGE);
        }
    }

    @ServiceThreadOnly
    void sendCecCommand(HdmiCecMessage command) {
        assertRunOnServiceThread();
        sendCecCommand(command, null);
    }

    @ServiceThreadOnly
    void maySendFeatureAbortCommand(HdmiCecMessage command, int reason) {
        assertRunOnServiceThread();
        this.mCecController.maySendFeatureAbortCommand(command, reason);
    }

    @ServiceThreadOnly
    boolean handleCecCommand(HdmiCecMessage message) {
        assertRunOnServiceThread();
        if (this.mAddressAllocated) {
            int errorCode = this.mMessageValidator.isValid(message);
            if (errorCode == 0) {
                return dispatchMessageToLocalDevice(message);
            }
            if (errorCode != INITIATED_BY_WAKE_UP_MESSAGE) {
                return true;
            }
            maySendFeatureAbortCommand(message, INITIATED_BY_WAKE_UP_MESSAGE);
            return true;
        }
        this.mCecMessageBuffer.bufferMessage(message);
        return true;
    }

    void setAudioReturnChannel(int portId, boolean enabled) {
        this.mCecController.setAudioReturnChannel(portId, enabled);
    }

    @ServiceThreadOnly
    private boolean dispatchMessageToLocalDevice(HdmiCecMessage message) {
        assertRunOnServiceThread();
        for (HdmiCecLocalDevice device : this.mCecController.getLocalDeviceList()) {
            if (device.dispatchMessage(message) && message.getDestination() != 15) {
                return true;
            }
        }
        if (message.getDestination() == 15) {
            return false;
        }
        HdmiLogger.warning("Unhandled cec command:" + message, new Object[INITIATED_BY_ENABLE_CEC]);
        return false;
    }

    @ServiceThreadOnly
    void onHotplug(int portId, boolean connected) {
        assertRunOnServiceThread();
        if (connected && !isTvDevice()) {
            ArrayList<HdmiCecLocalDevice> localDevices = new ArrayList();
            for (Integer intValue : this.mLocalDevices) {
                int type = intValue.intValue();
                HdmiCecLocalDevice localDevice = this.mCecController.getLocalDevice(type);
                if (localDevice == null) {
                    localDevice = HdmiCecLocalDevice.create(this, type);
                    localDevice.init();
                }
                localDevices.add(localDevice);
            }
            allocateLogicalAddress(localDevices, INITIATED_BY_HOTPLUG);
        }
        for (HdmiCecLocalDevice device : this.mCecController.getLocalDeviceList()) {
            device.onHotplug(portId, connected);
        }
        announceHotplugEvent(portId, connected);
    }

    @ServiceThreadOnly
    void pollDevices(DevicePollingCallback callback, int sourceAddress, int pickStrategy, int retryCount) {
        assertRunOnServiceThread();
        this.mCecController.pollDevices(callback, sourceAddress, checkPollStrategy(pickStrategy), retryCount);
    }

    private int checkPollStrategy(int pickStrategy) {
        int strategy = pickStrategy & INITIATED_BY_WAKE_UP_MESSAGE;
        if (strategy == 0) {
            throw new IllegalArgumentException("Invalid poll strategy:" + pickStrategy);
        }
        int iterationStrategy = pickStrategy & 196608;
        if (iterationStrategy != 0) {
            return strategy | iterationStrategy;
        }
        throw new IllegalArgumentException("Invalid iteration strategy:" + pickStrategy);
    }

    List<HdmiCecLocalDevice> getAllLocalDevices() {
        assertRunOnServiceThread();
        return this.mCecController.getLocalDeviceList();
    }

    Object getServiceLock() {
        return this.mLock;
    }

    void setAudioStatus(boolean mute, int volume) {
        AudioManager audioManager = getAudioManager();
        boolean muted = audioManager.isStreamMute(INITIATED_BY_WAKE_UP_MESSAGE);
        if (!mute) {
            if (muted) {
                audioManager.setStreamMute(INITIATED_BY_WAKE_UP_MESSAGE, false);
            }
            audioManager.setStreamVolume(INITIATED_BY_WAKE_UP_MESSAGE, volume, 257);
        } else if (!muted) {
            audioManager.setStreamMute(INITIATED_BY_WAKE_UP_MESSAGE, true);
        }
    }

    void announceSystemAudioModeChange(boolean enabled) {
        synchronized (this.mLock) {
            Iterator i$ = this.mSystemAudioModeChangeListenerRecords.iterator();
            while (i$.hasNext()) {
                invokeSystemAudioModeChangeLocked(((SystemAudioModeChangeListenerRecord) i$.next()).mListener, enabled);
            }
        }
    }

    private HdmiDeviceInfo createDeviceInfo(int logicalAddress, int deviceType, int powerStatus) {
        return new HdmiDeviceInfo(logicalAddress, getPhysicalAddress(), pathToPortId(getPhysicalAddress()), deviceType, getVendorId(), Build.MODEL);
    }

    @ServiceThreadOnly
    void handleMhlHotplugEvent(int portId, boolean connected) {
        assertRunOnServiceThread();
        if (connected) {
            HdmiMhlLocalDeviceStub newDevice = new HdmiMhlLocalDeviceStub(this, portId);
            HdmiMhlLocalDeviceStub oldDevice = this.mMhlController.addLocalDevice(newDevice);
            if (oldDevice != null) {
                oldDevice.onDeviceRemoved();
                Slog.i(TAG, "Old device of port " + portId + " is removed");
            }
            invokeDeviceEventListeners(newDevice.getInfo(), INITIATED_BY_BOOT_UP);
            updateSafeMhlInput();
        } else {
            HdmiMhlLocalDeviceStub device = this.mMhlController.removeLocalDevice(portId);
            if (device != null) {
                device.onDeviceRemoved();
                invokeDeviceEventListeners(device.getInfo(), INITIATED_BY_SCREEN_ON);
                updateSafeMhlInput();
            } else {
                Slog.w(TAG, "No device to remove:[portId=" + portId);
            }
        }
        announceHotplugEvent(portId, connected);
    }

    @ServiceThreadOnly
    void handleMhlBusModeChanged(int portId, int busmode) {
        assertRunOnServiceThread();
        HdmiMhlLocalDeviceStub device = this.mMhlController.getLocalDevice(portId);
        if (device != null) {
            device.setBusMode(busmode);
        } else {
            Slog.w(TAG, "No mhl device exists for bus mode change[portId:" + portId + ", busmode:" + busmode + "]");
        }
    }

    @ServiceThreadOnly
    void handleMhlBusOvercurrent(int portId, boolean on) {
        assertRunOnServiceThread();
        HdmiMhlLocalDeviceStub device = this.mMhlController.getLocalDevice(portId);
        if (device != null) {
            device.onBusOvercurrentDetected(on);
        } else {
            Slog.w(TAG, "No mhl device exists for bus overcurrent event[portId:" + portId + "]");
        }
    }

    @ServiceThreadOnly
    void handleMhlDeviceStatusChanged(int portId, int adopterId, int deviceId) {
        assertRunOnServiceThread();
        HdmiMhlLocalDeviceStub device = this.mMhlController.getLocalDevice(portId);
        if (device != null) {
            device.setDeviceStatusChange(adopterId, deviceId);
        } else {
            Slog.w(TAG, "No mhl device exists for device status event[portId:" + portId + ", adopterId:" + adopterId + ", deviceId:" + deviceId + "]");
        }
    }

    @ServiceThreadOnly
    private void updateSafeMhlInput() {
        assertRunOnServiceThread();
        List<HdmiDeviceInfo> inputs = Collections.emptyList();
        SparseArray<HdmiMhlLocalDeviceStub> devices = this.mMhlController.getAllLocalDevices();
        for (int i = INITIATED_BY_ENABLE_CEC; i < devices.size(); i += INITIATED_BY_BOOT_UP) {
            HdmiMhlLocalDeviceStub device = (HdmiMhlLocalDeviceStub) devices.valueAt(i);
            if (device.getInfo() != null) {
                if (inputs.isEmpty()) {
                    inputs = new ArrayList();
                }
                inputs.add(device.getInfo());
            }
        }
        synchronized (this.mLock) {
            this.mMhlDevices = inputs;
        }
    }

    private List<HdmiDeviceInfo> getMhlDevicesLocked() {
        return this.mMhlDevices;
    }

    private void enforceAccessPermission() {
        getContext().enforceCallingOrSelfPermission(PERMISSION, TAG);
    }

    @ServiceThreadOnly
    private void oneTouchPlay(IHdmiControlCallback callback) {
        assertRunOnServiceThread();
        HdmiCecLocalDevicePlayback source = playback();
        if (source == null) {
            Slog.w(TAG, "Local playback device not available");
            invokeCallback(callback, INITIATED_BY_SCREEN_ON);
            return;
        }
        source.oneTouchPlay(callback);
    }

    @ServiceThreadOnly
    private void queryDisplayStatus(IHdmiControlCallback callback) {
        assertRunOnServiceThread();
        HdmiCecLocalDevicePlayback source = playback();
        if (source == null) {
            Slog.w(TAG, "Local playback device not available");
            invokeCallback(callback, INITIATED_BY_SCREEN_ON);
            return;
        }
        source.queryDisplayStatus(callback);
    }

    private void addHotplugEventListener(IHdmiHotplugEventListener listener) {
        HotplugEventListenerRecord record = new HotplugEventListenerRecord(listener);
        try {
            listener.asBinder().linkToDeath(record, INITIATED_BY_ENABLE_CEC);
            synchronized (this.mLock) {
                this.mHotplugEventListenerRecords.add(record);
            }
            runOnServiceThread(new C02932(record, listener));
        } catch (RemoteException e) {
            Slog.w(TAG, "Listener already died");
        }
    }

    private void removeHotplugEventListener(IHdmiHotplugEventListener listener) {
        synchronized (this.mLock) {
            Iterator i$ = this.mHotplugEventListenerRecords.iterator();
            while (i$.hasNext()) {
                HotplugEventListenerRecord record = (HotplugEventListenerRecord) i$.next();
                if (record.mListener.asBinder() == listener.asBinder()) {
                    listener.asBinder().unlinkToDeath(record, INITIATED_BY_ENABLE_CEC);
                    this.mHotplugEventListenerRecords.remove(record);
                    break;
                }
            }
        }
    }

    private void addDeviceEventListener(IHdmiDeviceEventListener listener) {
        DeviceEventListenerRecord record = new DeviceEventListenerRecord(listener);
        try {
            listener.asBinder().linkToDeath(record, INITIATED_BY_ENABLE_CEC);
            synchronized (this.mLock) {
                this.mDeviceEventListenerRecords.add(record);
            }
        } catch (RemoteException e) {
            Slog.w(TAG, "Listener already died");
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void invokeDeviceEventListeners(android.hardware.hdmi.HdmiDeviceInfo r8, int r9) {
        /*
        r7 = this;
        r4 = r7.mLock;
        monitor-enter(r4);
        r3 = r7.mDeviceEventListenerRecords;	 Catch:{ all -> 0x0037 }
        r1 = r3.iterator();	 Catch:{ all -> 0x0037 }
    L_0x0009:
        r3 = r1.hasNext();	 Catch:{ all -> 0x0037 }
        if (r3 == 0) goto L_0x003a;
    L_0x000f:
        r2 = r1.next();	 Catch:{ all -> 0x0037 }
        r2 = (com.android.server.hdmi.HdmiControlService.DeviceEventListenerRecord) r2;	 Catch:{ all -> 0x0037 }
        r3 = r2.mListener;	 Catch:{ RemoteException -> 0x001d }
        r3.onStatusChanged(r8, r9);	 Catch:{ RemoteException -> 0x001d }
        goto L_0x0009;
    L_0x001d:
        r0 = move-exception;
        r3 = "HdmiControlService";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0037 }
        r5.<init>();	 Catch:{ all -> 0x0037 }
        r6 = "Failed to report device event:";
        r5 = r5.append(r6);	 Catch:{ all -> 0x0037 }
        r5 = r5.append(r0);	 Catch:{ all -> 0x0037 }
        r5 = r5.toString();	 Catch:{ all -> 0x0037 }
        android.util.Slog.e(r3, r5);	 Catch:{ all -> 0x0037 }
        goto L_0x0009;
    L_0x0037:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0037 }
        throw r3;
    L_0x003a:
        monitor-exit(r4);	 Catch:{ all -> 0x0037 }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.hdmi.HdmiControlService.invokeDeviceEventListeners(android.hardware.hdmi.HdmiDeviceInfo, int):void");
    }

    private void addSystemAudioModeChangeListner(IHdmiSystemAudioModeChangeListener listener) {
        SystemAudioModeChangeListenerRecord record = new SystemAudioModeChangeListenerRecord(listener);
        try {
            listener.asBinder().linkToDeath(record, INITIATED_BY_ENABLE_CEC);
            synchronized (this.mLock) {
                this.mSystemAudioModeChangeListenerRecords.add(record);
            }
        } catch (RemoteException e) {
            Slog.w(TAG, "Listener already died");
        }
    }

    private void removeSystemAudioModeChangeListener(IHdmiSystemAudioModeChangeListener listener) {
        synchronized (this.mLock) {
            Iterator i$ = this.mSystemAudioModeChangeListenerRecords.iterator();
            while (i$.hasNext()) {
                SystemAudioModeChangeListenerRecord record = (SystemAudioModeChangeListenerRecord) i$.next();
                if (record.mListener.asBinder() == listener) {
                    listener.asBinder().unlinkToDeath(record, INITIATED_BY_ENABLE_CEC);
                    this.mSystemAudioModeChangeListenerRecords.remove(record);
                    break;
                }
            }
        }
    }

    private void setInputChangeListener(IHdmiInputChangeListener listener) {
        synchronized (this.mLock) {
            this.mInputChangeListenerRecord = new InputChangeListenerRecord(listener);
            try {
                listener.asBinder().linkToDeath(this.mInputChangeListenerRecord, INITIATED_BY_ENABLE_CEC);
            } catch (RemoteException e) {
                Slog.w(TAG, "Listener already died");
            }
        }
    }

    void invokeInputChangeListener(HdmiDeviceInfo info) {
        synchronized (this.mLock) {
            if (this.mInputChangeListenerRecord != null) {
                try {
                    this.mInputChangeListenerRecord.mListener.onChanged(info);
                } catch (RemoteException e) {
                    Slog.w(TAG, "Exception thrown by IHdmiInputChangeListener: " + e);
                }
            }
        }
    }

    private void setHdmiRecordListener(IHdmiRecordListener listener) {
        synchronized (this.mLock) {
            this.mRecordListenerRecord = new HdmiRecordListenerRecord(listener);
            try {
                listener.asBinder().linkToDeath(this.mRecordListenerRecord, INITIATED_BY_ENABLE_CEC);
            } catch (RemoteException e) {
                Slog.w(TAG, "Listener already died.", e);
            }
        }
    }

    byte[] invokeRecordRequestListener(int recorderAddress) {
        byte[] oneTouchRecordSource;
        synchronized (this.mLock) {
            if (this.mRecordListenerRecord != null) {
                try {
                    oneTouchRecordSource = this.mRecordListenerRecord.mListener.getOneTouchRecordSource(recorderAddress);
                } catch (RemoteException e) {
                    Slog.w(TAG, "Failed to start record.", e);
                }
            }
            oneTouchRecordSource = EmptyArray.BYTE;
        }
        return oneTouchRecordSource;
    }

    void invokeOneTouchRecordResult(int recorderAddress, int result) {
        synchronized (this.mLock) {
            if (this.mRecordListenerRecord != null) {
                try {
                    this.mRecordListenerRecord.mListener.onOneTouchRecordResult(recorderAddress, result);
                } catch (RemoteException e) {
                    Slog.w(TAG, "Failed to call onOneTouchRecordResult.", e);
                }
            }
        }
    }

    void invokeTimerRecordingResult(int recorderAddress, int result) {
        synchronized (this.mLock) {
            if (this.mRecordListenerRecord != null) {
                try {
                    this.mRecordListenerRecord.mListener.onTimerRecordingResult(recorderAddress, result);
                } catch (RemoteException e) {
                    Slog.w(TAG, "Failed to call onTimerRecordingResult.", e);
                }
            }
        }
    }

    void invokeClearTimerRecordingResult(int recorderAddress, int result) {
        synchronized (this.mLock) {
            if (this.mRecordListenerRecord != null) {
                try {
                    this.mRecordListenerRecord.mListener.onClearTimerRecordingResult(recorderAddress, result);
                } catch (RemoteException e) {
                    Slog.w(TAG, "Failed to call onClearTimerRecordingResult.", e);
                }
            }
        }
    }

    private void invokeCallback(IHdmiControlCallback callback, int result) {
        try {
            callback.onComplete(result);
        } catch (RemoteException e) {
            Slog.e(TAG, "Invoking callback failed:" + e);
        }
    }

    private void invokeSystemAudioModeChangeLocked(IHdmiSystemAudioModeChangeListener listener, boolean enabled) {
        try {
            listener.onStatusChanged(enabled);
        } catch (RemoteException e) {
            Slog.e(TAG, "Invoking callback failed:" + e);
        }
    }

    private void announceHotplugEvent(int portId, boolean connected) {
        HdmiHotplugEvent event = new HdmiHotplugEvent(portId, connected);
        synchronized (this.mLock) {
            Iterator i$ = this.mHotplugEventListenerRecords.iterator();
            while (i$.hasNext()) {
                invokeHotplugEventListenerLocked(((HotplugEventListenerRecord) i$.next()).mListener, event);
            }
        }
    }

    private void invokeHotplugEventListenerLocked(IHdmiHotplugEventListener listener, HdmiHotplugEvent event) {
        try {
            listener.onReceived(event);
        } catch (RemoteException e) {
            Slog.e(TAG, "Failed to report hotplug event:" + event.toString(), e);
        }
    }

    private HdmiCecLocalDeviceTv tv() {
        return (HdmiCecLocalDeviceTv) this.mCecController.getLocalDevice(INITIATED_BY_ENABLE_CEC);
    }

    boolean isTvDevice() {
        return this.mLocalDevices.contains(Integer.valueOf(INITIATED_BY_ENABLE_CEC));
    }

    boolean isTvDeviceEnabled() {
        return isTvDevice() && tv() != null;
    }

    private HdmiCecLocalDevicePlayback playback() {
        return (HdmiCecLocalDevicePlayback) this.mCecController.getLocalDevice(INITIATED_BY_HOTPLUG);
    }

    AudioManager getAudioManager() {
        return (AudioManager) getContext().getSystemService("audio");
    }

    boolean isControlEnabled() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mHdmiControlEnabled;
        }
        return z;
    }

    @ServiceThreadOnly
    int getPowerStatus() {
        assertRunOnServiceThread();
        return this.mPowerStatus;
    }

    @ServiceThreadOnly
    boolean isPowerOnOrTransient() {
        assertRunOnServiceThread();
        return this.mPowerStatus == 0 || this.mPowerStatus == INITIATED_BY_SCREEN_ON;
    }

    @ServiceThreadOnly
    boolean isPowerStandbyOrTransient() {
        assertRunOnServiceThread();
        if (this.mPowerStatus == INITIATED_BY_BOOT_UP || this.mPowerStatus == INITIATED_BY_WAKE_UP_MESSAGE) {
            return true;
        }
        return false;
    }

    @ServiceThreadOnly
    boolean isPowerStandby() {
        assertRunOnServiceThread();
        if (this.mPowerStatus == INITIATED_BY_BOOT_UP) {
            return true;
        }
        return false;
    }

    @ServiceThreadOnly
    void wakeUp() {
        assertRunOnServiceThread();
        this.mWakeUpMessageReceived = true;
        this.mPowerManager.wakeUp(SystemClock.uptimeMillis());
    }

    @ServiceThreadOnly
    void standby() {
        assertRunOnServiceThread();
        this.mStandbyMessageReceived = true;
        this.mPowerManager.goToSleep(SystemClock.uptimeMillis(), 5, INITIATED_BY_ENABLE_CEC);
    }

    @ServiceThreadOnly
    private void onWakeUp() {
        assertRunOnServiceThread();
        this.mPowerStatus = INITIATED_BY_SCREEN_ON;
        if (this.mCecController == null) {
            Slog.i(TAG, "Device does not support HDMI-CEC.");
        } else if (this.mHdmiControlEnabled) {
            int startReason = INITIATED_BY_SCREEN_ON;
            if (this.mWakeUpMessageReceived) {
                startReason = INITIATED_BY_WAKE_UP_MESSAGE;
            }
            initializeCec(startReason);
        }
    }

    @ServiceThreadOnly
    private void onStandby() {
        assertRunOnServiceThread();
        if (canGoToStandby()) {
            this.mPowerStatus = INITIATED_BY_WAKE_UP_MESSAGE;
            invokeVendorCommandListenersOnControlStateChanged(false, INITIATED_BY_WAKE_UP_MESSAGE);
            disableDevices(new C02943(getAllLocalDevices()));
        }
    }

    private boolean canGoToStandby() {
        for (HdmiCecLocalDevice device : this.mCecController.getLocalDeviceList()) {
            if (!device.canGoToStandby()) {
                return false;
            }
        }
        return true;
    }

    @ServiceThreadOnly
    private void onLanguageChanged(String language) {
        assertRunOnServiceThread();
        this.mLanguage = language;
        if (isTvDeviceEnabled()) {
            tv().broadcastMenuLanguage(language);
            this.mCecController.setOption(5, HdmiUtils.languageToInt(language));
        }
    }

    @ServiceThreadOnly
    String getLanguage() {
        assertRunOnServiceThread();
        return this.mLanguage;
    }

    private void disableDevices(PendingActionClearedCallback callback) {
        if (this.mCecController != null) {
            for (HdmiCecLocalDevice device : this.mCecController.getLocalDeviceList()) {
                device.disableDevice(this.mStandbyMessageReceived, callback);
            }
        }
        this.mMhlController.clearAllLocalDevices();
    }

    @ServiceThreadOnly
    private void clearLocalDevices() {
        assertRunOnServiceThread();
        if (this.mCecController != null) {
            this.mCecController.clearLogicalAddress();
            this.mCecController.clearLocalDevices();
        }
    }

    @ServiceThreadOnly
    private void onStandbyCompleted() {
        assertRunOnServiceThread();
        Slog.v(TAG, "onStandbyCompleted");
        if (this.mPowerStatus == INITIATED_BY_WAKE_UP_MESSAGE) {
            this.mPowerStatus = INITIATED_BY_BOOT_UP;
            for (HdmiCecLocalDevice device : this.mCecController.getLocalDeviceList()) {
                device.onStandby(this.mStandbyMessageReceived);
            }
            this.mStandbyMessageReceived = false;
            this.mAddressAllocated = false;
            this.mCecController.setOption(INITIATED_BY_WAKE_UP_MESSAGE, INITIATED_BY_ENABLE_CEC);
            this.mMhlController.setOption(HdmiCecKeycode.CEC_KEYCODE_SELECT_MEDIA_FUNCTION, INITIATED_BY_ENABLE_CEC);
        }
    }

    private void addVendorCommandListener(IHdmiVendorCommandListener listener, int deviceType) {
        VendorCommandListenerRecord record = new VendorCommandListenerRecord(listener, deviceType);
        try {
            listener.asBinder().linkToDeath(record, INITIATED_BY_ENABLE_CEC);
            synchronized (this.mLock) {
                this.mVendorCommandListenerRecords.add(record);
            }
        } catch (RemoteException e) {
            Slog.w(TAG, "Listener already died");
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    boolean invokeVendorCommandListenersOnReceived(int r7, int r8, int r9, byte[] r10, boolean r11) {
        /*
        r6 = this;
        r4 = r6.mLock;
        monitor-enter(r4);
        r3 = r6.mVendorCommandListenerRecords;	 Catch:{ all -> 0x0037 }
        r3 = r3.isEmpty();	 Catch:{ all -> 0x0037 }
        if (r3 == 0) goto L_0x000e;
    L_0x000b:
        r3 = 0;
        monitor-exit(r4);	 Catch:{ all -> 0x0037 }
    L_0x000d:
        return r3;
    L_0x000e:
        r3 = r6.mVendorCommandListenerRecords;	 Catch:{ all -> 0x0037 }
        r1 = r3.iterator();	 Catch:{ all -> 0x0037 }
    L_0x0014:
        r3 = r1.hasNext();	 Catch:{ all -> 0x0037 }
        if (r3 == 0) goto L_0x003a;
    L_0x001a:
        r2 = r1.next();	 Catch:{ all -> 0x0037 }
        r2 = (com.android.server.hdmi.HdmiControlService.VendorCommandListenerRecord) r2;	 Catch:{ all -> 0x0037 }
        r3 = r2.mDeviceType;	 Catch:{ all -> 0x0037 }
        if (r3 != r7) goto L_0x0014;
    L_0x0026:
        r3 = r2.mListener;	 Catch:{ RemoteException -> 0x002e }
        r3.onReceived(r8, r9, r10, r11);	 Catch:{ RemoteException -> 0x002e }
        goto L_0x0014;
    L_0x002e:
        r0 = move-exception;
        r3 = "HdmiControlService";
        r5 = "Failed to notify vendor command reception";
        android.util.Slog.e(r3, r5, r0);	 Catch:{ all -> 0x0037 }
        goto L_0x0014;
    L_0x0037:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0037 }
        throw r3;
    L_0x003a:
        r3 = 1;
        monitor-exit(r4);	 Catch:{ all -> 0x0037 }
        goto L_0x000d;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.hdmi.HdmiControlService.invokeVendorCommandListenersOnReceived(int, int, int, byte[], boolean):boolean");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    boolean invokeVendorCommandListenersOnControlStateChanged(boolean r7, int r8) {
        /*
        r6 = this;
        r4 = r6.mLock;
        monitor-enter(r4);
        r3 = r6.mVendorCommandListenerRecords;	 Catch:{ all -> 0x0031 }
        r3 = r3.isEmpty();	 Catch:{ all -> 0x0031 }
        if (r3 == 0) goto L_0x000e;
    L_0x000b:
        r3 = 0;
        monitor-exit(r4);	 Catch:{ all -> 0x0031 }
    L_0x000d:
        return r3;
    L_0x000e:
        r3 = r6.mVendorCommandListenerRecords;	 Catch:{ all -> 0x0031 }
        r1 = r3.iterator();	 Catch:{ all -> 0x0031 }
    L_0x0014:
        r3 = r1.hasNext();	 Catch:{ all -> 0x0031 }
        if (r3 == 0) goto L_0x0034;
    L_0x001a:
        r2 = r1.next();	 Catch:{ all -> 0x0031 }
        r2 = (com.android.server.hdmi.HdmiControlService.VendorCommandListenerRecord) r2;	 Catch:{ all -> 0x0031 }
        r3 = r2.mListener;	 Catch:{ RemoteException -> 0x0028 }
        r3.onControlStateChanged(r7, r8);	 Catch:{ RemoteException -> 0x0028 }
        goto L_0x0014;
    L_0x0028:
        r0 = move-exception;
        r3 = "HdmiControlService";
        r5 = "Failed to notify control-state-changed to vendor handler";
        android.util.Slog.e(r3, r5, r0);	 Catch:{ all -> 0x0031 }
        goto L_0x0014;
    L_0x0031:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0031 }
        throw r3;
    L_0x0034:
        r3 = 1;
        monitor-exit(r4);	 Catch:{ all -> 0x0031 }
        goto L_0x000d;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.hdmi.HdmiControlService.invokeVendorCommandListenersOnControlStateChanged(boolean, int):boolean");
    }

    private void addHdmiMhlVendorCommandListener(IHdmiMhlVendorCommandListener listener) {
        HdmiMhlVendorCommandListenerRecord record = new HdmiMhlVendorCommandListenerRecord(listener);
        try {
            listener.asBinder().linkToDeath(record, INITIATED_BY_ENABLE_CEC);
            synchronized (this.mLock) {
                this.mMhlVendorCommandListenerRecords.add(record);
            }
        } catch (RemoteException e) {
            Slog.w(TAG, "Listener already died.");
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void invokeMhlVendorCommandListeners(int r7, int r8, int r9, byte[] r10) {
        /*
        r6 = this;
        r4 = r6.mLock;
        monitor-enter(r4);
        r3 = r6.mMhlVendorCommandListenerRecords;	 Catch:{ all -> 0x0026 }
        r1 = r3.iterator();	 Catch:{ all -> 0x0026 }
    L_0x0009:
        r3 = r1.hasNext();	 Catch:{ all -> 0x0026 }
        if (r3 == 0) goto L_0x0029;
    L_0x000f:
        r2 = r1.next();	 Catch:{ all -> 0x0026 }
        r2 = (com.android.server.hdmi.HdmiControlService.HdmiMhlVendorCommandListenerRecord) r2;	 Catch:{ all -> 0x0026 }
        r3 = r2.mListener;	 Catch:{ RemoteException -> 0x001d }
        r3.onReceived(r7, r8, r9, r10);	 Catch:{ RemoteException -> 0x001d }
        goto L_0x0009;
    L_0x001d:
        r0 = move-exception;
        r3 = "HdmiControlService";
        r5 = "Failed to notify MHL vendor command";
        android.util.Slog.e(r3, r5, r0);	 Catch:{ all -> 0x0026 }
        goto L_0x0009;
    L_0x0026:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0026 }
        throw r3;
    L_0x0029:
        monitor-exit(r4);	 Catch:{ all -> 0x0026 }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.hdmi.HdmiControlService.invokeMhlVendorCommandListeners(int, int, int, byte[]):void");
    }

    boolean isProhibitMode() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mProhibitMode;
        }
        return z;
    }

    void setProhibitMode(boolean enabled) {
        synchronized (this.mLock) {
            this.mProhibitMode = enabled;
        }
    }

    @ServiceThreadOnly
    void setCecOption(int key, int value) {
        assertRunOnServiceThread();
        this.mCecController.setOption(key, value);
    }

    @ServiceThreadOnly
    void setControlEnabled(boolean enabled) {
        assertRunOnServiceThread();
        synchronized (this.mLock) {
            this.mHdmiControlEnabled = enabled;
        }
        if (enabled) {
            enableHdmiControlService();
            return;
        }
        invokeVendorCommandListenersOnControlStateChanged(false, INITIATED_BY_BOOT_UP);
        runOnServiceThread(new C02954());
    }

    @ServiceThreadOnly
    private void enableHdmiControlService() {
        this.mCecController.setOption(INITIATED_BY_SCREEN_ON, INITIATED_BY_BOOT_UP);
        this.mMhlController.setOption(HdmiCecKeycode.CEC_KEYCODE_TUNE_FUNCTION, INITIATED_BY_BOOT_UP);
        initializeCec(INITIATED_BY_ENABLE_CEC);
    }

    @ServiceThreadOnly
    private void disableHdmiControlService() {
        disableDevices(new C02975());
    }

    @ServiceThreadOnly
    void setActivePortId(int portId) {
        assertRunOnServiceThread();
        this.mActivePortId = portId;
        setLastInputForMhl(-1);
    }

    @ServiceThreadOnly
    void setLastInputForMhl(int portId) {
        assertRunOnServiceThread();
        this.mLastInputMhl = portId;
    }

    @ServiceThreadOnly
    int getLastInputForMhl() {
        assertRunOnServiceThread();
        return this.mLastInputMhl;
    }

    @ServiceThreadOnly
    void changeInputForMhl(int portId, boolean contentOn) {
        assertRunOnServiceThread();
        if (tv() != null) {
            int lastInput;
            if (contentOn) {
                lastInput = tv().getActivePortId();
            } else {
                lastInput = -1;
            }
            if (portId != -1) {
                tv().doManualPortSwitching(portId, new C02986(lastInput));
            }
            tv().setActivePortId(portId);
            HdmiMhlLocalDeviceStub device = this.mMhlController.getLocalDevice(portId);
            invokeInputChangeListener(device != null ? device.getInfo() : (HdmiDeviceInfo) this.mPortDeviceMap.get(portId, HdmiDeviceInfo.INACTIVE_DEVICE));
        }
    }

    void setMhlInputChangeEnabled(boolean enabled) {
        this.mMhlController.setOption(HdmiCecKeycode.CEC_KEYCODE_MUTE_FUNCTION, toInt(enabled));
        synchronized (this.mLock) {
            this.mMhlInputChangeEnabled = enabled;
        }
    }

    boolean isMhlInputChangeEnabled() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mMhlInputChangeEnabled;
        }
        return z;
    }

    @ServiceThreadOnly
    void displayOsd(int messageId) {
        assertRunOnServiceThread();
        Intent intent = new Intent("android.hardware.hdmi.action.OSD_MESSAGE");
        intent.putExtra("android.hardware.hdmi.extra.MESSAGE_ID", messageId);
        getContext().sendBroadcastAsUser(intent, UserHandle.ALL, PERMISSION);
    }

    @ServiceThreadOnly
    void displayOsd(int messageId, int extra) {
        assertRunOnServiceThread();
        Intent intent = new Intent("android.hardware.hdmi.action.OSD_MESSAGE");
        intent.putExtra("android.hardware.hdmi.extra.MESSAGE_ID", messageId);
        intent.putExtra("android.hardware.hdmi.extra.MESSAGE_EXTRA_PARAM1", extra);
        getContext().sendBroadcastAsUser(intent, UserHandle.ALL, PERMISSION);
    }
}
