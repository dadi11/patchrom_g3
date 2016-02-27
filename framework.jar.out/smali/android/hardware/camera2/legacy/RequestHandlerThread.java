package android.hardware.camera2.legacy;

import android.os.ConditionVariable;
import android.os.Handler;
import android.os.Handler.Callback;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.MessageQueue.IdleHandler;

public class RequestHandlerThread extends HandlerThread {
    public static final int MSG_POKE_IDLE_HANDLER = -1;
    private Callback mCallback;
    private volatile Handler mHandler;
    private final ConditionVariable mIdle;
    private final IdleHandler mIdleHandler;
    private final ConditionVariable mStarted;

    /* renamed from: android.hardware.camera2.legacy.RequestHandlerThread.1 */
    class C02641 implements IdleHandler {
        C02641() {
        }

        public boolean queueIdle() {
            RequestHandlerThread.this.mIdle.open();
            return false;
        }
    }

    public RequestHandlerThread(String name, Callback callback) {
        super(name, 10);
        this.mStarted = new ConditionVariable(false);
        this.mIdle = new ConditionVariable(true);
        this.mIdleHandler = new C02641();
        this.mCallback = callback;
    }

    protected void onLooperPrepared() {
        this.mHandler = new Handler(getLooper(), this.mCallback);
        this.mStarted.open();
    }

    public void waitUntilStarted() {
        this.mStarted.block();
    }

    public Handler getHandler() {
        return this.mHandler;
    }

    public Handler waitAndGetHandler() {
        waitUntilStarted();
        return getHandler();
    }

    public boolean hasAnyMessages(int[] what) {
        synchronized (this.mHandler.getLooper().getQueue()) {
            for (int i : what) {
                if (this.mHandler.hasMessages(i)) {
                    return true;
                }
            }
            return false;
        }
    }

    public void removeMessages(int[] what) {
        synchronized (this.mHandler.getLooper().getQueue()) {
            for (int i : what) {
                this.mHandler.removeMessages(i);
            }
        }
    }

    public void waitUntilIdle() {
        Handler handler = waitAndGetHandler();
        Looper looper = handler.getLooper();
        if (!looper.isIdling()) {
            this.mIdle.close();
            looper.getQueue().addIdleHandler(this.mIdleHandler);
            handler.sendEmptyMessage(MSG_POKE_IDLE_HANDLER);
            if (!looper.isIdling()) {
                this.mIdle.block();
            }
        }
    }
}
