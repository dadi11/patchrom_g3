package android.os;

public class ConditionVariable {
    private volatile boolean mCondition;

    public ConditionVariable() {
        this.mCondition = false;
    }

    public ConditionVariable(boolean state) {
        this.mCondition = state;
    }

    public void open() {
        synchronized (this) {
            boolean old = this.mCondition;
            this.mCondition = true;
            if (!old) {
                notifyAll();
            }
        }
    }

    public void close() {
        synchronized (this) {
            this.mCondition = false;
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void block() {
        /*
        r1 = this;
        monitor-enter(r1);
    L_0x0001:
        r0 = r1.mCondition;	 Catch:{ all -> 0x000d }
        if (r0 != 0) goto L_0x000b;
    L_0x0005:
        r1.wait();	 Catch:{ InterruptedException -> 0x0009 }
        goto L_0x0001;
    L_0x0009:
        r0 = move-exception;
        goto L_0x0001;
    L_0x000b:
        monitor-exit(r1);	 Catch:{ all -> 0x000d }
        return;
    L_0x000d:
        r0 = move-exception;
        monitor-exit(r1);	 Catch:{ all -> 0x000d }
        throw r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.os.ConditionVariable.block():void");
    }

    public boolean block(long timeout) {
        if (timeout != 0) {
            boolean z;
            synchronized (this) {
                long now = System.currentTimeMillis();
                long end = now + timeout;
                while (!this.mCondition && now < end) {
                    try {
                        wait(end - now);
                    } catch (InterruptedException e) {
                    }
                    now = System.currentTimeMillis();
                }
                z = this.mCondition;
            }
            return z;
        }
        block();
        return true;
    }
}
