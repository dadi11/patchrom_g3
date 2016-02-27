package com.android.server.tv;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.hdmi.HdmiDeviceInfo;
import android.hardware.hdmi.HdmiHotplugEvent;
import android.hardware.hdmi.IHdmiControlService;
import android.hardware.hdmi.IHdmiDeviceEventListener;
import android.hardware.hdmi.IHdmiDeviceEventListener.Stub;
import android.hardware.hdmi.IHdmiHotplugEventListener;
import android.hardware.hdmi.IHdmiSystemAudioModeChangeListener;
import android.media.AudioDevicePort;
import android.media.AudioFormat;
import android.media.AudioGain;
import android.media.AudioGainConfig;
import android.media.AudioManager;
import android.media.AudioManager.OnAudioPortUpdateListener;
import android.media.AudioPatch;
import android.media.AudioPort;
import android.media.AudioPortConfig;
import android.media.tv.ITvInputHardware;
import android.media.tv.ITvInputHardwareCallback;
import android.media.tv.TvInputHardwareInfo;
import android.media.tv.TvInputInfo;
import android.media.tv.TvStreamConfig;
import android.os.Handler;
import android.os.IBinder.DeathRecipient;
import android.os.Message;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.util.ArrayMap;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseBooleanArray;
import android.view.KeyEvent;
import android.view.Surface;
import com.android.server.SystemService;
import com.android.server.tv.TvInputHal.Callback;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

class TvInputHardwareManager implements Callback {
    private static final String TAG;
    private final AudioManager mAudioManager;
    private final SparseArray<Connection> mConnections;
    private final Context mContext;
    private int mCurrentIndex;
    private int mCurrentMaxIndex;
    private final TvInputHal mHal;
    private final Handler mHandler;
    private final SparseArray<String> mHardwareInputIdMap;
    private final List<TvInputHardwareInfo> mHardwareList;
    private IHdmiControlService mHdmiControlService;
    private final IHdmiDeviceEventListener mHdmiDeviceEventListener;
    private final List<HdmiDeviceInfo> mHdmiDeviceList;
    private final IHdmiHotplugEventListener mHdmiHotplugEventListener;
    private final SparseArray<String> mHdmiInputIdMap;
    private final SparseBooleanArray mHdmiStateMap;
    private final IHdmiSystemAudioModeChangeListener mHdmiSystemAudioModeChangeListener;
    private final Map<String, TvInputInfo> mInputMap;
    private final Listener mListener;
    private final Object mLock;
    private final List<Message> mPendingHdmiDeviceEvents;
    private final boolean mUseMasterVolume;
    private final BroadcastReceiver mVolumeReceiver;

    /* renamed from: com.android.server.tv.TvInputHardwareManager.1 */
    class C05281 extends BroadcastReceiver {
        C05281() {
        }

        public void onReceive(Context context, Intent intent) {
            TvInputHardwareManager.this.handleVolumeChange(context, intent);
        }
    }

    /* renamed from: com.android.server.tv.TvInputHardwareManager.2 */
    class C05292 implements Runnable {
        final /* synthetic */ TvStreamConfig val$config;
        final /* synthetic */ TvInputHardwareImpl val$hardwareImpl;

        C05292(TvInputHardwareImpl tvInputHardwareImpl, TvStreamConfig tvStreamConfig) {
            this.val$hardwareImpl = tvInputHardwareImpl;
            this.val$config = tvStreamConfig;
        }

        public void run() {
            this.val$hardwareImpl.stopCapture(this.val$config);
        }
    }

    private class Connection implements DeathRecipient {
        private ITvInputHardwareCallback mCallback;
        private Integer mCallingUid;
        private TvStreamConfig[] mConfigs;
        private TvInputHardwareImpl mHardware;
        private final TvInputHardwareInfo mHardwareInfo;
        private TvInputInfo mInfo;
        private Runnable mOnFirstFrameCaptured;
        private Integer mResolvedUserId;

        public Connection(TvInputHardwareInfo hardwareInfo) {
            this.mHardware = null;
            this.mConfigs = null;
            this.mCallingUid = null;
            this.mResolvedUserId = null;
            this.mHardwareInfo = hardwareInfo;
        }

        public void resetLocked(TvInputHardwareImpl hardware, ITvInputHardwareCallback callback, TvInputInfo info, Integer callingUid, Integer resolvedUserId) {
            if (this.mHardware != null) {
                try {
                    this.mCallback.onReleased();
                } catch (RemoteException e) {
                    Slog.e(TvInputHardwareManager.TAG, "error in Connection::resetLocked", e);
                }
                this.mHardware.release();
            }
            this.mHardware = hardware;
            this.mCallback = callback;
            this.mInfo = info;
            this.mCallingUid = callingUid;
            this.mResolvedUserId = resolvedUserId;
            this.mOnFirstFrameCaptured = null;
            if (this.mHardware != null && this.mCallback != null) {
                try {
                    this.mCallback.onStreamConfigChanged(getConfigsLocked());
                } catch (RemoteException e2) {
                    Slog.e(TvInputHardwareManager.TAG, "error in Connection::resetLocked", e2);
                }
            }
        }

        public void updateConfigsLocked(TvStreamConfig[] configs) {
            this.mConfigs = configs;
        }

        public TvInputHardwareInfo getHardwareInfoLocked() {
            return this.mHardwareInfo;
        }

        public TvInputInfo getInfoLocked() {
            return this.mInfo;
        }

        public ITvInputHardware getHardwareLocked() {
            return this.mHardware;
        }

        public TvInputHardwareImpl getHardwareImplLocked() {
            return this.mHardware;
        }

        public ITvInputHardwareCallback getCallbackLocked() {
            return this.mCallback;
        }

        public TvStreamConfig[] getConfigsLocked() {
            return this.mConfigs;
        }

        public Integer getCallingUidLocked() {
            return this.mCallingUid;
        }

        public Integer getResolvedUserIdLocked() {
            return this.mResolvedUserId;
        }

        public void setOnFirstFrameCapturedLocked(Runnable runnable) {
            this.mOnFirstFrameCaptured = runnable;
        }

        public Runnable getOnFirstFrameCapturedLocked() {
            return this.mOnFirstFrameCaptured;
        }

        public void binderDied() {
            synchronized (TvInputHardwareManager.this.mLock) {
                resetLocked(null, null, null, null, null);
            }
        }
    }

    private final class HdmiDeviceEventListener extends Stub {
        private HdmiDeviceEventListener() {
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onStatusChanged(android.hardware.hdmi.HdmiDeviceInfo r9, int r10) {
            /*
            r8 = this;
            r4 = r9.isSourceType();
            if (r4 != 0) goto L_0x0007;
        L_0x0006:
            return;
        L_0x0007:
            r4 = com.android.server.tv.TvInputHardwareManager.this;
            r5 = r4.mLock;
            monitor-enter(r5);
            r0 = 0;
            r2 = 0;
            switch(r10) {
                case 1: goto L_0x0033;
                case 2: goto L_0x006b;
                case 3: goto L_0x00a6;
                default: goto L_0x0013;
            };
        L_0x0013:
            r4 = com.android.server.tv.TvInputHardwareManager.this;	 Catch:{ all -> 0x0030 }
            r4 = r4.mHandler;	 Catch:{ all -> 0x0030 }
            r6 = 0;
            r7 = 0;
            r1 = r4.obtainMessage(r0, r6, r7, r2);	 Catch:{ all -> 0x0030 }
            r4 = com.android.server.tv.TvInputHardwareManager.this;	 Catch:{ all -> 0x0030 }
            r6 = r9.getPortId();	 Catch:{ all -> 0x0030 }
            r4 = r4.findHardwareInfoForHdmiPortLocked(r6);	 Catch:{ all -> 0x0030 }
            if (r4 == 0) goto L_0x00ea;
        L_0x002b:
            r1.sendToTarget();	 Catch:{ all -> 0x0030 }
        L_0x002e:
            monitor-exit(r5);	 Catch:{ all -> 0x0030 }
            goto L_0x0006;
        L_0x0030:
            r4 = move-exception;
            monitor-exit(r5);	 Catch:{ all -> 0x0030 }
            throw r4;
        L_0x0033:
            r4 = r9.getId();	 Catch:{ all -> 0x0030 }
            r4 = r8.findHdmiDeviceInfo(r4);	 Catch:{ all -> 0x0030 }
            if (r4 != 0) goto L_0x0049;
        L_0x003d:
            r4 = com.android.server.tv.TvInputHardwareManager.this;	 Catch:{ all -> 0x0030 }
            r4 = r4.mHdmiDeviceList;	 Catch:{ all -> 0x0030 }
            r4.add(r9);	 Catch:{ all -> 0x0030 }
            r0 = 4;
            r2 = r9;
            goto L_0x0013;
        L_0x0049:
            r4 = com.android.server.tv.TvInputHardwareManager.TAG;	 Catch:{ all -> 0x0030 }
            r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0030 }
            r6.<init>();	 Catch:{ all -> 0x0030 }
            r7 = "The list already contains ";
            r6 = r6.append(r7);	 Catch:{ all -> 0x0030 }
            r6 = r6.append(r9);	 Catch:{ all -> 0x0030 }
            r7 = "; ignoring.";
            r6 = r6.append(r7);	 Catch:{ all -> 0x0030 }
            r6 = r6.toString();	 Catch:{ all -> 0x0030 }
            android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0030 }
            monitor-exit(r5);	 Catch:{ all -> 0x0030 }
            goto L_0x0006;
        L_0x006b:
            r4 = r9.getId();	 Catch:{ all -> 0x0030 }
            r3 = r8.findHdmiDeviceInfo(r4);	 Catch:{ all -> 0x0030 }
            r4 = com.android.server.tv.TvInputHardwareManager.this;	 Catch:{ all -> 0x0030 }
            r4 = r4.mHdmiDeviceList;	 Catch:{ all -> 0x0030 }
            r4 = r4.remove(r3);	 Catch:{ all -> 0x0030 }
            if (r4 != 0) goto L_0x00a2;
        L_0x007f:
            r4 = com.android.server.tv.TvInputHardwareManager.TAG;	 Catch:{ all -> 0x0030 }
            r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0030 }
            r6.<init>();	 Catch:{ all -> 0x0030 }
            r7 = "The list doesn't contain ";
            r6 = r6.append(r7);	 Catch:{ all -> 0x0030 }
            r6 = r6.append(r9);	 Catch:{ all -> 0x0030 }
            r7 = "; ignoring.";
            r6 = r6.append(r7);	 Catch:{ all -> 0x0030 }
            r6 = r6.toString();	 Catch:{ all -> 0x0030 }
            android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0030 }
            monitor-exit(r5);	 Catch:{ all -> 0x0030 }
            goto L_0x0006;
        L_0x00a2:
            r0 = 5;
            r2 = r9;
            goto L_0x0013;
        L_0x00a6:
            r4 = r9.getId();	 Catch:{ all -> 0x0030 }
            r3 = r8.findHdmiDeviceInfo(r4);	 Catch:{ all -> 0x0030 }
            r4 = com.android.server.tv.TvInputHardwareManager.this;	 Catch:{ all -> 0x0030 }
            r4 = r4.mHdmiDeviceList;	 Catch:{ all -> 0x0030 }
            r4 = r4.remove(r3);	 Catch:{ all -> 0x0030 }
            if (r4 != 0) goto L_0x00dd;
        L_0x00ba:
            r4 = com.android.server.tv.TvInputHardwareManager.TAG;	 Catch:{ all -> 0x0030 }
            r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0030 }
            r6.<init>();	 Catch:{ all -> 0x0030 }
            r7 = "The list doesn't contain ";
            r6 = r6.append(r7);	 Catch:{ all -> 0x0030 }
            r6 = r6.append(r9);	 Catch:{ all -> 0x0030 }
            r7 = "; ignoring.";
            r6 = r6.append(r7);	 Catch:{ all -> 0x0030 }
            r6 = r6.toString();	 Catch:{ all -> 0x0030 }
            android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0030 }
            monitor-exit(r5);	 Catch:{ all -> 0x0030 }
            goto L_0x0006;
        L_0x00dd:
            r4 = com.android.server.tv.TvInputHardwareManager.this;	 Catch:{ all -> 0x0030 }
            r4 = r4.mHdmiDeviceList;	 Catch:{ all -> 0x0030 }
            r4.add(r9);	 Catch:{ all -> 0x0030 }
            r0 = 6;
            r2 = r9;
            goto L_0x0013;
        L_0x00ea:
            r4 = com.android.server.tv.TvInputHardwareManager.this;	 Catch:{ all -> 0x0030 }
            r4 = r4.mPendingHdmiDeviceEvents;	 Catch:{ all -> 0x0030 }
            r4.add(r1);	 Catch:{ all -> 0x0030 }
            goto L_0x002e;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputHardwareManager.HdmiDeviceEventListener.onStatusChanged(android.hardware.hdmi.HdmiDeviceInfo, int):void");
        }

        private HdmiDeviceInfo findHdmiDeviceInfo(int id) {
            for (HdmiDeviceInfo info : TvInputHardwareManager.this.mHdmiDeviceList) {
                if (info.getId() == id) {
                    return info;
                }
            }
            return null;
        }
    }

    private final class HdmiHotplugEventListener extends IHdmiHotplugEventListener.Stub {
        private HdmiHotplugEventListener() {
        }

        public void onReceived(HdmiHotplugEvent event) {
            synchronized (TvInputHardwareManager.this.mLock) {
                TvInputHardwareManager.this.mHdmiStateMap.put(event.getPort(), event.isConnected());
                TvInputHardwareInfo hardwareInfo = TvInputHardwareManager.this.findHardwareInfoForHdmiPortLocked(event.getPort());
                if (hardwareInfo == null) {
                    return;
                }
                String inputId = (String) TvInputHardwareManager.this.mHardwareInputIdMap.get(hardwareInfo.getDeviceId());
                if (inputId == null) {
                    return;
                }
                TvInputHardwareManager.this.mHandler.obtainMessage(1, TvInputHardwareManager.this.convertConnectedToState(event.isConnected()), 0, inputId).sendToTarget();
            }
        }
    }

    private final class HdmiSystemAudioModeChangeListener extends IHdmiSystemAudioModeChangeListener.Stub {
        private HdmiSystemAudioModeChangeListener() {
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onStatusChanged(boolean r5) throws android.os.RemoteException {
            /*
            r4 = this;
            r2 = com.android.server.tv.TvInputHardwareManager.this;
            r3 = r2.mLock;
            monitor-enter(r3);
            r0 = 0;
        L_0x0008:
            r2 = com.android.server.tv.TvInputHardwareManager.this;	 Catch:{ all -> 0x002e }
            r2 = r2.mConnections;	 Catch:{ all -> 0x002e }
            r2 = r2.size();	 Catch:{ all -> 0x002e }
            if (r0 >= r2) goto L_0x002c;
        L_0x0014:
            r2 = com.android.server.tv.TvInputHardwareManager.this;	 Catch:{ all -> 0x002e }
            r2 = r2.mConnections;	 Catch:{ all -> 0x002e }
            r2 = r2.valueAt(r0);	 Catch:{ all -> 0x002e }
            r2 = (com.android.server.tv.TvInputHardwareManager.Connection) r2;	 Catch:{ all -> 0x002e }
            r1 = r2.getHardwareImplLocked();	 Catch:{ all -> 0x002e }
            if (r1 == 0) goto L_0x0029;
        L_0x0026:
            r1.handleAudioSinkUpdated();	 Catch:{ all -> 0x002e }
        L_0x0029:
            r0 = r0 + 1;
            goto L_0x0008;
        L_0x002c:
            monitor-exit(r3);	 Catch:{ all -> 0x002e }
            return;
        L_0x002e:
            r2 = move-exception;
            monitor-exit(r3);	 Catch:{ all -> 0x002e }
            throw r2;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputHardwareManager.HdmiSystemAudioModeChangeListener.onStatusChanged(boolean):void");
        }
    }

    interface Listener {
        void onHardwareDeviceAdded(TvInputHardwareInfo tvInputHardwareInfo);

        void onHardwareDeviceRemoved(TvInputHardwareInfo tvInputHardwareInfo);

        void onHdmiDeviceAdded(HdmiDeviceInfo hdmiDeviceInfo);

        void onHdmiDeviceRemoved(HdmiDeviceInfo hdmiDeviceInfo);

        void onHdmiDeviceUpdated(String str, HdmiDeviceInfo hdmiDeviceInfo);

        void onStateChanged(String str, int i);
    }

    private class ListenerHandler extends Handler {
        private static final int HARDWARE_DEVICE_ADDED = 2;
        private static final int HARDWARE_DEVICE_REMOVED = 3;
        private static final int HDMI_DEVICE_ADDED = 4;
        private static final int HDMI_DEVICE_REMOVED = 5;
        private static final int HDMI_DEVICE_UPDATED = 6;
        private static final int STATE_CHANGED = 1;

        private ListenerHandler() {
        }

        public final void handleMessage(Message msg) {
            switch (msg.what) {
                case STATE_CHANGED /*1*/:
                    TvInputHardwareManager.this.mListener.onStateChanged(msg.obj, msg.arg1);
                case HARDWARE_DEVICE_ADDED /*2*/:
                    TvInputHardwareManager.this.mListener.onHardwareDeviceAdded(msg.obj);
                case HARDWARE_DEVICE_REMOVED /*3*/:
                    TvInputHardwareManager.this.mListener.onHardwareDeviceRemoved((TvInputHardwareInfo) msg.obj);
                case HDMI_DEVICE_ADDED /*4*/:
                    TvInputHardwareManager.this.mListener.onHdmiDeviceAdded(msg.obj);
                case HDMI_DEVICE_REMOVED /*5*/:
                    TvInputHardwareManager.this.mListener.onHdmiDeviceRemoved((HdmiDeviceInfo) msg.obj);
                case HDMI_DEVICE_UPDATED /*6*/:
                    String inputId;
                    HdmiDeviceInfo info = (HdmiDeviceInfo) msg.obj;
                    synchronized (TvInputHardwareManager.this.mLock) {
                        inputId = (String) TvInputHardwareManager.this.mHdmiInputIdMap.get(info.getId());
                        break;
                    }
                    if (inputId != null) {
                        TvInputHardwareManager.this.mListener.onHdmiDeviceUpdated(inputId, info);
                    } else {
                        Slog.w(TvInputHardwareManager.TAG, "Could not resolve input ID matching the device info; ignoring.");
                    }
                default:
                    Slog.w(TvInputHardwareManager.TAG, "Unhandled message: " + msg);
            }
        }
    }

    private class TvInputHardwareImpl extends ITvInputHardware.Stub {
        private TvStreamConfig mActiveConfig;
        private final OnAudioPortUpdateListener mAudioListener;
        private AudioPatch mAudioPatch;
        private List<AudioDevicePort> mAudioSink;
        private AudioDevicePort mAudioSource;
        private float mCommittedVolume;
        private int mDesiredChannelMask;
        private int mDesiredFormat;
        private int mDesiredSamplingRate;
        private final Object mImplLock;
        private final TvInputHardwareInfo mInfo;
        private String mOverrideAudioAddress;
        private int mOverrideAudioType;
        private boolean mReleased;
        private float mSourceVolume;

        /* renamed from: com.android.server.tv.TvInputHardwareManager.TvInputHardwareImpl.1 */
        class C05301 implements OnAudioPortUpdateListener {
            C05301() {
            }

            public void onAudioPortListUpdate(AudioPort[] portList) {
                synchronized (TvInputHardwareImpl.this.mImplLock) {
                    TvInputHardwareImpl.this.updateAudioConfigLocked();
                }
            }

            public void onAudioPatchListUpdate(AudioPatch[] patchList) {
            }

            public void onServiceDied() {
                synchronized (TvInputHardwareImpl.this.mImplLock) {
                    TvInputHardwareImpl.this.mAudioSource = null;
                    TvInputHardwareImpl.this.mAudioSink.clear();
                    TvInputHardwareImpl.this.mAudioPatch = null;
                }
            }
        }

        public TvInputHardwareImpl(TvInputHardwareInfo info) {
            this.mReleased = false;
            this.mImplLock = new Object();
            this.mAudioListener = new C05301();
            this.mOverrideAudioType = 0;
            this.mOverrideAudioAddress = "";
            this.mAudioSink = new ArrayList();
            this.mAudioPatch = null;
            this.mCommittedVolume = -1.0f;
            this.mSourceVolume = 0.0f;
            this.mActiveConfig = null;
            this.mDesiredSamplingRate = 0;
            this.mDesiredChannelMask = 1;
            this.mDesiredFormat = 1;
            this.mInfo = info;
            TvInputHardwareManager.this.mAudioManager.registerAudioPortUpdateListener(this.mAudioListener);
            if (this.mInfo.getAudioType() != 0) {
                this.mAudioSource = findAudioDevicePort(this.mInfo.getAudioType(), this.mInfo.getAudioAddress());
                findAudioSinkFromAudioPolicy(this.mAudioSink);
            }
        }

        private void findAudioSinkFromAudioPolicy(List<AudioDevicePort> sinks) {
            sinks.clear();
            ArrayList<AudioPort> devicePorts = new ArrayList();
            if (TvInputHardwareManager.this.mAudioManager.listAudioDevicePorts(devicePorts) == 0) {
                int sinkDevice = TvInputHardwareManager.this.mAudioManager.getDevicesForStream(3);
                Iterator i$ = devicePorts.iterator();
                while (i$.hasNext()) {
                    AudioDevicePort devicePort = (AudioDevicePort) ((AudioPort) i$.next());
                    if ((devicePort.type() & sinkDevice) != 0) {
                        sinks.add(devicePort);
                    }
                }
            }
        }

        private AudioDevicePort findAudioDevicePort(int type, String address) {
            if (type == 0) {
                return null;
            }
            ArrayList<AudioPort> devicePorts = new ArrayList();
            if (TvInputHardwareManager.this.mAudioManager.listAudioDevicePorts(devicePorts) != 0) {
                return null;
            }
            Iterator i$ = devicePorts.iterator();
            while (i$.hasNext()) {
                AudioDevicePort devicePort = (AudioDevicePort) ((AudioPort) i$.next());
                if (devicePort.type() == type && devicePort.address().equals(address)) {
                    return devicePort;
                }
            }
            return null;
        }

        public void release() {
            synchronized (this.mImplLock) {
                TvInputHardwareManager.this.mAudioManager.unregisterAudioPortUpdateListener(this.mAudioListener);
                if (this.mAudioPatch != null) {
                    TvInputHardwareManager.this.mAudioManager.releaseAudioPatch(this.mAudioPatch);
                    this.mAudioPatch = null;
                }
                this.mReleased = true;
            }
        }

        public boolean setSurface(Surface surface, TvStreamConfig config) throws RemoteException {
            boolean z = true;
            synchronized (this.mImplLock) {
                if (this.mReleased) {
                    throw new IllegalStateException("Device already released.");
                }
                int result = 0;
                if (surface == null) {
                    if (this.mActiveConfig != null) {
                        result = TvInputHardwareManager.this.mHal.removeStream(this.mInfo.getDeviceId(), this.mActiveConfig);
                        this.mActiveConfig = null;
                    } else {
                        return true;
                    }
                } else if (config == null) {
                    return false;
                } else {
                    if (!(this.mActiveConfig == null || config.equals(this.mActiveConfig))) {
                        result = TvInputHardwareManager.this.mHal.removeStream(this.mInfo.getDeviceId(), this.mActiveConfig);
                        if (result != 0) {
                            this.mActiveConfig = null;
                        }
                    }
                    if (result == 0) {
                        result = TvInputHardwareManager.this.mHal.addOrUpdateStream(this.mInfo.getDeviceId(), surface, config);
                        if (result == 0) {
                            this.mActiveConfig = config;
                        }
                    }
                }
                updateAudioConfigLocked();
                if (result != 0) {
                    z = false;
                }
                return z;
            }
        }

        private void updateAudioConfigLocked() {
            boolean sinkUpdated = updateAudioSinkLocked();
            boolean sourceUpdated = updateAudioSourceLocked();
            if (this.mAudioSource != null) {
                if (!(this.mAudioSink.isEmpty() || this.mActiveConfig == null)) {
                    AudioPortConfig sinkConfig;
                    TvInputHardwareManager.this.updateVolume();
                    float volume = this.mSourceVolume * TvInputHardwareManager.this.getMediaStreamVolume();
                    AudioGainConfig sourceGainConfig = null;
                    if (this.mAudioSource.gains().length > 0) {
                        if (volume != this.mCommittedVolume) {
                            AudioGain sourceGain = null;
                            for (AudioGain gain : this.mAudioSource.gains()) {
                                if ((gain.mode() & 1) != 0) {
                                    sourceGain = gain;
                                    break;
                                }
                            }
                            if (sourceGain != null) {
                                int steps = (sourceGain.maxValue() - sourceGain.minValue()) / sourceGain.stepValue();
                                int gainValue = sourceGain.minValue();
                                if (volume < 1.0f) {
                                    gainValue += sourceGain.stepValue() * ((int) (((double) (((float) steps) * volume)) + 0.5d));
                                } else {
                                    gainValue = sourceGain.maxValue();
                                }
                                sourceGainConfig = sourceGain.buildConfig(1, sourceGain.channelMask(), new int[]{gainValue}, 0);
                            } else {
                                Slog.w(TvInputHardwareManager.TAG, "No audio source gain with MODE_JOINT support exists.");
                            }
                        }
                    }
                    AudioPortConfig sourceConfig = this.mAudioSource.activeConfig();
                    List<AudioPortConfig> sinkConfigs = new ArrayList();
                    AudioPatch[] audioPatchArray = new AudioPatch[1];
                    audioPatchArray[0] = this.mAudioPatch;
                    boolean shouldRecreateAudioPatch = sourceUpdated || sinkUpdated;
                    for (AudioDevicePort audioSink : this.mAudioSink) {
                        sinkConfig = audioSink.activeConfig();
                        int sinkSamplingRate = this.mDesiredSamplingRate;
                        int sinkChannelMask = this.mDesiredChannelMask;
                        int sinkFormat = this.mDesiredFormat;
                        if (sinkConfig != null) {
                            if (sinkSamplingRate == 0) {
                                sinkSamplingRate = sinkConfig.samplingRate();
                            }
                            if (sinkChannelMask == 1) {
                                sinkChannelMask = sinkConfig.channelMask();
                            }
                            if (sinkFormat == 1) {
                                sinkChannelMask = sinkConfig.format();
                            }
                        }
                        if (sinkConfig == null || sinkConfig.samplingRate() != sinkSamplingRate || sinkConfig.channelMask() != sinkChannelMask || sinkConfig.format() != sinkFormat) {
                            if (!TvInputHardwareManager.intArrayContains(audioSink.samplingRates(), sinkSamplingRate)) {
                                if (audioSink.samplingRates().length > 0) {
                                    sinkSamplingRate = audioSink.samplingRates()[0];
                                }
                            }
                            if (!TvInputHardwareManager.intArrayContains(audioSink.channelMasks(), sinkChannelMask)) {
                                sinkChannelMask = 1;
                            }
                            if (!TvInputHardwareManager.intArrayContains(audioSink.formats(), sinkFormat)) {
                                sinkFormat = 1;
                            }
                            sinkConfig = audioSink.buildConfig(sinkSamplingRate, sinkChannelMask, sinkFormat, null);
                            shouldRecreateAudioPatch = true;
                        }
                        sinkConfigs.add(sinkConfig);
                    }
                    sinkConfig = (AudioPortConfig) sinkConfigs.get(0);
                    if (sourceConfig == null || sourceGainConfig != null) {
                        int sourceSamplingRate = 0;
                        if (TvInputHardwareManager.intArrayContains(this.mAudioSource.samplingRates(), sinkConfig.samplingRate())) {
                            sourceSamplingRate = sinkConfig.samplingRate();
                        } else {
                            if (this.mAudioSource.samplingRates().length > 0) {
                                sourceSamplingRate = this.mAudioSource.samplingRates()[0];
                            }
                        }
                        int sourceChannelMask = 1;
                        for (int inChannelMask : this.mAudioSource.channelMasks()) {
                            if (AudioFormat.channelCountFromOutChannelMask(sinkConfig.channelMask()) == AudioFormat.channelCountFromInChannelMask(inChannelMask)) {
                                sourceChannelMask = inChannelMask;
                                break;
                            }
                        }
                        int sourceFormat = 1;
                        if (TvInputHardwareManager.intArrayContains(this.mAudioSource.formats(), sinkConfig.format())) {
                            sourceFormat = sinkConfig.format();
                        }
                        sourceConfig = this.mAudioSource.buildConfig(sourceSamplingRate, sourceChannelMask, sourceFormat, sourceGainConfig);
                        shouldRecreateAudioPatch = true;
                    }
                    if (shouldRecreateAudioPatch) {
                        this.mCommittedVolume = volume;
                        TvInputHardwareManager.this.mAudioManager.createAudioPatch(audioPatchArray, new AudioPortConfig[]{sourceConfig}, (AudioPortConfig[]) sinkConfigs.toArray(new AudioPortConfig[0]));
                        this.mAudioPatch = audioPatchArray[0];
                        if (sourceGainConfig != null) {
                            TvInputHardwareManager.this.mAudioManager.setAudioPortGain(this.mAudioSource, sourceGainConfig);
                            return;
                        }
                        return;
                    }
                    return;
                }
            }
            if (this.mAudioPatch != null) {
                TvInputHardwareManager.this.mAudioManager.releaseAudioPatch(this.mAudioPatch);
                this.mAudioPatch = null;
            }
        }

        public void setStreamVolume(float volume) throws RemoteException {
            synchronized (this.mImplLock) {
                if (this.mReleased) {
                    throw new IllegalStateException("Device already released.");
                }
                this.mSourceVolume = volume;
                updateAudioConfigLocked();
            }
        }

        public boolean dispatchKeyEventToHdmi(KeyEvent event) throws RemoteException {
            synchronized (this.mImplLock) {
                if (this.mReleased) {
                    throw new IllegalStateException("Device already released.");
                }
            }
            return this.mInfo.getType() != 9 ? false : false;
        }

        private boolean startCapture(Surface surface, TvStreamConfig config) {
            boolean z = false;
            synchronized (this.mImplLock) {
                if (this.mReleased) {
                } else if (surface == null || config == null) {
                } else if (config.getType() != 2) {
                } else {
                    if (TvInputHardwareManager.this.mHal.addOrUpdateStream(this.mInfo.getDeviceId(), surface, config) == 0) {
                        z = true;
                    }
                }
            }
            return z;
        }

        private boolean stopCapture(TvStreamConfig config) {
            boolean z = false;
            synchronized (this.mImplLock) {
                if (this.mReleased) {
                } else if (config == null) {
                } else {
                    if (TvInputHardwareManager.this.mHal.removeStream(this.mInfo.getDeviceId(), config) == 0) {
                        z = true;
                    }
                }
            }
            return z;
        }

        private boolean updateAudioSourceLocked() {
            boolean z = true;
            if (this.mInfo.getAudioType() == 0) {
                return false;
            }
            AudioDevicePort previousSource = this.mAudioSource;
            this.mAudioSource = findAudioDevicePort(this.mInfo.getAudioType(), this.mInfo.getAudioAddress());
            if (this.mAudioSource == null) {
                if (previousSource == null) {
                    z = false;
                }
            } else if (this.mAudioSource.equals(previousSource)) {
                z = false;
            }
            return z;
        }

        private boolean updateAudioSinkLocked() {
            if (this.mInfo.getAudioType() == 0) {
                return false;
            }
            List<AudioDevicePort> previousSink = this.mAudioSink;
            this.mAudioSink = new ArrayList();
            if (this.mOverrideAudioType == 0) {
                findAudioSinkFromAudioPolicy(this.mAudioSink);
            } else {
                AudioDevicePort audioSink = findAudioDevicePort(this.mOverrideAudioType, this.mOverrideAudioAddress);
                if (audioSink != null) {
                    this.mAudioSink.add(audioSink);
                }
            }
            if (this.mAudioSink.size() != previousSink.size()) {
                return true;
            }
            previousSink.removeAll(this.mAudioSink);
            if (previousSink.isEmpty()) {
                return false;
            }
            return true;
        }

        private void handleAudioSinkUpdated() {
            synchronized (this.mImplLock) {
                updateAudioConfigLocked();
            }
        }

        public void overrideAudioSink(int audioType, String audioAddress, int samplingRate, int channelMask, int format) {
            synchronized (this.mImplLock) {
                this.mOverrideAudioType = audioType;
                this.mOverrideAudioAddress = audioAddress;
                this.mDesiredSamplingRate = samplingRate;
                this.mDesiredChannelMask = channelMask;
                this.mDesiredFormat = format;
                updateAudioConfigLocked();
            }
        }

        public void onMediaStreamVolumeChanged() {
            synchronized (this.mImplLock) {
                updateAudioConfigLocked();
            }
        }
    }

    static {
        TAG = TvInputHardwareManager.class.getSimpleName();
    }

    public TvInputHardwareManager(Context context, Listener listener) {
        this.mHal = new TvInputHal(this);
        this.mConnections = new SparseArray();
        this.mHardwareList = new ArrayList();
        this.mHdmiDeviceList = new LinkedList();
        this.mHardwareInputIdMap = new SparseArray();
        this.mHdmiInputIdMap = new SparseArray();
        this.mInputMap = new ArrayMap();
        this.mHdmiHotplugEventListener = new HdmiHotplugEventListener();
        this.mHdmiDeviceEventListener = new HdmiDeviceEventListener();
        this.mHdmiSystemAudioModeChangeListener = new HdmiSystemAudioModeChangeListener();
        this.mVolumeReceiver = new C05281();
        this.mCurrentIndex = 0;
        this.mCurrentMaxIndex = 0;
        this.mHdmiStateMap = new SparseBooleanArray();
        this.mPendingHdmiDeviceEvents = new LinkedList();
        this.mHandler = new ListenerHandler();
        this.mLock = new Object();
        this.mContext = context;
        this.mListener = listener;
        this.mAudioManager = (AudioManager) context.getSystemService("audio");
        this.mUseMasterVolume = this.mContext.getResources().getBoolean(17956881);
        this.mHal.init();
    }

    public void onBootPhase(int phase) {
        if (phase == SystemService.PHASE_SYSTEM_SERVICES_READY) {
            this.mHdmiControlService = IHdmiControlService.Stub.asInterface(ServiceManager.getService("hdmi_control"));
            if (this.mHdmiControlService != null) {
                try {
                    this.mHdmiControlService.addHotplugEventListener(this.mHdmiHotplugEventListener);
                    this.mHdmiControlService.addDeviceEventListener(this.mHdmiDeviceEventListener);
                    this.mHdmiControlService.addSystemAudioModeChangeListener(this.mHdmiSystemAudioModeChangeListener);
                    this.mHdmiDeviceList.addAll(this.mHdmiControlService.getInputDevices());
                } catch (RemoteException e) {
                    Slog.w(TAG, "Error registering listeners to HdmiControlService:", e);
                }
            } else {
                Slog.w(TAG, "HdmiControlService is not available");
            }
            if (!this.mUseMasterVolume) {
                IntentFilter filter = new IntentFilter();
                filter.addAction("android.media.VOLUME_CHANGED_ACTION");
                filter.addAction("android.media.STREAM_MUTE_CHANGED_ACTION");
                this.mContext.registerReceiver(this.mVolumeReceiver, filter);
            }
            updateVolume();
        }
    }

    public void onDeviceAvailable(TvInputHardwareInfo info, TvStreamConfig[] configs) {
        synchronized (this.mLock) {
            Connection connection = new Connection(info);
            connection.updateConfigsLocked(configs);
            this.mConnections.put(info.getDeviceId(), connection);
            buildHardwareListLocked();
            this.mHandler.obtainMessage(2, 0, 0, info).sendToTarget();
            if (info.getType() == 9) {
                processPendingHdmiDeviceEventsLocked();
            }
        }
    }

    private void buildHardwareListLocked() {
        this.mHardwareList.clear();
        for (int i = 0; i < this.mConnections.size(); i++) {
            this.mHardwareList.add(((Connection) this.mConnections.valueAt(i)).getHardwareInfoLocked());
        }
    }

    public void onDeviceUnavailable(int deviceId) {
        synchronized (this.mLock) {
            Connection connection = (Connection) this.mConnections.get(deviceId);
            if (connection == null) {
                Slog.e(TAG, "onDeviceUnavailable: Cannot find a connection with " + deviceId);
                return;
            }
            connection.resetLocked(null, null, null, null, null);
            this.mConnections.remove(deviceId);
            buildHardwareListLocked();
            TvInputHardwareInfo info = connection.getHardwareInfoLocked();
            if (info.getType() == 9) {
                Iterator<HdmiDeviceInfo> it = this.mHdmiDeviceList.iterator();
                while (it.hasNext()) {
                    HdmiDeviceInfo deviceInfo = (HdmiDeviceInfo) it.next();
                    if (deviceInfo.getPortId() == info.getHdmiPortId()) {
                        this.mHandler.obtainMessage(5, 0, 0, deviceInfo).sendToTarget();
                        it.remove();
                    }
                }
            }
            this.mHandler.obtainMessage(3, 0, 0, info).sendToTarget();
        }
    }

    public void onStreamConfigurationChanged(int deviceId, TvStreamConfig[] configs) {
        boolean z = true;
        synchronized (this.mLock) {
            Connection connection = (Connection) this.mConnections.get(deviceId);
            if (connection == null) {
                Slog.e(TAG, "StreamConfigurationChanged: Cannot find a connection with " + deviceId);
                return;
            }
            connection.updateConfigsLocked(configs);
            String inputId = (String) this.mHardwareInputIdMap.get(deviceId);
            if (inputId != null) {
                Handler handler = this.mHandler;
                if (configs.length <= 0) {
                    z = false;
                }
                handler.obtainMessage(1, convertConnectedToState(z), 0, inputId).sendToTarget();
            }
            ITvInputHardwareCallback callback = connection.getCallbackLocked();
            if (callback != null) {
                try {
                    callback.onStreamConfigChanged(configs);
                } catch (RemoteException e) {
                    Slog.e(TAG, "error in onStreamConfigurationChanged", e);
                }
            }
        }
    }

    public void onFirstFrameCaptured(int deviceId, int streamId) {
        synchronized (this.mLock) {
            Connection connection = (Connection) this.mConnections.get(deviceId);
            if (connection == null) {
                Slog.e(TAG, "FirstFrameCaptured: Cannot find a connection with " + deviceId);
                return;
            }
            Runnable runnable = connection.getOnFirstFrameCapturedLocked();
            if (runnable != null) {
                runnable.run();
                connection.setOnFirstFrameCapturedLocked(null);
            }
        }
    }

    public List<TvInputHardwareInfo> getHardwareList() {
        List<TvInputHardwareInfo> unmodifiableList;
        synchronized (this.mLock) {
            unmodifiableList = Collections.unmodifiableList(this.mHardwareList);
        }
        return unmodifiableList;
    }

    public List<HdmiDeviceInfo> getHdmiDeviceList() {
        List<HdmiDeviceInfo> unmodifiableList;
        synchronized (this.mLock) {
            unmodifiableList = Collections.unmodifiableList(this.mHdmiDeviceList);
        }
        return unmodifiableList;
    }

    private boolean checkUidChangedLocked(Connection connection, int callingUid, int resolvedUserId) {
        Integer connectionCallingUid = connection.getCallingUidLocked();
        Integer connectionResolvedUserId = connection.getResolvedUserIdLocked();
        if (connectionCallingUid == null || connectionResolvedUserId == null || connectionCallingUid.intValue() != callingUid || connectionResolvedUserId.intValue() != resolvedUserId) {
            return true;
        }
        return false;
    }

    private int convertConnectedToState(boolean connected) {
        if (connected) {
            return 0;
        }
        return 2;
    }

    public void addHardwareTvInput(int deviceId, TvInputInfo info) {
        boolean z = true;
        synchronized (this.mLock) {
            String oldInputId = (String) this.mHardwareInputIdMap.get(deviceId);
            if (oldInputId != null) {
                Slog.w(TAG, "Trying to override previous registration: old = " + this.mInputMap.get(oldInputId) + ":" + deviceId + ", new = " + info + ":" + deviceId);
            }
            this.mHardwareInputIdMap.put(deviceId, info.getId());
            this.mInputMap.put(info.getId(), info);
            for (int i = 0; i < this.mHdmiStateMap.size(); i++) {
                TvInputHardwareInfo hardwareInfo = findHardwareInfoForHdmiPortLocked(this.mHdmiStateMap.keyAt(i));
                if (hardwareInfo != null) {
                    String inputId = (String) this.mHardwareInputIdMap.get(hardwareInfo.getDeviceId());
                    if (inputId != null && inputId.equals(info.getId())) {
                        this.mHandler.obtainMessage(1, convertConnectedToState(this.mHdmiStateMap.valueAt(i)), 0, inputId).sendToTarget();
                        return;
                    }
                }
            }
            Connection connection = (Connection) this.mConnections.get(deviceId);
            if (connection != null) {
                Handler handler = this.mHandler;
                if (connection.getConfigsLocked().length <= 0) {
                    z = false;
                }
                handler.obtainMessage(1, convertConnectedToState(z), 0, info.getId()).sendToTarget();
                return;
            }
        }
    }

    private static <T> int indexOfEqualValue(SparseArray<T> map, T value) {
        for (int i = 0; i < map.size(); i++) {
            if (map.valueAt(i).equals(value)) {
                return i;
            }
        }
        return -1;
    }

    private static boolean intArrayContains(int[] array, int value) {
        for (int element : array) {
            if (element == value) {
                return true;
            }
        }
        return false;
    }

    public void addHdmiTvInput(int id, TvInputInfo info) {
        if (info.getType() != 1007) {
            throw new IllegalArgumentException("info (" + info + ") has non-HDMI type.");
        }
        synchronized (this.mLock) {
            if (indexOfEqualValue(this.mHardwareInputIdMap, info.getParentId()) < 0) {
                throw new IllegalArgumentException("info (" + info + ") has invalid parentId.");
            }
            String oldInputId = (String) this.mHdmiInputIdMap.get(id);
            if (oldInputId != null) {
                Slog.w(TAG, "Trying to override previous registration: old = " + this.mInputMap.get(oldInputId) + ":" + id + ", new = " + info + ":" + id);
            }
            this.mHdmiInputIdMap.put(id, info.getId());
            this.mInputMap.put(info.getId(), info);
        }
    }

    public void removeTvInput(String inputId) {
        synchronized (this.mLock) {
            this.mInputMap.remove(inputId);
            int hardwareIndex = indexOfEqualValue(this.mHardwareInputIdMap, inputId);
            if (hardwareIndex >= 0) {
                this.mHardwareInputIdMap.removeAt(hardwareIndex);
            }
            int deviceIndex = indexOfEqualValue(this.mHdmiInputIdMap, inputId);
            if (deviceIndex >= 0) {
                this.mHdmiInputIdMap.removeAt(deviceIndex);
            }
        }
    }

    public ITvInputHardware acquireHardware(int deviceId, ITvInputHardwareCallback callback, TvInputInfo info, int callingUid, int resolvedUserId) {
        ITvInputHardware iTvInputHardware = null;
        if (callback == null) {
            throw new NullPointerException();
        }
        synchronized (this.mLock) {
            Connection connection = (Connection) this.mConnections.get(deviceId);
            if (connection == null) {
                Slog.e(TAG, "Invalid deviceId : " + deviceId);
            } else {
                if (checkUidChangedLocked(connection, callingUid, resolvedUserId)) {
                    TvInputHardwareImpl hardware = new TvInputHardwareImpl(connection.getHardwareInfoLocked());
                    try {
                        callback.asBinder().linkToDeath(connection, 0);
                        connection.resetLocked(hardware, callback, info, Integer.valueOf(callingUid), Integer.valueOf(resolvedUserId));
                    } catch (RemoteException e) {
                        hardware.release();
                    }
                }
                iTvInputHardware = connection.getHardwareLocked();
            }
        }
        return iTvInputHardware;
    }

    public void releaseHardware(int deviceId, ITvInputHardware hardware, int callingUid, int resolvedUserId) {
        synchronized (this.mLock) {
            Connection connection = (Connection) this.mConnections.get(deviceId);
            if (connection == null) {
                Slog.e(TAG, "Invalid deviceId : " + deviceId);
            } else if (connection.getHardwareLocked() != hardware || checkUidChangedLocked(connection, callingUid, resolvedUserId)) {
            } else {
                connection.resetLocked(null, null, null, null, null);
            }
        }
    }

    private TvInputHardwareInfo findHardwareInfoForHdmiPortLocked(int port) {
        for (TvInputHardwareInfo hardwareInfo : this.mHardwareList) {
            if (hardwareInfo.getType() == 9 && hardwareInfo.getHdmiPortId() == port) {
                return hardwareInfo;
            }
        }
        return null;
    }

    private int findDeviceIdForInputIdLocked(String inputId) {
        for (int i = 0; i < this.mConnections.size(); i++) {
            if (((Connection) this.mConnections.get(i)).getInfoLocked().getId().equals(inputId)) {
                return i;
            }
        }
        return -1;
    }

    public List<TvStreamConfig> getAvailableTvStreamConfigList(String inputId, int callingUid, int resolvedUserId) {
        List<TvStreamConfig> configsList = new ArrayList();
        synchronized (this.mLock) {
            int deviceId = findDeviceIdForInputIdLocked(inputId);
            if (deviceId < 0) {
                Slog.e(TAG, "Invalid inputId : " + inputId);
            } else {
                for (TvStreamConfig config : ((Connection) this.mConnections.get(deviceId)).getConfigsLocked()) {
                    if (config.getType() == 2) {
                        configsList.add(config);
                    }
                }
            }
        }
        return configsList;
    }

    public boolean captureFrame(String inputId, Surface surface, TvStreamConfig config, int callingUid, int resolvedUserId) {
        boolean z = false;
        synchronized (this.mLock) {
            int deviceId = findDeviceIdForInputIdLocked(inputId);
            if (deviceId < 0) {
                Slog.e(TAG, "Invalid inputId : " + inputId);
            } else {
                Connection connection = (Connection) this.mConnections.get(deviceId);
                TvInputHardwareImpl hardwareImpl = connection.getHardwareImplLocked();
                if (hardwareImpl != null) {
                    Runnable runnable = connection.getOnFirstFrameCapturedLocked();
                    if (runnable != null) {
                        runnable.run();
                        connection.setOnFirstFrameCapturedLocked(null);
                    }
                    z = hardwareImpl.startCapture(surface, config);
                    if (z) {
                        connection.setOnFirstFrameCapturedLocked(new C05292(hardwareImpl, config));
                    }
                }
            }
        }
        return z;
    }

    private void processPendingHdmiDeviceEventsLocked() {
        Iterator<Message> it = this.mPendingHdmiDeviceEvents.iterator();
        while (it.hasNext()) {
            Message msg = (Message) it.next();
            if (findHardwareInfoForHdmiPortLocked(msg.obj.getPortId()) != null) {
                msg.sendToTarget();
                it.remove();
            }
        }
    }

    private void updateVolume() {
        this.mCurrentMaxIndex = this.mAudioManager.getStreamMaxVolume(3);
        this.mCurrentIndex = this.mAudioManager.getStreamVolume(3);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void handleVolumeChange(android.content.Context r9, android.content.Intent r10) {
        /*
        r8 = this;
        r7 = 3;
        r6 = -1;
        r0 = r10.getAction();
        r5 = "android.media.VOLUME_CHANGED_ACTION";
        r5 = r0.equals(r5);
        if (r5 == 0) goto L_0x0044;
    L_0x000e:
        r5 = "android.media.EXTRA_VOLUME_STREAM_TYPE";
        r4 = r10.getIntExtra(r5, r6);
        if (r4 == r7) goto L_0x0017;
    L_0x0016:
        return;
    L_0x0017:
        r5 = "android.media.EXTRA_VOLUME_STREAM_VALUE";
        r6 = 0;
        r3 = r10.getIntExtra(r5, r6);
        r5 = r8.mCurrentIndex;
        if (r3 == r5) goto L_0x0016;
    L_0x0022:
        r8.mCurrentIndex = r3;
    L_0x0024:
        r6 = r8.mLock;
        monitor-enter(r6);
        r2 = 0;
    L_0x0028:
        r5 = r8.mConnections;	 Catch:{ all -> 0x0070 }
        r5 = r5.size();	 Catch:{ all -> 0x0070 }
        if (r2 >= r5) goto L_0x006e;
    L_0x0030:
        r5 = r8.mConnections;	 Catch:{ all -> 0x0070 }
        r5 = r5.valueAt(r2);	 Catch:{ all -> 0x0070 }
        r5 = (com.android.server.tv.TvInputHardwareManager.Connection) r5;	 Catch:{ all -> 0x0070 }
        r1 = r5.getHardwareImplLocked();	 Catch:{ all -> 0x0070 }
        if (r1 == 0) goto L_0x0041;
    L_0x003e:
        r1.onMediaStreamVolumeChanged();	 Catch:{ all -> 0x0070 }
    L_0x0041:
        r2 = r2 + 1;
        goto L_0x0028;
    L_0x0044:
        r5 = "android.media.STREAM_MUTE_CHANGED_ACTION";
        r5 = r0.equals(r5);
        if (r5 == 0) goto L_0x0055;
    L_0x004c:
        r5 = "android.media.EXTRA_VOLUME_STREAM_TYPE";
        r4 = r10.getIntExtra(r5, r6);
        if (r4 == r7) goto L_0x0024;
    L_0x0054:
        goto L_0x0016;
    L_0x0055:
        r5 = TAG;
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r7 = "Unrecognized intent: ";
        r6 = r6.append(r7);
        r6 = r6.append(r10);
        r6 = r6.toString();
        android.util.Slog.w(r5, r6);
        goto L_0x0016;
    L_0x006e:
        monitor-exit(r6);	 Catch:{ all -> 0x0070 }
        goto L_0x0016;
    L_0x0070:
        r5 = move-exception;
        monitor-exit(r6);	 Catch:{ all -> 0x0070 }
        throw r5;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.tv.TvInputHardwareManager.handleVolumeChange(android.content.Context, android.content.Intent):void");
    }

    private float getMediaStreamVolume() {
        return this.mUseMasterVolume ? 1.0f : ((float) this.mCurrentIndex) / ((float) this.mCurrentMaxIndex);
    }
}
