package android.media.tv;

import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import java.util.List;

public interface ITvInputSessionCallback extends IInterface {

    public static abstract class Stub extends Binder implements ITvInputSessionCallback {
        private static final String DESCRIPTOR = "android.media.tv.ITvInputSessionCallback";
        static final int TRANSACTION_onChannelRetuned = 3;
        static final int TRANSACTION_onContentAllowed = 8;
        static final int TRANSACTION_onContentBlocked = 9;
        static final int TRANSACTION_onLayoutSurface = 10;
        static final int TRANSACTION_onSessionCreated = 1;
        static final int TRANSACTION_onSessionEvent = 2;
        static final int TRANSACTION_onTrackSelected = 5;
        static final int TRANSACTION_onTracksChanged = 4;
        static final int TRANSACTION_onVideoAvailable = 6;
        static final int TRANSACTION_onVideoUnavailable = 7;

        private static class Proxy implements ITvInputSessionCallback {
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

            public void onSessionCreated(ITvInputSession session, IBinder hardwareSessionToken) throws RemoteException {
                IBinder iBinder = null;
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (session != null) {
                        iBinder = session.asBinder();
                    }
                    _data.writeStrongBinder(iBinder);
                    _data.writeStrongBinder(hardwareSessionToken);
                    this.mRemote.transact(Stub.TRANSACTION_onSessionCreated, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onSessionEvent(String name, Bundle args) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(name);
                    if (args != null) {
                        _data.writeInt(Stub.TRANSACTION_onSessionCreated);
                        args.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onSessionEvent, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onChannelRetuned(Uri channelUri) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (channelUri != null) {
                        _data.writeInt(Stub.TRANSACTION_onSessionCreated);
                        channelUri.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onChannelRetuned, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onTracksChanged(List<TvTrackInfo> tracks) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeTypedList(tracks);
                    this.mRemote.transact(Stub.TRANSACTION_onTracksChanged, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onTrackSelected(int type, String trackId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(type);
                    _data.writeString(trackId);
                    this.mRemote.transact(Stub.TRANSACTION_onTrackSelected, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onVideoAvailable() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_onVideoAvailable, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onVideoUnavailable(int reason) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(reason);
                    this.mRemote.transact(Stub.TRANSACTION_onVideoUnavailable, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onContentAllowed() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_onContentAllowed, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onContentBlocked(String rating) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(rating);
                    this.mRemote.transact(Stub.TRANSACTION_onContentBlocked, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onLayoutSurface(int left, int top, int right, int bottom) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(left);
                    _data.writeInt(top);
                    _data.writeInt(right);
                    _data.writeInt(bottom);
                    this.mRemote.transact(Stub.TRANSACTION_onLayoutSurface, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static ITvInputSessionCallback asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof ITvInputSessionCallback)) {
                return new Proxy(obj);
            }
            return (ITvInputSessionCallback) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_onSessionCreated /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    onSessionCreated(android.media.tv.ITvInputSession.Stub.asInterface(data.readStrongBinder()), data.readStrongBinder());
                    return true;
                case TRANSACTION_onSessionEvent /*2*/:
                    Bundle _arg1;
                    data.enforceInterface(DESCRIPTOR);
                    String _arg0 = data.readString();
                    if (data.readInt() != 0) {
                        _arg1 = (Bundle) Bundle.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    onSessionEvent(_arg0, _arg1);
                    return true;
                case TRANSACTION_onChannelRetuned /*3*/:
                    Uri _arg02;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (Uri) Uri.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    onChannelRetuned(_arg02);
                    return true;
                case TRANSACTION_onTracksChanged /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    onTracksChanged(data.createTypedArrayList(TvTrackInfo.CREATOR));
                    return true;
                case TRANSACTION_onTrackSelected /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    onTrackSelected(data.readInt(), data.readString());
                    return true;
                case TRANSACTION_onVideoAvailable /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    onVideoAvailable();
                    return true;
                case TRANSACTION_onVideoUnavailable /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    onVideoUnavailable(data.readInt());
                    return true;
                case TRANSACTION_onContentAllowed /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    onContentAllowed();
                    return true;
                case TRANSACTION_onContentBlocked /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    onContentBlocked(data.readString());
                    return true;
                case TRANSACTION_onLayoutSurface /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    onLayoutSurface(data.readInt(), data.readInt(), data.readInt(), data.readInt());
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void onChannelRetuned(Uri uri) throws RemoteException;

    void onContentAllowed() throws RemoteException;

    void onContentBlocked(String str) throws RemoteException;

    void onLayoutSurface(int i, int i2, int i3, int i4) throws RemoteException;

    void onSessionCreated(ITvInputSession iTvInputSession, IBinder iBinder) throws RemoteException;

    void onSessionEvent(String str, Bundle bundle) throws RemoteException;

    void onTrackSelected(int i, String str) throws RemoteException;

    void onTracksChanged(List<TvTrackInfo> list) throws RemoteException;

    void onVideoAvailable() throws RemoteException;

    void onVideoUnavailable(int i) throws RemoteException;
}
