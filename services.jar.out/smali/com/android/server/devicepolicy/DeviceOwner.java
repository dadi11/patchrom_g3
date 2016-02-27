package com.android.server.devicepolicy;

import android.app.AppGlobals;
import android.content.ComponentName;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Environment;
import android.os.RemoteException;
import android.util.AtomicFile;
import android.util.Slog;
import android.util.Xml;
import com.android.internal.util.FastXmlSerializer;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.Set;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class DeviceOwner {
    private static final String ATTR_COMPONENT_NAME = "component";
    private static final String ATTR_NAME = "name";
    private static final String ATTR_PACKAGE = "package";
    private static final String ATTR_USERID = "userId";
    private static final String DEVICE_OWNER_XML = "device_owner.xml";
    private static final String TAG = "DevicePolicyManagerService";
    private static final String TAG_DEVICE_OWNER = "device-owner";
    private static final String TAG_PROFILE_OWNER = "profile-owner";
    private AtomicFile fileForWriting;
    private OwnerInfo mDeviceOwner;
    private InputStream mInputStreamForTest;
    private OutputStream mOutputStreamForTest;
    private final HashMap<Integer, OwnerInfo> mProfileOwners;

    static class OwnerInfo {
        public ComponentName admin;
        public String name;
        public String packageName;

        public OwnerInfo(String name, String packageName) {
            this.name = name;
            this.packageName = packageName;
            this.admin = new ComponentName(packageName, "");
        }

        public OwnerInfo(String name, ComponentName admin) {
            this.name = name;
            this.admin = admin;
            this.packageName = admin.getPackageName();
        }
    }

    private DeviceOwner() {
        this.mProfileOwners = new HashMap();
    }

    DeviceOwner(InputStream in, OutputStream out) {
        this.mProfileOwners = new HashMap();
        this.mInputStreamForTest = in;
        this.mOutputStreamForTest = out;
    }

    static DeviceOwner load() {
        DeviceOwner owner = new DeviceOwner();
        if (!new File(Environment.getSystemSecureDirectory(), DEVICE_OWNER_XML).exists()) {
            return null;
        }
        owner.readOwnerFile();
        return owner;
    }

    static DeviceOwner createWithDeviceOwner(String packageName, String ownerName) {
        DeviceOwner owner = new DeviceOwner();
        owner.mDeviceOwner = new OwnerInfo(ownerName, packageName);
        return owner;
    }

    static DeviceOwner createWithProfileOwner(String packageName, String ownerName, int userId) {
        DeviceOwner owner = new DeviceOwner();
        owner.mProfileOwners.put(Integer.valueOf(userId), new OwnerInfo(ownerName, packageName));
        return owner;
    }

    static DeviceOwner createWithProfileOwner(ComponentName admin, String ownerName, int userId) {
        DeviceOwner owner = new DeviceOwner();
        owner.mProfileOwners.put(Integer.valueOf(userId), new OwnerInfo(ownerName, admin));
        return owner;
    }

    String getDeviceOwnerPackageName() {
        return this.mDeviceOwner != null ? this.mDeviceOwner.packageName : null;
    }

    String getDeviceOwnerName() {
        return this.mDeviceOwner != null ? this.mDeviceOwner.name : null;
    }

    void setDeviceOwner(String packageName, String ownerName) {
        this.mDeviceOwner = new OwnerInfo(ownerName, packageName);
    }

    void clearDeviceOwner() {
        this.mDeviceOwner = null;
    }

    void setProfileOwner(String packageName, String ownerName, int userId) {
        this.mProfileOwners.put(Integer.valueOf(userId), new OwnerInfo(ownerName, packageName));
    }

    void setProfileOwner(ComponentName admin, String ownerName, int userId) {
        this.mProfileOwners.put(Integer.valueOf(userId), new OwnerInfo(ownerName, admin));
    }

    void removeProfileOwner(int userId) {
        this.mProfileOwners.remove(Integer.valueOf(userId));
    }

    String getProfileOwnerPackageName(int userId) {
        OwnerInfo profileOwner = (OwnerInfo) this.mProfileOwners.get(Integer.valueOf(userId));
        return profileOwner != null ? profileOwner.packageName : null;
    }

    ComponentName getProfileOwnerComponent(int userId) {
        OwnerInfo profileOwner = (OwnerInfo) this.mProfileOwners.get(Integer.valueOf(userId));
        return profileOwner != null ? profileOwner.admin : null;
    }

    String getProfileOwnerName(int userId) {
        OwnerInfo profileOwner = (OwnerInfo) this.mProfileOwners.get(Integer.valueOf(userId));
        return profileOwner != null ? profileOwner.name : null;
    }

    Set<Integer> getProfileOwnerKeys() {
        return this.mProfileOwners.keySet();
    }

    boolean hasDeviceOwner() {
        return this.mDeviceOwner != null;
    }

    static boolean isInstalled(String packageName, PackageManager pm) {
        try {
            PackageInfo pi = pm.getPackageInfo(packageName, 0);
            if (pi == null || pi.applicationInfo.flags == 0) {
                return false;
            }
            return true;
        } catch (NameNotFoundException e) {
            Slog.w(TAG, "Device Owner package " + packageName + " not installed.");
            return false;
        }
    }

    static boolean isInstalledForUser(String packageName, int userHandle) {
        try {
            PackageInfo pi = AppGlobals.getPackageManager().getPackageInfo(packageName, 0, userHandle);
            if (pi == null || pi.applicationInfo.flags == 0) {
                return false;
            }
            return true;
        } catch (RemoteException re) {
            throw new RuntimeException("Package manager has died", re);
        }
    }

    void readOwnerFile() {
        try {
            String tag;
            InputStream input = openRead();
            XmlPullParser parser = Xml.newPullParser();
            parser.setInput(input, StandardCharsets.UTF_8.name());
            while (true) {
                int type = parser.next();
                if (type == 1) {
                    input.close();
                    return;
                } else if (type == 2) {
                    tag = parser.getName();
                    if (!tag.equals(TAG_DEVICE_OWNER)) {
                        if (!tag.equals(TAG_PROFILE_OWNER)) {
                            break;
                        }
                        String profileOwnerPackageName = parser.getAttributeValue(null, ATTR_PACKAGE);
                        String profileOwnerName = parser.getAttributeValue(null, ATTR_NAME);
                        String profileOwnerComponentStr = parser.getAttributeValue(null, ATTR_COMPONENT_NAME);
                        int userId = Integer.parseInt(parser.getAttributeValue(null, ATTR_USERID));
                        OwnerInfo ownerInfo = null;
                        if (profileOwnerComponentStr != null) {
                            ComponentName admin = ComponentName.unflattenFromString(profileOwnerComponentStr);
                            if (admin != null) {
                                ownerInfo = new OwnerInfo(profileOwnerName, admin);
                            } else {
                                Slog.e(TAG, "Error parsing device-owner file. Bad component name " + profileOwnerComponentStr);
                            }
                        }
                        if (ownerInfo == null) {
                            ownerInfo = new OwnerInfo(profileOwnerName, profileOwnerPackageName);
                        }
                        this.mProfileOwners.put(Integer.valueOf(userId), ownerInfo);
                    } else {
                        this.mDeviceOwner = new OwnerInfo(parser.getAttributeValue(null, ATTR_NAME), parser.getAttributeValue(null, ATTR_PACKAGE));
                    }
                }
            }
            throw new XmlPullParserException("Unexpected tag in device owner file: " + tag);
        } catch (XmlPullParserException xppe) {
            Slog.e(TAG, "Error parsing device-owner file\n" + xppe);
        } catch (IOException ioe) {
            Slog.e(TAG, "IO Exception when reading device-owner file\n" + ioe);
        }
    }

    void writeOwnerFile() {
        synchronized (this) {
            writeOwnerFileLocked();
        }
    }

    private void writeOwnerFileLocked() {
        try {
            OutputStream outputStream = startWrite();
            XmlSerializer out = new FastXmlSerializer();
            out.setOutput(outputStream, StandardCharsets.UTF_8.name());
            out.startDocument(null, Boolean.valueOf(true));
            if (this.mDeviceOwner != null) {
                out.startTag(null, TAG_DEVICE_OWNER);
                out.attribute(null, ATTR_PACKAGE, this.mDeviceOwner.packageName);
                if (this.mDeviceOwner.name != null) {
                    out.attribute(null, ATTR_NAME, this.mDeviceOwner.name);
                }
                out.endTag(null, TAG_DEVICE_OWNER);
            }
            if (this.mProfileOwners.size() > 0) {
                for (Entry<Integer, OwnerInfo> owner : this.mProfileOwners.entrySet()) {
                    out.startTag(null, TAG_PROFILE_OWNER);
                    OwnerInfo ownerInfo = (OwnerInfo) owner.getValue();
                    out.attribute(null, ATTR_PACKAGE, ownerInfo.packageName);
                    out.attribute(null, ATTR_NAME, ownerInfo.name);
                    out.attribute(null, ATTR_USERID, Integer.toString(((Integer) owner.getKey()).intValue()));
                    if (ownerInfo.admin != null) {
                        out.attribute(null, ATTR_COMPONENT_NAME, ownerInfo.admin.flattenToString());
                    }
                    out.endTag(null, TAG_PROFILE_OWNER);
                }
            }
            out.endDocument();
            out.flush();
            finishWrite(outputStream);
        } catch (IOException ioe) {
            Slog.e(TAG, "IO Exception when writing device-owner file\n" + ioe);
        }
    }

    private InputStream openRead() throws IOException {
        if (this.mInputStreamForTest != null) {
            return this.mInputStreamForTest;
        }
        return new AtomicFile(new File(Environment.getSystemSecureDirectory(), DEVICE_OWNER_XML)).openRead();
    }

    private OutputStream startWrite() throws IOException {
        if (this.mOutputStreamForTest != null) {
            return this.mOutputStreamForTest;
        }
        this.fileForWriting = new AtomicFile(new File(Environment.getSystemSecureDirectory(), DEVICE_OWNER_XML));
        return this.fileForWriting.startWrite();
    }

    private void finishWrite(OutputStream stream) {
        if (this.fileForWriting != null) {
            this.fileForWriting.finishWrite((FileOutputStream) stream);
        }
    }
}
