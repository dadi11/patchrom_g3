package com.android.internal.telephony;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import com.android.internal.telephony.uicc.AdnRecord;
import java.util.List;

public interface IIccPhoneBook extends IInterface {

    public static abstract class Stub extends Binder implements IIccPhoneBook {
        private static final String DESCRIPTOR = "com.android.internal.telephony.IIccPhoneBook";
        static final int TRANSACTION_getAdnRecordsInEf = 1;
        static final int TRANSACTION_getAdnRecordsInEfForSubscriber = 2;
        static final int TRANSACTION_getAdnRecordsSize = 7;
        static final int TRANSACTION_getAdnRecordsSizeForSubscriber = 8;
        static final int TRANSACTION_updateAdnRecordsInEfByIndex = 5;
        static final int TRANSACTION_updateAdnRecordsInEfByIndexForSubscriber = 6;
        static final int TRANSACTION_updateAdnRecordsInEfBySearch = 3;
        static final int TRANSACTION_updateAdnRecordsInEfBySearchForSubscriber = 4;

        private static class Proxy implements IIccPhoneBook {
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

            public List<AdnRecord> getAdnRecordsInEf(int efid) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(efid);
                    this.mRemote.transact(Stub.TRANSACTION_getAdnRecordsInEf, _data, _reply, 0);
                    _reply.readException();
                    List<AdnRecord> _result = _reply.createTypedArrayList(AdnRecord.CREATOR);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public List<AdnRecord> getAdnRecordsInEfForSubscriber(int subId, int efid) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(subId);
                    _data.writeInt(efid);
                    this.mRemote.transact(Stub.TRANSACTION_getAdnRecordsInEfForSubscriber, _data, _reply, 0);
                    _reply.readException();
                    List<AdnRecord> _result = _reply.createTypedArrayList(AdnRecord.CREATOR);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean updateAdnRecordsInEfBySearch(int efid, String oldTag, String oldPhoneNumber, String newTag, String newPhoneNumber, String pin2) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(efid);
                    _data.writeString(oldTag);
                    _data.writeString(oldPhoneNumber);
                    _data.writeString(newTag);
                    _data.writeString(newPhoneNumber);
                    _data.writeString(pin2);
                    this.mRemote.transact(Stub.TRANSACTION_updateAdnRecordsInEfBySearch, _data, _reply, 0);
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

            public boolean updateAdnRecordsInEfBySearchForSubscriber(int subId, int efid, String oldTag, String oldPhoneNumber, String newTag, String newPhoneNumber, String pin2) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(subId);
                    _data.writeInt(efid);
                    _data.writeString(oldTag);
                    _data.writeString(oldPhoneNumber);
                    _data.writeString(newTag);
                    _data.writeString(newPhoneNumber);
                    _data.writeString(pin2);
                    this.mRemote.transact(Stub.TRANSACTION_updateAdnRecordsInEfBySearchForSubscriber, _data, _reply, 0);
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

            public boolean updateAdnRecordsInEfByIndex(int efid, String newTag, String newPhoneNumber, int index, String pin2) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(efid);
                    _data.writeString(newTag);
                    _data.writeString(newPhoneNumber);
                    _data.writeInt(index);
                    _data.writeString(pin2);
                    this.mRemote.transact(Stub.TRANSACTION_updateAdnRecordsInEfByIndex, _data, _reply, 0);
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

            public boolean updateAdnRecordsInEfByIndexForSubscriber(int subId, int efid, String newTag, String newPhoneNumber, int index, String pin2) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(subId);
                    _data.writeInt(efid);
                    _data.writeString(newTag);
                    _data.writeString(newPhoneNumber);
                    _data.writeInt(index);
                    _data.writeString(pin2);
                    this.mRemote.transact(Stub.TRANSACTION_updateAdnRecordsInEfByIndexForSubscriber, _data, _reply, 0);
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

            public int[] getAdnRecordsSize(int efid) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(efid);
                    this.mRemote.transact(Stub.TRANSACTION_getAdnRecordsSize, _data, _reply, 0);
                    _reply.readException();
                    int[] _result = _reply.createIntArray();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int[] getAdnRecordsSizeForSubscriber(int subId, int efid) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(subId);
                    _data.writeInt(efid);
                    this.mRemote.transact(Stub.TRANSACTION_getAdnRecordsSizeForSubscriber, _data, _reply, 0);
                    _reply.readException();
                    int[] _result = _reply.createIntArray();
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

        public static IIccPhoneBook asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IIccPhoneBook)) {
                return new Proxy(obj);
            }
            return (IIccPhoneBook) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            List<AdnRecord> _result;
            boolean _result2;
            int[] _result3;
            switch (code) {
                case TRANSACTION_getAdnRecordsInEf /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = getAdnRecordsInEf(data.readInt());
                    reply.writeNoException();
                    reply.writeTypedList(_result);
                    return true;
                case TRANSACTION_getAdnRecordsInEfForSubscriber /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = getAdnRecordsInEfForSubscriber(data.readInt(), data.readInt());
                    reply.writeNoException();
                    reply.writeTypedList(_result);
                    return true;
                case TRANSACTION_updateAdnRecordsInEfBySearch /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = updateAdnRecordsInEfBySearch(data.readInt(), data.readString(), data.readString(), data.readString(), data.readString(), data.readString());
                    reply.writeNoException();
                    reply.writeInt(_result2 ? TRANSACTION_getAdnRecordsInEf : 0);
                    return true;
                case TRANSACTION_updateAdnRecordsInEfBySearchForSubscriber /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = updateAdnRecordsInEfBySearchForSubscriber(data.readInt(), data.readInt(), data.readString(), data.readString(), data.readString(), data.readString(), data.readString());
                    reply.writeNoException();
                    reply.writeInt(_result2 ? TRANSACTION_getAdnRecordsInEf : 0);
                    return true;
                case TRANSACTION_updateAdnRecordsInEfByIndex /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = updateAdnRecordsInEfByIndex(data.readInt(), data.readString(), data.readString(), data.readInt(), data.readString());
                    reply.writeNoException();
                    reply.writeInt(_result2 ? TRANSACTION_getAdnRecordsInEf : 0);
                    return true;
                case TRANSACTION_updateAdnRecordsInEfByIndexForSubscriber /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result2 = updateAdnRecordsInEfByIndexForSubscriber(data.readInt(), data.readInt(), data.readString(), data.readString(), data.readInt(), data.readString());
                    reply.writeNoException();
                    reply.writeInt(_result2 ? TRANSACTION_getAdnRecordsInEf : 0);
                    return true;
                case TRANSACTION_getAdnRecordsSize /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result3 = getAdnRecordsSize(data.readInt());
                    reply.writeNoException();
                    reply.writeIntArray(_result3);
                    return true;
                case TRANSACTION_getAdnRecordsSizeForSubscriber /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result3 = getAdnRecordsSizeForSubscriber(data.readInt(), data.readInt());
                    reply.writeNoException();
                    reply.writeIntArray(_result3);
                    return true;
                case 1598968902:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    List<AdnRecord> getAdnRecordsInEf(int i) throws RemoteException;

    List<AdnRecord> getAdnRecordsInEfForSubscriber(int i, int i2) throws RemoteException;

    int[] getAdnRecordsSize(int i) throws RemoteException;

    int[] getAdnRecordsSizeForSubscriber(int i, int i2) throws RemoteException;

    boolean updateAdnRecordsInEfByIndex(int i, String str, String str2, int i2, String str3) throws RemoteException;

    boolean updateAdnRecordsInEfByIndexForSubscriber(int i, int i2, String str, String str2, int i3, String str3) throws RemoteException;

    boolean updateAdnRecordsInEfBySearch(int i, String str, String str2, String str3, String str4, String str5) throws RemoteException;

    boolean updateAdnRecordsInEfBySearchForSubscriber(int i, int i2, String str, String str2, String str3, String str4, String str5) throws RemoteException;
}
