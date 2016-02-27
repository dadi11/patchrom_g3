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
import java.util.List;

public interface ITvInputManager extends IInterface {

    public static abstract class Stub extends Binder implements ITvInputManager {
        private static final String DESCRIPTOR = "android.media.tv.ITvInputManager";
        static final int TRANSACTION_acquireTvInputHardware = 28;
        static final int TRANSACTION_addBlockedRating = 11;
        static final int TRANSACTION_captureFrame = 31;
        static final int TRANSACTION_createOverlayView = 23;
        static final int TRANSACTION_createSession = 13;
        static final int TRANSACTION_dispatchSurfaceChanged = 17;
        static final int TRANSACTION_getAvailableTvStreamConfigList = 30;
        static final int TRANSACTION_getBlockedRatings = 10;
        static final int TRANSACTION_getHardwareList = 27;
        static final int TRANSACTION_getTvContentRatingSystemList = 4;
        static final int TRANSACTION_getTvInputInfo = 2;
        static final int TRANSACTION_getTvInputList = 1;
        static final int TRANSACTION_getTvInputState = 3;
        static final int TRANSACTION_isParentalControlsEnabled = 7;
        static final int TRANSACTION_isRatingBlocked = 9;
        static final int TRANSACTION_isSingleSessionActive = 32;
        static final int TRANSACTION_registerCallback = 5;
        static final int TRANSACTION_relayoutOverlayView = 24;
        static final int TRANSACTION_releaseSession = 14;
        static final int TRANSACTION_releaseTvInputHardware = 29;
        static final int TRANSACTION_removeBlockedRating = 12;
        static final int TRANSACTION_removeOverlayView = 25;
        static final int TRANSACTION_requestUnblockContent = 26;
        static final int TRANSACTION_selectTrack = 21;
        static final int TRANSACTION_sendAppPrivateCommand = 22;
        static final int TRANSACTION_setCaptionEnabled = 20;
        static final int TRANSACTION_setMainSession = 15;
        static final int TRANSACTION_setParentalControlsEnabled = 8;
        static final int TRANSACTION_setSurface = 16;
        static final int TRANSACTION_setVolume = 18;
        static final int TRANSACTION_tune = 19;
        static final int TRANSACTION_unregisterCallback = 6;

        private static class Proxy implements ITvInputManager {
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

            public List<TvInputInfo> getTvInputList(int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_getTvInputList, _data, _reply, 0);
                    _reply.readException();
                    List<TvInputInfo> _result = _reply.createTypedArrayList(TvInputInfo.CREATOR);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public TvInputInfo getTvInputInfo(String inputId, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    TvInputInfo _result;
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(inputId);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_getTvInputInfo, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() != 0) {
                        _result = (TvInputInfo) TvInputInfo.CREATOR.createFromParcel(_reply);
                    } else {
                        _result = null;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public int getTvInputState(String inputId, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(inputId);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_getTvInputState, _data, _reply, 0);
                    _reply.readException();
                    int _result = _reply.readInt();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public List<TvContentRatingSystemInfo> getTvContentRatingSystemList(int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_getTvContentRatingSystemList, _data, _reply, 0);
                    _reply.readException();
                    List<TvContentRatingSystemInfo> _result = _reply.createTypedArrayList(TvContentRatingSystemInfo.CREATOR);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void registerCallback(ITvInputManagerCallback callback, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(callback != null ? callback.asBinder() : null);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_registerCallback, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void unregisterCallback(ITvInputManagerCallback callback, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(callback != null ? callback.asBinder() : null);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_unregisterCallback, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean isParentalControlsEnabled(int userId) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_isParentalControlsEnabled, _data, _reply, 0);
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

            public void setParentalControlsEnabled(boolean enabled, int userId) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (enabled) {
                        i = Stub.TRANSACTION_getTvInputList;
                    }
                    _data.writeInt(i);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_setParentalControlsEnabled, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean isRatingBlocked(String rating, int userId) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(rating);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_isRatingBlocked, _data, _reply, 0);
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

            public List<String> getBlockedRatings(int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_getBlockedRatings, _data, _reply, 0);
                    _reply.readException();
                    List<String> _result = _reply.createStringArrayList();
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void addBlockedRating(String rating, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(rating);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_addBlockedRating, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void removeBlockedRating(String rating, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(rating);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_removeBlockedRating, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void createSession(ITvInputClient client, String inputId, int seq, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(client != null ? client.asBinder() : null);
                    _data.writeString(inputId);
                    _data.writeInt(seq);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_createSession, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void releaseSession(IBinder sessionToken, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_releaseSession, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setMainSession(IBinder sessionToken, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_setMainSession, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setSurface(IBinder sessionToken, Surface surface, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    if (surface != null) {
                        _data.writeInt(Stub.TRANSACTION_getTvInputList);
                        surface.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_setSurface, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void dispatchSurfaceChanged(IBinder sessionToken, int format, int width, int height, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    _data.writeInt(format);
                    _data.writeInt(width);
                    _data.writeInt(height);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_dispatchSurfaceChanged, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setVolume(IBinder sessionToken, float volume, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    _data.writeFloat(volume);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_setVolume, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void tune(IBinder sessionToken, Uri channelUri, Bundle params, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    if (channelUri != null) {
                        _data.writeInt(Stub.TRANSACTION_getTvInputList);
                        channelUri.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (params != null) {
                        _data.writeInt(Stub.TRANSACTION_getTvInputList);
                        params.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_tune, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void setCaptionEnabled(IBinder sessionToken, boolean enabled, int userId) throws RemoteException {
                int i = 0;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    if (enabled) {
                        i = Stub.TRANSACTION_getTvInputList;
                    }
                    _data.writeInt(i);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_setCaptionEnabled, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void selectTrack(IBinder sessionToken, int type, String trackId, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    _data.writeInt(type);
                    _data.writeString(trackId);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_selectTrack, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void sendAppPrivateCommand(IBinder sessionToken, String action, Bundle data, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    _data.writeString(action);
                    if (data != null) {
                        _data.writeInt(Stub.TRANSACTION_getTvInputList);
                        data.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_sendAppPrivateCommand, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void createOverlayView(IBinder sessionToken, IBinder windowToken, Rect frame, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    _data.writeStrongBinder(windowToken);
                    if (frame != null) {
                        _data.writeInt(Stub.TRANSACTION_getTvInputList);
                        frame.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_createOverlayView, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void relayoutOverlayView(IBinder sessionToken, Rect frame, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    if (frame != null) {
                        _data.writeInt(Stub.TRANSACTION_getTvInputList);
                        frame.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_relayoutOverlayView, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void removeOverlayView(IBinder sessionToken, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_removeOverlayView, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void requestUnblockContent(IBinder sessionToken, String unblockedRating, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeStrongBinder(sessionToken);
                    _data.writeString(unblockedRating);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_requestUnblockContent, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public List<TvInputHardwareInfo> getHardwareList() throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    this.mRemote.transact(Stub.TRANSACTION_getHardwareList, _data, _reply, 0);
                    _reply.readException();
                    List<TvInputHardwareInfo> _result = _reply.createTypedArrayList(TvInputHardwareInfo.CREATOR);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public ITvInputHardware acquireTvInputHardware(int deviceId, ITvInputHardwareCallback callback, TvInputInfo info, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(deviceId);
                    _data.writeStrongBinder(callback != null ? callback.asBinder() : null);
                    if (info != null) {
                        _data.writeInt(Stub.TRANSACTION_getTvInputList);
                        info.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_acquireTvInputHardware, _data, _reply, 0);
                    _reply.readException();
                    ITvInputHardware _result = android.media.tv.ITvInputHardware.Stub.asInterface(_reply.readStrongBinder());
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public void releaseTvInputHardware(int deviceId, ITvInputHardware hardware, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(deviceId);
                    _data.writeStrongBinder(hardware != null ? hardware.asBinder() : null);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_releaseTvInputHardware, _data, _reply, 0);
                    _reply.readException();
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public List<TvStreamConfig> getAvailableTvStreamConfigList(String inputId, int userId) throws RemoteException {
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(inputId);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_getAvailableTvStreamConfigList, _data, _reply, 0);
                    _reply.readException();
                    List<TvStreamConfig> _result = _reply.createTypedArrayList(TvStreamConfig.CREATOR);
                    return _result;
                } finally {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean captureFrame(String inputId, Surface surface, TvStreamConfig config, int userId) throws RemoteException {
                boolean _result = true;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeString(inputId);
                    if (surface != null) {
                        _data.writeInt(Stub.TRANSACTION_getTvInputList);
                        surface.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (config != null) {
                        _data.writeInt(Stub.TRANSACTION_getTvInputList);
                        config.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_captureFrame, _data, _reply, 0);
                    _reply.readException();
                    if (_reply.readInt() == 0) {
                        _result = false;
                    }
                    _reply.recycle();
                    _data.recycle();
                    return _result;
                } catch (Throwable th) {
                    _reply.recycle();
                    _data.recycle();
                }
            }

            public boolean isSingleSessionActive(int userId) throws RemoteException {
                boolean _result = false;
                Parcel _data = Parcel.obtain();
                Parcel _reply = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    _data.writeInt(userId);
                    this.mRemote.transact(Stub.TRANSACTION_isSingleSessionActive, _data, _reply, 0);
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
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static ITvInputManager asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof ITvInputManager)) {
                return new Proxy(obj);
            }
            return (ITvInputManager) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            boolean _result;
            IBinder _arg0;
            Surface _arg1;
            Bundle _arg2;
            switch (code) {
                case TRANSACTION_getTvInputList /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    List<TvInputInfo> _result2 = getTvInputList(data.readInt());
                    reply.writeNoException();
                    reply.writeTypedList(_result2);
                    return true;
                case TRANSACTION_getTvInputInfo /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    TvInputInfo _result3 = getTvInputInfo(data.readString(), data.readInt());
                    reply.writeNoException();
                    if (_result3 != null) {
                        reply.writeInt(TRANSACTION_getTvInputList);
                        _result3.writeToParcel(reply, TRANSACTION_getTvInputList);
                    } else {
                        reply.writeInt(0);
                    }
                    return true;
                case TRANSACTION_getTvInputState /*3*/:
                    data.enforceInterface(DESCRIPTOR);
                    int _result4 = getTvInputState(data.readString(), data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result4);
                    return true;
                case TRANSACTION_getTvContentRatingSystemList /*4*/:
                    data.enforceInterface(DESCRIPTOR);
                    List<TvContentRatingSystemInfo> _result5 = getTvContentRatingSystemList(data.readInt());
                    reply.writeNoException();
                    reply.writeTypedList(_result5);
                    return true;
                case TRANSACTION_registerCallback /*5*/:
                    data.enforceInterface(DESCRIPTOR);
                    registerCallback(android.media.tv.ITvInputManagerCallback.Stub.asInterface(data.readStrongBinder()), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_unregisterCallback /*6*/:
                    data.enforceInterface(DESCRIPTOR);
                    unregisterCallback(android.media.tv.ITvInputManagerCallback.Stub.asInterface(data.readStrongBinder()), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_isParentalControlsEnabled /*7*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = isParentalControlsEnabled(data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result ? TRANSACTION_getTvInputList : 0);
                    return true;
                case TRANSACTION_setParentalControlsEnabled /*8*/:
                    data.enforceInterface(DESCRIPTOR);
                    setParentalControlsEnabled(data.readInt() != 0, data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_isRatingBlocked /*9*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = isRatingBlocked(data.readString(), data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result ? TRANSACTION_getTvInputList : 0);
                    return true;
                case TRANSACTION_getBlockedRatings /*10*/:
                    data.enforceInterface(DESCRIPTOR);
                    List<String> _result6 = getBlockedRatings(data.readInt());
                    reply.writeNoException();
                    reply.writeStringList(_result6);
                    return true;
                case TRANSACTION_addBlockedRating /*11*/:
                    data.enforceInterface(DESCRIPTOR);
                    addBlockedRating(data.readString(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_removeBlockedRating /*12*/:
                    data.enforceInterface(DESCRIPTOR);
                    removeBlockedRating(data.readString(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_createSession /*13*/:
                    data.enforceInterface(DESCRIPTOR);
                    createSession(android.media.tv.ITvInputClient.Stub.asInterface(data.readStrongBinder()), data.readString(), data.readInt(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_releaseSession /*14*/:
                    data.enforceInterface(DESCRIPTOR);
                    releaseSession(data.readStrongBinder(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setMainSession /*15*/:
                    data.enforceInterface(DESCRIPTOR);
                    setMainSession(data.readStrongBinder(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setSurface /*16*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readStrongBinder();
                    if (data.readInt() != 0) {
                        _arg1 = (Surface) Surface.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    setSurface(_arg0, _arg1, data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_dispatchSurfaceChanged /*17*/:
                    data.enforceInterface(DESCRIPTOR);
                    dispatchSurfaceChanged(data.readStrongBinder(), data.readInt(), data.readInt(), data.readInt(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setVolume /*18*/:
                    data.enforceInterface(DESCRIPTOR);
                    setVolume(data.readStrongBinder(), data.readFloat(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_tune /*19*/:
                    Uri _arg12;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readStrongBinder();
                    if (data.readInt() != 0) {
                        _arg12 = (Uri) Uri.CREATOR.createFromParcel(data);
                    } else {
                        _arg12 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg2 = (Bundle) Bundle.CREATOR.createFromParcel(data);
                    } else {
                        _arg2 = null;
                    }
                    tune(_arg0, _arg12, _arg2, data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_setCaptionEnabled /*20*/:
                    data.enforceInterface(DESCRIPTOR);
                    setCaptionEnabled(data.readStrongBinder(), data.readInt() != 0, data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_selectTrack /*21*/:
                    data.enforceInterface(DESCRIPTOR);
                    selectTrack(data.readStrongBinder(), data.readInt(), data.readString(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_sendAppPrivateCommand /*22*/:
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readStrongBinder();
                    String _arg13 = data.readString();
                    if (data.readInt() != 0) {
                        _arg2 = (Bundle) Bundle.CREATOR.createFromParcel(data);
                    } else {
                        _arg2 = null;
                    }
                    sendAppPrivateCommand(_arg0, _arg13, _arg2, data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_createOverlayView /*23*/:
                    Rect _arg22;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readStrongBinder();
                    IBinder _arg14 = data.readStrongBinder();
                    if (data.readInt() != 0) {
                        _arg22 = (Rect) Rect.CREATOR.createFromParcel(data);
                    } else {
                        _arg22 = null;
                    }
                    createOverlayView(_arg0, _arg14, _arg22, data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_relayoutOverlayView /*24*/:
                    Rect _arg15;
                    data.enforceInterface(DESCRIPTOR);
                    _arg0 = data.readStrongBinder();
                    if (data.readInt() != 0) {
                        _arg15 = (Rect) Rect.CREATOR.createFromParcel(data);
                    } else {
                        _arg15 = null;
                    }
                    relayoutOverlayView(_arg0, _arg15, data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_removeOverlayView /*25*/:
                    data.enforceInterface(DESCRIPTOR);
                    removeOverlayView(data.readStrongBinder(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_requestUnblockContent /*26*/:
                    data.enforceInterface(DESCRIPTOR);
                    requestUnblockContent(data.readStrongBinder(), data.readString(), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_getHardwareList /*27*/:
                    data.enforceInterface(DESCRIPTOR);
                    List<TvInputHardwareInfo> _result7 = getHardwareList();
                    reply.writeNoException();
                    reply.writeTypedList(_result7);
                    return true;
                case TRANSACTION_acquireTvInputHardware /*28*/:
                    TvInputInfo _arg23;
                    data.enforceInterface(DESCRIPTOR);
                    int _arg02 = data.readInt();
                    ITvInputHardwareCallback _arg16 = android.media.tv.ITvInputHardwareCallback.Stub.asInterface(data.readStrongBinder());
                    if (data.readInt() != 0) {
                        _arg23 = (TvInputInfo) TvInputInfo.CREATOR.createFromParcel(data);
                    } else {
                        _arg23 = null;
                    }
                    ITvInputHardware _result8 = acquireTvInputHardware(_arg02, _arg16, _arg23, data.readInt());
                    reply.writeNoException();
                    reply.writeStrongBinder(_result8 != null ? _result8.asBinder() : null);
                    return true;
                case TRANSACTION_releaseTvInputHardware /*29*/:
                    data.enforceInterface(DESCRIPTOR);
                    releaseTvInputHardware(data.readInt(), android.media.tv.ITvInputHardware.Stub.asInterface(data.readStrongBinder()), data.readInt());
                    reply.writeNoException();
                    return true;
                case TRANSACTION_getAvailableTvStreamConfigList /*30*/:
                    data.enforceInterface(DESCRIPTOR);
                    List<TvStreamConfig> _result9 = getAvailableTvStreamConfigList(data.readString(), data.readInt());
                    reply.writeNoException();
                    reply.writeTypedList(_result9);
                    return true;
                case TRANSACTION_captureFrame /*31*/:
                    TvStreamConfig _arg24;
                    data.enforceInterface(DESCRIPTOR);
                    String _arg03 = data.readString();
                    if (data.readInt() != 0) {
                        _arg1 = (Surface) Surface.CREATOR.createFromParcel(data);
                    } else {
                        _arg1 = null;
                    }
                    if (data.readInt() != 0) {
                        _arg24 = (TvStreamConfig) TvStreamConfig.CREATOR.createFromParcel(data);
                    } else {
                        _arg24 = null;
                    }
                    _result = captureFrame(_arg03, _arg1, _arg24, data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result ? TRANSACTION_getTvInputList : 0);
                    return true;
                case TRANSACTION_isSingleSessionActive /*32*/:
                    data.enforceInterface(DESCRIPTOR);
                    _result = isSingleSessionActive(data.readInt());
                    reply.writeNoException();
                    reply.writeInt(_result ? TRANSACTION_getTvInputList : 0);
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    ITvInputHardware acquireTvInputHardware(int i, ITvInputHardwareCallback iTvInputHardwareCallback, TvInputInfo tvInputInfo, int i2) throws RemoteException;

    void addBlockedRating(String str, int i) throws RemoteException;

    boolean captureFrame(String str, Surface surface, TvStreamConfig tvStreamConfig, int i) throws RemoteException;

    void createOverlayView(IBinder iBinder, IBinder iBinder2, Rect rect, int i) throws RemoteException;

    void createSession(ITvInputClient iTvInputClient, String str, int i, int i2) throws RemoteException;

    void dispatchSurfaceChanged(IBinder iBinder, int i, int i2, int i3, int i4) throws RemoteException;

    List<TvStreamConfig> getAvailableTvStreamConfigList(String str, int i) throws RemoteException;

    List<String> getBlockedRatings(int i) throws RemoteException;

    List<TvInputHardwareInfo> getHardwareList() throws RemoteException;

    List<TvContentRatingSystemInfo> getTvContentRatingSystemList(int i) throws RemoteException;

    TvInputInfo getTvInputInfo(String str, int i) throws RemoteException;

    List<TvInputInfo> getTvInputList(int i) throws RemoteException;

    int getTvInputState(String str, int i) throws RemoteException;

    boolean isParentalControlsEnabled(int i) throws RemoteException;

    boolean isRatingBlocked(String str, int i) throws RemoteException;

    boolean isSingleSessionActive(int i) throws RemoteException;

    void registerCallback(ITvInputManagerCallback iTvInputManagerCallback, int i) throws RemoteException;

    void relayoutOverlayView(IBinder iBinder, Rect rect, int i) throws RemoteException;

    void releaseSession(IBinder iBinder, int i) throws RemoteException;

    void releaseTvInputHardware(int i, ITvInputHardware iTvInputHardware, int i2) throws RemoteException;

    void removeBlockedRating(String str, int i) throws RemoteException;

    void removeOverlayView(IBinder iBinder, int i) throws RemoteException;

    void requestUnblockContent(IBinder iBinder, String str, int i) throws RemoteException;

    void selectTrack(IBinder iBinder, int i, String str, int i2) throws RemoteException;

    void sendAppPrivateCommand(IBinder iBinder, String str, Bundle bundle, int i) throws RemoteException;

    void setCaptionEnabled(IBinder iBinder, boolean z, int i) throws RemoteException;

    void setMainSession(IBinder iBinder, int i) throws RemoteException;

    void setParentalControlsEnabled(boolean z, int i) throws RemoteException;

    void setSurface(IBinder iBinder, Surface surface, int i) throws RemoteException;

    void setVolume(IBinder iBinder, float f, int i) throws RemoteException;

    void tune(IBinder iBinder, Uri uri, Bundle bundle, int i) throws RemoteException;

    void unregisterCallback(ITvInputManagerCallback iTvInputManagerCallback, int i) throws RemoteException;
}
