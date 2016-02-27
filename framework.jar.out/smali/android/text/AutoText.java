package android.text;

import android.content.res.Resources;
import android.view.View;
import android.widget.AppSecurityPermissions;
import java.util.Locale;

public class AutoText {
    private static final int DEFAULT = 14337;
    private static final int INCREMENT = 1024;
    private static final int RIGHT = 9300;
    private static final int TRIE_C = 0;
    private static final int TRIE_CHILD = 2;
    private static final int TRIE_NEXT = 3;
    private static final char TRIE_NULL = '\uffff';
    private static final int TRIE_OFF = 1;
    private static final int TRIE_ROOT = 0;
    private static final int TRIE_SIZEOF = 4;
    private static AutoText sInstance;
    private static Object sLock;
    private Locale mLocale;
    private int mSize;
    private String mText;
    private char[] mTrie;
    private char mTrieUsed;

    static {
        sInstance = new AutoText(Resources.getSystem());
        sLock = new Object();
    }

    private AutoText(Resources resources) {
        this.mLocale = resources.getConfiguration().locale;
        init(resources);
    }

    private static AutoText getInstance(View view) {
        AutoText instance;
        Resources res = view.getContext().getResources();
        Locale locale = res.getConfiguration().locale;
        synchronized (sLock) {
            instance = sInstance;
            if (!locale.equals(instance.mLocale)) {
                instance = new AutoText(res);
                sInstance = instance;
            }
        }
        return instance;
    }

    public static String get(CharSequence src, int start, int end, View view) {
        return getInstance(view).lookup(src, start, end);
    }

    public static int getSize(View view) {
        return getInstance(view).getSize();
    }

    private int getSize() {
        return this.mSize;
    }

    private String lookup(CharSequence src, int start, int end) {
        int here = this.mTrie[TRIE_ROOT];
        for (int i = start; i < end; i += TRIE_OFF) {
            char c = src.charAt(i);
            while (here != AppSecurityPermissions.WHICH_ALL) {
                if (c != this.mTrie[here + TRIE_ROOT]) {
                    here = this.mTrie[here + TRIE_NEXT];
                } else if (i != end - 1 || this.mTrie[here + TRIE_OFF] == TRIE_NULL) {
                    here = this.mTrie[here + TRIE_CHILD];
                    if (here != AppSecurityPermissions.WHICH_ALL) {
                        return null;
                    }
                } else {
                    int off = this.mTrie[here + TRIE_OFF];
                    return this.mText.substring(off + TRIE_OFF, (off + TRIE_OFF) + this.mText.charAt(off));
                }
            }
            if (here != AppSecurityPermissions.WHICH_ALL) {
                return null;
            }
        }
        return null;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void init(android.content.res.Resources r13) {
        /*
        r12 = this;
        r9 = 17891330; // 0x1110002 float:2.66323E-38 double:8.8394915E-317;
        r6 = r13.getXml(r9);
        r7 = new java.lang.StringBuilder;
        r9 = 9300; // 0x2454 float:1.3032E-41 double:4.595E-320;
        r7.<init>(r9);
        r9 = 14337; // 0x3801 float:2.009E-41 double:7.0834E-320;
        r9 = new char[r9];
        r12.mTrie = r9;
        r9 = r12.mTrie;
        r10 = 0;
        r11 = 65535; // 0xffff float:9.1834E-41 double:3.23786E-319;
        r9[r10] = r11;
        r9 = 1;
        r12.mTrieUsed = r9;
        r9 = "words";
        com.android.internal.util.XmlUtils.beginDocument(r6, r9);	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        r3 = "";
        r5 = 0;
    L_0x0028:
        com.android.internal.util.XmlUtils.nextElement(r6);	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        r2 = r6.getName();	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        if (r2 == 0) goto L_0x003a;
    L_0x0031:
        r9 = "word";
        r9 = r2.equals(r9);	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        if (r9 != 0) goto L_0x0047;
    L_0x003a:
        r13.flushLayoutCache();	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        r6.close();
        r9 = r7.toString();
        r12.mText = r9;
        return;
    L_0x0047:
        r9 = 0;
        r10 = "src";
        r8 = r6.getAttributeValue(r9, r10);	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        r9 = r6.next();	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        r10 = 4;
        if (r9 != r10) goto L_0x0028;
    L_0x0056:
        r0 = r6.getText();	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        r9 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        if (r9 == 0) goto L_0x0071;
    L_0x0060:
        r4 = r5;
    L_0x0061:
        r12.add(r8, r4);	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        goto L_0x0028;
    L_0x0065:
        r1 = move-exception;
        r9 = new java.lang.RuntimeException;	 Catch:{ all -> 0x006c }
        r9.<init>(r1);	 Catch:{ all -> 0x006c }
        throw r9;	 Catch:{ all -> 0x006c }
    L_0x006c:
        r9 = move-exception;
        r6.close();
        throw r9;
    L_0x0071:
        r9 = r7.length();	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        r4 = (char) r9;	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        r9 = r0.length();	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        r9 = (char) r9;	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        r7.append(r9);	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        r7.append(r0);	 Catch:{ XmlPullParserException -> 0x0065, IOException -> 0x0082 }
        goto L_0x0061;
    L_0x0082:
        r1 = move-exception;
        r9 = new java.lang.RuntimeException;	 Catch:{ all -> 0x006c }
        r9.<init>(r1);	 Catch:{ all -> 0x006c }
        throw r9;	 Catch:{ all -> 0x006c }
        */
        throw new UnsupportedOperationException("Method not decompiled: android.text.AutoText.init(android.content.res.Resources):void");
    }

    private void add(String src, char off) {
        int slen = src.length();
        int herep = TRIE_ROOT;
        this.mSize += TRIE_OFF;
        for (int i = TRIE_ROOT; i < slen; i += TRIE_OFF) {
            char c = src.charAt(i);
            boolean found = false;
            while (this.mTrie[herep] != TRIE_NULL) {
                if (c != this.mTrie[this.mTrie[herep] + TRIE_ROOT]) {
                    herep = this.mTrie[herep] + TRIE_NEXT;
                } else if (i == slen - 1) {
                    this.mTrie[this.mTrie[herep] + TRIE_OFF] = off;
                    return;
                } else {
                    herep = this.mTrie[herep] + TRIE_CHILD;
                    found = true;
                    if (!found) {
                        this.mTrie[herep] = newTrieNode();
                        this.mTrie[this.mTrie[herep] + TRIE_ROOT] = c;
                        this.mTrie[this.mTrie[herep] + TRIE_OFF] = TRIE_NULL;
                        this.mTrie[this.mTrie[herep] + TRIE_NEXT] = TRIE_NULL;
                        this.mTrie[this.mTrie[herep] + TRIE_CHILD] = TRIE_NULL;
                        if (i != slen - 1) {
                            this.mTrie[this.mTrie[herep] + TRIE_OFF] = off;
                            return;
                        }
                        herep = this.mTrie[herep] + TRIE_CHILD;
                    }
                }
            }
            if (!found) {
                this.mTrie[herep] = newTrieNode();
                this.mTrie[this.mTrie[herep] + TRIE_ROOT] = c;
                this.mTrie[this.mTrie[herep] + TRIE_OFF] = TRIE_NULL;
                this.mTrie[this.mTrie[herep] + TRIE_NEXT] = TRIE_NULL;
                this.mTrie[this.mTrie[herep] + TRIE_CHILD] = TRIE_NULL;
                if (i != slen - 1) {
                    herep = this.mTrie[herep] + TRIE_CHILD;
                } else {
                    this.mTrie[this.mTrie[herep] + TRIE_OFF] = off;
                    return;
                }
            }
        }
    }

    private char newTrieNode() {
        if (this.mTrieUsed + TRIE_SIZEOF > this.mTrie.length) {
            char[] copy = new char[(this.mTrie.length + INCREMENT)];
            System.arraycopy(this.mTrie, TRIE_ROOT, copy, TRIE_ROOT, this.mTrie.length);
            this.mTrie = copy;
        }
        char ret = this.mTrieUsed;
        this.mTrieUsed = (char) (this.mTrieUsed + TRIE_SIZEOF);
        return ret;
    }
}
