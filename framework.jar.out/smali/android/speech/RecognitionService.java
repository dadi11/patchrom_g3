package android.speech;

import android.app.Service;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Message;
import android.os.RemoteException;
import android.speech.IRecognitionService.Stub;
import android.util.Log;
import java.lang.ref.WeakReference;

public abstract class RecognitionService extends Service {
    private static final boolean DBG = false;
    private static final int MSG_CANCEL = 3;
    private static final int MSG_RESET = 4;
    private static final int MSG_START_LISTENING = 1;
    private static final int MSG_STOP_LISTENING = 2;
    public static final String SERVICE_INTERFACE = "android.speech.RecognitionService";
    public static final String SERVICE_META_DATA = "android.speech";
    private static final String TAG = "RecognitionService";
    private RecognitionServiceBinder mBinder;
    private Callback mCurrentCallback;
    private final Handler mHandler;

    /* renamed from: android.speech.RecognitionService.1 */
    class C07051 extends Handler {
        C07051() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case RecognitionService.MSG_START_LISTENING /*1*/:
                    StartListeningArgs args = msg.obj;
                    RecognitionService.this.dispatchStartListening(args.mIntent, args.mListener);
                case RecognitionService.MSG_STOP_LISTENING /*2*/:
                    RecognitionService.this.dispatchStopListening((IRecognitionListener) msg.obj);
                case RecognitionService.MSG_CANCEL /*3*/:
                    RecognitionService.this.dispatchCancel((IRecognitionListener) msg.obj);
                case RecognitionService.MSG_RESET /*4*/:
                    RecognitionService.this.dispatchClearCallback();
                default:
            }
        }
    }

    /* renamed from: android.speech.RecognitionService.2 */
    class C07062 implements DeathRecipient {
        final /* synthetic */ IRecognitionListener val$listener;

        C07062(IRecognitionListener iRecognitionListener) {
            this.val$listener = iRecognitionListener;
        }

        public void binderDied() {
            RecognitionService.this.mHandler.sendMessage(RecognitionService.this.mHandler.obtainMessage(RecognitionService.MSG_CANCEL, this.val$listener));
        }
    }

    public class Callback {
        private final IRecognitionListener mListener;

        private Callback(IRecognitionListener listener) {
            this.mListener = listener;
        }

        public void beginningOfSpeech() throws RemoteException {
            this.mListener.onBeginningOfSpeech();
        }

        public void bufferReceived(byte[] buffer) throws RemoteException {
            this.mListener.onBufferReceived(buffer);
        }

        public void endOfSpeech() throws RemoteException {
            this.mListener.onEndOfSpeech();
        }

        public void error(int error) throws RemoteException {
            Message.obtain(RecognitionService.this.mHandler, (int) RecognitionService.MSG_RESET).sendToTarget();
            this.mListener.onError(error);
        }

        public void partialResults(Bundle partialResults) throws RemoteException {
            this.mListener.onPartialResults(partialResults);
        }

        public void readyForSpeech(Bundle params) throws RemoteException {
            this.mListener.onReadyForSpeech(params);
        }

        public void results(Bundle results) throws RemoteException {
            Message.obtain(RecognitionService.this.mHandler, (int) RecognitionService.MSG_RESET).sendToTarget();
            this.mListener.onResults(results);
        }

        public void rmsChanged(float rmsdB) throws RemoteException {
            this.mListener.onRmsChanged(rmsdB);
        }
    }

    private static final class RecognitionServiceBinder extends Stub {
        private final WeakReference<RecognitionService> mServiceRef;

        public RecognitionServiceBinder(RecognitionService service) {
            this.mServiceRef = new WeakReference(service);
        }

        public void startListening(Intent recognizerIntent, IRecognitionListener listener) {
            RecognitionService service = (RecognitionService) this.mServiceRef.get();
            if (service != null && service.checkPermissions(listener)) {
                Handler access$400 = service.mHandler;
                Handler access$4002 = service.mHandler;
                service.getClass();
                access$400.sendMessage(Message.obtain(access$4002, RecognitionService.MSG_START_LISTENING, new StartListeningArgs(recognizerIntent, listener)));
            }
        }

        public void stopListening(IRecognitionListener listener) {
            RecognitionService service = (RecognitionService) this.mServiceRef.get();
            if (service != null && service.checkPermissions(listener)) {
                service.mHandler.sendMessage(Message.obtain(service.mHandler, RecognitionService.MSG_STOP_LISTENING, listener));
            }
        }

        public void cancel(IRecognitionListener listener) {
            RecognitionService service = (RecognitionService) this.mServiceRef.get();
            if (service != null && service.checkPermissions(listener)) {
                service.mHandler.sendMessage(Message.obtain(service.mHandler, RecognitionService.MSG_CANCEL, listener));
            }
        }

        public void clearReference() {
            this.mServiceRef.clear();
        }
    }

    private class StartListeningArgs {
        public final Intent mIntent;
        public final IRecognitionListener mListener;

        public StartListeningArgs(Intent intent, IRecognitionListener listener) {
            this.mIntent = intent;
            this.mListener = listener;
        }
    }

    protected abstract void onCancel(Callback callback);

    protected abstract void onStartListening(Intent intent, Callback callback);

    protected abstract void onStopListening(Callback callback);

    public RecognitionService() {
        this.mBinder = new RecognitionServiceBinder(this);
        this.mCurrentCallback = null;
        this.mHandler = new C07051();
    }

    private void dispatchStartListening(Intent intent, IRecognitionListener listener) {
        if (this.mCurrentCallback == null) {
            try {
                listener.asBinder().linkToDeath(new C07062(listener), 0);
                this.mCurrentCallback = new Callback(listener, null);
                onStartListening(intent, this.mCurrentCallback);
                return;
            } catch (RemoteException e) {
                Log.e(TAG, "dead listener on startListening");
                return;
            }
        }
        try {
            listener.onError(8);
        } catch (RemoteException e2) {
            Log.d(TAG, "onError call from startListening failed");
        }
        Log.i(TAG, "concurrent startListening received - ignoring this call");
    }

    private void dispatchStopListening(IRecognitionListener listener) {
        try {
            if (this.mCurrentCallback == null) {
                listener.onError(5);
                Log.w(TAG, "stopListening called with no preceding startListening - ignoring");
            } else if (this.mCurrentCallback.mListener.asBinder() != listener.asBinder()) {
                listener.onError(8);
                Log.w(TAG, "stopListening called by other caller than startListening - ignoring");
            } else {
                onStopListening(this.mCurrentCallback);
            }
        } catch (RemoteException e) {
            Log.d(TAG, "onError call from stopListening failed");
        }
    }

    private void dispatchCancel(IRecognitionListener listener) {
        if (this.mCurrentCallback != null) {
            if (this.mCurrentCallback.mListener.asBinder() != listener.asBinder()) {
                Log.w(TAG, "cancel called by client who did not call startListening - ignoring");
                return;
            }
            onCancel(this.mCurrentCallback);
            this.mCurrentCallback = null;
        }
    }

    private void dispatchClearCallback() {
        this.mCurrentCallback = null;
    }

    private boolean checkPermissions(IRecognitionListener listener) {
        if (checkCallingOrSelfPermission("android.permission.RECORD_AUDIO") == 0) {
            return true;
        }
        try {
            Log.e(TAG, "call for recognition service without RECORD_AUDIO permissions");
            listener.onError(9);
        } catch (RemoteException re) {
            Log.e(TAG, "sending ERROR_INSUFFICIENT_PERMISSIONS message failed", re);
        }
        return DBG;
    }

    public final IBinder onBind(Intent intent) {
        return this.mBinder;
    }

    public void onDestroy() {
        this.mCurrentCallback = null;
        this.mBinder.clearReference();
        super.onDestroy();
    }
}
