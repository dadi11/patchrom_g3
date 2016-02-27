package android.service.fingerprint;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IFingerprintServiceReceiver extends IInterface {

    public static abstract class Stub extends Binder implements IFingerprintServiceReceiver {
        private static final String DESCRIPTOR = "android.service.fingerprint.IFingerprintServiceReceiver";
        static final int TRANSACTION_onAcquired = 2;
        static final int TRANSACTION_onEnrollResult = 1;
        static final int TRANSACTION_onError = 4;
        static final int TRANSACTION_onProcessed = 3;
        static final int TRANSACTION_onRemoved = 5;

        private static class Proxy implements IFingerprintServiceReceiver {
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

            public void onEnrollResult(int fingerprintId, int remaining) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(fingerprintId);
                    _data.writeInt(remaining);
                    this.mRemote.transact(Stub.TRANSACTION_onEnrollResult, _data, null, Stub.TRANSACTION_onEnrollResult);
                } finally {
                    _data.recycle();
                }
            }

            public void onAcquired(int acquiredInfo) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(acquiredInfo);
                    this.mRemote.transact(Stub.TRANSACTION_onAcquired, _data, null, Stub.TRANSACTION_onEnrollResult);
                } finally {
                    _data.recycle();
                }
            }

            public void onProcessed(int fingerprintId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(fingerprintId);
                    this.mRemote.transact(Stub.TRANSACTION_onProcessed, _data, null, Stub.TRANSACTION_onEnrollResult);
                } finally {
                    _data.recycle();
                }
            }

            public void onError(int error) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(error);
                    this.mRemote.transact(Stub.TRANSACTION_onError, _data, null, Stub.TRANSACTION_onEnrollResult);
                } finally {
                    _data.recycle();
                }
            }

            public void onRemoved(int fingerprintId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(fingerprintId);
                    this.mRemote.transact(Stub.TRANSACTION_onRemoved, _data, null, Stub.TRANSACTION_onEnrollResult);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static IFingerprintServiceReceiver asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IFingerprintServiceReceiver)) {
                return new Proxy(obj);
            }
            return (IFingerprintServiceReceiver) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_onEnrollResult /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    onEnrollResult(data.readInt(), data.readInt());
                    return true;
                case TRANSACTION_onAcquired /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onAcquired(data.readInt());
                    return true;
                case TRANSACTION_onProcessed /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    onProcessed(data.readInt());
                    return true;
                case TRANSACTION_onError /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    onError(data.readInt());
                    return true;
                case TRANSACTION_onRemoved /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    onRemoved(data.readInt());
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void onAcquired(int i) throws RemoteException;

    void onEnrollResult(int i, int i2) throws RemoteException;

    void onError(int i) throws RemoteException;

    void onProcessed(int i) throws RemoteException;

    void onRemoved(int i) throws RemoteException;
}
