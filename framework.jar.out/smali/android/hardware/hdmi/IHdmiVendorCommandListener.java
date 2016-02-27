package android.hardware.hdmi;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IHdmiVendorCommandListener extends IInterface {

    public static abstract class Stub extends Binder implements IHdmiVendorCommandListener {
        private static final String DESCRIPTOR = "android.hardware.hdmi.IHdmiVendorCommandListener";
        static final int TRANSACTION_onControlStateChanged = 2;
        static final int TRANSACTION_onReceived = 1;

        private static class Proxy implements IHdmiVendorCommandListener {
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

            public void onReceived(int logicalAddress, int destAddress, byte[] operands, boolean hasVendorId) throws RemoteException {
                int i = Stub.TRANSACTION_onReceived;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(logicalAddress);
                    _data.writeInt(destAddress);
                    _data.writeByteArray(operands);
                    if (!hasVendorId) {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_onReceived, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void onControlStateChanged(boolean enabled, int reason) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (enabled) {
                        i = Stub.TRANSACTION_onReceived;
                    }
                    _data.writeInt(i);
                    _data.writeInt(reason);
                    this.mRemote.transact(Stub.TRANSACTION_onControlStateChanged, _data, _reply, 0);
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

        public static IHdmiVendorCommandListener asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IHdmiVendorCommandListener)) {
                return new Proxy(obj);
            }
            return (IHdmiVendorCommandListener) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            boolean _arg3 = false;
            switch (code) {
                case TRANSACTION_onReceived /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    int _arg0 = data.readInt();
                    int _arg1 = data.readInt();
                    byte[] _arg2 = data.createByteArray();
                    if (data.readInt() != 0) {
                        _arg3 = true;
                    }
                    onReceived(_arg0, _arg1, _arg2, _arg3);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_onControlStateChanged /*2*/:
                    boolean _arg02;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = true;
                    } else {
                        _arg02 = false;
                    }
                    onControlStateChanged(_arg02, data.readInt());
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

    void onControlStateChanged(boolean z, int i) throws RemoteException;

    void onReceived(int i, int i2, byte[] bArr, boolean z) throws RemoteException;
}
