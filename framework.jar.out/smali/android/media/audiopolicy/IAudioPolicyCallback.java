package android.media.audiopolicy;

import android.media.AudioFocusInfo;
import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;

public interface IAudioPolicyCallback extends IInterface {

    public static abstract class Stub extends Binder implements IAudioPolicyCallback {
        private static final String DESCRIPTOR = "android.media.audiopolicy.IAudioPolicyCallback";
        static final int TRANSACTION_notifyAudioFocusGrant = 1;
        static final int TRANSACTION_notifyAudioFocusLoss = 2;

        private static class Proxy implements IAudioPolicyCallback {
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

            public void notifyAudioFocusGrant(AudioFocusInfo afi, int requestResult) throws RemoteException {
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (afi != null) {
                        _data.writeInt(Stub.TRANSACTION_notifyAudioFocusGrant);
                        afi.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    _data.writeInt(requestResult);
                    this.mRemote.transact(Stub.TRANSACTION_notifyAudioFocusGrant, _data, null, Stub.TRANSACTION_notifyAudioFocusGrant);
                } finally {
                    _data.recycle();
                }
            }

            public void notifyAudioFocusLoss(AudioFocusInfo afi, boolean wasNotified) throws RemoteException {
                int i = Stub.TRANSACTION_notifyAudioFocusGrant;
                Parcel _data = Parcel.obtain();
                try {
                    _data.writeInterfaceToken(Stub.DESCRIPTOR);
                    if (afi != null) {
                        _data.writeInt(Stub.TRANSACTION_notifyAudioFocusGrant);
                        afi.writeToParcel(_data, 0);
                    } else {
                        _data.writeInt(0);
                    }
                    if (!wasNotified) {
                        i = 0;
                    }
                    _data.writeInt(i);
                    this.mRemote.transact(Stub.TRANSACTION_notifyAudioFocusLoss, _data, null, Stub.TRANSACTION_notifyAudioFocusGrant);
                } finally {
                    _data.recycle();
                }
            }
        }

        public Stub() {
            attachInterface(this, DESCRIPTOR);
        }

        public static IAudioPolicyCallback asInterface(IBinder obj) {
            if (obj == null) {
                return null;
            }
            IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
            if (iin == null || !(iin instanceof IAudioPolicyCallback)) {
                return new Proxy(obj);
            }
            return (IAudioPolicyCallback) iin;
        }

        public IBinder asBinder() {
            return this;
        }

        public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            AudioFocusInfo _arg0;
            switch (code) {
                case TRANSACTION_notifyAudioFocusGrant /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (AudioFocusInfo) AudioFocusInfo.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    notifyAudioFocusGrant(_arg0, data.readInt());
                    return true;
                case TRANSACTION_notifyAudioFocusLoss /*2*/:
                    data.enforceInterface(DESCRIPTOR);
                    if (data.readInt() != 0) {
                        _arg0 = (AudioFocusInfo) AudioFocusInfo.CREATOR.createFromParcel(data);
                    } else {
                        _arg0 = null;
                    }
                    notifyAudioFocusLoss(_arg0, data.readInt() != 0);
                    return true;
                case IBinder.INTERFACE_TRANSACTION /*1598968902*/:
                    reply.writeString(DESCRIPTOR);
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    void notifyAudioFocusGrant(AudioFocusInfo audioFocusInfo, int i) throws RemoteException;

    void notifyAudioFocusLoss(AudioFocusInfo audioFocusInfo, boolean z) throws RemoteException;
}
