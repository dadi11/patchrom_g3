package com.android.server;

import java.util.ArrayList;
import java.util.List;

public class PermissionDialogReqQueue {
    private PermissionDialog mDialog;
    private List<PermissionDialogReq> resultList;

    public static final class PermissionDialogReq {
        boolean mHasResult;
        int mResult;

        public PermissionDialogReq() {
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
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.PermissionDialogReqQueue.PermissionDialogReq.get():int");
        }
    }

    public PermissionDialog getDialog() {
        return this.mDialog;
    }

    public void setDialog(PermissionDialog mDialog) {
        this.mDialog = mDialog;
    }

    public PermissionDialogReqQueue() {
        this.mDialog = null;
        this.resultList = new ArrayList();
    }

    public void register(PermissionDialogReq res) {
        synchronized (this) {
            this.resultList.add(res);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyAll(int r4) {
        /*
        r3 = this;
        monitor-enter(r3);
    L_0x0001:
        r1 = r3.resultList;	 Catch:{ all -> 0x001c }
        r1 = r1.size();	 Catch:{ all -> 0x001c }
        if (r1 == 0) goto L_0x001f;
    L_0x0009:
        r1 = r3.resultList;	 Catch:{ all -> 0x001c }
        r2 = 0;
        r0 = r1.get(r2);	 Catch:{ all -> 0x001c }
        r0 = (com.android.server.PermissionDialogReqQueue.PermissionDialogReq) r0;	 Catch:{ all -> 0x001c }
        r0.set(r4);	 Catch:{ all -> 0x001c }
        r1 = r3.resultList;	 Catch:{ all -> 0x001c }
        r2 = 0;
        r1.remove(r2);	 Catch:{ all -> 0x001c }
        goto L_0x0001;
    L_0x001c:
        r1 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x001c }
        throw r1;
    L_0x001f:
        monitor-exit(r3);	 Catch:{ all -> 0x001c }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.PermissionDialogReqQueue.notifyAll(int):void");
    }
}
