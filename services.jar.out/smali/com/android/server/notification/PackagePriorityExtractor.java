package com.android.server.notification;

import android.content.Context;

public class PackagePriorityExtractor implements NotificationSignalExtractor {
    private static final boolean DBG = false;
    private static final String TAG = "ImportantPackageExtractor";
    private RankingConfig mConfig;

    public void initialize(Context ctx) {
    }

    public RankingReconsideration process(NotificationRecord record) {
        if (!(record == null || record.getNotification() == null || this.mConfig == null)) {
            record.setPackagePriority(this.mConfig.getPackagePriority(record.sbn.getPackageName(), record.sbn.getUid()));
        }
        return null;
    }

    public void setConfig(RankingConfig config) {
        this.mConfig = config;
    }
}
