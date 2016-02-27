package android.location;

import android.hardware.location.IGeofenceHardware;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IGeofenceProvider extends IInterface {

    public static abstract class Stub extends Binder implements IGeofenceProvider {
        private static final String DESCRIPTOR = "android.location.IGeofenceProvider";
        static final int TRANSACTION_setGeofenceHardware = 1;

        private static class Proxy implements IGeofenceProvider {
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

            public void setGeofenceHardware(IGeofenceHardware proxy) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(proxy != null ? proxy.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_setGeofenceHardware, _data, _reply, 0);
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

        public static IGeofenceProvider asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IGeofenceProvider)) {
                return new Proxy(obj);
            }
            return (IGeofenceProvider) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_setGeofenceHardware /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    setGeofenceHardware(android.hardware.location.IGeofenceHardware.Stub.asInterface(data.readStrongBinder()));
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

    void setGeofenceHardware(IGeofenceHardware iGeofenceHardware) throws RemoteException;
}
