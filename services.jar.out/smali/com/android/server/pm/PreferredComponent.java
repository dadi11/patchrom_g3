package com.android.server.pm;

import android.content.ComponentName;
import android.content.pm.ActivityInfo;
import android.content.pm.ResolveInfo;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class PreferredComponent {
    private static final String ATTR_ALWAYS = "always";
    private static final String ATTR_MATCH = "match";
    private static final String ATTR_NAME = "name";
    private static final String ATTR_SET = "set";
    private static final String TAG_SET = "set";
    public boolean mAlways;
    private final Callbacks mCallbacks;
    public final ComponentName mComponent;
    public final int mMatch;
    private String mParseError;
    final String[] mSetClasses;
    final String[] mSetComponents;
    final String[] mSetPackages;
    final String mShortComponent;

    public interface Callbacks {
        boolean onReadTag(String str, XmlPullParser xmlPullParser) throws XmlPullParserException, IOException;
    }

    public PreferredComponent(Callbacks callbacks, int match, ComponentName[] set, ComponentName component, boolean always) {
        this.mCallbacks = callbacks;
        this.mMatch = 268369920 & match;
        this.mComponent = component;
        this.mAlways = always;
        this.mShortComponent = component.flattenToShortString();
        this.mParseError = null;
        if (set != null) {
            int N = set.length;
            String[] myPackages = new String[N];
            String[] myClasses = new String[N];
            String[] myComponents = new String[N];
            for (int i = 0; i < N; i++) {
                ComponentName cn = set[i];
                if (cn == null) {
                    this.mSetPackages = null;
                    this.mSetClasses = null;
                    this.mSetComponents = null;
                    return;
                }
                myPackages[i] = cn.getPackageName().intern();
                myClasses[i] = cn.getClassName().intern();
                myComponents[i] = cn.flattenToShortString();
            }
            this.mSetPackages = myPackages;
            this.mSetClasses = myClasses;
            this.mSetComponents = myComponents;
            return;
        }
        this.mSetPackages = null;
        this.mSetClasses = null;
        this.mSetComponents = null;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public PreferredComponent(com.android.server.pm.PreferredComponent.Callbacks r19, org.xmlpull.v1.XmlPullParser r20) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
        /*
        r18 = this;
        r18.<init>();
        r0 = r19;
        r1 = r18;
        r1.mCallbacks = r0;
        r15 = 0;
        r16 = "name";
        r0 = r20;
        r1 = r16;
        r15 = r0.getAttributeValue(r15, r1);
        r0 = r18;
        r0.mShortComponent = r15;
        r0 = r18;
        r15 = r0.mShortComponent;
        r15 = android.content.ComponentName.unflattenFromString(r15);
        r0 = r18;
        r0.mComponent = r15;
        r0 = r18;
        r15 = r0.mComponent;
        if (r15 != 0) goto L_0x0047;
    L_0x002a:
        r15 = new java.lang.StringBuilder;
        r15.<init>();
        r16 = "Bad activity name ";
        r15 = r15.append(r16);
        r0 = r18;
        r0 = r0.mShortComponent;
        r16 = r0;
        r15 = r15.append(r16);
        r15 = r15.toString();
        r0 = r18;
        r0.mParseError = r15;
    L_0x0047:
        r15 = 0;
        r16 = "match";
        r0 = r20;
        r1 = r16;
        r4 = r0.getAttributeValue(r15, r1);
        if (r4 == 0) goto L_0x00eb;
    L_0x0054:
        r15 = 16;
        r15 = java.lang.Integer.parseInt(r4, r15);
    L_0x005a:
        r0 = r18;
        r0.mMatch = r15;
        r15 = 0;
        r16 = "set";
        r0 = r20;
        r1 = r16;
        r11 = r0.getAttributeValue(r15, r1);
        if (r11 == 0) goto L_0x00ee;
    L_0x006b:
        r10 = java.lang.Integer.parseInt(r11);
    L_0x006f:
        r15 = 0;
        r16 = "always";
        r0 = r20;
        r1 = r16;
        r2 = r0.getAttributeValue(r15, r1);
        if (r2 == 0) goto L_0x00f0;
    L_0x007c:
        r15 = java.lang.Boolean.parseBoolean(r2);
    L_0x0080:
        r0 = r18;
        r0.mAlways = r15;
        if (r10 <= 0) goto L_0x00f2;
    L_0x0086:
        r7 = new java.lang.String[r10];
    L_0x0088:
        if (r10 <= 0) goto L_0x00f4;
    L_0x008a:
        r5 = new java.lang.String[r10];
    L_0x008c:
        if (r10 <= 0) goto L_0x00f6;
    L_0x008e:
        r6 = new java.lang.String[r10];
    L_0x0090:
        r12 = 0;
        r9 = r20.getDepth();
    L_0x0095:
        r14 = r20.next();
        r15 = 1;
        if (r14 == r15) goto L_0x0190;
    L_0x009c:
        r15 = 3;
        if (r14 != r15) goto L_0x00a5;
    L_0x009f:
        r15 = r20.getDepth();
        if (r15 <= r9) goto L_0x0190;
    L_0x00a5:
        r15 = 3;
        if (r14 == r15) goto L_0x0095;
    L_0x00a8:
        r15 = 4;
        if (r14 == r15) goto L_0x0095;
    L_0x00ab:
        r13 = r20.getName();
        r15 = "set";
        r15 = r13.equals(r15);
        if (r15 == 0) goto L_0x0163;
    L_0x00b7:
        r15 = 0;
        r16 = "name";
        r0 = r20;
        r1 = r16;
        r8 = r0.getAttributeValue(r15, r1);
        if (r8 != 0) goto L_0x00f8;
    L_0x00c4:
        r0 = r18;
        r15 = r0.mParseError;
        if (r15 != 0) goto L_0x00e7;
    L_0x00ca:
        r15 = new java.lang.StringBuilder;
        r15.<init>();
        r16 = "No name in set tag in preferred activity ";
        r15 = r15.append(r16);
        r0 = r18;
        r0 = r0.mShortComponent;
        r16 = r0;
        r15 = r15.append(r16);
        r15 = r15.toString();
        r0 = r18;
        r0.mParseError = r15;
    L_0x00e7:
        com.android.internal.util.XmlUtils.skipCurrentTag(r20);
        goto L_0x0095;
    L_0x00eb:
        r15 = 0;
        goto L_0x005a;
    L_0x00ee:
        r10 = 0;
        goto L_0x006f;
    L_0x00f0:
        r15 = 1;
        goto L_0x0080;
    L_0x00f2:
        r7 = 0;
        goto L_0x0088;
    L_0x00f4:
        r5 = 0;
        goto L_0x008c;
    L_0x00f6:
        r6 = 0;
        goto L_0x0090;
    L_0x00f8:
        if (r12 < r10) goto L_0x011e;
    L_0x00fa:
        r0 = r18;
        r15 = r0.mParseError;
        if (r15 != 0) goto L_0x00e7;
    L_0x0100:
        r15 = new java.lang.StringBuilder;
        r15.<init>();
        r16 = "Too many set tags in preferred activity ";
        r15 = r15.append(r16);
        r0 = r18;
        r0 = r0.mShortComponent;
        r16 = r0;
        r15 = r15.append(r16);
        r15 = r15.toString();
        r0 = r18;
        r0.mParseError = r15;
        goto L_0x00e7;
    L_0x011e:
        r3 = android.content.ComponentName.unflattenFromString(r8);
        if (r3 != 0) goto L_0x0152;
    L_0x0124:
        r0 = r18;
        r15 = r0.mParseError;
        if (r15 != 0) goto L_0x00e7;
    L_0x012a:
        r15 = new java.lang.StringBuilder;
        r15.<init>();
        r16 = "Bad set name ";
        r15 = r15.append(r16);
        r15 = r15.append(r8);
        r16 = " in preferred activity ";
        r15 = r15.append(r16);
        r0 = r18;
        r0 = r0.mShortComponent;
        r16 = r0;
        r15 = r15.append(r16);
        r15 = r15.toString();
        r0 = r18;
        r0.mParseError = r15;
        goto L_0x00e7;
    L_0x0152:
        r15 = r3.getPackageName();
        r7[r12] = r15;
        r15 = r3.getClassName();
        r5[r12] = r15;
        r6[r12] = r8;
        r12 = r12 + 1;
        goto L_0x00e7;
    L_0x0163:
        r0 = r18;
        r15 = r0.mCallbacks;
        r0 = r20;
        r15 = r15.onReadTag(r13, r0);
        if (r15 != 0) goto L_0x0095;
    L_0x016f:
        r15 = "PreferredComponent";
        r16 = new java.lang.StringBuilder;
        r16.<init>();
        r17 = "Unknown element: ";
        r16 = r16.append(r17);
        r17 = r20.getName();
        r16 = r16.append(r17);
        r16 = r16.toString();
        android.util.Slog.w(r15, r16);
        com.android.internal.util.XmlUtils.skipCurrentTag(r20);
        goto L_0x0095;
    L_0x0190:
        if (r12 == r10) goto L_0x01c9;
    L_0x0192:
        r0 = r18;
        r15 = r0.mParseError;
        if (r15 != 0) goto L_0x01c9;
    L_0x0198:
        r15 = new java.lang.StringBuilder;
        r15.<init>();
        r16 = "Not enough set tags (expected ";
        r15 = r15.append(r16);
        r15 = r15.append(r10);
        r16 = " but found ";
        r15 = r15.append(r16);
        r15 = r15.append(r12);
        r16 = ") in ";
        r15 = r15.append(r16);
        r0 = r18;
        r0 = r0.mShortComponent;
        r16 = r0;
        r15 = r15.append(r16);
        r15 = r15.toString();
        r0 = r18;
        r0.mParseError = r15;
    L_0x01c9:
        r0 = r18;
        r0.mSetPackages = r7;
        r0 = r18;
        r0.mSetClasses = r5;
        r0 = r18;
        r0.mSetComponents = r6;
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PreferredComponent.<init>(com.android.server.pm.PreferredComponent$Callbacks, org.xmlpull.v1.XmlPullParser):void");
    }

    public String getParseError() {
        return this.mParseError;
    }

    public void writeToXml(XmlSerializer serializer, boolean full) throws IOException {
        int NS = this.mSetClasses != null ? this.mSetClasses.length : 0;
        serializer.attribute(null, ATTR_NAME, this.mShortComponent);
        if (full) {
            if (this.mMatch != 0) {
                serializer.attribute(null, ATTR_MATCH, Integer.toHexString(this.mMatch));
            }
            serializer.attribute(null, ATTR_ALWAYS, Boolean.toString(this.mAlways));
            serializer.attribute(null, TAG_SET, Integer.toString(NS));
            for (int s = 0; s < NS; s++) {
                serializer.startTag(null, TAG_SET);
                serializer.attribute(null, ATTR_NAME, this.mSetComponents[s]);
                serializer.endTag(null, TAG_SET);
            }
        }
    }

    public boolean sameSet(List<ResolveInfo> query) {
        if (this.mSetPackages == null) {
            if (query == null) {
                return true;
            }
            return false;
        } else if (query == null) {
            return false;
        } else {
            int NQ = query.size();
            int NS = this.mSetPackages.length;
            int numMatch = 0;
            for (int i = 0; i < NQ; i++) {
                ActivityInfo ai = ((ResolveInfo) query.get(i)).activityInfo;
                boolean good = false;
                int j = 0;
                while (j < NS) {
                    if (this.mSetPackages[j].equals(ai.packageName) && this.mSetClasses[j].equals(ai.name)) {
                        numMatch++;
                        good = true;
                        break;
                    }
                    j++;
                }
                if (!good) {
                    return false;
                }
            }
            if (numMatch != NS) {
                return false;
            }
            return true;
        }
    }

    public boolean sameSet(ComponentName[] comps) {
        if (this.mSetPackages == null) {
            return false;
        }
        int NS = this.mSetPackages.length;
        int numMatch = 0;
        for (ComponentName cn : comps) {
            boolean good = false;
            int j = 0;
            while (j < NS) {
                if (this.mSetPackages[j].equals(cn.getPackageName()) && this.mSetClasses[j].equals(cn.getClassName())) {
                    numMatch++;
                    good = true;
                    break;
                }
                j++;
            }
            if (!good) {
                return false;
            }
        }
        if (numMatch == NS) {
            return true;
        }
        return false;
    }

    public void dump(PrintWriter out, String prefix, Object ident) {
        out.print(prefix);
        out.print(Integer.toHexString(System.identityHashCode(ident)));
        out.print(' ');
        out.println(this.mShortComponent);
        out.print(prefix);
        out.print(" mMatch=0x");
        out.print(Integer.toHexString(this.mMatch));
        out.print(" mAlways=");
        out.println(this.mAlways);
        if (this.mSetComponents != null) {
            out.print(prefix);
            out.println("  Selected from:");
            for (String println : this.mSetComponents) {
                out.print(prefix);
                out.print("    ");
                out.println(println);
            }
        }
    }
}
