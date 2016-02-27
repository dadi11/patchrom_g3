package android.os;

import android.util.Printer;
import java.util.ArrayList;

public final class MessageQueue {
    private boolean mBlocked;
    private final ArrayList<IdleHandler> mIdleHandlers;
    Message mMessages;
    private int mNextBarrierToken;
    private IdleHandler[] mPendingIdleHandlers;
    private long mPtr;
    private final boolean mQuitAllowed;
    private boolean mQuitting;

    public interface IdleHandler {
        boolean queueIdle();
    }

    private static native void nativeDestroy(long j);

    private static native long nativeInit();

    private static native boolean nativeIsIdling(long j);

    private static native void nativePollOnce(long j, int i);

    private static native void nativeWake(long j);

    public void addIdleHandler(IdleHandler handler) {
        if (handler == null) {
            throw new NullPointerException("Can't add a null IdleHandler");
        }
        synchronized (this) {
            this.mIdleHandlers.add(handler);
        }
    }

    public void removeIdleHandler(IdleHandler handler) {
        synchronized (this) {
            this.mIdleHandlers.remove(handler);
        }
    }

    MessageQueue(boolean quitAllowed) {
        this.mIdleHandlers = new ArrayList();
        this.mQuitAllowed = quitAllowed;
        this.mPtr = nativeInit();
    }

    protected void finalize() throws Throwable {
        try {
            dispose();
        } finally {
            super.finalize();
        }
    }

    private void dispose() {
        if (this.mPtr != 0) {
            nativeDestroy(this.mPtr);
            this.mPtr = 0;
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    android.os.Message next() {
        /*
        r22 = this;
        r0 = r22;
        r14 = r0.mPtr;
        r18 = 0;
        r17 = (r14 > r18 ? 1 : (r14 == r18 ? 0 : -1));
        if (r17 != 0) goto L_0x000c;
    L_0x000a:
        r6 = 0;
    L_0x000b:
        return r6;
    L_0x000c:
        r9 = -1;
        r8 = 0;
    L_0x000e:
        if (r8 == 0) goto L_0x0013;
    L_0x0010:
        android.os.Binder.flushPendingCommands();
    L_0x0013:
        nativePollOnce(r14, r8);
        monitor-enter(r22);
        r10 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0065 }
        r0 = r22;
        r0 = r0.mMessages;	 Catch:{ all -> 0x0065 }
        r17 = r0;
        if (r17 == 0) goto L_0x0068;
    L_0x0023:
        r16 = 1;
    L_0x0025:
        r12 = 0;
        r0 = r22;
        r6 = r0.mMessages;	 Catch:{ all -> 0x0065 }
        if (r6 == 0) goto L_0x003d;
    L_0x002c:
        r0 = r6.target;	 Catch:{ all -> 0x0065 }
        r17 = r0;
        if (r17 != 0) goto L_0x003d;
    L_0x0032:
        r12 = r6;
        r6 = r6.next;	 Catch:{ all -> 0x0065 }
        if (r6 == 0) goto L_0x003d;
    L_0x0037:
        r17 = r6.isAsynchronous();	 Catch:{ all -> 0x0065 }
        if (r17 == 0) goto L_0x0032;
    L_0x003d:
        if (r6 == 0) goto L_0x0090;
    L_0x003f:
        r0 = r6.when;	 Catch:{ all -> 0x0065 }
        r18 = r0;
        r17 = (r10 > r18 ? 1 : (r10 == r18 ? 0 : -1));
        if (r17 >= 0) goto L_0x006b;
    L_0x0047:
        r0 = r6.when;	 Catch:{ all -> 0x0065 }
        r18 = r0;
        r18 = r18 - r10;
        r20 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        r18 = java.lang.Math.min(r18, r20);	 Catch:{ all -> 0x0065 }
        r0 = r18;
        r8 = (int) r0;	 Catch:{ all -> 0x0065 }
    L_0x0057:
        r0 = r22;
        r0 = r0.mQuitting;	 Catch:{ all -> 0x0065 }
        r17 = r0;
        if (r17 == 0) goto L_0x00a7;
    L_0x005f:
        r22.dispose();	 Catch:{ all -> 0x0065 }
        r6 = 0;
        monitor-exit(r22);	 Catch:{ all -> 0x0065 }
        goto L_0x000b;
    L_0x0065:
        r17 = move-exception;
        monitor-exit(r22);	 Catch:{ all -> 0x0065 }
        throw r17;
    L_0x0068:
        r16 = 0;
        goto L_0x0025;
    L_0x006b:
        r17 = 0;
        r0 = r17;
        r1 = r22;
        r1.mBlocked = r0;	 Catch:{ all -> 0x0065 }
        if (r12 == 0) goto L_0x0085;
    L_0x0075:
        r0 = r6.next;	 Catch:{ all -> 0x0065 }
        r17 = r0;
        r0 = r17;
        r12.next = r0;	 Catch:{ all -> 0x0065 }
    L_0x007d:
        r17 = 0;
        r0 = r17;
        r6.next = r0;	 Catch:{ all -> 0x0065 }
        monitor-exit(r22);	 Catch:{ all -> 0x0065 }
        goto L_0x000b;
    L_0x0085:
        r0 = r6.next;	 Catch:{ all -> 0x0065 }
        r17 = r0;
        r0 = r17;
        r1 = r22;
        r1.mMessages = r0;	 Catch:{ all -> 0x0065 }
        goto L_0x007d;
    L_0x0090:
        r0 = r22;
        r7 = r0.mMessages;	 Catch:{ all -> 0x0065 }
        r2 = 0;
    L_0x0095:
        if (r7 == 0) goto L_0x009e;
    L_0x0097:
        r0 = r7.target;	 Catch:{ all -> 0x0065 }
        r17 = r0;
        if (r17 == 0) goto L_0x00a4;
    L_0x009d:
        r2 = 1;
    L_0x009e:
        if (r2 != 0) goto L_0x00a2;
    L_0x00a0:
        r16 = 0;
    L_0x00a2:
        r8 = -1;
        goto L_0x0057;
    L_0x00a4:
        r7 = r7.next;	 Catch:{ all -> 0x0065 }
        goto L_0x0095;
    L_0x00a7:
        if (r9 >= 0) goto L_0x00c5;
    L_0x00a9:
        if (r16 == 0) goto L_0x00bb;
    L_0x00ab:
        r0 = r22;
        r0 = r0.mMessages;	 Catch:{ all -> 0x0065 }
        r17 = r0;
        r0 = r17;
        r0 = r0.when;	 Catch:{ all -> 0x0065 }
        r18 = r0;
        r17 = (r10 > r18 ? 1 : (r10 == r18 ? 0 : -1));
        if (r17 >= 0) goto L_0x00c5;
    L_0x00bb:
        r0 = r22;
        r0 = r0.mIdleHandlers;	 Catch:{ all -> 0x0065 }
        r17 = r0;
        r9 = r17.size();	 Catch:{ all -> 0x0065 }
    L_0x00c5:
        if (r9 > 0) goto L_0x00d2;
    L_0x00c7:
        r17 = 1;
        r0 = r17;
        r1 = r22;
        r1.mBlocked = r0;	 Catch:{ all -> 0x0065 }
        monitor-exit(r22);	 Catch:{ all -> 0x0065 }
        goto L_0x000e;
    L_0x00d2:
        r0 = r22;
        r0 = r0.mPendingIdleHandlers;	 Catch:{ all -> 0x0065 }
        r17 = r0;
        if (r17 != 0) goto L_0x00ee;
    L_0x00da:
        r17 = 4;
        r0 = r17;
        r17 = java.lang.Math.max(r9, r0);	 Catch:{ all -> 0x0065 }
        r0 = r17;
        r0 = new android.os.MessageQueue.IdleHandler[r0];	 Catch:{ all -> 0x0065 }
        r17 = r0;
        r0 = r17;
        r1 = r22;
        r1.mPendingIdleHandlers = r0;	 Catch:{ all -> 0x0065 }
    L_0x00ee:
        r0 = r22;
        r0 = r0.mIdleHandlers;	 Catch:{ all -> 0x0065 }
        r17 = r0;
        r0 = r22;
        r0 = r0.mPendingIdleHandlers;	 Catch:{ all -> 0x0065 }
        r18 = r0;
        r17 = r17.toArray(r18);	 Catch:{ all -> 0x0065 }
        r17 = (android.os.MessageQueue.IdleHandler[]) r17;	 Catch:{ all -> 0x0065 }
        r0 = r17;
        r1 = r22;
        r1.mPendingIdleHandlers = r0;	 Catch:{ all -> 0x0065 }
        monitor-exit(r22);	 Catch:{ all -> 0x0065 }
        r3 = 0;
    L_0x0108:
        if (r3 >= r9) goto L_0x0143;
    L_0x010a:
        r0 = r22;
        r0 = r0.mPendingIdleHandlers;
        r17 = r0;
        r4 = r17[r3];
        r0 = r22;
        r0 = r0.mPendingIdleHandlers;
        r17 = r0;
        r18 = 0;
        r17[r3] = r18;
        r5 = 0;
        r5 = r4.queueIdle();	 Catch:{ Throwable -> 0x0133 }
    L_0x0121:
        if (r5 != 0) goto L_0x0130;
    L_0x0123:
        monitor-enter(r22);
        r0 = r22;
        r0 = r0.mIdleHandlers;	 Catch:{ all -> 0x0140 }
        r17 = r0;
        r0 = r17;
        r0.remove(r4);	 Catch:{ all -> 0x0140 }
        monitor-exit(r22);	 Catch:{ all -> 0x0140 }
    L_0x0130:
        r3 = r3 + 1;
        goto L_0x0108;
    L_0x0133:
        r13 = move-exception;
        r17 = "MessageQueue";
        r18 = "IdleHandler threw exception";
        r0 = r17;
        r1 = r18;
        android.util.Log.wtf(r0, r1, r13);
        goto L_0x0121;
    L_0x0140:
        r17 = move-exception;
        monitor-exit(r22);	 Catch:{ all -> 0x0140 }
        throw r17;
    L_0x0143:
        r9 = 0;
        r8 = 0;
        goto L_0x000e;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.os.MessageQueue.next():android.os.Message");
    }

    void quit(boolean safe) {
        if (this.mQuitAllowed) {
            synchronized (this) {
                if (this.mQuitting) {
                    return;
                }
                this.mQuitting = true;
                if (safe) {
                    removeAllFutureMessagesLocked();
                } else {
                    removeAllMessagesLocked();
                }
                nativeWake(this.mPtr);
                return;
            }
        }
        throw new IllegalStateException("Main thread not allowed to quit.");
    }

    int enqueueSyncBarrier(long when) {
        int token;
        synchronized (this) {
            token = this.mNextBarrierToken;
            this.mNextBarrierToken = token + 1;
            Message msg = Message.obtain();
            msg.markInUse();
            msg.when = when;
            msg.arg1 = token;
            Message prev = null;
            Message p = this.mMessages;
            if (when != 0) {
                while (p != null && p.when <= when) {
                    prev = p;
                    p = p.next;
                }
            }
            if (prev != null) {
                msg.next = p;
                prev.next = msg;
            } else {
                msg.next = p;
                this.mMessages = msg;
            }
        }
        return token;
    }

    void removeSyncBarrier(int token) {
        synchronized (this) {
            Message prev = null;
            Message p = this.mMessages;
            while (p != null && (p.target != null || p.arg1 != token)) {
                prev = p;
                p = p.next;
            }
            if (p == null) {
                throw new IllegalStateException("The specified message queue synchronization  barrier token has not been posted or has already been removed.");
            }
            boolean needWake;
            if (prev != null) {
                prev.next = p.next;
                needWake = false;
            } else {
                this.mMessages = p.next;
                needWake = this.mMessages == null || this.mMessages.target != null;
            }
            p.recycleUnchecked();
            if (needWake && !this.mQuitting) {
                nativeWake(this.mPtr);
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    boolean enqueueMessage(android.os.Message r9, long r10) {
        /*
        r8 = this;
        r4 = 1;
        r1 = 0;
        r5 = r9.target;
        if (r5 != 0) goto L_0x000e;
    L_0x0006:
        r4 = new java.lang.IllegalArgumentException;
        r5 = "Message must have a target.";
        r4.<init>(r5);
        throw r4;
    L_0x000e:
        r5 = r9.isInUse();
        if (r5 == 0) goto L_0x002d;
    L_0x0014:
        r4 = new java.lang.IllegalStateException;
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r5 = r5.append(r9);
        r6 = " This message is already in use.";
        r5 = r5.append(r6);
        r5 = r5.toString();
        r4.<init>(r5);
        throw r4;
    L_0x002d:
        monitor-enter(r8);
        r5 = r8.mQuitting;	 Catch:{ all -> 0x009e }
        if (r5 == 0) goto L_0x005a;
    L_0x0032:
        r0 = new java.lang.IllegalStateException;	 Catch:{ all -> 0x009e }
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009e }
        r4.<init>();	 Catch:{ all -> 0x009e }
        r5 = r9.target;	 Catch:{ all -> 0x009e }
        r4 = r4.append(r5);	 Catch:{ all -> 0x009e }
        r5 = " sending message to a Handler on a dead thread";
        r4 = r4.append(r5);	 Catch:{ all -> 0x009e }
        r4 = r4.toString();	 Catch:{ all -> 0x009e }
        r0.<init>(r4);	 Catch:{ all -> 0x009e }
        r4 = "MessageQueue";
        r5 = r0.getMessage();	 Catch:{ all -> 0x009e }
        android.util.Log.w(r4, r5, r0);	 Catch:{ all -> 0x009e }
        r9.recycle();	 Catch:{ all -> 0x009e }
        monitor-exit(r8);	 Catch:{ all -> 0x009e }
    L_0x0059:
        return r1;
    L_0x005a:
        r9.markInUse();	 Catch:{ all -> 0x009e }
        r9.when = r10;	 Catch:{ all -> 0x009e }
        r2 = r8.mMessages;	 Catch:{ all -> 0x009e }
        if (r2 == 0) goto L_0x006f;
    L_0x0063:
        r6 = 0;
        r5 = (r10 > r6 ? 1 : (r10 == r6 ? 0 : -1));
        if (r5 == 0) goto L_0x006f;
    L_0x0069:
        r6 = r2.when;	 Catch:{ all -> 0x009e }
        r5 = (r10 > r6 ? 1 : (r10 == r6 ? 0 : -1));
        if (r5 >= 0) goto L_0x007f;
    L_0x006f:
        r9.next = r2;	 Catch:{ all -> 0x009e }
        r8.mMessages = r9;	 Catch:{ all -> 0x009e }
        r1 = r8.mBlocked;	 Catch:{ all -> 0x009e }
    L_0x0075:
        if (r1 == 0) goto L_0x007c;
    L_0x0077:
        r6 = r8.mPtr;	 Catch:{ all -> 0x009e }
        nativeWake(r6);	 Catch:{ all -> 0x009e }
    L_0x007c:
        monitor-exit(r8);	 Catch:{ all -> 0x009e }
        r1 = r4;
        goto L_0x0059;
    L_0x007f:
        r5 = r8.mBlocked;	 Catch:{ all -> 0x009e }
        if (r5 == 0) goto L_0x008e;
    L_0x0083:
        r5 = r2.target;	 Catch:{ all -> 0x009e }
        if (r5 != 0) goto L_0x008e;
    L_0x0087:
        r5 = r9.isAsynchronous();	 Catch:{ all -> 0x009e }
        if (r5 == 0) goto L_0x008e;
    L_0x008d:
        r1 = r4;
    L_0x008e:
        r3 = r2;
        r2 = r2.next;	 Catch:{ all -> 0x009e }
        if (r2 == 0) goto L_0x0099;
    L_0x0093:
        r6 = r2.when;	 Catch:{ all -> 0x009e }
        r5 = (r10 > r6 ? 1 : (r10 == r6 ? 0 : -1));
        if (r5 >= 0) goto L_0x00a1;
    L_0x0099:
        r9.next = r2;	 Catch:{ all -> 0x009e }
        r3.next = r9;	 Catch:{ all -> 0x009e }
        goto L_0x0075;
    L_0x009e:
        r4 = move-exception;
        monitor-exit(r8);	 Catch:{ all -> 0x009e }
        throw r4;
    L_0x00a1:
        if (r1 == 0) goto L_0x008e;
    L_0x00a3:
        r5 = r2.isAsynchronous();	 Catch:{ all -> 0x009e }
        if (r5 == 0) goto L_0x008e;
    L_0x00a9:
        r1 = 0;
        goto L_0x008e;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.os.MessageQueue.enqueueMessage(android.os.Message, long):boolean");
    }

    boolean hasMessages(Handler h, int what, Object object) {
        boolean z = false;
        if (h != null) {
            synchronized (this) {
                Message p = this.mMessages;
                while (p != null) {
                    if (p.target == h && p.what == what && (object == null || p.obj == object)) {
                        z = true;
                        break;
                    }
                    p = p.next;
                }
            }
        }
        return z;
    }

    boolean hasMessages(Handler h, Runnable r, Object object) {
        boolean z = false;
        if (h != null) {
            synchronized (this) {
                Message p = this.mMessages;
                while (p != null) {
                    if (p.target == h && p.callback == r && (object == null || p.obj == object)) {
                        z = true;
                        break;
                    }
                    p = p.next;
                }
            }
        }
        return z;
    }

    boolean isIdling() {
        boolean isIdlingLocked;
        synchronized (this) {
            isIdlingLocked = isIdlingLocked();
        }
        return isIdlingLocked;
    }

    private boolean isIdlingLocked() {
        return !this.mQuitting && nativeIsIdling(this.mPtr);
    }

    void removeMessages(Handler h, int what, Object object) {
        if (h != null) {
            synchronized (this) {
                Message n;
                Message p = this.mMessages;
                while (p != null && p.target == h && p.what == what && (object == null || p.obj == object)) {
                    n = p.next;
                    this.mMessages = n;
                    p.recycleUnchecked();
                    p = n;
                }
                while (p != null) {
                    n = p.next;
                    if (n != null && n.target == h && n.what == what && (object == null || n.obj == object)) {
                        Message nn = n.next;
                        n.recycleUnchecked();
                        p.next = nn;
                    } else {
                        p = n;
                    }
                }
            }
        }
    }

    void removeMessages(Handler h, Runnable r, Object object) {
        if (h != null && r != null) {
            synchronized (this) {
                Message n;
                Message p = this.mMessages;
                while (p != null && p.target == h && p.callback == r && (object == null || p.obj == object)) {
                    n = p.next;
                    this.mMessages = n;
                    p.recycleUnchecked();
                    p = n;
                }
                while (p != null) {
                    n = p.next;
                    if (n != null && n.target == h && n.callback == r && (object == null || n.obj == object)) {
                        Message nn = n.next;
                        n.recycleUnchecked();
                        p.next = nn;
                    } else {
                        p = n;
                    }
                }
            }
        }
    }

    void removeCallbacksAndMessages(Handler h, Object object) {
        if (h != null) {
            synchronized (this) {
                Message n;
                Message p = this.mMessages;
                while (p != null && p.target == h && (object == null || p.obj == object)) {
                    n = p.next;
                    this.mMessages = n;
                    p.recycleUnchecked();
                    p = n;
                }
                while (p != null) {
                    n = p.next;
                    if (n != null && n.target == h && (object == null || n.obj == object)) {
                        Message nn = n.next;
                        n.recycleUnchecked();
                        p.next = nn;
                    } else {
                        p = n;
                    }
                }
            }
        }
    }

    private void removeAllMessagesLocked() {
        Message p = this.mMessages;
        while (p != null) {
            Message n = p.next;
            p.recycleUnchecked();
            p = n;
        }
        this.mMessages = null;
    }

    private void removeAllFutureMessagesLocked() {
        long now = SystemClock.uptimeMillis();
        Message p = this.mMessages;
        if (p == null) {
            return;
        }
        if (p.when > now) {
            removeAllMessagesLocked();
            return;
        }
        while (true) {
            Message n = p.next;
            if (n == null) {
                return;
            }
            if (n.when > now) {
                break;
            }
            p = n;
        }
        p.next = null;
        do {
            p = n;
            n = p.next;
            p.recycleUnchecked();
        } while (n != null);
    }

    void dump(Printer pw, String prefix) {
        synchronized (this) {
            long now = SystemClock.uptimeMillis();
            int n = 0;
            for (Message msg = this.mMessages; msg != null; msg = msg.next) {
                pw.println(prefix + "Message " + n + ": " + msg.toString(now));
                n++;
            }
            pw.println(prefix + "(Total messages: " + n + ", idling=" + isIdlingLocked() + ", quitting=" + this.mQuitting + ")");
        }
    }
}
