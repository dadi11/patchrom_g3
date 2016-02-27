package com.android.server;

import android.content.Context;
import android.location.Country;
import android.location.CountryListener;
import android.location.ICountryDetector.Stub;
import android.location.ICountryListener;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.RemoteException;
import android.util.Slog;
import com.android.internal.os.BackgroundThread;
import com.android.server.location.ComprehensiveCountryDetector;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.HashMap;

public class CountryDetectorService extends Stub implements Runnable {
    private static final boolean DEBUG = false;
    private static final String TAG = "CountryDetector";
    private final Context mContext;
    private ComprehensiveCountryDetector mCountryDetector;
    private Handler mHandler;
    private CountryListener mLocationBasedDetectorListener;
    private final HashMap<IBinder, Receiver> mReceivers;
    private boolean mSystemReady;

    /* renamed from: com.android.server.CountryDetectorService.1 */
    class C00311 implements CountryListener {

        /* renamed from: com.android.server.CountryDetectorService.1.1 */
        class C00301 implements Runnable {
            final /* synthetic */ Country val$country;

            C00301(Country country) {
                this.val$country = country;
            }

            public void run() {
                CountryDetectorService.this.notifyReceivers(this.val$country);
            }
        }

        C00311() {
        }

        public void onCountryDetected(Country country) {
            CountryDetectorService.this.mHandler.post(new C00301(country));
        }
    }

    /* renamed from: com.android.server.CountryDetectorService.2 */
    class C00322 implements Runnable {
        final /* synthetic */ CountryListener val$listener;

        C00322(CountryListener countryListener) {
            this.val$listener = countryListener;
        }

        public void run() {
            CountryDetectorService.this.mCountryDetector.setCountryListener(this.val$listener);
        }
    }

    private final class Receiver implements DeathRecipient {
        private final IBinder mKey;
        private final ICountryListener mListener;

        public Receiver(ICountryListener listener) {
            this.mListener = listener;
            this.mKey = listener.asBinder();
        }

        public void binderDied() {
            CountryDetectorService.this.removeListener(this.mKey);
        }

        public boolean equals(Object otherObj) {
            if (otherObj instanceof Receiver) {
                return this.mKey.equals(((Receiver) otherObj).mKey);
            }
            return CountryDetectorService.DEBUG;
        }

        public int hashCode() {
            return this.mKey.hashCode();
        }

        public ICountryListener getListener() {
            return this.mListener;
        }
    }

    public CountryDetectorService(Context context) {
        this.mReceivers = new HashMap();
        this.mContext = context;
    }

    public Country detectCountry() {
        if (this.mSystemReady) {
            return this.mCountryDetector.detectCountry();
        }
        return null;
    }

    public void addCountryListener(ICountryListener listener) throws RemoteException {
        if (this.mSystemReady) {
            addListener(listener);
            return;
        }
        throw new RemoteException();
    }

    public void removeCountryListener(ICountryListener listener) throws RemoteException {
        if (this.mSystemReady) {
            removeListener(listener.asBinder());
            return;
        }
        throw new RemoteException();
    }

    private void addListener(ICountryListener listener) {
        synchronized (this.mReceivers) {
            Receiver r = new Receiver(listener);
            try {
                listener.asBinder().linkToDeath(r, 0);
                this.mReceivers.put(listener.asBinder(), r);
                if (this.mReceivers.size() == 1) {
                    Slog.d(TAG, "The first listener is added");
                    setCountryListener(this.mLocationBasedDetectorListener);
                }
            } catch (RemoteException e) {
                Slog.e(TAG, "linkToDeath failed:", e);
            }
        }
    }

    private void removeListener(IBinder key) {
        synchronized (this.mReceivers) {
            this.mReceivers.remove(key);
            if (this.mReceivers.isEmpty()) {
                setCountryListener(null);
                Slog.d(TAG, "No listener is left");
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    protected void notifyReceivers(android.location.Country r7) {
        /*
        r6 = this;
        r4 = r6.mReceivers;
        monitor-enter(r4);
        r3 = r6.mReceivers;	 Catch:{ all -> 0x002a }
        r3 = r3.values();	 Catch:{ all -> 0x002a }
        r1 = r3.iterator();	 Catch:{ all -> 0x002a }
    L_0x000d:
        r3 = r1.hasNext();	 Catch:{ all -> 0x002a }
        if (r3 == 0) goto L_0x002d;
    L_0x0013:
        r2 = r1.next();	 Catch:{ all -> 0x002a }
        r2 = (com.android.server.CountryDetectorService.Receiver) r2;	 Catch:{ all -> 0x002a }
        r3 = r2.getListener();	 Catch:{ RemoteException -> 0x0021 }
        r3.onCountryDetected(r7);	 Catch:{ RemoteException -> 0x0021 }
        goto L_0x000d;
    L_0x0021:
        r0 = move-exception;
        r3 = "CountryDetector";
        r5 = "notifyReceivers failed:";
        android.util.Slog.e(r3, r5, r0);	 Catch:{ all -> 0x002a }
        goto L_0x000d;
    L_0x002a:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x002a }
        throw r3;
    L_0x002d:
        monitor-exit(r4);	 Catch:{ all -> 0x002a }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.CountryDetectorService.notifyReceivers(android.location.Country):void");
    }

    void systemRunning() {
        BackgroundThread.getHandler().post(this);
    }

    private void initialize() {
        this.mCountryDetector = new ComprehensiveCountryDetector(this.mContext);
        this.mLocationBasedDetectorListener = new C00311();
    }

    public void run() {
        this.mHandler = new Handler();
        initialize();
        this.mSystemReady = true;
    }

    protected void setCountryListener(CountryListener listener) {
        this.mHandler.post(new C00322(listener));
    }

    boolean isSystemReady() {
        return this.mSystemReady;
    }

    protected void dump(FileDescriptor fd, PrintWriter fout, String[] args) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DUMP", TAG);
    }
}
