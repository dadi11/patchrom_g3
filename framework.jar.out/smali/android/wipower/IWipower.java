package android.wipower;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IWipower extends IInterface {

    public static abstract class Stub extends Binder implements IWipower {
        private static final String DESCRIPTOR = "android.wipower.IWipower";
        static final int TRANSACTION_enableAlert = 6;
        static final int TRANSACTION_enableData = 7;
        static final int TRANSACTION_enablePowerApply = 8;
        static final int TRANSACTION_getCurrentLimit = 5;
        static final int TRANSACTION_getState = 1;
        static final int TRANSACTION_registerCallback = 9;
        static final int TRANSACTION_setCurrentLimit = 4;
        static final int TRANSACTION_startCharging = 2;
        static final int TRANSACTION_stopCharging = 3;
        static final int TRANSACTION_unregisterCallback = 10;

        private static class Proxy implements IWipower {
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

            public int getState() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getState, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean startCharging() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_startCharging, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = true;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean stopCharging() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_stopCharging, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = true;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean setCurrentLimit(byte value) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeByte(value);
                    this.mRemote.transact(Stub.TRANSACTION_setCurrentLimit, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = true;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public byte getCurrentLimit() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getCurrentLimit, _data, _reply, 0);
                    _reply.readException();
                    byte _result = _reply.readByte();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean enableAlert(boolean enable) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    int i;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (enable) {
                        i = Stub.TRANSACTION_getState;
                    } else {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_enableAlert, _data, _reply, 0);
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

            public boolean enableData(boolean enable) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    int i;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (enable) {
                        i = Stub.TRANSACTION_getState;
                    } else {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_enableData, _data, _reply, 0);
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

            public boolean enablePowerApply(boolean enable, boolean on, boolean time_flag) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    int i;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (enable) {
                        i = Stub.TRANSACTION_getState;
                    } else {
                        i = 0;
                    }
                    _data.writeInt(i);
                    if (on) {
                        i = Stub.TRANSACTION_getState;
                    } else {
                        i = 0;
                    }
                    _data.writeInt(i);
                    if (time_flag) {
                        i = Stub.TRANSACTION_getState;
                    } else {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_enablePowerApply, _data, _reply, 0);
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

            public void registerCallback(IWipowerManagerCallback callback) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(callback != null ? callback.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_registerCallback, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void unregisterCallback(IWipowerManagerCallback callback) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(callback != null ? callback.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_unregisterCallback, _data, _reply, 0);
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

        public static IWipower asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IWipower)) {
                return new Proxy(obj);
            }
            return (IWipower) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            boolean _result;
            boolean _arg0;
            switch (code) {
                case TRANSACTION_getState /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    int _result2 = getState();
                    reply.writeNoException();
                    reply.writeInt(_result2);
                    return true;
                case TRANSACTION_startCharging /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = startCharging();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getState;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_stopCharging /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = stopCharging();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getState;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_setCurrentLimit /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = setCurrentLimit(data.readByte());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getState;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_getCurrentLimit /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    byte _result3 = getCurrentLimit();
                    reply.writeNoException();
                    reply.writeByte(_result3);
                    return true;
                case TRANSACTION_enableAlert /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = true;
                    } else {
                        _arg0 = false;
                    }
                    _result = enableAlert(_arg0);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getState;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_enableData /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = true;
                    } else {
                        _arg0 = false;
                    }
                    _result = enableData(_arg0);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getState;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_enablePowerApply /*8*/:
                    boolean _arg1;
                    boolean _arg2;
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
                    if (data.readInt() != 0) {
                        _arg2 = true;
                    } else {
                        _arg2 = false;
                    }
                    _result = enablePowerApply(_arg0, _arg1, _arg2);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getState;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_registerCallback /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    registerCallback(android.wipower.IWipowerManagerCallback.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    return true;
                case TRANSACTION_unregisterCallback /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    unregisterCallback(android.wipower.IWipowerManagerCallback.Stub.asInterface(data.readStrongBinder()));
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

    boolean enableAlert(boolean z) throws RemoteException;

    boolean enableData(boolean z) throws RemoteException;

    boolean enablePowerApply(boolean z, boolean z2, boolean z3) throws RemoteException;

    byte getCurrentLimit() throws RemoteException;

    int getState() throws RemoteException;

    void registerCallback(IWipowerManagerCallback iWipowerManagerCallback) throws RemoteException;

    boolean setCurrentLimit(byte b) throws RemoteException;

    boolean startCharging() throws RemoteException;

    boolean stopCharging() throws RemoteException;

    void unregisterCallback(IWipowerManagerCallback iWipowerManagerCallback) throws RemoteException;
}
