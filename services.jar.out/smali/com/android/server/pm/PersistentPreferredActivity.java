package com.android.server.pm;

import android.content.ComponentName;
import android.content.IntentFilter;
import java.io.IOException;
import org.xmlpull.v1.XmlSerializer;

class PersistentPreferredActivity extends IntentFilter {
    private static final String ATTR_FILTER = "filter";
    private static final String ATTR_NAME = "name";
    private static final boolean DEBUG_FILTERS = false;
    private static final String TAG = "PersistentPreferredActivity";
    final ComponentName mComponent;

    PersistentPreferredActivity(IntentFilter filter, ComponentName activity) {
        super(filter);
        this.mComponent = activity;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    PersistentPreferredActivity(org.xmlpull.v1.XmlPullParser r9) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
        /*
        r8 = this;
        r7 = 3;
        r6 = 5;
        r8.<init>();
        r4 = 0;
        r5 = "name";
        r1 = r9.getAttributeValue(r4, r5);
        r4 = android.content.ComponentName.unflattenFromString(r1);
        r8.mComponent = r4;
        r4 = r8.mComponent;
        if (r4 != 0) goto L_0x003a;
    L_0x0016:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Error in package manager settings: Bad activity name ";
        r4 = r4.append(r5);
        r4 = r4.append(r1);
        r5 = " at ";
        r4 = r4.append(r5);
        r5 = r9.getPositionDescription();
        r4 = r4.append(r5);
        r4 = r4.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r6, r4);
    L_0x003a:
        r0 = r9.getDepth();
        r2 = r9.getName();
    L_0x0042:
        r3 = r9.next();
        r4 = 1;
        if (r3 == r4) goto L_0x0065;
    L_0x0049:
        if (r3 != r7) goto L_0x0051;
    L_0x004b:
        r4 = r9.getDepth();
        if (r4 <= r0) goto L_0x0065;
    L_0x0051:
        r2 = r9.getName();
        if (r3 == r7) goto L_0x0042;
    L_0x0057:
        r4 = 4;
        if (r3 == r4) goto L_0x0042;
    L_0x005a:
        r4 = 2;
        if (r3 != r4) goto L_0x0042;
    L_0x005d:
        r4 = "filter";
        r4 = r2.equals(r4);
        if (r4 == 0) goto L_0x0071;
    L_0x0065:
        r4 = "filter";
        r4 = r2.equals(r4);
        if (r4 == 0) goto L_0x0099;
    L_0x006d:
        r8.readFromXml(r9);
    L_0x0070:
        return;
    L_0x0071:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Unknown element: ";
        r4 = r4.append(r5);
        r4 = r4.append(r2);
        r5 = " at ";
        r4 = r4.append(r5);
        r5 = r9.getPositionDescription();
        r4 = r4.append(r5);
        r4 = r4.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r6, r4);
        com.android.internal.util.XmlUtils.skipCurrentTag(r9);
        goto L_0x0042;
    L_0x0099:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Missing element filter at ";
        r4 = r4.append(r5);
        r5 = r9.getPositionDescription();
        r4 = r4.append(r5);
        r4 = r4.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r6, r4);
        com.android.internal.util.XmlUtils.skipCurrentTag(r9);
        goto L_0x0070;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PersistentPreferredActivity.<init>(org.xmlpull.v1.XmlPullParser):void");
    }

    public void writeToXml(XmlSerializer serializer) throws IOException {
        serializer.attribute(null, ATTR_NAME, this.mComponent.flattenToShortString());
        serializer.startTag(null, ATTR_FILTER);
        super.writeToXml(serializer);
        serializer.endTag(null, ATTR_FILTER);
    }

    public String toString() {
        return "PersistentPreferredActivity{0x" + Integer.toHexString(System.identityHashCode(this)) + " " + this.mComponent.flattenToShortString() + "}";
    }
}
