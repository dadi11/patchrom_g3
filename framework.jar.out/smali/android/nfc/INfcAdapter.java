package android.nfc;

import android.app.PendingIntent;
import android.content.IntentFilter;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface INfcAdapter extends IInterface {

    public static abstract class Stub extends Binder implements INfcAdapter {
        private static final String DESCRIPTOR = "android.nfc.INfcAdapter";
        static final int TRANSACTION_addNfcUnlockHandler = 19;
        static final int TRANSACTION_disable = 5;
        static final int TRANSACTION_disableNdefPush = 8;
        static final int TRANSACTION_dispatch = 16;
        static final int TRANSACTION_enable = 6;
        static final int TRANSACTION_enableNdefPush = 7;
        static final int TRANSACTION_getNfcAdapterExtrasInterface = 3;
        static final int TRANSACTION_getNfcCardEmulationInterface = 2;
        static final int TRANSACTION_getNfcTagInterface = 1;
        static final int TRANSACTION_getState = 4;
        static final int TRANSACTION_invokeBeam = 14;
        static final int TRANSACTION_invokeBeamInternal = 15;
        static final int TRANSACTION_isNdefPushEnabled = 9;
        static final int TRANSACTION_pausePolling = 10;
        static final int TRANSACTION_removeNfcUnlockHandler = 20;
        static final int TRANSACTION_resumePolling = 11;
        static final int TRANSACTION_setAppCallback = 13;
        static final int TRANSACTION_setForegroundDispatch = 12;
        static final int TRANSACTION_setP2pModes = 18;
        static final int TRANSACTION_setReaderMode = 17;
        static final int TRANSACTION_verifyNfcPermission = 21;

        private static class Proxy implements INfcAdapter {
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

            public INfcTag getNfcTagInterface() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getNfcTagInterface, _data, _reply, 0);
                    _reply.readException();
                    INfcTag _result = android.nfc.INfcTag.Stub.asInterface(_reply.readStrongBinder());
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public INfcCardEmulation getNfcCardEmulationInterface() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getNfcCardEmulationInterface, _data, _reply, 0);
                    _reply.readException();
                    INfcCardEmulation _result = android.nfc.INfcCardEmulation.Stub.asInterface(_reply.readStrongBinder());
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public INfcAdapterExtras getNfcAdapterExtrasInterface(String pkg) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(pkg);
                    this.mRemote.transact(Stub.TRANSACTION_getNfcAdapterExtrasInterface, _data, _reply, 0);
                    _reply.readException();
                    INfcAdapterExtras _result = android.nfc.INfcAdapterExtras.Stub.asInterface(_reply.readStrongBinder());
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int getState() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getState, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean disable(boolean saveState) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    int i;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (saveState) {
                        i = Stub.TRANSACTION_getNfcTagInterface;
                    } else {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_disable, _data, _reply, 0);
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

            public boolean enable() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_enable, _data, _reply, 0);
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

            public boolean enableNdefPush() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_enableNdefPush, _data, _reply, 0);
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

            public boolean disableNdefPush() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_disableNdefPush, _data, _reply, 0);
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

            public boolean isNdefPushEnabled() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_isNdefPushEnabled, _data, _reply, 0);
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

            public void pausePolling(int timeoutInMs) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(timeoutInMs);
                    this.mRemote.transact(Stub.TRANSACTION_pausePolling, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void resumePolling() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_resumePolling, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setForegroundDispatch(PendingIntent intent, IntentFilter[] filters, TechListParcel techLists) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (intent != null) {
                        _data.writeInt(Stub.TRANSACTION_getNfcTagInterface);
                        intent.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeTypedArray(filters, 0);
                    if (techLists != null) {
                        _data.writeInt(Stub.TRANSACTION_getNfcTagInterface);
                        techLists.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setForegroundDispatch, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setAppCallback(IAppCallback callback) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(callback != null ? callback.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_setAppCallback, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void invokeBeam() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_invokeBeam, _data, null, Stub.TRANSACTION_getNfcTagInterface);
                } finally {
                    _data.recycle();
                }
            }

            public void invokeBeamInternal(BeamShareData shareData) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (shareData != null) {
                        _data.writeInt(Stub.TRANSACTION_getNfcTagInterface);
                        shareData.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_invokeBeamInternal, _data, null, Stub.TRANSACTION_getNfcTagInterface);
                } finally {
                    _data.recycle();
                }
            }

            public void dispatch(Tag tag) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (tag != null) {
                        _data.writeInt(Stub.TRANSACTION_getNfcTagInterface);
                        tag.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_dispatch, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setReaderMode(IBinder b, IAppCallback callback, int flags, Bundle extras) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(b);
                    _data.writeStrongBinder(callback != null ? callback.asBinder() : null);
                    _data.writeInt(flags);
                    if (extras != null) {
                        _data.writeInt(Stub.TRANSACTION_getNfcTagInterface);
                        extras.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setReaderMode, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setP2pModes(int initatorModes, int targetModes) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(initatorModes);
                    _data.writeInt(targetModes);
                    this.mRemote.transact(Stub.TRANSACTION_setP2pModes, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void addNfcUnlockHandler(INfcUnlockHandler unlockHandler, int[] techList) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(unlockHandler != null ? unlockHandler.asBinder() : null);
                    _data.writeIntArray(techList);
                    this.mRemote.transact(Stub.TRANSACTION_addNfcUnlockHandler, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void removeNfcUnlockHandler(INfcUnlockHandler unlockHandler) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(unlockHandler != null ? unlockHandler.asBinder() : null);
                    this.mRemote.transact(Stub.TRANSACTION_removeNfcUnlockHandler, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void verifyNfcPermission() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_verifyNfcPermission, _data, _reply, 0);
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

        public static INfcAdapter asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof INfcAdapter)) {
                return new Proxy(obj);
            }
            return (INfcAdapter) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            IBinder iBinder = null;
            int i = 0;
            boolean _result;
            switch (code) {
                case TRANSACTION_getNfcTagInterface /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    INfcTag _result2 = getNfcTagInterface();
                    reply.writeNoException();
                    if (_result2 != null) {
                        iBinder = _result2.asBinder();
                    }
                    reply.writeStrongBinder(iBinder);
                    return true;
                case TRANSACTION_getNfcCardEmulationInterface /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    INfcCardEmulation _result3 = getNfcCardEmulationInterface();
                    reply.writeNoException();
                    if (_result3 != null) {
                        iBinder = _result3.asBinder();
                    }
                    reply.writeStrongBinder(iBinder);
                    return true;
                case TRANSACTION_getNfcAdapterExtrasInterface /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    INfcAdapterExtras _result4 = getNfcAdapterExtrasInterface(data.readString());
                    reply.writeNoException();
                    if (_result4 != null) {
                        iBinder = _result4.asBinder();
                    }
                    reply.writeStrongBinder(iBinder);
                    return true;
                case TRANSACTION_getState /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    int _result5 = getState();
                    reply.writeNoException();
                    reply.writeInt(_result5);
                    return true;
                case TRANSACTION_disable /*5*/:
                    boolean _arg0;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = true;
                    } else {
                        _arg0 = false;
                    }
                    _result = disable(_arg0);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getNfcTagInterface;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_enable /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = enable();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getNfcTagInterface;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_enableNdefPush /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = enableNdefPush();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getNfcTagInterface;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_disableNdefPush /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = disableNdefPush();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getNfcTagInterface;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_isNdefPushEnabled /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = isNdefPushEnabled();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_getNfcTagInterface;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_pausePolling /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    pausePolling(data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_resumePolling /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    resumePolling();
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setForegroundDispatch /*12*/:
                    PendingIntent _arg02;
                    TechListParcel _arg2;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (PendingIntent) PendingIntent.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    IntentFilter[] _arg1 = (IntentFilter[]) data.createTypedArray(IntentFilter.CREATOR);
                    if (data.readInt() != 0) {
                        _arg2 = (TechListParcel) TechListParcel.CREATOR.createFromParcel(data);
                    } else {
                        _arg2 = null;
                    }
                    setForegroundDispatch(_arg02, _arg1, _arg2);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setAppCallback /*13*/:
                    data.enforceInterface(DESCRIPTOR);
                    setAppCallback(android.nfc.IAppCallback.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    return true;
                case TRANSACTION_invokeBeam /*14*/:
                    data.enforceInterface(DESCRIPTOR);
                    invokeBeam();
                    return true;
                case TRANSACTION_invokeBeamInternal /*15*/:
                    BeamShareData _arg03;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg03 = (BeamShareData) BeamShareData.CREATOR.createFromParcel(data);
                    } else {
                        _arg03 = null;
                    }
                    invokeBeamInternal(_arg03);
                    return true;
                case TRANSACTION_dispatch /*16*/:
                    Tag _arg04;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg04 = (Tag) Tag.CREATOR.createFromParcel(data);
                    } else {
                        _arg04 = null;
                    }
                    dispatch(_arg04);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setReaderMode /*17*/:
                    Bundle _arg3;
                    data.enforceInterface(DESCRIPTOR);
                    IBinder _arg05 = data.readStrongBinder();
                    IAppCallback _arg12 = android.nfc.IAppCallback.Stub.asInterface(data.readStrongBinder());
                    int _arg22 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg3 = (Bundle) Bundle.CREATOR.createFromParcel(data);
                    } else {
                        _arg3 = null;
                    }
                    setReaderMode(_arg05, _arg12, _arg22, _arg3);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setP2pModes /*18*/:
                    data.enforceInterface(DESCRIPTOR);
                    setP2pModes(data.readInt(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_addNfcUnlockHandler /*19*/:
                    data.enforceInterface(DESCRIPTOR);
                    addNfcUnlockHandler(android.nfc.INfcUnlockHandler.Stub.asInterface(data.readStrongBinder()), data.createIntArray());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_removeNfcUnlockHandler /*20*/:
                    data.enforceInterface(DESCRIPTOR);
                    removeNfcUnlockHandler(android.nfc.INfcUnlockHandler.Stub.asInterface(data.readStrongBinder()));
                    reply.writeNoException();
                    return true;
                case TRANSACTION_verifyNfcPermission /*21*/:
                    data.enforceInterface(DESCRIPTOR);
                    verifyNfcPermission();
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

    void addNfcUnlockHandler(INfcUnlockHandler iNfcUnlockHandler, int[] iArr) throws RemoteException;

    boolean disable(boolean z) throws RemoteException;

    boolean disableNdefPush() throws RemoteException;

    void dispatch(Tag tag) throws RemoteException;

    boolean enable() throws RemoteException;

    boolean enableNdefPush() throws RemoteException;

    INfcAdapterExtras getNfcAdapterExtrasInterface(String str) throws RemoteException;

    INfcCardEmulation getNfcCardEmulationInterface() throws RemoteException;

    INfcTag getNfcTagInterface() throws RemoteException;

    int getState() throws RemoteException;

    void invokeBeam() throws RemoteException;

    void invokeBeamInternal(BeamShareData beamShareData) throws RemoteException;

    boolean isNdefPushEnabled() throws RemoteException;

    void pausePolling(int i) throws RemoteException;

    void removeNfcUnlockHandler(INfcUnlockHandler iNfcUnlockHandler) throws RemoteException;

    void resumePolling() throws RemoteException;

    void setAppCallback(IAppCallback iAppCallback) throws RemoteException;

    void setForegroundDispatch(PendingIntent pendingIntent, IntentFilter[] intentFilterArr, TechListParcel techListParcel) throws RemoteException;

    void setP2pModes(int i, int i2) throws RemoteException;

    void setReaderMode(IBinder iBinder, IAppCallback iAppCallback, int i, Bundle bundle) throws RemoteException;

    void verifyNfcPermission() throws RemoteException;
}
