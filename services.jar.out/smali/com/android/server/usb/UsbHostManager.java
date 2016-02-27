package com.android.server.usb;

import android.content.Context;
import android.hardware.usb.UsbConfiguration;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbEndpoint;
import android.hardware.usb.UsbInterface;
import android.os.Bundle;
import android.os.ParcelFileDescriptor;
import android.os.Parcelable;
import android.util.Slog;
import com.android.internal.annotations.GuardedBy;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

public class UsbHostManager {
    private static final boolean DEBUG = false;
    private static final String TAG;
    private final Context mContext;
    @GuardedBy("mLock")
    private UsbSettingsManager mCurrentSettings;
    private final HashMap<String, UsbDevice> mDevices;
    private final String[] mHostBlacklist;
    private final Object mLock;
    private UsbConfiguration mNewConfiguration;
    private ArrayList<UsbConfiguration> mNewConfigurations;
    private UsbDevice mNewDevice;
    private ArrayList<UsbEndpoint> mNewEndpoints;
    private UsbInterface mNewInterface;
    private ArrayList<UsbInterface> mNewInterfaces;
    private UsbAudioManager mUsbAudioManager;

    /* renamed from: com.android.server.usb.UsbHostManager.1 */
    class C05491 implements Runnable {
        C05491() {
        }

        public void run() {
            UsbHostManager.this.monitorUsbHostBus();
        }
    }

    private native void monitorUsbHostBus();

    private native ParcelFileDescriptor nativeOpenDevice(String str);

    static {
        TAG = UsbHostManager.class.getSimpleName();
    }

    public UsbHostManager(Context context) {
        this.mDevices = new HashMap();
        this.mLock = new Object();
        this.mContext = context;
        this.mHostBlacklist = context.getResources().getStringArray(17235994);
        this.mUsbAudioManager = new UsbAudioManager(context);
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

    private boolean isBlackListed(String deviceName) {
        for (String startsWith : this.mHostBlacklist) {
            if (deviceName.startsWith(startsWith)) {
                return true;
            }
        }
        return false;
    }

    private boolean isBlackListed(int clazz, int subClass, int protocol) {
        if (clazz == 9) {
            return true;
        }
        if (clazz == 3 && subClass == 1) {
            return true;
        }
        return false;
    }

    private boolean beginUsbDeviceAdded(String deviceName, int vendorID, int productID, int deviceClass, int deviceSubclass, int deviceProtocol, String manufacturerName, String productName, String serialNumber) {
        if (isBlackListed(deviceName) || isBlackListed(deviceClass, deviceSubclass, deviceProtocol)) {
            return false;
        }
        synchronized (this.mLock) {
            if (this.mDevices.get(deviceName) != null) {
                Slog.w(TAG, "device already on mDevices list: " + deviceName);
                return false;
            } else if (this.mNewDevice != null) {
                Slog.e(TAG, "mNewDevice is not null in endUsbDeviceAdded");
                return false;
            } else {
                this.mNewDevice = new UsbDevice(deviceName, vendorID, productID, deviceClass, deviceSubclass, deviceProtocol, manufacturerName, productName, serialNumber);
                this.mNewConfigurations = new ArrayList();
                this.mNewInterfaces = new ArrayList();
                this.mNewEndpoints = new ArrayList();
                return true;
            }
        }
    }

    private void addUsbConfiguration(int id, String name, int attributes, int maxPower) {
        if (this.mNewConfiguration != null) {
            this.mNewConfiguration.setInterfaces((Parcelable[]) this.mNewInterfaces.toArray(new UsbInterface[this.mNewInterfaces.size()]));
            this.mNewInterfaces.clear();
        }
        this.mNewConfiguration = new UsbConfiguration(id, name, attributes, maxPower);
        this.mNewConfigurations.add(this.mNewConfiguration);
    }

    private void addUsbInterface(int id, String name, int altSetting, int Class, int subClass, int protocol) {
        if (this.mNewInterface != null) {
            this.mNewInterface.setEndpoints((Parcelable[]) this.mNewEndpoints.toArray(new UsbEndpoint[this.mNewEndpoints.size()]));
            this.mNewEndpoints.clear();
        }
        this.mNewInterface = new UsbInterface(id, altSetting, name, Class, subClass, protocol);
        this.mNewInterfaces.add(this.mNewInterface);
    }

    private void addUsbEndpoint(int address, int attributes, int maxPacketSize, int interval) {
        this.mNewEndpoints.add(new UsbEndpoint(address, attributes, maxPacketSize, interval));
    }

    private void endUsbDeviceAdded() {
        if (this.mNewInterface != null) {
            this.mNewInterface.setEndpoints((Parcelable[]) this.mNewEndpoints.toArray(new UsbEndpoint[this.mNewEndpoints.size()]));
        }
        if (this.mNewConfiguration != null) {
            this.mNewConfiguration.setInterfaces((Parcelable[]) this.mNewInterfaces.toArray(new UsbInterface[this.mNewInterfaces.size()]));
        }
        synchronized (this.mLock) {
            if (this.mNewDevice != null) {
                this.mNewDevice.setConfigurations((Parcelable[]) this.mNewConfigurations.toArray(new UsbConfiguration[this.mNewConfigurations.size()]));
                this.mDevices.put(this.mNewDevice.getDeviceName(), this.mNewDevice);
                Slog.d(TAG, "Added device " + this.mNewDevice);
                getCurrentSettings().deviceAttached(this.mNewDevice);
                this.mUsbAudioManager.deviceAdded(this.mNewDevice);
            } else {
                Slog.e(TAG, "mNewDevice is null in endUsbDeviceAdded");
            }
            this.mNewDevice = null;
            this.mNewConfigurations = null;
            this.mNewInterfaces = null;
            this.mNewEndpoints = null;
            this.mNewConfiguration = null;
            this.mNewInterface = null;
        }
    }

    private void usbDeviceRemoved(String deviceName) {
        synchronized (this.mLock) {
            UsbDevice device = (UsbDevice) this.mDevices.remove(deviceName);
            if (device != null) {
                this.mUsbAudioManager.deviceRemoved(device);
                getCurrentSettings().deviceDetached(device);
            }
        }
    }

    public void systemReady() {
        synchronized (this.mLock) {
            new Thread(null, new C05491(), "UsbService host thread").start();
        }
    }

    public void getDeviceList(Bundle devices) {
        synchronized (this.mLock) {
            for (String name : this.mDevices.keySet()) {
                devices.putParcelable(name, (Parcelable) this.mDevices.get(name));
            }
        }
    }

    public ParcelFileDescriptor openDevice(String deviceName) {
        ParcelFileDescriptor nativeOpenDevice;
        synchronized (this.mLock) {
            if (isBlackListed(deviceName)) {
                throw new SecurityException("USB device is on a restricted bus");
            }
            UsbDevice device = (UsbDevice) this.mDevices.get(deviceName);
            if (device == null) {
                throw new IllegalArgumentException("device " + deviceName + " does not exist or is restricted");
            }
            getCurrentSettings().checkPermission(device);
            nativeOpenDevice = nativeOpenDevice(deviceName);
        }
        return nativeOpenDevice;
    }

    public void dump(FileDescriptor fd, PrintWriter pw) {
        synchronized (this.mLock) {
            pw.println("  USB Host State:");
            for (String name : this.mDevices.keySet()) {
                pw.println("    " + name + ": " + this.mDevices.get(name));
            }
        }
        this.mUsbAudioManager.dump(fd, pw);
    }
}
