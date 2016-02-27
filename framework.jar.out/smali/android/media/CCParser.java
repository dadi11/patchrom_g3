package android.media;

import android.text.SpannableStringBuilder;
import android.text.style.StyleSpan;
import android.text.style.UnderlineSpan;
import android.util.Log;
import android.view.KeyEvent;
import android.view.accessibility.CaptioningManager.CaptionStyle;
import java.util.ArrayList;
import java.util.Arrays;

/* compiled from: ClosedCaptionRenderer */
class CCParser {
    private static final int AOF = 34;
    private static final int AON = 35;
    private static final int BS = 33;
    private static final int CR = 45;
    private static final boolean DEBUG;
    private static final int DER = 36;
    private static final int EDM = 44;
    private static final int ENM = 46;
    private static final int EOC = 47;
    private static final int FON = 40;
    private static final int INVALID = -1;
    public static final int MAX_COLS = 32;
    public static final int MAX_ROWS = 15;
    private static final int MODE_PAINT_ON = 1;
    private static final int MODE_POP_ON = 3;
    private static final int MODE_ROLL_UP = 2;
    private static final int MODE_TEXT = 4;
    private static final int MODE_UNKNOWN = 0;
    private static final int RCL = 32;
    private static final int RDC = 41;
    private static final int RTD = 43;
    private static final int RU2 = 37;
    private static final int RU3 = 38;
    private static final int RU4 = 39;
    private static final String TAG = "CCParser";
    private static final int TR = 42;
    private static final char TS = '\u00a0';
    private CCMemory mDisplay;
    private final DisplayListener mListener;
    private int mMode;
    private CCMemory mNonDisplay;
    private int mRollUpSize;
    private CCMemory mTextMem;

    /* compiled from: ClosedCaptionRenderer */
    private static class CCData {
        private static final String[] mCtrlCodeMap;
        private static final String[] mProtugueseCharMap;
        private static final String[] mSpanishCharMap;
        private static final String[] mSpecialCharMap;
        private final byte mData1;
        private final byte mData2;
        private final byte mType;

        static {
            mCtrlCodeMap = new String[]{"RCL", "BS", "AOF", "AON", "DER", "RU2", "RU3", "RU4", "FON", "RDC", "TR", "RTD", "EDM", "CR", "ENM", "EOC"};
            mSpecialCharMap = new String[]{"\u00ae", "\u00b0", "\u00bd", "\u00bf", "\u2122", "\u00a2", "\u00a3", "\u266a", "\u00e0", "\u00a0", "\u00e8", "\u00e2", "\u00ea", "\u00ee", "\u00f4", "\u00fb"};
            String[] strArr = new String[CCParser.RCL];
            strArr[CCParser.MODE_UNKNOWN] = "\u00c1";
            strArr[CCParser.MODE_PAINT_ON] = "\u00c9";
            strArr[CCParser.MODE_ROLL_UP] = "\u00d3";
            strArr[CCParser.MODE_POP_ON] = "\u00da";
            strArr[CCParser.MODE_TEXT] = "\u00dc";
            strArr[5] = "\u00fc";
            strArr[6] = "\u2018";
            strArr[7] = "\u00a1";
            strArr[8] = "*";
            strArr[9] = "'";
            strArr[10] = "\u2014";
            strArr[11] = "\u00a9";
            strArr[12] = "\u2120";
            strArr[13] = "\u2022";
            strArr[14] = "\u201c";
            strArr[CCParser.MAX_ROWS] = "\u201d";
            strArr[16] = "\u00c0";
            strArr[17] = "\u00c2";
            strArr[18] = "\u00c7";
            strArr[19] = "\u00c8";
            strArr[20] = "\u00ca";
            strArr[21] = "\u00cb";
            strArr[22] = "\u00eb";
            strArr[23] = "\u00ce";
            strArr[24] = "\u00cf";
            strArr[25] = "\u00ef";
            strArr[26] = "\u00d4";
            strArr[27] = "\u00d9";
            strArr[28] = "\u00f9";
            strArr[29] = "\u00db";
            strArr[30] = "\u00ab";
            strArr[31] = "\u00bb";
            mSpanishCharMap = strArr;
            strArr = new String[CCParser.RCL];
            strArr[CCParser.MODE_UNKNOWN] = "\u00c3";
            strArr[CCParser.MODE_PAINT_ON] = "\u00e3";
            strArr[CCParser.MODE_ROLL_UP] = "\u00cd";
            strArr[CCParser.MODE_POP_ON] = "\u00cc";
            strArr[CCParser.MODE_TEXT] = "\u00ec";
            strArr[5] = "\u00d2";
            strArr[6] = "\u00f2";
            strArr[7] = "\u00d5";
            strArr[8] = "\u00f5";
            strArr[9] = "{";
            strArr[10] = "}";
            strArr[11] = "\\";
            strArr[12] = "^";
            strArr[13] = "_";
            strArr[14] = "|";
            strArr[CCParser.MAX_ROWS] = "~";
            strArr[16] = "\u00c4";
            strArr[17] = "\u00e4";
            strArr[18] = "\u00d6";
            strArr[19] = "\u00f6";
            strArr[20] = "\u00df";
            strArr[21] = "\u00a5";
            strArr[22] = "\u00a4";
            strArr[23] = "\u2502";
            strArr[24] = "\u00c5";
            strArr[25] = "\u00e5";
            strArr[26] = "\u00d8";
            strArr[27] = "\u00f8";
            strArr[28] = "\u250c";
            strArr[29] = "\u2510";
            strArr[30] = "\u2514";
            strArr[31] = "\u2518";
            mProtugueseCharMap = strArr;
        }

        static CCData[] fromByteArray(byte[] data) {
            CCData[] ccData = new CCData[(data.length / CCParser.MODE_POP_ON)];
            for (int i = CCParser.MODE_UNKNOWN; i < ccData.length; i += CCParser.MODE_PAINT_ON) {
                ccData[i] = new CCData(data[i * CCParser.MODE_POP_ON], data[(i * CCParser.MODE_POP_ON) + CCParser.MODE_PAINT_ON], data[(i * CCParser.MODE_POP_ON) + CCParser.MODE_ROLL_UP]);
            }
            return ccData;
        }

        CCData(byte type, byte data1, byte data2) {
            this.mType = type;
            this.mData1 = data1;
            this.mData2 = data2;
        }

        int getCtrlCode() {
            if ((this.mData1 == 20 || this.mData1 == 28) && this.mData2 >= CCParser.RCL && this.mData2 <= CCParser.EOC) {
                return this.mData2;
            }
            return CCParser.INVALID;
        }

        StyleCode getMidRow() {
            if ((this.mData1 == 17 || this.mData1 == 25) && this.mData2 >= CCParser.RCL && this.mData2 <= CCParser.EOC) {
                return StyleCode.fromByte(this.mData2);
            }
            return null;
        }

        PAC getPAC() {
            if ((this.mData1 & KeyEvent.KEYCODE_FORWARD_DEL) == 16 && (this.mData2 & 64) == 64 && ((this.mData1 & 7) != 0 || (this.mData2 & CCParser.RCL) == 0)) {
                return PAC.fromBytes(this.mData1, this.mData2);
            }
            return null;
        }

        int getTabOffset() {
            if ((this.mData1 == 23 || this.mData1 == 31) && this.mData2 >= CCParser.BS && this.mData2 <= CCParser.AON) {
                return this.mData2 & CCParser.MODE_POP_ON;
            }
            return CCParser.MODE_UNKNOWN;
        }

        boolean isDisplayableChar() {
            return (isBasicChar() || isSpecialChar() || isExtendedChar()) ? true : CCParser.DEBUG;
        }

        String getDisplayText() {
            String str = getBasicChars();
            if (str != null) {
                return str;
            }
            str = getSpecialChar();
            if (str == null) {
                return getExtendedChar();
            }
            return str;
        }

        private String ctrlCodeToString(int ctrlCode) {
            return mCtrlCodeMap[ctrlCode - 32];
        }

        private boolean isBasicChar() {
            return (this.mData1 < CCParser.RCL || this.mData1 > 127) ? CCParser.DEBUG : true;
        }

        private boolean isSpecialChar() {
            return ((this.mData1 == 17 || this.mData1 == 25) && this.mData2 >= 48 && this.mData2 <= 63) ? true : CCParser.DEBUG;
        }

        private boolean isExtendedChar() {
            return ((this.mData1 == 18 || this.mData1 == 26 || this.mData1 == 19 || this.mData1 == 27) && this.mData2 >= CCParser.RCL && this.mData2 <= 63) ? true : CCParser.DEBUG;
        }

        private char getBasicChar(byte data) {
            switch (data) {
                case CCParser.TR /*42*/:
                    return '\u00e1';
                case KeyEvent.KEYCODE_PAGE_UP /*92*/:
                    return '\u00e9';
                case KeyEvent.KEYCODE_PICTSYMBOLS /*94*/:
                    return '\u00ed';
                case KeyEvent.KEYCODE_SWITCH_CHARSET /*95*/:
                    return '\u00f3';
                case KeyEvent.KEYCODE_BUTTON_A /*96*/:
                    return '\u00fa';
                case KeyEvent.KEYCODE_MOVE_END /*123*/:
                    return '\u00e7';
                case KeyEvent.KEYCODE_INSERT /*124*/:
                    return '\u00f7';
                case KeyEvent.KEYCODE_FORWARD /*125*/:
                    return '\u00d1';
                case KeyEvent.KEYCODE_MEDIA_PLAY /*126*/:
                    return '\u00f1';
                case KeyEvent.KEYCODE_MEDIA_PAUSE /*127*/:
                    return '\u2588';
                default:
                    return (char) data;
            }
        }

        private String getBasicChars() {
            if (this.mData1 < (byte) 32 || this.mData1 > Byte.MAX_VALUE) {
                return null;
            }
            StringBuilder builder = new StringBuilder(CCParser.MODE_ROLL_UP);
            builder.append(getBasicChar(this.mData1));
            if (this.mData2 >= (byte) 32 && this.mData2 <= Byte.MAX_VALUE) {
                builder.append(getBasicChar(this.mData2));
            }
            return builder.toString();
        }

        private String getSpecialChar() {
            if ((this.mData1 == 17 || this.mData1 == 25) && this.mData2 >= 48 && this.mData2 <= 63) {
                return mSpecialCharMap[this.mData2 - 48];
            }
            return null;
        }

        private String getExtendedChar() {
            if ((this.mData1 == 18 || this.mData1 == 26) && this.mData2 >= (byte) 32 && this.mData2 <= (byte) 63) {
                return mSpanishCharMap[this.mData2 - 32];
            }
            if ((this.mData1 == 19 || this.mData1 == 27) && this.mData2 >= (byte) 32 && this.mData2 <= (byte) 63) {
                return mProtugueseCharMap[this.mData2 - 32];
            }
            return null;
        }

        public String toString() {
            Object[] objArr;
            if (this.mData1 >= (byte) 16 || this.mData2 >= (byte) 16) {
                int ctrlCode = getCtrlCode();
                if (ctrlCode != CCParser.INVALID) {
                    objArr = new Object[CCParser.MODE_ROLL_UP];
                    objArr[CCParser.MODE_UNKNOWN] = Byte.valueOf(this.mType);
                    objArr[CCParser.MODE_PAINT_ON] = ctrlCodeToString(ctrlCode);
                    return String.format("[%d]%s", objArr);
                }
                int tabOffset = getTabOffset();
                if (tabOffset > 0) {
                    objArr = new Object[CCParser.MODE_ROLL_UP];
                    objArr[CCParser.MODE_UNKNOWN] = Byte.valueOf(this.mType);
                    objArr[CCParser.MODE_PAINT_ON] = Integer.valueOf(tabOffset);
                    return String.format("[%d]Tab%d", objArr);
                }
                PAC pac = getPAC();
                if (pac != null) {
                    objArr = new Object[CCParser.MODE_ROLL_UP];
                    objArr[CCParser.MODE_UNKNOWN] = Byte.valueOf(this.mType);
                    objArr[CCParser.MODE_PAINT_ON] = pac.toString();
                    return String.format("[%d]PAC: %s", objArr);
                }
                StyleCode m = getMidRow();
                if (m != null) {
                    objArr = new Object[CCParser.MODE_ROLL_UP];
                    objArr[CCParser.MODE_UNKNOWN] = Byte.valueOf(this.mType);
                    objArr[CCParser.MODE_PAINT_ON] = m.toString();
                    return String.format("[%d]Mid-row: %s", objArr);
                } else if (isDisplayableChar()) {
                    objArr = new Object[CCParser.MODE_TEXT];
                    objArr[CCParser.MODE_UNKNOWN] = Byte.valueOf(this.mType);
                    objArr[CCParser.MODE_PAINT_ON] = getDisplayText();
                    objArr[CCParser.MODE_ROLL_UP] = Byte.valueOf(this.mData1);
                    objArr[CCParser.MODE_POP_ON] = Byte.valueOf(this.mData2);
                    return String.format("[%d]Displayable: %s (%02x %02x)", objArr);
                } else {
                    objArr = new Object[CCParser.MODE_POP_ON];
                    objArr[CCParser.MODE_UNKNOWN] = Byte.valueOf(this.mType);
                    objArr[CCParser.MODE_PAINT_ON] = Byte.valueOf(this.mData1);
                    objArr[CCParser.MODE_ROLL_UP] = Byte.valueOf(this.mData2);
                    return String.format("[%d]Invalid: %02x %02x", objArr);
                }
            }
            objArr = new Object[CCParser.MODE_POP_ON];
            objArr[CCParser.MODE_UNKNOWN] = Byte.valueOf(this.mType);
            objArr[CCParser.MODE_PAINT_ON] = Byte.valueOf(this.mData1);
            objArr[CCParser.MODE_ROLL_UP] = Byte.valueOf(this.mData2);
            return String.format("[%d]Null: %02x %02x", objArr);
        }
    }

    /* compiled from: ClosedCaptionRenderer */
    private static class CCLineBuilder {
        private final StringBuilder mDisplayChars;
        private final StyleCode[] mMidRowStyles;
        private final StyleCode[] mPACStyles;

        CCLineBuilder(String str) {
            this.mDisplayChars = new StringBuilder(str);
            this.mMidRowStyles = new StyleCode[this.mDisplayChars.length()];
            this.mPACStyles = new StyleCode[this.mDisplayChars.length()];
        }

        void setCharAt(int index, char ch) {
            this.mDisplayChars.setCharAt(index, ch);
            this.mMidRowStyles[index] = null;
        }

        void setMidRowAt(int index, StyleCode m) {
            this.mDisplayChars.setCharAt(index, ' ');
            this.mMidRowStyles[index] = m;
        }

        void setPACAt(int index, PAC pac) {
            this.mPACStyles[index] = pac;
        }

        char charAt(int index) {
            return this.mDisplayChars.charAt(index);
        }

        int length() {
            return this.mDisplayChars.length();
        }

        void applyStyleSpan(SpannableStringBuilder styledText, StyleCode s, int start, int end) {
            if (s.isItalics()) {
                styledText.setSpan(new StyleSpan((int) CCParser.MODE_ROLL_UP), start, end, CCParser.BS);
            }
            if (s.isUnderline()) {
                styledText.setSpan(new UnderlineSpan(), start, end, CCParser.BS);
            }
        }

        SpannableStringBuilder getStyledText(CaptionStyle captionStyle) {
            SpannableStringBuilder styledText = new SpannableStringBuilder(this.mDisplayChars);
            int start = CCParser.INVALID;
            int next = CCParser.MODE_UNKNOWN;
            int styleStart = CCParser.INVALID;
            StyleCode curStyle = null;
            while (next < this.mDisplayChars.length()) {
                StyleCode newStyle = null;
                if (this.mMidRowStyles[next] != null) {
                    newStyle = this.mMidRowStyles[next];
                } else if (this.mPACStyles[next] != null && (styleStart < 0 || start < 0)) {
                    newStyle = this.mPACStyles[next];
                }
                if (newStyle != null) {
                    curStyle = newStyle;
                    if (styleStart >= 0 && start >= 0) {
                        applyStyleSpan(styledText, newStyle, styleStart, next);
                    }
                    styleStart = next;
                }
                if (this.mDisplayChars.charAt(next) != CCParser.TS) {
                    if (start < 0) {
                        start = next;
                    }
                } else if (start >= 0) {
                    int expandedStart = this.mDisplayChars.charAt(start) == ' ' ? start : start + CCParser.INVALID;
                    int expandedEnd = this.mDisplayChars.charAt(next + CCParser.INVALID) == ' ' ? next : next + CCParser.MODE_PAINT_ON;
                    styledText.setSpan(new MutableBackgroundColorSpan(captionStyle.backgroundColor), expandedStart, expandedEnd, CCParser.BS);
                    if (styleStart >= 0) {
                        applyStyleSpan(styledText, curStyle, styleStart, expandedEnd);
                    }
                    start = CCParser.INVALID;
                }
                next += CCParser.MODE_PAINT_ON;
            }
            return styledText;
        }
    }

    /* compiled from: ClosedCaptionRenderer */
    private static class CCMemory {
        private final String mBlankLine;
        private int mCol;
        private final CCLineBuilder[] mLines;
        private int mRow;

        CCMemory() {
            this.mLines = new CCLineBuilder[17];
            char[] blank = new char[CCParser.AOF];
            Arrays.fill(blank, CCParser.TS);
            this.mBlankLine = new String(blank);
        }

        void erase() {
            for (int i = CCParser.MODE_UNKNOWN; i < this.mLines.length; i += CCParser.MODE_PAINT_ON) {
                this.mLines[i] = null;
            }
            this.mRow = CCParser.MAX_ROWS;
            this.mCol = CCParser.MODE_PAINT_ON;
        }

        void der() {
            if (this.mLines[this.mRow] != null) {
                for (int i = CCParser.MODE_UNKNOWN; i < this.mCol; i += CCParser.MODE_PAINT_ON) {
                    if (this.mLines[this.mRow].charAt(i) != CCParser.TS) {
                        for (int j = this.mCol; j < this.mLines[this.mRow].length(); j += CCParser.MODE_PAINT_ON) {
                            this.mLines[j].setCharAt(j, CCParser.TS);
                        }
                        return;
                    }
                }
                this.mLines[this.mRow] = null;
            }
        }

        void tab(int tabs) {
            moveCursorByCol(tabs);
        }

        void bs() {
            moveCursorByCol(CCParser.INVALID);
            if (this.mLines[this.mRow] != null) {
                this.mLines[this.mRow].setCharAt(this.mCol, CCParser.TS);
                if (this.mCol == 31) {
                    this.mLines[this.mRow].setCharAt(CCParser.RCL, CCParser.TS);
                }
            }
        }

        void cr() {
            moveCursorTo(this.mRow + CCParser.MODE_PAINT_ON, CCParser.MODE_PAINT_ON);
        }

        void rollUp(int windowSize) {
            int i;
            for (i = CCParser.MODE_UNKNOWN; i <= this.mRow - windowSize; i += CCParser.MODE_PAINT_ON) {
                this.mLines[i] = null;
            }
            int startRow = (this.mRow - windowSize) + CCParser.MODE_PAINT_ON;
            if (startRow < CCParser.MODE_PAINT_ON) {
                startRow = CCParser.MODE_PAINT_ON;
            }
            for (i = startRow; i < this.mRow; i += CCParser.MODE_PAINT_ON) {
                this.mLines[i] = this.mLines[i + CCParser.MODE_PAINT_ON];
            }
            for (i = this.mRow; i < this.mLines.length; i += CCParser.MODE_PAINT_ON) {
                this.mLines[i] = null;
            }
            this.mCol = CCParser.MODE_PAINT_ON;
        }

        void writeText(String text) {
            for (int i = CCParser.MODE_UNKNOWN; i < text.length(); i += CCParser.MODE_PAINT_ON) {
                getLineBuffer(this.mRow).setCharAt(this.mCol, text.charAt(i));
                moveCursorByCol(CCParser.MODE_PAINT_ON);
            }
        }

        void writeMidRowCode(StyleCode m) {
            getLineBuffer(this.mRow).setMidRowAt(this.mCol, m);
            moveCursorByCol(CCParser.MODE_PAINT_ON);
        }

        void writePAC(PAC pac) {
            if (pac.isIndentPAC()) {
                moveCursorTo(pac.getRow(), pac.getCol());
            } else {
                moveCursorTo(pac.getRow(), CCParser.MODE_PAINT_ON);
            }
            getLineBuffer(this.mRow).setPACAt(this.mCol, pac);
        }

        SpannableStringBuilder[] getStyledText(CaptionStyle captionStyle) {
            ArrayList<SpannableStringBuilder> rows = new ArrayList(CCParser.MAX_ROWS);
            for (int i = CCParser.MODE_PAINT_ON; i <= CCParser.MAX_ROWS; i += CCParser.MODE_PAINT_ON) {
                rows.add(this.mLines[i] != null ? this.mLines[i].getStyledText(captionStyle) : null);
            }
            return (SpannableStringBuilder[]) rows.toArray(new SpannableStringBuilder[CCParser.MAX_ROWS]);
        }

        private static int clamp(int x, int min, int max) {
            if (x < min) {
                return min;
            }
            return x > max ? max : x;
        }

        private void moveCursorTo(int row, int col) {
            this.mRow = clamp(row, CCParser.MODE_PAINT_ON, CCParser.MAX_ROWS);
            this.mCol = clamp(col, CCParser.MODE_PAINT_ON, CCParser.RCL);
        }

        private void moveCursorToRow(int row) {
            this.mRow = clamp(row, CCParser.MODE_PAINT_ON, CCParser.MAX_ROWS);
        }

        private void moveCursorByCol(int col) {
            this.mCol = clamp(this.mCol + col, CCParser.MODE_PAINT_ON, CCParser.RCL);
        }

        private void moveBaselineTo(int baseRow, int windowSize) {
            if (this.mRow != baseRow) {
                int i;
                int actualWindowSize = windowSize;
                if (baseRow < actualWindowSize) {
                    actualWindowSize = baseRow;
                }
                if (this.mRow < actualWindowSize) {
                    actualWindowSize = this.mRow;
                }
                if (baseRow < this.mRow) {
                    for (i = actualWindowSize + CCParser.INVALID; i >= 0; i += CCParser.INVALID) {
                        this.mLines[baseRow - i] = this.mLines[this.mRow - i];
                    }
                } else {
                    for (i = CCParser.MODE_UNKNOWN; i < actualWindowSize; i += CCParser.MODE_PAINT_ON) {
                        this.mLines[baseRow - i] = this.mLines[this.mRow - i];
                    }
                }
                for (i = CCParser.MODE_UNKNOWN; i <= baseRow - windowSize; i += CCParser.MODE_PAINT_ON) {
                    this.mLines[i] = null;
                }
                for (i = baseRow + CCParser.MODE_PAINT_ON; i < this.mLines.length; i += CCParser.MODE_PAINT_ON) {
                    this.mLines[i] = null;
                }
            }
        }

        private CCLineBuilder getLineBuffer(int row) {
            if (this.mLines[row] == null) {
                this.mLines[row] = new CCLineBuilder(this.mBlankLine);
            }
            return this.mLines[row];
        }
    }

    /* compiled from: ClosedCaptionRenderer */
    interface DisplayListener {
        CaptionStyle getCaptionStyle();

        void onDisplayChanged(SpannableStringBuilder[] spannableStringBuilderArr);
    }

    /* compiled from: ClosedCaptionRenderer */
    private static class StyleCode {
        static final int COLOR_BLUE = 2;
        static final int COLOR_CYAN = 3;
        static final int COLOR_GREEN = 1;
        static final int COLOR_INVALID = 7;
        static final int COLOR_MAGENTA = 6;
        static final int COLOR_RED = 4;
        static final int COLOR_WHITE = 0;
        static final int COLOR_YELLOW = 5;
        static final int STYLE_ITALICS = 1;
        static final int STYLE_UNDERLINE = 2;
        static final String[] mColorMap;
        final int mColor;
        final int mStyle;

        static {
            mColorMap = new String[]{"WHITE", "GREEN", "BLUE", "CYAN", "RED", "YELLOW", "MAGENTA", "INVALID"};
        }

        static StyleCode fromByte(byte data2) {
            int style = COLOR_WHITE;
            int color = (data2 >> STYLE_ITALICS) & COLOR_INVALID;
            if ((data2 & STYLE_ITALICS) != 0) {
                style = COLOR_WHITE | STYLE_UNDERLINE;
            }
            if (color == COLOR_INVALID) {
                color = COLOR_WHITE;
                style |= STYLE_ITALICS;
            }
            return new StyleCode(style, color);
        }

        StyleCode(int style, int color) {
            this.mStyle = style;
            this.mColor = color;
        }

        boolean isItalics() {
            return (this.mStyle & STYLE_ITALICS) != 0 ? true : CCParser.DEBUG;
        }

        boolean isUnderline() {
            return (this.mStyle & STYLE_UNDERLINE) != 0 ? true : CCParser.DEBUG;
        }

        int getColor() {
            return this.mColor;
        }

        public String toString() {
            StringBuilder str = new StringBuilder();
            str.append("{");
            str.append(mColorMap[this.mColor]);
            if ((this.mStyle & STYLE_ITALICS) != 0) {
                str.append(", ITALICS");
            }
            if ((this.mStyle & STYLE_UNDERLINE) != 0) {
                str.append(", UNDERLINE");
            }
            str.append("}");
            return str.toString();
        }
    }

    /* compiled from: ClosedCaptionRenderer */
    private static class PAC extends StyleCode {
        final int mCol;
        final int mRow;

        static PAC fromBytes(byte data1, byte data2) {
            int row = new int[]{11, CCParser.MODE_PAINT_ON, CCParser.MODE_POP_ON, 12, 14, 5, 7, 9}[data1 & 7] + ((data2 & CCParser.RCL) >> 5);
            int style = CCParser.MODE_UNKNOWN;
            if ((data2 & CCParser.MODE_PAINT_ON) != 0) {
                style = CCParser.MODE_UNKNOWN | CCParser.MODE_ROLL_UP;
            }
            if ((data2 & 16) != 0) {
                return new PAC(row, ((data2 >> CCParser.MODE_PAINT_ON) & 7) * CCParser.MODE_TEXT, style, CCParser.MODE_UNKNOWN);
            }
            int color = (data2 >> CCParser.MODE_PAINT_ON) & 7;
            if (color == 7) {
                color = CCParser.MODE_UNKNOWN;
                style |= CCParser.MODE_PAINT_ON;
            }
            return new PAC(row, CCParser.INVALID, style, color);
        }

        PAC(int row, int col, int style, int color) {
            super(style, color);
            this.mRow = row;
            this.mCol = col;
        }

        boolean isIndentPAC() {
            return this.mCol >= 0 ? true : CCParser.DEBUG;
        }

        int getRow() {
            return this.mRow;
        }

        int getCol() {
            return this.mCol;
        }

        public String toString() {
            Object[] objArr = new Object[CCParser.MODE_POP_ON];
            objArr[CCParser.MODE_UNKNOWN] = Integer.valueOf(this.mRow);
            objArr[CCParser.MODE_PAINT_ON] = Integer.valueOf(this.mCol);
            objArr[CCParser.MODE_ROLL_UP] = super.toString();
            return String.format("{%d, %d}, %s", objArr);
        }
    }

    static {
        DEBUG = Log.isLoggable(TAG, MODE_POP_ON);
    }

    CCParser(DisplayListener listener) {
        this.mMode = MODE_PAINT_ON;
        this.mRollUpSize = MODE_TEXT;
        this.mDisplay = new CCMemory();
        this.mNonDisplay = new CCMemory();
        this.mTextMem = new CCMemory();
        this.mListener = listener;
    }

    void parse(byte[] data) {
        CCData[] ccData = CCData.fromByteArray(data);
        int i = MODE_UNKNOWN;
        while (i < ccData.length) {
            if (DEBUG) {
                Log.d(TAG, ccData[i].toString());
            }
            if (!(handleCtrlCode(ccData[i]) || handleTabOffsets(ccData[i]) || handlePACCode(ccData[i]) || handleMidRowCode(ccData[i]))) {
                handleDisplayableChars(ccData[i]);
            }
            i += MODE_PAINT_ON;
        }
    }

    private CCMemory getMemory() {
        switch (this.mMode) {
            case MODE_PAINT_ON /*1*/:
            case MODE_ROLL_UP /*2*/:
                return this.mDisplay;
            case MODE_POP_ON /*3*/:
                return this.mNonDisplay;
            case MODE_TEXT /*4*/:
                return this.mTextMem;
            default:
                Log.w(TAG, "unrecoginized mode: " + this.mMode);
                return this.mDisplay;
        }
    }

    private boolean handleDisplayableChars(CCData ccData) {
        if (!ccData.isDisplayableChar()) {
            return DEBUG;
        }
        if (ccData.isExtendedChar()) {
            getMemory().bs();
        }
        getMemory().writeText(ccData.getDisplayText());
        if (this.mMode != MODE_PAINT_ON && this.mMode != MODE_ROLL_UP) {
            return true;
        }
        updateDisplay();
        return true;
    }

    private boolean handleMidRowCode(CCData ccData) {
        StyleCode m = ccData.getMidRow();
        if (m == null) {
            return DEBUG;
        }
        getMemory().writeMidRowCode(m);
        return true;
    }

    private boolean handlePACCode(CCData ccData) {
        PAC pac = ccData.getPAC();
        if (pac == null) {
            return DEBUG;
        }
        if (this.mMode == MODE_ROLL_UP) {
            getMemory().moveBaselineTo(pac.getRow(), this.mRollUpSize);
        }
        getMemory().writePAC(pac);
        return true;
    }

    private boolean handleTabOffsets(CCData ccData) {
        int tabs = ccData.getTabOffset();
        if (tabs <= 0) {
            return DEBUG;
        }
        getMemory().tab(tabs);
        return true;
    }

    private boolean handleCtrlCode(CCData ccData) {
        int ctrlCode = ccData.getCtrlCode();
        switch (ctrlCode) {
            case RCL /*32*/:
                this.mMode = MODE_POP_ON;
                return true;
            case BS /*33*/:
                getMemory().bs();
                return true;
            case DER /*36*/:
                getMemory().der();
                return true;
            case RU2 /*37*/:
            case RU3 /*38*/:
            case RU4 /*39*/:
                this.mRollUpSize = ctrlCode - 35;
                if (this.mMode != MODE_ROLL_UP) {
                    this.mDisplay.erase();
                    this.mNonDisplay.erase();
                }
                this.mMode = MODE_ROLL_UP;
                return true;
            case FON /*40*/:
                Log.i(TAG, "Flash On");
                return true;
            case RDC /*41*/:
                this.mMode = MODE_PAINT_ON;
                return true;
            case TR /*42*/:
                this.mMode = MODE_TEXT;
                this.mTextMem.erase();
                return true;
            case RTD /*43*/:
                this.mMode = MODE_TEXT;
                return true;
            case EDM /*44*/:
                this.mDisplay.erase();
                updateDisplay();
                return true;
            case CR /*45*/:
                if (this.mMode == MODE_ROLL_UP) {
                    getMemory().rollUp(this.mRollUpSize);
                } else {
                    getMemory().cr();
                }
                if (this.mMode != MODE_ROLL_UP) {
                    return true;
                }
                updateDisplay();
                return true;
            case ENM /*46*/:
                this.mNonDisplay.erase();
                return true;
            case EOC /*47*/:
                swapMemory();
                this.mMode = MODE_POP_ON;
                updateDisplay();
                return true;
            default:
                return DEBUG;
        }
    }

    private void updateDisplay() {
        if (this.mListener != null) {
            this.mListener.onDisplayChanged(this.mDisplay.getStyledText(this.mListener.getCaptionStyle()));
        }
    }

    private void swapMemory() {
        CCMemory temp = this.mDisplay;
        this.mDisplay = this.mNonDisplay;
        this.mNonDisplay = temp;
    }
}
