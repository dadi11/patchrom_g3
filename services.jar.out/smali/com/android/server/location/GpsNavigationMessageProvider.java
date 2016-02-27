package com.android.server.location;

import android.location.GpsNavigationMessageEvent;
import android.location.IGpsNavigationMessageListener;
import android.os.Handler;
import android.os.RemoteException;
import android.util.Log;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;

public abstract class GpsNavigationMessageProvider extends RemoteListenerHelper<IGpsNavigationMessageListener> {
    private static final String TAG = "GpsNavigationMessageProvider";

    /* renamed from: com.android.server.location.GpsNavigationMessageProvider.1 */
    class C03611 implements ListenerOperation<IGpsNavigationMessageListener> {
        final /* synthetic */ GpsNavigationMessageEvent val$event;

        C03611(GpsNavigationMessageEvent gpsNavigationMessageEvent) {
            this.val$event = gpsNavigationMessageEvent;
        }

        public void execute(IGpsNavigationMessageListener listener) throws RemoteException {
            listener.onGpsNavigationMessageReceived(this.val$event);
        }
    }

    private class StatusChangedOperation implements ListenerOperation<IGpsNavigationMessageListener> {
        private final int mStatus;

        public StatusChangedOperation(int status) {
            this.mStatus = status;
        }

        public void execute(IGpsNavigationMessageListener listener) throws RemoteException {
            listener.onStatusChanged(this.mStatus);
        }
    }

    public /* bridge */ /* synthetic */ void onGpsEnabledChanged(boolean z) {
        super.onGpsEnabledChanged(z);
    }

    public GpsNavigationMessageProvider(Handler handler) {
        super(handler, TAG);
    }

    public void onNavigationMessageAvailable(GpsNavigationMessageEvent event) {
        foreach(new C03611(event));
    }

    public void onCapabilitiesUpdated(boolean isGpsNavigationMessageSupported) {
        setSupported(isGpsNavigationMessageSupported, new StatusChangedOperation(isGpsNavigationMessageSupported ? GpsNavigationMessageEvent.STATUS_READY : GpsNavigationMessageEvent.STATUS_NOT_SUPPORTED));
    }

    protected ListenerOperation<IGpsNavigationMessageListener> getHandlerOperation(int result) {
        int status;
        switch (result) {
            case AppTransition.TRANSIT_NONE /*0*/:
                status = GpsNavigationMessageEvent.STATUS_READY;
                break;
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
            case C0569H.DO_TRAVERSAL /*4*/:
                status = GpsNavigationMessageEvent.STATUS_NOT_SUPPORTED;
                break;
            case C0569H.REPORT_LOSING_FOCUS /*3*/:
                status = GpsNavigationMessageEvent.STATUS_GPS_LOCATION_DISABLED;
                break;
            default:
                Log.v(TAG, "Unhandled addListener result: " + result);
                return null;
        }
        return new StatusChangedOperation(status);
    }

    protected void handleGpsEnabledChanged(boolean enabled) {
        foreach(new StatusChangedOperation(enabled ? GpsNavigationMessageEvent.STATUS_READY : GpsNavigationMessageEvent.STATUS_GPS_LOCATION_DISABLED));
    }
}
