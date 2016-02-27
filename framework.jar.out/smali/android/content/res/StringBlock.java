package android.content.res;

import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.FontMetricsInt;
import android.graphics.Rect;
import android.hardware.SensorManager;
import android.service.notification.ZenModeConfig;
import android.telephony.SubscriptionManager;
import android.text.Annotation;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.SpannedString;
import android.text.TextPaint;
import android.text.TextUtils;
import android.text.TextUtils.TruncateAt;
import android.text.style.AbsoluteSizeSpan;
import android.text.style.BackgroundColorSpan;
import android.text.style.BulletSpan;
import android.text.style.CharacterStyle;
import android.text.style.ForegroundColorSpan;
import android.text.style.LineHeightSpan.WithDensity;
import android.text.style.RelativeSizeSpan;
import android.text.style.StrikethroughSpan;
import android.text.style.StyleSpan;
import android.text.style.SubscriptSpan;
import android.text.style.SuperscriptSpan;
import android.text.style.TextAppearanceSpan;
import android.text.style.TypefaceSpan;
import android.text.style.URLSpan;
import android.text.style.UnderlineSpan;
import android.util.SparseArray;
import android.view.KeyEvent;

final class StringBlock {
    private static final String TAG = "AssetManager";
    private static final boolean localLOGV = false;
    private final long mNative;
    private final boolean mOwnsNative;
    private SparseArray<CharSequence> mSparseStrings;
    private CharSequence[] mStrings;
    StyleIDs mStyleIDs;
    private final boolean mUseSparse;

    private static class Height implements WithDensity {
        private static float sProportion;
        private int mSize;

        static {
            sProportion = 0.0f;
        }

        public Height(int size) {
            this.mSize = size;
        }

        public void chooseHeight(CharSequence text, int start, int end, int spanstartv, int v, FontMetricsInt fm) {
            chooseHeight(text, start, end, spanstartv, v, fm, null);
        }

        public void chooseHeight(CharSequence text, int start, int end, int spanstartv, int v, FontMetricsInt fm, TextPaint paint) {
            int size = this.mSize;
            if (paint != null) {
                size = (int) (((float) size) * paint.density);
            }
            if (fm.bottom - fm.top < size) {
                fm.top = fm.bottom - size;
                fm.ascent -= size;
                return;
            }
            if (sProportion == 0.0f) {
                Paint p = new Paint();
                p.setTextSize(SensorManager.LIGHT_CLOUDY);
                Rect r = new Rect();
                p.getTextBounds("ABCDEFG", 0, 7, r);
                sProportion = ((float) r.top) / p.ascent();
            }
            int need = (int) Math.ceil((double) (((float) (-fm.top)) * sProportion));
            if (size - fm.descent >= need) {
                fm.top = fm.bottom - size;
                fm.ascent = fm.descent - size;
            } else if (size >= need) {
                r4 = -need;
                fm.ascent = r4;
                fm.top = r4;
                r4 = fm.top + size;
                fm.descent = r4;
                fm.bottom = r4;
            } else {
                r4 = -size;
                fm.ascent = r4;
                fm.top = r4;
                fm.descent = 0;
                fm.bottom = 0;
            }
        }
    }

    static final class StyleIDs {
        private int bigId;
        private int boldId;
        private int italicId;
        private int listItemId;
        private int marqueeId;
        private int smallId;
        private int strikeId;
        private int subId;
        private int supId;
        private int ttId;
        private int underlineId;

        StyleIDs() {
            this.boldId = -1;
            this.italicId = -1;
            this.underlineId = -1;
            this.ttId = -1;
            this.bigId = -1;
            this.smallId = -1;
            this.subId = -1;
            this.supId = -1;
            this.strikeId = -1;
            this.listItemId = -1;
            this.marqueeId = -1;
        }
    }

    private static native long nativeCreate(byte[] bArr, int i, int i2);

    private static native void nativeDestroy(long j);

    private static native int nativeGetSize(long j);

    private static native String nativeGetString(long j, int i);

    private static native int[] nativeGetStyle(long j, int i);

    public StringBlock(byte[] data, boolean useSparse) {
        this.mStyleIDs = null;
        this.mNative = nativeCreate(data, 0, data.length);
        this.mUseSparse = useSparse;
        this.mOwnsNative = true;
    }

    public StringBlock(byte[] data, int offset, int size, boolean useSparse) {
        this.mStyleIDs = null;
        this.mNative = nativeCreate(data, offset, size);
        this.mUseSparse = useSparse;
        this.mOwnsNative = true;
    }

    public CharSequence get(int idx) {
        CharSequence res;
        synchronized (this) {
            String str;
            int[] style;
            int styleIndex;
            int styleId;
            String styleTag;
            if (this.mStrings != null) {
                res = this.mStrings[idx];
                if (res != null) {
                }
                str = nativeGetString(this.mNative, idx);
                res = str;
                style = nativeGetStyle(this.mNative, idx);
                if (style != null) {
                    if (this.mStyleIDs == null) {
                        this.mStyleIDs = new StyleIDs();
                    }
                    for (styleIndex = 0; styleIndex < style.length; styleIndex += 3) {
                        styleId = style[styleIndex];
                        if (!(styleId == this.mStyleIDs.boldId || styleId == this.mStyleIDs.italicId || styleId == this.mStyleIDs.underlineId || styleId == this.mStyleIDs.ttId || styleId == this.mStyleIDs.bigId || styleId == this.mStyleIDs.smallId || styleId == this.mStyleIDs.subId || styleId == this.mStyleIDs.supId || styleId == this.mStyleIDs.strikeId || styleId == this.mStyleIDs.listItemId || styleId == this.mStyleIDs.marqueeId)) {
                            styleTag = nativeGetString(this.mNative, styleId);
                            if (styleTag.equals("b")) {
                                this.mStyleIDs.boldId = styleId;
                            } else if (styleTag.equals("i")) {
                                this.mStyleIDs.italicId = styleId;
                            } else if (styleTag.equals("u")) {
                                this.mStyleIDs.underlineId = styleId;
                            } else if (styleTag.equals(TtmlUtils.TAG_TT)) {
                                this.mStyleIDs.ttId = styleId;
                            } else if (styleTag.equals("big")) {
                                this.mStyleIDs.bigId = styleId;
                            } else if (styleTag.equals("small")) {
                                this.mStyleIDs.smallId = styleId;
                            } else if (styleTag.equals("sup")) {
                                this.mStyleIDs.supId = styleId;
                            } else if (styleTag.equals("sub")) {
                                this.mStyleIDs.subId = styleId;
                            } else if (styleTag.equals("strike")) {
                                this.mStyleIDs.strikeId = styleId;
                            } else if (styleTag.equals("li")) {
                                this.mStyleIDs.listItemId = styleId;
                            } else if (styleTag.equals("marquee")) {
                                this.mStyleIDs.marqueeId = styleId;
                            }
                        }
                    }
                    res = applyStyles(str, style, this.mStyleIDs);
                }
                if (this.mStrings == null) {
                    this.mStrings[idx] = res;
                } else {
                    this.mSparseStrings.put(idx, res);
                }
            } else {
                if (this.mSparseStrings != null) {
                    res = (CharSequence) this.mSparseStrings.get(idx);
                    if (res != null) {
                    }
                } else {
                    int num = nativeGetSize(this.mNative);
                    if (!this.mUseSparse || num <= KeyEvent.KEYCODE_TV_INPUT_COMPONENT_2) {
                        this.mStrings = new CharSequence[num];
                    } else {
                        this.mSparseStrings = new SparseArray();
                    }
                }
                str = nativeGetString(this.mNative, idx);
                res = str;
                style = nativeGetStyle(this.mNative, idx);
                if (style != null) {
                    if (this.mStyleIDs == null) {
                        this.mStyleIDs = new StyleIDs();
                    }
                    for (styleIndex = 0; styleIndex < style.length; styleIndex += 3) {
                        styleId = style[styleIndex];
                        styleTag = nativeGetString(this.mNative, styleId);
                        if (styleTag.equals("b")) {
                            this.mStyleIDs.boldId = styleId;
                        } else if (styleTag.equals("i")) {
                            this.mStyleIDs.italicId = styleId;
                        } else if (styleTag.equals("u")) {
                            this.mStyleIDs.underlineId = styleId;
                        } else if (styleTag.equals(TtmlUtils.TAG_TT)) {
                            this.mStyleIDs.ttId = styleId;
                        } else if (styleTag.equals("big")) {
                            this.mStyleIDs.bigId = styleId;
                        } else if (styleTag.equals("small")) {
                            this.mStyleIDs.smallId = styleId;
                        } else if (styleTag.equals("sup")) {
                            this.mStyleIDs.supId = styleId;
                        } else if (styleTag.equals("sub")) {
                            this.mStyleIDs.subId = styleId;
                        } else if (styleTag.equals("strike")) {
                            this.mStyleIDs.strikeId = styleId;
                        } else if (styleTag.equals("li")) {
                            this.mStyleIDs.listItemId = styleId;
                        } else if (styleTag.equals("marquee")) {
                            this.mStyleIDs.marqueeId = styleId;
                        }
                    }
                    res = applyStyles(str, style, this.mStyleIDs);
                }
                if (this.mStrings == null) {
                    this.mSparseStrings.put(idx, res);
                } else {
                    this.mStrings[idx] = res;
                }
            }
        }
        return res;
    }

    protected void finalize() throws Throwable {
        try {
            super.finalize();
            if (this.mOwnsNative) {
                nativeDestroy(this.mNative);
            }
        } catch (Throwable th) {
            if (this.mOwnsNative) {
                nativeDestroy(this.mNative);
            }
        }
    }

    private CharSequence applyStyles(String str, int[] style, StyleIDs ids) {
        if (style.length == 0) {
            return str;
        }
        SpannableString buffer = new SpannableString(str);
        for (int i = 0; i < style.length; i += 3) {
            int type = style[i];
            if (type == ids.boldId) {
                buffer.setSpan(new StyleSpan(1), style[i + 1], style[i + 2] + 1, 33);
            } else if (type == ids.italicId) {
                buffer.setSpan(new StyleSpan(2), style[i + 1], style[i + 2] + 1, 33);
            } else if (type == ids.underlineId) {
                buffer.setSpan(new UnderlineSpan(), style[i + 1], style[i + 2] + 1, 33);
            } else if (type == ids.ttId) {
                buffer.setSpan(new TypefaceSpan("monospace"), style[i + 1], style[i + 2] + 1, 33);
            } else if (type == ids.bigId) {
                buffer.setSpan(new RelativeSizeSpan(1.25f), style[i + 1], style[i + 2] + 1, 33);
            } else if (type == ids.smallId) {
                buffer.setSpan(new RelativeSizeSpan(0.8f), style[i + 1], style[i + 2] + 1, 33);
            } else if (type == ids.subId) {
                buffer.setSpan(new SubscriptSpan(), style[i + 1], style[i + 2] + 1, 33);
            } else if (type == ids.supId) {
                buffer.setSpan(new SuperscriptSpan(), style[i + 1], style[i + 2] + 1, 33);
            } else if (type == ids.strikeId) {
                buffer.setSpan(new StrikethroughSpan(), style[i + 1], style[i + 2] + 1, 33);
            } else if (type == ids.listItemId) {
                addParagraphSpan(buffer, new BulletSpan(10), style[i + 1], style[i + 2] + 1);
            } else if (type == ids.marqueeId) {
                buffer.setSpan(TruncateAt.MARQUEE, style[i + 1], style[i + 2] + 1, 18);
            } else {
                String tag = nativeGetString(this.mNative, type);
                String sub;
                if (tag.startsWith("font;")) {
                    sub = subtag(tag, ";height=");
                    if (sub != null) {
                        addParagraphSpan(buffer, new Height(Integer.parseInt(sub)), style[i + 1], style[i + 2] + 1);
                    }
                    sub = subtag(tag, ";size=");
                    if (sub != null) {
                        buffer.setSpan(new AbsoluteSizeSpan(Integer.parseInt(sub), true), style[i + 1], style[i + 2] + 1, 33);
                    }
                    sub = subtag(tag, ";fgcolor=");
                    if (sub != null) {
                        buffer.setSpan(getColor(sub, true), style[i + 1], style[i + 2] + 1, 33);
                    }
                    sub = subtag(tag, ";color=");
                    if (sub != null) {
                        buffer.setSpan(getColor(sub, true), style[i + 1], style[i + 2] + 1, 33);
                    }
                    sub = subtag(tag, ";bgcolor=");
                    if (sub != null) {
                        buffer.setSpan(getColor(sub, false), style[i + 1], style[i + 2] + 1, 33);
                    }
                    sub = subtag(tag, ";face=");
                    if (sub != null) {
                        buffer.setSpan(new TypefaceSpan(sub), style[i + 1], style[i + 2] + 1, 33);
                    }
                } else if (tag.startsWith("a;")) {
                    sub = subtag(tag, ";href=");
                    if (sub != null) {
                        buffer.setSpan(new URLSpan(sub), style[i + 1], style[i + 2] + 1, 33);
                    }
                } else if (tag.startsWith("annotation;")) {
                    int len = tag.length();
                    int t = tag.indexOf(59);
                    while (t < len) {
                        int eq = tag.indexOf(61, t);
                        if (eq < 0) {
                            break;
                        }
                        int next = tag.indexOf(59, eq);
                        if (next < 0) {
                            next = len;
                        }
                        buffer.setSpan(new Annotation(tag.substring(t + 1, eq), tag.substring(eq + 1, next)), style[i + 1], style[i + 2] + 1, 33);
                        t = next;
                    }
                }
            }
        }
        return new SpannedString(buffer);
    }

    private static CharacterStyle getColor(String color, boolean foreground) {
        int c = Spanned.SPAN_USER;
        if (!TextUtils.isEmpty(color)) {
            if (color.startsWith("@")) {
                Resources res = Resources.getSystem();
                int colorRes = res.getIdentifier(color.substring(1), SubscriptionManager.COLOR, ZenModeConfig.SYSTEM_AUTHORITY);
                if (colorRes != 0) {
                    ColorStateList colors = res.getColorStateList(colorRes);
                    if (foreground) {
                        return new TextAppearanceSpan(null, 0, 0, colors, null);
                    }
                    c = colors.getDefaultColor();
                }
            } else {
                c = Color.getHtmlColor(color);
            }
        }
        if (foreground) {
            return new ForegroundColorSpan(c);
        }
        return new BackgroundColorSpan(c);
    }

    private static void addParagraphSpan(Spannable buffer, Object what, int start, int end) {
        int len = buffer.length();
        if (!(start == 0 || start == len || buffer.charAt(start - 1) == '\n')) {
            start--;
            while (start > 0 && buffer.charAt(start - 1) != '\n') {
                start--;
            }
        }
        if (!(end == 0 || end == len || buffer.charAt(end - 1) == '\n')) {
            end++;
            while (end < len && buffer.charAt(end - 1) != '\n') {
                end++;
            }
        }
        buffer.setSpan(what, start, end, 51);
    }

    private static String subtag(String full, String attribute) {
        int start = full.indexOf(attribute);
        if (start < 0) {
            return null;
        }
        start += attribute.length();
        int end = full.indexOf(59, start);
        if (end < 0) {
            return full.substring(start);
        }
        return full.substring(start, end);
    }

    StringBlock(long obj, boolean useSparse) {
        this.mStyleIDs = null;
        this.mNative = obj;
        this.mUseSparse = useSparse;
        this.mOwnsNative = false;
    }
}
