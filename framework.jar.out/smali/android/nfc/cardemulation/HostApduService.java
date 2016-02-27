package android.nfc.cardemulation;

import android.app.Service;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;
import android.util.Log;

public abstract class HostApduService extends Service {
    public static final int DEACTIVATION_DESELECTED = 1;
    public static final int DEACTIVATION_LINK_LOSS = 0;
    public static final String KEY_DATA = "data";
    public static final int MSG_COMMAND_APDU = 0;
    public static final int MSG_DEACTIVATED = 2;
    public static final int MSG_RESPONSE_APDU = 1;
    public static final int MSG_UNHANDLED = 3;
    public static final String SERVICE_INTERFACE = "android.nfc.cardemulation.action.HOST_APDU_SERVICE";
    public static final String SERVICE_META_DATA = "android.nfc.cardemulation.host_apdu_service";
    static final String TAG = "ApduService";
    final Messenger mMessenger;
    Messenger mNfcService;

    final class MsgHandler extends Handler {
        MsgHandler() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case HostApduService.MSG_COMMAND_APDU /*0*/:
                    Bundle dataBundle = msg.getData();
                    if (dataBundle != null) {
                        if (HostApduService.this.mNfcService == null) {
                            HostApduService.this.mNfcService = msg.replyTo;
                        }
                        byte[] apdu = dataBundle.getByteArray(HostApduService.KEY_DATA);
                        if (apdu != null) {
                            byte[] responseApdu = HostApduService.this.processCommandApdu(apdu, null);
                            if (responseApdu == null) {
                                return;
                            }
                            if (HostApduService.this.mNfcService == null) {
                                Log.e(HostApduService.TAG, "Response not sent; service was deactivated.");
                                return;
                            }
                            Message responseMsg = Message.obtain(null, (int) HostApduService.MSG_RESPONSE_APDU);
                            Bundle responseBundle = new Bundle();
                            responseBundle.putByteArray(HostApduService.KEY_DATA, responseApdu);
                            responseMsg.setData(responseBundle);
                            responseMsg.replyTo = HostApduService.this.mMessenger;
                            try {
                                HostApduService.this.mNfcService.send(responseMsg);
                                return;
                            } catch (RemoteException e) {
                                Log.e("TAG", "Response not sent; RemoteException calling into NfcService.");
                                return;
                            }
                        }
                        Log.e(HostApduService.TAG, "Received MSG_COMMAND_APDU without data.");
                    }
                case HostApduService.MSG_RESPONSE_APDU /*1*/:
                    if (HostApduService.this.mNfcService == null) {
                        Log.e(HostApduService.TAG, "Response not sent; service was deactivated.");
                        return;
                    }
                    try {
                        msg.replyTo = HostApduService.this.mMessenger;
                        HostApduService.this.mNfcService.send(msg);
                    } catch (RemoteException e2) {
                        Log.e(HostApduService.TAG, "RemoteException calling into NfcService.");
                    }
                case HostApduService.MSG_DEACTIVATED /*2*/:
                    HostApduService.this.mNfcService = null;
                    HostApduService.this.onDeactivated(msg.arg1);
                case HostApduService.MSG_UNHANDLED /*3*/:
                    if (HostApduService.this.mNfcService == null) {
                        Log.e(HostApduService.TAG, "notifyUnhandled not sent; service was deactivated.");
                        return;
                    }
                    try {
                        msg.replyTo = HostApduService.this.mMessenger;
                        HostApduService.this.mNfcService.send(msg);
                    } catch (RemoteException e3) {
                        Log.e(HostApduService.TAG, "RemoteException calling into NfcService.");
                    }
                default:
                    super.handleMessage(msg);
            }
        }
    }

    public abstract void onDeactivated(int i);

    public abstract byte[] processCommandApdu(byte[] bArr, Bundle bundle);

    public HostApduService() {
        this.mNfcService = null;
        this.mMessenger = new Messenger(new MsgHandler());
    }

    public final IBinder onBind(Intent intent) {
        return this.mMessenger.getBinder();
    }

    public final void sendResponseApdu(byte[] responseApdu) {
        Message responseMsg = Message.obtain(null, (int) MSG_RESPONSE_APDU);
        Bundle dataBundle = new Bundle();
        dataBundle.putByteArray(KEY_DATA, responseApdu);
        responseMsg.setData(dataBundle);
        try {
            this.mMessenger.send(responseMsg);
        } catch (RemoteException e) {
            Log.e("TAG", "Local messenger has died.");
        }
    }

    public final void notifyUnhandled() {
        try {
            this.mMessenger.send(Message.obtain(null, (int) MSG_UNHANDLED));
        } catch (RemoteException e) {
            Log.e("TAG", "Local messenger has died.");
        }
    }
}
