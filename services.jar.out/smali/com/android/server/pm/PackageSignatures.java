package com.android.server.pm;

import android.content.pm.Signature;
import java.io.IOException;
import java.util.ArrayList;
import org.xmlpull.v1.XmlSerializer;

class PackageSignatures {
    Signature[] mSignatures;

    PackageSignatures(PackageSignatures orig) {
        if (orig != null && orig.mSignatures != null) {
            this.mSignatures = (Signature[]) orig.mSignatures.clone();
        }
    }

    PackageSignatures(Signature[] sigs) {
        assignSignatures(sigs);
    }

    PackageSignatures() {
    }

    void writeXml(XmlSerializer serializer, String tagName, ArrayList<Signature> pastSignatures) throws IOException {
        if (this.mSignatures != null) {
            serializer.startTag(null, tagName);
            serializer.attribute(null, "count", Integer.toString(this.mSignatures.length));
            for (Signature sig : this.mSignatures) {
                serializer.startTag(null, "cert");
                int sigHash = sig.hashCode();
                int numPast = pastSignatures.size();
                int j = 0;
                while (j < numPast) {
                    Signature pastSig = (Signature) pastSignatures.get(j);
                    if (pastSig.hashCode() == sigHash && pastSig.equals(sig)) {
                        serializer.attribute(null, "index", Integer.toString(j));
                        break;
                    }
                    j++;
                }
                if (j >= numPast) {
                    pastSignatures.add(sig);
                    serializer.attribute(null, "index", Integer.toString(numPast));
                    serializer.attribute(null, "key", sig.toCharsString());
                }
                serializer.endTag(null, "cert");
            }
            serializer.endTag(null, tagName);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void readXml(org.xmlpull.v1.XmlPullParser r17, java.util.ArrayList<android.content.pm.Signature> r18) throws java.io.IOException, org.xmlpull.v1.XmlPullParserException {
        /*
        r16 = this;
        r13 = 0;
        r14 = "count";
        r0 = r17;
        r2 = r0.getAttributeValue(r13, r14);
        if (r2 != 0) goto L_0x0029;
    L_0x000b:
        r13 = 5;
        r14 = new java.lang.StringBuilder;
        r14.<init>();
        r15 = "Error in package manager settings: <signatures> has no count at ";
        r14 = r14.append(r15);
        r15 = r17.getPositionDescription();
        r14 = r14.append(r15);
        r14 = r14.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r13, r14);
        com.android.internal.util.XmlUtils.skipCurrentTag(r17);
    L_0x0029:
        r1 = java.lang.Integer.parseInt(r2);
        r13 = new android.content.pm.Signature[r1];
        r0 = r16;
        r0.mSignatures = r13;
        r9 = 0;
        r8 = r17.getDepth();
    L_0x0038:
        r12 = r17.next();
        r13 = 1;
        if (r12 == r13) goto L_0x01c7;
    L_0x003f:
        r13 = 3;
        if (r12 != r13) goto L_0x0048;
    L_0x0042:
        r13 = r17.getDepth();
        if (r13 <= r8) goto L_0x01c7;
    L_0x0048:
        r13 = 3;
        if (r12 == r13) goto L_0x0038;
    L_0x004b:
        r13 = 4;
        if (r12 == r13) goto L_0x0038;
    L_0x004e:
        r11 = r17.getName();
        r13 = "cert";
        r13 = r11.equals(r13);
        if (r13 == 0) goto L_0x01aa;
    L_0x005a:
        if (r9 >= r1) goto L_0x0183;
    L_0x005c:
        r13 = 0;
        r14 = "index";
        r0 = r17;
        r5 = r0.getAttributeValue(r13, r14);
        if (r5 == 0) goto L_0x0166;
    L_0x0067:
        r4 = java.lang.Integer.parseInt(r5);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r13 = 0;
        r14 = "key";
        r0 = r17;
        r6 = r0.getAttributeValue(r13, r14);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        if (r6 != 0) goto L_0x0145;
    L_0x0076:
        if (r4 < 0) goto L_0x00e9;
    L_0x0078:
        r13 = r18.size();	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        if (r4 >= r13) goto L_0x00e9;
    L_0x007e:
        r0 = r18;
        r10 = r0.get(r4);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r10 = (android.content.pm.Signature) r10;	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        if (r10 == 0) goto L_0x009c;
    L_0x0088:
        r0 = r16;
        r14 = r0.mSignatures;	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r0 = r18;
        r13 = r0.get(r4);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r13 = (android.content.pm.Signature) r13;	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r14[r9] = r13;	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r9 = r9 + 1;
    L_0x0098:
        com.android.internal.util.XmlUtils.skipCurrentTag(r17);
        goto L_0x0038;
    L_0x009c:
        r13 = 5;
        r14 = new java.lang.StringBuilder;	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r14.<init>();	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r15 = "Error in package manager settings: <cert> index ";
        r14 = r14.append(r15);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r14 = r14.append(r5);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r15 = " is not defined at ";
        r14 = r14.append(r15);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r15 = r17.getPositionDescription();	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r14 = r14.append(r15);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r14 = r14.toString();	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r13, r14);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        goto L_0x0098;
    L_0x00c2:
        r3 = move-exception;
        r13 = 5;
        r14 = new java.lang.StringBuilder;
        r14.<init>();
        r15 = "Error in package manager settings: <cert> index ";
        r14 = r14.append(r15);
        r14 = r14.append(r5);
        r15 = " is not a number at ";
        r14 = r14.append(r15);
        r15 = r17.getPositionDescription();
        r14 = r14.append(r15);
        r14 = r14.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r13, r14);
        goto L_0x0098;
    L_0x00e9:
        r13 = 5;
        r14 = new java.lang.StringBuilder;	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r14.<init>();	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r15 = "Error in package manager settings: <cert> index ";
        r14 = r14.append(r15);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r14 = r14.append(r5);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r15 = " is out of bounds at ";
        r14 = r14.append(r15);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r15 = r17.getPositionDescription();	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r14 = r14.append(r15);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r14 = r14.toString();	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r13, r14);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        goto L_0x0098;
    L_0x010f:
        r3 = move-exception;
        r13 = 5;
        r14 = new java.lang.StringBuilder;
        r14.<init>();
        r15 = "Error in package manager settings: <cert> index ";
        r14 = r14.append(r15);
        r14 = r14.append(r5);
        r15 = " has an invalid signature at ";
        r14 = r14.append(r15);
        r15 = r17.getPositionDescription();
        r14 = r14.append(r15);
        r15 = ": ";
        r14 = r14.append(r15);
        r15 = r3.getMessage();
        r14 = r14.append(r15);
        r14 = r14.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r13, r14);
        goto L_0x0098;
    L_0x0145:
        r13 = r18.size();	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        if (r13 > r4) goto L_0x0152;
    L_0x014b:
        r13 = 0;
        r0 = r18;
        r0.add(r13);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        goto L_0x0145;
    L_0x0152:
        r10 = new android.content.pm.Signature;	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r10.<init>(r6);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r0 = r18;
        r0.set(r4, r10);	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r0 = r16;
        r13 = r0.mSignatures;	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r13[r9] = r10;	 Catch:{ NumberFormatException -> 0x00c2, IllegalArgumentException -> 0x010f }
        r9 = r9 + 1;
        goto L_0x0098;
    L_0x0166:
        r13 = 5;
        r14 = new java.lang.StringBuilder;
        r14.<init>();
        r15 = "Error in package manager settings: <cert> has no index at ";
        r14 = r14.append(r15);
        r15 = r17.getPositionDescription();
        r14 = r14.append(r15);
        r14 = r14.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r13, r14);
        goto L_0x0098;
    L_0x0183:
        r13 = 5;
        r14 = new java.lang.StringBuilder;
        r14.<init>();
        r15 = "Error in package manager settings: too many <cert> tags, expected ";
        r14 = r14.append(r15);
        r14 = r14.append(r1);
        r15 = " at ";
        r14 = r14.append(r15);
        r15 = r17.getPositionDescription();
        r14 = r14.append(r15);
        r14 = r14.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r13, r14);
        goto L_0x0098;
    L_0x01aa:
        r13 = 5;
        r14 = new java.lang.StringBuilder;
        r14.<init>();
        r15 = "Unknown element under <cert>: ";
        r14 = r14.append(r15);
        r15 = r17.getName();
        r14 = r14.append(r15);
        r14 = r14.toString();
        com.android.server.pm.PackageManagerService.reportSettingsProblem(r13, r14);
        goto L_0x0098;
    L_0x01c7:
        if (r9 >= r1) goto L_0x01d8;
    L_0x01c9:
        r7 = new android.content.pm.Signature[r9];
        r0 = r16;
        r13 = r0.mSignatures;
        r14 = 0;
        r15 = 0;
        java.lang.System.arraycopy(r13, r14, r7, r15, r9);
        r0 = r16;
        r0.mSignatures = r7;
    L_0x01d8:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageSignatures.readXml(org.xmlpull.v1.XmlPullParser, java.util.ArrayList):void");
    }

    void assignSignatures(Signature[] sigs) {
        if (sigs == null) {
            this.mSignatures = null;
            return;
        }
        this.mSignatures = new Signature[sigs.length];
        for (int i = 0; i < sigs.length; i++) {
            this.mSignatures[i] = sigs[i];
        }
    }

    public String toString() {
        StringBuffer buf = new StringBuffer(DumpState.DUMP_PROVIDERS);
        buf.append("PackageSignatures{");
        buf.append(Integer.toHexString(System.identityHashCode(this)));
        buf.append(" [");
        if (this.mSignatures != null) {
            for (int i = 0; i < this.mSignatures.length; i++) {
                if (i > 0) {
                    buf.append(", ");
                }
                buf.append(Integer.toHexString(System.identityHashCode(this.mSignatures[i])));
            }
        }
        buf.append("]}");
        return buf.toString();
    }
}
