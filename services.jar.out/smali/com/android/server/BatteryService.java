package com.android.server;

import android.app.ActivityManagerNative;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.database.ContentObserver;
import android.os.BatteryManagerInternal;
import android.os.BatteryProperties;
import android.os.Binder;
import android.os.DropBoxManager;
import android.os.FileUtils;
import android.os.Handler;
import android.os.IBatteryPropertiesListener.Stub;
import android.os.IBatteryPropertiesRegistrar;
import android.os.IBinder;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.UEventObserver;
import android.os.UEventObserver.UEvent;
import android.os.UserHandle;
import android.provider.Settings.Global;
import android.util.EventLog;
import android.util.Slog;
import com.android.internal.app.IBatteryStats;
import com.android.server.am.BatteryStatsService;
import com.android.server.lights.Light;
import com.android.server.lights.LightsManager;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

public final class BatteryService extends SystemService {
    private static final int BATTERY_PLUGGED_NONE = 0;
    private static final int BATTERY_SCALE = 100;
    private static final boolean DEBUG = false;
    private static final String[] DUMPSYS_ARGS;
    private static final String DUMPSYS_DATA_PATH = "/data/system/";
    private static final int DUMP_MAX_LENGTH = 24576;
    private static final String TAG;
    private boolean mBatteryLevelCritical;
    private boolean mBatteryLevelLow;
    private BatteryProperties mBatteryProps;
    private final IBatteryStats mBatteryStats;
    private final Context mContext;
    private int mCriticalBatteryLevel;
    private int mDischargeStartLevel;
    private long mDischargeStartTime;
    private final Handler mHandler;
    private int mInvalidCharger;
    private final UEventObserver mInvalidChargerObserver;
    private int mLastBatteryHealth;
    private int mLastBatteryLevel;
    private boolean mLastBatteryLevelCritical;
    private boolean mLastBatteryPresent;
    private final BatteryProperties mLastBatteryProps;
    private int mLastBatteryStatus;
    private int mLastBatteryTemperature;
    private int mLastBatteryVoltage;
    private int mLastInvalidCharger;
    private int mLastPlugType;
    private Led mLed;
    private final Object mLock;
    private int mLowBatteryCloseWarningLevel;
    private int mLowBatteryWarningLevel;
    private int mPlugType;
    private boolean mSentLowBatteryBroadcast;
    private int mShutdownBatteryTemperature;
    private boolean mUpdatesStopped;

    /* renamed from: com.android.server.BatteryService.1 */
    class C00081 extends ContentObserver {
        C00081(Handler x0) {
            super(x0);
        }

        public void onChange(boolean selfChange) {
            synchronized (BatteryService.this.mLock) {
                BatteryService.this.updateBatteryWarningLevelLocked();
            }
        }
    }

    /* renamed from: com.android.server.BatteryService.2 */
    class C00092 implements Runnable {
        C00092() {
        }

        public void run() {
            if (ActivityManagerNative.isSystemReady()) {
                Slog.e(BatteryService.TAG, "silent_reboot shutdownIfNoPowerLocked");
                Intent intent = new Intent("android.intent.action.ACTION_REQUEST_SHUTDOWN");
                intent.putExtra("android.intent.extra.KEY_CONFIRM", BatteryService.DEBUG);
                intent.setFlags(268435456);
                BatteryService.this.mContext.startActivityAsUser(intent, UserHandle.CURRENT);
            }
        }
    }

    /* renamed from: com.android.server.BatteryService.3 */
    class C00103 implements Runnable {
        C00103() {
        }

        public void run() {
            if (ActivityManagerNative.isSystemReady()) {
                Slog.e(BatteryService.TAG, "silent_reboot shutdownIfOverTempLocked");
                Intent intent = new Intent("android.intent.action.ACTION_REQUEST_SHUTDOWN");
                intent.putExtra("android.intent.extra.KEY_CONFIRM", BatteryService.DEBUG);
                intent.setFlags(268435456);
                BatteryService.this.mContext.startActivityAsUser(intent, UserHandle.CURRENT);
            }
        }
    }

    /* renamed from: com.android.server.BatteryService.4 */
    class C00114 implements Runnable {
        C00114() {
        }

        public void run() {
            Intent statusIntent = new Intent("android.intent.action.ACTION_POWER_CONNECTED");
            statusIntent.setFlags(67108864);
            BatteryService.this.mContext.sendBroadcastAsUser(statusIntent, UserHandle.ALL);
        }
    }

    /* renamed from: com.android.server.BatteryService.5 */
    class C00125 implements Runnable {
        C00125() {
        }

        public void run() {
            Intent statusIntent = new Intent("android.intent.action.ACTION_POWER_DISCONNECTED");
            statusIntent.setFlags(67108864);
            BatteryService.this.mContext.sendBroadcastAsUser(statusIntent, UserHandle.ALL);
        }
    }

    /* renamed from: com.android.server.BatteryService.6 */
    class C00136 implements Runnable {
        C00136() {
        }

        public void run() {
            Intent statusIntent = new Intent("android.intent.action.BATTERY_LOW");
            statusIntent.setFlags(67108864);
            BatteryService.this.mContext.sendBroadcastAsUser(statusIntent, UserHandle.ALL);
        }
    }

    /* renamed from: com.android.server.BatteryService.7 */
    class C00147 implements Runnable {
        C00147() {
        }

        public void run() {
            Intent statusIntent = new Intent("android.intent.action.BATTERY_OKAY");
            statusIntent.setFlags(67108864);
            BatteryService.this.mContext.sendBroadcastAsUser(statusIntent, UserHandle.ALL);
        }
    }

    /* renamed from: com.android.server.BatteryService.8 */
    class C00158 implements Runnable {
        final /* synthetic */ Intent val$intent;

        C00158(Intent intent) {
            this.val$intent = intent;
        }

        public void run() {
            ActivityManagerNative.broadcastStickyIntent(this.val$intent, null, -1);
        }
    }

    /* renamed from: com.android.server.BatteryService.9 */
    class C00169 extends UEventObserver {
        C00169() {
        }

        public void onUEvent(UEvent event) {
            int invalidCharger = "1".equals(event.get("SWITCH_STATE")) ? 1 : BatteryService.BATTERY_PLUGGED_NONE;
            synchronized (BatteryService.this.mLock) {
                if (BatteryService.this.mInvalidCharger != invalidCharger) {
                    BatteryService.this.mInvalidCharger = invalidCharger;
                }
            }
        }
    }

    private final class BatteryListener extends Stub {
        private BatteryListener() {
        }

        public void batteryPropertiesChanged(BatteryProperties props) {
            long identity = Binder.clearCallingIdentity();
            try {
                BatteryService.this.update(props);
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }
    }

    private final class BinderService extends Binder {
        private BinderService() {
        }

        protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (BatteryService.this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump Battery service from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            } else {
                BatteryService.this.dumpInternal(pw, args);
            }
        }
    }

    private final class Led {
        private final int mBatteryFullARGB;
        private final int mBatteryLedOff;
        private final int mBatteryLedOn;
        private final Light mBatteryLight;
        private final int mBatteryLowARGB;
        private final int mBatteryMediumARGB;

        public Led(Context context, LightsManager lights) {
            this.mBatteryLight = lights.getLight(3);
            this.mBatteryLowARGB = context.getResources().getInteger(17694794);
            this.mBatteryMediumARGB = context.getResources().getInteger(17694795);
            this.mBatteryFullARGB = context.getResources().getInteger(17694796);
            this.mBatteryLedOn = context.getResources().getInteger(17694797);
            this.mBatteryLedOff = context.getResources().getInteger(17694798);
        }

        public void updateLightsLocked() {
            int level = BatteryService.this.mBatteryProps.batteryLevel;
            int status = BatteryService.this.mBatteryProps.batteryStatus;
            if (level < BatteryService.this.mLowBatteryWarningLevel) {
                if (status == 2) {
                    this.mBatteryLight.setColor(this.mBatteryLowARGB);
                } else {
                    this.mBatteryLight.setFlashing(this.mBatteryLowARGB, 1, this.mBatteryLedOn, this.mBatteryLedOff);
                }
            } else if (status != 2 && status != 5) {
                this.mBatteryLight.turnOff();
            } else if (status == 5 || level >= 90) {
                this.mBatteryLight.setColor(this.mBatteryFullARGB);
            } else {
                this.mBatteryLight.setColor(this.mBatteryMediumARGB);
            }
        }
    }

    private final class LocalService extends BatteryManagerInternal {
        private LocalService() {
        }

        public boolean isPowered(int plugTypeSet) {
            boolean access$1200;
            synchronized (BatteryService.this.mLock) {
                access$1200 = BatteryService.this.isPoweredLocked(plugTypeSet);
            }
            return access$1200;
        }

        public int getPlugType() {
            int access$1300;
            synchronized (BatteryService.this.mLock) {
                access$1300 = BatteryService.this.mPlugType;
            }
            return access$1300;
        }

        public int getBatteryLevel() {
            int i;
            synchronized (BatteryService.this.mLock) {
                i = BatteryService.this.mBatteryProps.batteryLevel;
            }
            return i;
        }

        public boolean getBatteryLevelLow() {
            boolean access$1400;
            synchronized (BatteryService.this.mLock) {
                access$1400 = BatteryService.this.mBatteryLevelLow;
            }
            return access$1400;
        }

        public int getInvalidCharger() {
            int access$700;
            synchronized (BatteryService.this.mLock) {
                access$700 = BatteryService.this.mInvalidCharger;
            }
            return access$700;
        }
    }

    static {
        TAG = BatteryService.class.getSimpleName();
        DUMPSYS_ARGS = new String[]{"--checkin", "--unplugged"};
    }

    public BatteryService(Context context) {
        super(context);
        this.mLock = new Object();
        this.mLastBatteryProps = new BatteryProperties();
        this.mLastPlugType = -1;
        this.mSentLowBatteryBroadcast = DEBUG;
        this.mInvalidChargerObserver = new C00169();
        this.mContext = context;
        this.mHandler = new Handler(true);
        this.mLed = new Led(context, (LightsManager) getLocalService(LightsManager.class));
        this.mBatteryStats = BatteryStatsService.getService();
        this.mCriticalBatteryLevel = this.mContext.getResources().getInteger(17694788);
        this.mLowBatteryWarningLevel = this.mContext.getResources().getInteger(17694790);
        this.mLowBatteryCloseWarningLevel = this.mLowBatteryWarningLevel + this.mContext.getResources().getInteger(17694791);
        this.mShutdownBatteryTemperature = this.mContext.getResources().getInteger(17694789);
        if (new File("/sys/devices/virtual/switch/invalid_charger/state").exists()) {
            this.mInvalidChargerObserver.startObserving("DEVPATH=/devices/virtual/switch/invalid_charger");
        }
    }

    public void onStart() {
        try {
            IBatteryPropertiesRegistrar.Stub.asInterface(ServiceManager.getService("batteryproperties")).registerListener(new BatteryListener());
        } catch (RemoteException e) {
        }
        publishBinderService("battery", new BinderService());
        publishLocalService(BatteryManagerInternal.class, new LocalService());
    }

    public void onBootPhase(int phase) {
        if (phase == SystemService.PHASE_ACTIVITY_MANAGER_READY) {
            synchronized (this.mLock) {
                this.mContext.getContentResolver().registerContentObserver(Global.getUriFor("low_power_trigger_level"), DEBUG, new C00081(this.mHandler), -1);
                updateBatteryWarningLevelLocked();
            }
        }
    }

    private void updateBatteryWarningLevelLocked() {
        ContentResolver resolver = this.mContext.getContentResolver();
        int defWarnLevel = this.mContext.getResources().getInteger(17694790);
        this.mLowBatteryWarningLevel = Global.getInt(resolver, "low_power_trigger_level", defWarnLevel);
        if (this.mLowBatteryWarningLevel == 0) {
            this.mLowBatteryWarningLevel = defWarnLevel;
        }
        if (this.mLowBatteryWarningLevel < this.mCriticalBatteryLevel) {
            this.mLowBatteryWarningLevel = this.mCriticalBatteryLevel;
        }
        this.mLowBatteryCloseWarningLevel = this.mLowBatteryWarningLevel + this.mContext.getResources().getInteger(17694791);
        processValuesLocked(true);
    }

    private boolean isPoweredLocked(int plugTypeSet) {
        if (this.mBatteryProps.batteryStatus == 1) {
            return true;
        }
        if ((plugTypeSet & 1) != 0 && this.mBatteryProps.chargerAcOnline) {
            return true;
        }
        if ((plugTypeSet & 2) != 0 && this.mBatteryProps.chargerUsbOnline) {
            return true;
        }
        if ((plugTypeSet & 4) == 0 || !this.mBatteryProps.chargerWirelessOnline) {
            return DEBUG;
        }
        return true;
    }

    private boolean shouldSendBatteryLowLocked() {
        boolean plugged;
        if (this.mPlugType != 0) {
            plugged = true;
        } else {
            plugged = DEBUG;
        }
        boolean oldPlugged;
        if (this.mLastPlugType != 0) {
            oldPlugged = true;
        } else {
            oldPlugged = DEBUG;
        }
        if (plugged || this.mBatteryProps.batteryStatus == 1 || this.mBatteryProps.batteryLevel > this.mLowBatteryWarningLevel || (!oldPlugged && this.mLastBatteryLevel <= this.mLowBatteryWarningLevel)) {
            return DEBUG;
        }
        return true;
    }

    private void shutdownIfNoPowerLocked() {
        if (this.mBatteryProps.batteryLevel == 0 && !isPoweredLocked(7)) {
            this.mHandler.post(new C00092());
        }
    }

    private void shutdownIfOverTempLocked() {
        if (this.mBatteryProps.batteryTemperature > this.mShutdownBatteryTemperature) {
            this.mHandler.post(new C00103());
        }
    }

    private void update(BatteryProperties props) {
        synchronized (this.mLock) {
            if (this.mUpdatesStopped) {
                this.mLastBatteryProps.set(props);
            } else {
                this.mBatteryProps = props;
                processValuesLocked(DEBUG);
            }
        }
    }

    private void processValuesLocked(boolean force) {
        boolean logOutlier = DEBUG;
        long dischargeDuration = 0;
        this.mBatteryLevelCritical = this.mBatteryProps.batteryLevel <= this.mCriticalBatteryLevel ? true : DEBUG;
        if (this.mBatteryProps.chargerAcOnline) {
            this.mPlugType = 1;
        } else if (this.mBatteryProps.chargerUsbOnline) {
            this.mPlugType = 2;
        } else if (this.mBatteryProps.chargerWirelessOnline) {
            this.mPlugType = 4;
        } else {
            this.mPlugType = BATTERY_PLUGGED_NONE;
        }
        try {
            this.mBatteryStats.setBatteryState(this.mBatteryProps.batteryStatus, this.mBatteryProps.batteryHealth, this.mPlugType, this.mBatteryProps.batteryLevel, this.mBatteryProps.batteryTemperature, this.mBatteryProps.batteryVoltage);
        } catch (RemoteException e) {
        }
        shutdownIfNoPowerLocked();
        shutdownIfOverTempLocked();
        if (force || this.mBatteryProps.batteryStatus != this.mLastBatteryStatus || this.mBatteryProps.batteryHealth != this.mLastBatteryHealth || this.mBatteryProps.batteryPresent != this.mLastBatteryPresent || this.mBatteryProps.batteryLevel != this.mLastBatteryLevel || this.mPlugType != this.mLastPlugType || this.mBatteryProps.batteryVoltage != this.mLastBatteryVoltage || this.mBatteryProps.batteryTemperature != this.mLastBatteryTemperature || this.mInvalidCharger != this.mLastInvalidCharger) {
            if (this.mPlugType != this.mLastPlugType) {
                if (this.mLastPlugType == 0) {
                    if (!(this.mDischargeStartTime == 0 || this.mDischargeStartLevel == this.mBatteryProps.batteryLevel)) {
                        dischargeDuration = SystemClock.elapsedRealtime() - this.mDischargeStartTime;
                        logOutlier = true;
                        EventLog.writeEvent(EventLogTags.BATTERY_DISCHARGE, new Object[]{Long.valueOf(dischargeDuration), Integer.valueOf(this.mDischargeStartLevel), Integer.valueOf(this.mBatteryProps.batteryLevel)});
                        this.mDischargeStartTime = 0;
                    }
                } else if (this.mPlugType == 0) {
                    this.mDischargeStartTime = SystemClock.elapsedRealtime();
                    this.mDischargeStartLevel = this.mBatteryProps.batteryLevel;
                }
            }
            if (!(this.mBatteryProps.batteryStatus == this.mLastBatteryStatus && this.mBatteryProps.batteryHealth == this.mLastBatteryHealth && this.mBatteryProps.batteryPresent == this.mLastBatteryPresent && this.mPlugType == this.mLastPlugType)) {
                Object[] objArr = new Object[5];
                objArr[BATTERY_PLUGGED_NONE] = Integer.valueOf(this.mBatteryProps.batteryStatus);
                objArr[1] = Integer.valueOf(this.mBatteryProps.batteryHealth);
                objArr[2] = Integer.valueOf(this.mBatteryProps.batteryPresent ? 1 : BATTERY_PLUGGED_NONE);
                objArr[3] = Integer.valueOf(this.mPlugType);
                objArr[4] = this.mBatteryProps.batteryTechnology;
                EventLog.writeEvent(EventLogTags.BATTERY_STATUS, objArr);
            }
            if (this.mBatteryProps.batteryLevel != this.mLastBatteryLevel) {
                EventLog.writeEvent(EventLogTags.BATTERY_LEVEL, new Object[]{Integer.valueOf(this.mBatteryProps.batteryLevel), Integer.valueOf(this.mBatteryProps.batteryVoltage), Integer.valueOf(this.mBatteryProps.batteryTemperature)});
            }
            if (this.mBatteryLevelCritical && !this.mLastBatteryLevelCritical && this.mPlugType == 0) {
                dischargeDuration = SystemClock.elapsedRealtime() - this.mDischargeStartTime;
                logOutlier = true;
            }
            if (this.mBatteryLevelLow) {
                if (this.mPlugType != 0) {
                    this.mBatteryLevelLow = DEBUG;
                } else if (this.mBatteryProps.batteryLevel >= this.mLowBatteryCloseWarningLevel) {
                    this.mBatteryLevelLow = DEBUG;
                } else if (force && this.mBatteryProps.batteryLevel >= this.mLowBatteryWarningLevel) {
                    this.mBatteryLevelLow = DEBUG;
                }
            } else if (this.mPlugType == 0 && this.mBatteryProps.batteryLevel <= this.mLowBatteryWarningLevel) {
                this.mBatteryLevelLow = true;
            }
            sendIntentLocked();
            if (this.mPlugType != 0 && this.mLastPlugType == 0) {
                this.mHandler.post(new C00114());
            } else if (this.mPlugType == 0 && this.mLastPlugType != 0) {
                this.mHandler.post(new C00125());
            }
            if (shouldSendBatteryLowLocked()) {
                this.mSentLowBatteryBroadcast = true;
                this.mHandler.post(new C00136());
            } else if (this.mSentLowBatteryBroadcast && this.mLastBatteryLevel >= this.mLowBatteryCloseWarningLevel) {
                this.mSentLowBatteryBroadcast = DEBUG;
                this.mHandler.post(new C00147());
            }
            this.mLed.updateLightsLocked();
            if (logOutlier && dischargeDuration != 0) {
                logOutlierLocked(dischargeDuration);
            }
            this.mLastBatteryStatus = this.mBatteryProps.batteryStatus;
            this.mLastBatteryHealth = this.mBatteryProps.batteryHealth;
            this.mLastBatteryPresent = this.mBatteryProps.batteryPresent;
            this.mLastBatteryLevel = this.mBatteryProps.batteryLevel;
            this.mLastPlugType = this.mPlugType;
            this.mLastBatteryVoltage = this.mBatteryProps.batteryVoltage;
            this.mLastBatteryTemperature = this.mBatteryProps.batteryTemperature;
            this.mLastBatteryLevelCritical = this.mBatteryLevelCritical;
            this.mLastInvalidCharger = this.mInvalidCharger;
        }
    }

    private void sendIntentLocked() {
        Intent intent = new Intent("android.intent.action.BATTERY_CHANGED");
        intent.addFlags(1610612736);
        int icon = getIconLocked(this.mBatteryProps.batteryLevel);
        intent.putExtra("status", this.mBatteryProps.batteryStatus);
        intent.putExtra("health", this.mBatteryProps.batteryHealth);
        intent.putExtra("present", this.mBatteryProps.batteryPresent);
        intent.putExtra("level", this.mBatteryProps.batteryLevel);
        intent.putExtra("scale", BATTERY_SCALE);
        intent.putExtra("icon-small", icon);
        intent.putExtra("plugged", this.mPlugType);
        intent.putExtra("voltage", this.mBatteryProps.batteryVoltage);
        intent.putExtra("temperature", this.mBatteryProps.batteryTemperature);
        intent.putExtra("technology", this.mBatteryProps.batteryTechnology);
        intent.putExtra("invalid_charger", this.mInvalidCharger);
        this.mHandler.post(new C00158(intent));
    }

    private void logBatteryStatsLocked() {
        RemoteException e;
        Throwable th;
        IOException e2;
        IBinder batteryInfoService = ServiceManager.getService("batterystats");
        if (batteryInfoService != null) {
            DropBoxManager db = (DropBoxManager) this.mContext.getSystemService("dropbox");
            if (db != null && db.isTagEnabled("BATTERY_DISCHARGE_INFO")) {
                File dumpFile = null;
                FileOutputStream dumpStream = null;
                try {
                    File dumpFile2 = new File("/data/system/batterystats.dump");
                    try {
                        FileOutputStream dumpStream2 = new FileOutputStream(dumpFile2);
                        try {
                            batteryInfoService.dump(dumpStream2.getFD(), DUMPSYS_ARGS);
                            FileUtils.sync(dumpStream2);
                            db.addFile("BATTERY_DISCHARGE_INFO", dumpFile2, 2);
                            if (dumpStream2 != null) {
                                try {
                                    dumpStream2.close();
                                } catch (IOException e3) {
                                    Slog.e(TAG, "failed to close dumpsys output stream");
                                }
                            }
                            if (dumpFile2 == null || dumpFile2.delete()) {
                                dumpFile = dumpFile2;
                                return;
                            }
                            Slog.e(TAG, "failed to delete temporary dumpsys file: " + dumpFile2.getAbsolutePath());
                            dumpStream = dumpStream2;
                            dumpFile = dumpFile2;
                        } catch (RemoteException e4) {
                            e = e4;
                            dumpStream = dumpStream2;
                            dumpFile = dumpFile2;
                            try {
                                Slog.e(TAG, "failed to dump battery service", e);
                                if (dumpStream != null) {
                                    try {
                                        dumpStream.close();
                                    } catch (IOException e5) {
                                        Slog.e(TAG, "failed to close dumpsys output stream");
                                    }
                                }
                                if (dumpFile != null && !dumpFile.delete()) {
                                    Slog.e(TAG, "failed to delete temporary dumpsys file: " + dumpFile.getAbsolutePath());
                                }
                            } catch (Throwable th2) {
                                th = th2;
                                if (dumpStream != null) {
                                    try {
                                        dumpStream.close();
                                    } catch (IOException e6) {
                                        Slog.e(TAG, "failed to close dumpsys output stream");
                                    }
                                }
                                if (!(dumpFile == null || dumpFile.delete())) {
                                    Slog.e(TAG, "failed to delete temporary dumpsys file: " + dumpFile.getAbsolutePath());
                                }
                                throw th;
                            }
                        } catch (IOException e7) {
                            e2 = e7;
                            dumpStream = dumpStream2;
                            dumpFile = dumpFile2;
                            Slog.e(TAG, "failed to write dumpsys file", e2);
                            if (dumpStream != null) {
                                try {
                                    dumpStream.close();
                                } catch (IOException e8) {
                                    Slog.e(TAG, "failed to close dumpsys output stream");
                                }
                            }
                            if (dumpFile != null && !dumpFile.delete()) {
                                Slog.e(TAG, "failed to delete temporary dumpsys file: " + dumpFile.getAbsolutePath());
                            }
                        } catch (Throwable th3) {
                            th = th3;
                            dumpStream = dumpStream2;
                            dumpFile = dumpFile2;
                            if (dumpStream != null) {
                                dumpStream.close();
                            }
                            Slog.e(TAG, "failed to delete temporary dumpsys file: " + dumpFile.getAbsolutePath());
                            throw th;
                        }
                    } catch (RemoteException e9) {
                        e = e9;
                        dumpFile = dumpFile2;
                        Slog.e(TAG, "failed to dump battery service", e);
                        if (dumpStream != null) {
                            dumpStream.close();
                        }
                        if (dumpFile != null) {
                        }
                    } catch (IOException e10) {
                        e2 = e10;
                        dumpFile = dumpFile2;
                        Slog.e(TAG, "failed to write dumpsys file", e2);
                        if (dumpStream != null) {
                            dumpStream.close();
                        }
                        if (dumpFile != null) {
                        }
                    } catch (Throwable th4) {
                        th = th4;
                        dumpFile = dumpFile2;
                        if (dumpStream != null) {
                            dumpStream.close();
                        }
                        Slog.e(TAG, "failed to delete temporary dumpsys file: " + dumpFile.getAbsolutePath());
                        throw th;
                    }
                } catch (RemoteException e11) {
                    e = e11;
                    Slog.e(TAG, "failed to dump battery service", e);
                    if (dumpStream != null) {
                        dumpStream.close();
                    }
                    if (dumpFile != null) {
                    }
                } catch (IOException e12) {
                    e2 = e12;
                    Slog.e(TAG, "failed to write dumpsys file", e2);
                    if (dumpStream != null) {
                        dumpStream.close();
                    }
                    if (dumpFile != null) {
                    }
                }
            }
        }
    }

    private void logOutlierLocked(long duration) {
        ContentResolver cr = this.mContext.getContentResolver();
        String dischargeThresholdString = Global.getString(cr, "battery_discharge_threshold");
        String durationThresholdString = Global.getString(cr, "battery_discharge_duration_threshold");
        if (dischargeThresholdString != null && durationThresholdString != null) {
            try {
                long durationThreshold = Long.parseLong(durationThresholdString);
                int dischargeThreshold = Integer.parseInt(dischargeThresholdString);
                if (duration <= durationThreshold && this.mDischargeStartLevel - this.mBatteryProps.batteryLevel >= dischargeThreshold) {
                    logBatteryStatsLocked();
                }
            } catch (NumberFormatException e) {
                Slog.e(TAG, "Invalid DischargeThresholds GService string: " + durationThresholdString + " or " + dischargeThresholdString);
            }
        }
    }

    private int getIconLocked(int level) {
        if (this.mBatteryProps.batteryStatus == 2) {
            return 17303137;
        }
        if (this.mBatteryProps.batteryStatus == 3) {
            return 17303123;
        }
        if (this.mBatteryProps.batteryStatus != 4 && this.mBatteryProps.batteryStatus != 5) {
            return 17303151;
        }
        if (!isPoweredLocked(7) || this.mBatteryProps.batteryLevel < BATTERY_SCALE) {
            return 17303123;
        }
        return 17303137;
    }

    private void dumpInternal(java.io.PrintWriter r12, java.lang.String[] r13) {
        /* JADX: method processing error */
/*
        Error: jadx.core.utils.exceptions.JadxRuntimeException: Exception block dominator not found, method:com.android.server.BatteryService.dumpInternal(java.io.PrintWriter, java.lang.String[]):void. bs: [B:19:0x0143, B:31:0x0168, B:76:0x021b]
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.searchTryCatchDominators(ProcessTryCatchRegions.java:86)
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.process(ProcessTryCatchRegions.java:45)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.postProcessRegions(RegionMakerVisitor.java:57)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.visit(RegionMakerVisitor.java:52)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
        /*
        r11 = this;
        r6 = 1;
        r7 = 0;
        r8 = r11.mLock;
        monitor-enter(r8);
        if (r13 == 0) goto L_0x0015;
    L_0x0007:
        r9 = r13.length;	 Catch:{ all -> 0x018a }
        if (r9 == 0) goto L_0x0015;	 Catch:{ all -> 0x018a }
    L_0x000a:
        r9 = "-a";	 Catch:{ all -> 0x018a }
        r10 = 0;	 Catch:{ all -> 0x018a }
        r10 = r13[r10];	 Catch:{ all -> 0x018a }
        r9 = r9.equals(r10);	 Catch:{ all -> 0x018a }
        if (r9 == 0) goto L_0x012e;	 Catch:{ all -> 0x018a }
    L_0x0015:
        r6 = "Current Battery Service state:";	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = r11.mUpdatesStopped;	 Catch:{ all -> 0x018a }
        if (r6 == 0) goto L_0x0023;	 Catch:{ all -> 0x018a }
    L_0x001e:
        r6 = "  (UPDATES STOPPED -- use 'reset' to restart)";	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
    L_0x0023:
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x018a }
        r6.<init>();	 Catch:{ all -> 0x018a }
        r7 = "  AC powered: ";	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r7 = r11.mBatteryProps;	 Catch:{ all -> 0x018a }
        r7 = r7.chargerAcOnline;	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r6 = r6.toString();	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x018a }
        r6.<init>();	 Catch:{ all -> 0x018a }
        r7 = "  USB powered: ";	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r7 = r11.mBatteryProps;	 Catch:{ all -> 0x018a }
        r7 = r7.chargerUsbOnline;	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r6 = r6.toString();	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x018a }
        r6.<init>();	 Catch:{ all -> 0x018a }
        r7 = "  Wireless powered: ";	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r7 = r11.mBatteryProps;	 Catch:{ all -> 0x018a }
        r7 = r7.chargerWirelessOnline;	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r6 = r6.toString();	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x018a }
        r6.<init>();	 Catch:{ all -> 0x018a }
        r7 = "  status: ";	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r7 = r11.mBatteryProps;	 Catch:{ all -> 0x018a }
        r7 = r7.batteryStatus;	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r6 = r6.toString();	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x018a }
        r6.<init>();	 Catch:{ all -> 0x018a }
        r7 = "  health: ";	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r7 = r11.mBatteryProps;	 Catch:{ all -> 0x018a }
        r7 = r7.batteryHealth;	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r6 = r6.toString();	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x018a }
        r6.<init>();	 Catch:{ all -> 0x018a }
        r7 = "  present: ";	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r7 = r11.mBatteryProps;	 Catch:{ all -> 0x018a }
        r7 = r7.batteryPresent;	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r6 = r6.toString();	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x018a }
        r6.<init>();	 Catch:{ all -> 0x018a }
        r7 = "  level: ";	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r7 = r11.mBatteryProps;	 Catch:{ all -> 0x018a }
        r7 = r7.batteryLevel;	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r6 = r6.toString();	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = "  scale: 100";	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x018a }
        r6.<init>();	 Catch:{ all -> 0x018a }
        r7 = "  voltage: ";	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r7 = r11.mBatteryProps;	 Catch:{ all -> 0x018a }
        r7 = r7.batteryVoltage;	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r6 = r6.toString();	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x018a }
        r6.<init>();	 Catch:{ all -> 0x018a }
        r7 = "  temperature: ";	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r7 = r11.mBatteryProps;	 Catch:{ all -> 0x018a }
        r7 = r7.batteryTemperature;	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r6 = r6.toString();	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x018a }
        r6.<init>();	 Catch:{ all -> 0x018a }
        r7 = "  technology: ";	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r7 = r11.mBatteryProps;	 Catch:{ all -> 0x018a }
        r7 = r7.batteryTechnology;	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r6 = r6.toString();	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
    L_0x012c:
        monitor-exit(r8);	 Catch:{ all -> 0x018a }
        return;	 Catch:{ all -> 0x018a }
    L_0x012e:
        r9 = r13.length;	 Catch:{ all -> 0x018a }
        r10 = 3;	 Catch:{ all -> 0x018a }
        if (r9 != r10) goto L_0x0209;	 Catch:{ all -> 0x018a }
    L_0x0132:
        r9 = "set";	 Catch:{ all -> 0x018a }
        r10 = 0;	 Catch:{ all -> 0x018a }
        r10 = r13[r10];	 Catch:{ all -> 0x018a }
        r9 = r9.equals(r10);	 Catch:{ all -> 0x018a }
        if (r9 == 0) goto L_0x0209;	 Catch:{ all -> 0x018a }
    L_0x013d:
        r9 = 1;	 Catch:{ all -> 0x018a }
        r1 = r13[r9];	 Catch:{ all -> 0x018a }
        r9 = 2;	 Catch:{ all -> 0x018a }
        r5 = r13[r9];	 Catch:{ all -> 0x018a }
        r9 = r11.mUpdatesStopped;	 Catch:{ NumberFormatException -> 0x0172 }
        if (r9 != 0) goto L_0x014e;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x0147:
        r9 = r11.mLastBatteryProps;	 Catch:{ NumberFormatException -> 0x0172 }
        r10 = r11.mBatteryProps;	 Catch:{ NumberFormatException -> 0x0172 }
        r9.set(r10);	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x014e:
        r4 = 1;	 Catch:{ NumberFormatException -> 0x0172 }
        r9 = "ac";	 Catch:{ NumberFormatException -> 0x0172 }
        r9 = r9.equals(r1);	 Catch:{ NumberFormatException -> 0x0172 }
        if (r9 == 0) goto L_0x018f;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x0157:
        r9 = r11.mBatteryProps;	 Catch:{ NumberFormatException -> 0x0172 }
        r10 = java.lang.Integer.parseInt(r5);	 Catch:{ NumberFormatException -> 0x0172 }
        if (r10 == 0) goto L_0x018d;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x015f:
        r9.chargerAcOnline = r6;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x0161:
        if (r4 == 0) goto L_0x012c;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x0163:
        r2 = android.os.Binder.clearCallingIdentity();	 Catch:{ NumberFormatException -> 0x0172 }
        r6 = 1;
        r11.mUpdatesStopped = r6;	 Catch:{ all -> 0x0204 }
        r6 = 0;	 Catch:{ all -> 0x0204 }
        r11.processValuesLocked(r6);	 Catch:{ all -> 0x0204 }
        android.os.Binder.restoreCallingIdentity(r2);	 Catch:{ NumberFormatException -> 0x0172 }
        goto L_0x012c;
    L_0x0172:
        r0 = move-exception;
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x018a }
        r6.<init>();	 Catch:{ all -> 0x018a }
        r7 = "Bad value: ";	 Catch:{ all -> 0x018a }
        r6 = r6.append(r7);	 Catch:{ all -> 0x018a }
        r6 = r6.append(r5);	 Catch:{ all -> 0x018a }
        r6 = r6.toString();	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        goto L_0x012c;	 Catch:{ all -> 0x018a }
    L_0x018a:
        r6 = move-exception;	 Catch:{ all -> 0x018a }
        monitor-exit(r8);	 Catch:{ all -> 0x018a }
        throw r6;
    L_0x018d:
        r6 = r7;
        goto L_0x015f;
    L_0x018f:
        r9 = "usb";	 Catch:{ NumberFormatException -> 0x0172 }
        r9 = r9.equals(r1);	 Catch:{ NumberFormatException -> 0x0172 }
        if (r9 == 0) goto L_0x01a4;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x0197:
        r9 = r11.mBatteryProps;	 Catch:{ NumberFormatException -> 0x0172 }
        r10 = java.lang.Integer.parseInt(r5);	 Catch:{ NumberFormatException -> 0x0172 }
        if (r10 == 0) goto L_0x01a2;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x019f:
        r9.chargerUsbOnline = r6;	 Catch:{ NumberFormatException -> 0x0172 }
        goto L_0x0161;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01a2:
        r6 = r7;	 Catch:{ NumberFormatException -> 0x0172 }
        goto L_0x019f;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01a4:
        r9 = "wireless";	 Catch:{ NumberFormatException -> 0x0172 }
        r9 = r9.equals(r1);	 Catch:{ NumberFormatException -> 0x0172 }
        if (r9 == 0) goto L_0x01b9;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01ac:
        r9 = r11.mBatteryProps;	 Catch:{ NumberFormatException -> 0x0172 }
        r10 = java.lang.Integer.parseInt(r5);	 Catch:{ NumberFormatException -> 0x0172 }
        if (r10 == 0) goto L_0x01b7;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01b4:
        r9.chargerWirelessOnline = r6;	 Catch:{ NumberFormatException -> 0x0172 }
        goto L_0x0161;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01b7:
        r6 = r7;	 Catch:{ NumberFormatException -> 0x0172 }
        goto L_0x01b4;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01b9:
        r6 = "status";	 Catch:{ NumberFormatException -> 0x0172 }
        r6 = r6.equals(r1);	 Catch:{ NumberFormatException -> 0x0172 }
        if (r6 == 0) goto L_0x01ca;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01c1:
        r6 = r11.mBatteryProps;	 Catch:{ NumberFormatException -> 0x0172 }
        r7 = java.lang.Integer.parseInt(r5);	 Catch:{ NumberFormatException -> 0x0172 }
        r6.batteryStatus = r7;	 Catch:{ NumberFormatException -> 0x0172 }
        goto L_0x0161;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01ca:
        r6 = "level";	 Catch:{ NumberFormatException -> 0x0172 }
        r6 = r6.equals(r1);	 Catch:{ NumberFormatException -> 0x0172 }
        if (r6 == 0) goto L_0x01db;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01d2:
        r6 = r11.mBatteryProps;	 Catch:{ NumberFormatException -> 0x0172 }
        r7 = java.lang.Integer.parseInt(r5);	 Catch:{ NumberFormatException -> 0x0172 }
        r6.batteryLevel = r7;	 Catch:{ NumberFormatException -> 0x0172 }
        goto L_0x0161;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01db:
        r6 = "invalid";	 Catch:{ NumberFormatException -> 0x0172 }
        r6 = r6.equals(r1);	 Catch:{ NumberFormatException -> 0x0172 }
        if (r6 == 0) goto L_0x01eb;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01e3:
        r6 = java.lang.Integer.parseInt(r5);	 Catch:{ NumberFormatException -> 0x0172 }
        r11.mInvalidCharger = r6;	 Catch:{ NumberFormatException -> 0x0172 }
        goto L_0x0161;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x01eb:
        r6 = new java.lang.StringBuilder;	 Catch:{ NumberFormatException -> 0x0172 }
        r6.<init>();	 Catch:{ NumberFormatException -> 0x0172 }
        r7 = "Unknown set option: ";	 Catch:{ NumberFormatException -> 0x0172 }
        r6 = r6.append(r7);	 Catch:{ NumberFormatException -> 0x0172 }
        r6 = r6.append(r1);	 Catch:{ NumberFormatException -> 0x0172 }
        r6 = r6.toString();	 Catch:{ NumberFormatException -> 0x0172 }
        r12.println(r6);	 Catch:{ NumberFormatException -> 0x0172 }
        r4 = 0;	 Catch:{ NumberFormatException -> 0x0172 }
        goto L_0x0161;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x0204:
        r6 = move-exception;	 Catch:{ NumberFormatException -> 0x0172 }
        android.os.Binder.restoreCallingIdentity(r2);	 Catch:{ NumberFormatException -> 0x0172 }
        throw r6;	 Catch:{ NumberFormatException -> 0x0172 }
    L_0x0209:
        r7 = r13.length;	 Catch:{ all -> 0x018a }
        if (r7 != r6) goto L_0x0237;	 Catch:{ all -> 0x018a }
    L_0x020c:
        r6 = "reset";	 Catch:{ all -> 0x018a }
        r7 = 0;	 Catch:{ all -> 0x018a }
        r7 = r13[r7];	 Catch:{ all -> 0x018a }
        r6 = r6.equals(r7);	 Catch:{ all -> 0x018a }
        if (r6 == 0) goto L_0x0237;	 Catch:{ all -> 0x018a }
    L_0x0217:
        r2 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x018a }
        r6 = r11.mUpdatesStopped;	 Catch:{ all -> 0x0232 }
        if (r6 == 0) goto L_0x022d;	 Catch:{ all -> 0x0232 }
    L_0x021f:
        r6 = 0;	 Catch:{ all -> 0x0232 }
        r11.mUpdatesStopped = r6;	 Catch:{ all -> 0x0232 }
        r6 = r11.mBatteryProps;	 Catch:{ all -> 0x0232 }
        r7 = r11.mLastBatteryProps;	 Catch:{ all -> 0x0232 }
        r6.set(r7);	 Catch:{ all -> 0x0232 }
        r6 = 0;	 Catch:{ all -> 0x0232 }
        r11.processValuesLocked(r6);	 Catch:{ all -> 0x0232 }
    L_0x022d:
        android.os.Binder.restoreCallingIdentity(r2);	 Catch:{ all -> 0x018a }
        goto L_0x012c;	 Catch:{ all -> 0x018a }
    L_0x0232:
        r6 = move-exception;	 Catch:{ all -> 0x018a }
        android.os.Binder.restoreCallingIdentity(r2);	 Catch:{ all -> 0x018a }
        throw r6;	 Catch:{ all -> 0x018a }
    L_0x0237:
        r6 = "Dump current battery state, or:";	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = "  set [ac|usb|wireless|status|level|invalid] <value>";	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        r6 = "  reset";	 Catch:{ all -> 0x018a }
        r12.println(r6);	 Catch:{ all -> 0x018a }
        goto L_0x012c;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.BatteryService.dumpInternal(java.io.PrintWriter, java.lang.String[]):void");
    }
}
