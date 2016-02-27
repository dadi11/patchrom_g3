package android.hardware.camera2;

import android.hardware.camera2.impl.CameraMetadataNative;
import android.hardware.camera2.impl.CaptureResultExtras;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface ICameraDeviceCallbacks extends IInterface {

    public static abstract class Stub extends Binder implements ICameraDeviceCallbacks {
        private static final String DESCRIPTOR = "android.hardware.camera2.ICameraDeviceCallbacks";
        static final int TRANSACTION_onCaptureStarted = 3;
        static final int TRANSACTION_onDeviceError = 1;
        static final int TRANSACTION_onDeviceIdle = 2;
        static final int TRANSACTION_onResultReceived = 4;

        private static class Proxy implements ICameraDeviceCallbacks {
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

            public void onDeviceError(int errorCode, CaptureResultExtras resultExtras) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(errorCode);
                    if (resultExtras != null) {
                        _data.writeInt(Stub.TRANSACTION_onDeviceError);
                        resultExtras.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onDeviceError, _data, null, Stub.TRANSACTION_onDeviceError);
                } finally {
                    _data.recycle();
                }
            }

            public void onDeviceIdle() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_onDeviceIdle, _data, null, Stub.TRANSACTION_onDeviceError);
                } finally {
                    _data.recycle();
                }
            }

            public void onCaptureStarted(CaptureResultExtras resultExtras, long timestamp) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (resultExtras != null) {
                        _data.writeInt(Stub.TRANSACTION_onDeviceError);
                        resultExtras.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeLong(timestamp);
                    this.mRemote.transact(Stub.TRANSACTION_onCaptureStarted, _data, null, Stub.TRANSACTION_onDeviceError);
                } finally {
                    _data.recycle();
                }
            }

            public void onResultReceived(CameraMetadataNative result, CaptureResultExtras resultExtras) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (result != null) {
                        _data.writeInt(Stub.TRANSACTION_onDeviceError);
                        result.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (resultExtras != null) {
                        _data.writeInt(Stub.TRANSACTION_onDeviceError);
                        resultExtras.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onResultReceived, _data, null, Stub.TRANSACTION_onDeviceError);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static ICameraDeviceCallbacks asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof ICameraDeviceCallbacks)) {
                return new Proxy(obj);
            }
            return (ICameraDeviceCallbacks) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            CaptureResultExtras _arg1;
            switch (code) {
                case TRANSACTION_onDeviceError /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    int _arg0 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg1 = (CaptureResultExtras) CaptureResultExtras.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    onDeviceError(_arg0, _arg1);
                    return true;
                case TRANSACTION_onDeviceIdle /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onDeviceIdle();
                    return true;
                case TRANSACTION_onCaptureStarted /*3*/:
                    CaptureResultExtras _arg02;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (CaptureResultExtras) CaptureResultExtras.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    onCaptureStarted(_arg02, data.readLong());
                    return true;
                case TRANSACTION_onResultReceived /*4*/:
                    CameraMetadataNative _arg03;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg03 = (CameraMetadataNative) CameraMetadataNative.CREATOR.createFromParcel(data);
                    } else {
                        _arg03 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg1 = (CaptureResultExtras) CaptureResultExtras.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    onResultReceived(_arg03, _arg1);
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void onCaptureStarted(CaptureResultExtras captureResultExtras, long j) throws RemoteException;

    void onDeviceError(int i, CaptureResultExtras captureResultExtras) throws RemoteException;

    void onDeviceIdle() throws RemoteException;

    void onResultReceived(CameraMetadataNative cameraMetadataNative, CaptureResultExtras captureResultExtras) throws RemoteException;
}
