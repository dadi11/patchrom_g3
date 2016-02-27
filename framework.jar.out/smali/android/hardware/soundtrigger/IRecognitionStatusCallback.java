package android.hardware.soundtrigger;

import android.hardware.soundtrigger.SoundTrigger.KeyphraseRecognitionEvent;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IRecognitionStatusCallback extends IInterface {

    public static abstract class Stub extends Binder implements IRecognitionStatusCallback {
        private static final String DESCRIPTOR = "android.hardware.soundtrigger.IRecognitionStatusCallback";
        static final int TRANSACTION_onDetected = 1;
        static final int TRANSACTION_onError = 2;
        static final int TRANSACTION_onRecognitionPaused = 3;
        static final int TRANSACTION_onRecognitionResumed = 4;

        private static class Proxy implements IRecognitionStatusCallback {
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

            public void onDetected(KeyphraseRecognitionEvent recognitionEvent) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (recognitionEvent != null) {
                        _data.writeInt(Stub.TRANSACTION_onDetected);
                        recognitionEvent.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onDetected, _data, null, Stub.TRANSACTION_onDetected);
                } finally {
                    _data.recycle();
                }
            }

            public void onError(int status) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(status);
                    this.mRemote.transact(Stub.TRANSACTION_onError, _data, null, Stub.TRANSACTION_onDetected);
                } finally {
                    _data.recycle();
                }
            }

            public void onRecognitionPaused() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_onRecognitionPaused, _data, null, Stub.TRANSACTION_onDetected);
                } finally {
                    _data.recycle();
                }
            }

            public void onRecognitionResumed() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_onRecognitionResumed, _data, null, Stub.TRANSACTION_onDetected);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static IRecognitionStatusCallback asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IRecognitionStatusCallback)) {
                return new Proxy(obj);
            }
            return (IRecognitionStatusCallback) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_onDetected /*1*/:
                    KeyphraseRecognitionEvent _arg0;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (KeyphraseRecognitionEvent) KeyphraseRecognitionEvent.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    onDetected(_arg0);
                    return true;
                case TRANSACTION_onError /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onError(data.readInt());
                    return true;
                case TRANSACTION_onRecognitionPaused /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    onRecognitionPaused();
                    return true;
                case TRANSACTION_onRecognitionResumed /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    onRecognitionResumed();
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void onDetected(KeyphraseRecognitionEvent keyphraseRecognitionEvent) throws RemoteException;

    void onError(int i) throws RemoteException;

    void onRecognitionPaused() throws RemoteException;

    void onRecognitionResumed() throws RemoteException;
}
