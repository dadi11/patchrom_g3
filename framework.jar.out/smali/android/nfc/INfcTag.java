package android.nfc;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface INfcTag extends IInterface {

    public static abstract class Stub extends Binder implements INfcTag {
        private static final String DESCRIPTOR = "android.nfc.INfcTag";
        static final int TRANSACTION_canMakeReadOnly = 17;
        static final int TRANSACTION_close = 1;
        static final int TRANSACTION_connect = 2;
        static final int TRANSACTION_formatNdef = 12;
        static final int TRANSACTION_getExtendedLengthApdusSupported = 19;
        static final int TRANSACTION_getMaxTransceiveLength = 18;
        static final int TRANSACTION_getTechList = 4;
        static final int TRANSACTION_getTimeout = 15;
        static final int TRANSACTION_isNdef = 5;
        static final int TRANSACTION_isPresent = 6;
        static final int TRANSACTION_ndefIsWritable = 11;
        static final int TRANSACTION_ndefMakeReadOnly = 10;
        static final int TRANSACTION_ndefRead = 8;
        static final int TRANSACTION_ndefWrite = 9;
        static final int TRANSACTION_reconnect = 3;
        static final int TRANSACTION_rediscover = 13;
        static final int TRANSACTION_resetTimeouts = 16;
        static final int TRANSACTION_setTimeout = 14;
        static final int TRANSACTION_transceive = 7;

        private static class Proxy implements INfcTag {
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

            public int close(int nativeHandle) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    this.mRemote.transact(Stub.TRANSACTION_close, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int connect(int nativeHandle, int technology) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    _data.writeInt(technology);
                    this.mRemote.transact(Stub.TRANSACTION_connect, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int reconnect(int nativeHandle) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    this.mRemote.transact(Stub.TRANSACTION_reconnect, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int[] getTechList(int nativeHandle) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    this.mRemote.transact(Stub.TRANSACTION_getTechList, _data, _reply, 0);
                    _reply.readException();
                    int[] _result = _reply.createIntArray();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean isNdef(int nativeHandle) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    this.mRemote.transact(Stub.TRANSACTION_isNdef, _data, _reply, 0);
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

            public boolean isPresent(int nativeHandle) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    this.mRemote.transact(Stub.TRANSACTION_isPresent, _data, _reply, 0);
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

            public TransceiveResult transceive(int nativeHandle, byte[] data, boolean raw) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    TransceiveResult _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    _data.writeByteArray(data);
                    if (raw) {
                        i = Stub.TRANSACTION_close;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_transceive, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (TransceiveResult) TransceiveResult.CREATOR.createFromParcel(_reply);
                    } else {
                        _result = null;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public NdefMessage ndefRead(int nativeHandle) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    NdefMessage _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    this.mRemote.transact(Stub.TRANSACTION_ndefRead, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (NdefMessage) NdefMessage.CREATOR.createFromParcel(_reply);
                    } else {
                        _result = null;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int ndefWrite(int nativeHandle, NdefMessage msg) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    if (msg != null) {
                        _data.writeInt(Stub.TRANSACTION_close);
                        msg.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_ndefWrite, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int ndefMakeReadOnly(int nativeHandle) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    this.mRemote.transact(Stub.TRANSACTION_ndefMakeReadOnly, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean ndefIsWritable(int nativeHandle) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    this.mRemote.transact(Stub.TRANSACTION_ndefIsWritable, _data, _reply, 0);
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

            public int formatNdef(int nativeHandle, byte[] key) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativeHandle);
                    _data.writeByteArray(key);
                    this.mRemote.transact(Stub.TRANSACTION_formatNdef, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public Tag rediscover(int nativehandle) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    Tag _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(nativehandle);
                    this.mRemote.transact(Stub.TRANSACTION_rediscover, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (Tag) Tag.CREATOR.createFromParcel(_reply);
                    } else {
                        _result = null;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int setTimeout(int technology, int timeout) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(technology);
                    _data.writeInt(timeout);
                    this.mRemote.transact(Stub.TRANSACTION_setTimeout, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int getTimeout(int technology) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(technology);
                    this.mRemote.transact(Stub.TRANSACTION_getTimeout, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void resetTimeouts() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_resetTimeouts, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean canMakeReadOnly(int ndefType) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(ndefType);
                    this.mRemote.transact(Stub.TRANSACTION_canMakeReadOnly, _data, _reply, 0);
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

            public int getMaxTransceiveLength(int technology) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(technology);
                    this.mRemote.transact(Stub.TRANSACTION_getMaxTransceiveLength, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean getExtendedLengthApdusSupported() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getExtendedLengthApdusSupported, _data, _reply, 0);
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
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static INfcTag asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof INfcTag)) {
                return new Proxy(obj);
            }
            return (INfcTag) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            int _result;
            boolean _result2;
            int _arg0;
            switch (code) {
                case TRANSACTION_close /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = close(data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_connect /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = connect(data.readInt(), data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_reconnect /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = reconnect(data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_getTechList /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    int[] _result3 = getTechList(data.readInt());
                    reply.writeNoException();
                    reply.writeIntArray(_result3);
                    return true;
                case TRANSACTION_isNdef /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = isNdef(data.readInt());
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_close;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_isPresent /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = isPresent(data.readInt());
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_close;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_transceive /*7*/:
                    boolean _arg2;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    byte[] _arg1 = data.createByteArray();
                    if (data.readInt() != 0) {
                        _arg2 = true;
                    } else {
                        _arg2 = false;
                    }
                    TransceiveResult _result4 = transceive(_arg0, _arg1, _arg2);
                    reply.writeNoException();
                    if (_result4 != null) {
                        reply.writeInt(TRANSACTION_close);
                        _result4.writeToParcel(reply, TRANSACTION_close);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_ndefRead /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    NdefMessage _result5 = ndefRead(data.readInt());
                    reply.writeNoException();
                    if (_result5 != null) {
                        reply.writeInt(TRANSACTION_close);
                        _result5.writeToParcel(reply, TRANSACTION_close);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_ndefWrite /*9*/:
                    NdefMessage _arg12;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg12 = (NdefMessage) NdefMessage.CREATOR.createFromParcel(data);
                    } else {
                        _arg12 = null;
                    }
                    _result = ndefWrite(_arg0, _arg12);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_ndefMakeReadOnly /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = ndefMakeReadOnly(data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_ndefIsWritable /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = ndefIsWritable(data.readInt());
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_close;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_formatNdef /*12*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = formatNdef(data.readInt(), data.createByteArray());
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_rediscover /*13*/:
                    data.enforceInterface(DESCRIPTOR);
                    Tag _result6 = rediscover(data.readInt());
                    reply.writeNoException();
                    if (_result6 != null) {
                        reply.writeInt(TRANSACTION_close);
                        _result6.writeToParcel(reply, TRANSACTION_close);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_setTimeout /*14*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = setTimeout(data.readInt(), data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_getTimeout /*15*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = getTimeout(data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_resetTimeouts /*16*/:
                    data.enforceInterface(DESCRIPTOR);
                    resetTimeouts();
                    reply.writeNoException();
                    return true;
                case TRANSACTION_canMakeReadOnly /*17*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = canMakeReadOnly(data.readInt());
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_close;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_getMaxTransceiveLength /*18*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = getMaxTransceiveLength(data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_getExtendedLengthApdusSupported /*19*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = getExtendedLengthApdusSupported();
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_close;
                    }
                    reply.writeInt(i);
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    boolean canMakeReadOnly(int i) throws RemoteException;

    int close(int i) throws RemoteException;

    int connect(int i, int i2) throws RemoteException;

    int formatNdef(int i, byte[] bArr) throws RemoteException;

    boolean getExtendedLengthApdusSupported() throws RemoteException;

    int getMaxTransceiveLength(int i) throws RemoteException;

    int[] getTechList(int i) throws RemoteException;

    int getTimeout(int i) throws RemoteException;

    boolean isNdef(int i) throws RemoteException;

    boolean isPresent(int i) throws RemoteException;

    boolean ndefIsWritable(int i) throws RemoteException;

    int ndefMakeReadOnly(int i) throws RemoteException;

    NdefMessage ndefRead(int i) throws RemoteException;

    int ndefWrite(int i, NdefMessage ndefMessage) throws RemoteException;

    int reconnect(int i) throws RemoteException;

    Tag rediscover(int i) throws RemoteException;

    void resetTimeouts() throws RemoteException;

    int setTimeout(int i, int i2) throws RemoteException;

    TransceiveResult transceive(int i, byte[] bArr, boolean z) throws RemoteException;
}
