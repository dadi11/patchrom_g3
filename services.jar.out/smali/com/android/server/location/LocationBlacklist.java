package com.android.server.location;

import android.content.Context;
import android.database.ContentObserver;
import android.os.Handler;
import android.provider.Settings.Secure;
import android.util.Log;
import android.util.Slog;
import com.android.server.LocationManagerService;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;

public final class LocationBlacklist extends ContentObserver {
    private static final String BLACKLIST_CONFIG_NAME = "locationPackagePrefixBlacklist";
    private static final boolean f7D;
    private static final String TAG = "LocationBlacklist";
    private static final String WHITELIST_CONFIG_NAME = "locationPackagePrefixWhitelist";
    private String[] mBlacklist;
    private final Context mContext;
    private int mCurrentUserId;
    private final Object mLock;
    private String[] mWhitelist;

    static {
        f7D = LocationManagerService.f0D;
    }

    public LocationBlacklist(Context context, Handler handler) {
        super(handler);
        this.mLock = new Object();
        this.mWhitelist = new String[0];
        this.mBlacklist = new String[0];
        this.mCurrentUserId = 0;
        this.mContext = context;
    }

    public void init() {
        this.mContext.getContentResolver().registerContentObserver(Secure.getUriFor(BLACKLIST_CONFIG_NAME), f7D, this, -1);
        reloadBlacklist();
    }

    private void reloadBlacklistLocked() {
        this.mWhitelist = getStringArrayLocked(WHITELIST_CONFIG_NAME);
        if (f7D) {
            Slog.d(TAG, "whitelist: " + Arrays.toString(this.mWhitelist));
        }
        this.mBlacklist = getStringArrayLocked(BLACKLIST_CONFIG_NAME);
        if (f7D) {
            Slog.d(TAG, "blacklist: " + Arrays.toString(this.mBlacklist));
        }
    }

    private void reloadBlacklist() {
        synchronized (this.mLock) {
            reloadBlacklistLocked();
        }
    }

    public boolean isBlacklisted(String packageName) {
        synchronized (this.mLock) {
            String[] arr$ = this.mBlacklist;
            int len$ = arr$.length;
            int i$ = 0;
            while (i$ < len$) {
                String black = arr$[i$];
                if (!packageName.startsWith(black) || inWhitelist(packageName)) {
                    i$++;
                } else {
                    if (f7D) {
                        Log.d(TAG, "dropping location (blacklisted): " + packageName + " matches " + black);
                    }
                    return true;
                }
            }
            return f7D;
        }
    }

    private boolean inWhitelist(String pkg) {
        synchronized (this.mLock) {
            for (String white : this.mWhitelist) {
                if (pkg.startsWith(white)) {
                    return true;
                }
            }
            return f7D;
        }
    }

    public void onChange(boolean selfChange) {
        reloadBlacklist();
    }

    public void switchUser(int userId) {
        synchronized (this.mLock) {
            this.mCurrentUserId = userId;
            reloadBlacklistLocked();
        }
    }

    private String[] getStringArrayLocked(String key) {
        synchronized (this.mLock) {
            String flatString = Secure.getStringForUser(this.mContext.getContentResolver(), key, this.mCurrentUserId);
        }
        if (flatString == null) {
            return new String[0];
        }
        String[] splitStrings = flatString.split(",");
        ArrayList<String> result = new ArrayList();
        for (String pkg : splitStrings) {
            String pkg2 = pkg2.trim();
            if (!pkg2.isEmpty()) {
                result.add(pkg2);
            }
        }
        return (String[]) result.toArray(new String[result.size()]);
    }

    public void dump(PrintWriter pw) {
        pw.println("mWhitelist=" + Arrays.toString(this.mWhitelist) + " mBlacklist=" + Arrays.toString(this.mBlacklist));
    }
}
