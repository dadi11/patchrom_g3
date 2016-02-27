package android.os;

public interface IHardwareService extends IInterface {

    public static abstract class Stub extends Binder implements IHardwareService {
        private static final String DESCRIPTOR = "android.os.IHardwareService";
        static final int TRANSACTION_getFlashlightEnabled = 1;
        static final int TRANSACTION_setFlashlightEnabled = 2;

        private static class Proxy implements IHardwareService {
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

            public boolean getFlashlightEnabled() throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getFlashlightEnabled, _data, _reply, 0);
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

            public void setFlashlightEnabled(boolean on) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (on) {
                        i = Stub.TRANSACTION_getFlashlightEnabled;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_setFlashlightEnabled, _data, _reply, 0);
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

        public static IHardwareService asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IHardwareService)) {
                return new Proxy(obj);
            }
            return (IHardwareService) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            switch (code) {
                case TRANSACTION_getFlashlightEnabled /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    boolean _result = getFlashlightEnabled();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getFlashlightEnabled;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_setFlashlightEnabled /*2*/:
                    boolean _arg0;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = true;
                    } else {
                        _arg0 = false;
                    }
                    setFlashlightEnabled(_arg0);
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

    boolean getFlashlightEnabled() throws RemoteException;

    void setFlashlightEnabled(boolean z) throws RemoteException;
}
