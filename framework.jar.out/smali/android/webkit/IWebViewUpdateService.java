package android.webkit;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IWebViewUpdateService extends IInterface {

    public static abstract class Stub extends Binder implements IWebViewUpdateService {
        private static final String DESCRIPTOR = "android.webkit.IWebViewUpdateService";
        static final int TRANSACTION_notifyRelroCreationCompleted = 1;
        static final int TRANSACTION_waitForRelroCreationCompleted = 2;

        private static class Proxy implements IWebViewUpdateService {
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

            public void notifyRelroCreationCompleted(boolean is64Bit, boolean success) throws RemoteException {
                int i = Stub.TRANSACTION_notifyRelroCreationCompleted;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(is64Bit ? Stub.TRANSACTION_notifyRelroCreationCompleted : 0);
                    if (!success) {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_notifyRelroCreationCompleted, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void waitForRelroCreationCompleted(boolean is64Bit) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (is64Bit) {
                        i = Stub.TRANSACTION_notifyRelroCreationCompleted;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_waitForRelroCreationCompleted, _data, _reply, 0);
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

        public static IWebViewUpdateService asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IWebViewUpdateService)) {
                return new Proxy(obj);
            }
            return (IWebViewUpdateService) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            boolean _arg0;
            switch (code) {
                case TRANSACTION_notifyRelroCreationCompleted /*1*/:
                    boolean _arg1;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = true;
                    } else {
                        _arg0 = false;
                    }
                    if (data.readInt() != 0) {
                        _arg1 = true;
                    } else {
                        _arg1 = false;
                    }
                    notifyRelroCreationCompleted(_arg0, _arg1);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_waitForRelroCreationCompleted /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = true;
                    } else {
                        _arg0 = false;
                    }
                    waitForRelroCreationCompleted(_arg0);
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

    void notifyRelroCreationCompleted(boolean z, boolean z2) throws RemoteException;

    void waitForRelroCreationCompleted(boolean z) throws RemoteException;
}
