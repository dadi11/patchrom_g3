package android.media.session;

import android.content.pm.ParceledListSlice;
import android.media.MediaMetadata;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import android.text.TextUtils;

public interface ISessionControllerCallback extends IInterface {

    public static abstract class Stub extends Binder implements ISessionControllerCallback {
        private static final String DESCRIPTOR = "android.media.session.ISessionControllerCallback";
        static final int TRANSACTION_onEvent = 1;
        static final int TRANSACTION_onExtrasChanged = 7;
        static final int TRANSACTION_onMetadataChanged = 4;
        static final int TRANSACTION_onPlayItemResponse = 9;
        static final int TRANSACTION_onPlaybackStateChanged = 3;
        static final int TRANSACTION_onQueueChanged = 5;
        static final int TRANSACTION_onQueueTitleChanged = 6;
        static final int TRANSACTION_onSessionDestroyed = 2;
        static final int TRANSACTION_onUpdateFolderInfoBrowsedPlayer = 11;
        static final int TRANSACTION_onUpdateNowPlayingContentChange = 12;
        static final int TRANSACTION_onUpdateNowPlayingEntries = 10;
        static final int TRANSACTION_onVolumeInfoChanged = 8;

        private static class Proxy implements ISessionControllerCallback {
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

            public void onEvent(String event, Bundle extras) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(event);
                    if (extras != null) {
                        _data.writeInt(Stub.TRANSACTION_onEvent);
                        extras.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onEvent, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }

            public void onSessionDestroyed() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_onSessionDestroyed, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }

            public void onPlaybackStateChanged(PlaybackState state) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (state != null) {
                        _data.writeInt(Stub.TRANSACTION_onEvent);
                        state.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onPlaybackStateChanged, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }

            public void onMetadataChanged(MediaMetadata metadata) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (metadata != null) {
                        _data.writeInt(Stub.TRANSACTION_onEvent);
                        metadata.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onMetadataChanged, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }

            public void onQueueChanged(ParceledListSlice queue) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (queue != null) {
                        _data.writeInt(Stub.TRANSACTION_onEvent);
                        queue.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onQueueChanged, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }

            public void onQueueTitleChanged(CharSequence title) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (title != null) {
                        _data.writeInt(Stub.TRANSACTION_onEvent);
                        TextUtils.writeToParcel(title, _data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onQueueTitleChanged, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }

            public void onExtrasChanged(Bundle extras) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (extras != null) {
                        _data.writeInt(Stub.TRANSACTION_onEvent);
                        extras.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onExtrasChanged, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }

            public void onVolumeInfoChanged(ParcelableVolumeInfo info) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (info != null) {
                        _data.writeInt(Stub.TRANSACTION_onEvent);
                        info.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_onVolumeInfoChanged, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }

            public void onPlayItemResponse(boolean success) throws RemoteException {
                int i = Stub.TRANSACTION_onEvent;
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (!success) {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_onPlayItemResponse, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }

            public void onUpdateNowPlayingEntries(long[] playList) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeLongArray(playList);
                    this.mRemote.transact(Stub.TRANSACTION_onUpdateNowPlayingEntries, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }

            public void onUpdateFolderInfoBrowsedPlayer(String stringUri) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(stringUri);
                    this.mRemote.transact(Stub.TRANSACTION_onUpdateFolderInfoBrowsedPlayer, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }

            public void onUpdateNowPlayingContentChange() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_onUpdateNowPlayingContentChange, _data, null, Stub.TRANSACTION_onEvent);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static ISessionControllerCallback asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof ISessionControllerCallback)) {
                return new Proxy(obj);
            }
            return (ISessionControllerCallback) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case TRANSACTION_onEvent /*1*/:
                    Bundle _arg1;
                    data.enforceInterface(DESCRIPTOR);
                    String _arg0 = data.readString();
                    if (data.readInt() != 0) {
                        _arg1 = (Bundle) Bundle.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    onEvent(_arg0, _arg1);
                    return true;
                case TRANSACTION_onSessionDestroyed /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    onSessionDestroyed();
                    return true;
                case TRANSACTION_onPlaybackStateChanged /*3*/:
                    PlaybackState _arg02;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (PlaybackState) PlaybackState.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    onPlaybackStateChanged(_arg02);
                    return true;
                case TRANSACTION_onMetadataChanged /*4*/:
                    MediaMetadata _arg03;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg03 = (MediaMetadata) MediaMetadata.CREATOR.createFromParcel(data);
                    } else {
                        _arg03 = null;
                    }
                    onMetadataChanged(_arg03);
                    return true;
                case TRANSACTION_onQueueChanged /*5*/:
                    ParceledListSlice _arg04;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg04 = (ParceledListSlice) ParceledListSlice.CREATOR.createFromParcel(data);
                    } else {
                        _arg04 = null;
                    }
                    onQueueChanged(_arg04);
                    return true;
                case TRANSACTION_onQueueTitleChanged /*6*/:
                    CharSequence _arg05;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg05 = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(data);
                    } else {
                        _arg05 = null;
                    }
                    onQueueTitleChanged(_arg05);
                    return true;
                case TRANSACTION_onExtrasChanged /*7*/:
                    Bundle _arg06;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg06 = (Bundle) Bundle.CREATOR.createFromParcel(data);
                    } else {
                        _arg06 = null;
                    }
                    onExtrasChanged(_arg06);
                    return true;
                case TRANSACTION_onVolumeInfoChanged /*8*/:
                    ParcelableVolumeInfo _arg07;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg07 = (ParcelableVolumeInfo) ParcelableVolumeInfo.CREATOR.createFromParcel(data);
                    } else {
                        _arg07 = null;
                    }
                    onVolumeInfoChanged(_arg07);
                    return true;
                case TRANSACTION_onPlayItemResponse /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    onPlayItemResponse(data.readInt() != 0);
                    return true;
                case TRANSACTION_onUpdateNowPlayingEntries /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    onUpdateNowPlayingEntries(data.createLongArray());
                    return true;
                case TRANSACTION_onUpdateFolderInfoBrowsedPlayer /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    onUpdateFolderInfoBrowsedPlayer(data.readString());
                    return true;
                case TRANSACTION_onUpdateNowPlayingContentChange /*12*/:
                    data.enforceInterface(DESCRIPTOR);
                    onUpdateNowPlayingContentChange();
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void onEvent(String str, Bundle bundle) throws RemoteException;

    void onExtrasChanged(Bundle bundle) throws RemoteException;

    void onMetadataChanged(MediaMetadata mediaMetadata) throws RemoteException;

    void onPlayItemResponse(boolean z) throws RemoteException;

    void onPlaybackStateChanged(PlaybackState playbackState) throws RemoteException;

    void onQueueChanged(ParceledListSlice parceledListSlice) throws RemoteException;

    void onQueueTitleChanged(CharSequence charSequence) throws RemoteException;

    void onSessionDestroyed() throws RemoteException;

    void onUpdateFolderInfoBrowsedPlayer(String str) throws RemoteException;

    void onUpdateNowPlayingContentChange() throws RemoteException;

    void onUpdateNowPlayingEntries(long[] jArr) throws RemoteException;

    void onVolumeInfoChanged(ParcelableVolumeInfo parcelableVolumeInfo) throws RemoteException;
}
