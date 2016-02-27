package android.content.res;

import android.content.res.Resources.Theme;
import android.net.ProxyInfo;
import android.util.ArrayMap;
import android.util.LongSparseArray;
import java.lang.ref.WeakReference;

public class ConfigurationBoundResourceCache<T> {
    private final ArrayMap<String, LongSparseArray<WeakReference<ConstantState<T>>>> mCache;
    final Resources mResources;

    public ConfigurationBoundResourceCache(Resources resources) {
        this.mCache = new ArrayMap();
        this.mResources = resources;
    }

    public void put(long key, Theme theme, ConstantState<T> constantState) {
        if (constantState != null) {
            String themeKey = theme == null ? ProxyInfo.LOCAL_EXCL_LIST : theme.getKey();
            synchronized (this) {
                LongSparseArray<WeakReference<ConstantState<T>>> themedCache = (LongSparseArray) this.mCache.get(themeKey);
                if (themedCache == null) {
                    themedCache = new LongSparseArray(1);
                    this.mCache.put(themeKey, themedCache);
                }
                themedCache.put(key, new WeakReference(constantState));
            }
        }
    }

    public T get(long key, Theme theme) {
        String themeKey = theme != null ? theme.getKey() : ProxyInfo.LOCAL_EXCL_LIST;
        synchronized (this) {
            LongSparseArray<WeakReference<ConstantState<T>>> themedCache = (LongSparseArray) this.mCache.get(themeKey);
            if (themedCache == null) {
                return null;
            }
            WeakReference<ConstantState<T>> wr = (WeakReference) themedCache.get(key);
            if (wr == null) {
                return null;
            }
            ConstantState entry = (ConstantState) wr.get();
            if (entry != null) {
                return entry.newInstance(this.mResources, theme);
            }
            synchronized (this) {
                themedCache.delete(key);
            }
            return null;
        }
    }

    public void onConfigurationChange(int configChanges) {
        synchronized (this) {
            for (int i = this.mCache.size() - 1; i >= 0; i--) {
                LongSparseArray<WeakReference<ConstantState<T>>> themeCache = (LongSparseArray) this.mCache.valueAt(i);
                onConfigurationChangeInt(themeCache, configChanges);
                if (themeCache.size() == 0) {
                    this.mCache.removeAt(i);
                }
            }
        }
    }

    private void onConfigurationChangeInt(LongSparseArray<WeakReference<ConstantState<T>>> themeCache, int configChanges) {
        for (int i = themeCache.size() - 1; i >= 0; i--) {
            ConstantState<T> constantState = (ConstantState) ((WeakReference) themeCache.valueAt(i)).get();
            if (constantState == null || Configuration.needNewResources(configChanges, constantState.getChangingConfigurations())) {
                themeCache.removeAt(i);
            }
        }
    }
}
