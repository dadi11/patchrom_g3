package android.service.voice;

import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IVoiceInteractionSession extends IInterface {

    public static abstract class Stub extends Binder implements IVoiceInteractionSession {
        private static final String DESCRIPTOR = "android.service.voice.IVoiceInteractionSession";
        static final int TRANSACTION_closeSystemDialogs = 3;
        static final int TRANSACTION_destroy = 4;
        static final int TRANSACTION_taskFinished = 2;
        static final int TRANSACTION_taskStarted = 1;

        private static class Proxy implements IVoiceInteractionSession {
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

            public void taskStarted(Intent intent, int taskId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (intent != null) {
                        _data.writeInt(Stub.TRANSACTION_taskStarted);
                        intent.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(taskId);
                    this.mRemote.transact(Stub.TRANSACTION_taskStarted, _data, null, Stub.TRANSACTION_taskStarted);
                } finally {
                    _data.recycle();
                }
            }

            public void taskFinished(Intent intent, int taskId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (intent != null) {
                        _data.writeInt(Stub.TRANSACTION_taskStarted);
                        intent.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(taskId);
                    this.mRemote.transact(Stub.TRANSACTION_taskFinished, _data, null, Stub.TRANSACTION_taskStarted);
                } finally {
                    _data.recycle();
                }
            }

            public void closeSystemDialogs() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_closeSystemDialogs, _data, null, Stub.TRANSACTION_taskStarted);
                } finally {
                    _data.recycle();
                }
            }

            public void destroy() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_destroy, _data, null, Stub.TRANSACTION_taskStarted);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static IVoiceInteractionSession asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IVoiceInteractionSession)) {
                return new Proxy(obj);
            }
            return (IVoiceInteractionSession) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            Intent _arg0;
            switch (code) {
                case TRANSACTION_taskStarted /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (Intent) Intent.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    taskStarted(_arg0, data.readInt());
                    return true;
                case TRANSACTION_taskFinished /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (Intent) Intent.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    taskFinished(_arg0, data.readInt());
                    return true;
                case TRANSACTION_closeSystemDialogs /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    closeSystemDialogs();
                    return true;
                case TRANSACTION_destroy /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    destroy();
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void closeSystemDialogs() throws RemoteException;

    void destroy() throws RemoteException;

    void taskFinished(Intent intent, int i) throws RemoteException;

    void taskStarted(Intent intent, int i) throws RemoteException;
}
