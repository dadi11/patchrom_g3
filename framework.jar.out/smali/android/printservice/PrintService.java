package android.printservice;

import android.app.Service;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.print.PrintJobInfo;
import android.print.PrinterId;
import android.printservice.IPrintService.Stub;
import android.util.Log;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public abstract class PrintService extends Service {
    private static final boolean DEBUG = false;
    public static final String EXTRA_PRINTER_INFO = "android.intent.extra.print.EXTRA_PRINTER_INFO";
    public static final String EXTRA_PRINT_JOB_INFO = "android.intent.extra.print.PRINT_JOB_INFO";
    private static final String LOG_TAG = "PrintService";
    public static final String SERVICE_INTERFACE = "android.printservice.PrintService";
    public static final String SERVICE_META_DATA = "android.printservice";
    private IPrintServiceClient mClient;
    private PrinterDiscoverySession mDiscoverySession;
    private Handler mHandler;
    private int mLastSessionId;

    /* renamed from: android.printservice.PrintService.1 */
    class C06531 extends Stub {
        C06531() {
        }

        public void createPrinterDiscoverySession() {
            PrintService.this.mHandler.sendEmptyMessage(1);
        }

        public void destroyPrinterDiscoverySession() {
            PrintService.this.mHandler.sendEmptyMessage(2);
        }

        public void startPrinterDiscovery(List<PrinterId> priorityList) {
            PrintService.this.mHandler.obtainMessage(3, priorityList).sendToTarget();
        }

        public void stopPrinterDiscovery() {
            PrintService.this.mHandler.sendEmptyMessage(4);
        }

        public void validatePrinters(List<PrinterId> printerIds) {
            PrintService.this.mHandler.obtainMessage(5, printerIds).sendToTarget();
        }

        public void startPrinterStateTracking(PrinterId printerId) {
            PrintService.this.mHandler.obtainMessage(6, printerId).sendToTarget();
        }

        public void stopPrinterStateTracking(PrinterId printerId) {
            PrintService.this.mHandler.obtainMessage(7, printerId).sendToTarget();
        }

        public void setClient(IPrintServiceClient client) {
            PrintService.this.mHandler.obtainMessage(10, client).sendToTarget();
        }

        public void requestCancelPrintJob(PrintJobInfo printJobInfo) {
            PrintService.this.mHandler.obtainMessage(9, printJobInfo).sendToTarget();
        }

        public void onPrintJobQueued(PrintJobInfo printJobInfo) {
            PrintService.this.mHandler.obtainMessage(8, printJobInfo).sendToTarget();
        }
    }

    private final class ServiceHandler extends Handler {
        public static final int MSG_CREATE_PRINTER_DISCOVERY_SESSION = 1;
        public static final int MSG_DESTROY_PRINTER_DISCOVERY_SESSION = 2;
        public static final int MSG_ON_PRINTJOB_QUEUED = 8;
        public static final int MSG_ON_REQUEST_CANCEL_PRINTJOB = 9;
        public static final int MSG_SET_CLEINT = 10;
        public static final int MSG_START_PRINTER_DISCOVERY = 3;
        public static final int MSG_START_PRINTER_STATE_TRACKING = 6;
        public static final int MSG_STOP_PRINTER_DISCOVERY = 4;
        public static final int MSG_STOP_PRINTER_STATE_TRACKING = 7;
        public static final int MSG_VALIDATE_PRINTERS = 5;

        public ServiceHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message message) {
            int action = message.what;
            switch (action) {
                case MSG_CREATE_PRINTER_DISCOVERY_SESSION /*1*/:
                    PrinterDiscoverySession session = PrintService.this.onCreatePrinterDiscoverySession();
                    if (session == null) {
                        throw new NullPointerException("session cannot be null");
                    } else if (session.getId() == PrintService.this.mLastSessionId) {
                        throw new IllegalStateException("cannot reuse session instances");
                    } else {
                        PrintService.this.mDiscoverySession = session;
                        PrintService.this.mLastSessionId = session.getId();
                        session.setObserver(PrintService.this.mClient);
                    }
                case MSG_DESTROY_PRINTER_DISCOVERY_SESSION /*2*/:
                    if (PrintService.this.mDiscoverySession != null) {
                        PrintService.this.mDiscoverySession.destroy();
                        PrintService.this.mDiscoverySession = null;
                    }
                case MSG_START_PRINTER_DISCOVERY /*3*/:
                    if (PrintService.this.mDiscoverySession != null) {
                        PrintService.this.mDiscoverySession.startPrinterDiscovery((ArrayList) message.obj);
                    }
                case MSG_STOP_PRINTER_DISCOVERY /*4*/:
                    if (PrintService.this.mDiscoverySession != null) {
                        PrintService.this.mDiscoverySession.stopPrinterDiscovery();
                    }
                case MSG_VALIDATE_PRINTERS /*5*/:
                    if (PrintService.this.mDiscoverySession != null) {
                        PrintService.this.mDiscoverySession.validatePrinters(message.obj);
                    }
                case MSG_START_PRINTER_STATE_TRACKING /*6*/:
                    if (PrintService.this.mDiscoverySession != null) {
                        PrintService.this.mDiscoverySession.startPrinterStateTracking(message.obj);
                    }
                case MSG_STOP_PRINTER_STATE_TRACKING /*7*/:
                    if (PrintService.this.mDiscoverySession != null) {
                        PrintService.this.mDiscoverySession.stopPrinterStateTracking((PrinterId) message.obj);
                    }
                case MSG_ON_PRINTJOB_QUEUED /*8*/:
                    PrintService.this.onPrintJobQueued(new PrintJob((PrintJobInfo) message.obj, PrintService.this.mClient));
                case MSG_ON_REQUEST_CANCEL_PRINTJOB /*9*/:
                    PrintService.this.onRequestCancelPrintJob(new PrintJob(message.obj, PrintService.this.mClient));
                case MSG_SET_CLEINT /*10*/:
                    PrintService.this.mClient = (IPrintServiceClient) message.obj;
                    if (PrintService.this.mClient != null) {
                        PrintService.this.onConnected();
                    } else {
                        PrintService.this.onDisconnected();
                    }
                default:
                    throw new IllegalArgumentException("Unknown message: " + action);
            }
        }
    }

    protected abstract PrinterDiscoverySession onCreatePrinterDiscoverySession();

    protected abstract void onPrintJobQueued(PrintJob printJob);

    protected abstract void onRequestCancelPrintJob(PrintJob printJob);

    public PrintService() {
        this.mLastSessionId = -1;
    }

    protected final void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        this.mHandler = new ServiceHandler(base.getMainLooper());
    }

    protected void onConnected() {
    }

    protected void onDisconnected() {
    }

    public final List<PrintJob> getActivePrintJobs() {
        RemoteException re;
        throwIfNotCalledOnMainThread();
        if (this.mClient == null) {
            return Collections.emptyList();
        }
        List<PrintJob> printJobs = null;
        try {
            List<PrintJobInfo> printJobInfos = this.mClient.getPrintJobInfos();
            if (printJobInfos != null) {
                int printJobInfoCount = printJobInfos.size();
                List<PrintJob> printJobs2 = new ArrayList(printJobInfoCount);
                int i = 0;
                while (i < printJobInfoCount) {
                    try {
                        printJobs2.add(new PrintJob((PrintJobInfo) printJobInfos.get(i), this.mClient));
                        i++;
                    } catch (RemoteException e) {
                        re = e;
                        printJobs = printJobs2;
                    }
                }
                printJobs = printJobs2;
            }
            if (printJobs != null) {
                return printJobs;
            }
        } catch (RemoteException e2) {
            re = e2;
            Log.e(LOG_TAG, "Error calling getPrintJobs()", re);
            return Collections.emptyList();
        }
        return Collections.emptyList();
    }

    public final PrinterId generatePrinterId(String localId) {
        throwIfNotCalledOnMainThread();
        return new PrinterId(new ComponentName(getPackageName(), getClass().getName()), localId);
    }

    static void throwIfNotCalledOnMainThread() {
        if (!Looper.getMainLooper().isCurrentThread()) {
            throw new IllegalAccessError("must be called from the main thread");
        }
    }

    public final IBinder onBind(Intent intent) {
        return new C06531();
    }
}
