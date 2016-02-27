package android.security;

import android.content.pm.ParceledListSlice;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import java.util.List;

public interface IKeyChainService extends IInterface {

    public static abstract class Stub extends Binder implements IKeyChainService {
        private static final String DESCRIPTOR = "android.security.IKeyChainService";
        static final int TRANSACTION_containsCaAlias = 9;
        static final int TRANSACTION_deleteCaCertificate = 5;
        static final int TRANSACTION_getCaCertificateChainAliases = 11;
        static final int TRANSACTION_getCertificate = 2;
        static final int TRANSACTION_getEncodedCaCertificate = 10;
        static final int TRANSACTION_getSystemCaAliases = 8;
        static final int TRANSACTION_getUserCaAliases = 7;
        static final int TRANSACTION_hasGrant = 13;
        static final int TRANSACTION_installCaCertificate = 3;
        static final int TRANSACTION_installKeyPair = 4;
        static final int TRANSACTION_requestPrivateKey = 1;
        static final int TRANSACTION_reset = 6;
        static final int TRANSACTION_setGrant = 12;

        private static class Proxy implements IKeyChainService {
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

            public String requestPrivateKey(String alias) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(alias);
                    this.mRemote.transact(Stub.TRANSACTION_requestPrivateKey, _data, _reply, 0);
                    _reply.readException();
                    String _result = _reply.readString();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public byte[] getCertificate(String alias) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(alias);
                    this.mRemote.transact(Stub.TRANSACTION_getCertificate, _data, _reply, 0);
                    _reply.readException();
                    byte[] _result = _reply.createByteArray();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void installCaCertificate(byte[] caCertificate) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeByteArray(caCertificate);
                    this.mRemote.transact(Stub.TRANSACTION_installCaCertificate, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean installKeyPair(byte[] privateKey, byte[] userCert, String alias) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeByteArray(privateKey);
                    _data.writeByteArray(userCert);
                    _data.writeString(alias);
                    this.mRemote.transact(Stub.TRANSACTION_installKeyPair, _data, _reply, 0);
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

            public boolean deleteCaCertificate(String alias) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(alias);
                    this.mRemote.transact(Stub.TRANSACTION_deleteCaCertificate, _data, _reply, 0);
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

            public boolean reset() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_reset, _data, _reply, 0);
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

            public ParceledListSlice getUserCaAliases() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    ParceledListSlice _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getUserCaAliases, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (ParceledListSlice) ParceledListSlice.CREATOR.createFromParcel(_reply);
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

            public ParceledListSlice getSystemCaAliases() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    ParceledListSlice _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getSystemCaAliases, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (ParceledListSlice) ParceledListSlice.CREATOR.createFromParcel(_reply);
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

            public boolean containsCaAlias(String alias) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(alias);
                    this.mRemote.transact(Stub.TRANSACTION_containsCaAlias, _data, _reply, 0);
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

            public byte[] getEncodedCaCertificate(String alias, boolean includeDeletedSystem) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(alias);
                    if (includeDeletedSystem) {
                        i = Stub.TRANSACTION_requestPrivateKey;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_getEncodedCaCertificate, _data, _reply, 0);
                    _reply.readException();
                    byte[] _result = _reply.createByteArray();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public List<String> getCaCertificateChainAliases(String rootAlias, boolean includeDeletedSystem) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(rootAlias);
                    if (includeDeletedSystem) {
                        i = Stub.TRANSACTION_requestPrivateKey;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_getCaCertificateChainAliases, _data, _reply, 0);
                    _reply.readException();
                    List<String> _result = _reply.createStringArrayList();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setGrant(int uid, String alias, boolean value) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    _data.writeString(alias);
                    if (value) {
                        i = Stub.TRANSACTION_requestPrivateKey;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_setGrant, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean hasGrant(int uid, String alias) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    _data.writeString(alias);
                    this.mRemote.transact(Stub.TRANSACTION_hasGrant, _data, _reply, 0);
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

        public static IKeyChainService asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IKeyChainService)) {
                return new Proxy(obj);
            }
            return (IKeyChainService) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            byte[] _result;
            boolean _result2;
            ParceledListSlice _result3;
            String _arg0;
            boolean _arg1;
            switch (code) {
                case TRANSACTION_requestPrivateKey /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    String _result4 = requestPrivateKey(data.readString());
                    reply.writeNoException();
                    reply.writeString(_result4);
                    return true;
                case TRANSACTION_getCertificate /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = getCertificate(data.readString());
                    reply.writeNoException();
                    reply.writeByteArray(_result);
                    return true;
                case TRANSACTION_installCaCertificate /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    installCaCertificate(data.createByteArray());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_installKeyPair /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = installKeyPair(data.createByteArray(), data.createByteArray(), data.readString());
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_requestPrivateKey;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_deleteCaCertificate /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = deleteCaCertificate(data.readString());
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_requestPrivateKey;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_reset /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = reset();
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_requestPrivateKey;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_getUserCaAliases /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result3 = getUserCaAliases();
                    reply.writeNoException();
                    if (_result3 != null) {
                        reply.writeInt(TRANSACTION_requestPrivateKey);
                        _result3.writeToParcel(reply, TRANSACTION_requestPrivateKey);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_getSystemCaAliases /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result3 = getSystemCaAliases();
                    reply.writeNoException();
                    if (_result3 != null) {
                        reply.writeInt(TRANSACTION_requestPrivateKey);
                        _result3.writeToParcel(reply, TRANSACTION_requestPrivateKey);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_containsCaAlias /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = containsCaAlias(data.readString());
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_requestPrivateKey;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_getEncodedCaCertificate /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readString();
                    if (data.readInt() != 0) {
                        _arg1 = true;
                    } else {
                        _arg1 = false;
                    }
                    _result = getEncodedCaCertificate(_arg0, _arg1);
                    reply.writeNoException();
                    reply.writeByteArray(_result);
                    return true;
                case TRANSACTION_getCaCertificateChainAliases /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readString();
                    if (data.readInt() != 0) {
                        _arg1 = true;
                    } else {
                        _arg1 = false;
                    }
                    List<String> _result5 = getCaCertificateChainAliases(_arg0, _arg1);
                    reply.writeNoException();
                    reply.writeStringList(_result5);
                    return true;
                case TRANSACTION_setGrant /*12*/:
                    boolean _arg2;
                    data.enforceInterface(DESCRIPTOR);
                    int _arg02 = data.readInt();
                    String _arg12 = data.readString();
                    if (data.readInt() != 0) {
                        _arg2 = true;
                    } else {
                        _arg2 = false;
                    }
                    setGrant(_arg02, _arg12, _arg2);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_hasGrant /*13*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = hasGrant(data.readInt(), data.readString());
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_requestPrivateKey;
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

    boolean containsCaAlias(String str) throws RemoteException;

    boolean deleteCaCertificate(String str) throws RemoteException;

    List<String> getCaCertificateChainAliases(String str, boolean z) throws RemoteException;

    byte[] getCertificate(String str) throws RemoteException;

    byte[] getEncodedCaCertificate(String str, boolean z) throws RemoteException;

    ParceledListSlice getSystemCaAliases() throws RemoteException;

    ParceledListSlice getUserCaAliases() throws RemoteException;

    boolean hasGrant(int i, String str) throws RemoteException;

    void installCaCertificate(byte[] bArr) throws RemoteException;

    boolean installKeyPair(byte[] bArr, byte[] bArr2, String str) throws RemoteException;

    String requestPrivateKey(String str) throws RemoteException;

    boolean reset() throws RemoteException;

    void setGrant(int i, String str, boolean z) throws RemoteException;
}
