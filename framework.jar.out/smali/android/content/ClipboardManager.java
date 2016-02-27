package android.content;

import android.content.IOnPrimaryClipChangedListener.Stub;
import android.os.Handler;
import android.os.Message;
import android.os.RemoteException;
import android.os.ServiceManager;
import java.util.ArrayList;

public class ClipboardManager extends android.text.ClipboardManager {
    static final int MSG_REPORT_PRIMARY_CLIP_CHANGED = 1;
    private static IClipboard sService;
    private static final Object sStaticLock;
    private final Context mContext;
    private final Handler mHandler;
    private final ArrayList<OnPrimaryClipChangedListener> mPrimaryClipChangedListeners;
    private final Stub mPrimaryClipChangedServiceListener;

    /* renamed from: android.content.ClipboardManager.1 */
    class C00921 extends Stub {
        C00921() {
        }

        public void dispatchPrimaryClipChanged() {
            ClipboardManager.this.mHandler.sendEmptyMessage(ClipboardManager.MSG_REPORT_PRIMARY_CLIP_CHANGED);
        }
    }

    /* renamed from: android.content.ClipboardManager.2 */
    class C00932 extends Handler {
        C00932() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case ClipboardManager.MSG_REPORT_PRIMARY_CLIP_CHANGED /*1*/:
                    ClipboardManager.this.reportPrimaryClipChanged();
                default:
            }
        }
    }

    public interface OnPrimaryClipChangedListener {
        void onPrimaryClipChanged();
    }

    static {
        sStaticLock = new Object();
    }

    private static IClipboard getService() {
        IClipboard iClipboard;
        synchronized (sStaticLock) {
            if (sService != null) {
                iClipboard = sService;
            } else {
                sService = IClipboard.Stub.asInterface(ServiceManager.getService(Context.CLIPBOARD_SERVICE));
                iClipboard = sService;
            }
        }
        return iClipboard;
    }

    public ClipboardManager(Context context, Handler handler) {
        this.mPrimaryClipChangedListeners = new ArrayList();
        this.mPrimaryClipChangedServiceListener = new C00921();
        this.mHandler = new C00932();
        this.mContext = context;
    }

    public void setPrimaryClip(ClipData clip) {
        if (clip != null) {
            try {
                clip.prepareToLeaveProcess();
            } catch (RemoteException e) {
                return;
            }
        }
        getService().setPrimaryClip(clip, this.mContext.getOpPackageName());
    }

    public ClipData getPrimaryClip() {
        try {
            return getService().getPrimaryClip(this.mContext.getOpPackageName());
        } catch (RemoteException e) {
            return null;
        }
    }

    public ClipDescription getPrimaryClipDescription() {
        try {
            return getService().getPrimaryClipDescription(this.mContext.getOpPackageName());
        } catch (RemoteException e) {
            return null;
        }
    }

    public boolean hasPrimaryClip() {
        try {
            return getService().hasPrimaryClip(this.mContext.getOpPackageName());
        } catch (RemoteException e) {
            return false;
        }
    }

    public void addPrimaryClipChangedListener(OnPrimaryClipChangedListener what) {
        synchronized (this.mPrimaryClipChangedListeners) {
            if (this.mPrimaryClipChangedListeners.size() == 0) {
                try {
                    getService().addPrimaryClipChangedListener(this.mPrimaryClipChangedServiceListener, this.mContext.getOpPackageName());
                } catch (RemoteException e) {
                }
            }
            this.mPrimaryClipChangedListeners.add(what);
        }
    }

    public void removePrimaryClipChangedListener(OnPrimaryClipChangedListener what) {
        synchronized (this.mPrimaryClipChangedListeners) {
            this.mPrimaryClipChangedListeners.remove(what);
            if (this.mPrimaryClipChangedListeners.size() == 0) {
                try {
                    getService().removePrimaryClipChangedListener(this.mPrimaryClipChangedServiceListener);
                } catch (RemoteException e) {
                }
            }
        }
    }

    public CharSequence getText() {
        ClipData clip = getPrimaryClip();
        if (clip == null || clip.getItemCount() <= 0) {
            return null;
        }
        return clip.getItemAt(0).coerceToText(this.mContext);
    }

    public void setText(CharSequence text) {
        setPrimaryClip(ClipData.newPlainText(null, text));
    }

    public boolean hasText() {
        try {
            return getService().hasClipboardText(this.mContext.getOpPackageName());
        } catch (RemoteException e) {
            return false;
        }
    }

    void reportPrimaryClipChanged() {
        synchronized (this.mPrimaryClipChangedListeners) {
            if (this.mPrimaryClipChangedListeners.size() <= 0) {
                return;
            }
            Object[] listeners = this.mPrimaryClipChangedListeners.toArray();
            for (int i = 0; i < listeners.length; i += MSG_REPORT_PRIMARY_CLIP_CHANGED) {
                ((OnPrimaryClipChangedListener) listeners[i]).onPrimaryClipChanged();
            }
        }
    }
}
