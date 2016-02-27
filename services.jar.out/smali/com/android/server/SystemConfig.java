package com.android.server;

import android.app.ActivityManager;
import android.content.pm.FeatureInfo;
import android.os.Environment;
import android.os.Process;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.Slog;
import android.util.SparseArray;
import android.util.Xml;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.XmlUtils;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.Iterator;
import libcore.io.IoUtils;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

public class SystemConfig {
    static final String TAG = "SystemConfig";
    static SystemConfig sInstance;
    final ArraySet<String> mAllowInPowerSave;
    final ArrayMap<String, FeatureInfo> mAvailableFeatures;
    final ArraySet<String> mFixedImeApps;
    int[] mGlobalGids;
    final ArrayMap<String, PermissionEntry> mPermissions;
    final ArrayMap<String, String> mSharedLibraries;
    final SparseArray<ArraySet<String>> mSystemPermissions;
    final ArraySet<String> mUnavailableFeatures;

    public static final class PermissionEntry {
        public int[] gids;
        public final String name;

        PermissionEntry(String _name) {
            this.name = _name;
        }
    }

    public static SystemConfig getInstance() {
        SystemConfig systemConfig;
        synchronized (SystemConfig.class) {
            if (sInstance == null) {
                sInstance = new SystemConfig();
            }
            systemConfig = sInstance;
        }
        return systemConfig;
    }

    public int[] getGlobalGids() {
        return this.mGlobalGids;
    }

    public SparseArray<ArraySet<String>> getSystemPermissions() {
        return this.mSystemPermissions;
    }

    public ArrayMap<String, String> getSharedLibraries() {
        return this.mSharedLibraries;
    }

    public ArrayMap<String, FeatureInfo> getAvailableFeatures() {
        return this.mAvailableFeatures;
    }

    public ArrayMap<String, PermissionEntry> getPermissions() {
        return this.mPermissions;
    }

    public ArraySet<String> getAllowInPowerSave() {
        return this.mAllowInPowerSave;
    }

    public ArraySet<String> getFixedImeApps() {
        return this.mFixedImeApps;
    }

    SystemConfig() {
        this.mSystemPermissions = new SparseArray();
        this.mSharedLibraries = new ArrayMap();
        this.mAvailableFeatures = new ArrayMap();
        this.mUnavailableFeatures = new ArraySet();
        this.mPermissions = new ArrayMap();
        this.mAllowInPowerSave = new ArraySet();
        this.mFixedImeApps = new ArraySet();
        readPermissions(Environment.buildPath(Environment.getRootDirectory(), new String[]{"etc", "sysconfig"}), false);
        readPermissions(Environment.buildPath(Environment.getRootDirectory(), new String[]{"etc", "permissions"}), false);
        readPermissions(Environment.buildPath(Environment.getOemDirectory(), new String[]{"etc", "sysconfig"}), true);
        readPermissions(Environment.buildPath(Environment.getOemDirectory(), new String[]{"etc", "permissions"}), true);
    }

    void readPermissions(File libraryDir, boolean onlyFeatures) {
        if (libraryDir.exists() && libraryDir.isDirectory()) {
            if (libraryDir.canRead()) {
                File platformFile = null;
                for (File f : libraryDir.listFiles()) {
                    if (f.getPath().endsWith("etc/permissions/platform.xml")) {
                        platformFile = f;
                    } else if (!f.getPath().endsWith(".xml")) {
                        Slog.i(TAG, "Non-xml file " + f + " in " + libraryDir + " directory, ignoring");
                    } else if (f.canRead()) {
                        readPermissionsFromXml(f, onlyFeatures);
                    } else {
                        Slog.w(TAG, "Permissions library file " + f + " cannot be read");
                    }
                }
                if (platformFile != null) {
                    readPermissionsFromXml(platformFile, onlyFeatures);
                    return;
                }
                return;
            }
            Slog.w(TAG, "Directory " + libraryDir + " cannot be read");
        } else if (!onlyFeatures) {
            Slog.w(TAG, "No directory " + libraryDir + ", skipping");
        }
    }

    private void readPermissionsFromXml(File permFile, boolean onlyFeatures) {
        try {
            Reader fileReader = new FileReader(permFile);
            boolean lowRam = ActivityManager.isLowRamDeviceStatic();
            try {
                int type;
                XmlPullParser parser = Xml.newPullParser();
                parser.setInput(fileReader);
                while (true) {
                    type = parser.next();
                    if (type != 2) {
                        if (type == 1) {
                            break;
                        }
                    }
                    break;
                }
                if (type != 2) {
                    throw new XmlPullParserException("No start tag found");
                } else if (parser.getName().equals("permissions") || parser.getName().equals("config")) {
                    String fname;
                    while (true) {
                        XmlUtils.nextElement(parser);
                        if (parser.getEventType() == 1) {
                            break;
                        }
                        String name = parser.getName();
                        if (!"group".equals(name) || onlyFeatures) {
                            String perm;
                            if (!"permission".equals(name) || onlyFeatures) {
                                if (!"assign-permission".equals(name) || onlyFeatures) {
                                    if (!"library".equals(name) || onlyFeatures) {
                                        if ("feature".equals(name)) {
                                            boolean allowed;
                                            fname = parser.getAttributeValue(null, "name");
                                            if (lowRam) {
                                                allowed = !"true".equals(parser.getAttributeValue(null, "notLowRam"));
                                            } else {
                                                allowed = true;
                                            }
                                            if (fname == null) {
                                                Slog.w(TAG, "<feature> without name in " + permFile + " at " + parser.getPositionDescription());
                                            } else if (allowed) {
                                                FeatureInfo fi = new FeatureInfo();
                                                fi.name = fname;
                                                this.mAvailableFeatures.put(fname, fi);
                                            }
                                            XmlUtils.skipCurrentTag(parser);
                                        } else {
                                            if ("unavailable-feature".equals(name)) {
                                                fname = parser.getAttributeValue(null, "name");
                                                if (fname == null) {
                                                    Slog.w(TAG, "<unavailable-feature> without name in " + permFile + " at " + parser.getPositionDescription());
                                                } else {
                                                    this.mUnavailableFeatures.add(fname);
                                                }
                                                XmlUtils.skipCurrentTag(parser);
                                            } else {
                                                String pkgname;
                                                if (!"allow-in-power-save".equals(name) || onlyFeatures) {
                                                    if (!"fixed-ime-app".equals(name) || onlyFeatures) {
                                                        XmlUtils.skipCurrentTag(parser);
                                                    } else {
                                                        pkgname = parser.getAttributeValue(null, "package");
                                                        if (pkgname == null) {
                                                            Slog.w(TAG, "<fixed-ime-app> without package in " + permFile + " at " + parser.getPositionDescription());
                                                        } else {
                                                            this.mFixedImeApps.add(pkgname);
                                                        }
                                                        XmlUtils.skipCurrentTag(parser);
                                                    }
                                                } else {
                                                    pkgname = parser.getAttributeValue(null, "package");
                                                    if (pkgname == null) {
                                                        Slog.w(TAG, "<allow-in-power-save> without package in " + permFile + " at " + parser.getPositionDescription());
                                                    } else {
                                                        this.mAllowInPowerSave.add(pkgname);
                                                    }
                                                    XmlUtils.skipCurrentTag(parser);
                                                }
                                            }
                                        }
                                    } else {
                                        String lname = parser.getAttributeValue(null, "name");
                                        String lfile = parser.getAttributeValue(null, "file");
                                        if (lname == null) {
                                            Slog.w(TAG, "<library> without name in " + permFile + " at " + parser.getPositionDescription());
                                        } else if (lfile == null) {
                                            Slog.w(TAG, "<library> without file in " + permFile + " at " + parser.getPositionDescription());
                                        } else {
                                            this.mSharedLibraries.put(lname, lfile);
                                        }
                                        XmlUtils.skipCurrentTag(parser);
                                    }
                                } else {
                                    perm = parser.getAttributeValue(null, "name");
                                    if (perm == null) {
                                        Slog.w(TAG, "<assign-permission> without name in " + permFile + " at " + parser.getPositionDescription());
                                        XmlUtils.skipCurrentTag(parser);
                                    } else {
                                        String uidStr = parser.getAttributeValue(null, "uid");
                                        if (uidStr == null) {
                                            Slog.w(TAG, "<assign-permission> without uid in " + permFile + " at " + parser.getPositionDescription());
                                            XmlUtils.skipCurrentTag(parser);
                                        } else {
                                            int uid = Process.getUidForName(uidStr);
                                            if (uid < 0) {
                                                Slog.w(TAG, "<assign-permission> with unknown uid \"" + uidStr + "  in " + permFile + " at " + parser.getPositionDescription());
                                                XmlUtils.skipCurrentTag(parser);
                                            } else {
                                                perm = perm.intern();
                                                ArraySet<String> perms = (ArraySet) this.mSystemPermissions.get(uid);
                                                if (perms == null) {
                                                    perms = new ArraySet();
                                                    this.mSystemPermissions.put(uid, perms);
                                                }
                                                perms.add(perm);
                                                XmlUtils.skipCurrentTag(parser);
                                            }
                                        }
                                    }
                                }
                            } else {
                                perm = parser.getAttributeValue(null, "name");
                                if (perm == null) {
                                    Slog.w(TAG, "<permission> without name in " + permFile + " at " + parser.getPositionDescription());
                                    XmlUtils.skipCurrentTag(parser);
                                } else {
                                    readPermission(parser, perm.intern());
                                }
                            }
                        } else {
                            String gidStr = parser.getAttributeValue(null, "gid");
                            if (gidStr != null) {
                                this.mGlobalGids = ArrayUtils.appendInt(this.mGlobalGids, Process.getGidForName(gidStr));
                            } else {
                                Slog.w(TAG, "<group> without gid in " + permFile + " at " + parser.getPositionDescription());
                            }
                            XmlUtils.skipCurrentTag(parser);
                        }
                    }
                    Iterator i$ = this.mUnavailableFeatures.iterator();
                    while (i$.hasNext()) {
                        fname = (String) i$.next();
                        if (this.mAvailableFeatures.remove(fname) != null) {
                            Slog.d(TAG, "Removed unavailable feature " + fname);
                        }
                    }
                    Reader reader = fileReader;
                } else {
                    throw new XmlPullParserException("Unexpected start tag in " + permFile + ": found " + parser.getName() + ", expected 'permissions' or 'config'");
                }
            } catch (XmlPullParserException e) {
                Slog.w(TAG, "Got exception parsing permissions.", e);
            } catch (IOException e2) {
                Slog.w(TAG, "Got exception parsing permissions.", e2);
            } finally {
                IoUtils.closeQuietly(fileReader);
            }
        } catch (FileNotFoundException e3) {
            Slog.w(TAG, "Couldn't find or open permissions file " + permFile);
        }
    }

    void readPermission(XmlPullParser parser, String name) throws IOException, XmlPullParserException {
        name = name.intern();
        PermissionEntry perm = (PermissionEntry) this.mPermissions.get(name);
        if (perm == null) {
            perm = new PermissionEntry(name);
            this.mPermissions.put(name, perm);
        }
        int outerDepth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if (type == 1) {
                return;
            }
            if (type == 3 && parser.getDepth() <= outerDepth) {
                return;
            }
            if (!(type == 3 || type == 4)) {
                if ("group".equals(parser.getName())) {
                    String gidStr = parser.getAttributeValue(null, "gid");
                    if (gidStr != null) {
                        perm.gids = ArrayUtils.appendInt(perm.gids, Process.getGidForName(gidStr));
                    } else {
                        Slog.w(TAG, "<group> without gid at " + parser.getPositionDescription());
                    }
                }
                XmlUtils.skipCurrentTag(parser);
            }
        }
    }
}
