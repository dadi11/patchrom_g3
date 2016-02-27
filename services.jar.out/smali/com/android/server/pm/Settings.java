package com.android.server.pm;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.IntentFilter.AuthorityEntry;
import android.content.IntentFilter.MalformedMimeTypeException;
import android.content.pm.ActivityInfo;
import android.content.pm.ApplicationInfo;
import android.content.pm.ComponentInfo;
import android.content.pm.PackageCleanItem;
import android.content.pm.PackageParser.Package;
import android.content.pm.PackageUserState;
import android.content.pm.PermissionInfo;
import android.content.pm.ResolveInfo;
import android.content.pm.Signature;
import android.content.pm.UserInfo;
import android.content.pm.VerifierDeviceIdentity;
import android.net.Uri.Builder;
import android.os.Binder;
import android.os.Environment;
import android.os.FileUtils;
import android.os.PatternMatcher;
import android.os.UserHandle;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.Log;
import android.util.Slog;
import android.util.SparseArray;
import android.util.Xml;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.util.JournaledFile;
import com.android.internal.util.XmlUtils;
import com.android.server.voiceinteraction.DatabaseHelper.SoundModelContract;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Objects;
import libcore.io.IoUtils;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

final class Settings {
    private static final String ATTR_BLOCKED = "blocked";
    private static final String ATTR_BLOCK_UNINSTALL = "blockUninstall";
    private static final String ATTR_CODE = "code";
    private static final String ATTR_ENABLED = "enabled";
    private static final String ATTR_ENABLED_CALLER = "enabledCaller";
    private static final String ATTR_ENFORCEMENT = "enforcement";
    private static final String ATTR_HIDDEN = "hidden";
    private static final String ATTR_INSTALLED = "inst";
    private static final String ATTR_NAME = "name";
    private static final String ATTR_NOT_LAUNCHED = "nl";
    private static final String ATTR_STOPPED = "stopped";
    private static final String ATTR_USER = "user";
    private static final int CURRENT_DATABASE_VERSION = 3;
    private static final boolean DEBUG_MU = false;
    private static final boolean DEBUG_STOPPED = false;
    static final Object[] FLAG_DUMP_SPEC;
    private static final String TAG = "PackageSettings";
    static final String TAG_CROSS_PROFILE_INTENT_FILTERS = "crossProfile-intent-filters";
    private static final String TAG_DISABLED_COMPONENTS = "disabled-components";
    private static final String TAG_ENABLED_COMPONENTS = "enabled-components";
    private static final String TAG_ITEM = "item";
    private static final String TAG_PACKAGE = "pkg";
    private static final String TAG_PACKAGE_RESTRICTIONS = "package-restrictions";
    private static final String TAG_PERSISTENT_PREFERRED_ACTIVITIES = "persistent-preferred-activities";
    private static final String TAG_READ_EXTERNAL_STORAGE = "read-external-storage";
    private static int mFirstAvailableUid;
    private final File mBackupSettingsFilename;
    private final File mBackupStoppedPackagesFilename;
    final SparseArray<CrossProfileIntentResolver> mCrossProfileIntentResolvers;
    private final ArrayMap<String, PackageSetting> mDisabledSysPackages;
    int mExternalDatabaseVersion;
    int mExternalSdkPlatform;
    String mFingerprint;
    int mInternalDatabaseVersion;
    int mInternalSdkPlatform;
    public final KeySetManagerService mKeySetManagerService;
    private final SparseArray<Object> mOtherUserIds;
    private final File mPackageListFilename;
    final ArrayMap<String, PackageSetting> mPackages;
    final ArrayList<PackageCleanItem> mPackagesToBeCleaned;
    private final ArrayList<Signature> mPastSignatures;
    private final ArrayList<PendingPackage> mPendingPackages;
    final ArrayMap<String, BasePermission> mPermissionTrees;
    final ArrayMap<String, BasePermission> mPermissions;
    final SparseArray<PersistentPreferredIntentResolver> mPersistentPreferredActivities;
    final SparseArray<PreferredIntentResolver> mPreferredActivities;
    Boolean mReadExternalStorageEnforced;
    final StringBuilder mReadMessages;
    final ArrayMap<String, String> mRenamedPackages;
    private final File mSettingsFilename;
    final ArrayMap<String, SharedUserSetting> mSharedUsers;
    private final File mStoppedPackagesFilename;
    private final File mSystemDir;
    private final ArrayList<Object> mUserIds;
    private VerifierDeviceIdentity mVerifierDeviceIdentity;

    public static class DatabaseVersion {
        public static final int FIRST_VERSION = 1;
        public static final int SIGNATURE_END_ENTITY = 2;
        public static final int SIGNATURE_MALFORMED_RECOVER = 3;
    }

    static {
        mFirstAvailableUid = 0;
        FLAG_DUMP_SPEC = new Object[]{Integer.valueOf(1), "SYSTEM", Integer.valueOf(2), "DEBUGGABLE", Integer.valueOf(4), "HAS_CODE", Integer.valueOf(8), "PERSISTENT", Integer.valueOf(16), "FACTORY_TEST", Integer.valueOf(32), "ALLOW_TASK_REPARENTING", Integer.valueOf(64), "ALLOW_CLEAR_USER_DATA", Integer.valueOf(DumpState.DUMP_PROVIDERS), "UPDATED_SYSTEM_APP", Integer.valueOf(DumpState.DUMP_VERIFIERS), "TEST_ONLY", Integer.valueOf(16384), "VM_SAFE_MODE", Integer.valueOf(32768), "ALLOW_BACKUP", Integer.valueOf(65536), "KILL_AFTER_RESTORE", Integer.valueOf(131072), "RESTORE_ANY_VERSION", Integer.valueOf(262144), "EXTERNAL_STORAGE", Integer.valueOf(1048576), "LARGE_HEAP", Integer.valueOf(1073741824), "PRIVILEGED", Integer.valueOf(536870912), "FORWARD_LOCK", Integer.valueOf(268435456), "CANT_SAVE_STATE"};
    }

    Settings(Context context) {
        this(context, Environment.getDataDirectory());
    }

    Settings(Context context, File dataDir) {
        this.mPackages = new ArrayMap();
        this.mDisabledSysPackages = new ArrayMap();
        this.mPreferredActivities = new SparseArray();
        this.mPersistentPreferredActivities = new SparseArray();
        this.mCrossProfileIntentResolvers = new SparseArray();
        this.mSharedUsers = new ArrayMap();
        this.mUserIds = new ArrayList();
        this.mOtherUserIds = new SparseArray();
        this.mPastSignatures = new ArrayList();
        this.mPermissions = new ArrayMap();
        this.mPermissionTrees = new ArrayMap();
        this.mPackagesToBeCleaned = new ArrayList();
        this.mRenamedPackages = new ArrayMap();
        this.mReadMessages = new StringBuilder();
        this.mPendingPackages = new ArrayList();
        this.mKeySetManagerService = new KeySetManagerService(this.mPackages);
        this.mSystemDir = new File(dataDir, "system");
        this.mSystemDir.mkdirs();
        FileUtils.setPermissions(this.mSystemDir.toString(), 509, -1, -1);
        this.mSettingsFilename = new File(this.mSystemDir, "packages.xml");
        this.mBackupSettingsFilename = new File(this.mSystemDir, "packages-backup.xml");
        this.mPackageListFilename = new File(this.mSystemDir, "packages.list");
        FileUtils.setPermissions(this.mPackageListFilename, 416, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, 1032);
        this.mStoppedPackagesFilename = new File(this.mSystemDir, "packages-stopped.xml");
        this.mBackupStoppedPackagesFilename = new File(this.mSystemDir, "packages-stopped-backup.xml");
    }

    PackageSetting getPackageLPw(Package pkg, PackageSetting origPackage, String realName, SharedUserSetting sharedUser, File codePath, File resourcePath, String legacyNativeLibraryPathString, String primaryCpuAbi, String secondaryCpuAbi, int pkgFlags, UserHandle user, boolean add) {
        return getPackageLPw(pkg.packageName, origPackage, realName, sharedUser, codePath, resourcePath, legacyNativeLibraryPathString, primaryCpuAbi, secondaryCpuAbi, pkg.mVersionCode, pkgFlags, user, add, true);
    }

    PackageSetting peekPackageLPr(String name) {
        return (PackageSetting) this.mPackages.get(name);
    }

    void setInstallStatus(String pkgName, int status) {
        PackageSetting p = (PackageSetting) this.mPackages.get(pkgName);
        if (p != null && p.getInstallStatus() != status) {
            p.setInstallStatus(status);
        }
    }

    void setInstallerPackageName(String pkgName, String installerPkgName) {
        PackageSetting p = (PackageSetting) this.mPackages.get(pkgName);
        if (p != null) {
            p.setInstallerPackageName(installerPkgName);
        }
    }

    SharedUserSetting getSharedUserLPw(String name, int pkgFlags, boolean create) {
        SharedUserSetting s = (SharedUserSetting) this.mSharedUsers.get(name);
        if (s == null) {
            if (!create) {
                return null;
            }
            s = new SharedUserSetting(name, pkgFlags);
            s.userId = newUserIdLPw(s);
            Log.i("PackageManager", "New shared user " + name + ": id=" + s.userId);
            if (s.userId >= 0) {
                this.mSharedUsers.put(name, s);
            }
        }
        return s;
    }

    Collection<SharedUserSetting> getAllSharedUsersLPw() {
        return this.mSharedUsers.values();
    }

    boolean disableSystemPackageLPw(String name) {
        PackageSetting p = (PackageSetting) this.mPackages.get(name);
        if (p == null) {
            Log.w("PackageManager", "Package:" + name + " is not an installed package");
            return DEBUG_STOPPED;
        } else if (((PackageSetting) this.mDisabledSysPackages.get(name)) != null) {
            return DEBUG_STOPPED;
        } else {
            if (!(p.pkg == null || p.pkg.applicationInfo == null)) {
                ApplicationInfo applicationInfo = p.pkg.applicationInfo;
                applicationInfo.flags |= DumpState.DUMP_PROVIDERS;
            }
            this.mDisabledSysPackages.put(name, p);
            replacePackageLPw(name, new PackageSetting(p));
            return true;
        }
    }

    PackageSetting enableSystemPackageLPw(String name) {
        PackageSetting p = (PackageSetting) this.mDisabledSysPackages.get(name);
        if (p == null) {
            Log.w("PackageManager", "Package:" + name + " is not disabled");
            return null;
        }
        if (!(p.pkg == null || p.pkg.applicationInfo == null)) {
            ApplicationInfo applicationInfo = p.pkg.applicationInfo;
            applicationInfo.flags &= -129;
        }
        PackageSetting ret = addPackageLPw(name, p.realName, p.codePath, p.resourcePath, p.legacyNativeLibraryPathString, p.primaryCpuAbiString, p.secondaryCpuAbiString, p.secondaryCpuAbiString, p.appId, p.versionCode, p.pkgFlags);
        this.mDisabledSysPackages.remove(name);
        return ret;
    }

    boolean isDisabledSystemPackageLPr(String name) {
        return this.mDisabledSysPackages.containsKey(name);
    }

    void removeDisabledSystemPackageLPw(String name) {
        this.mDisabledSysPackages.remove(name);
    }

    PackageSetting addPackageLPw(String name, String realName, File codePath, File resourcePath, String legacyNativeLibraryPathString, String primaryCpuAbiString, String secondaryCpuAbiString, String cpuAbiOverrideString, int uid, int vc, int pkgFlags) {
        PackageSetting p = (PackageSetting) this.mPackages.get(name);
        if (p == null) {
            p = new PackageSetting(name, realName, codePath, resourcePath, legacyNativeLibraryPathString, primaryCpuAbiString, secondaryCpuAbiString, cpuAbiOverrideString, vc, pkgFlags);
            p.appId = uid;
            if (!addUserIdLPw(uid, p, name)) {
                return null;
            }
            this.mPackages.put(name, p);
            return p;
        } else if (p.appId == uid) {
            return p;
        } else {
            PackageManagerService.reportSettingsProblem(6, "Adding duplicate package, keeping first: " + name);
            return null;
        }
    }

    SharedUserSetting addSharedUserLPw(String name, int uid, int pkgFlags) {
        SharedUserSetting s = (SharedUserSetting) this.mSharedUsers.get(name);
        if (s == null) {
            s = new SharedUserSetting(name, pkgFlags);
            s.userId = uid;
            if (!addUserIdLPw(uid, s, name)) {
                return null;
            }
            this.mSharedUsers.put(name, s);
            return s;
        } else if (s.userId == uid) {
            return s;
        } else {
            PackageManagerService.reportSettingsProblem(6, "Adding duplicate shared user, keeping first: " + name);
            return null;
        }
    }

    void pruneSharedUsersLPw() {
        ArrayList<String> removeStage = new ArrayList();
        for (Entry<String, SharedUserSetting> entry : this.mSharedUsers.entrySet()) {
            SharedUserSetting sus = (SharedUserSetting) entry.getValue();
            if (sus == null || sus.packages.size() == 0) {
                removeStage.add(entry.getKey());
            }
        }
        for (int i = 0; i < removeStage.size(); i++) {
            this.mSharedUsers.remove(removeStage.get(i));
        }
    }

    void transferPermissionsLPw(String origPkg, String newPkg) {
        int i = 0;
        while (i < 2) {
            for (BasePermission bp : (i == 0 ? this.mPermissionTrees : this.mPermissions).values()) {
                if (origPkg.equals(bp.sourcePackage)) {
                    bp.sourcePackage = newPkg;
                    bp.packageSetting = null;
                    bp.perm = null;
                    if (bp.pendingInfo != null) {
                        bp.pendingInfo.packageName = newPkg;
                    }
                    bp.uid = 0;
                    bp.gids = null;
                }
            }
            i++;
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private com.android.server.pm.PackageSetting getPackageLPw(java.lang.String r25, com.android.server.pm.PackageSetting r26, java.lang.String r27, com.android.server.pm.SharedUserSetting r28, java.io.File r29, java.io.File r30, java.lang.String r31, java.lang.String r32, java.lang.String r33, int r34, int r35, android.os.UserHandle r36, boolean r37, boolean r38) {
        /*
        r24 = this;
        r0 = r24;
        r5 = r0.mPackages;
        r0 = r25;
        r4 = r5.get(r0);
        r4 = (com.android.server.pm.PackageSetting) r4;
        r22 = com.android.server.pm.UserManagerService.getInstance();
        if (r4 == 0) goto L_0x009a;
    L_0x0012:
        r0 = r32;
        r4.primaryCpuAbiString = r0;
        r0 = r33;
        r4.secondaryCpuAbiString = r0;
        r5 = r4.codePath;
        r0 = r29;
        r5 = r5.equals(r0);
        if (r5 != 0) goto L_0x0052;
    L_0x0024:
        r5 = r4.pkgFlags;
        r5 = r5 & 1;
        if (r5 == 0) goto L_0x0114;
    L_0x002a:
        r5 = "PackageManager";
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r8 = "Trying to update system app code path from ";
        r6 = r6.append(r8);
        r8 = r4.codePathString;
        r6 = r6.append(r8);
        r8 = " to ";
        r6 = r6.append(r8);
        r8 = r29.toString();
        r6 = r6.append(r8);
        r6 = r6.toString();
        android.util.Slog.w(r5, r6);
    L_0x0052:
        r5 = r4.sharedUser;
        r0 = r28;
        if (r5 == r0) goto L_0x015a;
    L_0x0058:
        r6 = 5;
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r8 = "Package ";
        r5 = r5.append(r8);
        r0 = r25;
        r5 = r5.append(r0);
        r8 = " shared user changed from ";
        r8 = r5.append(r8);
        r5 = r4.sharedUser;
        if (r5 == 0) goto L_0x0152;
    L_0x0074:
        r5 = r4.sharedUser;
        r5 = r5.name;
    L_0x0078:
        r5 = r8.append(r5);
        r8 = " to ";
        r8 = r5.append(r8);
        if (r28 == 0) goto L_0x0156;
    L_0x0084:
        r0 = r28;
        r5 = r0.name;
    L_0x0088:
        r5 = r8.append(r5);
        r8 = "; replacing with new";
        r5 = r5.append(r8);
        r5 = r5.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r6, r5);
        r4 = 0;
    L_0x009a:
        if (r4 != 0) goto L_0x0277;
    L_0x009c:
        if (r26 == 0) goto L_0x0167;
    L_0x009e:
        r4 = new com.android.server.pm.PackageSetting;
        r0 = r26;
        r5 = r0.name;
        r12 = 0;
        r6 = r25;
        r7 = r29;
        r8 = r30;
        r9 = r31;
        r10 = r32;
        r11 = r33;
        r13 = r34;
        r14 = r35;
        r4.<init>(r5, r6, r7, r8, r9, r10, r11, r12, r13, r14);
        r0 = r4.signatures;
        r18 = r0;
        r0 = r26;
        r4.copyFrom(r0);
        r0 = r18;
        r4.signatures = r0;
        r0 = r26;
        r5 = r0.sharedUser;
        r4.sharedUser = r5;
        r0 = r26;
        r5 = r0.appId;
        r4.appId = r5;
        r0 = r26;
        r4.origPackage = r0;
        r0 = r24;
        r5 = r0.mRenamedPackages;
        r0 = r26;
        r6 = r0.name;
        r0 = r25;
        r5.put(r0, r6);
        r0 = r26;
        r0 = r0.name;
        r25 = r0;
        r8 = r29.lastModified();
        r4.setTimeStamp(r8);
    L_0x00ef:
        r5 = r4.appId;
        if (r5 >= 0) goto L_0x0269;
    L_0x00f3:
        r5 = 5;
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r8 = "Package ";
        r6 = r6.append(r8);
        r0 = r25;
        r6 = r6.append(r0);
        r8 = " could not be assigned a valid uid";
        r6 = r6.append(r8);
        r6 = r6.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r5, r6);
        r5 = 0;
    L_0x0113:
        return r5;
    L_0x0114:
        r5 = "PackageManager";
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r8 = "Package ";
        r6 = r6.append(r8);
        r0 = r25;
        r6 = r6.append(r0);
        r8 = " codePath changed from ";
        r6 = r6.append(r8);
        r8 = r4.codePath;
        r6 = r6.append(r8);
        r8 = " to ";
        r6 = r6.append(r8);
        r0 = r29;
        r6 = r6.append(r0);
        r8 = "; Retaining data and using new";
        r6 = r6.append(r8);
        r6 = r6.toString();
        android.util.Slog.i(r5, r6);
        r0 = r31;
        r4.legacyNativeLibraryPathString = r0;
        goto L_0x0052;
    L_0x0152:
        r5 = "<nothing>";
        goto L_0x0078;
    L_0x0156:
        r5 = "<nothing>";
        goto L_0x0088;
    L_0x015a:
        r5 = 1073741825; // 0x40000001 float:2.0000002 double:5.30498948E-315;
        r19 = r35 & r5;
        r5 = r4.pkgFlags;
        r5 = r5 | r19;
        r4.pkgFlags = r5;
        goto L_0x009a;
    L_0x0167:
        r4 = new com.android.server.pm.PackageSetting;
        r12 = 0;
        r5 = r25;
        r6 = r27;
        r7 = r29;
        r8 = r30;
        r9 = r31;
        r10 = r32;
        r11 = r33;
        r13 = r34;
        r14 = r35;
        r4.<init>(r5, r6, r7, r8, r9, r10, r11, r12, r13, r14);
        r8 = r29.lastModified();
        r4.setTimeStamp(r8);
        r0 = r28;
        r4.sharedUser = r0;
        r5 = r35 & 1;
        if (r5 != 0) goto L_0x01e8;
    L_0x018e:
        r23 = r24.getAllUsers();
        if (r36 == 0) goto L_0x01e3;
    L_0x0194:
        r17 = r36.getIdentifier();
    L_0x0198:
        if (r23 == 0) goto L_0x01e8;
    L_0x019a:
        if (r38 == 0) goto L_0x01e8;
    L_0x019c:
        r16 = r23.iterator();
    L_0x01a0:
        r5 = r16.hasNext();
        if (r5 == 0) goto L_0x01e8;
    L_0x01a6:
        r20 = r16.next();
        r20 = (android.content.pm.UserInfo) r20;
        if (r36 == 0) goto L_0x01c9;
    L_0x01ae:
        r5 = -1;
        r0 = r17;
        if (r0 != r5) goto L_0x01c1;
    L_0x01b3:
        r0 = r20;
        r5 = r0.id;
        r0 = r24;
        r1 = r22;
        r5 = r0.isAdbInstallDisallowed(r1, r5);
        if (r5 == 0) goto L_0x01c9;
    L_0x01c1:
        r0 = r20;
        r5 = r0.id;
        r0 = r17;
        if (r0 != r5) goto L_0x01e6;
    L_0x01c9:
        r7 = 1;
    L_0x01ca:
        r0 = r20;
        r5 = r0.id;
        r6 = 0;
        r8 = 1;
        r9 = 1;
        r10 = 0;
        r11 = 0;
        r12 = 0;
        r13 = 0;
        r14 = 0;
        r4.setUserState(r5, r6, r7, r8, r9, r10, r11, r12, r13, r14);
        r0 = r20;
        r5 = r0.id;
        r0 = r24;
        r0.writePackageRestrictionsLPr(r5);
        goto L_0x01a0;
    L_0x01e3:
        r17 = 0;
        goto L_0x0198;
    L_0x01e6:
        r7 = 0;
        goto L_0x01ca;
    L_0x01e8:
        if (r28 == 0) goto L_0x01f2;
    L_0x01ea:
        r0 = r28;
        r5 = r0.userId;
        r4.appId = r5;
        goto L_0x00ef;
    L_0x01f2:
        r0 = r24;
        r5 = r0.mDisabledSysPackages;
        r0 = r25;
        r15 = r5.get(r0);
        r15 = (com.android.server.pm.PackageSetting) r15;
        if (r15 == 0) goto L_0x025f;
    L_0x0200:
        r5 = r15.signatures;
        r5 = r5.mSignatures;
        if (r5 == 0) goto L_0x0214;
    L_0x0206:
        r6 = r4.signatures;
        r5 = r15.signatures;
        r5 = r5.mSignatures;
        r5 = r5.clone();
        r5 = (android.content.pm.Signature[]) r5;
        r6.mSignatures = r5;
    L_0x0214:
        r5 = r15.appId;
        r4.appId = r5;
        r5 = new android.util.ArraySet;
        r6 = r15.grantedPermissions;
        r5.<init>(r6);
        r4.grantedPermissions = r5;
        r23 = r24.getAllUsers();
        if (r23 == 0) goto L_0x0254;
    L_0x0227:
        r16 = r23.iterator();
    L_0x022b:
        r5 = r16.hasNext();
        if (r5 == 0) goto L_0x0254;
    L_0x0231:
        r20 = r16.next();
        r20 = (android.content.pm.UserInfo) r20;
        r0 = r20;
        r0 = r0.id;
        r21 = r0;
        r0 = r21;
        r5 = r15.getDisabledComponents(r0);
        r0 = r21;
        r4.setDisabledComponentsCopy(r5, r0);
        r0 = r21;
        r5 = r15.getEnabledComponents(r0);
        r0 = r21;
        r4.setEnabledComponentsCopy(r5, r0);
        goto L_0x022b;
    L_0x0254:
        r5 = r4.appId;
        r0 = r24;
        r1 = r25;
        r0.addUserIdLPw(r5, r4, r1);
        goto L_0x00ef;
    L_0x025f:
        r0 = r24;
        r5 = r0.newUserIdLPw(r4);
        r4.appId = r5;
        goto L_0x00ef;
    L_0x0269:
        if (r37 == 0) goto L_0x0274;
    L_0x026b:
        r0 = r24;
        r1 = r25;
        r2 = r28;
        r0.addPackageSettingLPw(r4, r1, r2);
    L_0x0274:
        r5 = r4;
        goto L_0x0113;
    L_0x0277:
        if (r36 == 0) goto L_0x0274;
    L_0x0279:
        if (r38 == 0) goto L_0x0274;
    L_0x027b:
        r23 = r24.getAllUsers();
        if (r23 == 0) goto L_0x0274;
    L_0x0281:
        r16 = r23.iterator();
    L_0x0285:
        r5 = r16.hasNext();
        if (r5 == 0) goto L_0x0274;
    L_0x028b:
        r20 = r16.next();
        r20 = (android.content.pm.UserInfo) r20;
        r5 = r36.getIdentifier();
        r6 = -1;
        if (r5 != r6) goto L_0x02a6;
    L_0x0298:
        r0 = r20;
        r5 = r0.id;
        r0 = r24;
        r1 = r22;
        r5 = r0.isAdbInstallDisallowed(r1, r5);
        if (r5 == 0) goto L_0x02b0;
    L_0x02a6:
        r5 = r36.getIdentifier();
        r0 = r20;
        r6 = r0.id;
        if (r5 != r6) goto L_0x0285;
    L_0x02b0:
        r0 = r20;
        r5 = r0.id;
        r7 = r4.getInstalled(r5);
        if (r7 != 0) goto L_0x0285;
    L_0x02ba:
        r5 = 1;
        r0 = r20;
        r6 = r0.id;
        r4.setInstalled(r5, r6);
        r0 = r20;
        r5 = r0.id;
        r0 = r24;
        r0.writePackageRestrictionsLPr(r5);
        goto L_0x0285;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.Settings.getPackageLPw(java.lang.String, com.android.server.pm.PackageSetting, java.lang.String, com.android.server.pm.SharedUserSetting, java.io.File, java.io.File, java.lang.String, java.lang.String, java.lang.String, int, int, android.os.UserHandle, boolean, boolean):com.android.server.pm.PackageSetting");
    }

    boolean isAdbInstallDisallowed(UserManagerService userManager, int userId) {
        return userManager.hasUserRestriction("no_debugging_features", userId);
    }

    void insertPackageSettingLPw(PackageSetting p, Package pkg) {
        p.pkg = pkg;
        String codePath = pkg.applicationInfo.getCodePath();
        String resourcePath = pkg.applicationInfo.getResourcePath();
        String legacyNativeLibraryPath = pkg.applicationInfo.nativeLibraryRootDir;
        if (!Objects.equals(codePath, p.codePathString)) {
            Slog.w("PackageManager", "Code path for pkg : " + p.pkg.packageName + " changing from " + p.codePathString + " to " + codePath);
            p.codePath = new File(codePath);
            p.codePathString = codePath;
        }
        if (!Objects.equals(resourcePath, p.resourcePathString)) {
            Slog.w("PackageManager", "Resource path for pkg : " + p.pkg.packageName + " changing from " + p.resourcePathString + " to " + resourcePath);
            p.resourcePath = new File(resourcePath);
            p.resourcePathString = resourcePath;
        }
        if (!Objects.equals(legacyNativeLibraryPath, p.legacyNativeLibraryPathString)) {
            p.legacyNativeLibraryPathString = legacyNativeLibraryPath;
        }
        p.primaryCpuAbiString = pkg.applicationInfo.primaryCpuAbi;
        p.secondaryCpuAbiString = pkg.applicationInfo.secondaryCpuAbi;
        p.cpuAbiOverrideString = pkg.cpuAbiOverride;
        if (pkg.mVersionCode != p.versionCode) {
            p.versionCode = pkg.mVersionCode;
        }
        if (p.signatures.mSignatures == null) {
            p.signatures.assignSignatures(pkg.mSignatures);
        }
        if (pkg.applicationInfo.flags != p.pkgFlags) {
            p.pkgFlags = pkg.applicationInfo.flags;
        }
        if (p.sharedUser != null && p.sharedUser.signatures.mSignatures == null) {
            p.sharedUser.signatures.assignSignatures(pkg.mSignatures);
        }
        addPackageSettingLPw(p, pkg.packageName, p.sharedUser);
    }

    private void addPackageSettingLPw(PackageSetting p, String name, SharedUserSetting sharedUser) {
        this.mPackages.put(name, p);
        if (sharedUser != null) {
            if (p.sharedUser != null && p.sharedUser != sharedUser) {
                PackageManagerService.reportSettingsProblem(6, "Package " + p.name + " was user " + p.sharedUser + " but is now " + sharedUser + "; I am not changing its files so it will probably fail!");
                p.sharedUser.removePackage(p);
            } else if (p.appId != sharedUser.userId) {
                PackageManagerService.reportSettingsProblem(6, "Package " + p.name + " was user id " + p.appId + " but is now user " + sharedUser + " with id " + sharedUser.userId + "; I am not changing its files so it will probably fail!");
            }
            sharedUser.addPackage(p);
            p.sharedUser = sharedUser;
            p.appId = sharedUser.userId;
        }
    }

    void updateSharedUserPermsLPw(PackageSetting deletedPs, int[] globalGids) {
        if (deletedPs == null || deletedPs.pkg == null) {
            Slog.i("PackageManager", "Trying to update info for null package. Just ignoring");
        } else if (deletedPs.sharedUser != null) {
            SharedUserSetting sus = deletedPs.sharedUser;
            Iterator it = deletedPs.pkg.requestedPermissions.iterator();
            while (it.hasNext()) {
                String eachPerm = (String) it.next();
                boolean used = DEBUG_STOPPED;
                if (sus.grantedPermissions.contains(eachPerm)) {
                    Iterator i$ = sus.packages.iterator();
                    while (i$.hasNext()) {
                        PackageSetting pkg = (PackageSetting) i$.next();
                        if (pkg.pkg != null && !pkg.pkg.packageName.equals(deletedPs.pkg.packageName) && pkg.pkg.requestedPermissions.contains(eachPerm)) {
                            used = true;
                            break;
                        }
                    }
                    if (!used) {
                        sus.grantedPermissions.remove(eachPerm);
                    }
                }
            }
            int[] newGids = globalGids;
            it = sus.grantedPermissions.iterator();
            while (it.hasNext()) {
                BasePermission bp = (BasePermission) this.mPermissions.get((String) it.next());
                if (bp != null) {
                    newGids = PackageManagerService.appendInts(newGids, bp.gids);
                }
            }
            sus.gids = newGids;
        }
    }

    int removePackageLPw(String name) {
        PackageSetting p = (PackageSetting) this.mPackages.get(name);
        if (p != null) {
            this.mPackages.remove(name);
            if (p.sharedUser != null) {
                p.sharedUser.removePackage(p);
                if (p.sharedUser.packages.size() == 0) {
                    this.mSharedUsers.remove(p.sharedUser.name);
                    removeUserIdLPw(p.sharedUser.userId);
                    return p.sharedUser.userId;
                }
            }
            removeUserIdLPw(p.appId);
            return p.appId;
        }
        return -1;
    }

    private void replacePackageLPw(String name, PackageSetting newp) {
        PackageSetting p = (PackageSetting) this.mPackages.get(name);
        if (p != null) {
            if (p.sharedUser != null) {
                p.sharedUser.removePackage(p);
                p.sharedUser.addPackage(newp);
            } else {
                replaceUserIdLPw(p.appId, newp);
            }
        }
        this.mPackages.put(name, newp);
    }

    private boolean addUserIdLPw(int uid, Object obj, Object name) {
        if (uid > 19999) {
            return DEBUG_STOPPED;
        }
        if (uid >= ProcessList.PSS_TEST_MIN_TIME_FROM_STATE_CHANGE) {
            int index = uid - 10000;
            for (int N = this.mUserIds.size(); index >= N; N++) {
                this.mUserIds.add(null);
            }
            if (this.mUserIds.get(index) != null) {
                PackageManagerService.reportSettingsProblem(6, "Adding duplicate user id: " + uid + " name=" + name);
                return DEBUG_STOPPED;
            }
            this.mUserIds.set(index, obj);
        } else if (this.mOtherUserIds.get(uid) != null) {
            PackageManagerService.reportSettingsProblem(6, "Adding duplicate shared id: " + uid + " name=" + name);
            return DEBUG_STOPPED;
        } else {
            this.mOtherUserIds.put(uid, obj);
        }
        return true;
    }

    public Object getUserIdLPr(int uid) {
        if (uid < ProcessList.PSS_TEST_MIN_TIME_FROM_STATE_CHANGE) {
            return this.mOtherUserIds.get(uid);
        }
        int index = uid - 10000;
        return index < this.mUserIds.size() ? this.mUserIds.get(index) : null;
    }

    private void removeUserIdLPw(int uid) {
        if (uid >= ProcessList.PSS_TEST_MIN_TIME_FROM_STATE_CHANGE) {
            int index = uid - 10000;
            if (index < this.mUserIds.size()) {
                this.mUserIds.set(index, null);
            }
        } else {
            this.mOtherUserIds.remove(uid);
        }
        setFirstAvailableUid(uid + 1);
    }

    private void replaceUserIdLPw(int uid, Object obj) {
        if (uid >= ProcessList.PSS_TEST_MIN_TIME_FROM_STATE_CHANGE) {
            int index = uid - 10000;
            if (index < this.mUserIds.size()) {
                this.mUserIds.set(index, obj);
                return;
            }
            return;
        }
        this.mOtherUserIds.put(uid, obj);
    }

    PreferredIntentResolver editPreferredActivitiesLPw(int userId) {
        PreferredIntentResolver pir = (PreferredIntentResolver) this.mPreferredActivities.get(userId);
        if (pir != null) {
            return pir;
        }
        pir = new PreferredIntentResolver();
        this.mPreferredActivities.put(userId, pir);
        return pir;
    }

    PersistentPreferredIntentResolver editPersistentPreferredActivitiesLPw(int userId) {
        PersistentPreferredIntentResolver ppir = (PersistentPreferredIntentResolver) this.mPersistentPreferredActivities.get(userId);
        if (ppir != null) {
            return ppir;
        }
        ppir = new PersistentPreferredIntentResolver();
        this.mPersistentPreferredActivities.put(userId, ppir);
        return ppir;
    }

    CrossProfileIntentResolver editCrossProfileIntentResolverLPw(int userId) {
        CrossProfileIntentResolver cpir = (CrossProfileIntentResolver) this.mCrossProfileIntentResolvers.get(userId);
        if (cpir != null) {
            return cpir;
        }
        cpir = new CrossProfileIntentResolver();
        this.mCrossProfileIntentResolvers.put(userId, cpir);
        return cpir;
    }

    private File getUserPackagesStateFile(int userId) {
        return new File(Environment.getUserSystemDirectory(userId), "package-restrictions.xml");
    }

    private File getUserPackagesStateBackupFile(int userId) {
        return new File(Environment.getUserSystemDirectory(userId), "package-restrictions-backup.xml");
    }

    void writeAllUsersPackageRestrictionsLPr() {
        List<UserInfo> users = getAllUsers();
        if (users != null) {
            for (UserInfo user : users) {
                writePackageRestrictionsLPr(user.id);
            }
        }
    }

    void readAllUsersPackageRestrictionsLPr() {
        List<UserInfo> users = getAllUsers();
        if (users == null) {
            readPackageRestrictionsLPr(0);
            return;
        }
        for (UserInfo user : users) {
            readPackageRestrictionsLPr(user.id);
        }
    }

    public boolean isInternalDatabaseVersionOlderThan(int version) {
        return this.mInternalDatabaseVersion < version ? true : DEBUG_STOPPED;
    }

    public boolean isExternalDatabaseVersionOlderThan(int version) {
        return this.mExternalDatabaseVersion < version ? true : DEBUG_STOPPED;
    }

    public void updateInternalDatabaseVersion() {
        this.mInternalDatabaseVersion = CURRENT_DATABASE_VERSION;
    }

    public void updateExternalDatabaseVersion() {
        this.mExternalDatabaseVersion = CURRENT_DATABASE_VERSION;
    }

    private void readPreferredActivitiesLPw(XmlPullParser parser, int userId) throws XmlPullParserException, IOException {
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == 1) {
                return;
            }
            if (type == CURRENT_DATABASE_VERSION && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == CURRENT_DATABASE_VERSION || type == 4)) {
                if (parser.getName().equals(TAG_ITEM)) {
                    PreferredActivity pa = new PreferredActivity(parser);
                    if (pa.mPref.getParseError() == null) {
                        editPreferredActivitiesLPw(userId).addFilter(pa);
                    } else {
                        PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: <preferred-activity> " + pa.mPref.getParseError() + " at " + parser.getPositionDescription());
                    }
                } else {
                    PackageManagerService.reportSettingsProblem(5, "Unknown element under <preferred-activities>: " + parser.getName());
                    XmlUtils.skipCurrentTag(parser);
                }
            }
        }
    }

    private void readPersistentPreferredActivitiesLPw(XmlPullParser parser, int userId) throws XmlPullParserException, IOException {
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == 1) {
                return;
            }
            if (type == CURRENT_DATABASE_VERSION && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == CURRENT_DATABASE_VERSION || type == 4)) {
                if (parser.getName().equals(TAG_ITEM)) {
                    editPersistentPreferredActivitiesLPw(userId).addFilter(new PersistentPreferredActivity(parser));
                } else {
                    PackageManagerService.reportSettingsProblem(5, "Unknown element under <persistent-preferred-activities>: " + parser.getName());
                    XmlUtils.skipCurrentTag(parser);
                }
            }
        }
    }

    private void readCrossProfileIntentFiltersLPw(XmlPullParser parser, int userId) throws XmlPullParserException, IOException {
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == 1) {
                return;
            }
            if (type == CURRENT_DATABASE_VERSION && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == CURRENT_DATABASE_VERSION || type == 4)) {
                if (parser.getName().equals(TAG_ITEM)) {
                    editCrossProfileIntentResolverLPw(userId).addFilter(new CrossProfileIntentFilter(parser));
                } else {
                    PackageManagerService.reportSettingsProblem(5, "Unknown element under crossProfile-intent-filters: " + parser.getName());
                    XmlUtils.skipCurrentTag(parser);
                }
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void readPackageRestrictionsLPr(int r37) {
        /*
        r36 = this;
        r29 = 0;
        r33 = r36.getUserPackagesStateFile(r37);
        r15 = r36.getUserPackagesStateBackupFile(r37);
        r5 = r15.exists();
        if (r5 == 0) goto L_0x0342;
    L_0x0010:
        r30 = new java.io.FileInputStream;	 Catch:{ IOException -> 0x00df }
        r0 = r30;
        r0.<init>(r15);	 Catch:{ IOException -> 0x00df }
        r0 = r36;
        r5 = r0.mReadMessages;	 Catch:{ IOException -> 0x0339 }
        r34 = "Reading from backup stopped packages file\n";
        r0 = r34;
        r5.append(r0);	 Catch:{ IOException -> 0x0339 }
        r5 = 4;
        r34 = "Need to read from backup stopped packages file";
        r0 = r34;
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r5, r0);	 Catch:{ IOException -> 0x0339 }
        r5 = r33.exists();	 Catch:{ IOException -> 0x0339 }
        if (r5 == 0) goto L_0x0051;
    L_0x0030:
        r5 = "PackageManager";
        r34 = new java.lang.StringBuilder;	 Catch:{ IOException -> 0x0339 }
        r34.<init>();	 Catch:{ IOException -> 0x0339 }
        r35 = "Cleaning up stopped packages file ";
        r34 = r34.append(r35);	 Catch:{ IOException -> 0x0339 }
        r0 = r34;
        r1 = r33;
        r34 = r0.append(r1);	 Catch:{ IOException -> 0x0339 }
        r34 = r34.toString();	 Catch:{ IOException -> 0x0339 }
        r0 = r34;
        android.util.Slog.w(r5, r0);	 Catch:{ IOException -> 0x0339 }
        r33.delete();	 Catch:{ IOException -> 0x0339 }
    L_0x0051:
        if (r30 != 0) goto L_0x033e;
    L_0x0053:
        r5 = r33.exists();	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
        if (r5 != 0) goto L_0x00e7;
    L_0x0059:
        r0 = r36;
        r5 = r0.mReadMessages;	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
        r34 = "No stopped packages file found\n";
        r0 = r34;
        r5.append(r0);	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
        r5 = 4;
        r34 = "No stopped packages file; assuming all started";
        r0 = r34;
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r5, r0);	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
        r0 = r36;
        r5 = r0.mPackages;	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
        r5 = r5.values();	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
        r21 = r5.iterator();	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
    L_0x0078:
        r5 = r21.hasNext();	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
        if (r5 == 0) goto L_0x00e4;
    L_0x007e:
        r3 = r21.next();	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
        r3 = (com.android.server.pm.PackageSetting) r3;	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
        r5 = 0;
        r6 = 1;
        r7 = 0;
        r8 = 0;
        r9 = 0;
        r10 = 0;
        r11 = 0;
        r12 = 0;
        r13 = 0;
        r4 = r37;
        r3.setUserState(r4, r5, r6, r7, r8, r9, r10, r11, r12, r13);	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
        goto L_0x0078;
    L_0x0093:
        r18 = move-exception;
        r29 = r30;
    L_0x0096:
        r0 = r36;
        r5 = r0.mReadMessages;
        r34 = new java.lang.StringBuilder;
        r34.<init>();
        r35 = "Error reading: ";
        r34 = r34.append(r35);
        r35 = r18.toString();
        r34 = r34.append(r35);
        r34 = r34.toString();
        r0 = r34;
        r5.append(r0);
        r5 = 6;
        r34 = new java.lang.StringBuilder;
        r34.<init>();
        r35 = "Error reading stopped packages: ";
        r34 = r34.append(r35);
        r0 = r34;
        r1 = r18;
        r34 = r0.append(r1);
        r34 = r34.toString();
        r0 = r34;
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r5, r0);
        r5 = "PackageManager";
        r34 = "Error reading package manager stopped packages";
        r0 = r34;
        r1 = r18;
        android.util.Slog.wtf(r5, r0, r1);
    L_0x00de:
        return;
    L_0x00df:
        r5 = move-exception;
    L_0x00e0:
        r30 = r29;
        goto L_0x0051;
    L_0x00e4:
        r29 = r30;
        goto L_0x00de;
    L_0x00e7:
        r29 = new java.io.FileInputStream;	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
        r0 = r29;
        r1 = r33;
        r0.<init>(r1);	 Catch:{ XmlPullParserException -> 0x0093, IOException -> 0x0334 }
    L_0x00f0:
        r27 = android.util.Xml.newPullParser();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r5 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r5 = r5.name();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r0 = r27;
        r1 = r29;
        r0.setInput(r1, r5);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
    L_0x0101:
        r32 = r27.next();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r5 = 2;
        r0 = r32;
        if (r0 == r5) goto L_0x010f;
    L_0x010a:
        r5 = 1;
        r0 = r32;
        if (r0 != r5) goto L_0x0101;
    L_0x010f:
        r5 = 2;
        r0 = r32;
        if (r0 == r5) goto L_0x012b;
    L_0x0114:
        r0 = r36;
        r5 = r0.mReadMessages;	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r34 = "No start tag found in package restrictions file\n";
        r0 = r34;
        r5.append(r0);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r5 = 5;
        r34 = "No start tag found in package manager stopped packages";
        r0 = r34;
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r5, r0);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x00de;
    L_0x0128:
        r18 = move-exception;
        goto L_0x0096;
    L_0x012b:
        r25 = r27.getDepth();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r4 = 0;
    L_0x0130:
        r32 = r27.next();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r5 = 1;
        r0 = r32;
        if (r0 == r5) goto L_0x032f;
    L_0x0139:
        r5 = 3;
        r0 = r32;
        if (r0 != r5) goto L_0x0146;
    L_0x013e:
        r5 = r27.getDepth();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r0 = r25;
        if (r5 <= r0) goto L_0x032f;
    L_0x0146:
        r5 = 3;
        r0 = r32;
        if (r0 == r5) goto L_0x0130;
    L_0x014b:
        r5 = 4;
        r0 = r32;
        if (r0 == r5) goto L_0x0130;
    L_0x0150:
        r31 = r27.getName();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r5 = "pkg";
        r0 = r31;
        r5 = r0.equals(r5);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r5 == 0) goto L_0x02cd;
    L_0x015e:
        r5 = 0;
        r34 = "name";
        r0 = r27;
        r1 = r34;
        r23 = r0.getAttributeValue(r5, r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r0 = r36;
        r5 = r0.mPackages;	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r0 = r23;
        r4 = r5.get(r0);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r4 = (com.android.server.pm.PackageSetting) r4;	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r4 != 0) goto L_0x01e4;
    L_0x0177:
        r5 = "PackageManager";
        r34 = new java.lang.StringBuilder;	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r34.<init>();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r35 = "No package known for stopped package: ";
        r34 = r34.append(r35);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r0 = r34;
        r1 = r23;
        r34 = r0.append(r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r34 = r34.toString();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r0 = r34;
        android.util.Slog.w(r5, r0);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        com.android.internal.util.XmlUtils.skipCurrentTag(r27);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0130;
    L_0x0199:
        r18 = move-exception;
    L_0x019a:
        r0 = r36;
        r5 = r0.mReadMessages;
        r34 = new java.lang.StringBuilder;
        r34.<init>();
        r35 = "Error reading: ";
        r34 = r34.append(r35);
        r35 = r18.toString();
        r34 = r34.append(r35);
        r34 = r34.toString();
        r0 = r34;
        r5.append(r0);
        r5 = 6;
        r34 = new java.lang.StringBuilder;
        r34.<init>();
        r35 = "Error reading settings: ";
        r34 = r34.append(r35);
        r0 = r34;
        r1 = r18;
        r34 = r0.append(r1);
        r34 = r34.toString();
        r0 = r34;
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r5, r0);
        r5 = "PackageManager";
        r34 = "Error reading package manager stopped packages";
        r0 = r34;
        r1 = r18;
        android.util.Slog.wtf(r5, r0, r1);
        goto L_0x00de;
    L_0x01e4:
        r5 = 0;
        r34 = "enabled";
        r0 = r27;
        r1 = r34;
        r19 = r0.getAttributeValue(r5, r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r19 != 0) goto L_0x028d;
    L_0x01f1:
        r6 = 0;
    L_0x01f2:
        r5 = 0;
        r34 = "enabledCaller";
        r0 = r27;
        r1 = r34;
        r11 = r0.getAttributeValue(r5, r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r5 = 0;
        r34 = "inst";
        r0 = r27;
        r1 = r34;
        r22 = r0.getAttributeValue(r5, r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r22 != 0) goto L_0x0293;
    L_0x020a:
        r7 = 1;
    L_0x020b:
        r5 = 0;
        r34 = "stopped";
        r0 = r27;
        r1 = r34;
        r28 = r0.getAttributeValue(r5, r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r28 != 0) goto L_0x0299;
    L_0x0218:
        r8 = 0;
    L_0x0219:
        r5 = 0;
        r34 = "blocked";
        r0 = r27;
        r1 = r34;
        r17 = r0.getAttributeValue(r5, r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r17 != 0) goto L_0x029f;
    L_0x0226:
        r10 = 0;
    L_0x0227:
        r5 = 0;
        r34 = "hidden";
        r0 = r27;
        r1 = r34;
        r20 = r0.getAttributeValue(r5, r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r20 != 0) goto L_0x02a4;
    L_0x0234:
        r5 = 0;
        r34 = "nl";
        r0 = r27;
        r1 = r34;
        r24 = r0.getAttributeValue(r5, r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r28 != 0) goto L_0x02a9;
    L_0x0241:
        r9 = 0;
    L_0x0242:
        r5 = 0;
        r34 = "blockUninstall";
        r0 = r27;
        r1 = r34;
        r16 = r0.getAttributeValue(r5, r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r16 != 0) goto L_0x02ae;
    L_0x024f:
        r14 = 0;
    L_0x0250:
        r12 = 0;
        r13 = 0;
        r26 = r27.getDepth();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
    L_0x0256:
        r32 = r27.next();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r5 = 1;
        r0 = r32;
        if (r0 == r5) goto L_0x02c6;
    L_0x025f:
        r5 = 3;
        r0 = r32;
        if (r0 != r5) goto L_0x026c;
    L_0x0264:
        r5 = r27.getDepth();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r0 = r26;
        if (r5 <= r0) goto L_0x02c6;
    L_0x026c:
        r5 = 3;
        r0 = r32;
        if (r0 == r5) goto L_0x0256;
    L_0x0271:
        r5 = 4;
        r0 = r32;
        if (r0 == r5) goto L_0x0256;
    L_0x0276:
        r31 = r27.getName();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r5 = "enabled-components";
        r0 = r31;
        r5 = r0.equals(r5);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r5 == 0) goto L_0x02b3;
    L_0x0284:
        r0 = r36;
        r1 = r27;
        r12 = r0.readComponentsLPr(r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0256;
    L_0x028d:
        r6 = java.lang.Integer.parseInt(r19);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x01f2;
    L_0x0293:
        r7 = java.lang.Boolean.parseBoolean(r22);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x020b;
    L_0x0299:
        r8 = java.lang.Boolean.parseBoolean(r28);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0219;
    L_0x029f:
        r10 = java.lang.Boolean.parseBoolean(r17);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0227;
    L_0x02a4:
        r10 = java.lang.Boolean.parseBoolean(r20);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0234;
    L_0x02a9:
        r9 = java.lang.Boolean.parseBoolean(r24);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0242;
    L_0x02ae:
        r14 = java.lang.Boolean.parseBoolean(r16);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0250;
    L_0x02b3:
        r5 = "disabled-components";
        r0 = r31;
        r5 = r0.equals(r5);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r5 == 0) goto L_0x0256;
    L_0x02bd:
        r0 = r36;
        r1 = r27;
        r13 = r0.readComponentsLPr(r1);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0256;
    L_0x02c6:
        r5 = r37;
        r4.setUserState(r5, r6, r7, r8, r9, r10, r11, r12, r13, r14);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0130;
    L_0x02cd:
        r5 = "preferred-activities";
        r0 = r31;
        r5 = r0.equals(r5);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r5 == 0) goto L_0x02e2;
    L_0x02d7:
        r0 = r36;
        r1 = r27;
        r2 = r37;
        r0.readPreferredActivitiesLPw(r1, r2);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0130;
    L_0x02e2:
        r5 = "persistent-preferred-activities";
        r0 = r31;
        r5 = r0.equals(r5);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r5 == 0) goto L_0x02f7;
    L_0x02ec:
        r0 = r36;
        r1 = r27;
        r2 = r37;
        r0.readPersistentPreferredActivitiesLPw(r1, r2);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0130;
    L_0x02f7:
        r5 = "crossProfile-intent-filters";
        r0 = r31;
        r5 = r0.equals(r5);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        if (r5 == 0) goto L_0x030c;
    L_0x0301:
        r0 = r36;
        r1 = r27;
        r2 = r37;
        r0.readCrossProfileIntentFiltersLPw(r1, r2);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0130;
    L_0x030c:
        r5 = "PackageManager";
        r34 = new java.lang.StringBuilder;	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r34.<init>();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r35 = "Unknown element under <stopped-packages>: ";
        r34 = r34.append(r35);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r35 = r27.getName();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r34 = r34.append(r35);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r34 = r34.toString();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        r0 = r34;
        android.util.Slog.w(r5, r0);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        com.android.internal.util.XmlUtils.skipCurrentTag(r27);	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x0130;
    L_0x032f:
        r29.close();	 Catch:{ XmlPullParserException -> 0x0128, IOException -> 0x0199 }
        goto L_0x00de;
    L_0x0334:
        r18 = move-exception;
        r29 = r30;
        goto L_0x019a;
    L_0x0339:
        r5 = move-exception;
        r29 = r30;
        goto L_0x00e0;
    L_0x033e:
        r29 = r30;
        goto L_0x00f0;
    L_0x0342:
        r30 = r29;
        goto L_0x0051;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.Settings.readPackageRestrictionsLPr(int):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private android.util.ArraySet<java.lang.String> readComponentsLPr(org.xmlpull.v1.XmlPullParser r9) throws java.io.IOException, org.xmlpull.v1.XmlPullParserException {
        /*
        r8 = this;
        r7 = 3;
        r1 = 0;
        r2 = r9.getDepth();
    L_0x0006:
        r4 = r9.next();
        r5 = 1;
        if (r4 == r5) goto L_0x003a;
    L_0x000d:
        if (r4 != r7) goto L_0x0015;
    L_0x000f:
        r5 = r9.getDepth();
        if (r5 <= r2) goto L_0x003a;
    L_0x0015:
        if (r4 == r7) goto L_0x0006;
    L_0x0017:
        r5 = 4;
        if (r4 == r5) goto L_0x0006;
    L_0x001a:
        r3 = r9.getName();
        r5 = "item";
        r5 = r3.equals(r5);
        if (r5 == 0) goto L_0x0006;
    L_0x0026:
        r5 = 0;
        r6 = "name";
        r0 = r9.getAttributeValue(r5, r6);
        if (r0 == 0) goto L_0x0006;
    L_0x002f:
        if (r1 != 0) goto L_0x0036;
    L_0x0031:
        r1 = new android.util.ArraySet;
        r1.<init>();
    L_0x0036:
        r1.add(r0);
        goto L_0x0006;
    L_0x003a:
        return r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.Settings.readComponentsLPr(org.xmlpull.v1.XmlPullParser):android.util.ArraySet<java.lang.String>");
    }

    void writePreferredActivitiesLPr(XmlSerializer serializer, int userId, boolean full) throws IllegalArgumentException, IllegalStateException, IOException {
        serializer.startTag(null, "preferred-activities");
        PreferredIntentResolver pir = (PreferredIntentResolver) this.mPreferredActivities.get(userId);
        if (pir != null) {
            for (PreferredActivity pa : pir.filterSet()) {
                serializer.startTag(null, TAG_ITEM);
                pa.writeToXml(serializer, full);
                serializer.endTag(null, TAG_ITEM);
            }
        }
        serializer.endTag(null, "preferred-activities");
    }

    void writePersistentPreferredActivitiesLPr(XmlSerializer serializer, int userId) throws IllegalArgumentException, IllegalStateException, IOException {
        serializer.startTag(null, TAG_PERSISTENT_PREFERRED_ACTIVITIES);
        PersistentPreferredIntentResolver ppir = (PersistentPreferredIntentResolver) this.mPersistentPreferredActivities.get(userId);
        if (ppir != null) {
            for (PersistentPreferredActivity ppa : ppir.filterSet()) {
                serializer.startTag(null, TAG_ITEM);
                ppa.writeToXml(serializer);
                serializer.endTag(null, TAG_ITEM);
            }
        }
        serializer.endTag(null, TAG_PERSISTENT_PREFERRED_ACTIVITIES);
    }

    void writeCrossProfileIntentFiltersLPr(XmlSerializer serializer, int userId) throws IllegalArgumentException, IllegalStateException, IOException {
        serializer.startTag(null, TAG_CROSS_PROFILE_INTENT_FILTERS);
        CrossProfileIntentResolver cpir = (CrossProfileIntentResolver) this.mCrossProfileIntentResolvers.get(userId);
        if (cpir != null) {
            for (CrossProfileIntentFilter cpif : cpir.filterSet()) {
                serializer.startTag(null, TAG_ITEM);
                cpif.writeToXml(serializer);
                serializer.endTag(null, TAG_ITEM);
            }
        }
        serializer.endTag(null, TAG_CROSS_PROFILE_INTENT_FILTERS);
    }

    void writePackageRestrictionsLPr(int userId) {
        File userPackagesStateFile = getUserPackagesStateFile(userId);
        File backupFile = getUserPackagesStateBackupFile(userId);
        new File(userPackagesStateFile.getParent()).mkdirs();
        if (userPackagesStateFile.exists()) {
            if (backupFile.exists()) {
                userPackagesStateFile.delete();
                Slog.w("PackageManager", "Preserving older stopped packages backup");
            } else if (!userPackagesStateFile.renameTo(backupFile)) {
                Slog.wtf("PackageManager", "Unable to backup user packages state file, current changes will be lost at reboot");
                return;
            }
        }
        try {
            FileOutputStream fstr = new FileOutputStream(userPackagesStateFile);
            BufferedOutputStream str = new BufferedOutputStream(fstr);
            XmlSerializer serializer = new FastXmlSerializer();
            serializer.setOutput(str, StandardCharsets.UTF_8.name());
            serializer.startDocument(null, Boolean.valueOf(true));
            serializer.setFeature("http://xmlpull.org/v1/doc/features.html#indent-output", true);
            serializer.startTag(null, TAG_PACKAGE_RESTRICTIONS);
            for (PackageSetting pkg : this.mPackages.values()) {
                PackageUserState ustate = pkg.readUserState(userId);
                if (ustate.stopped || ustate.notLaunched || !ustate.installed || ustate.enabled != 0 || ustate.hidden || ((ustate.enabledComponents != null && ustate.enabledComponents.size() > 0) || ((ustate.disabledComponents != null && ustate.disabledComponents.size() > 0) || ustate.blockUninstall))) {
                    Iterator i$;
                    String name;
                    serializer.startTag(null, TAG_PACKAGE);
                    serializer.attribute(null, ATTR_NAME, pkg.name);
                    if (!ustate.installed) {
                        serializer.attribute(null, ATTR_INSTALLED, "false");
                    }
                    if (ustate.stopped) {
                        serializer.attribute(null, ATTR_STOPPED, "true");
                    }
                    if (ustate.notLaunched) {
                        serializer.attribute(null, ATTR_NOT_LAUNCHED, "true");
                    }
                    if (ustate.hidden) {
                        serializer.attribute(null, ATTR_HIDDEN, "true");
                    }
                    if (ustate.blockUninstall) {
                        serializer.attribute(null, ATTR_BLOCK_UNINSTALL, "true");
                    }
                    if (ustate.enabled != 0) {
                        serializer.attribute(null, ATTR_ENABLED, Integer.toString(ustate.enabled));
                        if (ustate.lastDisableAppCaller != null) {
                            serializer.attribute(null, ATTR_ENABLED_CALLER, ustate.lastDisableAppCaller);
                        }
                    }
                    if (ustate.enabledComponents != null && ustate.enabledComponents.size() > 0) {
                        serializer.startTag(null, TAG_ENABLED_COMPONENTS);
                        i$ = ustate.enabledComponents.iterator();
                        while (i$.hasNext()) {
                            name = (String) i$.next();
                            serializer.startTag(null, TAG_ITEM);
                            serializer.attribute(null, ATTR_NAME, name);
                            serializer.endTag(null, TAG_ITEM);
                        }
                        serializer.endTag(null, TAG_ENABLED_COMPONENTS);
                    }
                    if (ustate.disabledComponents != null && ustate.disabledComponents.size() > 0) {
                        serializer.startTag(null, TAG_DISABLED_COMPONENTS);
                        i$ = ustate.disabledComponents.iterator();
                        while (i$.hasNext()) {
                            name = (String) i$.next();
                            serializer.startTag(null, TAG_ITEM);
                            serializer.attribute(null, ATTR_NAME, name);
                            serializer.endTag(null, TAG_ITEM);
                        }
                        serializer.endTag(null, TAG_DISABLED_COMPONENTS);
                    }
                    serializer.endTag(null, TAG_PACKAGE);
                }
            }
            writePreferredActivitiesLPr(serializer, userId, true);
            writePersistentPreferredActivitiesLPr(serializer, userId);
            writeCrossProfileIntentFiltersLPr(serializer, userId);
            serializer.endTag(null, TAG_PACKAGE_RESTRICTIONS);
            serializer.endDocument();
            str.flush();
            FileUtils.sync(fstr);
            str.close();
            backupFile.delete();
            FileUtils.setPermissions(userPackagesStateFile.toString(), 432, -1, -1);
        } catch (IOException e) {
            Slog.wtf("PackageManager", "Unable to write package manager user packages state,  current changes will be lost at reboot", e);
            if (userPackagesStateFile.exists() && !userPackagesStateFile.delete()) {
                Log.i("PackageManager", "Failed to clean up mangled file: " + this.mStoppedPackagesFilename);
            }
        }
    }

    void readStoppedLPw() {
        FileInputStream str;
        XmlPullParser parser;
        int type;
        int outerDepth;
        FileInputStream str2 = null;
        if (this.mBackupStoppedPackagesFilename.exists()) {
            try {
                str = new FileInputStream(this.mBackupStoppedPackagesFilename);
                try {
                    this.mReadMessages.append("Reading from backup stopped packages file\n");
                    PackageManagerService.reportSettingsProblem(4, "Need to read from backup stopped packages file");
                    if (this.mSettingsFilename.exists()) {
                        Slog.w("PackageManager", "Cleaning up stopped packages file " + this.mStoppedPackagesFilename);
                        this.mStoppedPackagesFilename.delete();
                    }
                } catch (IOException e) {
                    str2 = str;
                    str = str2;
                    if (str == null) {
                        str2 = str;
                    } else {
                        try {
                            if (this.mStoppedPackagesFilename.exists()) {
                                this.mReadMessages.append("No stopped packages file found\n");
                                PackageManagerService.reportSettingsProblem(4, "No stopped packages file file; assuming all started");
                                for (PackageSetting pkg : this.mPackages.values()) {
                                    pkg.setStopped(DEBUG_STOPPED, 0);
                                    pkg.setNotLaunched(DEBUG_STOPPED, 0);
                                }
                                str2 = str;
                                return;
                            }
                            str2 = new FileInputStream(this.mStoppedPackagesFilename);
                        } catch (XmlPullParserException e2) {
                            XmlPullParserException e3 = e2;
                            str2 = str;
                            this.mReadMessages.append("Error reading: " + e3.toString());
                            PackageManagerService.reportSettingsProblem(6, "Error reading stopped packages: " + e3);
                            Slog.wtf("PackageManager", "Error reading package manager stopped packages", e3);
                            return;
                        } catch (IOException e4) {
                            IOException e5 = e4;
                            str2 = str;
                            this.mReadMessages.append("Error reading: " + e5.toString());
                            PackageManagerService.reportSettingsProblem(6, "Error reading settings: " + e5);
                            Slog.wtf("PackageManager", "Error reading package manager stopped packages", e5);
                            return;
                        }
                    }
                    parser = Xml.newPullParser();
                    parser.setInput(str2, null);
                    do {
                        type = parser.next();
                        if (type != 2) {
                            break;
                        }
                        if (type != 2) {
                            outerDepth = parser.getDepth();
                            while (true) {
                                type = parser.next();
                                if (type == 1) {
                                    break;
                                }
                                break;
                                str2.close();
                            }
                        }
                        this.mReadMessages.append("No start tag found in stopped packages file\n");
                        PackageManagerService.reportSettingsProblem(5, "No start tag found in package manager stopped packages");
                        return;
                    } while (type != 1);
                    if (type != 2) {
                        this.mReadMessages.append("No start tag found in stopped packages file\n");
                        PackageManagerService.reportSettingsProblem(5, "No start tag found in package manager stopped packages");
                        return;
                    }
                    outerDepth = parser.getDepth();
                    while (true) {
                        type = parser.next();
                        if (type == 1) {
                            break;
                        }
                        break;
                        str2.close();
                    }
                }
            } catch (IOException e6) {
                str = str2;
                if (str == null) {
                    str2 = str;
                } else if (this.mStoppedPackagesFilename.exists()) {
                    this.mReadMessages.append("No stopped packages file found\n");
                    PackageManagerService.reportSettingsProblem(4, "No stopped packages file file; assuming all started");
                    for (PackageSetting pkg2 : this.mPackages.values()) {
                        pkg2.setStopped(DEBUG_STOPPED, 0);
                        pkg2.setNotLaunched(DEBUG_STOPPED, 0);
                    }
                    str2 = str;
                    return;
                } else {
                    str2 = new FileInputStream(this.mStoppedPackagesFilename);
                }
                parser = Xml.newPullParser();
                parser.setInput(str2, null);
                do {
                    type = parser.next();
                    if (type != 2) {
                        break;
                    }
                    if (type != 2) {
                        outerDepth = parser.getDepth();
                        while (true) {
                            type = parser.next();
                            if (type == 1) {
                                break;
                            }
                            break;
                            str2.close();
                        }
                    }
                    this.mReadMessages.append("No start tag found in stopped packages file\n");
                    PackageManagerService.reportSettingsProblem(5, "No start tag found in package manager stopped packages");
                    return;
                } while (type != 1);
                if (type != 2) {
                    this.mReadMessages.append("No start tag found in stopped packages file\n");
                    PackageManagerService.reportSettingsProblem(5, "No start tag found in package manager stopped packages");
                    return;
                }
                outerDepth = parser.getDepth();
                while (true) {
                    type = parser.next();
                    if (type == 1) {
                        break;
                    }
                    break;
                    str2.close();
                }
            }
        }
        str = null;
        if (str == null) {
            str2 = str;
        } else if (this.mStoppedPackagesFilename.exists()) {
            this.mReadMessages.append("No stopped packages file found\n");
            PackageManagerService.reportSettingsProblem(4, "No stopped packages file file; assuming all started");
            for (PackageSetting pkg22 : this.mPackages.values()) {
                pkg22.setStopped(DEBUG_STOPPED, 0);
                pkg22.setNotLaunched(DEBUG_STOPPED, 0);
            }
            str2 = str;
            return;
        } else {
            str2 = new FileInputStream(this.mStoppedPackagesFilename);
        }
        try {
            parser = Xml.newPullParser();
            parser.setInput(str2, null);
            do {
                type = parser.next();
                if (type != 2) {
                    break;
                }
            } while (type != 1);
            if (type != 2) {
                this.mReadMessages.append("No start tag found in stopped packages file\n");
                PackageManagerService.reportSettingsProblem(5, "No start tag found in package manager stopped packages");
                return;
            }
            outerDepth = parser.getDepth();
            while (true) {
                type = parser.next();
                if (type == 1 || (type == CURRENT_DATABASE_VERSION && parser.getDepth() <= outerDepth)) {
                    str2.close();
                } else if (!(type == CURRENT_DATABASE_VERSION || type == 4)) {
                    if (parser.getName().equals(TAG_PACKAGE)) {
                        String name = parser.getAttributeValue(null, ATTR_NAME);
                        PackageSetting ps = (PackageSetting) this.mPackages.get(name);
                        if (ps != null) {
                            ps.setStopped(true, 0);
                            if ("1".equals(parser.getAttributeValue(null, ATTR_NOT_LAUNCHED))) {
                                ps.setNotLaunched(true, 0);
                            }
                        } else {
                            Slog.w("PackageManager", "No package known for stopped package: " + name);
                        }
                        XmlUtils.skipCurrentTag(parser);
                    } else {
                        Slog.w("PackageManager", "Unknown element under <stopped-packages>: " + parser.getName());
                        XmlUtils.skipCurrentTag(parser);
                    }
                }
            }
            str2.close();
        } catch (XmlPullParserException e7) {
            e3 = e7;
        } catch (IOException e8) {
            e5 = e8;
        }
    }

    void writeLPr() {
        if (this.mSettingsFilename.exists()) {
            if (this.mBackupSettingsFilename.exists()) {
                this.mSettingsFilename.delete();
                Slog.w("PackageManager", "Preserving older settings backup");
            } else {
                if (!this.mSettingsFilename.renameTo(this.mBackupSettingsFilename)) {
                    Slog.wtf("PackageManager", "Unable to backup package manager settings,  current changes will be lost at reboot");
                    return;
                }
            }
        }
        this.mPastSignatures.clear();
        try {
            Iterator i$;
            FileOutputStream fstr = new FileOutputStream(this.mSettingsFilename);
            OutputStream bufferedOutputStream = new BufferedOutputStream(fstr);
            XmlSerializer serializer = new FastXmlSerializer();
            serializer.setOutput(bufferedOutputStream, StandardCharsets.UTF_8.name());
            serializer.startDocument(null, Boolean.valueOf(true));
            serializer.setFeature("http://xmlpull.org/v1/doc/features.html#indent-output", true);
            serializer.startTag(null, "packages");
            serializer.startTag(null, "last-platform-version");
            serializer.attribute(null, "internal", Integer.toString(this.mInternalSdkPlatform));
            serializer.attribute(null, "external", Integer.toString(this.mExternalSdkPlatform));
            serializer.attribute(null, "fingerprint", this.mFingerprint);
            serializer.endTag(null, "last-platform-version");
            serializer.startTag(null, "database-version");
            serializer.attribute(null, "internal", Integer.toString(this.mInternalDatabaseVersion));
            serializer.attribute(null, "external", Integer.toString(this.mExternalDatabaseVersion));
            serializer.endTag(null, "database-version");
            if (this.mVerifierDeviceIdentity != null) {
                serializer.startTag(null, "verifier");
                serializer.attribute(null, "device", this.mVerifierDeviceIdentity.toString());
                serializer.endTag(null, "verifier");
            }
            if (this.mReadExternalStorageEnforced != null) {
                serializer.startTag(null, TAG_READ_EXTERNAL_STORAGE);
                serializer.attribute(null, ATTR_ENFORCEMENT, this.mReadExternalStorageEnforced.booleanValue() ? "1" : "0");
                serializer.endTag(null, TAG_READ_EXTERNAL_STORAGE);
            }
            serializer.startTag(null, "permission-trees");
            for (BasePermission bp : this.mPermissionTrees.values()) {
                writePermissionLPr(serializer, bp);
            }
            serializer.endTag(null, "permission-trees");
            serializer.startTag(null, "permissions");
            for (BasePermission bp2 : this.mPermissions.values()) {
                writePermissionLPr(serializer, bp2);
            }
            serializer.endTag(null, "permissions");
            for (PackageSetting writePackageLPr : this.mPackages.values()) {
                writePackageLPr(serializer, writePackageLPr);
            }
            for (PackageSetting writePackageLPr2 : this.mDisabledSysPackages.values()) {
                writeDisabledSysPackageLPr(serializer, writePackageLPr2);
            }
            for (SharedUserSetting usr : this.mSharedUsers.values()) {
                serializer.startTag(null, "shared-user");
                serializer.attribute(null, ATTR_NAME, usr.name);
                serializer.attribute(null, "userId", Integer.toString(usr.userId));
                usr.signatures.writeXml(serializer, "sigs", this.mPastSignatures);
                serializer.startTag(null, "perms");
                Iterator i$2 = usr.grantedPermissions.iterator();
                while (i$2.hasNext()) {
                    String name = (String) i$2.next();
                    serializer.startTag(null, TAG_ITEM);
                    serializer.attribute(null, ATTR_NAME, name);
                    serializer.endTag(null, TAG_ITEM);
                }
                serializer.endTag(null, "perms");
                serializer.endTag(null, "shared-user");
            }
            if (this.mPackagesToBeCleaned.size() > 0) {
                i$ = this.mPackagesToBeCleaned.iterator();
                while (i$.hasNext()) {
                    PackageCleanItem item = (PackageCleanItem) i$.next();
                    String userStr = Integer.toString(item.userId);
                    serializer.startTag(null, "cleaning-package");
                    serializer.attribute(null, ATTR_NAME, item.packageName);
                    serializer.attribute(null, ATTR_CODE, item.andCode ? "true" : "false");
                    serializer.attribute(null, ATTR_USER, userStr);
                    serializer.endTag(null, "cleaning-package");
                }
            }
            if (this.mRenamedPackages.size() > 0) {
                for (Entry<String, String> e : this.mRenamedPackages.entrySet()) {
                    serializer.startTag(null, "renamed-package");
                    serializer.attribute(null, "new", (String) e.getKey());
                    serializer.attribute(null, "old", (String) e.getValue());
                    serializer.endTag(null, "renamed-package");
                }
            }
            this.mKeySetManagerService.writeKeySetManagerServiceLPr(serializer);
            serializer.endTag(null, "packages");
            serializer.endDocument();
            bufferedOutputStream.flush();
            FileUtils.sync(fstr);
            bufferedOutputStream.close();
            this.mBackupSettingsFilename.delete();
            FileUtils.setPermissions(this.mSettingsFilename.toString(), 432, -1, -1);
            JournaledFile journaledFile = new JournaledFile(this.mPackageListFilename, new File(this.mPackageListFilename.getAbsolutePath() + ".tmp"));
            fstr = new FileOutputStream(journaledFile.chooseForWrite());
            BufferedOutputStream bufferedOutputStream2 = new BufferedOutputStream(fstr);
            try {
                FileUtils.setPermissions(fstr.getFD(), 416, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, 1032);
                StringBuilder sb = new StringBuilder();
                for (PackageSetting pkg : this.mPackages.values()) {
                    if (pkg.pkg != null) {
                        if (pkg.pkg.applicationInfo != null) {
                            ApplicationInfo ai = pkg.pkg.applicationInfo;
                            String dataPath = ai.dataDir;
                            boolean isDebug = (ai.flags & 2) != 0 ? true : DEBUG_STOPPED;
                            int[] gids = pkg.getGids();
                            if (dataPath.indexOf(" ") < 0) {
                                sb.setLength(0);
                                sb.append(ai.packageName);
                                sb.append(" ");
                                sb.append(ai.uid);
                                sb.append(isDebug ? " 1 " : " 0 ");
                                sb.append(dataPath);
                                sb.append(" ");
                                sb.append(ai.seinfo);
                                sb.append(" ");
                                if (gids != null && gids.length > 0) {
                                    sb.append(gids[0]);
                                    int i = 1;
                                    while (true) {
                                        int length = gids.length;
                                        if (i >= r0) {
                                            break;
                                        }
                                        sb.append(",");
                                        sb.append(gids[i]);
                                        i++;
                                    }
                                } else {
                                    sb.append("none");
                                }
                                sb.append("\n");
                                bufferedOutputStream2.write(sb.toString().getBytes());
                            }
                        }
                    }
                    Slog.w(TAG, "Skipping " + pkg + " due to missing metadata");
                }
                bufferedOutputStream2.flush();
                FileUtils.sync(fstr);
                bufferedOutputStream2.close();
                journaledFile.commit();
            } catch (Exception e2) {
                Slog.wtf(TAG, "Failed to write packages.list", e2);
                IoUtils.closeQuietly(bufferedOutputStream2);
                journaledFile.rollback();
            }
            writeAllUsersPackageRestrictionsLPr();
        } catch (XmlPullParserException e3) {
            Slog.wtf("PackageManager", "Unable to write package manager settings, current changes will be lost at reboot", e3);
            if (this.mSettingsFilename.exists()) {
                if (!this.mSettingsFilename.delete()) {
                    Slog.wtf("PackageManager", "Failed to clean up mangled file: " + this.mSettingsFilename);
                }
            }
        } catch (IOException e4) {
            Slog.wtf("PackageManager", "Unable to write package manager settings, current changes will be lost at reboot", e4);
            if (this.mSettingsFilename.exists()) {
                if (!this.mSettingsFilename.delete()) {
                    Slog.wtf("PackageManager", "Failed to clean up mangled file: " + this.mSettingsFilename);
                }
            }
        }
    }

    void writeDisabledSysPackageLPr(XmlSerializer serializer, PackageSetting pkg) throws IOException {
        serializer.startTag(null, "updated-package");
        serializer.attribute(null, ATTR_NAME, pkg.name);
        if (pkg.realName != null) {
            serializer.attribute(null, "realName", pkg.realName);
        }
        serializer.attribute(null, "codePath", pkg.codePathString);
        serializer.attribute(null, "ft", Long.toHexString(pkg.timeStamp));
        serializer.attribute(null, "it", Long.toHexString(pkg.firstInstallTime));
        serializer.attribute(null, "ut", Long.toHexString(pkg.lastUpdateTime));
        serializer.attribute(null, "version", String.valueOf(pkg.versionCode));
        if (!pkg.resourcePathString.equals(pkg.codePathString)) {
            serializer.attribute(null, "resourcePath", pkg.resourcePathString);
        }
        if (pkg.legacyNativeLibraryPathString != null) {
            serializer.attribute(null, "nativeLibraryPath", pkg.legacyNativeLibraryPathString);
        }
        if (pkg.primaryCpuAbiString != null) {
            serializer.attribute(null, "primaryCpuAbi", pkg.primaryCpuAbiString);
        }
        if (pkg.secondaryCpuAbiString != null) {
            serializer.attribute(null, "secondaryCpuAbi", pkg.secondaryCpuAbiString);
        }
        if (pkg.cpuAbiOverrideString != null) {
            serializer.attribute(null, "cpuAbiOverride", pkg.cpuAbiOverrideString);
        }
        if (pkg.sharedUser == null) {
            serializer.attribute(null, "userId", Integer.toString(pkg.appId));
        } else {
            serializer.attribute(null, "sharedUserId", Integer.toString(pkg.appId));
        }
        serializer.startTag(null, "perms");
        if (pkg.sharedUser == null) {
            Iterator i$ = pkg.grantedPermissions.iterator();
            while (i$.hasNext()) {
                String name = (String) i$.next();
                if (((BasePermission) this.mPermissions.get(name)) != null) {
                    serializer.startTag(null, TAG_ITEM);
                    serializer.attribute(null, ATTR_NAME, name);
                    serializer.endTag(null, TAG_ITEM);
                }
            }
        }
        serializer.endTag(null, "perms");
        serializer.endTag(null, "updated-package");
    }

    void writePackageLPr(XmlSerializer serializer, PackageSetting pkg) throws IOException {
        serializer.startTag(null, "package");
        serializer.attribute(null, ATTR_NAME, pkg.name);
        if (pkg.realName != null) {
            serializer.attribute(null, "realName", pkg.realName);
        }
        serializer.attribute(null, "codePath", pkg.codePathString);
        if (!pkg.resourcePathString.equals(pkg.codePathString)) {
            serializer.attribute(null, "resourcePath", pkg.resourcePathString);
        }
        if (pkg.legacyNativeLibraryPathString != null) {
            serializer.attribute(null, "nativeLibraryPath", pkg.legacyNativeLibraryPathString);
        }
        if (pkg.primaryCpuAbiString != null) {
            serializer.attribute(null, "primaryCpuAbi", pkg.primaryCpuAbiString);
        }
        if (pkg.secondaryCpuAbiString != null) {
            serializer.attribute(null, "secondaryCpuAbi", pkg.secondaryCpuAbiString);
        }
        if (pkg.cpuAbiOverrideString != null) {
            serializer.attribute(null, "cpuAbiOverride", pkg.cpuAbiOverrideString);
        }
        serializer.attribute(null, "flags", Integer.toString(pkg.pkgFlags));
        serializer.attribute(null, "ft", Long.toHexString(pkg.timeStamp));
        serializer.attribute(null, "it", Long.toHexString(pkg.firstInstallTime));
        serializer.attribute(null, "ut", Long.toHexString(pkg.lastUpdateTime));
        serializer.attribute(null, "version", String.valueOf(pkg.versionCode));
        if (pkg.sharedUser == null) {
            serializer.attribute(null, "userId", Integer.toString(pkg.appId));
        } else {
            serializer.attribute(null, "sharedUserId", Integer.toString(pkg.appId));
        }
        if (pkg.uidError) {
            serializer.attribute(null, "uidError", "true");
        }
        if (pkg.installStatus == 0) {
            serializer.attribute(null, "installStatus", "false");
        }
        if (pkg.installerPackageName != null) {
            serializer.attribute(null, "installer", pkg.installerPackageName);
        }
        pkg.signatures.writeXml(serializer, "sigs", this.mPastSignatures);
        if ((pkg.pkgFlags & 1) == 0) {
            serializer.startTag(null, "perms");
            if (pkg.sharedUser == null) {
                Iterator i$ = pkg.grantedPermissions.iterator();
                while (i$.hasNext()) {
                    String name = (String) i$.next();
                    serializer.startTag(null, TAG_ITEM);
                    serializer.attribute(null, ATTR_NAME, name);
                    serializer.endTag(null, TAG_ITEM);
                }
            }
            serializer.endTag(null, "perms");
        }
        writeSigningKeySetsLPr(serializer, pkg.keySetData);
        writeUpgradeKeySetsLPr(serializer, pkg.keySetData);
        writeKeySetAliasesLPr(serializer, pkg.keySetData);
        serializer.endTag(null, "package");
    }

    void writeSigningKeySetsLPr(XmlSerializer serializer, PackageKeySetData data) throws IOException {
        if (data.getSigningKeySets() != null) {
            long properSigningKeySet = data.getProperSigningKeySet();
            serializer.startTag(null, "proper-signing-keyset");
            serializer.attribute(null, "identifier", Long.toString(properSigningKeySet));
            serializer.endTag(null, "proper-signing-keyset");
            for (long id : data.getSigningKeySets()) {
                serializer.startTag(null, "signing-keyset");
                serializer.attribute(null, "identifier", Long.toString(id));
                serializer.endTag(null, "signing-keyset");
            }
        }
    }

    void writeUpgradeKeySetsLPr(XmlSerializer serializer, PackageKeySetData data) throws IOException {
        if (data.isUsingUpgradeKeySets()) {
            for (long id : data.getUpgradeKeySets()) {
                serializer.startTag(null, "upgrade-keyset");
                serializer.attribute(null, "identifier", Long.toString(id));
                serializer.endTag(null, "upgrade-keyset");
            }
        }
    }

    void writeKeySetAliasesLPr(XmlSerializer serializer, PackageKeySetData data) throws IOException {
        for (Entry<String, Long> e : data.getAliases().entrySet()) {
            serializer.startTag(null, "defined-keyset");
            serializer.attribute(null, "alias", (String) e.getKey());
            serializer.attribute(null, "identifier", Long.toString(((Long) e.getValue()).longValue()));
            serializer.endTag(null, "defined-keyset");
        }
    }

    void writePermissionLPr(XmlSerializer serializer, BasePermission bp) throws XmlPullParserException, IOException {
        if (bp.type != 1 && bp.sourcePackage != null) {
            serializer.startTag(null, TAG_ITEM);
            serializer.attribute(null, ATTR_NAME, bp.name);
            serializer.attribute(null, "package", bp.sourcePackage);
            if (bp.protectionLevel != 0) {
                serializer.attribute(null, "protection", Integer.toString(bp.protectionLevel));
            }
            if (bp.type == 2) {
                PermissionInfo pi = bp.perm != null ? bp.perm.info : bp.pendingInfo;
                if (pi != null) {
                    serializer.attribute(null, SoundModelContract.KEY_TYPE, "dynamic");
                    if (pi.icon != 0) {
                        serializer.attribute(null, "icon", Integer.toString(pi.icon));
                    }
                    if (pi.nonLocalizedLabel != null) {
                        serializer.attribute(null, "label", pi.nonLocalizedLabel.toString());
                    }
                }
            }
            serializer.endTag(null, TAG_ITEM);
        }
    }

    ArrayList<PackageSetting> getListOfIncompleteInstallPackagesLPr() {
        Iterator<String> its = new ArraySet(this.mPackages.keySet()).iterator();
        ArrayList<PackageSetting> ret = new ArrayList();
        while (its.hasNext()) {
            PackageSetting ps = (PackageSetting) this.mPackages.get((String) its.next());
            if (ps.getInstallStatus() == 0) {
                ret.add(ps);
            }
        }
        return ret;
    }

    void addPackageToCleanLPw(PackageCleanItem pkg) {
        if (!this.mPackagesToBeCleaned.contains(pkg)) {
            this.mPackagesToBeCleaned.add(pkg);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    boolean readLPw(com.android.server.pm.PackageManagerService r50, java.util.List<android.content.pm.UserInfo> r51, int r52, boolean r53) {
        /*
        r49 = this;
        r42 = 0;
        r0 = r49;
        r3 = r0.mBackupSettingsFilename;
        r3 = r3.exists();
        if (r3 == 0) goto L_0x0055;
    L_0x000c:
        r43 = new java.io.FileInputStream;	 Catch:{ IOException -> 0x059b }
        r0 = r49;
        r3 = r0.mBackupSettingsFilename;	 Catch:{ IOException -> 0x059b }
        r0 = r43;
        r0.<init>(r3);	 Catch:{ IOException -> 0x059b }
        r0 = r49;
        r3 = r0.mReadMessages;	 Catch:{ IOException -> 0x059e }
        r4 = "Reading from backup settings file\n";
        r3.append(r4);	 Catch:{ IOException -> 0x059e }
        r3 = 4;
        r4 = "Need to read from backup settings file";
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r3, r4);	 Catch:{ IOException -> 0x059e }
        r0 = r49;
        r3 = r0.mSettingsFilename;	 Catch:{ IOException -> 0x059e }
        r3 = r3.exists();	 Catch:{ IOException -> 0x059e }
        if (r3 == 0) goto L_0x0053;
    L_0x0030:
        r3 = "PackageManager";
        r4 = new java.lang.StringBuilder;	 Catch:{ IOException -> 0x059e }
        r4.<init>();	 Catch:{ IOException -> 0x059e }
        r5 = "Cleaning up settings file ";
        r4 = r4.append(r5);	 Catch:{ IOException -> 0x059e }
        r0 = r49;
        r5 = r0.mSettingsFilename;	 Catch:{ IOException -> 0x059e }
        r4 = r4.append(r5);	 Catch:{ IOException -> 0x059e }
        r4 = r4.toString();	 Catch:{ IOException -> 0x059e }
        android.util.Slog.w(r3, r4);	 Catch:{ IOException -> 0x059e }
        r0 = r49;
        r3 = r0.mSettingsFilename;	 Catch:{ IOException -> 0x059e }
        r3.delete();	 Catch:{ IOException -> 0x059e }
    L_0x0053:
        r42 = r43;
    L_0x0055:
        r0 = r49;
        r3 = r0.mPendingPackages;
        r3.clear();
        r0 = r49;
        r3 = r0.mPastSignatures;
        r3.clear();
        if (r42 != 0) goto L_0x009f;
    L_0x0065:
        r0 = r49;
        r3 = r0.mSettingsFilename;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = r3.exists();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 != 0) goto L_0x0092;
    L_0x006f:
        r0 = r49;
        r3 = r0.mReadMessages;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r4 = "No settings file found\n";
        r3.append(r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = 4;
        r4 = "No settings file; creating initial state";
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r52;
        r1 = r49;
        r1.mExternalSdkPlatform = r0;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r52;
        r1 = r49;
        r1.mInternalSdkPlatform = r0;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = android.os.Build.FINGERPRINT;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r49;
        r0.mFingerprint = r3;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = 0;
    L_0x0091:
        return r3;
    L_0x0092:
        r43 = new java.io.FileInputStream;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r49;
        r3 = r0.mSettingsFilename;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r43;
        r0.<init>(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r42 = r43;
    L_0x009f:
        r40 = android.util.Xml.newPullParser();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = r3.name();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r40;
        r1 = r42;
        r0.setInput(r1, r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
    L_0x00b0:
        r45 = r40.next();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = 2;
        r0 = r45;
        if (r0 == r3) goto L_0x00be;
    L_0x00b9:
        r3 = 1;
        r0 = r45;
        if (r0 != r3) goto L_0x00b0;
    L_0x00be:
        r3 = 2;
        r0 = r45;
        if (r0 == r3) goto L_0x00db;
    L_0x00c3:
        r0 = r49;
        r3 = r0.mReadMessages;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r4 = "No start tag found in settings file\n";
        r3.append(r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = 5;
        r4 = "No start tag found in package manager settings";
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = "PackageManager";
        r4 = "No start tag found in package manager settings";
        android.util.Slog.wtf(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = 0;
        goto L_0x0091;
    L_0x00db:
        r38 = r40.getDepth();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
    L_0x00df:
        r45 = r40.next();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = 1;
        r0 = r45;
        if (r0 == r3) goto L_0x0448;
    L_0x00e8:
        r3 = 3;
        r0 = r45;
        if (r0 != r3) goto L_0x00f5;
    L_0x00ed:
        r3 = r40.getDepth();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r38;
        if (r3 <= r0) goto L_0x0448;
    L_0x00f5:
        r3 = 3;
        r0 = r45;
        if (r0 == r3) goto L_0x00df;
    L_0x00fa:
        r3 = 4;
        r0 = r45;
        if (r0 == r3) goto L_0x00df;
    L_0x00ff:
        r44 = r40.getName();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = "package";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x01d8;
    L_0x010d:
        r0 = r49;
        r1 = r40;
        r0.readPackageLPw(r1);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x0115:
        r24 = move-exception;
        r0 = r49;
        r3 = r0.mReadMessages;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Error reading: ";
        r4 = r4.append(r5);
        r5 = r24.toString();
        r4 = r4.append(r5);
        r4 = r4.toString();
        r3.append(r4);
        r3 = 6;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Error reading settings: ";
        r4 = r4.append(r5);
        r0 = r24;
        r4 = r4.append(r0);
        r4 = r4.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r3, r4);
        r3 = "PackageManager";
        r4 = "Error reading package manager settings";
        r0 = r24;
        android.util.Slog.wtf(r3, r4, r0);
    L_0x0156:
        r0 = r49;
        r3 = r0.mPendingPackages;
        r18 = r3.size();
        r28 = 0;
    L_0x0160:
        r0 = r28;
        r1 = r18;
        if (r0 >= r1) goto L_0x04d0;
    L_0x0166:
        r0 = r49;
        r3 = r0.mPendingPackages;
        r0 = r28;
        r41 = r3.get(r0);
        r41 = (com.android.server.pm.PendingPackage) r41;
        r0 = r41;
        r3 = r0.sharedId;
        r0 = r49;
        r31 = r0.getUserIdLPr(r3);
        if (r31 == 0) goto L_0x0456;
    L_0x017e:
        r0 = r31;
        r3 = r0 instanceof com.android.server.pm.SharedUserSetting;
        if (r3 == 0) goto L_0x0456;
    L_0x0184:
        r0 = r41;
        r4 = r0.name;
        r5 = 0;
        r0 = r41;
        r6 = r0.realName;
        r7 = r31;
        r7 = (com.android.server.pm.SharedUserSetting) r7;
        r0 = r41;
        r8 = r0.codePath;
        r0 = r41;
        r9 = r0.resourcePath;
        r0 = r41;
        r10 = r0.legacyNativeLibraryPathString;
        r0 = r41;
        r11 = r0.primaryCpuAbiString;
        r0 = r41;
        r12 = r0.secondaryCpuAbiString;
        r0 = r41;
        r13 = r0.versionCode;
        r0 = r41;
        r14 = r0.pkgFlags;
        r15 = 0;
        r16 = 1;
        r17 = 0;
        r3 = r49;
        r39 = r3.getPackageLPw(r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17);
        if (r39 != 0) goto L_0x044d;
    L_0x01ba:
        r3 = 5;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Unable to create application package for ";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.name;
        r4 = r4.append(r5);
        r4 = r4.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r3, r4);
    L_0x01d5:
        r28 = r28 + 1;
        goto L_0x0160;
    L_0x01d8:
        r3 = "permissions";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x0232;
    L_0x01e2:
        r0 = r49;
        r3 = r0.mPermissions;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r49;
        r1 = r40;
        r0.readPermissionsLPw(r3, r1);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x01ef:
        r24 = move-exception;
        r0 = r49;
        r3 = r0.mReadMessages;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Error reading: ";
        r4 = r4.append(r5);
        r5 = r24.toString();
        r4 = r4.append(r5);
        r4 = r4.toString();
        r3.append(r4);
        r3 = 6;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Error reading settings: ";
        r4 = r4.append(r5);
        r0 = r24;
        r4 = r4.append(r0);
        r4 = r4.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r3, r4);
        r3 = "PackageManager";
        r4 = "Error reading package manager settings";
        r0 = r24;
        android.util.Slog.wtf(r3, r4, r0);
        goto L_0x0156;
    L_0x0232:
        r3 = "permission-trees";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x0249;
    L_0x023c:
        r0 = r49;
        r3 = r0.mPermissionTrees;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r49;
        r1 = r40;
        r0.readPermissionsLPw(r3, r1);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x0249:
        r3 = "shared-user";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x025c;
    L_0x0253:
        r0 = r49;
        r1 = r40;
        r0.readSharedUserLPw(r1);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x025c:
        r3 = "preferred-packages";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 != 0) goto L_0x00df;
    L_0x0266:
        r3 = "preferred-activities";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x027a;
    L_0x0270:
        r3 = 0;
        r0 = r49;
        r1 = r40;
        r0.readPreferredActivitiesLPw(r1, r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x027a:
        r3 = "persistent-preferred-activities";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x028e;
    L_0x0284:
        r3 = 0;
        r0 = r49;
        r1 = r40;
        r0.readPersistentPreferredActivitiesLPw(r1, r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x028e:
        r3 = "crossProfile-intent-filters";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x02a2;
    L_0x0298:
        r3 = 0;
        r0 = r49;
        r1 = r40;
        r0.readCrossProfileIntentFiltersLPw(r1, r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x02a2:
        r3 = "updated-package";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x02b5;
    L_0x02ac:
        r0 = r49;
        r1 = r40;
        r0.readDisabledSysPackageLPw(r1);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x02b5:
        r3 = "cleaning-package";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x02fe;
    L_0x02bf:
        r3 = 0;
        r4 = "name";
        r0 = r40;
        r35 = r0.getAttributeValue(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = 0;
        r4 = "user";
        r0 = r40;
        r48 = r0.getAttributeValue(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = 0;
        r4 = "code";
        r0 = r40;
        r20 = r0.getAttributeValue(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r35 == 0) goto L_0x00df;
    L_0x02dc:
        r47 = 0;
        r19 = 1;
        if (r48 == 0) goto L_0x02e6;
    L_0x02e2:
        r47 = java.lang.Integer.parseInt(r48);	 Catch:{ NumberFormatException -> 0x0595 }
    L_0x02e6:
        if (r20 == 0) goto L_0x02ec;
    L_0x02e8:
        r19 = java.lang.Boolean.parseBoolean(r20);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
    L_0x02ec:
        r3 = new android.content.pm.PackageCleanItem;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r47;
        r1 = r35;
        r2 = r19;
        r3.<init>(r0, r1, r2);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r49;
        r0.addPackageToCleanLPw(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x02fe:
        r3 = "renamed-package";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x032b;
    L_0x0308:
        r3 = 0;
        r4 = "new";
        r0 = r40;
        r36 = r0.getAttributeValue(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = 0;
        r4 = "old";
        r0 = r40;
        r37 = r0.getAttributeValue(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r36 == 0) goto L_0x00df;
    L_0x031c:
        if (r37 == 0) goto L_0x00df;
    L_0x031e:
        r0 = r49;
        r3 = r0.mRenamedPackages;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r36;
        r1 = r37;
        r3.put(r0, r1);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x032b:
        r3 = "last-platform-version";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x0373;
    L_0x0335:
        r3 = 0;
        r0 = r49;
        r0.mExternalSdkPlatform = r3;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r49;
        r0.mInternalSdkPlatform = r3;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = 0;
        r4 = "internal";
        r0 = r40;
        r32 = r0.getAttributeValue(r3, r4);	 Catch:{ NumberFormatException -> 0x0598 }
        if (r32 == 0) goto L_0x0351;
    L_0x0349:
        r3 = java.lang.Integer.parseInt(r32);	 Catch:{ NumberFormatException -> 0x0598 }
        r0 = r49;
        r0.mInternalSdkPlatform = r3;	 Catch:{ NumberFormatException -> 0x0598 }
    L_0x0351:
        r3 = 0;
        r4 = "external";
        r0 = r40;
        r26 = r0.getAttributeValue(r3, r4);	 Catch:{ NumberFormatException -> 0x0598 }
        if (r26 == 0) goto L_0x0364;
    L_0x035c:
        r3 = java.lang.Integer.parseInt(r26);	 Catch:{ NumberFormatException -> 0x0598 }
        r0 = r49;
        r0.mExternalSdkPlatform = r3;	 Catch:{ NumberFormatException -> 0x0598 }
    L_0x0364:
        r3 = 0;
        r4 = "fingerprint";
        r0 = r40;
        r3 = r0.getAttributeValue(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r49;
        r0.mFingerprint = r3;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x0373:
        r3 = "database-version";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x03b1;
    L_0x037d:
        r3 = 0;
        r0 = r49;
        r0.mExternalDatabaseVersion = r3;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r49;
        r0.mInternalDatabaseVersion = r3;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = 0;
        r4 = "internal";
        r0 = r40;
        r33 = r0.getAttributeValue(r3, r4);	 Catch:{ NumberFormatException -> 0x03ae }
        if (r33 == 0) goto L_0x0399;
    L_0x0391:
        r3 = java.lang.Integer.parseInt(r33);	 Catch:{ NumberFormatException -> 0x03ae }
        r0 = r49;
        r0.mInternalDatabaseVersion = r3;	 Catch:{ NumberFormatException -> 0x03ae }
    L_0x0399:
        r3 = 0;
        r4 = "external";
        r0 = r40;
        r27 = r0.getAttributeValue(r3, r4);	 Catch:{ NumberFormatException -> 0x03ae }
        if (r27 == 0) goto L_0x00df;
    L_0x03a4:
        r3 = java.lang.Integer.parseInt(r27);	 Catch:{ NumberFormatException -> 0x03ae }
        r0 = r49;
        r0.mExternalDatabaseVersion = r3;	 Catch:{ NumberFormatException -> 0x03ae }
        goto L_0x00df;
    L_0x03ae:
        r3 = move-exception;
        goto L_0x00df;
    L_0x03b1:
        r3 = "verifier";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x03ed;
    L_0x03bb:
        r3 = 0;
        r4 = "device";
        r0 = r40;
        r21 = r0.getAttributeValue(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = android.content.pm.VerifierDeviceIdentity.parse(r21);	 Catch:{ IllegalArgumentException -> 0x03ce }
        r0 = r49;
        r0.mVerifierDeviceIdentity = r3;	 Catch:{ IllegalArgumentException -> 0x03ce }
        goto L_0x00df;
    L_0x03ce:
        r24 = move-exception;
        r3 = "PackageManager";
        r4 = new java.lang.StringBuilder;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r4.<init>();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r5 = "Discard invalid verifier device id: ";
        r4 = r4.append(r5);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r5 = r24.getMessage();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r4 = r4.append(r5);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r4 = r4.toString();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        android.util.Slog.w(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x03ed:
        r3 = "read-external-storage";
        r0 = r44;
        r3 = r3.equals(r0);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x0412;
    L_0x03f7:
        r3 = 0;
        r4 = "enforcement";
        r0 = r40;
        r25 = r0.getAttributeValue(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = "1";
        r0 = r25;
        r3 = r3.equals(r0);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r3 = java.lang.Boolean.valueOf(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r49;
        r0.mReadExternalStorageEnforced = r3;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x0412:
        r3 = "keyset-settings";
        r0 = r44;
        r3 = r0.equals(r3);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        if (r3 == 0) goto L_0x0427;
    L_0x041c:
        r0 = r49;
        r3 = r0.mKeySetManagerService;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r0 = r40;
        r3.readKeySetsLPw(r0);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x0427:
        r3 = "PackageManager";
        r4 = new java.lang.StringBuilder;	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r4.<init>();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r5 = "Unknown element under <packages>: ";
        r4 = r4.append(r5);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r5 = r40.getName();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r4 = r4.append(r5);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        r4 = r4.toString();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        android.util.Slog.w(r3, r4);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        com.android.internal.util.XmlUtils.skipCurrentTag(r40);	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x00df;
    L_0x0448:
        r42.close();	 Catch:{ XmlPullParserException -> 0x0115, IOException -> 0x01ef }
        goto L_0x0156;
    L_0x044d:
        r0 = r39;
        r1 = r41;
        r0.copyFrom(r1);
        goto L_0x01d5;
    L_0x0456:
        if (r31 == 0) goto L_0x0494;
    L_0x0458:
        r3 = new java.lang.StringBuilder;
        r3.<init>();
        r4 = "Bad package setting: package ";
        r3 = r3.append(r4);
        r0 = r41;
        r4 = r0.name;
        r3 = r3.append(r4);
        r4 = " has shared uid ";
        r3 = r3.append(r4);
        r0 = r41;
        r4 = r0.sharedId;
        r3 = r3.append(r4);
        r4 = " that is not a shared uid\n";
        r3 = r3.append(r4);
        r34 = r3.toString();
        r0 = r49;
        r3 = r0.mReadMessages;
        r0 = r34;
        r3.append(r0);
        r3 = 6;
        r0 = r34;
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r3, r0);
        goto L_0x01d5;
    L_0x0494:
        r3 = new java.lang.StringBuilder;
        r3.<init>();
        r4 = "Bad package setting: package ";
        r3 = r3.append(r4);
        r0 = r41;
        r4 = r0.name;
        r3 = r3.append(r4);
        r4 = " has shared uid ";
        r3 = r3.append(r4);
        r0 = r41;
        r4 = r0.sharedId;
        r3 = r3.append(r4);
        r4 = " that is not defined\n";
        r3 = r3.append(r4);
        r34 = r3.toString();
        r0 = r49;
        r3 = r0.mReadMessages;
        r0 = r34;
        r3.append(r0);
        r3 = 6;
        r0 = r34;
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r3, r0);
        goto L_0x01d5;
    L_0x04d0:
        r0 = r49;
        r3 = r0.mPendingPackages;
        r3.clear();
        r0 = r49;
        r3 = r0.mBackupStoppedPackagesFilename;
        r3 = r3.exists();
        if (r3 != 0) goto L_0x04eb;
    L_0x04e1:
        r0 = r49;
        r3 = r0.mStoppedPackagesFilename;
        r3 = r3.exists();
        if (r3 == 0) goto L_0x0535;
    L_0x04eb:
        r49.readStoppedLPw();
        r0 = r49;
        r3 = r0.mBackupStoppedPackagesFilename;
        r3.delete();
        r0 = r49;
        r3 = r0.mStoppedPackagesFilename;
        r3.delete();
        r3 = 0;
        r0 = r49;
        r0.writePackageRestrictionsLPr(r3);
    L_0x0502:
        r0 = r49;
        r3 = r0.mDisabledSysPackages;
        r3 = r3.values();
        r22 = r3.iterator();
    L_0x050e:
        r3 = r22.hasNext();
        if (r3 == 0) goto L_0x0558;
    L_0x0514:
        r23 = r22.next();
        r23 = (com.android.server.pm.PackageSetting) r23;
        r0 = r23;
        r3 = r0.appId;
        r0 = r49;
        r30 = r0.getUserIdLPr(r3);
        if (r30 == 0) goto L_0x050e;
    L_0x0526:
        r0 = r30;
        r3 = r0 instanceof com.android.server.pm.SharedUserSetting;
        if (r3 == 0) goto L_0x050e;
    L_0x052c:
        r30 = (com.android.server.pm.SharedUserSetting) r30;
        r0 = r30;
        r1 = r23;
        r1.sharedUser = r0;
        goto L_0x050e;
    L_0x0535:
        if (r51 != 0) goto L_0x053e;
    L_0x0537:
        r3 = 0;
        r0 = r49;
        r0.readPackageRestrictionsLPr(r3);
        goto L_0x0502;
    L_0x053e:
        r29 = r51.iterator();
    L_0x0542:
        r3 = r29.hasNext();
        if (r3 == 0) goto L_0x0502;
    L_0x0548:
        r46 = r29.next();
        r46 = (android.content.pm.UserInfo) r46;
        r0 = r46;
        r3 = r0.id;
        r0 = r49;
        r0.readPackageRestrictionsLPr(r3);
        goto L_0x0542;
    L_0x0558:
        r0 = r49;
        r3 = r0.mReadMessages;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Read completed successfully: ";
        r4 = r4.append(r5);
        r0 = r49;
        r5 = r0.mPackages;
        r5 = r5.size();
        r4 = r4.append(r5);
        r5 = " packages, ";
        r4 = r4.append(r5);
        r0 = r49;
        r5 = r0.mSharedUsers;
        r5 = r5.size();
        r4 = r4.append(r5);
        r5 = " shared uids\n";
        r4 = r4.append(r5);
        r4 = r4.toString();
        r3.append(r4);
        r3 = 1;
        goto L_0x0091;
    L_0x0595:
        r3 = move-exception;
        goto L_0x02e6;
    L_0x0598:
        r3 = move-exception;
        goto L_0x0364;
    L_0x059b:
        r3 = move-exception;
        goto L_0x0055;
    L_0x059e:
        r3 = move-exception;
        r42 = r43;
        goto L_0x0055;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.Settings.readLPw(com.android.server.pm.PackageManagerService, java.util.List, int, boolean):boolean");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void readDefaultPreferredAppsLPw(com.android.server.pm.PackageManagerService r22, int r23) {
        /*
        r21 = this;
        r0 = r21;
        r0 = r0.mPackages;
        r18 = r0;
        r18 = r18.values();
        r9 = r18.iterator();
    L_0x000e:
        r18 = r9.hasNext();
        if (r18 == 0) goto L_0x006c;
    L_0x0014:
        r14 = r9.next();
        r14 = (com.android.server.pm.PackageSetting) r14;
        r0 = r14.pkgFlags;
        r18 = r0;
        r18 = r18 & 1;
        if (r18 == 0) goto L_0x000e;
    L_0x0022:
        r0 = r14.pkg;
        r18 = r0;
        if (r18 == 0) goto L_0x000e;
    L_0x0028:
        r0 = r14.pkg;
        r18 = r0;
        r0 = r18;
        r0 = r0.preferredActivityFilters;
        r18 = r0;
        if (r18 == 0) goto L_0x000e;
    L_0x0034:
        r0 = r14.pkg;
        r18 = r0;
        r0 = r18;
        r10 = r0.preferredActivityFilters;
        r8 = 0;
    L_0x003d:
        r18 = r10.size();
        r0 = r18;
        if (r8 >= r0) goto L_0x000e;
    L_0x0045:
        r4 = r10.get(r8);
        r4 = (android.content.pm.PackageParser.ActivityIntentInfo) r4;
        r18 = new android.content.ComponentName;
        r0 = r14.name;
        r19 = r0;
        r0 = r4.activity;
        r20 = r0;
        r0 = r20;
        r0 = r0.className;
        r20 = r0;
        r18.<init>(r19, r20);
        r0 = r21;
        r1 = r22;
        r2 = r18;
        r3 = r23;
        r0.applyDefaultPreferredActivityLPw(r1, r4, r2, r3);
        r8 = r8 + 1;
        goto L_0x003d;
    L_0x006c:
        r13 = new java.io.File;
        r18 = android.os.Environment.getRootDirectory();
        r19 = "etc/preferred-apps";
        r0 = r18;
        r1 = r19;
        r13.<init>(r0, r1);
        r18 = r13.exists();
        if (r18 == 0) goto L_0x0087;
    L_0x0081:
        r18 = r13.isDirectory();
        if (r18 != 0) goto L_0x0088;
    L_0x0087:
        return;
    L_0x0088:
        r18 = r13.canRead();
        if (r18 != 0) goto L_0x00af;
    L_0x008e:
        r18 = "PackageSettings";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "Directory ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r13);
        r20 = " cannot be read";
        r19 = r19.append(r20);
        r19 = r19.toString();
        android.util.Slog.w(r18, r19);
        goto L_0x0087;
    L_0x00af:
        r5 = r13.listFiles();
        r11 = r5.length;
        r9 = 0;
    L_0x00b5:
        if (r9 >= r11) goto L_0x0087;
    L_0x00b7:
        r7 = r5[r9];
        r18 = r7.getPath();
        r19 = ".xml";
        r18 = r18.endsWith(r19);
        if (r18 != 0) goto L_0x00f4;
    L_0x00c5:
        r18 = "PackageSettings";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "Non-xml file ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r7);
        r20 = " in ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r13);
        r20 = " directory, ignoring";
        r19 = r19.append(r20);
        r19 = r19.toString();
        android.util.Slog.i(r18, r19);
    L_0x00f1:
        r9 = r9 + 1;
        goto L_0x00b5;
    L_0x00f4:
        r18 = r7.canRead();
        if (r18 != 0) goto L_0x011b;
    L_0x00fa:
        r18 = "PackageSettings";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "Preferred apps file ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r7);
        r20 = " cannot be read";
        r19 = r19.append(r20);
        r19 = r19.toString();
        android.util.Slog.w(r18, r19);
        goto L_0x00f1;
    L_0x011b:
        r15 = 0;
        r16 = new java.io.FileInputStream;	 Catch:{ XmlPullParserException -> 0x01be, IOException -> 0x01e7 }
        r0 = r16;
        r0.<init>(r7);	 Catch:{ XmlPullParserException -> 0x01be, IOException -> 0x01e7 }
        r12 = android.util.Xml.newPullParser();	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r18 = 0;
        r0 = r16;
        r1 = r18;
        r12.setInput(r0, r1);	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
    L_0x0130:
        r17 = r12.next();	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r18 = 2;
        r0 = r17;
        r1 = r18;
        if (r0 == r1) goto L_0x0144;
    L_0x013c:
        r18 = 1;
        r0 = r17;
        r1 = r18;
        if (r0 != r1) goto L_0x0130;
    L_0x0144:
        r18 = 2;
        r0 = r17;
        r1 = r18;
        if (r0 == r1) goto L_0x0175;
    L_0x014c:
        r18 = "PackageSettings";
        r19 = new java.lang.StringBuilder;	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r19.<init>();	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r20 = "Preferred apps file ";
        r19 = r19.append(r20);	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r0 = r19;
        r19 = r0.append(r7);	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r20 = " does not have start tag";
        r19 = r19.append(r20);	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r19 = r19.toString();	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        android.util.Slog.w(r18, r19);	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        if (r16 == 0) goto L_0x00f1;
    L_0x016e:
        r16.close();	 Catch:{ IOException -> 0x0172 }
        goto L_0x00f1;
    L_0x0172:
        r18 = move-exception;
        goto L_0x00f1;
    L_0x0175:
        r18 = "preferred-activities";
        r19 = r12.getName();	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r18 = r18.equals(r19);	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        if (r18 != 0) goto L_0x01ab;
    L_0x0181:
        r18 = "PackageSettings";
        r19 = new java.lang.StringBuilder;	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r19.<init>();	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r20 = "Preferred apps file ";
        r19 = r19.append(r20);	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r0 = r19;
        r19 = r0.append(r7);	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r20 = " does not start with 'preferred-activities'";
        r19 = r19.append(r20);	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        r19 = r19.toString();	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        android.util.Slog.w(r18, r19);	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        if (r16 == 0) goto L_0x00f1;
    L_0x01a3:
        r16.close();	 Catch:{ IOException -> 0x01a8 }
        goto L_0x00f1;
    L_0x01a8:
        r18 = move-exception;
        goto L_0x00f1;
    L_0x01ab:
        r0 = r21;
        r1 = r22;
        r2 = r23;
        r0.readDefaultPreferredActivitiesLPw(r1, r12, r2);	 Catch:{ XmlPullParserException -> 0x0221, IOException -> 0x021d, all -> 0x0219 }
        if (r16 == 0) goto L_0x00f1;
    L_0x01b6:
        r16.close();	 Catch:{ IOException -> 0x01bb }
        goto L_0x00f1;
    L_0x01bb:
        r18 = move-exception;
        goto L_0x00f1;
    L_0x01be:
        r6 = move-exception;
    L_0x01bf:
        r18 = "PackageSettings";
        r19 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0210 }
        r19.<init>();	 Catch:{ all -> 0x0210 }
        r20 = "Error reading apps file ";
        r19 = r19.append(r20);	 Catch:{ all -> 0x0210 }
        r0 = r19;
        r19 = r0.append(r7);	 Catch:{ all -> 0x0210 }
        r19 = r19.toString();	 Catch:{ all -> 0x0210 }
        r0 = r18;
        r1 = r19;
        android.util.Slog.w(r0, r1, r6);	 Catch:{ all -> 0x0210 }
        if (r15 == 0) goto L_0x00f1;
    L_0x01df:
        r15.close();	 Catch:{ IOException -> 0x01e4 }
        goto L_0x00f1;
    L_0x01e4:
        r18 = move-exception;
        goto L_0x00f1;
    L_0x01e7:
        r6 = move-exception;
    L_0x01e8:
        r18 = "PackageSettings";
        r19 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0210 }
        r19.<init>();	 Catch:{ all -> 0x0210 }
        r20 = "Error reading apps file ";
        r19 = r19.append(r20);	 Catch:{ all -> 0x0210 }
        r0 = r19;
        r19 = r0.append(r7);	 Catch:{ all -> 0x0210 }
        r19 = r19.toString();	 Catch:{ all -> 0x0210 }
        r0 = r18;
        r1 = r19;
        android.util.Slog.w(r0, r1, r6);	 Catch:{ all -> 0x0210 }
        if (r15 == 0) goto L_0x00f1;
    L_0x0208:
        r15.close();	 Catch:{ IOException -> 0x020d }
        goto L_0x00f1;
    L_0x020d:
        r18 = move-exception;
        goto L_0x00f1;
    L_0x0210:
        r18 = move-exception;
    L_0x0211:
        if (r15 == 0) goto L_0x0216;
    L_0x0213:
        r15.close();	 Catch:{ IOException -> 0x0217 }
    L_0x0216:
        throw r18;
    L_0x0217:
        r19 = move-exception;
        goto L_0x0216;
    L_0x0219:
        r18 = move-exception;
        r15 = r16;
        goto L_0x0211;
    L_0x021d:
        r6 = move-exception;
        r15 = r16;
        goto L_0x01e8;
    L_0x0221:
        r6 = move-exception;
        r15 = r16;
        goto L_0x01bf;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.Settings.readDefaultPreferredAppsLPw(com.android.server.pm.PackageManagerService, int):void");
    }

    private void applyDefaultPreferredActivityLPw(PackageManagerService service, IntentFilter tmpPa, ComponentName cn, int userId) {
        int ischeme;
        Intent intent = new Intent();
        int flags = 0;
        intent.setAction(tmpPa.getAction(0));
        for (int i = 0; i < tmpPa.countCategories(); i++) {
            String cat = tmpPa.getCategory(i);
            if (cat.equals("android.intent.category.DEFAULT")) {
                flags |= 65536;
            } else {
                intent.addCategory(cat);
            }
        }
        boolean doNonData = true;
        boolean hasSchemes = DEBUG_STOPPED;
        for (ischeme = 0; ischeme < tmpPa.countDataSchemes(); ischeme++) {
            boolean doScheme = true;
            String scheme = tmpPa.getDataScheme(ischeme);
            if (!(scheme == null || scheme.isEmpty())) {
                hasSchemes = true;
            }
            for (int issp = 0; issp < tmpPa.countDataSchemeSpecificParts(); issp++) {
                Builder builder = new Builder();
                builder.scheme(scheme);
                PatternMatcher ssp = tmpPa.getDataSchemeSpecificPart(issp);
                builder.opaquePart(ssp.getPath());
                Intent finalIntent = new Intent(intent);
                finalIntent.setData(builder.build());
                applyDefaultPreferredActivityLPw(service, finalIntent, flags, cn, scheme, ssp, null, null, userId);
                doScheme = DEBUG_STOPPED;
            }
            for (int iauth = 0; iauth < tmpPa.countDataAuthorities(); iauth++) {
                int doAuth = 1;
                AuthorityEntry auth = tmpPa.getDataAuthority(iauth);
                for (int ipath = 0; ipath < tmpPa.countDataPaths(); ipath++) {
                    builder = new Builder();
                    builder.scheme(scheme);
                    if (auth.getHost() != null) {
                        builder.authority(auth.getHost());
                    }
                    PatternMatcher path = tmpPa.getDataPath(ipath);
                    builder.path(path.getPath());
                    finalIntent = new Intent(intent);
                    finalIntent.setData(builder.build());
                    applyDefaultPreferredActivityLPw(service, finalIntent, flags, cn, scheme, null, auth, path, userId);
                    doScheme = DEBUG_STOPPED;
                    doAuth = 0;
                }
                if (doAuth != 0) {
                    builder = new Builder();
                    builder.scheme(scheme);
                    if (auth.getHost() != null) {
                        builder.authority(auth.getHost());
                    }
                    finalIntent = new Intent(intent);
                    finalIntent.setData(builder.build());
                    applyDefaultPreferredActivityLPw(service, finalIntent, flags, cn, scheme, null, auth, null, userId);
                    doScheme = DEBUG_STOPPED;
                }
            }
            if (doScheme) {
                builder = new Builder();
                builder.scheme(scheme);
                finalIntent = new Intent(intent);
                finalIntent.setData(builder.build());
                applyDefaultPreferredActivityLPw(service, finalIntent, flags, cn, scheme, null, null, null, userId);
            }
            doNonData = DEBUG_STOPPED;
        }
        for (int idata = 0; idata < tmpPa.countDataTypes(); idata++) {
            String mimeType = tmpPa.getDataType(idata);
            if (hasSchemes) {
                builder = new Builder();
                for (ischeme = 0; ischeme < tmpPa.countDataSchemes(); ischeme++) {
                    scheme = tmpPa.getDataScheme(ischeme);
                    if (!(scheme == null || scheme.isEmpty())) {
                        finalIntent = new Intent(intent);
                        builder.scheme(scheme);
                        finalIntent.setDataAndType(builder.build(), mimeType);
                        applyDefaultPreferredActivityLPw(service, finalIntent, flags, cn, scheme, null, null, null, userId);
                    }
                }
            } else {
                finalIntent = new Intent(intent);
                finalIntent.setType(mimeType);
                applyDefaultPreferredActivityLPw(service, finalIntent, flags, cn, null, null, null, null, userId);
            }
            doNonData = DEBUG_STOPPED;
        }
        if (doNonData) {
            applyDefaultPreferredActivityLPw(service, intent, flags, cn, null, null, null, null, userId);
        }
    }

    private void applyDefaultPreferredActivityLPw(PackageManagerService service, Intent intent, int flags, ComponentName cn, String scheme, PatternMatcher ssp, AuthorityEntry auth, PatternMatcher path, int userId) {
        List<ResolveInfo> ri = service.mActivities.queryIntent(intent, intent.getType(), flags, 0);
        int systemMatch = 0;
        if (ri == null || ri.size() <= 1) {
            String str = " while setting preferred ";
            str = cn.flattenToShortString();
            Slog.w(TAG, "No potential matches found for " + intent + r19 + r19);
            return;
        }
        int i;
        boolean haveAct = DEBUG_STOPPED;
        ComponentName haveNonSys = null;
        ComponentName[] set = new ComponentName[ri.size()];
        for (i = 0; i < ri.size(); i++) {
            ActivityInfo ai = ((ResolveInfo) ri.get(i)).activityInfo;
            set[i] = new ComponentName(ai.packageName, ai.name);
            if ((ai.applicationInfo.flags & 1) == 0) {
                if (((ResolveInfo) ri.get(i)).match >= 0) {
                    haveNonSys = set[i];
                    break;
                }
            } else if (cn.getPackageName().equals(ai.packageName) && cn.getClassName().equals(ai.name)) {
                haveAct = true;
                systemMatch = ((ResolveInfo) ri.get(i)).match;
            }
        }
        if (haveNonSys != null && 0 < systemMatch) {
            haveNonSys = null;
        }
        if (haveAct && haveNonSys == null) {
            IntentFilter filter = new IntentFilter();
            if (intent.getAction() != null) {
                filter.addAction(intent.getAction());
            }
            if (intent.getCategories() != null) {
                for (String cat : intent.getCategories()) {
                    filter.addCategory(cat);
                }
            }
            if ((65536 & flags) != 0) {
                filter.addCategory("android.intent.category.DEFAULT");
            }
            if (scheme != null) {
                filter.addDataScheme(scheme);
            }
            if (ssp != null) {
                filter.addDataSchemeSpecificPart(ssp.getPath(), ssp.getType());
            }
            if (auth != null) {
                filter.addDataAuthority(auth);
            }
            if (path != null) {
                filter.addDataPath(path);
            }
            if (intent.getType() != null) {
                try {
                    filter.addDataType(intent.getType());
                } catch (MalformedMimeTypeException e) {
                    str = intent.getType();
                    str = " for ";
                    Slog.w(TAG, "Malformed mimetype " + r19 + r19 + cn);
                }
            }
            editPreferredActivitiesLPw(userId).addFilter(new PreferredActivity(filter, systemMatch, set, cn, true));
        } else if (haveNonSys == null) {
            StringBuilder sb = new StringBuilder();
            sb.append("No component ");
            sb.append(cn.flattenToShortString());
            sb.append(" found setting preferred ");
            sb.append(intent);
            sb.append("; possible matches are ");
            for (i = 0; i < set.length; i++) {
                if (i > 0) {
                    sb.append(", ");
                }
                sb.append(set[i].flattenToShortString());
            }
            Slog.w(TAG, sb.toString());
        } else {
            str = "; found third party match ";
            str = haveNonSys.flattenToShortString();
            Slog.i(TAG, "Not setting preferred " + intent + r19 + r19);
        }
    }

    private void readDefaultPreferredActivitiesLPw(PackageManagerService service, XmlPullParser parser, int userId) throws XmlPullParserException, IOException {
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == 1) {
                return;
            }
            if (type == CURRENT_DATABASE_VERSION && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == CURRENT_DATABASE_VERSION || type == 4)) {
                if (parser.getName().equals(TAG_ITEM)) {
                    PreferredActivity tmpPa = new PreferredActivity(parser);
                    if (tmpPa.mPref.getParseError() == null) {
                        applyDefaultPreferredActivityLPw(service, tmpPa, tmpPa.mPref.mComponent, userId);
                    } else {
                        PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: <preferred-activity> " + tmpPa.mPref.getParseError() + " at " + parser.getPositionDescription());
                    }
                } else {
                    PackageManagerService.reportSettingsProblem(5, "Unknown element under <preferred-activities>: " + parser.getName());
                    XmlUtils.skipCurrentTag(parser);
                }
            }
        }
    }

    private int readInt(XmlPullParser parser, String ns, String name, int defValue) {
        String v = parser.getAttributeValue(ns, name);
        if (v != null) {
            try {
                defValue = Integer.parseInt(v);
            } catch (NumberFormatException e) {
                PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: attribute " + name + " has bad integer value " + v + " at " + parser.getPositionDescription());
            }
        }
        return defValue;
    }

    private void readPermissionsLPw(ArrayMap<String, BasePermission> out, XmlPullParser parser) throws IOException, XmlPullParserException {
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == 1) {
                return;
            }
            if (type == CURRENT_DATABASE_VERSION && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == CURRENT_DATABASE_VERSION || type == 4)) {
                if (parser.getName().equals(TAG_ITEM)) {
                    String name = parser.getAttributeValue(null, ATTR_NAME);
                    String sourcePackage = parser.getAttributeValue(null, "package");
                    String ptype = parser.getAttributeValue(null, SoundModelContract.KEY_TYPE);
                    if (name == null || sourcePackage == null) {
                        PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: permissions has no name at " + parser.getPositionDescription());
                    } else {
                        boolean dynamic = "dynamic".equals(ptype);
                        BasePermission bp = new BasePermission(name, sourcePackage, dynamic ? 2 : 0);
                        bp.protectionLevel = readInt(parser, null, "protection", 0);
                        bp.protectionLevel = PermissionInfo.fixProtectionLevel(bp.protectionLevel);
                        if (dynamic) {
                            PermissionInfo pi = new PermissionInfo();
                            pi.packageName = sourcePackage.intern();
                            pi.name = name.intern();
                            pi.icon = readInt(parser, null, "icon", 0);
                            pi.nonLocalizedLabel = parser.getAttributeValue(null, "label");
                            pi.protectionLevel = bp.protectionLevel;
                            bp.pendingInfo = pi;
                        }
                        out.put(bp.name, bp);
                    }
                } else {
                    PackageManagerService.reportSettingsProblem(5, "Unknown element reading permissions: " + parser.getName() + " at " + parser.getPositionDescription());
                }
                XmlUtils.skipCurrentTag(parser);
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void readDisabledSysPackageLPw(org.xmlpull.v1.XmlPullParser r29) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
        /*
        r28 = this;
        r6 = 0;
        r25 = "name";
        r0 = r29;
        r1 = r25;
        r3 = r0.getAttributeValue(r6, r1);
        r6 = 0;
        r25 = "realName";
        r0 = r29;
        r1 = r25;
        r4 = r0.getAttributeValue(r6, r1);
        r6 = 0;
        r25 = "codePath";
        r0 = r29;
        r1 = r25;
        r13 = r0.getAttributeValue(r6, r1);
        r6 = 0;
        r25 = "resourcePath";
        r0 = r29;
        r1 = r25;
        r17 = r0.getAttributeValue(r6, r1);
        r6 = 0;
        r25 = "requiredCpuAbi";
        r0 = r29;
        r1 = r25;
        r15 = r0.getAttributeValue(r6, r1);
        r6 = 0;
        r25 = "nativeLibraryPath";
        r0 = r29;
        r1 = r25;
        r7 = r0.getAttributeValue(r6, r1);
        r6 = 0;
        r25 = "primaryCpuAbi";
        r0 = r29;
        r1 = r25;
        r8 = r0.getAttributeValue(r6, r1);
        r6 = 0;
        r25 = "secondaryCpuAbi";
        r0 = r29;
        r1 = r25;
        r9 = r0.getAttributeValue(r6, r1);
        r6 = 0;
        r25 = "cpuAbiOverride";
        r0 = r29;
        r1 = r25;
        r10 = r0.getAttributeValue(r6, r1);
        if (r8 != 0) goto L_0x0068;
    L_0x0065:
        if (r15 == 0) goto L_0x0068;
    L_0x0067:
        r8 = r15;
    L_0x0068:
        if (r17 != 0) goto L_0x006c;
    L_0x006a:
        r17 = r13;
    L_0x006c:
        r6 = 0;
        r25 = "version";
        r0 = r29;
        r1 = r25;
        r24 = r0.getAttributeValue(r6, r1);
        r11 = 0;
        if (r24 == 0) goto L_0x007e;
    L_0x007a:
        r11 = java.lang.Integer.parseInt(r24);	 Catch:{ NumberFormatException -> 0x0196 }
    L_0x007e:
        r12 = 0;
        r12 = r12 | 1;
        r5 = new java.io.File;
        r5.<init>(r13);
        r6 = com.android.server.pm.PackageManagerService.locationIsPrivileged(r5);
        if (r6 == 0) goto L_0x0090;
    L_0x008c:
        r6 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r12 = r6 | 1;
    L_0x0090:
        r2 = new com.android.server.pm.PackageSetting;
        r6 = new java.io.File;
        r0 = r17;
        r6.<init>(r0);
        r2.<init>(r3, r4, r5, r6, r7, r8, r9, r10, r11, r12);
        r6 = 0;
        r25 = "ft";
        r0 = r29;
        r1 = r25;
        r22 = r0.getAttributeValue(r6, r1);
        if (r22 == 0) goto L_0x014e;
    L_0x00a9:
        r6 = 16;
        r0 = r22;
        r20 = java.lang.Long.parseLong(r0, r6);	 Catch:{ NumberFormatException -> 0x019f }
        r0 = r20;
        r2.setTimeStamp(r0);	 Catch:{ NumberFormatException -> 0x019f }
    L_0x00b6:
        r6 = 0;
        r25 = "it";
        r0 = r29;
        r1 = r25;
        r22 = r0.getAttributeValue(r6, r1);
        if (r22 == 0) goto L_0x00cf;
    L_0x00c3:
        r6 = 16;
        r0 = r22;
        r26 = java.lang.Long.parseLong(r0, r6);	 Catch:{ NumberFormatException -> 0x019c }
        r0 = r26;
        r2.firstInstallTime = r0;	 Catch:{ NumberFormatException -> 0x019c }
    L_0x00cf:
        r6 = 0;
        r25 = "ut";
        r0 = r29;
        r1 = r25;
        r22 = r0.getAttributeValue(r6, r1);
        if (r22 == 0) goto L_0x00e8;
    L_0x00dc:
        r6 = 16;
        r0 = r22;
        r26 = java.lang.Long.parseLong(r0, r6);	 Catch:{ NumberFormatException -> 0x0199 }
        r0 = r26;
        r2.lastUpdateTime = r0;	 Catch:{ NumberFormatException -> 0x0199 }
    L_0x00e8:
        r6 = 0;
        r25 = "userId";
        r0 = r29;
        r1 = r25;
        r14 = r0.getAttributeValue(r6, r1);
        if (r14 == 0) goto L_0x0169;
    L_0x00f5:
        r6 = java.lang.Integer.parseInt(r14);
    L_0x00f9:
        r2.appId = r6;
        r6 = r2.appId;
        if (r6 > 0) goto L_0x0112;
    L_0x00ff:
        r6 = 0;
        r25 = "sharedUserId";
        r0 = r29;
        r1 = r25;
        r18 = r0.getAttributeValue(r6, r1);
        if (r18 == 0) goto L_0x016b;
    L_0x010c:
        r6 = java.lang.Integer.parseInt(r18);
    L_0x0110:
        r2.appId = r6;
    L_0x0112:
        r16 = r29.getDepth();
    L_0x0116:
        r23 = r29.next();
        r6 = 1;
        r0 = r23;
        if (r0 == r6) goto L_0x018e;
    L_0x011f:
        r6 = 3;
        r0 = r23;
        if (r0 != r6) goto L_0x012c;
    L_0x0124:
        r6 = r29.getDepth();
        r0 = r16;
        if (r6 <= r0) goto L_0x018e;
    L_0x012c:
        r6 = 3;
        r0 = r23;
        if (r0 == r6) goto L_0x0116;
    L_0x0131:
        r6 = 4;
        r0 = r23;
        if (r0 == r6) goto L_0x0116;
    L_0x0136:
        r19 = r29.getName();
        r6 = "perms";
        r0 = r19;
        r6 = r0.equals(r6);
        if (r6 == 0) goto L_0x016d;
    L_0x0144:
        r6 = r2.grantedPermissions;
        r0 = r28;
        r1 = r29;
        r0.readGrantedPermissionsLPw(r1, r6);
        goto L_0x0116;
    L_0x014e:
        r6 = 0;
        r25 = "ts";
        r0 = r29;
        r1 = r25;
        r22 = r0.getAttributeValue(r6, r1);
        if (r22 == 0) goto L_0x00b6;
    L_0x015b:
        r20 = java.lang.Long.parseLong(r22);	 Catch:{ NumberFormatException -> 0x0166 }
        r0 = r20;
        r2.setTimeStamp(r0);	 Catch:{ NumberFormatException -> 0x0166 }
        goto L_0x00b6;
    L_0x0166:
        r6 = move-exception;
        goto L_0x00b6;
    L_0x0169:
        r6 = 0;
        goto L_0x00f9;
    L_0x016b:
        r6 = 0;
        goto L_0x0110;
    L_0x016d:
        r6 = 5;
        r25 = new java.lang.StringBuilder;
        r25.<init>();
        r26 = "Unknown element under <updated-package>: ";
        r25 = r25.append(r26);
        r26 = r29.getName();
        r25 = r25.append(r26);
        r25 = r25.toString();
        r0 = r25;
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r6, r0);
        com.android.internal.util.XmlUtils.skipCurrentTag(r29);
        goto L_0x0116;
    L_0x018e:
        r0 = r28;
        r6 = r0.mDisabledSysPackages;
        r6.put(r3, r2);
        return;
    L_0x0196:
        r6 = move-exception;
        goto L_0x007e;
    L_0x0199:
        r6 = move-exception;
        goto L_0x00e8;
    L_0x019c:
        r6 = move-exception;
        goto L_0x00cf;
    L_0x019f:
        r6 = move-exception;
        goto L_0x00b6;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.Settings.readDisabledSysPackageLPw(org.xmlpull.v1.XmlPullParser):void");
    }

    private void readPackageLPw(XmlPullParser parser) throws XmlPullParserException, IOException {
        PackageSettingBase packageSetting;
        String enabledStr;
        String installStatusStr;
        int outerDepth;
        int type;
        String tagName;
        String name = null;
        String idStr = null;
        String legacyNativeLibraryPathStr = null;
        String primaryCpuAbiString = null;
        String secondaryCpuAbiString = null;
        String installerPackageName = null;
        String uidError = null;
        int pkgFlags = 0;
        long timeStamp = 0;
        long firstInstallTime = 0;
        long lastUpdateTime = 0;
        int versionCode = 0;
        try {
            name = parser.getAttributeValue(null, ATTR_NAME);
            String realName = parser.getAttributeValue(null, "realName");
            idStr = parser.getAttributeValue(null, "userId");
            uidError = parser.getAttributeValue(null, "uidError");
            String sharedIdStr = parser.getAttributeValue(null, "sharedUserId");
            String codePathStr = parser.getAttributeValue(null, "codePath");
            String resourcePathStr = parser.getAttributeValue(null, "resourcePath");
            String legacyCpuAbiString = parser.getAttributeValue(null, "requiredCpuAbi");
            legacyNativeLibraryPathStr = parser.getAttributeValue(null, "nativeLibraryPath");
            primaryCpuAbiString = parser.getAttributeValue(null, "primaryCpuAbi");
            secondaryCpuAbiString = parser.getAttributeValue(null, "secondaryCpuAbi");
            String cpuAbiOverrideString = parser.getAttributeValue(null, "cpuAbiOverride");
            if (primaryCpuAbiString == null && legacyCpuAbiString != null) {
                primaryCpuAbiString = legacyCpuAbiString;
            }
            String version = parser.getAttributeValue(null, "version");
            if (version != null) {
                try {
                    versionCode = Integer.parseInt(version);
                } catch (NumberFormatException e) {
                }
            }
            installerPackageName = parser.getAttributeValue(null, "installer");
            String systemStr = parser.getAttributeValue(null, "flags");
            if (systemStr != null) {
                try {
                    pkgFlags = Integer.parseInt(systemStr);
                } catch (NumberFormatException e2) {
                }
            } else {
                systemStr = parser.getAttributeValue(null, "system");
                if (systemStr != null) {
                    pkgFlags |= "true".equalsIgnoreCase(systemStr) ? 1 : 0;
                } else {
                    pkgFlags |= 1;
                }
            }
            String timeStampStr = parser.getAttributeValue(null, "ft");
            if (timeStampStr != null) {
                try {
                    timeStamp = Long.parseLong(timeStampStr, 16);
                } catch (NumberFormatException e3) {
                }
            } else {
                timeStampStr = parser.getAttributeValue(null, "ts");
                if (timeStampStr != null) {
                    try {
                        timeStamp = Long.parseLong(timeStampStr);
                    } catch (NumberFormatException e4) {
                    }
                }
            }
            timeStampStr = parser.getAttributeValue(null, "it");
            if (timeStampStr != null) {
                try {
                    firstInstallTime = Long.parseLong(timeStampStr, 16);
                } catch (NumberFormatException e5) {
                }
            }
            timeStampStr = parser.getAttributeValue(null, "ut");
            if (timeStampStr != null) {
                try {
                    lastUpdateTime = Long.parseLong(timeStampStr, 16);
                } catch (NumberFormatException e6) {
                }
            }
            int userId = idStr != null ? Integer.parseInt(idStr) : 0;
            if (resourcePathStr == null) {
                resourcePathStr = codePathStr;
            }
            if (realName != null) {
                realName = realName.intern();
            }
            if (name == null) {
                PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: <package> has no name at " + parser.getPositionDescription());
                packageSetting = null;
            } else if (codePathStr == null) {
                PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: <package> has no codePath at " + parser.getPositionDescription());
                packageSetting = null;
            } else if (userId > 0) {
                packageSetting = addPackageLPw(name.intern(), realName, new File(codePathStr), new File(resourcePathStr), legacyNativeLibraryPathStr, primaryCpuAbiString, secondaryCpuAbiString, cpuAbiOverrideString, userId, versionCode, pkgFlags);
                if (packageSetting == null) {
                    try {
                        PackageManagerService.reportSettingsProblem(6, "Failure adding uid " + userId + " while parsing settings at " + parser.getPositionDescription());
                    } catch (NumberFormatException e7) {
                        PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: package " + name + " has bad userId " + idStr + " at " + parser.getPositionDescription());
                        if (packageSetting != null) {
                            XmlUtils.skipCurrentTag(parser);
                        }
                        packageSetting.uidError = "true".equals(uidError);
                        packageSetting.installerPackageName = installerPackageName;
                        packageSetting.legacyNativeLibraryPathString = legacyNativeLibraryPathStr;
                        packageSetting.primaryCpuAbiString = primaryCpuAbiString;
                        packageSetting.secondaryCpuAbiString = secondaryCpuAbiString;
                        enabledStr = parser.getAttributeValue(null, ATTR_ENABLED);
                        if (enabledStr != null) {
                            packageSetting.setEnabled(0, 0, null);
                        } else {
                            try {
                                packageSetting.setEnabled(Integer.parseInt(enabledStr), 0, null);
                            } catch (NumberFormatException e8) {
                                if (enabledStr.equalsIgnoreCase("true")) {
                                    packageSetting.setEnabled(1, 0, null);
                                } else {
                                    if (enabledStr.equalsIgnoreCase("false")) {
                                        packageSetting.setEnabled(2, 0, null);
                                    } else {
                                        if (enabledStr.equalsIgnoreCase("default")) {
                                            packageSetting.setEnabled(0, 0, null);
                                        } else {
                                            PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: package " + name + " has bad enabled value: " + idStr + " at " + parser.getPositionDescription());
                                        }
                                    }
                                }
                            }
                        }
                        installStatusStr = parser.getAttributeValue(null, "installStatus");
                        if (installStatusStr != null) {
                            if (installStatusStr.equalsIgnoreCase("false")) {
                                packageSetting.installStatus = 1;
                            } else {
                                packageSetting.installStatus = 0;
                            }
                        }
                        outerDepth = parser.getDepth();
                        while (true) {
                            type = parser.next();
                            if (type != 1) {
                                if (type != CURRENT_DATABASE_VERSION) {
                                }
                                tagName = parser.getName();
                                if (tagName.equals(TAG_DISABLED_COMPONENTS)) {
                                    if (tagName.equals(TAG_ENABLED_COMPONENTS)) {
                                        if (tagName.equals("sigs")) {
                                            if (tagName.equals("perms")) {
                                                if (tagName.equals("proper-signing-keyset")) {
                                                    if (tagName.equals("signing-keyset")) {
                                                        if (tagName.equals("upgrade-keyset")) {
                                                            if (tagName.equals("defined-keyset")) {
                                                                PackageManagerService.reportSettingsProblem(5, "Unknown element under <package>: " + parser.getName());
                                                                XmlUtils.skipCurrentTag(parser);
                                                            } else {
                                                                packageSetting.keySetData.addDefinedKeySet(Long.parseLong(parser.getAttributeValue(null, "identifier")), parser.getAttributeValue(null, "alias"));
                                                            }
                                                        } else {
                                                            packageSetting.keySetData.addUpgradeKeySetById(Long.parseLong(parser.getAttributeValue(null, "identifier")));
                                                        }
                                                    } else {
                                                        packageSetting.keySetData.addSigningKeySet(Long.parseLong(parser.getAttributeValue(null, "identifier")));
                                                    }
                                                } else {
                                                    packageSetting.keySetData.setProperSigningKeySet(Long.parseLong(parser.getAttributeValue(null, "identifier")));
                                                }
                                            } else {
                                                readGrantedPermissionsLPw(parser, packageSetting.grantedPermissions);
                                                packageSetting.permissionsFixed = true;
                                            }
                                        } else {
                                            packageSetting.signatures.readXml(parser, this.mPastSignatures);
                                        }
                                    } else {
                                        readEnabledComponentsLPw(packageSetting, parser, 0);
                                    }
                                } else {
                                    readDisabledComponentsLPw(packageSetting, parser, 0);
                                }
                            } else {
                                return;
                            }
                        }
                    }
                }
                packageSetting.setTimeStamp(timeStamp);
                packageSetting.firstInstallTime = firstInstallTime;
                packageSetting.lastUpdateTime = lastUpdateTime;
            } else if (sharedIdStr != null) {
                userId = sharedIdStr != null ? Integer.parseInt(sharedIdStr) : 0;
                if (userId > 0) {
                    packageSetting = new PendingPackage(name.intern(), realName, new File(codePathStr), new File(resourcePathStr), legacyNativeLibraryPathStr, primaryCpuAbiString, secondaryCpuAbiString, cpuAbiOverrideString, userId, versionCode, pkgFlags);
                    packageSetting.setTimeStamp(timeStamp);
                    packageSetting.firstInstallTime = firstInstallTime;
                    packageSetting.lastUpdateTime = lastUpdateTime;
                    this.mPendingPackages.add((PendingPackage) packageSetting);
                } else {
                    PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: package " + name + " has bad sharedId " + sharedIdStr + " at " + parser.getPositionDescription());
                    packageSetting = null;
                }
            } else {
                PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: package " + name + " has bad userId " + idStr + " at " + parser.getPositionDescription());
                packageSetting = null;
            }
        } catch (NumberFormatException e9) {
            packageSetting = null;
            PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: package " + name + " has bad userId " + idStr + " at " + parser.getPositionDescription());
            if (packageSetting != null) {
                packageSetting.uidError = "true".equals(uidError);
                packageSetting.installerPackageName = installerPackageName;
                packageSetting.legacyNativeLibraryPathString = legacyNativeLibraryPathStr;
                packageSetting.primaryCpuAbiString = primaryCpuAbiString;
                packageSetting.secondaryCpuAbiString = secondaryCpuAbiString;
                enabledStr = parser.getAttributeValue(null, ATTR_ENABLED);
                if (enabledStr != null) {
                    packageSetting.setEnabled(Integer.parseInt(enabledStr), 0, null);
                } else {
                    packageSetting.setEnabled(0, 0, null);
                }
                installStatusStr = parser.getAttributeValue(null, "installStatus");
                if (installStatusStr != null) {
                    if (installStatusStr.equalsIgnoreCase("false")) {
                        packageSetting.installStatus = 0;
                    } else {
                        packageSetting.installStatus = 1;
                    }
                }
                outerDepth = parser.getDepth();
                while (true) {
                    type = parser.next();
                    if (type != 1) {
                        if (type != CURRENT_DATABASE_VERSION) {
                        }
                        tagName = parser.getName();
                        if (tagName.equals(TAG_DISABLED_COMPONENTS)) {
                            readDisabledComponentsLPw(packageSetting, parser, 0);
                        } else {
                            if (tagName.equals(TAG_ENABLED_COMPONENTS)) {
                                readEnabledComponentsLPw(packageSetting, parser, 0);
                            } else {
                                if (tagName.equals("sigs")) {
                                    packageSetting.signatures.readXml(parser, this.mPastSignatures);
                                } else {
                                    if (tagName.equals("perms")) {
                                        readGrantedPermissionsLPw(parser, packageSetting.grantedPermissions);
                                        packageSetting.permissionsFixed = true;
                                    } else {
                                        if (tagName.equals("proper-signing-keyset")) {
                                            packageSetting.keySetData.setProperSigningKeySet(Long.parseLong(parser.getAttributeValue(null, "identifier")));
                                        } else {
                                            if (tagName.equals("signing-keyset")) {
                                                packageSetting.keySetData.addSigningKeySet(Long.parseLong(parser.getAttributeValue(null, "identifier")));
                                            } else {
                                                if (tagName.equals("upgrade-keyset")) {
                                                    packageSetting.keySetData.addUpgradeKeySetById(Long.parseLong(parser.getAttributeValue(null, "identifier")));
                                                } else {
                                                    if (tagName.equals("defined-keyset")) {
                                                        packageSetting.keySetData.addDefinedKeySet(Long.parseLong(parser.getAttributeValue(null, "identifier")), parser.getAttributeValue(null, "alias"));
                                                    } else {
                                                        PackageManagerService.reportSettingsProblem(5, "Unknown element under <package>: " + parser.getName());
                                                        XmlUtils.skipCurrentTag(parser);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        return;
                    }
                }
            }
            XmlUtils.skipCurrentTag(parser);
        }
        if (packageSetting != null) {
            packageSetting.uidError = "true".equals(uidError);
            packageSetting.installerPackageName = installerPackageName;
            packageSetting.legacyNativeLibraryPathString = legacyNativeLibraryPathStr;
            packageSetting.primaryCpuAbiString = primaryCpuAbiString;
            packageSetting.secondaryCpuAbiString = secondaryCpuAbiString;
            enabledStr = parser.getAttributeValue(null, ATTR_ENABLED);
            if (enabledStr != null) {
                packageSetting.setEnabled(Integer.parseInt(enabledStr), 0, null);
            } else {
                packageSetting.setEnabled(0, 0, null);
            }
            installStatusStr = parser.getAttributeValue(null, "installStatus");
            if (installStatusStr != null) {
                if (installStatusStr.equalsIgnoreCase("false")) {
                    packageSetting.installStatus = 0;
                } else {
                    packageSetting.installStatus = 1;
                }
            }
            outerDepth = parser.getDepth();
            while (true) {
                type = parser.next();
                if (type != 1) {
                    return;
                }
                if (type != CURRENT_DATABASE_VERSION && parser.getDepth() <= outerDepth) {
                    return;
                }
                if (!(type == CURRENT_DATABASE_VERSION || type == 4)) {
                    tagName = parser.getName();
                    if (tagName.equals(TAG_DISABLED_COMPONENTS)) {
                        readDisabledComponentsLPw(packageSetting, parser, 0);
                    } else {
                        if (tagName.equals(TAG_ENABLED_COMPONENTS)) {
                            readEnabledComponentsLPw(packageSetting, parser, 0);
                        } else {
                            if (tagName.equals("sigs")) {
                                packageSetting.signatures.readXml(parser, this.mPastSignatures);
                            } else {
                                if (tagName.equals("perms")) {
                                    readGrantedPermissionsLPw(parser, packageSetting.grantedPermissions);
                                    packageSetting.permissionsFixed = true;
                                } else {
                                    if (tagName.equals("proper-signing-keyset")) {
                                        packageSetting.keySetData.setProperSigningKeySet(Long.parseLong(parser.getAttributeValue(null, "identifier")));
                                    } else {
                                        if (tagName.equals("signing-keyset")) {
                                            packageSetting.keySetData.addSigningKeySet(Long.parseLong(parser.getAttributeValue(null, "identifier")));
                                        } else {
                                            if (tagName.equals("upgrade-keyset")) {
                                                packageSetting.keySetData.addUpgradeKeySetById(Long.parseLong(parser.getAttributeValue(null, "identifier")));
                                            } else {
                                                if (tagName.equals("defined-keyset")) {
                                                    packageSetting.keySetData.addDefinedKeySet(Long.parseLong(parser.getAttributeValue(null, "identifier")), parser.getAttributeValue(null, "alias"));
                                                } else {
                                                    PackageManagerService.reportSettingsProblem(5, "Unknown element under <package>: " + parser.getName());
                                                    XmlUtils.skipCurrentTag(parser);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            XmlUtils.skipCurrentTag(parser);
        }
    }

    private void readDisabledComponentsLPw(PackageSettingBase packageSetting, XmlPullParser parser, int userId) throws IOException, XmlPullParserException {
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == 1) {
                return;
            }
            if (type == CURRENT_DATABASE_VERSION && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == CURRENT_DATABASE_VERSION || type == 4)) {
                if (parser.getName().equals(TAG_ITEM)) {
                    String name = parser.getAttributeValue(null, ATTR_NAME);
                    if (name != null) {
                        packageSetting.addDisabledComponent(name.intern(), userId);
                    } else {
                        PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: <disabled-components> has no name at " + parser.getPositionDescription());
                    }
                } else {
                    PackageManagerService.reportSettingsProblem(5, "Unknown element under <disabled-components>: " + parser.getName());
                }
                XmlUtils.skipCurrentTag(parser);
            }
        }
    }

    private void readEnabledComponentsLPw(PackageSettingBase packageSetting, XmlPullParser parser, int userId) throws IOException, XmlPullParserException {
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == 1) {
                return;
            }
            if (type == CURRENT_DATABASE_VERSION && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == CURRENT_DATABASE_VERSION || type == 4)) {
                if (parser.getName().equals(TAG_ITEM)) {
                    String name = parser.getAttributeValue(null, ATTR_NAME);
                    if (name != null) {
                        packageSetting.addEnabledComponent(name.intern(), userId);
                    } else {
                        PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: <enabled-components> has no name at " + parser.getPositionDescription());
                    }
                } else {
                    PackageManagerService.reportSettingsProblem(5, "Unknown element under <enabled-components>: " + parser.getName());
                }
                XmlUtils.skipCurrentTag(parser);
            }
        }
    }

    private void readSharedUserLPw(XmlPullParser parser) throws XmlPullParserException, IOException {
        String name = null;
        String idStr = null;
        int pkgFlags = 0;
        SharedUserSetting su = null;
        try {
            name = parser.getAttributeValue(null, ATTR_NAME);
            idStr = parser.getAttributeValue(null, "userId");
            int userId = idStr != null ? Integer.parseInt(idStr) : 0;
            if ("true".equals(parser.getAttributeValue(null, "system"))) {
                pkgFlags = 0 | 1;
            }
            if (name == null) {
                PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: <shared-user> has no name at " + parser.getPositionDescription());
            } else if (userId == 0) {
                PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: shared-user " + name + " has bad userId " + idStr + " at " + parser.getPositionDescription());
            } else {
                su = addSharedUserLPw(name.intern(), userId, pkgFlags);
                if (su == null) {
                    PackageManagerService.reportSettingsProblem(6, "Occurred while parsing settings at " + parser.getPositionDescription());
                }
            }
        } catch (NumberFormatException e) {
            PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: package " + name + " has bad userId " + idStr + " at " + parser.getPositionDescription());
        }
        if (su != null) {
            int outerDepth = parser.getDepth();
            while (true) {
                int type = parser.next();
                if (type == 1) {
                    return;
                }
                if (type == CURRENT_DATABASE_VERSION && parser.getDepth() <= outerDepth) {
                    return;
                }
                if (!(type == CURRENT_DATABASE_VERSION || type == 4)) {
                    String tagName = parser.getName();
                    if (tagName.equals("sigs")) {
                        su.signatures.readXml(parser, this.mPastSignatures);
                    } else if (tagName.equals("perms")) {
                        readGrantedPermissionsLPw(parser, su.grantedPermissions);
                    } else {
                        PackageManagerService.reportSettingsProblem(5, "Unknown element under <shared-user>: " + parser.getName());
                        XmlUtils.skipCurrentTag(parser);
                    }
                }
            }
        } else {
            XmlUtils.skipCurrentTag(parser);
        }
    }

    private void readGrantedPermissionsLPw(XmlPullParser parser, ArraySet<String> outPerms) throws IOException, XmlPullParserException {
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == 1) {
                return;
            }
            if (type == CURRENT_DATABASE_VERSION && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == CURRENT_DATABASE_VERSION || type == 4)) {
                if (parser.getName().equals(TAG_ITEM)) {
                    String name = parser.getAttributeValue(null, ATTR_NAME);
                    if (name != null) {
                        outPerms.add(name.intern());
                    } else {
                        PackageManagerService.reportSettingsProblem(5, "Error in package manager settings: <perms> has no name at " + parser.getPositionDescription());
                    }
                } else {
                    PackageManagerService.reportSettingsProblem(5, "Unknown element under <perms>: " + parser.getName());
                }
                XmlUtils.skipCurrentTag(parser);
            }
        }
    }

    void createNewUserLILPw(PackageManagerService service, Installer installer, int userHandle, File path) {
        path.mkdir();
        FileUtils.setPermissions(path.toString(), 505, -1, -1);
        for (PackageSetting ps : this.mPackages.values()) {
            if (!(ps.pkg == null || ps.pkg.applicationInfo == null)) {
                ps.setInstalled((ps.pkgFlags & 1) != 0 ? true : DEBUG_STOPPED, userHandle);
                installer.createUserData(ps.name, UserHandle.getUid(userHandle, ps.appId), userHandle, ps.pkg.applicationInfo.seinfo);
            }
        }
        readDefaultPreferredAppsLPw(service, userHandle);
        writePackageRestrictionsLPr(userHandle);
    }

    void removeUserLPw(int userId) {
        for (Entry<String, PackageSetting> entry : this.mPackages.entrySet()) {
            ((PackageSetting) entry.getValue()).removeUser(userId);
        }
        this.mPreferredActivities.remove(userId);
        getUserPackagesStateFile(userId).delete();
        getUserPackagesStateBackupFile(userId).delete();
        removeCrossProfileIntentFiltersLPw(userId);
    }

    void removeCrossProfileIntentFiltersLPw(int userId) {
        synchronized (this.mCrossProfileIntentResolvers) {
            if (this.mCrossProfileIntentResolvers.get(userId) != null) {
                this.mCrossProfileIntentResolvers.remove(userId);
                writePackageRestrictionsLPr(userId);
            }
            int count = this.mCrossProfileIntentResolvers.size();
            for (int i = 0; i < count; i++) {
                int sourceUserId = this.mCrossProfileIntentResolvers.keyAt(i);
                CrossProfileIntentResolver cpir = (CrossProfileIntentResolver) this.mCrossProfileIntentResolvers.get(sourceUserId);
                boolean needsWriting = DEBUG_STOPPED;
                Iterator i$ = new ArraySet(cpir.filterSet()).iterator();
                while (i$.hasNext()) {
                    CrossProfileIntentFilter cpif = (CrossProfileIntentFilter) i$.next();
                    if (cpif.getTargetUserId() == userId) {
                        needsWriting = true;
                        cpir.removeFilter(cpif);
                    }
                }
                if (needsWriting) {
                    writePackageRestrictionsLPr(sourceUserId);
                }
            }
        }
    }

    private void setFirstAvailableUid(int uid) {
        if (uid > mFirstAvailableUid) {
            mFirstAvailableUid = uid;
        }
    }

    private int newUserIdLPw(Object obj) {
        int N = this.mUserIds.size();
        for (int i = mFirstAvailableUid; i < N; i++) {
            if (this.mUserIds.get(i) == null) {
                this.mUserIds.set(i, obj);
                return i + ProcessList.PSS_TEST_MIN_TIME_FROM_STATE_CHANGE;
            }
        }
        if (N > 9999) {
            return -1;
        }
        this.mUserIds.add(obj);
        return N + ProcessList.PSS_TEST_MIN_TIME_FROM_STATE_CHANGE;
    }

    public VerifierDeviceIdentity getVerifierDeviceIdentityLPw() {
        if (this.mVerifierDeviceIdentity == null) {
            this.mVerifierDeviceIdentity = VerifierDeviceIdentity.generate();
            writeLPr();
        }
        return this.mVerifierDeviceIdentity;
    }

    public PackageSetting getDisabledSystemPkgLPr(String name) {
        return (PackageSetting) this.mDisabledSysPackages.get(name);
    }

    private String compToString(ArraySet<String> cmp) {
        return cmp != null ? Arrays.toString(cmp.toArray()) : "[]";
    }

    boolean isEnabledLPr(ComponentInfo componentInfo, int flags, int userId) {
        if ((flags & DumpState.DUMP_PREFERRED) != 0) {
            return true;
        }
        PackageSetting packageSettings = (PackageSetting) this.mPackages.get(componentInfo.packageName);
        if (packageSettings == null) {
            return DEBUG_STOPPED;
        }
        PackageUserState ustate = packageSettings.readUserState(userId);
        if ((32768 & flags) != 0 && ustate.enabled == 4) {
            return true;
        }
        if (ustate.enabled == 2 || ustate.enabled == CURRENT_DATABASE_VERSION || ustate.enabled == 4 || (packageSettings.pkg != null && !packageSettings.pkg.applicationInfo.enabled && ustate.enabled == 0)) {
            return DEBUG_STOPPED;
        }
        if (ustate.enabledComponents != null && ustate.enabledComponents.contains(componentInfo.name)) {
            return true;
        }
        if (ustate.disabledComponents == null || !ustate.disabledComponents.contains(componentInfo.name)) {
            return componentInfo.enabled;
        }
        return DEBUG_STOPPED;
    }

    String getInstallerPackageNameLPr(String packageName) {
        PackageSetting pkg = (PackageSetting) this.mPackages.get(packageName);
        if (pkg != null) {
            return pkg.installerPackageName;
        }
        throw new IllegalArgumentException("Unknown package: " + packageName);
    }

    int getApplicationEnabledSettingLPr(String packageName, int userId) {
        PackageSetting pkg = (PackageSetting) this.mPackages.get(packageName);
        if (pkg != null) {
            return pkg.getEnabled(userId);
        }
        throw new IllegalArgumentException("Unknown package: " + packageName);
    }

    int getComponentEnabledSettingLPr(ComponentName componentName, int userId) {
        PackageSetting pkg = (PackageSetting) this.mPackages.get(componentName.getPackageName());
        if (pkg != null) {
            return pkg.getCurrentEnabledStateLPr(componentName.getClassName(), userId);
        }
        throw new IllegalArgumentException("Unknown component: " + componentName);
    }

    boolean setPackageStoppedStateLPw(String packageName, boolean stopped, boolean allowedByPermission, int uid, int userId) {
        int appId = UserHandle.getAppId(uid);
        PackageSetting pkgSetting = (PackageSetting) this.mPackages.get(packageName);
        if (pkgSetting == null) {
            throw new IllegalArgumentException("Unknown package: " + packageName);
        } else if (!allowedByPermission && appId != pkgSetting.appId) {
            throw new SecurityException("Permission Denial: attempt to change stopped state from pid=" + Binder.getCallingPid() + ", uid=" + uid + ", package uid=" + pkgSetting.appId);
        } else if (pkgSetting.getStopped(userId) == stopped) {
            return DEBUG_STOPPED;
        } else {
            pkgSetting.setStopped(stopped, userId);
            if (pkgSetting.getNotLaunched(userId)) {
                if (pkgSetting.installerPackageName != null) {
                    PackageManagerService.sendPackageBroadcast("android.intent.action.PACKAGE_FIRST_LAUNCH", pkgSetting.name, null, pkgSetting.installerPackageName, null, new int[]{userId});
                }
                pkgSetting.setNotLaunched(DEBUG_STOPPED, userId);
            }
            return true;
        }
    }

    private List<UserInfo> getAllUsers() {
        long id = Binder.clearCallingIdentity();
        List<UserInfo> users;
        try {
            users = UserManagerService.getInstance().getUsers(DEBUG_STOPPED);
            return users;
        } catch (NullPointerException e) {
            users = e;
            return null;
        } finally {
            Binder.restoreCallingIdentity(id);
        }
    }

    static final void printFlags(PrintWriter pw, int val, Object[] spec) {
        pw.print("[ ");
        for (int i = 0; i < spec.length; i += 2) {
            if ((val & ((Integer) spec[i]).intValue()) != 0) {
                pw.print(spec[i + 1]);
                pw.print(" ");
            }
        }
        pw.print("]");
    }

    void dumpPackageLPr(PrintWriter pw, String prefix, String checkinTag, PackageSetting ps, SimpleDateFormat sdf, Date date, List<UserInfo> users) {
        int i;
        Iterator i$;
        String lastDisabledAppCaller;
        if (checkinTag != null) {
            pw.print(checkinTag);
            pw.print(",");
            pw.print(ps.realName != null ? ps.realName : ps.name);
            pw.print(",");
            pw.print(ps.appId);
            pw.print(",");
            pw.print(ps.versionCode);
            pw.print(",");
            pw.print(ps.firstInstallTime);
            pw.print(",");
            pw.print(ps.lastUpdateTime);
            pw.print(",");
            pw.print(ps.installerPackageName != null ? ps.installerPackageName : "?");
            pw.println();
            if (ps.pkg != null) {
                pw.print(checkinTag);
                pw.print("-");
                pw.print("splt,");
                pw.print("base,");
                pw.println(ps.pkg.baseRevisionCode);
                if (ps.pkg.splitNames != null) {
                    for (i = 0; i < ps.pkg.splitNames.length; i++) {
                        pw.print(checkinTag);
                        pw.print("-");
                        pw.print("splt,");
                        pw.print(ps.pkg.splitNames[i]);
                        pw.print(",");
                        pw.println(ps.pkg.splitRevisionCodes[i]);
                    }
                }
            }
            for (UserInfo user : users) {
                pw.print(checkinTag);
                pw.print("-");
                pw.print("usr");
                pw.print(",");
                pw.print(user.id);
                pw.print(",");
                pw.print(ps.getInstalled(user.id) ? "I" : "i");
                pw.print(ps.getHidden(user.id) ? "B" : "b");
                pw.print(ps.getStopped(user.id) ? "S" : "s");
                pw.print(ps.getNotLaunched(user.id) ? "l" : "L");
                pw.print(",");
                pw.print(ps.getEnabled(user.id));
                lastDisabledAppCaller = ps.getLastDisabledAppCaller(user.id);
                pw.print(",");
                if (lastDisabledAppCaller == null) {
                    lastDisabledAppCaller = "?";
                }
                pw.print(lastDisabledAppCaller);
                pw.println();
            }
            return;
        }
        String str;
        pw.print(prefix);
        pw.print("Package [");
        if (ps.realName != null) {
            str = ps.realName;
        } else {
            str = ps.name;
        }
        pw.print(str);
        pw.print("] (");
        pw.print(Integer.toHexString(System.identityHashCode(ps)));
        pw.println("):");
        if (ps.realName != null) {
            pw.print(prefix);
            pw.print("  compat name=");
            pw.println(ps.name);
        }
        pw.print(prefix);
        pw.print("  userId=");
        pw.print(ps.appId);
        pw.print(" gids=");
        pw.println(PackageManagerService.arrayToString(ps.gids));
        if (ps.sharedUser != null) {
            pw.print(prefix);
            pw.print("  sharedUser=");
            pw.println(ps.sharedUser);
        }
        pw.print(prefix);
        pw.print("  pkg=");
        pw.println(ps.pkg);
        pw.print(prefix);
        pw.print("  codePath=");
        pw.println(ps.codePathString);
        pw.print(prefix);
        pw.print("  resourcePath=");
        pw.println(ps.resourcePathString);
        pw.print(prefix);
        pw.print("  legacyNativeLibraryDir=");
        pw.println(ps.legacyNativeLibraryPathString);
        pw.print(prefix);
        pw.print("  primaryCpuAbi=");
        pw.println(ps.primaryCpuAbiString);
        pw.print(prefix);
        pw.print("  secondaryCpuAbi=");
        pw.println(ps.secondaryCpuAbiString);
        pw.print(prefix);
        pw.print("  versionCode=");
        pw.print(ps.versionCode);
        if (ps.pkg != null) {
            pw.print(" targetSdk=");
            pw.print(ps.pkg.applicationInfo.targetSdkVersion);
        }
        pw.println();
        if (ps.pkg != null) {
            pw.print(prefix);
            pw.print("  versionName=");
            pw.println(ps.pkg.mVersionName);
            pw.print(prefix);
            pw.print("  splits=");
            dumpSplitNames(pw, ps.pkg);
            pw.println();
            pw.print(prefix);
            pw.print("  applicationInfo=");
            pw.println(ps.pkg.applicationInfo.toString());
            pw.print(prefix);
            pw.print("  flags=");
            printFlags(pw, ps.pkg.applicationInfo.flags, FLAG_DUMP_SPEC);
            pw.println();
            pw.print(prefix);
            pw.print("  dataDir=");
            pw.println(ps.pkg.applicationInfo.dataDir);
            if (ps.pkg.mOperationPending) {
                pw.print(prefix);
                pw.println("  mOperationPending=true");
            }
            pw.print(prefix);
            pw.print("  supportsScreens=[");
            boolean first = true;
            if ((ps.pkg.applicationInfo.flags & DumpState.DUMP_PREFERRED) != 0) {
                if (1 == null) {
                    pw.print(", ");
                }
                first = DEBUG_STOPPED;
                pw.print("small");
            }
            if ((ps.pkg.applicationInfo.flags & DumpState.DUMP_PREFERRED_XML) != 0) {
                if (!first) {
                    pw.print(", ");
                }
                first = DEBUG_STOPPED;
                pw.print("medium");
            }
            if ((ps.pkg.applicationInfo.flags & DumpState.DUMP_KEYSETS) != 0) {
                if (!first) {
                    pw.print(", ");
                }
                first = DEBUG_STOPPED;
                pw.print("large");
            }
            if ((ps.pkg.applicationInfo.flags & 524288) != 0) {
                if (!first) {
                    pw.print(", ");
                }
                first = DEBUG_STOPPED;
                pw.print("xlarge");
            }
            if ((ps.pkg.applicationInfo.flags & DumpState.DUMP_VERSION) != 0) {
                if (!first) {
                    pw.print(", ");
                }
                first = DEBUG_STOPPED;
                pw.print("resizeable");
            }
            if ((ps.pkg.applicationInfo.flags & DumpState.DUMP_INSTALLS) != 0) {
                if (!first) {
                    pw.print(", ");
                }
                pw.print("anyDensity");
            }
            pw.println("]");
            if (ps.pkg.libraryNames != null && ps.pkg.libraryNames.size() > 0) {
                pw.print(prefix);
                pw.println("  libraries:");
                for (i = 0; i < ps.pkg.libraryNames.size(); i++) {
                    pw.print(prefix);
                    pw.print("    ");
                    pw.println((String) ps.pkg.libraryNames.get(i));
                }
            }
            if (ps.pkg.usesLibraries != null && ps.pkg.usesLibraries.size() > 0) {
                pw.print(prefix);
                pw.println("  usesLibraries:");
                for (i = 0; i < ps.pkg.usesLibraries.size(); i++) {
                    pw.print(prefix);
                    pw.print("    ");
                    pw.println((String) ps.pkg.usesLibraries.get(i));
                }
            }
            if (ps.pkg.usesOptionalLibraries != null && ps.pkg.usesOptionalLibraries.size() > 0) {
                pw.print(prefix);
                pw.println("  usesOptionalLibraries:");
                for (i = 0; i < ps.pkg.usesOptionalLibraries.size(); i++) {
                    pw.print(prefix);
                    pw.print("    ");
                    pw.println((String) ps.pkg.usesOptionalLibraries.get(i));
                }
            }
            if (ps.pkg.usesLibraryFiles != null && ps.pkg.usesLibraryFiles.length > 0) {
                pw.print(prefix);
                pw.println("  usesLibraryFiles:");
                for (String str2 : ps.pkg.usesLibraryFiles) {
                    pw.print(prefix);
                    pw.print("    ");
                    pw.println(str2);
                }
            }
        }
        pw.print(prefix);
        pw.print("  timeStamp=");
        date.setTime(ps.timeStamp);
        pw.println(sdf.format(date));
        pw.print(prefix);
        pw.print("  firstInstallTime=");
        date.setTime(ps.firstInstallTime);
        pw.println(sdf.format(date));
        pw.print(prefix);
        pw.print("  lastUpdateTime=");
        date.setTime(ps.lastUpdateTime);
        pw.println(sdf.format(date));
        if (ps.installerPackageName != null) {
            pw.print(prefix);
            pw.print("  installerPackageName=");
            pw.println(ps.installerPackageName);
        }
        pw.print(prefix);
        pw.print("  signatures=");
        pw.println(ps.signatures);
        pw.print(prefix);
        pw.print("  permissionsFixed=");
        pw.print(ps.permissionsFixed);
        pw.print(" haveGids=");
        pw.print(ps.haveGids);
        pw.print(" installStatus=");
        pw.println(ps.installStatus);
        pw.print(prefix);
        pw.print("  pkgFlags=");
        printFlags(pw, ps.pkgFlags, FLAG_DUMP_SPEC);
        pw.println();
        for (UserInfo user2 : users) {
            Iterator i$2;
            pw.print(prefix);
            pw.print("  User ");
            pw.print(user2.id);
            pw.print(": ");
            pw.print(" installed=");
            pw.print(ps.getInstalled(user2.id));
            pw.print(" hidden=");
            pw.print(ps.getHidden(user2.id));
            pw.print(" stopped=");
            pw.print(ps.getStopped(user2.id));
            pw.print(" notLaunched=");
            pw.print(ps.getNotLaunched(user2.id));
            pw.print(" enabled=");
            pw.println(ps.getEnabled(user2.id));
            lastDisabledAppCaller = ps.getLastDisabledAppCaller(user2.id);
            if (lastDisabledAppCaller != null) {
                pw.print(prefix);
                pw.print("    lastDisabledCaller: ");
                pw.println(lastDisabledAppCaller);
            }
            ArraySet<String> cmp = ps.getDisabledComponents(user2.id);
            if (cmp != null && cmp.size() > 0) {
                pw.print(prefix);
                pw.println("    disabledComponents:");
                i$2 = cmp.iterator();
                while (i$2.hasNext()) {
                    String s = (String) i$2.next();
                    pw.print(prefix);
                    pw.print("    ");
                    pw.println(s);
                }
            }
            cmp = ps.getEnabledComponents(user2.id);
            if (cmp != null && cmp.size() > 0) {
                pw.print(prefix);
                pw.println("    enabledComponents:");
                i$2 = cmp.iterator();
                while (i$2.hasNext()) {
                    s = (String) i$2.next();
                    pw.print(prefix);
                    pw.print("    ");
                    pw.println(s);
                }
            }
        }
        if (ps.grantedPermissions.size() > 0) {
            pw.print(prefix);
            pw.println("  grantedPermissions:");
            i$ = ps.grantedPermissions.iterator();
            while (i$.hasNext()) {
                s = (String) i$.next();
                pw.print(prefix);
                pw.print("    ");
                pw.println(s);
            }
        }
    }

    void dumpPackagesLPr(PrintWriter pw, String packageName, DumpState dumpState, boolean checkin) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        boolean printedSomething = DEBUG_STOPPED;
        List<UserInfo> users = getAllUsers();
        for (PackageSetting ps : this.mPackages.values()) {
            if (packageName == null || packageName.equals(ps.realName) || packageName.equals(ps.name)) {
                if (!(checkin || packageName == null)) {
                    dumpState.setSharedUser(ps.sharedUser);
                }
                if (!(checkin || printedSomething)) {
                    if (dumpState.onTitlePrinted()) {
                        pw.println();
                    }
                    pw.println("Packages:");
                    printedSomething = true;
                }
                dumpPackageLPr(pw, "  ", checkin ? TAG_PACKAGE : null, ps, sdf, date, users);
            }
        }
        printedSomething = DEBUG_STOPPED;
        if (!checkin && this.mRenamedPackages.size() > 0) {
            for (Entry<String, String> e : this.mRenamedPackages.entrySet()) {
                if (packageName == null || packageName.equals(e.getKey()) || packageName.equals(e.getValue())) {
                    if (checkin) {
                        pw.print("ren,");
                    } else {
                        if (!printedSomething) {
                            if (dumpState.onTitlePrinted()) {
                                pw.println();
                            }
                            pw.println("Renamed packages:");
                            printedSomething = true;
                        }
                        pw.print("  ");
                    }
                    pw.print((String) e.getKey());
                    pw.print(checkin ? " -> " : ",");
                    pw.println((String) e.getValue());
                }
            }
        }
        printedSomething = DEBUG_STOPPED;
        if (this.mDisabledSysPackages.size() > 0) {
            for (PackageSetting ps2 : this.mDisabledSysPackages.values()) {
                if (packageName == null || packageName.equals(ps2.realName) || packageName.equals(ps2.name)) {
                    if (!(checkin || printedSomething)) {
                        if (dumpState.onTitlePrinted()) {
                            pw.println();
                        }
                        pw.println("Hidden system packages:");
                        printedSomething = true;
                    }
                    dumpPackageLPr(pw, "  ", checkin ? "dis" : null, ps2, sdf, date, users);
                }
            }
        }
    }

    void dumpPermissionsLPr(PrintWriter pw, String packageName, DumpState dumpState) {
        boolean printedSomething = DEBUG_STOPPED;
        for (BasePermission p : this.mPermissions.values()) {
            if (packageName == null || packageName.equals(p.sourcePackage)) {
                if (!printedSomething) {
                    if (dumpState.onTitlePrinted()) {
                        pw.println();
                    }
                    pw.println("Permissions:");
                    printedSomething = true;
                }
                pw.print("  Permission [");
                pw.print(p.name);
                pw.print("] (");
                pw.print(Integer.toHexString(System.identityHashCode(p)));
                pw.println("):");
                pw.print("    sourcePackage=");
                pw.println(p.sourcePackage);
                pw.print("    uid=");
                pw.print(p.uid);
                pw.print(" gids=");
                pw.print(PackageManagerService.arrayToString(p.gids));
                pw.print(" type=");
                pw.print(p.type);
                pw.print(" prot=");
                pw.println(PermissionInfo.protectionToString(p.protectionLevel));
                if (p.packageSetting != null) {
                    pw.print("    packageSetting=");
                    pw.println(p.packageSetting);
                }
                if (p.perm != null) {
                    pw.print("    perm=");
                    pw.println(p.perm);
                }
                if ("android.permission.READ_EXTERNAL_STORAGE".equals(p.name)) {
                    pw.print("    enforced=");
                    pw.println(this.mReadExternalStorageEnforced);
                }
            }
        }
    }

    void dumpSharedUsersLPr(PrintWriter pw, String packageName, DumpState dumpState, boolean checkin) {
        boolean printedSomething = DEBUG_STOPPED;
        for (SharedUserSetting su : this.mSharedUsers.values()) {
            if (packageName == null || su == dumpState.getSharedUser()) {
                if (checkin) {
                    pw.print("suid,");
                    pw.print(su.userId);
                    pw.print(",");
                    pw.println(su.name);
                } else {
                    if (!printedSomething) {
                        if (dumpState.onTitlePrinted()) {
                            pw.println();
                        }
                        pw.println("Shared users:");
                        printedSomething = true;
                    }
                    pw.print("  SharedUser [");
                    pw.print(su.name);
                    pw.print("] (");
                    pw.print(Integer.toHexString(System.identityHashCode(su)));
                    pw.println("):");
                    pw.print("    userId=");
                    pw.print(su.userId);
                    pw.print(" gids=");
                    pw.println(PackageManagerService.arrayToString(su.gids));
                    pw.println("    grantedPermissions:");
                    Iterator i$ = su.grantedPermissions.iterator();
                    while (i$.hasNext()) {
                        String s = (String) i$.next();
                        pw.print("      ");
                        pw.println(s);
                    }
                }
            }
        }
    }

    void dumpReadMessagesLPr(PrintWriter pw, DumpState dumpState) {
        pw.println("Settings parse messages:");
        pw.print(this.mReadMessages.toString());
    }

    private static void dumpSplitNames(PrintWriter pw, Package pkg) {
        if (pkg == null) {
            pw.print("unknown");
            return;
        }
        pw.print("[");
        pw.print("base");
        if (pkg.baseRevisionCode != 0) {
            pw.print(":");
            pw.print(pkg.baseRevisionCode);
        }
        if (pkg.splitNames != null) {
            for (int i = 0; i < pkg.splitNames.length; i++) {
                pw.print(", ");
                pw.print(pkg.splitNames[i]);
                if (pkg.splitRevisionCodes[i] != 0) {
                    pw.print(":");
                    pw.print(pkg.splitRevisionCodes[i]);
                }
            }
        }
        pw.print("]");
    }
}
