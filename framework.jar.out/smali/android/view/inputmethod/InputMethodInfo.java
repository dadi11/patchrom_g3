package android.view.inputmethod;

import android.content.ComponentName;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.content.res.Resources.NotFoundException;
import android.graphics.drawable.Drawable;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Printer;
import java.io.IOException;
import java.util.List;
import org.xmlpull.v1.XmlPullParserException;

public final class InputMethodInfo implements Parcelable {
    public static final Creator<InputMethodInfo> CREATOR;
    static final String TAG = "InputMethodInfo";
    private final boolean mForceDefault;
    final String mId;
    private final boolean mIsAuxIme;
    final int mIsDefaultResId;
    final ResolveInfo mService;
    final String mSettingsActivityName;
    private final InputMethodSubtypeArray mSubtypes;
    private final boolean mSupportsSwitchingToNextInputMethod;

    /* renamed from: android.view.inputmethod.InputMethodInfo.1 */
    static class C08961 implements Creator<InputMethodInfo> {
        C08961() {
        }

        public InputMethodInfo createFromParcel(Parcel source) {
            return new InputMethodInfo(source);
        }

        public InputMethodInfo[] newArray(int size) {
            return new InputMethodInfo[size];
        }
    }

    public InputMethodInfo(Context context, ResolveInfo service) throws XmlPullParserException, IOException {
        this(context, service, null);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public InputMethodInfo(android.content.Context r26, android.content.pm.ResolveInfo r27, java.util.Map<java.lang.String, java.util.List<android.view.inputmethod.InputMethodSubtype>> r28) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
        /*
        r25 = this;
        r25.<init>();
        r0 = r27;
        r1 = r25;
        r1.mService = r0;
        r0 = r27;
        r0 = r0.serviceInfo;
        r17 = r0;
        r22 = new android.content.ComponentName;
        r0 = r17;
        r0 = r0.packageName;
        r23 = r0;
        r0 = r17;
        r0 = r0.name;
        r24 = r0;
        r22.<init>(r23, r24);
        r22 = r22.flattenToShortString();
        r0 = r22;
        r1 = r25;
        r1.mId = r0;
        r9 = 1;
        r20 = 0;
        r22 = 0;
        r0 = r22;
        r1 = r25;
        r1.mForceDefault = r0;
        r13 = r26.getPackageManager();
        r16 = 0;
        r10 = 0;
        r12 = 0;
        r19 = new java.util.ArrayList;
        r19.<init>();
        r22 = "android.view.im";
        r0 = r17;
        r1 = r22;
        r12 = r0.loadXmlMetaData(r13, r1);	 Catch:{ NameNotFoundException -> 0x0056 }
        if (r12 != 0) goto L_0x007d;
    L_0x004e:
        r22 = new org.xmlpull.v1.XmlPullParserException;	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = "No android.view.im meta-data";
        r22.<init>(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        throw r22;	 Catch:{ NameNotFoundException -> 0x0056 }
    L_0x0056:
        r7 = move-exception;
        r22 = new org.xmlpull.v1.XmlPullParserException;	 Catch:{ all -> 0x0076 }
        r23 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0076 }
        r23.<init>();	 Catch:{ all -> 0x0076 }
        r24 = "Unable to create context for: ";
        r23 = r23.append(r24);	 Catch:{ all -> 0x0076 }
        r0 = r17;
        r0 = r0.packageName;	 Catch:{ all -> 0x0076 }
        r24 = r0;
        r23 = r23.append(r24);	 Catch:{ all -> 0x0076 }
        r23 = r23.toString();	 Catch:{ all -> 0x0076 }
        r22.<init>(r23);	 Catch:{ all -> 0x0076 }
        throw r22;	 Catch:{ all -> 0x0076 }
    L_0x0076:
        r22 = move-exception;
        if (r12 == 0) goto L_0x007c;
    L_0x0079:
        r12.close();
    L_0x007c:
        throw r22;
    L_0x007d:
        r0 = r17;
        r0 = r0.applicationInfo;	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = r0;
        r0 = r22;
        r14 = r13.getResourcesForApplication(r0);	 Catch:{ NameNotFoundException -> 0x0056 }
        r5 = android.util.Xml.asAttributeSet(r12);	 Catch:{ NameNotFoundException -> 0x0056 }
    L_0x008d:
        r21 = r12.next();	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = 1;
        r0 = r21;
        r1 = r22;
        if (r0 == r1) goto L_0x00a1;
    L_0x0099:
        r22 = 2;
        r0 = r21;
        r1 = r22;
        if (r0 != r1) goto L_0x008d;
    L_0x00a1:
        r11 = r12.getName();	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = "input-method";
        r0 = r22;
        r22 = r0.equals(r11);	 Catch:{ NameNotFoundException -> 0x0056 }
        if (r22 != 0) goto L_0x00b7;
    L_0x00af:
        r22 = new org.xmlpull.v1.XmlPullParserException;	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = "Meta-data does not start with input-method tag";
        r22.<init>(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        throw r22;	 Catch:{ NameNotFoundException -> 0x0056 }
    L_0x00b7:
        r22 = com.android.internal.R.styleable.InputMethod;	 Catch:{ NameNotFoundException -> 0x0056 }
        r0 = r22;
        r15 = r14.obtainAttributes(r5, r0);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = 1;
        r0 = r22;
        r16 = r15.getString(r0);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = 0;
        r23 = 0;
        r0 = r22;
        r1 = r23;
        r10 = r15.getResourceId(r0, r1);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = 2;
        r23 = 0;
        r0 = r22;
        r1 = r23;
        r20 = r15.getBoolean(r0, r1);	 Catch:{ NameNotFoundException -> 0x0056 }
        r15.recycle();	 Catch:{ NameNotFoundException -> 0x0056 }
        r6 = r12.getDepth();	 Catch:{ NameNotFoundException -> 0x0056 }
    L_0x00e6:
        r21 = r12.next();	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = 3;
        r0 = r21;
        r1 = r22;
        if (r0 != r1) goto L_0x00fa;
    L_0x00f2:
        r22 = r12.getDepth();	 Catch:{ NameNotFoundException -> 0x0056 }
        r0 = r22;
        if (r0 <= r6) goto L_0x01c6;
    L_0x00fa:
        r22 = 1;
        r0 = r21;
        r1 = r22;
        if (r0 == r1) goto L_0x01c6;
    L_0x0102:
        r22 = 2;
        r0 = r21;
        r1 = r22;
        if (r0 != r1) goto L_0x00e6;
    L_0x010a:
        r11 = r12.getName();	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = "subtype";
        r0 = r22;
        r22 = r0.equals(r11);	 Catch:{ NameNotFoundException -> 0x0056 }
        if (r22 != 0) goto L_0x0121;
    L_0x0119:
        r22 = new org.xmlpull.v1.XmlPullParserException;	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = "Meta-data in input-method does not start with subtype tag";
        r22.<init>(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        throw r22;	 Catch:{ NameNotFoundException -> 0x0056 }
    L_0x0121:
        r22 = com.android.internal.R.styleable.InputMethod_Subtype;	 Catch:{ NameNotFoundException -> 0x0056 }
        r0 = r22;
        r3 = r14.obtainAttributes(r5, r0);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = new android.view.inputmethod.InputMethodSubtype$InputMethodSubtypeBuilder;	 Catch:{ NameNotFoundException -> 0x0056 }
        r22.<init>();	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = 0;
        r24 = 0;
        r0 = r23;
        r1 = r24;
        r23 = r3.getResourceId(r0, r1);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = r22.setSubtypeNameResId(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = 1;
        r24 = 0;
        r0 = r23;
        r1 = r24;
        r23 = r3.getResourceId(r0, r1);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = r22.setSubtypeIconResId(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = 2;
        r0 = r23;
        r23 = r3.getString(r0);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = r22.setSubtypeLocale(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = 3;
        r0 = r23;
        r23 = r3.getString(r0);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = r22.setSubtypeMode(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = 4;
        r0 = r23;
        r23 = r3.getString(r0);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = r22.setSubtypeExtraValue(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = 5;
        r24 = 0;
        r0 = r23;
        r1 = r24;
        r23 = r3.getBoolean(r0, r1);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = r22.setIsAuxiliary(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = 6;
        r24 = 0;
        r0 = r23;
        r1 = r24;
        r23 = r3.getBoolean(r0, r1);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = r22.setOverridesImplicitlyEnabledSubtype(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = 7;
        r24 = 0;
        r0 = r23;
        r1 = r24;
        r23 = r3.getInt(r0, r1);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = r22.setSubtypeId(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        r23 = 8;
        r24 = 0;
        r0 = r23;
        r1 = r24;
        r23 = r3.getBoolean(r0, r1);	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = r22.setIsAsciiCapable(r23);	 Catch:{ NameNotFoundException -> 0x0056 }
        r18 = r22.build();	 Catch:{ NameNotFoundException -> 0x0056 }
        r22 = r18.isAuxiliary();	 Catch:{ NameNotFoundException -> 0x0056 }
        if (r22 != 0) goto L_0x01bd;
    L_0x01bc:
        r9 = 0;
    L_0x01bd:
        r0 = r19;
        r1 = r18;
        r0.add(r1);	 Catch:{ NameNotFoundException -> 0x0056 }
        goto L_0x00e6;
    L_0x01c6:
        if (r12 == 0) goto L_0x01cb;
    L_0x01c8:
        r12.close();
    L_0x01cb:
        r22 = r19.size();
        if (r22 != 0) goto L_0x01d2;
    L_0x01d1:
        r9 = 0;
    L_0x01d2:
        if (r28 == 0) goto L_0x0240;
    L_0x01d4:
        r0 = r25;
        r0 = r0.mId;
        r22 = r0;
        r0 = r28;
        r1 = r22;
        r22 = r0.containsKey(r1);
        if (r22 == 0) goto L_0x0240;
    L_0x01e4:
        r0 = r25;
        r0 = r0.mId;
        r22 = r0;
        r0 = r28;
        r1 = r22;
        r4 = r0.get(r1);
        r4 = (java.util.List) r4;
        r2 = r4.size();
        r8 = 0;
    L_0x01f9:
        if (r8 >= r2) goto L_0x0240;
    L_0x01fb:
        r18 = r4.get(r8);
        r18 = (android.view.inputmethod.InputMethodSubtype) r18;
        r0 = r19;
        r1 = r18;
        r22 = r0.contains(r1);
        if (r22 != 0) goto L_0x0215;
    L_0x020b:
        r0 = r19;
        r1 = r18;
        r0.add(r1);
    L_0x0212:
        r8 = r8 + 1;
        goto L_0x01f9;
    L_0x0215:
        r22 = "InputMethodInfo";
        r23 = new java.lang.StringBuilder;
        r23.<init>();
        r24 = "Duplicated subtype definition found: ";
        r23 = r23.append(r24);
        r24 = r18.getLocale();
        r23 = r23.append(r24);
        r24 = ", ";
        r23 = r23.append(r24);
        r24 = r18.getMode();
        r23 = r23.append(r24);
        r23 = r23.toString();
        android.util.Slog.w(r22, r23);
        goto L_0x0212;
    L_0x0240:
        r22 = new android.view.inputmethod.InputMethodSubtypeArray;
        r0 = r22;
        r1 = r19;
        r0.<init>(r1);
        r0 = r22;
        r1 = r25;
        r1.mSubtypes = r0;
        r0 = r16;
        r1 = r25;
        r1.mSettingsActivityName = r0;
        r0 = r25;
        r0.mIsDefaultResId = r10;
        r0 = r25;
        r0.mIsAuxIme = r9;
        r0 = r20;
        r1 = r25;
        r1.mSupportsSwitchingToNextInputMethod = r0;
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.view.inputmethod.InputMethodInfo.<init>(android.content.Context, android.content.pm.ResolveInfo, java.util.Map):void");
    }

    InputMethodInfo(Parcel source) {
        boolean z = true;
        this.mId = source.readString();
        this.mSettingsActivityName = source.readString();
        this.mIsDefaultResId = source.readInt();
        this.mIsAuxIme = source.readInt() == 1;
        if (source.readInt() != 1) {
            z = false;
        }
        this.mSupportsSwitchingToNextInputMethod = z;
        this.mService = (ResolveInfo) ResolveInfo.CREATOR.createFromParcel(source);
        this.mSubtypes = new InputMethodSubtypeArray(source);
        this.mForceDefault = false;
    }

    public InputMethodInfo(String packageName, String className, CharSequence label, String settingsActivity) {
        this(buildDummyResolveInfo(packageName, className, label), false, settingsActivity, null, 0, false, true);
    }

    public InputMethodInfo(ResolveInfo ri, boolean isAuxIme, String settingsActivity, List<InputMethodSubtype> subtypes, int isDefaultResId, boolean forceDefault) {
        this(ri, isAuxIme, settingsActivity, subtypes, isDefaultResId, forceDefault, true);
    }

    public InputMethodInfo(ResolveInfo ri, boolean isAuxIme, String settingsActivity, List<InputMethodSubtype> subtypes, int isDefaultResId, boolean forceDefault, boolean supportsSwitchingToNextInputMethod) {
        ServiceInfo si = ri.serviceInfo;
        this.mService = ri;
        this.mId = new ComponentName(si.packageName, si.name).flattenToShortString();
        this.mSettingsActivityName = settingsActivity;
        this.mIsDefaultResId = isDefaultResId;
        this.mIsAuxIme = isAuxIme;
        this.mSubtypes = new InputMethodSubtypeArray((List) subtypes);
        this.mForceDefault = forceDefault;
        this.mSupportsSwitchingToNextInputMethod = supportsSwitchingToNextInputMethod;
    }

    private static ResolveInfo buildDummyResolveInfo(String packageName, String className, CharSequence label) {
        ResolveInfo ri = new ResolveInfo();
        ServiceInfo si = new ServiceInfo();
        ApplicationInfo ai = new ApplicationInfo();
        ai.packageName = packageName;
        ai.enabled = true;
        si.applicationInfo = ai;
        si.enabled = true;
        si.packageName = packageName;
        si.name = className;
        si.exported = true;
        si.nonLocalizedLabel = label;
        ri.serviceInfo = si;
        return ri;
    }

    public String getId() {
        return this.mId;
    }

    public String getPackageName() {
        return this.mService.serviceInfo.packageName;
    }

    public String getServiceName() {
        return this.mService.serviceInfo.name;
    }

    public ServiceInfo getServiceInfo() {
        return this.mService.serviceInfo;
    }

    public ComponentName getComponent() {
        return new ComponentName(this.mService.serviceInfo.packageName, this.mService.serviceInfo.name);
    }

    public CharSequence loadLabel(PackageManager pm) {
        return this.mService.loadLabel(pm);
    }

    public Drawable loadIcon(PackageManager pm) {
        return this.mService.loadIcon(pm);
    }

    public String getSettingsActivity() {
        return this.mSettingsActivityName;
    }

    public int getSubtypeCount() {
        return this.mSubtypes.getCount();
    }

    public InputMethodSubtype getSubtypeAt(int index) {
        return this.mSubtypes.get(index);
    }

    public int getIsDefaultResourceId() {
        return this.mIsDefaultResId;
    }

    public boolean isDefault(Context context) {
        if (this.mForceDefault) {
            return true;
        }
        try {
            if (getIsDefaultResourceId() != 0) {
                return context.createPackageContext(getPackageName(), 0).getResources().getBoolean(getIsDefaultResourceId());
            }
            return false;
        } catch (NameNotFoundException e) {
            return false;
        } catch (NotFoundException e2) {
            return false;
        }
    }

    public void dump(Printer pw, String prefix) {
        pw.println(prefix + "mId=" + this.mId + " mSettingsActivityName=" + this.mSettingsActivityName);
        pw.println(prefix + "mIsDefaultResId=0x" + Integer.toHexString(this.mIsDefaultResId));
        pw.println(prefix + "Service:");
        this.mService.dump(pw, prefix + "  ");
    }

    public String toString() {
        return "InputMethodInfo{" + this.mId + ", settings: " + this.mSettingsActivityName + "}";
    }

    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        if (o == null || !(o instanceof InputMethodInfo)) {
            return false;
        }
        return this.mId.equals(((InputMethodInfo) o).mId);
    }

    public int hashCode() {
        return this.mId.hashCode();
    }

    public boolean isAuxiliaryIme() {
        return this.mIsAuxIme;
    }

    public boolean supportsSwitchingToNextInputMethod() {
        return this.mSupportsSwitchingToNextInputMethod;
    }

    public void writeToParcel(Parcel dest, int flags) {
        int i;
        int i2 = 1;
        dest.writeString(this.mId);
        dest.writeString(this.mSettingsActivityName);
        dest.writeInt(this.mIsDefaultResId);
        if (this.mIsAuxIme) {
            i = 1;
        } else {
            i = 0;
        }
        dest.writeInt(i);
        if (!this.mSupportsSwitchingToNextInputMethod) {
            i2 = 0;
        }
        dest.writeInt(i2);
        this.mService.writeToParcel(dest, flags);
        this.mSubtypes.writeToParcel(dest);
    }

    static {
        CREATOR = new C08961();
    }

    public int describeContents() {
        return 0;
    }
}
