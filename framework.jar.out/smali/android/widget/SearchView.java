package android.widget;

import android.app.PendingIntent;
import android.app.SearchableInfo;
import android.app.SearchableInfo.ActionKeyInfo;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.database.Cursor;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.Drawable.ConstantState;
import android.net.ProxyInfo;
import android.net.Uri;
import android.os.Bundle;
import android.os.Parcelable;
import android.speech.RecognizerIntent;
import android.text.Editable;
import android.text.SpannableStringBuilder;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.text.style.ImageSpan;
import android.util.AttributeSet;
import android.util.Log;
import android.view.CollapsibleActionView;
import android.view.KeyEvent;
import android.view.KeyEvent.DispatcherState;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.MeasureSpec;
import android.view.View.OnClickListener;
import android.view.View.OnFocusChangeListener;
import android.view.View.OnKeyListener;
import android.view.View.OnLayoutChangeListener;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.TextView.OnEditorActionListener;
import com.android.internal.R;
import java.util.WeakHashMap;

public class SearchView extends LinearLayout implements CollapsibleActionView {
    private static final boolean DBG = false;
    private static final String IME_OPTION_NO_MICROPHONE = "nm";
    private static final String LOG_TAG = "SearchView";
    private Bundle mAppSearchData;
    private boolean mClearingFocus;
    private final ImageView mCloseButton;
    private final ImageView mCollapsedIcon;
    private int mCollapsedImeOptions;
    private final View mDropDownAnchor;
    private boolean mExpandedInActionView;
    private final ImageView mGoButton;
    private boolean mIconified;
    private boolean mIconifiedByDefault;
    private int mMaxWidth;
    private CharSequence mOldQueryText;
    private final OnClickListener mOnClickListener;
    private OnCloseListener mOnCloseListener;
    private final OnEditorActionListener mOnEditorActionListener;
    private final OnItemClickListener mOnItemClickListener;
    private final OnItemSelectedListener mOnItemSelectedListener;
    private OnQueryTextListener mOnQueryChangeListener;
    private OnFocusChangeListener mOnQueryTextFocusChangeListener;
    private OnClickListener mOnSearchClickListener;
    private OnSuggestionListener mOnSuggestionListener;
    private final WeakHashMap<String, ConstantState> mOutsideDrawablesCache;
    private CharSequence mQueryHint;
    private boolean mQueryRefinement;
    private Runnable mReleaseCursorRunnable;
    private final ImageView mSearchButton;
    private final View mSearchEditFrame;
    private final Drawable mSearchHintIcon;
    private final View mSearchPlate;
    private final SearchAutoComplete mSearchSrcTextView;
    private SearchableInfo mSearchable;
    private Runnable mShowImeRunnable;
    private final View mSubmitArea;
    private boolean mSubmitButtonEnabled;
    private final int mSuggestionCommitIconResId;
    private final int mSuggestionRowLayout;
    private CursorAdapter mSuggestionsAdapter;
    OnKeyListener mTextKeyListener;
    private TextWatcher mTextWatcher;
    private Runnable mUpdateDrawableStateRunnable;
    private CharSequence mUserQuery;
    private final Intent mVoiceAppSearchIntent;
    private final ImageView mVoiceButton;
    private boolean mVoiceButtonEnabled;
    private final Intent mVoiceWebSearchIntent;

    /* renamed from: android.widget.SearchView.1 */
    class C10361 implements Runnable {
        C10361() {
        }

        public void run() {
            InputMethodManager imm = (InputMethodManager) SearchView.this.getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
            if (imm != null) {
                imm.showSoftInputUnchecked(0, null);
            }
        }
    }

    /* renamed from: android.widget.SearchView.2 */
    class C10372 implements Runnable {
        C10372() {
        }

        public void run() {
            SearchView.this.updateFocusedState();
        }
    }

    /* renamed from: android.widget.SearchView.3 */
    class C10383 implements Runnable {
        C10383() {
        }

        public void run() {
            if (SearchView.this.mSuggestionsAdapter != null && (SearchView.this.mSuggestionsAdapter instanceof SuggestionsAdapter)) {
                SearchView.this.mSuggestionsAdapter.changeCursor(null);
            }
        }
    }

    /* renamed from: android.widget.SearchView.4 */
    class C10394 implements OnFocusChangeListener {
        C10394() {
        }

        public void onFocusChange(View v, boolean hasFocus) {
            if (SearchView.this.mOnQueryTextFocusChangeListener != null) {
                SearchView.this.mOnQueryTextFocusChangeListener.onFocusChange(SearchView.this, hasFocus);
            }
        }
    }

    /* renamed from: android.widget.SearchView.5 */
    class C10405 implements OnLayoutChangeListener {
        C10405() {
        }

        public void onLayoutChange(View v, int left, int top, int right, int bottom, int oldLeft, int oldTop, int oldRight, int oldBottom) {
            SearchView.this.adjustDropDownSizeAndPosition();
        }
    }

    /* renamed from: android.widget.SearchView.6 */
    class C10416 implements OnClickListener {
        C10416() {
        }

        public void onClick(View v) {
            if (v == SearchView.this.mSearchButton) {
                SearchView.this.onSearchClicked();
            } else if (v == SearchView.this.mCloseButton) {
                SearchView.this.onCloseClicked();
            } else if (v == SearchView.this.mGoButton) {
                SearchView.this.onSubmitQuery();
            } else if (v == SearchView.this.mVoiceButton) {
                SearchView.this.onVoiceClicked();
            } else if (v == SearchView.this.mSearchSrcTextView) {
                SearchView.this.forceSuggestionQuery();
            }
        }
    }

    /* renamed from: android.widget.SearchView.7 */
    class C10427 implements OnKeyListener {
        C10427() {
        }

        public boolean onKey(View v, int keyCode, KeyEvent event) {
            if (SearchView.this.mSearchable == null) {
                return SearchView.DBG;
            }
            if (SearchView.this.mSearchSrcTextView.isPopupShowing() && SearchView.this.mSearchSrcTextView.getListSelection() != -1) {
                return SearchView.this.onSuggestionsKey(v, keyCode, event);
            }
            if (SearchView.this.mSearchSrcTextView.isEmpty() || !event.hasNoModifiers()) {
                return SearchView.DBG;
            }
            if (event.getAction() == 1 && keyCode == 66) {
                v.cancelLongPress();
                SearchView.this.launchQuerySearch(0, null, SearchView.this.mSearchSrcTextView.getText().toString());
                return true;
            } else if (event.getAction() != 0) {
                return SearchView.DBG;
            } else {
                ActionKeyInfo actionKey = SearchView.this.mSearchable.findActionKey(keyCode);
                if (actionKey == null || actionKey.getQueryActionMsg() == null) {
                    return SearchView.DBG;
                }
                SearchView.this.launchQuerySearch(keyCode, actionKey.getQueryActionMsg(), SearchView.this.mSearchSrcTextView.getText().toString());
                return true;
            }
        }
    }

    /* renamed from: android.widget.SearchView.8 */
    class C10438 implements OnEditorActionListener {
        C10438() {
        }

        public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
            SearchView.this.onSubmitQuery();
            return true;
        }
    }

    /* renamed from: android.widget.SearchView.9 */
    class C10449 implements OnItemClickListener {
        C10449() {
        }

        public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
            SearchView.this.onItemClicked(position, 0, null);
        }
    }

    public interface OnCloseListener {
        boolean onClose();
    }

    public interface OnQueryTextListener {
        boolean onQueryTextChange(String str);

        boolean onQueryTextSubmit(String str);
    }

    public interface OnSuggestionListener {
        boolean onSuggestionClick(int i);

        boolean onSuggestionSelect(int i);
    }

    public static class SearchAutoComplete extends AutoCompleteTextView {
        private SearchView mSearchView;
        private int mThreshold;

        public SearchAutoComplete(Context context) {
            super(context);
            this.mThreshold = getThreshold();
        }

        public SearchAutoComplete(Context context, AttributeSet attrs) {
            super(context, attrs);
            this.mThreshold = getThreshold();
        }

        public SearchAutoComplete(Context context, AttributeSet attrs, int defStyleAttrs) {
            super(context, attrs, defStyleAttrs);
            this.mThreshold = getThreshold();
        }

        public SearchAutoComplete(Context context, AttributeSet attrs, int defStyleAttrs, int defStyleRes) {
            super(context, attrs, defStyleAttrs, defStyleRes);
            this.mThreshold = getThreshold();
        }

        void setSearchView(SearchView searchView) {
            this.mSearchView = searchView;
        }

        public void setThreshold(int threshold) {
            super.setThreshold(threshold);
            this.mThreshold = threshold;
        }

        private boolean isEmpty() {
            return TextUtils.getTrimmedLength(getText()) == 0 ? true : SearchView.DBG;
        }

        protected void replaceText(CharSequence text) {
        }

        public void performCompletion() {
        }

        public void onWindowFocusChanged(boolean hasWindowFocus) {
            super.onWindowFocusChanged(hasWindowFocus);
            if (hasWindowFocus && this.mSearchView.hasFocus() && getVisibility() == 0) {
                ((InputMethodManager) getContext().getSystemService(Context.INPUT_METHOD_SERVICE)).showSoftInput(this, 0);
                if (SearchView.isLandscapeMode(getContext())) {
                    ensureImeVisible(true);
                }
            }
        }

        protected void onFocusChanged(boolean focused, int direction, Rect previouslyFocusedRect) {
            super.onFocusChanged(focused, direction, previouslyFocusedRect);
            this.mSearchView.onTextFocusChanged();
        }

        public boolean enoughToFilter() {
            return (this.mThreshold <= 0 || super.enoughToFilter()) ? true : SearchView.DBG;
        }

        public boolean onKeyPreIme(int keyCode, KeyEvent event) {
            if (keyCode == 4) {
                DispatcherState state;
                if (event.getAction() == 0 && event.getRepeatCount() == 0) {
                    state = getKeyDispatcherState();
                    if (state == null) {
                        return true;
                    }
                    state.startTracking(event, this);
                    return true;
                } else if (event.getAction() == 1) {
                    state = getKeyDispatcherState();
                    if (state != null) {
                        state.handleUpEvent(event);
                    }
                    if (event.isTracking() && !event.isCanceled()) {
                        this.mSearchView.clearFocus();
                        this.mSearchView.setImeVisibility(SearchView.DBG);
                        return true;
                    }
                }
            }
            return super.onKeyPreIme(keyCode, event);
        }
    }

    public SearchView(Context context) {
        this(context, null);
    }

    public SearchView(Context context, AttributeSet attrs) {
        this(context, attrs, 16843904);
    }

    public SearchView(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public SearchView(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mShowImeRunnable = new C10361();
        this.mUpdateDrawableStateRunnable = new C10372();
        this.mReleaseCursorRunnable = new C10383();
        this.mOutsideDrawablesCache = new WeakHashMap();
        this.mOnClickListener = new C10416();
        this.mTextKeyListener = new C10427();
        this.mOnEditorActionListener = new C10438();
        this.mOnItemClickListener = new C10449();
        this.mOnItemSelectedListener = new OnItemSelectedListener() {
            public void onItemSelected(AdapterView<?> adapterView, View view, int position, long id) {
                SearchView.this.onItemSelected(position);
            }

            public void onNothingSelected(AdapterView<?> adapterView) {
            }
        };
        this.mTextWatcher = new TextWatcher() {
            public void beforeTextChanged(CharSequence s, int start, int before, int after) {
            }

            public void onTextChanged(CharSequence s, int start, int before, int after) {
                SearchView.this.onTextChanged(s);
            }

            public void afterTextChanged(Editable s) {
            }
        };
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.SearchView, defStyleAttr, defStyleRes);
        ((LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(a.getResourceId(1, 17367232), (ViewGroup) this, true);
        this.mSearchSrcTextView = (SearchAutoComplete) findViewById(16909194);
        this.mSearchSrcTextView.setSearchView(this);
        this.mSearchEditFrame = findViewById(16909191);
        this.mSearchPlate = findViewById(16909193);
        this.mSubmitArea = findViewById(16909196);
        this.mSearchButton = (ImageView) findViewById(16909190);
        this.mGoButton = (ImageView) findViewById(16909197);
        this.mCloseButton = (ImageView) findViewById(16909195);
        this.mVoiceButton = (ImageView) findViewById(16909198);
        this.mCollapsedIcon = (ImageView) findViewById(16909192);
        this.mSearchPlate.setBackground(a.getDrawable(13));
        this.mSubmitArea.setBackground(a.getDrawable(14));
        this.mSearchButton.setImageDrawable(a.getDrawable(9));
        this.mGoButton.setImageDrawable(a.getDrawable(8));
        this.mCloseButton.setImageDrawable(a.getDrawable(7));
        this.mVoiceButton.setImageDrawable(a.getDrawable(10));
        this.mCollapsedIcon.setImageDrawable(a.getDrawable(9));
        if (a.hasValueOrEmpty(15)) {
            this.mSearchHintIcon = a.getDrawable(15);
        } else {
            this.mSearchHintIcon = a.getDrawable(9);
        }
        this.mSuggestionRowLayout = a.getResourceId(12, 17367231);
        this.mSuggestionCommitIconResId = a.getResourceId(11, 0);
        this.mSearchButton.setOnClickListener(this.mOnClickListener);
        this.mCloseButton.setOnClickListener(this.mOnClickListener);
        this.mGoButton.setOnClickListener(this.mOnClickListener);
        this.mVoiceButton.setOnClickListener(this.mOnClickListener);
        this.mSearchSrcTextView.setOnClickListener(this.mOnClickListener);
        this.mSearchSrcTextView.addTextChangedListener(this.mTextWatcher);
        this.mSearchSrcTextView.setOnEditorActionListener(this.mOnEditorActionListener);
        this.mSearchSrcTextView.setOnItemClickListener(this.mOnItemClickListener);
        this.mSearchSrcTextView.setOnItemSelectedListener(this.mOnItemSelectedListener);
        this.mSearchSrcTextView.setOnKeyListener(this.mTextKeyListener);
        this.mSearchSrcTextView.setOnFocusChangeListener(new C10394());
        setIconifiedByDefault(a.getBoolean(5, true));
        int maxWidth = a.getDimensionPixelSize(2, -1);
        if (maxWidth != -1) {
            setMaxWidth(maxWidth);
        }
        CharSequence queryHint = a.getText(6);
        if (!TextUtils.isEmpty(queryHint)) {
            setQueryHint(queryHint);
        }
        int imeOptions = a.getInt(4, -1);
        if (imeOptions != -1) {
            setImeOptions(imeOptions);
        }
        int inputType = a.getInt(3, -1);
        if (inputType != -1) {
            setInputType(inputType);
        }
        setFocusable(a.getBoolean(0, true));
        a.recycle();
        this.mVoiceWebSearchIntent = new Intent(RecognizerIntent.ACTION_WEB_SEARCH);
        this.mVoiceWebSearchIntent.addFlags(EditorInfo.IME_FLAG_NO_EXTRACT_UI);
        this.mVoiceWebSearchIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_WEB_SEARCH);
        this.mVoiceAppSearchIntent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        this.mVoiceAppSearchIntent.addFlags(EditorInfo.IME_FLAG_NO_EXTRACT_UI);
        this.mDropDownAnchor = findViewById(this.mSearchSrcTextView.getDropDownAnchor());
        if (this.mDropDownAnchor != null) {
            this.mDropDownAnchor.addOnLayoutChangeListener(new C10405());
        }
        updateViewsVisibility(this.mIconifiedByDefault);
        updateQueryHint();
    }

    int getSuggestionRowLayout() {
        return this.mSuggestionRowLayout;
    }

    int getSuggestionCommitIconResId() {
        return this.mSuggestionCommitIconResId;
    }

    public void setSearchableInfo(SearchableInfo searchable) {
        this.mSearchable = searchable;
        if (this.mSearchable != null) {
            updateSearchAutoComplete();
            updateQueryHint();
        }
        this.mVoiceButtonEnabled = hasVoiceSearch();
        if (this.mVoiceButtonEnabled) {
            this.mSearchSrcTextView.setPrivateImeOptions(IME_OPTION_NO_MICROPHONE);
        }
        updateViewsVisibility(isIconified());
    }

    public void setAppSearchData(Bundle appSearchData) {
        this.mAppSearchData = appSearchData;
    }

    public void setImeOptions(int imeOptions) {
        this.mSearchSrcTextView.setImeOptions(imeOptions);
    }

    public int getImeOptions() {
        return this.mSearchSrcTextView.getImeOptions();
    }

    public void setInputType(int inputType) {
        this.mSearchSrcTextView.setInputType(inputType);
    }

    public int getInputType() {
        return this.mSearchSrcTextView.getInputType();
    }

    public boolean requestFocus(int direction, Rect previouslyFocusedRect) {
        if (this.mClearingFocus) {
            return DBG;
        }
        if (!isFocusable()) {
            return DBG;
        }
        if (isIconified()) {
            return super.requestFocus(direction, previouslyFocusedRect);
        }
        boolean result = this.mSearchSrcTextView.requestFocus(direction, previouslyFocusedRect);
        if (!result) {
            return result;
        }
        updateViewsVisibility(DBG);
        return result;
    }

    public void clearFocus() {
        this.mClearingFocus = true;
        setImeVisibility(DBG);
        super.clearFocus();
        this.mSearchSrcTextView.clearFocus();
        this.mClearingFocus = DBG;
    }

    public void setOnQueryTextListener(OnQueryTextListener listener) {
        this.mOnQueryChangeListener = listener;
    }

    public void setOnCloseListener(OnCloseListener listener) {
        this.mOnCloseListener = listener;
    }

    public void setOnQueryTextFocusChangeListener(OnFocusChangeListener listener) {
        this.mOnQueryTextFocusChangeListener = listener;
    }

    public void setOnSuggestionListener(OnSuggestionListener listener) {
        this.mOnSuggestionListener = listener;
    }

    public void setOnSearchClickListener(OnClickListener listener) {
        this.mOnSearchClickListener = listener;
    }

    public CharSequence getQuery() {
        return this.mSearchSrcTextView.getText();
    }

    public void setQuery(CharSequence query, boolean submit) {
        this.mSearchSrcTextView.setText(query);
        if (query != null) {
            this.mSearchSrcTextView.setSelection(this.mSearchSrcTextView.length());
            this.mUserQuery = query;
        }
        if (submit && !TextUtils.isEmpty(query)) {
            onSubmitQuery();
        }
    }

    public void setQueryHint(CharSequence hint) {
        this.mQueryHint = hint;
        updateQueryHint();
    }

    public CharSequence getQueryHint() {
        if (this.mQueryHint != null) {
            return this.mQueryHint;
        }
        if (this.mSearchable == null) {
            return null;
        }
        int hintId = this.mSearchable.getHintId();
        if (hintId != 0) {
            return getContext().getString(hintId);
        }
        return null;
    }

    public void setIconifiedByDefault(boolean iconified) {
        if (this.mIconifiedByDefault != iconified) {
            this.mIconifiedByDefault = iconified;
            updateViewsVisibility(iconified);
            updateQueryHint();
        }
    }

    public boolean isIconfiedByDefault() {
        return this.mIconifiedByDefault;
    }

    public void setIconified(boolean iconify) {
        if (iconify) {
            onCloseClicked();
        } else {
            onSearchClicked();
        }
    }

    public boolean isIconified() {
        return this.mIconified;
    }

    public void setSubmitButtonEnabled(boolean enabled) {
        this.mSubmitButtonEnabled = enabled;
        updateViewsVisibility(isIconified());
    }

    public boolean isSubmitButtonEnabled() {
        return this.mSubmitButtonEnabled;
    }

    public void setQueryRefinementEnabled(boolean enable) {
        this.mQueryRefinement = enable;
        if (this.mSuggestionsAdapter instanceof SuggestionsAdapter) {
            ((SuggestionsAdapter) this.mSuggestionsAdapter).setQueryRefinement(enable ? 2 : 1);
        }
    }

    public boolean isQueryRefinementEnabled() {
        return this.mQueryRefinement;
    }

    public void setSuggestionsAdapter(CursorAdapter adapter) {
        this.mSuggestionsAdapter = adapter;
        this.mSearchSrcTextView.setAdapter(this.mSuggestionsAdapter);
    }

    public CursorAdapter getSuggestionsAdapter() {
        return this.mSuggestionsAdapter;
    }

    public void setMaxWidth(int maxpixels) {
        this.mMaxWidth = maxpixels;
        requestLayout();
    }

    public int getMaxWidth() {
        return this.mMaxWidth;
    }

    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        if (isIconified()) {
            super.onMeasure(widthMeasureSpec, heightMeasureSpec);
            return;
        }
        int widthMode = MeasureSpec.getMode(widthMeasureSpec);
        int width = MeasureSpec.getSize(widthMeasureSpec);
        switch (widthMode) {
            case RtlSpacingHelper.UNDEFINED /*-2147483648*/:
                if (this.mMaxWidth <= 0) {
                    width = Math.min(getPreferredWidth(), width);
                    break;
                } else {
                    width = Math.min(this.mMaxWidth, width);
                    break;
                }
            case Toast.LENGTH_SHORT /*0*/:
                width = this.mMaxWidth > 0 ? this.mMaxWidth : getPreferredWidth();
                break;
            case EditorInfo.IME_FLAG_NO_ENTER_ACTION /*1073741824*/:
                if (this.mMaxWidth > 0) {
                    width = Math.min(this.mMaxWidth, width);
                    break;
                }
                break;
        }
        super.onMeasure(MeasureSpec.makeMeasureSpec(width, EditorInfo.IME_FLAG_NO_ENTER_ACTION), heightMeasureSpec);
    }

    private int getPreferredWidth() {
        return getContext().getResources().getDimensionPixelSize(17104948);
    }

    private void updateViewsVisibility(boolean collapsed) {
        int visCollapsed;
        boolean hasText;
        int i;
        boolean z = true;
        int i2 = 8;
        this.mIconified = collapsed;
        if (collapsed) {
            visCollapsed = 0;
        } else {
            visCollapsed = 8;
        }
        if (TextUtils.isEmpty(this.mSearchSrcTextView.getText())) {
            hasText = DBG;
        } else {
            hasText = true;
        }
        this.mSearchButton.setVisibility(visCollapsed);
        updateSubmitButton(hasText);
        View view = this.mSearchEditFrame;
        if (collapsed) {
            i = 8;
        } else {
            i = 0;
        }
        view.setVisibility(i);
        ImageView imageView = this.mCollapsedIcon;
        if (!this.mIconifiedByDefault) {
            i2 = 0;
        }
        imageView.setVisibility(i2);
        updateCloseButton();
        if (hasText) {
            z = DBG;
        }
        updateVoiceButton(z);
        updateSubmitArea();
    }

    private boolean hasVoiceSearch() {
        if (this.mSearchable == null || !this.mSearchable.getVoiceSearchEnabled()) {
            return DBG;
        }
        Intent testIntent = null;
        if (this.mSearchable.getVoiceSearchLaunchWebSearch()) {
            testIntent = this.mVoiceWebSearchIntent;
        } else if (this.mSearchable.getVoiceSearchLaunchRecognizer()) {
            testIntent = this.mVoiceAppSearchIntent;
        }
        if (testIntent == null || getContext().getPackageManager().resolveActivity(testIntent, AccessibilityNodeInfo.ACTION_CUT) == null) {
            return DBG;
        }
        return true;
    }

    private boolean isSubmitAreaEnabled() {
        return ((this.mSubmitButtonEnabled || this.mVoiceButtonEnabled) && !isIconified()) ? true : DBG;
    }

    private void updateSubmitButton(boolean hasText) {
        int visibility = 8;
        if (this.mSubmitButtonEnabled && isSubmitAreaEnabled() && hasFocus() && (hasText || !this.mVoiceButtonEnabled)) {
            visibility = 0;
        }
        this.mGoButton.setVisibility(visibility);
    }

    private void updateSubmitArea() {
        int visibility = 8;
        if (isSubmitAreaEnabled() && (this.mGoButton.getVisibility() == 0 || this.mVoiceButton.getVisibility() == 0)) {
            visibility = 0;
        }
        this.mSubmitArea.setVisibility(visibility);
    }

    private void updateCloseButton() {
        boolean hasText;
        boolean showClose = true;
        int i = 0;
        if (TextUtils.isEmpty(this.mSearchSrcTextView.getText())) {
            hasText = DBG;
        } else {
            hasText = true;
        }
        if (!hasText && (!this.mIconifiedByDefault || this.mExpandedInActionView)) {
            showClose = DBG;
        }
        ImageView imageView = this.mCloseButton;
        if (!showClose) {
            i = 8;
        }
        imageView.setVisibility(i);
        Drawable closeButtonImg = this.mCloseButton.getDrawable();
        if (closeButtonImg != null) {
            closeButtonImg.setState(hasText ? ENABLED_STATE_SET : EMPTY_STATE_SET);
        }
    }

    private void postUpdateFocusedState() {
        post(this.mUpdateDrawableStateRunnable);
    }

    private void updateFocusedState() {
        int[] stateSet = this.mSearchSrcTextView.hasFocus() ? FOCUSED_STATE_SET : EMPTY_STATE_SET;
        Drawable searchPlateBg = this.mSearchPlate.getBackground();
        if (searchPlateBg != null) {
            searchPlateBg.setState(stateSet);
        }
        Drawable submitAreaBg = this.mSubmitArea.getBackground();
        if (submitAreaBg != null) {
            submitAreaBg.setState(stateSet);
        }
        invalidate();
    }

    protected void onDetachedFromWindow() {
        removeCallbacks(this.mUpdateDrawableStateRunnable);
        post(this.mReleaseCursorRunnable);
        super.onDetachedFromWindow();
    }

    private void setImeVisibility(boolean visible) {
        if (visible) {
            post(this.mShowImeRunnable);
            return;
        }
        removeCallbacks(this.mShowImeRunnable);
        InputMethodManager imm = (InputMethodManager) getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
        if (imm != null) {
            imm.hideSoftInputFromWindow(getWindowToken(), 0);
        }
    }

    void onQueryRefine(CharSequence queryText) {
        setQuery(queryText);
    }

    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (this.mSearchable == null) {
            return DBG;
        }
        ActionKeyInfo actionKey = this.mSearchable.findActionKey(keyCode);
        if (actionKey == null || actionKey.getQueryActionMsg() == null) {
            return super.onKeyDown(keyCode, event);
        }
        launchQuerySearch(keyCode, actionKey.getQueryActionMsg(), this.mSearchSrcTextView.getText().toString());
        return true;
    }

    private boolean onSuggestionsKey(View v, int keyCode, KeyEvent event) {
        if (this.mSearchable == null || this.mSuggestionsAdapter == null || event.getAction() != 0 || !event.hasNoModifiers()) {
            return DBG;
        }
        if (keyCode == 66 || keyCode == 84 || keyCode == 61) {
            return onItemClicked(this.mSearchSrcTextView.getListSelection(), 0, null);
        }
        if (keyCode == 21 || keyCode == 22) {
            int selPoint;
            if (keyCode == 21) {
                selPoint = 0;
            } else {
                selPoint = this.mSearchSrcTextView.length();
            }
            this.mSearchSrcTextView.setSelection(selPoint);
            this.mSearchSrcTextView.setListSelection(0);
            this.mSearchSrcTextView.clearListSelection();
            this.mSearchSrcTextView.ensureImeVisible(true);
            return true;
        } else if (keyCode == 19 && this.mSearchSrcTextView.getListSelection() == 0) {
            return DBG;
        } else {
            ActionKeyInfo actionKey = this.mSearchable.findActionKey(keyCode);
            if (actionKey == null) {
                return DBG;
            }
            if (actionKey.getSuggestActionMsg() == null && actionKey.getSuggestActionMsgColumn() == null) {
                return DBG;
            }
            int position = this.mSearchSrcTextView.getListSelection();
            if (position == -1) {
                return DBG;
            }
            Cursor c = this.mSuggestionsAdapter.getCursor();
            if (!c.moveToPosition(position)) {
                return DBG;
            }
            String actionMsg = getActionKeyMessage(c, actionKey);
            if (actionMsg == null || actionMsg.length() <= 0) {
                return DBG;
            }
            return onItemClicked(position, keyCode, actionMsg);
        }
    }

    private static String getActionKeyMessage(Cursor c, ActionKeyInfo actionKey) {
        String result = null;
        String column = actionKey.getSuggestActionMsgColumn();
        if (column != null) {
            result = SuggestionsAdapter.getColumnString(c, column);
        }
        if (result == null) {
            return actionKey.getSuggestActionMsg();
        }
        return result;
    }

    private CharSequence getDecoratedHint(CharSequence hintText) {
        if (!this.mIconifiedByDefault || this.mSearchHintIcon == null) {
            return hintText;
        }
        int textSize = (int) (((double) this.mSearchSrcTextView.getTextSize()) * 1.25d);
        this.mSearchHintIcon.setBounds(0, 0, textSize, textSize);
        CharSequence ssb = new SpannableStringBuilder("   ");
        ssb.setSpan(new ImageSpan(this.mSearchHintIcon), 1, 2, 33);
        ssb.append(hintText);
        return ssb;
    }

    private void updateQueryHint() {
        if (this.mQueryHint != null) {
            this.mSearchSrcTextView.setHint(getDecoratedHint(this.mQueryHint));
        } else if (this.mSearchable != null) {
            CharSequence hint = null;
            int hintId = this.mSearchable.getHintId();
            if (hintId != 0) {
                hint = getContext().getString(hintId);
            }
            if (hint != null) {
                this.mSearchSrcTextView.setHint(getDecoratedHint(hint));
            }
        } else {
            this.mSearchSrcTextView.setHint(getDecoratedHint(ProxyInfo.LOCAL_EXCL_LIST));
        }
    }

    private void updateSearchAutoComplete() {
        int i = 1;
        this.mSearchSrcTextView.setDropDownAnimationStyle(0);
        this.mSearchSrcTextView.setThreshold(this.mSearchable.getSuggestThreshold());
        this.mSearchSrcTextView.setImeOptions(this.mSearchable.getImeOptions());
        int inputType = this.mSearchable.getInputType();
        if ((inputType & 15) == 1) {
            inputType &= -65537;
            if (this.mSearchable.getSuggestAuthority() != null) {
                inputType = (inputType | AccessibilityNodeInfo.ACTION_CUT) | AccessibilityNodeInfo.ACTION_COLLAPSE;
            }
        }
        this.mSearchSrcTextView.setInputType(inputType);
        if (this.mSuggestionsAdapter != null) {
            this.mSuggestionsAdapter.changeCursor(null);
        }
        if (this.mSearchable.getSuggestAuthority() != null) {
            this.mSuggestionsAdapter = new SuggestionsAdapter(getContext(), this, this.mSearchable, this.mOutsideDrawablesCache);
            this.mSearchSrcTextView.setAdapter(this.mSuggestionsAdapter);
            SuggestionsAdapter suggestionsAdapter = (SuggestionsAdapter) this.mSuggestionsAdapter;
            if (this.mQueryRefinement) {
                i = 2;
            }
            suggestionsAdapter.setQueryRefinement(i);
        }
    }

    private void updateVoiceButton(boolean empty) {
        int visibility = 8;
        if (this.mVoiceButtonEnabled && !isIconified() && empty) {
            visibility = 0;
            this.mGoButton.setVisibility(8);
        }
        this.mVoiceButton.setVisibility(visibility);
    }

    private void onTextChanged(CharSequence newText) {
        boolean hasText;
        boolean z = true;
        CharSequence text = this.mSearchSrcTextView.getText();
        this.mUserQuery = text;
        if (TextUtils.isEmpty(text)) {
            hasText = DBG;
        } else {
            hasText = true;
        }
        updateSubmitButton(hasText);
        if (hasText) {
            z = DBG;
        }
        updateVoiceButton(z);
        updateCloseButton();
        updateSubmitArea();
        if (!(this.mOnQueryChangeListener == null || TextUtils.equals(newText, this.mOldQueryText))) {
            this.mOnQueryChangeListener.onQueryTextChange(newText.toString());
        }
        this.mOldQueryText = newText.toString();
    }

    private void onSubmitQuery() {
        CharSequence query = this.mSearchSrcTextView.getText();
        if (query != null && TextUtils.getTrimmedLength(query) > 0) {
            if (this.mOnQueryChangeListener == null || !this.mOnQueryChangeListener.onQueryTextSubmit(query.toString())) {
                if (this.mSearchable != null) {
                    launchQuerySearch(0, null, query.toString());
                }
                setImeVisibility(DBG);
                dismissSuggestions();
            }
        }
    }

    private void dismissSuggestions() {
        this.mSearchSrcTextView.dismissDropDown();
    }

    private void onCloseClicked() {
        if (!TextUtils.isEmpty(this.mSearchSrcTextView.getText())) {
            this.mSearchSrcTextView.setText(ProxyInfo.LOCAL_EXCL_LIST);
            this.mSearchSrcTextView.requestFocus();
            setImeVisibility(true);
        } else if (!this.mIconifiedByDefault) {
        } else {
            if (this.mOnCloseListener == null || !this.mOnCloseListener.onClose()) {
                clearFocus();
                updateViewsVisibility(true);
            }
        }
    }

    private void onSearchClicked() {
        updateViewsVisibility(DBG);
        this.mSearchSrcTextView.requestFocus();
        setImeVisibility(true);
        if (this.mOnSearchClickListener != null) {
            this.mOnSearchClickListener.onClick(this);
        }
    }

    private void onVoiceClicked() {
        if (this.mSearchable != null) {
            SearchableInfo searchable = this.mSearchable;
            try {
                if (searchable.getVoiceSearchLaunchWebSearch()) {
                    getContext().startActivity(createVoiceWebSearchIntent(this.mVoiceWebSearchIntent, searchable));
                } else if (searchable.getVoiceSearchLaunchRecognizer()) {
                    getContext().startActivity(createVoiceAppSearchIntent(this.mVoiceAppSearchIntent, searchable));
                }
            } catch (ActivityNotFoundException e) {
                Log.w(LOG_TAG, "Could not find voice search activity");
            }
        }
    }

    void onTextFocusChanged() {
        updateViewsVisibility(isIconified());
        postUpdateFocusedState();
        if (this.mSearchSrcTextView.hasFocus()) {
            forceSuggestionQuery();
        }
    }

    public void onWindowFocusChanged(boolean hasWindowFocus) {
        super.onWindowFocusChanged(hasWindowFocus);
        postUpdateFocusedState();
    }

    public void onActionViewCollapsed() {
        setQuery(ProxyInfo.LOCAL_EXCL_LIST, DBG);
        clearFocus();
        updateViewsVisibility(true);
        this.mSearchSrcTextView.setImeOptions(this.mCollapsedImeOptions);
        this.mExpandedInActionView = DBG;
    }

    public void onActionViewExpanded() {
        if (!this.mExpandedInActionView) {
            this.mExpandedInActionView = true;
            this.mCollapsedImeOptions = this.mSearchSrcTextView.getImeOptions();
            this.mSearchSrcTextView.setImeOptions(this.mCollapsedImeOptions | EditorInfo.IME_FLAG_NO_FULLSCREEN);
            this.mSearchSrcTextView.setText(ProxyInfo.LOCAL_EXCL_LIST);
            setIconified(DBG);
        }
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(SearchView.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(SearchView.class.getName());
    }

    private void adjustDropDownSizeAndPosition() {
        if (this.mDropDownAnchor.getWidth() > 1) {
            int offset;
            Resources res = getContext().getResources();
            int anchorPadding = this.mSearchPlate.getPaddingLeft();
            Rect dropDownPadding = new Rect();
            boolean isLayoutRtl = isLayoutRtl();
            int iconOffset = this.mIconifiedByDefault ? res.getDimensionPixelSize(17104971) + res.getDimensionPixelSize(17104969) : 0;
            this.mSearchSrcTextView.getDropDownBackground().getPadding(dropDownPadding);
            if (isLayoutRtl) {
                offset = -dropDownPadding.left;
            } else {
                offset = anchorPadding - (dropDownPadding.left + iconOffset);
            }
            this.mSearchSrcTextView.setDropDownHorizontalOffset(offset);
            this.mSearchSrcTextView.setDropDownWidth((((this.mDropDownAnchor.getWidth() + dropDownPadding.left) + dropDownPadding.right) + iconOffset) - anchorPadding);
        }
    }

    private boolean onItemClicked(int position, int actionKey, String actionMsg) {
        if (this.mOnSuggestionListener != null && this.mOnSuggestionListener.onSuggestionClick(position)) {
            return DBG;
        }
        launchSuggestion(position, 0, null);
        setImeVisibility(DBG);
        dismissSuggestions();
        return true;
    }

    private boolean onItemSelected(int position) {
        if (this.mOnSuggestionListener != null && this.mOnSuggestionListener.onSuggestionSelect(position)) {
            return DBG;
        }
        rewriteQueryFromSuggestion(position);
        return true;
    }

    private void rewriteQueryFromSuggestion(int position) {
        CharSequence oldQuery = this.mSearchSrcTextView.getText();
        Cursor c = this.mSuggestionsAdapter.getCursor();
        if (c != null) {
            if (c.moveToPosition(position)) {
                CharSequence newQuery = this.mSuggestionsAdapter.convertToString(c);
                if (newQuery != null) {
                    setQuery(newQuery);
                    return;
                } else {
                    setQuery(oldQuery);
                    return;
                }
            }
            setQuery(oldQuery);
        }
    }

    private boolean launchSuggestion(int position, int actionKey, String actionMsg) {
        Cursor c = this.mSuggestionsAdapter.getCursor();
        if (c == null || !c.moveToPosition(position)) {
            return DBG;
        }
        launchIntent(createIntentFromSuggestion(c, actionKey, actionMsg));
        return true;
    }

    private void launchIntent(Intent intent) {
        if (intent != null) {
            try {
                getContext().startActivity(intent);
            } catch (RuntimeException ex) {
                Log.e(LOG_TAG, "Failed launch activity: " + intent, ex);
            }
        }
    }

    private void setQuery(CharSequence query) {
        this.mSearchSrcTextView.setText(query, true);
        this.mSearchSrcTextView.setSelection(TextUtils.isEmpty(query) ? 0 : query.length());
    }

    private void launchQuerySearch(int actionKey, String actionMsg, String query) {
        getContext().startActivity(createIntent(Intent.ACTION_SEARCH, null, null, query, actionKey, actionMsg));
    }

    private Intent createIntent(String action, Uri data, String extraData, String query, int actionKey, String actionMsg) {
        Intent intent = new Intent(action);
        intent.addFlags(EditorInfo.IME_FLAG_NO_EXTRACT_UI);
        if (data != null) {
            intent.setData(data);
        }
        intent.putExtra("user_query", this.mUserQuery);
        if (query != null) {
            intent.putExtra("query", query);
        }
        if (extraData != null) {
            intent.putExtra("intent_extra_data_key", extraData);
        }
        if (this.mAppSearchData != null) {
            intent.putExtra("app_data", this.mAppSearchData);
        }
        if (actionKey != 0) {
            intent.putExtra("action_key", actionKey);
            intent.putExtra("action_msg", actionMsg);
        }
        intent.setComponent(this.mSearchable.getSearchActivity());
        return intent;
    }

    private Intent createVoiceWebSearchIntent(Intent baseIntent, SearchableInfo searchable) {
        Intent voiceIntent = new Intent(baseIntent);
        ComponentName searchActivity = searchable.getSearchActivity();
        voiceIntent.putExtra(RecognizerIntent.EXTRA_CALLING_PACKAGE, searchActivity == null ? null : searchActivity.flattenToShortString());
        return voiceIntent;
    }

    private Intent createVoiceAppSearchIntent(Intent baseIntent, SearchableInfo searchable) {
        ComponentName searchActivity = searchable.getSearchActivity();
        Intent queryIntent = new Intent(Intent.ACTION_SEARCH);
        queryIntent.setComponent(searchActivity);
        Parcelable pending = PendingIntent.getActivity(getContext(), 0, queryIntent, EditorInfo.IME_FLAG_NO_ENTER_ACTION);
        Bundle queryExtras = new Bundle();
        if (this.mAppSearchData != null) {
            queryExtras.putParcelable("app_data", this.mAppSearchData);
        }
        Intent voiceIntent = new Intent(baseIntent);
        String languageModel = RecognizerIntent.LANGUAGE_MODEL_FREE_FORM;
        String prompt = null;
        String language = null;
        int maxResults = 1;
        Resources resources = getResources();
        if (searchable.getVoiceLanguageModeId() != 0) {
            languageModel = resources.getString(searchable.getVoiceLanguageModeId());
        }
        if (searchable.getVoicePromptTextId() != 0) {
            prompt = resources.getString(searchable.getVoicePromptTextId());
        }
        if (searchable.getVoiceLanguageId() != 0) {
            language = resources.getString(searchable.getVoiceLanguageId());
        }
        if (searchable.getVoiceMaxResults() != 0) {
            maxResults = searchable.getVoiceMaxResults();
        }
        voiceIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, languageModel);
        voiceIntent.putExtra(RecognizerIntent.EXTRA_PROMPT, prompt);
        voiceIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, language);
        voiceIntent.putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, maxResults);
        voiceIntent.putExtra(RecognizerIntent.EXTRA_CALLING_PACKAGE, searchActivity == null ? null : searchActivity.flattenToShortString());
        voiceIntent.putExtra(RecognizerIntent.EXTRA_RESULTS_PENDINGINTENT, pending);
        voiceIntent.putExtra(RecognizerIntent.EXTRA_RESULTS_PENDINGINTENT_BUNDLE, queryExtras);
        return voiceIntent;
    }

    private Intent createIntentFromSuggestion(Cursor c, int actionKey, String actionMsg) {
        try {
            String action = SuggestionsAdapter.getColumnString(c, "suggest_intent_action");
            if (action == null) {
                action = this.mSearchable.getSuggestIntentAction();
            }
            if (action == null) {
                action = Intent.ACTION_SEARCH;
            }
            String data = SuggestionsAdapter.getColumnString(c, "suggest_intent_data");
            if (data == null) {
                data = this.mSearchable.getSuggestIntentData();
            }
            if (data != null) {
                String id = SuggestionsAdapter.getColumnString(c, "suggest_intent_data_id");
                if (id != null) {
                    data = data + "/" + Uri.encode(id);
                }
            }
            return createIntent(action, data == null ? null : Uri.parse(data), SuggestionsAdapter.getColumnString(c, "suggest_intent_extra_data"), SuggestionsAdapter.getColumnString(c, "suggest_intent_query"), actionKey, actionMsg);
        } catch (RuntimeException e) {
            int rowNum;
            try {
                rowNum = c.getPosition();
            } catch (RuntimeException e2) {
                rowNum = -1;
            }
            Log.w(LOG_TAG, "Search suggestions cursor at row " + rowNum + " returned exception.", e);
            return null;
        }
    }

    private void forceSuggestionQuery() {
        this.mSearchSrcTextView.doBeforeTextChanged();
        this.mSearchSrcTextView.doAfterTextChanged();
    }

    static boolean isLandscapeMode(Context context) {
        return context.getResources().getConfiguration().orientation == 2 ? true : DBG;
    }
}
