package android.location;

import android.content.Context;
import android.location.GpsNavigationMessageEvent.Listener;
import android.location.IGpsNavigationMessageListener.Stub;
import android.os.RemoteException;

class GpsNavigationMessageListenerTransport extends LocalListenerHelper<Listener> {
    private final IGpsNavigationMessageListener mListenerTransport;
    private final ILocationManager mLocationManager;

    private class ListenerTransport extends Stub {

        /* renamed from: android.location.GpsNavigationMessageListenerTransport.ListenerTransport.1 */
        class C03441 implements ListenerOperation<Listener> {
            final /* synthetic */ GpsNavigationMessageEvent val$event;

            C03441(GpsNavigationMessageEvent gpsNavigationMessageEvent) {
                this.val$event = gpsNavigationMessageEvent;
            }

            public void execute(Listener listener) throws RemoteException {
                listener.onGpsNavigationMessageReceived(this.val$event);
            }
        }

        /* renamed from: android.location.GpsNavigationMessageListenerTransport.ListenerTransport.2 */
        class C03452 implements ListenerOperation<Listener> {
            final /* synthetic */ int val$status;

            C03452(int i) {
                this.val$status = i;
            }

            public void execute(Listener listener) throws RemoteException {
                listener.onStatusChanged(this.val$status);
            }
        }

        private ListenerTransport() {
        }

        public void onGpsNavigationMessageReceived(GpsNavigationMessageEvent event) {
            GpsNavigationMessageListenerTransport.this.foreach(new C03441(event));
        }

        public void onStatusChanged(int status) {
            GpsNavigationMessageListenerTransport.this.foreach(new C03452(status));
        }
    }

    public GpsNavigationMessageListenerTransport(Context context, ILocationManager locationManager) {
        super(context, "GpsNavigationMessageListenerTransport");
        this.mListenerTransport = new ListenerTransport();
        this.mLocationManager = locationManager;
    }

    protected boolean registerWithServer() throws RemoteException {
        return this.mLocationManager.addGpsNavigationMessageListener(this.mListenerTransport, getContext().getPackageName());
    }

    protected void unregisterFromServer() throws RemoteException {
        this.mLocationManager.removeGpsNavigationMessageListener(this.mListenerTransport);
    }
}
