package android.telecom;

import android.content.Context;
import android.content.pm.PackageManager.NameNotFoundException;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.TextUtils;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class PhoneAccount implements Parcelable {
    public static final int CAPABILITY_CALL_PROVIDER = 2;
    public static final int CAPABILITY_CONNECTION_MANAGER = 1;
    public static final int CAPABILITY_MULTI_USER = 32;
    public static final int CAPABILITY_PLACE_EMERGENCY_CALLS = 16;
    public static final int CAPABILITY_SIM_SUBSCRIPTION = 4;
    public static final int CAPABILITY_VIDEO_CALLING = 8;
    public static final Creator<PhoneAccount> CREATOR;
    public static final int NO_HIGHLIGHT_COLOR = 0;
    public static final int NO_ICON_TINT = 0;
    public static final int NO_RESOURCE_ID = -1;
    public static final String SCHEME_SIP = "sip";
    public static final String SCHEME_TEL = "tel";
    public static final String SCHEME_VOICEMAIL = "voicemail";
    private final PhoneAccountHandle mAccountHandle;
    private final Uri mAddress;
    private final int mCapabilities;
    private final int mHighlightColor;
    private final Bitmap mIconBitmap;
    private final String mIconPackageName;
    private final int mIconResId;
    private final int mIconTint;
    private final CharSequence mLabel;
    private final CharSequence mShortDescription;
    private final Uri mSubscriptionAddress;
    private final List<String> mSupportedUriSchemes;

    /* renamed from: android.telecom.PhoneAccount.1 */
    static class C07511 implements Creator<PhoneAccount> {
        C07511() {
        }

        public PhoneAccount createFromParcel(Parcel in) {
            return new PhoneAccount(null);
        }

        public PhoneAccount[] newArray(int size) {
            return new PhoneAccount[size];
        }
    }

    public static class Builder {
        private PhoneAccountHandle mAccountHandle;
        private Uri mAddress;
        private int mCapabilities;
        private int mHighlightColor;
        private Bitmap mIconBitmap;
        private String mIconPackageName;
        private int mIconResId;
        private int mIconTint;
        private CharSequence mLabel;
        private CharSequence mShortDescription;
        private Uri mSubscriptionAddress;
        private List<String> mSupportedUriSchemes;

        public Builder(PhoneAccountHandle accountHandle, CharSequence label) {
            this.mIconTint = PhoneAccount.NO_ICON_TINT;
            this.mHighlightColor = PhoneAccount.NO_ICON_TINT;
            this.mSupportedUriSchemes = new ArrayList();
            this.mAccountHandle = accountHandle;
            this.mLabel = label;
        }

        public Builder(PhoneAccount phoneAccount) {
            this.mIconTint = PhoneAccount.NO_ICON_TINT;
            this.mHighlightColor = PhoneAccount.NO_ICON_TINT;
            this.mSupportedUriSchemes = new ArrayList();
            this.mAccountHandle = phoneAccount.getAccountHandle();
            this.mAddress = phoneAccount.getAddress();
            this.mSubscriptionAddress = phoneAccount.getSubscriptionAddress();
            this.mCapabilities = phoneAccount.getCapabilities();
            this.mIconResId = phoneAccount.getIconResId();
            this.mIconPackageName = phoneAccount.getIconPackageName();
            this.mIconBitmap = phoneAccount.getIconBitmap();
            this.mIconTint = phoneAccount.getIconTint();
            this.mHighlightColor = phoneAccount.getHighlightColor();
            this.mLabel = phoneAccount.getLabel();
            this.mShortDescription = phoneAccount.getShortDescription();
            this.mSupportedUriSchemes.addAll(phoneAccount.getSupportedUriSchemes());
        }

        public Builder setAccountHandle(PhoneAccountHandle accountHandle) {
            this.mAccountHandle = accountHandle;
            return this;
        }

        public Builder setAddress(Uri value) {
            this.mAddress = value;
            return this;
        }

        public Builder setSubscriptionAddress(Uri value) {
            this.mSubscriptionAddress = value;
            return this;
        }

        public Builder setCapabilities(int value) {
            this.mCapabilities = value;
            return this;
        }

        public Builder setIcon(Context packageContext, int iconResId) {
            return setIcon(packageContext.getPackageName(), iconResId);
        }

        public Builder setIcon(String iconPackageName, int iconResId) {
            return setIcon(iconPackageName, iconResId, (int) PhoneAccount.NO_ICON_TINT);
        }

        public Builder setIcon(Context packageContext, int iconResId, int iconTint) {
            return setIcon(packageContext.getPackageName(), iconResId, iconTint);
        }

        public Builder setIcon(String iconPackageName, int iconResId, int iconTint) {
            this.mIconPackageName = iconPackageName;
            this.mIconResId = iconResId;
            this.mIconTint = iconTint;
            return this;
        }

        public Builder setIcon(Bitmap iconBitmap) {
            this.mIconBitmap = iconBitmap;
            this.mIconPackageName = null;
            this.mIconResId = PhoneAccount.NO_RESOURCE_ID;
            this.mIconTint = PhoneAccount.NO_ICON_TINT;
            return this;
        }

        public Builder setHighlightColor(int value) {
            this.mHighlightColor = value;
            return this;
        }

        public Builder setShortDescription(CharSequence value) {
            this.mShortDescription = value;
            return this;
        }

        public Builder addSupportedUriScheme(String uriScheme) {
            if (!(TextUtils.isEmpty(uriScheme) || this.mSupportedUriSchemes.contains(uriScheme))) {
                this.mSupportedUriSchemes.add(uriScheme);
            }
            return this;
        }

        public Builder setSupportedUriSchemes(List<String> uriSchemes) {
            this.mSupportedUriSchemes.clear();
            if (!(uriSchemes == null || uriSchemes.isEmpty())) {
                for (String uriScheme : uriSchemes) {
                    addSupportedUriScheme(uriScheme);
                }
            }
            return this;
        }

        public PhoneAccount build() {
            if (this.mSupportedUriSchemes.isEmpty()) {
                addSupportedUriScheme(PhoneAccount.SCHEME_TEL);
            }
            return new PhoneAccount(this.mAddress, this.mSubscriptionAddress, this.mCapabilities, this.mIconResId, this.mIconPackageName, this.mIconBitmap, this.mIconTint, this.mHighlightColor, this.mLabel, this.mShortDescription, this.mSupportedUriSchemes, null);
        }
    }

    private PhoneAccount(PhoneAccountHandle account, Uri address, Uri subscriptionAddress, int capabilities, int iconResId, String iconPackageName, Bitmap iconBitmap, int iconTint, int highlightColor, CharSequence label, CharSequence shortDescription, List<String> supportedUriSchemes) {
        this.mAccountHandle = account;
        this.mAddress = address;
        this.mSubscriptionAddress = subscriptionAddress;
        this.mCapabilities = capabilities;
        this.mIconResId = iconResId;
        this.mIconPackageName = iconPackageName;
        this.mIconBitmap = iconBitmap;
        this.mIconTint = iconTint;
        this.mHighlightColor = highlightColor;
        this.mLabel = label;
        this.mShortDescription = shortDescription;
        this.mSupportedUriSchemes = Collections.unmodifiableList(supportedUriSchemes);
    }

    public static Builder builder(PhoneAccountHandle accountHandle, CharSequence label) {
        return new Builder(accountHandle, label);
    }

    public Builder toBuilder() {
        return new Builder(this);
    }

    public PhoneAccountHandle getAccountHandle() {
        return this.mAccountHandle;
    }

    public Uri getAddress() {
        return this.mAddress;
    }

    public Uri getSubscriptionAddress() {
        return this.mSubscriptionAddress;
    }

    public int getCapabilities() {
        return this.mCapabilities;
    }

    public boolean hasCapabilities(int capability) {
        return (this.mCapabilities & capability) == capability;
    }

    public CharSequence getLabel() {
        return this.mLabel;
    }

    public CharSequence getShortDescription() {
        return this.mShortDescription;
    }

    public List<String> getSupportedUriSchemes() {
        return this.mSupportedUriSchemes;
    }

    public boolean supportsUriScheme(String uriScheme) {
        if (this.mSupportedUriSchemes == null || uriScheme == null) {
            return false;
        }
        for (String scheme : this.mSupportedUriSchemes) {
            if (scheme != null && scheme.equals(uriScheme)) {
                return true;
            }
        }
        return false;
    }

    public int getIconResId() {
        return this.mIconResId;
    }

    public String getIconPackageName() {
        return this.mIconPackageName;
    }

    public int getIconTint() {
        return this.mIconTint;
    }

    public Bitmap getIconBitmap() {
        return this.mIconBitmap;
    }

    public int getHighlightColor() {
        return this.mHighlightColor;
    }

    public Drawable createIconDrawable(Context context) {
        Object[] objArr;
        Throwable e;
        if (this.mIconBitmap != null) {
            return new BitmapDrawable(context.getResources(), this.mIconBitmap);
        }
        if (this.mIconResId != 0) {
            try {
            } catch (NameNotFoundException e2) {
                objArr = new Object[CAPABILITY_CONNECTION_MANAGER];
                objArr[NO_ICON_TINT] = this.mIconPackageName;
                Log.m11w((Object) this, "Cannot find package %s", objArr);
            }
            try {
                Drawable iconDrawable = context.createPackageContext(this.mIconPackageName, NO_ICON_TINT).getDrawable(this.mIconResId);
                if (this.mIconTint == 0) {
                    return iconDrawable;
                }
                iconDrawable.setTint(this.mIconTint);
                return iconDrawable;
            } catch (Throwable e3) {
                e = e3;
                objArr = new Object[CAPABILITY_CALL_PROVIDER];
                objArr[NO_ICON_TINT] = Integer.valueOf(this.mIconResId);
                objArr[CAPABILITY_CONNECTION_MANAGER] = this.mIconPackageName;
                Log.m5e((Object) this, e, "Cannot find icon %d in package %s", objArr);
                return new ColorDrawable((int) NO_ICON_TINT);
            } catch (Throwable e32) {
                e = e32;
                objArr = new Object[CAPABILITY_CALL_PROVIDER];
                objArr[NO_ICON_TINT] = Integer.valueOf(this.mIconResId);
                objArr[CAPABILITY_CONNECTION_MANAGER] = this.mIconPackageName;
                Log.m5e((Object) this, e, "Cannot find icon %d in package %s", objArr);
                return new ColorDrawable((int) NO_ICON_TINT);
            }
        }
        return new ColorDrawable((int) NO_ICON_TINT);
    }

    public int describeContents() {
        return NO_ICON_TINT;
    }

    public void writeToParcel(Parcel out, int flags) {
        if (this.mAccountHandle == null) {
            out.writeInt(NO_ICON_TINT);
        } else {
            out.writeInt(CAPABILITY_CONNECTION_MANAGER);
            this.mAccountHandle.writeToParcel(out, flags);
        }
        if (this.mAddress == null) {
            out.writeInt(NO_ICON_TINT);
        } else {
            out.writeInt(CAPABILITY_CONNECTION_MANAGER);
            this.mAddress.writeToParcel(out, flags);
        }
        if (this.mSubscriptionAddress == null) {
            out.writeInt(NO_ICON_TINT);
        } else {
            out.writeInt(CAPABILITY_CONNECTION_MANAGER);
            this.mSubscriptionAddress.writeToParcel(out, flags);
        }
        out.writeInt(this.mCapabilities);
        out.writeInt(this.mIconResId);
        out.writeString(this.mIconPackageName);
        if (this.mIconBitmap == null) {
            out.writeInt(NO_ICON_TINT);
        } else {
            out.writeInt(CAPABILITY_CONNECTION_MANAGER);
            this.mIconBitmap.writeToParcel(out, flags);
        }
        out.writeInt(this.mIconTint);
        out.writeInt(this.mHighlightColor);
        out.writeCharSequence(this.mLabel);
        out.writeCharSequence(this.mShortDescription);
        out.writeStringList(this.mSupportedUriSchemes);
    }

    static {
        CREATOR = new C07511();
    }

    private PhoneAccount(Parcel in) {
        if (in.readInt() > 0) {
            this.mAccountHandle = (PhoneAccountHandle) PhoneAccountHandle.CREATOR.createFromParcel(in);
        } else {
            this.mAccountHandle = null;
        }
        if (in.readInt() > 0) {
            this.mAddress = (Uri) Uri.CREATOR.createFromParcel(in);
        } else {
            this.mAddress = null;
        }
        if (in.readInt() > 0) {
            this.mSubscriptionAddress = (Uri) Uri.CREATOR.createFromParcel(in);
        } else {
            this.mSubscriptionAddress = null;
        }
        this.mCapabilities = in.readInt();
        this.mIconResId = in.readInt();
        this.mIconPackageName = in.readString();
        if (in.readInt() > 0) {
            this.mIconBitmap = (Bitmap) Bitmap.CREATOR.createFromParcel(in);
        } else {
            this.mIconBitmap = null;
        }
        this.mIconTint = in.readInt();
        this.mHighlightColor = in.readInt();
        this.mLabel = in.readCharSequence();
        this.mShortDescription = in.readCharSequence();
        this.mSupportedUriSchemes = Collections.unmodifiableList(in.createStringArrayList());
    }

    public String toString() {
        StringBuilder sb = new StringBuilder().append("[PhoneAccount: ").append(this.mAccountHandle).append(" Capabilities: ").append(this.mCapabilities).append(" Schemes: ");
        for (String scheme : this.mSupportedUriSchemes) {
            sb.append(scheme).append(" ");
        }
        sb.append("]");
        return sb.toString();
    }
}
