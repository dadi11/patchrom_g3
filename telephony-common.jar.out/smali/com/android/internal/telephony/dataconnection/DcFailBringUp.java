package com.android.internal.telephony.dataconnection;

import android.content.Intent;
import android.telephony.Rlog;

class DcFailBringUp {
    static final String ACTION_FAIL_BRINGUP = "action_fail_bringup";
    static final String COUNTER = "counter";
    private static final boolean DBG = true;
    static final int DEFAULT_COUNTER = 1;
    static final DcFailCause DEFAULT_FAIL_CAUSE;
    static final int DEFAULT_SUGGESTED_RETRY_TIME = -1;
    static final String FAIL_CAUSE = "fail_cause";
    static final String INTENT_BASE;
    private static final String LOG_TAG = "DcFailBringUp";
    static final String SUGGESTED_RETRY_TIME = "suggested_retry_time";
    int mCounter;
    DcFailCause mFailCause;
    int mSuggestedRetryTime;

    DcFailBringUp() {
    }

    static {
        INTENT_BASE = DataConnection.class.getPackage().getName();
        DEFAULT_FAIL_CAUSE = DcFailCause.ERROR_UNSPECIFIED;
    }

    void saveParameters(Intent intent, String s) {
        log(s + ".saveParameters: action=" + intent.getAction());
        this.mCounter = intent.getIntExtra(COUNTER, DEFAULT_COUNTER);
        this.mFailCause = DcFailCause.fromInt(intent.getIntExtra(FAIL_CAUSE, DEFAULT_FAIL_CAUSE.getErrorCode()));
        this.mSuggestedRetryTime = intent.getIntExtra(SUGGESTED_RETRY_TIME, DEFAULT_SUGGESTED_RETRY_TIME);
        log(s + ".saveParameters: " + this);
    }

    void saveParameters(int counter, int failCause, int suggestedRetryTime) {
        this.mCounter = counter;
        this.mFailCause = DcFailCause.fromInt(failCause);
        this.mSuggestedRetryTime = suggestedRetryTime;
    }

    public String toString() {
        return "{mCounter=" + this.mCounter + " mFailCause=" + this.mFailCause + " mSuggestedRetryTime=" + this.mSuggestedRetryTime + "}";
    }

    private static void log(String s) {
        Rlog.d(LOG_TAG, s);
    }
}
