package com.android.server;

import android.app.ActivityManager;
import android.app.ActivityThread;
import android.app.AppOpsManager;
import android.app.AppOpsManager.OpEntry;
import android.app.AppOpsManager.PackageOps;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.media.AudioAttributes;
import android.os.AsyncTask;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Process;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.UserHandle;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.AtomicFile;
import android.util.Log;
import android.util.Pair;
import android.util.Slog;
import android.util.SparseArray;
import android.util.TimeUtils;
import com.android.internal.app.IAppOpsCallback;
import com.android.internal.app.IAppOpsService.Stub;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.util.XmlUtils;
import com.android.server.PermissionDialogReqQueue.PermissionDialogReq;
import java.io.File;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class AppOpsService extends Stub {
    static final boolean DEBUG = false;
    static final String DEFAULT_POLICY_FILE = "/system/etc/appops_policy.xml";
    static final String TAG = "AppOps";
    static final long WRITE_DELAY = 1800000;
    final SparseArray<SparseArray<Restriction>> mAudioRestrictions;
    final ArrayMap<IBinder, ClientState> mClients;
    Context mContext;
    boolean mFastWriteScheduled;
    final AtomicFile mFile;
    final Handler mHandler;
    SparseArray<String> mLoadPrivLaterPkgs;
    final Looper mLooper;
    final ArrayMap<IBinder, Callback> mModeWatchers;
    final SparseArray<ArrayList<Callback>> mOpModeWatchers;
    private final SparseArray<boolean[]> mOpRestrictions;
    final ArrayMap<String, ArrayList<Callback>> mPackageModeWatchers;
    AppOpsPolicy mPolicy;
    final boolean mStrictEnable;
    final SparseArray<HashMap<String, Ops>> mUidOps;
    final Runnable mWriteRunner;
    boolean mWriteScheduled;

    /* renamed from: com.android.server.AppOpsService.1 */
    class C00041 implements Runnable {

        /* renamed from: com.android.server.AppOpsService.1.1 */
        class C00031 extends AsyncTask<Void, Void, Void> {
            C00031() {
            }

            protected Void doInBackground(Void... params) {
                AppOpsService.this.writeState();
                return null;
            }
        }

        C00041() {
        }

        public void run() {
            synchronized (AppOpsService.this) {
                AppOpsService.this.mWriteScheduled = AppOpsService.DEBUG;
                AppOpsService.this.mFastWriteScheduled = AppOpsService.DEBUG;
                new C00031().executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, (Void[]) null);
            }
        }
    }

    final class AskRunnable implements Runnable {
        final int code;
        final Op op;
        final String packageName;
        final PermissionDialogReq request;
        final int uid;

        public AskRunnable(int code, int uid, String packageName, Op op, PermissionDialogReq request) {
            this.code = code;
            this.uid = uid;
            this.packageName = packageName;
            this.op = op;
            this.request = request;
        }

        public void run() {
            Throwable th;
            synchronized (AppOpsService.this) {
                PermissionDialog permDialog;
                try {
                    Log.e(AppOpsService.TAG, "Creating dialog box");
                    this.op.dialogReqQueue.register(this.request);
                    if (this.op.dialogReqQueue.getDialog() == null) {
                        permDialog = new PermissionDialog(AppOpsService.this.mContext, AppOpsService.this, this.code, this.uid, this.packageName);
                        try {
                            this.op.dialogReqQueue.setDialog(permDialog);
                        } catch (Throwable th2) {
                            th = th2;
                            throw th;
                        }
                    }
                    permDialog = null;
                    if (permDialog != null) {
                        permDialog.show();
                    }
                } catch (Throwable th3) {
                    th = th3;
                    permDialog = null;
                    throw th;
                }
            }
        }
    }

    public final class Callback implements DeathRecipient {
        final IAppOpsCallback mCallback;

        public Callback(IAppOpsCallback callback) {
            this.mCallback = callback;
            try {
                this.mCallback.asBinder().linkToDeath(this, 0);
            } catch (RemoteException e) {
            }
        }

        public void unlinkToDeath() {
            this.mCallback.asBinder().unlinkToDeath(this, 0);
        }

        public void binderDied() {
            AppOpsService.this.stopWatchingMode(this.mCallback);
        }
    }

    public final class ClientState extends Binder implements DeathRecipient {
        final IBinder mAppToken;
        final int mPid;
        final ArrayList<Op> mStartedOps;

        public ClientState(IBinder appToken) {
            this.mAppToken = appToken;
            this.mPid = Binder.getCallingPid();
            if (appToken instanceof Binder) {
                this.mStartedOps = null;
                return;
            }
            this.mStartedOps = new ArrayList();
            try {
                this.mAppToken.linkToDeath(this, 0);
            } catch (RemoteException e) {
            }
        }

        public String toString() {
            return "ClientState{mAppToken=" + this.mAppToken + ", " + (this.mStartedOps != null ? "pid=" + this.mPid : "local") + '}';
        }

        public void binderDied() {
            synchronized (AppOpsService.this) {
                for (int i = this.mStartedOps.size() - 1; i >= 0; i--) {
                    AppOpsService.this.finishOperationLocked((Op) this.mStartedOps.get(i));
                }
                AppOpsService.this.mClients.remove(this.mAppToken);
            }
        }
    }

    public static final class Op {
        final ArrayList<IBinder> clientTokens;
        public PermissionDialogReqQueue dialogReqQueue;
        public int duration;
        public int mode;
        public int nesting;
        public int noteOpCount;
        public final int op;
        public final String packageName;
        public long rejectTime;
        public int startOpCount;
        public long time;
        public final int uid;

        public Op(int _uid, String _packageName, int _op, int _mode) {
            this.uid = _uid;
            this.packageName = _packageName;
            this.op = _op;
            this.mode = _mode;
            this.dialogReqQueue = new PermissionDialogReqQueue();
            this.clientTokens = new ArrayList();
        }
    }

    public static final class Ops extends SparseArray<Op> {
        public final boolean isPrivileged;
        public final String packageName;
        public final int uid;

        public Ops(String _packageName, int _uid, boolean _isPrivileged) {
            this.packageName = _packageName;
            this.uid = _uid;
            this.isPrivileged = _isPrivileged;
        }
    }

    private static final class Restriction {
        private static final ArraySet<String> NO_EXCEPTIONS;
        ArraySet<String> exceptionPackages;
        int mode;

        private Restriction() {
            this.exceptionPackages = NO_EXCEPTIONS;
        }

        static {
            NO_EXCEPTIONS = new ArraySet();
        }
    }

    public AppOpsService(File storagePath, Handler handler) {
        this.mWriteRunner = new C00041();
        this.mUidOps = new SparseArray();
        this.mOpRestrictions = new SparseArray();
        this.mOpModeWatchers = new SparseArray();
        this.mPackageModeWatchers = new ArrayMap();
        this.mModeWatchers = new ArrayMap();
        this.mAudioRestrictions = new SparseArray();
        this.mClients = new ArrayMap();
        this.mFile = new AtomicFile(storagePath);
        this.mHandler = handler;
        this.mLooper = Looper.myLooper();
        this.mStrictEnable = AppOpsManager.isStrictEnable();
        readState();
    }

    public void publish(Context context) {
        this.mContext = context;
        readPolicy();
        ServiceManager.addService("appops", asBinder());
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void systemReady() {
        /*
        r17 = this;
        monitor-enter(r17);
        r2 = 0;
        r5 = 0;
    L_0x0003:
        r0 = r17;
        r14 = r0.mUidOps;	 Catch:{ all -> 0x0126 }
        r14 = r14.size();	 Catch:{ all -> 0x0126 }
        if (r5 >= r14) goto L_0x0092;
    L_0x000d:
        r0 = r17;
        r14 = r0.mUidOps;	 Catch:{ all -> 0x0126 }
        r12 = r14.valueAt(r5);	 Catch:{ all -> 0x0126 }
        r12 = (java.util.HashMap) r12;	 Catch:{ all -> 0x0126 }
        r14 = r12.values();	 Catch:{ all -> 0x0126 }
        r6 = r14.iterator();	 Catch:{ all -> 0x0126 }
    L_0x001f:
        r14 = r6.hasNext();	 Catch:{ all -> 0x0126 }
        if (r14 == 0) goto L_0x0081;
    L_0x0025:
        r9 = r6.next();	 Catch:{ all -> 0x0126 }
        r9 = (com.android.server.AppOpsService.Ops) r9;	 Catch:{ all -> 0x0126 }
        r0 = r17;
        r14 = r0.mContext;	 Catch:{ NameNotFoundException -> 0x007e }
        r14 = r14.getPackageManager();	 Catch:{ NameNotFoundException -> 0x007e }
        r15 = r9.packageName;	 Catch:{ NameNotFoundException -> 0x007e }
        r0 = r9.uid;	 Catch:{ NameNotFoundException -> 0x007e }
        r16 = r0;
        r16 = android.os.UserHandle.getUserId(r16);	 Catch:{ NameNotFoundException -> 0x007e }
        r3 = r14.getPackageUid(r15, r16);	 Catch:{ NameNotFoundException -> 0x007e }
    L_0x0041:
        r14 = r9.uid;	 Catch:{ all -> 0x0126 }
        if (r3 == r14) goto L_0x001f;
    L_0x0045:
        r14 = "AppOps";
        r15 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0126 }
        r15.<init>();	 Catch:{ all -> 0x0126 }
        r16 = "Pruning old package ";
        r15 = r15.append(r16);	 Catch:{ all -> 0x0126 }
        r0 = r9.packageName;	 Catch:{ all -> 0x0126 }
        r16 = r0;
        r15 = r15.append(r16);	 Catch:{ all -> 0x0126 }
        r16 = "/";
        r15 = r15.append(r16);	 Catch:{ all -> 0x0126 }
        r0 = r9.uid;	 Catch:{ all -> 0x0126 }
        r16 = r0;
        r15 = r15.append(r16);	 Catch:{ all -> 0x0126 }
        r16 = ": new uid=";
        r15 = r15.append(r16);	 Catch:{ all -> 0x0126 }
        r15 = r15.append(r3);	 Catch:{ all -> 0x0126 }
        r15 = r15.toString();	 Catch:{ all -> 0x0126 }
        android.util.Slog.i(r14, r15);	 Catch:{ all -> 0x0126 }
        r6.remove();	 Catch:{ all -> 0x0126 }
        r2 = 1;
        goto L_0x001f;
    L_0x007e:
        r4 = move-exception;
        r3 = -1;
        goto L_0x0041;
    L_0x0081:
        r14 = r12.size();	 Catch:{ all -> 0x0126 }
        if (r14 > 0) goto L_0x008e;
    L_0x0087:
        r0 = r17;
        r14 = r0.mUidOps;	 Catch:{ all -> 0x0126 }
        r14.removeAt(r5);	 Catch:{ all -> 0x0126 }
    L_0x008e:
        r5 = r5 + 1;
        goto L_0x0003;
    L_0x0092:
        r10 = android.app.ActivityThread.getPackageManager();	 Catch:{ all -> 0x0126 }
        r0 = r17;
        r14 = r0.mLoadPrivLaterPkgs;	 Catch:{ all -> 0x0126 }
        if (r14 == 0) goto L_0x012e;
    L_0x009c:
        if (r10 == 0) goto L_0x012e;
    L_0x009e:
        r0 = r17;
        r14 = r0.mLoadPrivLaterPkgs;	 Catch:{ all -> 0x0126 }
        r14 = r14.size();	 Catch:{ all -> 0x0126 }
        r5 = r14 + -1;
    L_0x00a8:
        if (r5 < 0) goto L_0x0129;
    L_0x00aa:
        r0 = r17;
        r14 = r0.mLoadPrivLaterPkgs;	 Catch:{ all -> 0x0126 }
        r13 = r14.keyAt(r5);	 Catch:{ all -> 0x0126 }
        r0 = r17;
        r14 = r0.mLoadPrivLaterPkgs;	 Catch:{ all -> 0x0126 }
        r11 = r14.valueAt(r5);	 Catch:{ all -> 0x0126 }
        r11 = (java.lang.String) r11;	 Catch:{ all -> 0x0126 }
        r0 = r17;
        r14 = r0.mUidOps;	 Catch:{ all -> 0x0126 }
        r12 = r14.get(r13);	 Catch:{ all -> 0x0126 }
        r12 = (java.util.HashMap) r12;	 Catch:{ all -> 0x0126 }
        if (r12 != 0) goto L_0x00cb;
    L_0x00c8:
        r5 = r5 + -1;
        goto L_0x00a8;
    L_0x00cb:
        r9 = r12.get(r11);	 Catch:{ all -> 0x0126 }
        r9 = (com.android.server.AppOpsService.Ops) r9;	 Catch:{ all -> 0x0126 }
        if (r9 == 0) goto L_0x00c8;
    L_0x00d3:
        r14 = 0;
        r15 = android.os.UserHandle.getUserId(r13);	 Catch:{ RemoteException -> 0x011d }
        r1 = r10.getApplicationInfo(r11, r14, r15);	 Catch:{ RemoteException -> 0x011d }
        if (r1 == 0) goto L_0x00c8;
    L_0x00de:
        r14 = r1.flags;	 Catch:{ RemoteException -> 0x011d }
        r15 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r14 = r14 & r15;
        if (r14 == 0) goto L_0x00c8;
    L_0x00e5:
        r14 = "AppOps";
        r15 = new java.lang.StringBuilder;	 Catch:{ RemoteException -> 0x011d }
        r15.<init>();	 Catch:{ RemoteException -> 0x011d }
        r16 = "Privileged package ";
        r15 = r15.append(r16);	 Catch:{ RemoteException -> 0x011d }
        r15 = r15.append(r11);	 Catch:{ RemoteException -> 0x011d }
        r15 = r15.toString();	 Catch:{ RemoteException -> 0x011d }
        android.util.Slog.i(r14, r15);	 Catch:{ RemoteException -> 0x011d }
        r8 = new com.android.server.AppOpsService$Ops;	 Catch:{ RemoteException -> 0x011d }
        r14 = 1;
        r8.<init>(r11, r13, r14);	 Catch:{ RemoteException -> 0x011d }
        r7 = 0;
    L_0x0104:
        r14 = r9.size();	 Catch:{ RemoteException -> 0x011d }
        if (r7 >= r14) goto L_0x0118;
    L_0x010a:
        r14 = r9.keyAt(r7);	 Catch:{ RemoteException -> 0x011d }
        r15 = r9.valueAt(r7);	 Catch:{ RemoteException -> 0x011d }
        r8.put(r14, r15);	 Catch:{ RemoteException -> 0x011d }
        r7 = r7 + 1;
        goto L_0x0104;
    L_0x0118:
        r12.put(r11, r8);	 Catch:{ RemoteException -> 0x011d }
        r2 = 1;
        goto L_0x00c8;
    L_0x011d:
        r4 = move-exception;
        r14 = "AppOps";
        r15 = "Could not contact PackageManager";
        android.util.Slog.w(r14, r15, r4);	 Catch:{ all -> 0x0126 }
        goto L_0x00c8;
    L_0x0126:
        r14 = move-exception;
        monitor-exit(r17);	 Catch:{ all -> 0x0126 }
        throw r14;
    L_0x0129:
        r14 = 0;
        r0 = r17;
        r0.mLoadPrivLaterPkgs = r14;	 Catch:{ all -> 0x0126 }
    L_0x012e:
        if (r2 == 0) goto L_0x0133;
    L_0x0130:
        r17.scheduleFastWriteLocked();	 Catch:{ all -> 0x0126 }
    L_0x0133:
        monitor-exit(r17);	 Catch:{ all -> 0x0126 }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.AppOpsService.systemReady():void");
    }

    public void packageRemoved(int uid, String packageName) {
        synchronized (this) {
            HashMap<String, Ops> pkgs = (HashMap) this.mUidOps.get(uid);
            if (!(pkgs == null || pkgs.remove(packageName) == null)) {
                if (pkgs.size() <= 0) {
                    this.mUidOps.remove(uid);
                }
                scheduleFastWriteLocked();
            }
        }
    }

    public void uidRemoved(int uid) {
        synchronized (this) {
            if (this.mUidOps.indexOfKey(uid) >= 0) {
                this.mUidOps.remove(uid);
                scheduleFastWriteLocked();
            }
        }
    }

    public void shutdown() {
        Slog.w(TAG, "Writing app ops before shutdown...");
        boolean doWrite = DEBUG;
        synchronized (this) {
            if (this.mWriteScheduled) {
                this.mWriteScheduled = DEBUG;
                doWrite = true;
            }
        }
        if (doWrite) {
            writeState();
        }
    }

    private ArrayList<OpEntry> collectOps(Ops pkgOps, int[] ops) {
        ArrayList<OpEntry> resOps = null;
        int j;
        Op curOp;
        if (ops == null) {
            resOps = new ArrayList();
            for (j = 0; j < pkgOps.size(); j++) {
                curOp = (Op) pkgOps.valueAt(j);
                resOps.add(new OpEntry(curOp.op, curOp.mode, curOp.time, curOp.rejectTime, curOp.duration));
            }
        } else {
            for (int i : ops) {
                curOp = (Op) pkgOps.get(i);
                if (curOp != null) {
                    if (resOps == null) {
                        resOps = new ArrayList();
                    }
                    resOps.add(new OpEntry(curOp.op, curOp.mode, curOp.time, curOp.rejectTime, curOp.duration));
                }
            }
        }
        return resOps;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public java.util.List<android.app.AppOpsManager.PackageOps> getPackagesForOps(int[] r14) {
        /*
        r13 = this;
        r8 = r13.mContext;
        r9 = "android.permission.GET_APP_OPS_STATS";
        r10 = android.os.Binder.getCallingPid();
        r11 = android.os.Binder.getCallingUid();
        r12 = 0;
        r8.enforcePermission(r9, r10, r11, r12);
        r4 = 0;
        monitor-enter(r13);
        r0 = 0;
    L_0x0013:
        r8 = r13.mUidOps;	 Catch:{ all -> 0x0059 }
        r8 = r8.size();	 Catch:{ all -> 0x0059 }
        if (r0 >= r8) goto L_0x0057;
    L_0x001b:
        r8 = r13.mUidOps;	 Catch:{ all -> 0x0059 }
        r2 = r8.valueAt(r0);	 Catch:{ all -> 0x0059 }
        r2 = (java.util.HashMap) r2;	 Catch:{ all -> 0x0059 }
        r8 = r2.values();	 Catch:{ all -> 0x0059 }
        r1 = r8.iterator();	 Catch:{ all -> 0x0059 }
        r5 = r4;
    L_0x002c:
        r8 = r1.hasNext();	 Catch:{ all -> 0x005c }
        if (r8 == 0) goto L_0x0053;
    L_0x0032:
        r3 = r1.next();	 Catch:{ all -> 0x005c }
        r3 = (com.android.server.AppOpsService.Ops) r3;	 Catch:{ all -> 0x005c }
        r6 = r13.collectOps(r3, r14);	 Catch:{ all -> 0x005c }
        if (r6 == 0) goto L_0x0061;
    L_0x003e:
        if (r5 != 0) goto L_0x005f;
    L_0x0040:
        r4 = new java.util.ArrayList;	 Catch:{ all -> 0x005c }
        r4.<init>();	 Catch:{ all -> 0x005c }
    L_0x0045:
        r7 = new android.app.AppOpsManager$PackageOps;	 Catch:{ all -> 0x0059 }
        r8 = r3.packageName;	 Catch:{ all -> 0x0059 }
        r9 = r3.uid;	 Catch:{ all -> 0x0059 }
        r7.<init>(r8, r9, r6);	 Catch:{ all -> 0x0059 }
        r4.add(r7);	 Catch:{ all -> 0x0059 }
    L_0x0051:
        r5 = r4;
        goto L_0x002c;
    L_0x0053:
        r0 = r0 + 1;
        r4 = r5;
        goto L_0x0013;
    L_0x0057:
        monitor-exit(r13);	 Catch:{ all -> 0x0059 }
        return r4;
    L_0x0059:
        r8 = move-exception;
    L_0x005a:
        monitor-exit(r13);	 Catch:{ all -> 0x0059 }
        throw r8;
    L_0x005c:
        r8 = move-exception;
        r4 = r5;
        goto L_0x005a;
    L_0x005f:
        r4 = r5;
        goto L_0x0045;
    L_0x0061:
        r4 = r5;
        goto L_0x0051;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.AppOpsService.getPackagesForOps(int[]):java.util.List<android.app.AppOpsManager$PackageOps>");
    }

    public List<PackageOps> getOpsForPackage(int uid, String packageName, int[] ops) {
        List<PackageOps> list = null;
        this.mContext.enforcePermission("android.permission.GET_APP_OPS_STATS", Binder.getCallingPid(), Binder.getCallingUid(), null);
        synchronized (this) {
            Ops pkgOps = getOpsLocked(uid, packageName, DEBUG);
            if (pkgOps == null) {
            } else {
                ArrayList<OpEntry> resOps = collectOps(pkgOps, ops);
                if (resOps == null) {
                } else {
                    list = new ArrayList();
                    list.add(new PackageOps(pkgOps.packageName, pkgOps.uid, resOps));
                }
            }
        }
        return list;
    }

    private void pruneOp(Op op, int uid, String packageName) {
        if (op.time == 0 && op.rejectTime == 0) {
            Ops ops = getOpsLocked(uid, packageName, DEBUG);
            if (ops != null) {
                ops.remove(op.op);
                if (ops.size() <= 0) {
                    HashMap<String, Ops> pkgOps = (HashMap) this.mUidOps.get(uid);
                    if (pkgOps != null) {
                        pkgOps.remove(ops.packageName);
                        if (pkgOps.size() <= 0) {
                            this.mUidOps.remove(uid);
                        }
                    }
                }
            }
        }
    }

    public void setMode(int code, int uid, String packageName, int mode) {
        Throwable th;
        if (Binder.getCallingPid() != Process.myPid()) {
            this.mContext.enforcePermission("android.permission.UPDATE_APP_OPS_STATS", Binder.getCallingPid(), Binder.getCallingUid(), null);
        }
        verifyIncomingOp(code);
        ArrayList<Callback> repCbs = null;
        code = AppOpsManager.opToSwitch(code);
        synchronized (this) {
            Op op = getOpLocked(code, uid, packageName, true);
            if (!(op == null || op.mode == mode)) {
                op.mode = mode;
                ArrayList<Callback> cbs = (ArrayList) this.mOpModeWatchers.get(code);
                if (cbs != null) {
                    if (null == null) {
                        repCbs = new ArrayList();
                    }
                    repCbs.addAll(cbs);
                }
                ArrayList<Callback> repCbs2 = repCbs;
                try {
                    cbs = (ArrayList) this.mPackageModeWatchers.get(packageName);
                    if (cbs != null) {
                        if (repCbs2 == null) {
                            repCbs = new ArrayList();
                        } else {
                            repCbs = repCbs2;
                        }
                        try {
                            repCbs.addAll(cbs);
                        } catch (Throwable th2) {
                            th = th2;
                            throw th;
                        }
                    }
                    repCbs = repCbs2;
                    if (mode == getDefaultMode(code, uid, packageName)) {
                        pruneOp(op, uid, packageName);
                    }
                    scheduleFastWriteLocked();
                } catch (Throwable th3) {
                    th = th3;
                    repCbs = repCbs2;
                    throw th;
                }
            }
            if (repCbs != null) {
                for (int i = 0; i < repCbs.size(); i++) {
                    try {
                        ((Callback) repCbs.get(i)).mCallback.opChanged(code, packageName);
                    } catch (RemoteException e) {
                    }
                }
            }
        }
    }

    private static HashMap<Callback, ArrayList<Pair<String, Integer>>> addCallbacks(HashMap<Callback, ArrayList<Pair<String, Integer>>> callbacks, String packageName, int op, ArrayList<Callback> cbs) {
        if (cbs != null) {
            if (callbacks == null) {
                callbacks = new HashMap();
            }
            for (int i = 0; i < cbs.size(); i++) {
                Callback cb = (Callback) cbs.get(i);
                ArrayList<Pair<String, Integer>> reports = (ArrayList) callbacks.get(cb);
                if (reports == null) {
                    reports = new ArrayList();
                    callbacks.put(cb, reports);
                }
                reports.add(new Pair(packageName, Integer.valueOf(op)));
            }
        }
        return callbacks;
    }

    public void resetAllModes(int reqUserId, String reqPackageName) {
        int callingPid = Binder.getCallingPid();
        int callingUid = Binder.getCallingUid();
        this.mContext.enforcePermission("android.permission.UPDATE_APP_OPS_STATS", callingPid, callingUid, null);
        reqUserId = ActivityManager.handleIncomingUser(callingPid, callingUid, reqUserId, true, true, "resetAllModes", null);
        HashMap<Callback, ArrayList<Pair<String, Integer>>> callbacks = null;
        synchronized (this) {
            boolean changed = DEBUG;
            int i = this.mUidOps.size() - 1;
            while (i >= 0) {
                HashMap<String, Ops> packages = (HashMap) this.mUidOps.valueAt(i);
                if (reqUserId == -1 || reqUserId == UserHandle.getUserId(this.mUidOps.keyAt(i))) {
                    Iterator<Entry<String, Ops>> it = packages.entrySet().iterator();
                    while (it.hasNext()) {
                        Entry<String, Ops> ent = (Entry) it.next();
                        String packageName = (String) ent.getKey();
                        if (reqPackageName == null || reqPackageName.equals(packageName)) {
                            Ops pkgOps = (Ops) ent.getValue();
                            for (int j = pkgOps.size() - 1; j >= 0; j--) {
                                Op curOp = (Op) pkgOps.valueAt(j);
                                int defaultMode = getDefaultMode(curOp.op, curOp.uid, curOp.packageName);
                                if (AppOpsManager.opAllowsReset(curOp.op) && curOp.mode != defaultMode) {
                                    curOp.mode = defaultMode;
                                    changed = true;
                                    String str = packageName;
                                    callbacks = addCallbacks(addCallbacks(callbacks, packageName, curOp.op, (ArrayList) this.mOpModeWatchers.get(curOp.op)), str, curOp.op, (ArrayList) this.mPackageModeWatchers.get(packageName));
                                    if (curOp.time == 0 && curOp.rejectTime == 0) {
                                        pkgOps.removeAt(j);
                                    }
                                }
                            }
                            if (pkgOps.size() == 0) {
                                it.remove();
                            }
                        }
                    }
                    if (packages.size() == 0) {
                        this.mUidOps.removeAt(i);
                    }
                }
                i--;
            }
            if (changed) {
                scheduleFastWriteLocked();
            }
        }
        if (callbacks != null) {
            for (Entry<Callback, ArrayList<Pair<String, Integer>>> ent2 : callbacks.entrySet()) {
                Callback cb = (Callback) ent2.getKey();
                ArrayList<Pair<String, Integer>> reports = (ArrayList) ent2.getValue();
                for (i = 0; i < reports.size(); i++) {
                    Pair<String, Integer> rep = (Pair) reports.get(i);
                    try {
                        cb.mCallback.opChanged(((Integer) rep.second).intValue(), (String) rep.first);
                    } catch (RemoteException e) {
                    }
                }
            }
        }
    }

    public void startWatchingMode(int op, String packageName, IAppOpsCallback callback) {
        synchronized (this) {
            ArrayList<Callback> cbs;
            op = AppOpsManager.opToSwitch(op);
            Callback cb = (Callback) this.mModeWatchers.get(callback.asBinder());
            if (cb == null) {
                cb = new Callback(callback);
                this.mModeWatchers.put(callback.asBinder(), cb);
            }
            if (op != -1) {
                cbs = (ArrayList) this.mOpModeWatchers.get(op);
                if (cbs == null) {
                    cbs = new ArrayList();
                    this.mOpModeWatchers.put(op, cbs);
                }
                cbs.add(cb);
            }
            if (packageName != null) {
                cbs = (ArrayList) this.mPackageModeWatchers.get(packageName);
                if (cbs == null) {
                    cbs = new ArrayList();
                    this.mPackageModeWatchers.put(packageName, cbs);
                }
                cbs.add(cb);
            }
        }
    }

    public void stopWatchingMode(IAppOpsCallback callback) {
        synchronized (this) {
            Callback cb = (Callback) this.mModeWatchers.remove(callback.asBinder());
            if (cb != null) {
                int i;
                ArrayList<Callback> cbs;
                cb.unlinkToDeath();
                for (i = this.mOpModeWatchers.size() - 1; i >= 0; i--) {
                    cbs = (ArrayList) this.mOpModeWatchers.valueAt(i);
                    cbs.remove(cb);
                    if (cbs.size() <= 0) {
                        this.mOpModeWatchers.removeAt(i);
                    }
                }
                for (i = this.mPackageModeWatchers.size() - 1; i >= 0; i--) {
                    cbs = (ArrayList) this.mPackageModeWatchers.valueAt(i);
                    cbs.remove(cb);
                    if (cbs.size() <= 0) {
                        this.mPackageModeWatchers.removeAt(i);
                    }
                }
            }
        }
    }

    public IBinder getToken(IBinder clientToken) {
        ClientState cs;
        synchronized (this) {
            cs = (ClientState) this.mClients.get(clientToken);
            if (cs == null) {
                cs = new ClientState(clientToken);
                this.mClients.put(clientToken, cs);
            }
        }
        return cs;
    }

    public int checkOperation(int code, int uid, String packageName) {
        int i;
        verifyIncomingUid(uid);
        verifyIncomingOp(code);
        synchronized (this) {
            if (isOpRestricted(uid, code, packageName)) {
                i = 1;
            } else {
                Op op = getOpLocked(AppOpsManager.opToSwitch(code), uid, packageName, DEBUG);
                if (op == null) {
                    i = getDefaultMode(code, uid, packageName);
                } else {
                    i = op.mode;
                }
            }
        }
        return i;
    }

    public int checkAudioOperation(int code, int usage, int uid, String packageName) {
        synchronized (this) {
            int mode = checkRestrictionLocked(code, usage, uid, packageName);
            if (mode != 0) {
                return mode;
            }
            return checkOperation(code, uid, packageName);
        }
    }

    private int checkRestrictionLocked(int code, int usage, int uid, String packageName) {
        SparseArray<Restriction> usageRestrictions = (SparseArray) this.mAudioRestrictions.get(code);
        if (usageRestrictions != null) {
            Restriction r = (Restriction) usageRestrictions.get(usage);
            if (!(r == null || r.exceptionPackages.contains(packageName))) {
                return r.mode;
            }
        }
        return 0;
    }

    public void setAudioRestriction(int code, int usage, int uid, int mode, String[] exceptionPackages) {
        verifyIncomingUid(uid);
        verifyIncomingOp(code);
        synchronized (this) {
            SparseArray<Restriction> usageRestrictions = (SparseArray) this.mAudioRestrictions.get(code);
            if (usageRestrictions == null) {
                usageRestrictions = new SparseArray();
                this.mAudioRestrictions.put(code, usageRestrictions);
            }
            usageRestrictions.remove(usage);
            if (mode != 0) {
                Restriction r = new Restriction();
                r.mode = mode;
                if (exceptionPackages != null) {
                    r.exceptionPackages = new ArraySet(N);
                    for (String pkg : exceptionPackages) {
                        if (pkg != null) {
                            r.exceptionPackages.add(pkg.trim());
                        }
                    }
                }
                usageRestrictions.put(usage, r);
            }
        }
    }

    public int checkPackage(int uid, String packageName) {
        int i;
        synchronized (this) {
            if (getOpsRawLocked(uid, packageName, true) != null) {
                i = 0;
            } else {
                i = 2;
            }
        }
        return i;
    }

    public int noteOperation(int code, int uid, String packageName) {
        verifyIncomingUid(uid);
        verifyIncomingOp(code);
        synchronized (this) {
            Ops ops = getOpsLocked(uid, packageName, true);
            if (ops == null) {
                return 2;
            }
            Op op = getOpLocked(ops, code, true);
            if (isOpRestricted(uid, code, packageName)) {
                return 1;
            }
            Op switchOp;
            if (op.duration == -1) {
                Slog.w(TAG, "Noting op not finished: uid " + uid + " pkg " + packageName + " code " + code + " time=" + op.time + " duration=" + op.duration);
            }
            op.duration = 0;
            int switchCode = AppOpsManager.opToSwitch(code);
            if (switchCode != code) {
                switchOp = getOpLocked(ops, switchCode, true);
            } else {
                switchOp = op;
            }
            int i;
            if (switchOp.mode != 0 && switchOp.mode != 4) {
                op.rejectTime = System.currentTimeMillis();
                i = switchOp.mode;
                return i;
            } else if (switchOp.mode == 0) {
                op.time = System.currentTimeMillis();
                op.rejectTime = 0;
                return 0;
            } else if (Looper.myLooper() == this.mLooper) {
                Log.e(TAG, "noteOperation: This method will deadlock if called from the main thread. (Code: " + code + " uid: " + uid + " package: " + packageName + ")");
                i = switchOp.mode;
                return i;
            } else {
                op.noteOpCount++;
                PermissionDialogReq req = askOperationLocked(code, uid, packageName, switchOp);
                return req.get();
            }
        }
    }

    public int startOperation(IBinder token, int code, int uid, String packageName) {
        verifyIncomingUid(uid);
        verifyIncomingOp(code);
        ClientState client = (ClientState) token;
        synchronized (this) {
            Ops ops = getOpsLocked(uid, packageName, true);
            if (ops == null) {
                return 2;
            }
            Op op = getOpLocked(ops, code, true);
            if (isOpRestricted(uid, code, packageName)) {
                return 1;
            }
            Op switchOp;
            int switchCode = AppOpsManager.opToSwitch(code);
            if (switchCode != code) {
                switchOp = getOpLocked(ops, switchCode, true);
            } else {
                switchOp = op;
            }
            int i;
            if (switchOp.mode != 0 && switchOp.mode != 4) {
                op.rejectTime = System.currentTimeMillis();
                i = switchOp.mode;
                return i;
            } else if (switchOp.mode == 0) {
                if (op.nesting == 0) {
                    op.time = System.currentTimeMillis();
                    op.rejectTime = 0;
                    op.duration = -1;
                }
                op.nesting++;
                if (client.mStartedOps != null) {
                    client.mStartedOps.add(op);
                }
                return 0;
            } else if (Looper.myLooper() == this.mLooper) {
                Log.e(TAG, "startOperation: This method will deadlock if called from the main thread. (Code: " + code + " uid: " + uid + " package: " + packageName + ")");
                i = switchOp.mode;
                return i;
            } else {
                op.startOpCount++;
                op.clientTokens.add(client.mAppToken);
                PermissionDialogReq req = askOperationLocked(code, uid, packageName, switchOp);
                return req.get();
            }
        }
    }

    public void finishOperation(IBinder token, int code, int uid, String packageName) {
        verifyIncomingUid(uid);
        verifyIncomingOp(code);
        ClientState client = (ClientState) token;
        synchronized (this) {
            Op op = getOpLocked(code, uid, packageName, true);
            if (op == null) {
            } else if (client.mStartedOps == null || client.mStartedOps.remove(op)) {
                finishOperationLocked(op);
            } else {
                throw new IllegalStateException("Operation not started: uid" + op.uid + " pkg=" + op.packageName + " op=" + op.op);
            }
        }
    }

    void finishOperationLocked(Op op) {
        if (op.nesting <= 1) {
            if (op.nesting == 1) {
                op.duration = (int) (System.currentTimeMillis() - op.time);
                op.time += (long) op.duration;
            } else {
                Slog.w(TAG, "Finishing op nesting under-run: uid " + op.uid + " pkg " + op.packageName + " code " + op.op + " time=" + op.time + " duration=" + op.duration + " nesting=" + op.nesting);
            }
            op.nesting = 0;
            return;
        }
        op.nesting--;
    }

    private void verifyIncomingUid(int uid) {
        if (uid != Binder.getCallingUid() && Binder.getCallingPid() != Process.myPid()) {
            this.mContext.enforcePermission("android.permission.UPDATE_APP_OPS_STATS", Binder.getCallingPid(), Binder.getCallingUid(), null);
        }
    }

    private void verifyIncomingOp(int op) {
        if (op < 0 || op >= 60) {
            throw new IllegalArgumentException("Bad operation #" + op);
        }
    }

    private Ops getOpsLocked(int uid, String packageName, boolean edit) {
        if (uid == 0) {
            packageName = "root";
        } else if (uid == 2000) {
            packageName = "com.android.shell";
        } else if (uid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE && packageName == null) {
            packageName = "android";
        }
        return getOpsRawLocked(uid, packageName, edit);
    }

    private Ops getOpsRawLocked(int uid, String packageName, boolean edit) {
        HashMap<String, Ops> pkgOps = (HashMap) this.mUidOps.get(uid);
        if (pkgOps == null) {
            if (!edit) {
                return null;
            }
            pkgOps = new HashMap();
            this.mUidOps.put(uid, pkgOps);
        }
        Ops ops = (Ops) pkgOps.get(packageName);
        if (ops != null) {
            return ops;
        }
        if (!edit) {
            return null;
        }
        boolean isPrivileged = DEBUG;
        if (uid != 0) {
            long ident = Binder.clearCallingIdentity();
            int pkgUid = -1;
            try {
                ApplicationInfo appInfo = ActivityThread.getPackageManager().getApplicationInfo(packageName, 0, UserHandle.getUserId(uid));
                if (appInfo != null) {
                    pkgUid = appInfo.uid;
                    isPrivileged = (appInfo.flags & 1073741824) != 0 ? true : DEBUG;
                } else if ("media".equals(packageName)) {
                    pkgUid = 1013;
                    isPrivileged = DEBUG;
                }
            } catch (RemoteException e) {
                Slog.w(TAG, "Could not contact PackageManager", e);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
            if (pkgUid != uid) {
                Slog.w(TAG, "Bad call: specified package " + packageName + " under uid " + uid + " but it is really " + pkgUid);
                Binder.restoreCallingIdentity(ident);
                return null;
            }
            Binder.restoreCallingIdentity(ident);
        }
        ops = new Ops(packageName, uid, isPrivileged);
        pkgOps.put(packageName, ops);
        return ops;
    }

    private void scheduleWriteLocked() {
        if (!this.mWriteScheduled) {
            this.mWriteScheduled = true;
            this.mHandler.postDelayed(this.mWriteRunner, WRITE_DELAY);
        }
    }

    private void scheduleFastWriteLocked() {
        if (!this.mFastWriteScheduled) {
            this.mWriteScheduled = true;
            this.mFastWriteScheduled = true;
            this.mHandler.removeCallbacks(this.mWriteRunner);
            this.mHandler.postDelayed(this.mWriteRunner, 10000);
        }
    }

    private Op getOpLocked(int code, int uid, String packageName, boolean edit) {
        Ops ops = getOpsLocked(uid, packageName, edit);
        if (ops == null) {
            return null;
        }
        return getOpLocked(ops, code, edit);
    }

    private Op getOpLocked(Ops ops, int code, boolean edit) {
        Op op = (Op) ops.get(code);
        if (op == null) {
            if (!edit) {
                return null;
            }
            op = new Op(ops.uid, ops.packageName, code, getDefaultMode(code, ops.uid, ops.packageName));
            ops.put(code, op);
        }
        if (edit) {
            scheduleWriteLocked();
        }
        return op;
    }

    private boolean isOpRestricted(int uid, int code, String packageName) {
        boolean[] opRestrictions = (boolean[]) this.mOpRestrictions.get(UserHandle.getUserId(uid));
        if (opRestrictions == null || !opRestrictions[code]) {
            return DEBUG;
        }
        if (AppOpsManager.opAllowSystemBypassRestriction(code)) {
            synchronized (this) {
                Ops ops = getOpsLocked(uid, packageName, true);
                if (ops == null || !ops.isPrivileged) {
                } else {
                    return DEBUG;
                }
            }
        }
        return true;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void readState() {
        /*
        r13 = this;
        r12 = 3;
        r9 = 2;
        r11 = 1;
        r8 = r13.mFile;
        monitor-enter(r8);
        monitor-enter(r13);	 Catch:{ all -> 0x007b }
        r7 = r13.mFile;	 Catch:{ FileNotFoundException -> 0x0053 }
        r3 = r7.openRead();	 Catch:{ FileNotFoundException -> 0x0053 }
        r4 = 0;
        r2 = android.util.Xml.newPullParser();	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        r7 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        r7 = r7.name();	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        r2.setInput(r3, r7);	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
    L_0x001b:
        r6 = r2.next();	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        if (r6 == r9) goto L_0x0023;
    L_0x0021:
        if (r6 != r11) goto L_0x001b;
    L_0x0023:
        if (r6 == r9) goto L_0x007e;
    L_0x0025:
        r7 = new java.lang.IllegalStateException;	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        r9 = "no start tag found";
        r7.<init>(r9);	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        throw r7;	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
    L_0x002d:
        r0 = move-exception;
        r7 = "AppOps";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x019b }
        r9.<init>();	 Catch:{ all -> 0x019b }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x019b }
        r9 = r9.append(r0);	 Catch:{ all -> 0x019b }
        r9 = r9.toString();	 Catch:{ all -> 0x019b }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x019b }
        if (r4 != 0) goto L_0x004d;
    L_0x0048:
        r7 = r13.mUidOps;	 Catch:{ all -> 0x01a7 }
        r7.clear();	 Catch:{ all -> 0x01a7 }
    L_0x004d:
        r3.close();	 Catch:{ IOException -> 0x01aa }
    L_0x0050:
        monitor-exit(r13);	 Catch:{ all -> 0x01a7 }
        monitor-exit(r8);	 Catch:{ all -> 0x007b }
    L_0x0052:
        return;
    L_0x0053:
        r0 = move-exception;
        r7 = "AppOps";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a7 }
        r9.<init>();	 Catch:{ all -> 0x01a7 }
        r10 = "No existing app ops ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x01a7 }
        r10 = r13.mFile;	 Catch:{ all -> 0x01a7 }
        r10 = r10.getBaseFile();	 Catch:{ all -> 0x01a7 }
        r9 = r9.append(r10);	 Catch:{ all -> 0x01a7 }
        r10 = "; starting empty";
        r9 = r9.append(r10);	 Catch:{ all -> 0x01a7 }
        r9 = r9.toString();	 Catch:{ all -> 0x01a7 }
        android.util.Slog.i(r7, r9);	 Catch:{ all -> 0x01a7 }
        monitor-exit(r13);	 Catch:{ all -> 0x01a7 }
        monitor-exit(r8);	 Catch:{ all -> 0x007b }
        goto L_0x0052;
    L_0x007b:
        r7 = move-exception;
        monitor-exit(r8);	 Catch:{ all -> 0x007b }
        throw r7;
    L_0x007e:
        r1 = r2.getDepth();	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
    L_0x0082:
        r6 = r2.next();	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        if (r6 == r11) goto L_0x0113;
    L_0x0088:
        if (r6 != r12) goto L_0x0090;
    L_0x008a:
        r7 = r2.getDepth();	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        if (r7 <= r1) goto L_0x0113;
    L_0x0090:
        if (r6 == r12) goto L_0x0082;
    L_0x0092:
        r7 = 4;
        if (r6 == r7) goto L_0x0082;
    L_0x0095:
        r5 = r2.getName();	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        r7 = "pkg";
        r7 = r5.equals(r7);	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        if (r7 == 0) goto L_0x00cb;
    L_0x00a1:
        r13.readPackage(r2);	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        goto L_0x0082;
    L_0x00a5:
        r0 = move-exception;
        r7 = "AppOps";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x019b }
        r9.<init>();	 Catch:{ all -> 0x019b }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x019b }
        r9 = r9.append(r0);	 Catch:{ all -> 0x019b }
        r9 = r9.toString();	 Catch:{ all -> 0x019b }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x019b }
        if (r4 != 0) goto L_0x00c5;
    L_0x00c0:
        r7 = r13.mUidOps;	 Catch:{ all -> 0x01a7 }
        r7.clear();	 Catch:{ all -> 0x01a7 }
    L_0x00c5:
        r3.close();	 Catch:{ IOException -> 0x00c9 }
        goto L_0x0050;
    L_0x00c9:
        r7 = move-exception;
        goto L_0x0050;
    L_0x00cb:
        r7 = "AppOps";
        r9 = new java.lang.StringBuilder;	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        r9.<init>();	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        r10 = "Unknown element under <app-ops>: ";
        r9 = r9.append(r10);	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        r10 = r2.getName();	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        r9 = r9.append(r10);	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        r9 = r9.toString();	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        android.util.Slog.w(r7, r9);	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        com.android.internal.util.XmlUtils.skipCurrentTag(r2);	 Catch:{ IllegalStateException -> 0x002d, NullPointerException -> 0x00a5, NumberFormatException -> 0x00eb, XmlPullParserException -> 0x0123, IOException -> 0x014b, IndexOutOfBoundsException -> 0x0173 }
        goto L_0x0082;
    L_0x00eb:
        r0 = move-exception;
        r7 = "AppOps";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x019b }
        r9.<init>();	 Catch:{ all -> 0x019b }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x019b }
        r9 = r9.append(r0);	 Catch:{ all -> 0x019b }
        r9 = r9.toString();	 Catch:{ all -> 0x019b }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x019b }
        if (r4 != 0) goto L_0x010b;
    L_0x0106:
        r7 = r13.mUidOps;	 Catch:{ all -> 0x01a7 }
        r7.clear();	 Catch:{ all -> 0x01a7 }
    L_0x010b:
        r3.close();	 Catch:{ IOException -> 0x0110 }
        goto L_0x0050;
    L_0x0110:
        r7 = move-exception;
        goto L_0x0050;
    L_0x0113:
        r4 = 1;
        if (r4 != 0) goto L_0x011b;
    L_0x0116:
        r7 = r13.mUidOps;	 Catch:{ all -> 0x01a7 }
        r7.clear();	 Catch:{ all -> 0x01a7 }
    L_0x011b:
        r3.close();	 Catch:{ IOException -> 0x0120 }
        goto L_0x0050;
    L_0x0120:
        r7 = move-exception;
        goto L_0x0050;
    L_0x0123:
        r0 = move-exception;
        r7 = "AppOps";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x019b }
        r9.<init>();	 Catch:{ all -> 0x019b }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x019b }
        r9 = r9.append(r0);	 Catch:{ all -> 0x019b }
        r9 = r9.toString();	 Catch:{ all -> 0x019b }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x019b }
        if (r4 != 0) goto L_0x0143;
    L_0x013e:
        r7 = r13.mUidOps;	 Catch:{ all -> 0x01a7 }
        r7.clear();	 Catch:{ all -> 0x01a7 }
    L_0x0143:
        r3.close();	 Catch:{ IOException -> 0x0148 }
        goto L_0x0050;
    L_0x0148:
        r7 = move-exception;
        goto L_0x0050;
    L_0x014b:
        r0 = move-exception;
        r7 = "AppOps";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x019b }
        r9.<init>();	 Catch:{ all -> 0x019b }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x019b }
        r9 = r9.append(r0);	 Catch:{ all -> 0x019b }
        r9 = r9.toString();	 Catch:{ all -> 0x019b }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x019b }
        if (r4 != 0) goto L_0x016b;
    L_0x0166:
        r7 = r13.mUidOps;	 Catch:{ all -> 0x01a7 }
        r7.clear();	 Catch:{ all -> 0x01a7 }
    L_0x016b:
        r3.close();	 Catch:{ IOException -> 0x0170 }
        goto L_0x0050;
    L_0x0170:
        r7 = move-exception;
        goto L_0x0050;
    L_0x0173:
        r0 = move-exception;
        r7 = "AppOps";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x019b }
        r9.<init>();	 Catch:{ all -> 0x019b }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x019b }
        r9 = r9.append(r0);	 Catch:{ all -> 0x019b }
        r9 = r9.toString();	 Catch:{ all -> 0x019b }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x019b }
        if (r4 != 0) goto L_0x0193;
    L_0x018e:
        r7 = r13.mUidOps;	 Catch:{ all -> 0x01a7 }
        r7.clear();	 Catch:{ all -> 0x01a7 }
    L_0x0193:
        r3.close();	 Catch:{ IOException -> 0x0198 }
        goto L_0x0050;
    L_0x0198:
        r7 = move-exception;
        goto L_0x0050;
    L_0x019b:
        r7 = move-exception;
        if (r4 != 0) goto L_0x01a3;
    L_0x019e:
        r9 = r13.mUidOps;	 Catch:{ all -> 0x01a7 }
        r9.clear();	 Catch:{ all -> 0x01a7 }
    L_0x01a3:
        r3.close();	 Catch:{ IOException -> 0x01ad }
    L_0x01a6:
        throw r7;	 Catch:{ all -> 0x01a7 }
    L_0x01a7:
        r7 = move-exception;
        monitor-exit(r13);	 Catch:{ all -> 0x01a7 }
        throw r7;	 Catch:{ all -> 0x007b }
    L_0x01aa:
        r7 = move-exception;
        goto L_0x0050;
    L_0x01ad:
        r9 = move-exception;
        goto L_0x01a6;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.AppOpsService.readState():void");
    }

    void readPackage(XmlPullParser parser) throws NumberFormatException, XmlPullParserException, IOException {
        String pkgName = parser.getAttributeValue(null, "n");
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == 1) {
                return;
            }
            if (type == 3 && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == 3 || type == 4)) {
                if (parser.getName().equals("uid")) {
                    readUid(parser, pkgName);
                } else {
                    Slog.w(TAG, "Unknown element under <pkg>: " + parser.getName());
                    XmlUtils.skipCurrentTag(parser);
                }
            }
        }
    }

    void readUid(XmlPullParser parser, String pkgName) throws NumberFormatException, XmlPullParserException, IOException {
        int uid = Integer.parseInt(parser.getAttributeValue(null, "n"));
        String isPrivilegedString = parser.getAttributeValue(null, "p");
        boolean isPrivileged = DEBUG;
        if (isPrivilegedString == null) {
            if (this.mLoadPrivLaterPkgs == null) {
                this.mLoadPrivLaterPkgs = new SparseArray();
            }
            this.mLoadPrivLaterPkgs.put(uid, pkgName);
        } else {
            isPrivileged = Boolean.parseBoolean(isPrivilegedString);
        }
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == 1) {
                return;
            }
            if (type == 3 && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == 3 || type == 4)) {
                if (parser.getName().equals("op")) {
                    int code = Integer.parseInt(parser.getAttributeValue(null, "n"));
                    Op op = new Op(uid, pkgName, code, 2);
                    String mode = parser.getAttributeValue(null, "m");
                    if (mode != null) {
                        op.mode = Integer.parseInt(mode);
                    } else {
                        int defaultMode;
                        String sDefualtMode = parser.getAttributeValue(null, "dm");
                        if (sDefualtMode != null) {
                            defaultMode = Integer.parseInt(sDefualtMode);
                        } else {
                            defaultMode = getDefaultMode(code, uid, pkgName);
                        }
                        op.mode = defaultMode;
                    }
                    String time = parser.getAttributeValue(null, "t");
                    if (time != null) {
                        op.time = Long.parseLong(time);
                    }
                    time = parser.getAttributeValue(null, "r");
                    if (time != null) {
                        op.rejectTime = Long.parseLong(time);
                    }
                    String dur = parser.getAttributeValue(null, "d");
                    if (dur != null) {
                        op.duration = Integer.parseInt(dur);
                    }
                    HashMap<String, Ops> pkgOps = (HashMap) this.mUidOps.get(uid);
                    if (pkgOps == null) {
                        pkgOps = new HashMap();
                        this.mUidOps.put(uid, pkgOps);
                    }
                    Ops ops = (Ops) pkgOps.get(pkgName);
                    if (ops == null) {
                        ops = new Ops(pkgName, uid, isPrivileged);
                        pkgOps.put(pkgName, ops);
                    }
                    ops.put(op.op, op);
                } else {
                    Slog.w(TAG, "Unknown element under <pkg>: " + parser.getName());
                    XmlUtils.skipCurrentTag(parser);
                }
            }
        }
    }

    void writeState() {
        synchronized (this.mFile) {
            List<PackageOps> allOps = getPackagesForOps(null);
            try {
                OutputStream stream = this.mFile.startWrite();
                XmlSerializer out = new FastXmlSerializer();
                out.setOutput(stream, StandardCharsets.UTF_8.name());
                out.startDocument(null, Boolean.valueOf(true));
                out.startTag(null, "app-ops");
                if (allOps != null) {
                    String lastPkg = null;
                    for (int i = 0; i < allOps.size(); i++) {
                        PackageOps pkg = (PackageOps) allOps.get(i);
                        if (!pkg.getPackageName().equals(lastPkg)) {
                            if (lastPkg != null) {
                                out.endTag(null, "pkg");
                            }
                            lastPkg = pkg.getPackageName();
                            out.startTag(null, "pkg");
                            out.attribute(null, "n", lastPkg);
                        }
                        out.startTag(null, "uid");
                        out.attribute(null, "n", Integer.toString(pkg.getUid()));
                        synchronized (this) {
                            Ops ops = getOpsLocked(pkg.getUid(), pkg.getPackageName(), DEBUG);
                            if (ops != null) {
                                out.attribute(null, "p", Boolean.toString(ops.isPrivileged));
                            } else {
                                out.attribute(null, "p", Boolean.toString(DEBUG));
                            }
                        }
                        List<OpEntry> ops2 = pkg.getOps();
                        for (int j = 0; j < ops2.size(); j++) {
                            OpEntry op = (OpEntry) ops2.get(j);
                            out.startTag(null, "op");
                            out.attribute(null, "n", Integer.toString(op.getOp()));
                            int defaultMode = getDefaultMode(op.getOp(), pkg.getUid(), pkg.getPackageName());
                            if (op.getMode() != defaultMode) {
                                out.attribute(null, "m", Integer.toString(op.getMode()));
                            } else {
                                try {
                                    out.attribute(null, "dm", Integer.toString(defaultMode));
                                } catch (IOException e) {
                                    Slog.w(TAG, "Failed to write state, restoring backup.", e);
                                    this.mFile.failWrite(stream);
                                }
                            }
                            long time = op.getTime();
                            if (time != 0) {
                                out.attribute(null, "t", Long.toString(time));
                            }
                            time = op.getRejectTime();
                            if (time != 0) {
                                out.attribute(null, "r", Long.toString(time));
                            }
                            int dur = op.getDuration();
                            if (dur != 0) {
                                out.attribute(null, "d", Integer.toString(dur));
                            }
                            out.endTag(null, "op");
                        }
                        out.endTag(null, "uid");
                    }
                    if (lastPkg != null) {
                        out.endTag(null, "pkg");
                    }
                }
                out.endTag(null, "app-ops");
                out.endDocument();
                this.mFile.finishWrite(stream);
            } catch (IOException e2) {
                Slog.w(TAG, "Failed to write state: " + e2);
            }
        }
    }

    protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump ApOps service from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            return;
        }
        synchronized (this) {
            int i;
            ArrayList<Callback> callbacks;
            int j;
            pw.println("Current AppOps Service state:");
            long now = System.currentTimeMillis();
            boolean needSep = DEBUG;
            if (this.mOpModeWatchers.size() > 0) {
                needSep = true;
                pw.println("  Op mode watchers:");
                i = 0;
                while (true) {
                    if (i >= this.mOpModeWatchers.size()) {
                        break;
                    }
                    pw.print("    Op ");
                    pw.print(AppOpsManager.opToName(this.mOpModeWatchers.keyAt(i)));
                    pw.println(":");
                    callbacks = (ArrayList) this.mOpModeWatchers.valueAt(i);
                    for (j = 0; j < callbacks.size(); j++) {
                        pw.print("      #");
                        pw.print(j);
                        pw.print(": ");
                        pw.println(callbacks.get(j));
                    }
                    i++;
                }
            }
            if (this.mPackageModeWatchers.size() > 0) {
                needSep = true;
                pw.println("  Package mode watchers:");
                i = 0;
                while (true) {
                    if (i >= this.mPackageModeWatchers.size()) {
                        break;
                    }
                    pw.print("    Pkg ");
                    pw.print((String) this.mPackageModeWatchers.keyAt(i));
                    pw.println(":");
                    callbacks = (ArrayList) this.mPackageModeWatchers.valueAt(i);
                    for (j = 0; j < callbacks.size(); j++) {
                        pw.print("      #");
                        pw.print(j);
                        pw.print(": ");
                        pw.println(callbacks.get(j));
                    }
                    i++;
                }
            }
            if (this.mModeWatchers.size() > 0) {
                needSep = true;
                pw.println("  All mode watchers:");
                i = 0;
                while (true) {
                    if (i >= this.mModeWatchers.size()) {
                        break;
                    }
                    pw.print("    ");
                    pw.print(this.mModeWatchers.keyAt(i));
                    pw.print(" -> ");
                    pw.println(this.mModeWatchers.valueAt(i));
                    i++;
                }
            }
            if (this.mClients.size() > 0) {
                needSep = true;
                pw.println("  Clients:");
                i = 0;
                while (true) {
                    if (i >= this.mClients.size()) {
                        break;
                    }
                    pw.print("    ");
                    pw.print(this.mClients.keyAt(i));
                    pw.println(":");
                    ClientState cs = (ClientState) this.mClients.valueAt(i);
                    pw.print("      ");
                    pw.println(cs);
                    if (cs.mStartedOps != null) {
                        if (cs.mStartedOps.size() > 0) {
                            pw.println("      Started ops:");
                            j = 0;
                            while (true) {
                                if (j >= cs.mStartedOps.size()) {
                                    break;
                                }
                                Op op = (Op) cs.mStartedOps.get(j);
                                pw.print("        ");
                                pw.print("uid=");
                                pw.print(op.uid);
                                pw.print(" pkg=");
                                pw.print(op.packageName);
                                pw.print(" op=");
                                pw.println(AppOpsManager.opToName(op.op));
                                j++;
                            }
                        }
                    }
                    i++;
                }
            }
            if (this.mAudioRestrictions.size() > 0) {
                boolean printedHeader = DEBUG;
                int o = 0;
                while (true) {
                    if (o >= this.mAudioRestrictions.size()) {
                        break;
                    }
                    String op2 = AppOpsManager.opToName(this.mAudioRestrictions.keyAt(o));
                    SparseArray<Restriction> restrictions = (SparseArray) this.mAudioRestrictions.valueAt(o);
                    for (i = 0; i < restrictions.size(); i++) {
                        if (!printedHeader) {
                            pw.println("  Audio Restrictions:");
                            printedHeader = true;
                            needSep = true;
                        }
                        int usage = restrictions.keyAt(i);
                        pw.print("    ");
                        pw.print(op2);
                        pw.print(" usage=");
                        pw.print(AudioAttributes.usageToString(usage));
                        Restriction r = (Restriction) restrictions.valueAt(i);
                        pw.print(": mode=");
                        pw.println(r.mode);
                        if (!r.exceptionPackages.isEmpty()) {
                            pw.println("      Exceptions:");
                            j = 0;
                            while (true) {
                                if (j >= r.exceptionPackages.size()) {
                                    break;
                                }
                                pw.print("        ");
                                pw.println((String) r.exceptionPackages.valueAt(j));
                                j++;
                            }
                        }
                    }
                    o++;
                }
            }
            if (needSep) {
                pw.println();
            }
            i = 0;
            while (true) {
                if (i < this.mUidOps.size()) {
                    pw.print("  Uid ");
                    UserHandle.formatUid(pw, this.mUidOps.keyAt(i));
                    pw.println(":");
                    for (Ops ops : ((HashMap) this.mUidOps.valueAt(i)).values()) {
                        pw.print("    Package ");
                        pw.print(ops.packageName);
                        pw.println(":");
                        for (j = 0; j < ops.size(); j++) {
                            op = (Op) ops.valueAt(j);
                            pw.print("      ");
                            pw.print(AppOpsManager.opToName(op.op));
                            pw.print(": mode=");
                            pw.print(op.mode);
                            if (op.time != 0) {
                                pw.print("; time=");
                                TimeUtils.formatDuration(now - op.time, pw);
                                pw.print(" ago");
                            }
                            if (op.rejectTime != 0) {
                                pw.print("; rejectTime=");
                                TimeUtils.formatDuration(now - op.rejectTime, pw);
                                pw.print(" ago");
                            }
                            int i2 = op.duration;
                            if (r0 == -1) {
                                pw.print(" (running)");
                            } else if (op.duration != 0) {
                                pw.print("; duration=");
                                TimeUtils.formatDuration((long) op.duration, pw);
                            }
                            pw.println();
                        }
                    }
                    i++;
                }
            }
        }
    }

    public void setUserRestrictions(Bundle restrictions, int userHandle) throws RemoteException {
        checkSystemUid("setUserRestrictions");
        boolean[] opRestrictions = (boolean[]) this.mOpRestrictions.get(userHandle);
        if (opRestrictions == null) {
            opRestrictions = new boolean[60];
            this.mOpRestrictions.put(userHandle, opRestrictions);
        }
        for (int i = 0; i < opRestrictions.length; i++) {
            String restriction = AppOpsManager.opToRestriction(i);
            if (restriction != null) {
                opRestrictions[i] = restrictions.getBoolean(restriction, DEBUG);
            } else {
                opRestrictions[i] = DEBUG;
            }
        }
    }

    public void removeUser(int userHandle) throws RemoteException {
        checkSystemUid("removeUser");
        this.mOpRestrictions.remove(userHandle);
    }

    private void checkSystemUid(String function) {
        if (Binder.getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            throw new SecurityException(function + " must by called by the system");
        }
    }

    private PermissionDialogReq askOperationLocked(int code, int uid, String packageName, Op op) {
        PermissionDialogReq request = new PermissionDialogReq();
        this.mHandler.post(new AskRunnable(code, uid, packageName, op, request));
        return request;
    }

    private int getDefaultMode(int code, int uid, String packageName) {
        int mode = AppOpsManager.opToDefaultMode(code, isStrict(code, uid, packageName));
        if (!AppOpsManager.isStrictOp(code) || this.mPolicy == null) {
            return mode;
        }
        int policyMode = this.mPolicy.getDefualtMode(code, packageName);
        if (policyMode != 2) {
            return policyMode;
        }
        return mode;
    }

    private boolean isStrict(int code, int uid, String packageName) {
        if (this.mStrictEnable) {
            return UserHandle.isApp(uid);
        }
        return DEBUG;
    }

    private void printOperationLocked(Op op, int mode, String operation) {
        if (op != null) {
            int switchCode = AppOpsManager.opToSwitch(op.op);
            if (mode == 1 || mode != 0) {
            }
        }
    }

    private void recordOperationLocked(int code, int uid, String packageName, int mode) {
        Op op = getOpLocked(code, uid, packageName, DEBUG);
        if (op != null) {
            if (op.noteOpCount != 0) {
                printOperationLocked(op, mode, "noteOperartion");
            }
            if (op.startOpCount != 0) {
                printOperationLocked(op, mode, "startOperation");
            }
            if (mode == 1) {
                op.rejectTime = System.currentTimeMillis();
            } else if (mode == 0) {
                if (op.noteOpCount != 0) {
                    op.time = System.currentTimeMillis();
                    op.rejectTime = 0;
                }
                if (op.startOpCount != 0) {
                    if (op.nesting == 0) {
                        op.time = System.currentTimeMillis();
                        op.rejectTime = 0;
                        op.duration = -1;
                    }
                    op.nesting += op.startOpCount;
                    while (op.clientTokens.size() != 0) {
                        ClientState client = (ClientState) this.mClients.get((IBinder) op.clientTokens.get(0));
                        if (!(client == null || client.mStartedOps == null)) {
                            client.mStartedOps.add(op);
                        }
                        op.clientTokens.remove(0);
                    }
                }
            }
            op.clientTokens.clear();
            op.startOpCount = 0;
            op.noteOpCount = 0;
        }
    }

    public void notifyOperation(int code, int uid, String packageName, int mode, boolean remember) {
        verifyIncomingUid(uid);
        verifyIncomingOp(code);
        ArrayList<Callback> repCbs = null;
        int switchCode = AppOpsManager.opToSwitch(code);
        synchronized (this) {
            recordOperationLocked(code, uid, packageName, mode);
            Op op = getOpLocked(switchCode, uid, packageName, true);
            if (op != null) {
                if (op.dialogReqQueue.getDialog() != null) {
                    op.dialogReqQueue.notifyAll(mode);
                    op.dialogReqQueue.setDialog(null);
                }
                if (remember && op.mode != mode) {
                    op.mode = mode;
                    ArrayList<Callback> cbs = (ArrayList) this.mOpModeWatchers.get(switchCode);
                    if (cbs != null) {
                        if (null == null) {
                            repCbs = new ArrayList();
                        }
                        repCbs.addAll(cbs);
                    }
                    ArrayList<Callback> repCbs2 = repCbs;
                    try {
                        cbs = (ArrayList) this.mPackageModeWatchers.get(packageName);
                        if (cbs != null) {
                            if (repCbs2 == null) {
                                repCbs = new ArrayList();
                            } else {
                                repCbs = repCbs2;
                            }
                            try {
                                repCbs.addAll(cbs);
                            } catch (Throwable th) {
                                th = th;
                                throw th;
                            }
                        }
                        repCbs = repCbs2;
                        if (mode == getDefaultMode(op.op, op.uid, op.packageName)) {
                            pruneOp(op, uid, packageName);
                        }
                        scheduleFastWriteLocked();
                    } catch (Throwable th2) {
                        Throwable th3;
                        th3 = th2;
                        repCbs = repCbs2;
                        throw th3;
                    }
                }
            }
            if (repCbs != null) {
                for (int i = 0; i < repCbs.size(); i++) {
                    try {
                        ((Callback) repCbs.get(i)).mCallback.opChanged(switchCode, packageName);
                    } catch (RemoteException e) {
                    }
                }
            }
        }
    }

    private void readPolicy() {
        if (this.mStrictEnable) {
            this.mPolicy = new AppOpsPolicy(new File(DEFAULT_POLICY_FILE), this.mContext);
            this.mPolicy.readPolicy();
            this.mPolicy.debugPoilcy();
            return;
        }
        this.mPolicy = null;
    }

    public boolean isControlAllowed(int code, String packageName) {
        if (this.mPolicy != null) {
            return this.mPolicy.isControlAllowed(code, packageName);
        }
        return true;
    }
}
