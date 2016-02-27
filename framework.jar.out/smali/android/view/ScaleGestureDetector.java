package android.view;

import android.content.Context;
import android.content.res.Resources;
import android.os.Handler;
import android.view.GestureDetector.SimpleOnGestureListener;
import android.view.WindowManager.LayoutParams;

public class ScaleGestureDetector {
    private static final int DOUBLE_TAP_MODE_IN_PROGRESS = 1;
    private static final int DOUBLE_TAP_MODE_NONE = 0;
    private static final float SCALE_FACTOR = 0.5f;
    private static final String TAG = "ScaleGestureDetector";
    private static final long TOUCH_STABILIZE_TIME = 128;
    private final Context mContext;
    private float mCurrSpan;
    private float mCurrSpanX;
    private float mCurrSpanY;
    private long mCurrTime;
    private MotionEvent mDoubleTapEvent;
    private int mDoubleTapMode;
    private boolean mEventBeforeOrAboveStartingGestureEvent;
    private float mFocusX;
    private float mFocusY;
    private GestureDetector mGestureDetector;
    private final Handler mHandler;
    private boolean mInProgress;
    private float mInitialSpan;
    private final InputEventConsistencyVerifier mInputEventConsistencyVerifier;
    private final OnScaleGestureListener mListener;
    private int mMinSpan;
    private float mPrevSpan;
    private float mPrevSpanX;
    private float mPrevSpanY;
    private long mPrevTime;
    private boolean mQuickScaleEnabled;
    private int mSpanSlop;
    private int mTouchHistoryDirection;
    private float mTouchHistoryLastAccepted;
    private long mTouchHistoryLastAcceptedTime;
    private float mTouchLower;
    private int mTouchMinMajor;
    private float mTouchUpper;

    /* renamed from: android.view.ScaleGestureDetector.1 */
    class C08301 extends SimpleOnGestureListener {
        C08301() {
        }

        public boolean onDoubleTap(MotionEvent e) {
            ScaleGestureDetector.this.mDoubleTapEvent = e;
            ScaleGestureDetector.this.mDoubleTapMode = ScaleGestureDetector.DOUBLE_TAP_MODE_IN_PROGRESS;
            return true;
        }
    }

    public interface OnScaleGestureListener {
        boolean onScale(ScaleGestureDetector scaleGestureDetector);

        boolean onScaleBegin(ScaleGestureDetector scaleGestureDetector);

        void onScaleEnd(ScaleGestureDetector scaleGestureDetector);
    }

    public static class SimpleOnScaleGestureListener implements OnScaleGestureListener {
        public boolean onScale(ScaleGestureDetector detector) {
            return false;
        }

        public boolean onScaleBegin(ScaleGestureDetector detector) {
            return true;
        }

        public void onScaleEnd(ScaleGestureDetector detector) {
        }
    }

    public ScaleGestureDetector(Context context, OnScaleGestureListener listener) {
        this(context, listener, null);
    }

    public ScaleGestureDetector(Context context, OnScaleGestureListener listener, Handler handler) {
        InputEventConsistencyVerifier inputEventConsistencyVerifier;
        this.mDoubleTapMode = DOUBLE_TAP_MODE_NONE;
        if (InputEventConsistencyVerifier.isInstrumentationEnabled()) {
            inputEventConsistencyVerifier = new InputEventConsistencyVerifier(this, DOUBLE_TAP_MODE_NONE);
        } else {
            inputEventConsistencyVerifier = null;
        }
        this.mInputEventConsistencyVerifier = inputEventConsistencyVerifier;
        this.mContext = context;
        this.mListener = listener;
        this.mSpanSlop = ViewConfiguration.get(context).getScaledTouchSlop() * 2;
        Resources res = context.getResources();
        this.mTouchMinMajor = res.getDimensionPixelSize(17104910);
        this.mMinSpan = res.getDimensionPixelSize(17104909);
        this.mHandler = handler;
        if (context.getApplicationInfo().targetSdkVersion > 18) {
            setQuickScaleEnabled(true);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void addTouchHistory(android.view.MotionEvent r27) {
        /*
        r26 = this;
        r8 = android.os.SystemClock.uptimeMillis();
        r6 = r27.getPointerCount();
        r0 = r26;
        r0 = r0.mTouchHistoryLastAcceptedTime;
        r22 = r0;
        r22 = r8 - r22;
        r24 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
        r21 = (r22 > r24 ? 1 : (r22 == r24 ? 0 : -1));
        if (r21 < 0) goto L_0x00c8;
    L_0x0016:
        r4 = 1;
    L_0x0017:
        r20 = 0;
        r17 = 0;
        r13 = 0;
    L_0x001c:
        if (r13 >= r6) goto L_0x00e1;
    L_0x001e:
        r0 = r26;
        r0 = r0.mTouchHistoryLastAccepted;
        r21 = r0;
        r21 = java.lang.Float.isNaN(r21);
        if (r21 != 0) goto L_0x00cb;
    L_0x002a:
        r11 = 1;
    L_0x002b:
        r12 = r27.getHistorySize();
        r16 = r12 + 1;
        r10 = 0;
    L_0x0032:
        r0 = r16;
        if (r10 >= r0) goto L_0x00db;
    L_0x0036:
        if (r10 >= r12) goto L_0x00ce;
    L_0x0038:
        r0 = r27;
        r14 = r0.getHistoricalTouchMajor(r13, r10);
    L_0x003e:
        r0 = r26;
        r0 = r0.mTouchMinMajor;
        r21 = r0;
        r0 = r21;
        r0 = (float) r0;
        r21 = r0;
        r21 = (r14 > r21 ? 1 : (r14 == r21 ? 0 : -1));
        if (r21 >= 0) goto L_0x0056;
    L_0x004d:
        r0 = r26;
        r0 = r0.mTouchMinMajor;
        r21 = r0;
        r0 = r21;
        r14 = (float) r0;
    L_0x0056:
        r20 = r20 + r14;
        r0 = r26;
        r0 = r0.mTouchUpper;
        r21 = r0;
        r21 = java.lang.Float.isNaN(r21);
        if (r21 != 0) goto L_0x006e;
    L_0x0064:
        r0 = r26;
        r0 = r0.mTouchUpper;
        r21 = r0;
        r21 = (r14 > r21 ? 1 : (r14 == r21 ? 0 : -1));
        if (r21 <= 0) goto L_0x0072;
    L_0x006e:
        r0 = r26;
        r0.mTouchUpper = r14;
    L_0x0072:
        r0 = r26;
        r0 = r0.mTouchLower;
        r21 = r0;
        r21 = java.lang.Float.isNaN(r21);
        if (r21 != 0) goto L_0x0088;
    L_0x007e:
        r0 = r26;
        r0 = r0.mTouchLower;
        r21 = r0;
        r21 = (r14 > r21 ? 1 : (r14 == r21 ? 0 : -1));
        if (r21 >= 0) goto L_0x008c;
    L_0x0088:
        r0 = r26;
        r0.mTouchLower = r14;
    L_0x008c:
        if (r11 == 0) goto L_0x00c4;
    L_0x008e:
        r0 = r26;
        r0 = r0.mTouchHistoryLastAccepted;
        r21 = r0;
        r21 = r14 - r21;
        r21 = java.lang.Math.signum(r21);
        r0 = r21;
        r7 = (int) r0;
        r0 = r26;
        r0 = r0.mTouchHistoryDirection;
        r21 = r0;
        r0 = r21;
        if (r7 != r0) goto L_0x00b1;
    L_0x00a7:
        if (r7 != 0) goto L_0x00c4;
    L_0x00a9:
        r0 = r26;
        r0 = r0.mTouchHistoryDirection;
        r21 = r0;
        if (r21 != 0) goto L_0x00c4;
    L_0x00b1:
        r0 = r26;
        r0.mTouchHistoryDirection = r7;
        if (r10 >= r12) goto L_0x00d6;
    L_0x00b7:
        r0 = r27;
        r18 = r0.getHistoricalEventTime(r10);
    L_0x00bd:
        r0 = r18;
        r2 = r26;
        r2.mTouchHistoryLastAcceptedTime = r0;
        r4 = 0;
    L_0x00c4:
        r10 = r10 + 1;
        goto L_0x0032;
    L_0x00c8:
        r4 = 0;
        goto L_0x0017;
    L_0x00cb:
        r11 = 0;
        goto L_0x002b;
    L_0x00ce:
        r0 = r27;
        r14 = r0.getTouchMajor(r13);
        goto L_0x003e;
    L_0x00d6:
        r18 = r27.getEventTime();
        goto L_0x00bd;
    L_0x00db:
        r17 = r17 + r16;
        r13 = r13 + 1;
        goto L_0x001c;
    L_0x00e1:
        r0 = r17;
        r0 = (float) r0;
        r21 = r0;
        r5 = r20 / r21;
        if (r4 == 0) goto L_0x0138;
    L_0x00ea:
        r0 = r26;
        r0 = r0.mTouchUpper;
        r21 = r0;
        r0 = r26;
        r0 = r0.mTouchLower;
        r22 = r0;
        r21 = r21 + r22;
        r21 = r21 + r5;
        r22 = 1077936128; // 0x40400000 float:3.0 double:5.325712093E-315;
        r15 = r21 / r22;
        r0 = r26;
        r0 = r0.mTouchUpper;
        r21 = r0;
        r21 = r21 + r15;
        r22 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r21 = r21 / r22;
        r0 = r21;
        r1 = r26;
        r1.mTouchUpper = r0;
        r0 = r26;
        r0 = r0.mTouchLower;
        r21 = r0;
        r21 = r21 + r15;
        r22 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r21 = r21 / r22;
        r0 = r21;
        r1 = r26;
        r1.mTouchLower = r0;
        r0 = r26;
        r0.mTouchHistoryLastAccepted = r15;
        r21 = 0;
        r0 = r21;
        r1 = r26;
        r1.mTouchHistoryDirection = r0;
        r22 = r27.getEventTime();
        r0 = r22;
        r2 = r26;
        r2.mTouchHistoryLastAcceptedTime = r0;
    L_0x0138:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.view.ScaleGestureDetector.addTouchHistory(android.view.MotionEvent):void");
    }

    private void clearTouchHistory() {
        this.mTouchUpper = Float.NaN;
        this.mTouchLower = Float.NaN;
        this.mTouchHistoryLastAccepted = Float.NaN;
        this.mTouchHistoryDirection = DOUBLE_TAP_MODE_NONE;
        this.mTouchHistoryLastAcceptedTime = 0;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean onTouchEvent(android.view.MotionEvent r31) {
        /*
        r30 = this;
        r0 = r30;
        r0 = r0.mInputEventConsistencyVerifier;
        r27 = r0;
        if (r27 == 0) goto L_0x0019;
    L_0x0008:
        r0 = r30;
        r0 = r0.mInputEventConsistencyVerifier;
        r27 = r0;
        r28 = 0;
        r0 = r27;
        r1 = r31;
        r2 = r28;
        r0.onTouchEvent(r1, r2);
    L_0x0019:
        r28 = r31.getEventTime();
        r0 = r28;
        r2 = r30;
        r2.mCurrTime = r0;
        r4 = r31.getActionMasked();
        r0 = r30;
        r0 = r0.mQuickScaleEnabled;
        r27 = r0;
        if (r27 == 0) goto L_0x003c;
    L_0x002f:
        r0 = r30;
        r0 = r0.mGestureDetector;
        r27 = r0;
        r0 = r27;
        r1 = r31;
        r0.onTouchEvent(r1);
    L_0x003c:
        r27 = 1;
        r0 = r27;
        if (r4 == r0) goto L_0x0048;
    L_0x0042:
        r27 = 3;
        r0 = r27;
        if (r4 != r0) goto L_0x0083;
    L_0x0048:
        r21 = 1;
    L_0x004a:
        if (r4 == 0) goto L_0x004e;
    L_0x004c:
        if (r21 == 0) goto L_0x00af;
    L_0x004e:
        r0 = r30;
        r0 = r0.mInProgress;
        r27 = r0;
        if (r27 == 0) goto L_0x0086;
    L_0x0056:
        r0 = r30;
        r0 = r0.mListener;
        r27 = r0;
        r0 = r27;
        r1 = r30;
        r0.onScaleEnd(r1);
        r27 = 0;
        r0 = r27;
        r1 = r30;
        r1.mInProgress = r0;
        r27 = 0;
        r0 = r27;
        r1 = r30;
        r1.mInitialSpan = r0;
        r27 = 0;
        r0 = r27;
        r1 = r30;
        r1.mDoubleTapMode = r0;
    L_0x007b:
        if (r21 == 0) goto L_0x00af;
    L_0x007d:
        r30.clearTouchHistory();
        r27 = 1;
    L_0x0082:
        return r27;
    L_0x0083:
        r21 = 0;
        goto L_0x004a;
    L_0x0086:
        r0 = r30;
        r0 = r0.mDoubleTapMode;
        r27 = r0;
        r28 = 1;
        r0 = r27;
        r1 = r28;
        if (r0 != r1) goto L_0x007b;
    L_0x0094:
        if (r21 == 0) goto L_0x007b;
    L_0x0096:
        r27 = 0;
        r0 = r27;
        r1 = r30;
        r1.mInProgress = r0;
        r27 = 0;
        r0 = r27;
        r1 = r30;
        r1.mInitialSpan = r0;
        r27 = 0;
        r0 = r27;
        r1 = r30;
        r1.mDoubleTapMode = r0;
        goto L_0x007b;
    L_0x00af:
        if (r4 == 0) goto L_0x00bd;
    L_0x00b1:
        r27 = 6;
        r0 = r27;
        if (r4 == r0) goto L_0x00bd;
    L_0x00b7:
        r27 = 5;
        r0 = r27;
        if (r4 != r0) goto L_0x0119;
    L_0x00bd:
        r5 = 1;
    L_0x00be:
        r27 = 6;
        r0 = r27;
        if (r4 != r0) goto L_0x011b;
    L_0x00c4:
        r16 = 1;
    L_0x00c6:
        if (r16 == 0) goto L_0x011e;
    L_0x00c8:
        r17 = r31.getActionIndex();
    L_0x00cc:
        r22 = 0;
        r23 = 0;
        r6 = r31.getPointerCount();
        if (r16 == 0) goto L_0x0121;
    L_0x00d6:
        r11 = r6 + -1;
    L_0x00d8:
        r0 = r30;
        r0 = r0.mDoubleTapMode;
        r27 = r0;
        r28 = 1;
        r0 = r27;
        r1 = r28;
        if (r0 != r1) goto L_0x012c;
    L_0x00e6:
        r0 = r30;
        r0 = r0.mDoubleTapEvent;
        r27 = r0;
        r12 = r27.getX();
        r0 = r30;
        r0 = r0.mDoubleTapEvent;
        r27 = r0;
        r13 = r27.getY();
        r27 = r31.getY();
        r27 = (r27 > r13 ? 1 : (r27 == r13 ? 0 : -1));
        if (r27 >= 0) goto L_0x0123;
    L_0x0102:
        r27 = 1;
        r0 = r27;
        r1 = r30;
        r1.mEventBeforeOrAboveStartingGestureEvent = r0;
    L_0x010a:
        r30.addTouchHistory(r31);
        r7 = 0;
        r8 = 0;
        r14 = 0;
    L_0x0110:
        if (r14 >= r6) goto L_0x017d;
    L_0x0112:
        r0 = r17;
        if (r0 != r14) goto L_0x0152;
    L_0x0116:
        r14 = r14 + 1;
        goto L_0x0110;
    L_0x0119:
        r5 = 0;
        goto L_0x00be;
    L_0x011b:
        r16 = 0;
        goto L_0x00c6;
    L_0x011e:
        r17 = -1;
        goto L_0x00cc;
    L_0x0121:
        r11 = r6;
        goto L_0x00d8;
    L_0x0123:
        r27 = 0;
        r0 = r27;
        r1 = r30;
        r1.mEventBeforeOrAboveStartingGestureEvent = r0;
        goto L_0x010a;
    L_0x012c:
        r14 = 0;
    L_0x012d:
        if (r14 >= r6) goto L_0x0147;
    L_0x012f:
        r0 = r17;
        if (r0 != r14) goto L_0x0136;
    L_0x0133:
        r14 = r14 + 1;
        goto L_0x012d;
    L_0x0136:
        r0 = r31;
        r27 = r0.getX(r14);
        r22 = r22 + r27;
        r0 = r31;
        r27 = r0.getY(r14);
        r23 = r23 + r27;
        goto L_0x0133;
    L_0x0147:
        r0 = (float) r11;
        r27 = r0;
        r12 = r22 / r27;
        r0 = (float) r11;
        r27 = r0;
        r13 = r23 / r27;
        goto L_0x010a;
    L_0x0152:
        r0 = r30;
        r0 = r0.mTouchHistoryLastAccepted;
        r27 = r0;
        r28 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r24 = r27 / r28;
        r0 = r31;
        r27 = r0.getX(r14);
        r27 = r27 - r12;
        r27 = java.lang.Math.abs(r27);
        r27 = r27 + r24;
        r7 = r7 + r27;
        r0 = r31;
        r27 = r0.getY(r14);
        r27 = r27 - r13;
        r27 = java.lang.Math.abs(r27);
        r27 = r27 + r24;
        r8 = r8 + r27;
        goto L_0x0116;
    L_0x017d:
        r0 = (float) r11;
        r27 = r0;
        r9 = r7 / r27;
        r0 = (float) r11;
        r27 = r0;
        r10 = r8 / r27;
        r27 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r19 = r9 * r27;
        r27 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r20 = r10 * r27;
        r27 = r30.inDoubleTapMode();
        if (r27 == 0) goto L_0x02f3;
    L_0x0195:
        r18 = r20;
    L_0x0197:
        r0 = r30;
        r0 = r0.mInProgress;
        r26 = r0;
        r0 = r30;
        r0.mFocusX = r12;
        r0 = r30;
        r0.mFocusY = r13;
        r27 = r30.inDoubleTapMode();
        if (r27 != 0) goto L_0x01e7;
    L_0x01ab:
        r0 = r30;
        r0 = r0.mInProgress;
        r27 = r0;
        if (r27 == 0) goto L_0x01e7;
    L_0x01b3:
        r0 = r30;
        r0 = r0.mMinSpan;
        r27 = r0;
        r0 = r27;
        r0 = (float) r0;
        r27 = r0;
        r27 = (r18 > r27 ? 1 : (r18 == r27 ? 0 : -1));
        if (r27 < 0) goto L_0x01c4;
    L_0x01c2:
        if (r5 == 0) goto L_0x01e7;
    L_0x01c4:
        r0 = r30;
        r0 = r0.mListener;
        r27 = r0;
        r0 = r27;
        r1 = r30;
        r0.onScaleEnd(r1);
        r27 = 0;
        r0 = r27;
        r1 = r30;
        r1.mInProgress = r0;
        r0 = r18;
        r1 = r30;
        r1.mInitialSpan = r0;
        r27 = 0;
        r0 = r27;
        r1 = r30;
        r1.mDoubleTapMode = r0;
    L_0x01e7:
        if (r5 == 0) goto L_0x0213;
    L_0x01e9:
        r0 = r19;
        r1 = r30;
        r1.mCurrSpanX = r0;
        r0 = r19;
        r1 = r30;
        r1.mPrevSpanX = r0;
        r0 = r20;
        r1 = r30;
        r1.mCurrSpanY = r0;
        r0 = r20;
        r1 = r30;
        r1.mPrevSpanY = r0;
        r0 = r18;
        r1 = r30;
        r1.mCurrSpan = r0;
        r0 = r18;
        r1 = r30;
        r1.mPrevSpan = r0;
        r0 = r18;
        r1 = r30;
        r1.mInitialSpan = r0;
    L_0x0213:
        r27 = r30.inDoubleTapMode();
        if (r27 == 0) goto L_0x02ff;
    L_0x0219:
        r0 = r30;
        r15 = r0.mSpanSlop;
    L_0x021d:
        r0 = r30;
        r0 = r0.mInProgress;
        r27 = r0;
        if (r27 != 0) goto L_0x028d;
    L_0x0225:
        r0 = (float) r15;
        r27 = r0;
        r27 = (r18 > r27 ? 1 : (r18 == r27 ? 0 : -1));
        if (r27 < 0) goto L_0x028d;
    L_0x022c:
        if (r26 != 0) goto L_0x0249;
    L_0x022e:
        r0 = r30;
        r0 = r0.mInitialSpan;
        r27 = r0;
        r27 = r18 - r27;
        r27 = java.lang.Math.abs(r27);
        r0 = r30;
        r0 = r0.mSpanSlop;
        r28 = r0;
        r0 = r28;
        r0 = (float) r0;
        r28 = r0;
        r27 = (r27 > r28 ? 1 : (r27 == r28 ? 0 : -1));
        if (r27 <= 0) goto L_0x028d;
    L_0x0249:
        r0 = r19;
        r1 = r30;
        r1.mCurrSpanX = r0;
        r0 = r19;
        r1 = r30;
        r1.mPrevSpanX = r0;
        r0 = r20;
        r1 = r30;
        r1.mCurrSpanY = r0;
        r0 = r20;
        r1 = r30;
        r1.mPrevSpanY = r0;
        r0 = r18;
        r1 = r30;
        r1.mCurrSpan = r0;
        r0 = r18;
        r1 = r30;
        r1.mPrevSpan = r0;
        r0 = r30;
        r0 = r0.mCurrTime;
        r28 = r0;
        r0 = r28;
        r2 = r30;
        r2.mPrevTime = r0;
        r0 = r30;
        r0 = r0.mListener;
        r27 = r0;
        r0 = r27;
        r1 = r30;
        r27 = r0.onScaleBegin(r1);
        r0 = r27;
        r1 = r30;
        r1.mInProgress = r0;
    L_0x028d:
        r27 = 2;
        r0 = r27;
        if (r4 != r0) goto L_0x02ef;
    L_0x0293:
        r0 = r19;
        r1 = r30;
        r1.mCurrSpanX = r0;
        r0 = r20;
        r1 = r30;
        r1.mCurrSpanY = r0;
        r0 = r18;
        r1 = r30;
        r1.mCurrSpan = r0;
        r25 = 1;
        r0 = r30;
        r0 = r0.mInProgress;
        r27 = r0;
        if (r27 == 0) goto L_0x02bd;
    L_0x02af:
        r0 = r30;
        r0 = r0.mListener;
        r27 = r0;
        r0 = r27;
        r1 = r30;
        r25 = r0.onScale(r1);
    L_0x02bd:
        if (r25 == 0) goto L_0x02ef;
    L_0x02bf:
        r0 = r30;
        r0 = r0.mCurrSpanX;
        r27 = r0;
        r0 = r27;
        r1 = r30;
        r1.mPrevSpanX = r0;
        r0 = r30;
        r0 = r0.mCurrSpanY;
        r27 = r0;
        r0 = r27;
        r1 = r30;
        r1.mPrevSpanY = r0;
        r0 = r30;
        r0 = r0.mCurrSpan;
        r27 = r0;
        r0 = r27;
        r1 = r30;
        r1.mPrevSpan = r0;
        r0 = r30;
        r0 = r0.mCurrTime;
        r28 = r0;
        r0 = r28;
        r2 = r30;
        r2.mPrevTime = r0;
    L_0x02ef:
        r27 = 1;
        goto L_0x0082;
    L_0x02f3:
        r27 = r19 * r19;
        r28 = r20 * r20;
        r27 = r27 + r28;
        r18 = android.util.FloatMath.sqrt(r27);
        goto L_0x0197;
    L_0x02ff:
        r0 = r30;
        r15 = r0.mMinSpan;
        goto L_0x021d;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.view.ScaleGestureDetector.onTouchEvent(android.view.MotionEvent):boolean");
    }

    private boolean inDoubleTapMode() {
        return this.mDoubleTapMode == DOUBLE_TAP_MODE_IN_PROGRESS;
    }

    public void setQuickScaleEnabled(boolean scales) {
        this.mQuickScaleEnabled = scales;
        if (this.mQuickScaleEnabled && this.mGestureDetector == null) {
            this.mGestureDetector = new GestureDetector(this.mContext, new C08301(), this.mHandler);
        }
    }

    public boolean isQuickScaleEnabled() {
        return this.mQuickScaleEnabled;
    }

    public boolean isInProgress() {
        return this.mInProgress;
    }

    public float getFocusX() {
        return this.mFocusX;
    }

    public float getFocusY() {
        return this.mFocusY;
    }

    public float getCurrentSpan() {
        return this.mCurrSpan;
    }

    public float getCurrentSpanX() {
        return this.mCurrSpanX;
    }

    public float getCurrentSpanY() {
        return this.mCurrSpanY;
    }

    public float getPreviousSpan() {
        return this.mPrevSpan;
    }

    public float getPreviousSpanX() {
        return this.mPrevSpanX;
    }

    public float getPreviousSpanY() {
        return this.mPrevSpanY;
    }

    public float getScaleFactor() {
        if (inDoubleTapMode()) {
            boolean scaleUp = (this.mEventBeforeOrAboveStartingGestureEvent && this.mCurrSpan < this.mPrevSpan) || (!this.mEventBeforeOrAboveStartingGestureEvent && this.mCurrSpan > this.mPrevSpan);
            float spanDiff = Math.abs(LayoutParams.BRIGHTNESS_OVERRIDE_FULL - (this.mCurrSpan / this.mPrevSpan)) * SCALE_FACTOR;
            if (this.mPrevSpan <= 0.0f) {
                return LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
            }
            return scaleUp ? LayoutParams.BRIGHTNESS_OVERRIDE_FULL + spanDiff : LayoutParams.BRIGHTNESS_OVERRIDE_FULL - spanDiff;
        } else if (this.mPrevSpan > 0.0f) {
            return this.mCurrSpan / this.mPrevSpan;
        } else {
            return LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
        }
    }

    public long getTimeDelta() {
        return this.mCurrTime - this.mPrevTime;
    }

    public long getEventTime() {
        return this.mCurrTime;
    }
}
