package android.hardware.input;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import android.view.InputDevice;
import android.view.InputEvent;

public interface IInputManager extends IInterface {

    public static abstract class Stub extends Binder implements IInputManager {
        private static final String DESCRIPTOR = "android.hardware.input.IInputManager";
        static final int TRANSACTION_addKeyboardLayoutForInputDevice = 13;
        static final int TRANSACTION_cancelVibrate = 17;
        static final int TRANSACTION_getCurrentKeyboardLayoutForInputDevice = 10;
        static final int TRANSACTION_getInputDevice = 1;
        static final int TRANSACTION_getInputDeviceIds = 2;
        static final int TRANSACTION_getKeyboardLayout = 9;
        static final int TRANSACTION_getKeyboardLayouts = 8;
        static final int TRANSACTION_getKeyboardLayoutsForInputDevice = 12;
        static final int TRANSACTION_getTouchCalibrationForInputDevice = 6;
        static final int TRANSACTION_hasKeys = 3;
        static final int TRANSACTION_injectInputEvent = 5;
        static final int TRANSACTION_registerInputDevicesChangedListener = 15;
        static final int TRANSACTION_removeKeyboardLayoutForInputDevice = 14;
        static final int TRANSACTION_setCurrentKeyboardLayoutForInputDevice = 11;
        static final int TRANSACTION_setTouchCalibrationForInputDevice = 7;
        static final int TRANSACTION_tryPointerSpeed = 4;
        static final int TRANSACTION_vibrate = 16;

        private static class Proxy implements IInputManager {
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

            public InputDevice getInputDevice(int deviceId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    InputDevice _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(deviceId);
                    this.mRemote.transact(Stub.TRANSACTION_getInputDevice, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (InputDevice) InputDevice.CREATOR.createFromParcel(_reply);
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

            public int[] getInputDeviceIds() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getInputDeviceIds, _data, _reply, 0);
                    _reply.readException();
                    int[] _result = _reply.createIntArray();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean hasKeys(int deviceId, int sourceMask, int[] keyCodes, boolean[] keyExists) throws RemoteException {
                boolean z = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(deviceId);
                    _data.writeInt(sourceMask);
                    _data.writeIntArray(keyCodes);
                    if (keyExists == null) {
                        _data.writeInt(-1);
                    } else {
                        _data.writeInt(keyExists.length);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_hasKeys, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        z = true;
                    }
                    _reply.readBooleanArray(keyExists);
                    return z;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void tryPointerSpeed(int speed) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(speed);
                    this.mRemote.transact(Stub.TRANSACTION_tryPointerSpeed, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean injectInputEvent(InputEvent ev, int mode) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (ev != null) {
                        _data.writeInt(Stub.TRANSACTION_getInputDevice);
                        ev.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(mode);
                    this.mRemote.transact(Stub.TRANSACTION_injectInputEvent, _data, _reply, 0);
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

            public TouchCalibration getTouchCalibrationForInputDevice(String inputDeviceDescriptor, int rotation) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    TouchCalibration _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(inputDeviceDescriptor);
                    _data.writeInt(rotation);
                    this.mRemote.transact(Stub.TRANSACTION_getTouchCalibrationForInputDevice, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (TouchCalibration) TouchCalibration.CREATOR.createFromParcel(_reply);
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

            public void setTouchCalibrationForInputDevice(String inputDeviceDescriptor, int rotation, TouchCalibration calibration) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(inputDeviceDescriptor);
                    _data.writeInt(rotation);
                    if (calibration != null) {
                        _data.writeInt(Stub.TRANSACTION_getInputDevice);
                        calibration.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setTouchCalibrationForInputDevice, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public KeyboardLayout[] getKeyboardLayouts() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getKeyboardLayouts, _data, _reply, 0);
                    _reply.readException();
                    KeyboardLayout[] _result = (KeyboardLayout[]) _reply.createTypedArray(KeyboardLayout.CREATOR);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public KeyboardLayout getKeyboardLayout(String keyboardLayoutDescriptor) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    KeyboardLayout _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(keyboardLayoutDescriptor);
                    this.mRemote.transact(Stub.TRANSACTION_getKeyboardLayout, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (KeyboardLayout) KeyboardLayout.CREATOR.createFromParcel(_reply);
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

            public String getCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (identifier != null) {
                        _data.writeInt(Stub.TRANSACTION_getInputDevice);
                        identifier.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_getCurrentKeyboardLayoutForInputDevice, _data, _reply, 0);
                    _reply.readException();
                    String _result = _reply.readString();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier, String keyboardLayoutDescriptor) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (identifier != null) {
                        _data.writeInt(Stub.TRANSACTION_getInputDevice);
                        identifier.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(keyboardLayoutDescriptor);
                    this.mRemote.transact(Stub.TRANSACTION_setCurrentKeyboardLayoutForInputDevice, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public String[] getKeyboardLayoutsForInputDevice(InputDeviceIdentifier identifier) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (identifier != null) {
                        _data.writeInt(Stub.TRANSACTION_getInputDevice);
                        identifier.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_getKeyboardLayoutsForInputDevice, _data, _reply, 0);
                    _reply.readException();
                    String[] _result = _reply.createStringArray();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void addKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier, String keyboardLayoutDescriptor) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (identifier != null) {
                        _data.writeInt(Stub.TRANSACTION_getInputDevice);
                        identifier.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(keyboardLayoutDescriptor);
                    this.mRemote.transact(Stub.TRANSACTION_addKeyboardLayoutForInputDevice, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void removeKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier, String keyboardLayoutDescriptor) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (identifier != null) {
                        _data.writeInt(Stub.TRANSACTION_getInputDevice);
                        identifier.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(keyboardLayoutDescriptor);
                    this.mRemote.transact(Stub.TRANSACTION_removeKeyboardLayoutForInputDevice, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void registerInputDevicesChangedListener(IInputDevicesChangedListener listener) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(listener != null ? listener.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_registerInputDevicesChangedListener, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void vibrate(int deviceId, long[] pattern, int repeat, IBinder token) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(deviceId);
                    _data.writeLongArray(pattern);
                    _data.writeInt(repeat);
                    _data.writeStrongBinder(token);
                    this.mRemote.transact(Stub.TRANSACTION_vibrate, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void cancelVibrate(int deviceId, IBinder token) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(deviceId);
                    _data.writeStrongBinder(token);
                    this.mRemote.transact(Stub.TRANSACTION_cancelVibrate, _data, _reply, 0);
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

        public static IInputManager asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IInputManager)) {
                return new Proxy(obj);
            }
            return (IInputManager) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            int _arg1;
            boolean _result;
            InputDeviceIdentifier _arg0;
            switch (code) {
                case TRANSACTION_getInputDevice /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    InputDevice _result2 = getInputDevice(data.readInt());
                    reply.writeNoException();
                    if (_result2 != null) {
                        reply.writeInt(TRANSACTION_getInputDevice);
                        _result2.writeToParcel(reply, TRANSACTION_getInputDevice);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_getInputDeviceIds /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    int[] _result3 = getInputDeviceIds();
                    reply.writeNoException();
                    reply.writeIntArray(_result3);
                    return true;
                case TRANSACTION_hasKeys /*3*/:
                    boolean[] _arg3;
                    data.enforceInterface(DESCRIPTOR);
                    int _arg02 = data.readInt();
                    _arg1 = data.readInt();
                    int[] _arg2 = data.createIntArray();
                    int _arg3_length = data.readInt();
                    if (_arg3_length < 0) {
                        _arg3 = null;
                    } else {
                        _arg3 = new boolean[_arg3_length];
                    }
                    _result = hasKeys(_arg02, _arg1, _arg2, _arg3);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getInputDevice;
                    }
                    reply.writeInt(i);
                    reply.writeBooleanArray(_arg3);
                    return true;
                case TRANSACTION_tryPointerSpeed /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    tryPointerSpeed(data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_injectInputEvent /*5*/:
                    InputEvent _arg03;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg03 = (InputEvent) InputEvent.CREATOR.createFromParcel(data);
                    } else {
                        _arg03 = null;
                    }
                    _result = injectInputEvent(_arg03, data.readInt());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getInputDevice;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_getTouchCalibrationForInputDevice /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    TouchCalibration _result4 = getTouchCalibrationForInputDevice(data.readString(), data.readInt());
                    reply.writeNoException();
                    if (_result4 != null) {
                        reply.writeInt(TRANSACTION_getInputDevice);
                        _result4.writeToParcel(reply, TRANSACTION_getInputDevice);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_setTouchCalibrationForInputDevice /*7*/:
                    TouchCalibration _arg22;
                    data.enforceInterface(DESCRIPTOR);
                    String _arg04 = data.readString();
                    _arg1 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg22 = (TouchCalibration) TouchCalibration.CREATOR.createFromParcel(data);
                    } else {
                        _arg22 = null;
                    }
                    setTouchCalibrationForInputDevice(_arg04, _arg1, _arg22);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_getKeyboardLayouts /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    KeyboardLayout[] _result5 = getKeyboardLayouts();
                    reply.writeNoException();
                    reply.writeTypedArray(_result5, TRANSACTION_getInputDevice);
                    return true;
                case TRANSACTION_getKeyboardLayout /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    KeyboardLayout _result6 = getKeyboardLayout(data.readString());
                    reply.writeNoException();
                    if (_result6 != null) {
                        reply.writeInt(TRANSACTION_getInputDevice);
                        _result6.writeToParcel(reply, TRANSACTION_getInputDevice);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_getCurrentKeyboardLayoutForInputDevice /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (InputDeviceIdentifier) InputDeviceIdentifier.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    String _result7 = getCurrentKeyboardLayoutForInputDevice(_arg0);
                    reply.writeNoException();
                    reply.writeString(_result7);
                    return true;
                case TRANSACTION_setCurrentKeyboardLayoutForInputDevice /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (InputDeviceIdentifier) InputDeviceIdentifier.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    setCurrentKeyboardLayoutForInputDevice(_arg0, data.readString());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_getKeyboardLayoutsForInputDevice /*12*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (InputDeviceIdentifier) InputDeviceIdentifier.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    String[] _result8 = getKeyboardLayoutsForInputDevice(_arg0);
                    reply.writeNoException();
                    reply.writeStringArray(_result8);
                    return true;
                case TRANSACTION_addKeyboardLayoutForInputDevice /*13*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (InputDeviceIdentifier) InputDeviceIdentifier.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    addKeyboardLayoutForInputDevice(_arg0, data.readString());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_removeKeyboardLayoutForInputDevice /*14*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (InputDeviceIdentifier) InputDeviceIdentifier.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    removeKeyboardLayoutForInputDevice(_arg0, data.readString());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_registerInputDevicesChangedListener /*15*/:
                    data.enforceInterface(DESCRIPTOR);
                    registerInputDevicesChangedListener(android.hardware.input.IInputDevicesChangedListener.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    return true;
                case TRANSACTION_vibrate /*16*/:
                    data.enforceInterface(DESCRIPTOR);
                    vibrate(data.readInt(), data.createLongArray(), data.readInt(), data.readStrongBinder());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_cancelVibrate /*17*/:
                    data.enforceInterface(DESCRIPTOR);
                    cancelVibrate(data.readInt(), data.readStrongBinder());
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

    void addKeyboardLayoutForInputDevice(InputDeviceIdentifier inputDeviceIdentifier, String str) throws RemoteException;

    void cancelVibrate(int i, IBinder iBinder) throws RemoteException;

    String getCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier inputDeviceIdentifier) throws RemoteException;

    InputDevice getInputDevice(int i) throws RemoteException;

    int[] getInputDeviceIds() throws RemoteException;

    KeyboardLayout getKeyboardLayout(String str) throws RemoteException;

    KeyboardLayout[] getKeyboardLayouts() throws RemoteException;

    String[] getKeyboardLayoutsForInputDevice(InputDeviceIdentifier inputDeviceIdentifier) throws RemoteException;

    TouchCalibration getTouchCalibrationForInputDevice(String str, int i) throws RemoteException;

    boolean hasKeys(int i, int i2, int[] iArr, boolean[] zArr) throws RemoteException;

    boolean injectInputEvent(InputEvent inputEvent, int i) throws RemoteException;

    void registerInputDevicesChangedListener(IInputDevicesChangedListener iInputDevicesChangedListener) throws RemoteException;

    void removeKeyboardLayoutForInputDevice(InputDeviceIdentifier inputDeviceIdentifier, String str) throws RemoteException;

    void setCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier inputDeviceIdentifier, String str) throws RemoteException;

    void setTouchCalibrationForInputDevice(String str, int i, TouchCalibration touchCalibration) throws RemoteException;

    void tryPointerSpeed(int i) throws RemoteException;

    void vibrate(int i, long[] jArr, int i2, IBinder iBinder) throws RemoteException;
}
