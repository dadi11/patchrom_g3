package com.android.server.pm;

import android.content.pm.PackageParser.Permission;
import android.content.pm.PermissionInfo;

final class BasePermission {
    static final int TYPE_BUILTIN = 1;
    static final int TYPE_DYNAMIC = 2;
    static final int TYPE_NORMAL = 0;
    int[] gids;
    final String name;
    PackageSettingBase packageSetting;
    PermissionInfo pendingInfo;
    Permission perm;
    int protectionLevel;
    String sourcePackage;
    final int type;
    int uid;

    BasePermission(String _name, String _sourcePackage, int _type) {
        this.name = _name;
        this.sourcePackage = _sourcePackage;
        this.type = _type;
        this.protectionLevel = TYPE_DYNAMIC;
    }

    public String toString() {
        return "BasePermission{" + Integer.toHexString(System.identityHashCode(this)) + " " + this.name + "}";
    }
}
