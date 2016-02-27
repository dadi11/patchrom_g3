package com.android.server;

import android.app.AppOpsManager;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.util.Slog;
import android.util.SparseArray;
import com.android.internal.util.XmlUtils;
import com.android.server.voiceinteraction.DatabaseHelper.SoundModelContract;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map.Entry;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

public class AppOpsPolicy {
    public static final int CONTROL_NOSHOW = 1;
    public static final int CONTROL_SHOW = 0;
    public static final int CONTROL_UNKNOWN = 2;
    static final boolean DEBUG = false;
    static final String TAG = "AppOpsPolicy";
    final Context mContext;
    final File mFile;
    HashMap<String, PolicyPkg> mPolicy;

    public static final class PolicyOp {
        public int mode;
        public int op;
        public int show;

        public PolicyOp(int op, int mode, int show) {
            this.op = op;
            this.mode = mode;
            this.show = show;
        }

        public String toString() {
            return "PolicyOp [op=" + this.op + ", mode=" + this.mode + ", show=" + this.show + "]";
        }
    }

    public static final class PolicyPkg extends SparseArray<PolicyOp> {
        public int mode;
        public String packageName;
        public int show;
        public String type;

        public PolicyPkg(String packageName, int mode, int show, String type) {
            this.packageName = packageName;
            this.mode = mode;
            this.show = show;
            this.type = type;
        }

        public String toString() {
            return "PolicyPkg [packageName=" + this.packageName + ", mode=" + this.mode + ", show=" + this.show + ", type=" + this.type + "]";
        }
    }

    public static int stringToControl(String show) {
        if ("true".equalsIgnoreCase(show)) {
            return CONTROL_SHOW;
        }
        if ("false".equalsIgnoreCase(show)) {
            return CONTROL_NOSHOW;
        }
        return CONTROL_UNKNOWN;
    }

    public AppOpsPolicy(File file, Context context) {
        this.mPolicy = new HashMap();
        this.mFile = file;
        this.mContext = context;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void readPolicy() {
        /*
        r13 = this;
        r12 = 3;
        r9 = 2;
        r11 = 1;
        r8 = r13.mFile;
        monitor-enter(r8);
        r3 = new java.io.FileInputStream;	 Catch:{ FileNotFoundException -> 0x004e }
        r7 = r13.mFile;	 Catch:{ FileNotFoundException -> 0x004e }
        r3.<init>(r7);	 Catch:{ FileNotFoundException -> 0x004e }
        r4 = 0;
        r2 = android.util.Xml.newPullParser();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        r7 = 0;
        r2.setInput(r3, r7);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        r4 = 1;
    L_0x0017:
        r6 = r2.next();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        if (r6 == r9) goto L_0x001f;
    L_0x001d:
        if (r6 != r11) goto L_0x0017;
    L_0x001f:
        if (r6 == r9) goto L_0x0078;
    L_0x0021:
        r7 = new java.lang.IllegalStateException;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        r9 = "no start tag found";
        r7.<init>(r9);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        throw r7;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
    L_0x0029:
        r0 = move-exception;
        r7 = "AppOpsPolicy";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a9 }
        r9.<init>();	 Catch:{ all -> 0x01a9 }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x01a9 }
        r9 = r9.append(r0);	 Catch:{ all -> 0x01a9 }
        r9 = r9.toString();	 Catch:{ all -> 0x01a9 }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x01a9 }
        if (r4 != 0) goto L_0x0049;
    L_0x0044:
        r7 = r13.mPolicy;	 Catch:{ all -> 0x0075 }
        r7.clear();	 Catch:{ all -> 0x0075 }
    L_0x0049:
        r3.close();	 Catch:{ IOException -> 0x01b5 }
    L_0x004c:
        monitor-exit(r8);	 Catch:{ all -> 0x0075 }
    L_0x004d:
        return;
    L_0x004e:
        r0 = move-exception;
        r7 = "AppOpsPolicy";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0075 }
        r9.<init>();	 Catch:{ all -> 0x0075 }
        r10 = "App ops policy file (";
        r9 = r9.append(r10);	 Catch:{ all -> 0x0075 }
        r10 = r13.mFile;	 Catch:{ all -> 0x0075 }
        r10 = r10.getPath();	 Catch:{ all -> 0x0075 }
        r9 = r9.append(r10);	 Catch:{ all -> 0x0075 }
        r10 = ") not found; Skipping.";
        r9 = r9.append(r10);	 Catch:{ all -> 0x0075 }
        r9 = r9.toString();	 Catch:{ all -> 0x0075 }
        android.util.Slog.i(r7, r9);	 Catch:{ all -> 0x0075 }
        monitor-exit(r8);	 Catch:{ all -> 0x0075 }
        goto L_0x004d;
    L_0x0075:
        r7 = move-exception;
        monitor-exit(r8);	 Catch:{ all -> 0x0075 }
        throw r7;
    L_0x0078:
        r1 = r2.getDepth();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
    L_0x007c:
        r6 = r2.next();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        if (r6 == r11) goto L_0x014a;
    L_0x0082:
        if (r6 != r12) goto L_0x008a;
    L_0x0084:
        r7 = r2.getDepth();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        if (r7 <= r1) goto L_0x014a;
    L_0x008a:
        if (r6 == r12) goto L_0x007c;
    L_0x008c:
        r7 = 4;
        if (r6 == r7) goto L_0x007c;
    L_0x008f:
        r5 = r2.getName();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        r7 = "user-app";
        r7 = r5.equals(r7);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        if (r7 != 0) goto L_0x00a3;
    L_0x009b:
        r7 = "system-app";
        r7 = r5.equals(r7);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        if (r7 == 0) goto L_0x00cd;
    L_0x00a3:
        r13.readDefaultPolicy(r2, r5);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        goto L_0x007c;
    L_0x00a7:
        r0 = move-exception;
        r7 = "AppOpsPolicy";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a9 }
        r9.<init>();	 Catch:{ all -> 0x01a9 }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x01a9 }
        r9 = r9.append(r0);	 Catch:{ all -> 0x01a9 }
        r9 = r9.toString();	 Catch:{ all -> 0x01a9 }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x01a9 }
        if (r4 != 0) goto L_0x00c7;
    L_0x00c2:
        r7 = r13.mPolicy;	 Catch:{ all -> 0x0075 }
        r7.clear();	 Catch:{ all -> 0x0075 }
    L_0x00c7:
        r3.close();	 Catch:{ IOException -> 0x00cb }
        goto L_0x004c;
    L_0x00cb:
        r7 = move-exception;
        goto L_0x004c;
    L_0x00cd:
        r7 = "application";
        r7 = r5.equals(r7);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        if (r7 == 0) goto L_0x0101;
    L_0x00d5:
        r13.readApplicationPolicy(r2);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        goto L_0x007c;
    L_0x00d9:
        r0 = move-exception;
        r7 = "AppOpsPolicy";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a9 }
        r9.<init>();	 Catch:{ all -> 0x01a9 }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x01a9 }
        r9 = r9.append(r0);	 Catch:{ all -> 0x01a9 }
        r9 = r9.toString();	 Catch:{ all -> 0x01a9 }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x01a9 }
        if (r4 != 0) goto L_0x00f9;
    L_0x00f4:
        r7 = r13.mPolicy;	 Catch:{ all -> 0x0075 }
        r7.clear();	 Catch:{ all -> 0x0075 }
    L_0x00f9:
        r3.close();	 Catch:{ IOException -> 0x00fe }
        goto L_0x004c;
    L_0x00fe:
        r7 = move-exception;
        goto L_0x004c;
    L_0x0101:
        r7 = "AppOpsPolicy";
        r9 = new java.lang.StringBuilder;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        r9.<init>();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        r10 = "Unknown element under <appops-policy>: ";
        r9 = r9.append(r10);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        r10 = r2.getName();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        r9 = r9.append(r10);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        r9 = r9.toString();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        android.util.Slog.w(r7, r9);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        com.android.internal.util.XmlUtils.skipCurrentTag(r2);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x00a7, NumberFormatException -> 0x00d9, XmlPullParserException -> 0x0122, IOException -> 0x0159, IndexOutOfBoundsException -> 0x0181 }
        goto L_0x007c;
    L_0x0122:
        r0 = move-exception;
        r7 = "AppOpsPolicy";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a9 }
        r9.<init>();	 Catch:{ all -> 0x01a9 }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x01a9 }
        r9 = r9.append(r0);	 Catch:{ all -> 0x01a9 }
        r9 = r9.toString();	 Catch:{ all -> 0x01a9 }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x01a9 }
        if (r4 != 0) goto L_0x0142;
    L_0x013d:
        r7 = r13.mPolicy;	 Catch:{ all -> 0x0075 }
        r7.clear();	 Catch:{ all -> 0x0075 }
    L_0x0142:
        r3.close();	 Catch:{ IOException -> 0x0147 }
        goto L_0x004c;
    L_0x0147:
        r7 = move-exception;
        goto L_0x004c;
    L_0x014a:
        if (r4 != 0) goto L_0x0151;
    L_0x014c:
        r7 = r13.mPolicy;	 Catch:{ all -> 0x0075 }
        r7.clear();	 Catch:{ all -> 0x0075 }
    L_0x0151:
        r3.close();	 Catch:{ IOException -> 0x0156 }
        goto L_0x004c;
    L_0x0156:
        r7 = move-exception;
        goto L_0x004c;
    L_0x0159:
        r0 = move-exception;
        r7 = "AppOpsPolicy";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a9 }
        r9.<init>();	 Catch:{ all -> 0x01a9 }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x01a9 }
        r9 = r9.append(r0);	 Catch:{ all -> 0x01a9 }
        r9 = r9.toString();	 Catch:{ all -> 0x01a9 }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x01a9 }
        if (r4 != 0) goto L_0x0179;
    L_0x0174:
        r7 = r13.mPolicy;	 Catch:{ all -> 0x0075 }
        r7.clear();	 Catch:{ all -> 0x0075 }
    L_0x0179:
        r3.close();	 Catch:{ IOException -> 0x017e }
        goto L_0x004c;
    L_0x017e:
        r7 = move-exception;
        goto L_0x004c;
    L_0x0181:
        r0 = move-exception;
        r7 = "AppOpsPolicy";
        r9 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a9 }
        r9.<init>();	 Catch:{ all -> 0x01a9 }
        r10 = "Failed parsing ";
        r9 = r9.append(r10);	 Catch:{ all -> 0x01a9 }
        r9 = r9.append(r0);	 Catch:{ all -> 0x01a9 }
        r9 = r9.toString();	 Catch:{ all -> 0x01a9 }
        android.util.Slog.w(r7, r9);	 Catch:{ all -> 0x01a9 }
        if (r4 != 0) goto L_0x01a1;
    L_0x019c:
        r7 = r13.mPolicy;	 Catch:{ all -> 0x0075 }
        r7.clear();	 Catch:{ all -> 0x0075 }
    L_0x01a1:
        r3.close();	 Catch:{ IOException -> 0x01a6 }
        goto L_0x004c;
    L_0x01a6:
        r7 = move-exception;
        goto L_0x004c;
    L_0x01a9:
        r7 = move-exception;
        if (r4 != 0) goto L_0x01b1;
    L_0x01ac:
        r9 = r13.mPolicy;	 Catch:{ all -> 0x0075 }
        r9.clear();	 Catch:{ all -> 0x0075 }
    L_0x01b1:
        r3.close();	 Catch:{ IOException -> 0x01b8 }
    L_0x01b4:
        throw r7;	 Catch:{ all -> 0x0075 }
    L_0x01b5:
        r7 = move-exception;
        goto L_0x004c;
    L_0x01b8:
        r9 = move-exception;
        goto L_0x01b4;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.AppOpsPolicy.readPolicy():void");
    }

    private void readDefaultPolicy(XmlPullParser parser, String packageName) throws NumberFormatException, XmlPullParserException, IOException {
        if ("user-app".equalsIgnoreCase(packageName) || "system-app".equalsIgnoreCase(packageName)) {
            int mode = AppOpsManager.stringToMode(parser.getAttributeValue(null, "permission"));
            int show = stringToControl(parser.getAttributeValue(null, "show"));
            if (mode != CONTROL_UNKNOWN || show != CONTROL_UNKNOWN) {
                PolicyPkg pkg = (PolicyPkg) this.mPolicy.get(packageName);
                if (pkg == null) {
                    this.mPolicy.put(packageName, new PolicyPkg(packageName, mode, show, packageName));
                    return;
                }
                Slog.w(TAG, "Duplicate policy found for package: " + packageName + " of type: " + packageName);
                pkg.mode = mode;
                pkg.show = show;
            }
        }
    }

    private void readApplicationPolicy(XmlPullParser parser) throws NumberFormatException, XmlPullParserException, IOException {
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == CONTROL_NOSHOW) {
                return;
            }
            if (type == 3 && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == 3 || type == 4)) {
                if (parser.getName().equals("pkg")) {
                    readPkgPolicy(parser);
                } else {
                    Slog.w(TAG, "Unknown element under <application>: " + parser.getName());
                    XmlUtils.skipCurrentTag(parser);
                }
            }
        }
    }

    private void readPkgPolicy(XmlPullParser parser) throws NumberFormatException, XmlPullParserException, IOException {
        String packageName = parser.getAttributeValue(null, "name");
        if (packageName != null) {
            String appType = parser.getAttributeValue(null, SoundModelContract.KEY_TYPE);
            if (appType != null) {
                int mode = AppOpsManager.stringToMode(parser.getAttributeValue(null, "permission"));
                int show = stringToControl(parser.getAttributeValue(null, "show"));
                String key = packageName + "." + appType;
                PolicyPkg pkg = (PolicyPkg) this.mPolicy.get(key);
                if (pkg == null) {
                    pkg = new PolicyPkg(packageName, mode, show, appType);
                    this.mPolicy.put(key, pkg);
                } else {
                    Slog.w(TAG, "Duplicate policy found for package: " + packageName + " of type: " + appType);
                    pkg.mode = mode;
                    pkg.show = show;
                }
                int outerDepth = parser.getDepth();
                while (true) {
                    int type = parser.next();
                    if (type == CONTROL_NOSHOW) {
                        return;
                    }
                    if (type == 3 && parser.getDepth() <= outerDepth) {
                        return;
                    }
                    if (!(type == 3 || type == 4)) {
                        if (parser.getName().equals("op")) {
                            readOpPolicy(parser, pkg);
                        } else {
                            Slog.w(TAG, "Unknown element under <pkg>: " + parser.getName());
                            XmlUtils.skipCurrentTag(parser);
                        }
                    }
                }
            }
        }
    }

    private void readOpPolicy(XmlPullParser parser, PolicyPkg pkg) throws NumberFormatException, XmlPullParserException, IOException {
        if (pkg != null) {
            String opName = parser.getAttributeValue(null, "name");
            if (opName == null) {
                Slog.w(TAG, "Op name is null");
                return;
            }
            int code = AppOpsManager.stringOpToOp(opName);
            if (code == -1) {
                Slog.w(TAG, "Unknown Op: " + opName);
                return;
            }
            int mode = AppOpsManager.stringToMode(parser.getAttributeValue(null, "permission"));
            int show = stringToControl(parser.getAttributeValue(null, "show"));
            if (mode != CONTROL_UNKNOWN || show != CONTROL_UNKNOWN) {
                PolicyOp op = (PolicyOp) pkg.get(code);
                if (op == null) {
                    pkg.put(code, new PolicyOp(code, mode, show));
                    return;
                }
                Slog.w(TAG, "Duplicate policy found for package: " + pkg.packageName + " type: " + pkg.type + " op: " + op.op);
                op.mode = mode;
                op.show = show;
            }
        }
    }

    void debugPoilcy() {
        for (Entry key : this.mPolicy.entrySet()) {
            PolicyPkg pkg = (PolicyPkg) this.mPolicy.get((String) key.getKey());
            if (pkg != null) {
                for (int i = CONTROL_SHOW; i < pkg.size(); i += CONTROL_NOSHOW) {
                    PolicyOp policyOp = (PolicyOp) pkg.valueAt(i);
                }
            }
        }
    }

    private String getAppType(String packageName) {
        if (this.mContext != null) {
            ApplicationInfo appInfo;
            try {
                appInfo = this.mContext.getPackageManager().getApplicationInfo(packageName, CONTROL_SHOW);
            } catch (NameNotFoundException e) {
                appInfo = null;
            }
            if (appInfo == null) {
                return null;
            }
            if ((appInfo.flags & CONTROL_NOSHOW) != 0) {
                return "system-app";
            }
            return "user-app";
        }
        Slog.e(TAG, "Context is null");
        return null;
    }

    public boolean isControlAllowed(int code, String packageName) {
        boolean isShow = true;
        int show = CONTROL_UNKNOWN;
        if (this.mPolicy == null) {
            return CONTROL_NOSHOW;
        }
        PolicyPkg pkg;
        String type = getAppType(packageName);
        if (type != null) {
            pkg = (PolicyPkg) this.mPolicy.get(type);
            if (!(pkg == null || pkg.show == CONTROL_UNKNOWN)) {
                show = pkg.show;
            }
        }
        String key = packageName;
        if (type != null) {
            key = key + "." + type;
        }
        pkg = (PolicyPkg) this.mPolicy.get(key);
        if (pkg != null) {
            if (pkg.show != CONTROL_UNKNOWN) {
                show = pkg.show;
            }
            PolicyOp op = (PolicyOp) pkg.get(code);
            if (!(op == null || op.show == CONTROL_UNKNOWN)) {
                show = op.show;
            }
        }
        if (show == CONTROL_NOSHOW) {
            isShow = DEBUG;
        }
        return isShow;
    }

    public int getDefualtMode(int code, String packageName) {
        int i = CONTROL_UNKNOWN;
        if (this.mPolicy == null) {
            return CONTROL_UNKNOWN;
        }
        PolicyPkg pkg;
        String type = getAppType(packageName);
        if (type != null) {
            pkg = (PolicyPkg) this.mPolicy.get(type);
            if (!(pkg == null || pkg.mode == CONTROL_UNKNOWN)) {
                i = pkg.mode;
            }
        }
        String key = packageName;
        if (type != null) {
            key = key + "." + type;
        }
        pkg = (PolicyPkg) this.mPolicy.get(key);
        if (pkg != null) {
            if (pkg.mode != CONTROL_UNKNOWN) {
                i = pkg.mode;
            }
            PolicyOp op = (PolicyOp) pkg.get(code);
            if (!(op == null || op.mode == CONTROL_UNKNOWN)) {
                i = op.mode;
            }
        }
        return i;
    }
}
