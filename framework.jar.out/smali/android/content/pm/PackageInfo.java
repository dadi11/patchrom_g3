package android.content.pm;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class PackageInfo implements Parcelable {
    public static final Creator<PackageInfo> CREATOR;
    public static final int INSTALL_LOCATION_AUTO = 0;
    public static final int INSTALL_LOCATION_INTERNAL_ONLY = 1;
    public static final int INSTALL_LOCATION_PREFER_EXTERNAL = 2;
    public static final int INSTALL_LOCATION_UNSPECIFIED = -1;
    public static final int REQUESTED_PERMISSION_GRANTED = 2;
    public static final int REQUESTED_PERMISSION_REQUIRED = 1;
    public ActivityInfo[] activities;
    public ApplicationInfo applicationInfo;
    public int baseRevisionCode;
    public ConfigurationInfo[] configPreferences;
    public boolean coreApp;
    public FeatureGroupInfo[] featureGroups;
    public long firstInstallTime;
    public int[] gids;
    public int installLocation;
    public InstrumentationInfo[] instrumentation;
    public long lastUpdateTime;
    public String overlayTarget;
    public String packageName;
    public PermissionInfo[] permissions;
    public ProviderInfo[] providers;
    public ActivityInfo[] receivers;
    public FeatureInfo[] reqFeatures;
    public String[] requestedPermissions;
    public int[] requestedPermissionsFlags;
    public String requiredAccountType;
    public boolean requiredForAllUsers;
    public String restrictedAccountType;
    public ServiceInfo[] services;
    public String sharedUserId;
    public int sharedUserLabel;
    public Signature[] signatures;
    public String[] splitNames;
    public int[] splitRevisionCodes;
    public int versionCode;
    public String versionName;

    /* renamed from: android.content.pm.PackageInfo.1 */
    static class C01271 implements Creator<PackageInfo> {
        C01271() {
        }

        public PackageInfo createFromParcel(Parcel source) {
            return new PackageInfo(null);
        }

        public PackageInfo[] newArray(int size) {
            return new PackageInfo[size];
        }
    }

    public PackageInfo() {
        this.installLocation = REQUESTED_PERMISSION_REQUIRED;
    }

    public String toString() {
        return "PackageInfo{" + Integer.toHexString(System.identityHashCode(this)) + " " + this.packageName + "}";
    }

    public int describeContents() {
        return INSTALL_LOCATION_AUTO;
    }

    public void writeToParcel(Parcel dest, int parcelableFlags) {
        int i = REQUESTED_PERMISSION_REQUIRED;
        dest.writeString(this.packageName);
        dest.writeStringArray(this.splitNames);
        dest.writeInt(this.versionCode);
        dest.writeString(this.versionName);
        dest.writeInt(this.baseRevisionCode);
        dest.writeIntArray(this.splitRevisionCodes);
        dest.writeString(this.sharedUserId);
        dest.writeInt(this.sharedUserLabel);
        if (this.applicationInfo != null) {
            dest.writeInt(REQUESTED_PERMISSION_REQUIRED);
            this.applicationInfo.writeToParcel(dest, parcelableFlags);
        } else {
            dest.writeInt(INSTALL_LOCATION_AUTO);
        }
        dest.writeLong(this.firstInstallTime);
        dest.writeLong(this.lastUpdateTime);
        dest.writeIntArray(this.gids);
        dest.writeTypedArray(this.activities, parcelableFlags);
        dest.writeTypedArray(this.receivers, parcelableFlags);
        dest.writeTypedArray(this.services, parcelableFlags);
        dest.writeTypedArray(this.providers, parcelableFlags);
        dest.writeTypedArray(this.instrumentation, parcelableFlags);
        dest.writeTypedArray(this.permissions, parcelableFlags);
        dest.writeStringArray(this.requestedPermissions);
        dest.writeIntArray(this.requestedPermissionsFlags);
        dest.writeTypedArray(this.signatures, parcelableFlags);
        dest.writeTypedArray(this.configPreferences, parcelableFlags);
        dest.writeTypedArray(this.reqFeatures, parcelableFlags);
        dest.writeTypedArray(this.featureGroups, parcelableFlags);
        dest.writeInt(this.installLocation);
        dest.writeInt(this.coreApp ? REQUESTED_PERMISSION_REQUIRED : INSTALL_LOCATION_AUTO);
        if (!this.requiredForAllUsers) {
            i = INSTALL_LOCATION_AUTO;
        }
        dest.writeInt(i);
        dest.writeString(this.restrictedAccountType);
        dest.writeString(this.requiredAccountType);
        dest.writeString(this.overlayTarget);
    }

    static {
        CREATOR = new C01271();
    }

    private PackageInfo(Parcel source) {
        boolean z = true;
        this.installLocation = REQUESTED_PERMISSION_REQUIRED;
        this.packageName = source.readString();
        this.splitNames = source.createStringArray();
        this.versionCode = source.readInt();
        this.versionName = source.readString();
        this.baseRevisionCode = source.readInt();
        this.splitRevisionCodes = source.createIntArray();
        this.sharedUserId = source.readString();
        this.sharedUserLabel = source.readInt();
        if (source.readInt() != 0) {
            this.applicationInfo = (ApplicationInfo) ApplicationInfo.CREATOR.createFromParcel(source);
        }
        this.firstInstallTime = source.readLong();
        this.lastUpdateTime = source.readLong();
        this.gids = source.createIntArray();
        this.activities = (ActivityInfo[]) source.createTypedArray(ActivityInfo.CREATOR);
        this.receivers = (ActivityInfo[]) source.createTypedArray(ActivityInfo.CREATOR);
        this.services = (ServiceInfo[]) source.createTypedArray(ServiceInfo.CREATOR);
        this.providers = (ProviderInfo[]) source.createTypedArray(ProviderInfo.CREATOR);
        this.instrumentation = (InstrumentationInfo[]) source.createTypedArray(InstrumentationInfo.CREATOR);
        this.permissions = (PermissionInfo[]) source.createTypedArray(PermissionInfo.CREATOR);
        this.requestedPermissions = source.createStringArray();
        this.requestedPermissionsFlags = source.createIntArray();
        this.signatures = (Signature[]) source.createTypedArray(Signature.CREATOR);
        this.configPreferences = (ConfigurationInfo[]) source.createTypedArray(ConfigurationInfo.CREATOR);
        this.reqFeatures = (FeatureInfo[]) source.createTypedArray(FeatureInfo.CREATOR);
        this.featureGroups = (FeatureGroupInfo[]) source.createTypedArray(FeatureGroupInfo.CREATOR);
        this.installLocation = source.readInt();
        this.coreApp = source.readInt() != 0;
        if (source.readInt() == 0) {
            z = false;
        }
        this.requiredForAllUsers = z;
        this.restrictedAccountType = source.readString();
        this.requiredAccountType = source.readString();
        this.overlayTarget = source.readString();
    }
}
