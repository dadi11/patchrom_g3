package com.android.server.print;

import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentSender;
import android.content.pm.ParceledListSlice;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.os.UserHandle;
import android.print.IPrintDocumentAdapter;
import android.print.IPrintJobStateChangeListener;
import android.print.IPrinterDiscoveryObserver;
import android.print.IPrinterDiscoveryObserver.Stub;
import android.print.PrintAttributes;
import android.print.PrintJobId;
import android.print.PrintJobInfo;
import android.print.PrinterId;
import android.print.PrinterInfo;
import android.printservice.PrintServiceInfo;
import android.provider.Settings.Secure;
import android.text.TextUtils;
import android.text.TextUtils.SimpleStringSplitter;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.Log;
import android.util.Slog;
import android.util.SparseArray;
import com.android.internal.os.BackgroundThread;
import com.android.internal.os.SomeArgs;
import com.android.server.print.RemotePrintService.PrintServiceCallbacks;
import com.android.server.print.RemotePrintSpooler.PrintSpoolerCallbacks;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

final class UserState implements PrintSpoolerCallbacks, PrintServiceCallbacks {
    private static final char COMPONENT_NAME_SEPARATOR = ':';
    private static final boolean DEBUG = false;
    private static final String LOG_TAG = "UserState";
    private final ArrayMap<ComponentName, RemotePrintService> mActiveServices;
    private final Context mContext;
    private boolean mDestroyed;
    private final Set<ComponentName> mEnabledServices;
    private final Handler mHandler;
    private final List<PrintServiceInfo> mInstalledServices;
    private final Object mLock;
    private final PrintJobForAppCache mPrintJobForAppCache;
    private List<PrintJobStateChangeListenerRecord> mPrintJobStateChangeListenerRecords;
    private PrinterDiscoverySessionMediator mPrinterDiscoverySession;
    private final Intent mQueryIntent;
    private final RemotePrintSpooler mSpooler;
    private final SimpleStringSplitter mStringColonSplitter;
    private final int mUserId;

    /* renamed from: com.android.server.print.UserState.1 */
    class C04991 extends AsyncTask<Void, Void, Void> {
        final /* synthetic */ PrintJobInfo val$printJob;

        C04991(PrintJobInfo printJobInfo) {
            this.val$printJob = printJobInfo;
        }

        protected Void doInBackground(Void... params) {
            UserState.this.mSpooler.createPrintJob(this.val$printJob);
            return null;
        }
    }

    private class PrinterDiscoverySessionMediator {
        private final RemoteCallbackList<IPrinterDiscoveryObserver> mDiscoveryObservers;
        private final Handler mHandler;
        private boolean mIsDestroyed;
        private final ArrayMap<PrinterId, PrinterInfo> mPrinters;
        private final List<IBinder> mStartedPrinterDiscoveryTokens;
        private final List<PrinterId> mStateTrackedPrinters;

        /* renamed from: com.android.server.print.UserState.PrinterDiscoverySessionMediator.1 */
        class C05041 extends RemoteCallbackList<IPrinterDiscoveryObserver> {
            C05041() {
            }

            public void onCallbackDied(IPrinterDiscoveryObserver observer) {
                synchronized (UserState.this.mLock) {
                    PrinterDiscoverySessionMediator.this.stopPrinterDiscoveryLocked(observer);
                    PrinterDiscoverySessionMediator.this.removeObserverLocked(observer);
                }
            }
        }

        private final class SessionHandler extends Handler {
            public static final int MSG_CREATE_PRINTER_DISCOVERY_SESSION = 5;
            public static final int MSG_DESTROY_PRINTER_DISCOVERY_SESSION = 6;
            public static final int MSG_DESTROY_SERVICE = 16;
            public static final int MSG_DISPATCH_CREATE_PRINTER_DISCOVERY_SESSION = 9;
            public static final int MSG_DISPATCH_DESTROY_PRINTER_DISCOVERY_SESSION = 10;
            public static final int MSG_DISPATCH_PRINTERS_ADDED = 3;
            public static final int MSG_DISPATCH_PRINTERS_REMOVED = 4;
            public static final int MSG_DISPATCH_START_PRINTER_DISCOVERY = 11;
            public static final int MSG_DISPATCH_STOP_PRINTER_DISCOVERY = 12;
            public static final int MSG_PRINTERS_ADDED = 1;
            public static final int MSG_PRINTERS_REMOVED = 2;
            public static final int MSG_START_PRINTER_DISCOVERY = 7;
            public static final int MSG_START_PRINTER_STATE_TRACKING = 14;
            public static final int MSG_STOP_PRINTER_DISCOVERY = 8;
            public static final int MSG_STOP_PRINTER_STATE_TRACKING = 15;
            public static final int MSG_VALIDATE_PRINTERS = 13;

            SessionHandler(Looper looper) {
                super(looper, null, UserState.DEBUG);
            }

            public void handleMessage(Message message) {
                SomeArgs args;
                IPrinterDiscoveryObserver observer;
                List<PrinterId> printerIds;
                RemotePrintService service;
                PrinterId printerId;
                switch (message.what) {
                    case MSG_PRINTERS_ADDED /*1*/:
                        args = message.obj;
                        observer = args.arg1;
                        List<PrinterInfo> addedPrinters = args.arg2;
                        args.recycle();
                        PrinterDiscoverySessionMediator.this.handlePrintersAdded(observer, addedPrinters);
                        return;
                    case MSG_PRINTERS_REMOVED /*2*/:
                        args = (SomeArgs) message.obj;
                        observer = (IPrinterDiscoveryObserver) args.arg1;
                        List<PrinterId> removedPrinterIds = args.arg2;
                        args.recycle();
                        PrinterDiscoverySessionMediator.this.handlePrintersRemoved(observer, removedPrinterIds);
                        break;
                    case MSG_DISPATCH_PRINTERS_ADDED /*3*/:
                        break;
                    case MSG_DISPATCH_PRINTERS_REMOVED /*4*/:
                        PrinterDiscoverySessionMediator.this.handleDispatchPrintersRemoved((List) message.obj);
                        return;
                    case MSG_CREATE_PRINTER_DISCOVERY_SESSION /*5*/:
                        message.obj.createPrinterDiscoverySession();
                        return;
                    case MSG_DESTROY_PRINTER_DISCOVERY_SESSION /*6*/:
                        ((RemotePrintService) message.obj).destroyPrinterDiscoverySession();
                        return;
                    case MSG_START_PRINTER_DISCOVERY /*7*/:
                        ((RemotePrintService) message.obj).startPrinterDiscovery(null);
                        return;
                    case MSG_STOP_PRINTER_DISCOVERY /*8*/:
                        ((RemotePrintService) message.obj).stopPrinterDiscovery();
                        return;
                    case MSG_DISPATCH_CREATE_PRINTER_DISCOVERY_SESSION /*9*/:
                        PrinterDiscoverySessionMediator.this.handleDispatchCreatePrinterDiscoverySession(message.obj);
                        return;
                    case MSG_DISPATCH_DESTROY_PRINTER_DISCOVERY_SESSION /*10*/:
                        PrinterDiscoverySessionMediator.this.handleDispatchDestroyPrinterDiscoverySession((List) message.obj);
                        return;
                    case MSG_DISPATCH_START_PRINTER_DISCOVERY /*11*/:
                        args = (SomeArgs) message.obj;
                        List<RemotePrintService> services = (List) args.arg1;
                        printerIds = args.arg2;
                        args.recycle();
                        PrinterDiscoverySessionMediator.this.handleDispatchStartPrinterDiscovery(services, printerIds);
                        return;
                    case MSG_DISPATCH_STOP_PRINTER_DISCOVERY /*12*/:
                        PrinterDiscoverySessionMediator.this.handleDispatchStopPrinterDiscovery((List) message.obj);
                        return;
                    case MSG_VALIDATE_PRINTERS /*13*/:
                        args = (SomeArgs) message.obj;
                        service = (RemotePrintService) args.arg1;
                        printerIds = (List) args.arg2;
                        args.recycle();
                        PrinterDiscoverySessionMediator.this.handleValidatePrinters(service, printerIds);
                        return;
                    case MSG_START_PRINTER_STATE_TRACKING /*14*/:
                        args = (SomeArgs) message.obj;
                        service = (RemotePrintService) args.arg1;
                        printerId = args.arg2;
                        args.recycle();
                        PrinterDiscoverySessionMediator.this.handleStartPrinterStateTracking(service, printerId);
                        return;
                    case MSG_STOP_PRINTER_STATE_TRACKING /*15*/:
                        args = (SomeArgs) message.obj;
                        service = (RemotePrintService) args.arg1;
                        printerId = (PrinterId) args.arg2;
                        args.recycle();
                        PrinterDiscoverySessionMediator.this.handleStopPrinterStateTracking(service, printerId);
                        return;
                    case MSG_DESTROY_SERVICE /*16*/:
                        ((RemotePrintService) message.obj).destroy();
                        return;
                    default:
                        return;
                }
                PrinterDiscoverySessionMediator.this.handleDispatchPrintersAdded((List) message.obj);
            }
        }

        public PrinterDiscoverySessionMediator(Context context) {
            this.mPrinters = new ArrayMap();
            this.mDiscoveryObservers = new C05041();
            this.mStartedPrinterDiscoveryTokens = new ArrayList();
            this.mStateTrackedPrinters = new ArrayList();
            this.mHandler = new SessionHandler(context.getMainLooper());
            this.mHandler.obtainMessage(9, new ArrayList(UserState.this.mActiveServices.values())).sendToTarget();
        }

        public void addObserverLocked(IPrinterDiscoveryObserver observer) {
            this.mDiscoveryObservers.register(observer);
            if (!this.mPrinters.isEmpty()) {
                List<PrinterInfo> printers = new ArrayList(this.mPrinters.values());
                SomeArgs args = SomeArgs.obtain();
                args.arg1 = observer;
                args.arg2 = printers;
                this.mHandler.obtainMessage(1, args).sendToTarget();
            }
        }

        public void removeObserverLocked(IPrinterDiscoveryObserver observer) {
            this.mDiscoveryObservers.unregister(observer);
            if (this.mDiscoveryObservers.getRegisteredCallbackCount() == 0) {
                destroyLocked();
            }
        }

        public final void startPrinterDiscoveryLocked(IPrinterDiscoveryObserver observer, List<PrinterId> priorityList) {
            if (this.mIsDestroyed) {
                Log.w(UserState.LOG_TAG, "Not starting dicovery - session destroyed");
                return;
            }
            boolean discoveryStarted = !this.mStartedPrinterDiscoveryTokens.isEmpty() ? true : UserState.DEBUG;
            this.mStartedPrinterDiscoveryTokens.add(observer.asBinder());
            if (discoveryStarted && priorityList != null && !priorityList.isEmpty()) {
                UserState.this.validatePrinters(priorityList);
            } else if (this.mStartedPrinterDiscoveryTokens.size() <= 1) {
                List<RemotePrintService> services = new ArrayList(UserState.this.mActiveServices.values());
                SomeArgs args = SomeArgs.obtain();
                args.arg1 = services;
                args.arg2 = priorityList;
                this.mHandler.obtainMessage(11, args).sendToTarget();
            }
        }

        public final void stopPrinterDiscoveryLocked(IPrinterDiscoveryObserver observer) {
            if (this.mIsDestroyed) {
                Log.w(UserState.LOG_TAG, "Not stopping dicovery - session destroyed");
            } else if (this.mStartedPrinterDiscoveryTokens.remove(observer.asBinder()) && this.mStartedPrinterDiscoveryTokens.isEmpty()) {
                this.mHandler.obtainMessage(12, new ArrayList(UserState.this.mActiveServices.values())).sendToTarget();
            }
        }

        public void validatePrintersLocked(List<PrinterId> printerIds) {
            if (this.mIsDestroyed) {
                Log.w(UserState.LOG_TAG, "Not validating pritners - session destroyed");
                return;
            }
            List<PrinterId> remainingList = new ArrayList(printerIds);
            while (!remainingList.isEmpty()) {
                Iterator<PrinterId> iterator = remainingList.iterator();
                List<PrinterId> updateList = new ArrayList();
                ComponentName serviceName = null;
                while (iterator.hasNext()) {
                    PrinterId printerId = (PrinterId) iterator.next();
                    if (updateList.isEmpty()) {
                        updateList.add(printerId);
                        serviceName = printerId.getServiceName();
                        iterator.remove();
                    } else if (printerId.getServiceName().equals(serviceName)) {
                        updateList.add(printerId);
                        iterator.remove();
                    }
                }
                RemotePrintService service = (RemotePrintService) UserState.this.mActiveServices.get(serviceName);
                if (service != null) {
                    SomeArgs args = SomeArgs.obtain();
                    args.arg1 = service;
                    args.arg2 = updateList;
                    this.mHandler.obtainMessage(13, args).sendToTarget();
                }
            }
        }

        public final void startPrinterStateTrackingLocked(PrinterId printerId) {
            if (this.mIsDestroyed) {
                Log.w(UserState.LOG_TAG, "Not starting printer state tracking - session destroyed");
            } else if (!this.mStartedPrinterDiscoveryTokens.isEmpty()) {
                boolean containedPrinterId = this.mStateTrackedPrinters.contains(printerId);
                this.mStateTrackedPrinters.add(printerId);
                if (!containedPrinterId) {
                    RemotePrintService service = (RemotePrintService) UserState.this.mActiveServices.get(printerId.getServiceName());
                    if (service != null) {
                        SomeArgs args = SomeArgs.obtain();
                        args.arg1 = service;
                        args.arg2 = printerId;
                        this.mHandler.obtainMessage(14, args).sendToTarget();
                    }
                }
            }
        }

        public final void stopPrinterStateTrackingLocked(PrinterId printerId) {
            if (this.mIsDestroyed) {
                Log.w(UserState.LOG_TAG, "Not stopping printer state tracking - session destroyed");
            } else if (!this.mStartedPrinterDiscoveryTokens.isEmpty() && this.mStateTrackedPrinters.remove(printerId)) {
                RemotePrintService service = (RemotePrintService) UserState.this.mActiveServices.get(printerId.getServiceName());
                if (service != null) {
                    SomeArgs args = SomeArgs.obtain();
                    args.arg1 = service;
                    args.arg2 = printerId;
                    this.mHandler.obtainMessage(15, args).sendToTarget();
                }
            }
        }

        public void onDestroyed() {
        }

        public void destroyLocked() {
            if (this.mIsDestroyed) {
                Log.w(UserState.LOG_TAG, "Not destroying - session destroyed");
                return;
            }
            int i;
            this.mIsDestroyed = true;
            int printerCount = this.mStateTrackedPrinters.size();
            for (i = 0; i < printerCount; i++) {
                UserState.this.stopPrinterStateTracking((PrinterId) this.mStateTrackedPrinters.get(i));
            }
            int observerCount = this.mStartedPrinterDiscoveryTokens.size();
            for (i = 0; i < observerCount; i++) {
                stopPrinterDiscoveryLocked(Stub.asInterface((IBinder) this.mStartedPrinterDiscoveryTokens.get(i)));
            }
            this.mHandler.obtainMessage(10, new ArrayList(UserState.this.mActiveServices.values())).sendToTarget();
        }

        public void onPrintersAddedLocked(List<PrinterInfo> printers) {
            if (this.mIsDestroyed) {
                Log.w(UserState.LOG_TAG, "Not adding printers - session destroyed");
                return;
            }
            List<PrinterInfo> addedPrinters = null;
            int addedPrinterCount = printers.size();
            for (int i = 0; i < addedPrinterCount; i++) {
                PrinterInfo printer = (PrinterInfo) printers.get(i);
                PrinterInfo oldPrinter = (PrinterInfo) this.mPrinters.put(printer.getId(), printer);
                if (oldPrinter == null || !oldPrinter.equals(printer)) {
                    if (addedPrinters == null) {
                        addedPrinters = new ArrayList();
                    }
                    addedPrinters.add(printer);
                }
            }
            if (addedPrinters != null) {
                this.mHandler.obtainMessage(3, addedPrinters).sendToTarget();
            }
        }

        public void onPrintersRemovedLocked(List<PrinterId> printerIds) {
            if (this.mIsDestroyed) {
                Log.w(UserState.LOG_TAG, "Not removing printers - session destroyed");
                return;
            }
            List<PrinterId> removedPrinterIds = null;
            int removedPrinterCount = printerIds.size();
            for (int i = 0; i < removedPrinterCount; i++) {
                PrinterId removedPrinterId = (PrinterId) printerIds.get(i);
                if (this.mPrinters.remove(removedPrinterId) != null) {
                    if (removedPrinterIds == null) {
                        removedPrinterIds = new ArrayList();
                    }
                    removedPrinterIds.add(removedPrinterId);
                }
            }
            if (removedPrinterIds != null) {
                this.mHandler.obtainMessage(4, removedPrinterIds).sendToTarget();
            }
        }

        public void onServiceRemovedLocked(RemotePrintService service) {
            if (this.mIsDestroyed) {
                Log.w(UserState.LOG_TAG, "Not updating removed service - session destroyed");
                return;
            }
            removePrintersForServiceLocked(service.getComponentName());
            service.destroy();
        }

        public void onServiceDiedLocked(RemotePrintService service) {
            removePrintersForServiceLocked(service.getComponentName());
        }

        public void onServiceAddedLocked(RemotePrintService service) {
            if (this.mIsDestroyed) {
                Log.w(UserState.LOG_TAG, "Not updating added service - session destroyed");
                return;
            }
            this.mHandler.obtainMessage(5, service).sendToTarget();
            if (!this.mStartedPrinterDiscoveryTokens.isEmpty()) {
                this.mHandler.obtainMessage(7, service).sendToTarget();
            }
            int trackedPrinterCount = this.mStateTrackedPrinters.size();
            for (int i = 0; i < trackedPrinterCount; i++) {
                PrinterId printerId = (PrinterId) this.mStateTrackedPrinters.get(i);
                if (printerId.getServiceName().equals(service.getComponentName())) {
                    SomeArgs args = SomeArgs.obtain();
                    args.arg1 = service;
                    args.arg2 = printerId;
                    this.mHandler.obtainMessage(14, args).sendToTarget();
                }
            }
        }

        public void dump(PrintWriter pw, String prefix) {
            int i;
            pw.append(prefix).append("destroyed=").append(String.valueOf(UserState.this.mDestroyed)).println();
            pw.append(prefix).append("printDiscoveryInProgress=").append(String.valueOf(!this.mStartedPrinterDiscoveryTokens.isEmpty() ? true : UserState.DEBUG)).println();
            String tab = "  ";
            pw.append(prefix).append(tab).append("printer discovery observers:").println();
            int observerCount = this.mDiscoveryObservers.beginBroadcast();
            for (i = 0; i < observerCount; i++) {
                pw.append(prefix).append(prefix).append(((IPrinterDiscoveryObserver) this.mDiscoveryObservers.getBroadcastItem(i)).toString());
                pw.println();
            }
            this.mDiscoveryObservers.finishBroadcast();
            pw.append(prefix).append(tab).append("start discovery requests:").println();
            int tokenCount = this.mStartedPrinterDiscoveryTokens.size();
            for (i = 0; i < tokenCount; i++) {
                pw.append(prefix).append(tab).append(tab).append(((IBinder) this.mStartedPrinterDiscoveryTokens.get(i)).toString()).println();
            }
            pw.append(prefix).append(tab).append("tracked printer requests:").println();
            int trackedPrinters = this.mStateTrackedPrinters.size();
            for (i = 0; i < trackedPrinters; i++) {
                pw.append(prefix).append(tab).append(tab).append(((PrinterId) this.mStateTrackedPrinters.get(i)).toString()).println();
            }
            pw.append(prefix).append(tab).append("printers:").println();
            int pritnerCount = this.mPrinters.size();
            for (i = 0; i < pritnerCount; i++) {
                pw.append(prefix).append(tab).append(tab).append(((PrinterInfo) this.mPrinters.valueAt(i)).toString()).println();
            }
        }

        private void removePrintersForServiceLocked(ComponentName serviceName) {
            if (!this.mPrinters.isEmpty()) {
                int i;
                List<PrinterId> removedPrinterIds = null;
                int printerCount = this.mPrinters.size();
                for (i = 0; i < printerCount; i++) {
                    PrinterId printerId = (PrinterId) this.mPrinters.keyAt(i);
                    if (printerId.getServiceName().equals(serviceName)) {
                        if (removedPrinterIds == null) {
                            removedPrinterIds = new ArrayList();
                        }
                        removedPrinterIds.add(printerId);
                    }
                }
                if (removedPrinterIds != null) {
                    int removedPrinterCount = removedPrinterIds.size();
                    for (i = 0; i < removedPrinterCount; i++) {
                        this.mPrinters.remove(removedPrinterIds.get(i));
                    }
                    this.mHandler.obtainMessage(4, removedPrinterIds).sendToTarget();
                }
            }
        }

        private void handleDispatchPrintersAdded(List<PrinterInfo> addedPrinters) {
            int observerCount = this.mDiscoveryObservers.beginBroadcast();
            for (int i = 0; i < observerCount; i++) {
                handlePrintersAdded((IPrinterDiscoveryObserver) this.mDiscoveryObservers.getBroadcastItem(i), addedPrinters);
            }
            this.mDiscoveryObservers.finishBroadcast();
        }

        private void handleDispatchPrintersRemoved(List<PrinterId> removedPrinterIds) {
            int observerCount = this.mDiscoveryObservers.beginBroadcast();
            for (int i = 0; i < observerCount; i++) {
                handlePrintersRemoved((IPrinterDiscoveryObserver) this.mDiscoveryObservers.getBroadcastItem(i), removedPrinterIds);
            }
            this.mDiscoveryObservers.finishBroadcast();
        }

        private void handleDispatchCreatePrinterDiscoverySession(List<RemotePrintService> services) {
            int serviceCount = services.size();
            for (int i = 0; i < serviceCount; i++) {
                ((RemotePrintService) services.get(i)).createPrinterDiscoverySession();
            }
        }

        private void handleDispatchDestroyPrinterDiscoverySession(List<RemotePrintService> services) {
            int serviceCount = services.size();
            for (int i = 0; i < serviceCount; i++) {
                ((RemotePrintService) services.get(i)).destroyPrinterDiscoverySession();
            }
            onDestroyed();
        }

        private void handleDispatchStartPrinterDiscovery(List<RemotePrintService> services, List<PrinterId> printerIds) {
            int serviceCount = services.size();
            for (int i = 0; i < serviceCount; i++) {
                ((RemotePrintService) services.get(i)).startPrinterDiscovery(printerIds);
            }
        }

        private void handleDispatchStopPrinterDiscovery(List<RemotePrintService> services) {
            int serviceCount = services.size();
            for (int i = 0; i < serviceCount; i++) {
                ((RemotePrintService) services.get(i)).stopPrinterDiscovery();
            }
        }

        private void handleValidatePrinters(RemotePrintService service, List<PrinterId> printerIds) {
            service.validatePrinters(printerIds);
        }

        private void handleStartPrinterStateTracking(RemotePrintService service, PrinterId printerId) {
            service.startPrinterStateTracking(printerId);
        }

        private void handleStopPrinterStateTracking(RemotePrintService service, PrinterId printerId) {
            service.stopPrinterStateTracking(printerId);
        }

        private void handlePrintersAdded(IPrinterDiscoveryObserver observer, List<PrinterInfo> printers) {
            try {
                observer.onPrintersAdded(new ParceledListSlice(printers));
            } catch (RemoteException re) {
                Log.e(UserState.LOG_TAG, "Error sending added printers", re);
            }
        }

        private void handlePrintersRemoved(IPrinterDiscoveryObserver observer, List<PrinterId> printerIds) {
            try {
                observer.onPrintersRemoved(new ParceledListSlice(printerIds));
            } catch (RemoteException re) {
                Log.e(UserState.LOG_TAG, "Error sending removed printers", re);
            }
        }
    }

    /* renamed from: com.android.server.print.UserState.2 */
    class C05002 extends PrinterDiscoverySessionMediator {
        C05002(Context x0) {
            super(x0);
        }

        public void onDestroyed() {
            UserState.this.mPrinterDiscoverySession = null;
        }
    }

    private abstract class PrintJobStateChangeListenerRecord implements DeathRecipient {
        final int appId;
        final IPrintJobStateChangeListener listener;

        public abstract void onBinderDied();

        public PrintJobStateChangeListenerRecord(IPrintJobStateChangeListener listener, int appId) throws RemoteException {
            this.listener = listener;
            this.appId = appId;
            listener.asBinder().linkToDeath(this, 0);
        }

        public void binderDied() {
            this.listener.asBinder().unlinkToDeath(this, 0);
            onBinderDied();
        }
    }

    /* renamed from: com.android.server.print.UserState.3 */
    class C05013 extends PrintJobStateChangeListenerRecord {
        C05013(IPrintJobStateChangeListener x0, int x1) {
            super(x0, x1);
        }

        public void onBinderDied() {
            UserState.this.mPrintJobStateChangeListenerRecords.remove(this);
        }
    }

    /* renamed from: com.android.server.print.UserState.4 */
    class C05024 implements Runnable {
        final /* synthetic */ ComponentName val$serviceName;

        C05024(ComponentName componentName) {
            this.val$serviceName = componentName;
        }

        public void run() {
            UserState.this.failScheduledPrintJobsForServiceInternal(this.val$serviceName);
        }
    }

    private final class PrintJobForAppCache {
        private final SparseArray<List<PrintJobInfo>> mPrintJobsForRunningApp;

        /* renamed from: com.android.server.print.UserState.PrintJobForAppCache.1 */
        class C05031 implements DeathRecipient {
            final /* synthetic */ int val$appId;
            final /* synthetic */ IBinder val$creator;

            C05031(IBinder iBinder, int i) {
                this.val$creator = iBinder;
                this.val$appId = i;
            }

            public void binderDied() {
                this.val$creator.unlinkToDeath(this, 0);
                synchronized (UserState.this.mLock) {
                    PrintJobForAppCache.this.mPrintJobsForRunningApp.remove(this.val$appId);
                }
            }
        }

        private PrintJobForAppCache() {
            this.mPrintJobsForRunningApp = new SparseArray();
        }

        public boolean onPrintJobCreated(IBinder creator, int appId, PrintJobInfo printJob) {
            try {
                creator.linkToDeath(new C05031(creator, appId), 0);
                synchronized (UserState.this.mLock) {
                    List<PrintJobInfo> printJobsForApp = (List) this.mPrintJobsForRunningApp.get(appId);
                    if (printJobsForApp == null) {
                        printJobsForApp = new ArrayList();
                        this.mPrintJobsForRunningApp.put(appId, printJobsForApp);
                    }
                    printJobsForApp.add(printJob);
                }
                return true;
            } catch (RemoteException e) {
                return UserState.DEBUG;
            }
        }

        public void onPrintJobStateChanged(PrintJobInfo printJob) {
            synchronized (UserState.this.mLock) {
                List<PrintJobInfo> printJobsForApp = (List) this.mPrintJobsForRunningApp.get(printJob.getAppId());
                if (printJobsForApp == null) {
                    return;
                }
                int printJobCount = printJobsForApp.size();
                for (int i = 0; i < printJobCount; i++) {
                    if (((PrintJobInfo) printJobsForApp.get(i)).getId().equals(printJob.getId())) {
                        printJobsForApp.set(i, printJob);
                    }
                }
            }
        }

        public PrintJobInfo getPrintJob(PrintJobId printJobId, int appId) {
            synchronized (UserState.this.mLock) {
                List<PrintJobInfo> printJobsForApp = (List) this.mPrintJobsForRunningApp.get(appId);
                if (printJobsForApp == null) {
                    return null;
                }
                int printJobCount = printJobsForApp.size();
                for (int i = 0; i < printJobCount; i++) {
                    PrintJobInfo printJob = (PrintJobInfo) printJobsForApp.get(i);
                    if (printJob.getId().equals(printJobId)) {
                        return printJob;
                    }
                }
                return null;
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public java.util.List<android.print.PrintJobInfo> getPrintJobs(int r8) {
            /*
            r7 = this;
            r5 = com.android.server.print.UserState.this;
            r6 = r5.mLock;
            monitor-enter(r6);
            r3 = 0;
            r5 = -2;
            if (r8 != r5) goto L_0x0030;
        L_0x000b:
            r5 = r7.mPrintJobsForRunningApp;	 Catch:{ all -> 0x0046 }
            r1 = r5.size();	 Catch:{ all -> 0x0046 }
            r2 = 0;
            r4 = r3;
        L_0x0013:
            if (r2 >= r1) goto L_0x002b;
        L_0x0015:
            r5 = r7.mPrintJobsForRunningApp;	 Catch:{ all -> 0x0050 }
            r0 = r5.valueAt(r2);	 Catch:{ all -> 0x0050 }
            r0 = (java.util.List) r0;	 Catch:{ all -> 0x0050 }
            if (r4 != 0) goto L_0x0053;
        L_0x001f:
            r3 = new java.util.ArrayList;	 Catch:{ all -> 0x0050 }
            r3.<init>();	 Catch:{ all -> 0x0050 }
        L_0x0024:
            r3.addAll(r0);	 Catch:{ all -> 0x0046 }
            r2 = r2 + 1;
            r4 = r3;
            goto L_0x0013;
        L_0x002b:
            r3 = r4;
        L_0x002c:
            if (r3 == 0) goto L_0x0049;
        L_0x002e:
            monitor-exit(r6);	 Catch:{ all -> 0x0046 }
        L_0x002f:
            return r3;
        L_0x0030:
            r5 = r7.mPrintJobsForRunningApp;	 Catch:{ all -> 0x0046 }
            r0 = r5.get(r8);	 Catch:{ all -> 0x0046 }
            r0 = (java.util.List) r0;	 Catch:{ all -> 0x0046 }
            if (r0 == 0) goto L_0x002c;
        L_0x003a:
            if (r3 != 0) goto L_0x0042;
        L_0x003c:
            r4 = new java.util.ArrayList;	 Catch:{ all -> 0x0046 }
            r4.<init>();	 Catch:{ all -> 0x0046 }
            r3 = r4;
        L_0x0042:
            r3.addAll(r0);	 Catch:{ all -> 0x0046 }
            goto L_0x002c;
        L_0x0046:
            r5 = move-exception;
        L_0x0047:
            monitor-exit(r6);	 Catch:{ all -> 0x0046 }
            throw r5;
        L_0x0049:
            r5 = java.util.Collections.emptyList();	 Catch:{ all -> 0x0046 }
            monitor-exit(r6);	 Catch:{ all -> 0x0046 }
            r3 = r5;
            goto L_0x002f;
        L_0x0050:
            r5 = move-exception;
            r3 = r4;
            goto L_0x0047;
        L_0x0053:
            r3 = r4;
            goto L_0x0024;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.print.UserState.PrintJobForAppCache.getPrintJobs(int):java.util.List<android.print.PrintJobInfo>");
        }

        public void dump(PrintWriter pw, String prefix) {
            synchronized (UserState.this.mLock) {
                String tab = "  ";
                int bucketCount = this.mPrintJobsForRunningApp.size();
                for (int i = 0; i < bucketCount; i++) {
                    pw.append(prefix).append("appId=" + this.mPrintJobsForRunningApp.keyAt(i)).append(UserState.COMPONENT_NAME_SEPARATOR).println();
                    List<PrintJobInfo> bucket = (List) this.mPrintJobsForRunningApp.valueAt(i);
                    int printJobCount = bucket.size();
                    for (int j = 0; j < printJobCount; j++) {
                        pw.append(prefix).append(tab).append(((PrintJobInfo) bucket.get(j)).toString()).println();
                    }
                }
            }
        }
    }

    private final class UserStateHandler extends Handler {
        public static final int MSG_DISPATCH_PRINT_JOB_STATE_CHANGED = 1;

        public UserStateHandler(Looper looper) {
            super(looper, null, UserState.DEBUG);
        }

        public void handleMessage(Message message) {
            if (message.what == MSG_DISPATCH_PRINT_JOB_STATE_CHANGED) {
                UserState.this.handleDispatchPrintJobStateChanged(message.obj, message.arg1);
            }
        }
    }

    public UserState(Context context, int userId, Object lock) {
        this.mStringColonSplitter = new SimpleStringSplitter(COMPONENT_NAME_SEPARATOR);
        this.mQueryIntent = new Intent("android.printservice.PrintService");
        this.mActiveServices = new ArrayMap();
        this.mInstalledServices = new ArrayList();
        this.mEnabledServices = new ArraySet();
        this.mPrintJobForAppCache = new PrintJobForAppCache();
        this.mContext = context;
        this.mUserId = userId;
        this.mLock = lock;
        this.mSpooler = new RemotePrintSpooler(context, userId, this);
        this.mHandler = new UserStateHandler(context.getMainLooper());
        synchronized (this.mLock) {
            enableSystemPrintServicesLocked();
            onConfigurationChangedLocked();
        }
    }

    public void onPrintJobQueued(PrintJobInfo printJob) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            RemotePrintService service = (RemotePrintService) this.mActiveServices.get(printJob.getPrinterId().getServiceName());
        }
        if (service != null) {
            service.onPrintJobQueued(printJob);
        } else {
            this.mSpooler.setPrintJobState(printJob.getId(), 6, this.mContext.getString(17041016));
        }
    }

    public void onAllPrintJobsForServiceHandled(ComponentName printService) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            RemotePrintService service = (RemotePrintService) this.mActiveServices.get(printService);
        }
        if (service != null) {
            service.onAllPrintJobsHandled();
        }
    }

    public void removeObsoletePrintJobs() {
        this.mSpooler.removeObsoletePrintJobs();
    }

    public Bundle print(String printJobName, IPrintDocumentAdapter adapter, PrintAttributes attributes, String packageName, int appId) {
        PrintJobInfo printJob = new PrintJobInfo();
        printJob.setId(new PrintJobId());
        printJob.setAppId(appId);
        printJob.setLabel(printJobName);
        printJob.setAttributes(attributes);
        printJob.setState(1);
        printJob.setCopies(1);
        printJob.setCreationTime(System.currentTimeMillis());
        if (!this.mPrintJobForAppCache.onPrintJobCreated(adapter.asBinder(), appId, printJob)) {
            return null;
        }
        new C04991(printJob).executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, (Void[]) null);
        long identity = Binder.clearCallingIdentity();
        try {
            Intent intent = new Intent("android.print.PRINT_DIALOG");
            intent.setData(Uri.fromParts("printjob", printJob.getId().flattenToString(), null));
            intent.putExtra("android.print.intent.extra.EXTRA_PRINT_DOCUMENT_ADAPTER", adapter.asBinder());
            intent.putExtra("android.print.intent.extra.EXTRA_PRINT_JOB", printJob);
            intent.putExtra("android.content.extra.PACKAGE_NAME", packageName);
            IntentSender intentSender = PendingIntent.getActivityAsUser(this.mContext, 0, intent, 1342177280, null, new UserHandle(this.mUserId)).getIntentSender();
            Bundle result = new Bundle();
            result.putParcelable("android.print.intent.extra.EXTRA_PRINT_JOB", printJob);
            result.putParcelable("android.print.intent.extra.EXTRA_PRINT_DIALOG_INTENT", intentSender);
            return result;
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
    }

    public List<PrintJobInfo> getPrintJobInfos(int appId) {
        int i;
        List<PrintJobInfo> cachedPrintJobs = this.mPrintJobForAppCache.getPrintJobs(appId);
        ArrayMap<PrintJobId, PrintJobInfo> result = new ArrayMap();
        int cachedPrintJobCount = cachedPrintJobs.size();
        for (i = 0; i < cachedPrintJobCount; i++) {
            PrintJobInfo cachedPrintJob = (PrintJobInfo) cachedPrintJobs.get(i);
            result.put(cachedPrintJob.getId(), cachedPrintJob);
            cachedPrintJob.setTag(null);
            cachedPrintJob.setAdvancedOptions(null);
        }
        List<PrintJobInfo> printJobs = this.mSpooler.getPrintJobInfos(null, -1, appId);
        if (printJobs != null) {
            int printJobCount = printJobs.size();
            for (i = 0; i < printJobCount; i++) {
                PrintJobInfo printJob = (PrintJobInfo) printJobs.get(i);
                result.put(printJob.getId(), printJob);
                printJob.setTag(null);
                printJob.setAdvancedOptions(null);
            }
        }
        return new ArrayList(result.values());
    }

    public PrintJobInfo getPrintJobInfo(PrintJobId printJobId, int appId) {
        PrintJobInfo printJob = this.mPrintJobForAppCache.getPrintJob(printJobId, appId);
        if (printJob == null) {
            printJob = this.mSpooler.getPrintJobInfo(printJobId, appId);
        }
        if (printJob != null) {
            printJob.setTag(null);
            printJob.setAdvancedOptions(null);
        }
        return printJob;
    }

    public void cancelPrintJob(PrintJobId printJobId, int appId) {
        PrintJobInfo printJobInfo = this.mSpooler.getPrintJobInfo(printJobId, appId);
        if (printJobInfo != null) {
            this.mSpooler.setPrintJobCancelling(printJobId, true);
            if (printJobInfo.getState() != 6) {
                RemotePrintService printService;
                ComponentName printServiceName = printJobInfo.getPrinterId().getServiceName();
                synchronized (this.mLock) {
                    printService = (RemotePrintService) this.mActiveServices.get(printServiceName);
                }
                if (printService != null) {
                    printService.onRequestCancelPrintJob(printJobInfo);
                    return;
                }
                return;
            }
            this.mSpooler.setPrintJobState(printJobId, 7, null);
        }
    }

    public void restartPrintJob(PrintJobId printJobId, int appId) {
        PrintJobInfo printJobInfo = getPrintJobInfo(printJobId, appId);
        if (printJobInfo != null && printJobInfo.getState() == 6) {
            this.mSpooler.setPrintJobState(printJobId, 2, null);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public java.util.List<android.printservice.PrintServiceInfo> getEnabledPrintServices() {
        /*
        r9 = this;
        r7 = r9.mLock;
        monitor-enter(r7);
        r1 = 0;
        r6 = r9.mInstalledServices;	 Catch:{ all -> 0x0043 }
        r5 = r6.size();	 Catch:{ all -> 0x0043 }
        r3 = 0;
        r2 = r1;
    L_0x000c:
        if (r3 >= r5) goto L_0x0041;
    L_0x000e:
        r6 = r9.mInstalledServices;	 Catch:{ all -> 0x0046 }
        r4 = r6.get(r3);	 Catch:{ all -> 0x0046 }
        r4 = (android.printservice.PrintServiceInfo) r4;	 Catch:{ all -> 0x0046 }
        r0 = new android.content.ComponentName;	 Catch:{ all -> 0x0046 }
        r6 = r4.getResolveInfo();	 Catch:{ all -> 0x0046 }
        r6 = r6.serviceInfo;	 Catch:{ all -> 0x0046 }
        r6 = r6.packageName;	 Catch:{ all -> 0x0046 }
        r8 = r4.getResolveInfo();	 Catch:{ all -> 0x0046 }
        r8 = r8.serviceInfo;	 Catch:{ all -> 0x0046 }
        r8 = r8.name;	 Catch:{ all -> 0x0046 }
        r0.<init>(r6, r8);	 Catch:{ all -> 0x0046 }
        r6 = r9.mActiveServices;	 Catch:{ all -> 0x0046 }
        r6 = r6.containsKey(r0);	 Catch:{ all -> 0x0046 }
        if (r6 == 0) goto L_0x004b;
    L_0x0033:
        if (r2 != 0) goto L_0x0049;
    L_0x0035:
        r1 = new java.util.ArrayList;	 Catch:{ all -> 0x0046 }
        r1.<init>();	 Catch:{ all -> 0x0046 }
    L_0x003a:
        r1.add(r4);	 Catch:{ all -> 0x0043 }
    L_0x003d:
        r3 = r3 + 1;
        r2 = r1;
        goto L_0x000c;
    L_0x0041:
        monitor-exit(r7);	 Catch:{ all -> 0x0046 }
        return r2;
    L_0x0043:
        r6 = move-exception;
    L_0x0044:
        monitor-exit(r7);	 Catch:{ all -> 0x0043 }
        throw r6;
    L_0x0046:
        r6 = move-exception;
        r1 = r2;
        goto L_0x0044;
    L_0x0049:
        r1 = r2;
        goto L_0x003a;
    L_0x004b:
        r1 = r2;
        goto L_0x003d;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.print.UserState.getEnabledPrintServices():java.util.List<android.printservice.PrintServiceInfo>");
    }

    public List<PrintServiceInfo> getInstalledPrintServices() {
        List<PrintServiceInfo> list;
        synchronized (this.mLock) {
            list = this.mInstalledServices;
        }
        return list;
    }

    public void createPrinterDiscoverySession(IPrinterDiscoveryObserver observer) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            if (this.mActiveServices.isEmpty()) {
                return;
            }
            if (this.mPrinterDiscoverySession == null) {
                this.mPrinterDiscoverySession = new C05002(this.mContext);
                this.mPrinterDiscoverySession.addObserverLocked(observer);
            } else {
                this.mPrinterDiscoverySession.addObserverLocked(observer);
            }
        }
    }

    public void destroyPrinterDiscoverySession(IPrinterDiscoveryObserver observer) {
        synchronized (this.mLock) {
            if (this.mPrinterDiscoverySession == null) {
                return;
            }
            this.mPrinterDiscoverySession.removeObserverLocked(observer);
        }
    }

    public void startPrinterDiscovery(IPrinterDiscoveryObserver observer, List<PrinterId> printerIds) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            if (this.mActiveServices.isEmpty()) {
            } else if (this.mPrinterDiscoverySession == null) {
            } else {
                this.mPrinterDiscoverySession.startPrinterDiscoveryLocked(observer, printerIds);
            }
        }
    }

    public void stopPrinterDiscovery(IPrinterDiscoveryObserver observer) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            if (this.mActiveServices.isEmpty()) {
            } else if (this.mPrinterDiscoverySession == null) {
            } else {
                this.mPrinterDiscoverySession.stopPrinterDiscoveryLocked(observer);
            }
        }
    }

    public void validatePrinters(List<PrinterId> printerIds) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            if (this.mActiveServices.isEmpty()) {
            } else if (this.mPrinterDiscoverySession == null) {
            } else {
                this.mPrinterDiscoverySession.validatePrintersLocked(printerIds);
            }
        }
    }

    public void startPrinterStateTracking(PrinterId printerId) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            if (this.mActiveServices.isEmpty()) {
            } else if (this.mPrinterDiscoverySession == null) {
            } else {
                this.mPrinterDiscoverySession.startPrinterStateTrackingLocked(printerId);
            }
        }
    }

    public void stopPrinterStateTracking(PrinterId printerId) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            if (this.mActiveServices.isEmpty()) {
            } else if (this.mPrinterDiscoverySession == null) {
            } else {
                this.mPrinterDiscoverySession.stopPrinterStateTrackingLocked(printerId);
            }
        }
    }

    public void addPrintJobStateChangeListener(IPrintJobStateChangeListener listener, int appId) throws RemoteException {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            if (this.mPrintJobStateChangeListenerRecords == null) {
                this.mPrintJobStateChangeListenerRecords = new ArrayList();
            }
            this.mPrintJobStateChangeListenerRecords.add(new C05013(listener, appId));
        }
    }

    public void removePrintJobStateChangeListener(IPrintJobStateChangeListener listener) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            if (this.mPrintJobStateChangeListenerRecords == null) {
                return;
            }
            int recordCount = this.mPrintJobStateChangeListenerRecords.size();
            for (int i = 0; i < recordCount; i++) {
                if (((PrintJobStateChangeListenerRecord) this.mPrintJobStateChangeListenerRecords.get(i)).listener.asBinder().equals(listener.asBinder())) {
                    this.mPrintJobStateChangeListenerRecords.remove(i);
                    break;
                }
            }
            if (this.mPrintJobStateChangeListenerRecords.isEmpty()) {
                this.mPrintJobStateChangeListenerRecords = null;
            }
        }
    }

    public void onPrintJobStateChanged(PrintJobInfo printJob) {
        this.mPrintJobForAppCache.onPrintJobStateChanged(printJob);
        this.mHandler.obtainMessage(1, printJob.getAppId(), 0, printJob.getId()).sendToTarget();
    }

    public void onPrintersAdded(List<PrinterInfo> printers) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            if (this.mActiveServices.isEmpty()) {
            } else if (this.mPrinterDiscoverySession == null) {
            } else {
                this.mPrinterDiscoverySession.onPrintersAddedLocked(printers);
            }
        }
    }

    public void onPrintersRemoved(List<PrinterId> printerIds) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            if (this.mActiveServices.isEmpty()) {
            } else if (this.mPrinterDiscoverySession == null) {
            } else {
                this.mPrinterDiscoverySession.onPrintersRemovedLocked(printerIds);
            }
        }
    }

    public void onServiceDied(RemotePrintService service) {
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            if (this.mActiveServices.isEmpty()) {
                return;
            }
            failActivePrintJobsForService(service.getComponentName());
            service.onAllPrintJobsHandled();
            if (this.mPrinterDiscoverySession == null) {
                return;
            }
            this.mPrinterDiscoverySession.onServiceDiedLocked(service);
        }
    }

    public void updateIfNeededLocked() {
        throwIfDestroyedLocked();
        if (readConfigurationLocked()) {
            onConfigurationChangedLocked();
        }
    }

    public Set<ComponentName> getEnabledServices() {
        Set<ComponentName> set;
        synchronized (this.mLock) {
            throwIfDestroyedLocked();
            set = this.mEnabledServices;
        }
        return set;
    }

    public void destroyLocked() {
        throwIfDestroyedLocked();
        this.mSpooler.destroy();
        for (RemotePrintService service : this.mActiveServices.values()) {
            service.destroy();
        }
        this.mActiveServices.clear();
        this.mInstalledServices.clear();
        this.mEnabledServices.clear();
        if (this.mPrinterDiscoverySession != null) {
            this.mPrinterDiscoverySession.destroyLocked();
            this.mPrinterDiscoverySession = null;
        }
        this.mDestroyed = true;
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String prefix) {
        int i;
        pw.append(prefix).append("user state ").append(String.valueOf(this.mUserId)).append(":");
        pw.println();
        String tab = "  ";
        pw.append(prefix).append(tab).append("installed services:").println();
        int installedServiceCount = this.mInstalledServices.size();
        for (i = 0; i < installedServiceCount; i++) {
            PrintServiceInfo installedService = (PrintServiceInfo) this.mInstalledServices.get(i);
            String installedServicePrefix = prefix + tab + tab;
            pw.append(installedServicePrefix).append("service:").println();
            ResolveInfo resolveInfo = installedService.getResolveInfo();
            pw.append(installedServicePrefix).append(tab).append("componentName=").append(new ComponentName(resolveInfo.serviceInfo.packageName, resolveInfo.serviceInfo.name).flattenToString()).println();
            pw.append(installedServicePrefix).append(tab).append("settingsActivity=").append(installedService.getSettingsActivityName()).println();
            pw.append(installedServicePrefix).append(tab).append("addPrintersActivity=").append(installedService.getAddPrintersActivityName()).println();
            pw.append(installedServicePrefix).append(tab).append("avancedOptionsActivity=").append(installedService.getAdvancedOptionsActivityName()).println();
        }
        pw.append(prefix).append(tab).append("enabled services:").println();
        for (ComponentName enabledService : this.mEnabledServices) {
            String enabledServicePrefix = prefix + tab + tab;
            pw.append(enabledServicePrefix).append("service:").println();
            pw.append(enabledServicePrefix).append(tab).append("componentName=").append(enabledService.flattenToString());
            pw.println();
        }
        pw.append(prefix).append(tab).append("active services:").println();
        int activeServiceCount = this.mActiveServices.size();
        for (i = 0; i < activeServiceCount; i++) {
            ((RemotePrintService) this.mActiveServices.valueAt(i)).dump(pw, prefix + tab + tab);
            pw.println();
        }
        pw.append(prefix).append(tab).append("cached print jobs:").println();
        this.mPrintJobForAppCache.dump(pw, prefix + tab + tab);
        pw.append(prefix).append(tab).append("discovery mediator:").println();
        if (this.mPrinterDiscoverySession != null) {
            this.mPrinterDiscoverySession.dump(pw, prefix + tab + tab);
        }
        pw.append(prefix).append(tab).append("print spooler:").println();
        this.mSpooler.dump(fd, pw, prefix + tab + tab);
        pw.println();
    }

    private boolean readConfigurationLocked() {
        return (DEBUG | readInstalledPrintServicesLocked()) | readEnabledPrintServicesLocked();
    }

    private boolean readInstalledPrintServicesLocked() {
        Set<PrintServiceInfo> tempPrintServices = new HashSet();
        List<ResolveInfo> installedServices = this.mContext.getPackageManager().queryIntentServicesAsUser(this.mQueryIntent, 132, this.mUserId);
        int count = installedServices.size();
        for (int i = 0; i < count; i++) {
            ResolveInfo installedService = (ResolveInfo) installedServices.get(i);
            if ("android.permission.BIND_PRINT_SERVICE".equals(installedService.serviceInfo.permission)) {
                tempPrintServices.add(PrintServiceInfo.create(installedService, this.mContext));
            } else {
                Slog.w(LOG_TAG, "Skipping print service " + new ComponentName(installedService.serviceInfo.packageName, installedService.serviceInfo.name).flattenToShortString() + " since it does not require permission " + "android.permission.BIND_PRINT_SERVICE");
            }
        }
        boolean someServiceChanged = DEBUG;
        if (tempPrintServices.size() == this.mInstalledServices.size()) {
            for (PrintServiceInfo newService : tempPrintServices) {
                int oldServiceIndex = this.mInstalledServices.indexOf(newService);
                if (oldServiceIndex >= 0) {
                    PrintServiceInfo oldService = (PrintServiceInfo) this.mInstalledServices.get(oldServiceIndex);
                    if (TextUtils.equals(oldService.getAddPrintersActivityName(), newService.getAddPrintersActivityName()) && TextUtils.equals(oldService.getAdvancedOptionsActivityName(), newService.getAdvancedOptionsActivityName())) {
                        if (!TextUtils.equals(oldService.getSettingsActivityName(), newService.getSettingsActivityName())) {
                            someServiceChanged = true;
                            break;
                        }
                    }
                    someServiceChanged = true;
                    break;
                }
                someServiceChanged = true;
                break;
            }
        }
        someServiceChanged = true;
        if (!someServiceChanged) {
            return DEBUG;
        }
        this.mInstalledServices.clear();
        this.mInstalledServices.addAll(tempPrintServices);
        return true;
    }

    private boolean readEnabledPrintServicesLocked() {
        Set<ComponentName> tempEnabledServiceNameSet = new HashSet();
        readPrintServicesFromSettingLocked("enabled_print_services", tempEnabledServiceNameSet);
        if (tempEnabledServiceNameSet.equals(this.mEnabledServices)) {
            return DEBUG;
        }
        this.mEnabledServices.clear();
        this.mEnabledServices.addAll(tempEnabledServiceNameSet);
        return true;
    }

    private void readPrintServicesFromSettingLocked(String setting, Set<ComponentName> outServiceNames) {
        String settingValue = Secure.getStringForUser(this.mContext.getContentResolver(), setting, this.mUserId);
        if (!TextUtils.isEmpty(settingValue)) {
            SimpleStringSplitter splitter = this.mStringColonSplitter;
            splitter.setString(settingValue);
            while (splitter.hasNext()) {
                String string = splitter.next();
                if (!TextUtils.isEmpty(string)) {
                    ComponentName componentName = ComponentName.unflattenFromString(string);
                    if (componentName != null) {
                        outServiceNames.add(componentName);
                    }
                }
            }
        }
    }

    private void enableSystemPrintServicesLocked() {
        readEnabledPrintServicesLocked();
        readInstalledPrintServicesLocked();
        Set<ComponentName> enabledOnFirstBoot = new HashSet();
        readPrintServicesFromSettingLocked("enabled_on_first_boot_system_print_services", enabledOnFirstBoot);
        StringBuilder builder = new StringBuilder();
        int serviceCount = this.mInstalledServices.size();
        for (int i = 0; i < serviceCount; i++) {
            ServiceInfo serviceInfo = ((PrintServiceInfo) this.mInstalledServices.get(i)).getResolveInfo().serviceInfo;
            if ((serviceInfo.applicationInfo.flags & 1) != 0) {
                ComponentName serviceName = new ComponentName(serviceInfo.packageName, serviceInfo.name);
                if (!(this.mEnabledServices.contains(serviceName) || enabledOnFirstBoot.contains(serviceName))) {
                    if (builder.length() > 0) {
                        builder.append(":");
                    }
                    builder.append(serviceName.flattenToString());
                }
            }
        }
        if (builder.length() > 0) {
            String servicesToEnable = builder.toString();
            String enabledServices = Secure.getStringForUser(this.mContext.getContentResolver(), "enabled_print_services", this.mUserId);
            if (TextUtils.isEmpty(enabledServices)) {
                enabledServices = servicesToEnable;
            } else {
                enabledServices = enabledServices + ":" + servicesToEnable;
            }
            Secure.putStringForUser(this.mContext.getContentResolver(), "enabled_print_services", enabledServices, this.mUserId);
            String enabledOnFirstBootServices = Secure.getStringForUser(this.mContext.getContentResolver(), "enabled_on_first_boot_system_print_services", this.mUserId);
            if (TextUtils.isEmpty(enabledOnFirstBootServices)) {
                enabledOnFirstBootServices = servicesToEnable;
            } else {
                enabledOnFirstBootServices = enabledOnFirstBootServices + ":" + enabledServices;
            }
            Secure.putStringForUser(this.mContext.getContentResolver(), "enabled_on_first_boot_system_print_services", enabledOnFirstBootServices, this.mUserId);
        }
    }

    private void onConfigurationChangedLocked() {
        Set<ComponentName> installedComponents = new ArraySet();
        int installedCount = this.mInstalledServices.size();
        for (int i = 0; i < installedCount; i++) {
            RemotePrintService service;
            ResolveInfo resolveInfo = ((PrintServiceInfo) this.mInstalledServices.get(i)).getResolveInfo();
            ComponentName serviceName = new ComponentName(resolveInfo.serviceInfo.packageName, resolveInfo.serviceInfo.name);
            installedComponents.add(serviceName);
            if (!this.mEnabledServices.contains(serviceName)) {
                service = (RemotePrintService) this.mActiveServices.remove(serviceName);
                if (service != null) {
                    removeServiceLocked(service);
                }
            } else if (!this.mActiveServices.containsKey(serviceName)) {
                addServiceLocked(new RemotePrintService(this.mContext, serviceName, this.mUserId, this.mSpooler, this));
            }
        }
        Iterator<Entry<ComponentName, RemotePrintService>> iterator = this.mActiveServices.entrySet().iterator();
        while (iterator.hasNext()) {
            Entry<ComponentName, RemotePrintService> entry = (Entry) iterator.next();
            service = (RemotePrintService) entry.getValue();
            if (!installedComponents.contains((ComponentName) entry.getKey())) {
                removeServiceLocked(service);
                iterator.remove();
            }
        }
    }

    private void addServiceLocked(RemotePrintService service) {
        this.mActiveServices.put(service.getComponentName(), service);
        if (this.mPrinterDiscoverySession != null) {
            this.mPrinterDiscoverySession.onServiceAddedLocked(service);
        }
    }

    private void removeServiceLocked(RemotePrintService service) {
        failActivePrintJobsForService(service.getComponentName());
        if (this.mPrinterDiscoverySession != null) {
            this.mPrinterDiscoverySession.onServiceRemovedLocked(service);
        } else {
            service.destroy();
        }
    }

    private void failActivePrintJobsForService(ComponentName serviceName) {
        if (Looper.getMainLooper().isCurrentThread()) {
            BackgroundThread.getHandler().post(new C05024(serviceName));
        } else {
            failScheduledPrintJobsForServiceInternal(serviceName);
        }
    }

    private void failScheduledPrintJobsForServiceInternal(ComponentName serviceName) {
        List<PrintJobInfo> printJobs = this.mSpooler.getPrintJobInfos(serviceName, -4, -2);
        if (printJobs != null) {
            long identity = Binder.clearCallingIdentity();
            try {
                int printJobCount = printJobs.size();
                for (int i = 0; i < printJobCount; i++) {
                    this.mSpooler.setPrintJobState(((PrintJobInfo) printJobs.get(i)).getId(), 6, this.mContext.getString(17041016));
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }
    }

    private void throwIfDestroyedLocked() {
        if (this.mDestroyed) {
            throw new IllegalStateException("Cannot interact with a destroyed instance.");
        }
    }

    private void handleDispatchPrintJobStateChanged(PrintJobId printJobId, int appId) {
        synchronized (this.mLock) {
            if (this.mPrintJobStateChangeListenerRecords == null) {
                return;
            }
            List<PrintJobStateChangeListenerRecord> records = new ArrayList(this.mPrintJobStateChangeListenerRecords);
            int recordCount = records.size();
            for (int i = 0; i < recordCount; i++) {
                PrintJobStateChangeListenerRecord record = (PrintJobStateChangeListenerRecord) records.get(i);
                if (record.appId == -2 || record.appId == appId) {
                    try {
                        record.listener.onPrintJobStateChanged(printJobId);
                    } catch (RemoteException re) {
                        Log.e(LOG_TAG, "Error notifying for print job state change", re);
                    }
                }
            }
        }
    }
}
