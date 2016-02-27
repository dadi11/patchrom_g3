package android.appwidget;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.IntentSender;
import android.content.IntentSender.SendIntentException;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.Process;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.widget.RemoteViews;
import android.widget.RemoteViews.OnClickHandler;
import com.android.internal.appwidget.IAppWidgetHost.Stub;
import com.android.internal.appwidget.IAppWidgetService;
import java.util.ArrayList;
import java.util.HashMap;

public class AppWidgetHost {
    static final int HANDLE_PROVIDERS_CHANGED = 3;
    static final int HANDLE_PROVIDER_CHANGED = 2;
    static final int HANDLE_UPDATE = 1;
    static final int HANDLE_VIEW_DATA_CHANGED = 4;
    static IAppWidgetService sService;
    static final Object sServiceLock;
    Callbacks mCallbacks;
    private String mContextOpPackageName;
    private DisplayMetrics mDisplayMetrics;
    Handler mHandler;
    int mHostId;
    private OnClickHandler mOnClickHandler;
    final HashMap<Integer, AppWidgetHostView> mViews;

    class Callbacks extends Stub {
        Callbacks() {
        }

        public void updateAppWidget(int appWidgetId, RemoteViews views) {
            if (AppWidgetHost.this.isLocalBinder() && views != null) {
                views = views.clone();
            }
            AppWidgetHost.this.mHandler.obtainMessage(AppWidgetHost.HANDLE_UPDATE, appWidgetId, 0, views).sendToTarget();
        }

        public void providerChanged(int appWidgetId, AppWidgetProviderInfo info) {
            if (AppWidgetHost.this.isLocalBinder() && info != null) {
                info = info.clone();
            }
            AppWidgetHost.this.mHandler.obtainMessage(AppWidgetHost.HANDLE_PROVIDER_CHANGED, appWidgetId, 0, info).sendToTarget();
        }

        public void providersChanged() {
            AppWidgetHost.this.mHandler.obtainMessage(AppWidgetHost.HANDLE_PROVIDERS_CHANGED).sendToTarget();
        }

        public void viewDataChanged(int appWidgetId, int viewId) {
            AppWidgetHost.this.mHandler.obtainMessage(AppWidgetHost.HANDLE_VIEW_DATA_CHANGED, appWidgetId, viewId).sendToTarget();
        }
    }

    class UpdateHandler extends Handler {
        public UpdateHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case AppWidgetHost.HANDLE_UPDATE /*1*/:
                    AppWidgetHost.this.updateAppWidgetView(msg.arg1, (RemoteViews) msg.obj);
                case AppWidgetHost.HANDLE_PROVIDER_CHANGED /*2*/:
                    AppWidgetHost.this.onProviderChanged(msg.arg1, (AppWidgetProviderInfo) msg.obj);
                case AppWidgetHost.HANDLE_PROVIDERS_CHANGED /*3*/:
                    AppWidgetHost.this.onProvidersChanged();
                case AppWidgetHost.HANDLE_VIEW_DATA_CHANGED /*4*/:
                    AppWidgetHost.this.viewDataChanged(msg.arg1, msg.arg2);
                default:
            }
        }
    }

    static {
        sServiceLock = new Object();
    }

    public AppWidgetHost(Context context, int hostId) {
        this(context, hostId, null, context.getMainLooper());
    }

    public AppWidgetHost(Context context, int hostId, OnClickHandler handler, Looper looper) {
        this.mCallbacks = new Callbacks();
        this.mViews = new HashMap();
        this.mContextOpPackageName = context.getOpPackageName();
        this.mHostId = hostId;
        this.mOnClickHandler = handler;
        this.mHandler = new UpdateHandler(looper);
        this.mDisplayMetrics = context.getResources().getDisplayMetrics();
        bindService();
    }

    private static void bindService() {
        synchronized (sServiceLock) {
            if (sService == null) {
                sService = IAppWidgetService.Stub.asInterface(ServiceManager.getService(Context.APPWIDGET_SERVICE));
            }
        }
    }

    public void startListening() {
        ArrayList<RemoteViews> updatedViews = new ArrayList();
        try {
            int[] updatedIds = sService.startListening(this.mCallbacks, this.mContextOpPackageName, this.mHostId, updatedViews);
            int N = updatedIds.length;
            for (int i = 0; i < N; i += HANDLE_UPDATE) {
                updateAppWidgetView(updatedIds[i], (RemoteViews) updatedViews.get(i));
            }
        } catch (RemoteException e) {
            throw new RuntimeException("system server dead?", e);
        }
    }

    public void stopListening() {
        try {
            sService.stopListening(this.mContextOpPackageName, this.mHostId);
            clearViews();
        } catch (RemoteException e) {
            throw new RuntimeException("system server dead?", e);
        }
    }

    public int allocateAppWidgetId() {
        try {
            return sService.allocateAppWidgetId(this.mContextOpPackageName, this.mHostId);
        } catch (RemoteException e) {
            throw new RuntimeException("system server dead?", e);
        }
    }

    public final void startAppWidgetConfigureActivityForResult(Activity activity, int appWidgetId, int intentFlags, int requestCode, Bundle options) {
        try {
            IntentSender intentSender = sService.createAppWidgetConfigIntentSender(this.mContextOpPackageName, appWidgetId);
            if (intentSender != null) {
                activity.startIntentSenderForResult(intentSender, requestCode, null, 0, intentFlags, intentFlags, options);
                return;
            }
            throw new ActivityNotFoundException();
        } catch (SendIntentException e) {
            throw new ActivityNotFoundException();
        } catch (RemoteException e2) {
            throw new RuntimeException("system server dead?", e2);
        }
    }

    public int[] getAppWidgetIds() {
        try {
            if (sService == null) {
                bindService();
            }
            return sService.getAppWidgetIdsForHost(this.mContextOpPackageName, this.mHostId);
        } catch (RemoteException e) {
            throw new RuntimeException("system server dead?", e);
        }
    }

    private boolean isLocalBinder() {
        return Process.myPid() == Binder.getCallingPid();
    }

    public void deleteAppWidgetId(int appWidgetId) {
        synchronized (this.mViews) {
            this.mViews.remove(Integer.valueOf(appWidgetId));
            try {
                sService.deleteAppWidgetId(this.mContextOpPackageName, appWidgetId);
            } catch (RemoteException e) {
                throw new RuntimeException("system server dead?", e);
            }
        }
    }

    public void deleteHost() {
        try {
            sService.deleteHost(this.mContextOpPackageName, this.mHostId);
        } catch (RemoteException e) {
            throw new RuntimeException("system server dead?", e);
        }
    }

    public static void deleteAllHosts() {
        try {
            sService.deleteAllHosts();
        } catch (RemoteException e) {
            throw new RuntimeException("system server dead?", e);
        }
    }

    public final AppWidgetHostView createView(Context context, int appWidgetId, AppWidgetProviderInfo appWidget) {
        AppWidgetHostView view = onCreateView(context, appWidgetId, appWidget);
        view.setOnClickHandler(this.mOnClickHandler);
        view.setAppWidget(appWidgetId, appWidget);
        synchronized (this.mViews) {
            this.mViews.put(Integer.valueOf(appWidgetId), view);
        }
        try {
            view.updateAppWidget(sService.getAppWidgetViews(this.mContextOpPackageName, appWidgetId));
            return view;
        } catch (RemoteException e) {
            throw new RuntimeException("system server dead?", e);
        }
    }

    protected AppWidgetHostView onCreateView(Context context, int appWidgetId, AppWidgetProviderInfo appWidget) {
        return new AppWidgetHostView(context, this.mOnClickHandler);
    }

    protected void onProviderChanged(int appWidgetId, AppWidgetProviderInfo appWidget) {
        appWidget.minWidth = TypedValue.complexToDimensionPixelSize(appWidget.minWidth, this.mDisplayMetrics);
        appWidget.minHeight = TypedValue.complexToDimensionPixelSize(appWidget.minHeight, this.mDisplayMetrics);
        appWidget.minResizeWidth = TypedValue.complexToDimensionPixelSize(appWidget.minResizeWidth, this.mDisplayMetrics);
        appWidget.minResizeHeight = TypedValue.complexToDimensionPixelSize(appWidget.minResizeHeight, this.mDisplayMetrics);
        synchronized (this.mViews) {
            AppWidgetHostView v = (AppWidgetHostView) this.mViews.get(Integer.valueOf(appWidgetId));
        }
        if (v != null) {
            v.resetAppWidget(appWidget);
        }
    }

    protected void onProvidersChanged() {
    }

    void updateAppWidgetView(int appWidgetId, RemoteViews views) {
        synchronized (this.mViews) {
            AppWidgetHostView v = (AppWidgetHostView) this.mViews.get(Integer.valueOf(appWidgetId));
        }
        if (v != null) {
            v.updateAppWidget(views);
        }
    }

    void viewDataChanged(int appWidgetId, int viewId) {
        synchronized (this.mViews) {
            AppWidgetHostView v = (AppWidgetHostView) this.mViews.get(Integer.valueOf(appWidgetId));
        }
        if (v != null) {
            v.viewDataChanged(viewId);
        }
    }

    protected void clearViews() {
        this.mViews.clear();
    }
}
