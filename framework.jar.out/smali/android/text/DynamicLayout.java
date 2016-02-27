package android.text;

import android.graphics.Paint.FontMetricsInt;
import android.text.Layout.Alignment;
import android.text.Layout.Directions;
import android.text.TextUtils.TruncateAt;
import android.text.style.UpdateLayout;
import android.text.style.WrapTogetherSpan;
import android.view.inputmethod.EditorInfo;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.GrowingArrayUtils;
import java.lang.ref.WeakReference;

public class DynamicLayout extends Layout {
    private static final int BLOCK_MINIMUM_CHARACTER_LENGTH = 400;
    private static final int COLUMNS_ELLIPSIZE = 5;
    private static final int COLUMNS_NORMAL = 3;
    private static final int DESCENT = 2;
    private static final int DIR = 0;
    private static final int DIR_SHIFT = 30;
    private static final int ELLIPSIS_COUNT = 4;
    private static final int ELLIPSIS_START = 3;
    private static final int ELLIPSIS_UNDEFINED = Integer.MIN_VALUE;
    public static final int INVALID_BLOCK_INDEX = -1;
    private static final int PRIORITY = 128;
    private static final int START = 0;
    private static final int START_MASK = 536870911;
    private static final int TAB = 0;
    private static final int TAB_MASK = 536870912;
    private static final int TOP = 1;
    private static final Object[] sLock;
    private static StaticLayout sStaticLayout;
    private CharSequence mBase;
    private int[] mBlockEndLines;
    private int[] mBlockIndices;
    private int mBottomPadding;
    private CharSequence mDisplay;
    private boolean mEllipsize;
    private TruncateAt mEllipsizeAt;
    private int mEllipsizedWidth;
    private boolean mIncludePad;
    private int mIndexFirstChangedBlock;
    private PackedIntVector mInts;
    private int mNumberOfBlocks;
    private PackedObjectVector<Directions> mObjects;
    private int mTopPadding;
    private ChangeWatcher mWatcher;

    private static class ChangeWatcher implements TextWatcher, SpanWatcher {
        private WeakReference<DynamicLayout> mLayout;

        public ChangeWatcher(DynamicLayout layout) {
            this.mLayout = new WeakReference(layout);
        }

        private void reflow(CharSequence s, int where, int before, int after) {
            DynamicLayout ml = (DynamicLayout) this.mLayout.get();
            if (ml != null) {
                ml.reflow(s, where, before, after);
            } else if (s instanceof Spannable) {
                ((Spannable) s).removeSpan(this);
            }
        }

        public void beforeTextChanged(CharSequence s, int where, int before, int after) {
        }

        public void onTextChanged(CharSequence s, int where, int before, int after) {
            reflow(s, where, before, after);
        }

        public void afterTextChanged(Editable s) {
        }

        public void onSpanAdded(Spannable s, Object o, int start, int end) {
            if (o instanceof UpdateLayout) {
                reflow(s, start, end - start, end - start);
            }
        }

        public void onSpanRemoved(Spannable s, Object o, int start, int end) {
            if (o instanceof UpdateLayout) {
                reflow(s, start, end - start, end - start);
            }
        }

        public void onSpanChanged(Spannable s, Object o, int start, int end, int nstart, int nend) {
            if (o instanceof UpdateLayout) {
                reflow(s, start, end - start, end - start);
                reflow(s, nstart, nend - nstart, nend - nstart);
            }
        }
    }

    public DynamicLayout(CharSequence base, TextPaint paint, int width, Alignment align, float spacingmult, float spacingadd, boolean includepad) {
        this(base, base, paint, width, align, spacingmult, spacingadd, includepad);
    }

    public DynamicLayout(CharSequence base, CharSequence display, TextPaint paint, int width, Alignment align, float spacingmult, float spacingadd, boolean includepad) {
        this(base, display, paint, width, align, spacingmult, spacingadd, includepad, null, TAB);
    }

    public DynamicLayout(CharSequence base, CharSequence display, TextPaint paint, int width, Alignment align, float spacingmult, float spacingadd, boolean includepad, TruncateAt ellipsize, int ellipsizedWidth) {
        this(base, display, paint, width, align, TextDirectionHeuristics.FIRSTSTRONG_LTR, spacingmult, spacingadd, includepad, ellipsize, ellipsizedWidth);
    }

    public DynamicLayout(CharSequence base, CharSequence display, TextPaint paint, int width, Alignment align, TextDirectionHeuristic textDir, float spacingmult, float spacingadd, boolean includepad, TruncateAt ellipsize, int ellipsizedWidth) {
        int[] start;
        CharSequence spannedEllipsizer = ellipsize == null ? display : display instanceof Spanned ? new SpannedEllipsizer(display) : new Ellipsizer(display);
        super(spannedEllipsizer, paint, width, align, textDir, spacingmult, spacingadd);
        this.mBase = base;
        this.mDisplay = display;
        if (ellipsize != null) {
            this.mInts = new PackedIntVector(COLUMNS_ELLIPSIZE);
            this.mEllipsizedWidth = ellipsizedWidth;
            this.mEllipsizeAt = ellipsize;
        } else {
            this.mInts = new PackedIntVector(ELLIPSIS_START);
            this.mEllipsizedWidth = width;
            this.mEllipsizeAt = null;
        }
        this.mObjects = new PackedObjectVector(TOP);
        this.mIncludePad = includepad;
        if (ellipsize != null) {
            Ellipsizer e = (Ellipsizer) getText();
            e.mLayout = this;
            e.mWidth = ellipsizedWidth;
            e.mMethod = ellipsize;
            this.mEllipsize = true;
        }
        if (ellipsize != null) {
            start = new int[COLUMNS_ELLIPSIZE];
            start[ELLIPSIS_START] = ELLIPSIS_UNDEFINED;
        } else {
            start = new int[ELLIPSIS_START];
        }
        Directions[] dirs = new Directions[TOP];
        dirs[TAB] = DIRS_ALL_LEFT_TO_RIGHT;
        FontMetricsInt fm = paint.getFontMetricsInt();
        int asc = fm.ascent;
        int desc = fm.descent;
        start[TAB] = EditorInfo.IME_FLAG_NO_ENTER_ACTION;
        start[TOP] = TAB;
        start[DESCENT] = desc;
        this.mInts.insertAt(TAB, start);
        start[TOP] = desc - asc;
        this.mInts.insertAt(TOP, start);
        this.mObjects.insertAt(TAB, dirs);
        reflow(base, TAB, TAB, base.length());
        if (base instanceof Spannable) {
            if (this.mWatcher == null) {
                this.mWatcher = new ChangeWatcher(this);
            }
            Spannable sp = (Spannable) base;
            ChangeWatcher[] spans = (ChangeWatcher[]) sp.getSpans(TAB, sp.length(), ChangeWatcher.class);
            for (int i = TAB; i < spans.length; i += TOP) {
                sp.removeSpan(spans[i]);
            }
            sp.setSpan(this.mWatcher, TAB, base.length(), 8388626);
        }
    }

    private void reflow(CharSequence s, int where, int before, int after) {
        if (s == this.mBase) {
            int i;
            StaticLayout reflowed;
            int[] ints;
            CharSequence text = this.mDisplay;
            int len = text.length();
            int find = TextUtils.lastIndexOf(text, '\n', where + INVALID_BLOCK_INDEX);
            if (find < 0) {
                find = TAB;
            } else {
                find += TOP;
            }
            int diff = where - find;
            before += diff;
            after += diff;
            where -= diff;
            int look = TextUtils.indexOf(text, '\n', where + after);
            if (look < 0) {
                look = len;
            } else {
                look += TOP;
            }
            int change = look - (where + after);
            before += change;
            after += change;
            if (text instanceof Spanned) {
                Spanned sp = (Spanned) text;
                boolean again;
                do {
                    again = false;
                    Object[] force = sp.getSpans(where, where + after, WrapTogetherSpan.class);
                    for (i = TAB; i < force.length; i += TOP) {
                        int st = sp.getSpanStart(force[i]);
                        int en = sp.getSpanEnd(force[i]);
                        if (st < where) {
                            again = true;
                            diff = where - st;
                            before += diff;
                            after += diff;
                            where -= diff;
                        }
                        if (en > where + after) {
                            again = true;
                            diff = en - (where + after);
                            before += diff;
                            after += diff;
                        }
                    }
                } while (again);
            }
            int startline = getLineForOffset(where);
            int startv = getLineTop(startline);
            int endline = getLineForOffset(where + before);
            if (where + after == len) {
                endline = getLineCount();
            }
            int endv = getLineTop(endline);
            boolean islast = endline == getLineCount();
            synchronized (sLock) {
                reflowed = sStaticLayout;
                sStaticLayout = null;
            }
            if (reflowed == null) {
                reflowed = new StaticLayout(null);
            } else {
                reflowed.prepare();
            }
            reflowed.generate(text, where, where + after, getPaint(), getWidth(), getTextDirectionHeuristic(), getSpacingMultiplier(), getSpacingAdd(), false, true, (float) this.mEllipsizedWidth, this.mEllipsizeAt);
            int n = reflowed.getLineCount();
            if (where + after != len && reflowed.getLineStart(n + INVALID_BLOCK_INDEX) == where + after) {
                n += INVALID_BLOCK_INDEX;
            }
            this.mInts.deleteAt(startline, endline - startline);
            this.mObjects.deleteAt(startline, endline - startline);
            int ht = reflowed.getLineTop(n);
            int toppad = TAB;
            int botpad = TAB;
            if (this.mIncludePad && startline == 0) {
                toppad = reflowed.getTopPadding();
                this.mTopPadding = toppad;
                ht -= toppad;
            }
            if (this.mIncludePad && islast) {
                botpad = reflowed.getBottomPadding();
                this.mBottomPadding = botpad;
                ht += botpad;
            }
            this.mInts.adjustValuesBelow(startline, TAB, after - before);
            this.mInts.adjustValuesBelow(startline, TOP, (startv - endv) + ht);
            if (this.mEllipsize) {
                ints = new int[COLUMNS_ELLIPSIZE];
                ints[ELLIPSIS_START] = ELLIPSIS_UNDEFINED;
            } else {
                ints = new int[ELLIPSIS_START];
            }
            Directions[] objects = new Directions[TOP];
            for (i = TAB; i < n; i += TOP) {
                ints[TAB] = (reflowed.getLineContainsTab(i) ? TAB_MASK : TAB) | ((reflowed.getParagraphDirection(i) << DIR_SHIFT) | reflowed.getLineStart(i));
                int top = reflowed.getLineTop(i) + startv;
                if (i > 0) {
                    top -= toppad;
                }
                ints[TOP] = top;
                int desc = reflowed.getLineDescent(i);
                if (i == n + INVALID_BLOCK_INDEX) {
                    desc += botpad;
                }
                ints[DESCENT] = desc;
                objects[TAB] = reflowed.getLineDirections(i);
                if (this.mEllipsize) {
                    ints[ELLIPSIS_START] = reflowed.getEllipsisStart(i);
                    ints[ELLIPSIS_COUNT] = reflowed.getEllipsisCount(i);
                }
                this.mInts.insertAt(startline + i, ints);
                this.mObjects.insertAt(startline + i, objects);
            }
            updateBlocks(startline, endline + INVALID_BLOCK_INDEX, n);
            synchronized (sLock) {
                sStaticLayout = reflowed;
                reflowed.finish();
            }
        }
    }

    private void createBlocks() {
        int offset = BLOCK_MINIMUM_CHARACTER_LENGTH;
        this.mNumberOfBlocks = TAB;
        CharSequence text = this.mDisplay;
        while (true) {
            offset = TextUtils.indexOf(text, '\n', offset);
            if (offset < 0) {
                break;
            }
            addBlockAtOffset(offset);
            offset += BLOCK_MINIMUM_CHARACTER_LENGTH;
        }
        addBlockAtOffset(text.length());
        this.mBlockIndices = new int[this.mBlockEndLines.length];
        for (int i = TAB; i < this.mBlockEndLines.length; i += TOP) {
            this.mBlockIndices[i] = INVALID_BLOCK_INDEX;
        }
    }

    private void addBlockAtOffset(int offset) {
        int line = getLineForOffset(offset);
        if (this.mBlockEndLines == null) {
            this.mBlockEndLines = ArrayUtils.newUnpaddedIntArray(TOP);
            this.mBlockEndLines[this.mNumberOfBlocks] = line;
            this.mNumberOfBlocks += TOP;
        } else if (line > this.mBlockEndLines[this.mNumberOfBlocks + INVALID_BLOCK_INDEX]) {
            this.mBlockEndLines = GrowingArrayUtils.append(this.mBlockEndLines, this.mNumberOfBlocks, line);
            this.mNumberOfBlocks += TOP;
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void updateBlocks(int r25, int r26, int r27) {
        /*
        r24 = this;
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        if (r19 != 0) goto L_0x000c;
    L_0x0008:
        r24.createBlocks();
    L_0x000b:
        return;
    L_0x000c:
        r11 = -1;
        r13 = -1;
        r12 = 0;
    L_0x000f:
        r0 = r24;
        r0 = r0.mNumberOfBlocks;
        r19 = r0;
        r0 = r19;
        if (r12 >= r0) goto L_0x0028;
    L_0x0019:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r19 = r19[r12];
        r0 = r19;
        r1 = r25;
        if (r0 < r1) goto L_0x00a7;
    L_0x0027:
        r11 = r12;
    L_0x0028:
        r12 = r11;
    L_0x0029:
        r0 = r24;
        r0 = r0.mNumberOfBlocks;
        r19 = r0;
        r0 = r19;
        if (r12 >= r0) goto L_0x0042;
    L_0x0033:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r19 = r19[r12];
        r0 = r19;
        r1 = r26;
        if (r0 < r1) goto L_0x00ab;
    L_0x0041:
        r13 = r12;
    L_0x0042:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r14 = r19[r13];
        if (r11 != 0) goto L_0x00af;
    L_0x004c:
        r19 = 0;
    L_0x004e:
        r0 = r25;
        r1 = r19;
        if (r0 <= r1) goto L_0x00bc;
    L_0x0054:
        r9 = 1;
    L_0x0055:
        if (r27 <= 0) goto L_0x00be;
    L_0x0057:
        r7 = 1;
    L_0x0058:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r19 = r19[r13];
        r0 = r26;
        r1 = r19;
        if (r0 >= r1) goto L_0x00c0;
    L_0x0066:
        r8 = 1;
    L_0x0067:
        r17 = 0;
        if (r9 == 0) goto L_0x006d;
    L_0x006b:
        r17 = r17 + 1;
    L_0x006d:
        if (r7 == 0) goto L_0x0071;
    L_0x006f:
        r17 = r17 + 1;
    L_0x0071:
        if (r8 == 0) goto L_0x0075;
    L_0x0073:
        r17 = r17 + 1;
    L_0x0075:
        r19 = r13 - r11;
        r18 = r19 + 1;
        r0 = r24;
        r0 = r0.mNumberOfBlocks;
        r19 = r0;
        r19 = r19 + r17;
        r16 = r19 - r18;
        if (r16 != 0) goto L_0x00c2;
    L_0x0085:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r20 = 0;
        r21 = 0;
        r19[r20] = r21;
        r0 = r24;
        r0 = r0.mBlockIndices;
        r19 = r0;
        r20 = 0;
        r21 = -1;
        r19[r20] = r21;
        r19 = 1;
        r0 = r19;
        r1 = r24;
        r1.mNumberOfBlocks = r0;
        goto L_0x000b;
    L_0x00a7:
        r12 = r12 + 1;
        goto L_0x000f;
    L_0x00ab:
        r12 = r12 + 1;
        goto L_0x0029;
    L_0x00af:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r20 = r11 + -1;
        r19 = r19[r20];
        r19 = r19 + 1;
        goto L_0x004e;
    L_0x00bc:
        r9 = 0;
        goto L_0x0055;
    L_0x00be:
        r7 = 0;
        goto L_0x0058;
    L_0x00c0:
        r8 = 0;
        goto L_0x0067;
    L_0x00c2:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r0 = r19;
        r0 = r0.length;
        r19 = r0;
        r0 = r16;
        r1 = r19;
        if (r0 <= r1) goto L_0x0189;
    L_0x00d3:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r0 = r19;
        r0 = r0.length;
        r19 = r0;
        r19 = r19 * 2;
        r0 = r19;
        r1 = r16;
        r19 = java.lang.Math.max(r0, r1);
        r4 = com.android.internal.util.ArrayUtils.newUnpaddedIntArray(r19);
        r0 = r4.length;
        r19 = r0;
        r0 = r19;
        r6 = new int[r0];
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r20 = 0;
        r21 = 0;
        r0 = r19;
        r1 = r20;
        r2 = r21;
        java.lang.System.arraycopy(r0, r1, r4, r2, r11);
        r0 = r24;
        r0 = r0.mBlockIndices;
        r19 = r0;
        r20 = 0;
        r21 = 0;
        r0 = r19;
        r1 = r20;
        r2 = r21;
        java.lang.System.arraycopy(r0, r1, r6, r2, r11);
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r20 = r13 + 1;
        r21 = r11 + r17;
        r0 = r24;
        r0 = r0.mNumberOfBlocks;
        r22 = r0;
        r22 = r22 - r13;
        r22 = r22 + -1;
        r0 = r19;
        r1 = r20;
        r2 = r21;
        r3 = r22;
        java.lang.System.arraycopy(r0, r1, r4, r2, r3);
        r0 = r24;
        r0 = r0.mBlockIndices;
        r19 = r0;
        r20 = r13 + 1;
        r21 = r11 + r17;
        r0 = r24;
        r0 = r0.mNumberOfBlocks;
        r22 = r0;
        r22 = r22 - r13;
        r22 = r22 + -1;
        r0 = r19;
        r1 = r20;
        r2 = r21;
        r3 = r22;
        java.lang.System.arraycopy(r0, r1, r6, r2, r3);
        r0 = r24;
        r0.mBlockEndLines = r4;
        r0 = r24;
        r0.mBlockIndices = r6;
    L_0x015f:
        r0 = r16;
        r1 = r24;
        r1.mNumberOfBlocks = r0;
        r19 = r26 - r25;
        r19 = r19 + 1;
        r10 = r27 - r19;
        if (r10 == 0) goto L_0x01c4;
    L_0x016d:
        r15 = r11 + r17;
        r12 = r15;
    L_0x0170:
        r0 = r24;
        r0 = r0.mNumberOfBlocks;
        r19 = r0;
        r0 = r19;
        if (r12 >= r0) goto L_0x01c8;
    L_0x017a:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r20 = r19[r12];
        r20 = r20 + r10;
        r19[r12] = r20;
        r12 = r12 + 1;
        goto L_0x0170;
    L_0x0189:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r20 = r13 + 1;
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r21 = r0;
        r22 = r11 + r17;
        r0 = r24;
        r0 = r0.mNumberOfBlocks;
        r23 = r0;
        r23 = r23 - r13;
        r23 = r23 + -1;
        java.lang.System.arraycopy(r19, r20, r21, r22, r23);
        r0 = r24;
        r0 = r0.mBlockIndices;
        r19 = r0;
        r20 = r13 + 1;
        r0 = r24;
        r0 = r0.mBlockIndices;
        r21 = r0;
        r22 = r11 + r17;
        r0 = r24;
        r0 = r0.mNumberOfBlocks;
        r23 = r0;
        r23 = r23 - r13;
        r23 = r23 + -1;
        java.lang.System.arraycopy(r19, r20, r21, r22, r23);
        goto L_0x015f;
    L_0x01c4:
        r0 = r24;
        r15 = r0.mNumberOfBlocks;
    L_0x01c8:
        r0 = r24;
        r0 = r0.mIndexFirstChangedBlock;
        r19 = r0;
        r0 = r19;
        r19 = java.lang.Math.min(r0, r15);
        r0 = r19;
        r1 = r24;
        r1.mIndexFirstChangedBlock = r0;
        r5 = r11;
        if (r9 == 0) goto L_0x01f3;
    L_0x01dd:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r20 = r25 + -1;
        r19[r5] = r20;
        r0 = r24;
        r0 = r0.mBlockIndices;
        r19 = r0;
        r20 = -1;
        r19[r5] = r20;
        r5 = r5 + 1;
    L_0x01f3:
        if (r7 == 0) goto L_0x020d;
    L_0x01f5:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r20 = r25 + r27;
        r20 = r20 + -1;
        r19[r5] = r20;
        r0 = r24;
        r0 = r0.mBlockIndices;
        r19 = r0;
        r20 = -1;
        r19[r5] = r20;
        r5 = r5 + 1;
    L_0x020d:
        if (r8 == 0) goto L_0x000b;
    L_0x020f:
        r0 = r24;
        r0 = r0.mBlockEndLines;
        r19 = r0;
        r20 = r14 + r10;
        r19[r5] = r20;
        r0 = r24;
        r0 = r0.mBlockIndices;
        r19 = r0;
        r20 = -1;
        r19[r5] = r20;
        goto L_0x000b;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.text.DynamicLayout.updateBlocks(int, int, int):void");
    }

    void setBlocksDataForTest(int[] blockEndLines, int[] blockIndices, int numberOfBlocks) {
        this.mBlockEndLines = new int[blockEndLines.length];
        this.mBlockIndices = new int[blockIndices.length];
        System.arraycopy(blockEndLines, TAB, this.mBlockEndLines, TAB, blockEndLines.length);
        System.arraycopy(blockIndices, TAB, this.mBlockIndices, TAB, blockIndices.length);
        this.mNumberOfBlocks = numberOfBlocks;
    }

    public int[] getBlockEndLines() {
        return this.mBlockEndLines;
    }

    public int[] getBlockIndices() {
        return this.mBlockIndices;
    }

    public int getNumberOfBlocks() {
        return this.mNumberOfBlocks;
    }

    public int getIndexFirstChangedBlock() {
        return this.mIndexFirstChangedBlock;
    }

    public void setIndexFirstChangedBlock(int i) {
        this.mIndexFirstChangedBlock = i;
    }

    public int getLineCount() {
        return this.mInts.size() + INVALID_BLOCK_INDEX;
    }

    public int getLineTop(int line) {
        return this.mInts.getValue(line, TOP);
    }

    public int getLineDescent(int line) {
        return this.mInts.getValue(line, DESCENT);
    }

    public int getLineStart(int line) {
        return this.mInts.getValue(line, TAB) & START_MASK;
    }

    public boolean getLineContainsTab(int line) {
        return (this.mInts.getValue(line, TAB) & TAB_MASK) != 0;
    }

    public int getParagraphDirection(int line) {
        return this.mInts.getValue(line, TAB) >> DIR_SHIFT;
    }

    public final Directions getLineDirections(int line) {
        return (Directions) this.mObjects.getValue(line, TAB);
    }

    public int getTopPadding() {
        return this.mTopPadding;
    }

    public int getBottomPadding() {
        return this.mBottomPadding;
    }

    public int getEllipsizedWidth() {
        return this.mEllipsizedWidth;
    }

    public int getEllipsisStart(int line) {
        if (this.mEllipsizeAt == null) {
            return TAB;
        }
        return this.mInts.getValue(line, ELLIPSIS_START);
    }

    public int getEllipsisCount(int line) {
        if (this.mEllipsizeAt == null) {
            return TAB;
        }
        return this.mInts.getValue(line, ELLIPSIS_COUNT);
    }

    static {
        sStaticLayout = new StaticLayout(null);
        sLock = new Object[TAB];
    }
}
