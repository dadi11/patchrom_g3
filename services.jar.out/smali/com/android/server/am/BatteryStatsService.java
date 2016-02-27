package com.android.server.am;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothHeadset;
import android.bluetooth.BluetoothProfile;
import android.bluetooth.BluetoothProfile.ServiceListener;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Binder;
import android.os.Handler;
import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.PowerManagerInternal;
import android.os.PowerManagerInternal.LowPowerModeListener;
import android.os.Process;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.WorkSource;
import android.telephony.SignalStrength;
import android.telephony.TelephonyManager;
import android.util.Slog;
import com.android.internal.app.IBatteryStats;
import com.android.internal.app.IBatteryStats.Stub;
import com.android.internal.os.BatteryStatsHelper;
import com.android.internal.os.BatteryStatsImpl;
import com.android.internal.os.PowerProfile;
import com.android.server.LocalServices;
import java.io.File;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public final class BatteryStatsService extends Stub implements LowPowerModeListener {
    static final String TAG = "BatteryStatsService";
    static IBatteryStats sService;
    private BluetoothHeadset mBluetoothHeadset;
    private boolean mBluetoothPendingStats;
    private ServiceListener mBluetoothProfileServiceListener;
    Context mContext;
    PowerManagerInternal mPowerManagerInternal;
    final BatteryStatsImpl mStats;

    /* renamed from: com.android.server.am.BatteryStatsService.1 */
    class C01381 implements ServiceListener {
        C01381() {
        }

        public void onServiceConnected(int profile, BluetoothProfile proxy) {
            BatteryStatsService.this.mBluetoothHeadset = (BluetoothHeadset) proxy;
            synchronized (BatteryStatsService.this.mStats) {
                if (BatteryStatsService.this.mBluetoothPendingStats) {
                    BatteryStatsService.this.mStats.noteBluetoothOnLocked();
                    BatteryStatsService.this.mStats.setBtHeadset(BatteryStatsService.this.mBluetoothHeadset);
                    BatteryStatsService.this.mBluetoothPendingStats = false;
                }
            }
        }

        public void onServiceDisconnected(int profile) {
            BatteryStatsService.this.mBluetoothHeadset = null;
        }
    }

    final class WakeupReasonThread extends Thread {
        final int[] mIrqs;
        final String[] mReasons;

        WakeupReasonThread() {
            super("BatteryStats_wakeupReason");
            this.mIrqs = new int[32];
            this.mReasons = new String[32];
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void run() {
            /*
            r6 = this;
            r3 = -2;
            android.os.Process.setThreadPriority(r3);
        L_0x0004:
            r3 = r6.mIrqs;	 Catch:{ RuntimeException -> 0x0034 }
            r4 = r6.mReasons;	 Catch:{ RuntimeException -> 0x0034 }
            r2 = com.android.server.am.BatteryStatsService.nativeWaitWakeup(r3, r4);	 Catch:{ RuntimeException -> 0x0034 }
            if (r2 < 0) goto L_0x003c;
        L_0x000e:
            r3 = com.android.server.am.BatteryStatsService.this;	 Catch:{ RuntimeException -> 0x0034 }
            r4 = r3.mStats;	 Catch:{ RuntimeException -> 0x0034 }
            monitor-enter(r4);	 Catch:{ RuntimeException -> 0x0034 }
            if (r2 <= 0) goto L_0x0026;
        L_0x0015:
            r1 = 0;
        L_0x0016:
            if (r1 >= r2) goto L_0x002f;
        L_0x0018:
            r3 = com.android.server.am.BatteryStatsService.this;	 Catch:{ all -> 0x0031 }
            r3 = r3.mStats;	 Catch:{ all -> 0x0031 }
            r5 = r6.mReasons;	 Catch:{ all -> 0x0031 }
            r5 = r5[r1];	 Catch:{ all -> 0x0031 }
            r3.noteWakeupReasonLocked(r5);	 Catch:{ all -> 0x0031 }
            r1 = r1 + 1;
            goto L_0x0016;
        L_0x0026:
            r3 = com.android.server.am.BatteryStatsService.this;	 Catch:{ all -> 0x0031 }
            r3 = r3.mStats;	 Catch:{ all -> 0x0031 }
            r5 = "unknown";
            r3.noteWakeupReasonLocked(r5);	 Catch:{ all -> 0x0031 }
        L_0x002f:
            monitor-exit(r4);	 Catch:{ all -> 0x0031 }
            goto L_0x0004;
        L_0x0031:
            r3 = move-exception;
            monitor-exit(r4);	 Catch:{ all -> 0x0031 }
            throw r3;	 Catch:{ RuntimeException -> 0x0034 }
        L_0x0034:
            r0 = move-exception;
            r3 = "BatteryStatsService";
            r4 = "Failure reading wakeup reasons";
            android.util.Slog.e(r3, r4, r0);
        L_0x003c:
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.BatteryStatsService.WakeupReasonThread.run():void");
        }
    }

    private static native int nativeWaitWakeup(int[] iArr, String[] strArr);

    BatteryStatsService(File systemDir, Handler handler) {
        this.mBluetoothProfileServiceListener = new C01381();
        this.mStats = new BatteryStatsImpl(systemDir, handler);
    }

    public void publish(Context context) {
        this.mContext = context;
        ServiceManager.addService("batterystats", asBinder());
        this.mStats.setNumSpeedSteps(new PowerProfile(this.mContext).getNumSpeedSteps());
        this.mStats.setRadioScanningTimeout(((long) this.mContext.getResources().getInteger(17694732)) * 1000);
    }

    public void initPowerManagement() {
        this.mPowerManagerInternal = (PowerManagerInternal) LocalServices.getService(PowerManagerInternal.class);
        this.mPowerManagerInternal.registerLowPowerModeObserver(this);
        this.mStats.noteLowPowerMode(this.mPowerManagerInternal.getLowPowerModeEnabled());
        new WakeupReasonThread().start();
    }

    public void shutdown() {
        Slog.w("BatteryStats", "Writing battery stats before shutdown...");
        synchronized (this.mStats) {
            this.mStats.shutdownLocked();
        }
    }

    public static IBatteryStats getService() {
        if (sService != null) {
            return sService;
        }
        sService = asInterface(ServiceManager.getService("batterystats"));
        return sService;
    }

    public void onLowPowerModeChanged(boolean enabled) {
        synchronized (this.mStats) {
            this.mStats.noteLowPowerMode(enabled);
        }
    }

    public BatteryStatsImpl getActiveStatistics() {
        return this.mStats;
    }

    void addIsolatedUid(int isolatedUid, int appUid) {
        synchronized (this.mStats) {
            this.mStats.addIsolatedUidLocked(isolatedUid, appUid);
        }
    }

    void removeIsolatedUid(int isolatedUid, int appUid) {
        synchronized (this.mStats) {
            this.mStats.removeIsolatedUidLocked(isolatedUid, appUid);
        }
    }

    void noteProcessStart(String name, int uid) {
        synchronized (this.mStats) {
            this.mStats.noteProcessStartLocked(name, uid);
        }
    }

    void noteProcessCrash(String name, int uid) {
        synchronized (this.mStats) {
            this.mStats.noteProcessCrashLocked(name, uid);
        }
    }

    void noteProcessAnr(String name, int uid) {
        synchronized (this.mStats) {
            this.mStats.noteProcessAnrLocked(name, uid);
        }
    }

    void noteProcessState(String name, int uid, int state) {
        synchronized (this.mStats) {
            this.mStats.noteProcessStateLocked(name, uid, state);
        }
    }

    void noteProcessFinish(String name, int uid) {
        synchronized (this.mStats) {
            this.mStats.noteProcessFinishLocked(name, uid);
        }
    }

    public byte[] getStatistics() {
        this.mContext.enforceCallingPermission("android.permission.BATTERY_STATS", null);
        Parcel out = Parcel.obtain();
        this.mStats.writeToParcel(out, 0);
        byte[] data = out.marshall();
        out.recycle();
        return data;
    }

    public ParcelFileDescriptor getStatisticsStream() {
        ParcelFileDescriptor parcelFileDescriptor = null;
        this.mContext.enforceCallingPermission("android.permission.BATTERY_STATS", parcelFileDescriptor);
        Parcel out = Parcel.obtain();
        this.mStats.writeToParcel(out, 0);
        byte[] data = out.marshall();
        out.recycle();
        try {
            parcelFileDescriptor = ParcelFileDescriptor.fromData(data, "battery-stats");
        } catch (IOException e) {
            Slog.w(TAG, "Unable to create shared memory", e);
        }
        return parcelFileDescriptor;
    }

    public long computeBatteryTimeRemaining() {
        long time;
        synchronized (this.mStats) {
            time = this.mStats.computeBatteryTimeRemaining(SystemClock.elapsedRealtime());
            if (time >= 0) {
                time /= 1000;
            }
        }
        return time;
    }

    public long computeChargeTimeRemaining() {
        long time;
        synchronized (this.mStats) {
            time = this.mStats.computeChargeTimeRemaining(SystemClock.elapsedRealtime());
            if (time >= 0) {
                time /= 1000;
            }
        }
        return time;
    }

    public void noteEvent(int code, String name, int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteEventLocked(code, name, uid);
        }
    }

    public void noteSyncStart(String name, int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteSyncStartLocked(name, uid);
        }
    }

    public void noteSyncFinish(String name, int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteSyncFinishLocked(name, uid);
        }
    }

    public void noteJobStart(String name, int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteJobStartLocked(name, uid);
        }
    }

    public void noteJobFinish(String name, int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteJobFinishLocked(name, uid);
        }
    }

    public void noteStartWakelock(int uid, int pid, String name, String historyName, int type, boolean unimportantForLogging) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteStartWakeLocked(uid, pid, name, historyName, type, unimportantForLogging, SystemClock.elapsedRealtime(), SystemClock.uptimeMillis());
        }
    }

    public void noteStopWakelock(int uid, int pid, String name, String historyName, int type) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteStopWakeLocked(uid, pid, name, historyName, type, SystemClock.elapsedRealtime(), SystemClock.uptimeMillis());
        }
    }

    public void noteStartWakelockFromSource(WorkSource ws, int pid, String name, String historyName, int type, boolean unimportantForLogging) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteStartWakeFromSourceLocked(ws, pid, name, historyName, type, unimportantForLogging);
        }
    }

    public void noteChangeWakelockFromSource(WorkSource ws, int pid, String name, String historyName, int type, WorkSource newWs, int newPid, String newName, String newHistoryName, int newType, boolean newUnimportantForLogging) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteChangeWakelockFromSourceLocked(ws, pid, name, historyName, type, newWs, newPid, newName, newHistoryName, newType, newUnimportantForLogging);
        }
    }

    public void noteStopWakelockFromSource(WorkSource ws, int pid, String name, String historyName, int type) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteStopWakeFromSourceLocked(ws, pid, name, historyName, type);
        }
    }

    public void noteStartSensor(int uid, int sensor) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteStartSensorLocked(uid, sensor);
        }
    }

    public void noteStopSensor(int uid, int sensor) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteStopSensorLocked(uid, sensor);
        }
    }

    public void noteVibratorOn(int uid, long durationMillis) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteVibratorOnLocked(uid, durationMillis);
        }
    }

    public void noteVibratorOff(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteVibratorOffLocked(uid);
        }
    }

    public void noteStartGps(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteStartGpsLocked(uid);
        }
    }

    public void noteStopGps(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteStopGpsLocked(uid);
        }
    }

    public void noteScreenState(int state) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteScreenStateLocked(state);
        }
    }

    public void noteScreenBrightness(int brightness) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteScreenBrightnessLocked(brightness);
        }
    }

    public void noteUserActivity(int uid, int event) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteUserActivityLocked(uid, event);
        }
    }

    public void noteInteractive(boolean interactive) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteInteractiveLocked(interactive);
        }
    }

    public void noteConnectivityChanged(int type, String extra) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteConnectivityChangedLocked(type, extra);
        }
    }

    public void noteMobileRadioPowerState(int powerState, long timestampNs) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteMobileRadioPowerState(powerState, timestampNs);
        }
    }

    public void notePhoneOn() {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.notePhoneOnLocked();
        }
    }

    public void notePhoneOff() {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.notePhoneOffLocked();
        }
    }

    public void notePhoneSignalStrength(SignalStrength signalStrength) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.notePhoneSignalStrengthLocked(signalStrength);
        }
    }

    public void notePhoneDataConnectionState(int dataType, boolean hasData) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.notePhoneDataConnectionStateLocked(dataType, hasData);
        }
    }

    public void notePhoneState(int state) {
        enforceCallingPermission();
        int simState = TelephonyManager.getDefault().getSimState();
        synchronized (this.mStats) {
            this.mStats.notePhoneStateLocked(state, simState);
        }
    }

    public void noteWifiOn() {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiOnLocked();
        }
    }

    public void noteWifiOff() {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiOffLocked();
        }
    }

    public void noteStartAudio(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteAudioOnLocked(uid);
        }
    }

    public void noteStopAudio(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteAudioOffLocked(uid);
        }
    }

    public void noteStartVideo(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteVideoOnLocked(uid);
        }
    }

    public void noteStopVideo(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteVideoOffLocked(uid);
        }
    }

    public void noteResetAudio() {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteResetAudioLocked();
        }
    }

    public void noteResetVideo() {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteResetVideoLocked();
        }
    }

    public void noteFlashlightOn() {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteFlashlightOnLocked();
        }
    }

    public void noteFlashlightOff() {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteFlashlightOffLocked();
        }
    }

    public void noteWifiRunning(WorkSource ws) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiRunningLocked(ws);
        }
    }

    public void noteWifiRunningChanged(WorkSource oldWs, WorkSource newWs) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiRunningChangedLocked(oldWs, newWs);
        }
    }

    public void noteWifiStopped(WorkSource ws) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiStoppedLocked(ws);
        }
    }

    public void noteWifiState(int wifiState, String accessPoint) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiStateLocked(wifiState, accessPoint);
        }
    }

    public void noteWifiSupplicantStateChanged(int supplState, boolean failedAuth) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiSupplicantStateChangedLocked(supplState, failedAuth);
        }
    }

    public void noteWifiRssiChanged(int newRssi) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiRssiChangedLocked(newRssi);
        }
    }

    public void noteBluetoothOn() {
        enforceCallingPermission();
        BluetoothAdapter adapter = BluetoothAdapter.getDefaultAdapter();
        if (adapter != null) {
            adapter.getProfileProxy(this.mContext, this.mBluetoothProfileServiceListener, 1);
        }
        synchronized (this.mStats) {
            if (this.mBluetoothHeadset != null) {
                this.mStats.noteBluetoothOnLocked();
                this.mStats.setBtHeadset(this.mBluetoothHeadset);
            } else {
                this.mBluetoothPendingStats = true;
            }
        }
    }

    public void noteBluetoothOff() {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mBluetoothPendingStats = false;
            this.mStats.noteBluetoothOffLocked();
        }
    }

    public void noteBluetoothState(int bluetoothState) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteBluetoothStateLocked(bluetoothState);
        }
    }

    public void noteFullWifiLockAcquired(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteFullWifiLockAcquiredLocked(uid);
        }
    }

    public void noteFullWifiLockReleased(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteFullWifiLockReleasedLocked(uid);
        }
    }

    public void noteWifiScanStarted(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiScanStartedLocked(uid);
        }
    }

    public void noteWifiScanStopped(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiScanStoppedLocked(uid);
        }
    }

    public void noteWifiMulticastEnabled(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiMulticastEnabledLocked(uid);
        }
    }

    public void noteWifiMulticastDisabled(int uid) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiMulticastDisabledLocked(uid);
        }
    }

    public void noteFullWifiLockAcquiredFromSource(WorkSource ws) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteFullWifiLockAcquiredFromSourceLocked(ws);
        }
    }

    public void noteFullWifiLockReleasedFromSource(WorkSource ws) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteFullWifiLockReleasedFromSourceLocked(ws);
        }
    }

    public void noteWifiScanStartedFromSource(WorkSource ws) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiScanStartedFromSourceLocked(ws);
        }
    }

    public void noteWifiScanStoppedFromSource(WorkSource ws) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiScanStoppedFromSourceLocked(ws);
        }
    }

    public void noteWifiBatchedScanStartedFromSource(WorkSource ws, int csph) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiBatchedScanStartedFromSourceLocked(ws, csph);
        }
    }

    public void noteWifiBatchedScanStoppedFromSource(WorkSource ws) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiBatchedScanStoppedFromSourceLocked(ws);
        }
    }

    public void noteWifiMulticastEnabledFromSource(WorkSource ws) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiMulticastEnabledFromSourceLocked(ws);
        }
    }

    public void noteWifiMulticastDisabledFromSource(WorkSource ws) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteWifiMulticastDisabledFromSourceLocked(ws);
        }
    }

    public void noteNetworkInterfaceType(String iface, int type) {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteNetworkInterfaceTypeLocked(iface, type);
        }
    }

    public void noteNetworkStatsEnabled() {
        enforceCallingPermission();
        synchronized (this.mStats) {
            this.mStats.noteNetworkStatsEnabledLocked();
        }
    }

    public boolean isOnBattery() {
        return this.mStats.isOnBattery();
    }

    public void setBatteryState(int status, int health, int plugType, int level, int temp, int volt) {
        enforceCallingPermission();
        this.mStats.setBatteryState(status, health, plugType, level, temp, volt);
    }

    public long getAwakeTimeBattery() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BATTERY_STATS", null);
        return this.mStats.getAwakeTimeBattery();
    }

    public long getAwakeTimePlugged() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BATTERY_STATS", null);
        return this.mStats.getAwakeTimePlugged();
    }

    public void enforceCallingPermission() {
        if (Binder.getCallingPid() != Process.myPid()) {
            this.mContext.enforcePermission("android.permission.UPDATE_DEVICE_STATS", Binder.getCallingPid(), Binder.getCallingUid(), null);
        }
    }

    private void dumpHelp(PrintWriter pw) {
        pw.println("Battery stats (batterystats) dump options:");
        pw.println("  [--checkin] [--history] [--history-start] [--unplugged] [--charged] [-c]");
        pw.println("  [--reset] [--write] [-h] [<package.name>]");
        pw.println("  --checkin: format output for a checkin report.");
        pw.println("  --history: show only history data.");
        pw.println("  --history-start <num>: show only history data starting at given time offset.");
        pw.println("  --unplugged: only output data since last unplugged.");
        pw.println("  --charged: only output data since last charged.");
        pw.println("  --reset: reset the stats, clearing all current data.");
        pw.println("  --write: force write current collected stats to disk.");
        pw.println("  <package.name>: optional name of package to filter output by.");
        pw.println("  -h: print this help text.");
        pw.println("Battery stats (batterystats) commands:");
        pw.println("  enable|disable <option>");
        pw.println("    Enable or disable a running option.  Option state is not saved across boots.");
        pw.println("    Options are:");
        pw.println("      full-history: include additional detailed events in battery history:");
        pw.println("          wake_lock_in and proc events");
        pw.println("      no-auto-reset: don't automatically reset stats when unplugged");
    }

    private int doEnableOrDisable(PrintWriter pw, int i, String[] args, boolean enable) {
        i++;
        if (i >= args.length) {
            pw.println("Missing option argument for " + (enable ? "--enable" : "--disable"));
            dumpHelp(pw);
            return -1;
        } else if ("full-wake-history".equals(args[i]) || "full-history".equals(args[i])) {
            synchronized (this.mStats) {
                this.mStats.setRecordAllHistoryLocked(enable);
            }
            return i;
        } else if ("no-auto-reset".equals(args[i])) {
            synchronized (this.mStats) {
                this.mStats.setNoAutoReset(enable);
            }
            return i;
        } else {
            pw.println("Unknown enable/disable option: " + args[i]);
            dumpHelp(pw);
            return -1;
        }
    }

    protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump BatteryStats from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " without permission " + "android.permission.DUMP");
            return;
        }
        int flags = 0;
        boolean useCheckinFormat = false;
        boolean isRealCheckin = false;
        boolean noOutput = false;
        boolean writeData = false;
        long historyStart = -1;
        int reqUid = -1;
        if (args != null) {
            int i = 0;
            while (i < args.length) {
                String arg = args[i];
                if ("--checkin".equals(arg)) {
                    useCheckinFormat = true;
                    isRealCheckin = true;
                } else if ("--history".equals(arg)) {
                    flags |= 4;
                } else if ("--history-start".equals(arg)) {
                    flags |= 4;
                    i++;
                    if (i >= args.length) {
                        pw.println("Missing time argument for --history-since");
                        dumpHelp(pw);
                        return;
                    }
                    historyStart = Long.parseLong(args[i]);
                    writeData = true;
                } else if ("-c".equals(arg)) {
                    useCheckinFormat = true;
                    flags |= 8;
                } else if ("--unplugged".equals(arg)) {
                    flags |= 1;
                } else if ("--charged".equals(arg)) {
                    flags |= 2;
                } else if ("--reset".equals(arg)) {
                    synchronized (this.mStats) {
                        this.mStats.resetAllStatsCmdLocked();
                        pw.println("Battery stats reset.");
                        noOutput = true;
                    }
                } else if ("--write".equals(arg)) {
                    synchronized (this.mStats) {
                        this.mStats.writeSyncLocked();
                        pw.println("Battery stats written.");
                        noOutput = true;
                    }
                } else if ("--enable".equals(arg) || "enable".equals(arg)) {
                    i = doEnableOrDisable(pw, i, args, true);
                    if (i >= 0) {
                        pw.println("Enabled: " + args[i]);
                        return;
                    }
                    return;
                } else if ("--disable".equals(arg) || "disable".equals(arg)) {
                    i = doEnableOrDisable(pw, i, args, false);
                    if (i >= 0) {
                        pw.println("Disabled: " + args[i]);
                        return;
                    }
                    return;
                } else if ("-h".equals(arg)) {
                    dumpHelp(pw);
                    return;
                } else if ("-a".equals(arg)) {
                    flags |= 16;
                } else if (arg.length() <= 0 || arg.charAt(0) != '-') {
                    try {
                        reqUid = this.mContext.getPackageManager().getPackageUid(arg, UserHandle.getCallingUserId());
                    } catch (NameNotFoundException e) {
                        pw.println("Unknown package: " + arg);
                        dumpHelp(pw);
                        return;
                    }
                } else {
                    pw.println("Unknown option: " + arg);
                    dumpHelp(pw);
                    return;
                }
                i++;
            }
        }
        if (!noOutput) {
            if (BatteryStatsHelper.checkWifiOnly(this.mContext)) {
                flags |= 32;
            }
            if (reqUid >= 0 && (flags & 7) == 0) {
                flags = (flags | 2) & -9;
            }
            if (useCheckinFormat) {
                List<ApplicationInfo> apps = this.mContext.getPackageManager().getInstalledApplications(0);
                if (isRealCheckin) {
                    synchronized (this.mStats.mCheckinFile) {
                        if (this.mStats.mCheckinFile.exists()) {
                            try {
                                byte[] raw = this.mStats.mCheckinFile.readFully();
                                if (raw != null) {
                                    Parcel in = Parcel.obtain();
                                    in.unmarshall(raw, 0, raw.length);
                                    in.setDataPosition(0);
                                    BatteryStatsImpl checkinStats = new BatteryStatsImpl(null, this.mStats.mHandler);
                                    checkinStats.readSummaryFromParcel(in);
                                    in.recycle();
                                    checkinStats.dumpCheckinLocked(this.mContext, pw, apps, flags, historyStart);
                                    this.mStats.mCheckinFile.delete();
                                    return;
                                }
                            } catch (IOException e2) {
                                Slog.w(TAG, "Failure reading checkin file " + this.mStats.mCheckinFile.getBaseFile(), e2);
                            }
                        }
                    }
                }
                synchronized (this.mStats) {
                    this.mStats.dumpCheckinLocked(this.mContext, pw, apps, flags, historyStart);
                    if (writeData) {
                        this.mStats.writeAsyncLocked();
                    }
                }
                return;
            }
            synchronized (this.mStats) {
                this.mStats.dumpLocked(this.mContext, pw, flags, reqUid, historyStart);
                if (writeData) {
                    this.mStats.writeAsyncLocked();
                }
            }
        }
    }
}
