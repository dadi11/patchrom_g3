package android.text.method;

import android.text.Layout;
import android.text.Layout.Alignment;
import android.text.NoCopySpan;
import android.text.Spannable;
import android.widget.TextView;

public class Touch {

    private static class DragState implements NoCopySpan {
        public boolean mFarEnough;
        public boolean mIsActivelySelecting;
        public boolean mIsSelectionStarted;
        public int mScrollX;
        public int mScrollY;
        public boolean mUsed;
        public float mX;
        public float mY;

        public DragState(float x, float y, int scrollX, int scrollY) {
            this.mX = x;
            this.mY = y;
            this.mScrollX = scrollX;
            this.mScrollY = scrollY;
        }
    }

    private Touch() {
    }

    public static void scrollTo(TextView widget, Layout layout, int x, int y) {
        int left;
        int right;
        int availableWidth = widget.getWidth() - (widget.getTotalPaddingLeft() + widget.getTotalPaddingRight());
        int top = layout.getLineForVertical(y);
        Alignment a = layout.getParagraphAlignment(top);
        boolean ltr = layout.getParagraphDirection(top) > 0;
        if (widget.getHorizontallyScrolling()) {
            int bottom = layout.getLineForVertical((widget.getHeight() + y) - (widget.getTotalPaddingTop() + widget.getTotalPaddingBottom()));
            left = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
            right = 0;
            for (int i = top; i <= bottom; i++) {
                left = (int) Math.min((float) left, layout.getLineLeft(i));
                right = (int) Math.max((float) right, layout.getLineRight(i));
            }
        } else {
            left = 0;
            right = availableWidth;
        }
        int actualWidth = right - left;
        if (actualWidth >= availableWidth) {
            x = Math.max(Math.min(x, right - availableWidth), left);
        } else if (a == Alignment.ALIGN_CENTER) {
            x = left - ((availableWidth - actualWidth) / 2);
        } else if (!(ltr && a == Alignment.ALIGN_OPPOSITE) && ((ltr || a != Alignment.ALIGN_NORMAL) && a != Alignment.ALIGN_RIGHT)) {
            x = left;
        } else {
            x = left - (availableWidth - actualWidth);
        }
        widget.scrollTo(x, y);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public static boolean onTouchEvent(android.widget.TextView r22, android.text.Spannable r23, android.view.MotionEvent r24) {
        /*
        r17 = r24.getActionMasked();
        switch(r17) {
            case 0: goto L_0x000a;
            case 1: goto L_0x005f;
            case 2: goto L_0x00a2;
            default: goto L_0x0007;
        };
    L_0x0007:
        r17 = 0;
    L_0x0009:
        return r17;
    L_0x000a:
        r17 = 0;
        r18 = r23.length();
        r19 = android.text.method.Touch.DragState.class;
        r0 = r23;
        r1 = r17;
        r2 = r18;
        r3 = r19;
        r6 = r0.getSpans(r1, r2, r3);
        r6 = (android.text.method.Touch.DragState[]) r6;
        r9 = 0;
    L_0x0021:
        r0 = r6.length;
        r17 = r0;
        r0 = r17;
        if (r9 >= r0) goto L_0x0034;
    L_0x0028:
        r17 = r6[r9];
        r0 = r23;
        r1 = r17;
        r0.removeSpan(r1);
        r9 = r9 + 1;
        goto L_0x0021;
    L_0x0034:
        r17 = new android.text.method.Touch$DragState;
        r18 = r24.getX();
        r19 = r24.getY();
        r20 = r22.getScrollX();
        r21 = r22.getScrollY();
        r17.<init>(r18, r19, r20, r21);
        r18 = 0;
        r19 = 0;
        r20 = 17;
        r0 = r23;
        r1 = r17;
        r2 = r18;
        r3 = r19;
        r4 = r20;
        r0.setSpan(r1, r2, r3, r4);
        r17 = 1;
        goto L_0x0009;
    L_0x005f:
        r17 = 0;
        r18 = r23.length();
        r19 = android.text.method.Touch.DragState.class;
        r0 = r23;
        r1 = r17;
        r2 = r18;
        r3 = r19;
        r6 = r0.getSpans(r1, r2, r3);
        r6 = (android.text.method.Touch.DragState[]) r6;
        r9 = 0;
    L_0x0076:
        r0 = r6.length;
        r17 = r0;
        r0 = r17;
        if (r9 >= r0) goto L_0x0089;
    L_0x007d:
        r17 = r6[r9];
        r0 = r23;
        r1 = r17;
        r0.removeSpan(r1);
        r9 = r9 + 1;
        goto L_0x0076;
    L_0x0089:
        r0 = r6.length;
        r17 = r0;
        if (r17 <= 0) goto L_0x009e;
    L_0x008e:
        r17 = 0;
        r17 = r6[r17];
        r0 = r17;
        r0 = r0.mUsed;
        r17 = r0;
        if (r17 == 0) goto L_0x009e;
    L_0x009a:
        r17 = 1;
        goto L_0x0009;
    L_0x009e:
        r17 = 0;
        goto L_0x0009;
    L_0x00a2:
        r17 = 0;
        r18 = r23.length();
        r19 = android.text.method.Touch.DragState.class;
        r0 = r23;
        r1 = r17;
        r2 = r18;
        r3 = r19;
        r6 = r0.getSpans(r1, r2, r3);
        r6 = (android.text.method.Touch.DragState[]) r6;
        r0 = r6.length;
        r17 = r0;
        if (r17 <= 0) goto L_0x0007;
    L_0x00bd:
        r17 = 0;
        r17 = r6[r17];
        r18 = 0;
        r0 = r18;
        r1 = r17;
        r1.mIsSelectionStarted = r0;
        r17 = 0;
        r17 = r6[r17];
        r0 = r17;
        r0 = r0.mFarEnough;
        r17 = r0;
        if (r17 != 0) goto L_0x014b;
    L_0x00d5:
        r17 = r22.getContext();
        r17 = android.view.ViewConfiguration.get(r17);
        r16 = r17.getScaledTouchSlop();
        r17 = r24.getX();
        r18 = 0;
        r18 = r6[r18];
        r0 = r18;
        r0 = r0.mX;
        r18 = r0;
        r17 = r17 - r18;
        r17 = java.lang.Math.abs(r17);
        r0 = r16;
        r0 = (float) r0;
        r18 = r0;
        r17 = (r17 > r18 ? 1 : (r17 == r18 ? 0 : -1));
        if (r17 >= 0) goto L_0x011b;
    L_0x00fe:
        r17 = r24.getY();
        r18 = 0;
        r18 = r6[r18];
        r0 = r18;
        r0 = r0.mY;
        r18 = r0;
        r17 = r17 - r18;
        r17 = java.lang.Math.abs(r17);
        r0 = r16;
        r0 = (float) r0;
        r18 = r0;
        r17 = (r17 > r18 ? 1 : (r17 == r18 ? 0 : -1));
        if (r17 < 0) goto L_0x014b;
    L_0x011b:
        r17 = 0;
        r17 = r6[r17];
        r18 = 1;
        r0 = r18;
        r1 = r17;
        r1.mFarEnough = r0;
        r17 = 1;
        r0 = r24;
        r1 = r17;
        r17 = r0.isButtonPressed(r1);
        if (r17 == 0) goto L_0x014b;
    L_0x0133:
        r17 = 0;
        r17 = r6[r17];
        r18 = 1;
        r0 = r18;
        r1 = r17;
        r1.mIsActivelySelecting = r0;
        r17 = 0;
        r17 = r6[r17];
        r18 = 1;
        r0 = r18;
        r1 = r17;
        r1.mIsSelectionStarted = r0;
    L_0x014b:
        r17 = 0;
        r17 = r6[r17];
        r0 = r17;
        r0 = r0.mFarEnough;
        r17 = r0;
        if (r17 == 0) goto L_0x0007;
    L_0x0157:
        r17 = 0;
        r17 = r6[r17];
        r18 = 1;
        r0 = r18;
        r1 = r17;
        r1.mUsed = r0;
        r17 = r24.getMetaState();
        r17 = r17 & 1;
        if (r17 != 0) goto L_0x0189;
    L_0x016b:
        r17 = 1;
        r0 = r23;
        r1 = r17;
        r17 = android.text.method.MetaKeyKeyListener.getMetaState(r0, r1);
        r18 = 1;
        r0 = r17;
        r1 = r18;
        if (r0 == r1) goto L_0x0189;
    L_0x017d:
        r17 = 2048; // 0x800 float:2.87E-42 double:1.0118E-320;
        r0 = r23;
        r1 = r17;
        r17 = android.text.method.MetaKeyKeyListener.getMetaState(r0, r1);
        if (r17 == 0) goto L_0x0256;
    L_0x0189:
        r5 = 1;
    L_0x018a:
        r17 = 1;
        r0 = r24;
        r1 = r17;
        r17 = r0.isButtonPressed(r1);
        if (r17 != 0) goto L_0x01a2;
    L_0x0196:
        r17 = 0;
        r17 = r6[r17];
        r18 = 0;
        r0 = r18;
        r1 = r17;
        r1.mIsActivelySelecting = r0;
    L_0x01a2:
        if (r5 == 0) goto L_0x0259;
    L_0x01a4:
        r17 = 1;
        r0 = r24;
        r1 = r17;
        r17 = r0.isButtonPressed(r1);
        if (r17 == 0) goto L_0x0259;
    L_0x01b0:
        r17 = r24.getX();
        r18 = 0;
        r18 = r6[r18];
        r0 = r18;
        r0 = r0.mX;
        r18 = r0;
        r7 = r17 - r18;
        r17 = r24.getY();
        r18 = 0;
        r18 = r6[r18];
        r0 = r18;
        r0 = r0.mY;
        r18 = r0;
        r8 = r17 - r18;
    L_0x01d0:
        r17 = 0;
        r17 = r6[r17];
        r18 = r24.getX();
        r0 = r18;
        r1 = r17;
        r1.mX = r0;
        r17 = 0;
        r17 = r6[r17];
        r18 = r24.getY();
        r0 = r18;
        r1 = r17;
        r1.mY = r0;
        r17 = r22.getScrollX();
        r0 = (int) r7;
        r18 = r0;
        r11 = r17 + r18;
        r17 = r22.getScrollY();
        r0 = (int) r8;
        r18 = r0;
        r12 = r17 + r18;
        r17 = r22.getTotalPaddingTop();
        r18 = r22.getTotalPaddingBottom();
        r15 = r17 + r18;
        r10 = r22.getLayout();
        r17 = r10.getHeight();
        r18 = r22.getHeight();
        r18 = r18 - r15;
        r17 = r17 - r18;
        r0 = r17;
        r12 = java.lang.Math.min(r12, r0);
        r17 = 0;
        r0 = r17;
        r12 = java.lang.Math.max(r12, r0);
        r13 = r22.getScrollX();
        r14 = r22.getScrollY();
        r17 = 1;
        r0 = r24;
        r1 = r17;
        r17 = r0.isButtonPressed(r1);
        if (r17 != 0) goto L_0x023f;
    L_0x023a:
        r0 = r22;
        scrollTo(r0, r10, r11, r12);
    L_0x023f:
        r17 = r22.getScrollX();
        r0 = r17;
        if (r13 != r0) goto L_0x024f;
    L_0x0247:
        r17 = r22.getScrollY();
        r0 = r17;
        if (r14 == r0) goto L_0x0252;
    L_0x024f:
        r22.cancelLongPress();
    L_0x0252:
        r17 = 1;
        goto L_0x0009;
    L_0x0256:
        r5 = 0;
        goto L_0x018a;
    L_0x0259:
        r17 = 0;
        r17 = r6[r17];
        r0 = r17;
        r0 = r0.mX;
        r17 = r0;
        r18 = r24.getX();
        r7 = r17 - r18;
        r17 = 0;
        r17 = r6[r17];
        r0 = r17;
        r0 = r0.mY;
        r17 = r0;
        r18 = r24.getY();
        r8 = r17 - r18;
        goto L_0x01d0;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.text.method.Touch.onTouchEvent(android.widget.TextView, android.text.Spannable, android.view.MotionEvent):boolean");
    }

    public static int getInitialScrollX(TextView widget, Spannable buffer) {
        DragState[] ds = (DragState[]) buffer.getSpans(0, buffer.length(), DragState.class);
        return ds.length > 0 ? ds[0].mScrollX : -1;
    }

    public static int getInitialScrollY(TextView widget, Spannable buffer) {
        DragState[] ds = (DragState[]) buffer.getSpans(0, buffer.length(), DragState.class);
        return ds.length > 0 ? ds[0].mScrollY : -1;
    }

    static boolean isActivelySelecting(Spannable buffer) {
        DragState[] ds = (DragState[]) buffer.getSpans(0, buffer.length(), DragState.class);
        if (ds.length <= 0 || !ds[0].mIsActivelySelecting) {
            return false;
        }
        return true;
    }

    static boolean isSelectionStarted(Spannable buffer) {
        DragState[] ds = (DragState[]) buffer.getSpans(0, buffer.length(), DragState.class);
        if (ds.length <= 0 || !ds[0].mIsSelectionStarted) {
            return false;
        }
        return true;
    }
}
