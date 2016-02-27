package android.printservice;

import android.print.PrintDocumentInfo;
import android.print.PrintJobId;

public final class PrintDocument {
    private static final String LOG_TAG = "PrintDocument";
    private final PrintDocumentInfo mInfo;
    private final PrintJobId mPrintJobId;
    private final IPrintServiceClient mPrintServiceClient;

    PrintDocument(PrintJobId printJobId, IPrintServiceClient printServiceClient, PrintDocumentInfo info) {
        this.mPrintJobId = printJobId;
        this.mPrintServiceClient = printServiceClient;
        this.mInfo = info;
    }

    public PrintDocumentInfo getInfo() {
        PrintService.throwIfNotCalledOnMainThread();
        return this.mInfo;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public android.os.ParcelFileDescriptor getData() {
        /*
        r7 = this;
        android.printservice.PrintService.throwIfNotCalledOnMainThread();
        r4 = 0;
        r3 = 0;
        r0 = android.os.ParcelFileDescriptor.createPipe();	 Catch:{ IOException -> 0x001d, RemoteException -> 0x002c }
        r5 = 0;
        r4 = r0[r5];	 Catch:{ IOException -> 0x001d, RemoteException -> 0x002c }
        r5 = 1;
        r3 = r0[r5];	 Catch:{ IOException -> 0x001d, RemoteException -> 0x002c }
        r5 = r7.mPrintServiceClient;	 Catch:{ IOException -> 0x001d, RemoteException -> 0x002c }
        r6 = r7.mPrintJobId;	 Catch:{ IOException -> 0x001d, RemoteException -> 0x002c }
        r5.writePrintJobData(r3, r6);	 Catch:{ IOException -> 0x001d, RemoteException -> 0x002c }
        if (r3 == 0) goto L_0x001b;
    L_0x0018:
        r3.close();	 Catch:{ IOException -> 0x0043 }
    L_0x001b:
        r5 = r4;
    L_0x001c:
        return r5;
    L_0x001d:
        r1 = move-exception;
        r5 = "PrintDocument";
        r6 = "Error calling getting print job data!";
        android.util.Log.e(r5, r6, r1);	 Catch:{ all -> 0x003c }
        if (r3 == 0) goto L_0x002a;
    L_0x0027:
        r3.close();	 Catch:{ IOException -> 0x0045 }
    L_0x002a:
        r5 = 0;
        goto L_0x001c;
    L_0x002c:
        r2 = move-exception;
        r5 = "PrintDocument";
        r6 = "Error calling getting print job data!";
        android.util.Log.e(r5, r6, r2);	 Catch:{ all -> 0x003c }
        if (r3 == 0) goto L_0x002a;
    L_0x0036:
        r3.close();	 Catch:{ IOException -> 0x003a }
        goto L_0x002a;
    L_0x003a:
        r5 = move-exception;
        goto L_0x002a;
    L_0x003c:
        r5 = move-exception;
        if (r3 == 0) goto L_0x0042;
    L_0x003f:
        r3.close();	 Catch:{ IOException -> 0x0047 }
    L_0x0042:
        throw r5;
    L_0x0043:
        r5 = move-exception;
        goto L_0x001b;
    L_0x0045:
        r5 = move-exception;
        goto L_0x002a;
    L_0x0047:
        r6 = move-exception;
        goto L_0x0042;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.printservice.PrintDocument.getData():android.os.ParcelFileDescriptor");
    }
}
