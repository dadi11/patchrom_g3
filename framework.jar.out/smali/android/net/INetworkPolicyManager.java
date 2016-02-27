package android.net;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface INetworkPolicyManager extends IInterface {

    public static abstract class Stub extends Binder implements INetworkPolicyManager {
        private static final String DESCRIPTOR = "android.net.INetworkPolicyManager";
        static final int TRANSACTION_addUidPolicy = 2;
        static final int TRANSACTION_getNetworkPolicies = 11;
        static final int TRANSACTION_getNetworkQuotaInfo = 15;
        static final int TRANSACTION_getPowerSaveAppIdWhitelist = 7;
        static final int TRANSACTION_getRestrictBackground = 14;
        static final int TRANSACTION_getUidPolicy = 4;
        static final int TRANSACTION_getUidsWithPolicy = 5;
        static final int TRANSACTION_isNetworkMetered = 16;
        static final int TRANSACTION_isUidForeground = 6;
        static final int TRANSACTION_registerListener = 8;
        static final int TRANSACTION_removeUidPolicy = 3;
        static final int TRANSACTION_setNetworkPolicies = 10;
        static final int TRANSACTION_setRestrictBackground = 13;
        static final int TRANSACTION_setUidPolicy = 1;
        static final int TRANSACTION_snoozeLimit = 12;
        static final int TRANSACTION_unregisterListener = 9;

        private static class Proxy implements INetworkPolicyManager {
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

            public void setUidPolicy(int uid, int policy) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    _data.writeInt(policy);
                    this.mRemote.transact(Stub.TRANSACTION_setUidPolicy, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void addUidPolicy(int uid, int policy) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    _data.writeInt(policy);
                    this.mRemote.transact(Stub.TRANSACTION_addUidPolicy, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void removeUidPolicy(int uid, int policy) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    _data.writeInt(policy);
                    this.mRemote.transact(Stub.TRANSACTION_removeUidPolicy, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int getUidPolicy(int uid) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    this.mRemote.transact(Stub.TRANSACTION_getUidPolicy, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int[] getUidsWithPolicy(int policy) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(policy);
                    this.mRemote.transact(Stub.TRANSACTION_getUidsWithPolicy, _data, _reply, 0);
                    _reply.readException();
                    int[] _result = _reply.createIntArray();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean isUidForeground(int uid) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    this.mRemote.transact(Stub.TRANSACTION_isUidForeground, _data, _reply, 0);
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

            public int[] getPowerSaveAppIdWhitelist() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getPowerSaveAppIdWhitelist, _data, _reply, 0);
                    _reply.readException();
                    int[] _result = _reply.createIntArray();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void registerListener(INetworkPolicyListener listener) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(listener != null ? listener.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_registerListener, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void unregisterListener(INetworkPolicyListener listener) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(listener != null ? listener.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_unregisterListener, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setNetworkPolicies(NetworkPolicy[] policies) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeTypedArray(policies, 0);
                    this.mRemote.transact(Stub.TRANSACTION_setNetworkPolicies, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public NetworkPolicy[] getNetworkPolicies() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getNetworkPolicies, _data, _reply, 0);
                    _reply.readException();
                    NetworkPolicy[] _result = (NetworkPolicy[]) _reply.createTypedArray(NetworkPolicy.CREATOR);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void snoozeLimit(NetworkTemplate template) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (template != null) {
                        _data.writeInt(Stub.TRANSACTION_setUidPolicy);
                        template.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_snoozeLimit, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setRestrictBackground(boolean restrictBackground) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (restrictBackground) {
                        i = Stub.TRANSACTION_setUidPolicy;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_setRestrictBackground, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean getRestrictBackground() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getRestrictBackground, _data, _reply, 0);
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

            public NetworkQuotaInfo getNetworkQuotaInfo(NetworkState state) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    NetworkQuotaInfo _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (state != null) {
                        _data.writeInt(Stub.TRANSACTION_setUidPolicy);
                        state.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_getNetworkQuotaInfo, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (NetworkQuotaInfo) NetworkQuotaInfo.CREATOR.createFromParcel(_reply);
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

            public boolean isNetworkMetered(NetworkState state) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (state != null) {
                        _data.writeInt(Stub.TRANSACTION_setUidPolicy);
                        state.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_isNetworkMetered, _data, _reply, 0);
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
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static INetworkPolicyManager asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof INetworkPolicyManager)) {
                return new Proxy(obj);
            }
            return (INetworkPolicyManager) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            int[] _result;
            boolean _result2;
            NetworkState _arg0;
            switch (code) {
                case TRANSACTION_setUidPolicy /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    setUidPolicy(data.readInt(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_addUidPolicy /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    addUidPolicy(data.readInt(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_removeUidPolicy /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    removeUidPolicy(data.readInt(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_getUidPolicy /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    int _result3 = getUidPolicy(data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result3);
                    return true;
                case TRANSACTION_getUidsWithPolicy /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = getUidsWithPolicy(data.readInt());
                    reply.writeNoException();
                    reply.writeIntArray(_result);
                    return true;
                case TRANSACTION_isUidForeground /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = isUidForeground(data.readInt());
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_setUidPolicy;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_getPowerSaveAppIdWhitelist /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = getPowerSaveAppIdWhitelist();
                    reply.writeNoException();
                    reply.writeIntArray(_result);
                    return true;
                case TRANSACTION_registerListener /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    registerListener(android.net.INetworkPolicyListener.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    return true;
                case TRANSACTION_unregisterListener /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    unregisterListener(android.net.INetworkPolicyListener.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setNetworkPolicies /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    setNetworkPolicies((NetworkPolicy[]) data.createTypedArray(NetworkPolicy.CREATOR));
                    reply.writeNoException();
                    return true;
                case TRANSACTION_getNetworkPolicies /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    NetworkPolicy[] _result4 = getNetworkPolicies();
                    reply.writeNoException();
                    reply.writeTypedArray(_result4, TRANSACTION_setUidPolicy);
                    return true;
                case TRANSACTION_snoozeLimit /*12*/:
                    NetworkTemplate _arg02;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (NetworkTemplate) NetworkTemplate.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    snoozeLimit(_arg02);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setRestrictBackground /*13*/:
                    boolean _arg03;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg03 = true;
                    } else {
                        _arg03 = false;
                    }
                    setRestrictBackground(_arg03);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_getRestrictBackground /*14*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = getRestrictBackground();
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_setUidPolicy;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_getNetworkQuotaInfo /*15*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (NetworkState) NetworkState.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    NetworkQuotaInfo _result5 = getNetworkQuotaInfo(_arg0);
                    reply.writeNoException();
                    if (_result5 != null) {
                        reply.writeInt(TRANSACTION_setUidPolicy);
                        _result5.writeToParcel(reply, TRANSACTION_setUidPolicy);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_isNetworkMetered /*16*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (NetworkState) NetworkState.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    _result2 = isNetworkMetered(_arg0);
                    reply.writeNoException();
                    if (_result2) {
                        i = TRANSACTION_setUidPolicy;
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

    void addUidPolicy(int i, int i2) throws RemoteException;

    NetworkPolicy[] getNetworkPolicies() throws RemoteException;

    NetworkQuotaInfo getNetworkQuotaInfo(NetworkState networkState) throws RemoteException;

    int[] getPowerSaveAppIdWhitelist() throws RemoteException;

    boolean getRestrictBackground() throws RemoteException;

    int getUidPolicy(int i) throws RemoteException;

    int[] getUidsWithPolicy(int i) throws RemoteException;

    boolean isNetworkMetered(NetworkState networkState) throws RemoteException;

    boolean isUidForeground(int i) throws RemoteException;

    void registerListener(INetworkPolicyListener iNetworkPolicyListener) throws RemoteException;

    void removeUidPolicy(int i, int i2) throws RemoteException;

    void setNetworkPolicies(NetworkPolicy[] networkPolicyArr) throws RemoteException;

    void setRestrictBackground(boolean z) throws RemoteException;

    void setUidPolicy(int i, int i2) throws RemoteException;

    void snoozeLimit(NetworkTemplate networkTemplate) throws RemoteException;

    void unregisterListener(INetworkPolicyListener iNetworkPolicyListener) throws RemoteException;
}
