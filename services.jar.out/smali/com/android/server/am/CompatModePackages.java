package com.android.server.am;

import android.app.AppGlobals;
import android.content.pm.ApplicationInfo;
import android.content.pm.IPackageManager;
import android.content.res.CompatibilityInfo;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.util.AtomicFile;
import android.util.Slog;
import android.util.Xml;
import com.android.internal.util.FastXmlSerializer;
import com.android.server.wm.AppTransition;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map.Entry;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public final class CompatModePackages {
    public static final int COMPAT_FLAG_DONT_ASK = 1;
    public static final int COMPAT_FLAG_ENABLED = 2;
    private static final int MSG_WRITE = 300;
    private final boolean DEBUG_CONFIGURATION;
    private final String TAG;
    private final AtomicFile mFile;
    private final CompatHandler mHandler;
    private final HashMap<String, Integer> mPackages;
    private final ActivityManagerService mService;

    private final class CompatHandler extends Handler {
        public CompatHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case CompatModePackages.MSG_WRITE /*300*/:
                    CompatModePackages.this.saveCompatModes();
                default:
            }
        }
    }

    public CompatModePackages(ActivityManagerService service, File systemDir, Handler handler) {
        this.TAG = "ActivityManager";
        this.DEBUG_CONFIGURATION = false;
        this.mPackages = new HashMap();
        this.mService = service;
        this.mFile = new AtomicFile(new File(systemDir, "packages-compat.xml"));
        this.mHandler = new CompatHandler(handler.getLooper());
        FileInputStream fis = null;
        try {
            fis = this.mFile.openRead();
            XmlPullParser parser = Xml.newPullParser();
            parser.setInput(fis, StandardCharsets.UTF_8.name());
            int eventType = parser.getEventType();
            while (eventType != COMPAT_FLAG_ENABLED && eventType != COMPAT_FLAG_DONT_ASK) {
                eventType = parser.next();
            }
            if (eventType != COMPAT_FLAG_DONT_ASK) {
                if ("compat-packages".equals(parser.getName())) {
                    eventType = parser.next();
                    do {
                        if (eventType == COMPAT_FLAG_ENABLED) {
                            String tagName = parser.getName();
                            if (parser.getDepth() == COMPAT_FLAG_ENABLED && "pkg".equals(tagName)) {
                                String pkg = parser.getAttributeValue(null, "name");
                                if (pkg != null) {
                                    String mode = parser.getAttributeValue(null, "mode");
                                    int modeInt = 0;
                                    if (mode != null) {
                                        try {
                                            modeInt = Integer.parseInt(mode);
                                        } catch (NumberFormatException e) {
                                        }
                                    }
                                    this.mPackages.put(pkg, Integer.valueOf(modeInt));
                                }
                            }
                        }
                        eventType = parser.next();
                    } while (eventType != COMPAT_FLAG_DONT_ASK);
                }
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e2) {
                    }
                }
            } else if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e3) {
                }
            }
        } catch (XmlPullParserException e4) {
            Slog.w("ActivityManager", "Error reading compat-packages", e4);
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e5) {
                }
            }
        } catch (IOException e6) {
            if (fis != null) {
                Slog.w("ActivityManager", "Error reading compat-packages", e6);
            }
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e7) {
                }
            }
        } catch (Throwable th) {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e8) {
                }
            }
        }
    }

    public HashMap<String, Integer> getPackages() {
        return this.mPackages;
    }

    private int getPackageFlags(String packageName) {
        Integer flags = (Integer) this.mPackages.get(packageName);
        return flags != null ? flags.intValue() : 0;
    }

    public void handlePackageAddedLocked(String packageName, boolean updated) {
        boolean mayCompat = false;
        ApplicationInfo ai = null;
        try {
            ai = AppGlobals.getPackageManager().getApplicationInfo(packageName, 0, 0);
        } catch (RemoteException e) {
        }
        if (ai != null) {
            CompatibilityInfo ci = compatibilityInfoForPackageLocked(ai);
            if (!(ci.alwaysSupportsScreen() || ci.neverSupportsScreen())) {
                mayCompat = true;
            }
            if (updated && !mayCompat && this.mPackages.containsKey(packageName)) {
                this.mPackages.remove(packageName);
                this.mHandler.removeMessages(MSG_WRITE);
                this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(MSG_WRITE), 10000);
            }
        }
    }

    public CompatibilityInfo compatibilityInfoForPackageLocked(ApplicationInfo ai) {
        return new CompatibilityInfo(ai, this.mService.mConfiguration.screenLayout, this.mService.mConfiguration.smallestScreenWidthDp, (getPackageFlags(ai.packageName) & COMPAT_FLAG_ENABLED) != 0);
    }

    public int computeCompatModeLocked(ApplicationInfo ai) {
        boolean enabled;
        if ((getPackageFlags(ai.packageName) & COMPAT_FLAG_ENABLED) != 0) {
            enabled = true;
        } else {
            enabled = false;
        }
        CompatibilityInfo info = new CompatibilityInfo(ai, this.mService.mConfiguration.screenLayout, this.mService.mConfiguration.smallestScreenWidthDp, enabled);
        if (info.alwaysSupportsScreen()) {
            return -2;
        }
        if (info.neverSupportsScreen()) {
            return -1;
        }
        if (enabled) {
            return COMPAT_FLAG_DONT_ASK;
        }
        return 0;
    }

    public boolean getFrontActivityAskCompatModeLocked() {
        ActivityRecord r = this.mService.getFocusedStack().topRunningActivityLocked(null);
        if (r == null) {
            return false;
        }
        return getPackageAskCompatModeLocked(r.packageName);
    }

    public boolean getPackageAskCompatModeLocked(String packageName) {
        return (getPackageFlags(packageName) & COMPAT_FLAG_DONT_ASK) == 0;
    }

    public void setFrontActivityAskCompatModeLocked(boolean ask) {
        ActivityRecord r = this.mService.getFocusedStack().topRunningActivityLocked(null);
        if (r != null) {
            setPackageAskCompatModeLocked(r.packageName, ask);
        }
    }

    public void setPackageAskCompatModeLocked(String packageName, boolean ask) {
        int curFlags = getPackageFlags(packageName);
        int newFlags = ask ? curFlags & -2 : curFlags | COMPAT_FLAG_DONT_ASK;
        if (curFlags != newFlags) {
            if (newFlags != 0) {
                this.mPackages.put(packageName, Integer.valueOf(newFlags));
            } else {
                this.mPackages.remove(packageName);
            }
            this.mHandler.removeMessages(MSG_WRITE);
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(MSG_WRITE), 10000);
        }
    }

    public int getFrontActivityScreenCompatModeLocked() {
        ActivityRecord r = this.mService.getFocusedStack().topRunningActivityLocked(null);
        if (r == null) {
            return -3;
        }
        return computeCompatModeLocked(r.info.applicationInfo);
    }

    public void setFrontActivityScreenCompatModeLocked(int mode) {
        ActivityRecord r = this.mService.getFocusedStack().topRunningActivityLocked(null);
        if (r == null) {
            Slog.w("ActivityManager", "setFrontActivityScreenCompatMode failed: no top activity");
        } else {
            setPackageScreenCompatModeLocked(r.info.applicationInfo, mode);
        }
    }

    public int getPackageScreenCompatModeLocked(String packageName) {
        ApplicationInfo ai = null;
        try {
            ai = AppGlobals.getPackageManager().getApplicationInfo(packageName, 0, 0);
        } catch (RemoteException e) {
        }
        if (ai == null) {
            return -3;
        }
        return computeCompatModeLocked(ai);
    }

    public void setPackageScreenCompatModeLocked(String packageName, int mode) {
        ApplicationInfo ai = null;
        try {
            ai = AppGlobals.getPackageManager().getApplicationInfo(packageName, 0, 0);
        } catch (RemoteException e) {
        }
        if (ai == null) {
            Slog.w("ActivityManager", "setPackageScreenCompatMode failed: unknown package " + packageName);
        } else {
            setPackageScreenCompatModeLocked(ai, mode);
        }
    }

    private void setPackageScreenCompatModeLocked(ApplicationInfo ai, int mode) {
        boolean enable;
        String packageName = ai.packageName;
        int curFlags = getPackageFlags(packageName);
        switch (mode) {
            case AppTransition.TRANSIT_NONE /*0*/:
                enable = false;
                break;
            case COMPAT_FLAG_DONT_ASK /*1*/:
                enable = true;
                break;
            case COMPAT_FLAG_ENABLED /*2*/:
                enable = (curFlags & COMPAT_FLAG_ENABLED) == 0;
                break;
            default:
                Slog.w("ActivityManager", "Unknown screen compat mode req #" + mode + "; ignoring");
                return;
        }
        int newFlags = curFlags;
        if (enable) {
            newFlags |= COMPAT_FLAG_ENABLED;
        } else {
            newFlags &= -3;
        }
        CompatibilityInfo ci = compatibilityInfoForPackageLocked(ai);
        if (ci.alwaysSupportsScreen()) {
            Slog.w("ActivityManager", "Ignoring compat mode change of " + packageName + "; compatibility never needed");
            newFlags = 0;
        }
        if (ci.neverSupportsScreen()) {
            Slog.w("ActivityManager", "Ignoring compat mode change of " + packageName + "; compatibility always needed");
            newFlags = 0;
        }
        if (newFlags != curFlags) {
            if (newFlags != 0) {
                this.mPackages.put(packageName, Integer.valueOf(newFlags));
            } else {
                this.mPackages.remove(packageName);
            }
            ci = compatibilityInfoForPackageLocked(ai);
            this.mHandler.removeMessages(MSG_WRITE);
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(MSG_WRITE), 10000);
            ActivityStack stack = this.mService.getFocusedStack();
            ActivityRecord starting = stack.restartPackage(packageName);
            for (int i = this.mService.mLruProcesses.size() - 1; i >= 0; i--) {
                ProcessRecord app = (ProcessRecord) this.mService.mLruProcesses.get(i);
                if (app.pkgList.containsKey(packageName)) {
                    try {
                        if (app.thread != null) {
                            app.thread.updatePackageCompatibilityInfo(packageName, ci);
                        }
                    } catch (Exception e) {
                    }
                }
            }
            if (starting != null) {
                stack.ensureActivityConfigurationLocked(starting, 0);
                stack.ensureActivitiesVisibleLocked(starting, 0);
            }
        }
    }

    void saveCompatModes() {
        synchronized (this.mService) {
            HashMap<String, Integer> pkgs = new HashMap(this.mPackages);
        }
        FileOutputStream fos = null;
        try {
            fos = this.mFile.startWrite();
            XmlSerializer out = new FastXmlSerializer();
            out.setOutput(fos, StandardCharsets.UTF_8.name());
            out.startDocument(null, Boolean.valueOf(true));
            out.setFeature("http://xmlpull.org/v1/doc/features.html#indent-output", true);
            out.startTag(null, "compat-packages");
            IPackageManager pm = AppGlobals.getPackageManager();
            int screenLayout = this.mService.mConfiguration.screenLayout;
            int smallestScreenWidthDp = this.mService.mConfiguration.smallestScreenWidthDp;
            for (Entry<String, Integer> entry : pkgs.entrySet()) {
                String pkg = (String) entry.getKey();
                int mode = ((Integer) entry.getValue()).intValue();
                if (mode != 0) {
                    ApplicationInfo ai = null;
                    try {
                        ai = pm.getApplicationInfo(pkg, 0, 0);
                    } catch (RemoteException e) {
                    }
                    if (ai != null) {
                        CompatibilityInfo info = new CompatibilityInfo(ai, screenLayout, smallestScreenWidthDp, false);
                        if (!(info.alwaysSupportsScreen() || info.neverSupportsScreen())) {
                            out.startTag(null, "pkg");
                            out.attribute(null, "name", pkg);
                            out.attribute(null, "mode", Integer.toString(mode));
                            out.endTag(null, "pkg");
                        }
                    } else {
                        continue;
                    }
                }
            }
            out.endTag(null, "compat-packages");
            out.endDocument();
            this.mFile.finishWrite(fos);
        } catch (IOException e1) {
            Slog.w("ActivityManager", "Error writing compat packages", e1);
            if (fos != null) {
                this.mFile.failWrite(fos);
            }
        }
    }
}
