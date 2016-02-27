package android.os;

public abstract class CountDownTimer {
    private static final int MSG = 1;
    private boolean mCancelled;
    private final long mCountdownInterval;
    private Handler mHandler;
    private final long mMillisInFuture;
    private long mStopTimeInFuture;

    /* renamed from: android.os.CountDownTimer.1 */
    class C05881 extends Handler {
        C05881() {
        }

        public void handleMessage(Message msg) {
            synchronized (CountDownTimer.this) {
                if (CountDownTimer.this.mCancelled) {
                    return;
                }
                long millisLeft = CountDownTimer.this.mStopTimeInFuture - SystemClock.elapsedRealtime();
                if (millisLeft <= 0) {
                    CountDownTimer.this.onFinish();
                } else if (millisLeft < CountDownTimer.this.mCountdownInterval) {
                    sendMessageDelayed(obtainMessage(CountDownTimer.MSG), millisLeft);
                } else {
                    long lastTickStart = SystemClock.elapsedRealtime();
                    CountDownTimer.this.onTick(millisLeft);
                    long delay = (CountDownTimer.this.mCountdownInterval + lastTickStart) - SystemClock.elapsedRealtime();
                    while (delay < 0) {
                        delay += CountDownTimer.this.mCountdownInterval;
                    }
                    sendMessageDelayed(obtainMessage(CountDownTimer.MSG), delay);
                }
            }
        }
    }

    public abstract void onFinish();

    public abstract void onTick(long j);

    public CountDownTimer(long millisInFuture, long countDownInterval) {
        this.mCancelled = false;
        this.mHandler = new C05881();
        this.mMillisInFuture = millisInFuture;
        this.mCountdownInterval = countDownInterval;
    }

    public final synchronized void cancel() {
        this.mCancelled = true;
        this.mHandler.removeMessages(MSG);
    }

    public final synchronized CountDownTimer start() {
        CountDownTimer this;
        this.mCancelled = false;
        if (this.mMillisInFuture <= 0) {
            onFinish();
            this = this;
        } else {
            this.mStopTimeInFuture = SystemClock.elapsedRealtime() + this.mMillisInFuture;
            this.mHandler.sendMessage(this.mHandler.obtainMessage(MSG));
            this = this;
        }
        return this;
    }
}
