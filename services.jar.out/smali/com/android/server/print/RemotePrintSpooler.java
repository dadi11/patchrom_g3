package com.android.server.print;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Binder;
import android.os.Build;
import android.os.IBinder;
import android.os.ParcelFileDescriptor;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.print.IPrintSpooler;
import android.print.IPrintSpoolerCallbacks;
import android.print.IPrintSpoolerCallbacks.Stub;
import android.print.IPrintSpoolerClient;
import android.print.PrintJobId;
import android.print.PrintJobInfo;
import android.util.Slog;
import android.util.TimedRemoteCaller;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.lang.ref.WeakReference;
import java.util.List;
import java.util.concurrent.TimeoutException;
import libcore.io.IoUtils;

final class RemotePrintSpooler {
    private static final long BIND_SPOOLER_SERVICE_TIMEOUT;
    private static final boolean DEBUG = false;
    private static final String LOG_TAG = "RemotePrintSpooler";
    private final PrintSpoolerCallbacks mCallbacks;
    private boolean mCanUnbind;
    private final PrintSpoolerClient mClient;
    private final Context mContext;
    private boolean mDestroyed;
    private final GetPrintJobInfoCaller mGetPrintJobInfoCaller;
    private final GetPrintJobInfosCaller mGetPrintJobInfosCaller;
    private final Intent mIntent;
    private final Object mLock;
    private IPrintSpooler mRemoteInstance;
    private final ServiceConnection mServiceConnection;
    private final SetPrintJobStateCaller mSetPrintJobStatusCaller;
    private final SetPrintJobTagCaller mSetPrintJobTagCaller;
    private final UserHandle mUserHandle;

    private static abstract class BasePrintSpoolerServiceCallbacks extends Stub {
        private BasePrintSpoolerServiceCallbacks() {
        }

        public void onGetPrintJobInfosResult(List<PrintJobInfo> list, int sequence) {
        }

        public void onGetPrintJobInfoResult(PrintJobInfo printJob, int sequence) {
        }

        public void onCancelPrintJobResult(boolean canceled, int sequence) {
        }

        public void onSetPrintJobStateResult(boolean success, int sequece) {
        }

        public void onSetPrintJobTagResult(boolean success, int sequence) {
        }
    }

    private static final class GetPrintJobInfoCaller extends TimedRemoteCaller<PrintJobInfo> {
        private final IPrintSpoolerCallbacks mCallback;

        /* renamed from: com.android.server.print.RemotePrintSpooler.GetPrintJobInfoCaller.1 */
        class C04951 extends BasePrintSpoolerServiceCallbacks {
            C04951() {
                super();
            }

            public void onGetPrintJobInfoResult(PrintJobInfo printJob, int sequence) {
                GetPrintJobInfoCaller.this.onRemoteMethodResult(printJob, sequence);
            }
        }

        public GetPrintJobInfoCaller() {
            super(5000);
            this.mCallback = new C04951();
        }

        public PrintJobInfo getPrintJobInfo(IPrintSpooler target, PrintJobId printJobId, int appId) throws RemoteException, TimeoutException {
            int sequence = onBeforeRemoteCall();
            target.getPrintJobInfo(printJobId, this.mCallback, appId, sequence);
            return (PrintJobInfo) getResultTimed(sequence);
        }
    }

    private static final class GetPrintJobInfosCaller extends TimedRemoteCaller<List<PrintJobInfo>> {
        private final IPrintSpoolerCallbacks mCallback;

        /* renamed from: com.android.server.print.RemotePrintSpooler.GetPrintJobInfosCaller.1 */
        class C04961 extends BasePrintSpoolerServiceCallbacks {
            C04961() {
                super();
            }

            public void onGetPrintJobInfosResult(List<PrintJobInfo> printJobs, int sequence) {
                GetPrintJobInfosCaller.this.onRemoteMethodResult(printJobs, sequence);
            }
        }

        public GetPrintJobInfosCaller() {
            super(5000);
            this.mCallback = new C04961();
        }

        public List<PrintJobInfo> getPrintJobInfos(IPrintSpooler target, ComponentName componentName, int state, int appId) throws RemoteException, TimeoutException {
            int sequence = onBeforeRemoteCall();
            target.getPrintJobInfos(this.mCallback, componentName, state, appId, sequence);
            return (List) getResultTimed(sequence);
        }
    }

    private final class MyServiceConnection implements ServiceConnection {
        private MyServiceConnection() {
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            synchronized (RemotePrintSpooler.this.mLock) {
                RemotePrintSpooler.this.mRemoteInstance = IPrintSpooler.Stub.asInterface(service);
                RemotePrintSpooler.this.setClientLocked();
                RemotePrintSpooler.this.mLock.notifyAll();
            }
        }

        public void onServiceDisconnected(ComponentName name) {
            synchronized (RemotePrintSpooler.this.mLock) {
                RemotePrintSpooler.this.clearClientLocked();
                RemotePrintSpooler.this.mRemoteInstance = null;
            }
        }
    }

    public interface PrintSpoolerCallbacks {
        void onAllPrintJobsForServiceHandled(ComponentName componentName);

        void onPrintJobQueued(PrintJobInfo printJobInfo);

        void onPrintJobStateChanged(PrintJobInfo printJobInfo);
    }

    private static final class PrintSpoolerClient extends IPrintSpoolerClient.Stub {
        private final WeakReference<RemotePrintSpooler> mWeakSpooler;

        public PrintSpoolerClient(RemotePrintSpooler spooler) {
            this.mWeakSpooler = new WeakReference(spooler);
        }

        public void onPrintJobQueued(PrintJobInfo printJob) {
            RemotePrintSpooler spooler = (RemotePrintSpooler) this.mWeakSpooler.get();
            if (spooler != null) {
                long identity = Binder.clearCallingIdentity();
                try {
                    spooler.mCallbacks.onPrintJobQueued(printJob);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void onAllPrintJobsForServiceHandled(ComponentName printService) {
            RemotePrintSpooler spooler = (RemotePrintSpooler) this.mWeakSpooler.get();
            if (spooler != null) {
                long identity = Binder.clearCallingIdentity();
                try {
                    spooler.mCallbacks.onAllPrintJobsForServiceHandled(printService);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void onAllPrintJobsHandled() {
            RemotePrintSpooler spooler = (RemotePrintSpooler) this.mWeakSpooler.get();
            if (spooler != null) {
                long identity = Binder.clearCallingIdentity();
                try {
                    spooler.onAllPrintJobsHandled();
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public void onPrintJobStateChanged(PrintJobInfo printJob) {
            RemotePrintSpooler spooler = (RemotePrintSpooler) this.mWeakSpooler.get();
            if (spooler != null) {
                long identity = Binder.clearCallingIdentity();
                try {
                    spooler.onPrintJobStateChanged(printJob);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }
    }

    private static final class SetPrintJobStateCaller extends TimedRemoteCaller<Boolean> {
        private final IPrintSpoolerCallbacks mCallback;

        /* renamed from: com.android.server.print.RemotePrintSpooler.SetPrintJobStateCaller.1 */
        class C04971 extends BasePrintSpoolerServiceCallbacks {
            C04971() {
                super();
            }

            public void onSetPrintJobStateResult(boolean success, int sequence) {
                SetPrintJobStateCaller.this.onRemoteMethodResult(Boolean.valueOf(success), sequence);
            }
        }

        public SetPrintJobStateCaller() {
            super(5000);
            this.mCallback = new C04971();
        }

        public boolean setPrintJobState(IPrintSpooler target, PrintJobId printJobId, int status, String error) throws RemoteException, TimeoutException {
            int sequence = onBeforeRemoteCall();
            target.setPrintJobState(printJobId, status, error, this.mCallback, sequence);
            return ((Boolean) getResultTimed(sequence)).booleanValue();
        }
    }

    private static final class SetPrintJobTagCaller extends TimedRemoteCaller<Boolean> {
        private final IPrintSpoolerCallbacks mCallback;

        /* renamed from: com.android.server.print.RemotePrintSpooler.SetPrintJobTagCaller.1 */
        class C04981 extends BasePrintSpoolerServiceCallbacks {
            C04981() {
                super();
            }

            public void onSetPrintJobTagResult(boolean success, int sequence) {
                SetPrintJobTagCaller.this.onRemoteMethodResult(Boolean.valueOf(success), sequence);
            }
        }

        public SetPrintJobTagCaller() {
            super(5000);
            this.mCallback = new C04981();
        }

        public boolean setPrintJobTag(IPrintSpooler target, PrintJobId printJobId, String tag) throws RemoteException, TimeoutException {
            int sequence = onBeforeRemoteCall();
            target.setPrintJobTag(printJobId, tag, this.mCallback, sequence);
            return ((Boolean) getResultTimed(sequence)).booleanValue();
        }
    }

    static {
        BIND_SPOOLER_SERVICE_TIMEOUT = "eng".equals(Build.TYPE) ? 120000 : 10000;
    }

    public RemotePrintSpooler(Context context, int userId, PrintSpoolerCallbacks callbacks) {
        this.mLock = new Object();
        this.mGetPrintJobInfosCaller = new GetPrintJobInfosCaller();
        this.mGetPrintJobInfoCaller = new GetPrintJobInfoCaller();
        this.mSetPrintJobStatusCaller = new SetPrintJobStateCaller();
        this.mSetPrintJobTagCaller = new SetPrintJobTagCaller();
        this.mServiceConnection = new MyServiceConnection();
        this.mContext = context;
        this.mUserHandle = new UserHandle(userId);
        this.mCallbacks = callbacks;
        this.mClient = new PrintSpoolerClient(this);
        this.mIntent = new Intent();
        this.mIntent.setComponent(new ComponentName("com.android.printspooler", "com.android.printspooler.model.PrintSpoolerService"));
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public final java.util.List<android.print.PrintJobInfo> getPrintJobInfos(android.content.ComponentName r6, int r7, int r8) {
        /*
        r5 = this;
        r5.throwIfCalledOnMainThread();
        r3 = r5.mLock;
        monitor-enter(r3);
        r5.throwIfDestroyedLocked();	 Catch:{ all -> 0x0024 }
        r2 = 0;
        r5.mCanUnbind = r2;	 Catch:{ all -> 0x0024 }
        monitor-exit(r3);	 Catch:{ all -> 0x0024 }
        r2 = r5.mGetPrintJobInfosCaller;	 Catch:{ RemoteException -> 0x002a, TimeoutException -> 0x0043 }
        r3 = r5.getRemoteInstanceLazy();	 Catch:{ RemoteException -> 0x002a, TimeoutException -> 0x0043 }
        r2 = r2.getPrintJobInfos(r3, r6, r7, r8);	 Catch:{ RemoteException -> 0x002a, TimeoutException -> 0x0043 }
        r3 = r5.mLock;
        monitor-enter(r3);
        r4 = 1;
        r5.mCanUnbind = r4;	 Catch:{ all -> 0x0027 }
        r4 = r5.mLock;	 Catch:{ all -> 0x0027 }
        r4.notifyAll();	 Catch:{ all -> 0x0027 }
        monitor-exit(r3);	 Catch:{ all -> 0x0027 }
    L_0x0023:
        return r2;
    L_0x0024:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0024 }
        throw r2;
    L_0x0027:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0027 }
        throw r2;
    L_0x002a:
        r0 = move-exception;
        r2 = "RemotePrintSpooler";
        r3 = "Error getting print jobs.";
        android.util.Slog.e(r2, r3, r0);	 Catch:{ all -> 0x005b }
        r3 = r5.mLock;
        monitor-enter(r3);
        r2 = 1;
        r5.mCanUnbind = r2;	 Catch:{ all -> 0x0040 }
        r2 = r5.mLock;	 Catch:{ all -> 0x0040 }
        r2.notifyAll();	 Catch:{ all -> 0x0040 }
        monitor-exit(r3);	 Catch:{ all -> 0x0040 }
    L_0x003e:
        r2 = 0;
        goto L_0x0023;
    L_0x0040:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0040 }
        throw r2;
    L_0x0043:
        r1 = move-exception;
        r2 = "RemotePrintSpooler";
        r3 = "Error getting print jobs.";
        android.util.Slog.e(r2, r3, r1);	 Catch:{ all -> 0x005b }
        r3 = r5.mLock;
        monitor-enter(r3);
        r2 = 1;
        r5.mCanUnbind = r2;	 Catch:{ all -> 0x0058 }
        r2 = r5.mLock;	 Catch:{ all -> 0x0058 }
        r2.notifyAll();	 Catch:{ all -> 0x0058 }
        monitor-exit(r3);	 Catch:{ all -> 0x0058 }
        goto L_0x003e;
    L_0x0058:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0058 }
        throw r2;
    L_0x005b:
        r2 = move-exception;
        r3 = r5.mLock;
        monitor-enter(r3);
        r4 = 1;
        r5.mCanUnbind = r4;	 Catch:{ all -> 0x0069 }
        r4 = r5.mLock;	 Catch:{ all -> 0x0069 }
        r4.notifyAll();	 Catch:{ all -> 0x0069 }
        monitor-exit(r3);	 Catch:{ all -> 0x0069 }
        throw r2;
    L_0x0069:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0069 }
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.print.RemotePrintSpooler.getPrintJobInfos(android.content.ComponentName, int, int):java.util.List<android.print.PrintJobInfo>");
    }

    public final void createPrintJob(PrintJobInfo printJob) {
        throwIfCalledOnMainThread();
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            this.mCanUnbind = DEBUG;
        }
        try {
            getRemoteInstanceLazy().createPrintJob(printJob);
            synchronized (this.mLock) {
                this.mCanUnbind = true;
                this.mLock.notifyAll();
            }
        } catch (RemoteException re) {
            Slog.e(LOG_TAG, "Error creating print job.", re);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (TimeoutException te) {
            Slog.e(LOG_TAG, "Error creating print job.", te);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (Throwable th) {
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        }
    }

    public final void writePrintJobData(ParcelFileDescriptor fd, PrintJobId printJobId) {
        throwIfCalledOnMainThread();
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            this.mCanUnbind = DEBUG;
        }
        try {
            getRemoteInstanceLazy().writePrintJobData(fd, printJobId);
            IoUtils.closeQuietly(fd);
            synchronized (this.mLock) {
                this.mCanUnbind = true;
                this.mLock.notifyAll();
            }
        } catch (RemoteException re) {
            Slog.e(LOG_TAG, "Error writing print job data.", re);
            IoUtils.closeQuietly(fd);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (TimeoutException te) {
            Slog.e(LOG_TAG, "Error writing print job data.", te);
            IoUtils.closeQuietly(fd);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (Throwable th) {
            IoUtils.closeQuietly(fd);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public final android.print.PrintJobInfo getPrintJobInfo(android.print.PrintJobId r6, int r7) {
        /*
        r5 = this;
        r5.throwIfCalledOnMainThread();
        r3 = r5.mLock;
        monitor-enter(r3);
        r5.throwIfDestroyedLocked();	 Catch:{ all -> 0x0024 }
        r2 = 0;
        r5.mCanUnbind = r2;	 Catch:{ all -> 0x0024 }
        monitor-exit(r3);	 Catch:{ all -> 0x0024 }
        r2 = r5.mGetPrintJobInfoCaller;	 Catch:{ RemoteException -> 0x002a, TimeoutException -> 0x0043 }
        r3 = r5.getRemoteInstanceLazy();	 Catch:{ RemoteException -> 0x002a, TimeoutException -> 0x0043 }
        r2 = r2.getPrintJobInfo(r3, r6, r7);	 Catch:{ RemoteException -> 0x002a, TimeoutException -> 0x0043 }
        r3 = r5.mLock;
        monitor-enter(r3);
        r4 = 1;
        r5.mCanUnbind = r4;	 Catch:{ all -> 0x0027 }
        r4 = r5.mLock;	 Catch:{ all -> 0x0027 }
        r4.notifyAll();	 Catch:{ all -> 0x0027 }
        monitor-exit(r3);	 Catch:{ all -> 0x0027 }
    L_0x0023:
        return r2;
    L_0x0024:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0024 }
        throw r2;
    L_0x0027:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0027 }
        throw r2;
    L_0x002a:
        r0 = move-exception;
        r2 = "RemotePrintSpooler";
        r3 = "Error getting print job info.";
        android.util.Slog.e(r2, r3, r0);	 Catch:{ all -> 0x005b }
        r3 = r5.mLock;
        monitor-enter(r3);
        r2 = 1;
        r5.mCanUnbind = r2;	 Catch:{ all -> 0x0040 }
        r2 = r5.mLock;	 Catch:{ all -> 0x0040 }
        r2.notifyAll();	 Catch:{ all -> 0x0040 }
        monitor-exit(r3);	 Catch:{ all -> 0x0040 }
    L_0x003e:
        r2 = 0;
        goto L_0x0023;
    L_0x0040:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0040 }
        throw r2;
    L_0x0043:
        r1 = move-exception;
        r2 = "RemotePrintSpooler";
        r3 = "Error getting print job info.";
        android.util.Slog.e(r2, r3, r1);	 Catch:{ all -> 0x005b }
        r3 = r5.mLock;
        monitor-enter(r3);
        r2 = 1;
        r5.mCanUnbind = r2;	 Catch:{ all -> 0x0058 }
        r2 = r5.mLock;	 Catch:{ all -> 0x0058 }
        r2.notifyAll();	 Catch:{ all -> 0x0058 }
        monitor-exit(r3);	 Catch:{ all -> 0x0058 }
        goto L_0x003e;
    L_0x0058:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0058 }
        throw r2;
    L_0x005b:
        r2 = move-exception;
        r3 = r5.mLock;
        monitor-enter(r3);
        r4 = 1;
        r5.mCanUnbind = r4;	 Catch:{ all -> 0x0069 }
        r4 = r5.mLock;	 Catch:{ all -> 0x0069 }
        r4.notifyAll();	 Catch:{ all -> 0x0069 }
        monitor-exit(r3);	 Catch:{ all -> 0x0069 }
        throw r2;
    L_0x0069:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0069 }
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.print.RemotePrintSpooler.getPrintJobInfo(android.print.PrintJobId, int):android.print.PrintJobInfo");
    }

    public final boolean setPrintJobState(PrintJobId printJobId, int state, String error) {
        boolean z = DEBUG;
        throwIfCalledOnMainThread();
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            this.mCanUnbind = DEBUG;
        }
        try {
            z = this.mSetPrintJobStatusCaller.setPrintJobState(getRemoteInstanceLazy(), printJobId, state, error);
            synchronized (this.mLock) {
                this.mCanUnbind = true;
                this.mLock.notifyAll();
            }
        } catch (RemoteException re) {
            Slog.e(LOG_TAG, "Error setting print job state.", re);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (TimeoutException te) {
            Slog.e(LOG_TAG, "Error setting print job state.", te);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (Throwable th) {
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        }
        return z;
    }

    public final boolean setPrintJobTag(PrintJobId printJobId, String tag) {
        boolean z = DEBUG;
        throwIfCalledOnMainThread();
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            this.mCanUnbind = DEBUG;
        }
        try {
            z = this.mSetPrintJobTagCaller.setPrintJobTag(getRemoteInstanceLazy(), printJobId, tag);
            synchronized (this.mLock) {
                this.mCanUnbind = true;
                this.mLock.notifyAll();
            }
        } catch (RemoteException re) {
            Slog.e(LOG_TAG, "Error setting print job tag.", re);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (TimeoutException te) {
            Slog.e(LOG_TAG, "Error setting print job tag.", te);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (Throwable th) {
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        }
        return z;
    }

    public final void setPrintJobCancelling(PrintJobId printJobId, boolean cancelling) {
        throwIfCalledOnMainThread();
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            this.mCanUnbind = DEBUG;
        }
        try {
            getRemoteInstanceLazy().setPrintJobCancelling(printJobId, cancelling);
            synchronized (this.mLock) {
                this.mCanUnbind = true;
                this.mLock.notifyAll();
            }
        } catch (RemoteException re) {
            Slog.e(LOG_TAG, "Error setting print job cancelling.", re);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (TimeoutException te) {
            Slog.e(LOG_TAG, "Error setting print job cancelling.", te);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (Throwable th) {
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        }
    }

    public final void removeObsoletePrintJobs() {
        throwIfCalledOnMainThread();
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            this.mCanUnbind = DEBUG;
        }
        try {
            getRemoteInstanceLazy().removeObsoletePrintJobs();
            synchronized (this.mLock) {
                this.mCanUnbind = true;
                this.mLock.notifyAll();
            }
        } catch (RemoteException re) {
            Slog.e(LOG_TAG, "Error removing obsolete print jobs .", re);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (TimeoutException te) {
            Slog.e(LOG_TAG, "Error removing obsolete print jobs .", te);
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        } catch (Throwable th) {
            synchronized (this.mLock) {
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        }
    }

    public final void destroy() {
        throwIfCalledOnMainThread();
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            unbindLocked();
            this.mDestroyed = true;
            this.mCanUnbind = DEBUG;
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String prefix) {
        synchronized (this.mLock) {
            pw.append(prefix).append("destroyed=").append(String.valueOf(this.mDestroyed)).println();
            pw.append(prefix).append("bound=").append(this.mRemoteInstance != null ? "true" : "false").println();
            pw.flush();
            try {
                getRemoteInstanceLazy().asBinder().dump(fd, new String[]{prefix});
            } catch (TimeoutException e) {
            } catch (RemoteException e2) {
            }
        }
    }

    private void onAllPrintJobsHandled() {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            unbindLocked();
        }
    }

    private void onPrintJobStateChanged(PrintJobInfo printJob) {
        this.mCallbacks.onPrintJobStateChanged(printJob);
    }

    private IPrintSpooler getRemoteInstanceLazy() throws TimeoutException {
        IPrintSpooler iPrintSpooler;
        synchronized (this.mLock) {
            if (this.mRemoteInstance != null) {
                iPrintSpooler = this.mRemoteInstance;
            } else {
                bindLocked();
                iPrintSpooler = this.mRemoteInstance;
            }
        }
        return iPrintSpooler;
    }

    private void bindLocked() throws TimeoutException {
        if (this.mRemoteInstance == null) {
            this.mContext.bindServiceAsUser(this.mIntent, this.mServiceConnection, 1, this.mUserHandle);
            long startMillis = SystemClock.uptimeMillis();
            while (this.mRemoteInstance == null) {
                long remainingMillis = BIND_SPOOLER_SERVICE_TIMEOUT - (SystemClock.uptimeMillis() - startMillis);
                if (remainingMillis <= BIND_SPOOLER_SERVICE_TIMEOUT) {
                    throw new TimeoutException("Cannot get spooler!");
                }
                try {
                    this.mLock.wait(remainingMillis);
                } catch (InterruptedException e) {
                }
            }
            this.mCanUnbind = true;
            this.mLock.notifyAll();
        }
    }

    private void unbindLocked() {
        if (this.mRemoteInstance != null) {
            while (!this.mCanUnbind) {
                try {
                    this.mLock.wait();
                } catch (InterruptedException e) {
                }
            }
            clearClientLocked();
            this.mRemoteInstance = null;
            this.mContext.unbindService(this.mServiceConnection);
        }
    }

    private void setClientLocked() {
        try {
            this.mRemoteInstance.setClient(this.mClient);
        } catch (RemoteException re) {
            Slog.d(LOG_TAG, "Error setting print spooler client", re);
        }
    }

    private void clearClientLocked() {
        try {
            this.mRemoteInstance.setClient(null);
        } catch (RemoteException re) {
            Slog.d(LOG_TAG, "Error clearing print spooler client", re);
        }
    }

    private void throwIfDestroyedLocked() {
        if (this.mDestroyed) {
            throw new IllegalStateException("Cannot interact with a destroyed instance.");
        }
    }

    private void throwIfCalledOnMainThread() {
        if (Thread.currentThread() == this.mContext.getMainLooper().getThread()) {
            throw new RuntimeException("Cannot invoke on the main thread");
        }
    }
}
