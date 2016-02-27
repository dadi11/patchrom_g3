package com.android.server.location;

import android.location.GpsMeasurementsEvent;
import android.location.IGpsMeasurementsListener;
import android.os.Handler;
import android.os.RemoteException;
import android.util.Log;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;

public abstract class GpsMeasurementsProvider extends RemoteListenerHelper<IGpsMeasurementsListener> {
    private static final String TAG = "GpsMeasurementsProvider";

    /* renamed from: com.android.server.location.GpsMeasurementsProvider.1 */
    class C03601 implements ListenerOperation<IGpsMeasurementsListener> {
        final /* synthetic */ GpsMeasurementsEvent val$event;

        C03601(GpsMeasurementsEvent gpsMeasurementsEvent) {
            this.val$event = gpsMeasurementsEvent;
        }

        public void execute(IGpsMeasurementsListener listener) throws RemoteException {
            listener.onGpsMeasurementsReceived(this.val$event);
        }
    }

    private class StatusChangedOperation implements ListenerOperation<IGpsMeasurementsListener> {
        private final int mStatus;

        public StatusChangedOperation(int status) {
            this.mStatus = status;
        }

        public void execute(IGpsMeasurementsListener listener) throws RemoteException {
            listener.onStatusChanged(this.mStatus);
        }
    }

    public /* bridge */ /* synthetic */ void onGpsEnabledChanged(boolean z) {
        super.onGpsEnabledChanged(z);
    }

    public GpsMeasurementsProvider(Handler handler) {
        super(handler, TAG);
    }

    public void onMeasurementsAvailable(GpsMeasurementsEvent event) {
        foreach(new C03601(event));
    }

    public void onCapabilitiesUpdated(boolean isGpsMeasurementsSupported) {
        setSupported(isGpsMeasurementsSupported, new StatusChangedOperation(isGpsMeasurementsSupported ? 1 : 0));
    }

    protected ListenerOperation<IGpsMeasurementsListener> getHandlerOperation(int result) {
        int status;
        switch (result) {
            case AppTransition.TRANSIT_NONE /*0*/:
                status = 1;
                break;
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
            case C0569H.DO_TRAVERSAL /*4*/:
                status = 0;
                break;
            case C0569H.REPORT_LOSING_FOCUS /*3*/:
                status = 2;
                break;
            default:
                Log.v(TAG, "Unhandled addListener result: " + result);
                return null;
        }
        return new StatusChangedOperation(status);
    }

    protected void handleGpsEnabledChanged(boolean enabled) {
        foreach(new StatusChangedOperation(enabled ? 1 : 2));
    }
}
