package android.bluetooth;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IBluetoothHidDevice extends IInterface {

    public static abstract class Stub extends Binder implements IBluetoothHidDevice {
        private static final String DESCRIPTOR = "android.bluetooth.IBluetoothHidDevice";
        static final int TRANSACTION_connect = 7;
        static final int TRANSACTION_disconnect = 8;
        static final int TRANSACTION_registerApp = 1;
        static final int TRANSACTION_replyReport = 4;
        static final int TRANSACTION_reportError = 5;
        static final int TRANSACTION_sendReport = 3;
        static final int TRANSACTION_unplug = 6;
        static final int TRANSACTION_unregisterApp = 2;

        private static class Proxy implements IBluetoothHidDevice {
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

            public boolean registerApp(BluetoothHidDeviceAppConfiguration config, BluetoothHidDeviceAppSdpSettings sdp, BluetoothHidDeviceAppQosSettings inQos, BluetoothHidDeviceAppQosSettings outQos, IBluetoothHidDeviceCallback callback) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (config != null) {
                        _data.writeInt(Stub.TRANSACTION_registerApp);
                        config.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (sdp != null) {
                        _data.writeInt(Stub.TRANSACTION_registerApp);
                        sdp.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (inQos != null) {
                        _data.writeInt(Stub.TRANSACTION_registerApp);
                        inQos.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (outQos != null) {
                        _data.writeInt(Stub.TRANSACTION_registerApp);
                        outQos.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeStrongBinder(callback != null ? callback.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_registerApp, _data, _reply, 0);
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

            public boolean unregisterApp(BluetoothHidDeviceAppConfiguration config) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (config != null) {
                        _data.writeInt(Stub.TRANSACTION_registerApp);
                        config.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_unregisterApp, _data, _reply, 0);
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

            public boolean sendReport(int id, byte[] data) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(id);
                    _data.writeByteArray(data);
                    this.mRemote.transact(Stub.TRANSACTION_sendReport, _data, _reply, 0);
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

            public boolean replyReport(byte type, byte id, byte[] data) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeByte(type);
                    _data.writeByte(id);
                    _data.writeByteArray(data);
                    this.mRemote.transact(Stub.TRANSACTION_replyReport, _data, _reply, 0);
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

            public boolean reportError(byte error) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeByte(error);
                    this.mRemote.transact(Stub.TRANSACTION_reportError, _data, _reply, 0);
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

            public boolean unplug() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_unplug, _data, _reply, 0);
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

            public boolean connect() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_connect, _data, _reply, 0);
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

            public boolean disconnect() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_disconnect, _data, _reply, 0);
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
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static IBluetoothHidDevice asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IBluetoothHidDevice)) {
                return new Proxy(obj);
            }
            return (IBluetoothHidDevice) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            BluetoothHidDeviceAppConfiguration _arg0;
            boolean _result;
            switch (code) {
                case TRANSACTION_registerApp /*1*/:
                    BluetoothHidDeviceAppSdpSettings _arg1;
                    BluetoothHidDeviceAppQosSettings _arg2;
                    BluetoothHidDeviceAppQosSettings _arg3;
                    int i2;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (BluetoothHidDeviceAppConfiguration) BluetoothHidDeviceAppConfiguration.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg1 = (BluetoothHidDeviceAppSdpSettings) BluetoothHidDeviceAppSdpSettings.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg2 = (BluetoothHidDeviceAppQosSettings) BluetoothHidDeviceAppQosSettings.CREATOR.createFromParcel(data);
                    } else {
                        _arg2 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg3 = (BluetoothHidDeviceAppQosSettings) BluetoothHidDeviceAppQosSettings.CREATOR.createFromParcel(data);
                    } else {
                        _arg3 = null;
                    }
                    _result = registerApp(_arg0, _arg1, _arg2, _arg3, android.bluetooth.IBluetoothHidDeviceCallback.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    if (_result) {
                        i2 = TRANSACTION_registerApp;
                    } else {
                        i2 = 0;
                    }
                    reply.writeInt(i2);
                    return true;
                case TRANSACTION_unregisterApp /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (BluetoothHidDeviceAppConfiguration) BluetoothHidDeviceAppConfiguration.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    _result = unregisterApp(_arg0);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerApp;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_sendReport /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = sendReport(data.readInt(), data.createByteArray());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerApp;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_replyReport /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = replyReport(data.readByte(), data.readByte(), data.createByteArray());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerApp;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_reportError /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = reportError(data.readByte());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerApp;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_unplug /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = unplug();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerApp;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_connect /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = connect();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerApp;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_disconnect /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = disconnect();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerApp;
                    }
                    reply.writeInt(i);
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    boolean connect() throws RemoteException;

    boolean disconnect() throws RemoteException;

    boolean registerApp(BluetoothHidDeviceAppConfiguration bluetoothHidDeviceAppConfiguration, BluetoothHidDeviceAppSdpSettings bluetoothHidDeviceAppSdpSettings, BluetoothHidDeviceAppQosSettings bluetoothHidDeviceAppQosSettings, BluetoothHidDeviceAppQosSettings bluetoothHidDeviceAppQosSettings2, IBluetoothHidDeviceCallback iBluetoothHidDeviceCallback) throws RemoteException;

    boolean replyReport(byte b, byte b2, byte[] bArr) throws RemoteException;

    boolean reportError(byte b) throws RemoteException;

    boolean sendReport(int i, byte[] bArr) throws RemoteException;

    boolean unplug() throws RemoteException;

    boolean unregisterApp(BluetoothHidDeviceAppConfiguration bluetoothHidDeviceAppConfiguration) throws RemoteException;
}
