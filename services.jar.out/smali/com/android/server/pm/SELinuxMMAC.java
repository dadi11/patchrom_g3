package com.android.server.pm;

import android.content.pm.PackageParser.Package;
import android.content.pm.Signature;
import android.os.Environment;
import android.util.Slog;
import android.util.Xml;
import com.android.internal.util.XmlUtils;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import libcore.io.IoUtils;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

public final class SELinuxMMAC {
    private static final String BASE_MAC_PERMISSIONS;
    private static final String BASE_SEAPP_CONTEXTS = "/seapp_contexts";
    private static final String BASE_VERSION_FILE = "/selinux_version";
    private static final String DATA_MAC_PERMISSIONS;
    private static final String DATA_SEAPP_CONTEXTS;
    private static final String DATA_VERSION_FILE;
    private static final boolean DEBUG_POLICY = false;
    private static final boolean DEBUG_POLICY_INSTALL = false;
    private static final String MAC_PERMISSIONS;
    private static final String SEAPP_CONTEXTS;
    private static final String SEAPP_HASH_FILE;
    private static final String TAG = "SELinuxMMAC";
    private static final boolean USE_OVERRIDE_POLICY;
    private static String sDefaultSeinfo;
    private static HashMap<Signature, Policy> sSigSeinfo;

    static class Policy {
        private final HashMap<String, String> pkgMap;
        private String seinfo;

        Policy() {
            this.seinfo = null;
            this.pkgMap = new HashMap();
        }

        void putSeinfo(String seinfoValue) {
            this.seinfo = seinfoValue;
        }

        void putPkg(String pkg, String seinfoValue) {
            this.pkgMap.put(pkg, seinfoValue);
        }

        boolean isValid() {
            return (this.seinfo == null && this.pkgMap.isEmpty()) ? SELinuxMMAC.DEBUG_POLICY_INSTALL : true;
        }

        String checkPolicy(String pkgName) {
            String seinfoValue = (String) this.pkgMap.get(pkgName);
            return seinfoValue != null ? seinfoValue : this.seinfo;
        }
    }

    static {
        sSigSeinfo = new HashMap();
        sDefaultSeinfo = null;
        DATA_VERSION_FILE = Environment.getDataDirectory() + "/security/current/selinux_version";
        USE_OVERRIDE_POLICY = useOverridePolicy();
        DATA_MAC_PERMISSIONS = Environment.getDataDirectory() + "/security/current/mac_permissions.xml";
        BASE_MAC_PERMISSIONS = Environment.getRootDirectory() + "/etc/security/mac_permissions.xml";
        MAC_PERMISSIONS = USE_OVERRIDE_POLICY ? DATA_MAC_PERMISSIONS : BASE_MAC_PERMISSIONS;
        DATA_SEAPP_CONTEXTS = Environment.getDataDirectory() + "/security/current/seapp_contexts";
        SEAPP_CONTEXTS = USE_OVERRIDE_POLICY ? DATA_SEAPP_CONTEXTS : BASE_SEAPP_CONTEXTS;
        SEAPP_HASH_FILE = Environment.getDataDirectory().toString() + "/system/seapp_hash";
    }

    private static void flushInstallPolicy() {
        sSigSeinfo.clear();
        sDefaultSeinfo = null;
    }

    public static boolean readInstallPolicy() {
        XmlPullParserException xpe;
        IOException ioe;
        Throwable th;
        HashMap<Signature, Policy> sigSeinfo = new HashMap();
        String defaultSeinfo = null;
        FileReader fileReader = null;
        try {
            FileReader policyFile = new FileReader(MAC_PERMISSIONS);
            try {
                Slog.d(TAG, "Using policy file " + MAC_PERMISSIONS);
                XmlPullParser parser = Xml.newPullParser();
                parser.setInput(policyFile);
                XmlUtils.beginDocument(parser, "policy");
                while (true) {
                    XmlUtils.nextElement(parser);
                    if (parser.getEventType() == 1) {
                        IoUtils.closeQuietly(policyFile);
                        flushInstallPolicy();
                        sSigSeinfo = sigSeinfo;
                        sDefaultSeinfo = defaultSeinfo;
                        fileReader = policyFile;
                        return true;
                    }
                    String tagName = parser.getName();
                    if ("signer".equals(tagName)) {
                        String cert = parser.getAttributeValue(null, "signature");
                        if (cert == null) {
                            Slog.w(TAG, "<signer> without signature at " + parser.getPositionDescription());
                            XmlUtils.skipCurrentTag(parser);
                        } else {
                            try {
                                Signature signature = new Signature(cert);
                                Policy policy = readPolicyTags(parser);
                                if (policy.isValid()) {
                                    sigSeinfo.put(signature, policy);
                                }
                            } catch (IllegalArgumentException e) {
                                Slog.w(TAG, "<signer> with bad signature at " + parser.getPositionDescription(), e);
                                XmlUtils.skipCurrentTag(parser);
                            }
                        }
                    } else if ("default".equals(tagName)) {
                        defaultSeinfo = readSeinfoTag(parser);
                    } else {
                        XmlUtils.skipCurrentTag(parser);
                    }
                }
            } catch (XmlPullParserException e2) {
                xpe = e2;
                fileReader = policyFile;
            } catch (IOException e3) {
                ioe = e3;
                fileReader = policyFile;
            } catch (Throwable th2) {
                th = th2;
                fileReader = policyFile;
            }
        } catch (XmlPullParserException e4) {
            xpe = e4;
            try {
                Slog.w(TAG, "Got exception parsing " + MAC_PERMISSIONS, xpe);
                IoUtils.closeQuietly(fileReader);
                return DEBUG_POLICY_INSTALL;
            } catch (Throwable th3) {
                th = th3;
                IoUtils.closeQuietly(fileReader);
                throw th;
            }
        } catch (IOException e5) {
            ioe = e5;
            Slog.w(TAG, "Got exception parsing " + MAC_PERMISSIONS, ioe);
            IoUtils.closeQuietly(fileReader);
            return DEBUG_POLICY_INSTALL;
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private static com.android.server.pm.SELinuxMMAC.Policy readPolicyTags(org.xmlpull.v1.XmlPullParser r10) throws java.io.IOException, org.xmlpull.v1.XmlPullParserException {
        /*
        r9 = 3;
        r0 = r10.getDepth();
        r2 = new com.android.server.pm.SELinuxMMAC$Policy;
        r2.<init>();
    L_0x000a:
        r5 = r10.next();
        r6 = 1;
        if (r5 == r6) goto L_0x007a;
    L_0x0011:
        if (r5 != r9) goto L_0x0019;
    L_0x0013:
        r6 = r10.getDepth();
        if (r6 <= r0) goto L_0x007a;
    L_0x0019:
        if (r5 == r9) goto L_0x000a;
    L_0x001b:
        r6 = 4;
        if (r5 == r6) goto L_0x000a;
    L_0x001e:
        r4 = r10.getName();
        r6 = "seinfo";
        r6 = r6.equals(r4);
        if (r6 == 0) goto L_0x0037;
    L_0x002a:
        r3 = parseSeinfo(r10);
        if (r3 == 0) goto L_0x0033;
    L_0x0030:
        r2.putSeinfo(r3);
    L_0x0033:
        com.android.internal.util.XmlUtils.skipCurrentTag(r10);
        goto L_0x000a;
    L_0x0037:
        r6 = "package";
        r6 = r6.equals(r4);
        if (r6 == 0) goto L_0x0076;
    L_0x003f:
        r6 = 0;
        r7 = "name";
        r1 = r10.getAttributeValue(r6, r7);
        r6 = validatePackageName(r1);
        if (r6 != 0) goto L_0x006c;
    L_0x004c:
        r6 = "SELinuxMMAC";
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "<package> without valid name at ";
        r7 = r7.append(r8);
        r8 = r10.getPositionDescription();
        r7 = r7.append(r8);
        r7 = r7.toString();
        android.util.Slog.w(r6, r7);
        com.android.internal.util.XmlUtils.skipCurrentTag(r10);
        goto L_0x000a;
    L_0x006c:
        r3 = readSeinfoTag(r10);
        if (r3 == 0) goto L_0x000a;
    L_0x0072:
        r2.putPkg(r1, r3);
        goto L_0x000a;
    L_0x0076:
        com.android.internal.util.XmlUtils.skipCurrentTag(r10);
        goto L_0x000a;
    L_0x007a:
        return r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.SELinuxMMAC.readPolicyTags(org.xmlpull.v1.XmlPullParser):com.android.server.pm.SELinuxMMAC$Policy");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private static java.lang.String readSeinfoTag(org.xmlpull.v1.XmlPullParser r6) throws java.io.IOException, org.xmlpull.v1.XmlPullParserException {
        /*
        r5 = 3;
        r0 = r6.getDepth();
        r1 = 0;
    L_0x0006:
        r3 = r6.next();
        r4 = 1;
        if (r3 == r4) goto L_0x002e;
    L_0x000d:
        if (r3 != r5) goto L_0x0015;
    L_0x000f:
        r4 = r6.getDepth();
        if (r4 <= r0) goto L_0x002e;
    L_0x0015:
        if (r3 == r5) goto L_0x0006;
    L_0x0017:
        r4 = 4;
        if (r3 == r4) goto L_0x0006;
    L_0x001a:
        r2 = r6.getName();
        r4 = "seinfo";
        r4 = r4.equals(r2);
        if (r4 == 0) goto L_0x002a;
    L_0x0026:
        r1 = parseSeinfo(r6);
    L_0x002a:
        com.android.internal.util.XmlUtils.skipCurrentTag(r6);
        goto L_0x0006;
    L_0x002e:
        return r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.SELinuxMMAC.readSeinfoTag(org.xmlpull.v1.XmlPullParser):java.lang.String");
    }

    private static String parseSeinfo(XmlPullParser parser) {
        String seinfoValue = parser.getAttributeValue(null, "value");
        if (validateValue(seinfoValue)) {
            return seinfoValue;
        }
        Slog.w(TAG, "<seinfo> without valid value at " + parser.getPositionDescription());
        return null;
    }

    private static boolean validatePackageName(String name) {
        if (name == null) {
            return DEBUG_POLICY_INSTALL;
        }
        int N = name.length();
        boolean hasSep = DEBUG_POLICY_INSTALL;
        boolean front = true;
        for (int i = 0; i < N; i++) {
            char c = name.charAt(i);
            if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
                front = DEBUG_POLICY_INSTALL;
            } else if (front || ((c < '0' || c > '9') && c != '_')) {
                if (c != '.') {
                    return DEBUG_POLICY_INSTALL;
                }
                hasSep = true;
                front = true;
            }
        }
        return hasSep;
    }

    private static boolean validateValue(String name) {
        if (name == null) {
            return DEBUG_POLICY_INSTALL;
        }
        int N = name.length();
        if (N == 0) {
            return DEBUG_POLICY_INSTALL;
        }
        for (int i = 0; i < N; i++) {
            char c = name.charAt(i);
            if ((c < 'a' || c > 'z') && ((c < 'A' || c > 'Z') && c != '_')) {
                return DEBUG_POLICY_INSTALL;
            }
        }
        return true;
    }

    public static boolean assignSeinfoValue(Package pkg) {
        for (Signature s : pkg.mSignatures) {
            if (s != null) {
                Policy policy = (Policy) sSigSeinfo.get(s);
                if (policy != null) {
                    String seinfo = policy.checkPolicy(pkg.packageName);
                    if (seinfo != null) {
                        pkg.applicationInfo.seinfo = seinfo;
                        return true;
                    }
                } else {
                    continue;
                }
            }
        }
        pkg.applicationInfo.seinfo = sDefaultSeinfo;
        if (sDefaultSeinfo == null) {
            return DEBUG_POLICY_INSTALL;
        }
        return true;
    }

    public static boolean shouldRestorecon() {
        try {
            byte[] currentHash = returnHash(SEAPP_CONTEXTS);
            byte[] storedHash = null;
            try {
                storedHash = IoUtils.readFileAsByteArray(SEAPP_HASH_FILE);
            } catch (IOException e) {
                Slog.w(TAG, "Error opening " + SEAPP_HASH_FILE + ". Assuming first boot.");
            }
            if (storedHash == null || !MessageDigest.isEqual(storedHash, currentHash)) {
                return true;
            }
            return DEBUG_POLICY_INSTALL;
        } catch (IOException ioe) {
            Slog.e(TAG, "Error with hashing seapp_contexts.", ioe);
            return DEBUG_POLICY_INSTALL;
        }
    }

    public static void setRestoreconDone() {
        try {
            dumpHash(new File(SEAPP_HASH_FILE), returnHash(SEAPP_CONTEXTS));
        } catch (IOException ioe) {
            Slog.e(TAG, "Error with saving hash to " + SEAPP_HASH_FILE, ioe);
        }
    }

    private static void dumpHash(File file, byte[] content) throws IOException {
        Throwable th;
        FileOutputStream fos = null;
        File tmp = null;
        try {
            tmp = File.createTempFile("seapp_hash", ".journal", file.getParentFile());
            tmp.setReadable(true);
            FileOutputStream fos2 = new FileOutputStream(tmp);
            try {
                fos2.write(content);
                fos2.getFD().sync();
                if (tmp.renameTo(file)) {
                    if (tmp != null) {
                        tmp.delete();
                    }
                    IoUtils.closeQuietly(fos2);
                    return;
                }
                throw new IOException("Failure renaming " + file.getCanonicalPath());
            } catch (Throwable th2) {
                th = th2;
                fos = fos2;
                if (tmp != null) {
                    tmp.delete();
                }
                IoUtils.closeQuietly(fos);
                throw th;
            }
        } catch (Throwable th3) {
            th = th3;
            if (tmp != null) {
                tmp.delete();
            }
            IoUtils.closeQuietly(fos);
            throw th;
        }
    }

    private static byte[] returnHash(String file) throws IOException {
        try {
            return MessageDigest.getInstance("SHA-1").digest(IoUtils.readFileAsByteArray(file));
        } catch (NoSuchAlgorithmException nsae) {
            throw new RuntimeException(nsae);
        }
    }

    private static boolean useOverridePolicy() {
        try {
            String overrideVersion = IoUtils.readFileAsString(DATA_VERSION_FILE);
            String baseVersion = IoUtils.readFileAsString(BASE_VERSION_FILE);
            if (overrideVersion.equals(baseVersion)) {
                return true;
            }
            Slog.e(TAG, "Override policy version '" + overrideVersion + "' doesn't match " + "base version '" + baseVersion + "'. Skipping override policy files.");
            return DEBUG_POLICY_INSTALL;
        } catch (FileNotFoundException e) {
        } catch (IOException ioe) {
            Slog.w(TAG, "Skipping override policy files.", ioe);
        }
    }
}
