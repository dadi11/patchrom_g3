package android.filterfw.core;

import android.util.Log;
import dalvik.system.PathClassLoader;
import java.util.HashSet;
import java.util.Iterator;

public class FilterFactory {
    private static final String TAG = "FilterFactory";
    private static Object mClassLoaderGuard;
    private static ClassLoader mCurrentClassLoader;
    private static HashSet<String> mLibraries;
    private static boolean mLogVerbose;
    private static FilterFactory mSharedFactory;
    private HashSet<String> mPackages;

    public FilterFactory() {
        this.mPackages = new HashSet();
    }

    static {
        mCurrentClassLoader = Thread.currentThread().getContextClassLoader();
        mLibraries = new HashSet();
        mClassLoaderGuard = new Object();
        mLogVerbose = Log.isLoggable(TAG, 2);
    }

    public static FilterFactory sharedFactory() {
        if (mSharedFactory == null) {
            mSharedFactory = new FilterFactory();
        }
        return mSharedFactory;
    }

    public static void addFilterLibrary(String libraryPath) {
        if (mLogVerbose) {
            Log.v(TAG, "Adding filter library " + libraryPath);
        }
        synchronized (mClassLoaderGuard) {
            if (mLibraries.contains(libraryPath)) {
                if (mLogVerbose) {
                    Log.v(TAG, "Library already added");
                }
                return;
            }
            mLibraries.add(libraryPath);
            mCurrentClassLoader = new PathClassLoader(libraryPath, mCurrentClassLoader);
        }
    }

    public void addPackage(String packageName) {
        if (mLogVerbose) {
            Log.v(TAG, "Adding package " + packageName);
        }
        this.mPackages.add(packageName);
    }

    public Filter createFilterByClassName(String className, String filterName) {
        if (mLogVerbose) {
            Log.v(TAG, "Looking up class " + className);
        }
        Class filterClass = null;
        Iterator i$ = this.mPackages.iterator();
        while (i$.hasNext()) {
            String packageName = (String) i$.next();
            try {
                if (mLogVerbose) {
                    Log.v(TAG, "Trying " + packageName + "." + className);
                }
                synchronized (mClassLoaderGuard) {
                    filterClass = mCurrentClassLoader.loadClass(packageName + "." + className);
                }
                if (filterClass != null) {
                    break;
                }
            } catch (ClassNotFoundException e) {
            }
        }
        if (filterClass != null) {
            return createFilterByClass(filterClass, filterName);
        }
        throw new IllegalArgumentException("Unknown filter class '" + className + "'!");
    }

    public Filter createFilterByClass(Class filterClass, String filterName) {
        try {
            filterClass.asSubclass(Filter.class);
            try {
                Filter filter = null;
                try {
                    filter = (Filter) filterClass.getConstructor(new Class[]{String.class}).newInstance(new Object[]{filterName});
                } catch (Throwable th) {
                }
                if (filter != null) {
                    return filter;
                }
                throw new IllegalArgumentException("Could not construct the filter '" + filterName + "'!");
            } catch (NoSuchMethodException e) {
                throw new IllegalArgumentException("The filter class '" + filterClass + "' does not have a constructor of the form <init>(String name)!");
            }
        } catch (ClassCastException e2) {
            throw new IllegalArgumentException("Attempting to allocate class '" + filterClass + "' which is not a subclass of Filter!");
        }
    }
}
