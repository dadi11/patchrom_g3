package com.android.server.usb;

import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.usb.IUsbManager.Stub;
import android.hardware.usb.UsbAccessory;
import android.hardware.usb.UsbDevice;
import android.os.Bundle;
import android.os.ParcelFileDescriptor;
import android.os.UserHandle;
import android.os.UserManager;
import android.util.SparseArray;
import com.android.internal.annotations.GuardedBy;
import com.android.server.SystemService;
import java.io.File;

public class UsbService extends Stub {
    private static final String TAG = "UsbService";
    private final Context mContext;
    private UsbDeviceManager mDeviceManager;
    private UsbHostManager mHostManager;
    private final Object mLock;
    @GuardedBy("mLock")
    private final SparseArray<UsbSettingsManager> mSettingsByUser;
    private BroadcastReceiver mUserReceiver;

    /* renamed from: com.android.server.usb.UsbService.1 */
    class C05501 extends BroadcastReceiver {
        C05501() {
        }

        public void onReceive(Context context, Intent intent) {
            int userId = intent.getIntExtra("android.intent.extra.user_handle", -1);
            String action = intent.getAction();
            if ("android.intent.action.USER_SWITCHED".equals(action)) {
                UsbService.this.setCurrentUser(userId);
            } else if ("android.intent.action.USER_STOPPED".equals(action)) {
                synchronized (UsbService.this.mLock) {
                    UsbService.this.mSettingsByUser.remove(userId);
                }
            }
        }
    }

    public static class Lifecycle extends SystemService {
        private UsbService mUsbService;

        public Lifecycle(Context context) {
            super(context);
        }

        public void onStart() {
            this.mUsbService = new UsbService(getContext());
            publishBinderService("usb", this.mUsbService);
        }

        public void onBootPhase(int phase) {
            if (phase == SystemService.PHASE_ACTIVITY_MANAGER_READY) {
                this.mUsbService.systemReady();
            }
        }
    }

    private UsbSettingsManager getSettingsForUser(int userId) {
        UsbSettingsManager settings;
        synchronized (this.mLock) {
            settings = (UsbSettingsManager) this.mSettingsByUser.get(userId);
            if (settings == null) {
                settings = new UsbSettingsManager(this.mContext, new UserHandle(userId));
                this.mSettingsByUser.put(userId, settings);
            }
        }
        return settings;
    }

    public UsbService(Context context) {
        this.mLock = new Object();
        this.mSettingsByUser = new SparseArray();
        this.mUserReceiver = new C05501();
        this.mContext = context;
        if (this.mContext.getPackageManager().hasSystemFeature("android.hardware.usb.host")) {
            this.mHostManager = new UsbHostManager(context);
        }
        if (new File("/sys/class/android_usb").exists()) {
            this.mDeviceManager = new UsbDeviceManager(context);
        }
        setCurrentUser(0);
        IntentFilter userFilter = new IntentFilter();
        userFilter.addAction("android.intent.action.USER_SWITCHED");
        userFilter.addAction("android.intent.action.USER_STOPPED");
        this.mContext.registerReceiver(this.mUserReceiver, userFilter, null, null);
    }

    private void setCurrentUser(int userId) {
        UsbSettingsManager userSettings = getSettingsForUser(userId);
        if (this.mHostManager != null) {
            this.mHostManager.setCurrentSettings(userSettings);
        }
        if (this.mDeviceManager != null) {
            this.mDeviceManager.setCurrentSettings(userSettings);
        }
    }

    public void systemReady() {
        if (this.mDeviceManager != null) {
            this.mDeviceManager.systemReady();
        }
        if (this.mHostManager != null) {
            this.mHostManager.systemReady();
        }
    }

    public void getDeviceList(Bundle devices) {
        if (this.mHostManager != null) {
            this.mHostManager.getDeviceList(devices);
        }
    }

    public ParcelFileDescriptor openDevice(String deviceName) {
        if (this.mHostManager != null) {
            return this.mHostManager.openDevice(deviceName);
        }
        return null;
    }

    public UsbAccessory getCurrentAccessory() {
        if (this.mDeviceManager != null) {
            return this.mDeviceManager.getCurrentAccessory();
        }
        return null;
    }

    public ParcelFileDescriptor openAccessory(UsbAccessory accessory) {
        if (this.mDeviceManager != null) {
            return this.mDeviceManager.openAccessory(accessory);
        }
        return null;
    }

    public void setDevicePackage(UsbDevice device, String packageName, int userId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USB", null);
        getSettingsForUser(userId).setDevicePackage(device, packageName);
    }

    public void setAccessoryPackage(UsbAccessory accessory, String packageName, int userId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USB", null);
        getSettingsForUser(userId).setAccessoryPackage(accessory, packageName);
    }

    public boolean hasDevicePermission(UsbDevice device) {
        return getSettingsForUser(UserHandle.getCallingUserId()).hasPermission(device);
    }

    public boolean hasAccessoryPermission(UsbAccessory accessory) {
        return getSettingsForUser(UserHandle.getCallingUserId()).hasPermission(accessory);
    }

    public void requestDevicePermission(UsbDevice device, String packageName, PendingIntent pi) {
        getSettingsForUser(UserHandle.getCallingUserId()).requestPermission(device, packageName, pi);
    }

    public void requestAccessoryPermission(UsbAccessory accessory, String packageName, PendingIntent pi) {
        getSettingsForUser(UserHandle.getCallingUserId()).requestPermission(accessory, packageName, pi);
    }

    public void grantDevicePermission(UsbDevice device, int uid) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USB", null);
        getSettingsForUser(UserHandle.getUserId(uid)).grantDevicePermission(device, uid);
    }

    public void grantAccessoryPermission(UsbAccessory accessory, int uid) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USB", null);
        getSettingsForUser(UserHandle.getUserId(uid)).grantAccessoryPermission(accessory, uid);
    }

    public boolean hasDefaults(String packageName, int userId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USB", null);
        return getSettingsForUser(userId).hasDefaults(packageName);
    }

    public void clearDefaults(String packageName, int userId) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USB", null);
        getSettingsForUser(userId).clearDefaults(packageName);
    }

    public void setCurrentFunction(String function, boolean makeDefault) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USB", null);
        if (((UserManager) this.mContext.getSystemService("user")).hasUserRestriction("no_usb_file_transfer")) {
            if (this.mDeviceManager != null) {
                this.mDeviceManager.setCurrentFunctions("none", false);
            }
        } else if (this.mDeviceManager != null) {
            this.mDeviceManager.setCurrentFunctions(function, makeDefault);
        } else {
            throw new IllegalStateException("USB device mode not supported");
        }
    }

    public void setMassStorageBackingFile(String path) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USB", null);
        if (this.mDeviceManager != null) {
            this.mDeviceManager.setMassStorageBackingFile(path);
            return;
        }
        throw new IllegalStateException("USB device mode not supported");
    }

    public void allowUsbDebugging(boolean alwaysAllow, String publicKey) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USB", null);
        this.mDeviceManager.allowUsbDebugging(alwaysAllow, publicKey);
    }

    public void denyUsbDebugging() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USB", null);
        this.mDeviceManager.denyUsbDebugging();
    }

    public void clearUsbDebuggingKeys() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MANAGE_USB", null);
        this.mDeviceManager.clearUsbDebuggingKeys();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void dump(java.io.FileDescriptor r8, java.io.PrintWriter r9, java.lang.String[] r10) {
        /*
        r7 = this;
        r4 = r7.mContext;
        r5 = "android.permission.DUMP";
        r6 = "UsbService";
        r4.enforceCallingOrSelfPermission(r5, r6);
        r1 = new com.android.internal.util.IndentingPrintWriter;
        r4 = "  ";
        r1.<init>(r9, r4);
        r4 = "USB Manager State:";
        r1.println(r4);
        r4 = r7.mDeviceManager;
        if (r4 == 0) goto L_0x001e;
    L_0x0019:
        r4 = r7.mDeviceManager;
        r4.dump(r8, r1);
    L_0x001e:
        r4 = r7.mHostManager;
        if (r4 == 0) goto L_0x0027;
    L_0x0022:
        r4 = r7.mHostManager;
        r4.dump(r8, r1);
    L_0x0027:
        r5 = r7.mLock;
        monitor-enter(r5);
        r0 = 0;
    L_0x002b:
        r4 = r7.mSettingsByUser;	 Catch:{ all -> 0x006e }
        r4 = r4.size();	 Catch:{ all -> 0x006e }
        if (r0 >= r4) goto L_0x0069;
    L_0x0033:
        r4 = r7.mSettingsByUser;	 Catch:{ all -> 0x006e }
        r3 = r4.keyAt(r0);	 Catch:{ all -> 0x006e }
        r4 = r7.mSettingsByUser;	 Catch:{ all -> 0x006e }
        r2 = r4.valueAt(r0);	 Catch:{ all -> 0x006e }
        r2 = (com.android.server.usb.UsbSettingsManager) r2;	 Catch:{ all -> 0x006e }
        r1.increaseIndent();	 Catch:{ all -> 0x006e }
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x006e }
        r4.<init>();	 Catch:{ all -> 0x006e }
        r6 = "Settings for user ";
        r4 = r4.append(r6);	 Catch:{ all -> 0x006e }
        r4 = r4.append(r3);	 Catch:{ all -> 0x006e }
        r6 = ":";
        r4 = r4.append(r6);	 Catch:{ all -> 0x006e }
        r4 = r4.toString();	 Catch:{ all -> 0x006e }
        r1.println(r4);	 Catch:{ all -> 0x006e }
        r2.dump(r8, r1);	 Catch:{ all -> 0x006e }
        r1.decreaseIndent();	 Catch:{ all -> 0x006e }
        r0 = r0 + 1;
        goto L_0x002b;
    L_0x0069:
        monitor-exit(r5);	 Catch:{ all -> 0x006e }
        r1.decreaseIndent();
        return;
    L_0x006e:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x006e }
        throw r4;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.usb.UsbService.dump(java.io.FileDescriptor, java.io.PrintWriter, java.lang.String[]):void");
    }
}
