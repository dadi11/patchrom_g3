package android.nfc;

import android.content.ComponentName;
import android.nfc.cardemulation.AidGroup;
import android.nfc.cardemulation.ApduServiceInfo;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import java.util.List;

public interface INfcCardEmulation extends IInterface {

    public static abstract class Stub extends Binder implements INfcCardEmulation {
        private static final String DESCRIPTOR = "android.nfc.INfcCardEmulation";
        static final int TRANSACTION_getAidGroupForService = 6;
        static final int TRANSACTION_getServices = 8;
        static final int TRANSACTION_isDefaultServiceForAid = 2;
        static final int TRANSACTION_isDefaultServiceForCategory = 1;
        static final int TRANSACTION_registerAidGroupForService = 5;
        static final int TRANSACTION_removeAidGroupForService = 7;
        static final int TRANSACTION_setDefaultForNextTap = 4;
        static final int TRANSACTION_setDefaultServiceForCategory = 3;
        static final int TRANSACTION_setPreferredService = 9;
        static final int TRANSACTION_supportsAidPrefixRegistration = 11;
        static final int TRANSACTION_unsetPreferredService = 10;

        private static class Proxy implements INfcCardEmulation {
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

            public boolean isDefaultServiceForCategory(int userHandle, ComponentName service, String category) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userHandle);
                    if (service != null) {
                        _data.writeInt(Stub.TRANSACTION_isDefaultServiceForCategory);
                        service.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(category);
                    this.mRemote.transact(Stub.TRANSACTION_isDefaultServiceForCategory, _data, _reply, 0);
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

            public boolean isDefaultServiceForAid(int userHandle, ComponentName service, String aid) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userHandle);
                    if (service != null) {
                        _data.writeInt(Stub.TRANSACTION_isDefaultServiceForCategory);
                        service.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(aid);
                    this.mRemote.transact(Stub.TRANSACTION_isDefaultServiceForAid, _data, _reply, 0);
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

            public boolean setDefaultServiceForCategory(int userHandle, ComponentName service, String category) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userHandle);
                    if (service != null) {
                        _data.writeInt(Stub.TRANSACTION_isDefaultServiceForCategory);
                        service.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(category);
                    this.mRemote.transact(Stub.TRANSACTION_setDefaultServiceForCategory, _data, _reply, 0);
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

            public boolean setDefaultForNextTap(int userHandle, ComponentName service) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userHandle);
                    if (service != null) {
                        _data.writeInt(Stub.TRANSACTION_isDefaultServiceForCategory);
                        service.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setDefaultForNextTap, _data, _reply, 0);
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

            public boolean registerAidGroupForService(int userHandle, ComponentName service, AidGroup aidGroup) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userHandle);
                    if (service != null) {
                        _data.writeInt(Stub.TRANSACTION_isDefaultServiceForCategory);
                        service.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (aidGroup != null) {
                        _data.writeInt(Stub.TRANSACTION_isDefaultServiceForCategory);
                        aidGroup.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_registerAidGroupForService, _data, _reply, 0);
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

            public AidGroup getAidGroupForService(int userHandle, ComponentName service, String category) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    AidGroup _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userHandle);
                    if (service != null) {
                        _data.writeInt(Stub.TRANSACTION_isDefaultServiceForCategory);
                        service.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(category);
                    this.mRemote.transact(Stub.TRANSACTION_getAidGroupForService, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (AidGroup) AidGroup.CREATOR.createFromParcel(_reply);
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

            public boolean removeAidGroupForService(int userHandle, ComponentName service, String category) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userHandle);
                    if (service != null) {
                        _data.writeInt(Stub.TRANSACTION_isDefaultServiceForCategory);
                        service.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeString(category);
                    this.mRemote.transact(Stub.TRANSACTION_removeAidGroupForService, _data, _reply, 0);
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

            public List<ApduServiceInfo> getServices(int userHandle, String category) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userHandle);
                    _data.writeString(category);
                    this.mRemote.transact(Stub.TRANSACTION_getServices, _data, _reply, 0);
                    _reply.readException();
                    List<ApduServiceInfo> _result = _reply.createTypedArrayList(ApduServiceInfo.CREATOR);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean setPreferredService(ComponentName service) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (service != null) {
                        _data.writeInt(Stub.TRANSACTION_isDefaultServiceForCategory);
                        service.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setPreferredService, _data, _reply, 0);
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

            public boolean unsetPreferredService() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_unsetPreferredService, _data, _reply, 0);
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

            public boolean supportsAidPrefixRegistration() throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_supportsAidPrefixRegistration, _data, _reply, 0);
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

        public static INfcCardEmulation asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof INfcCardEmulation)) {
                return new Proxy(obj);
            }
            return (INfcCardEmulation) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            int _arg0;
            ComponentName _arg1;
            boolean _result;
            switch (code) {
                case TRANSACTION_isDefaultServiceForCategory /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg1 = (ComponentName) ComponentName.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    _result = isDefaultServiceForCategory(_arg0, _arg1, data.readString());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_isDefaultServiceForCategory;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_isDefaultServiceForAid /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg1 = (ComponentName) ComponentName.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    _result = isDefaultServiceForAid(_arg0, _arg1, data.readString());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_isDefaultServiceForCategory;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_setDefaultServiceForCategory /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg1 = (ComponentName) ComponentName.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    _result = setDefaultServiceForCategory(_arg0, _arg1, data.readString());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_isDefaultServiceForCategory;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_setDefaultForNextTap /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg1 = (ComponentName) ComponentName.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    _result = setDefaultForNextTap(_arg0, _arg1);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_isDefaultServiceForCategory;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_registerAidGroupForService /*5*/:
                    AidGroup _arg2;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg1 = (ComponentName) ComponentName.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg2 = (AidGroup) AidGroup.CREATOR.createFromParcel(data);
                    } else {
                        _arg2 = null;
                    }
                    _result = registerAidGroupForService(_arg0, _arg1, _arg2);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_isDefaultServiceForCategory;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_getAidGroupForService /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg1 = (ComponentName) ComponentName.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    AidGroup _result2 = getAidGroupForService(_arg0, _arg1, data.readString());
                    reply.writeNoException();
                    if (_result2 != null) {
                        reply.writeInt(TRANSACTION_isDefaultServiceForCategory);
                        _result2.writeToParcel(reply, TRANSACTION_isDefaultServiceForCategory);
                        return true;
                    }
                    reply.writeInt(0);
                    return true;
                case TRANSACTION_removeAidGroupForService /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readInt();
                    if (data.readInt() != 0) {
                        _arg1 = (ComponentName) ComponentName.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    _result = removeAidGroupForService(_arg0, _arg1, data.readString());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_isDefaultServiceForCategory;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_getServices /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    List<ApduServiceInfo> _result3 = getServices(data.readInt(), data.readString());
                    reply.writeNoException();
                    reply.writeTypedList(_result3);
                    return true;
                case TRANSACTION_setPreferredService /*9*/:
                    ComponentName _arg02;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (ComponentName) ComponentName.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    _result = setPreferredService(_arg02);
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_isDefaultServiceForCategory;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_unsetPreferredService /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = unsetPreferredService();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_isDefaultServiceForCategory;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_supportsAidPrefixRegistration /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = supportsAidPrefixRegistration();
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_isDefaultServiceForCategory;
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

    AidGroup getAidGroupForService(int i, ComponentName componentName, String str) throws RemoteException;

    List<ApduServiceInfo> getServices(int i, String str) throws RemoteException;

    boolean isDefaultServiceForAid(int i, ComponentName componentName, String str) throws RemoteException;

    boolean isDefaultServiceForCategory(int i, ComponentName componentName, String str) throws RemoteException;

    boolean registerAidGroupForService(int i, ComponentName componentName, AidGroup aidGroup) throws RemoteException;

    boolean removeAidGroupForService(int i, ComponentName componentName, String str) throws RemoteException;

    boolean setDefaultForNextTap(int i, ComponentName componentName) throws RemoteException;

    boolean setDefaultServiceForCategory(int i, ComponentName componentName, String str) throws RemoteException;

    boolean setPreferredService(ComponentName componentName) throws RemoteException;

    boolean supportsAidPrefixRegistration() throws RemoteException;

    boolean unsetPreferredService() throws RemoteException;
}
