package android.preference;

import android.C0000R;
import android.app.Fragment;
import android.app.FragmentBreadCrumbs;
import android.app.FragmentTransaction;
import android.app.ListActivity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.opengl.GLES31;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.preference.PreferenceFragment.OnPreferenceStartFragmentCallback;
import android.preference.PreferenceManager.OnPreferenceTreeClickListener;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.FrameLayout.LayoutParams;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import com.android.internal.R;
import java.util.ArrayList;
import java.util.List;

public abstract class PreferenceActivity extends ListActivity implements OnPreferenceTreeClickListener, OnPreferenceStartFragmentCallback {
    private static final String BACK_STACK_PREFS = ":android:prefs";
    private static final String CUR_HEADER_TAG = ":android:cur_header";
    public static final String EXTRA_NO_HEADERS = ":android:no_headers";
    private static final String EXTRA_PREFS_SET_BACK_TEXT = "extra_prefs_set_back_text";
    private static final String EXTRA_PREFS_SET_NEXT_TEXT = "extra_prefs_set_next_text";
    private static final String EXTRA_PREFS_SHOW_BUTTON_BAR = "extra_prefs_show_button_bar";
    private static final String EXTRA_PREFS_SHOW_SKIP = "extra_prefs_show_skip";
    public static final String EXTRA_SHOW_FRAGMENT = ":android:show_fragment";
    public static final String EXTRA_SHOW_FRAGMENT_ARGUMENTS = ":android:show_fragment_args";
    public static final String EXTRA_SHOW_FRAGMENT_SHORT_TITLE = ":android:show_fragment_short_title";
    public static final String EXTRA_SHOW_FRAGMENT_TITLE = ":android:show_fragment_title";
    private static final int FIRST_REQUEST_CODE = 100;
    private static final String HEADERS_TAG = ":android:headers";
    public static final long HEADER_ID_UNDEFINED = -1;
    private static final int MSG_BIND_PREFERENCES = 1;
    private static final int MSG_BUILD_HEADERS = 2;
    private static final String PREFERENCES_TAG = ":android:preferences";
    private static final String TAG = "PreferenceActivity";
    private Header mCurHeader;
    private FragmentBreadCrumbs mFragmentBreadCrumbs;
    private Handler mHandler;
    private final ArrayList<Header> mHeaders;
    private FrameLayout mListFooter;
    private Button mNextButton;
    private int mPreferenceHeaderItemResId;
    private boolean mPreferenceHeaderRemoveEmptyIcon;
    private PreferenceManager mPreferenceManager;
    private ViewGroup mPrefsContainer;
    private Bundle mSavedInstanceState;
    private boolean mSinglePane;

    /* renamed from: android.preference.PreferenceActivity.1 */
    class C06371 extends Handler {
        C06371() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case PreferenceActivity.MSG_BIND_PREFERENCES /*1*/:
                    PreferenceActivity.this.bindPreferences();
                case PreferenceActivity.MSG_BUILD_HEADERS /*2*/:
                    ArrayList<Header> oldHeaders = new ArrayList(PreferenceActivity.this.mHeaders);
                    PreferenceActivity.this.mHeaders.clear();
                    PreferenceActivity.this.onBuildHeaders(PreferenceActivity.this.mHeaders);
                    if (PreferenceActivity.this.mAdapter instanceof BaseAdapter) {
                        ((BaseAdapter) PreferenceActivity.this.mAdapter).notifyDataSetChanged();
                    }
                    Header header = PreferenceActivity.this.onGetNewHeader();
                    Header mappedHeader;
                    if (header != null && header.fragment != null) {
                        mappedHeader = PreferenceActivity.this.findBestMatchingHeader(header, oldHeaders);
                        if (mappedHeader == null || PreferenceActivity.this.mCurHeader != mappedHeader) {
                            PreferenceActivity.this.switchToHeader(header);
                        }
                    } else if (PreferenceActivity.this.mCurHeader != null) {
                        mappedHeader = PreferenceActivity.this.findBestMatchingHeader(PreferenceActivity.this.mCurHeader, PreferenceActivity.this.mHeaders);
                        if (mappedHeader != null) {
                            PreferenceActivity.this.setSelectedHeader(mappedHeader);
                        }
                    }
                default:
            }
        }
    }

    /* renamed from: android.preference.PreferenceActivity.2 */
    class C06382 implements OnClickListener {
        C06382() {
        }

        public void onClick(View v) {
            PreferenceActivity.this.setResult(0);
            PreferenceActivity.this.finish();
        }
    }

    /* renamed from: android.preference.PreferenceActivity.3 */
    class C06393 implements OnClickListener {
        C06393() {
        }

        public void onClick(View v) {
            PreferenceActivity.this.setResult(-1);
            PreferenceActivity.this.finish();
        }
    }

    /* renamed from: android.preference.PreferenceActivity.4 */
    class C06404 implements OnClickListener {
        C06404() {
        }

        public void onClick(View v) {
            PreferenceActivity.this.setResult(-1);
            PreferenceActivity.this.finish();
        }
    }

    public static final class Header implements Parcelable {
        public static final Creator<Header> CREATOR;
        public CharSequence breadCrumbShortTitle;
        public int breadCrumbShortTitleRes;
        public CharSequence breadCrumbTitle;
        public int breadCrumbTitleRes;
        public Bundle extras;
        public String fragment;
        public Bundle fragmentArguments;
        public int iconRes;
        public long id;
        public Intent intent;
        public CharSequence summary;
        public int summaryRes;
        public CharSequence title;
        public int titleRes;

        /* renamed from: android.preference.PreferenceActivity.Header.1 */
        static class C06411 implements Creator<Header> {
            C06411() {
            }

            public Header createFromParcel(Parcel source) {
                return new Header(source);
            }

            public Header[] newArray(int size) {
                return new Header[size];
            }
        }

        public Header() {
            this.id = PreferenceActivity.HEADER_ID_UNDEFINED;
        }

        public CharSequence getTitle(Resources res) {
            if (this.titleRes != 0) {
                return res.getText(this.titleRes);
            }
            return this.title;
        }

        public CharSequence getSummary(Resources res) {
            if (this.summaryRes != 0) {
                return res.getText(this.summaryRes);
            }
            return this.summary;
        }

        public CharSequence getBreadCrumbTitle(Resources res) {
            if (this.breadCrumbTitleRes != 0) {
                return res.getText(this.breadCrumbTitleRes);
            }
            return this.breadCrumbTitle;
        }

        public CharSequence getBreadCrumbShortTitle(Resources res) {
            if (this.breadCrumbShortTitleRes != 0) {
                return res.getText(this.breadCrumbShortTitleRes);
            }
            return this.breadCrumbShortTitle;
        }

        public int describeContents() {
            return 0;
        }

        public void writeToParcel(Parcel dest, int flags) {
            dest.writeLong(this.id);
            dest.writeInt(this.titleRes);
            TextUtils.writeToParcel(this.title, dest, flags);
            dest.writeInt(this.summaryRes);
            TextUtils.writeToParcel(this.summary, dest, flags);
            dest.writeInt(this.breadCrumbTitleRes);
            TextUtils.writeToParcel(this.breadCrumbTitle, dest, flags);
            dest.writeInt(this.breadCrumbShortTitleRes);
            TextUtils.writeToParcel(this.breadCrumbShortTitle, dest, flags);
            dest.writeInt(this.iconRes);
            dest.writeString(this.fragment);
            dest.writeBundle(this.fragmentArguments);
            if (this.intent != null) {
                dest.writeInt(PreferenceActivity.MSG_BIND_PREFERENCES);
                this.intent.writeToParcel(dest, flags);
            } else {
                dest.writeInt(0);
            }
            dest.writeBundle(this.extras);
        }

        public void readFromParcel(Parcel in) {
            this.id = in.readLong();
            this.titleRes = in.readInt();
            this.title = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(in);
            this.summaryRes = in.readInt();
            this.summary = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(in);
            this.breadCrumbTitleRes = in.readInt();
            this.breadCrumbTitle = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(in);
            this.breadCrumbShortTitleRes = in.readInt();
            this.breadCrumbShortTitle = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(in);
            this.iconRes = in.readInt();
            this.fragment = in.readString();
            this.fragmentArguments = in.readBundle();
            if (in.readInt() != 0) {
                this.intent = (Intent) Intent.CREATOR.createFromParcel(in);
            }
            this.extras = in.readBundle();
        }

        Header(Parcel in) {
            this.id = PreferenceActivity.HEADER_ID_UNDEFINED;
            readFromParcel(in);
        }

        static {
            CREATOR = new C06411();
        }
    }

    private static class HeaderAdapter extends ArrayAdapter<Header> {
        private LayoutInflater mInflater;
        private int mLayoutResId;
        private boolean mRemoveIconIfEmpty;

        private static class HeaderViewHolder {
            ImageView icon;
            TextView summary;
            TextView title;

            private HeaderViewHolder() {
            }
        }

        public HeaderAdapter(Context context, List<Header> objects, int layoutResId, boolean removeIconBehavior) {
            super(context, 0, (List) objects);
            this.mInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            this.mLayoutResId = layoutResId;
            this.mRemoveIconIfEmpty = removeIconBehavior;
        }

        public View getView(int position, View convertView, ViewGroup parent) {
            View view;
            HeaderViewHolder holder;
            if (convertView == null) {
                view = this.mInflater.inflate(this.mLayoutResId, parent, false);
                holder = new HeaderViewHolder();
                holder.icon = (ImageView) view.findViewById(C0000R.id.icon);
                holder.title = (TextView) view.findViewById(C0000R.id.title);
                holder.summary = (TextView) view.findViewById(C0000R.id.summary);
                view.setTag(holder);
            } else {
                view = convertView;
                holder = (HeaderViewHolder) view.getTag();
            }
            Header header = (Header) getItem(position);
            if (!this.mRemoveIconIfEmpty) {
                holder.icon.setImageResource(header.iconRes);
            } else if (header.iconRes == 0) {
                holder.icon.setVisibility(8);
            } else {
                holder.icon.setVisibility(0);
                holder.icon.setImageResource(header.iconRes);
            }
            holder.title.setText(header.getTitle(getContext().getResources()));
            CharSequence summary = header.getSummary(getContext().getResources());
            if (TextUtils.isEmpty(summary)) {
                holder.summary.setVisibility(8);
            } else {
                holder.summary.setVisibility(0);
                holder.summary.setText(summary);
            }
            return view;
        }
    }

    public PreferenceActivity() {
        this.mHeaders = new ArrayList();
        this.mPreferenceHeaderItemResId = 0;
        this.mPreferenceHeaderRemoveEmptyIcon = false;
        this.mHandler = new C06371();
    }

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        TypedArray sa = obtainStyledAttributes(null, R.styleable.PreferenceActivity, 18219034, 0);
        int layoutResId = sa.getResourceId(0, 17367196);
        this.mPreferenceHeaderItemResId = sa.getResourceId(MSG_BIND_PREFERENCES, 17367190);
        this.mPreferenceHeaderRemoveEmptyIcon = sa.getBoolean(MSG_BUILD_HEADERS, false);
        sa.recycle();
        setContentView(layoutResId);
        this.mListFooter = (FrameLayout) findViewById(16909147);
        this.mPrefsContainer = (ViewGroup) findViewById(16909148);
        boolean z = onIsHidingHeaders() || !onIsMultiPane();
        this.mSinglePane = z;
        String initialFragment = getIntent().getStringExtra(EXTRA_SHOW_FRAGMENT);
        Bundle initialArguments = getIntent().getBundleExtra(EXTRA_SHOW_FRAGMENT_ARGUMENTS);
        int initialTitle = getIntent().getIntExtra(EXTRA_SHOW_FRAGMENT_TITLE, 0);
        int initialShortTitle = getIntent().getIntExtra(EXTRA_SHOW_FRAGMENT_SHORT_TITLE, 0);
        if (savedInstanceState != null) {
            ArrayList<Header> headers = savedInstanceState.getParcelableArrayList(HEADERS_TAG);
            if (headers != null) {
                this.mHeaders.addAll(headers);
                int curHeader = savedInstanceState.getInt(CUR_HEADER_TAG, -1);
                if (curHeader >= 0) {
                    if (curHeader < this.mHeaders.size()) {
                        setSelectedHeader((Header) this.mHeaders.get(curHeader));
                    }
                }
            }
        } else if (initialFragment == null || !this.mSinglePane) {
            onBuildHeaders(this.mHeaders);
            if (this.mHeaders.size() > 0 && !this.mSinglePane) {
                if (initialFragment == null) {
                    switchToHeader(onGetInitialHeader());
                } else {
                    switchToHeader(initialFragment, initialArguments);
                }
            }
        } else {
            switchToHeader(initialFragment, initialArguments);
            if (initialTitle != 0) {
                showBreadCrumbs(getText(initialTitle), initialShortTitle != 0 ? getText(initialShortTitle) : null);
            }
        }
        if (initialFragment == null || !this.mSinglePane) {
            if (this.mHeaders.size() > 0) {
                setListAdapter(new HeaderAdapter(this, this.mHeaders, this.mPreferenceHeaderItemResId, this.mPreferenceHeaderRemoveEmptyIcon));
                if (!this.mSinglePane) {
                    getListView().setChoiceMode(MSG_BIND_PREFERENCES);
                    if (this.mCurHeader != null) {
                        setSelectedHeader(this.mCurHeader);
                    }
                    this.mPrefsContainer.setVisibility(0);
                }
            } else {
                setContentView(17367198);
                this.mListFooter = (FrameLayout) findViewById(16909147);
                this.mPrefsContainer = (ViewGroup) findViewById(16909149);
                this.mPreferenceManager = new PreferenceManager(this, FIRST_REQUEST_CODE);
                this.mPreferenceManager.setOnPreferenceTreeClickListener(this);
            }
        } else {
            findViewById(16909146).setVisibility(8);
            this.mPrefsContainer.setVisibility(0);
            if (initialTitle != 0) {
                showBreadCrumbs(getText(initialTitle), initialShortTitle != 0 ? getText(initialShortTitle) : null);
            }
        }
        Intent intent = getIntent();
        if (intent.getBooleanExtra(EXTRA_PREFS_SHOW_BUTTON_BAR, false)) {
            String buttonText;
            findViewById(16909150).setVisibility(0);
            Button backButton = (Button) findViewById(16909151);
            backButton.setOnClickListener(new C06382());
            Button skipButton = (Button) findViewById(16909152);
            skipButton.setOnClickListener(new C06393());
            this.mNextButton = (Button) findViewById(16909153);
            this.mNextButton.setOnClickListener(new C06404());
            if (intent.hasExtra(EXTRA_PREFS_SET_NEXT_TEXT)) {
                buttonText = intent.getStringExtra(EXTRA_PREFS_SET_NEXT_TEXT);
                if (TextUtils.isEmpty(buttonText)) {
                    this.mNextButton.setVisibility(8);
                } else {
                    this.mNextButton.setText((CharSequence) buttonText);
                }
            }
            if (intent.hasExtra(EXTRA_PREFS_SET_BACK_TEXT)) {
                buttonText = intent.getStringExtra(EXTRA_PREFS_SET_BACK_TEXT);
                if (TextUtils.isEmpty(buttonText)) {
                    backButton.setVisibility(8);
                } else {
                    backButton.setText((CharSequence) buttonText);
                }
            }
            if (intent.getBooleanExtra(EXTRA_PREFS_SHOW_SKIP, false)) {
                skipButton.setVisibility(0);
            }
        }
    }

    public boolean hasHeaders() {
        return getListView().getVisibility() == 0 && this.mPreferenceManager == null;
    }

    public List<Header> getHeaders() {
        return this.mHeaders;
    }

    public boolean isMultiPane() {
        return hasHeaders() && this.mPrefsContainer.getVisibility() == 0;
    }

    public boolean onIsMultiPane() {
        return getResources().getBoolean(17956870);
    }

    public boolean onIsHidingHeaders() {
        return getIntent().getBooleanExtra(EXTRA_NO_HEADERS, false);
    }

    public Header onGetInitialHeader() {
        for (int i = 0; i < this.mHeaders.size(); i += MSG_BIND_PREFERENCES) {
            Header h = (Header) this.mHeaders.get(i);
            if (h.fragment != null) {
                return h;
            }
        }
        throw new IllegalStateException("Must have at least one header with a fragment");
    }

    public Header onGetNewHeader() {
        return null;
    }

    public void onBuildHeaders(List<Header> list) {
    }

    public void invalidateHeaders() {
        if (!this.mHandler.hasMessages(MSG_BUILD_HEADERS)) {
            this.mHandler.sendEmptyMessage(MSG_BUILD_HEADERS);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void loadHeadersFromResource(int r18, java.util.List<android.preference.PreferenceActivity.Header> r19) {
        /*
        r17 = this;
        r10 = 0;
        r14 = r17.getResources();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r0 = r18;
        r10 = r14.getXml(r0);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r2 = android.util.Xml.asAttributeSet(r10);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
    L_0x000f:
        r13 = r10.next();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = 1;
        if (r13 == r14) goto L_0x0019;
    L_0x0016:
        r14 = 2;
        if (r13 != r14) goto L_0x000f;
    L_0x0019:
        r8 = r10.getName();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = "preference-headers";
        r14 = r14.equals(r8);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r14 != 0) goto L_0x005d;
    L_0x0026:
        r14 = new java.lang.RuntimeException;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r15 = new java.lang.StringBuilder;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r15.<init>();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r16 = "XML document must start with <preference-headers> tag; found";
        r15 = r15.append(r16);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r15 = r15.append(r8);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r16 = " at ";
        r15 = r15.append(r16);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r16 = r10.getPositionDescription();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r15 = r15.append(r16);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r15 = r15.toString();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14.<init>(r15);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        throw r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
    L_0x004d:
        r4 = move-exception;
        r14 = new java.lang.RuntimeException;	 Catch:{ all -> 0x0056 }
        r15 = "Error parsing headers";
        r14.<init>(r15, r4);	 Catch:{ all -> 0x0056 }
        throw r14;	 Catch:{ all -> 0x0056 }
    L_0x0056:
        r14 = move-exception;
        if (r10 == 0) goto L_0x005c;
    L_0x0059:
        r10.close();
    L_0x005c:
        throw r14;
    L_0x005d:
        r3 = 0;
        r9 = r10.getDepth();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
    L_0x0062:
        r13 = r10.next();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = 1;
        if (r13 == r14) goto L_0x0181;
    L_0x0069:
        r14 = 3;
        if (r13 != r14) goto L_0x0072;
    L_0x006c:
        r14 = r10.getDepth();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r14 <= r9) goto L_0x0181;
    L_0x0072:
        r14 = 3;
        if (r13 == r14) goto L_0x0062;
    L_0x0075:
        r14 = 4;
        if (r13 == r14) goto L_0x0062;
    L_0x0078:
        r8 = r10.getName();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = "header";
        r14 = r14.equals(r8);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r14 == 0) goto L_0x017c;
    L_0x0084:
        r5 = new android.preference.PreferenceActivity$Header;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.<init>();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = com.android.internal.R.styleable.PreferenceHeader;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r0 = r17;
        r11 = r0.obtainStyledAttributes(r2, r14);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = 1;
        r15 = -1;
        r14 = r11.getResourceId(r14, r15);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = (long) r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.id = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = 2;
        r12 = r11.peekValue(r14);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r12 == 0) goto L_0x00ae;
    L_0x00a1:
        r14 = r12.type;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r15 = 3;
        if (r14 != r15) goto L_0x00ae;
    L_0x00a6:
        r14 = r12.resourceId;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r14 == 0) goto L_0x013f;
    L_0x00aa:
        r14 = r12.resourceId;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.titleRes = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
    L_0x00ae:
        r14 = 3;
        r12 = r11.peekValue(r14);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r12 == 0) goto L_0x00c2;
    L_0x00b5:
        r14 = r12.type;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r15 = 3;
        if (r14 != r15) goto L_0x00c2;
    L_0x00ba:
        r14 = r12.resourceId;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r14 == 0) goto L_0x0145;
    L_0x00be:
        r14 = r12.resourceId;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.summaryRes = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
    L_0x00c2:
        r14 = 5;
        r12 = r11.peekValue(r14);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r12 == 0) goto L_0x00d6;
    L_0x00c9:
        r14 = r12.type;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r15 = 3;
        if (r14 != r15) goto L_0x00d6;
    L_0x00ce:
        r14 = r12.resourceId;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r14 == 0) goto L_0x014b;
    L_0x00d2:
        r14 = r12.resourceId;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.breadCrumbTitleRes = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
    L_0x00d6:
        r14 = 6;
        r12 = r11.peekValue(r14);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r12 == 0) goto L_0x00ea;
    L_0x00dd:
        r14 = r12.type;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r15 = 3;
        if (r14 != r15) goto L_0x00ea;
    L_0x00e2:
        r14 = r12.resourceId;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r14 == 0) goto L_0x0150;
    L_0x00e6:
        r14 = r12.resourceId;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.breadCrumbShortTitleRes = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
    L_0x00ea:
        r14 = 0;
        r15 = 0;
        r14 = r11.getResourceId(r14, r15);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.iconRes = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = 4;
        r14 = r11.getString(r14);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.fragment = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r11.recycle();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r3 != 0) goto L_0x0103;
    L_0x00fe:
        r3 = new android.os.Bundle;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r3.<init>();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
    L_0x0103:
        r6 = r10.getDepth();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
    L_0x0107:
        r13 = r10.next();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = 1;
        if (r13 == r14) goto L_0x016c;
    L_0x010e:
        r14 = 3;
        if (r13 != r14) goto L_0x0117;
    L_0x0111:
        r14 = r10.getDepth();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r14 <= r6) goto L_0x016c;
    L_0x0117:
        r14 = 3;
        if (r13 == r14) goto L_0x0107;
    L_0x011a:
        r14 = 4;
        if (r13 == r14) goto L_0x0107;
    L_0x011d:
        r7 = r10.getName();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = "extra";
        r14 = r7.equals(r14);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r14 == 0) goto L_0x0155;
    L_0x0129:
        r14 = r17.getResources();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r15 = "extra";
        r14.parseBundleExtra(r15, r2, r3);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        com.android.internal.util.XmlUtils.skipCurrentTag(r10);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        goto L_0x0107;
    L_0x0136:
        r4 = move-exception;
        r14 = new java.lang.RuntimeException;	 Catch:{ all -> 0x0056 }
        r15 = "Error parsing headers";
        r14.<init>(r15, r4);	 Catch:{ all -> 0x0056 }
        throw r14;	 Catch:{ all -> 0x0056 }
    L_0x013f:
        r14 = r12.string;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.title = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        goto L_0x00ae;
    L_0x0145:
        r14 = r12.string;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.summary = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        goto L_0x00c2;
    L_0x014b:
        r14 = r12.string;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.breadCrumbTitle = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        goto L_0x00d6;
    L_0x0150:
        r14 = r12.string;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.breadCrumbShortTitle = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        goto L_0x00ea;
    L_0x0155:
        r14 = "intent";
        r14 = r7.equals(r14);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r14 == 0) goto L_0x0168;
    L_0x015d:
        r14 = r17.getResources();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r14 = android.content.Intent.parseIntent(r14, r10, r2);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r5.intent = r14;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        goto L_0x0107;
    L_0x0168:
        com.android.internal.util.XmlUtils.skipCurrentTag(r10);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        goto L_0x0107;
    L_0x016c:
        r14 = r3.size();	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        if (r14 <= 0) goto L_0x0175;
    L_0x0172:
        r5.fragmentArguments = r3;	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        r3 = 0;
    L_0x0175:
        r0 = r19;
        r0.add(r5);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        goto L_0x0062;
    L_0x017c:
        com.android.internal.util.XmlUtils.skipCurrentTag(r10);	 Catch:{ XmlPullParserException -> 0x004d, IOException -> 0x0136 }
        goto L_0x0062;
    L_0x0181:
        if (r10 == 0) goto L_0x0186;
    L_0x0183:
        r10.close();
    L_0x0186:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.preference.PreferenceActivity.loadHeadersFromResource(int, java.util.List):void");
    }

    protected boolean isValidFragment(String fragmentName) {
        if (getApplicationInfo().targetSdkVersion < 19) {
            return true;
        }
        throw new RuntimeException("Subclasses of PreferenceActivity must override isValidFragment(String) to verify that the Fragment class is valid! " + getClass().getName() + " has not checked if fragment " + fragmentName + " is valid.");
    }

    public void setListFooter(View view) {
        this.mListFooter.removeAllViews();
        this.mListFooter.addView(view, new LayoutParams(-1, -2));
    }

    protected void onStop() {
        super.onStop();
        if (this.mPreferenceManager != null) {
            this.mPreferenceManager.dispatchActivityStop();
        }
    }

    protected void onDestroy() {
        this.mHandler.removeMessages(MSG_BIND_PREFERENCES);
        this.mHandler.removeMessages(MSG_BUILD_HEADERS);
        super.onDestroy();
        if (this.mPreferenceManager != null) {
            this.mPreferenceManager.dispatchActivityDestroy();
        }
    }

    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        if (this.mHeaders.size() > 0) {
            outState.putParcelableArrayList(HEADERS_TAG, this.mHeaders);
            if (this.mCurHeader != null) {
                int index = this.mHeaders.indexOf(this.mCurHeader);
                if (index >= 0) {
                    outState.putInt(CUR_HEADER_TAG, index);
                }
            }
        }
        if (this.mPreferenceManager != null) {
            PreferenceScreen preferenceScreen = getPreferenceScreen();
            if (preferenceScreen != null) {
                Bundle container = new Bundle();
                preferenceScreen.saveHierarchyState(container);
                outState.putBundle(PREFERENCES_TAG, container);
            }
        }
    }

    protected void onRestoreInstanceState(Bundle state) {
        if (this.mPreferenceManager != null) {
            Bundle container = state.getBundle(PREFERENCES_TAG);
            if (container != null) {
                PreferenceScreen preferenceScreen = getPreferenceScreen();
                if (preferenceScreen != null) {
                    preferenceScreen.restoreHierarchyState(container);
                    this.mSavedInstanceState = state;
                    return;
                }
            }
        }
        super.onRestoreInstanceState(state);
    }

    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (this.mPreferenceManager != null) {
            this.mPreferenceManager.dispatchActivityResult(requestCode, resultCode, data);
        }
    }

    public void onContentChanged() {
        super.onContentChanged();
        if (this.mPreferenceManager != null) {
            postBindPreferences();
        }
    }

    protected void onListItemClick(ListView l, View v, int position, long id) {
        if (isResumed()) {
            super.onListItemClick(l, v, position, id);
            if (this.mAdapter != null) {
                Object item = this.mAdapter.getItem(position);
                if (item instanceof Header) {
                    onHeaderClick((Header) item, position);
                }
            }
        }
    }

    public void onHeaderClick(Header header, int position) {
        if (header.fragment != null) {
            if (this.mSinglePane) {
                int titleRes = header.breadCrumbTitleRes;
                int shortTitleRes = header.breadCrumbShortTitleRes;
                if (titleRes == 0) {
                    titleRes = header.titleRes;
                    shortTitleRes = 0;
                }
                startWithFragment(header.fragment, header.fragmentArguments, null, 0, titleRes, shortTitleRes);
                return;
            }
            switchToHeader(header);
        } else if (header.intent != null) {
            startActivity(header.intent);
        }
    }

    public Intent onBuildStartFragmentIntent(String fragmentName, Bundle args, int titleRes, int shortTitleRes) {
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.setClass(this, getClass());
        intent.putExtra(EXTRA_SHOW_FRAGMENT, fragmentName);
        intent.putExtra(EXTRA_SHOW_FRAGMENT_ARGUMENTS, args);
        intent.putExtra(EXTRA_SHOW_FRAGMENT_TITLE, titleRes);
        intent.putExtra(EXTRA_SHOW_FRAGMENT_SHORT_TITLE, shortTitleRes);
        intent.putExtra(EXTRA_NO_HEADERS, true);
        return intent;
    }

    public void startWithFragment(String fragmentName, Bundle args, Fragment resultTo, int resultRequestCode) {
        startWithFragment(fragmentName, args, resultTo, resultRequestCode, 0, 0);
    }

    public void startWithFragment(String fragmentName, Bundle args, Fragment resultTo, int resultRequestCode, int titleRes, int shortTitleRes) {
        Intent intent = onBuildStartFragmentIntent(fragmentName, args, titleRes, shortTitleRes);
        if (resultTo == null) {
            startActivity(intent);
        } else {
            resultTo.startActivityForResult(intent, resultRequestCode);
        }
    }

    public void showBreadCrumbs(CharSequence title, CharSequence shortTitle) {
        if (this.mFragmentBreadCrumbs == null) {
            try {
                this.mFragmentBreadCrumbs = (FragmentBreadCrumbs) findViewById(C0000R.id.title);
                if (this.mFragmentBreadCrumbs != null) {
                    if (this.mSinglePane) {
                        this.mFragmentBreadCrumbs.setVisibility(8);
                        View bcSection = findViewById(16909022);
                        if (bcSection != null) {
                            bcSection.setVisibility(8);
                        }
                        setTitle(title);
                    }
                    this.mFragmentBreadCrumbs.setMaxVisible(MSG_BUILD_HEADERS);
                    this.mFragmentBreadCrumbs.setActivity(this);
                } else if (title != null) {
                    setTitle(title);
                    return;
                } else {
                    return;
                }
            } catch (ClassCastException e) {
                setTitle(title);
                return;
            }
        }
        if (this.mFragmentBreadCrumbs.getVisibility() != 0) {
            setTitle(title);
            return;
        }
        this.mFragmentBreadCrumbs.setTitle(title, shortTitle);
        this.mFragmentBreadCrumbs.setParentTitle(null, null, null);
    }

    public void setParentTitle(CharSequence title, CharSequence shortTitle, OnClickListener listener) {
        if (this.mFragmentBreadCrumbs != null) {
            this.mFragmentBreadCrumbs.setParentTitle(title, shortTitle, listener);
        }
    }

    void setSelectedHeader(Header header) {
        this.mCurHeader = header;
        int index = this.mHeaders.indexOf(header);
        if (index >= 0) {
            getListView().setItemChecked(index, true);
        } else {
            getListView().clearChoices();
        }
        showBreadCrumbs(header);
    }

    void showBreadCrumbs(Header header) {
        if (header != null) {
            CharSequence title = header.getBreadCrumbTitle(getResources());
            if (title == null) {
                title = header.getTitle(getResources());
            }
            if (title == null) {
                title = getTitle();
            }
            showBreadCrumbs(title, header.getBreadCrumbShortTitle(getResources()));
            return;
        }
        showBreadCrumbs(getTitle(), null);
    }

    private void switchToHeaderInner(String fragmentName, Bundle args) {
        getFragmentManager().popBackStack(BACK_STACK_PREFS, MSG_BIND_PREFERENCES);
        if (isValidFragment(fragmentName)) {
            Fragment f = Fragment.instantiate(this, fragmentName, args);
            FragmentTransaction transaction = getFragmentManager().beginTransaction();
            transaction.setTransition(GLES31.GL_TEXTURE_INTERNAL_FORMAT);
            transaction.replace(16909149, f);
            transaction.commitAllowingStateLoss();
            return;
        }
        throw new IllegalArgumentException("Invalid fragment for this activity: " + fragmentName);
    }

    public void switchToHeader(String fragmentName, Bundle args) {
        Header selectedHeader = null;
        for (int i = 0; i < this.mHeaders.size(); i += MSG_BIND_PREFERENCES) {
            if (fragmentName.equals(((Header) this.mHeaders.get(i)).fragment)) {
                selectedHeader = (Header) this.mHeaders.get(i);
                break;
            }
        }
        setSelectedHeader(selectedHeader);
        switchToHeaderInner(fragmentName, args);
    }

    public void switchToHeader(Header header) {
        if (this.mCurHeader == header) {
            getFragmentManager().popBackStack(BACK_STACK_PREFS, MSG_BIND_PREFERENCES);
        } else if (header.fragment == null) {
            throw new IllegalStateException("can't switch to header that has no fragment");
        } else {
            switchToHeaderInner(header.fragment, header.fragmentArguments);
            setSelectedHeader(header);
        }
    }

    Header findBestMatchingHeader(Header cur, ArrayList<Header> from) {
        int j;
        ArrayList<Header> matches = new ArrayList();
        for (j = 0; j < from.size(); j += MSG_BIND_PREFERENCES) {
            Header oh = (Header) from.get(j);
            if (cur == oh || (cur.id != HEADER_ID_UNDEFINED && cur.id == oh.id)) {
                matches.clear();
                matches.add(oh);
                break;
            }
            if (cur.fragment != null) {
                if (cur.fragment.equals(oh.fragment)) {
                    matches.add(oh);
                }
            } else if (cur.intent != null) {
                if (cur.intent.equals(oh.intent)) {
                    matches.add(oh);
                }
            } else if (cur.title != null && cur.title.equals(oh.title)) {
                matches.add(oh);
            }
        }
        int NM = matches.size();
        if (NM == MSG_BIND_PREFERENCES) {
            return (Header) matches.get(0);
        }
        if (NM > MSG_BIND_PREFERENCES) {
            for (j = 0; j < NM; j += MSG_BIND_PREFERENCES) {
                oh = (Header) matches.get(j);
                if (cur.fragmentArguments != null && cur.fragmentArguments.equals(oh.fragmentArguments)) {
                    return oh;
                }
                if (cur.extras != null && cur.extras.equals(oh.extras)) {
                    return oh;
                }
                if (cur.title != null && cur.title.equals(oh.title)) {
                    return oh;
                }
            }
        }
        return null;
    }

    public void startPreferenceFragment(Fragment fragment, boolean push) {
        FragmentTransaction transaction = getFragmentManager().beginTransaction();
        transaction.replace(16909149, fragment);
        if (push) {
            transaction.setTransition(GLES31.GL_TEXTURE_HEIGHT);
            transaction.addToBackStack(BACK_STACK_PREFS);
        } else {
            transaction.setTransition(GLES31.GL_TEXTURE_INTERNAL_FORMAT);
        }
        transaction.commitAllowingStateLoss();
    }

    public void startPreferencePanel(String fragmentClass, Bundle args, int titleRes, CharSequence titleText, Fragment resultTo, int resultRequestCode) {
        if (this.mSinglePane) {
            startWithFragment(fragmentClass, args, resultTo, resultRequestCode, titleRes, 0);
            return;
        }
        Fragment f = Fragment.instantiate(this, fragmentClass, args);
        if (resultTo != null) {
            f.setTargetFragment(resultTo, resultRequestCode);
        }
        FragmentTransaction transaction = getFragmentManager().beginTransaction();
        transaction.replace(16909149, f);
        if (titleRes != 0) {
            transaction.setBreadCrumbTitle(titleRes);
        } else if (titleText != null) {
            transaction.setBreadCrumbTitle(titleText);
        }
        transaction.setTransition(GLES31.GL_TEXTURE_HEIGHT);
        transaction.addToBackStack(BACK_STACK_PREFS);
        transaction.commitAllowingStateLoss();
    }

    public void finishPreferencePanel(Fragment caller, int resultCode, Intent resultData) {
        if (this.mSinglePane) {
            setResult(resultCode, resultData);
            finish();
            return;
        }
        onBackPressed();
        if (caller != null && caller.getTargetFragment() != null) {
            caller.getTargetFragment().onActivityResult(caller.getTargetRequestCode(), resultCode, resultData);
        }
    }

    public boolean onPreferenceStartFragment(PreferenceFragment caller, Preference pref) {
        startPreferencePanel(pref.getFragment(), pref.getExtras(), pref.getTitleRes(), pref.getTitle(), null, 0);
        return true;
    }

    private void postBindPreferences() {
        if (!this.mHandler.hasMessages(MSG_BIND_PREFERENCES)) {
            this.mHandler.obtainMessage(MSG_BIND_PREFERENCES).sendToTarget();
        }
    }

    private void bindPreferences() {
        PreferenceScreen preferenceScreen = getPreferenceScreen();
        if (preferenceScreen != null) {
            preferenceScreen.bind(getListView());
            if (this.mSavedInstanceState != null) {
                super.onRestoreInstanceState(this.mSavedInstanceState);
                this.mSavedInstanceState = null;
            }
        }
    }

    @Deprecated
    public PreferenceManager getPreferenceManager() {
        return this.mPreferenceManager;
    }

    private void requirePreferenceManager() {
        if (this.mPreferenceManager != null) {
            return;
        }
        if (this.mAdapter == null) {
            throw new RuntimeException("This should be called after super.onCreate.");
        }
        throw new RuntimeException("Modern two-pane PreferenceActivity requires use of a PreferenceFragment");
    }

    @Deprecated
    public void setPreferenceScreen(PreferenceScreen preferenceScreen) {
        requirePreferenceManager();
        if (this.mPreferenceManager.setPreferences(preferenceScreen) && preferenceScreen != null) {
            postBindPreferences();
            CharSequence title = getPreferenceScreen().getTitle();
            if (title != null) {
                setTitle(title);
            }
        }
    }

    @Deprecated
    public PreferenceScreen getPreferenceScreen() {
        if (this.mPreferenceManager != null) {
            return this.mPreferenceManager.getPreferenceScreen();
        }
        return null;
    }

    @Deprecated
    public void addPreferencesFromIntent(Intent intent) {
        requirePreferenceManager();
        setPreferenceScreen(this.mPreferenceManager.inflateFromIntent(intent, getPreferenceScreen()));
    }

    @Deprecated
    public void addPreferencesFromResource(int preferencesResId) {
        requirePreferenceManager();
        setPreferenceScreen(this.mPreferenceManager.inflateFromResource(this, preferencesResId, getPreferenceScreen()));
    }

    @Deprecated
    public boolean onPreferenceTreeClick(PreferenceScreen preferenceScreen, Preference preference) {
        return false;
    }

    @Deprecated
    public Preference findPreference(CharSequence key) {
        if (this.mPreferenceManager == null) {
            return null;
        }
        return this.mPreferenceManager.findPreference(key);
    }

    protected void onNewIntent(Intent intent) {
        if (this.mPreferenceManager != null) {
            this.mPreferenceManager.dispatchNewIntent(intent);
        }
    }

    protected boolean hasNextButton() {
        return this.mNextButton != null;
    }

    protected Button getNextButton() {
        return this.mNextButton;
    }
}
