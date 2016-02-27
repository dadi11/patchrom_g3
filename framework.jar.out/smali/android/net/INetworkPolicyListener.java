package android.net;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface INetworkPolicyListener extends IInterface {

    public static abstract class Stub extends Binder implements INetworkPolicyListener {
        private static final String DESCRIPTOR = "android.net.INetworkPolicyListener";
        static final int TRANSACTION_onMeteredIfacesChanged = 2;
        static final int TRANSACTION_onRestrictBackgroundChanged = 3;
        static final int TRANSACTION_onUidRulesChanged = 1;

        private static class Proxy implements INetworkPolicyListener {
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

            public void onUidRulesChanged(int uid, int uidRules) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    _data.writeInt(uidRules);
                    this.mRemote.transact(Stub.TRANSACTION_onUidRulesChanged, _data, null, Stub.TRANSACTION_onUidRulesChanged);
                } finally {
                    _data.recycle();
                }
            }

            public void onMeteredIfacesChanged(String[] meteredIfaces) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStringArray(meteredIfaces);
                    this.mRemote.transact(Stub.TRANSACTION_onMeteredIfacesChanged, _data, null, Stub.TRANSACTION_onUidRulesChanged);
                } finally {
                    _data.recycle();
                }
            }

            public void onRestrictBackgroundChanged(boolean restrictBackground) throws RemoteException {
                int i = Stub.TRANSACTION_onUidRulesChanged;
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (!restrictBackground) {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_onRestrictBackgroundChanged, _data, null, Stub.TRANSACTION_onUidRulesChanged);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static INetworkPolicyListener asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof INetworkPolicyListener)) {
                return new Proxy(obj);
            }
            return (INetworkPolicyListener) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_onUidRulesChanged /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    onUidRulesChanged(data.readInt(), data.readInt());
                    return true;
                case TRANSACTION_onMeteredIfacesChanged /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onMeteredIfacesChanged(data.createStringArray());
                    return true;
                case TRANSACTION_onRestrictBackgroundChanged /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    onRestrictBackgroundChanged(data.readInt() != 0);
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void onMeteredIfacesChanged(String[] strArr) throws RemoteException;

    void onRestrictBackgroundChanged(boolean z) throws RemoteException;

    void onUidRulesChanged(int i, int i2) throws RemoteException;
}
