package android.text.method;

import android.content.ContentResolver;
import android.content.Context;
import android.database.ContentObserver;
import android.os.Handler;
import android.provider.Settings.System;
import android.text.Editable;
import android.text.NoCopySpan.Concrete;
import android.text.Selection;
import android.text.SpanWatcher;
import android.text.Spannable;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.accessibility.AccessibilityNodeInfo;
import java.lang.ref.WeakReference;

public class TextKeyListener extends BaseKeyListener implements SpanWatcher {
    static final Object ACTIVE;
    static final int AUTO_CAP = 1;
    static final int AUTO_PERIOD = 4;
    static final int AUTO_TEXT = 2;
    static final Object CAPPED;
    static final Object INHIBIT_REPLACEMENT;
    static final Object LAST_TYPED;
    static final int SHOW_PASSWORD = 8;
    private static TextKeyListener[] sInstance;
    private Capitalize mAutoCap;
    private boolean mAutoText;
    private SettingsObserver mObserver;
    private int mPrefs;
    private boolean mPrefsInited;
    private WeakReference<ContentResolver> mResolver;

    public enum Capitalize {
        NONE,
        SENTENCES,
        WORDS,
        CHARACTERS
    }

    private static class NullKeyListener implements KeyListener {
        private static NullKeyListener sInstance;

        private NullKeyListener() {
        }

        public int getInputType() {
            return 0;
        }

        public boolean onKeyDown(View view, Editable content, int keyCode, KeyEvent event) {
            return false;
        }

        public boolean onKeyUp(View view, Editable content, int keyCode, KeyEvent event) {
            return false;
        }

        public boolean onKeyOther(View view, Editable content, KeyEvent event) {
            return false;
        }

        public void clearMetaKeyState(View view, Editable content, int states) {
        }

        public static NullKeyListener getInstance() {
            if (sInstance != null) {
                return sInstance;
            }
            sInstance = new NullKeyListener();
            return sInstance;
        }
    }

    private class SettingsObserver extends ContentObserver {
        public SettingsObserver() {
            super(new Handler());
        }

        public void onChange(boolean selfChange) {
            if (TextKeyListener.this.mResolver != null) {
                ContentResolver contentResolver = (ContentResolver) TextKeyListener.this.mResolver.get();
                if (contentResolver == null) {
                    TextKeyListener.this.mPrefsInited = false;
                    return;
                } else {
                    TextKeyListener.this.updatePrefs(contentResolver);
                    return;
                }
            }
            TextKeyListener.this.mPrefsInited = false;
        }
    }

    static {
        sInstance = new TextKeyListener[(Capitalize.values().length * AUTO_TEXT)];
        ACTIVE = new Concrete();
        CAPPED = new Concrete();
        INHIBIT_REPLACEMENT = new Concrete();
        LAST_TYPED = new Concrete();
    }

    public TextKeyListener(Capitalize cap, boolean autotext) {
        this.mAutoCap = cap;
        this.mAutoText = autotext;
    }

    public static TextKeyListener getInstance(boolean autotext, Capitalize cap) {
        int off = (cap.ordinal() * AUTO_TEXT) + (autotext ? AUTO_CAP : 0);
        if (sInstance[off] == null) {
            sInstance[off] = new TextKeyListener(cap, autotext);
        }
        return sInstance[off];
    }

    public static TextKeyListener getInstance() {
        return getInstance(false, Capitalize.NONE);
    }

    public static boolean shouldCap(Capitalize cap, CharSequence cs, int off) {
        if (cap == Capitalize.NONE) {
            return false;
        }
        if (cap == Capitalize.CHARACTERS) {
            return true;
        }
        return TextUtils.getCapsMode(cs, off, cap == Capitalize.WORDS ? AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD : AccessibilityNodeInfo.ACTION_COPY) != 0 ? AUTO_CAP : false;
    }

    public int getInputType() {
        return BaseKeyListener.makeTextContentType(this.mAutoCap, this.mAutoText);
    }

    public boolean onKeyDown(View view, Editable content, int keyCode, KeyEvent event) {
        return getKeyListener(event).onKeyDown(view, content, keyCode, event);
    }

    public boolean onKeyUp(View view, Editable content, int keyCode, KeyEvent event) {
        return getKeyListener(event).onKeyUp(view, content, keyCode, event);
    }

    public boolean onKeyOther(View view, Editable content, KeyEvent event) {
        return getKeyListener(event).onKeyOther(view, content, event);
    }

    public static void clear(Editable e) {
        e.clear();
        e.removeSpan(ACTIVE);
        e.removeSpan(CAPPED);
        e.removeSpan(INHIBIT_REPLACEMENT);
        e.removeSpan(LAST_TYPED);
        Replaced[] repl = (Replaced[]) e.getSpans(0, e.length(), Replaced.class);
        int count = repl.length;
        for (int i = 0; i < count; i += AUTO_CAP) {
            e.removeSpan(repl[i]);
        }
    }

    public void onSpanAdded(Spannable s, Object what, int start, int end) {
    }

    public void onSpanRemoved(Spannable s, Object what, int start, int end) {
    }

    public void onSpanChanged(Spannable s, Object what, int start, int end, int st, int en) {
        if (what == Selection.SELECTION_END) {
            s.removeSpan(ACTIVE);
        }
    }

    private KeyListener getKeyListener(KeyEvent event) {
        int kind = event.getKeyCharacterMap().getKeyboardType();
        if (kind == 3) {
            return QwertyKeyListener.getInstance(this.mAutoText, this.mAutoCap);
        }
        if (kind == AUTO_CAP) {
            return MultiTapKeyListener.getInstance(this.mAutoText, this.mAutoCap);
        }
        if (kind == AUTO_PERIOD || kind == 5) {
            return QwertyKeyListener.getInstanceForFullKeyboard();
        }
        return NullKeyListener.getInstance();
    }

    public void release() {
        if (this.mResolver != null) {
            ContentResolver contentResolver = (ContentResolver) this.mResolver.get();
            if (contentResolver != null) {
                contentResolver.unregisterContentObserver(this.mObserver);
                this.mResolver.clear();
            }
            this.mObserver = null;
            this.mResolver = null;
            this.mPrefsInited = false;
        }
    }

    private void initPrefs(Context context) {
        ContentResolver contentResolver = context.getContentResolver();
        this.mResolver = new WeakReference(contentResolver);
        if (this.mObserver == null) {
            this.mObserver = new SettingsObserver();
            contentResolver.registerContentObserver(System.CONTENT_URI, true, this.mObserver);
        }
        updatePrefs(contentResolver);
        this.mPrefsInited = true;
    }

    private void updatePrefs(ContentResolver resolver) {
        boolean cap;
        boolean text;
        boolean period;
        boolean pw;
        int i;
        int i2 = 0;
        if (System.getInt(resolver, "auto_caps", AUTO_CAP) > 0) {
            cap = true;
        } else {
            cap = false;
        }
        if (System.getInt(resolver, "auto_replace", AUTO_CAP) > 0) {
            text = true;
        } else {
            text = false;
        }
        if (System.getInt(resolver, "auto_punctuate", AUTO_CAP) > 0) {
            period = true;
        } else {
            period = false;
        }
        if (System.getInt(resolver, "show_password", AUTO_CAP) > 0) {
            pw = true;
        } else {
            pw = false;
        }
        if (cap) {
            i = AUTO_CAP;
        } else {
            i = 0;
        }
        int i3 = (period ? AUTO_PERIOD : 0) | (i | (text ? AUTO_TEXT : 0));
        if (pw) {
            i2 = SHOW_PASSWORD;
        }
        this.mPrefs = i3 | i2;
    }

    int getPrefs(Context context) {
        synchronized (this) {
            if (!this.mPrefsInited || this.mResolver.get() == null) {
                initPrefs(context);
            }
        }
        return this.mPrefs;
    }
}
