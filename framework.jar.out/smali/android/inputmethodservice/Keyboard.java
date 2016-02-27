package android.inputmethodservice;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.graphics.drawable.Drawable;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.util.Log;
import android.util.TypedValue;
import android.util.Xml;
import com.android.internal.R;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import org.xmlpull.v1.XmlPullParserException;

public class Keyboard {
    public static final int EDGE_BOTTOM = 8;
    public static final int EDGE_LEFT = 1;
    public static final int EDGE_RIGHT = 2;
    public static final int EDGE_TOP = 4;
    private static final int GRID_HEIGHT = 5;
    private static final int GRID_SIZE = 50;
    private static final int GRID_WIDTH = 10;
    public static final int KEYCODE_ALT = -6;
    public static final int KEYCODE_CANCEL = -3;
    public static final int KEYCODE_DELETE = -5;
    public static final int KEYCODE_DONE = -4;
    public static final int KEYCODE_MODE_CHANGE = -2;
    public static final int KEYCODE_SHIFT = -1;
    private static float SEARCH_DISTANCE = 0.0f;
    static final String TAG = "Keyboard";
    private static final String TAG_KEY = "Key";
    private static final String TAG_KEYBOARD = "Keyboard";
    private static final String TAG_ROW = "Row";
    private int mCellHeight;
    private int mCellWidth;
    private int mDefaultHeight;
    private int mDefaultHorizontalGap;
    private int mDefaultVerticalGap;
    private int mDefaultWidth;
    private int mDisplayHeight;
    private int mDisplayWidth;
    private int[][] mGridNeighbors;
    private int mKeyHeight;
    private int mKeyWidth;
    private int mKeyboardMode;
    private List<Key> mKeys;
    private CharSequence mLabel;
    private List<Key> mModifierKeys;
    private int mProximityThreshold;
    private int[] mShiftKeyIndices;
    private Key[] mShiftKeys;
    private boolean mShifted;
    private int mTotalHeight;
    private int mTotalWidth;
    private ArrayList<Row> rows;

    public static class Key {
        private static final int[] KEY_STATE_NORMAL;
        private static final int[] KEY_STATE_NORMAL_OFF;
        private static final int[] KEY_STATE_NORMAL_ON;
        private static final int[] KEY_STATE_PRESSED;
        private static final int[] KEY_STATE_PRESSED_OFF;
        private static final int[] KEY_STATE_PRESSED_ON;
        public int[] codes;
        public int edgeFlags;
        public int gap;
        public int height;
        public Drawable icon;
        public Drawable iconPreview;
        private Keyboard keyboard;
        public CharSequence label;
        public boolean modifier;
        public boolean on;
        public CharSequence popupCharacters;
        public int popupResId;
        public boolean pressed;
        public boolean repeatable;
        public boolean sticky;
        public CharSequence text;
        public int width;
        public int f18x;
        public int f19y;

        static {
            KEY_STATE_NORMAL_ON = new int[]{16842911, 16842912};
            KEY_STATE_PRESSED_ON = new int[]{16842919, 16842911, 16842912};
            int[] iArr = new int[Keyboard.EDGE_LEFT];
            iArr[0] = 16842911;
            KEY_STATE_NORMAL_OFF = iArr;
            KEY_STATE_PRESSED_OFF = new int[]{16842919, 16842911};
            KEY_STATE_NORMAL = new int[0];
            iArr = new int[Keyboard.EDGE_LEFT];
            iArr[0] = 16842919;
            KEY_STATE_PRESSED = iArr;
        }

        public Key(Row parent) {
            this.keyboard = parent.parent;
            this.height = parent.defaultHeight;
            this.width = parent.defaultWidth;
            this.gap = parent.defaultHorizontalGap;
            this.edgeFlags = parent.rowEdgeFlags;
        }

        public Key(Resources res, Row parent, int x, int y, XmlResourceParser parser) {
            this(parent);
            this.f18x = x;
            this.f19y = y;
            TypedArray a = res.obtainAttributes(Xml.asAttributeSet(parser), R.styleable.Keyboard);
            this.width = Keyboard.getDimensionOrFraction(a, 0, this.keyboard.mDisplayWidth, parent.defaultWidth);
            this.height = Keyboard.getDimensionOrFraction(a, Keyboard.EDGE_LEFT, this.keyboard.mDisplayHeight, parent.defaultHeight);
            this.gap = Keyboard.getDimensionOrFraction(a, Keyboard.EDGE_RIGHT, this.keyboard.mDisplayWidth, parent.defaultHorizontalGap);
            a.recycle();
            a = res.obtainAttributes(Xml.asAttributeSet(parser), R.styleable.Keyboard_Key);
            this.f18x += this.gap;
            TypedValue codesValue = new TypedValue();
            a.getValue(0, codesValue);
            if (codesValue.type == 16 || codesValue.type == 17) {
                int[] iArr = new int[Keyboard.EDGE_LEFT];
                iArr[0] = codesValue.data;
                this.codes = iArr;
            } else if (codesValue.type == 3) {
                this.codes = parseCSV(codesValue.string.toString());
            }
            this.iconPreview = a.getDrawable(7);
            if (this.iconPreview != null) {
                this.iconPreview.setBounds(0, 0, this.iconPreview.getIntrinsicWidth(), this.iconPreview.getIntrinsicHeight());
            }
            this.popupCharacters = a.getText(Keyboard.EDGE_RIGHT);
            this.popupResId = a.getResourceId(Keyboard.EDGE_LEFT, 0);
            this.repeatable = a.getBoolean(6, false);
            this.modifier = a.getBoolean(Keyboard.EDGE_TOP, false);
            this.sticky = a.getBoolean(Keyboard.GRID_HEIGHT, false);
            this.edgeFlags = a.getInt(3, 0);
            this.edgeFlags |= parent.rowEdgeFlags;
            this.icon = a.getDrawable(Keyboard.GRID_WIDTH);
            if (this.icon != null) {
                this.icon.setBounds(0, 0, this.icon.getIntrinsicWidth(), this.icon.getIntrinsicHeight());
            }
            this.label = a.getText(9);
            this.text = a.getText(Keyboard.EDGE_BOTTOM);
            if (this.codes == null && !TextUtils.isEmpty(this.label)) {
                iArr = new int[Keyboard.EDGE_LEFT];
                iArr[0] = this.label.charAt(0);
                this.codes = iArr;
            }
            a.recycle();
        }

        public void onPressed() {
            this.pressed = !this.pressed;
        }

        public void onReleased(boolean inside) {
            boolean z;
            boolean z2 = true;
            if (this.pressed) {
                z = false;
            } else {
                z = true;
            }
            this.pressed = z;
            if (this.sticky) {
                if (this.on) {
                    z2 = false;
                }
                this.on = z2;
            }
        }

        int[] parseCSV(String value) {
            int count = 0;
            int lastIndex = 0;
            if (value.length() > 0) {
                count = 0 + Keyboard.EDGE_LEFT;
                while (true) {
                    lastIndex = value.indexOf(",", lastIndex + Keyboard.EDGE_LEFT);
                    if (lastIndex <= 0) {
                        break;
                    }
                    count += Keyboard.EDGE_LEFT;
                }
            }
            int[] values = new int[count];
            count = 0;
            StringTokenizer st = new StringTokenizer(value, ",");
            while (st.hasMoreTokens()) {
                int count2 = count + Keyboard.EDGE_LEFT;
                try {
                    values[count] = Integer.parseInt(st.nextToken());
                    count = count2;
                } catch (NumberFormatException e) {
                    Log.e(Keyboard.TAG_KEYBOARD, "Error parsing keycodes " + value);
                    count = count2;
                }
            }
            return values;
        }

        public boolean isInside(int x, int y) {
            boolean bottomEdge;
            boolean leftEdge;
            if ((this.edgeFlags & Keyboard.EDGE_LEFT) > 0) {
                leftEdge = true;
            } else {
                leftEdge = false;
            }
            boolean rightEdge;
            if ((this.edgeFlags & Keyboard.EDGE_RIGHT) > 0) {
                rightEdge = true;
            } else {
                rightEdge = false;
            }
            boolean topEdge;
            if ((this.edgeFlags & Keyboard.EDGE_TOP) > 0) {
                topEdge = true;
            } else {
                topEdge = false;
            }
            if ((this.edgeFlags & Keyboard.EDGE_BOTTOM) > 0) {
                bottomEdge = true;
            } else {
                bottomEdge = false;
            }
            if ((x >= this.f18x || (leftEdge && x <= this.f18x + this.width)) && ((x < this.f18x + this.width || (rightEdge && x >= this.f18x)) && (y >= this.f19y || (topEdge && y <= this.f19y + this.height)))) {
                if (y < this.f19y + this.height) {
                    return true;
                }
                if (bottomEdge && y >= this.f19y) {
                    return true;
                }
            }
            return false;
        }

        public int squaredDistanceFrom(int x, int y) {
            int xDist = (this.f18x + (this.width / Keyboard.EDGE_RIGHT)) - x;
            int yDist = (this.f19y + (this.height / Keyboard.EDGE_RIGHT)) - y;
            return (xDist * xDist) + (yDist * yDist);
        }

        public int[] getCurrentDrawableState() {
            int[] states = KEY_STATE_NORMAL;
            if (this.on) {
                if (this.pressed) {
                    return KEY_STATE_PRESSED_ON;
                }
                return KEY_STATE_NORMAL_ON;
            } else if (this.sticky) {
                if (this.pressed) {
                    return KEY_STATE_PRESSED_OFF;
                }
                return KEY_STATE_NORMAL_OFF;
            } else if (this.pressed) {
                return KEY_STATE_PRESSED;
            } else {
                return states;
            }
        }
    }

    public static class Row {
        public int defaultHeight;
        public int defaultHorizontalGap;
        public int defaultWidth;
        ArrayList<Key> mKeys;
        public int mode;
        private Keyboard parent;
        public int rowEdgeFlags;
        public int verticalGap;

        public Row(Keyboard parent) {
            this.mKeys = new ArrayList();
            this.parent = parent;
        }

        public Row(Resources res, Keyboard parent, XmlResourceParser parser) {
            this.mKeys = new ArrayList();
            this.parent = parent;
            TypedArray a = res.obtainAttributes(Xml.asAttributeSet(parser), R.styleable.Keyboard);
            this.defaultWidth = Keyboard.getDimensionOrFraction(a, 0, parent.mDisplayWidth, parent.mDefaultWidth);
            this.defaultHeight = Keyboard.getDimensionOrFraction(a, Keyboard.EDGE_LEFT, parent.mDisplayHeight, parent.mDefaultHeight);
            this.defaultHorizontalGap = Keyboard.getDimensionOrFraction(a, Keyboard.EDGE_RIGHT, parent.mDisplayWidth, parent.mDefaultHorizontalGap);
            this.verticalGap = Keyboard.getDimensionOrFraction(a, 3, parent.mDisplayHeight, parent.mDefaultVerticalGap);
            a.recycle();
            a = res.obtainAttributes(Xml.asAttributeSet(parser), R.styleable.Keyboard_Row);
            this.rowEdgeFlags = a.getInt(0, 0);
            this.mode = a.getResourceId(Keyboard.EDGE_LEFT, 0);
        }
    }

    static {
        SEARCH_DISTANCE = 1.8f;
    }

    public Keyboard(Context context, int xmlLayoutResId) {
        this(context, xmlLayoutResId, 0);
    }

    public Keyboard(Context context, int xmlLayoutResId, int modeId, int width, int height) {
        Key[] keyArr = new Key[EDGE_RIGHT];
        keyArr[0] = null;
        keyArr[EDGE_LEFT] = null;
        this.mShiftKeys = keyArr;
        this.mShiftKeyIndices = new int[]{KEYCODE_SHIFT, KEYCODE_SHIFT};
        this.rows = new ArrayList();
        this.mDisplayWidth = width;
        this.mDisplayHeight = height;
        this.mDefaultHorizontalGap = 0;
        this.mDefaultWidth = this.mDisplayWidth / GRID_WIDTH;
        this.mDefaultVerticalGap = 0;
        this.mDefaultHeight = this.mDefaultWidth;
        this.mKeys = new ArrayList();
        this.mModifierKeys = new ArrayList();
        this.mKeyboardMode = modeId;
        loadKeyboard(context, context.getResources().getXml(xmlLayoutResId));
    }

    public Keyboard(Context context, int xmlLayoutResId, int modeId) {
        Key[] keyArr = new Key[EDGE_RIGHT];
        keyArr[0] = null;
        keyArr[EDGE_LEFT] = null;
        this.mShiftKeys = keyArr;
        this.mShiftKeyIndices = new int[]{KEYCODE_SHIFT, KEYCODE_SHIFT};
        this.rows = new ArrayList();
        DisplayMetrics dm = context.getResources().getDisplayMetrics();
        this.mDisplayWidth = dm.widthPixels;
        this.mDisplayHeight = dm.heightPixels;
        this.mDefaultHorizontalGap = 0;
        this.mDefaultWidth = this.mDisplayWidth / GRID_WIDTH;
        this.mDefaultVerticalGap = 0;
        this.mDefaultHeight = this.mDefaultWidth;
        this.mKeys = new ArrayList();
        this.mModifierKeys = new ArrayList();
        this.mKeyboardMode = modeId;
        loadKeyboard(context, context.getResources().getXml(xmlLayoutResId));
    }

    public Keyboard(Context context, int layoutTemplateResId, CharSequence characters, int columns, int horizontalPadding) {
        int maxColumns;
        this(context, layoutTemplateResId);
        int x = 0;
        int y = 0;
        int column = 0;
        this.mTotalWidth = 0;
        Row row = new Row(this);
        row.defaultHeight = this.mDefaultHeight;
        row.defaultWidth = this.mDefaultWidth;
        row.defaultHorizontalGap = this.mDefaultHorizontalGap;
        row.verticalGap = this.mDefaultVerticalGap;
        row.rowEdgeFlags = 12;
        if (columns == KEYCODE_SHIFT) {
            maxColumns = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        } else {
            maxColumns = columns;
        }
        for (int i = 0; i < characters.length(); i += EDGE_LEFT) {
            char c = characters.charAt(i);
            if (column >= maxColumns || (this.mDefaultWidth + x) + horizontalPadding > this.mDisplayWidth) {
                x = 0;
                y += this.mDefaultVerticalGap + this.mDefaultHeight;
                column = 0;
            }
            Key key = new Key(row);
            key.f18x = x;
            key.f19y = y;
            key.label = String.valueOf(c);
            int[] iArr = new int[EDGE_LEFT];
            iArr[0] = c;
            key.codes = iArr;
            column += EDGE_LEFT;
            x += key.width + key.gap;
            this.mKeys.add(key);
            row.mKeys.add(key);
            if (x > this.mTotalWidth) {
                this.mTotalWidth = x;
            }
        }
        this.mTotalHeight = this.mDefaultHeight + y;
        this.rows.add(row);
    }

    final void resize(int newWidth, int newHeight) {
        int numRows = this.rows.size();
        for (int rowIndex = 0; rowIndex < numRows; rowIndex += EDGE_LEFT) {
            int keyIndex;
            Row row = (Row) this.rows.get(rowIndex);
            int numKeys = row.mKeys.size();
            int totalGap = 0;
            int totalWidth = 0;
            for (keyIndex = 0; keyIndex < numKeys; keyIndex += EDGE_LEFT) {
                Key key = (Key) row.mKeys.get(keyIndex);
                if (keyIndex > 0) {
                    totalGap += key.gap;
                }
                totalWidth += key.width;
            }
            if (totalGap + totalWidth > newWidth) {
                int x = 0;
                float scaleFactor = ((float) (newWidth - totalGap)) / ((float) totalWidth);
                for (keyIndex = 0; keyIndex < numKeys; keyIndex += EDGE_LEFT) {
                    key = (Key) row.mKeys.get(keyIndex);
                    key.width = (int) (((float) key.width) * scaleFactor);
                    key.f18x = x;
                    x += key.width + key.gap;
                }
            }
        }
        this.mTotalWidth = newWidth;
    }

    public List<Key> getKeys() {
        return this.mKeys;
    }

    public List<Key> getModifierKeys() {
        return this.mModifierKeys;
    }

    protected int getHorizontalGap() {
        return this.mDefaultHorizontalGap;
    }

    protected void setHorizontalGap(int gap) {
        this.mDefaultHorizontalGap = gap;
    }

    protected int getVerticalGap() {
        return this.mDefaultVerticalGap;
    }

    protected void setVerticalGap(int gap) {
        this.mDefaultVerticalGap = gap;
    }

    protected int getKeyHeight() {
        return this.mDefaultHeight;
    }

    protected void setKeyHeight(int height) {
        this.mDefaultHeight = height;
    }

    protected int getKeyWidth() {
        return this.mDefaultWidth;
    }

    protected void setKeyWidth(int width) {
        this.mDefaultWidth = width;
    }

    public int getHeight() {
        return this.mTotalHeight;
    }

    public int getMinWidth() {
        return this.mTotalWidth;
    }

    public boolean setShifted(boolean shiftState) {
        Key[] arr$ = this.mShiftKeys;
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += EDGE_LEFT) {
            Key shiftKey = arr$[i$];
            if (shiftKey != null) {
                shiftKey.on = shiftState;
            }
        }
        if (this.mShifted == shiftState) {
            return false;
        }
        this.mShifted = shiftState;
        return true;
    }

    public boolean isShifted() {
        return this.mShifted;
    }

    public int[] getShiftKeyIndices() {
        return this.mShiftKeyIndices;
    }

    public int getShiftKeyIndex() {
        return this.mShiftKeyIndices[0];
    }

    private void computeNearestNeighbors() {
        this.mCellWidth = ((getMinWidth() + GRID_WIDTH) + KEYCODE_SHIFT) / GRID_WIDTH;
        this.mCellHeight = ((getHeight() + GRID_HEIGHT) + KEYCODE_SHIFT) / GRID_HEIGHT;
        this.mGridNeighbors = new int[GRID_SIZE][];
        int[] indices = new int[this.mKeys.size()];
        int gridWidth = this.mCellWidth * GRID_WIDTH;
        int gridHeight = this.mCellHeight * GRID_HEIGHT;
        int x = 0;
        while (x < gridWidth) {
            int y = 0;
            while (y < gridHeight) {
                int count = 0;
                for (int i = 0; i < this.mKeys.size(); i += EDGE_LEFT) {
                    Key key = (Key) this.mKeys.get(i);
                    if (key.squaredDistanceFrom(x, y) < this.mProximityThreshold || key.squaredDistanceFrom((this.mCellWidth + x) + KEYCODE_SHIFT, y) < this.mProximityThreshold || key.squaredDistanceFrom((this.mCellWidth + x) + KEYCODE_SHIFT, (this.mCellHeight + y) + KEYCODE_SHIFT) < this.mProximityThreshold || key.squaredDistanceFrom(x, (this.mCellHeight + y) + KEYCODE_SHIFT) < this.mProximityThreshold) {
                        int count2 = count + EDGE_LEFT;
                        indices[count] = i;
                        count = count2;
                    }
                }
                int[] cell = new int[count];
                System.arraycopy(indices, 0, cell, 0, count);
                this.mGridNeighbors[((y / this.mCellHeight) * GRID_WIDTH) + (x / this.mCellWidth)] = cell;
                y += this.mCellHeight;
            }
            x += this.mCellWidth;
        }
    }

    public int[] getNearestKeys(int x, int y) {
        if (this.mGridNeighbors == null) {
            computeNearestNeighbors();
        }
        if (x >= 0 && x < getMinWidth() && y >= 0 && y < getHeight()) {
            int index = ((y / this.mCellHeight) * GRID_WIDTH) + (x / this.mCellWidth);
            if (index < GRID_SIZE) {
                return this.mGridNeighbors[index];
            }
        }
        return new int[0];
    }

    protected Row createRowFromXml(Resources res, XmlResourceParser parser) {
        return new Row(res, this, parser);
    }

    protected Key createKeyFromXml(Resources res, Row parent, int x, int y, XmlResourceParser parser) {
        return new Key(res, parent, x, y, parser);
    }

    private void loadKeyboard(Context context, XmlResourceParser parser) {
        boolean inKey = false;
        boolean inRow = false;
        int row = 0;
        int x = 0;
        int y = 0;
        Key key = null;
        Row currentRow = null;
        Resources res = context.getResources();
        while (true) {
            int event = parser.next();
            if (event == EDGE_LEFT) {
                break;
            } else if (event == EDGE_RIGHT) {
                String tag = parser.getName();
                if (TAG_ROW.equals(tag)) {
                    inRow = true;
                    x = 0;
                    currentRow = createRowFromXml(res, parser);
                    this.rows.add(currentRow);
                    boolean skipRow = (currentRow.mode == 0 || currentRow.mode == this.mKeyboardMode) ? false : true;
                    if (skipRow) {
                        skipToEndOfRow(parser);
                        inRow = false;
                    }
                } else if (TAG_KEY.equals(tag)) {
                    inKey = true;
                    key = createKeyFromXml(res, currentRow, x, y, parser);
                    this.mKeys.add(key);
                    if (key.codes[0] == KEYCODE_SHIFT) {
                        for (int i = 0; i < this.mShiftKeys.length; i += EDGE_LEFT) {
                            if (this.mShiftKeys[i] == null) {
                                this.mShiftKeys[i] = key;
                                this.mShiftKeyIndices[i] = this.mKeys.size() + KEYCODE_SHIFT;
                                break;
                            }
                        }
                        this.mModifierKeys.add(key);
                    } else {
                        try {
                            if (key.codes[0] == KEYCODE_ALT) {
                                this.mModifierKeys.add(key);
                            }
                        } catch (Exception e) {
                            Log.e(TAG_KEYBOARD, "Parse error:" + e);
                            e.printStackTrace();
                        }
                    }
                    currentRow.mKeys.add(key);
                } else if (TAG_KEYBOARD.equals(tag)) {
                    parseKeyboardAttributes(res, parser);
                }
            } else if (event == 3) {
                if (inKey) {
                    inKey = false;
                    x += key.gap + key.width;
                    if (x > this.mTotalWidth) {
                        this.mTotalWidth = x;
                    }
                } else if (inRow) {
                    inRow = false;
                    y = (y + currentRow.verticalGap) + currentRow.defaultHeight;
                    row += EDGE_LEFT;
                }
            }
        }
        this.mTotalHeight = y - this.mDefaultVerticalGap;
    }

    private void skipToEndOfRow(XmlResourceParser parser) throws XmlPullParserException, IOException {
        while (true) {
            int event = parser.next();
            if (event == EDGE_LEFT) {
                return;
            }
            if (event == 3 && parser.getName().equals(TAG_ROW)) {
                return;
            }
        }
    }

    private void parseKeyboardAttributes(Resources res, XmlResourceParser parser) {
        TypedArray a = res.obtainAttributes(Xml.asAttributeSet(parser), R.styleable.Keyboard);
        this.mDefaultWidth = getDimensionOrFraction(a, 0, this.mDisplayWidth, this.mDisplayWidth / GRID_WIDTH);
        this.mDefaultHeight = getDimensionOrFraction(a, EDGE_LEFT, this.mDisplayHeight, GRID_SIZE);
        this.mDefaultHorizontalGap = getDimensionOrFraction(a, EDGE_RIGHT, this.mDisplayWidth, 0);
        this.mDefaultVerticalGap = getDimensionOrFraction(a, 3, this.mDisplayHeight, 0);
        this.mProximityThreshold = (int) (((float) this.mDefaultWidth) * SEARCH_DISTANCE);
        this.mProximityThreshold *= this.mProximityThreshold;
        a.recycle();
    }

    static int getDimensionOrFraction(TypedArray a, int index, int base, int defValue) {
        TypedValue value = a.peekValue(index);
        if (value == null) {
            return defValue;
        }
        if (value.type == GRID_HEIGHT) {
            return a.getDimensionPixelOffset(index, defValue);
        }
        if (value.type == 6) {
            return Math.round(a.getFraction(index, base, base, (float) defValue));
        }
        return defValue;
    }
}
