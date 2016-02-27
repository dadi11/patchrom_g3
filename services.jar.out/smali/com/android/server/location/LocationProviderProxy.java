package com.android.server.location;

import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.RemoteException;
import android.os.WorkSource;
import android.util.Log;
import com.android.internal.location.ILocationProvider;
import com.android.internal.location.ILocationProvider.Stub;
import com.android.internal.location.ProviderProperties;
import com.android.internal.location.ProviderRequest;
import com.android.server.LocationManagerService;
import com.android.server.ServiceWatcher;
import java.io.FileDescriptor;
import java.io.PrintWriter;

public class LocationProviderProxy implements LocationProviderInterface {
    private static final boolean f9D;
    private static final String TAG = "LocationProviderProxy";
    private final Context mContext;
    private boolean mEnabled;
    private Object mLock;
    private final String mName;
    private Runnable mNewServiceWork;
    private ProviderProperties mProperties;
    private ProviderRequest mRequest;
    private final ServiceWatcher mServiceWatcher;
    private WorkSource mWorksource;

    /* renamed from: com.android.server.location.LocationProviderProxy.1 */
    class C03721 implements Runnable {
        C03721() {
        }

        public void run() {
            if (LocationProviderProxy.f9D) {
                Log.d(LocationProviderProxy.TAG, "applying state to connected service");
            }
            ProviderProperties properties = null;
            synchronized (LocationProviderProxy.this.mLock) {
                boolean enabled = LocationProviderProxy.this.mEnabled;
                ProviderRequest request = LocationProviderProxy.this.mRequest;
                WorkSource source = LocationProviderProxy.this.mWorksource;
                ILocationProvider service = LocationProviderProxy.this.getService();
            }
            if (service != null) {
                try {
                    properties = service.getProperties();
                    if (properties == null) {
                        Log.e(LocationProviderProxy.TAG, LocationProviderProxy.this.mServiceWatcher.getBestPackageName() + " has invalid locatino provider properties");
                    }
                    if (enabled) {
                        service.enable();
                        if (request != null) {
                            service.setRequest(request, source);
                        }
                    }
                } catch (RemoteException e) {
                    Log.w(LocationProviderProxy.TAG, e);
                } catch (Exception e2) {
                    Log.e(LocationProviderProxy.TAG, "Exception from " + LocationProviderProxy.this.mServiceWatcher.getBestPackageName(), e2);
                }
                synchronized (LocationProviderProxy.this.mLock) {
                    LocationProviderProxy.this.mProperties = properties;
                }
            }
        }
    }

    static {
        f9D = LocationManagerService.f0D;
    }

    public static LocationProviderProxy createAndBind(Context context, String name, String action, int overlaySwitchResId, int defaultServicePackageNameResId, int initialPackageNamesResId, Handler handler) {
        LocationProviderProxy proxy = new LocationProviderProxy(context, name, action, overlaySwitchResId, defaultServicePackageNameResId, initialPackageNamesResId, handler);
        return proxy.bind() ? proxy : null;
    }

    private LocationProviderProxy(Context context, String name, String action, int overlaySwitchResId, int defaultServicePackageNameResId, int initialPackageNamesResId, Handler handler) {
        this.mLock = new Object();
        this.mEnabled = f9D;
        this.mRequest = null;
        this.mWorksource = new WorkSource();
        this.mNewServiceWork = new C03721();
        this.mContext = context;
        this.mName = name;
        this.mServiceWatcher = new ServiceWatcher(this.mContext, "LocationProviderProxy-" + name, action, overlaySwitchResId, defaultServicePackageNameResId, initialPackageNamesResId, this.mNewServiceWork, handler);
    }

    private boolean bind() {
        return this.mServiceWatcher.start();
    }

    private ILocationProvider getService() {
        return Stub.asInterface(this.mServiceWatcher.getBinder());
    }

    public String getConnectedPackageName() {
        return this.mServiceWatcher.getBestPackageName();
    }

    public String getName() {
        return this.mName;
    }

    public ProviderProperties getProperties() {
        ProviderProperties providerProperties;
        synchronized (this.mLock) {
            providerProperties = this.mProperties;
        }
        return providerProperties;
    }

    public void enable() {
        synchronized (this.mLock) {
            this.mEnabled = true;
        }
        ILocationProvider service = getService();
        if (service != null) {
            try {
                service.enable();
            } catch (RemoteException e) {
                Log.w(TAG, e);
            } catch (Exception e2) {
                Log.e(TAG, "Exception from " + this.mServiceWatcher.getBestPackageName(), e2);
            }
        }
    }

    public void disable() {
        synchronized (this.mLock) {
            this.mEnabled = f9D;
        }
        ILocationProvider service = getService();
        if (service != null) {
            try {
                service.disable();
            } catch (RemoteException e) {
                Log.w(TAG, e);
            } catch (Exception e2) {
                Log.e(TAG, "Exception from " + this.mServiceWatcher.getBestPackageName(), e2);
            }
        }
    }

    public boolean isEnabled() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mEnabled;
        }
        return z;
    }

    public void setRequest(ProviderRequest request, WorkSource source) {
        synchronized (this.mLock) {
            this.mRequest = request;
            this.mWorksource = source;
        }
        ILocationProvider service = getService();
        if (service != null) {
            try {
                service.setRequest(request, source);
            } catch (RemoteException e) {
                Log.w(TAG, e);
            } catch (Exception e2) {
                Log.e(TAG, "Exception from " + this.mServiceWatcher.getBestPackageName(), e2);
            }
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.append("REMOTE SERVICE");
        pw.append(" name=").append(this.mName);
        pw.append(" pkg=").append(this.mServiceWatcher.getBestPackageName());
        pw.append(" version=").append("" + this.mServiceWatcher.getBestVersion());
        pw.append('\n');
        ILocationProvider service = getService();
        if (service == null) {
            pw.println("service down (null)");
            return;
        }
        pw.flush();
        try {
            service.asBinder().dump(fd, args);
        } catch (RemoteException e) {
            pw.println("service down (RemoteException)");
            Log.w(TAG, e);
        } catch (Exception e2) {
            pw.println("service down (Exception)");
            Log.e(TAG, "Exception from " + this.mServiceWatcher.getBestPackageName(), e2);
        }
    }

    public int getStatus(Bundle extras) {
        int i = 1;
        ILocationProvider service = getService();
        if (service != null) {
            try {
                i = service.getStatus(extras);
            } catch (RemoteException e) {
                Log.w(TAG, e);
            } catch (Exception e2) {
                Log.e(TAG, "Exception from " + this.mServiceWatcher.getBestPackageName(), e2);
            }
        }
        return i;
    }

    public long getStatusUpdateTime() {
        long j = 0;
        ILocationProvider service = getService();
        if (service != null) {
            try {
                j = service.getStatusUpdateTime();
            } catch (RemoteException e) {
                Log.w(TAG, e);
            } catch (Exception e2) {
                Log.e(TAG, "Exception from " + this.mServiceWatcher.getBestPackageName(), e2);
            }
        }
        return j;
    }

    public boolean sendExtraCommand(String command, Bundle extras) {
        boolean z = f9D;
        ILocationProvider service = getService();
        if (service != null) {
            try {
                z = service.sendExtraCommand(command, extras);
            } catch (RemoteException e) {
                Log.w(TAG, e);
            } catch (Exception e2) {
                Log.e(TAG, "Exception from " + this.mServiceWatcher.getBestPackageName(), e2);
            }
        }
        return z;
    }
}
