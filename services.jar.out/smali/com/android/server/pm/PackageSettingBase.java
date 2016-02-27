package com.android.server.pm;

import android.content.pm.PackageUserState;
import android.util.ArraySet;
import android.util.SparseArray;
import java.io.File;

class PackageSettingBase extends GrantedPermissions {
    private static final PackageUserState DEFAULT_USER_STATE;
    static final int PKG_INSTALL_COMPLETE = 1;
    static final int PKG_INSTALL_INCOMPLETE = 0;
    File codePath;
    String codePathString;
    String cpuAbiOverrideString;
    long firstInstallTime;
    boolean haveGids;
    int installStatus;
    String installerPackageName;
    PackageKeySetData keySetData;
    long lastUpdateTime;
    @Deprecated
    String legacyNativeLibraryPathString;
    final String name;
    PackageSettingBase origPackage;
    boolean permissionsFixed;
    String primaryCpuAbiString;
    final String realName;
    File resourcePath;
    String resourcePathString;
    String secondaryCpuAbiString;
    PackageSignatures signatures;
    long timeStamp;
    boolean uidError;
    private final SparseArray<PackageUserState> userState;
    int versionCode;

    static {
        DEFAULT_USER_STATE = new PackageUserState();
    }

    PackageSettingBase(String name, String realName, File codePath, File resourcePath, String legacyNativeLibraryPathString, String primaryCpuAbiString, String secondaryCpuAbiString, String cpuAbiOverrideString, int pVersionCode, int pkgFlags) {
        super(pkgFlags);
        this.signatures = new PackageSignatures();
        this.keySetData = new PackageKeySetData();
        this.userState = new SparseArray();
        this.installStatus = PKG_INSTALL_COMPLETE;
        this.name = name;
        this.realName = realName;
        init(codePath, resourcePath, legacyNativeLibraryPathString, primaryCpuAbiString, secondaryCpuAbiString, cpuAbiOverrideString, pVersionCode);
    }

    PackageSettingBase(PackageSettingBase base) {
        super((GrantedPermissions) base);
        this.signatures = new PackageSignatures();
        this.keySetData = new PackageKeySetData();
        this.userState = new SparseArray();
        this.installStatus = PKG_INSTALL_COMPLETE;
        this.name = base.name;
        this.realName = base.realName;
        this.codePath = base.codePath;
        this.codePathString = base.codePathString;
        this.resourcePath = base.resourcePath;
        this.resourcePathString = base.resourcePathString;
        this.legacyNativeLibraryPathString = base.legacyNativeLibraryPathString;
        this.primaryCpuAbiString = base.primaryCpuAbiString;
        this.secondaryCpuAbiString = base.secondaryCpuAbiString;
        this.cpuAbiOverrideString = base.cpuAbiOverrideString;
        this.timeStamp = base.timeStamp;
        this.firstInstallTime = base.firstInstallTime;
        this.lastUpdateTime = base.lastUpdateTime;
        this.versionCode = base.versionCode;
        this.uidError = base.uidError;
        this.signatures = new PackageSignatures(base.signatures);
        this.permissionsFixed = base.permissionsFixed;
        this.haveGids = base.haveGids;
        this.userState.clear();
        for (int i = 0; i < base.userState.size(); i += PKG_INSTALL_COMPLETE) {
            this.userState.put(base.userState.keyAt(i), new PackageUserState((PackageUserState) base.userState.valueAt(i)));
        }
        this.installStatus = base.installStatus;
        this.origPackage = base.origPackage;
        this.installerPackageName = base.installerPackageName;
        this.keySetData = new PackageKeySetData(base.keySetData);
    }

    void init(File codePath, File resourcePath, String legacyNativeLibraryPathString, String primaryCpuAbiString, String secondaryCpuAbiString, String cpuAbiOverrideString, int pVersionCode) {
        this.codePath = codePath;
        this.codePathString = codePath.toString();
        this.resourcePath = resourcePath;
        this.resourcePathString = resourcePath.toString();
        this.legacyNativeLibraryPathString = legacyNativeLibraryPathString;
        this.primaryCpuAbiString = primaryCpuAbiString;
        this.secondaryCpuAbiString = secondaryCpuAbiString;
        this.cpuAbiOverrideString = cpuAbiOverrideString;
        this.versionCode = pVersionCode;
    }

    public void setInstallerPackageName(String packageName) {
        this.installerPackageName = packageName;
    }

    String getInstallerPackageName() {
        return this.installerPackageName;
    }

    public void setInstallStatus(int newStatus) {
        this.installStatus = newStatus;
    }

    public int getInstallStatus() {
        return this.installStatus;
    }

    public void setTimeStamp(long newStamp) {
        this.timeStamp = newStamp;
    }

    public void copyFrom(PackageSettingBase base) {
        this.grantedPermissions = base.grantedPermissions;
        this.gids = base.gids;
        this.primaryCpuAbiString = base.primaryCpuAbiString;
        this.secondaryCpuAbiString = base.secondaryCpuAbiString;
        this.cpuAbiOverrideString = base.cpuAbiOverrideString;
        this.timeStamp = base.timeStamp;
        this.firstInstallTime = base.firstInstallTime;
        this.lastUpdateTime = base.lastUpdateTime;
        this.signatures = base.signatures;
        this.permissionsFixed = base.permissionsFixed;
        this.haveGids = base.haveGids;
        this.userState.clear();
        for (int i = 0; i < base.userState.size(); i += PKG_INSTALL_COMPLETE) {
            this.userState.put(base.userState.keyAt(i), base.userState.valueAt(i));
        }
        this.installStatus = base.installStatus;
        this.keySetData = base.keySetData;
    }

    private PackageUserState modifyUserState(int userId) {
        PackageUserState state = (PackageUserState) this.userState.get(userId);
        if (state != null) {
            return state;
        }
        state = new PackageUserState();
        this.userState.put(userId, state);
        return state;
    }

    public PackageUserState readUserState(int userId) {
        PackageUserState state = (PackageUserState) this.userState.get(userId);
        return state != null ? state : DEFAULT_USER_STATE;
    }

    void setEnabled(int state, int userId, String callingPackage) {
        PackageUserState st = modifyUserState(userId);
        st.enabled = state;
        st.lastDisableAppCaller = callingPackage;
    }

    int getEnabled(int userId) {
        return readUserState(userId).enabled;
    }

    String getLastDisabledAppCaller(int userId) {
        return readUserState(userId).lastDisableAppCaller;
    }

    void setInstalled(boolean inst, int userId) {
        modifyUserState(userId).installed = inst;
    }

    boolean getInstalled(int userId) {
        return readUserState(userId).installed;
    }

    boolean isAnyInstalled(int[] users) {
        int[] arr$ = users;
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += PKG_INSTALL_COMPLETE) {
            if (readUserState(arr$[i$]).installed) {
                return true;
            }
        }
        return false;
    }

    int[] queryInstalledUsers(int[] users, boolean installed) {
        int i$;
        int num = 0;
        int[] arr$ = users;
        int len$ = arr$.length;
        for (i$ = 0; i$ < len$; i$ += PKG_INSTALL_COMPLETE) {
            if (getInstalled(arr$[i$]) == installed) {
                num += PKG_INSTALL_COMPLETE;
            }
        }
        int[] res = new int[num];
        num = 0;
        arr$ = users;
        len$ = arr$.length;
        for (i$ = 0; i$ < len$; i$ += PKG_INSTALL_COMPLETE) {
            int user = arr$[i$];
            if (getInstalled(user) == installed) {
                res[num] = user;
                num += PKG_INSTALL_COMPLETE;
            }
        }
        return res;
    }

    boolean getStopped(int userId) {
        return readUserState(userId).stopped;
    }

    void setStopped(boolean stop, int userId) {
        modifyUserState(userId).stopped = stop;
    }

    boolean getNotLaunched(int userId) {
        return readUserState(userId).notLaunched;
    }

    void setNotLaunched(boolean stop, int userId) {
        modifyUserState(userId).notLaunched = stop;
    }

    boolean getHidden(int userId) {
        return readUserState(userId).hidden;
    }

    void setHidden(boolean hidden, int userId) {
        modifyUserState(userId).hidden = hidden;
    }

    boolean getBlockUninstall(int userId) {
        return readUserState(userId).blockUninstall;
    }

    void setBlockUninstall(boolean blockUninstall, int userId) {
        modifyUserState(userId).blockUninstall = blockUninstall;
    }

    void setUserState(int userId, int enabled, boolean installed, boolean stopped, boolean notLaunched, boolean hidden, String lastDisableAppCaller, ArraySet<String> enabledComponents, ArraySet<String> disabledComponents, boolean blockUninstall) {
        PackageUserState state = modifyUserState(userId);
        state.enabled = enabled;
        state.installed = installed;
        state.stopped = stopped;
        state.notLaunched = notLaunched;
        state.hidden = hidden;
        state.lastDisableAppCaller = lastDisableAppCaller;
        state.enabledComponents = enabledComponents;
        state.disabledComponents = disabledComponents;
        state.blockUninstall = blockUninstall;
    }

    ArraySet<String> getEnabledComponents(int userId) {
        return readUserState(userId).enabledComponents;
    }

    ArraySet<String> getDisabledComponents(int userId) {
        return readUserState(userId).disabledComponents;
    }

    void setEnabledComponents(ArraySet<String> components, int userId) {
        modifyUserState(userId).enabledComponents = components;
    }

    void setDisabledComponents(ArraySet<String> components, int userId) {
        modifyUserState(userId).disabledComponents = components;
    }

    void setEnabledComponentsCopy(ArraySet<String> components, int userId) {
        modifyUserState(userId).enabledComponents = components != null ? new ArraySet(components) : null;
    }

    void setDisabledComponentsCopy(ArraySet<String> components, int userId) {
        modifyUserState(userId).disabledComponents = components != null ? new ArraySet(components) : null;
    }

    PackageUserState modifyUserStateComponents(int userId, boolean disabled, boolean enabled) {
        PackageUserState state = modifyUserState(userId);
        if (disabled && state.disabledComponents == null) {
            state.disabledComponents = new ArraySet(PKG_INSTALL_COMPLETE);
        }
        if (enabled && state.enabledComponents == null) {
            state.enabledComponents = new ArraySet(PKG_INSTALL_COMPLETE);
        }
        return state;
    }

    void addDisabledComponent(String componentClassName, int userId) {
        modifyUserStateComponents(userId, true, false).disabledComponents.add(componentClassName);
    }

    void addEnabledComponent(String componentClassName, int userId) {
        modifyUserStateComponents(userId, false, true).enabledComponents.add(componentClassName);
    }

    boolean enableComponentLPw(String componentClassName, int userId) {
        boolean changed = false;
        PackageUserState state = modifyUserStateComponents(userId, false, true);
        if (state.disabledComponents != null) {
            changed = state.disabledComponents.remove(componentClassName);
        }
        return changed | state.enabledComponents.add(componentClassName);
    }

    boolean disableComponentLPw(String componentClassName, int userId) {
        boolean changed = false;
        PackageUserState state = modifyUserStateComponents(userId, true, false);
        if (state.enabledComponents != null) {
            changed = state.enabledComponents.remove(componentClassName);
        }
        return changed | state.disabledComponents.add(componentClassName);
    }

    boolean restoreComponentLPw(String componentClassName, int userId) {
        boolean changed;
        int i = 0;
        PackageUserState state = modifyUserStateComponents(userId, true, true);
        if (state.disabledComponents != null) {
            changed = state.disabledComponents.remove(componentClassName);
        } else {
            changed = false;
        }
        if (state.enabledComponents != null) {
            i = state.enabledComponents.remove(componentClassName);
        }
        return changed | i;
    }

    int getCurrentEnabledStateLPr(String componentName, int userId) {
        PackageUserState state = readUserState(userId);
        if (state.enabledComponents != null && state.enabledComponents.contains(componentName)) {
            return PKG_INSTALL_COMPLETE;
        }
        if (state.disabledComponents == null || !state.disabledComponents.contains(componentName)) {
            return 0;
        }
        return 2;
    }

    void removeUser(int userId) {
        this.userState.delete(userId);
    }
}
