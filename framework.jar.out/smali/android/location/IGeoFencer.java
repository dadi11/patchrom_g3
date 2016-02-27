package android.location;

import android.app.PendingIntent;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IGeoFencer extends IInterface {

    public static abstract class Stub extends Binder implements IGeoFencer {
        private static final String DESCRIPTOR = "android.location.IGeoFencer";
        static final int TRANSACTION_clearGeoFence = 2;
        static final int TRANSACTION_clearGeoFenceUser = 3;
        static final int TRANSACTION_setGeoFence = 1;

        private static class Proxy implements IGeoFencer {
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

            public boolean setGeoFence(IBinder who, GeoFenceParams params) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(who);
                    if (params != null) {
                        _data.writeInt(Stub.TRANSACTION_setGeoFence);
                        params.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setGeoFence, _data, _reply, 0);
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

            public void clearGeoFence(IBinder who, PendingIntent fence) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(who);
                    if (fence != null) {
                        _data.writeInt(Stub.TRANSACTION_setGeoFence);
                        fence.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_clearGeoFence, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void clearGeoFenceUser(int uid) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    this.mRemote.transact(Stub.TRANSACTION_clearGeoFenceUser, _data, _reply, 0);
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

        public static IGeoFencer asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IGeoFencer)) {
                return new Proxy(obj);
            }
            return (IGeoFencer) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            IBinder _arg0;
            switch (code) {
                case TRANSACTION_setGeoFence /*1*/:
                    GeoFenceParams _arg1;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readStrongBinder();
                    if (data.readInt() != 0) {
                        _arg1 = (GeoFenceParams) GeoFenceParams.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    boolean _result = setGeoFence(_arg0, _arg1);
                    reply.writeNoException();
                    reply.writeInt(_result ? TRANSACTION_setGeoFence : 0);
                    return true;
                case TRANSACTION_clearGeoFence /*2*/:
                    PendingIntent _arg12;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readStrongBinder();
                    if (data.readInt() != 0) {
                        _arg12 = (PendingIntent) PendingIntent.CREATOR.createFromParcel(data);
                    } else {
                        _arg12 = null;
                    }
                    clearGeoFence(_arg0, _arg12);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_clearGeoFenceUser /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    clearGeoFenceUser(data.readInt());
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

    void clearGeoFence(IBinder iBinder, PendingIntent pendingIntent) throws RemoteException;

    void clearGeoFenceUser(int i) throws RemoteException;

    boolean setGeoFence(IBinder iBinder, GeoFenceParams geoFenceParams) throws RemoteException;
}
