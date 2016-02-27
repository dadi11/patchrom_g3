package com.android.server.location;

import android.location.IGpsStatusListener;
import android.os.Handler;
import android.os.RemoteException;

abstract class GpsStatusListenerHelper extends RemoteListenerHelper<IGpsStatusListener> {

    private abstract class Operation implements ListenerOperation<IGpsStatusListener> {
        private Operation() {
        }
    }

    /* renamed from: com.android.server.location.GpsStatusListenerHelper.1 */
    class C03621 extends Operation {
        C03621() {
            super(null);
        }

        public void execute(IGpsStatusListener iGpsStatusListener) throws RemoteException {
        }
    }

    /* renamed from: com.android.server.location.GpsStatusListenerHelper.2 */
    class C03632 extends Operation {
        C03632() {
            super(null);
        }

        public void execute(IGpsStatusListener listener) throws RemoteException {
            listener.onGpsStarted();
        }
    }

    /* renamed from: com.android.server.location.GpsStatusListenerHelper.3 */
    class C03643 extends Operation {
        C03643() {
            super(null);
        }

        public void execute(IGpsStatusListener listener) throws RemoteException {
            listener.onGpsStopped();
        }
    }

    /* renamed from: com.android.server.location.GpsStatusListenerHelper.4 */
    class C03654 extends Operation {
        final /* synthetic */ int val$timeToFirstFix;

        C03654(int i) {
            this.val$timeToFirstFix = i;
            super(null);
        }

        public void execute(IGpsStatusListener listener) throws RemoteException {
            listener.onFirstFix(this.val$timeToFirstFix);
        }
    }

    /* renamed from: com.android.server.location.GpsStatusListenerHelper.5 */
    class C03665 extends Operation {
        final /* synthetic */ int val$almanacMask;
        final /* synthetic */ float[] val$azimuths;
        final /* synthetic */ float[] val$elevations;
        final /* synthetic */ int val$ephemerisMask;
        final /* synthetic */ int[] val$prns;
        final /* synthetic */ float[] val$snrs;
        final /* synthetic */ int val$svCount;
        final /* synthetic */ int val$usedInFixMask;

        C03665(int i, int[] iArr, float[] fArr, float[] fArr2, float[] fArr3, int i2, int i3, int i4) {
            this.val$svCount = i;
            this.val$prns = iArr;
            this.val$snrs = fArr;
            this.val$elevations = fArr2;
            this.val$azimuths = fArr3;
            this.val$ephemerisMask = i2;
            this.val$almanacMask = i3;
            this.val$usedInFixMask = i4;
            super(null);
        }

        public void execute(IGpsStatusListener listener) throws RemoteException {
            listener.onSvStatusChanged(this.val$svCount, this.val$prns, this.val$snrs, this.val$elevations, this.val$azimuths, this.val$ephemerisMask, this.val$almanacMask, this.val$usedInFixMask);
        }
    }

    /* renamed from: com.android.server.location.GpsStatusListenerHelper.6 */
    class C03676 extends Operation {
        final /* synthetic */ String val$nmea;
        final /* synthetic */ long val$timestamp;

        C03676(long j, String str) {
            this.val$timestamp = j;
            this.val$nmea = str;
            super(null);
        }

        public void execute(IGpsStatusListener listener) throws RemoteException {
            listener.onNmeaReceived(this.val$timestamp, this.val$nmea);
        }
    }

    public GpsStatusListenerHelper(Handler handler) {
        super(handler, "GpsStatusListenerHelper");
        setSupported(GpsLocationProvider.isSupported(), new C03621());
    }

    protected boolean registerWithService() {
        return true;
    }

    protected void unregisterFromService() {
    }

    protected ListenerOperation<IGpsStatusListener> getHandlerOperation(int result) {
        return null;
    }

    protected void handleGpsEnabledChanged(boolean enabled) {
        Operation operation;
        if (enabled) {
            operation = new C03632();
        } else {
            operation = new C03643();
        }
        foreach(operation);
    }

    public void onFirstFix(int timeToFirstFix) {
        foreach(new C03654(timeToFirstFix));
    }

    public void onSvStatusChanged(int svCount, int[] prns, float[] snrs, float[] elevations, float[] azimuths, int ephemerisMask, int almanacMask, int usedInFixMask) {
        foreach(new C03665(svCount, prns, snrs, elevations, azimuths, ephemerisMask, almanacMask, usedInFixMask));
    }

    public void onNmeaReceived(long timestamp, String nmea) {
        foreach(new C03676(timestamp, nmea));
    }
}
