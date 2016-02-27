package com.android.server.am;

final class AppErrorResult {
    boolean mHasResult;
    int mResult;

    AppErrorResult() {
        this.mHasResult = false;
    }

    public void set(int res) {
        synchronized (this) {
            this.mHasResult = true;
            this.mResult = res;
            notifyAll();
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public int get() {
        /*
        r1 = this;
        monitor-enter(r1);
    L_0x0001:
        r0 = r1.mHasResult;	 Catch:{ all -> 0x000f }
        if (r0 != 0) goto L_0x000b;
    L_0x0005:
        r1.wait();	 Catch:{ InterruptedException -> 0x0009 }
        goto L_0x0001;
    L_0x0009:
        r0 = move-exception;
        goto L_0x0001;
    L_0x000b:
        monitor-exit(r1);	 Catch:{ all -> 0x000f }
        r0 = r1.mResult;
        return r0;
    L_0x000f:
        r0 = move-exception;
        monitor-exit(r1);	 Catch:{ all -> 0x000f }
        throw r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.AppErrorResult.get():int");
    }
}
