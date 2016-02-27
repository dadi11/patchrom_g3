package android.hardware.camera2;

import android.hardware.camera2.impl.CameraMetadataNative;
import android.hardware.camera2.utils.LongParcelable;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import android.view.Surface;
import java.util.List;

public interface ICameraDeviceUser extends IInterface {

    public static abstract class Stub extends Binder implements ICameraDeviceUser {
        private static final String DESCRIPTOR = "android.hardware.camera2.ICameraDeviceUser";
        static final int TRANSACTION_beginConfigure = 5;
        static final int TRANSACTION_cancelRequest = 4;
        static final int TRANSACTION_createDefaultRequest = 9;
        static final int TRANSACTION_createStream = 8;
        static final int TRANSACTION_deleteStream = 7;
        static final int TRANSACTION_disconnect = 1;
        static final int TRANSACTION_endConfigure = 6;
        static final int TRANSACTION_flush = 12;
        static final int TRANSACTION_getCameraInfo = 10;
        static final int TRANSACTION_submitRequest = 2;
        static final int TRANSACTION_submitRequestList = 3;
        static final int TRANSACTION_waitUntilIdle = 11;

        private static class Proxy implements ICameraDeviceUser {
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

            public void disconnect() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_disconnect, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int submitRequest(CaptureRequest request, boolean streaming, LongParcelable lastFrameNumber) throws RemoteException {
                int i = Stub.TRANSACTION_disconnect;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (request != null) {
                        _data.writeInt(Stub.TRANSACTION_disconnect);
                        request.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (!streaming) {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_submitRequest, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    if (_reply.readInt() != 0) {
                        lastFrameNumber.readFromParcel(_reply);
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int submitRequestList(List<CaptureRequest> requestList, boolean streaming, LongParcelable lastFrameNumber) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeTypedList(requestList);
                    if (streaming) {
                        i = Stub.TRANSACTION_disconnect;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_submitRequestList, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    if (_reply.readInt() != 0) {
                        lastFrameNumber.readFromParcel(_reply);
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int cancelRequest(int requestId, LongParcelable lastFrameNumber) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(requestId);
                    this.mRemote.transact(Stub.TRANSACTION_cancelRequest, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    if (_reply.readInt() != 0) {
                        lastFrameNumber.readFromParcel(_reply);
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int beginConfigure() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_beginConfigure, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int endConfigure() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_endConfigure, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int deleteStream(int streamId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(streamId);
                    this.mRemote.transact(Stub.TRANSACTION_deleteStream, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int createStream(int width, int height, int format, Surface surface) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(width);
                    _data.writeInt(height);
                    _data.writeInt(format);
                    if (surface != null) {
                        _data.writeInt(Stub.TRANSACTION_disconnect);
                        surface.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_createStream, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int createDefaultRequest(int templateId, CameraMetadataNative request) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(templateId);
                    this.mRemote.transact(Stub.TRANSACTION_createDefaultRequest, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    if (_reply.readInt() != 0) {
                        request.readFromParcel(_reply);
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int getCameraInfo(CameraMetadataNative info) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getCameraInfo, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    if (_reply.readInt() != 0) {
                        info.readFromParcel(_reply);
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int waitUntilIdle() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_waitUntilIdle, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int flush(LongParcelable lastFrameNumber) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_flush, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    if (_reply.readInt() != 0) {
                        lastFrameNumber.readFromParcel(_reply);
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

        public static ICameraDeviceUser asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof ICameraDeviceUser)) {
                return new Proxy(obj);
            }
            return (ICameraDeviceUser) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            boolean _arg1;
            LongParcelable _arg2;
            int _result;
            int _arg0;
            switch (code) {
                case TRANSACTION_disconnect /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    disconnect();
                    reply.writeNoException();
                    return true;
                case TRANSACTION_submitRequest /*2*/:
                    CaptureRequest _arg02;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (CaptureRequest) CaptureRequest.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg1 = true;
                    } else {
                        _arg1 = false;
                    }
                    _arg2 = new LongParcelable();
                    _result = submitRequest(_arg02, _arg1, _arg2);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg2 != null) {
                        reply.writeInt(TRANSACTION_disconnect);
                        _arg2.writeToParcel(reply, TRANSACTION_disconnect);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_submitRequestList /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    List<CaptureRequest> _arg03 = data.createTypedArrayList(CaptureRequest.CREATOR);
                    if (data.readInt() != 0) {
                        _arg1 = true;
                    } else {
                        _arg1 = false;
                    }
                    _arg2 = new LongParcelable();
                    _result = submitRequestList(_arg03, _arg1, _arg2);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg2 != null) {
                        reply.writeInt(TRANSACTION_disconnect);
                        _arg2.writeToParcel(reply, TRANSACTION_disconnect);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_cancelRequest /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    LongParcelable _arg12 = new LongParcelable();
                    _result = cancelRequest(_arg0, _arg12);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg12 != null) {
                        reply.writeInt(TRANSACTION_disconnect);
                        _arg12.writeToParcel(reply, TRANSACTION_disconnect);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_beginConfigure /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = beginConfigure();
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_endConfigure /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = endConfigure();
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_deleteStream /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = deleteStream(data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_createStream /*8*/:
                    Surface _arg3;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    int _arg13 = data.readInt();
                    int _arg22 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg3 = (Surface) Surface.CREATOR.createFromParcel(data);
                    } else {
                        _arg3 = null;
                    }
                    _result = createStream(_arg0, _arg13, _arg22, _arg3);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_createDefaultRequest /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    CameraMetadataNative _arg14 = new CameraMetadataNative();
                    _result = createDefaultRequest(_arg0, _arg14);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg14 != null) {
                        reply.writeInt(TRANSACTION_disconnect);
                        _arg14.writeToParcel(reply, TRANSACTION_disconnect);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_getCameraInfo /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    CameraMetadataNative _arg04 = new CameraMetadataNative();
                    _result = getCameraInfo(_arg04);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg04 != null) {
                        reply.writeInt(TRANSACTION_disconnect);
                        _arg04.writeToParcel(reply, TRANSACTION_disconnect);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_waitUntilIdle /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = waitUntilIdle();
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_flush /*12*/:
                    data.enforceInterface(DESCRIPTOR);
                    LongParcelable _arg05 = new LongParcelable();
                    _result = flush(_arg05);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg05 != null) {
                        reply.writeInt(TRANSACTION_disconnect);
                        _arg05.writeToParcel(reply, TRANSACTION_disconnect);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    int beginConfigure() throws RemoteException;

    int cancelRequest(int i, LongParcelable longParcelable) throws RemoteException;

    int createDefaultRequest(int i, CameraMetadataNative cameraMetadataNative) throws RemoteException;

    int createStream(int i, int i2, int i3, Surface surface) throws RemoteException;

    int deleteStream(int i) throws RemoteException;

    void disconnect() throws RemoteException;

    int endConfigure() throws RemoteException;

    int flush(LongParcelable longParcelable) throws RemoteException;

    int getCameraInfo(CameraMetadataNative cameraMetadataNative) throws RemoteException;

    int submitRequest(CaptureRequest captureRequest, boolean z, LongParcelable longParcelable) throws RemoteException;

    int submitRequestList(List<CaptureRequest> list, boolean z, LongParcelable longParcelable) throws RemoteException;

    int waitUntilIdle() throws RemoteException;
}
