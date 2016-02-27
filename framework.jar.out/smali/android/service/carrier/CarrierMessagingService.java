package android.service.carrier;

import android.app.Service;
import android.content.Intent;
import android.net.Uri;
import android.os.IBinder;
import android.os.RemoteException;
import android.service.carrier.ICarrierMessagingService.Stub;
import java.util.List;

public abstract class CarrierMessagingService extends Service {
    public static final int DOWNLOAD_STATUS_ERROR = 2;
    public static final int DOWNLOAD_STATUS_OK = 0;
    public static final int DOWNLOAD_STATUS_RETRY_ON_CARRIER_NETWORK = 1;
    public static final int SEND_STATUS_ERROR = 2;
    public static final int SEND_STATUS_OK = 0;
    public static final int SEND_STATUS_RETRY_ON_CARRIER_NETWORK = 1;
    public static final String SERVICE_INTERFACE = "android.service.carrier.CarrierMessagingService";
    private final ICarrierMessagingWrapper mWrapper;

    public interface ResultCallback<T> {
        void onReceiveResult(T t) throws RemoteException;
    }

    private class ICarrierMessagingWrapper extends Stub {

        /* renamed from: android.service.carrier.CarrierMessagingService.ICarrierMessagingWrapper.1 */
        class C06631 implements ResultCallback<Boolean> {
            final /* synthetic */ ICarrierMessagingCallback val$callback;

            C06631(ICarrierMessagingCallback iCarrierMessagingCallback) {
                this.val$callback = iCarrierMessagingCallback;
            }

            public void onReceiveResult(Boolean result) throws RemoteException {
                this.val$callback.onFilterComplete(result.booleanValue());
            }
        }

        /* renamed from: android.service.carrier.CarrierMessagingService.ICarrierMessagingWrapper.2 */
        class C06642 implements ResultCallback<SendSmsResult> {
            final /* synthetic */ ICarrierMessagingCallback val$callback;

            C06642(ICarrierMessagingCallback iCarrierMessagingCallback) {
                this.val$callback = iCarrierMessagingCallback;
            }

            public void onReceiveResult(SendSmsResult result) throws RemoteException {
                this.val$callback.onSendSmsComplete(result.getSendStatus(), result.getMessageRef());
            }
        }

        /* renamed from: android.service.carrier.CarrierMessagingService.ICarrierMessagingWrapper.3 */
        class C06653 implements ResultCallback<SendSmsResult> {
            final /* synthetic */ ICarrierMessagingCallback val$callback;

            C06653(ICarrierMessagingCallback iCarrierMessagingCallback) {
                this.val$callback = iCarrierMessagingCallback;
            }

            public void onReceiveResult(SendSmsResult result) throws RemoteException {
                this.val$callback.onSendSmsComplete(result.getSendStatus(), result.getMessageRef());
            }
        }

        /* renamed from: android.service.carrier.CarrierMessagingService.ICarrierMessagingWrapper.4 */
        class C06664 implements ResultCallback<SendMultipartSmsResult> {
            final /* synthetic */ ICarrierMessagingCallback val$callback;

            C06664(ICarrierMessagingCallback iCarrierMessagingCallback) {
                this.val$callback = iCarrierMessagingCallback;
            }

            public void onReceiveResult(SendMultipartSmsResult result) throws RemoteException {
                this.val$callback.onSendMultipartSmsComplete(result.getSendStatus(), result.getMessageRefs());
            }
        }

        /* renamed from: android.service.carrier.CarrierMessagingService.ICarrierMessagingWrapper.5 */
        class C06675 implements ResultCallback<SendMmsResult> {
            final /* synthetic */ ICarrierMessagingCallback val$callback;

            C06675(ICarrierMessagingCallback iCarrierMessagingCallback) {
                this.val$callback = iCarrierMessagingCallback;
            }

            public void onReceiveResult(SendMmsResult result) throws RemoteException {
                this.val$callback.onSendMmsComplete(result.getSendStatus(), result.getSendConfPdu());
            }
        }

        /* renamed from: android.service.carrier.CarrierMessagingService.ICarrierMessagingWrapper.6 */
        class C06686 implements ResultCallback<Integer> {
            final /* synthetic */ ICarrierMessagingCallback val$callback;

            C06686(ICarrierMessagingCallback iCarrierMessagingCallback) {
                this.val$callback = iCarrierMessagingCallback;
            }

            public void onReceiveResult(Integer result) throws RemoteException {
                this.val$callback.onDownloadMmsComplete(result.intValue());
            }
        }

        private ICarrierMessagingWrapper() {
        }

        public void filterSms(MessagePdu pdu, String format, int destPort, int subId, ICarrierMessagingCallback callback) {
            CarrierMessagingService.this.onFilterSms(pdu, format, destPort, subId, new C06631(callback));
        }

        public void sendTextSms(String text, int subId, String destAddress, ICarrierMessagingCallback callback) {
            CarrierMessagingService.this.onSendTextSms(text, subId, destAddress, new C06642(callback));
        }

        public void sendDataSms(byte[] data, int subId, String destAddress, int destPort, ICarrierMessagingCallback callback) {
            CarrierMessagingService.this.onSendDataSms(data, subId, destAddress, destPort, new C06653(callback));
        }

        public void sendMultipartTextSms(List<String> parts, int subId, String destAddress, ICarrierMessagingCallback callback) {
            CarrierMessagingService.this.onSendMultipartTextSms(parts, subId, destAddress, new C06664(callback));
        }

        public void sendMms(Uri pduUri, int subId, Uri location, ICarrierMessagingCallback callback) {
            CarrierMessagingService.this.onSendMms(pduUri, subId, location, new C06675(callback));
        }

        public void downloadMms(Uri pduUri, int subId, Uri location, ICarrierMessagingCallback callback) {
            CarrierMessagingService.this.onDownloadMms(pduUri, subId, location, new C06686(callback));
        }
    }

    public static final class SendMmsResult {
        private byte[] mSendConfPdu;
        private int mSendStatus;

        public SendMmsResult(int sendStatus, byte[] sendConfPdu) {
            this.mSendStatus = sendStatus;
            this.mSendConfPdu = sendConfPdu;
        }

        public int getSendStatus() {
            return this.mSendStatus;
        }

        public byte[] getSendConfPdu() {
            return this.mSendConfPdu;
        }
    }

    public static final class SendMultipartSmsResult {
        private final int[] mMessageRefs;
        private final int mSendStatus;

        public SendMultipartSmsResult(int sendStatus, int[] messageRefs) {
            this.mSendStatus = sendStatus;
            this.mMessageRefs = messageRefs;
        }

        public int[] getMessageRefs() {
            return this.mMessageRefs;
        }

        public int getSendStatus() {
            return this.mSendStatus;
        }
    }

    public static final class SendSmsResult {
        private final int mMessageRef;
        private final int mSendStatus;

        public SendSmsResult(int sendStatus, int messageRef) {
            this.mSendStatus = sendStatus;
            this.mMessageRef = messageRef;
        }

        public int getMessageRef() {
            return this.mMessageRef;
        }

        public int getSendStatus() {
            return this.mSendStatus;
        }
    }

    public CarrierMessagingService() {
        this.mWrapper = new ICarrierMessagingWrapper();
    }

    public void onFilterSms(MessagePdu pdu, String format, int destPort, int subId, ResultCallback<Boolean> callback) {
        try {
            callback.onReceiveResult(Boolean.valueOf(true));
        } catch (RemoteException e) {
        }
    }

    public void onSendTextSms(String text, int subId, String destAddress, ResultCallback<SendSmsResult> callback) {
        try {
            callback.onReceiveResult(new SendSmsResult(SEND_STATUS_RETRY_ON_CARRIER_NETWORK, SEND_STATUS_OK));
        } catch (RemoteException e) {
        }
    }

    public void onSendDataSms(byte[] data, int subId, String destAddress, int destPort, ResultCallback<SendSmsResult> callback) {
        try {
            callback.onReceiveResult(new SendSmsResult(SEND_STATUS_RETRY_ON_CARRIER_NETWORK, SEND_STATUS_OK));
        } catch (RemoteException e) {
        }
    }

    public void onSendMultipartTextSms(List<String> list, int subId, String destAddress, ResultCallback<SendMultipartSmsResult> callback) {
        try {
            callback.onReceiveResult(new SendMultipartSmsResult(SEND_STATUS_RETRY_ON_CARRIER_NETWORK, null));
        } catch (RemoteException e) {
        }
    }

    public void onSendMms(Uri pduUri, int subId, Uri location, ResultCallback<SendMmsResult> callback) {
        try {
            callback.onReceiveResult(new SendMmsResult(SEND_STATUS_RETRY_ON_CARRIER_NETWORK, null));
        } catch (RemoteException e) {
        }
    }

    public void onDownloadMms(Uri contentUri, int subId, Uri location, ResultCallback<Integer> callback) {
        try {
            callback.onReceiveResult(Integer.valueOf(SEND_STATUS_RETRY_ON_CARRIER_NETWORK));
        } catch (RemoteException e) {
        }
    }

    public IBinder onBind(Intent intent) {
        if (SERVICE_INTERFACE.equals(intent.getAction())) {
            return this.mWrapper;
        }
        return null;
    }
}
