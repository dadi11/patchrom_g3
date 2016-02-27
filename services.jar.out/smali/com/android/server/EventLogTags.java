package com.android.server;

import android.util.EventLog;

public class EventLogTags {
    public static final int BACKUP_AGENT_FAILURE = 2823;
    public static final int BACKUP_DATA_CHANGED = 2820;
    public static final int BACKUP_INITIALIZE = 2827;
    public static final int BACKUP_PACKAGE = 2824;
    public static final int BACKUP_RESET = 2826;
    public static final int BACKUP_START = 2821;
    public static final int BACKUP_SUCCESS = 2825;
    public static final int BACKUP_TRANSPORT_FAILURE = 2822;
    public static final int BACKUP_TRANSPORT_LIFECYCLE = 2850;
    public static final int BATTERY_DISCHARGE = 2730;
    public static final int BATTERY_LEVEL = 2722;
    public static final int BATTERY_STATUS = 2723;
    public static final int BOOT_PROGRESS_PMS_DATA_SCAN_START = 3080;
    public static final int BOOT_PROGRESS_PMS_READY = 3100;
    public static final int BOOT_PROGRESS_PMS_SCAN_END = 3090;
    public static final int BOOT_PROGRESS_PMS_START = 3060;
    public static final int BOOT_PROGRESS_PMS_SYSTEM_SCAN_START = 3070;
    public static final int BOOT_PROGRESS_SYSTEM_RUN = 3010;
    public static final int CACHE_FILE_DELETED = 2748;
    public static final int CONFIG_INSTALL_FAILED = 51300;
    public static final int CONNECTIVITY_STATE_CHANGED = 50020;
    public static final int FREE_STORAGE_CHANGED = 2744;
    public static final int FREE_STORAGE_LEFT = 2746;
    public static final int FSTRIM_FINISH = 2756;
    public static final int FSTRIM_START = 2755;
    public static final int FULL_BACKUP_AGENT_FAILURE = 2841;
    public static final int FULL_BACKUP_PACKAGE = 2840;
    public static final int FULL_BACKUP_SUCCESS = 2843;
    public static final int FULL_BACKUP_TRANSPORT_FAILURE = 2842;
    public static final int FULL_RESTORE_PACKAGE = 2844;
    public static final int IDLE_MAINTENANCE_WINDOW_FINISH = 2754;
    public static final int IDLE_MAINTENANCE_WINDOW_START = 2753;
    public static final int IFW_INTENT_MATCHED = 51400;
    public static final int IMF_FORCE_RECONNECT_IME = 32000;
    public static final int LOCKDOWN_VPN_CONNECTED = 51201;
    public static final int LOCKDOWN_VPN_CONNECTING = 51200;
    public static final int LOCKDOWN_VPN_ERROR = 51202;
    public static final int LOW_STORAGE = 2745;
    public static final int NETSTATS_MOBILE_SAMPLE = 51100;
    public static final int NETSTATS_WIFI_SAMPLE = 51101;
    public static final int NOTIFICATION_ACTION_CLICKED = 27521;
    public static final int NOTIFICATION_CANCEL = 2751;
    public static final int NOTIFICATION_CANCELED = 27530;
    public static final int NOTIFICATION_CANCEL_ALL = 2752;
    public static final int NOTIFICATION_CLICKED = 27520;
    public static final int NOTIFICATION_ENQUEUE = 2750;
    public static final int NOTIFICATION_EXPANSION = 27511;
    public static final int NOTIFICATION_PANEL_HIDDEN = 27501;
    public static final int NOTIFICATION_PANEL_REVEALED = 27500;
    public static final int NOTIFICATION_VISIBILITY_CHANGED = 27510;
    public static final int PM_CRITICAL_INFO = 3120;
    public static final int POWER_PARTIAL_WAKE_STATE = 2729;
    public static final int POWER_SCREEN_BROADCAST_DONE = 2726;
    public static final int POWER_SCREEN_BROADCAST_SEND = 2725;
    public static final int POWER_SCREEN_BROADCAST_STOP = 2727;
    public static final int POWER_SCREEN_STATE = 2728;
    public static final int POWER_SLEEP_REQUESTED = 2724;
    public static final int RESTORE_AGENT_FAILURE = 2832;
    public static final int RESTORE_PACKAGE = 2833;
    public static final int RESTORE_START = 2830;
    public static final int RESTORE_SUCCESS = 2834;
    public static final int RESTORE_TRANSPORT_FAILURE = 2831;
    public static final int UNKNOWN_SOURCES_ENABLED = 3110;
    public static final int WATCHDOG = 2802;
    public static final int WATCHDOG_HARD_RESET = 2805;
    public static final int WATCHDOG_MEMINFO = 2809;
    public static final int WATCHDOG_PROC_PSS = 2803;
    public static final int WATCHDOG_PROC_STATS = 2807;
    public static final int WATCHDOG_PSS_STATS = 2806;
    public static final int WATCHDOG_REQUESTED_REBOOT = 2811;
    public static final int WATCHDOG_SCHEDULED_REBOOT = 2808;
    public static final int WATCHDOG_SOFT_RESET = 2804;
    public static final int WATCHDOG_VMSTAT = 2810;
    public static final int WM_HOME_STACK_MOVED = 31005;
    public static final int WM_NO_SURFACE_MEMORY = 31000;
    public static final int WM_STACK_CREATED = 31004;
    public static final int WM_STACK_REMOVED = 31006;
    public static final int WM_TASK_CREATED = 31001;
    public static final int WM_TASK_MOVED = 31002;
    public static final int WM_TASK_REMOVED = 31003;
    public static final int WP_WALLPAPER_CRASHED = 33000;

    private EventLogTags() {
    }

    public static void writeBatteryLevel(int level, int voltage, int temperature) {
        EventLog.writeEvent(BATTERY_LEVEL, new Object[]{Integer.valueOf(level), Integer.valueOf(voltage), Integer.valueOf(temperature)});
    }

    public static void writeBatteryStatus(int status, int health, int present, int plugged, String technology) {
        EventLog.writeEvent(BATTERY_STATUS, new Object[]{Integer.valueOf(status), Integer.valueOf(health), Integer.valueOf(present), Integer.valueOf(plugged), technology});
    }

    public static void writeBatteryDischarge(long duration, int minlevel, int maxlevel) {
        EventLog.writeEvent(BATTERY_DISCHARGE, new Object[]{Long.valueOf(duration), Integer.valueOf(minlevel), Integer.valueOf(maxlevel)});
    }

    public static void writePowerSleepRequested(int wakelockscleared) {
        EventLog.writeEvent(POWER_SLEEP_REQUESTED, wakelockscleared);
    }

    public static void writePowerScreenBroadcastSend(int wakelockcount) {
        EventLog.writeEvent(POWER_SCREEN_BROADCAST_SEND, wakelockcount);
    }

    public static void writePowerScreenBroadcastDone(int on, long broadcastduration, int wakelockcount) {
        EventLog.writeEvent(POWER_SCREEN_BROADCAST_DONE, new Object[]{Integer.valueOf(on), Long.valueOf(broadcastduration), Integer.valueOf(wakelockcount)});
    }

    public static void writePowerScreenBroadcastStop(int which, int wakelockcount) {
        EventLog.writeEvent(POWER_SCREEN_BROADCAST_STOP, new Object[]{Integer.valueOf(which), Integer.valueOf(wakelockcount)});
    }

    public static void writePowerScreenState(int offoron, int becauseofuser, long totaltouchdowntime, int touchcycles) {
        EventLog.writeEvent(POWER_SCREEN_STATE, new Object[]{Integer.valueOf(offoron), Integer.valueOf(becauseofuser), Long.valueOf(totaltouchdowntime), Integer.valueOf(touchcycles)});
    }

    public static void writePowerPartialWakeState(int releasedoracquired, String tag) {
        EventLog.writeEvent(POWER_PARTIAL_WAKE_STATE, new Object[]{Integer.valueOf(releasedoracquired), tag});
    }

    public static void writeFreeStorageChanged(long data) {
        EventLog.writeEvent(FREE_STORAGE_CHANGED, data);
    }

    public static void writeLowStorage(long data) {
        EventLog.writeEvent(LOW_STORAGE, data);
    }

    public static void writeFreeStorageLeft(long data, long system, long cache) {
        EventLog.writeEvent(FREE_STORAGE_LEFT, new Object[]{Long.valueOf(data), Long.valueOf(system), Long.valueOf(cache)});
    }

    public static void writeCacheFileDeleted(String path) {
        EventLog.writeEvent(CACHE_FILE_DELETED, path);
    }

    public static void writeNotificationEnqueue(int uid, int pid, String pkg, int id, String tag, int userid, String notification, int status) {
        EventLog.writeEvent(NOTIFICATION_ENQUEUE, new Object[]{Integer.valueOf(uid), Integer.valueOf(pid), pkg, Integer.valueOf(id), tag, Integer.valueOf(userid), notification, Integer.valueOf(status)});
    }

    public static void writeNotificationCancel(int uid, int pid, String pkg, int id, String tag, int userid, int requiredFlags, int forbiddenFlags, int reason, String listener) {
        EventLog.writeEvent(NOTIFICATION_CANCEL, new Object[]{Integer.valueOf(uid), Integer.valueOf(pid), pkg, Integer.valueOf(id), tag, Integer.valueOf(userid), Integer.valueOf(requiredFlags), Integer.valueOf(forbiddenFlags), Integer.valueOf(reason), listener});
    }

    public static void writeNotificationCancelAll(int uid, int pid, String pkg, int userid, int requiredFlags, int forbiddenFlags, int reason, String listener) {
        EventLog.writeEvent(NOTIFICATION_CANCEL_ALL, new Object[]{Integer.valueOf(uid), Integer.valueOf(pid), pkg, Integer.valueOf(userid), Integer.valueOf(requiredFlags), Integer.valueOf(forbiddenFlags), Integer.valueOf(reason), listener});
    }

    public static void writeNotificationPanelRevealed() {
        EventLog.writeEvent(NOTIFICATION_PANEL_REVEALED, new Object[0]);
    }

    public static void writeNotificationPanelHidden() {
        EventLog.writeEvent(NOTIFICATION_PANEL_HIDDEN, new Object[0]);
    }

    public static void writeNotificationVisibilityChanged(String newlyvisiblekeys, String nolongervisiblekeys) {
        EventLog.writeEvent(NOTIFICATION_VISIBILITY_CHANGED, new Object[]{newlyvisiblekeys, nolongervisiblekeys});
    }

    public static void writeNotificationExpansion(String key, int userAction, int expanded) {
        EventLog.writeEvent(NOTIFICATION_EXPANSION, new Object[]{key, Integer.valueOf(userAction), Integer.valueOf(expanded)});
    }

    public static void writeNotificationClicked(String key) {
        EventLog.writeEvent(NOTIFICATION_CLICKED, key);
    }

    public static void writeNotificationActionClicked(String key, int actionIndex) {
        EventLog.writeEvent(NOTIFICATION_ACTION_CLICKED, new Object[]{key, Integer.valueOf(actionIndex)});
    }

    public static void writeNotificationCanceled(String key, int reason) {
        EventLog.writeEvent(NOTIFICATION_CANCELED, new Object[]{key, Integer.valueOf(reason)});
    }

    public static void writeWatchdog(String service) {
        EventLog.writeEvent(WATCHDOG, service);
    }

    public static void writeWatchdogProcPss(String process, int pid, int pss) {
        EventLog.writeEvent(WATCHDOG_PROC_PSS, new Object[]{process, Integer.valueOf(pid), Integer.valueOf(pss)});
    }

    public static void writeWatchdogSoftReset(String process, int pid, int maxpss, int pss, String skip) {
        EventLog.writeEvent(WATCHDOG_SOFT_RESET, new Object[]{process, Integer.valueOf(pid), Integer.valueOf(maxpss), Integer.valueOf(pss), skip});
    }

    public static void writeWatchdogHardReset(String process, int pid, int maxpss, int pss) {
        EventLog.writeEvent(WATCHDOG_HARD_RESET, new Object[]{process, Integer.valueOf(pid), Integer.valueOf(maxpss), Integer.valueOf(pss)});
    }

    public static void writeWatchdogPssStats(int emptypss, int emptycount, int backgroundpss, int backgroundcount, int servicepss, int servicecount, int visiblepss, int visiblecount, int foregroundpss, int foregroundcount, int nopsscount) {
        EventLog.writeEvent(WATCHDOG_PSS_STATS, new Object[]{Integer.valueOf(emptypss), Integer.valueOf(emptycount), Integer.valueOf(backgroundpss), Integer.valueOf(backgroundcount), Integer.valueOf(servicepss), Integer.valueOf(servicecount), Integer.valueOf(visiblepss), Integer.valueOf(visiblecount), Integer.valueOf(foregroundpss), Integer.valueOf(foregroundcount), Integer.valueOf(nopsscount)});
    }

    public static void writeWatchdogProcStats(int deathsinone, int deathsintwo, int deathsinthree, int deathsinfour, int deathsinfive) {
        EventLog.writeEvent(WATCHDOG_PROC_STATS, new Object[]{Integer.valueOf(deathsinone), Integer.valueOf(deathsintwo), Integer.valueOf(deathsinthree), Integer.valueOf(deathsinfour), Integer.valueOf(deathsinfive)});
    }

    public static void writeWatchdogScheduledReboot(long now, int interval, int starttime, int window, String skip) {
        EventLog.writeEvent(WATCHDOG_SCHEDULED_REBOOT, new Object[]{Long.valueOf(now), Integer.valueOf(interval), Integer.valueOf(starttime), Integer.valueOf(window), skip});
    }

    public static void writeWatchdogMeminfo(int memfree, int buffers, int cached, int active, int inactive, int anonpages, int mapped, int slab, int sreclaimable, int sunreclaim, int pagetables) {
        EventLog.writeEvent(WATCHDOG_MEMINFO, new Object[]{Integer.valueOf(memfree), Integer.valueOf(buffers), Integer.valueOf(cached), Integer.valueOf(active), Integer.valueOf(inactive), Integer.valueOf(anonpages), Integer.valueOf(mapped), Integer.valueOf(slab), Integer.valueOf(sreclaimable), Integer.valueOf(sunreclaim), Integer.valueOf(pagetables)});
    }

    public static void writeWatchdogVmstat(long runtime, int pgfree, int pgactivate, int pgdeactivate, int pgfault, int pgmajfault) {
        EventLog.writeEvent(WATCHDOG_VMSTAT, new Object[]{Long.valueOf(runtime), Integer.valueOf(pgfree), Integer.valueOf(pgactivate), Integer.valueOf(pgdeactivate), Integer.valueOf(pgfault), Integer.valueOf(pgmajfault)});
    }

    public static void writeWatchdogRequestedReboot(int nowait, int scheduleinterval, int recheckinterval, int starttime, int window, int minscreenoff, int minnextalarm) {
        EventLog.writeEvent(WATCHDOG_REQUESTED_REBOOT, new Object[]{Integer.valueOf(nowait), Integer.valueOf(scheduleinterval), Integer.valueOf(recheckinterval), Integer.valueOf(starttime), Integer.valueOf(window), Integer.valueOf(minscreenoff), Integer.valueOf(minnextalarm)});
    }

    public static void writeBackupDataChanged(String package_) {
        EventLog.writeEvent(BACKUP_DATA_CHANGED, package_);
    }

    public static void writeBackupStart(String transport) {
        EventLog.writeEvent(BACKUP_START, transport);
    }

    public static void writeBackupTransportFailure(String package_) {
        EventLog.writeEvent(BACKUP_TRANSPORT_FAILURE, package_);
    }

    public static void writeBackupAgentFailure(String package_, String message) {
        EventLog.writeEvent(BACKUP_AGENT_FAILURE, new Object[]{package_, message});
    }

    public static void writeBackupPackage(String package_, int size) {
        EventLog.writeEvent(BACKUP_PACKAGE, new Object[]{package_, Integer.valueOf(size)});
    }

    public static void writeBackupSuccess(int packages, int time) {
        EventLog.writeEvent(BACKUP_SUCCESS, new Object[]{Integer.valueOf(packages), Integer.valueOf(time)});
    }

    public static void writeBackupReset(String transport) {
        EventLog.writeEvent(BACKUP_RESET, transport);
    }

    public static void writeBackupInitialize() {
        EventLog.writeEvent(BACKUP_INITIALIZE, new Object[0]);
    }

    public static void writeRestoreStart(String transport, long source) {
        EventLog.writeEvent(RESTORE_START, new Object[]{transport, Long.valueOf(source)});
    }

    public static void writeRestoreTransportFailure() {
        EventLog.writeEvent(RESTORE_TRANSPORT_FAILURE, new Object[0]);
    }

    public static void writeRestoreAgentFailure(String package_, String message) {
        EventLog.writeEvent(RESTORE_AGENT_FAILURE, new Object[]{package_, message});
    }

    public static void writeRestorePackage(String package_, int size) {
        EventLog.writeEvent(RESTORE_PACKAGE, new Object[]{package_, Integer.valueOf(size)});
    }

    public static void writeRestoreSuccess(int packages, int time) {
        EventLog.writeEvent(RESTORE_SUCCESS, new Object[]{Integer.valueOf(packages), Integer.valueOf(time)});
    }

    public static void writeFullBackupPackage(String package_) {
        EventLog.writeEvent(FULL_BACKUP_PACKAGE, package_);
    }

    public static void writeFullBackupAgentFailure(String package_, String message) {
        EventLog.writeEvent(FULL_BACKUP_AGENT_FAILURE, new Object[]{package_, message});
    }

    public static void writeFullBackupTransportFailure() {
        EventLog.writeEvent(FULL_BACKUP_TRANSPORT_FAILURE, new Object[0]);
    }

    public static void writeFullBackupSuccess(String package_) {
        EventLog.writeEvent(FULL_BACKUP_SUCCESS, package_);
    }

    public static void writeFullRestorePackage(String package_) {
        EventLog.writeEvent(FULL_RESTORE_PACKAGE, package_);
    }

    public static void writeBackupTransportLifecycle(String transport, int bound) {
        EventLog.writeEvent(BACKUP_TRANSPORT_LIFECYCLE, new Object[]{transport, Integer.valueOf(bound)});
    }

    public static void writeBootProgressSystemRun(long time) {
        EventLog.writeEvent(BOOT_PROGRESS_SYSTEM_RUN, time);
    }

    public static void writeBootProgressPmsStart(long time) {
        EventLog.writeEvent(BOOT_PROGRESS_PMS_START, time);
    }

    public static void writeBootProgressPmsSystemScanStart(long time) {
        EventLog.writeEvent(BOOT_PROGRESS_PMS_SYSTEM_SCAN_START, time);
    }

    public static void writeBootProgressPmsDataScanStart(long time) {
        EventLog.writeEvent(BOOT_PROGRESS_PMS_DATA_SCAN_START, time);
    }

    public static void writeBootProgressPmsScanEnd(long time) {
        EventLog.writeEvent(BOOT_PROGRESS_PMS_SCAN_END, time);
    }

    public static void writeBootProgressPmsReady(long time) {
        EventLog.writeEvent(BOOT_PROGRESS_PMS_READY, time);
    }

    public static void writeUnknownSourcesEnabled(int value) {
        EventLog.writeEvent(UNKNOWN_SOURCES_ENABLED, value);
    }

    public static void writePmCriticalInfo(String msg) {
        EventLog.writeEvent(PM_CRITICAL_INFO, msg);
    }

    public static void writeWmNoSurfaceMemory(String window, int pid, String operation) {
        EventLog.writeEvent(WM_NO_SURFACE_MEMORY, new Object[]{window, Integer.valueOf(pid), operation});
    }

    public static void writeWmTaskCreated(int taskid, int stackid) {
        EventLog.writeEvent(WM_TASK_CREATED, new Object[]{Integer.valueOf(taskid), Integer.valueOf(stackid)});
    }

    public static void writeWmTaskMoved(int taskid, int totop, int index) {
        EventLog.writeEvent(WM_TASK_MOVED, new Object[]{Integer.valueOf(taskid), Integer.valueOf(totop), Integer.valueOf(index)});
    }

    public static void writeWmTaskRemoved(int taskid, String reason) {
        EventLog.writeEvent(WM_TASK_REMOVED, new Object[]{Integer.valueOf(taskid), reason});
    }

    public static void writeWmStackCreated(int stackid, int relativeboxid, int position, int weight) {
        EventLog.writeEvent(WM_STACK_CREATED, new Object[]{Integer.valueOf(stackid), Integer.valueOf(relativeboxid), Integer.valueOf(position), Integer.valueOf(weight)});
    }

    public static void writeWmHomeStackMoved(int totop) {
        EventLog.writeEvent(WM_HOME_STACK_MOVED, totop);
    }

    public static void writeWmStackRemoved(int stackid) {
        EventLog.writeEvent(WM_STACK_REMOVED, stackid);
    }

    public static void writeImfForceReconnectIme(Object[] ime, long timeSinceConnect, int showing) {
        EventLog.writeEvent(IMF_FORCE_RECONNECT_IME, new Object[]{ime, Long.valueOf(timeSinceConnect), Integer.valueOf(showing)});
    }

    public static void writeWpWallpaperCrashed(String component) {
        EventLog.writeEvent(WP_WALLPAPER_CRASHED, component);
    }

    public static void writeConnectivityStateChanged(int type, int subtype, int state) {
        EventLog.writeEvent(CONNECTIVITY_STATE_CHANGED, new Object[]{Integer.valueOf(type), Integer.valueOf(subtype), Integer.valueOf(state)});
    }

    public static void writeNetstatsMobileSample(long devRxBytes, long devTxBytes, long devRxPkts, long devTxPkts, long xtRxBytes, long xtTxBytes, long xtRxPkts, long xtTxPkts, long uidRxBytes, long uidTxBytes, long uidRxPkts, long uidTxPkts, long trustedTime) {
        EventLog.writeEvent(NETSTATS_MOBILE_SAMPLE, new Object[]{Long.valueOf(devRxBytes), Long.valueOf(devTxBytes), Long.valueOf(devRxPkts), Long.valueOf(devTxPkts), Long.valueOf(xtRxBytes), Long.valueOf(xtTxBytes), Long.valueOf(xtRxPkts), Long.valueOf(xtTxPkts), Long.valueOf(uidRxBytes), Long.valueOf(uidTxBytes), Long.valueOf(uidRxPkts), Long.valueOf(uidTxPkts), Long.valueOf(trustedTime)});
    }

    public static void writeNetstatsWifiSample(long devRxBytes, long devTxBytes, long devRxPkts, long devTxPkts, long xtRxBytes, long xtTxBytes, long xtRxPkts, long xtTxPkts, long uidRxBytes, long uidTxBytes, long uidRxPkts, long uidTxPkts, long trustedTime) {
        EventLog.writeEvent(NETSTATS_WIFI_SAMPLE, new Object[]{Long.valueOf(devRxBytes), Long.valueOf(devTxBytes), Long.valueOf(devRxPkts), Long.valueOf(devTxPkts), Long.valueOf(xtRxBytes), Long.valueOf(xtTxBytes), Long.valueOf(xtRxPkts), Long.valueOf(xtTxPkts), Long.valueOf(uidRxBytes), Long.valueOf(uidTxBytes), Long.valueOf(uidRxPkts), Long.valueOf(uidTxPkts), Long.valueOf(trustedTime)});
    }

    public static void writeLockdownVpnConnecting(int egressNet) {
        EventLog.writeEvent(LOCKDOWN_VPN_CONNECTING, egressNet);
    }

    public static void writeLockdownVpnConnected(int egressNet) {
        EventLog.writeEvent(LOCKDOWN_VPN_CONNECTED, egressNet);
    }

    public static void writeLockdownVpnError(int egressNet) {
        EventLog.writeEvent(LOCKDOWN_VPN_ERROR, egressNet);
    }

    public static void writeConfigInstallFailed(String dir) {
        EventLog.writeEvent(CONFIG_INSTALL_FAILED, dir);
    }

    public static void writeIfwIntentMatched(int intentType, String componentName, int callerUid, int callerPkgCount, String callerPkgs, String action, String mimeType, String uri, int flags) {
        EventLog.writeEvent(IFW_INTENT_MATCHED, new Object[]{Integer.valueOf(intentType), componentName, Integer.valueOf(callerUid), Integer.valueOf(callerPkgCount), callerPkgs, action, mimeType, uri, Integer.valueOf(flags)});
    }

    public static void writeIdleMaintenanceWindowStart(long time, long lastuseractivity, int batterylevel, int batterycharging) {
        EventLog.writeEvent(IDLE_MAINTENANCE_WINDOW_START, new Object[]{Long.valueOf(time), Long.valueOf(lastuseractivity), Integer.valueOf(batterylevel), Integer.valueOf(batterycharging)});
    }

    public static void writeIdleMaintenanceWindowFinish(long time, long lastuseractivity, int batterylevel, int batterycharging) {
        EventLog.writeEvent(IDLE_MAINTENANCE_WINDOW_FINISH, new Object[]{Long.valueOf(time), Long.valueOf(lastuseractivity), Integer.valueOf(batterylevel), Integer.valueOf(batterycharging)});
    }

    public static void writeFstrimStart(long time) {
        EventLog.writeEvent(FSTRIM_START, time);
    }

    public static void writeFstrimFinish(long time) {
        EventLog.writeEvent(FSTRIM_FINISH, time);
    }
}
