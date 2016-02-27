package android.speech.tts;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface ITextToSpeechCallback extends IInterface {

    public static abstract class Stub extends Binder implements ITextToSpeechCallback {
        private static final String DESCRIPTOR = "android.speech.tts.ITextToSpeechCallback";
        static final int TRANSACTION_onError = 4;
        static final int TRANSACTION_onStart = 1;
        static final int TRANSACTION_onStop = 3;
        static final int TRANSACTION_onSuccess = 2;

        private static class Proxy implements ITextToSpeechCallback {
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

            public void onStart(String utteranceId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(utteranceId);
                    this.mRemote.transact(Stub.TRANSACTION_onStart, _data, null, Stub.TRANSACTION_onStart);
                } finally {
                    _data.recycle();
                }
            }

            public void onSuccess(String utteranceId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(utteranceId);
                    this.mRemote.transact(Stub.TRANSACTION_onSuccess, _data, null, Stub.TRANSACTION_onStart);
                } finally {
                    _data.recycle();
                }
            }

            public void onStop(String utteranceId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(utteranceId);
                    this.mRemote.transact(Stub.TRANSACTION_onStop, _data, null, Stub.TRANSACTION_onStart);
                } finally {
                    _data.recycle();
                }
            }

            public void onError(String utteranceId, int errorCode) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(utteranceId);
                    _data.writeInt(errorCode);
                    this.mRemote.transact(Stub.TRANSACTION_onError, _data, null, Stub.TRANSACTION_onStart);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static ITextToSpeechCallback asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof ITextToSpeechCallback)) {
                return new Proxy(obj);
            }
            return (ITextToSpeechCallback) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_onStart /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    onStart(data.readString());
                    return true;
                case TRANSACTION_onSuccess /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onSuccess(data.readString());
                    return true;
                case TRANSACTION_onStop /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    onStop(data.readString());
                    return true;
                case TRANSACTION_onError /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    onError(data.readString(), data.readInt());
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void onError(String str, int i) throws RemoteException;

    void onStart(String str) throws RemoteException;

    void onStop(String str) throws RemoteException;

    void onSuccess(String str) throws RemoteException;
}
