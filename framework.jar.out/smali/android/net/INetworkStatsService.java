package android.net;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface INetworkStatsService extends IInterface {

    public static abstract class Stub extends Binder implements INetworkStatsService {
        private static final String DESCRIPTOR = "android.net.INetworkStatsService";
        static final int TRANSACTION_advisePersistThreshold = 9;
        static final int TRANSACTION_forceUpdate = 8;
        static final int TRANSACTION_forceUpdateIfaces = 7;
        static final int TRANSACTION_getDataLayerSnapshotForUid = 3;
        static final int TRANSACTION_getMobileIfaces = 4;
        static final int TRANSACTION_getNetworkTotalBytes = 2;
        static final int TRANSACTION_incrementOperationCount = 5;
        static final int TRANSACTION_openSession = 1;
        static final int TRANSACTION_setUidForeground = 6;

        private static class Proxy implements INetworkStatsService {
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

            public INetworkStatsSession openSession() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_openSession, _data, _reply, 0);
                    _reply.readException();
                    INetworkStatsSession _result = android.net.INetworkStatsSession.Stub.asInterface(_reply.readStrongBinder());
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public long getNetworkTotalBytes(NetworkTemplate template, long start, long end) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (template != null) {
                        _data.writeInt(Stub.TRANSACTION_openSession);
                        template.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeLong(start);
                    _data.writeLong(end);
                    this.mRemote.transact(Stub.TRANSACTION_getNetworkTotalBytes, _data, _reply, 0);
                    _reply.readException();
                    long _result = _reply.readLong();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public NetworkStats getDataLayerSnapshotForUid(int uid) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    NetworkStats _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    this.mRemote.transact(Stub.TRANSACTION_getDataLayerSnapshotForUid, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (NetworkStats) NetworkStats.CREATOR.createFromParcel(_reply);
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

            public String[] getMobileIfaces() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getMobileIfaces, _data, _reply, 0);
                    _reply.readException();
                    String[] _result = _reply.createStringArray();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void incrementOperationCount(int uid, int tag, int operationCount) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    _data.writeInt(tag);
                    _data.writeInt(operationCount);
                    this.mRemote.transact(Stub.TRANSACTION_incrementOperationCount, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setUidForeground(int uid, boolean uidForeground) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(uid);
                    if (uidForeground) {
                        i = Stub.TRANSACTION_openSession;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_setUidForeground, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void forceUpdateIfaces() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_forceUpdateIfaces, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void forceUpdate() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_forceUpdate, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void advisePersistThreshold(long thresholdBytes) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeLong(thresholdBytes);
                    this.mRemote.transact(Stub.TRANSACTION_advisePersistThreshold, _data, _reply, 0);
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

        public static INetworkStatsService asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof INetworkStatsService)) {
                return new Proxy(obj);
            }
            return (INetworkStatsService) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            boolean _arg1 = false;
            switch (code) {
                case TRANSACTION_openSession /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    INetworkStatsSession _result = openSession();
                    reply.writeNoException();
                    reply.writeStrongBinder(_result != null ? _result.asBinder() : null);
                    return true;
                case TRANSACTION_getNetworkTotalBytes /*2*/:
                    NetworkTemplate _arg0;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (NetworkTemplate) NetworkTemplate.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    long _result2 = getNetworkTotalBytes(_arg0, data.readLong(), data.readLong());
                    reply.writeNoException();
                    reply.writeLong(_result2);
                    return true;
                case TRANSACTION_getDataLayerSnapshotForUid /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    NetworkStats _result3 = getDataLayerSnapshotForUid(data.readInt());
                    reply.writeNoException();
                    if (_result3 != null) {
                        reply.writeInt(TRANSACTION_openSession);
                        _result3.writeToParcel(reply, TRANSACTION_openSession);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_getMobileIfaces /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    String[] _result4 = getMobileIfaces();
                    reply.writeNoException();
                    reply.writeStringArray(_result4);
                    return true;
                case TRANSACTION_incrementOperationCount /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    incrementOperationCount(data.readInt(), data.readInt(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setUidForeground /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    int _arg02 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg1 = true;
                    }
                    setUidForeground(_arg02, _arg1);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_forceUpdateIfaces /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    forceUpdateIfaces();
                    reply.writeNoException();
                    return true;
                case TRANSACTION_forceUpdate /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    forceUpdate();
                    reply.writeNoException();
                    return true;
                case TRANSACTION_advisePersistThreshold /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    advisePersistThreshold(data.readLong());
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

    void advisePersistThreshold(long j) throws RemoteException;

    void forceUpdate() throws RemoteException;

    void forceUpdateIfaces() throws RemoteException;

    NetworkStats getDataLayerSnapshotForUid(int i) throws RemoteException;

    String[] getMobileIfaces() throws RemoteException;

    long getNetworkTotalBytes(NetworkTemplate networkTemplate, long j, long j2) throws RemoteException;

    void incrementOperationCount(int i, int i2, int i3) throws RemoteException;

    INetworkStatsSession openSession() throws RemoteException;

    void setUidForeground(int i, boolean z) throws RemoteException;
}
