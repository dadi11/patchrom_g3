package android.location;

import android.location.ICountryListener.Stub;
import android.os.Handler;
import android.os.Looper;
import android.os.RemoteException;
import android.util.Log;
import java.util.HashMap;

public class CountryDetector {
    private static final String TAG = "CountryDetector";
    private final HashMap<CountryListener, ListenerTransport> mListeners;
    private final ICountryDetector mService;

    private static final class ListenerTransport extends Stub {
        private final Handler mHandler;
        private final CountryListener mListener;

        /* renamed from: android.location.CountryDetector.ListenerTransport.1 */
        class C03291 implements Runnable {
            final /* synthetic */ Country val$country;

            C03291(Country country) {
                this.val$country = country;
            }

            public void run() {
                ListenerTransport.this.mListener.onCountryDetected(this.val$country);
            }
        }

        public ListenerTransport(CountryListener listener, Looper looper) {
            this.mListener = listener;
            if (looper != null) {
                this.mHandler = new Handler(looper);
            } else {
                this.mHandler = new Handler();
            }
        }

        public void onCountryDetected(Country country) {
            this.mHandler.post(new C03291(country));
        }
    }

    public CountryDetector(ICountryDetector service) {
        this.mService = service;
        this.mListeners = new HashMap();
    }

    public Country detectCountry() {
        try {
            return this.mService.detectCountry();
        } catch (RemoteException e) {
            Log.e(TAG, "detectCountry: RemoteException", e);
            return null;
        }
    }

    public void addCountryListener(CountryListener listener, Looper looper) {
        synchronized (this.mListeners) {
            if (!this.mListeners.containsKey(listener)) {
                ListenerTransport transport = new ListenerTransport(listener, looper);
                try {
                    this.mService.addCountryListener(transport);
                    this.mListeners.put(listener, transport);
                } catch (RemoteException e) {
                    Log.e(TAG, "addCountryListener: RemoteException", e);
                }
            }
        }
    }

    public void removeCountryListener(CountryListener listener) {
        synchronized (this.mListeners) {
            ListenerTransport transport = (ListenerTransport) this.mListeners.get(listener);
            if (transport != null) {
                try {
                    this.mListeners.remove(listener);
                    this.mService.removeCountryListener(transport);
                } catch (RemoteException e) {
                    Log.e(TAG, "removeCountryListener: RemoteException", e);
                }
            }
        }
    }
}
