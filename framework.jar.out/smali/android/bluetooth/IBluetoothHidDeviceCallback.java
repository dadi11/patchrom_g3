package android.bluetooth;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IBluetoothHidDeviceCallback extends IInterface {

    public static abstract class Stub extends Binder implements IBluetoothHidDeviceCallback {
        private static final String DESCRIPTOR = "android.bluetooth.IBluetoothHidDeviceCallback";
        static final int TRANSACTION_onAppStatusChanged = 1;
        static final int TRANSACTION_onConnectionStateChanged = 2;
        static final int TRANSACTION_onGetReport = 3;
        static final int TRANSACTION_onIntrData = 6;
        static final int TRANSACTION_onSetProtocol = 5;
        static final int TRANSACTION_onSetReport = 4;
        static final int TRANSACTION_onVirtualCableUnplug = 7;

        private static class Proxy implements IBluetoothHidDeviceCallback {
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

            public void onAppStatusChanged(BluetoothDevice device, BluetoothHidDeviceAppConfiguration config, boolean registered) throws RemoteException {
                int i = Stub.TRANSACTION_onAppStatusChanged;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (device != null) {
                        _data.writeInt(Stub.TRANSACTION_onAppStatusChanged);
                        device.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (config != null) {
                        _data.writeInt(Stub.TRANSACTION_onAppStatusChanged);
                        config.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (!registered) {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_onAppStatusChanged, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onConnectionStateChanged(BluetoothDevice device, int state) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (device != null) {
                        _data.writeInt(Stub.TRANSACTION_onAppStatusChanged);
                        device.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(state);
                    this.mRemote.transact(Stub.TRANSACTION_onConnectionStateChanged, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onGetReport(byte type, byte id, int bufferSize) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeByte(type);
                    _data.writeByte(id);
                    _data.writeInt(bufferSize);
                    this.mRemote.transact(Stub.TRANSACTION_onGetReport, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onSetReport(byte type, byte id, byte[] data) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeByte(type);
                    _data.writeByte(id);
                    _data.writeByteArray(data);
                    this.mRemote.transact(Stub.TRANSACTION_onSetReport, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onSetProtocol(byte protocol) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeByte(protocol);
                    this.mRemote.transact(Stub.TRANSACTION_onSetProtocol, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onIntrData(byte reportId, byte[] data) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeByte(reportId);
                    _data.writeByteArray(data);
                    this.mRemote.transact(Stub.TRANSACTION_onIntrData, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onVirtualCableUnplug() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_onVirtualCableUnplug, _data, _reply, 0);
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

        public static IBluetoothHidDeviceCallback asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IBluetoothHidDeviceCallback)) {
                return new Proxy(obj);
            }
            return (IBluetoothHidDeviceCallback) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            BluetoothDevice _arg0;
            switch (code) {
                case TRANSACTION_onAppStatusChanged /*1*/:
                    BluetoothHidDeviceAppConfiguration _arg1;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (BluetoothDevice) BluetoothDevice.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg1 = (BluetoothHidDeviceAppConfiguration) BluetoothHidDeviceAppConfiguration.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    onAppStatusChanged(_arg0, _arg1, data.readInt() != 0);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onConnectionStateChanged /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (BluetoothDevice) BluetoothDevice.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    onConnectionStateChanged(_arg0, data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onGetReport /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    onGetReport(data.readByte(), data.readByte(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onSetReport /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    onSetReport(data.readByte(), data.readByte(), data.createByteArray());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onSetProtocol /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    onSetProtocol(data.readByte());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onIntrData /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    onIntrData(data.readByte(), data.createByteArray());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onVirtualCableUnplug /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    onVirtualCableUnplug();
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

    void onAppStatusChanged(BluetoothDevice bluetoothDevice, BluetoothHidDeviceAppConfiguration bluetoothHidDeviceAppConfiguration, boolean z) throws RemoteException;

    void onConnectionStateChanged(BluetoothDevice bluetoothDevice, int i) throws RemoteException;

    void onGetReport(byte b, byte b2, int i) throws RemoteException;

    void onIntrData(byte b, byte[] bArr) throws RemoteException;

    void onSetProtocol(byte b) throws RemoteException;

    void onSetReport(byte b, byte b2, byte[] bArr) throws RemoteException;

    void onVirtualCableUnplug() throws RemoteException;
}
