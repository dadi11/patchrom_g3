package android.widget;

import android.C0000R;
import android.app.INotificationManager;
import android.app.ITransientNotification.Stub;
import android.content.Context;
import android.content.res.Resources.NotFoundException;
import android.os.Handler;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityManager;

public class Toast {
    public static final int LENGTH_LONG = 1;
    public static final int LENGTH_SHORT = 0;
    static final String TAG = "Toast";
    static final boolean localLOGV = false;
    private static INotificationManager sService;
    final Context mContext;
    int mDuration;
    View mNextView;
    final TN mTN;

    private static class TN extends Stub {
        int mGravity;
        final Handler mHandler;
        final Runnable mHide;
        float mHorizontalMargin;
        View mNextView;
        private final LayoutParams mParams;
        final Runnable mShow;
        float mVerticalMargin;
        View mView;
        WindowManager mWM;
        int mX;
        int mY;

        /* renamed from: android.widget.Toast.TN.1 */
        class C10841 implements Runnable {
            C10841() {
            }

            public void run() {
                TN.this.handleShow();
            }
        }

        /* renamed from: android.widget.Toast.TN.2 */
        class C10852 implements Runnable {
            C10852() {
            }

            public void run() {
                TN.this.handleHide();
                TN.this.mNextView = null;
            }
        }

        TN() {
            this.mShow = new C10841();
            this.mHide = new C10852();
            this.mParams = new LayoutParams();
            this.mHandler = new Handler();
            LayoutParams params = this.mParams;
            params.height = -2;
            params.width = -2;
            params.format = -3;
            params.windowAnimations = 16973828;
            params.type = LayoutParams.TYPE_TOAST;
            params.setTitle(Toast.TAG);
            params.flags = KeyEvent.KEYCODE_NUMPAD_8;
        }

        public void show() {
            this.mHandler.post(this.mShow);
        }

        public void hide() {
            this.mHandler.post(this.mHide);
        }

        public void handleShow() {
            if (this.mView != this.mNextView) {
                handleHide();
                this.mView = this.mNextView;
                Context context = this.mView.getContext().getApplicationContext();
                String packageName = this.mView.getContext().getOpPackageName();
                if (context == null) {
                    context = this.mView.getContext();
                }
                this.mWM = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
                int gravity = Gravity.getAbsoluteGravity(this.mGravity, this.mView.getContext().getResources().getConfiguration().getLayoutDirection());
                this.mParams.gravity = gravity;
                if ((gravity & 7) == 7) {
                    this.mParams.horizontalWeight = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
                }
                if ((gravity & KeyEvent.KEYCODE_FORWARD_DEL) == KeyEvent.KEYCODE_FORWARD_DEL) {
                    this.mParams.verticalWeight = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
                }
                this.mParams.f95x = this.mX;
                this.mParams.f96y = this.mY;
                this.mParams.verticalMargin = this.mVerticalMargin;
                this.mParams.horizontalMargin = this.mHorizontalMargin;
                this.mParams.packageName = packageName;
                if (this.mView.getParent() != null) {
                    this.mWM.removeView(this.mView);
                }
                this.mWM.addView(this.mView, this.mParams);
                trySendAccessibilityEvent();
            }
        }

        private void trySendAccessibilityEvent() {
            AccessibilityManager accessibilityManager = AccessibilityManager.getInstance(this.mView.getContext());
            if (accessibilityManager.isEnabled()) {
                AccessibilityEvent event = AccessibilityEvent.obtain(64);
                event.setClassName(getClass().getName());
                event.setPackageName(this.mView.getContext().getPackageName());
                this.mView.dispatchPopulateAccessibilityEvent(event);
                accessibilityManager.sendAccessibilityEvent(event);
            }
        }

        public void handleHide() {
            if (this.mView != null) {
                if (this.mView.getParent() != null) {
                    this.mWM.removeView(this.mView);
                }
                this.mView = null;
            }
        }
    }

    public Toast(Context context) {
        this.mContext = context;
        this.mTN = new TN();
        this.mTN.mY = context.getResources().getDimensionPixelSize(17104912);
        this.mTN.mGravity = context.getResources().getInteger(17694843);
    }

    public void show() {
        if (this.mNextView == null) {
            throw new RuntimeException("setView must have been called");
        }
        INotificationManager service = getService();
        String pkg = this.mContext.getOpPackageName();
        TN tn = this.mTN;
        tn.mNextView = this.mNextView;
        try {
            service.enqueueToast(pkg, tn, this.mDuration);
        } catch (RemoteException e) {
        }
    }

    public void cancel() {
        this.mTN.hide();
        try {
            getService().cancelToast(this.mContext.getPackageName(), this.mTN);
        } catch (RemoteException e) {
        }
    }

    public void setView(View view) {
        this.mNextView = view;
    }

    public View getView() {
        return this.mNextView;
    }

    public void setDuration(int duration) {
        this.mDuration = duration;
    }

    public int getDuration() {
        return this.mDuration;
    }

    public void setMargin(float horizontalMargin, float verticalMargin) {
        this.mTN.mHorizontalMargin = horizontalMargin;
        this.mTN.mVerticalMargin = verticalMargin;
    }

    public float getHorizontalMargin() {
        return this.mTN.mHorizontalMargin;
    }

    public float getVerticalMargin() {
        return this.mTN.mVerticalMargin;
    }

    public void setGravity(int gravity, int xOffset, int yOffset) {
        this.mTN.mGravity = gravity;
        this.mTN.mX = xOffset;
        this.mTN.mY = yOffset;
    }

    public int getGravity() {
        return this.mTN.mGravity;
    }

    public int getXOffset() {
        return this.mTN.mX;
    }

    public int getYOffset() {
        return this.mTN.mY;
    }

    public LayoutParams getWindowParams() {
        return this.mTN.mParams;
    }

    public static Toast makeText(Context context, CharSequence text, int duration) {
        Toast result = new Toast(context);
        View v = ((LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(17367269, null);
        ((TextView) v.findViewById(C0000R.id.message)).setText(text);
        result.mNextView = v;
        result.mDuration = duration;
        return result;
    }

    public static Toast makeText(Context context, int resId, int duration) throws NotFoundException {
        return makeText(context, context.getResources().getText(resId), duration);
    }

    public void setText(int resId) {
        setText(this.mContext.getText(resId));
    }

    public void setText(CharSequence s) {
        if (this.mNextView == null) {
            throw new RuntimeException("This Toast was not created with Toast.makeText()");
        }
        TextView tv = (TextView) this.mNextView.findViewById(C0000R.id.message);
        if (tv == null) {
            throw new RuntimeException("This Toast was not created with Toast.makeText()");
        }
        tv.setText(s);
    }

    private static INotificationManager getService() {
        if (sService != null) {
            return sService;
        }
        sService = INotificationManager.Stub.asInterface(ServiceManager.getService(Context.NOTIFICATION_SERVICE));
        return sService;
    }
}
