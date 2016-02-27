package com.android.server.usage;

import android.app.usage.ConfigurationStats;
import android.app.usage.TimeSparseArray;
import android.app.usage.UsageEvents.Event;
import android.app.usage.UsageStats;
import android.content.res.Configuration;
import android.util.ArrayMap;
import android.util.ArraySet;

class IntervalStats {
    public Configuration activeConfiguration;
    public long beginTime;
    public final ArrayMap<Configuration, ConfigurationStats> configurations;
    public long endTime;
    public TimeSparseArray<Event> events;
    public long lastTimeSaved;
    private final ArraySet<String> mStringCache;
    public final ArrayMap<String, UsageStats> packageStats;

    IntervalStats() {
        this.packageStats = new ArrayMap();
        this.configurations = new ArrayMap();
        this.mStringCache = new ArraySet();
    }

    UsageStats getOrCreateUsageStats(String packageName) {
        UsageStats usageStats = (UsageStats) this.packageStats.get(packageName);
        if (usageStats != null) {
            return usageStats;
        }
        usageStats = new UsageStats();
        usageStats.mPackageName = getCachedStringRef(packageName);
        usageStats.mBeginTimeStamp = this.beginTime;
        usageStats.mEndTimeStamp = this.endTime;
        this.packageStats.put(usageStats.mPackageName, usageStats);
        return usageStats;
    }

    ConfigurationStats getOrCreateConfigurationStats(Configuration config) {
        ConfigurationStats configStats = (ConfigurationStats) this.configurations.get(config);
        if (configStats != null) {
            return configStats;
        }
        configStats = new ConfigurationStats();
        configStats.mBeginTimeStamp = this.beginTime;
        configStats.mEndTimeStamp = this.endTime;
        configStats.mConfiguration = config;
        this.configurations.put(config, configStats);
        return configStats;
    }

    Event buildEvent(String packageName, String className) {
        Event event = new Event();
        event.mPackage = getCachedStringRef(packageName);
        if (className != null) {
            event.mClass = getCachedStringRef(className);
        }
        return event;
    }

    void update(String packageName, long timeStamp, int eventType) {
        UsageStats usageStats = getOrCreateUsageStats(packageName);
        if ((eventType == 2 || eventType == 3) && (usageStats.mLastEvent == 1 || usageStats.mLastEvent == 4)) {
            usageStats.mTotalTimeInForeground += timeStamp - usageStats.mLastTimeUsed;
        }
        usageStats.mLastEvent = eventType;
        usageStats.mLastTimeUsed = timeStamp;
        usageStats.mEndTimeStamp = timeStamp;
        if (eventType == 1) {
            usageStats.mLaunchCount++;
        }
        this.endTime = timeStamp;
    }

    void updateConfigurationStats(Configuration config, long timeStamp) {
        if (this.activeConfiguration != null) {
            ConfigurationStats activeStats = (ConfigurationStats) this.configurations.get(this.activeConfiguration);
            activeStats.mTotalTimeActive += timeStamp - activeStats.mLastTimeActive;
            activeStats.mLastTimeActive = timeStamp - 1;
        }
        if (config != null) {
            ConfigurationStats configStats = getOrCreateConfigurationStats(config);
            configStats.mLastTimeActive = timeStamp;
            configStats.mActivationCount++;
            this.activeConfiguration = configStats.mConfiguration;
        }
        this.endTime = timeStamp;
    }

    private String getCachedStringRef(String str) {
        int index = this.mStringCache.indexOf(str);
        if (index >= 0) {
            return (String) this.mStringCache.valueAt(index);
        }
        this.mStringCache.add(str);
        return str;
    }
}
