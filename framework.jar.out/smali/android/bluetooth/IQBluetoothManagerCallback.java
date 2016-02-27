package android.bluetooth;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IQBluetoothManagerCallback extends IInterface {

    public static abstract class Stub extends Binder implements IQBluetoothManagerCallback {
        private static final String DESCRIPTOR = "android.bluetooth.IQBluetoothManagerCallback";
        static final int TRANSACTION_onQBluetoothServiceDown = 2;
        static final int TRANSACTION_onQBluetoothServiceUp = 1;

        private static class Proxy implements IQBluetoothManagerCallback {
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

            public void onQBluetoothServiceUp(IQBluetooth QbluetoothService) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(QbluetoothService != null ? QbluetoothService.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_onQBluetoothServiceUp, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onQBluetoothServiceDown() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_onQBluetoothServiceDown, _data, _reply, 0);
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

        public static IQBluetoothManagerCallback asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IQBluetoothManagerCallback)) {
                return new Proxy(obj);
            }
            return (IQBluetoothManagerCallback) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_onQBluetoothServiceUp /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    onQBluetoothServiceUp(android.bluetooth.IQBluetooth.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onQBluetoothServiceDown /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onQBluetoothServiceDown();
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

    void onQBluetoothServiceDown() throws RemoteException;

    void onQBluetoothServiceUp(IQBluetooth iQBluetooth) throws RemoteException;
}
