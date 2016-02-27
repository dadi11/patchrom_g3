package com.android.server.voiceinteraction;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.soundtrigger.IRecognitionStatusCallback;
import android.hardware.soundtrigger.SoundTrigger;
import android.hardware.soundtrigger.SoundTrigger.KeyphraseRecognitionEvent;
import android.hardware.soundtrigger.SoundTrigger.KeyphraseRecognitionExtra;
import android.hardware.soundtrigger.SoundTrigger.KeyphraseSoundModel;
import android.hardware.soundtrigger.SoundTrigger.ModuleProperties;
import android.hardware.soundtrigger.SoundTrigger.RecognitionConfig;
import android.hardware.soundtrigger.SoundTrigger.RecognitionEvent;
import android.hardware.soundtrigger.SoundTrigger.SoundModelEvent;
import android.hardware.soundtrigger.SoundTrigger.StatusListener;
import android.hardware.soundtrigger.SoundTriggerModule;
import android.os.PowerManager;
import android.os.RemoteException;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;
import android.util.Slog;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;

public class SoundTriggerHelper implements StatusListener {
    static final boolean DBG = false;
    private static final int INVALID_VALUE = Integer.MIN_VALUE;
    public static final int STATUS_ERROR = Integer.MIN_VALUE;
    public static final int STATUS_OK = 0;
    static final String TAG = "SoundTriggerHelper";
    private IRecognitionStatusCallback mActiveListener;
    private boolean mCallActive;
    private final Context mContext;
    private KeyphraseSoundModel mCurrentSoundModel;
    private int mCurrentSoundModelHandle;
    private boolean mIsPowerSaveMode;
    private int mKeyphraseId;
    private final Object mLock;
    private SoundTriggerModule mModule;
    private final PhoneStateListener mPhoneStateListener;
    private final PowerManager mPowerManager;
    private PowerSaveModeListener mPowerSaveModeListener;
    private RecognitionConfig mRecognitionConfig;
    private boolean mRequested;
    private boolean mServiceDisabled;
    private boolean mStarted;
    private final TelephonyManager mTelephonyManager;
    final ModuleProperties moduleProperties;

    class MyCallStateListener extends PhoneStateListener {
        MyCallStateListener() {
        }

        public void onCallStateChanged(int state, String arg1) {
            synchronized (SoundTriggerHelper.this.mLock) {
                SoundTriggerHelper.this.onCallStateChangedLocked(state != 0 ? true : SoundTriggerHelper.DBG);
            }
        }
    }

    class PowerSaveModeListener extends BroadcastReceiver {
        PowerSaveModeListener() {
        }

        public void onReceive(Context context, Intent intent) {
            if ("android.os.action.POWER_SAVE_MODE_CHANGED".equals(intent.getAction())) {
                boolean active = SoundTriggerHelper.this.mPowerManager.isPowerSaveMode();
                synchronized (SoundTriggerHelper.this.mLock) {
                    SoundTriggerHelper.this.onPowerSaveModeChangedLocked(active);
                }
            }
        }
    }

    SoundTriggerHelper(Context context) {
        this.mLock = new Object();
        this.mKeyphraseId = STATUS_ERROR;
        this.mCurrentSoundModelHandle = STATUS_ERROR;
        this.mCurrentSoundModel = null;
        this.mRecognitionConfig = null;
        this.mRequested = DBG;
        this.mCallActive = DBG;
        this.mIsPowerSaveMode = DBG;
        this.mServiceDisabled = DBG;
        this.mStarted = DBG;
        ArrayList<ModuleProperties> modules = new ArrayList();
        int status = SoundTrigger.listModules(modules);
        this.mContext = context;
        this.mTelephonyManager = (TelephonyManager) context.getSystemService("phone");
        this.mPowerManager = (PowerManager) context.getSystemService("power");
        this.mPhoneStateListener = new MyCallStateListener();
        if (status != 0 || modules.size() == 0) {
            Slog.w(TAG, "listModules status=" + status + ", # of modules=" + modules.size());
            this.moduleProperties = null;
            this.mModule = null;
            return;
        }
        this.moduleProperties = (ModuleProperties) modules.get(STATUS_OK);
    }

    int startRecognition(int keyphraseId, KeyphraseSoundModel soundModel, IRecognitionStatusCallback listener, RecognitionConfig recognitionConfig) {
        boolean z = true;
        if (soundModel == null || listener == null || recognitionConfig == null) {
            return STATUS_ERROR;
        }
        synchronized (this.mLock) {
            if (!this.mStarted) {
                if (this.mTelephonyManager.getCallState() == 0) {
                    z = DBG;
                }
                this.mCallActive = z;
                this.mTelephonyManager.listen(this.mPhoneStateListener, 32);
                if (this.mPowerSaveModeListener == null) {
                    this.mPowerSaveModeListener = new PowerSaveModeListener();
                    this.mContext.registerReceiver(this.mPowerSaveModeListener, new IntentFilter("android.os.action.POWER_SAVE_MODE_CHANGED"));
                }
                this.mIsPowerSaveMode = this.mPowerManager.isPowerSaveMode();
            }
            if (this.moduleProperties == null) {
                Slog.w(TAG, "Attempting startRecognition without the capability");
                return STATUS_ERROR;
            }
            int status;
            if (this.mModule == null) {
                this.mModule = SoundTrigger.attachModule(this.moduleProperties.id, this, null);
                if (this.mModule == null) {
                    Slog.w(TAG, "startRecognition cannot attach to sound trigger module");
                    return STATUS_ERROR;
                }
            }
            if (!(this.mCurrentSoundModelHandle == STATUS_ERROR || soundModel.equals(this.mCurrentSoundModel))) {
                Slog.w(TAG, "Unloading previous sound model");
                status = this.mModule.unloadSoundModel(this.mCurrentSoundModelHandle);
                if (status != 0) {
                    Slog.w(TAG, "unloadSoundModel call failed with " + status);
                }
                internalClearSoundModelLocked();
                this.mStarted = DBG;
            }
            if (!(this.mActiveListener == null || this.mActiveListener.asBinder() == listener.asBinder())) {
                Slog.w(TAG, "Canceling previous recognition");
                try {
                    this.mActiveListener.onError(STATUS_ERROR);
                } catch (RemoteException e) {
                    Slog.w(TAG, "RemoteException in onDetectionStopped", e);
                }
                this.mActiveListener = null;
            }
            int soundModelHandle = this.mCurrentSoundModelHandle;
            if (this.mCurrentSoundModelHandle == STATUS_ERROR || this.mCurrentSoundModel == null) {
                int[] handle = new int[]{STATUS_ERROR};
                status = this.mModule.loadSoundModel(soundModel, handle);
                if (status != 0) {
                    Slog.w(TAG, "loadSoundModel call failed with " + status);
                    return status;
                } else if (handle[STATUS_OK] == STATUS_ERROR) {
                    Slog.w(TAG, "loadSoundModel call returned invalid sound model handle");
                    return STATUS_ERROR;
                } else {
                    soundModelHandle = handle[STATUS_OK];
                }
            }
            this.mRequested = true;
            this.mKeyphraseId = keyphraseId;
            this.mCurrentSoundModelHandle = soundModelHandle;
            this.mCurrentSoundModel = soundModel;
            this.mRecognitionConfig = recognitionConfig;
            this.mActiveListener = listener;
            status = updateRecognitionLocked(DBG);
            return status;
        }
    }

    int stopRecognition(int keyphraseId, IRecognitionStatusCallback listener) {
        int i = STATUS_ERROR;
        if (listener != null) {
            synchronized (this.mLock) {
                if (this.moduleProperties == null || this.mModule == null) {
                    Slog.w(TAG, "Attempting stopRecognition without the capability");
                } else if (this.mActiveListener == null) {
                    Slog.w(TAG, "Attempting stopRecognition without a successful startRecognition");
                } else if (this.mActiveListener.asBinder() != listener.asBinder()) {
                    Slog.w(TAG, "Attempting stopRecognition for another recognition");
                } else {
                    this.mRequested = DBG;
                    i = updateRecognitionLocked(DBG);
                    if (i != 0) {
                    } else {
                        internalClearStateLocked();
                    }
                }
            }
        }
        return i;
    }

    void stopAllRecognitions() {
        synchronized (this.mLock) {
            if (this.moduleProperties == null || this.mModule == null) {
            } else if (this.mCurrentSoundModelHandle == STATUS_ERROR) {
            } else {
                this.mRequested = DBG;
                int status = updateRecognitionLocked(DBG);
                internalClearStateLocked();
            }
        }
    }

    public void onRecognition(RecognitionEvent event) {
        if (event == null || !(event instanceof KeyphraseRecognitionEvent)) {
            Slog.w(TAG, "Invalid recognition event!");
            return;
        }
        synchronized (this.mLock) {
            if (this.mActiveListener == null) {
                Slog.w(TAG, "received onRecognition event without any listener for it");
                return;
            }
            switch (event.status) {
                case STATUS_OK /*0*/:
                    onRecognitionSuccessLocked((KeyphraseRecognitionEvent) event);
                    break;
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                    onRecognitionAbortLocked();
                    break;
                case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                    onRecognitionFailureLocked();
                    break;
            }
        }
    }

    public void onSoundModelUpdate(SoundModelEvent event) {
        if (event == null) {
            Slog.w(TAG, "Invalid sound model event!");
            return;
        }
        synchronized (this.mLock) {
            onSoundModelUpdatedLocked(event);
        }
    }

    public void onServiceStateChange(int state) {
        boolean z = true;
        synchronized (this.mLock) {
            if (1 != state) {
                z = DBG;
            }
            onServiceStateChangedLocked(z);
        }
    }

    public void onServiceDied() {
        Slog.e(TAG, "onServiceDied!!");
        synchronized (this.mLock) {
            onServiceDiedLocked();
        }
    }

    private void onCallStateChangedLocked(boolean callActive) {
        if (this.mCallActive != callActive) {
            this.mCallActive = callActive;
            updateRecognitionLocked(true);
        }
    }

    private void onPowerSaveModeChangedLocked(boolean isPowerSaveMode) {
        if (this.mIsPowerSaveMode != isPowerSaveMode) {
            this.mIsPowerSaveMode = isPowerSaveMode;
            updateRecognitionLocked(true);
        }
    }

    private void onSoundModelUpdatedLocked(SoundModelEvent event) {
    }

    private void onServiceStateChangedLocked(boolean disabled) {
        if (disabled != this.mServiceDisabled) {
            this.mServiceDisabled = disabled;
            updateRecognitionLocked(true);
        }
    }

    private void onRecognitionAbortLocked() {
        Slog.w(TAG, "Recognition aborted");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void onRecognitionFailureLocked() {
        /*
        r3 = this;
        r1 = "SoundTriggerHelper";
        r2 = "Recognition failure";
        android.util.Slog.w(r1, r2);
        r1 = r3.mActiveListener;	 Catch:{ RemoteException -> 0x0016 }
        if (r1 == 0) goto L_0x0012;
    L_0x000b:
        r1 = r3.mActiveListener;	 Catch:{ RemoteException -> 0x0016 }
        r2 = -2147483648; // 0xffffffff80000000 float:-0.0 double:NaN;
        r1.onError(r2);	 Catch:{ RemoteException -> 0x0016 }
    L_0x0012:
        r3.internalClearStateLocked();
    L_0x0015:
        return;
    L_0x0016:
        r0 = move-exception;
        r1 = "SoundTriggerHelper";
        r2 = "RemoteException in onError";
        android.util.Slog.w(r1, r2, r0);	 Catch:{ all -> 0x0022 }
        r3.internalClearStateLocked();
        goto L_0x0015;
    L_0x0022:
        r1 = move-exception;
        r3.internalClearStateLocked();
        throw r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.voiceinteraction.SoundTriggerHelper.onRecognitionFailureLocked():void");
    }

    private void onRecognitionSuccessLocked(KeyphraseRecognitionEvent event) {
        Slog.i(TAG, "Recognition success");
        KeyphraseRecognitionExtra[] keyphraseExtras = event.keyphraseExtras;
        if (keyphraseExtras == null || keyphraseExtras.length == 0) {
            Slog.w(TAG, "Invalid keyphrase recognition event!");
        } else if (this.mKeyphraseId != keyphraseExtras[STATUS_OK].id) {
            Slog.w(TAG, "received onRecognition event for a different keyphrase");
        } else {
            try {
                if (this.mActiveListener != null) {
                    this.mActiveListener.onDetected(event);
                }
            } catch (RemoteException e) {
                Slog.w(TAG, "RemoteException in onDetected", e);
            }
            this.mStarted = DBG;
            this.mRequested = this.mRecognitionConfig.allowMultipleTriggers;
            if (this.mRequested) {
                updateRecognitionLocked(true);
            }
        }
    }

    private void onServiceDiedLocked() {
        try {
            if (this.mActiveListener != null) {
                this.mActiveListener.onError(-32);
            }
            internalClearSoundModelLocked();
            internalClearStateLocked();
            if (this.mModule != null) {
                this.mModule.detach();
                this.mModule = null;
            }
        } catch (RemoteException e) {
            Slog.w(TAG, "RemoteException in onError", e);
            internalClearSoundModelLocked();
            internalClearStateLocked();
            if (this.mModule != null) {
                this.mModule.detach();
                this.mModule = null;
            }
        } catch (Throwable th) {
            internalClearSoundModelLocked();
            internalClearStateLocked();
            if (this.mModule != null) {
                this.mModule.detach();
                this.mModule = null;
            }
        }
    }

    private int updateRecognitionLocked(boolean notify) {
        if (this.mModule == null || this.moduleProperties == null || this.mCurrentSoundModelHandle == STATUS_ERROR || this.mActiveListener == null) {
            return STATUS_OK;
        }
        boolean start;
        if (!this.mRequested || this.mCallActive || this.mServiceDisabled || this.mIsPowerSaveMode) {
            start = DBG;
        } else {
            start = true;
        }
        if (start == this.mStarted) {
            return STATUS_OK;
        }
        int status;
        if (start) {
            status = this.mModule.startRecognition(this.mCurrentSoundModelHandle, this.mRecognitionConfig);
            if (status != 0) {
                Slog.w(TAG, "startRecognition failed with " + status);
                if (notify) {
                    try {
                        this.mActiveListener.onError(status);
                    } catch (RemoteException e) {
                        Slog.w(TAG, "RemoteException in onError", e);
                    }
                }
            } else {
                this.mStarted = true;
                if (notify) {
                    try {
                        this.mActiveListener.onRecognitionResumed();
                    } catch (RemoteException e2) {
                        Slog.w(TAG, "RemoteException in onRecognitionResumed", e2);
                    }
                }
            }
            return status;
        }
        status = this.mModule.stopRecognition(this.mCurrentSoundModelHandle);
        if (status != 0) {
            Slog.w(TAG, "stopRecognition call failed with " + status);
            if (notify) {
                try {
                    this.mActiveListener.onError(status);
                } catch (RemoteException e22) {
                    Slog.w(TAG, "RemoteException in onError", e22);
                }
            }
        } else {
            this.mStarted = DBG;
            if (notify) {
                try {
                    this.mActiveListener.onRecognitionPaused();
                } catch (RemoteException e222) {
                    Slog.w(TAG, "RemoteException in onRecognitionPaused", e222);
                }
            }
        }
        return status;
    }

    private void internalClearStateLocked() {
        this.mStarted = DBG;
        this.mRequested = DBG;
        this.mKeyphraseId = STATUS_ERROR;
        this.mRecognitionConfig = null;
        this.mActiveListener = null;
        this.mTelephonyManager.listen(this.mPhoneStateListener, STATUS_OK);
        if (this.mPowerSaveModeListener != null) {
            this.mContext.unregisterReceiver(this.mPowerSaveModeListener);
            this.mPowerSaveModeListener = null;
        }
    }

    private void internalClearSoundModelLocked() {
        this.mCurrentSoundModelHandle = STATUS_ERROR;
        this.mCurrentSoundModel = null;
    }

    void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        synchronized (this.mLock) {
            pw.print("  module properties=");
            pw.println(this.moduleProperties == null ? "null" : this.moduleProperties);
            pw.print("  keyphrase ID=");
            pw.println(this.mKeyphraseId);
            pw.print("  sound model handle=");
            pw.println(this.mCurrentSoundModelHandle);
            pw.print("  sound model UUID=");
            pw.println(this.mCurrentSoundModel == null ? "null" : this.mCurrentSoundModel.uuid);
            pw.print("  current listener=");
            pw.println(this.mActiveListener == null ? "null" : this.mActiveListener.asBinder());
            pw.print("  requested=");
            pw.println(this.mRequested);
            pw.print("  started=");
            pw.println(this.mStarted);
            pw.print("  call active=");
            pw.println(this.mCallActive);
            pw.print("  power save mode active=");
            pw.println(this.mIsPowerSaveMode);
            pw.print("  service disabled=");
            pw.println(this.mServiceDisabled);
        }
    }
}
