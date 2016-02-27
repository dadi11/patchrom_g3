package android.media.tv;

import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import android.view.InputChannel;
import java.util.List;

public interface ITvInputClient extends IInterface {

    public static abstract class Stub extends Binder implements ITvInputClient {
        private static final String DESCRIPTOR = "android.media.tv.ITvInputClient";
        static final int TRANSACTION_onChannelRetuned = 4;
        static final int TRANSACTION_onContentAllowed = 9;
        static final int TRANSACTION_onContentBlocked = 10;
        static final int TRANSACTION_onLayoutSurface = 11;
        static final int TRANSACTION_onSessionCreated = 1;
        static final int TRANSACTION_onSessionEvent = 3;
        static final int TRANSACTION_onSessionReleased = 2;
        static final int TRANSACTION_onTrackSelected = 6;
        static final int TRANSACTION_onTracksChanged = 5;
        static final int TRANSACTION_onVideoAvailable = 7;
        static final int TRANSACTION_onVideoUnavailable = 8;

        private static class Proxy implements ITvInputClient {
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

            public void onSessionCreated(String inputId, IBinder token, InputChannel channel, int seq) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(inputId);
                    _data.writeStrongBinder(token);
                    if (channel != null) {
                        _data.writeInt(Stub.TRANSACTION_onSessionCreated);
                        channel.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(seq);
                    this.mRemote.transact(Stub.TRANSACTION_onSessionCreated, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onSessionReleased(int seq) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(seq);
                    this.mRemote.transact(Stub.TRANSACTION_onSessionReleased, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onSessionEvent(String name, Bundle args, int seq) throws RemoteException {
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
                    _data.writeInt(seq);
                    this.mRemote.transact(Stub.TRANSACTION_onSessionEvent, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onChannelRetuned(Uri channelUri, int seq) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (channelUri != null) {
                        _data.writeInt(Stub.TRANSACTION_onSessionCreated);
                        channelUri.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(seq);
                    this.mRemote.transact(Stub.TRANSACTION_onChannelRetuned, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onTracksChanged(List<TvTrackInfo> tracks, int seq) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeTypedList(tracks);
                    _data.writeInt(seq);
                    this.mRemote.transact(Stub.TRANSACTION_onTracksChanged, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onTrackSelected(int type, String trackId, int seq) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(type);
                    _data.writeString(trackId);
                    _data.writeInt(seq);
                    this.mRemote.transact(Stub.TRANSACTION_onTrackSelected, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onVideoAvailable(int seq) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(seq);
                    this.mRemote.transact(Stub.TRANSACTION_onVideoAvailable, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onVideoUnavailable(int reason, int seq) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(reason);
                    _data.writeInt(seq);
                    this.mRemote.transact(Stub.TRANSACTION_onVideoUnavailable, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onContentAllowed(int seq) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(seq);
                    this.mRemote.transact(Stub.TRANSACTION_onContentAllowed, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onContentBlocked(String rating, int seq) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(rating);
                    _data.writeInt(seq);
                    this.mRemote.transact(Stub.TRANSACTION_onContentBlocked, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }

            public void onLayoutSurface(int left, int top, int right, int bottom, int seq) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(left);
                    _data.writeInt(top);
                    _data.writeInt(right);
                    _data.writeInt(bottom);
                    _data.writeInt(seq);
                    this.mRemote.transact(Stub.TRANSACTION_onLayoutSurface, _data, null, Stub.TRANSACTION_onSessionCreated);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static ITvInputClient asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof ITvInputClient)) {
                return new Proxy(obj);
            }
            return (ITvInputClient) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            String _arg0;
            switch (code) {
                case TRANSACTION_onSessionCreated /*1*/:
                    InputChannel _arg2;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readString();
                    IBinder _arg1 = data.readStrongBinder();
                    if (data.readInt() != 0) {
                        _arg2 = (InputChannel) InputChannel.CREATOR.createFromParcel(data);
                    } else {
                        _arg2 = null;
                    }
                    onSessionCreated(_arg0, _arg1, _arg2, data.readInt());
                    return true;
                case TRANSACTION_onSessionReleased /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onSessionReleased(data.readInt());
                    return true;
                case TRANSACTION_onSessionEvent /*3*/:
                    Bundle _arg12;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readString();
                    if (data.readInt() != 0) {
                        _arg12 = (Bundle) Bundle.CREATOR.createFromParcel(data);
                    } else {
                        _arg12 = null;
                    }
                    onSessionEvent(_arg0, _arg12, data.readInt());
                    return true;
                case TRANSACTION_onChannelRetuned /*4*/:
                    Uri _arg02;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (Uri) Uri.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    onChannelRetuned(_arg02, data.readInt());
                    return true;
                case TRANSACTION_onTracksChanged /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    onTracksChanged(data.createTypedArrayList(TvTrackInfo.CREATOR), data.readInt());
                    return true;
                case TRANSACTION_onTrackSelected /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    onTrackSelected(data.readInt(), data.readString(), data.readInt());
                    return true;
                case TRANSACTION_onVideoAvailable /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    onVideoAvailable(data.readInt());
                    return true;
                case TRANSACTION_onVideoUnavailable /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    onVideoUnavailable(data.readInt(), data.readInt());
                    return true;
                case TRANSACTION_onContentAllowed /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    onContentAllowed(data.readInt());
                    return true;
                case TRANSACTION_onContentBlocked /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    onContentBlocked(data.readString(), data.readInt());
                    return true;
                case TRANSACTION_onLayoutSurface /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    onLayoutSurface(data.readInt(), data.readInt(), data.readInt(), data.readInt(), data.readInt());
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void onChannelRetuned(Uri uri, int i) throws RemoteException;

    void onContentAllowed(int i) throws RemoteException;

    void onContentBlocked(String str, int i) throws RemoteException;

    void onLayoutSurface(int i, int i2, int i3, int i4, int i5) throws RemoteException;

    void onSessionCreated(String str, IBinder iBinder, InputChannel inputChannel, int i) throws RemoteException;

    void onSessionEvent(String str, Bundle bundle, int i) throws RemoteException;

    void onSessionReleased(int i) throws RemoteException;

    void onTrackSelected(int i, String str, int i2) throws RemoteException;

    void onTracksChanged(List<TvTrackInfo> list, int i) throws RemoteException;

    void onVideoAvailable(int i) throws RemoteException;

    void onVideoUnavailable(int i, int i2) throws RemoteException;
}
