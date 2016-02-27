package android.location;

import android.content.Context;
import android.location.GpsMeasurementsEvent.Listener;
import android.location.IGpsMeasurementsListener.Stub;
import android.os.RemoteException;

class GpsMeasurementListenerTransport extends LocalListenerHelper<Listener> {
    private final IGpsMeasurementsListener mListenerTransport;
    private final ILocationManager mLocationManager;

    private class ListenerTransport extends Stub {

        /* renamed from: android.location.GpsMeasurementListenerTransport.ListenerTransport.1 */
        class C03381 implements ListenerOperation<Listener> {
            final /* synthetic */ GpsMeasurementsEvent val$event;

            C03381(GpsMeasurementsEvent gpsMeasurementsEvent) {
                this.val$event = gpsMeasurementsEvent;
            }

            public void execute(Listener listener) throws RemoteException {
                listener.onGpsMeasurementsReceived(this.val$event);
            }
        }

        /* renamed from: android.location.GpsMeasurementListenerTransport.ListenerTransport.2 */
        class C03392 implements ListenerOperation<Listener> {
            final /* synthetic */ int val$status;

            C03392(int i) {
                this.val$status = i;
            }

            public void execute(Listener listener) throws RemoteException {
                listener.onStatusChanged(this.val$status);
            }
        }

        private ListenerTransport() {
        }

        public void onGpsMeasurementsReceived(GpsMeasurementsEvent event) {
            GpsMeasurementListenerTransport.this.foreach(new C03381(event));
        }

        public void onStatusChanged(int status) {
            GpsMeasurementListenerTransport.this.foreach(new C03392(status));
        }
    }

    public GpsMeasurementListenerTransport(Context context, ILocationManager locationManager) {
        super(context, "GpsMeasurementListenerTransport");
        this.mListenerTransport = new ListenerTransport();
        this.mLocationManager = locationManager;
    }

    protected boolean registerWithServer() throws RemoteException {
        return this.mLocationManager.addGpsMeasurementsListener(this.mListenerTransport, getContext().getPackageName());
    }

    protected void unregisterFromServer() throws RemoteException {
        this.mLocationManager.removeGpsMeasurementsListener(this.mListenerTransport);
    }
}
