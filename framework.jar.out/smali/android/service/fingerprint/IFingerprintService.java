package android.service.fingerprint;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IFingerprintService extends IInterface {

    public static abstract class Stub extends Binder implements IFingerprintService {
        private static final String DESCRIPTOR = "android.service.fingerprint.IFingerprintService";
        static final int TRANSACTION_enroll = 1;
        static final int TRANSACTION_enrollCancel = 2;
        static final int TRANSACTION_remove = 3;
        static final int TRANSACTION_startListening = 4;
        static final int TRANSACTION_stopListening = 5;

        private static class Proxy implements IFingerprintService {
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

            public void enroll(IBinder token, long timeout, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(token);
                    _data.writeLong(timeout);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_enroll, _data, null, Stub.TRANSACTION_enroll);
                } finally {
                    _data.recycle();
                }
            }

            public void enrollCancel(IBinder token, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(token);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_enrollCancel, _data, null, Stub.TRANSACTION_enroll);
                } finally {
                    _data.recycle();
                }
            }

            public void remove(IBinder token, int fingerprintId, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(token);
                    _data.writeInt(fingerprintId);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_remove, _data, null, Stub.TRANSACTION_enroll);
                } finally {
                    _data.recycle();
                }
            }

            public void startListening(IBinder token, IFingerprintServiceReceiver receiver, int userId) throws RemoteException {
                IBinder iBinder = null;
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(token);
                    if (receiver != null) {
                        iBinder = receiver.asBinder();
                    }
                    _data.writeStrongBinder(iBinder);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_startListening, _data, null, Stub.TRANSACTION_enroll);
                } finally {
                    _data.recycle();
                }
            }

            public void stopListening(IBinder token, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(token);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_stopListening, _data, null, Stub.TRANSACTION_enroll);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static IFingerprintService asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IFingerprintService)) {
                return new Proxy(obj);
            }
            return (IFingerprintService) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_enroll /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    enroll(data.readStrongBinder(), data.readLong(), data.readInt());
                    return true;
                case TRANSACTION_enrollCancel /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    enrollCancel(data.readStrongBinder(), data.readInt());
                    return true;
                case TRANSACTION_remove /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    remove(data.readStrongBinder(), data.readInt(), data.readInt());
                    return true;
                case TRANSACTION_startListening /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    startListening(data.readStrongBinder(), android.service.fingerprint.IFingerprintServiceReceiver.Stub.asInterface(data.readStrongBinder()), data.readInt());
                    return true;
                case TRANSACTION_stopListening /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    stopListening(data.readStrongBinder(), data.readInt());
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void enroll(IBinder iBinder, long j, int i) throws RemoteException;

    void enrollCancel(IBinder iBinder, int i) throws RemoteException;

    void remove(IBinder iBinder, int i, int i2) throws RemoteException;

    void startListening(IBinder iBinder, IFingerprintServiceReceiver iFingerprintServiceReceiver, int i) throws RemoteException;

    void stopListening(IBinder iBinder, int i) throws RemoteException;
}
