package android.location;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IGpsNavigationMessageListener extends IInterface {

    public static abstract class Stub extends Binder implements IGpsNavigationMessageListener {
        private static final String DESCRIPTOR = "android.location.IGpsNavigationMessageListener";
        static final int TRANSACTION_onGpsNavigationMessageReceived = 1;
        static final int TRANSACTION_onStatusChanged = 2;

        private static class Proxy implements IGpsNavigationMessageListener {
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

            public void onGpsNavigationMessageReceived(GpsNavigationMessageEvent event) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (event != null) {
                        _data.writeInt(Stub.TRANSACTION_onGpsNavigationMessageReceived);
                        event.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onGpsNavigationMessageReceived, _data, null, Stub.TRANSACTION_onGpsNavigationMessageReceived);
                } finally {
                    _data.recycle();
                }
            }

            public void onStatusChanged(int status) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(status);
                    this.mRemote.transact(Stub.TRANSACTION_onStatusChanged, _data, null, Stub.TRANSACTION_onGpsNavigationMessageReceived);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static IGpsNavigationMessageListener asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IGpsNavigationMessageListener)) {
                return new Proxy(obj);
            }
            return (IGpsNavigationMessageListener) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_onGpsNavigationMessageReceived /*1*/:
                    GpsNavigationMessageEvent _arg0;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (GpsNavigationMessageEvent) GpsNavigationMessageEvent.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    onGpsNavigationMessageReceived(_arg0);
                    return true;
                case TRANSACTION_onStatusChanged /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onStatusChanged(data.readInt());
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void onGpsNavigationMessageReceived(GpsNavigationMessageEvent gpsNavigationMessageEvent) throws RemoteException;

    void onStatusChanged(int i) throws RemoteException;
}
