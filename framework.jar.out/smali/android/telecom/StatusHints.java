package android.telecom;

import android.content.ComponentName;
import android.content.Context;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.Objects;

public final class StatusHints implements Parcelable {
    public static final Creator<StatusHints> CREATOR;
    private final Bundle mExtras;
    private final int mIconResId;
    private final CharSequence mLabel;
    private final ComponentName mPackageName;

    /* renamed from: android.telecom.StatusHints.1 */
    static class C07581 implements Creator<StatusHints> {
        C07581() {
        }

        public StatusHints createFromParcel(Parcel in) {
            return new StatusHints(null);
        }

        public StatusHints[] newArray(int size) {
            return new StatusHints[size];
        }
    }

    public StatusHints(ComponentName packageName, CharSequence label, int iconResId, Bundle extras) {
        this.mPackageName = packageName;
        this.mLabel = label;
        this.mIconResId = iconResId;
        this.mExtras = extras;
    }

    public ComponentName getPackageName() {
        return this.mPackageName;
    }

    public CharSequence getLabel() {
        return this.mLabel;
    }

    public int getIconResId() {
        return this.mIconResId;
    }

    public Drawable getIcon(Context context) {
        return getIcon(context, this.mIconResId);
    }

    public Bundle getExtras() {
        return this.mExtras;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeParcelable(this.mPackageName, flags);
        out.writeCharSequence(this.mLabel);
        out.writeInt(this.mIconResId);
        out.writeParcelable(this.mExtras, 0);
    }

    static {
        CREATOR = new C07581();
    }

    private StatusHints(Parcel in) {
        this.mPackageName = (ComponentName) in.readParcelable(getClass().getClassLoader());
        this.mLabel = in.readCharSequence();
        this.mIconResId = in.readInt();
        this.mExtras = (Bundle) in.readParcelable(getClass().getClassLoader());
    }

    private Drawable getIcon(Context context, int resId) {
        Drawable drawable = null;
        try {
            try {
                drawable = context.createPackageContext(this.mPackageName.getPackageName(), 0).getDrawable(resId);
            } catch (Throwable e) {
                Log.m5e((Object) this, e, "Cannot find icon %d in package %s", Integer.valueOf(resId), this.mPackageName.getPackageName());
            }
        } catch (Throwable e2) {
            Log.m5e((Object) this, e2, "Cannot find package %s", this.mPackageName.getPackageName());
        }
        return drawable;
    }

    public boolean equals(Object other) {
        if (other == null || !(other instanceof StatusHints)) {
            return false;
        }
        StatusHints otherHints = (StatusHints) other;
        if (Objects.equals(otherHints.getPackageName(), getPackageName()) && Objects.equals(otherHints.getLabel(), getLabel()) && otherHints.getIconResId() == getIconResId() && Objects.equals(otherHints.getExtras(), getExtras())) {
            return true;
        }
        return false;
    }

    public int hashCode() {
        return ((Objects.hashCode(this.mPackageName) + Objects.hashCode(this.mLabel)) + this.mIconResId) + Objects.hashCode(this.mExtras);
    }
}
