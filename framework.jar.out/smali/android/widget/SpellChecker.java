package android.widget;

import android.content.Context;
import android.text.Editable;
import android.text.Selection;
import android.text.TextUtils;
import android.text.format.DateFormat;
import android.text.method.WordIterator;
import android.text.style.SpellCheckSpan;
import android.text.style.SuggestionSpan;
import android.util.Log;
import android.util.LruCache;
import android.view.textservice.SentenceSuggestionsInfo;
import android.view.textservice.SpellCheckerSession;
import android.view.textservice.SpellCheckerSession.SpellCheckerSessionListener;
import android.view.textservice.SuggestionsInfo;
import android.view.textservice.TextInfo;
import android.view.textservice.TextServicesManager;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.GrowingArrayUtils;
import java.util.Locale;

public class SpellChecker implements SpellCheckerSessionListener {
    public static final int AVERAGE_WORD_LENGTH = 7;
    private static final boolean DBG = false;
    public static final int MAX_NUMBER_OF_WORDS = 50;
    private static final int MIN_SENTENCE_LENGTH = 50;
    private static final int SPELL_PAUSE_DURATION = 400;
    private static final int SUGGESTION_SPAN_CACHE_SIZE = 10;
    private static final String TAG;
    private static final int USE_SPAN_RANGE = -1;
    public static final int WORD_ITERATOR_INTERVAL = 350;
    final int mCookie;
    private Locale mCurrentLocale;
    private int[] mIds;
    private boolean mIsSentenceSpellCheckSupported;
    private int mLength;
    private int mSpanSequenceCounter;
    private SpellCheckSpan[] mSpellCheckSpans;
    SpellCheckerSession mSpellCheckerSession;
    private SpellParser[] mSpellParsers;
    private Runnable mSpellRunnable;
    private final LruCache<Long, SuggestionSpan> mSuggestionSpanCache;
    private TextServicesManager mTextServicesManager;
    private final TextView mTextView;
    private WordIterator mWordIterator;

    /* renamed from: android.widget.SpellChecker.1 */
    class C10491 implements Runnable {
        C10491() {
        }

        public void run() {
            int length = SpellChecker.this.mSpellParsers.length;
            int i = 0;
            while (i < length) {
                SpellParser spellParser = SpellChecker.this.mSpellParsers[i];
                if (spellParser.isFinished()) {
                    i++;
                } else {
                    spellParser.parse();
                    return;
                }
            }
        }
    }

    private class SpellParser {
        private Object mRange;

        private SpellParser() {
            this.mRange = new Object();
        }

        public void parse(int start, int end) {
            int parseEnd;
            int max = SpellChecker.this.mTextView.length();
            if (end > max) {
                Log.w(SpellChecker.TAG, "Parse invalid region, from " + start + " to " + end);
                parseEnd = max;
            } else {
                parseEnd = end;
            }
            if (parseEnd > start) {
                setRangeSpan((Editable) SpellChecker.this.mTextView.getText(), start, parseEnd);
                parse();
            }
        }

        public boolean isFinished() {
            return ((Editable) SpellChecker.this.mTextView.getText()).getSpanStart(this.mRange) < 0 ? true : SpellChecker.DBG;
        }

        public void stop() {
            removeRangeSpan((Editable) SpellChecker.this.mTextView.getText());
        }

        private void setRangeSpan(Editable editable, int start, int end) {
            editable.setSpan(this.mRange, start, end, 33);
        }

        private void removeRangeSpan(Editable editable) {
            editable.removeSpan(this.mRange);
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void parse() {
            /*
            r25 = this;
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mTextView;
            r5 = r22.getText();
            r5 = (android.text.Editable) r5;
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mIsSentenceSpellCheckSupported;
            if (r22 == 0) goto L_0x00af;
        L_0x001c:
            r22 = 0;
            r0 = r25;
            r0 = r0.mRange;
            r23 = r0;
            r0 = r23;
            r23 = r5.getSpanStart(r0);
            r23 = r23 + -50;
            r16 = java.lang.Math.max(r22, r23);
        L_0x0030:
            r0 = r25;
            r0 = r0.mRange;
            r22 = r0;
            r0 = r22;
            r6 = r5.getSpanEnd(r0);
            r0 = r16;
            r0 = r0 + 350;
            r22 = r0;
            r0 = r22;
            r20 = java.lang.Math.min(r6, r0);
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mWordIterator;
            r0 = r22;
            r1 = r16;
            r2 = r20;
            r0.setCharSequence(r5, r1, r2);
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mWordIterator;
            r0 = r22;
            r1 = r16;
            r21 = r0.preceding(r1);
            r22 = -1;
            r0 = r21;
            r1 = r22;
            if (r0 != r1) goto L_0x00bd;
        L_0x0075:
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mWordIterator;
            r0 = r22;
            r1 = r16;
            r19 = r0.following(r1);
            r22 = -1;
            r0 = r19;
            r1 = r22;
            if (r0 == r1) goto L_0x00a1;
        L_0x008f:
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mWordIterator;
            r0 = r22;
            r1 = r19;
            r21 = r0.getBeginning(r1);
        L_0x00a1:
            r22 = -1;
            r0 = r19;
            r1 = r22;
            if (r0 != r1) goto L_0x00d0;
        L_0x00a9:
            r0 = r25;
            r0.removeRangeSpan(r5);
        L_0x00ae:
            return;
        L_0x00af:
            r0 = r25;
            r0 = r0.mRange;
            r22 = r0;
            r0 = r22;
            r16 = r5.getSpanStart(r0);
            goto L_0x0030;
        L_0x00bd:
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mWordIterator;
            r0 = r22;
            r1 = r21;
            r19 = r0.getEnd(r1);
            goto L_0x00a1;
        L_0x00d0:
            r22 = r16 + -1;
            r23 = r6 + 1;
            r24 = android.text.style.SpellCheckSpan.class;
            r0 = r22;
            r1 = r23;
            r2 = r24;
            r14 = r5.getSpans(r0, r1, r2);
            r14 = (android.text.style.SpellCheckSpan[]) r14;
            r22 = r16 + -1;
            r23 = r6 + 1;
            r24 = android.text.style.SuggestionSpan.class;
            r0 = r22;
            r1 = r23;
            r2 = r24;
            r17 = r5.getSpans(r0, r1, r2);
            r17 = (android.text.style.SuggestionSpan[]) r17;
            r18 = 0;
            r9 = 0;
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mIsSentenceSpellCheckSupported;
            if (r22 == 0) goto L_0x01f2;
        L_0x0103:
            r0 = r20;
            if (r0 >= r6) goto L_0x0108;
        L_0x0107:
            r9 = 1;
        L_0x0108:
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mWordIterator;
            r0 = r22;
            r1 = r20;
            r12 = r0.preceding(r1);
            r22 = -1;
            r0 = r22;
            if (r12 == r0) goto L_0x0143;
        L_0x0120:
            r3 = 1;
        L_0x0121:
            if (r3 == 0) goto L_0x013a;
        L_0x0123:
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mWordIterator;
            r0 = r22;
            r12 = r0.getEnd(r12);
            r22 = -1;
            r0 = r22;
            if (r12 == r0) goto L_0x0145;
        L_0x0139:
            r3 = 1;
        L_0x013a:
            if (r3 != 0) goto L_0x0147;
        L_0x013c:
            r0 = r25;
            r0.removeRangeSpan(r5);
            goto L_0x00ae;
        L_0x0143:
            r3 = 0;
            goto L_0x0121;
        L_0x0145:
            r3 = 0;
            goto L_0x013a;
        L_0x0147:
            r15 = r21;
            r4 = 1;
            r7 = 0;
        L_0x014b:
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mLength;
            r0 = r22;
            if (r7 >= r0) goto L_0x018d;
        L_0x0159:
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mSpellCheckSpans;
            r13 = r22[r7];
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mIds;
            r22 = r22[r7];
            if (r22 < 0) goto L_0x0179;
        L_0x0173:
            r22 = r13.isSpellCheckInProgress();
            if (r22 == 0) goto L_0x017c;
        L_0x0179:
            r7 = r7 + 1;
            goto L_0x014b;
        L_0x017c:
            r11 = r5.getSpanStart(r13);
            r10 = r5.getSpanEnd(r13);
            if (r10 < r15) goto L_0x0179;
        L_0x0186:
            if (r12 < r11) goto L_0x0179;
        L_0x0188:
            if (r11 > r15) goto L_0x01ab;
        L_0x018a:
            if (r12 > r10) goto L_0x01ab;
        L_0x018c:
            r4 = 0;
        L_0x018d:
            r0 = r16;
            if (r12 >= r0) goto L_0x01b7;
        L_0x0191:
            r21 = r12;
        L_0x0193:
            if (r9 == 0) goto L_0x02ff;
        L_0x0195:
            r0 = r21;
            if (r0 > r6) goto L_0x02ff;
        L_0x0199:
            r0 = r25;
            r1 = r21;
            r0.setRangeSpan(r5, r1, r6);
        L_0x01a0:
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22.spellCheck();
            goto L_0x00ae;
        L_0x01ab:
            r5.removeSpan(r13);
            r15 = java.lang.Math.min(r11, r15);
            r12 = java.lang.Math.max(r10, r12);
            goto L_0x0179;
        L_0x01b7:
            if (r12 > r15) goto L_0x01e4;
        L_0x01b9:
            r22 = android.widget.SpellChecker.TAG;
            r23 = new java.lang.StringBuilder;
            r23.<init>();
            r24 = "Trying to spellcheck invalid region, from ";
            r23 = r23.append(r24);
            r0 = r23;
            r1 = r16;
            r23 = r0.append(r1);
            r24 = " to ";
            r23 = r23.append(r24);
            r0 = r23;
            r23 = r0.append(r6);
            r23 = r23.toString();
            android.util.Log.w(r22, r23);
            goto L_0x0191;
        L_0x01e4:
            if (r4 == 0) goto L_0x0191;
        L_0x01e6:
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r0 = r22;
            r0.addSpellCheckSpan(r5, r15, r12);
            goto L_0x0191;
        L_0x01f2:
            r0 = r21;
            if (r0 > r6) goto L_0x0193;
        L_0x01f6:
            r0 = r19;
            r1 = r16;
            if (r0 < r1) goto L_0x0282;
        L_0x01fc:
            r0 = r19;
            r1 = r21;
            if (r0 <= r1) goto L_0x0282;
        L_0x0202:
            r22 = 50;
            r0 = r18;
            r1 = r22;
            if (r0 < r1) goto L_0x020c;
        L_0x020a:
            r9 = 1;
            goto L_0x0193;
        L_0x020c:
            r0 = r21;
            r1 = r16;
            if (r0 >= r1) goto L_0x0228;
        L_0x0212:
            r0 = r19;
            r1 = r16;
            if (r0 <= r1) goto L_0x0228;
        L_0x0218:
            r0 = r25;
            r1 = r16;
            r0.removeSpansAt(r5, r1, r14);
            r0 = r25;
            r1 = r16;
            r2 = r17;
            r0.removeSpansAt(r5, r1, r2);
        L_0x0228:
            r0 = r21;
            if (r0 >= r6) goto L_0x023c;
        L_0x022c:
            r0 = r19;
            if (r0 <= r6) goto L_0x023c;
        L_0x0230:
            r0 = r25;
            r0.removeSpansAt(r5, r6, r14);
            r0 = r25;
            r1 = r17;
            r0.removeSpansAt(r5, r6, r1);
        L_0x023c:
            r4 = 1;
            r0 = r19;
            r1 = r16;
            if (r0 != r1) goto L_0x0258;
        L_0x0243:
            r7 = 0;
        L_0x0244:
            r0 = r14.length;
            r22 = r0;
            r0 = r22;
            if (r7 >= r0) goto L_0x0258;
        L_0x024b:
            r22 = r14[r7];
            r0 = r22;
            r10 = r5.getSpanEnd(r0);
            r0 = r16;
            if (r10 != r0) goto L_0x02f7;
        L_0x0257:
            r4 = 0;
        L_0x0258:
            r0 = r21;
            if (r0 != r6) goto L_0x026f;
        L_0x025c:
            r7 = 0;
        L_0x025d:
            r0 = r14.length;
            r22 = r0;
            r0 = r22;
            if (r7 >= r0) goto L_0x026f;
        L_0x0264:
            r22 = r14[r7];
            r0 = r22;
            r11 = r5.getSpanStart(r0);
            if (r11 != r6) goto L_0x02fb;
        L_0x026e:
            r4 = 0;
        L_0x026f:
            if (r4 == 0) goto L_0x0280;
        L_0x0271:
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r0 = r22;
            r1 = r21;
            r2 = r19;
            r0.addSpellCheckSpan(r5, r1, r2);
        L_0x0280:
            r18 = r18 + 1;
        L_0x0282:
            r8 = r19;
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mWordIterator;
            r0 = r22;
            r1 = r19;
            r19 = r0.following(r1);
            r0 = r20;
            if (r0 >= r6) goto L_0x02d3;
        L_0x029a:
            r22 = -1;
            r0 = r19;
            r1 = r22;
            if (r0 == r1) goto L_0x02a8;
        L_0x02a2:
            r0 = r19;
            r1 = r20;
            if (r0 < r1) goto L_0x02d3;
        L_0x02a8:
            r0 = r8 + 350;
            r22 = r0;
            r0 = r22;
            r20 = java.lang.Math.min(r6, r0);
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mWordIterator;
            r0 = r22;
            r1 = r20;
            r0.setCharSequence(r5, r8, r1);
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mWordIterator;
            r0 = r22;
            r19 = r0.following(r8);
        L_0x02d3:
            r22 = -1;
            r0 = r19;
            r1 = r22;
            if (r0 == r1) goto L_0x0193;
        L_0x02db:
            r0 = r25;
            r0 = android.widget.SpellChecker.this;
            r22 = r0;
            r22 = r22.mWordIterator;
            r0 = r22;
            r1 = r19;
            r21 = r0.getBeginning(r1);
            r22 = -1;
            r0 = r21;
            r1 = r22;
            if (r0 != r1) goto L_0x01f2;
        L_0x02f5:
            goto L_0x0193;
        L_0x02f7:
            r7 = r7 + 1;
            goto L_0x0244;
        L_0x02fb:
            r7 = r7 + 1;
            goto L_0x025d;
        L_0x02ff:
            r0 = r25;
            r0.removeRangeSpan(r5);
            goto L_0x01a0;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.widget.SpellChecker.SpellParser.parse():void");
        }

        private <T> void removeSpansAt(Editable editable, int offset, T[] spans) {
            for (T span : spans) {
                if (editable.getSpanStart(span) <= offset && editable.getSpanEnd(span) >= offset) {
                    editable.removeSpan(span);
                }
            }
        }
    }

    static {
        TAG = SpellChecker.class.getSimpleName();
    }

    public SpellChecker(TextView textView) {
        this.mSpellParsers = new SpellParser[0];
        this.mSpanSequenceCounter = 0;
        this.mSuggestionSpanCache = new LruCache(SUGGESTION_SPAN_CACHE_SIZE);
        this.mTextView = textView;
        this.mIds = ArrayUtils.newUnpaddedIntArray(1);
        this.mSpellCheckSpans = new SpellCheckSpan[this.mIds.length];
        setLocale(this.mTextView.getSpellCheckerLocale());
        this.mCookie = hashCode();
    }

    private void resetSession() {
        closeSession();
        this.mTextServicesManager = (TextServicesManager) this.mTextView.getContext().getSystemService(Context.TEXT_SERVICES_MANAGER_SERVICE);
        if (!this.mTextServicesManager.isSpellCheckerEnabled() || this.mCurrentLocale == null || this.mTextServicesManager.getCurrentSpellCheckerSubtype(true) == null) {
            this.mSpellCheckerSession = null;
        } else {
            this.mSpellCheckerSession = this.mTextServicesManager.newSpellCheckerSession(null, this.mCurrentLocale, this, DBG);
            this.mIsSentenceSpellCheckSupported = true;
        }
        for (int i = 0; i < this.mLength; i++) {
            this.mIds[i] = USE_SPAN_RANGE;
        }
        this.mLength = 0;
        this.mTextView.removeMisspelledSpans((Editable) this.mTextView.getText());
        this.mSuggestionSpanCache.evictAll();
    }

    private void setLocale(Locale locale) {
        this.mCurrentLocale = locale;
        resetSession();
        if (locale != null) {
            this.mWordIterator = new WordIterator(locale);
        }
        this.mTextView.onLocaleChanged();
    }

    private boolean isSessionActive() {
        return this.mSpellCheckerSession != null ? true : DBG;
    }

    public void closeSession() {
        if (this.mSpellCheckerSession != null) {
            this.mSpellCheckerSession.close();
        }
        for (SpellParser stop : this.mSpellParsers) {
            stop.stop();
        }
        if (this.mSpellRunnable != null) {
            this.mTextView.removeCallbacks(this.mSpellRunnable);
        }
    }

    private int nextSpellCheckSpanIndex() {
        for (int i = 0; i < this.mLength; i++) {
            if (this.mIds[i] < 0) {
                return i;
            }
        }
        this.mIds = GrowingArrayUtils.append(this.mIds, this.mLength, 0);
        this.mSpellCheckSpans = (SpellCheckSpan[]) GrowingArrayUtils.append(this.mSpellCheckSpans, this.mLength, new SpellCheckSpan());
        this.mLength++;
        return this.mLength + USE_SPAN_RANGE;
    }

    private void addSpellCheckSpan(Editable editable, int start, int end) {
        int index = nextSpellCheckSpanIndex();
        SpellCheckSpan spellCheckSpan = this.mSpellCheckSpans[index];
        editable.setSpan(spellCheckSpan, start, end, 33);
        spellCheckSpan.setSpellCheckInProgress(DBG);
        int[] iArr = this.mIds;
        int i = this.mSpanSequenceCounter;
        this.mSpanSequenceCounter = i + 1;
        iArr[index] = i;
    }

    public void onSpellCheckSpanRemoved(SpellCheckSpan spellCheckSpan) {
        for (int i = 0; i < this.mLength; i++) {
            if (this.mSpellCheckSpans[i] == spellCheckSpan) {
                this.mIds[i] = USE_SPAN_RANGE;
                return;
            }
        }
    }

    public void onSelectionChanged() {
        spellCheck();
    }

    public void spellCheck(int start, int end) {
        Locale locale = this.mTextView.getSpellCheckerLocale();
        boolean isSessionActive = isSessionActive();
        if (locale == null || this.mCurrentLocale == null || !this.mCurrentLocale.equals(locale)) {
            setLocale(locale);
            start = 0;
            end = this.mTextView.getText().length();
        } else if (isSessionActive != this.mTextServicesManager.isSpellCheckerEnabled()) {
            resetSession();
        }
        if (isSessionActive) {
            for (SpellParser spellParser : this.mSpellParsers) {
                if (spellParser.isFinished()) {
                    spellParser.parse(start, end);
                    return;
                }
            }
            SpellParser[] newSpellParsers = new SpellParser[(length + 1)];
            System.arraycopy(this.mSpellParsers, 0, newSpellParsers, 0, length);
            this.mSpellParsers = newSpellParsers;
            SpellParser spellParser2 = new SpellParser();
            this.mSpellParsers[length] = spellParser2;
            spellParser2.parse(start, end);
        }
    }

    private void spellCheck() {
        if (this.mSpellCheckerSession != null) {
            Editable editable = (Editable) this.mTextView.getText();
            int selectionStart = Selection.getSelectionStart(editable);
            int selectionEnd = Selection.getSelectionEnd(editable);
            TextInfo[] textInfos = new TextInfo[this.mLength];
            int textInfosCount = 0;
            for (int i = 0; i < this.mLength; i++) {
                SpellCheckSpan spellCheckSpan = this.mSpellCheckSpans[i];
                if (this.mIds[i] >= 0 && !spellCheckSpan.isSpellCheckInProgress()) {
                    int start = editable.getSpanStart(spellCheckSpan);
                    int end = editable.getSpanEnd(spellCheckSpan);
                    boolean apostrophe = (selectionStart == end + 1 && editable.charAt(end) == DateFormat.QUOTE) ? true : DBG;
                    boolean isEditing = this.mIsSentenceSpellCheckSupported ? (apostrophe || (selectionEnd > start && selectionStart <= end)) ? DBG : true : (apostrophe || (selectionEnd >= start && selectionStart <= end)) ? DBG : true;
                    if (start >= 0 && end > start && isEditing) {
                        spellCheckSpan.setSpellCheckInProgress(true);
                        int textInfosCount2 = textInfosCount + 1;
                        textInfos[textInfosCount] = new TextInfo(editable, start, end, this.mCookie, this.mIds[i]);
                        textInfosCount = textInfosCount2;
                    }
                }
            }
            if (textInfosCount > 0) {
                if (textInfosCount < textInfos.length) {
                    TextInfo[] textInfosCopy = new TextInfo[textInfosCount];
                    System.arraycopy(textInfos, 0, textInfosCopy, 0, textInfosCount);
                    textInfos = textInfosCopy;
                }
                if (this.mIsSentenceSpellCheckSupported) {
                    this.mSpellCheckerSession.getSentenceSuggestions(textInfos, 5);
                } else {
                    this.mSpellCheckerSession.getSuggestions(textInfos, 5, DBG);
                }
            }
        }
    }

    private SpellCheckSpan onGetSuggestionsInternal(SuggestionsInfo suggestionsInfo, int offset, int length) {
        if (suggestionsInfo == null || suggestionsInfo.getCookie() != this.mCookie) {
            return null;
        }
        Editable editable = (Editable) this.mTextView.getText();
        int sequenceNumber = suggestionsInfo.getSequence();
        for (int k = 0; k < this.mLength; k++) {
            if (sequenceNumber == this.mIds[k]) {
                int attributes = suggestionsInfo.getSuggestionsAttributes();
                boolean isInDictionary = (attributes & 1) > 0 ? true : DBG;
                boolean looksLikeTypo = (attributes & 2) > 0 ? true : DBG;
                SpellCheckSpan spellCheckSpan = this.mSpellCheckSpans[k];
                if (!isInDictionary && looksLikeTypo) {
                    createMisspelledSuggestionSpan(editable, suggestionsInfo, spellCheckSpan, offset, length);
                    return spellCheckSpan;
                } else if (!this.mIsSentenceSpellCheckSupported) {
                    return spellCheckSpan;
                } else {
                    int start;
                    int end;
                    int spellCheckSpanStart = editable.getSpanStart(spellCheckSpan);
                    int spellCheckSpanEnd = editable.getSpanEnd(spellCheckSpan);
                    if (offset == USE_SPAN_RANGE || length == USE_SPAN_RANGE) {
                        start = spellCheckSpanStart;
                        end = spellCheckSpanEnd;
                    } else {
                        start = spellCheckSpanStart + offset;
                        end = start + length;
                    }
                    if (spellCheckSpanStart < 0 || spellCheckSpanEnd <= spellCheckSpanStart || end <= start) {
                        return spellCheckSpan;
                    }
                    Long key = Long.valueOf(TextUtils.packRangeInLong(start, end));
                    SuggestionSpan tempSuggestionSpan = (SuggestionSpan) this.mSuggestionSpanCache.get(key);
                    if (tempSuggestionSpan == null) {
                        return spellCheckSpan;
                    }
                    editable.removeSpan(tempSuggestionSpan);
                    this.mSuggestionSpanCache.remove(key);
                    return spellCheckSpan;
                }
            }
        }
        return null;
    }

    public void onGetSuggestions(SuggestionsInfo[] results) {
        Editable editable = (Editable) this.mTextView.getText();
        for (SuggestionsInfo onGetSuggestionsInternal : results) {
            SpellCheckSpan spellCheckSpan = onGetSuggestionsInternal(onGetSuggestionsInternal, USE_SPAN_RANGE, USE_SPAN_RANGE);
            if (spellCheckSpan != null) {
                editable.removeSpan(spellCheckSpan);
            }
        }
        scheduleNewSpellCheck();
    }

    public void onGetSentenceSuggestions(SentenceSuggestionsInfo[] results) {
        Editable editable = (Editable) this.mTextView.getText();
        for (SentenceSuggestionsInfo ssi : results) {
            if (ssi != null) {
                SpellCheckSpan spellCheckSpan = null;
                for (int j = 0; j < ssi.getSuggestionsCount(); j++) {
                    SuggestionsInfo suggestionsInfo = ssi.getSuggestionsInfoAt(j);
                    if (suggestionsInfo != null) {
                        SpellCheckSpan scs = onGetSuggestionsInternal(suggestionsInfo, ssi.getOffsetAt(j), ssi.getLengthAt(j));
                        if (spellCheckSpan == null && scs != null) {
                            spellCheckSpan = scs;
                        }
                    }
                }
                if (spellCheckSpan != null) {
                    editable.removeSpan(spellCheckSpan);
                }
            }
        }
        scheduleNewSpellCheck();
    }

    private void scheduleNewSpellCheck() {
        if (this.mSpellRunnable == null) {
            this.mSpellRunnable = new C10491();
        } else {
            this.mTextView.removeCallbacks(this.mSpellRunnable);
        }
        this.mTextView.postDelayed(this.mSpellRunnable, 400);
    }

    private void createMisspelledSuggestionSpan(Editable editable, SuggestionsInfo suggestionsInfo, SpellCheckSpan spellCheckSpan, int offset, int length) {
        int spellCheckSpanStart = editable.getSpanStart(spellCheckSpan);
        int spellCheckSpanEnd = editable.getSpanEnd(spellCheckSpan);
        if (spellCheckSpanStart >= 0 && spellCheckSpanEnd > spellCheckSpanStart) {
            int start;
            int end;
            String[] suggestions;
            if (offset == USE_SPAN_RANGE || length == USE_SPAN_RANGE) {
                start = spellCheckSpanStart;
                end = spellCheckSpanEnd;
            } else {
                start = spellCheckSpanStart + offset;
                end = start + length;
            }
            int suggestionsCount = suggestionsInfo.getSuggestionsCount();
            if (suggestionsCount > 0) {
                suggestions = new String[suggestionsCount];
                for (int i = 0; i < suggestionsCount; i++) {
                    suggestions[i] = suggestionsInfo.getSuggestionAt(i);
                }
            } else {
                suggestions = (String[]) ArrayUtils.emptyArray(String.class);
            }
            SuggestionSpan suggestionSpan = new SuggestionSpan(this.mTextView.getContext(), suggestions, 3);
            if (this.mIsSentenceSpellCheckSupported) {
                Long key = Long.valueOf(TextUtils.packRangeInLong(start, end));
                SuggestionSpan tempSuggestionSpan = (SuggestionSpan) this.mSuggestionSpanCache.get(key);
                if (tempSuggestionSpan != null) {
                    editable.removeSpan(tempSuggestionSpan);
                }
                this.mSuggestionSpanCache.put(key, suggestionSpan);
            }
            editable.setSpan(suggestionSpan, start, end, 33);
            this.mTextView.invalidateRegion(start, end, DBG);
        }
    }

    public static boolean haveWordBoundariesChanged(Editable editable, int start, int end, int spanStart, int spanEnd) {
        if (spanEnd != start && spanStart != end) {
            return true;
        }
        if (spanEnd == start && start < editable.length()) {
            return Character.isLetterOrDigit(Character.codePointAt(editable, start));
        }
        if (spanStart != end || end <= 0) {
            return DBG;
        }
        return Character.isLetterOrDigit(Character.codePointBefore(editable, end));
    }
}
