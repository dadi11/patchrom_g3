package android.media;

import android.net.Uri;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import android.os.UserHandle;

public interface IRingtonePlayer extends IInterface {

    public static abstract class Stub extends Binder implements IRingtonePlayer {
        private static final String DESCRIPTOR = "android.media.IRingtonePlayer";
        static final int TRANSACTION_isPlaying = 3;
        static final int TRANSACTION_play = 1;
        static final int TRANSACTION_playAsync = 4;
        static final int TRANSACTION_stop = 2;
        static final int TRANSACTION_stopAsync = 5;

        private static class Proxy implements IRingtonePlayer {
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

            public void play(IBinder token, Uri uri, AudioAttributes aa) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(token);
                    if (uri != null) {
                        _data.writeInt(Stub.TRANSACTION_play);
                        uri.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (aa != null) {
                        _data.writeInt(Stub.TRANSACTION_play);
                        aa.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_play, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void stop(IBinder token) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(token);
                    this.mRemote.transact(Stub.TRANSACTION_stop, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean isPlaying(IBinder token) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(token);
                    this.mRemote.transact(Stub.TRANSACTION_isPlaying, _data, _reply, 0);
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

            public void playAsync(Uri uri, UserHandle user, boolean looping, AudioAttributes aa) throws RemoteException {
                int i = Stub.TRANSACTION_play;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (uri != null) {
                        _data.writeInt(Stub.TRANSACTION_play);
                        uri.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (user != null) {
                        _data.writeInt(Stub.TRANSACTION_play);
                        user.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (!looping) {
                        i = 0;
                    }
                    _data.writeInt(i);
                    if (aa != null) {
                        _data.writeInt(Stub.TRANSACTION_play);
                        aa.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_playAsync, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void stopAsync() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_stopAsync, _data, _reply, 0);
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

        public static IRingtonePlayer asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IRingtonePlayer)) {
                return new Proxy(obj);
            }
            return (IRingtonePlayer) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            int i = 0;
            switch (code) {
                case TRANSACTION_play /*1*/:
                    Uri _arg1;
                    AudioAttributes _arg2;
                    data.enforceInterface(DESCRIPTOR);
                    IBinder _arg0 = data.readStrongBinder();
                    if (data.readInt() != 0) {
                        _arg1 = (Uri) Uri.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg2 = (AudioAttributes) AudioAttributes.CREATOR.createFromParcel(data);
                    } else {
                        _arg2 = null;
                    }
                    play(_arg0, _arg1, _arg2);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_stop /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    stop(data.readStrongBinder());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_isPlaying /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    boolean _result = isPlaying(data.readStrongBinder());
                    reply.writeNoException();
                    if (_result) {
                        i = TRANSACTION_play;
                    }
                    reply.writeInt(i);
                    return true;
                case TRANSACTION_playAsync /*4*/:
                    Uri _arg02;
                    UserHandle _arg12;
                    boolean _arg22;
                    AudioAttributes _arg3;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (Uri) Uri.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg12 = (UserHandle) UserHandle.CREATOR.createFromParcel(data);
                    } else {
                        _arg12 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg22 = true;
                    } else {
                        _arg22 = false;
                    }
                    if (data.readInt() != 0) {
                        _arg3 = (AudioAttributes) AudioAttributes.CREATOR.createFromParcel(data);
                    } else {
                        _arg3 = null;
                    }
                    playAsync(_arg02, _arg12, _arg22, _arg3);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_stopAsync /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    stopAsync();
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

    boolean isPlaying(IBinder iBinder) throws RemoteException;

    void play(IBinder iBinder, Uri uri, AudioAttributes audioAttributes) throws RemoteException;

    void playAsync(Uri uri, UserHandle userHandle, boolean z, AudioAttributes audioAttributes) throws RemoteException;

    void stop(IBinder iBinder) throws RemoteException;

    void stopAsync() throws RemoteException;
}
