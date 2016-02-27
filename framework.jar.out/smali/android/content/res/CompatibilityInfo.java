package android.content.res;

import android.content.pm.ApplicationInfo;
import android.graphics.Canvas;
import android.graphics.PointF;
import android.graphics.Rect;
import android.graphics.Region;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.DisplayMetrics;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.EditorInfo;

public class CompatibilityInfo implements Parcelable {
    private static final int ALWAYS_NEEDS_COMPAT = 2;
    public static final Creator<CompatibilityInfo> CREATOR;
    public static final CompatibilityInfo DEFAULT_COMPATIBILITY_INFO;
    public static final int DEFAULT_NORMAL_SHORT_DIMENSION = 320;
    public static final float MAXIMUM_ASPECT_RATIO = 1.7791667f;
    private static final int NEEDS_SCREEN_COMPAT = 8;
    private static final int NEVER_NEEDS_COMPAT = 4;
    private static final int SCALING_REQUIRED = 1;
    public final int applicationDensity;
    public final float applicationInvertedScale;
    public final float applicationScale;
    private final int mCompatibilityFlags;

    /* renamed from: android.content.res.CompatibilityInfo.1 */
    static class C01521 extends CompatibilityInfo {
        C01521() {
            super();
        }
    }

    /* renamed from: android.content.res.CompatibilityInfo.2 */
    static class C01532 implements Creator<CompatibilityInfo> {
        C01532() {
        }

        public CompatibilityInfo createFromParcel(Parcel source) {
            return new CompatibilityInfo(null);
        }

        public CompatibilityInfo[] newArray(int size) {
            return new CompatibilityInfo[size];
        }
    }

    public class Translator {
        public final float applicationInvertedScale;
        public final float applicationScale;
        private Rect mContentInsetsBuffer;
        private Region mTouchableAreaBuffer;
        private Rect mVisibleInsetsBuffer;

        Translator(float applicationScale, float applicationInvertedScale) {
            this.mContentInsetsBuffer = null;
            this.mVisibleInsetsBuffer = null;
            this.mTouchableAreaBuffer = null;
            this.applicationScale = applicationScale;
            this.applicationInvertedScale = applicationInvertedScale;
        }

        Translator(CompatibilityInfo compatibilityInfo) {
            this(compatibilityInfo.applicationScale, compatibilityInfo.applicationInvertedScale);
        }

        public void translateRectInScreenToAppWinFrame(Rect rect) {
            rect.scale(this.applicationInvertedScale);
        }

        public void translateRegionInWindowToScreen(Region transparentRegion) {
            transparentRegion.scale(this.applicationScale);
        }

        public void translateCanvas(Canvas canvas) {
            if (this.applicationScale == 1.5f) {
                canvas.translate(0.0026143792f, 0.0026143792f);
            }
            canvas.scale(this.applicationScale, this.applicationScale);
        }

        public void translateEventInScreenToAppWindow(MotionEvent event) {
            event.scale(this.applicationInvertedScale);
        }

        public void translateWindowLayout(LayoutParams params) {
            params.scale(this.applicationScale);
        }

        public void translateRectInAppWindowToScreen(Rect rect) {
            rect.scale(this.applicationScale);
        }

        public void translateRectInScreenToAppWindow(Rect rect) {
            rect.scale(this.applicationInvertedScale);
        }

        public void translatePointInScreenToAppWindow(PointF point) {
            float scale = this.applicationInvertedScale;
            if (scale != LayoutParams.BRIGHTNESS_OVERRIDE_FULL) {
                point.f15x *= scale;
                point.f16y *= scale;
            }
        }

        public void translateLayoutParamsInAppWindowToScreen(LayoutParams params) {
            params.scale(this.applicationScale);
        }

        public Rect getTranslatedContentInsets(Rect contentInsets) {
            if (this.mContentInsetsBuffer == null) {
                this.mContentInsetsBuffer = new Rect();
            }
            this.mContentInsetsBuffer.set(contentInsets);
            translateRectInAppWindowToScreen(this.mContentInsetsBuffer);
            return this.mContentInsetsBuffer;
        }

        public Rect getTranslatedVisibleInsets(Rect visibleInsets) {
            if (this.mVisibleInsetsBuffer == null) {
                this.mVisibleInsetsBuffer = new Rect();
            }
            this.mVisibleInsetsBuffer.set(visibleInsets);
            translateRectInAppWindowToScreen(this.mVisibleInsetsBuffer);
            return this.mVisibleInsetsBuffer;
        }

        public Region getTranslatedTouchableArea(Region touchableArea) {
            if (this.mTouchableAreaBuffer == null) {
                this.mTouchableAreaBuffer = new Region();
            }
            this.mTouchableAreaBuffer.set(touchableArea);
            this.mTouchableAreaBuffer.scale(this.applicationScale);
            return this.mTouchableAreaBuffer;
        }
    }

    static {
        DEFAULT_COMPATIBILITY_INFO = new C01521();
        CREATOR = new C01532();
    }

    public CompatibilityInfo(ApplicationInfo appInfo, int screenLayout, int sw, boolean forceCompat) {
        int compatFlags = 0;
        if (appInfo.requiresSmallestWidthDp == 0 && appInfo.compatibleWidthLimitDp == 0 && appInfo.largestWidthLimitDp == 0) {
            int sizeInfo = 0;
            boolean anyResizeable = false;
            if ((appInfo.flags & AccessibilityNodeInfo.ACTION_PREVIOUS_HTML_ELEMENT) != 0) {
                sizeInfo = 0 | NEEDS_SCREEN_COMPAT;
                anyResizeable = true;
                if (!forceCompat) {
                    sizeInfo |= 34;
                }
            }
            if ((appInfo.flags & AccessibilityNodeInfo.ACTION_COLLAPSE) != 0) {
                anyResizeable = true;
                if (!forceCompat) {
                    sizeInfo |= 34;
                }
            }
            if ((appInfo.flags & AccessibilityNodeInfo.ACTION_SCROLL_FORWARD) != 0) {
                anyResizeable = true;
                sizeInfo |= ALWAYS_NEEDS_COMPAT;
            }
            if (forceCompat) {
                sizeInfo &= -3;
            }
            compatFlags = 0 | NEEDS_SCREEN_COMPAT;
            switch (screenLayout & 15) {
                case SetDrawableParameters.TAG /*3*/:
                    if ((sizeInfo & NEEDS_SCREEN_COMPAT) != 0) {
                        compatFlags &= -9;
                    }
                    if ((appInfo.flags & AccessibilityNodeInfo.ACTION_PREVIOUS_HTML_ELEMENT) != 0) {
                        compatFlags |= NEVER_NEEDS_COMPAT;
                        break;
                    }
                    break;
                case NEVER_NEEDS_COMPAT /*4*/:
                    if ((sizeInfo & 32) != 0) {
                        compatFlags &= -9;
                    }
                    if ((appInfo.flags & AccessibilityNodeInfo.ACTION_COLLAPSE) != 0) {
                        compatFlags |= NEVER_NEEDS_COMPAT;
                        break;
                    }
                    break;
            }
            if ((EditorInfo.IME_FLAG_NO_EXTRACT_UI & screenLayout) == 0) {
                compatFlags = (compatFlags & -9) | NEVER_NEEDS_COMPAT;
            } else if ((sizeInfo & ALWAYS_NEEDS_COMPAT) != 0) {
                compatFlags &= -9;
            } else if (!anyResizeable) {
                compatFlags |= ALWAYS_NEEDS_COMPAT;
            }
            if ((appInfo.flags & AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD) != 0) {
                this.applicationDensity = DisplayMetrics.DENSITY_DEVICE;
                this.applicationScale = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
                this.applicationInvertedScale = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
            } else {
                this.applicationDensity = KeyEvent.KEYCODE_NUMPAD_ENTER;
                this.applicationScale = ((float) DisplayMetrics.DENSITY_DEVICE) / 160.0f;
                this.applicationInvertedScale = LayoutParams.BRIGHTNESS_OVERRIDE_FULL / this.applicationScale;
                compatFlags |= SCALING_REQUIRED;
            }
        } else {
            int compat;
            int required = appInfo.requiresSmallestWidthDp != 0 ? appInfo.requiresSmallestWidthDp : appInfo.compatibleWidthLimitDp;
            if (required == 0) {
                required = appInfo.largestWidthLimitDp;
            }
            if (appInfo.compatibleWidthLimitDp != 0) {
                compat = appInfo.compatibleWidthLimitDp;
            } else {
                compat = required;
            }
            if (compat < required) {
                compat = required;
            }
            int largest = appInfo.largestWidthLimitDp;
            if (required > DEFAULT_NORMAL_SHORT_DIMENSION) {
                compatFlags = 0 | NEVER_NEEDS_COMPAT;
            } else if (largest != 0 && sw > largest) {
                compatFlags = 0 | 10;
            } else if (compat >= sw) {
                compatFlags = 0 | NEVER_NEEDS_COMPAT;
            } else if (forceCompat) {
                compatFlags = 0 | NEEDS_SCREEN_COMPAT;
            }
            this.applicationDensity = DisplayMetrics.DENSITY_DEVICE;
            this.applicationScale = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
            this.applicationInvertedScale = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
        }
        this.mCompatibilityFlags = compatFlags;
    }

    private CompatibilityInfo(int compFlags, int dens, float scale, float invertedScale) {
        this.mCompatibilityFlags = compFlags;
        this.applicationDensity = dens;
        this.applicationScale = scale;
        this.applicationInvertedScale = invertedScale;
    }

    private CompatibilityInfo() {
        this((int) NEVER_NEEDS_COMPAT, DisplayMetrics.DENSITY_DEVICE, (float) LayoutParams.BRIGHTNESS_OVERRIDE_FULL, (float) LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
    }

    public boolean isScalingRequired() {
        return (this.mCompatibilityFlags & SCALING_REQUIRED) != 0;
    }

    public boolean supportsScreen() {
        return (this.mCompatibilityFlags & NEEDS_SCREEN_COMPAT) == 0;
    }

    public boolean neverSupportsScreen() {
        return (this.mCompatibilityFlags & ALWAYS_NEEDS_COMPAT) != 0;
    }

    public boolean alwaysSupportsScreen() {
        return (this.mCompatibilityFlags & NEVER_NEEDS_COMPAT) != 0;
    }

    public Translator getTranslator() {
        return isScalingRequired() ? new Translator(this) : null;
    }

    public void applyToDisplayMetrics(DisplayMetrics inoutDm) {
        if (supportsScreen()) {
            inoutDm.widthPixels = inoutDm.noncompatWidthPixels;
            inoutDm.heightPixels = inoutDm.noncompatHeightPixels;
        } else {
            computeCompatibleScaling(inoutDm, inoutDm);
        }
        if (isScalingRequired()) {
            float invertedRatio = this.applicationInvertedScale;
            inoutDm.density = inoutDm.noncompatDensity * invertedRatio;
            inoutDm.densityDpi = (int) ((((float) inoutDm.noncompatDensityDpi) * invertedRatio) + 0.5f);
            inoutDm.scaledDensity = inoutDm.noncompatScaledDensity * invertedRatio;
            inoutDm.xdpi = inoutDm.noncompatXdpi * invertedRatio;
            inoutDm.ydpi = inoutDm.noncompatYdpi * invertedRatio;
            inoutDm.widthPixels = (int) ((((float) inoutDm.widthPixels) * invertedRatio) + 0.5f);
            inoutDm.heightPixels = (int) ((((float) inoutDm.heightPixels) * invertedRatio) + 0.5f);
        }
    }

    public void applyToConfiguration(int displayDensity, Configuration inoutConfig) {
        if (!supportsScreen()) {
            inoutConfig.screenLayout = (inoutConfig.screenLayout & -16) | ALWAYS_NEEDS_COMPAT;
            inoutConfig.screenWidthDp = inoutConfig.compatScreenWidthDp;
            inoutConfig.screenHeightDp = inoutConfig.compatScreenHeightDp;
            inoutConfig.smallestScreenWidthDp = inoutConfig.compatSmallestScreenWidthDp;
        }
        inoutConfig.densityDpi = displayDensity;
        if (isScalingRequired()) {
            inoutConfig.densityDpi = (int) ((((float) inoutConfig.densityDpi) * this.applicationInvertedScale) + 0.5f);
        }
    }

    public static float computeCompatibleScaling(DisplayMetrics dm, DisplayMetrics outDm) {
        int shortSize;
        int longSize;
        int newWidth;
        int newHeight;
        float scale;
        int width = dm.noncompatWidthPixels;
        int height = dm.noncompatHeightPixels;
        if (width < height) {
            shortSize = width;
            longSize = height;
        } else {
            shortSize = height;
            longSize = width;
        }
        int newShortSize = (int) ((320.0f * dm.density) + 0.5f);
        float aspect = ((float) longSize) / ((float) shortSize);
        if (aspect > MAXIMUM_ASPECT_RATIO) {
            aspect = MAXIMUM_ASPECT_RATIO;
        }
        int newLongSize = (int) ((((float) newShortSize) * aspect) + 0.5f);
        if (width < height) {
            newWidth = newShortSize;
            newHeight = newLongSize;
        } else {
            newWidth = newLongSize;
            newHeight = newShortSize;
        }
        float sw = ((float) width) / ((float) newWidth);
        float sh = ((float) height) / ((float) newHeight);
        if (sw < sh) {
            scale = sw;
        } else {
            scale = sh;
        }
        if (scale < LayoutParams.BRIGHTNESS_OVERRIDE_FULL) {
            scale = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
        }
        if (outDm != null) {
            outDm.widthPixels = newWidth;
            outDm.heightPixels = newHeight;
        }
        return scale;
    }

    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        try {
            CompatibilityInfo oc = (CompatibilityInfo) o;
            if (this.mCompatibilityFlags != oc.mCompatibilityFlags) {
                return false;
            }
            if (this.applicationDensity != oc.applicationDensity) {
                return false;
            }
            if (this.applicationScale != oc.applicationScale) {
                return false;
            }
            if (this.applicationInvertedScale != oc.applicationInvertedScale) {
                return false;
            }
            return true;
        } catch (ClassCastException e) {
            return false;
        }
    }

    public String toString() {
        StringBuilder sb = new StringBuilder(AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
        sb.append("{");
        sb.append(this.applicationDensity);
        sb.append("dpi");
        if (isScalingRequired()) {
            sb.append(" ");
            sb.append(this.applicationScale);
            sb.append("x");
        }
        if (!supportsScreen()) {
            sb.append(" resizing");
        }
        if (neverSupportsScreen()) {
            sb.append(" never-compat");
        }
        if (alwaysSupportsScreen()) {
            sb.append(" always-compat");
        }
        sb.append("}");
        return sb.toString();
    }

    public int hashCode() {
        return ((((((this.mCompatibilityFlags + 527) * 31) + this.applicationDensity) * 31) + Float.floatToIntBits(this.applicationScale)) * 31) + Float.floatToIntBits(this.applicationInvertedScale);
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mCompatibilityFlags);
        dest.writeInt(this.applicationDensity);
        dest.writeFloat(this.applicationScale);
        dest.writeFloat(this.applicationInvertedScale);
    }

    private CompatibilityInfo(Parcel source) {
        this.mCompatibilityFlags = source.readInt();
        this.applicationDensity = source.readInt();
        this.applicationScale = source.readFloat();
        this.applicationInvertedScale = source.readFloat();
    }
}
