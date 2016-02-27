package com.android.server.display;

import android.content.Context;
import android.os.Handler;
import com.android.server.display.DisplayManagerService.SyncRoot;
import java.io.PrintWriter;

abstract class DisplayAdapter {
    public static final int DISPLAY_DEVICE_EVENT_ADDED = 1;
    public static final int DISPLAY_DEVICE_EVENT_CHANGED = 2;
    public static final int DISPLAY_DEVICE_EVENT_REMOVED = 3;
    private final Context mContext;
    private final Handler mHandler;
    private final Listener mListener;
    private final String mName;
    private final SyncRoot mSyncRoot;

    /* renamed from: com.android.server.display.DisplayAdapter.1 */
    class C01931 implements Runnable {
        final /* synthetic */ DisplayDevice val$device;
        final /* synthetic */ int val$event;

        C01931(DisplayDevice displayDevice, int i) {
            this.val$device = displayDevice;
            this.val$event = i;
        }

        public void run() {
            DisplayAdapter.this.mListener.onDisplayDeviceEvent(this.val$device, this.val$event);
        }
    }

    /* renamed from: com.android.server.display.DisplayAdapter.2 */
    class C01942 implements Runnable {
        C01942() {
        }

        public void run() {
            DisplayAdapter.this.mListener.onTraversalRequested();
        }
    }

    public interface Listener {
        void onDisplayDeviceEvent(DisplayDevice displayDevice, int i);

        void onTraversalRequested();
    }

    public DisplayAdapter(SyncRoot syncRoot, Context context, Handler handler, Listener listener, String name) {
        this.mSyncRoot = syncRoot;
        this.mContext = context;
        this.mHandler = handler;
        this.mListener = listener;
        this.mName = name;
    }

    public final SyncRoot getSyncRoot() {
        return this.mSyncRoot;
    }

    public final Context getContext() {
        return this.mContext;
    }

    public final Handler getHandler() {
        return this.mHandler;
    }

    public final String getName() {
        return this.mName;
    }

    public void registerLocked() {
    }

    public void dumpLocked(PrintWriter pw) {
    }

    protected final void sendDisplayDeviceEventLocked(DisplayDevice device, int event) {
        this.mHandler.post(new C01931(device, event));
    }

    protected final void sendTraversalRequestLocked() {
        this.mHandler.post(new C01942());
    }
}
