package android.view;

import android.graphics.Outline;
import android.graphics.drawable.Drawable;

public abstract class ViewOutlineProvider {
    public static final ViewOutlineProvider BACKGROUND;
    public static final ViewOutlineProvider BOUNDS;
    public static final ViewOutlineProvider PADDED_BOUNDS;

    /* renamed from: android.view.ViewOutlineProvider.1 */
    static class C08591 extends ViewOutlineProvider {
        C08591() {
        }

        public void getOutline(View view, Outline outline) {
            Drawable background = view.getBackground();
            if (background != null) {
                background.getOutline(outline);
                return;
            }
            outline.setRect(0, 0, view.getWidth(), view.getHeight());
            outline.setAlpha(0.0f);
        }
    }

    /* renamed from: android.view.ViewOutlineProvider.2 */
    static class C08602 extends ViewOutlineProvider {
        C08602() {
        }

        public void getOutline(View view, Outline outline) {
            outline.setRect(0, 0, view.getWidth(), view.getHeight());
        }
    }

    /* renamed from: android.view.ViewOutlineProvider.3 */
    static class C08613 extends ViewOutlineProvider {
        C08613() {
        }

        public void getOutline(View view, Outline outline) {
            outline.setRect(view.getPaddingLeft(), view.getPaddingTop(), view.getWidth() - view.getPaddingRight(), view.getHeight() - view.getPaddingBottom());
        }
    }

    public abstract void getOutline(View view, Outline outline);

    static {
        BACKGROUND = new C08591();
        BOUNDS = new C08602();
        PADDED_BOUNDS = new C08613();
    }
}
