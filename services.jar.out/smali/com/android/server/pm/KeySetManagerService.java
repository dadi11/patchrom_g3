package com.android.server.pm;

import android.content.pm.PackageParser;
import android.util.ArraySet;
import android.util.Base64;
import android.util.LongSparseArray;
import android.util.Slog;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.PublicKey;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class KeySetManagerService {
    public static final int CURRENT_VERSION = 1;
    public static final int FIRST_VERSION = 1;
    public static final long KEYSET_NOT_FOUND = -1;
    protected static final long PUBLIC_KEY_NOT_FOUND = -1;
    static final String TAG = "KeySetManagerService";
    private static long lastIssuedKeyId;
    private static long lastIssuedKeySetId;
    protected final LongSparseArray<ArraySet<Long>> mKeySetMapping;
    private final LongSparseArray<KeySetHandle> mKeySets;
    private final Map<String, PackageSetting> mPackages;
    private final LongSparseArray<PublicKey> mPublicKeys;

    static {
        lastIssuedKeySetId = 0;
        lastIssuedKeyId = 0;
    }

    public KeySetManagerService(Map<String, PackageSetting> packages) {
        this.mKeySets = new LongSparseArray();
        this.mPublicKeys = new LongSparseArray();
        this.mKeySetMapping = new LongSparseArray();
        this.mPackages = packages;
    }

    public boolean packageIsSignedByLPr(String packageName, KeySetHandle ks) {
        PackageSetting pkg = (PackageSetting) this.mPackages.get(packageName);
        if (pkg == null) {
            throw new NullPointerException("Invalid package name");
        } else if (pkg.keySetData == null) {
            throw new NullPointerException("Package has no KeySet data");
        } else {
            long id = getIdByKeySetLPr(ks);
            if (id == PUBLIC_KEY_NOT_FOUND) {
                return false;
            }
            return pkg.keySetData.packageIsSignedBy(id);
        }
    }

    public boolean packageIsSignedByExactlyLPr(String packageName, KeySetHandle ks) {
        PackageSetting pkg = (PackageSetting) this.mPackages.get(packageName);
        if (pkg == null) {
            throw new NullPointerException("Invalid package name");
        } else if (pkg.keySetData == null || pkg.keySetData.getProperSigningKeySet() == PUBLIC_KEY_NOT_FOUND) {
            throw new NullPointerException("Package has no KeySet data");
        } else {
            return pkg.keySetData.getProperSigningKeySet() == getIdByKeySetLPr(ks);
        }
    }

    public void addDefinedKeySetToPackageLPw(String packageName, ArraySet<PublicKey> keys, String alias) {
        if (packageName == null || keys == null || alias == null) {
            Slog.w(TAG, "Got null argument for a defined keyset, ignoring!");
            return;
        }
        PackageSetting pkg = (PackageSetting) this.mPackages.get(packageName);
        if (pkg == null) {
            throw new NullPointerException("Unknown package");
        }
        pkg.keySetData.addDefinedKeySet(getIdByKeySetLPr(addKeySetLPw(keys)), alias);
    }

    public void addUpgradeKeySetToPackageLPw(String packageName, String alias) {
        if (packageName == null || alias == null) {
            Slog.w(TAG, "Got null argument for a defined keyset, ignoring!");
            return;
        }
        PackageSetting pkg = (PackageSetting) this.mPackages.get(packageName);
        if (pkg == null) {
            throw new NullPointerException("Unknown package");
        }
        pkg.keySetData.addUpgradeKeySet(alias);
    }

    public void addSigningKeySetToPackageLPw(String packageName, ArraySet<PublicKey> signingKeys) {
        if (packageName == null || signingKeys == null) {
            Slog.w(TAG, "Got null argument for a signing keyset, ignoring!");
            return;
        }
        long id = getIdByKeySetLPr(addKeySetLPw(signingKeys));
        ArraySet<Long> publicKeyIds = (ArraySet) this.mKeySetMapping.get(id);
        if (publicKeyIds == null) {
            throw new NullPointerException("Got invalid KeySet id");
        }
        PackageSetting pkg = (PackageSetting) this.mPackages.get(packageName);
        if (pkg == null) {
            throw new NullPointerException("No such package!");
        }
        pkg.keySetData.setProperSigningKeySet(id);
        for (int keySetIndex = 0; keySetIndex < this.mKeySets.size(); keySetIndex += FIRST_VERSION) {
            long keySetID = this.mKeySets.keyAt(keySetIndex);
            if (publicKeyIds.containsAll((ArraySet) this.mKeySetMapping.get(keySetID))) {
                pkg.keySetData.addSigningKeySet(keySetID);
            }
        }
    }

    private long getIdByKeySetLPr(KeySetHandle ks) {
        for (int keySetIndex = 0; keySetIndex < this.mKeySets.size(); keySetIndex += FIRST_VERSION) {
            if (ks.equals((KeySetHandle) this.mKeySets.valueAt(keySetIndex))) {
                return this.mKeySets.keyAt(keySetIndex);
            }
        }
        return PUBLIC_KEY_NOT_FOUND;
    }

    public KeySetHandle getKeySetByIdLPr(long id) {
        return (KeySetHandle) this.mKeySets.get(id);
    }

    public KeySetHandle getKeySetByAliasAndPackageNameLPr(String packageName, String alias) {
        PackageSetting p = (PackageSetting) this.mPackages.get(packageName);
        if (p == null || p.keySetData == null) {
            return null;
        }
        Long keySetId = (Long) p.keySetData.getAliases().get(alias);
        if (keySetId != null) {
            return (KeySetHandle) this.mKeySets.get(keySetId.longValue());
        }
        throw new IllegalArgumentException("Unknown KeySet alias: " + alias);
    }

    public ArraySet<PublicKey> getPublicKeysFromKeySetLPr(long id) {
        if (this.mKeySetMapping.get(id) == null) {
            return null;
        }
        ArraySet<PublicKey> mPubKeys = new ArraySet();
        Iterator i$ = ((ArraySet) this.mKeySetMapping.get(id)).iterator();
        while (i$.hasNext()) {
            mPubKeys.add(this.mPublicKeys.get(((Long) i$.next()).longValue()));
        }
        return mPubKeys;
    }

    public KeySetHandle getSigningKeySetByPackageNameLPr(String packageName) {
        PackageSetting p = (PackageSetting) this.mPackages.get(packageName);
        if (p == null || p.keySetData == null || p.keySetData.getProperSigningKeySet() == PUBLIC_KEY_NOT_FOUND) {
            return null;
        }
        return (KeySetHandle) this.mKeySets.get(p.keySetData.getProperSigningKeySet());
    }

    public ArraySet<KeySetHandle> getUpgradeKeySetsByPackageNameLPr(String packageName) {
        ArraySet<KeySetHandle> upgradeKeySets = new ArraySet();
        PackageSetting p = (PackageSetting) this.mPackages.get(packageName);
        if (p == null) {
            throw new NullPointerException("Unknown package");
        } else if (p.keySetData == null) {
            throw new IllegalArgumentException("Package has no keySet data");
        } else {
            if (p.keySetData.isUsingUpgradeKeySets()) {
                long[] arr$ = p.keySetData.getUpgradeKeySets();
                int len$ = arr$.length;
                for (int i$ = 0; i$ < len$; i$ += FIRST_VERSION) {
                    upgradeKeySets.add(this.mKeySets.get(arr$[i$]));
                }
            }
            return upgradeKeySets;
        }
    }

    private KeySetHandle addKeySetLPw(ArraySet<PublicKey> keys) {
        if (keys == null) {
            throw new NullPointerException("Provided keys cannot be null");
        }
        ArraySet<Long> addedKeyIds = new ArraySet(keys.size());
        Iterator i$ = keys.iterator();
        while (i$.hasNext()) {
            addedKeyIds.add(Long.valueOf(addPublicKeyLPw((PublicKey) i$.next())));
        }
        long existingKeySetId = getIdFromKeyIdsLPr(addedKeyIds);
        if (existingKeySetId != PUBLIC_KEY_NOT_FOUND) {
            return (KeySetHandle) this.mKeySets.get(existingKeySetId);
        }
        KeySetHandle ks = new KeySetHandle();
        long id = getFreeKeySetIDLPw();
        this.mKeySets.put(id, ks);
        this.mKeySetMapping.put(id, addedKeyIds);
        for (String pkgName : this.mPackages.keySet()) {
            PackageSetting p = (PackageSetting) this.mPackages.get(pkgName);
            if (p.keySetData != null) {
                long pProperSigning = p.keySetData.getProperSigningKeySet();
                if (pProperSigning != PUBLIC_KEY_NOT_FOUND && ((ArraySet) this.mKeySetMapping.get(pProperSigning)).containsAll(addedKeyIds)) {
                    p.keySetData.addSigningKeySet(id);
                }
            }
        }
        return ks;
    }

    private long addPublicKeyLPw(PublicKey key) {
        long existingKeyId = getIdForPublicKeyLPr(key);
        if (existingKeyId != PUBLIC_KEY_NOT_FOUND) {
            return existingKeyId;
        }
        long id = getFreePublicKeyIdLPw();
        this.mPublicKeys.put(id, key);
        return id;
    }

    private long getIdFromKeyIdsLPr(Set<Long> publicKeyIds) {
        for (int keyMapIndex = 0; keyMapIndex < this.mKeySetMapping.size(); keyMapIndex += FIRST_VERSION) {
            if (((ArraySet) this.mKeySetMapping.valueAt(keyMapIndex)).equals(publicKeyIds)) {
                return this.mKeySetMapping.keyAt(keyMapIndex);
            }
        }
        return PUBLIC_KEY_NOT_FOUND;
    }

    private long getIdForPublicKeyLPr(PublicKey k) {
        String encodedPublicKey = new String(k.getEncoded());
        for (int publicKeyIndex = 0; publicKeyIndex < this.mPublicKeys.size(); publicKeyIndex += FIRST_VERSION) {
            if (encodedPublicKey.equals(new String(((PublicKey) this.mPublicKeys.valueAt(publicKeyIndex)).getEncoded()))) {
                return this.mPublicKeys.keyAt(publicKeyIndex);
            }
        }
        return PUBLIC_KEY_NOT_FOUND;
    }

    private long getFreeKeySetIDLPw() {
        lastIssuedKeySetId++;
        return lastIssuedKeySetId;
    }

    private long getFreePublicKeyIdLPw() {
        lastIssuedKeyId++;
        return lastIssuedKeyId;
    }

    public void removeAppKeySetDataLPw(String packageName) {
        ArraySet<Long> deletableKeySets = getOriginalKeySetsByPackageNameLPr(packageName);
        ArraySet<Long> deletableKeys = new ArraySet();
        Iterator i$ = deletableKeySets.iterator();
        while (i$.hasNext()) {
            ArraySet<Long> knownKeys = (ArraySet) this.mKeySetMapping.get(((Long) i$.next()).longValue());
            if (knownKeys != null) {
                deletableKeys.addAll(knownKeys);
            }
        }
        for (String pkgName : this.mPackages.keySet()) {
            Iterator i$2;
            if (!pkgName.equals(packageName)) {
                ArraySet<Long> knownKeySets = getOriginalKeySetsByPackageNameLPr(pkgName);
                deletableKeySets.removeAll(knownKeySets);
                knownKeys = new ArraySet();
                i$2 = knownKeySets.iterator();
                while (i$2.hasNext()) {
                    knownKeys = (ArraySet) this.mKeySetMapping.get(((Long) i$2.next()).longValue());
                    if (knownKeys != null) {
                        deletableKeys.removeAll(knownKeys);
                    }
                }
            }
        }
        i$ = deletableKeySets.iterator();
        while (i$.hasNext()) {
            Long ks = (Long) i$.next();
            this.mKeySets.delete(ks.longValue());
            this.mKeySetMapping.delete(ks.longValue());
        }
        i$ = deletableKeys.iterator();
        while (i$.hasNext()) {
            this.mPublicKeys.delete(((Long) i$.next()).longValue());
        }
        for (String pkgName2 : this.mPackages.keySet()) {
            PackageSetting p = (PackageSetting) this.mPackages.get(pkgName2);
            i$2 = deletableKeySets.iterator();
            while (i$2.hasNext()) {
                p.keySetData.removeSigningKeySet(((Long) i$2.next()).longValue());
            }
        }
        clearPackageKeySetDataLPw((PackageSetting) this.mPackages.get(packageName));
    }

    private void clearPackageKeySetDataLPw(PackageSetting p) {
        p.keySetData.removeAllSigningKeySets();
        p.keySetData.removeAllUpgradeKeySets();
        p.keySetData.removeAllDefinedKeySets();
    }

    private ArraySet<Long> getOriginalKeySetsByPackageNameLPr(String packageName) {
        PackageSetting p = (PackageSetting) this.mPackages.get(packageName);
        if (p == null) {
            throw new NullPointerException("Unknown package");
        } else if (p.keySetData == null) {
            throw new IllegalArgumentException("Package has no keySet data");
        } else {
            ArraySet<Long> knownKeySets = new ArraySet();
            knownKeySets.add(Long.valueOf(p.keySetData.getProperSigningKeySet()));
            if (p.keySetData.isUsingDefinedKeySets()) {
                long[] arr$ = p.keySetData.getDefinedKeySets();
                int len$ = arr$.length;
                for (int i$ = 0; i$ < len$; i$ += FIRST_VERSION) {
                    knownKeySets.add(Long.valueOf(arr$[i$]));
                }
            }
            return knownKeySets;
        }
    }

    public String encodePublicKey(PublicKey k) throws IOException {
        return new String(Base64.encode(k.getEncoded(), 0));
    }

    public void dumpLPr(PrintWriter pw, String packageName, DumpState dumpState) {
        boolean printedHeader = false;
        for (Entry<String, PackageSetting> e : this.mPackages.entrySet()) {
            String keySetPackage = (String) e.getKey();
            if (packageName == null || packageName.equals(keySetPackage)) {
                if (!printedHeader) {
                    if (dumpState.onTitlePrinted()) {
                        pw.println();
                    }
                    pw.println("Key Set Manager:");
                    printedHeader = true;
                }
                PackageSetting pkg = (PackageSetting) e.getValue();
                pw.print("  [");
                pw.print(keySetPackage);
                pw.println("]");
                if (pkg.keySetData != null) {
                    long[] arr$;
                    int len$;
                    int i$;
                    long keySetId;
                    boolean printedLabel = false;
                    for (Entry<String, Long> entry : pkg.keySetData.getAliases().entrySet()) {
                        if (printedLabel) {
                            pw.print(", ");
                        } else {
                            pw.print("      KeySets Aliases: ");
                            printedLabel = true;
                        }
                        pw.print((String) entry.getKey());
                        pw.print('=');
                        pw.print(Long.toString(((Long) entry.getValue()).longValue()));
                    }
                    if (printedLabel) {
                        pw.println("");
                    }
                    printedLabel = false;
                    if (pkg.keySetData.isUsingDefinedKeySets()) {
                        arr$ = pkg.keySetData.getDefinedKeySets();
                        len$ = arr$.length;
                        for (i$ = 0; i$ < len$; i$ += FIRST_VERSION) {
                            keySetId = arr$[i$];
                            if (printedLabel) {
                                pw.print(", ");
                            } else {
                                pw.print("      Defined KeySets: ");
                                printedLabel = true;
                            }
                            pw.print(Long.toString(keySetId));
                        }
                    }
                    if (printedLabel) {
                        pw.println("");
                    }
                    printedLabel = false;
                    long[] signingKeySets = pkg.keySetData.getSigningKeySets();
                    if (signingKeySets != null) {
                        arr$ = signingKeySets;
                        len$ = arr$.length;
                        for (i$ = 0; i$ < len$; i$ += FIRST_VERSION) {
                            keySetId = arr$[i$];
                            if (printedLabel) {
                                pw.print(", ");
                            } else {
                                pw.print("      Signing KeySets: ");
                                printedLabel = true;
                            }
                            pw.print(Long.toString(keySetId));
                        }
                    }
                    if (printedLabel) {
                        pw.println("");
                    }
                    printedLabel = false;
                    if (pkg.keySetData.isUsingUpgradeKeySets()) {
                        arr$ = pkg.keySetData.getUpgradeKeySets();
                        len$ = arr$.length;
                        for (i$ = 0; i$ < len$; i$ += FIRST_VERSION) {
                            keySetId = arr$[i$];
                            if (printedLabel) {
                                pw.print(", ");
                            } else {
                                pw.print("      Upgrade KeySets: ");
                                printedLabel = true;
                            }
                            pw.print(Long.toString(keySetId));
                        }
                    }
                    if (printedLabel) {
                        pw.println("");
                    }
                }
            }
        }
    }

    void writeKeySetManagerServiceLPr(XmlSerializer serializer) throws IOException {
        serializer.startTag(null, "keyset-settings");
        serializer.attribute(null, "version", Integer.toString(FIRST_VERSION));
        writePublicKeysLPr(serializer);
        writeKeySetsLPr(serializer);
        serializer.startTag(null, "lastIssuedKeyId");
        serializer.attribute(null, "value", Long.toString(lastIssuedKeyId));
        serializer.endTag(null, "lastIssuedKeyId");
        serializer.startTag(null, "lastIssuedKeySetId");
        serializer.attribute(null, "value", Long.toString(lastIssuedKeySetId));
        serializer.endTag(null, "lastIssuedKeySetId");
        serializer.endTag(null, "keyset-settings");
    }

    void writePublicKeysLPr(XmlSerializer serializer) throws IOException {
        serializer.startTag(null, "keys");
        for (int pKeyIndex = 0; pKeyIndex < this.mPublicKeys.size(); pKeyIndex += FIRST_VERSION) {
            long id = this.mPublicKeys.keyAt(pKeyIndex);
            String encodedKey = encodePublicKey((PublicKey) this.mPublicKeys.valueAt(pKeyIndex));
            serializer.startTag(null, "public-key");
            serializer.attribute(null, "identifier", Long.toString(id));
            serializer.attribute(null, "value", encodedKey);
            serializer.endTag(null, "public-key");
        }
        serializer.endTag(null, "keys");
    }

    void writeKeySetsLPr(XmlSerializer serializer) throws IOException {
        serializer.startTag(null, "keysets");
        for (int keySetIndex = 0; keySetIndex < this.mKeySetMapping.size(); keySetIndex += FIRST_VERSION) {
            long id = this.mKeySetMapping.keyAt(keySetIndex);
            ArraySet<Long> keys = (ArraySet) this.mKeySetMapping.valueAt(keySetIndex);
            serializer.startTag(null, "keyset");
            serializer.attribute(null, "identifier", Long.toString(id));
            Iterator i$ = keys.iterator();
            while (i$.hasNext()) {
                long keyId = ((Long) i$.next()).longValue();
                serializer.startTag(null, "key-id");
                serializer.attribute(null, "identifier", Long.toString(keyId));
                serializer.endTag(null, "key-id");
            }
            serializer.endTag(null, "keyset");
        }
        serializer.endTag(null, "keysets");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void readKeySetsLPw(org.xmlpull.v1.XmlPullParser r14) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
        /*
        r13 = this;
        r12 = 0;
        r11 = 3;
        r10 = 1;
        r0 = 0;
        r3 = r14.getDepth();
        r8 = "version";
        r5 = r14.getAttributeValue(r12, r8);
        if (r5 == 0) goto L_0x0017;
    L_0x0011:
        r8 = java.lang.Integer.parseInt(r5);
        if (r8 == r10) goto L_0x003f;
    L_0x0017:
        r7 = r14.next();
        if (r7 == r10) goto L_0x0025;
    L_0x001d:
        if (r7 != r11) goto L_0x0017;
    L_0x001f:
        r8 = r14.getDepth();
        if (r8 > r3) goto L_0x0017;
    L_0x0025:
        r8 = r13.mPackages;
        r8 = r8.values();
        r2 = r8.iterator();
    L_0x002f:
        r8 = r2.hasNext();
        if (r8 == 0) goto L_0x0098;
    L_0x0035:
        r4 = r2.next();
        r4 = (com.android.server.pm.PackageSetting) r4;
        r13.clearPackageKeySetDataLPw(r4);
        goto L_0x002f;
    L_0x003f:
        r7 = r14.next();
        if (r7 == r10) goto L_0x0098;
    L_0x0045:
        if (r7 != r11) goto L_0x004d;
    L_0x0047:
        r8 = r14.getDepth();
        if (r8 <= r3) goto L_0x0098;
    L_0x004d:
        if (r7 == r11) goto L_0x003f;
    L_0x004f:
        r8 = 4;
        if (r7 == r8) goto L_0x003f;
    L_0x0052:
        r6 = r14.getName();
        r8 = "keys";
        r8 = r6.equals(r8);
        if (r8 == 0) goto L_0x0062;
    L_0x005e:
        r13.readKeysLPw(r14);
        goto L_0x003f;
    L_0x0062:
        r8 = "keysets";
        r8 = r6.equals(r8);
        if (r8 == 0) goto L_0x006e;
    L_0x006a:
        r13.readKeySetListLPw(r14);
        goto L_0x003f;
    L_0x006e:
        r8 = "lastIssuedKeyId";
        r8 = r6.equals(r8);
        if (r8 == 0) goto L_0x0083;
    L_0x0076:
        r8 = "value";
        r8 = r14.getAttributeValue(r12, r8);
        r8 = java.lang.Long.parseLong(r8);
        lastIssuedKeyId = r8;
        goto L_0x003f;
    L_0x0083:
        r8 = "lastIssuedKeySetId";
        r8 = r6.equals(r8);
        if (r8 == 0) goto L_0x003f;
    L_0x008b:
        r8 = "value";
        r8 = r14.getAttributeValue(r12, r8);
        r8 = java.lang.Long.parseLong(r8);
        lastIssuedKeySetId = r8;
        goto L_0x003f;
    L_0x0098:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.KeySetManagerService.readKeySetsLPw(org.xmlpull.v1.XmlPullParser):void");
    }

    void readKeysLPw(XmlPullParser parser) throws XmlPullParserException, IOException {
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == FIRST_VERSION) {
                return;
            }
            if (type == 3 && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == 3 || type == 4 || !parser.getName().equals("public-key"))) {
                readPublicKeyLPw(parser);
            }
        }
    }

    void readKeySetListLPw(XmlPullParser parser) throws XmlPullParserException, IOException {
        int outerDepth = parser.getDepth();
        long currentKeySetId = 0;
        while (true) {
            int type = parser.next();
            if (type == FIRST_VERSION) {
                return;
            }
            if (type == 3 && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == 3 || type == 4)) {
                String tagName = parser.getName();
                if (tagName.equals("keyset")) {
                    currentKeySetId = readIdentifierLPw(parser);
                    this.mKeySets.put(currentKeySetId, new KeySetHandle());
                    this.mKeySetMapping.put(currentKeySetId, new ArraySet());
                } else if (tagName.equals("key-id")) {
                    ((ArraySet) this.mKeySetMapping.get(currentKeySetId)).add(Long.valueOf(readIdentifierLPw(parser)));
                }
            }
        }
    }

    long readIdentifierLPw(XmlPullParser parser) throws XmlPullParserException {
        return Long.parseLong(parser.getAttributeValue(null, "identifier"));
    }

    void readPublicKeyLPw(XmlPullParser parser) throws XmlPullParserException {
        long identifier = Long.parseLong(parser.getAttributeValue(null, "identifier"));
        PublicKey pub = PackageParser.parsePublicKey(parser.getAttributeValue(null, "value"));
        if (pub != null) {
            this.mPublicKeys.put(identifier, pub);
        }
    }
}
