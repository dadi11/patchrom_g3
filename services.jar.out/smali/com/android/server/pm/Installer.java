package com.android.server.pm;

import android.content.Context;
import android.content.pm.PackageStats;
import android.os.Build;
import android.util.Slog;
import com.android.internal.os.InstallerConnection;
import com.android.server.SystemService;
import dalvik.system.VMRuntime;

public final class Installer extends SystemService {
    private static final String TAG = "Installer";
    private final InstallerConnection mInstaller;

    public Installer(Context context) {
        super(context);
        this.mInstaller = new InstallerConnection();
    }

    public void onStart() {
        Slog.i(TAG, "Waiting for installd to be ready.");
        ping();
    }

    public int install(String name, int uid, int gid, String seinfo) {
        StringBuilder builder = new StringBuilder("install");
        builder.append(' ');
        builder.append(name);
        builder.append(' ');
        builder.append(uid);
        builder.append(' ');
        builder.append(gid);
        builder.append(' ');
        if (seinfo == null) {
            seinfo = "!";
        }
        builder.append(seinfo);
        return this.mInstaller.execute(builder.toString());
    }

    public int patchoat(String apkPath, int uid, boolean isPublic, String pkgName, String instructionSet) {
        if (isValidInstructionSet(instructionSet)) {
            return this.mInstaller.patchoat(apkPath, uid, isPublic, pkgName, instructionSet);
        }
        Slog.e(TAG, "Invalid instruction set: " + instructionSet);
        return -1;
    }

    public int patchoat(String apkPath, int uid, boolean isPublic, String instructionSet) {
        if (isValidInstructionSet(instructionSet)) {
            return this.mInstaller.patchoat(apkPath, uid, isPublic, instructionSet);
        }
        Slog.e(TAG, "Invalid instruction set: " + instructionSet);
        return -1;
    }

    public int dexopt(String apkPath, int uid, boolean isPublic, String instructionSet) {
        if (isValidInstructionSet(instructionSet)) {
            return this.mInstaller.dexopt(apkPath, uid, isPublic, instructionSet);
        }
        Slog.e(TAG, "Invalid instruction set: " + instructionSet);
        return -1;
    }

    public int dexopt(String apkPath, int uid, boolean isPublic, String pkgName, String instructionSet, boolean vmSafeMode) {
        if (isValidInstructionSet(instructionSet)) {
            return this.mInstaller.dexopt(apkPath, uid, isPublic, pkgName, instructionSet, vmSafeMode);
        }
        Slog.e(TAG, "Invalid instruction set: " + instructionSet);
        return -1;
    }

    public int idmap(String targetApkPath, String overlayApkPath, int uid) {
        StringBuilder builder = new StringBuilder("idmap");
        builder.append(' ');
        builder.append(targetApkPath);
        builder.append(' ');
        builder.append(overlayApkPath);
        builder.append(' ');
        builder.append(uid);
        return this.mInstaller.execute(builder.toString());
    }

    public int movedex(String srcPath, String dstPath, String instructionSet) {
        if (isValidInstructionSet(instructionSet)) {
            StringBuilder builder = new StringBuilder("movedex");
            builder.append(' ');
            builder.append(srcPath);
            builder.append(' ');
            builder.append(dstPath);
            builder.append(' ');
            builder.append(instructionSet);
            return this.mInstaller.execute(builder.toString());
        }
        Slog.e(TAG, "Invalid instruction set: " + instructionSet);
        return -1;
    }

    public int rmdex(String codePath, String instructionSet) {
        if (isValidInstructionSet(instructionSet)) {
            StringBuilder builder = new StringBuilder("rmdex");
            builder.append(' ');
            builder.append(codePath);
            builder.append(' ');
            builder.append(instructionSet);
            return this.mInstaller.execute(builder.toString());
        }
        Slog.e(TAG, "Invalid instruction set: " + instructionSet);
        return -1;
    }

    public int remove(String name, int userId) {
        StringBuilder builder = new StringBuilder("remove");
        builder.append(' ');
        builder.append(name);
        builder.append(' ');
        builder.append(userId);
        return this.mInstaller.execute(builder.toString());
    }

    public int rename(String oldname, String newname) {
        StringBuilder builder = new StringBuilder("rename");
        builder.append(' ');
        builder.append(oldname);
        builder.append(' ');
        builder.append(newname);
        return this.mInstaller.execute(builder.toString());
    }

    public int fixUid(String name, int uid, int gid) {
        StringBuilder builder = new StringBuilder("fixuid");
        builder.append(' ');
        builder.append(name);
        builder.append(' ');
        builder.append(uid);
        builder.append(' ');
        builder.append(gid);
        return this.mInstaller.execute(builder.toString());
    }

    public int deleteCacheFiles(String name, int userId) {
        StringBuilder builder = new StringBuilder("rmcache");
        builder.append(' ');
        builder.append(name);
        builder.append(' ');
        builder.append(userId);
        return this.mInstaller.execute(builder.toString());
    }

    public int deleteCodeCacheFiles(String name, int userId) {
        StringBuilder builder = new StringBuilder("rmcodecache");
        builder.append(' ');
        builder.append(name);
        builder.append(' ');
        builder.append(userId);
        return this.mInstaller.execute(builder.toString());
    }

    public int createUserData(String name, int uid, int userId, String seinfo) {
        StringBuilder builder = new StringBuilder("mkuserdata");
        builder.append(' ');
        builder.append(name);
        builder.append(' ');
        builder.append(uid);
        builder.append(' ');
        builder.append(userId);
        builder.append(' ');
        if (seinfo == null) {
            seinfo = "!";
        }
        builder.append(seinfo);
        return this.mInstaller.execute(builder.toString());
    }

    public int createUserConfig(int userId) {
        StringBuilder builder = new StringBuilder("mkuserconfig");
        builder.append(' ');
        builder.append(userId);
        return this.mInstaller.execute(builder.toString());
    }

    public int removeUserDataDirs(int userId) {
        StringBuilder builder = new StringBuilder("rmuser");
        builder.append(' ');
        builder.append(userId);
        return this.mInstaller.execute(builder.toString());
    }

    public int clearUserData(String name, int userId) {
        StringBuilder builder = new StringBuilder("rmuserdata");
        builder.append(' ');
        builder.append(name);
        builder.append(' ');
        builder.append(userId);
        return this.mInstaller.execute(builder.toString());
    }

    public int markBootComplete(String instructionSet) {
        if (isValidInstructionSet(instructionSet)) {
            StringBuilder builder = new StringBuilder("markbootcomplete");
            builder.append(' ');
            builder.append(instructionSet);
            return this.mInstaller.execute(builder.toString());
        }
        Slog.e(TAG, "Invalid instruction set: " + instructionSet);
        return -1;
    }

    public boolean ping() {
        if (this.mInstaller.execute("ping") < 0) {
            return false;
        }
        return true;
    }

    public int freeCache(long freeStorageSize) {
        StringBuilder builder = new StringBuilder("freecache");
        builder.append(' ');
        builder.append(String.valueOf(freeStorageSize));
        return this.mInstaller.execute(builder.toString());
    }

    public int getSizeInfo(String pkgName, int persona, String apkPath, String libDirPath, String fwdLockApkPath, String asecPath, String[] instructionSets, PackageStats pStats) {
        String[] arr$ = instructionSets;
        int len$ = arr$.length;
        int i$ = 0;
        while (i$ < len$) {
            String instructionSet = arr$[i$];
            if (isValidInstructionSet(instructionSet)) {
                i$++;
            } else {
                Slog.e(TAG, "Invalid instruction set: " + instructionSet);
                return -1;
            }
        }
        StringBuilder builder = new StringBuilder("getsize");
        builder.append(' ');
        builder.append(pkgName);
        builder.append(' ');
        builder.append(persona);
        builder.append(' ');
        builder.append(apkPath);
        builder.append(' ');
        if (libDirPath == null) {
            libDirPath = "!";
        }
        builder.append(libDirPath);
        builder.append(' ');
        if (fwdLockApkPath == null) {
            fwdLockApkPath = "!";
        }
        builder.append(fwdLockApkPath);
        builder.append(' ');
        if (asecPath == null) {
            asecPath = "!";
        }
        builder.append(asecPath);
        builder.append(' ');
        builder.append(instructionSets[0]);
        String[] res = this.mInstaller.transact(builder.toString()).split(" ");
        if (res == null || res.length != 5) {
            return -1;
        }
        try {
            pStats.codeSize = Long.parseLong(res[1]);
            pStats.dataSize = Long.parseLong(res[2]);
            pStats.cacheSize = Long.parseLong(res[3]);
            pStats.externalCodeSize = Long.parseLong(res[4]);
            return Integer.parseInt(res[0]);
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    public int moveFiles() {
        return this.mInstaller.execute("movefiles");
    }

    public int linkNativeLibraryDirectory(String dataPath, String nativeLibPath32, int userId) {
        if (dataPath == null) {
            Slog.e(TAG, "linkNativeLibraryDirectory dataPath is null");
            return -1;
        } else if (nativeLibPath32 == null) {
            Slog.e(TAG, "linkNativeLibraryDirectory nativeLibPath is null");
            return -1;
        } else {
            StringBuilder builder = new StringBuilder("linklib ");
            builder.append(dataPath);
            builder.append(' ');
            builder.append(nativeLibPath32);
            builder.append(' ');
            builder.append(userId);
            return this.mInstaller.execute(builder.toString());
        }
    }

    public boolean restoreconData(String pkgName, String seinfo, int uid) {
        StringBuilder builder = new StringBuilder("restorecondata");
        builder.append(' ');
        builder.append(pkgName);
        builder.append(' ');
        if (seinfo == null) {
            seinfo = "!";
        }
        builder.append(seinfo);
        builder.append(' ');
        builder.append(uid);
        return this.mInstaller.execute(builder.toString()) == 0;
    }

    private static boolean isValidInstructionSet(String instructionSet) {
        if (instructionSet == null) {
            return false;
        }
        for (String abi : Build.SUPPORTED_ABIS) {
            if (instructionSet.equals(VMRuntime.getInstructionSet(abi))) {
                return true;
            }
        }
        return false;
    }
}
