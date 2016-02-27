package android.hardware.location;

import android.location.FusedBatchOptions;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IFusedLocationHardware extends IInterface {

    public static abstract class Stub extends Binder implements IFusedLocationHardware {
        private static final String DESCRIPTOR = "android.hardware.location.IFusedLocationHardware";
        static final int TRANSACTION_getSupportedBatchSize = 3;
        static final int TRANSACTION_injectDeviceContext = 11;
        static final int TRANSACTION_injectDiagnosticData = 9;
        static final int TRANSACTION_registerSink = 1;
        static final int TRANSACTION_requestBatchOfLocations = 7;
        static final int TRANSACTION_startBatching = 4;
        static final int TRANSACTION_stopBatching = 5;
        static final int TRANSACTION_supportsDeviceContextInjection = 10;
        static final int TRANSACTION_supportsDiagnosticDataInjection = 8;
        static final int TRANSACTION_unregisterSink = 2;
        static final int TRANSACTION_updateBatchingOptions = 6;

        private static class Proxy implements IFusedLocationHardware {
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

            public void registerSink(IFusedLocationHardwareSink eventSink) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(eventSink != null ? eventSink.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_registerSink, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void unregisterSink(IFusedLocationHardwareSink eventSink) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(eventSink != null ? eventSink.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_unregisterSink, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int getSupportedBatchSize() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getSupportedBatchSize, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void startBatching(int id, FusedBatchOptions batchOptions) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(id);
                    if (batchOptions != null) {
                        _data.writeInt(Stub.TRANSACTION_registerSink);
                        batchOptions.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_startBatching, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void stopBatching(int id) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(id);
                    this.mRemote.transact(Stub.TRANSACTION_stopBatching, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void updateBatchingOptions(int id, FusedBatchOptions batchOptions) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(id);
                    if (batchOptions != null) {
                        _data.writeInt(Stub.TRANSACTION_registerSink);
                        batchOptions.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_updateBatchingOptions, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void requestBatchOfLocations(int batchSizeRequested) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(batchSizeRequested);
                    this.mRemote.transact(Stub.TRANSACTION_requestBatchOfLocations, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean supportsDiagnosticDataInjection() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_supportsDiagnosticDataInjection, _data, _reply, 0);
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

            public void injectDiagnosticData(String data) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(data);
                    this.mRemote.transact(Stub.TRANSACTION_injectDiagnosticData, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean supportsDeviceContextInjection() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_supportsDeviceContextInjection, _data, _reply, 0);
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

            public void injectDeviceContext(int deviceEnabledContext) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(deviceEnabledContext);
                    this.mRemote.transact(Stub.TRANSACTION_injectDeviceContext, _data, _reply, 0);
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

        public static IFusedLocationHardware asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IFusedLocationHardware)) {
                return new Proxy(obj);
            }
            return (IFusedLocationHardware) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            int _arg0;
            FusedBatchOptions _arg1;
            boolean _result;
            switch (code) {
                case TRANSACTION_registerSink /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    registerSink(android.hardware.location.IFusedLocationHardwareSink.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    return true;
                case TRANSACTION_unregisterSink /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    unregisterSink(android.hardware.location.IFusedLocationHardwareSink.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    return true;
                case TRANSACTION_getSupportedBatchSize /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    int _result2 = getSupportedBatchSize();
                    reply.writeNoException();
                    reply.writeInt(_result2);
                    return true;
                case TRANSACTION_startBatching /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg1 = (FusedBatchOptions) FusedBatchOptions.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    startBatching(_arg0, _arg1);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_stopBatching /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    stopBatching(data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_updateBatchingOptions /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg1 = (FusedBatchOptions) FusedBatchOptions.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    updateBatchingOptions(_arg0, _arg1);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_requestBatchOfLocations /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    requestBatchOfLocations(data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_supportsDiagnosticDataInjection /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = supportsDiagnosticDataInjection();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerSink;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_injectDiagnosticData /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    injectDiagnosticData(data.readString());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_supportsDeviceContextInjection /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = supportsDeviceContextInjection();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerSink;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_injectDeviceContext /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    injectDeviceContext(data.readInt());
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

    int getSupportedBatchSize() throws RemoteException;

    void injectDeviceContext(int i) throws RemoteException;

    void injectDiagnosticData(String str) throws RemoteException;

    void registerSink(IFusedLocationHardwareSink iFusedLocationHardwareSink) throws RemoteException;

    void requestBatchOfLocations(int i) throws RemoteException;

    void startBatching(int i, FusedBatchOptions fusedBatchOptions) throws RemoteException;

    void stopBatching(int i) throws RemoteException;

    boolean supportsDeviceContextInjection() throws RemoteException;

    boolean supportsDiagnosticDataInjection() throws RemoteException;

    void unregisterSink(IFusedLocationHardwareSink iFusedLocationHardwareSink) throws RemoteException;

    void updateBatchingOptions(int i, FusedBatchOptions fusedBatchOptions) throws RemoteException;
}
