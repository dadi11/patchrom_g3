package android.hardware.camera2.utils;

import android.graphics.Matrix;
import android.graphics.Rect;
import android.graphics.RectF;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureRequest.Key;
import android.util.Size;
import com.android.internal.util.Preconditions;

public class ParamsUtils {
    private static final int RATIONAL_DENOMINATOR = 1000000;

    public static Rect createRect(Size size) {
        Preconditions.checkNotNull(size, "size must not be null");
        return new Rect(0, 0, size.getWidth(), size.getHeight());
    }

    public static Rect createRect(RectF rect) {
        Preconditions.checkNotNull(rect, "rect must not be null");
        Rect r = new Rect();
        rect.roundOut(r);
        return r;
    }

    public static Rect mapRect(Matrix transform, Rect rect) {
        Preconditions.checkNotNull(transform, "transform must not be null");
        Preconditions.checkNotNull(rect, "rect must not be null");
        RectF rectF = new RectF(rect);
        transform.mapRect(rectF);
        return createRect(rectF);
    }

    public static Size createSize(Rect rect) {
        Preconditions.checkNotNull(rect, "rect must not be null");
        return new Size(rect.width(), rect.height());
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public static android.util.Rational createRational(float r4) {
        /*
        r3 = java.lang.Float.isNaN(r4);
        if (r3 == 0) goto L_0x0009;
    L_0x0006:
        r3 = android.util.Rational.NaN;
    L_0x0008:
        return r3;
    L_0x0009:
        r3 = 2139095040; // 0x7f800000 float:Infinity double:1.0568533725E-314;
        r3 = (r4 > r3 ? 1 : (r4 == r3 ? 0 : -1));
        if (r3 != 0) goto L_0x0012;
    L_0x000f:
        r3 = android.util.Rational.POSITIVE_INFINITY;
        goto L_0x0008;
    L_0x0012:
        r3 = -8388608; // 0xffffffffff800000 float:-Infinity double:NaN;
        r3 = (r4 > r3 ? 1 : (r4 == r3 ? 0 : -1));
        if (r3 != 0) goto L_0x001b;
    L_0x0018:
        r3 = android.util.Rational.NEGATIVE_INFINITY;
        goto L_0x0008;
    L_0x001b:
        r3 = 0;
        r3 = (r4 > r3 ? 1 : (r4 == r3 ? 0 : -1));
        if (r3 != 0) goto L_0x0023;
    L_0x0020:
        r3 = android.util.Rational.ZERO;
        goto L_0x0008;
    L_0x0023:
        r0 = 1000000; // 0xf4240 float:1.401298E-39 double:4.940656E-318;
    L_0x0026:
        r3 = (float) r0;
        r2 = r4 * r3;
        r3 = -822083584; // 0xffffffffcf000000 float:-2.14748365E9 double:NaN;
        r3 = (r2 > r3 ? 1 : (r2 == r3 ? 0 : -1));
        if (r3 <= 0) goto L_0x0035;
    L_0x002f:
        r3 = 1325400064; // 0x4f000000 float:2.14748365E9 double:6.548346386E-315;
        r3 = (r2 > r3 ? 1 : (r2 == r3 ? 0 : -1));
        if (r3 < 0) goto L_0x0038;
    L_0x0035:
        r3 = 1;
        if (r0 != r3) goto L_0x003f;
    L_0x0038:
        r1 = (int) r2;
        r3 = new android.util.Rational;
        r3.<init>(r1, r0);
        goto L_0x0008;
    L_0x003f:
        r0 = r0 / 10;
        goto L_0x0026;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.hardware.camera2.utils.ParamsUtils.createRational(float):android.util.Rational");
    }

    public static void convertRectF(Rect source, RectF destination) {
        Preconditions.checkNotNull(source, "source must not be null");
        Preconditions.checkNotNull(destination, "destination must not be null");
        destination.left = (float) source.left;
        destination.right = (float) source.right;
        destination.bottom = (float) source.bottom;
        destination.top = (float) source.top;
    }

    public static <T> T getOrDefault(CaptureRequest r, Key<T> key, T defaultValue) {
        Preconditions.checkNotNull(r, "r must not be null");
        Preconditions.checkNotNull(key, "key must not be null");
        Preconditions.checkNotNull(defaultValue, "defaultValue must not be null");
        T value = r.get(key);
        return value == null ? defaultValue : value;
    }

    private ParamsUtils() {
        throw new AssertionError();
    }
}
