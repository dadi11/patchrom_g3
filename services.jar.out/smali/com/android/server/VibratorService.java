package com.android.server;

import android.app.AppOpsManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.ContentObserver;
import android.hardware.input.InputManager;
import android.hardware.input.InputManager.InputDeviceListener;
import android.media.AudioAttributes;
import android.media.AudioAttributes.Builder;
import android.os.Binder;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.IVibratorService.Stub;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.PowerManagerInternal;
import android.os.PowerManagerInternal.LowPowerModeListener;
import android.os.Process;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.Vibrator;
import android.os.WorkSource;
import android.provider.Settings.SettingNotFoundException;
import android.provider.Settings.System;
import android.util.Slog;
import com.android.internal.app.IAppOpsService;
import com.android.internal.app.IBatteryStats;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.ListIterator;

public class VibratorService extends Stub implements InputDeviceListener {
    private static final boolean DEBUG = false;
    private static final String TAG = "VibratorService";
    private final IAppOpsService mAppOpsService;
    private final IBatteryStats mBatteryStatsService;
    private final Context mContext;
    private int mCurVibUid;
    private Vibration mCurrentVibration;
    private final Handler mH;
    private InputManager mIm;
    private boolean mInputDeviceListenerRegistered;
    private final ArrayList<Vibrator> mInputDeviceVibrators;
    BroadcastReceiver mIntentReceiver;
    private boolean mLowPowerMode;
    private PowerManagerInternal mPowerManagerInternal;
    private SettingsObserver mSettingObserver;
    volatile VibrateThread mThread;
    private final WorkSource mTmpWorkSource;
    private boolean mVibrateInputDevicesSetting;
    private final Runnable mVibrationRunnable;
    private final LinkedList<Vibration> mVibrations;
    private final WakeLock mWakeLock;

    /* renamed from: com.android.server.VibratorService.1 */
    class C00911 implements LowPowerModeListener {
        C00911() {
        }

        public void onLowPowerModeChanged(boolean enabled) {
            VibratorService.this.updateInputDeviceVibrators();
        }
    }

    /* renamed from: com.android.server.VibratorService.2 */
    class C00922 extends BroadcastReceiver {
        C00922() {
        }

        public void onReceive(Context context, Intent intent) {
            VibratorService.this.updateInputDeviceVibrators();
        }
    }

    /* renamed from: com.android.server.VibratorService.3 */
    class C00933 implements Runnable {
        C00933() {
        }

        public void run() {
            synchronized (VibratorService.this.mVibrations) {
                VibratorService.this.doCancelVibrateLocked();
                VibratorService.this.startNextVibrationLocked();
            }
        }
    }

    /* renamed from: com.android.server.VibratorService.4 */
    class C00944 extends BroadcastReceiver {
        C00944() {
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onReceive(android.content.Context r5, android.content.Intent r6) {
            /*
            r4 = this;
            r2 = r6.getAction();
            r3 = "android.intent.action.SCREEN_OFF";
            r2 = r2.equals(r3);
            if (r2 == 0) goto L_0x0057;
        L_0x000c:
            r2 = com.android.server.VibratorService.this;
            r3 = r2.mVibrations;
            monitor-enter(r3);
            r2 = com.android.server.VibratorService.this;	 Catch:{ all -> 0x0053 }
            r2 = r2.mCurrentVibration;	 Catch:{ all -> 0x0053 }
            if (r2 == 0) goto L_0x002c;
        L_0x001b:
            r2 = com.android.server.VibratorService.this;	 Catch:{ all -> 0x0053 }
            r2 = r2.mCurrentVibration;	 Catch:{ all -> 0x0053 }
            r2 = r2.isSystemHapticFeedback();	 Catch:{ all -> 0x0053 }
            if (r2 != 0) goto L_0x002c;
        L_0x0027:
            r2 = com.android.server.VibratorService.this;	 Catch:{ all -> 0x0053 }
            r2.doCancelVibrateLocked();	 Catch:{ all -> 0x0053 }
        L_0x002c:
            r2 = com.android.server.VibratorService.this;	 Catch:{ all -> 0x0053 }
            r2 = r2.mVibrations;	 Catch:{ all -> 0x0053 }
            r0 = r2.iterator();	 Catch:{ all -> 0x0053 }
        L_0x0036:
            r2 = r0.hasNext();	 Catch:{ all -> 0x0053 }
            if (r2 == 0) goto L_0x0056;
        L_0x003c:
            r1 = r0.next();	 Catch:{ all -> 0x0053 }
            r1 = (com.android.server.VibratorService.Vibration) r1;	 Catch:{ all -> 0x0053 }
            r2 = com.android.server.VibratorService.this;	 Catch:{ all -> 0x0053 }
            r2 = r2.mCurrentVibration;	 Catch:{ all -> 0x0053 }
            if (r1 == r2) goto L_0x0036;
        L_0x004a:
            r2 = com.android.server.VibratorService.this;	 Catch:{ all -> 0x0053 }
            r2.unlinkVibration(r1);	 Catch:{ all -> 0x0053 }
            r0.remove();	 Catch:{ all -> 0x0053 }
            goto L_0x0036;
        L_0x0053:
            r2 = move-exception;
            monitor-exit(r3);	 Catch:{ all -> 0x0053 }
            throw r2;
        L_0x0056:
            monitor-exit(r3);	 Catch:{ all -> 0x0053 }
        L_0x0057:
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.VibratorService.4.onReceive(android.content.Context, android.content.Intent):void");
        }
    }

    private final class SettingsObserver extends ContentObserver {
        public SettingsObserver(Handler handler) {
            super(handler);
        }

        public void onChange(boolean SelfChange) {
            VibratorService.this.updateInputDeviceVibrators();
        }
    }

    private class VibrateThread extends Thread {
        boolean mDone;
        final Vibration mVibration;

        VibrateThread(Vibration vib) {
            this.mVibration = vib;
            VibratorService.this.mTmpWorkSource.set(vib.mUid);
            VibratorService.this.mWakeLock.setWorkSource(VibratorService.this.mTmpWorkSource);
            VibratorService.this.mWakeLock.acquire();
        }

        private void delay(long duration) {
            if (duration > 0) {
                long bedtime = duration + SystemClock.uptimeMillis();
                do {
                    try {
                        wait(duration);
                    } catch (InterruptedException e) {
                    }
                    if (!this.mDone) {
                        duration = bedtime - SystemClock.uptimeMillis();
                    } else {
                        return;
                    }
                } while (duration > 0);
            }
        }

        public void run() {
            Process.setThreadPriority(-8);
            synchronized (this) {
                int i;
                long[] pattern = this.mVibration.mPattern;
                int len = pattern.length;
                int repeat = this.mVibration.mRepeat;
                int uid = this.mVibration.mUid;
                int usageHint = this.mVibration.mUsageHint;
                long duration = 0;
                int index = 0;
                while (!this.mDone) {
                    if (index < len) {
                        duration += pattern[index];
                        index++;
                    }
                    delay(duration);
                    if (this.mDone) {
                        i = index;
                        break;
                    } else if (index < len) {
                        i = index + 1;
                        duration = pattern[index];
                        if (duration > 0) {
                            VibratorService.this.doVibratorOn(duration, uid, usageHint);
                            index = i;
                        } else {
                            index = i;
                        }
                    } else if (repeat < 0) {
                        i = index;
                        break;
                    } else {
                        duration = 0;
                        index = repeat;
                    }
                }
                i = index;
                VibratorService.this.mWakeLock.release();
            }
            synchronized (VibratorService.this.mVibrations) {
                if (VibratorService.this.mThread == this) {
                    VibratorService.this.mThread = null;
                }
                if (!this.mDone) {
                    VibratorService.this.mVibrations.remove(this.mVibration);
                    VibratorService.this.unlinkVibration(this.mVibration);
                    VibratorService.this.startNextVibrationLocked();
                }
            }
        }
    }

    private class Vibration implements DeathRecipient {
        private final String mOpPkg;
        private final long[] mPattern;
        private final int mRepeat;
        private final long mStartTime;
        private final long mTimeout;
        private final IBinder mToken;
        private final int mUid;
        private final int mUsageHint;

        Vibration(VibratorService vibratorService, IBinder token, long millis, int usageHint, int uid, String opPkg) {
            this(token, millis, null, 0, usageHint, uid, opPkg);
        }

        Vibration(VibratorService vibratorService, IBinder token, long[] pattern, int repeat, int usageHint, int uid, String opPkg) {
            this(token, 0, pattern, repeat, usageHint, uid, opPkg);
        }

        private Vibration(IBinder token, long millis, long[] pattern, int repeat, int usageHint, int uid, String opPkg) {
            this.mToken = token;
            this.mTimeout = millis;
            this.mStartTime = SystemClock.uptimeMillis();
            this.mPattern = pattern;
            this.mRepeat = repeat;
            this.mUsageHint = usageHint;
            this.mUid = uid;
            this.mOpPkg = opPkg;
        }

        public void binderDied() {
            synchronized (VibratorService.this.mVibrations) {
                VibratorService.this.mVibrations.remove(this);
                if (this == VibratorService.this.mCurrentVibration) {
                    VibratorService.this.doCancelVibrateLocked();
                    VibratorService.this.startNextVibrationLocked();
                }
            }
        }

        public boolean hasLongerTimeout(long millis) {
            if (this.mTimeout != 0 && this.mStartTime + this.mTimeout >= SystemClock.uptimeMillis() + millis) {
                return true;
            }
            return VibratorService.DEBUG;
        }

        public boolean isSystemHapticFeedback() {
            return ((this.mUid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || this.mUid == 0) && this.mRepeat < 0) ? true : VibratorService.DEBUG;
        }
    }

    static native boolean vibratorExists();

    static native void vibratorOff();

    static native void vibratorOn(long j);

    VibratorService(Context context) {
        this.mTmpWorkSource = new WorkSource();
        this.mH = new Handler();
        this.mInputDeviceVibrators = new ArrayList();
        this.mCurVibUid = -1;
        this.mVibrationRunnable = new C00933();
        this.mIntentReceiver = new C00944();
        vibratorOff();
        this.mContext = context;
        this.mWakeLock = ((PowerManager) context.getSystemService("power")).newWakeLock(1, "*vibrator*");
        this.mWakeLock.setReferenceCounted(true);
        this.mAppOpsService = IAppOpsService.Stub.asInterface(ServiceManager.getService("appops"));
        this.mBatteryStatsService = IBatteryStats.Stub.asInterface(ServiceManager.getService("batterystats"));
        this.mVibrations = new LinkedList();
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.SCREEN_OFF");
        context.registerReceiver(this.mIntentReceiver, filter);
    }

    public void systemReady() {
        this.mIm = (InputManager) this.mContext.getSystemService("input");
        this.mSettingObserver = new SettingsObserver(this.mH);
        this.mPowerManagerInternal = (PowerManagerInternal) LocalServices.getService(PowerManagerInternal.class);
        this.mPowerManagerInternal.registerLowPowerModeObserver(new C00911());
        this.mContext.getContentResolver().registerContentObserver(System.getUriFor("vibrate_input_devices"), true, this.mSettingObserver, -1);
        this.mContext.registerReceiver(new C00922(), new IntentFilter("android.intent.action.USER_SWITCHED"), null, this.mH);
        updateInputDeviceVibrators();
    }

    public boolean hasVibrator() {
        return doVibratorExists();
    }

    private void verifyIncomingUid(int uid) {
        if (uid != Binder.getCallingUid() && Binder.getCallingPid() != Process.myPid()) {
            this.mContext.enforcePermission("android.permission.UPDATE_APP_OPS_STATS", Binder.getCallingPid(), Binder.getCallingUid(), null);
        }
    }

    public void vibrate(int uid, String opPkg, long milliseconds, int usageHint, IBinder token) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.VIBRATE") != 0) {
            throw new SecurityException("Requires VIBRATE permission");
        }
        verifyIncomingUid(uid);
        if (milliseconds <= 0) {
            return;
        }
        if (this.mCurrentVibration == null || !this.mCurrentVibration.hasLongerTimeout(milliseconds)) {
            Vibration vib = new Vibration(this, token, milliseconds, usageHint, uid, opPkg);
            long ident = Binder.clearCallingIdentity();
            try {
                synchronized (this.mVibrations) {
                    removeVibrationLocked(token);
                    doCancelVibrateLocked();
                    this.mCurrentVibration = vib;
                    startVibrationLocked(vib);
                }
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    private boolean isAll0(long[] pattern) {
        for (long j : pattern) {
            if (j != 0) {
                return DEBUG;
            }
        }
        return true;
    }

    public void vibratePattern(int uid, String packageName, long[] pattern, int repeat, int usageHint, IBinder token) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.VIBRATE") != 0) {
            throw new SecurityException("Requires VIBRATE permission");
        }
        verifyIncomingUid(uid);
        long identity = Binder.clearCallingIdentity();
        if (pattern != null) {
            try {
                if (!(pattern.length == 0 || isAll0(pattern) || repeat >= pattern.length || token == null)) {
                    Vibration vib = new Vibration(this, token, pattern, repeat, usageHint, uid, packageName);
                    try {
                        token.linkToDeath(vib, 0);
                        synchronized (this.mVibrations) {
                            removeVibrationLocked(token);
                            doCancelVibrateLocked();
                            if (repeat >= 0) {
                                this.mVibrations.addFirst(vib);
                                startNextVibrationLocked();
                            } else {
                                this.mCurrentVibration = vib;
                                startVibrationLocked(vib);
                            }
                        }
                        Binder.restoreCallingIdentity(identity);
                        return;
                    } catch (RemoteException e) {
                        Binder.restoreCallingIdentity(identity);
                        return;
                    }
                }
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(identity);
            }
        }
        Binder.restoreCallingIdentity(identity);
    }

    public void cancelVibrate(IBinder token) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.VIBRATE", "cancelVibrate");
        long identity = Binder.clearCallingIdentity();
        try {
            synchronized (this.mVibrations) {
                if (removeVibrationLocked(token) == this.mCurrentVibration) {
                    doCancelVibrateLocked();
                    startNextVibrationLocked();
                }
            }
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
    }

    private void doCancelVibrateLocked() {
        if (this.mThread != null) {
            synchronized (this.mThread) {
                this.mThread.mDone = true;
                this.mThread.notify();
            }
            this.mThread = null;
        }
        doVibratorOff();
        this.mH.removeCallbacks(this.mVibrationRunnable);
        reportFinishVibrationLocked();
    }

    private void startNextVibrationLocked() {
        if (this.mVibrations.size() <= 0) {
            reportFinishVibrationLocked();
            this.mCurrentVibration = null;
            return;
        }
        this.mCurrentVibration = (Vibration) this.mVibrations.getFirst();
        startVibrationLocked(this.mCurrentVibration);
    }

    private void startVibrationLocked(Vibration vib) {
        try {
            if (!this.mLowPowerMode || vib.mUsageHint == 6) {
                int mode = this.mAppOpsService.checkAudioOperation(3, vib.mUsageHint, vib.mUid, vib.mOpPkg);
                if (mode == 0) {
                    mode = this.mAppOpsService.startOperation(AppOpsManager.getToken(this.mAppOpsService), 3, vib.mUid, vib.mOpPkg);
                }
                if (mode != 0) {
                    if (mode == 2) {
                        Slog.w(TAG, "Would be an error: vibrate from uid " + vib.mUid);
                    }
                    this.mH.post(this.mVibrationRunnable);
                    return;
                }
                if (vib.mTimeout != 0) {
                    doVibratorOn(vib.mTimeout, vib.mUid, vib.mUsageHint);
                    this.mH.postDelayed(this.mVibrationRunnable, vib.mTimeout);
                    return;
                }
                this.mThread = new VibrateThread(vib);
                this.mThread.start();
            }
        } catch (RemoteException e) {
        }
    }

    private void reportFinishVibrationLocked() {
        if (this.mCurrentVibration != null) {
            try {
                this.mAppOpsService.finishOperation(AppOpsManager.getToken(this.mAppOpsService), 3, this.mCurrentVibration.mUid, this.mCurrentVibration.mOpPkg);
            } catch (RemoteException e) {
            }
            this.mCurrentVibration = null;
        }
    }

    private Vibration removeVibrationLocked(IBinder token) {
        ListIterator<Vibration> iter = this.mVibrations.listIterator(0);
        while (iter.hasNext()) {
            Vibration vib = (Vibration) iter.next();
            if (vib.mToken == token) {
                iter.remove();
                unlinkVibration(vib);
                return vib;
            }
        }
        if (this.mCurrentVibration == null || this.mCurrentVibration.mToken != token) {
            return null;
        }
        unlinkVibration(this.mCurrentVibration);
        return this.mCurrentVibration;
    }

    private void unlinkVibration(Vibration vib) {
        if (vib.mPattern != null) {
            vib.mToken.unlinkToDeath(vib, 0);
        }
    }

    private void updateInputDeviceVibrators() {
        boolean z = true;
        synchronized (this.mVibrations) {
            doCancelVibrateLocked();
            synchronized (this.mInputDeviceVibrators) {
                this.mVibrateInputDevicesSetting = DEBUG;
                try {
                    if (System.getIntForUser(this.mContext.getContentResolver(), "vibrate_input_devices", -2) <= 0) {
                        z = DEBUG;
                    }
                    this.mVibrateInputDevicesSetting = z;
                } catch (SettingNotFoundException e) {
                }
                this.mLowPowerMode = this.mPowerManagerInternal.getLowPowerModeEnabled();
                if (this.mVibrateInputDevicesSetting) {
                    if (!this.mInputDeviceListenerRegistered) {
                        this.mInputDeviceListenerRegistered = true;
                        this.mIm.registerInputDeviceListener(this, this.mH);
                    }
                } else if (this.mInputDeviceListenerRegistered) {
                    this.mInputDeviceListenerRegistered = DEBUG;
                    this.mIm.unregisterInputDeviceListener(this);
                }
                this.mInputDeviceVibrators.clear();
                if (this.mVibrateInputDevicesSetting) {
                    int[] ids = this.mIm.getInputDeviceIds();
                    for (int inputDevice : ids) {
                        Vibrator vibrator = this.mIm.getInputDevice(inputDevice).getVibrator();
                        if (vibrator.hasVibrator()) {
                            this.mInputDeviceVibrators.add(vibrator);
                        }
                    }
                }
            }
            startNextVibrationLocked();
        }
    }

    public void onInputDeviceAdded(int deviceId) {
        updateInputDeviceVibrators();
    }

    public void onInputDeviceChanged(int deviceId) {
        updateInputDeviceVibrators();
    }

    public void onInputDeviceRemoved(int deviceId) {
        updateInputDeviceVibrators();
    }

    private boolean doVibratorExists() {
        return vibratorExists();
    }

    private void doVibratorOn(long millis, int uid, int usageHint) {
        synchronized (this.mInputDeviceVibrators) {
            try {
                this.mBatteryStatsService.noteVibratorOn(uid, millis);
                this.mCurVibUid = uid;
            } catch (RemoteException e) {
            }
            int vibratorCount = this.mInputDeviceVibrators.size();
            if (vibratorCount != 0) {
                AudioAttributes attributes = new Builder().setUsage(usageHint).build();
                for (int i = 0; i < vibratorCount; i++) {
                    ((Vibrator) this.mInputDeviceVibrators.get(i)).vibrate(millis, attributes);
                }
            } else {
                vibratorOn(millis);
            }
        }
    }

    private void doVibratorOff() {
        synchronized (this.mInputDeviceVibrators) {
            if (this.mCurVibUid >= 0) {
                try {
                    this.mBatteryStatsService.noteVibratorOff(this.mCurVibUid);
                } catch (RemoteException e) {
                }
                this.mCurVibUid = -1;
            }
            int vibratorCount = this.mInputDeviceVibrators.size();
            if (vibratorCount != 0) {
                for (int i = 0; i < vibratorCount; i++) {
                    ((Vibrator) this.mInputDeviceVibrators.get(i)).cancel();
                }
            } else {
                vibratorOff();
            }
        }
    }
}
