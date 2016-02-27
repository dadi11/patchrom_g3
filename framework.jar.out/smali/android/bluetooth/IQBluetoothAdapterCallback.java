package android.bluetooth;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IQBluetoothAdapterCallback extends IInterface {

    public static abstract class Stub extends Binder implements IQBluetoothAdapterCallback {
        private static final String DESCRIPTOR = "android.bluetooth.IQBluetoothAdapterCallback";
        static final int TRANSACTION_onEnableRssiMonitor = 3;
        static final int TRANSACTION_onReadRssiThreshold = 2;
        static final int TRANSACTION_onRssiThresholdEvent = 4;
        static final int TRANSACTION_onUpdateLease = 5;
        static final int TRANSACTION_onWriteRssiThreshold = 1;

        private static class Proxy implements IQBluetoothAdapterCallback {
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

            public void onWriteRssiThreshold(String address, int status) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(address);
                    _data.writeInt(status);
                    this.mRemote.transact(Stub.TRANSACTION_onWriteRssiThreshold, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onReadRssiThreshold(String address, int low, int upper, int alert, int status) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(address);
                    _data.writeInt(low);
                    _data.writeInt(upper);
                    _data.writeInt(alert);
                    _data.writeInt(status);
                    this.mRemote.transact(Stub.TRANSACTION_onReadRssiThreshold, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onEnableRssiMonitor(String address, int enable, int status) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(address);
                    _data.writeInt(enable);
                    _data.writeInt(status);
                    this.mRemote.transact(Stub.TRANSACTION_onEnableRssiMonitor, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onRssiThresholdEvent(String address, int evtType, int rssi) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(address);
                    _data.writeInt(evtType);
                    _data.writeInt(rssi);
                    this.mRemote.transact(Stub.TRANSACTION_onRssiThresholdEvent, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean onUpdateLease() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_onUpdateLease, _data, _reply, 0);
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

        public static IQBluetoothAdapterCallback asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IQBluetoothAdapterCallback)) {
                return new Proxy(obj);
            }
            return (IQBluetoothAdapterCallback) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_onWriteRssiThreshold /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    onWriteRssiThreshold(data.readString(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onReadRssiThreshold /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onReadRssiThreshold(data.readString(), data.readInt(), data.readInt(), data.readInt(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onEnableRssiMonitor /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    onEnableRssiMonitor(data.readString(), data.readInt(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onRssiThresholdEvent /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    onRssiThresholdEvent(data.readString(), data.readInt(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onUpdateLease /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    boolean _result = onUpdateLease();
                    reply.writeNoException();
                    reply.writeInt(_result ? TRANSACTION_onWriteRssiThreshold : 0);
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void onEnableRssiMonitor(String str, int i, int i2) throws RemoteException;

    void onReadRssiThreshold(String str, int i, int i2, int i3, int i4) throws RemoteException;

    void onRssiThresholdEvent(String str, int i, int i2) throws RemoteException;

    boolean onUpdateLease() throws RemoteException;

    void onWriteRssiThreshold(String str, int i) throws RemoteException;
}
