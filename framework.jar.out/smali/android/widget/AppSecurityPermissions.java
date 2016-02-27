package android.widget;

import android.C0000R;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.Context;
import android.content.DialogInterface;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.PermissionGroupInfo;
import android.content.pm.PermissionInfo;
import android.graphics.drawable.Drawable;
import android.os.Parcel;
import android.text.SpannableStringBuilder;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.LinearLayout.LayoutParams;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class AppSecurityPermissions {
    private static final String TAG = "AppSecurityPermissions";
    public static final int WHICH_ALL = 65535;
    public static final int WHICH_DEVICE = 2;
    public static final int WHICH_NEW = 4;
    public static final int WHICH_PERSONAL = 1;
    private static final boolean localLOGV = false;
    private final Context mContext;
    private final LayoutInflater mInflater;
    private final CharSequence mNewPermPrefix;
    private String mPackageName;
    private final PermissionInfoComparator mPermComparator;
    private final PermissionGroupInfoComparator mPermGroupComparator;
    private final Map<String, MyPermissionGroupInfo> mPermGroups;
    private final List<MyPermissionGroupInfo> mPermGroupsList;
    private final List<MyPermissionInfo> mPermsList;
    private final PackageManager mPm;

    static class MyPermissionGroupInfo extends PermissionGroupInfo {
        final ArrayList<MyPermissionInfo> mAllPermissions;
        final ArrayList<MyPermissionInfo> mDevicePermissions;
        CharSequence mLabel;
        final ArrayList<MyPermissionInfo> mNewPermissions;
        final ArrayList<MyPermissionInfo> mPersonalPermissions;

        MyPermissionGroupInfo(PermissionInfo perm) {
            this.mNewPermissions = new ArrayList();
            this.mPersonalPermissions = new ArrayList();
            this.mDevicePermissions = new ArrayList();
            this.mAllPermissions = new ArrayList();
            this.name = perm.packageName;
            this.packageName = perm.packageName;
        }

        MyPermissionGroupInfo(PermissionGroupInfo info) {
            super(info);
            this.mNewPermissions = new ArrayList();
            this.mPersonalPermissions = new ArrayList();
            this.mDevicePermissions = new ArrayList();
            this.mAllPermissions = new ArrayList();
        }

        public Drawable loadGroupIcon(PackageManager pm) {
            if (this.icon != 0) {
                return loadUnbadgedIcon(pm);
            }
            try {
                return pm.getApplicationInfo(this.packageName, 0).loadUnbadgedIcon(pm);
            } catch (NameNotFoundException e) {
                return null;
            }
        }
    }

    private static class MyPermissionInfo extends PermissionInfo {
        int mExistingReqFlags;
        CharSequence mLabel;
        boolean mNew;
        int mNewReqFlags;

        MyPermissionInfo(PermissionInfo info) {
            super(info);
        }
    }

    private static class PermissionGroupInfoComparator implements Comparator<MyPermissionGroupInfo> {
        private final Collator sCollator;

        PermissionGroupInfoComparator() {
            this.sCollator = Collator.getInstance();
        }

        public final int compare(MyPermissionGroupInfo a, MyPermissionGroupInfo b) {
            if (((a.flags ^ b.flags) & AppSecurityPermissions.WHICH_PERSONAL) != 0) {
                if ((a.flags & AppSecurityPermissions.WHICH_PERSONAL) != 0) {
                    return -1;
                }
                return AppSecurityPermissions.WHICH_PERSONAL;
            } else if (a.priority == b.priority) {
                return this.sCollator.compare(a.mLabel, b.mLabel);
            } else {
                if (a.priority <= b.priority) {
                    return AppSecurityPermissions.WHICH_PERSONAL;
                }
                return -1;
            }
        }
    }

    private static class PermissionInfoComparator implements Comparator<MyPermissionInfo> {
        private final Collator sCollator;

        PermissionInfoComparator() {
            this.sCollator = Collator.getInstance();
        }

        public final int compare(MyPermissionInfo a, MyPermissionInfo b) {
            return this.sCollator.compare(a.mLabel, b.mLabel);
        }
    }

    public static class PermissionItemView extends LinearLayout implements OnClickListener {
        AlertDialog mDialog;
        MyPermissionGroupInfo mGroup;
        private String mPackageName;
        MyPermissionInfo mPerm;
        private boolean mShowRevokeUI;

        /* renamed from: android.widget.AppSecurityPermissions.PermissionItemView.1 */
        class C09421 implements DialogInterface.OnClickListener {
            C09421() {
            }

            public void onClick(DialogInterface dialog, int which) {
                PermissionItemView.this.getContext().getPackageManager().revokePermission(PermissionItemView.this.mPackageName, PermissionItemView.this.mPerm.name);
                PermissionItemView.this.setVisibility(8);
            }
        }

        public PermissionItemView(Context context, AttributeSet attrs) {
            super(context, attrs);
            this.mShowRevokeUI = false;
            setClickable(true);
        }

        public void setPermission(MyPermissionGroupInfo grp, MyPermissionInfo perm, boolean first, CharSequence newPermPrefix, String packageName, boolean showRevokeUI) {
            this.mGroup = grp;
            this.mPerm = perm;
            this.mShowRevokeUI = showRevokeUI;
            this.mPackageName = packageName;
            ImageView permGrpIcon = (ImageView) findViewById(16909014);
            TextView permNameView = (TextView) findViewById(16909015);
            PackageManager pm = getContext().getPackageManager();
            Drawable icon = null;
            if (first) {
                icon = grp.loadGroupIcon(pm);
            }
            CharSequence label = perm.mLabel;
            if (perm.mNew && newPermPrefix != null) {
                SpannableStringBuilder builder = new SpannableStringBuilder();
                Parcel parcel = Parcel.obtain();
                TextUtils.writeToParcel(newPermPrefix, parcel, 0);
                parcel.setDataPosition(0);
                CharSequence newStr = (CharSequence) TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(parcel);
                parcel.recycle();
                builder.append(newStr);
                builder.append(label);
                label = builder;
            }
            permGrpIcon.setImageDrawable(icon);
            permNameView.setText(label);
            setOnClickListener(this);
        }

        public void onClick(View v) {
            if (this.mGroup != null && this.mPerm != null) {
                if (this.mDialog != null) {
                    this.mDialog.dismiss();
                }
                PackageManager pm = getContext().getPackageManager();
                Builder builder = new Builder(getContext());
                builder.setTitle(this.mGroup.mLabel);
                if (this.mPerm.descriptionRes != 0) {
                    builder.setMessage(this.mPerm.loadDescription(pm));
                } else {
                    CharSequence appName;
                    try {
                        appName = pm.getApplicationInfo(this.mPerm.packageName, 0).loadLabel(pm);
                    } catch (NameNotFoundException e) {
                        appName = this.mPerm.packageName;
                    }
                    StringBuilder sbuilder = new StringBuilder(AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
                    Context context = getContext();
                    Object[] objArr = new Object[AppSecurityPermissions.WHICH_PERSONAL];
                    objArr[0] = appName;
                    sbuilder.append(context.getString(17040626, objArr));
                    sbuilder.append("\n\n");
                    sbuilder.append(this.mPerm.name);
                    builder.setMessage(sbuilder.toString());
                }
                builder.setCancelable(true);
                builder.setIcon(this.mGroup.loadGroupIcon(pm));
                addRevokeUIIfNecessary(builder);
                this.mDialog = builder.show();
                this.mDialog.setCanceledOnTouchOutside(true);
            }
        }

        protected void onDetachedFromWindow() {
            super.onDetachedFromWindow();
            if (this.mDialog != null) {
                this.mDialog.dismiss();
            }
        }

        private void addRevokeUIIfNecessary(Builder builder) {
            if (this.mShowRevokeUI) {
                if (!((this.mPerm.mExistingReqFlags & AppSecurityPermissions.WHICH_PERSONAL) != 0)) {
                    builder.setNegativeButton(17040929, new C09421());
                    builder.setPositiveButton(C0000R.string.ok, null);
                }
            }
        }
    }

    private AppSecurityPermissions(Context context) {
        this.mPermGroups = new HashMap();
        this.mPermGroupsList = new ArrayList();
        this.mPermGroupComparator = new PermissionGroupInfoComparator();
        this.mPermComparator = new PermissionInfoComparator();
        this.mPermsList = new ArrayList();
        this.mContext = context;
        this.mInflater = (LayoutInflater) this.mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.mPm = this.mContext.getPackageManager();
        this.mNewPermPrefix = this.mContext.getText(17040625);
    }

    public AppSecurityPermissions(Context context, String packageName) {
        this(context);
        this.mPackageName = packageName;
        Set<MyPermissionInfo> permSet = new HashSet();
        try {
            PackageInfo pkgInfo = this.mPm.getPackageInfo(packageName, AccessibilityNodeInfo.ACTION_SCROLL_FORWARD);
            if (!(pkgInfo.applicationInfo == null || pkgInfo.applicationInfo.uid == -1)) {
                getAllUsedPermissions(pkgInfo.applicationInfo.uid, permSet);
            }
            this.mPermsList.addAll(permSet);
            setPermissions(this.mPermsList);
        } catch (NameNotFoundException e) {
            Log.w(TAG, "Couldn't retrieve permissions for package:" + packageName);
        }
    }

    public AppSecurityPermissions(Context context, PackageInfo info) {
        this(context);
        Set<MyPermissionInfo> permSet = new HashSet();
        if (info != null) {
            this.mPackageName = info.packageName;
            PackageInfo installedPkgInfo = null;
            if (info.requestedPermissions != null) {
                try {
                    installedPkgInfo = this.mPm.getPackageInfo(info.packageName, AccessibilityNodeInfo.ACTION_SCROLL_FORWARD);
                } catch (NameNotFoundException e) {
                }
                extractPerms(info, permSet, installedPkgInfo);
            }
            if (info.sharedUserId != null) {
                try {
                    getAllUsedPermissions(this.mPm.getUidForSharedUser(info.sharedUserId), permSet);
                } catch (NameNotFoundException e2) {
                    Log.w(TAG, "Couldn't retrieve shared user id for: " + info.packageName);
                }
            }
            this.mPermsList.addAll(permSet);
            setPermissions(this.mPermsList);
        }
    }

    public static View getPermissionItemView(Context context, CharSequence grpName, CharSequence description, boolean dangerous) {
        return getPermissionItemViewOld(context, (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE), grpName, description, dangerous, context.getDrawable(dangerous ? 17302317 : 17302586));
    }

    private void getAllUsedPermissions(int sharedUid, Set<MyPermissionInfo> permSet) {
        String[] sharedPkgList = this.mPm.getPackagesForUid(sharedUid);
        if (sharedPkgList != null && sharedPkgList.length != 0) {
            String[] arr$ = sharedPkgList;
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += WHICH_PERSONAL) {
                getPermissionsForPackage(arr$[i$], permSet);
            }
        }
    }

    private void getPermissionsForPackage(String packageName, Set<MyPermissionInfo> permSet) {
        try {
            PackageInfo pkgInfo = this.mPm.getPackageInfo(packageName, AccessibilityNodeInfo.ACTION_SCROLL_FORWARD);
            extractPerms(pkgInfo, permSet, pkgInfo);
        } catch (NameNotFoundException e) {
            Log.w(TAG, "Couldn't retrieve permissions for package: " + packageName);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void extractPerms(android.content.pm.PackageInfo r22, java.util.Set<android.widget.AppSecurityPermissions.MyPermissionInfo> r23, android.content.pm.PackageInfo r24) {
        /*
        r21 = this;
        r0 = r22;
        r0 = r0.requestedPermissions;
        r16 = r0;
        r0 = r22;
        r6 = r0.requestedPermissionsFlags;
        if (r16 == 0) goto L_0x0013;
    L_0x000c:
        r0 = r16;
        r0 = r0.length;
        r18 = r0;
        if (r18 != 0) goto L_0x0014;
    L_0x0013:
        return;
    L_0x0014:
        r10 = 0;
    L_0x0015:
        r0 = r16;
        r0 = r0.length;
        r18 = r0;
        r0 = r18;
        if (r10 >= r0) goto L_0x0013;
    L_0x001e:
        r15 = r16[r10];
        if (r24 == 0) goto L_0x0031;
    L_0x0022:
        r0 = r22;
        r1 = r24;
        if (r0 != r1) goto L_0x0031;
    L_0x0028:
        r18 = r6[r10];
        r18 = r18 & 2;
        if (r18 != 0) goto L_0x0031;
    L_0x002e:
        r10 = r10 + 1;
        goto L_0x0015;
    L_0x0031:
        r0 = r21;
        r0 = r0.mPm;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r0;
        r19 = 0;
        r0 = r18;
        r1 = r19;
        r17 = r0.getPermissionInfo(r15, r1);	 Catch:{ NameNotFoundException -> 0x00f2 }
        if (r17 == 0) goto L_0x002e;
    L_0x0043:
        r5 = -1;
        if (r24 == 0) goto L_0x006f;
    L_0x0046:
        r0 = r24;
        r0 = r0.requestedPermissions;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r0;
        if (r18 == 0) goto L_0x006f;
    L_0x004e:
        r11 = 0;
    L_0x004f:
        r0 = r24;
        r0 = r0.requestedPermissions;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r0;
        r0 = r18;
        r0 = r0.length;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r0;
        r0 = r18;
        if (r11 >= r0) goto L_0x006f;
    L_0x005e:
        r0 = r24;
        r0 = r0.requestedPermissions;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r0;
        r18 = r18[r11];	 Catch:{ NameNotFoundException -> 0x00f2 }
        r0 = r18;
        r18 = r15.equals(r0);	 Catch:{ NameNotFoundException -> 0x00f2 }
        if (r18 == 0) goto L_0x010f;
    L_0x006e:
        r5 = r11;
    L_0x006f:
        if (r5 < 0) goto L_0x0113;
    L_0x0071:
        r0 = r24;
        r0 = r0.requestedPermissionsFlags;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r0;
        r4 = r18[r5];	 Catch:{ NameNotFoundException -> 0x00f2 }
    L_0x0079:
        r18 = r6[r10];	 Catch:{ NameNotFoundException -> 0x00f2 }
        r0 = r21;
        r1 = r17;
        r2 = r18;
        r18 = r0.isDisplayablePermission(r1, r2, r4);	 Catch:{ NameNotFoundException -> 0x00f2 }
        if (r18 == 0) goto L_0x002e;
    L_0x0087:
        r0 = r17;
        r14 = r0.group;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r8 = r14;
        if (r8 != 0) goto L_0x0096;
    L_0x008e:
        r0 = r17;
        r8 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r0 = r17;
        r0.group = r8;	 Catch:{ NameNotFoundException -> 0x00f2 }
    L_0x0096:
        r0 = r21;
        r0 = r0.mPermGroups;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r0;
        r0 = r18;
        r7 = r0.get(r8);	 Catch:{ NameNotFoundException -> 0x00f2 }
        r7 = (android.widget.AppSecurityPermissions.MyPermissionGroupInfo) r7;	 Catch:{ NameNotFoundException -> 0x00f2 }
        if (r7 != 0) goto L_0x00d3;
    L_0x00a6:
        r9 = 0;
        if (r14 == 0) goto L_0x00b9;
    L_0x00a9:
        r0 = r21;
        r0 = r0.mPm;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r0;
        r19 = 0;
        r0 = r18;
        r1 = r19;
        r9 = r0.getPermissionGroupInfo(r14, r1);	 Catch:{ NameNotFoundException -> 0x00f2 }
    L_0x00b9:
        if (r9 == 0) goto L_0x0116;
    L_0x00bb:
        r7 = new android.widget.AppSecurityPermissions$MyPermissionGroupInfo;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r7.<init>(r9);	 Catch:{ NameNotFoundException -> 0x00f2 }
    L_0x00c0:
        r0 = r21;
        r0 = r0.mPermGroups;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r0;
        r0 = r17;
        r0 = r0.group;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r19 = r0;
        r0 = r18;
        r1 = r19;
        r0.put(r1, r7);	 Catch:{ NameNotFoundException -> 0x00f2 }
    L_0x00d3:
        if (r24 == 0) goto L_0x0146;
    L_0x00d5:
        r18 = r4 & 2;
        if (r18 != 0) goto L_0x0146;
    L_0x00d9:
        r13 = 1;
    L_0x00da:
        r12 = new android.widget.AppSecurityPermissions$MyPermissionInfo;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r0 = r17;
        r12.<init>(r0);	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r6[r10];	 Catch:{ NameNotFoundException -> 0x00f2 }
        r0 = r18;
        r12.mNewReqFlags = r0;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r12.mExistingReqFlags = r4;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r12.mNew = r13;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r0 = r23;
        r0.add(r12);	 Catch:{ NameNotFoundException -> 0x00f2 }
        goto L_0x002e;
    L_0x00f2:
        r3 = move-exception;
        r18 = "AppSecurityPermissions";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "Ignoring unknown permission:";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r15);
        r19 = r19.toString();
        android.util.Log.i(r18, r19);
        goto L_0x002e;
    L_0x010f:
        r11 = r11 + 1;
        goto L_0x004f;
    L_0x0113:
        r4 = 0;
        goto L_0x0079;
    L_0x0116:
        r0 = r17;
        r0 = r0.packageName;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r0;
        r0 = r18;
        r1 = r17;
        r1.group = r0;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r0 = r21;
        r0 = r0.mPermGroups;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r18 = r0;
        r0 = r17;
        r0 = r0.group;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r19 = r0;
        r7 = r18.get(r19);	 Catch:{ NameNotFoundException -> 0x00f2 }
        r7 = (android.widget.AppSecurityPermissions.MyPermissionGroupInfo) r7;	 Catch:{ NameNotFoundException -> 0x00f2 }
        if (r7 != 0) goto L_0x013d;
    L_0x0136:
        r7 = new android.widget.AppSecurityPermissions$MyPermissionGroupInfo;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r0 = r17;
        r7.<init>(r0);	 Catch:{ NameNotFoundException -> 0x00f2 }
    L_0x013d:
        r7 = new android.widget.AppSecurityPermissions$MyPermissionGroupInfo;	 Catch:{ NameNotFoundException -> 0x00f2 }
        r0 = r17;
        r7.<init>(r0);	 Catch:{ NameNotFoundException -> 0x00f2 }
        goto L_0x00c0;
    L_0x0146:
        r13 = 0;
        goto L_0x00da;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.widget.AppSecurityPermissions.extractPerms(android.content.pm.PackageInfo, java.util.Set, android.content.pm.PackageInfo):void");
    }

    public int getPermissionCount() {
        return getPermissionCount(WHICH_ALL);
    }

    private List<MyPermissionInfo> getPermissionList(MyPermissionGroupInfo grp, int which) {
        if (which == WHICH_NEW) {
            return grp.mNewPermissions;
        }
        if (which == WHICH_PERSONAL) {
            return grp.mPersonalPermissions;
        }
        if (which == WHICH_DEVICE) {
            return grp.mDevicePermissions;
        }
        return grp.mAllPermissions;
    }

    public int getPermissionCount(int which) {
        int N = 0;
        for (int i = 0; i < this.mPermGroupsList.size(); i += WHICH_PERSONAL) {
            N += getPermissionList((MyPermissionGroupInfo) this.mPermGroupsList.get(i), which).size();
        }
        return N;
    }

    public View getPermissionsView() {
        return getPermissionsView(WHICH_ALL, false);
    }

    public View getPermissionsViewWithRevokeButtons() {
        return getPermissionsView(WHICH_ALL, true);
    }

    public View getPermissionsView(int which) {
        return getPermissionsView(which, false);
    }

    private View getPermissionsView(int which, boolean showRevokeUI) {
        LinearLayout permsView = (LinearLayout) this.mInflater.inflate(17367093, null);
        LinearLayout displayList = (LinearLayout) permsView.findViewById(16909021);
        View noPermsView = permsView.findViewById(16909020);
        displayPermissions(this.mPermGroupsList, displayList, which, showRevokeUI);
        if (displayList.getChildCount() <= 0) {
            noPermsView.setVisibility(0);
        }
        return permsView;
    }

    private void displayPermissions(List<MyPermissionGroupInfo> groups, LinearLayout permListView, int which, boolean showRevokeUI) {
        permListView.removeAllViews();
        int spacing = (int) (8.0f * this.mContext.getResources().getDisplayMetrics().density);
        for (int i = 0; i < groups.size(); i += WHICH_PERSONAL) {
            MyPermissionGroupInfo grp = (MyPermissionGroupInfo) groups.get(i);
            List<MyPermissionInfo> perms = getPermissionList(grp, which);
            int j = 0;
            while (j < perms.size()) {
                CharSequence charSequence;
                MyPermissionInfo perm = (MyPermissionInfo) perms.get(j);
                boolean z = j == 0;
                if (which != WHICH_NEW) {
                    charSequence = this.mNewPermPrefix;
                } else {
                    charSequence = null;
                }
                View view = getPermissionItemView(grp, perm, z, charSequence, showRevokeUI);
                LayoutParams lp = new LayoutParams(-1, -2);
                if (j == 0) {
                    lp.topMargin = spacing;
                }
                if (j == grp.mAllPermissions.size() - 1) {
                    lp.bottomMargin = spacing;
                }
                if (permListView.getChildCount() == 0) {
                    lp.topMargin *= WHICH_DEVICE;
                }
                permListView.addView(view, (ViewGroup.LayoutParams) lp);
                j += WHICH_PERSONAL;
            }
        }
    }

    private PermissionItemView getPermissionItemView(MyPermissionGroupInfo grp, MyPermissionInfo perm, boolean first, CharSequence newPermPrefix, boolean showRevokeUI) {
        return getPermissionItemView(this.mContext, this.mInflater, grp, perm, first, newPermPrefix, this.mPackageName, showRevokeUI);
    }

    private static PermissionItemView getPermissionItemView(Context context, LayoutInflater inflater, MyPermissionGroupInfo grp, MyPermissionInfo perm, boolean first, CharSequence newPermPrefix, String packageName, boolean showRevokeUI) {
        PermissionItemView permView = (PermissionItemView) inflater.inflate((perm.flags & WHICH_PERSONAL) != 0 ? 17367091 : 17367090, null);
        permView.setPermission(grp, perm, first, newPermPrefix, packageName, showRevokeUI);
        return permView;
    }

    private static View getPermissionItemViewOld(Context context, LayoutInflater inflater, CharSequence grpName, CharSequence permList, boolean dangerous, Drawable icon) {
        View permView = inflater.inflate(17367092, null);
        TextView permGrpView = (TextView) permView.findViewById(16909018);
        TextView permDescView = (TextView) permView.findViewById(16909019);
        ((ImageView) permView.findViewById(16909014)).setImageDrawable(icon);
        if (grpName != null) {
            permGrpView.setText(grpName);
            permDescView.setText(permList);
        } else {
            permGrpView.setText(permList);
            permDescView.setVisibility(8);
        }
        return permView;
    }

    private boolean isDisplayablePermission(PermissionInfo pInfo, int newReqFlags, int existingReqFlags) {
        boolean isNormal;
        boolean isDevelopment;
        int base = pInfo.protectionLevel & 15;
        if (base == 0) {
            isNormal = true;
        } else {
            isNormal = false;
        }
        boolean isDangerous;
        if (base == WHICH_PERSONAL) {
            isDangerous = true;
        } else {
            isDangerous = false;
        }
        boolean isRequired;
        if ((newReqFlags & WHICH_PERSONAL) != 0) {
            isRequired = true;
        } else {
            isRequired = false;
        }
        if ((pInfo.protectionLevel & 32) != 0) {
            isDevelopment = true;
        } else {
            isDevelopment = false;
        }
        boolean wasGranted;
        if ((existingReqFlags & WHICH_DEVICE) != 0) {
            wasGranted = true;
        } else {
            wasGranted = false;
        }
        boolean isGranted;
        if ((newReqFlags & WHICH_DEVICE) != 0) {
            isGranted = true;
        } else {
            isGranted = false;
        }
        if ((isNormal || isDangerous) && (isRequired || wasGranted || isGranted)) {
            return true;
        }
        if (isDevelopment && wasGranted) {
            return true;
        }
        return false;
    }

    private void addPermToList(List<MyPermissionInfo> permList, MyPermissionInfo pInfo) {
        if (pInfo.mLabel == null) {
            pInfo.mLabel = pInfo.loadLabel(this.mPm);
        }
        int idx = Collections.binarySearch(permList, pInfo, this.mPermComparator);
        if (idx < 0) {
            permList.add((-idx) - 1, pInfo);
        }
    }

    private void setPermissions(List<MyPermissionInfo> permList) {
        if (permList != null) {
            for (MyPermissionInfo pInfo : permList) {
                if (isDisplayablePermission(pInfo, pInfo.mNewReqFlags, pInfo.mExistingReqFlags)) {
                    MyPermissionGroupInfo group = (MyPermissionGroupInfo) this.mPermGroups.get(pInfo.group);
                    if (group != null) {
                        pInfo.mLabel = pInfo.loadLabel(this.mPm);
                        addPermToList(group.mAllPermissions, pInfo);
                        if (pInfo.mNew) {
                            addPermToList(group.mNewPermissions, pInfo);
                        }
                        if ((group.flags & WHICH_PERSONAL) != 0) {
                            addPermToList(group.mPersonalPermissions, pInfo);
                        } else {
                            addPermToList(group.mDevicePermissions, pInfo);
                        }
                    }
                }
            }
        }
        for (MyPermissionGroupInfo pgrp : this.mPermGroups.values()) {
            if (pgrp.labelRes == 0 && pgrp.nonLocalizedLabel == null) {
                try {
                    pgrp.mLabel = this.mPm.getApplicationInfo(pgrp.packageName, 0).loadLabel(this.mPm);
                } catch (NameNotFoundException e) {
                    pgrp.mLabel = pgrp.loadLabel(this.mPm);
                }
            } else {
                pgrp.mLabel = pgrp.loadLabel(this.mPm);
            }
            this.mPermGroupsList.add(pgrp);
        }
        Collections.sort(this.mPermGroupsList, this.mPermGroupComparator);
    }
}
