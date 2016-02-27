package android.service.voice;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.service.voice.IVoiceInteractionSessionService.Stub;
import com.android.internal.app.IVoiceInteractionManagerService;
import com.android.internal.os.HandlerCaller;
import com.android.internal.os.HandlerCaller.Callback;
import com.android.internal.os.SomeArgs;

public abstract class VoiceInteractionSessionService extends Service {
    static final int MSG_NEW_SESSION = 1;
    HandlerCaller mHandlerCaller;
    final Callback mHandlerCallerCallback;
    IVoiceInteractionSessionService mInterface;
    VoiceInteractionSession mSession;
    IVoiceInteractionManagerService mSystemService;

    /* renamed from: android.service.voice.VoiceInteractionSessionService.1 */
    class C07001 extends Stub {
        C07001() {
        }

        public void newSession(IBinder token, Bundle args) {
            VoiceInteractionSessionService.this.mHandlerCaller.sendMessage(VoiceInteractionSessionService.this.mHandlerCaller.obtainMessageOO(VoiceInteractionSessionService.MSG_NEW_SESSION, token, args));
        }
    }

    /* renamed from: android.service.voice.VoiceInteractionSessionService.2 */
    class C07012 implements Callback {
        C07012() {
        }

        public void executeMessage(Message msg) {
            SomeArgs args = msg.obj;
            switch (msg.what) {
                case VoiceInteractionSessionService.MSG_NEW_SESSION /*1*/:
                    VoiceInteractionSessionService.this.doNewSession((IBinder) args.arg1, (Bundle) args.arg2);
                default:
            }
        }
    }

    public abstract VoiceInteractionSession onNewSession(Bundle bundle);

    public VoiceInteractionSessionService() {
        this.mInterface = new C07001();
        this.mHandlerCallerCallback = new C07012();
    }

    public void onCreate() {
        super.onCreate();
        this.mSystemService = IVoiceInteractionManagerService.Stub.asInterface(ServiceManager.getService(Context.VOICE_INTERACTION_MANAGER_SERVICE));
        this.mHandlerCaller = new HandlerCaller(this, Looper.myLooper(), this.mHandlerCallerCallback, true);
    }

    public IBinder onBind(Intent intent) {
        return this.mInterface.asBinder();
    }

    void doNewSession(IBinder token, Bundle args) {
        if (this.mSession != null) {
            this.mSession.doDestroy();
            this.mSession = null;
        }
        this.mSession = onNewSession(args);
        try {
            this.mSystemService.deliverNewSession(token, this.mSession.mSession, this.mSession.mInteractor);
            this.mSession.doCreate(this.mSystemService, token, args);
        } catch (RemoteException e) {
        }
    }
}
