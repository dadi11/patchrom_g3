package android.bluetooth;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.RemoteException;
import java.util.List;

public interface IBluetoothHealth extends IInterface {

    public static abstract class Stub extends Binder implements IBluetoothHealth {
        private static final String DESCRIPTOR = "android.bluetooth.IBluetoothHealth";
        static final int TRANSACTION_connectChannelToSink = 4;
        static final int TRANSACTION_connectChannelToSource = 3;
        static final int TRANSACTION_disconnectChannel = 5;
        static final int TRANSACTION_getConnectedHealthDevices = 7;
        static final int TRANSACTION_getHealthDeviceConnectionState = 9;
        static final int TRANSACTION_getHealthDevicesMatchingConnectionStates = 8;
        static final int TRANSACTION_getMainChannelFd = 6;
        static final int TRANSACTION_registerAppConfiguration = 1;
        static final int TRANSACTION_unregisterAppConfiguration = 2;

        private static class Proxy implements IBluetoothHealth {
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

            public boolean registerAppConfiguration(BluetoothHealthAppConfiguration config, IBluetoothHealthCallback callback) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (config != null) {
                        _data.writeInt(Stub.TRANSACTION_registerAppConfiguration);
                        config.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeStrongBinder(callback != null ? callback.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_registerAppConfiguration, _data, _reply, 0);
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

            public boolean unregisterAppConfiguration(BluetoothHealthAppConfiguration config) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (config != null) {
                        _data.writeInt(Stub.TRANSACTION_registerAppConfiguration);
                        config.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_unregisterAppConfiguration, _data, _reply, 0);
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

            public boolean connectChannelToSource(BluetoothDevice device, BluetoothHealthAppConfiguration config) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (device != null) {
                        _data.writeInt(Stub.TRANSACTION_registerAppConfiguration);
                        device.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (config != null) {
                        _data.writeInt(Stub.TRANSACTION_registerAppConfiguration);
                        config.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_connectChannelToSource, _data, _reply, 0);
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

            public boolean connectChannelToSink(BluetoothDevice device, BluetoothHealthAppConfiguration config, int channelType) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (device != null) {
                        _data.writeInt(Stub.TRANSACTION_registerAppConfiguration);
                        device.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (config != null) {
                        _data.writeInt(Stub.TRANSACTION_registerAppConfiguration);
                        config.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(channelType);
                    this.mRemote.transact(Stub.TRANSACTION_connectChannelToSink, _data, _reply, 0);
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

            public boolean disconnectChannel(BluetoothDevice device, BluetoothHealthAppConfiguration config, int id) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (device != null) {
                        _data.writeInt(Stub.TRANSACTION_registerAppConfiguration);
                        device.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (config != null) {
                        _data.writeInt(Stub.TRANSACTION_registerAppConfiguration);
                        config.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(id);
                    this.mRemote.transact(Stub.TRANSACTION_disconnectChannel, _data, _reply, 0);
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

            public ParcelFileDescriptor getMainChannelFd(BluetoothDevice device, BluetoothHealthAppConfiguration config) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    ParcelFileDescriptor _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (device != null) {
                        _data.writeInt(Stub.TRANSACTION_registerAppConfiguration);
                        device.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (config != null) {
                        _data.writeInt(Stub.TRANSACTION_registerAppConfiguration);
                        config.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_getMainChannelFd, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (ParcelFileDescriptor) ParcelFileDescriptor.CREATOR.createFromParcel(_reply);
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

            public List<BluetoothDevice> getConnectedHealthDevices() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getConnectedHealthDevices, _data, _reply, 0);
                    _reply.readException();
                    List<BluetoothDevice> _result = _reply.createTypedArrayList(BluetoothDevice.CREATOR);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public List<BluetoothDevice> getHealthDevicesMatchingConnectionStates(int[] states) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeIntArray(states);
                    this.mRemote.transact(Stub.TRANSACTION_getHealthDevicesMatchingConnectionStates, _data, _reply, 0);
                    _reply.readException();
                    List<BluetoothDevice> _result = _reply.createTypedArrayList(BluetoothDevice.CREATOR);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int getHealthDeviceConnectionState(BluetoothDevice device) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (device != null) {
                        _data.writeInt(Stub.TRANSACTION_registerAppConfiguration);
                        device.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_getHealthDeviceConnectionState, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static IBluetoothHealth asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IBluetoothHealth)) {
                return new Proxy(obj);
            }
            return (IBluetoothHealth) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            BluetoothHealthAppConfiguration _arg0;
            boolean _result;
            BluetoothDevice _arg02;
            BluetoothHealthAppConfiguration _arg1;
            List<BluetoothDevice> _result2;
            switch (code) {
                case TRANSACTION_registerAppConfiguration /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (BluetoothHealthAppConfiguration) BluetoothHealthAppConfiguration.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    _result = registerAppConfiguration(_arg0, android.bluetooth.IBluetoothHealthCallback.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerAppConfiguration;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_unregisterAppConfiguration /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (BluetoothHealthAppConfiguration) BluetoothHealthAppConfiguration.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    _result = unregisterAppConfiguration(_arg0);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerAppConfiguration;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_connectChannelToSource /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (BluetoothDevice) BluetoothDevice.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg1 = (BluetoothHealthAppConfiguration) BluetoothHealthAppConfiguration.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    _result = connectChannelToSource(_arg02, _arg1);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerAppConfiguration;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_connectChannelToSink /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (BluetoothDevice) BluetoothDevice.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg1 = (BluetoothHealthAppConfiguration) BluetoothHealthAppConfiguration.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    _result = connectChannelToSink(_arg02, _arg1, data.readInt());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerAppConfiguration;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_disconnectChannel /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (BluetoothDevice) BluetoothDevice.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg1 = (BluetoothHealthAppConfiguration) BluetoothHealthAppConfiguration.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    _result = disconnectChannel(_arg02, _arg1, data.readInt());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_registerAppConfiguration;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_getMainChannelFd /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (BluetoothDevice) BluetoothDevice.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg1 = (BluetoothHealthAppConfiguration) BluetoothHealthAppConfiguration.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    ParcelFileDescriptor _result3 = getMainChannelFd(_arg02, _arg1);
                    reply.writeNoException();
                    if (_result3 != null) {
                        reply.writeInt(TRANSACTION_registerAppConfiguration);
                        _result3.writeToParcel(reply, TRANSACTION_registerAppConfiguration);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_getConnectedHealthDevices /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = getConnectedHealthDevices();
                    reply.writeNoException();
                    reply.writeTypedList(_result2);
                    return true;
                case TRANSACTION_getHealthDevicesMatchingConnectionStates /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = getHealthDevicesMatchingConnectionStates(data.createIntArray());
                    reply.writeNoException();
                    reply.writeTypedList(_result2);
                    return true;
                case TRANSACTION_getHealthDeviceConnectionState /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (BluetoothDevice) BluetoothDevice.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    int _result4 = getHealthDeviceConnectionState(_arg02);
                    reply.writeNoException();
                    reply.writeInt(_result4);
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    boolean connectChannelToSink(BluetoothDevice bluetoothDevice, BluetoothHealthAppConfiguration bluetoothHealthAppConfiguration, int i) throws RemoteException;

    boolean connectChannelToSource(BluetoothDevice bluetoothDevice, BluetoothHealthAppConfiguration bluetoothHealthAppConfiguration) throws RemoteException;

    boolean disconnectChannel(BluetoothDevice bluetoothDevice, BluetoothHealthAppConfiguration bluetoothHealthAppConfiguration, int i) throws RemoteException;

    List<BluetoothDevice> getConnectedHealthDevices() throws RemoteException;

    int getHealthDeviceConnectionState(BluetoothDevice bluetoothDevice) throws RemoteException;

    List<BluetoothDevice> getHealthDevicesMatchingConnectionStates(int[] iArr) throws RemoteException;

    ParcelFileDescriptor getMainChannelFd(BluetoothDevice bluetoothDevice, BluetoothHealthAppConfiguration bluetoothHealthAppConfiguration) throws RemoteException;

    boolean registerAppConfiguration(BluetoothHealthAppConfiguration bluetoothHealthAppConfiguration, IBluetoothHealthCallback iBluetoothHealthCallback) throws RemoteException;

    boolean unregisterAppConfiguration(BluetoothHealthAppConfiguration bluetoothHealthAppConfiguration) throws RemoteException;
}
