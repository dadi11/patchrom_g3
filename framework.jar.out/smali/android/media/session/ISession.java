package android.media.session;

import android.app.PendingIntent;
import android.content.pm.ParceledListSlice;
import android.media.AudioAttributes;
import android.media.MediaMetadata;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import android.text.TextUtils;

public interface ISession extends IInterface {

    public static abstract class Stub extends Binder implements ISession {
        private static final String DESCRIPTOR = "android.media.session.ISession";
        static final int TRANSACTION_destroy = 7;
        static final int TRANSACTION_getController = 2;
        static final int TRANSACTION_playItemResponse = 14;
        static final int TRANSACTION_sendEvent = 1;
        static final int TRANSACTION_setActive = 4;
        static final int TRANSACTION_setCurrentVolume = 20;
        static final int TRANSACTION_setExtras = 12;
        static final int TRANSACTION_setFlags = 3;
        static final int TRANSACTION_setLaunchPendingIntent = 6;
        static final int TRANSACTION_setMediaButtonReceiver = 5;
        static final int TRANSACTION_setMetadata = 8;
        static final int TRANSACTION_setPlaybackState = 9;
        static final int TRANSACTION_setPlaybackToLocal = 18;
        static final int TRANSACTION_setPlaybackToRemote = 19;
        static final int TRANSACTION_setQueue = 10;
        static final int TRANSACTION_setQueueTitle = 11;
        static final int TRANSACTION_setRatingType = 13;
        static final int TRANSACTION_updateFolderInfoBrowsedPlayer = 16;
        static final int TRANSACTION_updateNowPlayingContentChange = 17;
        static final int TRANSACTION_updateNowPlayingEntries = 15;

        private static class Proxy implements ISession {
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

            public void sendEvent(String event, Bundle data) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(event);
                    if (data != null) {
                        _data.writeInt(Stub.TRANSACTION_sendEvent);
                        data.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_sendEvent, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public ISessionController getController() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getController, _data, _reply, 0);
                    _reply.readException();
                    ISessionController _result = android.media.session.ISessionController.Stub.asInterface(_reply.readStrongBinder());
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setFlags(int flags) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(flags);
                    this.mRemote.transact(Stub.TRANSACTION_setFlags, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setActive(boolean active) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (active) {
                        i = Stub.TRANSACTION_sendEvent;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_setActive, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setMediaButtonReceiver(PendingIntent mbr) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (mbr != null) {
                        _data.writeInt(Stub.TRANSACTION_sendEvent);
                        mbr.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setMediaButtonReceiver, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setLaunchPendingIntent(PendingIntent pi) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (pi != null) {
                        _data.writeInt(Stub.TRANSACTION_sendEvent);
                        pi.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setLaunchPendingIntent, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void destroy() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_destroy, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setMetadata(MediaMetadata metadata) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (metadata != null) {
                        _data.writeInt(Stub.TRANSACTION_sendEvent);
                        metadata.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setMetadata, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setPlaybackState(PlaybackState state) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (state != null) {
                        _data.writeInt(Stub.TRANSACTION_sendEvent);
                        state.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setPlaybackState, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setQueue(ParceledListSlice queue) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (queue != null) {
                        _data.writeInt(Stub.TRANSACTION_sendEvent);
                        queue.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setQueue, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setQueueTitle(CharSequence title) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (title != null) {
                        _data.writeInt(Stub.TRANSACTION_sendEvent);
                        TextUtils.writeToParcel(title, _data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setQueueTitle, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setExtras(Bundle extras) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (extras != null) {
                        _data.writeInt(Stub.TRANSACTION_sendEvent);
                        extras.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setExtras, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setRatingType(int type) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(type);
                    this.mRemote.transact(Stub.TRANSACTION_setRatingType, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void playItemResponse(boolean success) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (success) {
                        i = Stub.TRANSACTION_sendEvent;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_playItemResponse, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void updateNowPlayingEntries(long[] playList) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeLongArray(playList);
                    this.mRemote.transact(Stub.TRANSACTION_updateNowPlayingEntries, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void updateFolderInfoBrowsedPlayer(String stringUri) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(stringUri);
                    this.mRemote.transact(Stub.TRANSACTION_updateFolderInfoBrowsedPlayer, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void updateNowPlayingContentChange() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_updateNowPlayingContentChange, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setPlaybackToLocal(AudioAttributes attributes) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (attributes != null) {
                        _data.writeInt(Stub.TRANSACTION_sendEvent);
                        attributes.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setPlaybackToLocal, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setPlaybackToRemote(int control, int max) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(control);
                    _data.writeInt(max);
                    this.mRemote.transact(Stub.TRANSACTION_setPlaybackToRemote, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setCurrentVolume(int currentVolume) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(currentVolume);
                    this.mRemote.transact(Stub.TRANSACTION_setCurrentVolume, _data, _reply, 0);
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

        public static ISession asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof ISession)) {
                return new Proxy(obj);
            }
            return (ISession) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            boolean _arg0 = false;
            PendingIntent _arg02;
            switch (code) {
                case TRANSACTION_sendEvent /*1*/:
                    Bundle _arg1;
                    data.enforceInterface(DESCRIPTOR);
                    String _arg03 = data.readString();
                    if (data.readInt() != 0) {
                        _arg1 = (Bundle) Bundle.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    sendEvent(_arg03, _arg1);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_getController /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    ISessionController _result = getController();
                    reply.writeNoException();
                    reply.writeStrongBinder(_result != null ? _result.asBinder() : null);
                    return true;
                case TRANSACTION_setFlags /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    setFlags(data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setActive /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = true;
                    }
                    setActive(_arg0);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setMediaButtonReceiver /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (PendingIntent) PendingIntent.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    setMediaButtonReceiver(_arg02);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setLaunchPendingIntent /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (PendingIntent) PendingIntent.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    setLaunchPendingIntent(_arg02);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_destroy /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    destroy();
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setMetadata /*8*/:
                    MediaMetadata _arg04;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg04 = (MediaMetadata) MediaMetadata.CREATOR.createFromParcel(data);
                    } else {
                        _arg04 = null;
                    }
                    setMetadata(_arg04);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setPlaybackState /*9*/:
                    PlaybackState _arg05;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg05 = (PlaybackState) PlaybackState.CREATOR.createFromParcel(data);
                    } else {
                        _arg05 = null;
                    }
                    setPlaybackState(_arg05);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setQueue /*10*/:
                    ParceledListSlice _arg06;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg06 = (ParceledListSlice) ParceledListSlice.CREATOR.createFromParcel(data);
                    } else {
                        _arg06 = null;
                    }
                    setQueue(_arg06);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setQueueTitle /*11*/:
                    CharSequence _arg07;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg07 = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(data);
                    } else {
                        _arg07 = null;
                    }
                    setQueueTitle(_arg07);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setExtras /*12*/:
                    Bundle _arg08;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg08 = (Bundle) Bundle.CREATOR.createFromParcel(data);
                    } else {
                        _arg08 = null;
                    }
                    setExtras(_arg08);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setRatingType /*13*/:
                    data.enforceInterface(DESCRIPTOR);
                    setRatingType(data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_playItemResponse /*14*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = true;
                    }
                    playItemResponse(_arg0);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_updateNowPlayingEntries /*15*/:
                    data.enforceInterface(DESCRIPTOR);
                    updateNowPlayingEntries(data.createLongArray());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_updateFolderInfoBrowsedPlayer /*16*/:
                    data.enforceInterface(DESCRIPTOR);
                    updateFolderInfoBrowsedPlayer(data.readString());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_updateNowPlayingContentChange /*17*/:
                    data.enforceInterface(DESCRIPTOR);
                    updateNowPlayingContentChange();
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setPlaybackToLocal /*18*/:
                    AudioAttributes _arg09;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg09 = (AudioAttributes) AudioAttributes.CREATOR.createFromParcel(data);
                    } else {
                        _arg09 = null;
                    }
                    setPlaybackToLocal(_arg09);
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setPlaybackToRemote /*19*/:
                    data.enforceInterface(DESCRIPTOR);
                    setPlaybackToRemote(data.readInt(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setCurrentVolume /*20*/:
                    data.enforceInterface(DESCRIPTOR);
                    setCurrentVolume(data.readInt());
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

    void destroy() throws RemoteException;

    ISessionController getController() throws RemoteException;

    void playItemResponse(boolean z) throws RemoteException;

    void sendEvent(String str, Bundle bundle) throws RemoteException;

    void setActive(boolean z) throws RemoteException;

    void setCurrentVolume(int i) throws RemoteException;

    void setExtras(Bundle bundle) throws RemoteException;

    void setFlags(int i) throws RemoteException;

    void setLaunchPendingIntent(PendingIntent pendingIntent) throws RemoteException;

    void setMediaButtonReceiver(PendingIntent pendingIntent) throws RemoteException;

    void setMetadata(MediaMetadata mediaMetadata) throws RemoteException;

    void setPlaybackState(PlaybackState playbackState) throws RemoteException;

    void setPlaybackToLocal(AudioAttributes audioAttributes) throws RemoteException;

    void setPlaybackToRemote(int i, int i2) throws RemoteException;

    void setQueue(ParceledListSlice parceledListSlice) throws RemoteException;

    void setQueueTitle(CharSequence charSequence) throws RemoteException;

    void setRatingType(int i) throws RemoteException;

    void updateFolderInfoBrowsedPlayer(String str) throws RemoteException;

    void updateNowPlayingContentChange() throws RemoteException;

    void updateNowPlayingEntries(long[] jArr) throws RemoteException;
}
