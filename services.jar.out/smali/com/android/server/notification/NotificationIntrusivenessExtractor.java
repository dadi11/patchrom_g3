package com.android.server.notification;

import android.app.Notification;
import android.content.Context;

public class NotificationIntrusivenessExtractor implements NotificationSignalExtractor {
    private static final boolean DBG = false;
    private static final long HANG_TIME_MS = 10000;
    private static final String TAG = "NotificationNoiseExtractor";

    /* renamed from: com.android.server.notification.NotificationIntrusivenessExtractor.1 */
    class C04171 extends RankingReconsideration {
        C04171(String x0, long x1) {
            super(x0, x1);
        }

        public void work() {
        }

        public void applyChangesLocked(NotificationRecord record) {
            record.setRecentlyIntusive(NotificationIntrusivenessExtractor.DBG);
        }
    }

    public void initialize(Context ctx) {
    }

    public RankingReconsideration process(NotificationRecord record) {
        if (record == null || record.getNotification() == null) {
            return null;
        }
        Notification notification = record.getNotification();
        if (!((notification.defaults & 2) == 0 && notification.vibrate == null && (notification.defaults & 1) == 0 && notification.sound == null && notification.fullScreenIntent == null)) {
            record.setRecentlyIntusive(true);
        }
        return new C04171(record.getKey(), HANG_TIME_MS);
    }

    public void setConfig(RankingConfig config) {
    }
}
