package android.widget;

import android.content.AsyncQueryHandler;
import android.content.ContentResolver;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Bundle;
import android.provider.ContactsContract.CommonDataKinds.Email;
import android.provider.ContactsContract.PhoneLookup;
import android.provider.ContactsContract.QuickContact;
import android.telephony.SubscriptionManager;
import android.util.AttributeSet;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import com.android.internal.R;

public class QuickContactBadge extends ImageView implements OnClickListener {
    static final int EMAIL_ID_COLUMN_INDEX = 0;
    static final String[] EMAIL_LOOKUP_PROJECTION;
    static final int EMAIL_LOOKUP_STRING_COLUMN_INDEX = 1;
    private static final String EXTRA_URI_CONTENT = "uri_content";
    static final int PHONE_ID_COLUMN_INDEX = 0;
    static final String[] PHONE_LOOKUP_PROJECTION;
    static final int PHONE_LOOKUP_STRING_COLUMN_INDEX = 1;
    private static final int TOKEN_EMAIL_LOOKUP = 0;
    private static final int TOKEN_EMAIL_LOOKUP_AND_TRIGGER = 2;
    private static final int TOKEN_PHONE_LOOKUP = 1;
    private static final int TOKEN_PHONE_LOOKUP_AND_TRIGGER = 3;
    private String mContactEmail;
    private String mContactPhone;
    private Uri mContactUri;
    private Drawable mDefaultAvatar;
    protected String[] mExcludeMimes;
    private Bundle mExtras;
    private Drawable mOverlay;
    private QueryHandler mQueryHandler;

    private class QueryHandler extends AsyncQueryHandler {
        public QueryHandler(ContentResolver cr) {
            super(cr);
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        protected void onQueryComplete(int r13, java.lang.Object r14, android.database.Cursor r15) {
            /*
            r12 = this;
            r6 = 0;
            r2 = 0;
            r7 = 0;
            if (r14 == 0) goto L_0x002f;
        L_0x0005:
            r14 = (android.os.Bundle) r14;
            r3 = r14;
        L_0x0008:
            switch(r13) {
                case 0: goto L_0x006c;
                case 1: goto L_0x0045;
                case 2: goto L_0x005c;
                case 3: goto L_0x0035;
                default: goto L_0x000b;
            };
        L_0x000b:
            if (r15 == 0) goto L_0x0010;
        L_0x000d:
            r15.close();
        L_0x0010:
            r8 = android.widget.QuickContactBadge.this;
            r8.mContactUri = r6;
            r8 = android.widget.QuickContactBadge.this;
            r8.onContactUriChanged();
            if (r7 == 0) goto L_0x008a;
        L_0x001c:
            if (r6 == 0) goto L_0x008a;
        L_0x001e:
            r8 = android.widget.QuickContactBadge.this;
            r8 = r8.getContext();
            r9 = android.widget.QuickContactBadge.this;
            r10 = 3;
            r11 = android.widget.QuickContactBadge.this;
            r11 = r11.mExcludeMimes;
            android.provider.ContactsContract.QuickContact.showQuickContact(r8, r9, r6, r10, r11);
        L_0x002e:
            return;
        L_0x002f:
            r3 = new android.os.Bundle;
            r3.<init>();
            goto L_0x0008;
        L_0x0035:
            r7 = 1;
            r8 = "tel";
            r9 = "uri_content";
            r9 = r3.getString(r9);	 Catch:{ all -> 0x0083 }
            r10 = 0;
            r2 = android.net.Uri.fromParts(r8, r9, r10);	 Catch:{ all -> 0x0083 }
        L_0x0045:
            if (r15 == 0) goto L_0x000b;
        L_0x0047:
            r8 = r15.moveToFirst();	 Catch:{ all -> 0x0083 }
            if (r8 == 0) goto L_0x000b;
        L_0x004d:
            r8 = 0;
            r0 = r15.getLong(r8);	 Catch:{ all -> 0x0083 }
            r8 = 1;
            r5 = r15.getString(r8);	 Catch:{ all -> 0x0083 }
            r6 = android.provider.ContactsContract.Contacts.getLookupUri(r0, r5);	 Catch:{ all -> 0x0083 }
            goto L_0x000b;
        L_0x005c:
            r7 = 1;
            r8 = "mailto";
            r9 = "uri_content";
            r9 = r3.getString(r9);	 Catch:{ all -> 0x0083 }
            r10 = 0;
            r2 = android.net.Uri.fromParts(r8, r9, r10);	 Catch:{ all -> 0x0083 }
        L_0x006c:
            if (r15 == 0) goto L_0x000b;
        L_0x006e:
            r8 = r15.moveToFirst();	 Catch:{ all -> 0x0083 }
            if (r8 == 0) goto L_0x000b;
        L_0x0074:
            r8 = 0;
            r0 = r15.getLong(r8);	 Catch:{ all -> 0x0083 }
            r8 = 1;
            r5 = r15.getString(r8);	 Catch:{ all -> 0x0083 }
            r6 = android.provider.ContactsContract.Contacts.getLookupUri(r0, r5);	 Catch:{ all -> 0x0083 }
            goto L_0x000b;
        L_0x0083:
            r8 = move-exception;
            if (r15 == 0) goto L_0x0089;
        L_0x0086:
            r15.close();
        L_0x0089:
            throw r8;
        L_0x008a:
            if (r2 == 0) goto L_0x002e;
        L_0x008c:
            r4 = new android.content.Intent;
            r8 = "com.android.contacts.action.SHOW_OR_CREATE_CONTACT";
            r4.<init>(r8, r2);
            if (r3 == 0) goto L_0x009e;
        L_0x0095:
            r8 = "uri_content";
            r3.remove(r8);
            r4.putExtras(r3);
        L_0x009e:
            r8 = android.widget.QuickContactBadge.this;
            r8 = r8.getContext();
            r8.startActivity(r4);
            goto L_0x002e;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.widget.QuickContactBadge.QueryHandler.onQueryComplete(int, java.lang.Object, android.database.Cursor):void");
        }
    }

    static {
        String[] strArr = new String[TOKEN_EMAIL_LOOKUP_AND_TRIGGER];
        strArr[TOKEN_EMAIL_LOOKUP] = "contact_id";
        strArr[TOKEN_PHONE_LOOKUP] = "lookup";
        EMAIL_LOOKUP_PROJECTION = strArr;
        strArr = new String[TOKEN_EMAIL_LOOKUP_AND_TRIGGER];
        strArr[TOKEN_EMAIL_LOOKUP] = SubscriptionManager.UNIQUE_KEY_SUBSCRIPTION_ID;
        strArr[TOKEN_PHONE_LOOKUP] = "lookup";
        PHONE_LOOKUP_PROJECTION = strArr;
    }

    public QuickContactBadge(Context context) {
        this(context, null);
    }

    public QuickContactBadge(Context context, AttributeSet attrs) {
        this(context, attrs, TOKEN_EMAIL_LOOKUP);
    }

    public QuickContactBadge(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, TOKEN_EMAIL_LOOKUP);
    }

    public QuickContactBadge(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mExtras = null;
        this.mExcludeMimes = null;
        TypedArray styledAttributes = this.mContext.obtainStyledAttributes(R.styleable.Theme);
        this.mOverlay = styledAttributes.getDrawable(284);
        styledAttributes.recycle();
        if (!isInEditMode()) {
            this.mQueryHandler = new QueryHandler(this.mContext.getContentResolver());
        }
        setOnClickListener(this);
    }

    protected void drawableStateChanged() {
        super.drawableStateChanged();
        if (this.mOverlay != null && this.mOverlay.isStateful()) {
            this.mOverlay.setState(getDrawableState());
            invalidate();
        }
    }

    public void drawableHotspotChanged(float x, float y) {
        super.drawableHotspotChanged(x, y);
        if (this.mOverlay != null) {
            this.mOverlay.setHotspot(x, y);
        }
    }

    public void setMode(int size) {
    }

    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        if (isEnabled() && this.mOverlay != null && this.mOverlay.getIntrinsicWidth() != 0 && this.mOverlay.getIntrinsicHeight() != 0) {
            this.mOverlay.setBounds(TOKEN_EMAIL_LOOKUP, TOKEN_EMAIL_LOOKUP, getWidth(), getHeight());
            if (this.mPaddingTop == 0 && this.mPaddingLeft == 0) {
                this.mOverlay.draw(canvas);
                return;
            }
            int saveCount = canvas.getSaveCount();
            canvas.save();
            canvas.translate((float) this.mPaddingLeft, (float) this.mPaddingTop);
            this.mOverlay.draw(canvas);
            canvas.restoreToCount(saveCount);
        }
    }

    private boolean isAssigned() {
        return (this.mContactUri == null && this.mContactEmail == null && this.mContactPhone == null) ? false : true;
    }

    public void setImageToDefault() {
        if (this.mDefaultAvatar == null) {
            this.mDefaultAvatar = this.mContext.getDrawable(17302341);
        }
        setImageDrawable(this.mDefaultAvatar);
    }

    public void assignContactUri(Uri contactUri) {
        this.mContactUri = contactUri;
        this.mContactEmail = null;
        this.mContactPhone = null;
        onContactUriChanged();
    }

    public void assignContactFromEmail(String emailAddress, boolean lazyLookup) {
        assignContactFromEmail(emailAddress, lazyLookup, null);
    }

    public void assignContactFromEmail(String emailAddress, boolean lazyLookup, Bundle extras) {
        this.mContactEmail = emailAddress;
        this.mExtras = extras;
        if (lazyLookup || this.mQueryHandler == null) {
            this.mContactUri = null;
            onContactUriChanged();
            return;
        }
        this.mQueryHandler.startQuery(TOKEN_EMAIL_LOOKUP, null, Uri.withAppendedPath(Email.CONTENT_LOOKUP_URI, Uri.encode(this.mContactEmail)), EMAIL_LOOKUP_PROJECTION, null, null, null);
    }

    public void assignContactFromPhone(String phoneNumber, boolean lazyLookup) {
        assignContactFromPhone(phoneNumber, lazyLookup, new Bundle());
    }

    public void assignContactFromPhone(String phoneNumber, boolean lazyLookup, Bundle extras) {
        this.mContactPhone = phoneNumber;
        this.mExtras = extras;
        if (lazyLookup || this.mQueryHandler == null) {
            this.mContactUri = null;
            onContactUriChanged();
            return;
        }
        this.mQueryHandler.startQuery(TOKEN_PHONE_LOOKUP, null, Uri.withAppendedPath(PhoneLookup.CONTENT_FILTER_URI, this.mContactPhone), PHONE_LOOKUP_PROJECTION, null, null, null);
    }

    public void setOverlay(Drawable overlay) {
        this.mOverlay = overlay;
    }

    private void onContactUriChanged() {
        setEnabled(isAssigned());
    }

    public void onClick(View v) {
        Bundle extras = this.mExtras == null ? new Bundle() : this.mExtras;
        if (this.mContactUri != null) {
            QuickContact.showQuickContact(getContext(), this, this.mContactUri, TOKEN_PHONE_LOOKUP_AND_TRIGGER, this.mExcludeMimes);
        } else if (this.mContactEmail != null && this.mQueryHandler != null) {
            extras.putString(EXTRA_URI_CONTENT, this.mContactEmail);
            this.mQueryHandler.startQuery(TOKEN_EMAIL_LOOKUP_AND_TRIGGER, extras, Uri.withAppendedPath(Email.CONTENT_LOOKUP_URI, Uri.encode(this.mContactEmail)), EMAIL_LOOKUP_PROJECTION, null, null, null);
        } else if (this.mContactPhone != null && this.mQueryHandler != null) {
            extras.putString(EXTRA_URI_CONTENT, this.mContactPhone);
            this.mQueryHandler.startQuery(TOKEN_PHONE_LOOKUP_AND_TRIGGER, extras, Uri.withAppendedPath(PhoneLookup.CONTENT_FILTER_URI, this.mContactPhone), PHONE_LOOKUP_PROJECTION, null, null, null);
        }
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(QuickContactBadge.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(QuickContactBadge.class.getName());
    }

    public void setExcludeMimes(String[] excludeMimes) {
        this.mExcludeMimes = excludeMimes;
    }
}
