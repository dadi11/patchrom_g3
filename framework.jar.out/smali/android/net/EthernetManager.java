package android.net;

import android.content.Context;
import android.net.IEthernetServiceListener.Stub;
import android.os.Handler;
import android.os.Message;
import android.os.RemoteException;
import java.util.ArrayList;
import java.util.Iterator;

public class EthernetManager {
    private static final int MSG_AVAILABILITY_CHANGED = 1000;
    private static final String TAG = "EthernetManager";
    private final Context mContext;
    private final Handler mHandler;
    private final ArrayList<Listener> mListeners;
    private final IEthernetManager mService;
    private final Stub mServiceListener;

    /* renamed from: android.net.EthernetManager.1 */
    class C04781 extends Handler {
        C04781() {
        }

        public void handleMessage(Message msg) {
            boolean isAvailable = true;
            if (msg.what == EthernetManager.MSG_AVAILABILITY_CHANGED) {
                if (msg.arg1 != 1) {
                    isAvailable = false;
                }
                Iterator i$ = EthernetManager.this.mListeners.iterator();
                while (i$.hasNext()) {
                    ((Listener) i$.next()).onAvailabilityChanged(isAvailable);
                }
            }
        }
    }

    /* renamed from: android.net.EthernetManager.2 */
    class C04792 extends Stub {
        C04792() {
        }

        public void onAvailabilityChanged(boolean isAvailable) {
            int i;
            Handler access$100 = EthernetManager.this.mHandler;
            if (isAvailable) {
                i = 1;
            } else {
                i = 0;
            }
            access$100.obtainMessage(EthernetManager.MSG_AVAILABILITY_CHANGED, i, 0, null).sendToTarget();
        }
    }

    public interface Listener {
        void onAvailabilityChanged(boolean z);
    }

    public EthernetManager(Context context, IEthernetManager service) {
        this.mHandler = new C04781();
        this.mListeners = new ArrayList();
        this.mServiceListener = new C04792();
        this.mContext = context;
        this.mService = service;
    }

    public IpConfiguration getConfiguration() {
        try {
            return this.mService.getConfiguration();
        } catch (NullPointerException e) {
            return new IpConfiguration();
        } catch (RemoteException e2) {
            return new IpConfiguration();
        }
    }

    public void setConfiguration(IpConfiguration config) {
        try {
            this.mService.setConfiguration(config);
        } catch (NullPointerException e) {
        } catch (RemoteException e2) {
        }
    }

    public boolean isAvailable() {
        try {
            return this.mService.isAvailable();
        } catch (NullPointerException e) {
            return false;
        } catch (RemoteException e2) {
            return false;
        }
    }

    public void addListener(Listener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }
        this.mListeners.add(listener);
        if (this.mListeners.size() == 1) {
            try {
                this.mService.addListener(this.mServiceListener);
            } catch (NullPointerException e) {
            } catch (RemoteException e2) {
            }
        }
    }

    public void removeListener(Listener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }
        this.mListeners.remove(listener);
        if (this.mListeners.isEmpty()) {
            try {
                this.mService.removeListener(this.mServiceListener);
            } catch (NullPointerException e) {
            } catch (RemoteException e2) {
            }
        }
    }
}
