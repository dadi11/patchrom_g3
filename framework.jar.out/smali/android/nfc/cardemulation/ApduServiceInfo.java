package android.nfc.cardemulation;

import android.content.ComponentName;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.res.Resources.NotFoundException;
import android.graphics.drawable.Drawable;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;

public final class ApduServiceInfo implements Parcelable {
    public static final Creator<ApduServiceInfo> CREATOR;
    static final String TAG = "ApduServiceInfo";
    final int mBannerResourceId;
    final String mDescription;
    final HashMap<String, AidGroup> mDynamicAidGroups;
    final boolean mOnHost;
    final boolean mRequiresDeviceUnlock;
    final String mSeName;
    final ResolveInfo mService;
    final HashMap<String, AidGroup> mStaticAidGroups;
    final int mUid;

    /* renamed from: android.nfc.cardemulation.ApduServiceInfo.1 */
    static class C05711 implements Creator<ApduServiceInfo> {
        C05711() {
        }

        public ApduServiceInfo createFromParcel(Parcel source) {
            boolean onHost;
            boolean requiresUnlock;
            ResolveInfo info = (ResolveInfo) ResolveInfo.CREATOR.createFromParcel(source);
            String description = source.readString();
            if (source.readInt() != 0) {
                onHost = true;
            } else {
                onHost = false;
            }
            ArrayList<AidGroup> staticAidGroups = new ArrayList();
            if (source.readInt() > 0) {
                source.readTypedList(staticAidGroups, AidGroup.CREATOR);
            }
            ArrayList<AidGroup> dynamicAidGroups = new ArrayList();
            if (source.readInt() > 0) {
                source.readTypedList(dynamicAidGroups, AidGroup.CREATOR);
            }
            if (source.readInt() != 0) {
                requiresUnlock = true;
            } else {
                requiresUnlock = false;
            }
            return new ApduServiceInfo(info, onHost, description, staticAidGroups, dynamicAidGroups, requiresUnlock, source.readInt(), source.readInt(), source.readString());
        }

        public ApduServiceInfo[] newArray(int size) {
            return new ApduServiceInfo[size];
        }
    }

    public ApduServiceInfo(ResolveInfo info, boolean onHost, String description, ArrayList<AidGroup> staticAidGroups, ArrayList<AidGroup> dynamicAidGroups, boolean requiresUnlock, int bannerResource, int uid) {
        this.mService = info;
        this.mDescription = description;
        this.mStaticAidGroups = new HashMap();
        this.mDynamicAidGroups = new HashMap();
        this.mOnHost = onHost;
        this.mRequiresDeviceUnlock = requiresUnlock;
        Iterator i$ = staticAidGroups.iterator();
        while (i$.hasNext()) {
            AidGroup aidGroup = (AidGroup) i$.next();
            this.mStaticAidGroups.put(aidGroup.category, aidGroup);
        }
        i$ = dynamicAidGroups.iterator();
        while (i$.hasNext()) {
            aidGroup = (AidGroup) i$.next();
            this.mDynamicAidGroups.put(aidGroup.category, aidGroup);
        }
        this.mBannerResourceId = bannerResource;
        this.mUid = uid;
        if (onHost) {
            this.mSeName = new String("DH");
        } else {
            this.mSeName = new String("SIM1");
        }
    }

    public ApduServiceInfo(ResolveInfo info, boolean onHost, String description, ArrayList<AidGroup> staticAidGroups, ArrayList<AidGroup> dynamicAidGroups, boolean requiresUnlock, int bannerResource, int uid, String seName) {
        this.mService = info;
        this.mDescription = description;
        this.mStaticAidGroups = new HashMap();
        this.mDynamicAidGroups = new HashMap();
        this.mOnHost = onHost;
        this.mRequiresDeviceUnlock = requiresUnlock;
        Iterator i$ = staticAidGroups.iterator();
        while (i$.hasNext()) {
            AidGroup aidGroup = (AidGroup) i$.next();
            this.mStaticAidGroups.put(aidGroup.category, aidGroup);
        }
        i$ = dynamicAidGroups.iterator();
        while (i$.hasNext()) {
            aidGroup = (AidGroup) i$.next();
            this.mDynamicAidGroups.put(aidGroup.category, aidGroup);
        }
        this.mBannerResourceId = bannerResource;
        this.mUid = uid;
        this.mSeName = seName;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public ApduServiceInfo(android.content.pm.PackageManager r23, android.content.pm.ResolveInfo r24, boolean r25) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
        /*
        r22 = this;
        r22.<init>();
        r0 = r24;
        r0 = r0.serviceInfo;
        r17 = r0;
        r13 = 0;
        if (r25 == 0) goto L_0x0049;
    L_0x000c:
        r19 = "android.nfc.cardemulation.host_apdu_service";
        r0 = r17;
        r1 = r23;
        r2 = r19;
        r13 = r0.loadXmlMetaData(r1, r2);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r13 != 0) goto L_0x005f;
    L_0x001a:
        r19 = new org.xmlpull.v1.XmlPullParserException;	 Catch:{ NameNotFoundException -> 0x0022 }
        r20 = "No android.nfc.cardemulation.host_apdu_service meta-data";
        r19.<init>(r20);	 Catch:{ NameNotFoundException -> 0x0022 }
        throw r19;	 Catch:{ NameNotFoundException -> 0x0022 }
    L_0x0022:
        r8 = move-exception;
        r19 = new org.xmlpull.v1.XmlPullParserException;	 Catch:{ all -> 0x0042 }
        r20 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0042 }
        r20.<init>();	 Catch:{ all -> 0x0042 }
        r21 = "Unable to create context for: ";
        r20 = r20.append(r21);	 Catch:{ all -> 0x0042 }
        r0 = r17;
        r0 = r0.packageName;	 Catch:{ all -> 0x0042 }
        r21 = r0;
        r20 = r20.append(r21);	 Catch:{ all -> 0x0042 }
        r20 = r20.toString();	 Catch:{ all -> 0x0042 }
        r19.<init>(r20);	 Catch:{ all -> 0x0042 }
        throw r19;	 Catch:{ all -> 0x0042 }
    L_0x0042:
        r19 = move-exception;
        if (r13 == 0) goto L_0x0048;
    L_0x0045:
        r13.close();
    L_0x0048:
        throw r19;
    L_0x0049:
        r19 = "android.nfc.cardemulation.off_host_apdu_service";
        r0 = r17;
        r1 = r23;
        r2 = r19;
        r13 = r0.loadXmlMetaData(r1, r2);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r13 != 0) goto L_0x005f;
    L_0x0057:
        r19 = new org.xmlpull.v1.XmlPullParserException;	 Catch:{ NameNotFoundException -> 0x0022 }
        r20 = "No android.nfc.cardemulation.off_host_apdu_service meta-data";
        r19.<init>(r20);	 Catch:{ NameNotFoundException -> 0x0022 }
        throw r19;	 Catch:{ NameNotFoundException -> 0x0022 }
    L_0x005f:
        r9 = r13.getEventType();	 Catch:{ NameNotFoundException -> 0x0022 }
    L_0x0063:
        r19 = 2;
        r0 = r19;
        if (r9 == r0) goto L_0x0074;
    L_0x0069:
        r19 = 1;
        r0 = r19;
        if (r9 == r0) goto L_0x0074;
    L_0x006f:
        r9 = r13.next();	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x0063;
    L_0x0074:
        r18 = r13.getName();	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r25 == 0) goto L_0x008e;
    L_0x007a:
        r19 = "host-apdu-service";
        r0 = r19;
        r1 = r18;
        r19 = r0.equals(r1);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 != 0) goto L_0x008e;
    L_0x0086:
        r19 = new org.xmlpull.v1.XmlPullParserException;	 Catch:{ NameNotFoundException -> 0x0022 }
        r20 = "Meta-data does not start with <host-apdu-service> tag";
        r19.<init>(r20);	 Catch:{ NameNotFoundException -> 0x0022 }
        throw r19;	 Catch:{ NameNotFoundException -> 0x0022 }
    L_0x008e:
        if (r25 != 0) goto L_0x00a5;
    L_0x0090:
        r19 = "offhost-apdu-service";
        r0 = r19;
        r1 = r18;
        r19 = r0.equals(r1);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 != 0) goto L_0x00a5;
    L_0x009d:
        r19 = new org.xmlpull.v1.XmlPullParserException;	 Catch:{ NameNotFoundException -> 0x0022 }
        r20 = "Meta-data does not start with <offhost-apdu-service> tag";
        r19.<init>(r20);	 Catch:{ NameNotFoundException -> 0x0022 }
        throw r19;	 Catch:{ NameNotFoundException -> 0x0022 }
    L_0x00a5:
        r0 = r17;
        r0 = r0.applicationInfo;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = r0;
        r0 = r23;
        r1 = r19;
        r14 = r0.getResourcesForApplication(r1);	 Catch:{ NameNotFoundException -> 0x0022 }
        r5 = android.util.Xml.asAttributeSet(r13);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r25 == 0) goto L_0x01b6;
    L_0x00b9:
        r19 = com.android.internal.R.styleable.HostApduService;	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r15 = r14.obtainAttributes(r5, r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r24;
        r1 = r22;
        r1.mService = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 0;
        r0 = r19;
        r19 = r15.getString(r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r1 = r22;
        r1.mDescription = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 1;
        r20 = 0;
        r0 = r19;
        r1 = r20;
        r19 = r15.getBoolean(r0, r1);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r1 = r22;
        r1.mRequiresDeviceUnlock = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 2;
        r20 = -1;
        r0 = r19;
        r1 = r20;
        r19 = r15.getResourceId(r0, r1);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r1 = r22;
        r1.mBannerResourceId = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        r15.recycle();	 Catch:{ NameNotFoundException -> 0x0022 }
    L_0x00fc:
        r19 = new java.util.HashMap;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19.<init>();	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r1 = r22;
        r1.mStaticAidGroups = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = new java.util.HashMap;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19.<init>();	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r1 = r22;
        r1.mDynamicAidGroups = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r25;
        r1 = r22;
        r1.mOnHost = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        r7 = r13.getDepth();	 Catch:{ NameNotFoundException -> 0x0022 }
        r6 = 0;
        r16 = 0;
    L_0x011f:
        r9 = r13.next();	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 3;
        r0 = r19;
        if (r9 != r0) goto L_0x0131;
    L_0x0129:
        r19 = r13.getDepth();	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        if (r0 <= r7) goto L_0x0339;
    L_0x0131:
        r19 = 1;
        r0 = r19;
        if (r9 == r0) goto L_0x0339;
    L_0x0137:
        r18 = r13.getName();	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 2;
        r0 = r19;
        if (r9 != r0) goto L_0x01f7;
    L_0x0141:
        r19 = "aid-group";
        r0 = r19;
        r1 = r18;
        r19 = r0.equals(r1);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 == 0) goto L_0x01f7;
    L_0x014d:
        if (r6 != 0) goto L_0x01f7;
    L_0x014f:
        r19 = com.android.internal.R.styleable.AidGroup;	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r10 = r14.obtainAttributes(r5, r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 1;
        r0 = r19;
        r11 = r10.getString(r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 0;
        r0 = r19;
        r12 = r10.getString(r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = "payment";
        r0 = r19;
        r19 = r0.equals(r11);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 != 0) goto L_0x0175;
    L_0x0172:
        r11 = "other";
    L_0x0175:
        r0 = r22;
        r0 = r0.mStaticAidGroups;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = r0;
        r0 = r19;
        r6 = r0.get(r11);	 Catch:{ NameNotFoundException -> 0x0022 }
        r6 = (android.nfc.cardemulation.AidGroup) r6;	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r6 == 0) goto L_0x01f1;
    L_0x0185:
        r19 = "other";
        r0 = r19;
        r19 = r0.equals(r11);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 != 0) goto L_0x01b1;
    L_0x0190:
        r19 = "ApduServiceInfo";
        r20 = new java.lang.StringBuilder;	 Catch:{ NameNotFoundException -> 0x0022 }
        r20.<init>();	 Catch:{ NameNotFoundException -> 0x0022 }
        r21 = "Not allowing multiple aid-groups in the ";
        r20 = r20.append(r21);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r20;
        r20 = r0.append(r11);	 Catch:{ NameNotFoundException -> 0x0022 }
        r21 = " category";
        r20 = r20.append(r21);	 Catch:{ NameNotFoundException -> 0x0022 }
        r20 = r20.toString();	 Catch:{ NameNotFoundException -> 0x0022 }
        android.util.Log.e(r19, r20);	 Catch:{ NameNotFoundException -> 0x0022 }
        r6 = 0;
    L_0x01b1:
        r10.recycle();	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x011f;
    L_0x01b6:
        r19 = com.android.internal.R.styleable.OffHostApduService;	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r15 = r14.obtainAttributes(r5, r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r24;
        r1 = r22;
        r1.mService = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 0;
        r0 = r19;
        r19 = r15.getString(r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r1 = r22;
        r1.mDescription = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 0;
        r0 = r19;
        r1 = r22;
        r1.mRequiresDeviceUnlock = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 1;
        r20 = -1;
        r0 = r19;
        r1 = r20;
        r19 = r15.getResourceId(r0, r1);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r1 = r22;
        r1.mBannerResourceId = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        r15.recycle();	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x00fc;
    L_0x01f1:
        r6 = new android.nfc.cardemulation.AidGroup;	 Catch:{ NameNotFoundException -> 0x0022 }
        r6.<init>(r11, r12);	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x01b1;
    L_0x01f7:
        r19 = 3;
        r0 = r19;
        if (r9 != r0) goto L_0x0241;
    L_0x01fd:
        r19 = "aid-group";
        r0 = r19;
        r1 = r18;
        r19 = r0.equals(r1);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 == 0) goto L_0x0241;
    L_0x0209:
        if (r6 == 0) goto L_0x0241;
    L_0x020b:
        r0 = r6.aids;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = r0;
        r19 = r19.size();	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 <= 0) goto L_0x0239;
    L_0x0215:
        r0 = r22;
        r0 = r0.mStaticAidGroups;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = r0;
        r0 = r6.category;	 Catch:{ NameNotFoundException -> 0x0022 }
        r20 = r0;
        r19 = r19.containsKey(r20);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 != 0) goto L_0x0236;
    L_0x0225:
        r0 = r22;
        r0 = r0.mStaticAidGroups;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = r0;
        r0 = r6.category;	 Catch:{ NameNotFoundException -> 0x0022 }
        r20 = r0;
        r0 = r19;
        r1 = r20;
        r0.put(r1, r6);	 Catch:{ NameNotFoundException -> 0x0022 }
    L_0x0236:
        r6 = 0;
        goto L_0x011f;
    L_0x0239:
        r19 = "ApduServiceInfo";
        r20 = "Not adding <aid-group> with empty or invalid AIDs";
        android.util.Log.e(r19, r20);	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x0236;
    L_0x0241:
        r19 = 2;
        r0 = r19;
        if (r9 != r0) goto L_0x02a4;
    L_0x0247:
        r19 = "aid-filter";
        r0 = r19;
        r1 = r18;
        r19 = r0.equals(r1);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 == 0) goto L_0x02a4;
    L_0x0253:
        if (r6 == 0) goto L_0x02a4;
    L_0x0255:
        r19 = com.android.internal.R.styleable.AidFilter;	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r3 = r14.obtainAttributes(r5, r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 0;
        r0 = r19;
        r19 = r3.getString(r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r4 = r19.toUpperCase();	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = android.nfc.cardemulation.CardEmulation.isValidAid(r4);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 == 0) goto L_0x0289;
    L_0x026f:
        r0 = r6.aids;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = r0;
        r0 = r19;
        r19 = r0.contains(r4);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 != 0) goto L_0x0289;
    L_0x027b:
        r0 = r6.aids;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = r0;
        r0 = r19;
        r0.add(r4);	 Catch:{ NameNotFoundException -> 0x0022 }
    L_0x0284:
        r3.recycle();	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x011f;
    L_0x0289:
        r19 = "ApduServiceInfo";
        r20 = new java.lang.StringBuilder;	 Catch:{ NameNotFoundException -> 0x0022 }
        r20.<init>();	 Catch:{ NameNotFoundException -> 0x0022 }
        r21 = "Ignoring invalid or duplicate aid: ";
        r20 = r20.append(r21);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r20;
        r20 = r0.append(r4);	 Catch:{ NameNotFoundException -> 0x0022 }
        r20 = r20.toString();	 Catch:{ NameNotFoundException -> 0x0022 }
        android.util.Log.e(r19, r20);	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x0284;
    L_0x02a4:
        r19 = 2;
        r0 = r19;
        if (r9 != r0) goto L_0x030f;
    L_0x02aa:
        r19 = "aid-prefix-filter";
        r0 = r19;
        r1 = r18;
        r19 = r0.equals(r1);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 == 0) goto L_0x030f;
    L_0x02b6:
        if (r6 == 0) goto L_0x030f;
    L_0x02b8:
        r19 = com.android.internal.R.styleable.AidFilter;	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r3 = r14.obtainAttributes(r5, r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 0;
        r0 = r19;
        r19 = r3.getString(r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r4 = r19.toUpperCase();	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = "*";
        r0 = r19;
        r4 = r4.concat(r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = android.nfc.cardemulation.CardEmulation.isValidAid(r4);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 == 0) goto L_0x02f4;
    L_0x02da:
        r0 = r6.aids;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = r0;
        r0 = r19;
        r19 = r0.contains(r4);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 != 0) goto L_0x02f4;
    L_0x02e6:
        r0 = r6.aids;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = r0;
        r0 = r19;
        r0.add(r4);	 Catch:{ NameNotFoundException -> 0x0022 }
    L_0x02ef:
        r3.recycle();	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x011f;
    L_0x02f4:
        r19 = "ApduServiceInfo";
        r20 = new java.lang.StringBuilder;	 Catch:{ NameNotFoundException -> 0x0022 }
        r20.<init>();	 Catch:{ NameNotFoundException -> 0x0022 }
        r21 = "Ignoring invalid or duplicate aid: ";
        r20 = r20.append(r21);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r20;
        r20 = r0.append(r4);	 Catch:{ NameNotFoundException -> 0x0022 }
        r20 = r20.toString();	 Catch:{ NameNotFoundException -> 0x0022 }
        android.util.Log.e(r19, r20);	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x02ef;
    L_0x030f:
        r19 = 2;
        r0 = r19;
        if (r9 != r0) goto L_0x011f;
    L_0x0315:
        r19 = "secure-element";
        r0 = r19;
        r1 = r18;
        r19 = r0.equals(r1);	 Catch:{ NameNotFoundException -> 0x0022 }
        if (r19 == 0) goto L_0x011f;
    L_0x0322:
        if (r6 == 0) goto L_0x011f;
    L_0x0324:
        r19 = com.android.internal.R.styleable.AidFilter;	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r3 = r14.obtainAttributes(r5, r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = 0;
        r0 = r19;
        r16 = r3.getString(r0);	 Catch:{ NameNotFoundException -> 0x0022 }
        r3.recycle();	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x011f;
    L_0x0339:
        r0 = r22;
        r0 = r0.mOnHost;	 Catch:{ NameNotFoundException -> 0x0022 }
        r19 = r0;
        r20 = 1;
        r0 = r19;
        r1 = r20;
        if (r0 != r1) goto L_0x036c;
    L_0x0347:
        r19 = new java.lang.String;	 Catch:{ NameNotFoundException -> 0x0022 }
        r20 = "DH";
        r19.<init>(r20);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r1 = r22;
        r1.mSeName = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
    L_0x0354:
        if (r13 == 0) goto L_0x0359;
    L_0x0356:
        r13.close();
    L_0x0359:
        r0 = r17;
        r0 = r0.applicationInfo;
        r19 = r0;
        r0 = r19;
        r0 = r0.uid;
        r19 = r0;
        r0 = r19;
        r1 = r22;
        r1.mUid = r0;
        return;
    L_0x036c:
        if (r16 != 0) goto L_0x037c;
    L_0x036e:
        r19 = new java.lang.String;	 Catch:{ NameNotFoundException -> 0x0022 }
        r20 = "SIM1";
        r19.<init>(r20);	 Catch:{ NameNotFoundException -> 0x0022 }
        r0 = r19;
        r1 = r22;
        r1.mSeName = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x0354;
    L_0x037c:
        r0 = r16;
        r1 = r22;
        r1.mSeName = r0;	 Catch:{ NameNotFoundException -> 0x0022 }
        goto L_0x0354;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.nfc.cardemulation.ApduServiceInfo.<init>(android.content.pm.PackageManager, android.content.pm.ResolveInfo, boolean):void");
    }

    public ComponentName getComponent() {
        return new ComponentName(this.mService.serviceInfo.packageName, this.mService.serviceInfo.name);
    }

    public ArrayList<String> getAids() {
        ArrayList<String> aids = new ArrayList();
        Iterator i$ = getAidGroups().iterator();
        while (i$.hasNext()) {
            aids.addAll(((AidGroup) i$.next()).aids);
        }
        return aids;
    }

    public AidGroup getDynamicAidGroupForCategory(String category) {
        return (AidGroup) this.mDynamicAidGroups.get(category);
    }

    public boolean removeDynamicAidGroupForCategory(String category) {
        return this.mDynamicAidGroups.remove(category) != null;
    }

    public ArrayList<AidGroup> getAidGroups() {
        ArrayList<AidGroup> groups = new ArrayList();
        for (Entry<String, AidGroup> entry : this.mDynamicAidGroups.entrySet()) {
            groups.add(entry.getValue());
        }
        for (Entry<String, AidGroup> entry2 : this.mStaticAidGroups.entrySet()) {
            if (!this.mDynamicAidGroups.containsKey(entry2.getKey())) {
                groups.add(entry2.getValue());
            }
        }
        return groups;
    }

    public String getCategoryForAid(String aid) {
        Iterator i$ = getAidGroups().iterator();
        while (i$.hasNext()) {
            AidGroup group = (AidGroup) i$.next();
            if (group.aids.contains(aid.toUpperCase())) {
                return group.category;
            }
        }
        return null;
    }

    public boolean hasCategory(String category) {
        return this.mStaticAidGroups.containsKey(category) || this.mDynamicAidGroups.containsKey(category);
    }

    public boolean isOnHost() {
        return this.mOnHost;
    }

    public boolean requiresUnlock() {
        return this.mRequiresDeviceUnlock;
    }

    public String getDescription() {
        return this.mDescription;
    }

    public int getUid() {
        return this.mUid;
    }

    public void setOrReplaceDynamicAidGroup(AidGroup aidGroup) {
        this.mDynamicAidGroups.put(aidGroup.getCategory(), aidGroup);
    }

    public CharSequence loadLabel(PackageManager pm) {
        return this.mService.loadLabel(pm);
    }

    public Drawable loadIcon(PackageManager pm) {
        return this.mService.loadIcon(pm);
    }

    public Drawable loadBanner(PackageManager pm) {
        Drawable drawable = null;
        try {
            drawable = pm.getResourcesForApplication(this.mService.serviceInfo.packageName).getDrawable(this.mBannerResourceId);
        } catch (NotFoundException e) {
            Log.e(TAG, "Could not load banner.");
        } catch (NameNotFoundException e2) {
            Log.e(TAG, "Could not load banner.");
        }
        return drawable;
    }

    public String getSeName() {
        return this.mSeName;
    }

    public String toString() {
        StringBuilder out = new StringBuilder("ApduService: ");
        out.append(getComponent());
        out.append(", description: " + this.mDescription);
        out.append(", Static AID Groups: ");
        for (AidGroup aidGroup : this.mStaticAidGroups.values()) {
            out.append(aidGroup.toString());
        }
        out.append(", Dynamic AID Groups: ");
        for (AidGroup aidGroup2 : this.mDynamicAidGroups.values()) {
            out.append(aidGroup2.toString());
        }
        return out.toString();
    }

    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o instanceof ApduServiceInfo) {
            return ((ApduServiceInfo) o).getComponent().equals(getComponent());
        }
        return false;
    }

    public int hashCode() {
        return getComponent().hashCode();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        int i = 1;
        this.mService.writeToParcel(dest, flags);
        dest.writeString(this.mDescription);
        dest.writeInt(this.mOnHost ? 1 : 0);
        dest.writeInt(this.mStaticAidGroups.size());
        if (this.mStaticAidGroups.size() > 0) {
            dest.writeTypedList(new ArrayList(this.mStaticAidGroups.values()));
        }
        dest.writeInt(this.mDynamicAidGroups.size());
        if (this.mDynamicAidGroups.size() > 0) {
            dest.writeTypedList(new ArrayList(this.mDynamicAidGroups.values()));
        }
        if (!this.mRequiresDeviceUnlock) {
            i = 0;
        }
        dest.writeInt(i);
        dest.writeInt(this.mBannerResourceId);
        dest.writeInt(this.mUid);
        dest.writeString(this.mSeName);
    }

    static {
        CREATOR = new C05711();
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("    " + getComponent() + " (Description: " + getDescription() + ")");
        pw.println("    Static AID groups:");
        for (AidGroup group : this.mStaticAidGroups.values()) {
            pw.println("        Category: " + group.category);
            for (String aid : group.aids) {
                pw.println("            AID: " + aid);
            }
        }
        pw.println("    Dynamic AID groups:");
        for (AidGroup group2 : this.mDynamicAidGroups.values()) {
            pw.println("        Category: " + group2.category);
            for (String aid2 : group2.aids) {
                pw.println("            AID: " + aid2);
            }
        }
    }
}
