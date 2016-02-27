package com.android.server.pm;

import android.content.IntentFilter;
import java.io.IOException;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlSerializer;

class CrossProfileIntentFilter extends IntentFilter {
    private static final String ATTR_FILTER = "filter";
    private static final String ATTR_FLAGS = "flags";
    private static final String ATTR_OWNER_PACKAGE = "ownerPackage";
    private static final String ATTR_OWNER_USER_ID = "ownerUserId";
    private static final String ATTR_TARGET_USER_ID = "targetUserId";
    private static final String TAG = "CrossProfileIntentFilter";
    final int mFlags;
    final String mOwnerPackage;
    final int mOwnerUserId;
    final int mTargetUserId;

    CrossProfileIntentFilter(IntentFilter filter, String ownerPackage, int ownerUserId, int targetUserId, int flags) {
        super(filter);
        this.mTargetUserId = targetUserId;
        this.mOwnerUserId = ownerUserId;
        this.mOwnerPackage = ownerPackage;
        this.mFlags = flags;
    }

    public int getTargetUserId() {
        return this.mTargetUserId;
    }

    public int getFlags() {
        return this.mFlags;
    }

    public int getOwnerUserId() {
        return this.mOwnerUserId;
    }

    public String getOwnerPackage() {
        return this.mOwnerPackage;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    CrossProfileIntentFilter(org.xmlpull.v1.XmlPullParser r9) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
        /*
        r8 = this;
        r7 = 5;
        r6 = 3;
        r5 = -10000; // 0xffffffffffffd8f0 float:NaN double:NaN;
        r8.<init>();
        r4 = "targetUserId";
        r4 = r8.getIntFromXml(r9, r4, r5);
        r8.mTargetUserId = r4;
        r4 = "ownerUserId";
        r4 = r8.getIntFromXml(r9, r4, r5);
        r8.mOwnerUserId = r4;
        r4 = "ownerPackage";
        r5 = "";
        r4 = r8.getStringFromXml(r9, r4, r5);
        r8.mOwnerPackage = r4;
        r4 = "flags";
        r5 = 0;
        r4 = r8.getIntFromXml(r9, r4, r5);
        r8.mFlags = r4;
        r1 = r9.getDepth();
        r2 = r9.getName();
    L_0x0032:
        r3 = r9.next();
        r4 = 1;
        if (r3 == r4) goto L_0x0055;
    L_0x0039:
        if (r3 != r6) goto L_0x0041;
    L_0x003b:
        r4 = r9.getDepth();
        if (r4 <= r1) goto L_0x0055;
    L_0x0041:
        r2 = r9.getName();
        if (r3 == r6) goto L_0x0032;
    L_0x0047:
        r4 = 4;
        if (r3 == r4) goto L_0x0032;
    L_0x004a:
        r4 = 2;
        if (r3 != r4) goto L_0x0032;
    L_0x004d:
        r4 = "filter";
        r4 = r2.equals(r4);
        if (r4 == 0) goto L_0x0061;
    L_0x0055:
        r4 = "filter";
        r4 = r2.equals(r4);
        if (r4 == 0) goto L_0x0089;
    L_0x005d:
        r8.readFromXml(r9);
    L_0x0060:
        return;
    L_0x0061:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Unknown element under crossProfile-intent-filters: ";
        r4 = r4.append(r5);
        r4 = r4.append(r2);
        r5 = " at ";
        r4 = r4.append(r5);
        r5 = r9.getPositionDescription();
        r4 = r4.append(r5);
        r0 = r4.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r7, r0);
        com.android.internal.util.XmlUtils.skipCurrentTag(r9);
        goto L_0x0032;
    L_0x0089:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Missing element under CrossProfileIntentFilter: filter at ";
        r4 = r4.append(r5);
        r5 = r9.getPositionDescription();
        r4 = r4.append(r5);
        r0 = r4.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r7, r0);
        com.android.internal.util.XmlUtils.skipCurrentTag(r9);
        goto L_0x0060;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.CrossProfileIntentFilter.<init>(org.xmlpull.v1.XmlPullParser):void");
    }

    String getStringFromXml(XmlPullParser parser, String attribute, String defaultValue) {
        String value = parser.getAttributeValue(null, attribute);
        if (value != null) {
            return value;
        }
        PackageManagerService.reportSettingsProblem(5, "Missing element under CrossProfileIntentFilter: " + attribute + " at " + parser.getPositionDescription());
        return defaultValue;
    }

    int getIntFromXml(XmlPullParser parser, String attribute, int defaultValue) {
        String stringValue = getStringFromXml(parser, attribute, null);
        if (stringValue != null) {
            return Integer.parseInt(stringValue);
        }
        return defaultValue;
    }

    public void writeToXml(XmlSerializer serializer) throws IOException {
        serializer.attribute(null, ATTR_TARGET_USER_ID, Integer.toString(this.mTargetUserId));
        serializer.attribute(null, ATTR_FLAGS, Integer.toString(this.mFlags));
        serializer.attribute(null, ATTR_OWNER_USER_ID, Integer.toString(this.mOwnerUserId));
        serializer.attribute(null, ATTR_OWNER_PACKAGE, this.mOwnerPackage);
        serializer.startTag(null, ATTR_FILTER);
        super.writeToXml(serializer);
        serializer.endTag(null, ATTR_FILTER);
    }

    public String toString() {
        return "CrossProfileIntentFilter{0x" + Integer.toHexString(System.identityHashCode(this)) + " " + Integer.toString(this.mTargetUserId) + "}";
    }

    boolean equalsIgnoreFilter(CrossProfileIntentFilter other) {
        return this.mTargetUserId == other.mTargetUserId && this.mOwnerUserId == other.mOwnerUserId && this.mOwnerPackage.equals(other.mOwnerPackage) && this.mFlags == other.mFlags;
    }
}
