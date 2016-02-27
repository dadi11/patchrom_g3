package android.bluetooth;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IQBluetooth extends IInterface {

    public static abstract class Stub extends Binder implements IQBluetooth {
        private static final String DESCRIPTOR = "android.bluetooth.IQBluetooth";
        static final int TRANSACTION_enableLeLppRssiMonitor = 4;
        static final int TRANSACTION_readLeLppRssiThreshold = 3;
        static final int TRANSACTION_registerLeLppRssiMonitorClient = 1;
        static final int TRANSACTION_writeLeLppRssiThreshold = 2;

        private static class Proxy implements IQBluetooth {
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

            public boolean registerLeLppRssiMonitorClient(String address, IQBluetoothAdapterCallback client, boolean add) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    int i;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(address);
                    _data.writeStrongBinder(client != null ? client.asBinder() : null);
                    if (add) {
                        i = Stub.TRANSACTION_registerLeLppRssiMonitorClient;
                    } else {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_registerLeLppRssiMonitorClient, _data, _reply, 0);
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

            public void writeLeLppRssiThreshold(String address, byte min, byte max) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(address);
                    _data.writeByte(min);
                    _data.writeByte(max);
                    this.mRemote.transact(Stub.TRANSACTION_writeLeLppRssiThreshold, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void readLeLppRssiThreshold(String address) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(address);
                    this.mRemote.transact(Stub.TRANSACTION_readLeLppRssiThreshold, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void enableLeLppRssiMonitor(String address, boolean enable) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(address);
                    if (enable) {
                        i = Stub.TRANSACTION_registerLeLppRssiMonitorClient;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_enableLeLppRssiMonitor, _data, _reply, 0);
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

        public static IQBluetooth asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IQBluetooth)) {
                return new Proxy(obj);
            }
            return (IQBluetooth) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            String _arg0;
            switch (code) {
                case TRANSACTION_registerLeLppRssiMonitorClient /*1*/:
                    boolean _arg2;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readString();
                    IQBluetoothAdapterCallback _arg1 = android.bluetooth.IQBluetoothAdapterCallback.Stub.asInterface(data.readStrongBinder());
                    if (data.readInt() != 0) {
                        _arg2 = true;
                    } else {
                        _arg2 = false;
                    }
                    boolean _result = registerLeLppRssiMonitorClient(_arg0, _arg1, _arg2);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerLeLppRssiMonitorClient;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_writeLeLppRssiThreshold /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    writeLeLppRssiThreshold(data.readString(), data.readByte(), data.readByte());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_readLeLppRssiThreshold /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    readLeLppRssiThreshold(data.readString());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_enableLeLppRssiMonitor /*4*/:
                    boolean _arg12;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readString();
                    if (data.readInt() != 0) {
                        _arg12 = true;
                    } else {
                        _arg12 = false;
                    }
                    enableLeLppRssiMonitor(_arg0, _arg12);
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

    void enableLeLppRssiMonitor(String str, boolean z) throws RemoteException;

    void readLeLppRssiThreshold(String str) throws RemoteException;

    boolean registerLeLppRssiMonitorClient(String str, IQBluetoothAdapterCallback iQBluetoothAdapterCallback, boolean z) throws RemoteException;

    void writeLeLppRssiThreshold(String str, byte b, byte b2) throws RemoteException;
}
