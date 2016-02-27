package android.view.accessibility;

import android.content.ContentResolver;
import android.content.Context;
import android.database.ContentObserver;
import android.graphics.Color;
import android.graphics.Typeface;
import android.net.Uri;
import android.os.Handler;
import android.provider.Settings.Secure;
import android.text.Spanned;
import android.text.TextUtils;
import android.view.InputDevice;
import android.widget.Toast;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Locale;

public class CaptioningManager {
    private static final int DEFAULT_ENABLED = 0;
    private static final float DEFAULT_FONT_SCALE = 1.0f;
    private static final int DEFAULT_PRESET = 0;
    private final ContentObserver mContentObserver;
    private final ContentResolver mContentResolver;
    private final Handler mHandler;
    private final ArrayList<CaptioningChangeListener> mListeners;
    private final Runnable mStyleChangedRunnable;

    public static abstract class CaptioningChangeListener {
        public void onEnabledChanged(boolean enabled) {
        }

        public void onUserStyleChanged(CaptionStyle userStyle) {
        }

        public void onLocaleChanged(Locale locale) {
        }

        public void onFontScaleChanged(float fontScale) {
        }
    }

    /* renamed from: android.view.accessibility.CaptioningManager.1 */
    class C08841 extends ContentObserver {
        C08841(Handler x0) {
            super(x0);
        }

        public void onChange(boolean selfChange, Uri uri) {
            String uriPath = uri.getPath();
            String name = uriPath.substring(uriPath.lastIndexOf(47) + 1);
            if ("accessibility_captioning_enabled".equals(name)) {
                CaptioningManager.this.notifyEnabledChanged();
            } else if ("accessibility_captioning_locale".equals(name)) {
                CaptioningManager.this.notifyLocaleChanged();
            } else if ("accessibility_captioning_font_scale".equals(name)) {
                CaptioningManager.this.notifyFontScaleChanged();
            } else {
                CaptioningManager.this.mHandler.removeCallbacks(CaptioningManager.this.mStyleChangedRunnable);
                CaptioningManager.this.mHandler.post(CaptioningManager.this.mStyleChangedRunnable);
            }
        }
    }

    /* renamed from: android.view.accessibility.CaptioningManager.2 */
    class C08852 implements Runnable {
        C08852() {
        }

        public void run() {
            CaptioningManager.this.notifyUserStyleChanged();
        }
    }

    public static final class CaptionStyle {
        private static final CaptionStyle BLACK_ON_WHITE;
        private static final int COLOR_NONE_OPAQUE = 255;
        private static final int COLOR_UNSPECIFIED = 511;
        public static final CaptionStyle DEFAULT;
        private static final CaptionStyle DEFAULT_CUSTOM;
        public static final int EDGE_TYPE_DEPRESSED = 4;
        public static final int EDGE_TYPE_DROP_SHADOW = 2;
        public static final int EDGE_TYPE_NONE = 0;
        public static final int EDGE_TYPE_OUTLINE = 1;
        public static final int EDGE_TYPE_RAISED = 3;
        public static final int EDGE_TYPE_UNSPECIFIED = -1;
        public static final CaptionStyle[] PRESETS;
        public static final int PRESET_CUSTOM = -1;
        private static final CaptionStyle UNSPECIFIED;
        private static final CaptionStyle WHITE_ON_BLACK;
        private static final CaptionStyle YELLOW_ON_BLACK;
        private static final CaptionStyle YELLOW_ON_BLUE;
        public final int backgroundColor;
        public final int edgeColor;
        public final int edgeType;
        public final int foregroundColor;
        private final boolean mHasBackgroundColor;
        private final boolean mHasEdgeColor;
        private final boolean mHasEdgeType;
        private final boolean mHasForegroundColor;
        private final boolean mHasWindowColor;
        private Typeface mParsedTypeface;
        public final String mRawTypeface;
        public final int windowColor;

        private CaptionStyle(int foregroundColor, int backgroundColor, int edgeType, int edgeColor, int windowColor, String rawTypeface) {
            boolean z;
            boolean z2 = true;
            if (foregroundColor != COLOR_UNSPECIFIED) {
                z = true;
            } else {
                z = false;
            }
            this.mHasForegroundColor = z;
            if (backgroundColor != COLOR_UNSPECIFIED) {
                z = true;
            } else {
                z = false;
            }
            this.mHasBackgroundColor = z;
            if (edgeType != PRESET_CUSTOM) {
                z = true;
            } else {
                z = false;
            }
            this.mHasEdgeType = z;
            if (edgeColor != COLOR_UNSPECIFIED) {
                z = true;
            } else {
                z = false;
            }
            this.mHasEdgeColor = z;
            if (windowColor == COLOR_UNSPECIFIED) {
                z2 = false;
            }
            this.mHasWindowColor = z2;
            if (!this.mHasForegroundColor) {
                foregroundColor = PRESET_CUSTOM;
            }
            this.foregroundColor = foregroundColor;
            if (!this.mHasBackgroundColor) {
                backgroundColor = Spanned.SPAN_USER;
            }
            this.backgroundColor = backgroundColor;
            if (!this.mHasEdgeType) {
                edgeType = EDGE_TYPE_NONE;
            }
            this.edgeType = edgeType;
            if (!this.mHasEdgeColor) {
                edgeColor = Spanned.SPAN_USER;
            }
            this.edgeColor = edgeColor;
            if (!this.mHasWindowColor) {
                windowColor = COLOR_NONE_OPAQUE;
            }
            this.windowColor = windowColor;
            this.mRawTypeface = rawTypeface;
        }

        public CaptionStyle applyStyle(CaptionStyle overlay) {
            return new CaptionStyle(overlay.hasForegroundColor() ? overlay.foregroundColor : this.foregroundColor, overlay.hasBackgroundColor() ? overlay.backgroundColor : this.backgroundColor, overlay.hasEdgeType() ? overlay.edgeType : this.edgeType, overlay.hasEdgeColor() ? overlay.edgeColor : this.edgeColor, overlay.hasWindowColor() ? overlay.windowColor : this.windowColor, overlay.mRawTypeface != null ? overlay.mRawTypeface : this.mRawTypeface);
        }

        public boolean hasBackgroundColor() {
            return this.mHasBackgroundColor;
        }

        public boolean hasForegroundColor() {
            return this.mHasForegroundColor;
        }

        public boolean hasEdgeType() {
            return this.mHasEdgeType;
        }

        public boolean hasEdgeColor() {
            return this.mHasEdgeColor;
        }

        public boolean hasWindowColor() {
            return this.mHasWindowColor;
        }

        public Typeface getTypeface() {
            if (this.mParsedTypeface == null && !TextUtils.isEmpty(this.mRawTypeface)) {
                this.mParsedTypeface = Typeface.create(this.mRawTypeface, (int) EDGE_TYPE_NONE);
            }
            return this.mParsedTypeface;
        }

        public static CaptionStyle getCustomStyle(ContentResolver cr) {
            CaptionStyle defStyle = DEFAULT_CUSTOM;
            int foregroundColor = Secure.getInt(cr, "accessibility_captioning_foreground_color", defStyle.foregroundColor);
            int backgroundColor = Secure.getInt(cr, "accessibility_captioning_background_color", defStyle.backgroundColor);
            int edgeType = Secure.getInt(cr, "accessibility_captioning_edge_type", defStyle.edgeType);
            int edgeColor = Secure.getInt(cr, "accessibility_captioning_edge_color", defStyle.edgeColor);
            int windowColor = Secure.getInt(cr, "accessibility_captioning_window_color", defStyle.windowColor);
            String rawTypeface = Secure.getString(cr, "accessibility_captioning_typeface");
            if (rawTypeface == null) {
                rawTypeface = defStyle.mRawTypeface;
            }
            return new CaptionStyle(foregroundColor, backgroundColor, edgeType, edgeColor, windowColor, rawTypeface);
        }

        static {
            WHITE_ON_BLACK = new CaptionStyle(PRESET_CUSTOM, Spanned.SPAN_USER, EDGE_TYPE_NONE, Spanned.SPAN_USER, COLOR_NONE_OPAQUE, null);
            BLACK_ON_WHITE = new CaptionStyle(Spanned.SPAN_USER, PRESET_CUSTOM, EDGE_TYPE_NONE, Spanned.SPAN_USER, COLOR_NONE_OPAQUE, null);
            YELLOW_ON_BLACK = new CaptionStyle(InputDevice.SOURCE_ANY, Spanned.SPAN_USER, EDGE_TYPE_NONE, Spanned.SPAN_USER, COLOR_NONE_OPAQUE, null);
            YELLOW_ON_BLUE = new CaptionStyle(InputDevice.SOURCE_ANY, Color.BLUE, EDGE_TYPE_NONE, Spanned.SPAN_USER, COLOR_NONE_OPAQUE, null);
            UNSPECIFIED = new CaptionStyle(COLOR_UNSPECIFIED, COLOR_UNSPECIFIED, PRESET_CUSTOM, COLOR_UNSPECIFIED, COLOR_UNSPECIFIED, null);
            PRESETS = new CaptionStyle[]{WHITE_ON_BLACK, BLACK_ON_WHITE, YELLOW_ON_BLACK, YELLOW_ON_BLUE, UNSPECIFIED};
            DEFAULT_CUSTOM = WHITE_ON_BLACK;
            DEFAULT = WHITE_ON_BLACK;
        }
    }

    public CaptioningManager(Context context) {
        this.mListeners = new ArrayList();
        this.mHandler = new Handler();
        this.mContentObserver = new C08841(this.mHandler);
        this.mStyleChangedRunnable = new C08852();
        this.mContentResolver = context.getContentResolver();
    }

    public final boolean isEnabled() {
        return Secure.getInt(this.mContentResolver, "accessibility_captioning_enabled", DEFAULT_ENABLED) == 1;
    }

    public final String getRawLocale() {
        return Secure.getString(this.mContentResolver, "accessibility_captioning_locale");
    }

    public final Locale getLocale() {
        String rawLocale = getRawLocale();
        if (!TextUtils.isEmpty(rawLocale)) {
            String[] splitLocale = rawLocale.split("_");
            switch (splitLocale.length) {
                case Toast.LENGTH_LONG /*1*/:
                    return new Locale(splitLocale[DEFAULT_ENABLED]);
                case Action.MERGE_IGNORE /*2*/:
                    return new Locale(splitLocale[DEFAULT_ENABLED], splitLocale[1]);
                case SetDrawableParameters.TAG /*3*/:
                    return new Locale(splitLocale[DEFAULT_ENABLED], splitLocale[1], splitLocale[2]);
            }
        }
        return null;
    }

    public final float getFontScale() {
        return Secure.getFloat(this.mContentResolver, "accessibility_captioning_font_scale", DEFAULT_FONT_SCALE);
    }

    public int getRawUserStyle() {
        return Secure.getInt(this.mContentResolver, "accessibility_captioning_preset", DEFAULT_ENABLED);
    }

    public CaptionStyle getUserStyle() {
        int preset = getRawUserStyle();
        if (preset == -1) {
            return CaptionStyle.getCustomStyle(this.mContentResolver);
        }
        return CaptionStyle.PRESETS[preset];
    }

    public void addCaptioningChangeListener(CaptioningChangeListener listener) {
        synchronized (this.mListeners) {
            if (this.mListeners.isEmpty()) {
                registerObserver("accessibility_captioning_enabled");
                registerObserver("accessibility_captioning_foreground_color");
                registerObserver("accessibility_captioning_background_color");
                registerObserver("accessibility_captioning_window_color");
                registerObserver("accessibility_captioning_edge_type");
                registerObserver("accessibility_captioning_edge_color");
                registerObserver("accessibility_captioning_typeface");
                registerObserver("accessibility_captioning_font_scale");
                registerObserver("accessibility_captioning_locale");
                registerObserver("accessibility_captioning_preset");
            }
            this.mListeners.add(listener);
        }
    }

    private void registerObserver(String key) {
        this.mContentResolver.registerContentObserver(Secure.getUriFor(key), false, this.mContentObserver);
    }

    public void removeCaptioningChangeListener(CaptioningChangeListener listener) {
        synchronized (this.mListeners) {
            this.mListeners.remove(listener);
            if (this.mListeners.isEmpty()) {
                this.mContentResolver.unregisterContentObserver(this.mContentObserver);
            }
        }
    }

    private void notifyEnabledChanged() {
        boolean enabled = isEnabled();
        synchronized (this.mListeners) {
            Iterator i$ = this.mListeners.iterator();
            while (i$.hasNext()) {
                ((CaptioningChangeListener) i$.next()).onEnabledChanged(enabled);
            }
        }
    }

    private void notifyUserStyleChanged() {
        CaptionStyle userStyle = getUserStyle();
        synchronized (this.mListeners) {
            Iterator i$ = this.mListeners.iterator();
            while (i$.hasNext()) {
                ((CaptioningChangeListener) i$.next()).onUserStyleChanged(userStyle);
            }
        }
    }

    private void notifyLocaleChanged() {
        Locale locale = getLocale();
        synchronized (this.mListeners) {
            Iterator i$ = this.mListeners.iterator();
            while (i$.hasNext()) {
                ((CaptioningChangeListener) i$.next()).onLocaleChanged(locale);
            }
        }
    }

    private void notifyFontScaleChanged() {
        float fontScale = getFontScale();
        synchronized (this.mListeners) {
            Iterator i$ = this.mListeners.iterator();
            while (i$.hasNext()) {
                ((CaptioningChangeListener) i$.next()).onFontScaleChanged(fontScale);
            }
        }
    }
}
