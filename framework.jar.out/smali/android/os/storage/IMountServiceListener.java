package android.os.storage;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IMountServiceListener extends IInterface {

    public static abstract class Stub extends Binder implements IMountServiceListener {
        private static final String DESCRIPTOR = "IMountServiceListener";
        static final int TRANSACTION_onStorageStateChanged = 2;
        static final int TRANSACTION_onUsbMassStorageConnectionChanged = 1;

        private static class Proxy implements IMountServiceListener {
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

            public void onUsbMassStorageConnectionChanged(boolean connected) throws RemoteException {
                int i = Stub.TRANSACTION_onUsbMassStorageConnectionChanged;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (!connected) {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_onUsbMassStorageConnectionChanged, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onStorageStateChanged(String path, String oldState, String newState) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(path);
                    _data.writeString(oldState);
                    _data.writeString(newState);
                    this.mRemote.transact(Stub.TRANSACTION_onStorageStateChanged, _data, _reply, 0);
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

        public static IMountServiceListener asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IMountServiceListener)) {
                return new Proxy(obj);
            }
            return (IMountServiceListener) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_onUsbMassStorageConnectionChanged /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    onUsbMassStorageConnectionChanged(data.readInt() != 0);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onStorageStateChanged /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onStorageStateChanged(data.readString(), data.readString(), data.readString());
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

    void onStorageStateChanged(String str, String str2, String str3) throws RemoteException;

    void onUsbMassStorageConnectionChanged(boolean z) throws RemoteException;
}
