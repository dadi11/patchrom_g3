package com.android.server;

import android.content.Context;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.Configuration;
import android.content.res.Resources.NotFoundException;
import android.content.res.TypedArray;
import android.os.UserHandle;
import android.util.SparseArray;
import java.util.HashMap;
import java.util.WeakHashMap;

public final class AttributeCache {
    private static AttributeCache sInstance;
    private final Configuration mConfiguration;
    private final Context mContext;
    private final WeakHashMap<String, Package> mPackages;

    public static final class Entry {
        public final TypedArray array;
        public final Context context;

        public Entry(Context c, TypedArray ta) {
            this.context = c;
            this.array = ta;
        }
    }

    public static final class Package {
        public final Context context;
        private final SparseArray<HashMap<int[], Entry>> mMap;

        public Package(Context c) {
            this.mMap = new SparseArray();
            this.context = c;
        }
    }

    static {
        sInstance = null;
    }

    public static void init(Context context) {
        if (sInstance == null) {
            sInstance = new AttributeCache(context);
        }
    }

    public static AttributeCache instance() {
        return sInstance;
    }

    public AttributeCache(Context context) {
        this.mPackages = new WeakHashMap();
        this.mConfiguration = new Configuration();
        this.mContext = context;
    }

    public void removePackage(String packageName) {
        synchronized (this) {
            this.mPackages.remove(packageName);
        }
    }

    public void updateConfiguration(Configuration config) {
        synchronized (this) {
            if ((-1073741985 & this.mConfiguration.updateFrom(config)) != 0) {
                this.mPackages.clear();
            }
        }
    }

    public Entry get(String packageName, int resId, int[] styleable, int userId) {
        synchronized (this) {
            Package pkg = (Package) this.mPackages.get(packageName);
            HashMap<int[], Entry> hashMap = null;
            Entry ent = null;
            if (pkg != null) {
                hashMap = (HashMap) pkg.mMap.get(resId);
                if (hashMap != null) {
                    ent = (Entry) hashMap.get(styleable);
                    if (ent != null) {
                        return ent;
                    }
                }
            }
            try {
                Context context = this.mContext.createPackageContextAsUser(packageName, 0, new UserHandle(userId));
                if (context == null) {
                    return null;
                }
                pkg = new Package(context);
                this.mPackages.put(packageName, pkg);
            } catch (NameNotFoundException e) {
                return null;
            }
            Entry ent2 = ent;
            if (hashMap == null) {
                hashMap = new HashMap();
                pkg.mMap.put(resId, hashMap);
            }
            try {
                ent = new Entry(pkg.context, pkg.context.obtainStyledAttributes(resId, styleable));
                try {
                    hashMap.put(styleable, ent);
                    return ent;
                } catch (NotFoundException e2) {
                    return null;
                }
            } catch (NotFoundException e3) {
                ent = ent2;
                return null;
            }
        }
    }
}
