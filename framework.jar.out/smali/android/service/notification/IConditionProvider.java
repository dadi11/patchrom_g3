package android.service.notification;

import android.net.Uri;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IConditionProvider extends IInterface {

    public static abstract class Stub extends Binder implements IConditionProvider {
        private static final String DESCRIPTOR = "android.service.notification.IConditionProvider";
        static final int TRANSACTION_onConnected = 1;
        static final int TRANSACTION_onRequestConditions = 2;
        static final int TRANSACTION_onSubscribe = 3;
        static final int TRANSACTION_onUnsubscribe = 4;

        private static class Proxy implements IConditionProvider {
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

            public void onConnected() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_onConnected, _data, null, Stub.TRANSACTION_onConnected);
                } finally {
                    _data.recycle();
                }
            }

            public void onRequestConditions(int relevance) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(relevance);
                    this.mRemote.transact(Stub.TRANSACTION_onRequestConditions, _data, null, Stub.TRANSACTION_onConnected);
                } finally {
                    _data.recycle();
                }
            }

            public void onSubscribe(Uri conditionId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (conditionId != null) {
                        _data.writeInt(Stub.TRANSACTION_onConnected);
                        conditionId.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onSubscribe, _data, null, Stub.TRANSACTION_onConnected);
                } finally {
                    _data.recycle();
                }
            }

            public void onUnsubscribe(Uri conditionId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (conditionId != null) {
                        _data.writeInt(Stub.TRANSACTION_onConnected);
                        conditionId.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onUnsubscribe, _data, null, Stub.TRANSACTION_onConnected);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static IConditionProvider asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IConditionProvider)) {
                return new Proxy(obj);
            }
            return (IConditionProvider) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            Uri _arg0;
            switch (code) {
                case TRANSACTION_onConnected /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    onConnected();
                    return true;
                case TRANSACTION_onRequestConditions /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onRequestConditions(data.readInt());
                    return true;
                case TRANSACTION_onSubscribe /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (Uri) Uri.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    onSubscribe(_arg0);
                    return true;
                case TRANSACTION_onUnsubscribe /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (Uri) Uri.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    onUnsubscribe(_arg0);
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void onConnected() throws RemoteException;

    void onRequestConditions(int i) throws RemoteException;

    void onSubscribe(Uri uri) throws RemoteException;

    void onUnsubscribe(Uri uri) throws RemoteException;
}
