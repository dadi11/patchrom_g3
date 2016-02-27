package android.view;

import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.RemoteException;
import android.view.IWindowFocusObserver.Stub;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.Toast;
import java.util.HashMap;

public class WindowId implements Parcelable {
    public static final Creator<WindowId> CREATOR;
    private final IWindowId mToken;

    /* renamed from: android.view.WindowId.1 */
    static class C08731 implements Creator<WindowId> {
        C08731() {
        }

        public WindowId createFromParcel(Parcel in) {
            IBinder target = in.readStrongBinder();
            return target != null ? new WindowId(target) : null;
        }

        public WindowId[] newArray(int size) {
            return new WindowId[size];
        }
    }

    public static abstract class FocusObserver {
        final Handler mHandler;
        final Stub mIObserver;
        final HashMap<IBinder, WindowId> mRegistrations;

        /* renamed from: android.view.WindowId.FocusObserver.1 */
        class C08741 extends Stub {
            C08741() {
            }

            public void focusGained(IBinder inputToken) {
                synchronized (FocusObserver.this.mRegistrations) {
                    WindowId token = (WindowId) FocusObserver.this.mRegistrations.get(inputToken);
                }
                if (FocusObserver.this.mHandler != null) {
                    FocusObserver.this.mHandler.sendMessage(FocusObserver.this.mHandler.obtainMessage(1, token));
                } else {
                    FocusObserver.this.onFocusGained(token);
                }
            }

            public void focusLost(IBinder inputToken) {
                synchronized (FocusObserver.this.mRegistrations) {
                    WindowId token = (WindowId) FocusObserver.this.mRegistrations.get(inputToken);
                }
                if (FocusObserver.this.mHandler != null) {
                    FocusObserver.this.mHandler.sendMessage(FocusObserver.this.mHandler.obtainMessage(2, token));
                } else {
                    FocusObserver.this.onFocusLost(token);
                }
            }
        }

        /* renamed from: android.view.WindowId.FocusObserver.H */
        class C0875H extends Handler {
            C0875H() {
            }

            public void handleMessage(Message msg) {
                switch (msg.what) {
                    case Toast.LENGTH_LONG /*1*/:
                        FocusObserver.this.onFocusGained((WindowId) msg.obj);
                    case Action.MERGE_IGNORE /*2*/:
                        FocusObserver.this.onFocusLost((WindowId) msg.obj);
                    default:
                        super.handleMessage(msg);
                }
            }
        }

        public abstract void onFocusGained(WindowId windowId);

        public abstract void onFocusLost(WindowId windowId);

        public FocusObserver() {
            this.mIObserver = new C08741();
            this.mRegistrations = new HashMap();
            this.mHandler = new C0875H();
        }
    }

    public boolean isFocused() {
        try {
            return this.mToken.isFocused();
        } catch (RemoteException e) {
            return false;
        }
    }

    public void registerFocusObserver(FocusObserver observer) {
        synchronized (observer.mRegistrations) {
            if (observer.mRegistrations.containsKey(this.mToken.asBinder())) {
                throw new IllegalStateException("Focus observer already registered with input token");
            }
            observer.mRegistrations.put(this.mToken.asBinder(), this);
            try {
                this.mToken.registerFocusObserver(observer.mIObserver);
            } catch (RemoteException e) {
            }
        }
    }

    public void unregisterFocusObserver(FocusObserver observer) {
        synchronized (observer.mRegistrations) {
            if (observer.mRegistrations.remove(this.mToken.asBinder()) == null) {
                throw new IllegalStateException("Focus observer not registered with input token");
            }
            try {
                this.mToken.unregisterFocusObserver(observer.mIObserver);
            } catch (RemoteException e) {
            }
        }
    }

    public boolean equals(Object otherObj) {
        if (otherObj instanceof WindowId) {
            return this.mToken.asBinder().equals(((WindowId) otherObj).mToken.asBinder());
        }
        return false;
    }

    public int hashCode() {
        return this.mToken.asBinder().hashCode();
    }

    public String toString() {
        StringBuilder sb = new StringBuilder(AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
        sb.append("IntentSender{");
        sb.append(Integer.toHexString(System.identityHashCode(this)));
        sb.append(": ");
        sb.append(this.mToken != null ? this.mToken.asBinder() : null);
        sb.append('}');
        return sb.toString();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeStrongBinder(this.mToken.asBinder());
    }

    static {
        CREATOR = new C08731();
    }

    public IWindowId getTarget() {
        return this.mToken;
    }

    public WindowId(IWindowId target) {
        this.mToken = target;
    }

    public WindowId(IBinder target) {
        this.mToken = IWindowId.Stub.asInterface(target);
    }
}
