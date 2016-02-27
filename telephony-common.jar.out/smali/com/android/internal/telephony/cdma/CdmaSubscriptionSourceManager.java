package com.android.internal.telephony.cdma;

import android.content.Context;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.Registrant;
import android.os.RegistrantList;
import android.provider.Settings.Global;
import android.telephony.Rlog;
import com.android.internal.telephony.CommandsInterface;
import java.util.concurrent.atomic.AtomicInteger;

public class CdmaSubscriptionSourceManager extends Handler {
    private static final int EVENT_CDMA_SUBSCRIPTION_SOURCE_CHANGED = 1;
    private static final int EVENT_GET_CDMA_SUBSCRIPTION_SOURCE = 2;
    private static final int EVENT_RADIO_ON = 3;
    private static final int EVENT_SUBSCRIPTION_STATUS_CHANGED = 4;
    static final String LOG_TAG = "CdmaSSM";
    public static final int PREFERRED_CDMA_SUBSCRIPTION = 1;
    private static final int SUBSCRIPTION_ACTIVATED = 1;
    public static final int SUBSCRIPTION_FROM_NV = 1;
    public static final int SUBSCRIPTION_FROM_RUIM = 0;
    public static final int SUBSCRIPTION_SOURCE_UNKNOWN = -1;
    private static CdmaSubscriptionSourceManager sInstance;
    private static int sReferenceCount;
    private static final Object sReferenceCountMonitor;
    private AtomicInteger mCdmaSubscriptionSource;
    private RegistrantList mCdmaSubscriptionSourceChangedRegistrants;
    private CommandsInterface mCi;
    private Context mContext;

    static {
        sReferenceCountMonitor = new Object();
        sReferenceCount = SUBSCRIPTION_FROM_RUIM;
    }

    private CdmaSubscriptionSourceManager(Context context, CommandsInterface ci) {
        this.mCdmaSubscriptionSourceChangedRegistrants = new RegistrantList();
        this.mCdmaSubscriptionSource = new AtomicInteger(SUBSCRIPTION_FROM_NV);
        this.mContext = context;
        this.mCi = ci;
        this.mCi.registerForCdmaSubscriptionChanged(this, SUBSCRIPTION_FROM_NV, null);
        this.mCi.registerForOn(this, EVENT_RADIO_ON, null);
        int subscriptionSource = getDefault(context);
        log("cdmaSSM constructor: " + subscriptionSource);
        this.mCdmaSubscriptionSource.set(subscriptionSource);
        this.mCi.registerForSubscriptionStatusChanged(this, EVENT_SUBSCRIPTION_STATUS_CHANGED, null);
    }

    public static CdmaSubscriptionSourceManager getInstance(Context context, CommandsInterface ci, Handler h, int what, Object obj) {
        synchronized (sReferenceCountMonitor) {
            if (sInstance == null) {
                sInstance = new CdmaSubscriptionSourceManager(context, ci);
            }
            sReferenceCount += SUBSCRIPTION_FROM_NV;
        }
        sInstance.registerForCdmaSubscriptionSourceChanged(h, what, obj);
        return sInstance;
    }

    public void dispose(Handler h) {
        this.mCdmaSubscriptionSourceChangedRegistrants.remove(h);
        synchronized (sReferenceCountMonitor) {
            sReferenceCount += SUBSCRIPTION_SOURCE_UNKNOWN;
            if (sReferenceCount <= 0) {
                this.mCi.unregisterForCdmaSubscriptionChanged(this);
                this.mCi.unregisterForOn(this);
                this.mCi.unregisterForSubscriptionStatusChanged(this);
                sInstance = null;
            }
        }
    }

    public void handleMessage(Message msg) {
        switch (msg.what) {
            case SUBSCRIPTION_FROM_NV /*1*/:
            case EVENT_GET_CDMA_SUBSCRIPTION_SOURCE /*2*/:
                log("CDMA_SUBSCRIPTION_SOURCE event = " + msg.what);
                handleGetCdmaSubscriptionSource(msg.obj);
            case EVENT_RADIO_ON /*3*/:
                this.mCi.getCdmaSubscriptionSource(obtainMessage(EVENT_GET_CDMA_SUBSCRIPTION_SOURCE));
            case EVENT_SUBSCRIPTION_STATUS_CHANGED /*4*/:
                log("EVENT_SUBSCRIPTION_STATUS_CHANGED");
                AsyncResult ar = (AsyncResult) msg.obj;
                if (ar.exception == null) {
                    int actStatus = ((int[]) ar.result)[SUBSCRIPTION_FROM_RUIM];
                    log("actStatus = " + actStatus);
                    if (actStatus == SUBSCRIPTION_FROM_NV) {
                        Rlog.v(LOG_TAG, "get Cdma Subscription Source");
                        this.mCi.getCdmaSubscriptionSource(obtainMessage(EVENT_GET_CDMA_SUBSCRIPTION_SOURCE));
                        return;
                    }
                    return;
                }
                logw("EVENT_SUBSCRIPTION_STATUS_CHANGED, Exception:" + ar.exception);
            default:
                super.handleMessage(msg);
        }
    }

    public int getCdmaSubscriptionSource() {
        log("getcdmasubscriptionSource: " + this.mCdmaSubscriptionSource.get());
        return this.mCdmaSubscriptionSource.get();
    }

    public static int getDefault(Context context) {
        int subscriptionSource = Global.getInt(context.getContentResolver(), "subscription_mode", SUBSCRIPTION_FROM_NV);
        Rlog.d(LOG_TAG, "subscriptionSource from settings: " + subscriptionSource);
        return subscriptionSource;
    }

    private void registerForCdmaSubscriptionSourceChanged(Handler h, int what, Object obj) {
        this.mCdmaSubscriptionSourceChangedRegistrants.add(new Registrant(h, what, obj));
    }

    private void handleGetCdmaSubscriptionSource(AsyncResult ar) {
        if (ar.exception != null || ar.result == null) {
            logw("Unable to get CDMA Subscription Source, Exception: " + ar.exception + ", result: " + ar.result);
            return;
        }
        int newSubscriptionSource = ((int[]) ar.result)[SUBSCRIPTION_FROM_RUIM];
        if (newSubscriptionSource != this.mCdmaSubscriptionSource.get()) {
            log("Subscription Source Changed : " + this.mCdmaSubscriptionSource + " >> " + newSubscriptionSource);
            this.mCdmaSubscriptionSource.set(newSubscriptionSource);
            this.mCdmaSubscriptionSourceChangedRegistrants.notifyRegistrants(new AsyncResult(null, null, null));
        }
    }

    private void log(String s) {
        Rlog.d(LOG_TAG, s);
    }

    private void logw(String s) {
        Rlog.w(LOG_TAG, s);
    }
}
