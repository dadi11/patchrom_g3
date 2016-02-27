package com.android.server.usb;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Resources;
import android.database.ContentObserver;
import android.hardware.usb.UsbAccessory;
import android.os.FileUtils;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.ParcelFileDescriptor;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UEventObserver;
import android.os.UEventObserver.UEvent;
import android.os.UserHandle;
import android.os.UserManager;
import android.os.storage.StorageManager;
import android.os.storage.StorageVolume;
import android.provider.Settings.Global;
import android.util.Pair;
import android.util.Slog;
import com.android.internal.annotations.GuardedBy;
import com.android.server.FgThread;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Scanner;

public class UsbDeviceManager {
    private static final int ACCESSORY_REQUEST_TIMEOUT = 10000;
    private static final String ACCESSORY_START_MATCH = "DEVPATH=/devices/virtual/misc/usb_accessory";
    private static final int AUDIO_MODE_NONE = 0;
    private static final int AUDIO_MODE_SOURCE = 1;
    private static final String AUDIO_SOURCE_PCM_PATH = "/sys/class/android_usb/android0/f_audio_source/pcm";
    private static final String BOOT_MODE_PROPERTY = "ro.bootmode";
    private static final boolean DEBUG = false;
    private static final String FUNCTIONS_PATH = "/sys/class/android_usb/android0/functions";
    private static final String MASS_STORAGE_FILE_PATH = "/sys/class/android_usb/android0/f_mass_storage/lun/file";
    private static final int MSG_BOOT_COMPLETED = 4;
    private static final int MSG_ENABLE_ADB = 1;
    private static final int MSG_SET_CURRENT_FUNCTIONS = 2;
    private static final int MSG_SYSTEM_READY = 3;
    private static final int MSG_UPDATE_STATE = 0;
    private static final int MSG_USER_SWITCHED = 5;
    private static final String RNDIS_ETH_ADDR_PATH = "/sys/class/android_usb/android0/f_rndis/ethaddr";
    private static final String STATE_PATH = "/sys/class/android_usb/android0/state";
    private static final String TAG;
    private static final int UPDATE_DELAY = 1000;
    private static final String USB_STATE_MATCH = "DEVPATH=/devices/virtual/android_usb/android0";
    private long mAccessoryModeRequestTime;
    private String[] mAccessoryStrings;
    private boolean mAdbEnabled;
    private boolean mAudioSourceEnabled;
    private boolean mBootCompleted;
    private final ContentResolver mContentResolver;
    private final Context mContext;
    @GuardedBy("mLock")
    private UsbSettingsManager mCurrentSettings;
    private UsbDebuggingManager mDebuggingManager;
    private UsbHandler mHandler;
    private final boolean mHasUsbAccessory;
    private final Object mLock;
    private NotificationManager mNotificationManager;
    private Map<String, List<Pair<String, String>>> mOemModeMap;
    private final UEventObserver mUEventObserver;
    private boolean mUseUsbNotification;

    /* renamed from: com.android.server.usb.UsbDeviceManager.1 */
    class C05461 extends UEventObserver {
        C05461() {
        }

        public void onUEvent(UEvent event) {
            String state = event.get("USB_STATE");
            String accessory = event.get("ACCESSORY");
            if (state != null) {
                UsbDeviceManager.this.mHandler.updateState(state);
            } else if ("START".equals(accessory)) {
                UsbDeviceManager.this.startAccessoryMode();
            }
        }
    }

    private class AdbSettingsObserver extends ContentObserver {
        public AdbSettingsObserver() {
            super(null);
        }

        public void onChange(boolean selfChange) {
            boolean enable = UsbDeviceManager.DEBUG;
            if (Global.getInt(UsbDeviceManager.this.mContentResolver, "adb_enabled", UsbDeviceManager.MSG_UPDATE_STATE) > 0) {
                enable = true;
            }
            UsbDeviceManager.this.mHandler.sendMessage((int) UsbDeviceManager.MSG_ENABLE_ADB, enable);
        }
    }

    private final class UsbHandler extends Handler {
        private boolean mAdbNotificationShown;
        private final BroadcastReceiver mBootCompletedReceiver;
        private boolean mConfigured;
        private boolean mConnected;
        private UsbAccessory mCurrentAccessory;
        private String mCurrentFunctions;
        private int mCurrentUser;
        private String mDefaultFunctions;
        private int mUsbNotificationId;
        private final BroadcastReceiver mUserSwitchedReceiver;

        /* renamed from: com.android.server.usb.UsbDeviceManager.UsbHandler.1 */
        class C05471 extends BroadcastReceiver {
            C05471() {
            }

            public void onReceive(Context context, Intent intent) {
                UsbDeviceManager.this.mHandler.sendEmptyMessage(UsbDeviceManager.MSG_BOOT_COMPLETED);
            }
        }

        /* renamed from: com.android.server.usb.UsbDeviceManager.UsbHandler.2 */
        class C05482 extends BroadcastReceiver {
            C05482() {
            }

            public void onReceive(Context context, Intent intent) {
                UsbDeviceManager.this.mHandler.obtainMessage(UsbDeviceManager.MSG_USER_SWITCHED, intent.getIntExtra("android.intent.extra.user_handle", -1), UsbDeviceManager.MSG_UPDATE_STATE).sendToTarget();
            }
        }

        public UsbHandler(Looper looper) {
            super(looper);
            this.mCurrentUser = -10000;
            this.mBootCompletedReceiver = new C05471();
            this.mUserSwitchedReceiver = new C05482();
            try {
                this.mDefaultFunctions = SystemProperties.get("persist.sys.usb.config", "adb");
                this.mDefaultFunctions = UsbDeviceManager.this.processOemUsbOverride(this.mDefaultFunctions);
                if (!SystemProperties.get("sys.usb.config", "none").equals(this.mDefaultFunctions)) {
                    Slog.w(UsbDeviceManager.TAG, "resetting config to persistent property: " + this.mDefaultFunctions);
                    SystemProperties.set("sys.usb.config", this.mDefaultFunctions);
                }
                this.mCurrentFunctions = getDefaultFunctions();
                updateState(FileUtils.readTextFile(new File(UsbDeviceManager.STATE_PATH), UsbDeviceManager.MSG_UPDATE_STATE, null).trim());
                UsbDeviceManager.this.mAdbEnabled = UsbDeviceManager.containsFunction(this.mCurrentFunctions, "adb");
                String value = SystemProperties.get("persist.service.adb.enable", "");
                if (value.length() > 0) {
                    char enable = value.charAt(UsbDeviceManager.MSG_UPDATE_STATE);
                    if (enable == '1') {
                        setAdbEnabled(true);
                    } else if (enable == '0') {
                        setAdbEnabled(UsbDeviceManager.DEBUG);
                    }
                    SystemProperties.set("persist.service.adb.enable", "");
                }
                UsbDeviceManager.this.mContentResolver.registerContentObserver(Global.getUriFor("adb_enabled"), UsbDeviceManager.DEBUG, new AdbSettingsObserver());
                UsbDeviceManager.this.mUEventObserver.startObserving(UsbDeviceManager.USB_STATE_MATCH);
                UsbDeviceManager.this.mUEventObserver.startObserving(UsbDeviceManager.ACCESSORY_START_MATCH);
                IntentFilter filter = new IntentFilter("android.intent.action.BOOT_COMPLETED");
                filter.setPriority(UsbDeviceManager.UPDATE_DELAY);
                UsbDeviceManager.this.mContext.registerReceiver(this.mBootCompletedReceiver, filter);
                UsbDeviceManager.this.mContext.registerReceiver(this.mUserSwitchedReceiver, new IntentFilter("android.intent.action.USER_SWITCHED"));
            } catch (Exception e) {
                Slog.e(UsbDeviceManager.TAG, "Error initializing UsbHandler", e);
            }
        }

        public void sendMessage(int what, boolean arg) {
            removeMessages(what);
            Message m = Message.obtain(this, what);
            m.arg1 = arg ? UsbDeviceManager.MSG_ENABLE_ADB : UsbDeviceManager.MSG_UPDATE_STATE;
            sendMessage(m);
        }

        public void sendMessage(int what, Object arg) {
            removeMessages(what);
            Message m = Message.obtain(this, what);
            m.obj = arg;
            sendMessage(m);
        }

        public void sendMessage(int what, Object arg0, boolean arg1) {
            removeMessages(what);
            Message m = Message.obtain(this, what);
            m.obj = arg0;
            m.arg1 = arg1 ? UsbDeviceManager.MSG_ENABLE_ADB : UsbDeviceManager.MSG_UPDATE_STATE;
            sendMessage(m);
        }

        public void updateState(String state) {
            int connected;
            int configured;
            if ("DISCONNECTED".equals(state)) {
                connected = UsbDeviceManager.MSG_UPDATE_STATE;
                configured = UsbDeviceManager.MSG_UPDATE_STATE;
            } else if ("CONNECTED".equals(state)) {
                connected = UsbDeviceManager.MSG_ENABLE_ADB;
                configured = UsbDeviceManager.MSG_UPDATE_STATE;
            } else if ("CONFIGURED".equals(state)) {
                connected = UsbDeviceManager.MSG_ENABLE_ADB;
                configured = UsbDeviceManager.MSG_ENABLE_ADB;
            } else {
                Slog.e(UsbDeviceManager.TAG, "unknown state " + state);
                return;
            }
            removeMessages(UsbDeviceManager.MSG_UPDATE_STATE);
            Message msg = Message.obtain(this, UsbDeviceManager.MSG_UPDATE_STATE);
            msg.arg1 = connected;
            msg.arg2 = configured;
            sendMessageDelayed(msg, connected == 0 ? 1000 : 0);
        }

        private boolean waitForState(String state) {
            for (int i = UsbDeviceManager.MSG_UPDATE_STATE; i < 20; i += UsbDeviceManager.MSG_ENABLE_ADB) {
                if (state.equals(SystemProperties.get("sys.usb.state"))) {
                    return true;
                }
                SystemClock.sleep(50);
            }
            Slog.e(UsbDeviceManager.TAG, "waitForState(" + state + ") FAILED");
            return UsbDeviceManager.DEBUG;
        }

        private boolean setUsbConfig(String config) {
            SystemProperties.set("sys.usb.config", config);
            return waitForState(config);
        }

        private void setAdbEnabled(boolean enable) {
            if (enable != UsbDeviceManager.this.mAdbEnabled) {
                UsbDeviceManager.this.mAdbEnabled = enable;
                setEnabledFunctions(this.mDefaultFunctions, true);
                setEnabledFunctions(getDefaultFunctions(), UsbDeviceManager.DEBUG);
                updateAdbNotification();
            }
            if (UsbDeviceManager.this.mDebuggingManager != null) {
                UsbDeviceManager.this.mDebuggingManager.setAdbEnabled(UsbDeviceManager.this.mAdbEnabled);
            }
        }

        private void setEnabledFunctions(String functions, boolean makeDefault) {
            if (functions == null || !makeDefault || UsbDeviceManager.this.needsOemUsbOverride()) {
                if (functions == null) {
                    functions = this.mDefaultFunctions;
                }
                functions = UsbDeviceManager.this.processOemUsbOverride(functions);
                if (UsbDeviceManager.this.mAdbEnabled) {
                    functions = UsbDeviceManager.addFunction(functions, "adb");
                } else {
                    functions = UsbDeviceManager.removeFunction(functions, "adb");
                }
                if (!this.mCurrentFunctions.equals(functions)) {
                    if (!setUsbConfig("none")) {
                        Slog.e(UsbDeviceManager.TAG, "Failed to disable USB");
                        setUsbConfig(this.mCurrentFunctions);
                        return;
                    } else if (setUsbConfig(functions)) {
                        this.mCurrentFunctions = functions;
                        return;
                    } else {
                        Slog.e(UsbDeviceManager.TAG, "Failed to switch USB config to " + functions);
                        setUsbConfig(this.mCurrentFunctions);
                        return;
                    }
                }
                return;
            }
            if (UsbDeviceManager.this.mAdbEnabled) {
                functions = UsbDeviceManager.addFunction(functions, "adb");
            } else {
                functions = UsbDeviceManager.removeFunction(functions, "adb");
            }
            if (!this.mDefaultFunctions.equals(functions)) {
                if (setUsbConfig("none")) {
                    SystemProperties.set("persist.sys.usb.config", functions);
                    if (waitForState(functions)) {
                        this.mCurrentFunctions = functions;
                        this.mDefaultFunctions = functions;
                        return;
                    }
                    Slog.e(UsbDeviceManager.TAG, "Failed to switch persistent USB config to " + functions);
                    SystemProperties.set("persist.sys.usb.config", this.mDefaultFunctions);
                    return;
                }
                Slog.e(UsbDeviceManager.TAG, "Failed to disable USB");
                setUsbConfig(this.mCurrentFunctions);
            }
        }

        private void updateCurrentAccessory() {
            boolean enteringAccessoryMode;
            if (UsbDeviceManager.this.mAccessoryModeRequestTime <= 0 || SystemClock.elapsedRealtime() >= UsbDeviceManager.this.mAccessoryModeRequestTime + 10000) {
                enteringAccessoryMode = UsbDeviceManager.DEBUG;
            } else {
                enteringAccessoryMode = true;
            }
            if (this.mConfigured && enteringAccessoryMode) {
                if (UsbDeviceManager.this.mAccessoryStrings != null) {
                    this.mCurrentAccessory = new UsbAccessory(UsbDeviceManager.this.mAccessoryStrings);
                    Slog.d(UsbDeviceManager.TAG, "entering USB accessory mode: " + this.mCurrentAccessory);
                    if (UsbDeviceManager.this.mBootCompleted) {
                        UsbDeviceManager.this.getCurrentSettings().accessoryAttached(this.mCurrentAccessory);
                        return;
                    }
                    return;
                }
                Slog.e(UsbDeviceManager.TAG, "nativeGetAccessoryStrings failed");
            } else if (!enteringAccessoryMode) {
                Slog.d(UsbDeviceManager.TAG, "exited USB accessory mode");
                setEnabledFunctions(getDefaultFunctions(), UsbDeviceManager.DEBUG);
                if (this.mCurrentAccessory != null) {
                    if (UsbDeviceManager.this.mBootCompleted) {
                        UsbDeviceManager.this.getCurrentSettings().accessoryDetached(this.mCurrentAccessory);
                    }
                    this.mCurrentAccessory = null;
                    UsbDeviceManager.this.mAccessoryStrings = null;
                }
            }
        }

        private void updateUsbState() {
            Intent intent = new Intent("android.hardware.usb.action.USB_STATE");
            intent.addFlags(536870912);
            intent.putExtra("connected", this.mConnected);
            intent.putExtra("configured", this.mConfigured);
            if (this.mCurrentFunctions != null) {
                String[] functions = this.mCurrentFunctions.split(",");
                for (int i = UsbDeviceManager.MSG_UPDATE_STATE; i < functions.length; i += UsbDeviceManager.MSG_ENABLE_ADB) {
                    intent.putExtra(functions[i], true);
                }
            }
            UsbDeviceManager.this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
        }

        private void updateAudioSourceFunction() {
            FileNotFoundException e;
            Throwable th;
            boolean enabled = UsbDeviceManager.containsFunction(this.mCurrentFunctions, "audio_source");
            if (enabled != UsbDeviceManager.this.mAudioSourceEnabled) {
                Intent intent = new Intent("android.media.action.USB_AUDIO_ACCESSORY_PLUG");
                intent.addFlags(536870912);
                intent.addFlags(1073741824);
                intent.putExtra("state", enabled ? UsbDeviceManager.MSG_ENABLE_ADB : UsbDeviceManager.MSG_UPDATE_STATE);
                if (enabled) {
                    Scanner scanner = null;
                    try {
                        Scanner scanner2 = new Scanner(new File(UsbDeviceManager.AUDIO_SOURCE_PCM_PATH));
                        try {
                            int card = scanner2.nextInt();
                            int device = scanner2.nextInt();
                            intent.putExtra("card", card);
                            intent.putExtra("device", device);
                            if (scanner2 != null) {
                                scanner2.close();
                            }
                        } catch (FileNotFoundException e2) {
                            e = e2;
                            scanner = scanner2;
                            try {
                                Slog.e(UsbDeviceManager.TAG, "could not open audio source PCM file", e);
                                if (scanner != null) {
                                    scanner.close();
                                }
                                UsbDeviceManager.this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
                                UsbDeviceManager.this.mAudioSourceEnabled = enabled;
                            } catch (Throwable th2) {
                                th = th2;
                                if (scanner != null) {
                                    scanner.close();
                                }
                                throw th;
                            }
                        } catch (Throwable th3) {
                            th = th3;
                            scanner = scanner2;
                            if (scanner != null) {
                                scanner.close();
                            }
                            throw th;
                        }
                    } catch (FileNotFoundException e3) {
                        e = e3;
                        Slog.e(UsbDeviceManager.TAG, "could not open audio source PCM file", e);
                        if (scanner != null) {
                            scanner.close();
                        }
                        UsbDeviceManager.this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
                        UsbDeviceManager.this.mAudioSourceEnabled = enabled;
                    }
                }
                UsbDeviceManager.this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
                UsbDeviceManager.this.mAudioSourceEnabled = enabled;
            }
        }

        public void handleMessage(Message msg) {
            boolean z = true;
            switch (msg.what) {
                case UsbDeviceManager.MSG_UPDATE_STATE /*0*/:
                    this.mConnected = msg.arg1 == UsbDeviceManager.MSG_ENABLE_ADB ? true : UsbDeviceManager.DEBUG;
                    if (msg.arg2 != UsbDeviceManager.MSG_ENABLE_ADB) {
                        z = UsbDeviceManager.DEBUG;
                    }
                    this.mConfigured = z;
                    updateUsbNotification();
                    updateAdbNotification();
                    if (UsbDeviceManager.containsFunction(this.mCurrentFunctions, "accessory")) {
                        updateCurrentAccessory();
                    } else if (!this.mConnected) {
                        setEnabledFunctions(getDefaultFunctions(), UsbDeviceManager.DEBUG);
                    }
                    if (UsbDeviceManager.this.mBootCompleted) {
                        updateUsbState();
                        updateAudioSourceFunction();
                    }
                case UsbDeviceManager.MSG_ENABLE_ADB /*1*/:
                    if (msg.arg1 != UsbDeviceManager.MSG_ENABLE_ADB) {
                        z = UsbDeviceManager.DEBUG;
                    }
                    setAdbEnabled(z);
                case UsbDeviceManager.MSG_SET_CURRENT_FUNCTIONS /*2*/:
                    boolean makeDefault;
                    String functions = msg.obj;
                    if (msg.arg1 == UsbDeviceManager.MSG_ENABLE_ADB) {
                        makeDefault = true;
                    } else {
                        makeDefault = UsbDeviceManager.DEBUG;
                    }
                    setEnabledFunctions(functions, makeDefault);
                case UsbDeviceManager.MSG_SYSTEM_READY /*3*/:
                    updateUsbNotification();
                    updateAdbNotification();
                    updateUsbState();
                    updateAudioSourceFunction();
                case UsbDeviceManager.MSG_BOOT_COMPLETED /*4*/:
                    UsbDeviceManager.this.mBootCompleted = true;
                    if (this.mCurrentAccessory != null) {
                        UsbDeviceManager.this.getCurrentSettings().accessoryAttached(this.mCurrentAccessory);
                    }
                    if (UsbDeviceManager.this.mDebuggingManager != null) {
                        UsbDeviceManager.this.mDebuggingManager.setAdbEnabled(UsbDeviceManager.this.mAdbEnabled);
                    }
                case UsbDeviceManager.MSG_USER_SWITCHED /*5*/:
                    if (((UserManager) UsbDeviceManager.this.mContext.getSystemService("user")).hasUserRestriction("no_usb_file_transfer", new UserHandle(msg.arg1))) {
                        Slog.v(UsbDeviceManager.TAG, "Switched to user " + msg.arg1 + " with DISALLOW_USB_FILE_TRANSFER restriction; disabling USB.");
                        setUsbConfig("none");
                        this.mCurrentUser = msg.arg1;
                        return;
                    }
                    boolean mtpActive;
                    if (UsbDeviceManager.containsFunction(this.mCurrentFunctions, "mtp") || UsbDeviceManager.containsFunction(this.mCurrentFunctions, "ptp")) {
                        mtpActive = true;
                    } else {
                        mtpActive = UsbDeviceManager.DEBUG;
                    }
                    if (mtpActive && this.mCurrentUser != -10000) {
                        Slog.v(UsbDeviceManager.TAG, "Current user switched; resetting USB host stack for MTP");
                        setUsbConfig("none");
                        setUsbConfig(this.mCurrentFunctions);
                    }
                    this.mCurrentUser = msg.arg1;
                default:
            }
        }

        public UsbAccessory getCurrentAccessory() {
            return this.mCurrentAccessory;
        }

        private void updateUsbNotification() {
            if (UsbDeviceManager.this.mNotificationManager != null && UsbDeviceManager.this.mUseUsbNotification) {
                int id = UsbDeviceManager.MSG_UPDATE_STATE;
                Resources r = UsbDeviceManager.this.mContext.getResources();
                if (this.mConnected) {
                    if (UsbDeviceManager.containsFunction(this.mCurrentFunctions, "mtp")) {
                        id = 17040646;
                    } else if (UsbDeviceManager.containsFunction(this.mCurrentFunctions, "ptp")) {
                        id = 17040647;
                    } else if (UsbDeviceManager.containsFunction(this.mCurrentFunctions, "mass_storage")) {
                        id = 17040648;
                    } else if (UsbDeviceManager.containsFunction(this.mCurrentFunctions, "accessory")) {
                        id = 17040649;
                    }
                }
                if (id != this.mUsbNotificationId) {
                    if (this.mUsbNotificationId != 0) {
                        UsbDeviceManager.this.mNotificationManager.cancelAsUser(null, this.mUsbNotificationId, UserHandle.ALL);
                        this.mUsbNotificationId = UsbDeviceManager.MSG_UPDATE_STATE;
                    }
                    if (id != 0) {
                        CharSequence message = r.getText(17040650);
                        CharSequence title = r.getText(id);
                        Notification notification = new Notification();
                        notification.icon = 17303153;
                        notification.when = 0;
                        notification.flags = UsbDeviceManager.MSG_SET_CURRENT_FUNCTIONS;
                        notification.tickerText = title;
                        notification.defaults = UsbDeviceManager.MSG_UPDATE_STATE;
                        notification.sound = null;
                        notification.vibrate = null;
                        notification.priority = -2;
                        PendingIntent pi = PendingIntent.getActivityAsUser(UsbDeviceManager.this.mContext, UsbDeviceManager.MSG_UPDATE_STATE, Intent.makeRestartActivityTask(new ComponentName("com.android.settings", "com.android.settings.UsbSettings")), UsbDeviceManager.MSG_UPDATE_STATE, null, UserHandle.CURRENT);
                        notification.color = UsbDeviceManager.this.mContext.getResources().getColor(17170521);
                        notification.setLatestEventInfo(UsbDeviceManager.this.mContext, title, message, pi);
                        notification.visibility = UsbDeviceManager.MSG_ENABLE_ADB;
                        UsbDeviceManager.this.mNotificationManager.notifyAsUser(null, id, notification, UserHandle.ALL);
                        this.mUsbNotificationId = id;
                    }
                }
            }
        }

        private void updateAdbNotification() {
            if (UsbDeviceManager.this.mNotificationManager != null) {
                if (UsbDeviceManager.this.mAdbEnabled && this.mConnected) {
                    if (!"0".equals(SystemProperties.get("persist.adb.notify")) && !this.mAdbNotificationShown) {
                        Resources r = UsbDeviceManager.this.mContext.getResources();
                        CharSequence title = r.getText(17040654);
                        CharSequence message = r.getText(17040655);
                        Notification notification = new Notification();
                        notification.icon = 17303122;
                        notification.when = 0;
                        notification.flags = UsbDeviceManager.MSG_SET_CURRENT_FUNCTIONS;
                        notification.tickerText = title;
                        notification.defaults = UsbDeviceManager.MSG_UPDATE_STATE;
                        notification.sound = null;
                        notification.vibrate = null;
                        notification.priority = -1;
                        PendingIntent pi = PendingIntent.getActivityAsUser(UsbDeviceManager.this.mContext, UsbDeviceManager.MSG_UPDATE_STATE, Intent.makeRestartActivityTask(new ComponentName("com.android.settings", "com.android.settings.DevelopmentSettings")), UsbDeviceManager.MSG_UPDATE_STATE, null, UserHandle.CURRENT);
                        notification.color = UsbDeviceManager.this.mContext.getResources().getColor(17170521);
                        notification.setLatestEventInfo(UsbDeviceManager.this.mContext, title, message, pi);
                        notification.visibility = UsbDeviceManager.MSG_ENABLE_ADB;
                        this.mAdbNotificationShown = true;
                        UsbDeviceManager.this.mNotificationManager.notifyAsUser(null, 17040654, notification, UserHandle.ALL);
                    }
                } else if (this.mAdbNotificationShown) {
                    this.mAdbNotificationShown = UsbDeviceManager.DEBUG;
                    UsbDeviceManager.this.mNotificationManager.cancelAsUser(null, 17040654, UserHandle.ALL);
                }
            }
        }

        private String getDefaultFunctions() {
            if (((UserManager) UsbDeviceManager.this.mContext.getSystemService("user")).hasUserRestriction("no_usb_file_transfer", new UserHandle(this.mCurrentUser))) {
                return "none";
            }
            return this.mDefaultFunctions;
        }

        public void dump(FileDescriptor fd, PrintWriter pw) {
            pw.println("  USB Device State:");
            pw.println("    Current Functions: " + this.mCurrentFunctions);
            pw.println("    Default Functions: " + this.mDefaultFunctions);
            pw.println("    mConnected: " + this.mConnected);
            pw.println("    mConfigured: " + this.mConfigured);
            pw.println("    mCurrentAccessory: " + this.mCurrentAccessory);
            try {
                pw.println("    Kernel state: " + FileUtils.readTextFile(new File(UsbDeviceManager.STATE_PATH), UsbDeviceManager.MSG_UPDATE_STATE, null).trim());
                pw.println("    Kernel function list: " + FileUtils.readTextFile(new File(UsbDeviceManager.FUNCTIONS_PATH), UsbDeviceManager.MSG_UPDATE_STATE, null).trim());
                pw.println("    Mass storage backing file: " + FileUtils.readTextFile(new File(UsbDeviceManager.MASS_STORAGE_FILE_PATH), UsbDeviceManager.MSG_UPDATE_STATE, null).trim());
            } catch (IOException e) {
                pw.println("IOException: " + e);
            }
        }
    }

    private native String[] nativeGetAccessoryStrings();

    private native int nativeGetAudioMode();

    private native boolean nativeIsStartRequested();

    private native ParcelFileDescriptor nativeOpenAccessory();

    static {
        TAG = UsbDeviceManager.class.getSimpleName();
    }

    public UsbDeviceManager(Context context) {
        this.mAccessoryModeRequestTime = 0;
        this.mLock = new Object();
        this.mUEventObserver = new C05461();
        this.mContext = context;
        this.mContentResolver = context.getContentResolver();
        this.mHasUsbAccessory = this.mContext.getPackageManager().hasSystemFeature("android.hardware.usb.accessory");
        initRndisAddress();
        readOemUsbOverrideConfig();
        this.mHandler = new UsbHandler(FgThread.get().getLooper());
        if (nativeIsStartRequested()) {
            startAccessoryMode();
        }
        boolean secureAdbEnabled = SystemProperties.getBoolean("ro.adb.secure", DEBUG);
        boolean dataEncrypted = "1".equals(SystemProperties.get("vold.decrypt"));
        if (secureAdbEnabled && !dataEncrypted) {
            this.mDebuggingManager = new UsbDebuggingManager(context);
        }
    }

    public void setCurrentSettings(UsbSettingsManager settings) {
        synchronized (this.mLock) {
            this.mCurrentSettings = settings;
        }
    }

    private UsbSettingsManager getCurrentSettings() {
        UsbSettingsManager usbSettingsManager;
        synchronized (this.mLock) {
            usbSettingsManager = this.mCurrentSettings;
        }
        return usbSettingsManager;
    }

    public void systemReady() {
        boolean z;
        int i = MSG_ENABLE_ADB;
        this.mNotificationManager = (NotificationManager) this.mContext.getSystemService("notification");
        StorageVolume primary = StorageManager.from(this.mContext).getPrimaryVolume();
        boolean massStorageSupported = (primary == null || !primary.allowMassStorage()) ? DEBUG : true;
        if (massStorageSupported) {
            z = DEBUG;
        } else {
            z = true;
        }
        this.mUseUsbNotification = z;
        try {
            ContentResolver contentResolver = this.mContentResolver;
            String str = "adb_enabled";
            if (!this.mAdbEnabled) {
                i = MSG_UPDATE_STATE;
            }
            Global.putInt(contentResolver, str, i);
        } catch (SecurityException e) {
            Slog.d(TAG, "ADB_ENABLED is restricted.");
        }
        this.mHandler.sendEmptyMessage(MSG_SYSTEM_READY);
    }

    private void startAccessoryMode() {
        if (this.mHasUsbAccessory) {
            boolean enableAudio;
            boolean enableAccessory;
            this.mAccessoryStrings = nativeGetAccessoryStrings();
            if (nativeGetAudioMode() == MSG_ENABLE_ADB) {
                enableAudio = true;
            } else {
                enableAudio = DEBUG;
            }
            if (this.mAccessoryStrings == null || this.mAccessoryStrings[MSG_UPDATE_STATE] == null || this.mAccessoryStrings[MSG_ENABLE_ADB] == null) {
                enableAccessory = DEBUG;
            } else {
                enableAccessory = true;
            }
            String functions = null;
            if (enableAccessory && enableAudio) {
                functions = "accessory,audio_source";
            } else if (enableAccessory) {
                functions = "accessory";
            } else if (enableAudio) {
                functions = "audio_source";
            }
            if (functions != null) {
                this.mAccessoryModeRequestTime = SystemClock.elapsedRealtime();
                setCurrentFunctions(functions, DEBUG);
            }
        }
    }

    private static void initRndisAddress() {
        int[] address = new int[6];
        address[MSG_UPDATE_STATE] = MSG_SET_CURRENT_FUNCTIONS;
        String serial = SystemProperties.get("ro.serialno", "1234567890ABCDEF");
        int serialLength = serial.length();
        for (int i = MSG_UPDATE_STATE; i < serialLength; i += MSG_ENABLE_ADB) {
            int i2 = (i % MSG_USER_SWITCHED) + MSG_ENABLE_ADB;
            address[i2] = address[i2] ^ serial.charAt(i);
        }
        try {
            FileUtils.stringToFile(RNDIS_ETH_ADDR_PATH, String.format(Locale.US, "%02X:%02X:%02X:%02X:%02X:%02X", new Object[]{Integer.valueOf(address[MSG_UPDATE_STATE]), Integer.valueOf(address[MSG_ENABLE_ADB]), Integer.valueOf(address[MSG_SET_CURRENT_FUNCTIONS]), Integer.valueOf(address[MSG_SYSTEM_READY]), Integer.valueOf(address[MSG_BOOT_COMPLETED]), Integer.valueOf(address[MSG_USER_SWITCHED])}));
        } catch (IOException e) {
            Slog.e(TAG, "failed to write to /sys/class/android_usb/android0/f_rndis/ethaddr");
        }
    }

    private static String addFunction(String functions, String function) {
        if ("none".equals(functions)) {
            return function;
        }
        if (!containsFunction(functions, function)) {
            if (functions.length() > 0) {
                functions = functions + ",";
            }
            functions = functions + function;
        }
        return functions;
    }

    private static String removeFunction(String functions, String function) {
        int i;
        String[] split = functions.split(",");
        for (i = MSG_UPDATE_STATE; i < split.length; i += MSG_ENABLE_ADB) {
            if (function.equals(split[i])) {
                split[i] = null;
            }
        }
        if (split.length == MSG_ENABLE_ADB && split[MSG_UPDATE_STATE] == null) {
            return "none";
        }
        StringBuilder builder = new StringBuilder();
        for (i = MSG_UPDATE_STATE; i < split.length; i += MSG_ENABLE_ADB) {
            String s = split[i];
            if (s != null) {
                if (builder.length() > 0) {
                    builder.append(",");
                }
                builder.append(s);
            }
        }
        return builder.toString();
    }

    private static boolean containsFunction(String functions, String function) {
        return Arrays.asList(functions.split(",")).contains(function);
    }

    public UsbAccessory getCurrentAccessory() {
        return this.mHandler.getCurrentAccessory();
    }

    public ParcelFileDescriptor openAccessory(UsbAccessory accessory) {
        UsbAccessory currentAccessory = this.mHandler.getCurrentAccessory();
        if (currentAccessory == null) {
            throw new IllegalArgumentException("no accessory attached");
        } else if (currentAccessory.equals(accessory)) {
            getCurrentSettings().checkPermission(accessory);
            return nativeOpenAccessory();
        } else {
            throw new IllegalArgumentException(accessory.toString() + " does not match current accessory " + currentAccessory);
        }
    }

    public void setCurrentFunctions(String functions, boolean makeDefault) {
        this.mHandler.sendMessage(MSG_SET_CURRENT_FUNCTIONS, functions, makeDefault);
    }

    public void setMassStorageBackingFile(String path) {
        if (path == null) {
            path = "";
        }
        try {
            FileUtils.stringToFile(MASS_STORAGE_FILE_PATH, path);
        } catch (IOException e) {
            Slog.e(TAG, "failed to write to /sys/class/android_usb/android0/f_mass_storage/lun/file");
        }
    }

    private void readOemUsbOverrideConfig() {
        String[] configList = this.mContext.getResources().getStringArray(17236013);
        if (configList != null) {
            String[] arr$ = configList;
            int len$ = arr$.length;
            for (int i$ = MSG_UPDATE_STATE; i$ < len$; i$ += MSG_ENABLE_ADB) {
                String[] items = arr$[i$].split(":");
                if (items.length == MSG_SYSTEM_READY) {
                    if (this.mOemModeMap == null) {
                        this.mOemModeMap = new HashMap();
                    }
                    List<Pair<String, String>> overrideList = (List) this.mOemModeMap.get(items[MSG_UPDATE_STATE]);
                    if (overrideList == null) {
                        overrideList = new LinkedList();
                        this.mOemModeMap.put(items[MSG_UPDATE_STATE], overrideList);
                    }
                    overrideList.add(new Pair(items[MSG_ENABLE_ADB], items[MSG_SET_CURRENT_FUNCTIONS]));
                }
            }
        }
    }

    private boolean needsOemUsbOverride() {
        if (this.mOemModeMap == null) {
            return DEBUG;
        }
        if (this.mOemModeMap.get(SystemProperties.get(BOOT_MODE_PROPERTY, "unknown")) != null) {
            return true;
        }
        return DEBUG;
    }

    private String processOemUsbOverride(String usbFunctions) {
        if (usbFunctions == null || this.mOemModeMap == null) {
            return usbFunctions;
        }
        List<Pair<String, String>> overrides = (List) this.mOemModeMap.get(SystemProperties.get(BOOT_MODE_PROPERTY, "unknown"));
        if (overrides == null) {
            return usbFunctions;
        }
        for (Pair<String, String> pair : overrides) {
            if (((String) pair.first).equals(usbFunctions)) {
                Slog.d(TAG, "OEM USB override: " + ((String) pair.first) + " ==> " + ((String) pair.second));
                return (String) pair.second;
            }
        }
        return usbFunctions;
    }

    public void allowUsbDebugging(boolean alwaysAllow, String publicKey) {
        if (this.mDebuggingManager != null) {
            this.mDebuggingManager.allowUsbDebugging(alwaysAllow, publicKey);
        }
    }

    public void denyUsbDebugging() {
        if (this.mDebuggingManager != null) {
            this.mDebuggingManager.denyUsbDebugging();
        }
    }

    public void clearUsbDebuggingKeys() {
        if (this.mDebuggingManager != null) {
            this.mDebuggingManager.clearUsbDebuggingKeys();
            return;
        }
        throw new RuntimeException("Cannot clear Usb Debugging keys, UsbDebuggingManager not enabled");
    }

    public void dump(FileDescriptor fd, PrintWriter pw) {
        if (this.mHandler != null) {
            this.mHandler.dump(fd, pw);
        }
        if (this.mDebuggingManager != null) {
            this.mDebuggingManager.dump(fd, pw);
        }
    }
}
