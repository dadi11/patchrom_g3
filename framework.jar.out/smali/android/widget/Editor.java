package android.widget;

import android.C0000R;
import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.bluetooth.BluetoothClass.Device;
import android.content.ClipData;
import android.content.Context;
import android.content.Intent;
import android.content.UndoManager;
import android.content.UndoOperation;
import android.content.UndoOwner;
import android.content.pm.PackageManager;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Paint.Style;
import android.graphics.Path;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.hardware.SensorManager;
import android.inputmethodservice.ExtractEditText;
import android.net.ProxyInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.Parcel;
import android.os.Parcelable.ClassLoaderCreator;
import android.os.SystemClock;
import android.text.DynamicLayout;
import android.text.Editable;
import android.text.InputFilter;
import android.text.InputType;
import android.text.Layout;
import android.text.Layout.Alignment;
import android.text.ParcelableSpan;
import android.text.Selection;
import android.text.SpanWatcher;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.StaticLayout;
import android.text.TextUtils;
import android.text.format.DateFormat;
import android.text.method.KeyListener;
import android.text.method.MetaKeyKeyListener;
import android.text.method.MovementMethod;
import android.text.method.PasswordTransformationMethod;
import android.text.method.WordIterator;
import android.text.style.EasyEditSpan;
import android.text.style.SuggestionRangeSpan;
import android.text.style.SuggestionSpan;
import android.text.style.TextAppearanceSpan;
import android.text.style.URLSpan;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.ActionMode;
import android.view.ActionMode.Callback;
import android.view.DragEvent;
import android.view.HardwareCanvas;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.RenderNode;
import android.view.View;
import android.view.View.DragShadowBuilder;
import android.view.View.MeasureSpec;
import android.view.View.OnClickListener;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.ViewTreeObserver;
import android.view.ViewTreeObserver.OnPreDrawListener;
import android.view.ViewTreeObserver.OnTouchModeChangeListener;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.CorrectionInfo;
import android.view.inputmethod.CursorAnchorInfo.Builder;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.ExtractedText;
import android.view.inputmethod.ExtractedTextRequest;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.TextView.OnEditorActionListener;
import com.android.internal.R;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.GrowingArrayUtils;
import com.android.internal.view.menu.MenuBuilder;
import com.android.internal.widget.EditableInputConnection;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;

public class Editor {
    static final int BLINK = 500;
    static final boolean DEBUG_UNDO = false;
    private static int DRAG_SHADOW_MAX_TEXT_LENGTH = 0;
    static final int EXTRACT_NOTHING = -2;
    static final int EXTRACT_UNKNOWN = -1;
    private static final String TAG = "Editor";
    private static final float[] TEMP_POSITION;
    Blink mBlink;
    CorrectionHighlighter mCorrectionHighlighter;
    boolean mCreatedWithASelection;
    final CursorAnchorInfoNotifier mCursorAnchorInfoNotifier;
    int mCursorCount;
    final Drawable[] mCursorDrawable;
    boolean mCursorVisible;
    Callback mCustomSelectionActionModeCallback;
    boolean mDiscardNextActionUp;
    CharSequence mError;
    ErrorPopup mErrorPopup;
    boolean mErrorWasChanged;
    boolean mFrozenWithFocus;
    boolean mIgnoreActionUpEvent;
    boolean mInBatchEditControllers;
    InputContentType mInputContentType;
    InputMethodState mInputMethodState;
    int mInputType;
    boolean mInsertionControllerEnabled;
    InsertionPointCursorController mInsertionPointCursorController;
    KeyListener mKeyListener;
    float mLastDownPositionX;
    float mLastDownPositionY;
    private PositionListener mPositionListener;
    boolean mPreserveDetachedSelection;
    boolean mSelectAllOnFocus;
    private Drawable mSelectHandleCenter;
    private Drawable mSelectHandleLeft;
    private Drawable mSelectHandleRight;
    ActionMode mSelectionActionMode;
    boolean mSelectionControllerEnabled;
    SelectionModifierCursorController mSelectionModifierCursorController;
    boolean mSelectionMoved;
    long mShowCursor;
    boolean mShowErrorAfterAttach;
    boolean mShowSoftInputOnFocus;
    Runnable mShowSuggestionRunnable;
    private SpanController mSpanController;
    SpellChecker mSpellChecker;
    SuggestionRangeSpan mSuggestionRangeSpan;
    SuggestionsPopupWindow mSuggestionsPopupWindow;
    private Rect mTempRect;
    boolean mTemporaryDetach;
    TextDisplayList[] mTextDisplayLists;
    boolean mTextIsSelectable;
    private TextView mTextView;
    boolean mTouchFocusSelected;
    InputFilter mUndoInputFilter;
    UndoManager mUndoManager;
    UndoOwner mUndoOwner;
    WordIterator mWordIterator;

    /* renamed from: android.widget.Editor.1 */
    class C09671 implements Runnable {
        C09671() {
        }

        public void run() {
            Editor.this.showSuggestions();
        }
    }

    private interface TextViewPositionListener {
        void updatePosition(int i, int i2, boolean z, boolean z2);
    }

    private abstract class PinnedPopupWindow implements TextViewPositionListener {
        protected ViewGroup mContentView;
        protected PopupWindow mPopupWindow;
        int mPositionX;
        int mPositionY;

        protected abstract int clipVertically(int i);

        protected abstract void createPopupWindow();

        protected abstract int getTextOffset();

        protected abstract int getVerticalLocalPosition(int i);

        protected abstract void initContentView();

        public PinnedPopupWindow() {
            createPopupWindow();
            this.mPopupWindow.setWindowLayoutType(LayoutParams.TYPE_APPLICATION_SUB_PANEL);
            this.mPopupWindow.setWidth(Editor.EXTRACT_NOTHING);
            this.mPopupWindow.setHeight(Editor.EXTRACT_NOTHING);
            initContentView();
            this.mContentView.setLayoutParams(new ViewGroup.LayoutParams((int) Editor.EXTRACT_NOTHING, (int) Editor.EXTRACT_NOTHING));
            this.mPopupWindow.setContentView(this.mContentView);
        }

        public void show() {
            Editor.this.getPositionListener().addSubscriber(this, Editor.DEBUG_UNDO);
            computeLocalPosition();
            PositionListener positionListener = Editor.this.getPositionListener();
            updatePosition(positionListener.getPositionX(), positionListener.getPositionY());
        }

        protected void measureContent() {
            DisplayMetrics displayMetrics = Editor.this.mTextView.getResources().getDisplayMetrics();
            this.mContentView.measure(MeasureSpec.makeMeasureSpec(displayMetrics.widthPixels, RtlSpacingHelper.UNDEFINED), MeasureSpec.makeMeasureSpec(displayMetrics.heightPixels, RtlSpacingHelper.UNDEFINED));
        }

        private void computeLocalPosition() {
            measureContent();
            int width = this.mContentView.getMeasuredWidth();
            int offset = getTextOffset();
            this.mPositionX = (int) (Editor.this.mTextView.getLayout().getPrimaryHorizontal(offset) - (((float) width) / 2.0f));
            this.mPositionX += Editor.this.mTextView.viewportToContentHorizontalOffset();
            this.mPositionY = getVerticalLocalPosition(Editor.this.mTextView.getLayout().getLineForOffset(offset));
            this.mPositionY += Editor.this.mTextView.viewportToContentVerticalOffset();
        }

        private void updatePosition(int parentPositionX, int parentPositionY) {
            int positionX = parentPositionX + this.mPositionX;
            int positionY = clipVertically(parentPositionY + this.mPositionY);
            DisplayMetrics displayMetrics = Editor.this.mTextView.getResources().getDisplayMetrics();
            positionX = Math.max(0, Math.min(displayMetrics.widthPixels - this.mContentView.getMeasuredWidth(), positionX));
            if (isShowing()) {
                this.mPopupWindow.update(positionX, positionY, Editor.EXTRACT_UNKNOWN, Editor.EXTRACT_UNKNOWN);
            } else {
                this.mPopupWindow.showAtLocation(Editor.this.mTextView, 0, positionX, positionY);
            }
        }

        public void hide() {
            this.mPopupWindow.dismiss();
            Editor.this.getPositionListener().removeSubscriber(this);
        }

        public void updatePosition(int parentPositionX, int parentPositionY, boolean parentPositionChanged, boolean parentScrolled) {
            if (isShowing() && Editor.this.isOffsetVisible(getTextOffset())) {
                if (parentScrolled) {
                    computeLocalPosition();
                }
                updatePosition(parentPositionX, parentPositionY);
                return;
            }
            hide();
        }

        public boolean isShowing() {
            return this.mPopupWindow.isShowing();
        }
    }

    private class ActionPopupWindow extends PinnedPopupWindow implements OnClickListener {
        private static final int POPUP_TEXT_LAYOUT = 17367256;
        private TextView mPasteTextView;
        private TextView mReplaceTextView;

        private ActionPopupWindow() {
            super();
        }

        protected void createPopupWindow() {
            this.mPopupWindow = new PopupWindow(Editor.this.mTextView.getContext(), null, 16843464);
            this.mPopupWindow.setClippingEnabled(true);
        }

        protected void initContentView() {
            LinearLayout linearLayout = new LinearLayout(Editor.this.mTextView.getContext());
            linearLayout.setOrientation(0);
            this.mContentView = linearLayout;
            this.mContentView.setBackgroundResource(17303317);
            LayoutInflater inflater = (LayoutInflater) Editor.this.mTextView.getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            ViewGroup.LayoutParams wrapContent = new ViewGroup.LayoutParams((int) Editor.EXTRACT_NOTHING, (int) Editor.EXTRACT_NOTHING);
            this.mPasteTextView = (TextView) inflater.inflate((int) POPUP_TEXT_LAYOUT, null);
            this.mPasteTextView.setLayoutParams(wrapContent);
            this.mContentView.addView(this.mPasteTextView);
            this.mPasteTextView.setText((int) C0000R.string.paste);
            this.mPasteTextView.setOnClickListener(this);
            this.mReplaceTextView = (TextView) inflater.inflate((int) POPUP_TEXT_LAYOUT, null);
            this.mReplaceTextView.setLayoutParams(wrapContent);
            this.mContentView.addView(this.mReplaceTextView);
            this.mReplaceTextView.setText(17040496);
            this.mReplaceTextView.setOnClickListener(this);
        }

        public void show() {
            boolean canSuggest;
            int i;
            int i2 = 0;
            boolean canPaste = Editor.this.mTextView.canPaste();
            if (Editor.this.mTextView.isSuggestionsEnabled() && Editor.this.isCursorInsideSuggestionSpan()) {
                canSuggest = true;
            } else {
                canSuggest = Editor.DEBUG_UNDO;
            }
            TextView textView = this.mPasteTextView;
            if (canPaste) {
                i = 0;
            } else {
                i = 8;
            }
            textView.setVisibility(i);
            TextView textView2 = this.mReplaceTextView;
            if (!canSuggest) {
                i2 = 8;
            }
            textView2.setVisibility(i2);
            if (canPaste || canSuggest) {
                super.show();
            }
        }

        public void onClick(View view) {
            if (view == this.mPasteTextView && Editor.this.mTextView.canPaste()) {
                Editor.this.mTextView.onTextContextMenuItem(C0000R.id.paste);
                hide();
            } else if (view == this.mReplaceTextView) {
                int middle = (Editor.this.mTextView.getSelectionStart() + Editor.this.mTextView.getSelectionEnd()) / 2;
                Editor.this.stopSelectionActionMode();
                Selection.setSelection((Spannable) Editor.this.mTextView.getText(), middle);
                Editor.this.showSuggestions();
            }
        }

        protected int getTextOffset() {
            return (Editor.this.mTextView.getSelectionStart() + Editor.this.mTextView.getSelectionEnd()) / 2;
        }

        protected int getVerticalLocalPosition(int line) {
            return Editor.this.mTextView.getLayout().getLineTop(line) - this.mContentView.getMeasuredHeight();
        }

        protected int clipVertically(int positionY) {
            if (positionY >= 0) {
                return positionY;
            }
            int offset = getTextOffset();
            Layout layout = Editor.this.mTextView.getLayout();
            int line = layout.getLineForOffset(offset);
            return ((positionY + (layout.getLineBottom(line) - layout.getLineTop(line))) + this.mContentView.getMeasuredHeight()) + Editor.this.mTextView.getContext().getDrawable(Editor.this.mTextView.mTextSelectHandleRes).getIntrinsicHeight();
        }
    }

    private class Blink extends Handler implements Runnable {
        private boolean mCancelled;

        private Blink() {
        }

        public void run() {
            if (!this.mCancelled) {
                removeCallbacks(this);
                if (Editor.this.shouldBlink()) {
                    if (Editor.this.mTextView.getLayout() != null) {
                        Editor.this.mTextView.invalidateCursorPath();
                    }
                    postAtTime(this, SystemClock.uptimeMillis() + 500);
                }
            }
        }

        void cancel() {
            if (!this.mCancelled) {
                removeCallbacks(this);
                this.mCancelled = true;
            }
        }

        void uncancel() {
            this.mCancelled = Editor.DEBUG_UNDO;
        }
    }

    private class CorrectionHighlighter {
        private static final int FADE_OUT_DURATION = 400;
        private int mEnd;
        private long mFadingStartTime;
        private final Paint mPaint;
        private final Path mPath;
        private int mStart;
        private RectF mTempRectF;

        public CorrectionHighlighter() {
            this.mPath = new Path();
            this.mPaint = new Paint(1);
            this.mPaint.setCompatibilityScaling(Editor.this.mTextView.getResources().getCompatibilityInfo().applicationScale);
            this.mPaint.setStyle(Style.FILL);
        }

        public void highlight(CorrectionInfo info) {
            this.mStart = info.getOffset();
            this.mEnd = this.mStart + info.getNewText().length();
            this.mFadingStartTime = SystemClock.uptimeMillis();
            if (this.mStart < 0 || this.mEnd < 0) {
                stopAnimation();
            }
        }

        public void draw(Canvas canvas, int cursorOffsetVertical) {
            if (updatePath() && updatePaint()) {
                if (cursorOffsetVertical != 0) {
                    canvas.translate(0.0f, (float) cursorOffsetVertical);
                }
                canvas.drawPath(this.mPath, this.mPaint);
                if (cursorOffsetVertical != 0) {
                    canvas.translate(0.0f, (float) (-cursorOffsetVertical));
                }
                invalidate(true);
                return;
            }
            stopAnimation();
            invalidate(Editor.DEBUG_UNDO);
        }

        private boolean updatePaint() {
            long duration = SystemClock.uptimeMillis() - this.mFadingStartTime;
            if (duration > 400) {
                return Editor.DEBUG_UNDO;
            }
            this.mPaint.setColor((Editor.this.mTextView.mHighlightColor & View.MEASURED_SIZE_MASK) + (((int) (((float) Color.alpha(Editor.this.mTextView.mHighlightColor)) * (LayoutParams.BRIGHTNESS_OVERRIDE_FULL - (((float) duration) / SensorManager.LIGHT_SUNRISE)))) << 24));
            return true;
        }

        private boolean updatePath() {
            Layout layout = Editor.this.mTextView.getLayout();
            if (layout == null) {
                return Editor.DEBUG_UNDO;
            }
            int length = Editor.this.mTextView.getText().length();
            int start = Math.min(length, this.mStart);
            int end = Math.min(length, this.mEnd);
            this.mPath.reset();
            layout.getSelectionPath(start, end, this.mPath);
            return true;
        }

        private void invalidate(boolean delayed) {
            if (Editor.this.mTextView.getLayout() != null) {
                if (this.mTempRectF == null) {
                    this.mTempRectF = new RectF();
                }
                this.mPath.computeBounds(this.mTempRectF, Editor.DEBUG_UNDO);
                int left = Editor.this.mTextView.getCompoundPaddingLeft();
                int top = Editor.this.mTextView.getExtendedPaddingTop() + Editor.this.mTextView.getVerticalOffset(true);
                if (delayed) {
                    Editor.this.mTextView.postInvalidateOnAnimation(((int) this.mTempRectF.left) + left, ((int) this.mTempRectF.top) + top, ((int) this.mTempRectF.right) + left, ((int) this.mTempRectF.bottom) + top);
                } else {
                    Editor.this.mTextView.postInvalidate((int) this.mTempRectF.left, (int) this.mTempRectF.top, (int) this.mTempRectF.right, (int) this.mTempRectF.bottom);
                }
            }
        }

        private void stopAnimation() {
            Editor.this.mCorrectionHighlighter = null;
        }
    }

    private final class CursorAnchorInfoNotifier implements TextViewPositionListener {
        final Builder mSelectionInfoBuilder;
        final int[] mTmpIntOffset;
        final Matrix mViewToScreenMatrix;

        private CursorAnchorInfoNotifier() {
            this.mSelectionInfoBuilder = new Builder();
            this.mTmpIntOffset = new int[2];
            this.mViewToScreenMatrix = new Matrix();
        }

        public void updatePosition(int parentPositionX, int parentPositionY, boolean parentPositionChanged, boolean parentScrolled) {
            InputMethodState ims = Editor.this.mInputMethodState;
            if (ims != null && ims.mBatchEditNesting <= 0) {
                InputMethodManager imm = InputMethodManager.peekInstance();
                if (imm != null) {
                    if (imm.isActive(Editor.this.mTextView) && imm.isCursorAnchorInfoEnabled()) {
                        Layout layout = Editor.this.mTextView.getLayout();
                        if (layout != null) {
                            int line;
                            int offset;
                            Builder builder = this.mSelectionInfoBuilder;
                            builder.reset();
                            int selectionStart = Editor.this.mTextView.getSelectionStart();
                            builder.setSelectionRange(selectionStart, Editor.this.mTextView.getSelectionEnd());
                            this.mViewToScreenMatrix.set(Editor.this.mTextView.getMatrix());
                            Editor.this.mTextView.getLocationOnScreen(this.mTmpIntOffset);
                            this.mViewToScreenMatrix.postTranslate((float) this.mTmpIntOffset[0], (float) this.mTmpIntOffset[1]);
                            builder.setMatrix(this.mViewToScreenMatrix);
                            float viewportToContentHorizontalOffset = (float) Editor.this.mTextView.viewportToContentHorizontalOffset();
                            float viewportToContentVerticalOffset = (float) Editor.this.mTextView.viewportToContentVerticalOffset();
                            CharSequence text = Editor.this.mTextView.getText();
                            if (text instanceof Spannable) {
                                Spannable sp = (Spannable) text;
                                int composingTextStart = EditableInputConnection.getComposingSpanStart(sp);
                                int composingTextEnd = EditableInputConnection.getComposingSpanEnd(sp);
                                if (composingTextEnd < composingTextStart) {
                                    int temp = composingTextEnd;
                                    composingTextEnd = composingTextStart;
                                    composingTextStart = temp;
                                }
                                boolean hasComposingText = (composingTextStart < 0 || composingTextStart >= composingTextEnd) ? Editor.DEBUG_UNDO : true;
                                if (hasComposingText) {
                                    builder.setComposingText(composingTextStart, text.subSequence(composingTextStart, composingTextEnd));
                                    int minLine = layout.getLineForOffset(composingTextStart);
                                    int maxLine = layout.getLineForOffset(composingTextEnd + Editor.EXTRACT_UNKNOWN);
                                    for (line = minLine; line <= maxLine; line++) {
                                        int lineStart = layout.getLineStart(line);
                                        int lineEnd = layout.getLineEnd(line);
                                        int offsetStart = Math.max(lineStart, composingTextStart);
                                        int offsetEnd = Math.min(lineEnd, composingTextEnd);
                                        boolean ltrLine = layout.getParagraphDirection(line) == 1 ? true : Editor.DEBUG_UNDO;
                                        float[] widths = new float[(offsetEnd - offsetStart)];
                                        layout.getPaint().getTextWidths(text, offsetStart, offsetEnd, widths);
                                        float top = (float) layout.getLineTop(line);
                                        float bottom = (float) layout.getLineBottom(line);
                                        for (offset = offsetStart; offset < offsetEnd; offset++) {
                                            float left;
                                            float right;
                                            float charWidth = widths[offset - offsetStart];
                                            boolean isRtl = layout.isRtlCharAt(offset);
                                            float primary = layout.getPrimaryHorizontal(offset);
                                            float secondary = layout.getSecondaryHorizontal(offset);
                                            if (ltrLine) {
                                                if (isRtl) {
                                                    left = secondary - charWidth;
                                                    right = secondary;
                                                } else {
                                                    left = primary;
                                                    right = primary + charWidth;
                                                }
                                            } else if (isRtl) {
                                                left = primary - charWidth;
                                                right = primary;
                                            } else {
                                                left = secondary;
                                                right = secondary + charWidth;
                                            }
                                            float localLeft = left + viewportToContentHorizontalOffset;
                                            float localRight = right + viewportToContentHorizontalOffset;
                                            float localTop = top + viewportToContentVerticalOffset;
                                            float localBottom = bottom + viewportToContentVerticalOffset;
                                            boolean isTopLeftVisible = Editor.this.isPositionVisible(localLeft, localTop);
                                            boolean isBottomRightVisible = Editor.this.isPositionVisible(localRight, localBottom);
                                            int characterBoundsFlags = 0;
                                            if (isTopLeftVisible || isBottomRightVisible) {
                                                characterBoundsFlags = 0 | 1;
                                            }
                                            if (!(isTopLeftVisible && isBottomRightVisible)) {
                                                characterBoundsFlags |= 2;
                                            }
                                            if (isRtl) {
                                                characterBoundsFlags |= 4;
                                            }
                                            builder.addCharacterBounds(offset, localLeft, localTop, localRight, localBottom, characterBoundsFlags);
                                        }
                                    }
                                }
                            }
                            if (selectionStart >= 0) {
                                offset = selectionStart;
                                line = layout.getLineForOffset(offset);
                                float insertionMarkerX = layout.getPrimaryHorizontal(offset) + viewportToContentHorizontalOffset;
                                float insertionMarkerTop = ((float) layout.getLineTop(line)) + viewportToContentVerticalOffset;
                                float insertionMarkerBaseline = ((float) layout.getLineBaseline(line)) + viewportToContentVerticalOffset;
                                float insertionMarkerBottom = ((float) layout.getLineBottom(line)) + viewportToContentVerticalOffset;
                                boolean isTopVisible = Editor.this.isPositionVisible(insertionMarkerX, insertionMarkerTop);
                                boolean isBottomVisible = Editor.this.isPositionVisible(insertionMarkerX, insertionMarkerBottom);
                                int insertionMarkerFlags = 0;
                                if (isTopVisible || isBottomVisible) {
                                    insertionMarkerFlags = 0 | 1;
                                }
                                if (!(isTopVisible && isBottomVisible)) {
                                    insertionMarkerFlags |= 2;
                                }
                                if (layout.isRtlCharAt(offset)) {
                                    insertionMarkerFlags |= 4;
                                }
                                builder.setInsertionMarkerLocation(insertionMarkerX, insertionMarkerTop, insertionMarkerBaseline, insertionMarkerBottom, insertionMarkerFlags);
                            }
                            imm.updateCursorAnchorInfo(Editor.this.mTextView, builder.build());
                        }
                    }
                }
            }
        }
    }

    private interface CursorController extends OnTouchModeChangeListener {
        void hide();

        void onDetached();

        void show();
    }

    private static class DragLocalState {
        public int end;
        public TextView sourceTextView;
        public int start;

        public DragLocalState(TextView sourceTextView, int start, int end) {
            this.sourceTextView = sourceTextView;
            this.start = start;
            this.end = end;
        }
    }

    private interface EasyEditDeleteListener {
        void onDeleteClick(EasyEditSpan easyEditSpan);
    }

    private class EasyEditPopupWindow extends PinnedPopupWindow implements OnClickListener {
        private static final int POPUP_TEXT_LAYOUT = 17367256;
        private TextView mDeleteTextView;
        private EasyEditSpan mEasyEditSpan;
        private EasyEditDeleteListener mOnDeleteListener;

        private EasyEditPopupWindow() {
            super();
        }

        protected void createPopupWindow() {
            this.mPopupWindow = new PopupWindow(Editor.this.mTextView.getContext(), null, 16843464);
            this.mPopupWindow.setInputMethodMode(2);
            this.mPopupWindow.setClippingEnabled(true);
        }

        protected void initContentView() {
            LinearLayout linearLayout = new LinearLayout(Editor.this.mTextView.getContext());
            linearLayout.setOrientation(0);
            this.mContentView = linearLayout;
            this.mContentView.setBackgroundResource(17303318);
            LayoutInflater inflater = (LayoutInflater) Editor.this.mTextView.getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            ViewGroup.LayoutParams wrapContent = new ViewGroup.LayoutParams((int) Editor.EXTRACT_NOTHING, (int) Editor.EXTRACT_NOTHING);
            this.mDeleteTextView = (TextView) inflater.inflate((int) POPUP_TEXT_LAYOUT, null);
            this.mDeleteTextView.setLayoutParams(wrapContent);
            this.mDeleteTextView.setText(17040497);
            this.mDeleteTextView.setOnClickListener(this);
            this.mContentView.addView(this.mDeleteTextView);
        }

        public void setEasyEditSpan(EasyEditSpan easyEditSpan) {
            this.mEasyEditSpan = easyEditSpan;
        }

        private void setOnDeleteListener(EasyEditDeleteListener listener) {
            this.mOnDeleteListener = listener;
        }

        public void onClick(View view) {
            if (view == this.mDeleteTextView && this.mEasyEditSpan != null && this.mEasyEditSpan.isDeleteEnabled() && this.mOnDeleteListener != null) {
                this.mOnDeleteListener.onDeleteClick(this.mEasyEditSpan);
            }
        }

        public void hide() {
            if (this.mEasyEditSpan != null) {
                this.mEasyEditSpan.setDeleteEnabled(Editor.DEBUG_UNDO);
            }
            this.mOnDeleteListener = null;
            super.hide();
        }

        protected int getTextOffset() {
            return ((Editable) Editor.this.mTextView.getText()).getSpanEnd(this.mEasyEditSpan);
        }

        protected int getVerticalLocalPosition(int line) {
            return Editor.this.mTextView.getLayout().getLineBottom(line);
        }

        protected int clipVertically(int positionY) {
            return positionY;
        }
    }

    private static class ErrorPopup extends PopupWindow {
        private boolean mAbove;
        private int mPopupInlineErrorAboveBackgroundId;
        private int mPopupInlineErrorBackgroundId;
        private final TextView mView;

        ErrorPopup(TextView v, int width, int height) {
            super((View) v, width, height);
            this.mAbove = Editor.DEBUG_UNDO;
            this.mPopupInlineErrorBackgroundId = 0;
            this.mPopupInlineErrorAboveBackgroundId = 0;
            this.mView = v;
            this.mPopupInlineErrorBackgroundId = getResourceId(this.mPopupInlineErrorBackgroundId, Device.COMPUTER_HANDHELD_PC_PDA);
            this.mView.setBackgroundResource(this.mPopupInlineErrorBackgroundId);
        }

        void fixDirection(boolean above) {
            this.mAbove = above;
            if (above) {
                this.mPopupInlineErrorAboveBackgroundId = getResourceId(this.mPopupInlineErrorAboveBackgroundId, 273);
            } else {
                this.mPopupInlineErrorBackgroundId = getResourceId(this.mPopupInlineErrorBackgroundId, Device.COMPUTER_HANDHELD_PC_PDA);
            }
            this.mView.setBackgroundResource(above ? this.mPopupInlineErrorAboveBackgroundId : this.mPopupInlineErrorBackgroundId);
        }

        private int getResourceId(int currentId, int index) {
            if (currentId != 0) {
                return currentId;
            }
            TypedArray styledAttributes = this.mView.getContext().obtainStyledAttributes(C0000R.styleable.Theme);
            currentId = styledAttributes.getResourceId(index, 0);
            styledAttributes.recycle();
            return currentId;
        }

        public void update(int x, int y, int w, int h, boolean force) {
            super.update(x, y, w, h, force);
            boolean above = isAboveAnchor();
            if (above != this.mAbove) {
                fixDirection(above);
            }
        }
    }

    private abstract class HandleView extends View implements TextViewPositionListener {
        private static final int HISTORY_SIZE = 5;
        private static final int TOUCH_UP_FILTER_DELAY_AFTER = 150;
        private static final int TOUCH_UP_FILTER_DELAY_BEFORE = 350;
        private Runnable mActionPopupShower;
        protected ActionPopupWindow mActionPopupWindow;
        private final PopupWindow mContainer;
        protected Drawable mDrawable;
        protected Drawable mDrawableLtr;
        protected Drawable mDrawableRtl;
        protected int mHorizontalGravity;
        protected int mHotspotX;
        private float mIdealVerticalOffset;
        private boolean mIsDragging;
        private int mLastParentX;
        private int mLastParentY;
        private int mMinSize;
        private int mNumberPreviousOffsets;
        private boolean mPositionHasChanged;
        private int mPositionX;
        private int mPositionY;
        private int mPreviousOffset;
        private int mPreviousOffsetIndex;
        private final int[] mPreviousOffsets;
        private final long[] mPreviousOffsetsTimes;
        private float mTouchOffsetY;
        private float mTouchToWindowOffsetX;
        private float mTouchToWindowOffsetY;

        /* renamed from: android.widget.Editor.HandleView.1 */
        class C09681 implements Runnable {
            C09681() {
            }

            public void run() {
                HandleView.this.mActionPopupWindow.show();
            }
        }

        public abstract int getCurrentCursorOffset();

        protected abstract int getHorizontalGravity(boolean z);

        protected abstract int getHotspotX(Drawable drawable, boolean z);

        public abstract void updatePosition(float f, float f2);

        protected abstract void updateSelection(int i);

        public HandleView(Drawable drawableLtr, Drawable drawableRtl) {
            super(Editor.this.mTextView.getContext());
            this.mPreviousOffset = Editor.EXTRACT_UNKNOWN;
            this.mPositionHasChanged = true;
            this.mPreviousOffsetsTimes = new long[HISTORY_SIZE];
            this.mPreviousOffsets = new int[HISTORY_SIZE];
            this.mPreviousOffsetIndex = 0;
            this.mNumberPreviousOffsets = 0;
            this.mContainer = new PopupWindow(Editor.this.mTextView.getContext(), null, 16843464);
            this.mContainer.setSplitTouchEnabled(true);
            this.mContainer.setClippingEnabled(Editor.DEBUG_UNDO);
            this.mContainer.setWindowLayoutType(LayoutParams.TYPE_APPLICATION_SUB_PANEL);
            this.mContainer.setContentView(this);
            this.mDrawableLtr = drawableLtr;
            this.mDrawableRtl = drawableRtl;
            this.mMinSize = Editor.this.mTextView.getContext().getResources().getDimensionPixelSize(17105059);
            updateDrawable();
            int handleHeight = getPreferredHeight();
            this.mTouchOffsetY = -0.3f * ((float) handleHeight);
            this.mIdealVerticalOffset = 0.7f * ((float) handleHeight);
        }

        protected void updateDrawable() {
            boolean isRtlCharAtOffset = Editor.this.mTextView.getLayout().isRtlCharAt(getCurrentCursorOffset());
            this.mDrawable = isRtlCharAtOffset ? this.mDrawableRtl : this.mDrawableLtr;
            this.mHotspotX = getHotspotX(this.mDrawable, isRtlCharAtOffset);
            this.mHorizontalGravity = getHorizontalGravity(isRtlCharAtOffset);
        }

        private void startTouchUpFilter(int offset) {
            this.mNumberPreviousOffsets = 0;
            addPositionToTouchUpFilter(offset);
        }

        private void addPositionToTouchUpFilter(int offset) {
            this.mPreviousOffsetIndex = (this.mPreviousOffsetIndex + 1) % HISTORY_SIZE;
            this.mPreviousOffsets[this.mPreviousOffsetIndex] = offset;
            this.mPreviousOffsetsTimes[this.mPreviousOffsetIndex] = SystemClock.uptimeMillis();
            this.mNumberPreviousOffsets++;
        }

        private void filterOnTouchUp() {
            long now = SystemClock.uptimeMillis();
            int i = 0;
            int index = this.mPreviousOffsetIndex;
            int iMax = Math.min(this.mNumberPreviousOffsets, HISTORY_SIZE);
            while (i < iMax && now - this.mPreviousOffsetsTimes[index] < 150) {
                i++;
                index = ((this.mPreviousOffsetIndex - i) + HISTORY_SIZE) % HISTORY_SIZE;
            }
            if (i > 0 && i < iMax && now - this.mPreviousOffsetsTimes[index] > 350) {
                positionAtCursorOffset(this.mPreviousOffsets[index], Editor.DEBUG_UNDO);
            }
        }

        public boolean offsetHasBeenChanged() {
            return this.mNumberPreviousOffsets > 1 ? true : Editor.DEBUG_UNDO;
        }

        protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
            setMeasuredDimension(getPreferredWidth(), getPreferredHeight());
        }

        private int getPreferredWidth() {
            return Math.max(this.mDrawable.getIntrinsicWidth(), this.mMinSize);
        }

        private int getPreferredHeight() {
            return Math.max(this.mDrawable.getIntrinsicHeight(), this.mMinSize);
        }

        public void show() {
            if (!isShowing()) {
                Editor.this.getPositionListener().addSubscriber(this, true);
                this.mPreviousOffset = Editor.EXTRACT_UNKNOWN;
                positionAtCursorOffset(getCurrentCursorOffset(), Editor.DEBUG_UNDO);
                hideActionPopupWindow();
            }
        }

        protected void dismiss() {
            this.mIsDragging = Editor.DEBUG_UNDO;
            if (this.mContainer.isShowing()) {
                this.mContainer.dismiss();
            }
            onDetached();
        }

        public void hide() {
            dismiss();
            Editor.this.getPositionListener().removeSubscriber(this);
        }

        void showActionPopupWindow(int delay) {
            if (this.mActionPopupWindow == null) {
                this.mActionPopupWindow = new ActionPopupWindow(null);
            }
            if (this.mActionPopupShower == null) {
                this.mActionPopupShower = new C09681();
            } else {
                Editor.this.mTextView.removeCallbacks(this.mActionPopupShower);
            }
            Editor.this.mTextView.postDelayed(this.mActionPopupShower, (long) delay);
        }

        protected void hideActionPopupWindow() {
            if (this.mActionPopupShower != null) {
                Editor.this.mTextView.removeCallbacks(this.mActionPopupShower);
            }
            if (this.mActionPopupWindow != null) {
                this.mActionPopupWindow.hide();
            }
        }

        public boolean isShowing() {
            return this.mContainer.isShowing();
        }

        private boolean isVisible() {
            if (this.mIsDragging) {
                return true;
            }
            if (Editor.this.mTextView.isInBatchEditMode()) {
                return Editor.DEBUG_UNDO;
            }
            return Editor.this.isPositionVisible((float) (this.mPositionX + this.mHotspotX), (float) this.mPositionY);
        }

        protected void positionAtCursorOffset(int offset, boolean parentScrolled) {
            Layout layout = Editor.this.mTextView.getLayout();
            if (layout == null) {
                Editor.this.prepareCursorControllers();
                return;
            }
            boolean offsetChanged = offset != this.mPreviousOffset ? true : Editor.DEBUG_UNDO;
            if (offsetChanged || parentScrolled) {
                if (offsetChanged) {
                    updateSelection(offset);
                    addPositionToTouchUpFilter(offset);
                }
                int line = layout.getLineForOffset(offset);
                this.mPositionX = (int) ((((layout.getPrimaryHorizontal(offset) - 0.5f) - ((float) this.mHotspotX)) - ((float) getHorizontalOffset())) + ((float) getCursorOffset()));
                this.mPositionY = layout.getLineBottom(line);
                this.mPositionX += Editor.this.mTextView.viewportToContentHorizontalOffset();
                this.mPositionY += Editor.this.mTextView.viewportToContentVerticalOffset();
                this.mPreviousOffset = offset;
                this.mPositionHasChanged = true;
            }
        }

        public void updatePosition(int parentPositionX, int parentPositionY, boolean parentPositionChanged, boolean parentScrolled) {
            positionAtCursorOffset(getCurrentCursorOffset(), parentScrolled);
            if (parentPositionChanged || this.mPositionHasChanged) {
                if (this.mIsDragging) {
                    if (!(parentPositionX == this.mLastParentX && parentPositionY == this.mLastParentY)) {
                        this.mTouchToWindowOffsetX += (float) (parentPositionX - this.mLastParentX);
                        this.mTouchToWindowOffsetY += (float) (parentPositionY - this.mLastParentY);
                        this.mLastParentX = parentPositionX;
                        this.mLastParentY = parentPositionY;
                    }
                    onHandleMoved();
                }
                if (isVisible()) {
                    int positionX = parentPositionX + this.mPositionX;
                    int positionY = parentPositionY + this.mPositionY;
                    if (isShowing()) {
                        this.mContainer.update(positionX, positionY, Editor.EXTRACT_UNKNOWN, Editor.EXTRACT_UNKNOWN);
                    } else {
                        this.mContainer.showAtLocation(Editor.this.mTextView, 0, positionX, positionY);
                    }
                } else if (isShowing()) {
                    dismiss();
                }
                this.mPositionHasChanged = Editor.DEBUG_UNDO;
            }
        }

        protected void onDraw(Canvas c) {
            int drawWidth = this.mDrawable.getIntrinsicWidth();
            int left = getHorizontalOffset();
            this.mDrawable.setBounds(left, 0, left + drawWidth, this.mDrawable.getIntrinsicHeight());
            this.mDrawable.draw(c);
        }

        private int getHorizontalOffset() {
            int width = getPreferredWidth();
            int drawWidth = this.mDrawable.getIntrinsicWidth();
            switch (this.mHorizontalGravity) {
                case SetDrawableParameters.TAG /*3*/:
                    return 0;
                case HISTORY_SIZE /*5*/:
                    return width - drawWidth;
                default:
                    return (width - drawWidth) / 2;
            }
        }

        protected int getCursorOffset() {
            return 0;
        }

        public boolean onTouchEvent(MotionEvent ev) {
            switch (ev.getActionMasked()) {
                case Toast.LENGTH_SHORT /*0*/:
                    startTouchUpFilter(getCurrentCursorOffset());
                    this.mTouchToWindowOffsetX = ev.getRawX() - ((float) this.mPositionX);
                    this.mTouchToWindowOffsetY = ev.getRawY() - ((float) this.mPositionY);
                    PositionListener positionListener = Editor.this.getPositionListener();
                    this.mLastParentX = positionListener.getPositionX();
                    this.mLastParentY = positionListener.getPositionY();
                    this.mIsDragging = true;
                    break;
                case Toast.LENGTH_LONG /*1*/:
                    filterOnTouchUp();
                    this.mIsDragging = Editor.DEBUG_UNDO;
                    break;
                case Action.MERGE_IGNORE /*2*/:
                    float newVerticalOffset;
                    float rawX = ev.getRawX();
                    float rawY = ev.getRawY();
                    float previousVerticalOffset = this.mTouchToWindowOffsetY - ((float) this.mLastParentY);
                    float currentVerticalOffset = (rawY - ((float) this.mPositionY)) - ((float) this.mLastParentY);
                    if (previousVerticalOffset < this.mIdealVerticalOffset) {
                        newVerticalOffset = Math.max(Math.min(currentVerticalOffset, this.mIdealVerticalOffset), previousVerticalOffset);
                    } else {
                        newVerticalOffset = Math.min(Math.max(currentVerticalOffset, this.mIdealVerticalOffset), previousVerticalOffset);
                    }
                    this.mTouchToWindowOffsetY = ((float) this.mLastParentY) + newVerticalOffset;
                    updatePosition((rawX - this.mTouchToWindowOffsetX) + ((float) this.mHotspotX), (rawY - this.mTouchToWindowOffsetY) + this.mTouchOffsetY);
                    break;
                case SetDrawableParameters.TAG /*3*/:
                    this.mIsDragging = Editor.DEBUG_UNDO;
                    break;
            }
            return true;
        }

        public boolean isDragging() {
            return this.mIsDragging;
        }

        void onHandleMoved() {
            hideActionPopupWindow();
        }

        public void onDetached() {
            hideActionPopupWindow();
        }
    }

    static class InputContentType {
        boolean enterDown;
        Bundle extras;
        int imeActionId;
        CharSequence imeActionLabel;
        int imeOptions;
        OnEditorActionListener onEditorActionListener;
        String privateImeOptions;

        InputContentType() {
            this.imeOptions = 0;
        }
    }

    static class InputMethodState {
        int mBatchEditNesting;
        int mChangedDelta;
        int mChangedEnd;
        int mChangedStart;
        boolean mContentChanged;
        boolean mCursorChanged;
        Rect mCursorRectInWindow;
        final ExtractedText mExtractedText;
        ExtractedTextRequest mExtractedTextRequest;
        boolean mSelectionModeChanged;
        float[] mTmpOffset;

        InputMethodState() {
            this.mCursorRectInWindow = new Rect();
            this.mTmpOffset = new float[2];
            this.mExtractedText = new ExtractedText();
        }
    }

    private class InsertionHandleView extends HandleView {
        private static final int DELAY_BEFORE_HANDLE_FADES_OUT = 4000;
        private static final int RECENT_CUT_COPY_DURATION = 15000;
        private float mDownPositionX;
        private float mDownPositionY;
        private Runnable mHider;

        /* renamed from: android.widget.Editor.InsertionHandleView.1 */
        class C09691 implements Runnable {
            C09691() {
            }

            public void run() {
                InsertionHandleView.this.hide();
            }
        }

        public InsertionHandleView(Drawable drawable) {
            super(drawable, drawable);
        }

        public void show() {
            super.show();
            if (SystemClock.uptimeMillis() - TextView.LAST_CUT_OR_COPY_TIME < 15000) {
                showActionPopupWindow(0);
            }
            hideAfterDelay();
        }

        public void showWithActionPopup() {
            show();
            showActionPopupWindow(0);
        }

        private void hideAfterDelay() {
            if (this.mHider == null) {
                this.mHider = new C09691();
            } else {
                removeHiderCallback();
            }
            Editor.this.mTextView.postDelayed(this.mHider, 4000);
        }

        private void removeHiderCallback() {
            if (this.mHider != null) {
                Editor.this.mTextView.removeCallbacks(this.mHider);
            }
        }

        protected int getHotspotX(Drawable drawable, boolean isRtlRun) {
            return drawable.getIntrinsicWidth() / 2;
        }

        protected int getHorizontalGravity(boolean isRtlRun) {
            return 1;
        }

        protected int getCursorOffset() {
            int offset = super.getCursorOffset();
            Drawable cursor = Editor.this.mCursorCount > 0 ? Editor.this.mCursorDrawable[0] : null;
            if (cursor == null) {
                return offset;
            }
            cursor.getPadding(Editor.this.mTempRect);
            return offset + (((cursor.getIntrinsicWidth() - Editor.this.mTempRect.left) - Editor.this.mTempRect.right) / 2);
        }

        public boolean onTouchEvent(MotionEvent ev) {
            boolean result = super.onTouchEvent(ev);
            switch (ev.getActionMasked()) {
                case Toast.LENGTH_SHORT /*0*/:
                    this.mDownPositionX = ev.getRawX();
                    this.mDownPositionY = ev.getRawY();
                    break;
                case Toast.LENGTH_LONG /*1*/:
                    if (!offsetHasBeenChanged()) {
                        float deltaX = this.mDownPositionX - ev.getRawX();
                        float deltaY = this.mDownPositionY - ev.getRawY();
                        float distanceSquared = (deltaX * deltaX) + (deltaY * deltaY);
                        int touchSlop = ViewConfiguration.get(Editor.this.mTextView.getContext()).getScaledTouchSlop();
                        if (distanceSquared < ((float) (touchSlop * touchSlop))) {
                            if (this.mActionPopupWindow == null || !this.mActionPopupWindow.isShowing()) {
                                showWithActionPopup();
                            } else {
                                this.mActionPopupWindow.hide();
                            }
                        }
                    }
                    hideAfterDelay();
                    break;
                case SetDrawableParameters.TAG /*3*/:
                    hideAfterDelay();
                    break;
            }
            return result;
        }

        public int getCurrentCursorOffset() {
            return Editor.this.mTextView.getSelectionStart();
        }

        public void updateSelection(int offset) {
            Selection.setSelection((Spannable) Editor.this.mTextView.getText(), offset);
        }

        public void updatePosition(float x, float y) {
            positionAtCursorOffset(Editor.this.mTextView.getOffsetForPosition(x, y), Editor.DEBUG_UNDO);
        }

        void onHandleMoved() {
            super.onHandleMoved();
            removeHiderCallback();
        }

        public void onDetached() {
            super.onDetached();
            removeHiderCallback();
        }
    }

    private class InsertionPointCursorController implements CursorController {
        private InsertionHandleView mHandle;

        private InsertionPointCursorController() {
        }

        public void show() {
            getHandle().show();
        }

        public void showWithActionPopup() {
            getHandle().showWithActionPopup();
        }

        public void hide() {
            if (this.mHandle != null) {
                this.mHandle.hide();
            }
        }

        public void onTouchModeChanged(boolean isInTouchMode) {
            if (!isInTouchMode) {
                hide();
            }
        }

        private InsertionHandleView getHandle() {
            if (Editor.this.mSelectHandleCenter == null) {
                Editor.this.mSelectHandleCenter = Editor.this.mTextView.getContext().getDrawable(Editor.this.mTextView.mTextSelectHandleRes);
            }
            if (this.mHandle == null) {
                this.mHandle = new InsertionHandleView(Editor.this.mSelectHandleCenter);
            }
            return this.mHandle;
        }

        public void onDetached() {
            Editor.this.mTextView.getViewTreeObserver().removeOnTouchModeChangeListener(this);
            if (this.mHandle != null) {
                this.mHandle.onDetached();
            }
        }
    }

    private class PositionListener implements OnPreDrawListener {
        private final int MAXIMUM_NUMBER_OF_LISTENERS;
        private boolean[] mCanMove;
        private int mNumberOfListeners;
        private boolean mPositionHasChanged;
        private TextViewPositionListener[] mPositionListeners;
        private int mPositionX;
        private int mPositionY;
        private boolean mScrollHasChanged;
        final int[] mTempCoords;

        private PositionListener() {
            this.MAXIMUM_NUMBER_OF_LISTENERS = 7;
            this.mPositionListeners = new TextViewPositionListener[7];
            this.mCanMove = new boolean[7];
            this.mPositionHasChanged = true;
            this.mTempCoords = new int[2];
        }

        public void addSubscriber(TextViewPositionListener positionListener, boolean canMove) {
            if (this.mNumberOfListeners == 0) {
                updatePosition();
                Editor.this.mTextView.getViewTreeObserver().addOnPreDrawListener(this);
            }
            int emptySlotIndex = Editor.EXTRACT_UNKNOWN;
            int i = 0;
            while (i < 7) {
                TextViewPositionListener listener = this.mPositionListeners[i];
                if (listener != positionListener) {
                    if (emptySlotIndex < 0 && listener == null) {
                        emptySlotIndex = i;
                    }
                    i++;
                } else {
                    return;
                }
            }
            this.mPositionListeners[emptySlotIndex] = positionListener;
            this.mCanMove[emptySlotIndex] = canMove;
            this.mNumberOfListeners++;
        }

        public void removeSubscriber(TextViewPositionListener positionListener) {
            for (int i = 0; i < 7; i++) {
                if (this.mPositionListeners[i] == positionListener) {
                    this.mPositionListeners[i] = null;
                    this.mNumberOfListeners += Editor.EXTRACT_UNKNOWN;
                    break;
                }
            }
            if (this.mNumberOfListeners == 0) {
                Editor.this.mTextView.getViewTreeObserver().removeOnPreDrawListener(this);
            }
        }

        public int getPositionX() {
            return this.mPositionX;
        }

        public int getPositionY() {
            return this.mPositionY;
        }

        public boolean onPreDraw() {
            updatePosition();
            int i = 0;
            while (i < 7) {
                if (this.mPositionHasChanged || this.mScrollHasChanged || this.mCanMove[i]) {
                    TextViewPositionListener positionListener = this.mPositionListeners[i];
                    if (positionListener != null) {
                        positionListener.updatePosition(this.mPositionX, this.mPositionY, this.mPositionHasChanged, this.mScrollHasChanged);
                    }
                }
                i++;
            }
            this.mScrollHasChanged = Editor.DEBUG_UNDO;
            return true;
        }

        private void updatePosition() {
            boolean z;
            Editor.this.mTextView.getLocationInWindow(this.mTempCoords);
            if (this.mTempCoords[0] == this.mPositionX && this.mTempCoords[1] == this.mPositionY) {
                z = Editor.DEBUG_UNDO;
            } else {
                z = true;
            }
            this.mPositionHasChanged = z;
            this.mPositionX = this.mTempCoords[0];
            this.mPositionY = this.mTempCoords[1];
        }

        public void onScrollChanged() {
            this.mScrollHasChanged = true;
        }
    }

    private class SelectionActionModeCallback implements Callback {
        private SelectionActionModeCallback() {
        }

        public boolean onCreateActionMode(ActionMode mode, Menu menu) {
            boolean legacy;
            Context context;
            if (Editor.this.mTextView.getContext().getApplicationInfo().targetSdkVersion < 21) {
                legacy = true;
            } else {
                legacy = Editor.DEBUG_UNDO;
            }
            if (legacy || !(menu instanceof MenuBuilder)) {
                context = Editor.this.mTextView.getContext();
            } else {
                context = ((MenuBuilder) menu).getContext();
            }
            TypedArray styledAttributes = context.obtainStyledAttributes(R.styleable.SelectionModeDrawables);
            mode.setTitle(Editor.this.mTextView.getContext().getString(17040498));
            mode.setSubtitle(null);
            mode.setTitleOptionalHint(true);
            menu.add(0, (int) C0000R.id.selectAll, 0, (int) C0000R.string.selectAll).setIcon(styledAttributes.getResourceId(3, 0)).setAlphabeticShortcut(DateFormat.AM_PM).setShowAsAction(6);
            if (Editor.this.mTextView.canCut()) {
                menu.add(0, (int) C0000R.id.cut, 0, (int) C0000R.string.cut).setIcon(styledAttributes.getResourceId(0, 0)).setAlphabeticShortcut('x').setShowAsAction(6);
            }
            if (Editor.this.mTextView.canCopy()) {
                menu.add(0, (int) C0000R.id.copy, 0, (int) C0000R.string.copy).setIcon(styledAttributes.getResourceId(1, 0)).setAlphabeticShortcut('c').setShowAsAction(6);
            }
            if (Editor.this.mTextView.canPaste()) {
                menu.add(0, (int) C0000R.id.paste, 0, (int) C0000R.string.paste).setIcon(styledAttributes.getResourceId(2, 0)).setAlphabeticShortcut('v').setShowAsAction(6);
            }
            styledAttributes.recycle();
            if (Editor.this.mCustomSelectionActionModeCallback != null && !Editor.this.mCustomSelectionActionModeCallback.onCreateActionMode(mode, menu)) {
                return Editor.DEBUG_UNDO;
            }
            if (!menu.hasVisibleItems() && mode.getCustomView() == null) {
                return Editor.DEBUG_UNDO;
            }
            Editor.this.getSelectionController().show();
            Editor.this.mTextView.setHasTransientState(true);
            return true;
        }

        public boolean onPrepareActionMode(ActionMode mode, Menu menu) {
            if (Editor.this.mCustomSelectionActionModeCallback != null) {
                return Editor.this.mCustomSelectionActionModeCallback.onPrepareActionMode(mode, menu);
            }
            return true;
        }

        public boolean onActionItemClicked(ActionMode mode, MenuItem item) {
            if (Editor.this.mCustomSelectionActionModeCallback == null || !Editor.this.mCustomSelectionActionModeCallback.onActionItemClicked(mode, item)) {
                return Editor.this.mTextView.onTextContextMenuItem(item.getItemId());
            }
            return true;
        }

        public void onDestroyActionMode(ActionMode mode) {
            if (Editor.this.mCustomSelectionActionModeCallback != null) {
                Editor.this.mCustomSelectionActionModeCallback.onDestroyActionMode(mode);
            }
            if (!Editor.this.mPreserveDetachedSelection) {
                Selection.setSelection((Spannable) Editor.this.mTextView.getText(), Editor.this.mTextView.getSelectionEnd());
                Editor.this.mTextView.setHasTransientState(Editor.DEBUG_UNDO);
            }
            if (Editor.this.mSelectionModifierCursorController != null) {
                Editor.this.mSelectionModifierCursorController.hide();
            }
            Editor.this.mSelectionActionMode = null;
        }
    }

    private class SelectionEndHandleView extends HandleView {
        public SelectionEndHandleView(Drawable drawableLtr, Drawable drawableRtl) {
            super(drawableLtr, drawableRtl);
        }

        protected int getHotspotX(Drawable drawable, boolean isRtlRun) {
            if (isRtlRun) {
                return (drawable.getIntrinsicWidth() * 3) / 4;
            }
            return drawable.getIntrinsicWidth() / 4;
        }

        protected int getHorizontalGravity(boolean isRtlRun) {
            return isRtlRun ? 3 : 5;
        }

        public int getCurrentCursorOffset() {
            return Editor.this.mTextView.getSelectionEnd();
        }

        public void updateSelection(int offset) {
            Selection.setSelection((Spannable) Editor.this.mTextView.getText(), Editor.this.mTextView.getSelectionStart(), offset);
            updateDrawable();
        }

        public void updatePosition(float x, float y) {
            int offset = Editor.this.mTextView.getOffsetForPosition(x, y);
            int selectionStart = Editor.this.mTextView.getSelectionStart();
            if (offset <= selectionStart) {
                offset = Math.min(selectionStart + 1, Editor.this.mTextView.getText().length());
            }
            positionAtCursorOffset(offset, Editor.DEBUG_UNDO);
        }

        public void setActionPopupWindow(ActionPopupWindow actionPopupWindow) {
            this.mActionPopupWindow = actionPopupWindow;
        }
    }

    class SelectionModifierCursorController implements CursorController {
        private static final int DELAY_BEFORE_REPLACE_ACTION = 200;
        private float mDownPositionX;
        private float mDownPositionY;
        private SelectionEndHandleView mEndHandle;
        private boolean mGestureStayedInTapRegion;
        private int mMaxTouchOffset;
        private int mMinTouchOffset;
        private long mPreviousTapUpTime;
        private SelectionStartHandleView mStartHandle;

        SelectionModifierCursorController() {
            this.mPreviousTapUpTime = 0;
            resetTouchOffsets();
        }

        public void show() {
            if (!Editor.this.mTextView.isInBatchEditMode()) {
                initDrawables();
                initHandles();
                Editor.this.hideInsertionPointCursorController();
            }
        }

        private void initDrawables() {
            if (Editor.this.mSelectHandleLeft == null) {
                Editor.this.mSelectHandleLeft = Editor.this.mTextView.getContext().getDrawable(Editor.this.mTextView.mTextSelectHandleLeftRes);
            }
            if (Editor.this.mSelectHandleRight == null) {
                Editor.this.mSelectHandleRight = Editor.this.mTextView.getContext().getDrawable(Editor.this.mTextView.mTextSelectHandleRightRes);
            }
        }

        private void initHandles() {
            if (this.mStartHandle == null) {
                this.mStartHandle = new SelectionStartHandleView(Editor.this.mSelectHandleLeft, Editor.this.mSelectHandleRight);
            }
            if (this.mEndHandle == null) {
                this.mEndHandle = new SelectionEndHandleView(Editor.this.mSelectHandleRight, Editor.this.mSelectHandleLeft);
            }
            this.mStartHandle.show();
            this.mEndHandle.show();
            this.mStartHandle.showActionPopupWindow(DELAY_BEFORE_REPLACE_ACTION);
            this.mEndHandle.setActionPopupWindow(this.mStartHandle.getActionPopupWindow());
            Editor.this.hideInsertionPointCursorController();
        }

        public void hide() {
            if (this.mStartHandle != null) {
                this.mStartHandle.hide();
            }
            if (this.mEndHandle != null) {
                this.mEndHandle.hide();
            }
        }

        public void onTouchEvent(MotionEvent event) {
            float deltaX;
            float deltaY;
            float distanceSquared;
            switch (event.getActionMasked()) {
                case Toast.LENGTH_SHORT /*0*/:
                    float x = event.getX();
                    float y = event.getY();
                    int offsetForPosition = Editor.this.mTextView.getOffsetForPosition(x, y);
                    this.mMaxTouchOffset = offsetForPosition;
                    this.mMinTouchOffset = offsetForPosition;
                    if (this.mGestureStayedInTapRegion) {
                        if (SystemClock.uptimeMillis() - this.mPreviousTapUpTime <= ((long) ViewConfiguration.getDoubleTapTimeout())) {
                            deltaX = x - this.mDownPositionX;
                            deltaY = y - this.mDownPositionY;
                            distanceSquared = (deltaX * deltaX) + (deltaY * deltaY);
                            int doubleTapSlop = ViewConfiguration.get(Editor.this.mTextView.getContext()).getScaledDoubleTapSlop();
                            if ((distanceSquared < ((float) (doubleTapSlop * doubleTapSlop)) ? true : Editor.DEBUG_UNDO) && Editor.this.isPositionOnText(x, y)) {
                                Editor.this.startSelectionActionMode();
                                Editor.this.mDiscardNextActionUp = true;
                            }
                        }
                    }
                    this.mDownPositionX = x;
                    this.mDownPositionY = y;
                    this.mGestureStayedInTapRegion = true;
                case Toast.LENGTH_LONG /*1*/:
                    this.mPreviousTapUpTime = SystemClock.uptimeMillis();
                case Action.MERGE_IGNORE /*2*/:
                    if (this.mGestureStayedInTapRegion) {
                        deltaX = event.getX() - this.mDownPositionX;
                        deltaY = event.getY() - this.mDownPositionY;
                        distanceSquared = (deltaX * deltaX) + (deltaY * deltaY);
                        int doubleTapTouchSlop = ViewConfiguration.get(Editor.this.mTextView.getContext()).getScaledDoubleTapTouchSlop();
                        if (distanceSquared > ((float) (doubleTapTouchSlop * doubleTapTouchSlop))) {
                            this.mGestureStayedInTapRegion = Editor.DEBUG_UNDO;
                        }
                    }
                case ReflectionActionWithoutParams.TAG /*5*/:
                case SetEmptyView.TAG /*6*/:
                    if (Editor.this.mTextView.getContext().getPackageManager().hasSystemFeature(PackageManager.FEATURE_TOUCHSCREEN_MULTITOUCH_DISTINCT)) {
                        updateMinAndMaxOffsets(event);
                    }
                default:
            }
        }

        private void updateMinAndMaxOffsets(MotionEvent event) {
            int pointerCount = event.getPointerCount();
            for (int index = 0; index < pointerCount; index++) {
                int offset = Editor.this.mTextView.getOffsetForPosition(event.getX(index), event.getY(index));
                if (offset < this.mMinTouchOffset) {
                    this.mMinTouchOffset = offset;
                }
                if (offset > this.mMaxTouchOffset) {
                    this.mMaxTouchOffset = offset;
                }
            }
        }

        public int getMinTouchOffset() {
            return this.mMinTouchOffset;
        }

        public int getMaxTouchOffset() {
            return this.mMaxTouchOffset;
        }

        public void resetTouchOffsets() {
            this.mMaxTouchOffset = Editor.EXTRACT_UNKNOWN;
            this.mMinTouchOffset = Editor.EXTRACT_UNKNOWN;
        }

        public boolean isSelectionStartDragged() {
            return (this.mStartHandle == null || !this.mStartHandle.isDragging()) ? Editor.DEBUG_UNDO : true;
        }

        public void onTouchModeChanged(boolean isInTouchMode) {
            if (!isInTouchMode) {
                hide();
            }
        }

        public void onDetached() {
            Editor.this.mTextView.getViewTreeObserver().removeOnTouchModeChangeListener(this);
            if (this.mStartHandle != null) {
                this.mStartHandle.onDetached();
            }
            if (this.mEndHandle != null) {
                this.mEndHandle.onDetached();
            }
        }
    }

    private class SelectionStartHandleView extends HandleView {
        public SelectionStartHandleView(Drawable drawableLtr, Drawable drawableRtl) {
            super(drawableLtr, drawableRtl);
        }

        protected int getHotspotX(Drawable drawable, boolean isRtlRun) {
            if (isRtlRun) {
                return drawable.getIntrinsicWidth() / 4;
            }
            return (drawable.getIntrinsicWidth() * 3) / 4;
        }

        protected int getHorizontalGravity(boolean isRtlRun) {
            return isRtlRun ? 5 : 3;
        }

        public int getCurrentCursorOffset() {
            return Editor.this.mTextView.getSelectionStart();
        }

        public void updateSelection(int offset) {
            Selection.setSelection((Spannable) Editor.this.mTextView.getText(), offset, Editor.this.mTextView.getSelectionEnd());
            updateDrawable();
        }

        public void updatePosition(float x, float y) {
            int offset = Editor.this.mTextView.getOffsetForPosition(x, y);
            int selectionEnd = Editor.this.mTextView.getSelectionEnd();
            if (offset >= selectionEnd) {
                offset = Math.max(0, selectionEnd + Editor.EXTRACT_UNKNOWN);
            }
            positionAtCursorOffset(offset, Editor.DEBUG_UNDO);
        }

        public ActionPopupWindow getActionPopupWindow() {
            return this.mActionPopupWindow;
        }
    }

    class SpanController implements SpanWatcher {
        private static final int DISPLAY_TIMEOUT_MS = 3000;
        private Runnable mHidePopup;
        private EasyEditPopupWindow mPopupWindow;

        /* renamed from: android.widget.Editor.SpanController.1 */
        class C09701 implements Runnable {
            C09701() {
            }

            public void run() {
                SpanController.this.hide();
            }
        }

        /* renamed from: android.widget.Editor.SpanController.2 */
        class C09712 implements EasyEditDeleteListener {
            C09712() {
            }

            public void onDeleteClick(EasyEditSpan span) {
                Editable editable = (Editable) Editor.this.mTextView.getText();
                int start = editable.getSpanStart(span);
                int end = editable.getSpanEnd(span);
                if (start >= 0 && end >= 0) {
                    SpanController.this.sendEasySpanNotification(1, span);
                    Editor.this.mTextView.deleteText_internal(start, end);
                }
                editable.removeSpan(span);
            }
        }

        SpanController() {
        }

        private boolean isNonIntermediateSelectionSpan(Spannable text, Object span) {
            return ((Selection.SELECTION_START == span || Selection.SELECTION_END == span) && (text.getSpanFlags(span) & AccessibilityNodeInfo.ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY) == 0) ? true : Editor.DEBUG_UNDO;
        }

        public void onSpanAdded(Spannable text, Object span, int start, int end) {
            if (isNonIntermediateSelectionSpan(text, span)) {
                Editor.this.sendUpdateSelection();
            } else if (span instanceof EasyEditSpan) {
                if (this.mPopupWindow == null) {
                    this.mPopupWindow = new EasyEditPopupWindow(null);
                    this.mHidePopup = new C09701();
                }
                if (this.mPopupWindow.mEasyEditSpan != null) {
                    this.mPopupWindow.mEasyEditSpan.setDeleteEnabled(Editor.DEBUG_UNDO);
                }
                this.mPopupWindow.setEasyEditSpan((EasyEditSpan) span);
                this.mPopupWindow.setOnDeleteListener(new C09712());
                if (Editor.this.mTextView.getWindowVisibility() == 0 && Editor.this.mTextView.getLayout() != null && !Editor.this.extractedTextModeWillBeStarted()) {
                    this.mPopupWindow.show();
                    Editor.this.mTextView.removeCallbacks(this.mHidePopup);
                    Editor.this.mTextView.postDelayed(this.mHidePopup, 3000);
                }
            }
        }

        public void onSpanRemoved(Spannable text, Object span, int start, int end) {
            if (isNonIntermediateSelectionSpan(text, span)) {
                Editor.this.sendUpdateSelection();
            } else if (this.mPopupWindow != null && span == this.mPopupWindow.mEasyEditSpan) {
                hide();
            }
        }

        public void onSpanChanged(Spannable text, Object span, int previousStart, int previousEnd, int newStart, int newEnd) {
            if (isNonIntermediateSelectionSpan(text, span)) {
                Editor.this.sendUpdateSelection();
            } else if (this.mPopupWindow != null && (span instanceof EasyEditSpan)) {
                EasyEditSpan easyEditSpan = (EasyEditSpan) span;
                sendEasySpanNotification(2, easyEditSpan);
                text.removeSpan(easyEditSpan);
            }
        }

        public void hide() {
            if (this.mPopupWindow != null) {
                this.mPopupWindow.hide();
                Editor.this.mTextView.removeCallbacks(this.mHidePopup);
            }
        }

        private void sendEasySpanNotification(int textChangedType, EasyEditSpan span) {
            try {
                PendingIntent pendingIntent = span.getPendingIntent();
                if (pendingIntent != null) {
                    Intent intent = new Intent();
                    intent.putExtra(EasyEditSpan.EXTRA_TEXT_CHANGED_TYPE, textChangedType);
                    pendingIntent.send(Editor.this.mTextView.getContext(), 0, intent);
                }
            } catch (CanceledException e) {
                Log.w(Editor.TAG, "PendingIntent for notification cannot be sent", e);
            }
        }
    }

    private class SuggestionsPopupWindow extends PinnedPopupWindow implements OnItemClickListener {
        private static final int ADD_TO_DICTIONARY = -1;
        private static final int DELETE_TEXT = -2;
        private static final int MAX_NUMBER_SUGGESTIONS = 5;
        private boolean mCursorWasVisibleBeforeSuggestions;
        private boolean mIsShowingUp;
        private int mNumberOfSuggestions;
        private final HashMap<SuggestionSpan, Integer> mSpansLengths;
        private SuggestionInfo[] mSuggestionInfos;
        private final Comparator<SuggestionSpan> mSuggestionSpanComparator;
        private SuggestionAdapter mSuggestionsAdapter;

        private class CustomPopupWindow extends PopupWindow {
            public CustomPopupWindow(Context context, int defStyleAttr) {
                super(context, null, defStyleAttr);
            }

            public void dismiss() {
                super.dismiss();
                Editor.this.getPositionListener().removeSubscriber(SuggestionsPopupWindow.this);
                ((Spannable) Editor.this.mTextView.getText()).removeSpan(Editor.this.mSuggestionRangeSpan);
                Editor.this.mTextView.setCursorVisible(SuggestionsPopupWindow.this.mCursorWasVisibleBeforeSuggestions);
                if (Editor.this.hasInsertionController()) {
                    Editor.this.getInsertionController().show();
                }
            }
        }

        private class SuggestionAdapter extends BaseAdapter {
            private LayoutInflater mInflater;

            private SuggestionAdapter() {
                this.mInflater = (LayoutInflater) Editor.this.mTextView.getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            }

            public int getCount() {
                return SuggestionsPopupWindow.this.mNumberOfSuggestions;
            }

            public Object getItem(int position) {
                return SuggestionsPopupWindow.this.mSuggestionInfos[position];
            }

            public long getItemId(int position) {
                return (long) position;
            }

            public View getView(int position, View convertView, ViewGroup parent) {
                TextView textView = (TextView) convertView;
                if (textView == null) {
                    textView = (TextView) this.mInflater.inflate(Editor.this.mTextView.mTextEditSuggestionItemLayout, parent, (boolean) Editor.DEBUG_UNDO);
                }
                SuggestionInfo suggestionInfo = SuggestionsPopupWindow.this.mSuggestionInfos[position];
                textView.setText(suggestionInfo.text);
                if (suggestionInfo.suggestionIndex == SuggestionsPopupWindow.ADD_TO_DICTIONARY || suggestionInfo.suggestionIndex == SuggestionsPopupWindow.DELETE_TEXT) {
                    textView.setBackgroundColor(0);
                } else {
                    textView.setBackgroundColor(SuggestionsPopupWindow.ADD_TO_DICTIONARY);
                }
                return textView;
            }
        }

        private class SuggestionInfo {
            TextAppearanceSpan highlightSpan;
            int suggestionEnd;
            int suggestionIndex;
            SuggestionSpan suggestionSpan;
            int suggestionStart;
            SpannableStringBuilder text;

            private SuggestionInfo() {
                this.text = new SpannableStringBuilder();
                this.highlightSpan = new TextAppearanceSpan(Editor.this.mTextView.getContext(), 16974104);
            }
        }

        private class SuggestionSpanComparator implements Comparator<SuggestionSpan> {
            private SuggestionSpanComparator() {
            }

            public int compare(SuggestionSpan span1, SuggestionSpan span2) {
                boolean misspelled2 = Editor.DEBUG_UNDO;
                int flag1 = span1.getFlags();
                int flag2 = span2.getFlags();
                if (flag1 != flag2) {
                    boolean easy2;
                    boolean misspelled1;
                    boolean easy1 = (flag1 & 1) != 0 ? true : Editor.DEBUG_UNDO;
                    if ((flag2 & 1) != 0) {
                        easy2 = true;
                    } else {
                        easy2 = Editor.DEBUG_UNDO;
                    }
                    if ((flag1 & 2) != 0) {
                        misspelled1 = true;
                    } else {
                        misspelled1 = Editor.DEBUG_UNDO;
                    }
                    if ((flag2 & 2) != 0) {
                        misspelled2 = true;
                    }
                    if (easy1 && !misspelled1) {
                        return SuggestionsPopupWindow.ADD_TO_DICTIONARY;
                    }
                    if (easy2 && !misspelled2) {
                        return 1;
                    }
                    if (misspelled1) {
                        return SuggestionsPopupWindow.ADD_TO_DICTIONARY;
                    }
                    if (misspelled2) {
                        return 1;
                    }
                }
                return ((Integer) SuggestionsPopupWindow.this.mSpansLengths.get(span1)).intValue() - ((Integer) SuggestionsPopupWindow.this.mSpansLengths.get(span2)).intValue();
            }
        }

        public SuggestionsPopupWindow() {
            super();
            this.mIsShowingUp = Editor.DEBUG_UNDO;
            this.mCursorWasVisibleBeforeSuggestions = Editor.this.mCursorVisible;
            this.mSuggestionSpanComparator = new SuggestionSpanComparator();
            this.mSpansLengths = new HashMap();
        }

        protected void createPopupWindow() {
            this.mPopupWindow = new CustomPopupWindow(Editor.this.mTextView.getContext(), 16843635);
            this.mPopupWindow.setInputMethodMode(2);
            this.mPopupWindow.setFocusable(true);
            this.mPopupWindow.setClippingEnabled(Editor.DEBUG_UNDO);
        }

        protected void initContentView() {
            ListView listView = new ListView(Editor.this.mTextView.getContext());
            this.mSuggestionsAdapter = new SuggestionAdapter();
            listView.setAdapter(this.mSuggestionsAdapter);
            listView.setOnItemClickListener(this);
            this.mContentView = listView;
            this.mSuggestionInfos = new SuggestionInfo[7];
            for (int i = 0; i < this.mSuggestionInfos.length; i++) {
                this.mSuggestionInfos[i] = new SuggestionInfo();
            }
        }

        public boolean isShowingUp() {
            return this.mIsShowingUp;
        }

        public void onParentLostFocus() {
            this.mIsShowingUp = Editor.DEBUG_UNDO;
        }

        private SuggestionSpan[] getSuggestionSpans() {
            int pos = Editor.this.mTextView.getSelectionStart();
            Spannable spannable = (Spannable) Editor.this.mTextView.getText();
            SuggestionSpan[] suggestionSpans = (SuggestionSpan[]) spannable.getSpans(pos, pos, SuggestionSpan.class);
            this.mSpansLengths.clear();
            for (SuggestionSpan suggestionSpan : suggestionSpans) {
                this.mSpansLengths.put(suggestionSpan, Integer.valueOf(spannable.getSpanEnd(suggestionSpan) - spannable.getSpanStart(suggestionSpan)));
            }
            Arrays.sort(suggestionSpans, this.mSuggestionSpanComparator);
            return suggestionSpans;
        }

        public void show() {
            if ((Editor.this.mTextView.getText() instanceof Editable) && updateSuggestions()) {
                this.mCursorWasVisibleBeforeSuggestions = Editor.this.mCursorVisible;
                Editor.this.mTextView.setCursorVisible(Editor.DEBUG_UNDO);
                this.mIsShowingUp = true;
                super.show();
            }
        }

        protected void measureContent() {
            DisplayMetrics displayMetrics = Editor.this.mTextView.getResources().getDisplayMetrics();
            int horizontalMeasure = MeasureSpec.makeMeasureSpec(displayMetrics.widthPixels, RtlSpacingHelper.UNDEFINED);
            int verticalMeasure = MeasureSpec.makeMeasureSpec(displayMetrics.heightPixels, RtlSpacingHelper.UNDEFINED);
            int width = 0;
            View view = null;
            for (int i = 0; i < this.mNumberOfSuggestions; i++) {
                view = this.mSuggestionsAdapter.getView(i, view, this.mContentView);
                view.getLayoutParams().width = DELETE_TEXT;
                view.measure(horizontalMeasure, verticalMeasure);
                width = Math.max(width, view.getMeasuredWidth());
            }
            this.mContentView.measure(MeasureSpec.makeMeasureSpec(width, EditorInfo.IME_FLAG_NO_ENTER_ACTION), verticalMeasure);
            Drawable popupBackground = this.mPopupWindow.getBackground();
            if (popupBackground != null) {
                if (Editor.this.mTempRect == null) {
                    Editor.this.mTempRect = new Rect();
                }
                popupBackground.getPadding(Editor.this.mTempRect);
                width += Editor.this.mTempRect.left + Editor.this.mTempRect.right;
            }
            this.mPopupWindow.setWidth(width);
        }

        protected int getTextOffset() {
            return Editor.this.mTextView.getSelectionStart();
        }

        protected int getVerticalLocalPosition(int line) {
            return Editor.this.mTextView.getLayout().getLineBottom(line);
        }

        protected int clipVertically(int positionY) {
            return Math.min(positionY, Editor.this.mTextView.getResources().getDisplayMetrics().heightPixels - this.mContentView.getMeasuredHeight());
        }

        public void hide() {
            super.hide();
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private boolean updateSuggestions() {
            /*
            r35 = this;
            r0 = r35;
            r0 = android.widget.Editor.this;
            r30 = r0;
            r30 = r30.mTextView;
            r21 = r30.getText();
            r21 = (android.text.Spannable) r21;
            r27 = r35.getSuggestionSpans();
            r0 = r27;
            r10 = r0.length;
            if (r10 != 0) goto L_0x001c;
        L_0x0019:
            r30 = 0;
        L_0x001b:
            return r30;
        L_0x001c:
            r30 = 0;
            r0 = r30;
            r1 = r35;
            r1.mNumberOfSuggestions = r0;
            r0 = r35;
            r0 = android.widget.Editor.this;
            r30 = r0;
            r30 = r30.mTextView;
            r30 = r30.getText();
            r20 = r30.length();
            r19 = 0;
            r8 = 0;
            r29 = 0;
            r17 = 0;
        L_0x003d:
            r0 = r17;
            if (r0 >= r10) goto L_0x0130;
        L_0x0041:
            r26 = r27[r17];
            r0 = r21;
            r1 = r26;
            r18 = r0.getSpanStart(r1);
            r0 = r21;
            r1 = r26;
            r16 = r0.getSpanEnd(r1);
            r0 = r18;
            r1 = r20;
            r20 = java.lang.Math.min(r0, r1);
            r0 = r16;
            r1 = r19;
            r19 = java.lang.Math.max(r0, r1);
            r30 = r26.getFlags();
            r30 = r30 & 2;
            if (r30 == 0) goto L_0x006d;
        L_0x006b:
            r8 = r26;
        L_0x006d:
            if (r17 != 0) goto L_0x0073;
        L_0x006f:
            r29 = r26.getUnderlineColor();
        L_0x0073:
            r28 = r26.getSuggestions();
            r0 = r28;
            r11 = r0.length;
            r23 = 0;
        L_0x007c:
            r0 = r23;
            if (r0 >= r11) goto L_0x0124;
        L_0x0080:
            r22 = r28[r23];
            r25 = 0;
            r6 = 0;
        L_0x0085:
            r0 = r35;
            r0 = r0.mNumberOfSuggestions;
            r30 = r0;
            r0 = r30;
            if (r6 >= r0) goto L_0x00cd;
        L_0x008f:
            r0 = r35;
            r0 = r0.mSuggestionInfos;
            r30 = r0;
            r30 = r30[r6];
            r0 = r30;
            r0 = r0.text;
            r30 = r0;
            r30 = r30.toString();
            r0 = r30;
            r1 = r22;
            r30 = r0.equals(r1);
            if (r30 == 0) goto L_0x0128;
        L_0x00ab:
            r0 = r35;
            r0 = r0.mSuggestionInfos;
            r30 = r0;
            r30 = r30[r6];
            r0 = r30;
            r15 = r0.suggestionSpan;
            r0 = r21;
            r14 = r0.getSpanStart(r15);
            r0 = r21;
            r13 = r0.getSpanEnd(r15);
            r0 = r18;
            if (r0 != r14) goto L_0x0128;
        L_0x00c7:
            r0 = r16;
            if (r0 != r13) goto L_0x0128;
        L_0x00cb:
            r25 = 1;
        L_0x00cd:
            if (r25 != 0) goto L_0x012c;
        L_0x00cf:
            r0 = r35;
            r0 = r0.mSuggestionInfos;
            r30 = r0;
            r0 = r35;
            r0 = r0.mNumberOfSuggestions;
            r31 = r0;
            r24 = r30[r31];
            r0 = r26;
            r1 = r24;
            r1.suggestionSpan = r0;
            r0 = r23;
            r1 = r24;
            r1.suggestionIndex = r0;
            r0 = r24;
            r0 = r0.text;
            r30 = r0;
            r31 = 0;
            r0 = r24;
            r0 = r0.text;
            r32 = r0;
            r32 = r32.length();
            r0 = r30;
            r1 = r31;
            r2 = r32;
            r3 = r22;
            r0.replace(r1, r2, r3);
            r0 = r35;
            r0 = r0.mNumberOfSuggestions;
            r30 = r0;
            r30 = r30 + 1;
            r0 = r30;
            r1 = r35;
            r1.mNumberOfSuggestions = r0;
            r0 = r35;
            r0 = r0.mNumberOfSuggestions;
            r30 = r0;
            r31 = 5;
            r0 = r30;
            r1 = r31;
            if (r0 != r1) goto L_0x012c;
        L_0x0122:
            r17 = r10;
        L_0x0124:
            r17 = r17 + 1;
            goto L_0x003d;
        L_0x0128:
            r6 = r6 + 1;
            goto L_0x0085;
        L_0x012c:
            r23 = r23 + 1;
            goto L_0x007c;
        L_0x0130:
            r6 = 0;
        L_0x0131:
            r0 = r35;
            r0 = r0.mNumberOfSuggestions;
            r30 = r0;
            r0 = r30;
            if (r6 >= r0) goto L_0x0151;
        L_0x013b:
            r0 = r35;
            r0 = r0.mSuggestionInfos;
            r30 = r0;
            r30 = r30[r6];
            r0 = r35;
            r1 = r30;
            r2 = r20;
            r3 = r19;
            r0.highlightTextDifferences(r1, r2, r3);
            r6 = r6 + 1;
            goto L_0x0131;
        L_0x0151:
            if (r8 == 0) goto L_0x01ca;
        L_0x0153:
            r0 = r21;
            r9 = r0.getSpanStart(r8);
            r0 = r21;
            r7 = r0.getSpanEnd(r8);
            if (r9 < 0) goto L_0x01ca;
        L_0x0161:
            if (r7 <= r9) goto L_0x01ca;
        L_0x0163:
            r0 = r35;
            r0 = r0.mSuggestionInfos;
            r30 = r0;
            r0 = r35;
            r0 = r0.mNumberOfSuggestions;
            r31 = r0;
            r24 = r30[r31];
            r0 = r24;
            r0.suggestionSpan = r8;
            r30 = -1;
            r0 = r30;
            r1 = r24;
            r1.suggestionIndex = r0;
            r0 = r24;
            r0 = r0.text;
            r30 = r0;
            r31 = 0;
            r0 = r24;
            r0 = r0.text;
            r32 = r0;
            r32 = r32.length();
            r0 = r35;
            r0 = android.widget.Editor.this;
            r33 = r0;
            r33 = r33.mTextView;
            r33 = r33.getContext();
            r34 = 17040499; // 0x1040473 float:2.4247763E-38 double:8.419125E-317;
            r33 = r33.getString(r34);
            r30.replace(r31, r32, r33);
            r0 = r24;
            r0 = r0.text;
            r30 = r0;
            r0 = r24;
            r0 = r0.highlightSpan;
            r31 = r0;
            r32 = 0;
            r33 = 0;
            r34 = 33;
            r30.setSpan(r31, r32, r33, r34);
            r0 = r35;
            r0 = r0.mNumberOfSuggestions;
            r30 = r0;
            r30 = r30 + 1;
            r0 = r30;
            r1 = r35;
            r1.mNumberOfSuggestions = r0;
        L_0x01ca:
            r0 = r35;
            r0 = r0.mSuggestionInfos;
            r30 = r0;
            r0 = r35;
            r0 = r0.mNumberOfSuggestions;
            r31 = r0;
            r24 = r30[r31];
            r30 = 0;
            r0 = r30;
            r1 = r24;
            r1.suggestionSpan = r0;
            r30 = -2;
            r0 = r30;
            r1 = r24;
            r1.suggestionIndex = r0;
            r0 = r24;
            r0 = r0.text;
            r30 = r0;
            r31 = 0;
            r0 = r24;
            r0 = r0.text;
            r32 = r0;
            r32 = r32.length();
            r0 = r35;
            r0 = android.widget.Editor.this;
            r33 = r0;
            r33 = r33.mTextView;
            r33 = r33.getContext();
            r34 = 17040500; // 0x1040474 float:2.4247766E-38 double:8.4191256E-317;
            r33 = r33.getString(r34);
            r30.replace(r31, r32, r33);
            r0 = r24;
            r0 = r0.text;
            r30 = r0;
            r0 = r24;
            r0 = r0.highlightSpan;
            r31 = r0;
            r32 = 0;
            r33 = 0;
            r34 = 33;
            r30.setSpan(r31, r32, r33, r34);
            r0 = r35;
            r0 = r0.mNumberOfSuggestions;
            r30 = r0;
            r30 = r30 + 1;
            r0 = r30;
            r1 = r35;
            r1.mNumberOfSuggestions = r0;
            r0 = r35;
            r0 = android.widget.Editor.this;
            r30 = r0;
            r0 = r30;
            r0 = r0.mSuggestionRangeSpan;
            r30 = r0;
            if (r30 != 0) goto L_0x0254;
        L_0x0243:
            r0 = r35;
            r0 = android.widget.Editor.this;
            r30 = r0;
            r31 = new android.text.style.SuggestionRangeSpan;
            r31.<init>();
            r0 = r31;
            r1 = r30;
            r1.mSuggestionRangeSpan = r0;
        L_0x0254:
            if (r29 != 0) goto L_0x029d;
        L_0x0256:
            r0 = r35;
            r0 = android.widget.Editor.this;
            r30 = r0;
            r0 = r30;
            r0 = r0.mSuggestionRangeSpan;
            r30 = r0;
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r31 = r31.mTextView;
            r0 = r31;
            r0 = r0.mHighlightColor;
            r31 = r0;
            r30.setBackgroundColor(r31);
        L_0x0275:
            r0 = r35;
            r0 = android.widget.Editor.this;
            r30 = r0;
            r0 = r30;
            r0 = r0.mSuggestionRangeSpan;
            r30 = r0;
            r31 = 33;
            r0 = r21;
            r1 = r30;
            r2 = r20;
            r3 = r19;
            r4 = r31;
            r0.setSpan(r1, r2, r3, r4);
            r0 = r35;
            r0 = r0.mSuggestionsAdapter;
            r30 = r0;
            r30.notifyDataSetChanged();
            r30 = 1;
            goto L_0x001b;
        L_0x029d:
            r5 = 1053609165; // 0x3ecccccd float:0.4 double:5.205520926E-315;
            r30 = android.graphics.Color.alpha(r29);
            r0 = r30;
            r0 = (float) r0;
            r30 = r0;
            r31 = 1053609165; // 0x3ecccccd float:0.4 double:5.205520926E-315;
            r30 = r30 * r31;
            r0 = r30;
            r12 = (int) r0;
            r0 = r35;
            r0 = android.widget.Editor.this;
            r30 = r0;
            r0 = r30;
            r0 = r0.mSuggestionRangeSpan;
            r30 = r0;
            r31 = 16777215; // 0xffffff float:2.3509886E-38 double:8.2890456E-317;
            r31 = r31 & r29;
            r32 = r12 << 24;
            r31 = r31 + r32;
            r30.setBackgroundColor(r31);
            goto L_0x0275;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.widget.Editor.SuggestionsPopupWindow.updateSuggestions():boolean");
        }

        private void highlightTextDifferences(SuggestionInfo suggestionInfo, int unionStart, int unionEnd) {
            Spannable text = (Spannable) Editor.this.mTextView.getText();
            int spanStart = text.getSpanStart(suggestionInfo.suggestionSpan);
            int spanEnd = text.getSpanEnd(suggestionInfo.suggestionSpan);
            suggestionInfo.suggestionStart = spanStart - unionStart;
            suggestionInfo.suggestionEnd = suggestionInfo.suggestionStart + suggestionInfo.text.length();
            suggestionInfo.text.setSpan(suggestionInfo.highlightSpan, 0, suggestionInfo.text.length(), 33);
            String textAsString = text.toString();
            suggestionInfo.text.insert(0, textAsString.substring(unionStart, spanStart));
            suggestionInfo.text.append(textAsString.substring(spanEnd, unionEnd));
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onItemClick(android.widget.AdapterView<?> r36, android.view.View r37, int r38, long r39) {
            /*
            r35 = this;
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r31 = r31.mTextView;
            r4 = r31.getText();
            r4 = (android.text.Editable) r4;
            r0 = r35;
            r0 = r0.mSuggestionInfos;
            r31 = r0;
            r21 = r31[r38];
            r0 = r21;
            r0 = r0.suggestionIndex;
            r31 = r0;
            r32 = -2;
            r0 = r31;
            r1 = r32;
            if (r0 != r1) goto L_0x0091;
        L_0x0026:
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r0 = r31;
            r0 = r0.mSuggestionRangeSpan;
            r31 = r0;
            r0 = r31;
            r17 = r4.getSpanStart(r0);
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r0 = r31;
            r0 = r0.mSuggestionRangeSpan;
            r31 = r0;
            r0 = r31;
            r16 = r4.getSpanEnd(r0);
            if (r17 < 0) goto L_0x008d;
        L_0x004c:
            r0 = r16;
            r1 = r17;
            if (r0 <= r1) goto L_0x008d;
        L_0x0052:
            r31 = r4.length();
            r0 = r16;
            r1 = r31;
            if (r0 >= r1) goto L_0x007a;
        L_0x005c:
            r0 = r16;
            r31 = r4.charAt(r0);
            r31 = java.lang.Character.isSpaceChar(r31);
            if (r31 == 0) goto L_0x007a;
        L_0x0068:
            if (r17 == 0) goto L_0x0078;
        L_0x006a:
            r31 = r17 + -1;
            r0 = r31;
            r31 = r4.charAt(r0);
            r31 = java.lang.Character.isSpaceChar(r31);
            if (r31 == 0) goto L_0x007a;
        L_0x0078:
            r16 = r16 + 1;
        L_0x007a:
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r31 = r31.mTextView;
            r0 = r31;
            r1 = r17;
            r2 = r16;
            r0.deleteText_internal(r1, r2);
        L_0x008d:
            r35.hide();
        L_0x0090:
            return;
        L_0x0091:
            r0 = r21;
            r0 = r0.suggestionSpan;
            r31 = r0;
            r0 = r31;
            r15 = r4.getSpanStart(r0);
            r0 = r21;
            r0 = r0.suggestionSpan;
            r31 = r0;
            r0 = r31;
            r14 = r4.getSpanEnd(r0);
            if (r15 < 0) goto L_0x00ad;
        L_0x00ab:
            if (r14 > r15) goto L_0x00b1;
        L_0x00ad:
            r35.hide();
            goto L_0x0090;
        L_0x00b1:
            r31 = r4.toString();
            r0 = r31;
            r11 = r0.substring(r15, r14);
            r0 = r21;
            r0 = r0.suggestionIndex;
            r31 = r0;
            r32 = -1;
            r0 = r31;
            r1 = r32;
            if (r0 != r1) goto L_0x0137;
        L_0x00c9:
            r6 = new android.content.Intent;
            r31 = "com.android.settings.USER_DICTIONARY_INSERT";
            r0 = r31;
            r6.<init>(r0);
            r31 = "word";
            r0 = r31;
            r6.putExtra(r0, r11);
            r31 = "locale";
            r0 = r35;
            r0 = android.widget.Editor.this;
            r32 = r0;
            r32 = r32.mTextView;
            r32 = r32.getTextServicesLocale();
            r32 = r32.toString();
            r0 = r31;
            r1 = r32;
            r6.putExtra(r0, r1);
            r31 = r6.getFlags();
            r32 = 268435456; // 0x10000000 float:2.5243549E-29 double:1.32624737E-315;
            r31 = r31 | r32;
            r0 = r31;
            r6.setFlags(r0);
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r31 = r31.mTextView;
            r31 = r31.getContext();
            r0 = r31;
            r0.startActivity(r6);
            r0 = r21;
            r0 = r0.suggestionSpan;
            r31 = r0;
            r0 = r31;
            r4.removeSpan(r0);
            android.text.Selection.setSelection(r4, r14);
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r32 = 0;
            r0 = r31;
            r1 = r32;
            r0.updateSpellCheckSpans(r15, r14, r1);
        L_0x0132:
            r35.hide();
            goto L_0x0090;
        L_0x0137:
            r31 = android.text.style.SuggestionSpan.class;
            r0 = r31;
            r24 = r4.getSpans(r15, r14, r0);
            r24 = (android.text.style.SuggestionSpan[]) r24;
            r0 = r24;
            r7 = r0.length;
            r0 = new int[r7];
            r27 = r0;
            r0 = new int[r7];
            r25 = r0;
            r0 = new int[r7];
            r26 = r0;
            r5 = 0;
        L_0x0151:
            if (r5 >= r7) goto L_0x017f;
        L_0x0153:
            r22 = r24[r5];
            r0 = r22;
            r31 = r4.getSpanStart(r0);
            r27[r5] = r31;
            r0 = r22;
            r31 = r4.getSpanEnd(r0);
            r25[r5] = r31;
            r0 = r22;
            r31 = r4.getSpanFlags(r0);
            r26[r5] = r31;
            r23 = r22.getFlags();
            r31 = r23 & 2;
            if (r31 <= 0) goto L_0x017c;
        L_0x0175:
            r23 = r23 & -3;
            r23 = r23 & -2;
            r22.setFlags(r23);
        L_0x017c:
            r5 = r5 + 1;
            goto L_0x0151;
        L_0x017f:
            r0 = r21;
            r0 = r0.suggestionStart;
            r28 = r0;
            r0 = r21;
            r0 = r0.suggestionEnd;
            r20 = r0;
            r0 = r21;
            r0 = r0.text;
            r31 = r0;
            r0 = r31;
            r1 = r28;
            r2 = r20;
            r31 = r0.subSequence(r1, r2);
            r19 = r31.toString();
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r31 = r31.mTextView;
            r0 = r31;
            r1 = r19;
            r0.replaceText_internal(r15, r14, r1);
            r0 = r21;
            r0 = r0.suggestionSpan;
            r31 = r0;
            r0 = r35;
            r0 = android.widget.Editor.this;
            r32 = r0;
            r32 = r32.mTextView;
            r32 = r32.getContext();
            r0 = r21;
            r0 = r0.suggestionIndex;
            r33 = r0;
            r0 = r31;
            r1 = r32;
            r2 = r33;
            r0.notifySelection(r1, r11, r2);
            r0 = r21;
            r0 = r0.suggestionSpan;
            r31 = r0;
            r29 = r31.getSuggestions();
            r0 = r21;
            r0 = r0.suggestionIndex;
            r31 = r0;
            r29[r31] = r11;
            r31 = r19.length();
            r32 = r14 - r15;
            r8 = r31 - r32;
            r5 = 0;
        L_0x01ee:
            if (r5 >= r7) goto L_0x0238;
        L_0x01f0:
            r31 = r27[r5];
            r0 = r31;
            if (r0 > r15) goto L_0x0232;
        L_0x01f6:
            r31 = r25[r5];
            r0 = r31;
            if (r0 < r14) goto L_0x0232;
        L_0x01fc:
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r31 = r31.mTextView;
            r31 = r31.getText();
            r9 = r31.length();
            r31 = r25[r5];
            r18 = r31 + r8;
            r0 = r18;
            if (r0 <= r9) goto L_0x0235;
        L_0x0216:
            r13 = r9;
        L_0x0217:
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r31 = r31.mTextView;
            r32 = r24[r5];
            r33 = r27[r5];
            r34 = r26[r5];
            r0 = r31;
            r1 = r32;
            r2 = r33;
            r3 = r34;
            r0.setSpan_internal(r1, r2, r13, r3);
        L_0x0232:
            r5 = r5 + 1;
            goto L_0x01ee;
        L_0x0235:
            r13 = r18;
            goto L_0x0217;
        L_0x0238:
            r10 = r14 + r8;
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r31 = r31.mTextView;
            r31 = r31.getText();
            r30 = r31.length();
            r0 = r30;
            if (r10 <= r0) goto L_0x0263;
        L_0x0250:
            r12 = r30;
        L_0x0252:
            r0 = r35;
            r0 = android.widget.Editor.this;
            r31 = r0;
            r31 = r31.mTextView;
            r0 = r31;
            r0.setCursorPosition_internal(r12, r12);
            goto L_0x0132;
        L_0x0263:
            r12 = r10;
            goto L_0x0252;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.widget.Editor.SuggestionsPopupWindow.onItemClick(android.widget.AdapterView, android.view.View, int, long):void");
        }
    }

    private static class TextDisplayList {
        RenderNode displayList;
        boolean isDirty;

        public TextDisplayList(String name) {
            this.isDirty = true;
            this.displayList = RenderNode.create(name, null);
        }

        boolean needsRecord() {
            return (this.isDirty || !this.displayList.isValid()) ? true : Editor.DEBUG_UNDO;
        }
    }

    public static class TextModifyOperation extends UndoOperation<TextView> {
        public static final ClassLoaderCreator<TextModifyOperation> CREATOR;
        CharSequence mOldText;
        int mRangeEnd;
        int mRangeStart;

        /* renamed from: android.widget.Editor.TextModifyOperation.1 */
        static class C09721 implements ClassLoaderCreator<TextModifyOperation> {
            C09721() {
            }

            public TextModifyOperation createFromParcel(Parcel in) {
                return new TextModifyOperation(in, null);
            }

            public TextModifyOperation createFromParcel(Parcel in, ClassLoader loader) {
                return new TextModifyOperation(in, loader);
            }

            public TextModifyOperation[] newArray(int size) {
                return new TextModifyOperation[size];
            }
        }

        public TextModifyOperation(UndoOwner owner) {
            super(owner);
        }

        public TextModifyOperation(Parcel src, ClassLoader loader) {
            super(src, loader);
            this.mRangeStart = src.readInt();
            this.mRangeEnd = src.readInt();
            this.mOldText = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(src);
        }

        public void commit() {
        }

        public void undo() {
            swapText();
        }

        public void redo() {
            swapText();
        }

        private void swapText() {
            CharSequence curText;
            Editable editable = (Editable) ((TextView) getOwnerData()).getText();
            if (this.mRangeStart >= this.mRangeEnd) {
                curText = null;
            } else {
                curText = editable.subSequence(this.mRangeStart, this.mRangeEnd);
            }
            if (this.mOldText == null) {
                editable.delete(this.mRangeStart, this.mRangeEnd);
                this.mRangeEnd = this.mRangeStart;
            } else {
                editable.replace(this.mRangeStart, this.mRangeEnd, this.mOldText);
                this.mRangeEnd = this.mRangeStart + this.mOldText.length();
            }
            this.mOldText = curText;
        }

        public void writeToParcel(Parcel dest, int flags) {
            dest.writeInt(this.mRangeStart);
            dest.writeInt(this.mRangeEnd);
            TextUtils.writeToParcel(this.mOldText, dest, flags);
        }

        static {
            CREATOR = new C09721();
        }
    }

    public static class UndoInputFilter implements InputFilter {
        final Editor mEditor;

        public UndoInputFilter(Editor editor) {
            this.mEditor = editor;
        }

        public CharSequence filter(CharSequence source, int start, int end, Spanned dest, int dstart, int dend) {
            UndoManager um = this.mEditor.mUndoManager;
            if (!um.isInUndo()) {
                um.beginUpdate("Edit text");
                TextModifyOperation op = (TextModifyOperation) um.getLastOperation(TextModifyOperation.class, this.mEditor.mUndoOwner, 1);
                if (op != null) {
                    if (op.mOldText == null) {
                        if (start < end && ((dstart >= op.mRangeStart && dend <= op.mRangeEnd) || (dstart == op.mRangeEnd && dend == op.mRangeEnd))) {
                            op.mRangeEnd = (end - start) + dstart;
                            um.endUpdate();
                        }
                    } else if (start == end && dend == op.mRangeStart + Editor.EXTRACT_UNKNOWN) {
                        SpannableStringBuilder str;
                        if (op.mOldText instanceof SpannableString) {
                            str = (SpannableStringBuilder) op.mOldText;
                        } else {
                            str = new SpannableStringBuilder(op.mOldText);
                        }
                        str.insert(0, (CharSequence) dest, dstart, dend);
                        op.mRangeStart = dstart;
                        op.mOldText = str;
                        um.endUpdate();
                    }
                    um.commitState(null);
                    um.setUndoLabel("Edit text");
                }
                op = new TextModifyOperation(this.mEditor.mUndoOwner);
                op.mRangeStart = dstart;
                if (start < end) {
                    op.mRangeEnd = (end - start) + dstart;
                } else {
                    op.mRangeEnd = dstart;
                }
                if (dstart < dend) {
                    op.mOldText = dest.subSequence(dstart, dend);
                }
                um.addOperation(op, 0);
                um.endUpdate();
            }
            return null;
        }
    }

    static {
        TEMP_POSITION = new float[2];
        DRAG_SHADOW_MAX_TEXT_LENGTH = 20;
    }

    Editor(TextView textView) {
        this.mInputType = 0;
        this.mCursorVisible = true;
        this.mShowSoftInputOnFocus = true;
        this.mCursorDrawable = new Drawable[2];
        this.mCursorAnchorInfoNotifier = new CursorAnchorInfoNotifier();
        this.mTextView = textView;
    }

    void onAttachedToWindow() {
        if (this.mShowErrorAfterAttach) {
            showError();
            this.mShowErrorAfterAttach = DEBUG_UNDO;
        }
        this.mTemporaryDetach = DEBUG_UNDO;
        ViewTreeObserver observer = this.mTextView.getViewTreeObserver();
        if (this.mInsertionPointCursorController != null) {
            observer.addOnTouchModeChangeListener(this.mInsertionPointCursorController);
        }
        if (this.mSelectionModifierCursorController != null) {
            this.mSelectionModifierCursorController.resetTouchOffsets();
            observer.addOnTouchModeChangeListener(this.mSelectionModifierCursorController);
        }
        updateSpellCheckSpans(0, this.mTextView.getText().length(), true);
        if (this.mTextView.hasTransientState() && this.mTextView.getSelectionStart() != this.mTextView.getSelectionEnd()) {
            this.mTextView.setHasTransientState(DEBUG_UNDO);
            startSelectionActionMode();
        }
        getPositionListener().addSubscriber(this.mCursorAnchorInfoNotifier, true);
        resumeBlink();
    }

    void onDetachedFromWindow() {
        getPositionListener().removeSubscriber(this.mCursorAnchorInfoNotifier);
        if (this.mError != null) {
            hideError();
        }
        suspendBlink();
        if (this.mInsertionPointCursorController != null) {
            this.mInsertionPointCursorController.onDetached();
        }
        if (this.mSelectionModifierCursorController != null) {
            this.mSelectionModifierCursorController.onDetached();
        }
        if (this.mShowSuggestionRunnable != null) {
            this.mTextView.removeCallbacks(this.mShowSuggestionRunnable);
        }
        destroyDisplayListsData();
        if (this.mSpellChecker != null) {
            this.mSpellChecker.closeSession();
            this.mSpellChecker = null;
        }
        this.mPreserveDetachedSelection = true;
        hideControllers();
        this.mPreserveDetachedSelection = DEBUG_UNDO;
        this.mTemporaryDetach = DEBUG_UNDO;
    }

    private void destroyDisplayListsData() {
        if (this.mTextDisplayLists != null) {
            for (int i = 0; i < this.mTextDisplayLists.length; i++) {
                RenderNode displayList = this.mTextDisplayLists[i] != null ? this.mTextDisplayLists[i].displayList : null;
                if (displayList != null && displayList.isValid()) {
                    displayList.destroyDisplayListData();
                }
            }
        }
    }

    private void showError() {
        if (this.mTextView.getWindowToken() == null) {
            this.mShowErrorAfterAttach = true;
            return;
        }
        if (this.mErrorPopup == null) {
            TextView err = (TextView) LayoutInflater.from(this.mTextView.getContext()).inflate(17367263, null);
            float scale = this.mTextView.getResources().getDisplayMetrics().density;
            this.mErrorPopup = new ErrorPopup(err, (int) ((200.0f * scale) + 0.5f), (int) ((50.0f * scale) + 0.5f));
            this.mErrorPopup.setFocusable(DEBUG_UNDO);
            this.mErrorPopup.setInputMethodMode(1);
        }
        TextView tv = (TextView) this.mErrorPopup.getContentView();
        chooseSize(this.mErrorPopup, this.mError, tv);
        tv.setText(this.mError);
        this.mErrorPopup.showAsDropDown(this.mTextView, getErrorX(), getErrorY());
        this.mErrorPopup.fixDirection(this.mErrorPopup.isAboveAnchor());
    }

    public void setError(CharSequence error, Drawable icon) {
        this.mError = TextUtils.stringOrSpannedString(error);
        this.mErrorWasChanged = true;
        if (this.mError == null) {
            setErrorIcon(null);
            if (this.mErrorPopup != null) {
                if (this.mErrorPopup.isShowing()) {
                    this.mErrorPopup.dismiss();
                }
                this.mErrorPopup = null;
            }
            this.mShowErrorAfterAttach = DEBUG_UNDO;
            return;
        }
        setErrorIcon(icon);
        if (this.mTextView.isFocused()) {
            showError();
        }
    }

    private void setErrorIcon(Drawable icon) {
        Drawables dr = this.mTextView.mDrawables;
        if (dr == null) {
            TextView textView = this.mTextView;
            dr = new Drawables(this.mTextView.getContext());
            textView.mDrawables = dr;
        }
        dr.setErrorDrawable(icon, this.mTextView);
        this.mTextView.resetResolvedDrawables();
        this.mTextView.invalidate();
        this.mTextView.requestLayout();
    }

    private void hideError() {
        if (this.mErrorPopup != null && this.mErrorPopup.isShowing()) {
            this.mErrorPopup.dismiss();
        }
        this.mShowErrorAfterAttach = DEBUG_UNDO;
    }

    private int getErrorX() {
        int i = 0;
        float scale = this.mTextView.getResources().getDisplayMetrics().density;
        Drawables dr = this.mTextView.mDrawables;
        switch (this.mTextView.getLayoutDirection()) {
            case Toast.LENGTH_LONG /*1*/:
                if (dr != null) {
                    i = dr.mDrawableSizeLeft;
                }
                return this.mTextView.getPaddingLeft() + ((i / 2) - ((int) ((25.0f * scale) + 0.5f)));
            default:
                if (dr != null) {
                    i = dr.mDrawableSizeRight;
                }
                return ((this.mTextView.getWidth() - this.mErrorPopup.getWidth()) - this.mTextView.getPaddingRight()) + (((-i) / 2) + ((int) ((25.0f * scale) + 0.5f)));
        }
    }

    private int getErrorY() {
        int height = 0;
        int compoundPaddingTop = this.mTextView.getCompoundPaddingTop();
        int vspace = ((this.mTextView.getBottom() - this.mTextView.getTop()) - this.mTextView.getCompoundPaddingBottom()) - compoundPaddingTop;
        Drawables dr = this.mTextView.mDrawables;
        switch (this.mTextView.getLayoutDirection()) {
            case Toast.LENGTH_LONG /*1*/:
                if (dr != null) {
                    height = dr.mDrawableHeightLeft;
                }
                break;
            default:
                if (dr != null) {
                    height = dr.mDrawableHeightRight;
                    break;
                }
                break;
        }
        return (((compoundPaddingTop + ((vspace - height) / 2)) + height) - this.mTextView.getHeight()) - ((int) ((2.0f * this.mTextView.getResources().getDisplayMetrics().density) + 0.5f));
    }

    void createInputContentTypeIfNeeded() {
        if (this.mInputContentType == null) {
            this.mInputContentType = new InputContentType();
        }
    }

    void createInputMethodStateIfNeeded() {
        if (this.mInputMethodState == null) {
            this.mInputMethodState = new InputMethodState();
        }
    }

    boolean isCursorVisible() {
        return (this.mCursorVisible && this.mTextView.isTextEditable()) ? true : DEBUG_UNDO;
    }

    void prepareCursorControllers() {
        boolean enabled;
        boolean z;
        boolean z2 = true;
        boolean windowSupportsHandles = DEBUG_UNDO;
        ViewGroup.LayoutParams params = this.mTextView.getRootView().getLayoutParams();
        if (params instanceof LayoutParams) {
            LayoutParams windowParams = (LayoutParams) params;
            if (windowParams.type < LayoutParams.TYPE_APPLICATION_PANEL || windowParams.type > LayoutParams.LAST_SUB_WINDOW) {
                windowSupportsHandles = true;
            } else {
                windowSupportsHandles = DEBUG_UNDO;
            }
        }
        if (!windowSupportsHandles || this.mTextView.getLayout() == null) {
            enabled = DEBUG_UNDO;
        } else {
            enabled = true;
        }
        if (enabled && isCursorVisible()) {
            z = true;
        } else {
            z = DEBUG_UNDO;
        }
        this.mInsertionControllerEnabled = z;
        if (!(enabled && this.mTextView.textCanBeSelected())) {
            z2 = DEBUG_UNDO;
        }
        this.mSelectionControllerEnabled = z2;
        if (!this.mInsertionControllerEnabled) {
            hideInsertionPointCursorController();
            if (this.mInsertionPointCursorController != null) {
                this.mInsertionPointCursorController.onDetached();
                this.mInsertionPointCursorController = null;
            }
        }
        if (!this.mSelectionControllerEnabled) {
            stopSelectionActionMode();
            if (this.mSelectionModifierCursorController != null) {
                this.mSelectionModifierCursorController.onDetached();
                this.mSelectionModifierCursorController = null;
            }
        }
    }

    private void hideInsertionPointCursorController() {
        if (this.mInsertionPointCursorController != null) {
            this.mInsertionPointCursorController.hide();
        }
    }

    void hideControllers() {
        hideCursorControllers();
        hideSpanControllers();
    }

    private void hideSpanControllers() {
        if (this.mSpanController != null) {
            this.mSpanController.hide();
        }
    }

    private void hideCursorControllers() {
        if (!(this.mSuggestionsPopupWindow == null || this.mSuggestionsPopupWindow.isShowingUp())) {
            this.mSuggestionsPopupWindow.hide();
        }
        hideInsertionPointCursorController();
        stopSelectionActionMode();
    }

    private void updateSpellCheckSpans(int start, int end, boolean createSpellChecker) {
        this.mTextView.removeAdjacentSuggestionSpans(start);
        this.mTextView.removeAdjacentSuggestionSpans(end);
        if (this.mTextView.isTextEditable() && this.mTextView.isSuggestionsEnabled() && !(this.mTextView instanceof ExtractEditText)) {
            if (this.mSpellChecker == null && createSpellChecker) {
                this.mSpellChecker = new SpellChecker(this.mTextView);
            }
            if (this.mSpellChecker != null) {
                this.mSpellChecker.spellCheck(start, end);
            }
        }
    }

    void onScreenStateChanged(int screenState) {
        switch (screenState) {
            case Toast.LENGTH_SHORT /*0*/:
                suspendBlink();
            case Toast.LENGTH_LONG /*1*/:
                resumeBlink();
            default:
        }
    }

    private void suspendBlink() {
        if (this.mBlink != null) {
            this.mBlink.cancel();
        }
    }

    private void resumeBlink() {
        if (this.mBlink != null) {
            this.mBlink.uncancel();
            makeBlink();
        }
    }

    void adjustInputType(boolean password, boolean passwordInputType, boolean webPasswordInputType, boolean numberPasswordInputType) {
        if ((this.mInputType & 15) == 1) {
            if (password || passwordInputType) {
                this.mInputType = (this.mInputType & -4081) | AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS;
            }
            if (webPasswordInputType) {
                this.mInputType = (this.mInputType & -4081) | KeyEvent.KEYCODE_WAKEUP;
            }
        } else if ((this.mInputType & 15) == 2 && numberPasswordInputType) {
            this.mInputType = (this.mInputType & -4081) | 16;
        }
    }

    private void chooseSize(PopupWindow pop, CharSequence text, TextView tv) {
        int wid = tv.getPaddingLeft() + tv.getPaddingRight();
        int ht = tv.getPaddingTop() + tv.getPaddingBottom();
        CharSequence charSequence = text;
        Layout l = new StaticLayout(charSequence, tv.getPaint(), this.mTextView.getResources().getDimensionPixelSize(17104972), Alignment.ALIGN_NORMAL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f, true);
        float max = 0.0f;
        for (int i = 0; i < l.getLineCount(); i++) {
            max = Math.max(max, l.getLineWidth(i));
        }
        pop.setWidth(((int) Math.ceil((double) max)) + wid);
        pop.setHeight(l.getHeight() + ht);
    }

    void setFrame() {
        if (this.mErrorPopup != null) {
            chooseSize(this.mErrorPopup, this.mError, (TextView) this.mErrorPopup.getContentView());
            this.mErrorPopup.update(this.mTextView, getErrorX(), getErrorY(), this.mErrorPopup.getWidth(), this.mErrorPopup.getHeight());
        }
    }

    private boolean canSelectText() {
        return (!hasSelectionController() || this.mTextView.getText().length() == 0) ? DEBUG_UNDO : true;
    }

    private boolean hasPasswordTransformationMethod() {
        return this.mTextView.getTransformationMethod() instanceof PasswordTransformationMethod;
    }

    private boolean selectCurrentWord() {
        if (!canSelectText()) {
            return DEBUG_UNDO;
        }
        if (hasPasswordTransformationMethod()) {
            return this.mTextView.selectAllText();
        }
        int inputType = this.mTextView.getInputType();
        int klass = inputType & 15;
        int variation = inputType & InputType.TYPE_MASK_VARIATION;
        if (klass == 2 || klass == 3 || klass == 4 || variation == 16 || variation == 32 || variation == 208 || variation == 176) {
            return this.mTextView.selectAllText();
        }
        long lastTouchOffsets = getLastTouchOffsets();
        int minOffset = TextUtils.unpackRangeStartFromLong(lastTouchOffsets);
        int maxOffset = TextUtils.unpackRangeEndFromLong(lastTouchOffsets);
        if (minOffset >= 0) {
            if (minOffset < this.mTextView.getText().length()) {
                if (maxOffset >= 0) {
                    if (maxOffset < this.mTextView.getText().length()) {
                        int selectionStart;
                        int selectionEnd;
                        URLSpan[] urlSpans = (URLSpan[]) ((Spanned) this.mTextView.getText()).getSpans(minOffset, maxOffset, URLSpan.class);
                        int length = urlSpans.length;
                        if (r0 >= 1) {
                            URLSpan urlSpan = urlSpans[0];
                            selectionStart = ((Spanned) this.mTextView.getText()).getSpanStart(urlSpan);
                            selectionEnd = ((Spanned) this.mTextView.getText()).getSpanEnd(urlSpan);
                        } else {
                            WordIterator wordIterator = getWordIterator();
                            wordIterator.setCharSequence(this.mTextView.getText(), minOffset, maxOffset);
                            selectionStart = wordIterator.getBeginning(minOffset);
                            selectionEnd = wordIterator.getEnd(maxOffset);
                            if (selectionStart == EXTRACT_UNKNOWN || selectionEnd == EXTRACT_UNKNOWN || selectionStart == selectionEnd) {
                                long range = getCharRange(minOffset);
                                selectionStart = TextUtils.unpackRangeStartFromLong(range);
                                selectionEnd = TextUtils.unpackRangeEndFromLong(range);
                            }
                        }
                        Selection.setSelection((Spannable) this.mTextView.getText(), selectionStart, selectionEnd);
                        if (selectionEnd > selectionStart) {
                            return true;
                        }
                        return DEBUG_UNDO;
                    }
                }
                return DEBUG_UNDO;
            }
        }
        return DEBUG_UNDO;
    }

    void onLocaleChanged() {
        this.mWordIterator = null;
    }

    public WordIterator getWordIterator() {
        if (this.mWordIterator == null) {
            this.mWordIterator = new WordIterator(this.mTextView.getTextServicesLocale());
        }
        return this.mWordIterator;
    }

    private long getCharRange(int offset) {
        int textLength = this.mTextView.getText().length();
        if (offset + 1 < textLength && Character.isSurrogatePair(this.mTextView.getText().charAt(offset), this.mTextView.getText().charAt(offset + 1))) {
            return TextUtils.packRangeInLong(offset, offset + 2);
        }
        if (offset < textLength) {
            return TextUtils.packRangeInLong(offset, offset + 1);
        }
        if (offset + EXTRACT_NOTHING >= 0) {
            if (Character.isSurrogatePair(this.mTextView.getText().charAt(offset + EXTRACT_NOTHING), this.mTextView.getText().charAt(offset + EXTRACT_UNKNOWN))) {
                return TextUtils.packRangeInLong(offset + EXTRACT_NOTHING, offset);
            }
        }
        if (offset + EXTRACT_UNKNOWN >= 0) {
            return TextUtils.packRangeInLong(offset + EXTRACT_UNKNOWN, offset);
        }
        return TextUtils.packRangeInLong(offset, offset);
    }

    private boolean touchPositionIsInSelection() {
        int selectionStart = this.mTextView.getSelectionStart();
        int selectionEnd = this.mTextView.getSelectionEnd();
        if (selectionStart == selectionEnd) {
            return DEBUG_UNDO;
        }
        if (selectionStart > selectionEnd) {
            int tmp = selectionStart;
            selectionStart = selectionEnd;
            selectionEnd = tmp;
            Selection.setSelection((Spannable) this.mTextView.getText(), selectionStart, selectionEnd);
        }
        SelectionModifierCursorController selectionController = getSelectionController();
        boolean z = (selectionController.getMinTouchOffset() < selectionStart || selectionController.getMaxTouchOffset() >= selectionEnd) ? DEBUG_UNDO : true;
        return z;
    }

    private PositionListener getPositionListener() {
        if (this.mPositionListener == null) {
            this.mPositionListener = new PositionListener();
        }
        return this.mPositionListener;
    }

    private boolean isPositionVisible(float positionX, float positionY) {
        synchronized (TEMP_POSITION) {
            float[] position = TEMP_POSITION;
            position[0] = positionX;
            position[1] = positionY;
            View view = this.mTextView;
            while (view != null) {
                if (view != this.mTextView) {
                    position[0] = position[0] - ((float) view.getScrollX());
                    position[1] = position[1] - ((float) view.getScrollY());
                }
                if (position[0] < 0.0f || position[1] < 0.0f || position[0] > ((float) view.getWidth()) || position[1] > ((float) view.getHeight())) {
                    return DEBUG_UNDO;
                }
                if (!view.getMatrix().isIdentity()) {
                    view.getMatrix().mapPoints(position);
                }
                position[0] = position[0] + ((float) view.getLeft());
                position[1] = position[1] + ((float) view.getTop());
                ViewParent parent = view.getParent();
                if (parent instanceof View) {
                    view = (View) parent;
                } else {
                    view = null;
                }
            }
            return true;
        }
    }

    private boolean isOffsetVisible(int offset) {
        Layout layout = this.mTextView.getLayout();
        if (layout == null) {
            return DEBUG_UNDO;
        }
        return isPositionVisible((float) (this.mTextView.viewportToContentHorizontalOffset() + ((int) layout.getPrimaryHorizontal(offset))), (float) (this.mTextView.viewportToContentVerticalOffset() + layout.getLineBottom(layout.getLineForOffset(offset))));
    }

    private boolean isPositionOnText(float x, float y) {
        Layout layout = this.mTextView.getLayout();
        if (layout == null) {
            return DEBUG_UNDO;
        }
        int line = this.mTextView.getLineAtCoordinate(y);
        x = this.mTextView.convertToLocalHorizontalCoordinate(x);
        if (x < layout.getLineLeft(line) || x > layout.getLineRight(line)) {
            return DEBUG_UNDO;
        }
        return true;
    }

    public boolean performLongClick(boolean handled) {
        if (!(handled || isPositionOnText(this.mLastDownPositionX, this.mLastDownPositionY) || !this.mInsertionControllerEnabled)) {
            int offset = this.mTextView.getOffsetForPosition(this.mLastDownPositionX, this.mLastDownPositionY);
            stopSelectionActionMode();
            Selection.setSelection((Spannable) this.mTextView.getText(), offset);
            getInsertionController().showWithActionPopup();
            handled = true;
        }
        if (!(handled || this.mSelectionActionMode == null)) {
            if (touchPositionIsInSelection()) {
                int start = this.mTextView.getSelectionStart();
                int end = this.mTextView.getSelectionEnd();
                CharSequence selectedText = this.mTextView.getTransformedText(start, end);
                this.mTextView.startDrag(ClipData.newPlainText(null, selectedText), getTextThumbnailBuilder(selectedText), new DragLocalState(this.mTextView, start, end), 0);
                stopSelectionActionMode();
            } else {
                getSelectionController().hide();
                selectCurrentWord();
                getSelectionController().show();
            }
            handled = true;
        }
        if (handled) {
            return handled;
        }
        return startSelectionActionMode();
    }

    private long getLastTouchOffsets() {
        SelectionModifierCursorController selectionController = getSelectionController();
        return TextUtils.packRangeInLong(selectionController.getMinTouchOffset(), selectionController.getMaxTouchOffset());
    }

    void onFocusChanged(boolean focused, int direction) {
        this.mShowCursor = SystemClock.uptimeMillis();
        ensureEndedBatchEdit();
        int selStart;
        int selEnd;
        if (focused) {
            boolean z;
            selStart = this.mTextView.getSelectionStart();
            selEnd = this.mTextView.getSelectionEnd();
            boolean isFocusHighlighted;
            if (this.mSelectAllOnFocus && selStart == 0 && selEnd == this.mTextView.getText().length()) {
                isFocusHighlighted = true;
            } else {
                isFocusHighlighted = DEBUG_UNDO;
            }
            if (this.mFrozenWithFocus && this.mTextView.hasSelection() && !isFocusHighlighted) {
                z = true;
            } else {
                z = DEBUG_UNDO;
            }
            this.mCreatedWithASelection = z;
            if (!this.mFrozenWithFocus || selStart < 0 || selEnd < 0) {
                int lastTapPosition = getLastTapPosition();
                if (lastTapPosition >= 0) {
                    Selection.setSelection((Spannable) this.mTextView.getText(), lastTapPosition);
                }
                MovementMethod mMovement = this.mTextView.getMovementMethod();
                if (mMovement != null) {
                    mMovement.onTakeFocus(this.mTextView, (Spannable) this.mTextView.getText(), direction);
                }
                if (((this.mTextView instanceof ExtractEditText) || this.mSelectionMoved) && selStart >= 0 && selEnd >= 0) {
                    Selection.setSelection((Spannable) this.mTextView.getText(), selStart, selEnd);
                }
                if (this.mSelectAllOnFocus) {
                    this.mTextView.selectAllText();
                }
                this.mTouchFocusSelected = true;
            }
            this.mFrozenWithFocus = DEBUG_UNDO;
            this.mSelectionMoved = DEBUG_UNDO;
            if (this.mError != null) {
                showError();
            }
            makeBlink();
            return;
        }
        if (this.mError != null) {
            hideError();
        }
        this.mTextView.onEndBatchEdit();
        if (this.mTextView instanceof ExtractEditText) {
            selStart = this.mTextView.getSelectionStart();
            selEnd = this.mTextView.getSelectionEnd();
            hideControllers();
            Selection.setSelection((Spannable) this.mTextView.getText(), selStart, selEnd);
        } else {
            if (this.mTemporaryDetach) {
                this.mPreserveDetachedSelection = true;
            }
            hideControllers();
            if (this.mTemporaryDetach) {
                this.mPreserveDetachedSelection = DEBUG_UNDO;
            }
            downgradeEasyCorrectionSpans();
        }
        if (this.mSelectionModifierCursorController != null) {
            this.mSelectionModifierCursorController.resetTouchOffsets();
        }
    }

    private void downgradeEasyCorrectionSpans() {
        CharSequence text = this.mTextView.getText();
        if (text instanceof Spannable) {
            Spannable spannable = (Spannable) text;
            SuggestionSpan[] suggestionSpans = (SuggestionSpan[]) spannable.getSpans(0, spannable.length(), SuggestionSpan.class);
            for (int i = 0; i < suggestionSpans.length; i++) {
                int flags = suggestionSpans[i].getFlags();
                if ((flags & 1) != 0 && (flags & 2) == 0) {
                    suggestionSpans[i].setFlags(flags & EXTRACT_NOTHING);
                }
            }
        }
    }

    void sendOnTextChanged(int start, int after) {
        updateSpellCheckSpans(start, start + after, DEBUG_UNDO);
        hideCursorControllers();
    }

    private int getLastTapPosition() {
        if (this.mSelectionModifierCursorController != null) {
            int lastTapPosition = this.mSelectionModifierCursorController.getMinTouchOffset();
            if (lastTapPosition >= 0) {
                if (lastTapPosition > this.mTextView.getText().length()) {
                    return this.mTextView.getText().length();
                }
                return lastTapPosition;
            }
        }
        return EXTRACT_UNKNOWN;
    }

    void onWindowFocusChanged(boolean hasWindowFocus) {
        if (!hasWindowFocus) {
            if (this.mBlink != null) {
                this.mBlink.cancel();
            }
            if (this.mInputContentType != null) {
                this.mInputContentType.enterDown = DEBUG_UNDO;
            }
            hideControllers();
            if (this.mSuggestionsPopupWindow != null) {
                this.mSuggestionsPopupWindow.onParentLostFocus();
            }
            ensureEndedBatchEdit();
        } else if (this.mBlink != null) {
            this.mBlink.uncancel();
            makeBlink();
        }
    }

    void onTouchEvent(MotionEvent event) {
        if (hasSelectionController()) {
            getSelectionController().onTouchEvent(event);
        }
        if (this.mShowSuggestionRunnable != null) {
            this.mTextView.removeCallbacks(this.mShowSuggestionRunnable);
            this.mShowSuggestionRunnable = null;
        }
        if (event.getActionMasked() == 0) {
            this.mLastDownPositionX = event.getX();
            this.mLastDownPositionY = event.getY();
            this.mTouchFocusSelected = DEBUG_UNDO;
            this.mIgnoreActionUpEvent = DEBUG_UNDO;
        }
    }

    public void beginBatchEdit() {
        this.mInBatchEditControllers = true;
        InputMethodState ims = this.mInputMethodState;
        if (ims != null) {
            int nesting = ims.mBatchEditNesting + 1;
            ims.mBatchEditNesting = nesting;
            if (nesting == 1) {
                ims.mCursorChanged = DEBUG_UNDO;
                ims.mChangedDelta = 0;
                if (ims.mContentChanged) {
                    ims.mChangedStart = 0;
                    ims.mChangedEnd = this.mTextView.getText().length();
                } else {
                    ims.mChangedStart = EXTRACT_UNKNOWN;
                    ims.mChangedEnd = EXTRACT_UNKNOWN;
                    ims.mContentChanged = DEBUG_UNDO;
                }
                this.mTextView.onBeginBatchEdit();
            }
        }
    }

    public void endBatchEdit() {
        this.mInBatchEditControllers = DEBUG_UNDO;
        InputMethodState ims = this.mInputMethodState;
        if (ims != null) {
            int nesting = ims.mBatchEditNesting + EXTRACT_UNKNOWN;
            ims.mBatchEditNesting = nesting;
            if (nesting == 0) {
                finishBatchEdit(ims);
            }
        }
    }

    void ensureEndedBatchEdit() {
        InputMethodState ims = this.mInputMethodState;
        if (ims != null && ims.mBatchEditNesting != 0) {
            ims.mBatchEditNesting = 0;
            finishBatchEdit(ims);
        }
    }

    void finishBatchEdit(InputMethodState ims) {
        this.mTextView.onEndBatchEdit();
        if (ims.mContentChanged || ims.mSelectionModeChanged) {
            this.mTextView.updateAfterEdit();
            reportExtractedText();
        } else if (ims.mCursorChanged) {
            this.mTextView.invalidateCursor();
        }
        sendUpdateSelection();
    }

    boolean extractText(ExtractedTextRequest request, ExtractedText outText) {
        return extractTextInternal(request, EXTRACT_UNKNOWN, EXTRACT_UNKNOWN, EXTRACT_UNKNOWN, outText);
    }

    private boolean extractTextInternal(ExtractedTextRequest request, int partialStartOffset, int partialEndOffset, int delta, ExtractedText outText) {
        CharSequence content = this.mTextView.getText();
        if (content == null) {
            return DEBUG_UNDO;
        }
        if (partialStartOffset != EXTRACT_NOTHING) {
            int N = content.length();
            if (partialStartOffset < 0) {
                outText.partialEndOffset = EXTRACT_UNKNOWN;
                outText.partialStartOffset = EXTRACT_UNKNOWN;
                partialStartOffset = 0;
                partialEndOffset = N;
            } else {
                partialEndOffset += delta;
                if (content instanceof Spanned) {
                    Spanned spanned = (Spanned) content;
                    Object[] spans = spanned.getSpans(partialStartOffset, partialEndOffset, ParcelableSpan.class);
                    int i = spans.length;
                    while (i > 0) {
                        i += EXTRACT_UNKNOWN;
                        int j = spanned.getSpanStart(spans[i]);
                        if (j < partialStartOffset) {
                            partialStartOffset = j;
                        }
                        j = spanned.getSpanEnd(spans[i]);
                        if (j > partialEndOffset) {
                            partialEndOffset = j;
                        }
                    }
                }
                outText.partialStartOffset = partialStartOffset;
                outText.partialEndOffset = partialEndOffset - delta;
                if (partialStartOffset > N) {
                    partialStartOffset = N;
                } else if (partialStartOffset < 0) {
                    partialStartOffset = 0;
                }
                if (partialEndOffset > N) {
                    partialEndOffset = N;
                } else if (partialEndOffset < 0) {
                    partialEndOffset = 0;
                }
            }
            if ((request.flags & 1) != 0) {
                outText.text = content.subSequence(partialStartOffset, partialEndOffset);
            } else {
                outText.text = TextUtils.substring(content, partialStartOffset, partialEndOffset);
            }
        } else {
            outText.partialStartOffset = 0;
            outText.partialEndOffset = 0;
            outText.text = ProxyInfo.LOCAL_EXCL_LIST;
        }
        outText.flags = 0;
        if (MetaKeyKeyListener.getMetaState(content, (int) AccessibilityNodeInfo.ACTION_PREVIOUS_HTML_ELEMENT) != 0) {
            outText.flags |= 2;
        }
        if (this.mTextView.isSingleLine()) {
            outText.flags |= 1;
        }
        outText.startOffset = 0;
        outText.selectionStart = this.mTextView.getSelectionStart();
        outText.selectionEnd = this.mTextView.getSelectionEnd();
        return true;
    }

    boolean reportExtractedText() {
        InputMethodState ims = this.mInputMethodState;
        if (ims != null) {
            boolean contentChanged = ims.mContentChanged;
            if (contentChanged || ims.mSelectionModeChanged) {
                ims.mContentChanged = DEBUG_UNDO;
                ims.mSelectionModeChanged = DEBUG_UNDO;
                ExtractedTextRequest req = ims.mExtractedTextRequest;
                if (req != null) {
                    InputMethodManager imm = InputMethodManager.peekInstance();
                    if (imm != null) {
                        if (ims.mChangedStart < 0 && !contentChanged) {
                            ims.mChangedStart = EXTRACT_NOTHING;
                        }
                        if (extractTextInternal(req, ims.mChangedStart, ims.mChangedEnd, ims.mChangedDelta, ims.mExtractedText)) {
                            imm.updateExtractedText(this.mTextView, req.token, ims.mExtractedText);
                            ims.mChangedStart = EXTRACT_UNKNOWN;
                            ims.mChangedEnd = EXTRACT_UNKNOWN;
                            ims.mChangedDelta = 0;
                            ims.mContentChanged = DEBUG_UNDO;
                            return true;
                        }
                    }
                }
            }
        }
        return DEBUG_UNDO;
    }

    private void sendUpdateSelection() {
        if (this.mInputMethodState != null && this.mInputMethodState.mBatchEditNesting <= 0) {
            InputMethodManager imm = InputMethodManager.peekInstance();
            if (imm != null) {
                int selectionStart = this.mTextView.getSelectionStart();
                int selectionEnd = this.mTextView.getSelectionEnd();
                int candStart = EXTRACT_UNKNOWN;
                int candEnd = EXTRACT_UNKNOWN;
                if (this.mTextView.getText() instanceof Spannable) {
                    Spannable sp = (Spannable) this.mTextView.getText();
                    candStart = EditableInputConnection.getComposingSpanStart(sp);
                    candEnd = EditableInputConnection.getComposingSpanEnd(sp);
                }
                imm.updateSelection(this.mTextView, selectionStart, selectionEnd, candStart, candEnd);
            }
        }
    }

    void onDraw(Canvas canvas, Layout layout, Path highlight, Paint highlightPaint, int cursorOffsetVertical) {
        int selectionStart = this.mTextView.getSelectionStart();
        int selectionEnd = this.mTextView.getSelectionEnd();
        InputMethodState ims = this.mInputMethodState;
        if (ims != null && ims.mBatchEditNesting == 0) {
            InputMethodManager imm = InputMethodManager.peekInstance();
            if (imm != null && imm.isActive(this.mTextView) && (ims.mContentChanged || ims.mSelectionModeChanged)) {
                reportExtractedText();
            }
        }
        if (this.mCorrectionHighlighter != null) {
            this.mCorrectionHighlighter.draw(canvas, cursorOffsetVertical);
        }
        if (highlight != null && selectionStart == selectionEnd && this.mCursorCount > 0) {
            drawCursor(canvas, cursorOffsetVertical);
            highlight = null;
        }
        if (this.mTextView.canHaveDisplayList() && canvas.isHardwareAccelerated()) {
            drawHardwareAccelerated(canvas, layout, highlight, highlightPaint, cursorOffsetVertical);
        } else {
            layout.draw(canvas, highlight, highlightPaint, cursorOffsetVertical);
        }
    }

    private void drawHardwareAccelerated(Canvas canvas, Layout layout, Path highlight, Paint highlightPaint, int cursorOffsetVertical) {
        long lineRange = layout.getLineRangeForDraw(canvas);
        int firstLine = TextUtils.unpackRangeStartFromLong(lineRange);
        int lastLine = TextUtils.unpackRangeEndFromLong(lineRange);
        if (lastLine >= 0) {
            layout.drawBackground(canvas, highlight, highlightPaint, cursorOffsetVertical, firstLine, lastLine);
            if (layout instanceof DynamicLayout) {
                if (this.mTextDisplayLists == null) {
                    this.mTextDisplayLists = (TextDisplayList[]) ArrayUtils.emptyArray(TextDisplayList.class);
                }
                DynamicLayout dynamicLayout = (DynamicLayout) layout;
                int[] blockEndLines = dynamicLayout.getBlockEndLines();
                int[] blockIndices = dynamicLayout.getBlockIndices();
                int numberOfBlocks = dynamicLayout.getNumberOfBlocks();
                int indexFirstChangedBlock = dynamicLayout.getIndexFirstChangedBlock();
                int endOfPreviousBlock = EXTRACT_UNKNOWN;
                int searchStartIndex = 0;
                for (int i = 0; i < numberOfBlocks; i++) {
                    int blockEndLine = blockEndLines[i];
                    int blockIndex = blockIndices[i];
                    if (blockIndex == EXTRACT_UNKNOWN ? true : DEBUG_UNDO) {
                        blockIndex = getAvailableDisplayListIndex(blockIndices, numberOfBlocks, searchStartIndex);
                        blockIndices[i] = blockIndex;
                        searchStartIndex = blockIndex + 1;
                    }
                    if (this.mTextDisplayLists[blockIndex] == null) {
                        this.mTextDisplayLists[blockIndex] = new TextDisplayList("Text " + blockIndex);
                    }
                    boolean blockDisplayListIsInvalid = this.mTextDisplayLists[blockIndex].needsRecord();
                    RenderNode blockDisplayList = this.mTextDisplayLists[blockIndex].displayList;
                    if (i >= indexFirstChangedBlock || blockDisplayListIsInvalid) {
                        int blockBeginLine = endOfPreviousBlock + 1;
                        int top = layout.getLineTop(blockBeginLine);
                        int bottom = layout.getLineBottom(blockEndLine);
                        int left = 0;
                        int right = this.mTextView.getWidth();
                        if (this.mTextView.getHorizontallyScrolling()) {
                            float min = Float.MAX_VALUE;
                            float max = Float.MIN_VALUE;
                            for (int line = blockBeginLine; line <= blockEndLine; line++) {
                                min = Math.min(min, layout.getLineLeft(line));
                                max = Math.max(max, layout.getLineRight(line));
                            }
                            left = (int) min;
                            right = (int) (0.5f + max);
                        }
                        if (blockDisplayListIsInvalid) {
                            Canvas hardwareCanvas = blockDisplayList.start(right - left, bottom - top);
                            try {
                                hardwareCanvas.translate((float) (-left), (float) (-top));
                                layout.drawText(hardwareCanvas, blockBeginLine, blockEndLine);
                            } finally {
                                blockDisplayList.end(hardwareCanvas);
                                blockDisplayList.setClipToBounds(DEBUG_UNDO);
                            }
                        }
                        blockDisplayList.setLeftTopRightBottom(left, top, right, bottom);
                    }
                    ((HardwareCanvas) canvas).drawRenderNode(blockDisplayList, null, 0);
                    endOfPreviousBlock = blockEndLine;
                }
                dynamicLayout.setIndexFirstChangedBlock(numberOfBlocks);
                return;
            }
            layout.drawText(canvas, firstLine, lastLine);
        }
    }

    private int getAvailableDisplayListIndex(int[] blockIndices, int numberOfBlocks, int searchStartIndex) {
        int length = this.mTextDisplayLists.length;
        for (int i = searchStartIndex; i < length; i++) {
            boolean blockIndexFound = DEBUG_UNDO;
            for (int j = 0; j < numberOfBlocks; j++) {
                if (blockIndices[j] == i) {
                    blockIndexFound = true;
                    break;
                }
            }
            if (!blockIndexFound) {
                return i;
            }
        }
        this.mTextDisplayLists = (TextDisplayList[]) GrowingArrayUtils.append(this.mTextDisplayLists, length, null);
        return length;
    }

    private void drawCursor(Canvas canvas, int cursorOffsetVertical) {
        boolean translate = cursorOffsetVertical != 0 ? true : DEBUG_UNDO;
        if (translate) {
            canvas.translate(0.0f, (float) cursorOffsetVertical);
        }
        for (int i = 0; i < this.mCursorCount; i++) {
            this.mCursorDrawable[i].draw(canvas);
        }
        if (translate) {
            canvas.translate(0.0f, (float) (-cursorOffsetVertical));
        }
    }

    void invalidateTextDisplayList(Layout layout, int start, int end) {
        if (this.mTextDisplayLists != null && (layout instanceof DynamicLayout)) {
            int firstLine = layout.getLineForOffset(start);
            int lastLine = layout.getLineForOffset(end);
            DynamicLayout dynamicLayout = (DynamicLayout) layout;
            int[] blockEndLines = dynamicLayout.getBlockEndLines();
            int[] blockIndices = dynamicLayout.getBlockIndices();
            int numberOfBlocks = dynamicLayout.getNumberOfBlocks();
            int i = 0;
            while (i < numberOfBlocks && blockEndLines[i] < firstLine) {
                i++;
            }
            while (i < numberOfBlocks) {
                int blockIndex = blockIndices[i];
                if (blockIndex != EXTRACT_UNKNOWN) {
                    this.mTextDisplayLists[blockIndex].isDirty = true;
                }
                if (blockEndLines[i] < lastLine) {
                    i++;
                } else {
                    return;
                }
            }
        }
    }

    void invalidateTextDisplayList() {
        if (this.mTextDisplayLists != null) {
            for (int i = 0; i < this.mTextDisplayLists.length; i++) {
                if (this.mTextDisplayLists[i] != null) {
                    this.mTextDisplayLists[i].isDirty = true;
                }
            }
        }
    }

    void updateCursorsPositions() {
        if (this.mTextView.mCursorDrawableRes == 0) {
            this.mCursorCount = 0;
            return;
        }
        int i;
        Layout layout = this.mTextView.getLayout();
        Layout hintLayout = this.mTextView.getHintLayout();
        int offset = this.mTextView.getSelectionStart();
        int line = layout.getLineForOffset(offset);
        int top = layout.getLineTop(line);
        int bottom = layout.getLineTop(line + 1);
        if (layout.isLevelBoundary(offset)) {
            i = 2;
        } else {
            i = 1;
        }
        this.mCursorCount = i;
        int middle = bottom;
        if (this.mCursorCount == 2) {
            middle = (top + bottom) >> 1;
        }
        boolean clamped = layout.shouldClampCursor(line);
        updateCursorPosition(0, top, middle, getPrimaryHorizontal(layout, hintLayout, offset, clamped));
        if (this.mCursorCount == 2) {
            updateCursorPosition(1, middle, bottom, layout.getSecondaryHorizontal(offset, clamped));
        }
    }

    private float getPrimaryHorizontal(Layout layout, Layout hintLayout, int offset, boolean clamped) {
        if (!TextUtils.isEmpty(layout.getText()) || hintLayout == null || TextUtils.isEmpty(hintLayout.getText())) {
            return layout.getPrimaryHorizontal(offset, clamped);
        }
        return hintLayout.getPrimaryHorizontal(offset, clamped);
    }

    boolean startSelectionActionMode() {
        if (this.mSelectionActionMode != null) {
            return DEBUG_UNDO;
        }
        if (!canSelectText() || !this.mTextView.requestFocus()) {
            Log.w("TextView", "TextView does not support text selection. Action mode cancelled.");
            return DEBUG_UNDO;
        } else if (!this.mTextView.hasSelection() && !selectCurrentWord()) {
            return DEBUG_UNDO;
        } else {
            boolean selectionStarted;
            boolean willExtract = extractedTextModeWillBeStarted();
            if (!willExtract) {
                this.mSelectionActionMode = this.mTextView.startActionMode(new SelectionActionModeCallback());
            }
            if (this.mSelectionActionMode != null || willExtract) {
                selectionStarted = true;
            } else {
                selectionStarted = DEBUG_UNDO;
            }
            if (!selectionStarted || this.mTextView.isTextSelectable() || !this.mShowSoftInputOnFocus) {
                return selectionStarted;
            }
            InputMethodManager imm = InputMethodManager.peekInstance();
            if (imm == null) {
                return selectionStarted;
            }
            imm.showSoftInput(this.mTextView, 0, null);
            return selectionStarted;
        }
    }

    private boolean extractedTextModeWillBeStarted() {
        if (this.mTextView instanceof ExtractEditText) {
            return DEBUG_UNDO;
        }
        InputMethodManager imm = InputMethodManager.peekInstance();
        if (imm == null || !imm.isFullscreenMode()) {
            return DEBUG_UNDO;
        }
        return true;
    }

    private boolean isCursorInsideSuggestionSpan() {
        CharSequence text = this.mTextView.getText();
        if ((text instanceof Spannable) && ((SuggestionSpan[]) ((Spannable) text).getSpans(this.mTextView.getSelectionStart(), this.mTextView.getSelectionEnd(), SuggestionSpan.class)).length > 0) {
            return true;
        }
        return DEBUG_UNDO;
    }

    private boolean isCursorInsideEasyCorrectionSpan() {
        SuggestionSpan[] suggestionSpans = (SuggestionSpan[]) ((Spannable) this.mTextView.getText()).getSpans(this.mTextView.getSelectionStart(), this.mTextView.getSelectionEnd(), SuggestionSpan.class);
        for (SuggestionSpan flags : suggestionSpans) {
            if ((flags.getFlags() & 1) != 0) {
                return true;
            }
        }
        return DEBUG_UNDO;
    }

    void onTouchUpEvent(MotionEvent event) {
        boolean selectAllGotFocus = (this.mSelectAllOnFocus && this.mTextView.didTouchFocusSelect()) ? true : DEBUG_UNDO;
        hideControllers();
        CharSequence text = this.mTextView.getText();
        if (!selectAllGotFocus && text.length() > 0) {
            Selection.setSelection((Spannable) text, this.mTextView.getOffsetForPosition(event.getX(), event.getY()));
            if (this.mSpellChecker != null) {
                this.mSpellChecker.onSelectionChanged();
            }
            if (!extractedTextModeWillBeStarted()) {
                if (isCursorInsideEasyCorrectionSpan()) {
                    this.mShowSuggestionRunnable = new C09671();
                    this.mTextView.postDelayed(this.mShowSuggestionRunnable, (long) ViewConfiguration.getDoubleTapTimeout());
                } else if (hasInsertionController()) {
                    getInsertionController().show();
                }
            }
        }
    }

    protected void stopSelectionActionMode() {
        if (this.mSelectionActionMode != null) {
            this.mSelectionActionMode.finish();
        }
    }

    boolean hasInsertionController() {
        return this.mInsertionControllerEnabled;
    }

    boolean hasSelectionController() {
        return this.mSelectionControllerEnabled;
    }

    InsertionPointCursorController getInsertionController() {
        if (!this.mInsertionControllerEnabled) {
            return null;
        }
        if (this.mInsertionPointCursorController == null) {
            this.mInsertionPointCursorController = new InsertionPointCursorController();
            this.mTextView.getViewTreeObserver().addOnTouchModeChangeListener(this.mInsertionPointCursorController);
        }
        return this.mInsertionPointCursorController;
    }

    SelectionModifierCursorController getSelectionController() {
        if (!this.mSelectionControllerEnabled) {
            return null;
        }
        if (this.mSelectionModifierCursorController == null) {
            this.mSelectionModifierCursorController = new SelectionModifierCursorController();
            this.mTextView.getViewTreeObserver().addOnTouchModeChangeListener(this.mSelectionModifierCursorController);
        }
        return this.mSelectionModifierCursorController;
    }

    private void updateCursorPosition(int cursorIndex, int top, int bottom, float horizontal) {
        if (this.mCursorDrawable[cursorIndex] == null) {
            this.mCursorDrawable[cursorIndex] = this.mTextView.getContext().getDrawable(this.mTextView.mCursorDrawableRes);
        }
        if (this.mTempRect == null) {
            this.mTempRect = new Rect();
        }
        this.mCursorDrawable[cursorIndex].getPadding(this.mTempRect);
        int left = ((int) Math.max(0.5f, horizontal - 0.5f)) - this.mTempRect.left;
        this.mCursorDrawable[cursorIndex].setBounds(left, top - this.mTempRect.top, left + this.mCursorDrawable[cursorIndex].getIntrinsicWidth(), this.mTempRect.bottom + bottom);
    }

    public void onCommitCorrection(CorrectionInfo info) {
        if (this.mCorrectionHighlighter == null) {
            this.mCorrectionHighlighter = new CorrectionHighlighter();
        } else {
            this.mCorrectionHighlighter.invalidate(DEBUG_UNDO);
        }
        this.mCorrectionHighlighter.highlight(info);
    }

    void showSuggestions() {
        if (this.mSuggestionsPopupWindow == null) {
            this.mSuggestionsPopupWindow = new SuggestionsPopupWindow();
        }
        hideControllers();
        this.mSuggestionsPopupWindow.show();
    }

    boolean areSuggestionsShown() {
        return (this.mSuggestionsPopupWindow == null || !this.mSuggestionsPopupWindow.isShowing()) ? DEBUG_UNDO : true;
    }

    void onScrollChanged() {
        if (this.mPositionListener != null) {
            this.mPositionListener.onScrollChanged();
        }
    }

    private boolean shouldBlink() {
        if (!isCursorVisible() || !this.mTextView.isFocused()) {
            return DEBUG_UNDO;
        }
        int start = this.mTextView.getSelectionStart();
        if (start < 0) {
            return DEBUG_UNDO;
        }
        int end = this.mTextView.getSelectionEnd();
        if (end < 0 || start != end) {
            return DEBUG_UNDO;
        }
        return true;
    }

    void makeBlink() {
        if (shouldBlink()) {
            this.mShowCursor = SystemClock.uptimeMillis();
            if (this.mBlink == null) {
                this.mBlink = new Blink();
            }
            this.mBlink.removeCallbacks(this.mBlink);
            this.mBlink.postAtTime(this.mBlink, this.mShowCursor + 500);
        } else if (this.mBlink != null) {
            this.mBlink.removeCallbacks(this.mBlink);
        }
    }

    private DragShadowBuilder getTextThumbnailBuilder(CharSequence text) {
        TextView shadowView = (TextView) View.inflate(this.mTextView.getContext(), 17367255, null);
        if (shadowView == null) {
            throw new IllegalArgumentException("Unable to inflate text drag thumbnail");
        }
        if (text.length() > DRAG_SHADOW_MAX_TEXT_LENGTH) {
            text = text.subSequence(0, DRAG_SHADOW_MAX_TEXT_LENGTH);
        }
        shadowView.setText(text);
        shadowView.setTextColor(this.mTextView.getTextColors());
        shadowView.setTextAppearance(this.mTextView.getContext(), 16);
        shadowView.setGravity(17);
        shadowView.setLayoutParams(new ViewGroup.LayoutParams((int) EXTRACT_NOTHING, (int) EXTRACT_NOTHING));
        int size = MeasureSpec.makeMeasureSpec(0, 0);
        shadowView.measure(size, size);
        shadowView.layout(0, 0, shadowView.getMeasuredWidth(), shadowView.getMeasuredHeight());
        shadowView.invalidate();
        return new DragShadowBuilder(shadowView);
    }

    void onDrop(DragEvent event) {
        StringBuilder content = new StringBuilder(ProxyInfo.LOCAL_EXCL_LIST);
        ClipData clipData = event.getClipData();
        int itemCount = clipData.getItemCount();
        for (int i = 0; i < itemCount; i++) {
            content.append(clipData.getItemAt(i).coerceToStyledText(this.mTextView.getContext()));
        }
        int offset = this.mTextView.getOffsetForPosition(event.getX(), event.getY());
        DragLocalState localState = event.getLocalState();
        DragLocalState dragLocalState = null;
        if (localState instanceof DragLocalState) {
            dragLocalState = localState;
        }
        boolean dragDropIntoItself = (dragLocalState == null || dragLocalState.sourceTextView != this.mTextView) ? DEBUG_UNDO : true;
        if (!dragDropIntoItself || offset < dragLocalState.start || offset >= dragLocalState.end) {
            int originalLength = this.mTextView.getText().length();
            int min = offset;
            int max = offset;
            Selection.setSelection((Spannable) this.mTextView.getText(), max);
            this.mTextView.replaceText_internal(min, max, content);
            if (dragDropIntoItself) {
                int dragSourceStart = dragLocalState.start;
                int dragSourceEnd = dragLocalState.end;
                if (max <= dragSourceStart) {
                    int shift = this.mTextView.getText().length() - originalLength;
                    dragSourceStart += shift;
                    dragSourceEnd += shift;
                }
                this.mTextView.deleteText_internal(dragSourceStart, dragSourceEnd);
                int prevCharIdx = Math.max(0, dragSourceStart + EXTRACT_UNKNOWN);
                int nextCharIdx = Math.min(this.mTextView.getText().length(), dragSourceStart + 1);
                if (nextCharIdx > prevCharIdx + 1) {
                    CharSequence t = this.mTextView.getTransformedText(prevCharIdx, nextCharIdx);
                    if (Character.isSpaceChar(t.charAt(0)) && Character.isSpaceChar(t.charAt(1))) {
                        this.mTextView.deleteText_internal(prevCharIdx, prevCharIdx + 1);
                    }
                }
            }
        }
    }

    public void addSpanWatchers(Spannable text) {
        int textLength = text.length();
        if (this.mKeyListener != null) {
            text.setSpan(this.mKeyListener, 0, textLength, 18);
        }
        if (this.mSpanController == null) {
            this.mSpanController = new SpanController();
        }
        text.setSpan(this.mSpanController, 0, textLength, 18);
    }
}
