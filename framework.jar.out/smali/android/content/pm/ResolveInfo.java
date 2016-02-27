package android.content.pm;

import android.content.ComponentName;
import android.content.IntentFilter;
import android.graphics.drawable.Drawable;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.TextUtils;
import android.util.Printer;
import android.util.Slog;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.Toast;
import java.text.Collator;
import java.util.Comparator;

public class ResolveInfo implements Parcelable {
    public static final Creator<ResolveInfo> CREATOR;
    private static final String TAG = "ResolveInfo";
    public ActivityInfo activityInfo;
    public IntentFilter filter;
    public int icon;
    public boolean isDefault;
    public int labelRes;
    public int match;
    public boolean noResourceId;
    public CharSequence nonLocalizedLabel;
    public int preferredOrder;
    public int priority;
    public ProviderInfo providerInfo;
    public String resolvePackageName;
    public ServiceInfo serviceInfo;
    public int specificIndex;
    public boolean system;
    public int targetUserId;

    /* renamed from: android.content.pm.ResolveInfo.1 */
    static class C01421 implements Creator<ResolveInfo> {
        C01421() {
        }

        public ResolveInfo createFromParcel(Parcel source) {
            return new ResolveInfo(null);
        }

        public ResolveInfo[] newArray(int size) {
            return new ResolveInfo[size];
        }
    }

    public static class DisplayNameComparator implements Comparator<ResolveInfo> {
        private final Collator mCollator;
        private PackageManager mPM;

        public DisplayNameComparator(PackageManager pm) {
            this.mCollator = Collator.getInstance();
            this.mPM = pm;
            this.mCollator.setStrength(0);
        }

        public final int compare(ResolveInfo a, ResolveInfo b) {
            if (a.targetUserId != -2) {
                return 1;
            }
            if (b.targetUserId != -2) {
                return -1;
            }
            CharSequence sa = a.loadLabel(this.mPM);
            if (sa == null) {
                sa = a.activityInfo.name;
            }
            CharSequence sb = b.loadLabel(this.mPM);
            if (sb == null) {
                sb = b.activityInfo.name;
            }
            return this.mCollator.compare(sa.toString(), sb.toString());
        }
    }

    private ComponentInfo getComponentInfo() {
        if (this.activityInfo != null) {
            return this.activityInfo;
        }
        if (this.serviceInfo != null) {
            return this.serviceInfo;
        }
        if (this.providerInfo != null) {
            return this.providerInfo;
        }
        throw new IllegalStateException("Missing ComponentInfo!");
    }

    public CharSequence loadLabel(PackageManager pm) {
        if (this.nonLocalizedLabel != null) {
            return this.nonLocalizedLabel;
        }
        CharSequence label;
        if (!(this.resolvePackageName == null || this.labelRes == 0)) {
            label = pm.getText(this.resolvePackageName, this.labelRes, null);
            if (label != null) {
                return label.toString().trim();
            }
        }
        ComponentInfo ci = getComponentInfo();
        ApplicationInfo ai = ci.applicationInfo;
        if (this.labelRes != 0) {
            label = pm.getText(ci.packageName, this.labelRes, ai);
            if (label != null) {
                return label.toString().trim();
            }
        }
        CharSequence data = ci.loadLabel(pm);
        if (data != null) {
            return data.toString().trim();
        }
        return data;
    }

    public Drawable loadIcon(PackageManager pm) {
        Drawable dr;
        if (!(this.resolvePackageName == null || this.icon == 0)) {
            dr = pm.getDrawable(this.resolvePackageName, this.icon, null);
            if (dr != null) {
                return dr;
            }
        }
        ComponentInfo ci = getComponentInfo();
        ApplicationInfo ai = ci.applicationInfo;
        if (this.icon != 0) {
            dr = pm.getDrawable(ci.packageName, this.icon, ai);
            if (dr != null) {
                return dr;
            }
        }
        return ci.loadIcon(pm);
    }

    public final int getIconResource() {
        if (this.noResourceId) {
            return 0;
        }
        if (this.icon != 0) {
            return this.icon;
        }
        ComponentInfo ci = getComponentInfo();
        if (ci != null) {
            return ci.getIconResource();
        }
        return 0;
    }

    public void dump(Printer pw, String prefix) {
        if (this.filter != null) {
            pw.println(prefix + "Filter:");
            this.filter.dump(pw, prefix + "  ");
        }
        pw.println(prefix + "priority=" + this.priority + " preferredOrder=" + this.preferredOrder + " match=0x" + Integer.toHexString(this.match) + " specificIndex=" + this.specificIndex + " isDefault=" + this.isDefault);
        if (this.resolvePackageName != null) {
            pw.println(prefix + "resolvePackageName=" + this.resolvePackageName);
        }
        if (!(this.labelRes == 0 && this.nonLocalizedLabel == null && this.icon == 0)) {
            pw.println(prefix + "labelRes=0x" + Integer.toHexString(this.labelRes) + " nonLocalizedLabel=" + this.nonLocalizedLabel + " icon=0x" + Integer.toHexString(this.icon));
        }
        if (this.activityInfo != null) {
            pw.println(prefix + "ActivityInfo:");
            this.activityInfo.dump(pw, prefix + "  ");
        } else if (this.serviceInfo != null) {
            pw.println(prefix + "ServiceInfo:");
            this.serviceInfo.dump(pw, prefix + "  ");
        } else if (this.providerInfo != null) {
            pw.println(prefix + "ProviderInfo:");
            this.providerInfo.dump(pw, prefix + "  ");
        }
    }

    public ResolveInfo() {
        this.specificIndex = -1;
        this.targetUserId = -2;
    }

    public ResolveInfo(ResolveInfo orig) {
        this.specificIndex = -1;
        this.activityInfo = orig.activityInfo;
        this.serviceInfo = orig.serviceInfo;
        this.providerInfo = orig.providerInfo;
        this.filter = orig.filter;
        this.priority = orig.priority;
        this.preferredOrder = orig.preferredOrder;
        this.match = orig.match;
        this.specificIndex = orig.specificIndex;
        this.labelRes = orig.labelRes;
        this.nonLocalizedLabel = orig.nonLocalizedLabel;
        this.icon = orig.icon;
        this.resolvePackageName = orig.resolvePackageName;
        this.system = orig.system;
        this.targetUserId = orig.targetUserId;
    }

    public String toString() {
        ComponentInfo ci = getComponentInfo();
        StringBuilder sb = new StringBuilder(AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
        sb.append("ResolveInfo{");
        sb.append(Integer.toHexString(System.identityHashCode(this)));
        sb.append(' ');
        ComponentName.appendShortString(sb, ci.packageName, ci.name);
        if (this.priority != 0) {
            sb.append(" p=");
            sb.append(this.priority);
        }
        if (this.preferredOrder != 0) {
            sb.append(" o=");
            sb.append(this.preferredOrder);
        }
        sb.append(" m=0x");
        sb.append(Integer.toHexString(this.match));
        if (this.targetUserId != -2) {
            sb.append(" targetUserId=");
            sb.append(this.targetUserId);
        }
        sb.append('}');
        return sb.toString();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int parcelableFlags) {
        int i = 1;
        if (this.activityInfo != null) {
            dest.writeInt(1);
            this.activityInfo.writeToParcel(dest, parcelableFlags);
        } else if (this.serviceInfo != null) {
            dest.writeInt(2);
            this.serviceInfo.writeToParcel(dest, parcelableFlags);
        } else if (this.providerInfo != null) {
            dest.writeInt(3);
            this.providerInfo.writeToParcel(dest, parcelableFlags);
        } else {
            dest.writeInt(0);
        }
        if (this.filter != null) {
            dest.writeInt(1);
            this.filter.writeToParcel(dest, parcelableFlags);
        } else {
            dest.writeInt(0);
        }
        dest.writeInt(this.priority);
        dest.writeInt(this.preferredOrder);
        dest.writeInt(this.match);
        dest.writeInt(this.specificIndex);
        dest.writeInt(this.labelRes);
        TextUtils.writeToParcel(this.nonLocalizedLabel, dest, parcelableFlags);
        dest.writeInt(this.icon);
        dest.writeString(this.resolvePackageName);
        dest.writeInt(this.targetUserId);
        dest.writeInt(this.system ? 1 : 0);
        if (!this.noResourceId) {
            i = 0;
        }
        dest.writeInt(i);
    }

    static {
        CREATOR = new C01421();
    }

    private ResolveInfo(Parcel source) {
        boolean z = true;
        this.specificIndex = -1;
        this.activityInfo = null;
        this.serviceInfo = null;
        this.providerInfo = null;
        switch (source.readInt()) {
            case Toast.LENGTH_LONG /*1*/:
                this.activityInfo = (ActivityInfo) ActivityInfo.CREATOR.createFromParcel(source);
                break;
            case Action.MERGE_IGNORE /*2*/:
                this.serviceInfo = (ServiceInfo) ServiceInfo.CREATOR.createFromParcel(source);
                break;
            case SetDrawableParameters.TAG /*3*/:
                this.providerInfo = (ProviderInfo) ProviderInfo.CREATOR.createFromParcel(source);
                break;
            default:
                Slog.w(TAG, "Missing ComponentInfo!");
                break;
        }
        if (source.readInt() != 0) {
            this.filter = (IntentFilter) IntentFilter.CREATOR.createFromParcel(source);
        }
        this.priority = source.readInt();
        this.preferredOrder = source.readInt();
        this.match = source.readInt();
        this.specificIndex = source.readInt();
        this.labelRes = source.readInt();
        this.nonLocalizedLabel = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(source);
        this.icon = source.readInt();
        this.resolvePackageName = source.readString();
        this.targetUserId = source.readInt();
        this.system = source.readInt() != 0;
        if (source.readInt() == 0) {
            z = false;
        }
        this.noResourceId = z;
    }
}
