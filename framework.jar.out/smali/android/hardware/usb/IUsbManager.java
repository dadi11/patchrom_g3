package android.hardware.usb;

import android.app.PendingIntent;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.RemoteException;

public interface IUsbManager extends IInterface {

    public static abstract class Stub extends Binder implements IUsbManager {
        private static final String DESCRIPTOR = "android.hardware.usb.IUsbManager";
        static final int TRANSACTION_allowUsbDebugging = 17;
        static final int TRANSACTION_clearDefaults = 14;
        static final int TRANSACTION_clearUsbDebuggingKeys = 19;
        static final int TRANSACTION_denyUsbDebugging = 18;
        static final int TRANSACTION_getCurrentAccessory = 3;
        static final int TRANSACTION_getDeviceList = 1;
        static final int TRANSACTION_grantAccessoryPermission = 12;
        static final int TRANSACTION_grantDevicePermission = 11;
        static final int TRANSACTION_hasAccessoryPermission = 8;
        static final int TRANSACTION_hasDefaults = 13;
        static final int TRANSACTION_hasDevicePermission = 7;
        static final int TRANSACTION_openAccessory = 4;
        static final int TRANSACTION_openDevice = 2;
        static final int TRANSACTION_requestAccessoryPermission = 10;
        static final int TRANSACTION_requestDevicePermission = 9;
        static final int TRANSACTION_setAccessoryPackage = 6;
        static final int TRANSACTION_setCurrentFunction = 15;
        static final int TRANSACTION_setDevicePackage = 5;
        static final int TRANSACTION_setMassStorageBackingFile = 16;

        private static class Proxy implements IUsbManager {
            private IBinder mRemote;

            Proxy(IBinder remote) {
                this.mRemote = remote;
            }

            public IBinder asBinder() {
                return this.mRemote;
            }

            public String getInterfaceDescriptor() {
                return Stub.DESCRIPTOR;
            }

            public void getDeviceList(Bundle devices) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getDeviceList, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        devices.readFromParcel(_reply);
                    }
                    _reply.recycle();
                    _data.recycle();
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public ParcelFileDescriptor openDevice(String deviceName) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    ParcelFileDescriptor _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(deviceName);
                    this.mRemote.transact(Stub.TRANSACTION_openDevice, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (ParcelFileDescriptor) ParcelFileDescriptor.CREATOR.createFromParcel(_reply);
                    } else {
                        _result = null;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public UsbAccessory getCurrentAccessory() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    UsbAccessory _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getCurrentAccessory, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (UsbAccessory) UsbAccessory.CREATOR.createFromParcel(_reply);
                    } else {
                        _result = null;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public ParcelFileDescriptor openAccessory(UsbAccessory accessory) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    ParcelFileDescriptor _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (accessory != null) {
                        _data.writeInt(Stub.TRANSACTION_getDeviceList);
                        accessory.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_openAccessory, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (ParcelFileDescriptor) ParcelFileDescriptor.CREATOR.createFromParcel(_reply);
                    } else {
                        _result = null;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setDevicePackage(UsbDevice device, String packageName, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (device != null) {
                        _data.writeInt(Stub.TRANSACTION_getDeviceList);
                        device.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(packageName);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_setDevicePackage, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setAccessoryPackage(UsbAccessory accessory, String packageName, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (accessory != null) {
                        _data.writeInt(Stub.TRANSACTION_getDeviceList);
                        accessory.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(packageName);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_setAccessoryPackage, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean hasDevicePermission(UsbDevice device) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (device != null) {
                        _data.writeInt(Stub.TRANSACTION_getDeviceList);
                        device.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_hasDevicePermission, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() == 0) {
                        _result = false;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean hasAccessoryPermission(UsbAccessory accessory) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (accessory != null) {
                        _data.writeInt(Stub.TRANSACTION_getDeviceList);
                        accessory.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_hasAccessoryPermission, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() == 0) {
                        _result = false;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void requestDevicePermission(UsbDevice device, String packageName, PendingIntent pi) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (device != null) {
                        _data.writeInt(Stub.TRANSACTION_getDeviceList);
                        device.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(packageName);
                    if (pi != null) {
                        _data.writeInt(Stub.TRANSACTION_getDeviceList);
                        pi.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_requestDevicePermission, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void requestAccessoryPermission(UsbAccessory accessory, String packageName, PendingIntent pi) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (accessory != null) {
                        _data.writeInt(Stub.TRANSACTION_getDeviceList);
                        accessory.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(packageName);
                    if (pi != null) {
                        _data.writeInt(Stub.TRANSACTION_getDeviceList);
                        pi.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_requestAccessoryPermission, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void grantDevicePermission(UsbDevice device, int uid) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (device != null) {
                        _data.writeInt(Stub.TRANSACTION_getDeviceList);
                        device.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(uid);
                    this.mRemote.transact(Stub.TRANSACTION_grantDevicePermission, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void grantAccessoryPermission(UsbAccessory accessory, int uid) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (accessory != null) {
                        _data.writeInt(Stub.TRANSACTION_getDeviceList);
                        accessory.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(uid);
                    this.mRemote.transact(Stub.TRANSACTION_grantAccessoryPermission, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean hasDefaults(String packageName, int userId) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(packageName);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_hasDefaults, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = true;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void clearDefaults(String packageName, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(packageName);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_clearDefaults, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setCurrentFunction(String function, boolean makeDefault) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(function);
                    if (makeDefault) {
                        i = Stub.TRANSACTION_getDeviceList;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_setCurrentFunction, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setMassStorageBackingFile(String path) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(path);
                    this.mRemote.transact(Stub.TRANSACTION_setMassStorageBackingFile, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void allowUsbDebugging(boolean alwaysAllow, String publicKey) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (alwaysAllow) {
                        i = Stub.TRANSACTION_getDeviceList;
                    }
                    _data.writeInt(i);
                    _data.writeString(publicKey);
                    this.mRemote.transact(Stub.TRANSACTION_allowUsbDebugging, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void denyUsbDebugging() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_denyUsbDebugging, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void clearUsbDebuggingKeys() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_clearUsbDebuggingKeys, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static IUsbManager asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IUsbManager)) {
                return new Proxy(obj);
            }
            return (IUsbManager) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            ParcelFileDescriptor _result;
            UsbAccessory _arg0;
            UsbDevice _arg02;
            boolean _result2;
            String _arg1;
            PendingIntent _arg2;
            switch (code) {
                case TRANSACTION_getDeviceList /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    Bundle _arg03 = new Bundle();
                    getDeviceList(_arg03);
                    reply.writeNoException();
                    if (_arg03 != null) {
                        reply.writeInt(TRANSACTION_getDeviceList);
                        _arg03.writeToParcel(reply, TRANSACTION_getDeviceList);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_openDevice /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = openDevice(data.readString());
                    reply.writeNoException();
                    if (_result != null) {
                        reply.writeInt(TRANSACTION_getDeviceList);
                        _result.writeToParcel(reply, TRANSACTION_getDeviceList);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_getCurrentAccessory /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    UsbAccessory _result3 = getCurrentAccessory();
                    reply.writeNoException();
                    if (_result3 != null) {
                        reply.writeInt(TRANSACTION_getDeviceList);
                        _result3.writeToParcel(reply, TRANSACTION_getDeviceList);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_openAccessory /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (UsbAccessory) UsbAccessory.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    _result = openAccessory(_arg0);
                    reply.writeNoException();
                    if (_result != null) {
                        reply.writeInt(TRANSACTION_getDeviceList);
                        _result.writeToParcel(reply, TRANSACTION_getDeviceList);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_setDevicePackage /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (UsbDevice) UsbDevice.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    setDevicePackage(_arg02, data.readString(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setAccessoryPackage /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (UsbAccessory) UsbAccessory.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    setAccessoryPackage(_arg0, data.readString(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_hasDevicePermission /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (UsbDevice) UsbDevice.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    _result2 = hasDevicePermission(_arg02);
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_getDeviceList;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_hasAccessoryPermission /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (UsbAccessory) UsbAccessory.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    _result2 = hasAccessoryPermission(_arg0);
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_getDeviceList;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_requestDevicePermission /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (UsbDevice) UsbDevice.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    _arg1 = data.readString();
                    if (data.readInt() != 0) {
                        _arg2 = (PendingIntent) PendingIntent.CREATOR.createFromParcel(data);
                    } else {
                        _arg2 = null;
                    }
                    requestDevicePermission(_arg02, _arg1, _arg2);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_requestAccessoryPermission /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (UsbAccessory) UsbAccessory.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    _arg1 = data.readString();
                    if (data.readInt() != 0) {
                        _arg2 = (PendingIntent) PendingIntent.CREATOR.createFromParcel(data);
                    } else {
                        _arg2 = null;
                    }
                    requestAccessoryPermission(_arg0, _arg1, _arg2);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_grantDevicePermission /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (UsbDevice) UsbDevice.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    grantDevicePermission(_arg02, data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_grantAccessoryPermission /*12*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (UsbAccessory) UsbAccessory.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    grantAccessoryPermission(_arg0, data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_hasDefaults /*13*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = hasDefaults(data.readString(), data.readInt());
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_getDeviceList;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_clearDefaults /*14*/:
                    data.enforceInterface(DESCRIPTOR);
                    clearDefaults(data.readString(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setCurrentFunction /*15*/:
                    boolean _arg12;
                    data.enforceInterface(DESCRIPTOR);
                    String _arg04 = data.readString();
                    if (data.readInt() != 0) {
                        _arg12 = true;
                    } else {
                        _arg12 = false;
                    }
                    setCurrentFunction(_arg04, _arg12);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setMassStorageBackingFile /*16*/:
                    data.enforceInterface(DESCRIPTOR);
                    setMassStorageBackingFile(data.readString());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_allowUsbDebugging /*17*/:
                    boolean _arg05;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg05 = true;
                    } else {
                        _arg05 = false;
                    }
                    allowUsbDebugging(_arg05, data.readString());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_denyUsbDebugging /*18*/:
                    data.enforceInterface(DESCRIPTOR);
                    denyUsbDebugging();
                    reply.writeNoException();
                    return true;
                case TRANSACTION_clearUsbDebuggingKeys /*19*/:
                    data.enforceInterface(DESCRIPTOR);
                    clearUsbDebuggingKeys();
                    reply.writeNoException();
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void allowUsbDebugging(boolean z, String str) throws RemoteException;

    void clearDefaults(String str, int i) throws RemoteException;

    void clearUsbDebuggingKeys() throws RemoteException;

    void denyUsbDebugging() throws RemoteException;

    UsbAccessory getCurrentAccessory() throws RemoteException;

    void getDeviceList(Bundle bundle) throws RemoteException;

    void grantAccessoryPermission(UsbAccessory usbAccessory, int i) throws RemoteException;

    void grantDevicePermission(UsbDevice usbDevice, int i) throws RemoteException;

    boolean hasAccessoryPermission(UsbAccessory usbAccessory) throws RemoteException;

    boolean hasDefaults(String str, int i) throws RemoteException;

    boolean hasDevicePermission(UsbDevice usbDevice) throws RemoteException;

    ParcelFileDescriptor openAccessory(UsbAccessory usbAccessory) throws RemoteException;

    ParcelFileDescriptor openDevice(String str) throws RemoteException;

    void requestAccessoryPermission(UsbAccessory usbAccessory, String str, PendingIntent pendingIntent) throws RemoteException;

    void requestDevicePermission(UsbDevice usbDevice, String str, PendingIntent pendingIntent) throws RemoteException;

    void setAccessoryPackage(UsbAccessory usbAccessory, String str, int i) throws RemoteException;

    void setCurrentFunction(String str, boolean z) throws RemoteException;

    void setDevicePackage(UsbDevice usbDevice, String str, int i) throws RemoteException;

    void setMassStorageBackingFile(String str) throws RemoteException;
}
