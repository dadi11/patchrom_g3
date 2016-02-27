package android.media.tv;

import android.graphics.Rect;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import android.view.Surface;

public interface ITvInputSession extends IInterface {

    public static abstract class Stub extends Binder implements ITvInputSession {
        private static final String DESCRIPTOR = "android.media.tv.ITvInputSession";
        static final int TRANSACTION_appPrivateCommand = 9;
        static final int TRANSACTION_createOverlayView = 10;
        static final int TRANSACTION_dispatchSurfaceChanged = 4;
        static final int TRANSACTION_relayoutOverlayView = 11;
        static final int TRANSACTION_release = 1;
        static final int TRANSACTION_removeOverlayView = 12;
        static final int TRANSACTION_requestUnblockContent = 13;
        static final int TRANSACTION_selectTrack = 8;
        static final int TRANSACTION_setCaptionEnabled = 7;
        static final int TRANSACTION_setMain = 2;
        static final int TRANSACTION_setSurface = 3;
        static final int TRANSACTION_setVolume = 5;
        static final int TRANSACTION_tune = 6;

        private static class Proxy implements ITvInputSession {
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

            public void release() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_release, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void setMain(boolean isMain) throws RemoteException {
                int i = Stub.TRANSACTION_release;
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (!isMain) {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_setMain, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void setSurface(Surface surface) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (surface != null) {
                        _data.writeInt(Stub.TRANSACTION_release);
                        surface.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_setSurface, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void dispatchSurfaceChanged(int format, int width, int height) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(format);
                    _data.writeInt(width);
                    _data.writeInt(height);
                    this.mRemote.transact(Stub.TRANSACTION_dispatchSurfaceChanged, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void setVolume(float volume) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeFloat(volume);
                    this.mRemote.transact(Stub.TRANSACTION_setVolume, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void tune(Uri channelUri, Bundle params) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (channelUri != null) {
                        _data.writeInt(Stub.TRANSACTION_release);
                        channelUri.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (params != null) {
                        _data.writeInt(Stub.TRANSACTION_release);
                        params.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_tune, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void setCaptionEnabled(boolean enabled) throws RemoteException {
                int i = Stub.TRANSACTION_release;
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (!enabled) {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_setCaptionEnabled, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void selectTrack(int type, String trackId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(type);
                    _data.writeString(trackId);
                    this.mRemote.transact(Stub.TRANSACTION_selectTrack, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void appPrivateCommand(String action, Bundle data) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(action);
                    if (data != null) {
                        _data.writeInt(Stub.TRANSACTION_release);
                        data.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_appPrivateCommand, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void createOverlayView(IBinder windowToken, Rect frame) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(windowToken);
                    if (frame != null) {
                        _data.writeInt(Stub.TRANSACTION_release);
                        frame.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_createOverlayView, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void relayoutOverlayView(Rect frame) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (frame != null) {
                        _data.writeInt(Stub.TRANSACTION_release);
                        frame.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    this.mRemote.transact(Stub.TRANSACTION_relayoutOverlayView, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void removeOverlayView() throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_removeOverlayView, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }

            public void requestUnblockContent(String unblockedRating) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(unblockedRating);
                    this.mRemote.transact(Stub.TRANSACTION_requestUnblockContent, _data, null, Stub.TRANSACTION_release);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static ITvInputSession asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof ITvInputSession)) {
                return new Proxy(obj);
            }
            return (ITvInputSession) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            boolean _arg0 = false;
            Bundle _arg1;
            switch (code) {
                case TRANSACTION_release /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    release();
                    return true;
                case TRANSACTION_setMain /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = true;
                    }
                    setMain(_arg0);
                    return true;
                case TRANSACTION_setSurface /*3*/:
                    Surface _arg02;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg02 = (Surface) Surface.CREATOR.createFromParcel(data);
                    } else {
                        _arg02 = null;
                    }
                    setSurface(_arg02);
                    return true;
                case TRANSACTION_dispatchSurfaceChanged /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    dispatchSurfaceChanged(data.readInt(), data.readInt(), data.readInt());
                    return true;
                case TRANSACTION_setVolume /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    setVolume(data.readFloat());
                    return true;
                case TRANSACTION_tune /*6*/:
                    Uri _arg03;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg03 = (Uri) Uri.CREATOR.createFromParcel(data);
                    } else {
                        _arg03 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg1 = (Bundle) Bundle.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    tune(_arg03, _arg1);
                    return true;
                case TRANSACTION_setCaptionEnabled /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = true;
                    }
                    setCaptionEnabled(_arg0);
                    return true;
                case TRANSACTION_selectTrack /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    selectTrack(data.readInt(), data.readString());
                    return true;
                case TRANSACTION_appPrivateCommand /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    String _arg04 = data.readString();
                    if (data.readInt() != 0) {
                        _arg1 = (Bundle) Bundle.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    appPrivateCommand(_arg04, _arg1);
                    return true;
                case TRANSACTION_createOverlayView /*10*/:
                    Rect _arg12;
                    data.enforceInterface(DESCRIPTOR);
                    IBinder _arg05 = data.readStrongBinder();
                    if (data.readInt() != 0) {
                        _arg12 = (Rect) Rect.CREATOR.createFromParcel(data);
                    } else {
                        _arg12 = null;
                    }
                    createOverlayView(_arg05, _arg12);
                    return true;
                case TRANSACTION_relayoutOverlayView /*11*/:
                    Rect _arg06;
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg06 = (Rect) Rect.CREATOR.createFromParcel(data);
                    } else {
                        _arg06 = null;
                    }
                    relayoutOverlayView(_arg06);
                    return true;
                case TRANSACTION_removeOverlayView /*12*/:
                    data.enforceInterface(DESCRIPTOR);
                    removeOverlayView();
                    return true;
                case TRANSACTION_requestUnblockContent /*13*/:
                    data.enforceInterface(DESCRIPTOR);
                    requestUnblockContent(data.readString());
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void appPrivateCommand(String str, Bundle bundle) throws RemoteException;

    void createOverlayView(IBinder iBinder, Rect rect) throws RemoteException;

    void dispatchSurfaceChanged(int i, int i2, int i3) throws RemoteException;

    void relayoutOverlayView(Rect rect) throws RemoteException;

    void release() throws RemoteException;

    void removeOverlayView() throws RemoteException;

    void requestUnblockContent(String str) throws RemoteException;

    void selectTrack(int i, String str) throws RemoteException;

    void setCaptionEnabled(boolean z) throws RemoteException;

    void setMain(boolean z) throws RemoteException;

    void setSurface(Surface surface) throws RemoteException;

    void setVolume(float f) throws RemoteException;

    void tune(Uri uri, Bundle bundle) throws RemoteException;
}
