package android.hardware;

import android.hardware.camera2.ICameraDeviceCallbacks;
import android.hardware.camera2.impl.CameraMetadataNative;
import android.hardware.camera2.utils.BinderHolder;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface ICameraService extends IInterface {

    public static abstract class Stub extends Binder implements ICameraService {
        private static final String DESCRIPTOR = "android.hardware.ICameraService";
        static final int TRANSACTION_addListener = 6;
        static final int TRANSACTION_connect = 3;
        static final int TRANSACTION_connectDevice = 5;
        static final int TRANSACTION_connectLegacy = 12;
        static final int TRANSACTION_connectPro = 4;
        static final int TRANSACTION_getCameraCharacteristics = 8;
        static final int TRANSACTION_getCameraInfo = 2;
        static final int TRANSACTION_getCameraVendorTagDescriptor = 9;
        static final int TRANSACTION_getLegacyParameters = 10;
        static final int TRANSACTION_getNumberOfCameras = 1;
        static final int TRANSACTION_removeListener = 7;
        static final int TRANSACTION_supportsCameraApi = 11;

        private static class Proxy implements ICameraService {
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

            public int getNumberOfCameras() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getNumberOfCameras, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int getCameraInfo(int cameraId, CameraInfo info) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(cameraId);
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

            public int connect(ICameraClient client, int cameraId, String clientPackageName, int clientUid, BinderHolder device) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(client != null ? client.asBinder() : null);
                    _data.writeInt(cameraId);
                    _data.writeString(clientPackageName);
                    _data.writeInt(clientUid);
                    this.mRemote.transact(Stub.TRANSACTION_connect, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    if (_reply.readInt() != 0) {
                        device.readFromParcel(_reply);
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int connectPro(IProCameraCallbacks callbacks, int cameraId, String clientPackageName, int clientUid, BinderHolder device) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(callbacks != null ? callbacks.asBinder() : null);
                    _data.writeInt(cameraId);
                    _data.writeString(clientPackageName);
                    _data.writeInt(clientUid);
                    this.mRemote.transact(Stub.TRANSACTION_connectPro, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    if (_reply.readInt() != 0) {
                        device.readFromParcel(_reply);
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int connectDevice(ICameraDeviceCallbacks callbacks, int cameraId, String clientPackageName, int clientUid, BinderHolder device) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(callbacks != null ? callbacks.asBinder() : null);
                    _data.writeInt(cameraId);
                    _data.writeString(clientPackageName);
                    _data.writeInt(clientUid);
                    this.mRemote.transact(Stub.TRANSACTION_connectDevice, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    if (_reply.readInt() != 0) {
                        device.readFromParcel(_reply);
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int addListener(ICameraServiceListener listener) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(listener != null ? listener.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_addListener, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int removeListener(ICameraServiceListener listener) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(listener != null ? listener.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_removeListener, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int getCameraCharacteristics(int cameraId, CameraMetadataNative info) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(cameraId);
                    this.mRemote.transact(Stub.TRANSACTION_getCameraCharacteristics, _data, _reply, 0);
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

            public int getCameraVendorTagDescriptor(BinderHolder desc) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getCameraVendorTagDescriptor, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    if (_reply.readInt() != 0) {
                        desc.readFromParcel(_reply);
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int getLegacyParameters(int cameraId, String[] parameters) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(cameraId);
                    if (parameters == null) {
                        _data.writeInt(-1);
                    } else {
                        _data.writeInt(parameters.length);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_getLegacyParameters, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    _reply.readStringArray(parameters);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int supportsCameraApi(int cameraId, int apiVersion) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(cameraId);
                    _data.writeInt(apiVersion);
                    this.mRemote.transact(Stub.TRANSACTION_supportsCameraApi, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int connectLegacy(ICameraClient client, int cameraId, int halVersion, String clientPackageName, int clientUid, BinderHolder device) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(client != null ? client.asBinder() : null);
                    _data.writeInt(cameraId);
                    _data.writeInt(halVersion);
                    _data.writeString(clientPackageName);
                    _data.writeInt(clientUid);
                    this.mRemote.transact(Stub.TRANSACTION_connectLegacy, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    if (_reply.readInt() != 0) {
                        device.readFromParcel(_reply);
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

        public static ICameraService asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof ICameraService)) {
                return new Proxy(obj);
            }
            return (ICameraService) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int _result;
            int _arg0;
            ICameraClient _arg02;
            int _arg1;
            String _arg2;
            int _arg3;
            BinderHolder _arg4;
            switch (code) {
                case TRANSACTION_getNumberOfCameras /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = getNumberOfCameras();
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_getCameraInfo /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    CameraInfo _arg12 = new CameraInfo();
                    _result = getCameraInfo(_arg0, _arg12);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg12 != null) {
                        reply.writeInt(TRANSACTION_getNumberOfCameras);
                        _arg12.writeToParcel(reply, TRANSACTION_getNumberOfCameras);
                    } else {
                        reply.writeInt(0);
                    }
                    return true;
                case TRANSACTION_connect /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg02 = android.hardware.ICameraClient.Stub.asInterface(data.readStrongBinder());
                    _arg1 = data.readInt();
                    _arg2 = data.readString();
                    _arg3 = data.readInt();
                    _arg4 = new BinderHolder();
                    _result = connect(_arg02, _arg1, _arg2, _arg3, _arg4);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg4 != null) {
                        reply.writeInt(TRANSACTION_getNumberOfCameras);
                        _arg4.writeToParcel(reply, TRANSACTION_getNumberOfCameras);
                    } else {
                        reply.writeInt(0);
                    }
                    return true;
                case TRANSACTION_connectPro /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    IProCameraCallbacks _arg03 = android.hardware.IProCameraCallbacks.Stub.asInterface(data.readStrongBinder());
                    _arg1 = data.readInt();
                    _arg2 = data.readString();
                    _arg3 = data.readInt();
                    _arg4 = new BinderHolder();
                    _result = connectPro(_arg03, _arg1, _arg2, _arg3, _arg4);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg4 != null) {
                        reply.writeInt(TRANSACTION_getNumberOfCameras);
                        _arg4.writeToParcel(reply, TRANSACTION_getNumberOfCameras);
                    } else {
                        reply.writeInt(0);
                    }
                    return true;
                case TRANSACTION_connectDevice /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    ICameraDeviceCallbacks _arg04 = android.hardware.camera2.ICameraDeviceCallbacks.Stub.asInterface(data.readStrongBinder());
                    _arg1 = data.readInt();
                    _arg2 = data.readString();
                    _arg3 = data.readInt();
                    _arg4 = new BinderHolder();
                    _result = connectDevice(_arg04, _arg1, _arg2, _arg3, _arg4);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg4 != null) {
                        reply.writeInt(TRANSACTION_getNumberOfCameras);
                        _arg4.writeToParcel(reply, TRANSACTION_getNumberOfCameras);
                    } else {
                        reply.writeInt(0);
                    }
                    return true;
                case TRANSACTION_addListener /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = addListener(android.hardware.ICameraServiceListener.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_removeListener /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = removeListener(android.hardware.ICameraServiceListener.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_getCameraCharacteristics /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    CameraMetadataNative _arg13 = new CameraMetadataNative();
                    _result = getCameraCharacteristics(_arg0, _arg13);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg13 != null) {
                        reply.writeInt(TRANSACTION_getNumberOfCameras);
                        _arg13.writeToParcel(reply, TRANSACTION_getNumberOfCameras);
                    } else {
                        reply.writeInt(0);
                    }
                    return true;
                case TRANSACTION_getCameraVendorTagDescriptor /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    BinderHolder _arg05 = new BinderHolder();
                    _result = getCameraVendorTagDescriptor(_arg05);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg05 != null) {
                        reply.writeInt(TRANSACTION_getNumberOfCameras);
                        _arg05.writeToParcel(reply, TRANSACTION_getNumberOfCameras);
                    } else {
                        reply.writeInt(0);
                    }
                    return true;
                case TRANSACTION_getLegacyParameters /*10*/:
                    String[] _arg14;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    int _arg1_length = data.readInt();
                    if (_arg1_length < 0) {
                        _arg14 = null;
                    } else {
                        _arg14 = new String[_arg1_length];
                    }
                    _result = getLegacyParameters(_arg0, _arg14);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    reply.writeStringArray(_arg14);
                    return true;
                case TRANSACTION_supportsCameraApi /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = supportsCameraApi(data.readInt(), data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result);
                    return true;
                case TRANSACTION_connectLegacy /*12*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg02 = android.hardware.ICameraClient.Stub.asInterface(data.readStrongBinder());
                    _arg1 = data.readInt();
                    int _arg22 = data.readInt();
                    String _arg32 = data.readString();
                    int _arg42 = data.readInt();
                    BinderHolder _arg5 = new BinderHolder();
                    _result = connectLegacy(_arg02, _arg1, _arg22, _arg32, _arg42, _arg5);
                    reply.writeNoException();
                    reply.writeInt(_result);
                    if (_arg5 != null) {
                        reply.writeInt(TRANSACTION_getNumberOfCameras);
                        _arg5.writeToParcel(reply, TRANSACTION_getNumberOfCameras);
                    } else {
                        reply.writeInt(0);
                    }
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    int addListener(ICameraServiceListener iCameraServiceListener) throws RemoteException;

    int connect(ICameraClient iCameraClient, int i, String str, int i2, BinderHolder binderHolder) throws RemoteException;

    int connectDevice(ICameraDeviceCallbacks iCameraDeviceCallbacks, int i, String str, int i2, BinderHolder binderHolder) throws RemoteException;

    int connectLegacy(ICameraClient iCameraClient, int i, int i2, String str, int i3, BinderHolder binderHolder) throws RemoteException;

    int connectPro(IProCameraCallbacks iProCameraCallbacks, int i, String str, int i2, BinderHolder binderHolder) throws RemoteException;

    int getCameraCharacteristics(int i, CameraMetadataNative cameraMetadataNative) throws RemoteException;

    int getCameraInfo(int i, CameraInfo cameraInfo) throws RemoteException;

    int getCameraVendorTagDescriptor(BinderHolder binderHolder) throws RemoteException;

    int getLegacyParameters(int i, String[] strArr) throws RemoteException;

    int getNumberOfCameras() throws RemoteException;

    int removeListener(ICameraServiceListener iCameraServiceListener) throws RemoteException;

    int supportsCameraApi(int i, int i2) throws RemoteException;
}
