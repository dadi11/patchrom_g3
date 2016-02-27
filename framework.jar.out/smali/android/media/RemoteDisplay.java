package android.media;

import android.os.Handler;
import android.view.Surface;
import dalvik.system.CloseGuard;

public final class RemoteDisplay {
    public static final int DISPLAY_ERROR_CONNECTION_DROPPED = 2;
    public static final int DISPLAY_ERROR_UNKOWN = 1;
    public static final int DISPLAY_FLAG_SECURE = 1;
    private final CloseGuard mGuard;
    private final Handler mHandler;
    private final Listener mListener;
    private long mPtr;

    /* renamed from: android.media.RemoteDisplay.1 */
    class C03921 implements Runnable {
        final /* synthetic */ int val$flags;
        final /* synthetic */ int val$height;
        final /* synthetic */ int val$session;
        final /* synthetic */ Surface val$surface;
        final /* synthetic */ int val$width;

        C03921(Surface surface, int i, int i2, int i3, int i4) {
            this.val$surface = surface;
            this.val$width = i;
            this.val$height = i2;
            this.val$flags = i3;
            this.val$session = i4;
        }

        public void run() {
            RemoteDisplay.this.mListener.onDisplayConnected(this.val$surface, this.val$width, this.val$height, this.val$flags, this.val$session);
        }
    }

    /* renamed from: android.media.RemoteDisplay.2 */
    class C03932 implements Runnable {
        C03932() {
        }

        public void run() {
            RemoteDisplay.this.mListener.onDisplayDisconnected();
        }
    }

    /* renamed from: android.media.RemoteDisplay.3 */
    class C03943 implements Runnable {
        final /* synthetic */ int val$error;

        C03943(int i) {
            this.val$error = i;
        }

        public void run() {
            RemoteDisplay.this.mListener.onDisplayError(this.val$error);
        }
    }

    public interface Listener {
        void onDisplayConnected(Surface surface, int i, int i2, int i3, int i4);

        void onDisplayDisconnected();

        void onDisplayError(int i);
    }

    private native void nativeDispose(long j);

    private native long nativeListen(String str);

    private native void nativePause(long j);

    private native void nativeResume(long j);

    private RemoteDisplay(Listener listener, Handler handler) {
        this.mGuard = CloseGuard.get();
        this.mListener = listener;
        this.mHandler = handler;
    }

    protected void finalize() throws Throwable {
        try {
            dispose(true);
        } finally {
            super.finalize();
        }
    }

    public static RemoteDisplay listen(String iface, Listener listener, Handler handler) {
        if (iface == null) {
            throw new IllegalArgumentException("iface must not be null");
        } else if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        } else if (handler == null) {
            throw new IllegalArgumentException("handler must not be null");
        } else {
            RemoteDisplay display = new RemoteDisplay(listener, handler);
            display.startListening(iface);
            return display;
        }
    }

    public void dispose() {
        dispose(false);
    }

    public void pause() {
        nativePause(this.mPtr);
    }

    public void resume() {
        nativeResume(this.mPtr);
    }

    private void dispose(boolean finalized) {
        if (this.mPtr != 0) {
            if (this.mGuard != null) {
                if (finalized) {
                    this.mGuard.warnIfOpen();
                } else {
                    this.mGuard.close();
                }
            }
            nativeDispose(this.mPtr);
            this.mPtr = 0;
        }
    }

    private void startListening(String iface) {
        this.mPtr = nativeListen(iface);
        if (this.mPtr == 0) {
            throw new IllegalStateException("Could not start listening for remote display connection on \"" + iface + "\"");
        }
        this.mGuard.open("dispose");
    }

    private void notifyDisplayConnected(Surface surface, int width, int height, int flags, int session) {
        this.mHandler.post(new C03921(surface, width, height, flags, session));
    }

    private void notifyDisplayDisconnected() {
        this.mHandler.post(new C03932());
    }

    private void notifyDisplayError(int error) {
        this.mHandler.post(new C03943(error));
    }
}
