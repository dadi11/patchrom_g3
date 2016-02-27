package com.android.internal.telephony.uicc;

import android.telephony.Rlog;

public final class UICCConfig {
    private final boolean LOG_DEBUG;
    private final String PREFERENCE_NAME;
    private final String TAG;
    private String mImsi;
    private int mMncLength;

    public UICCConfig() {
        this.PREFERENCE_NAME = "UICCConfig";
        this.TAG = "UICCConfig";
        this.LOG_DEBUG = false;
    }

    public String getImsi() {
        if (this.mImsi == null) {
            logd("Getting IMSI: null");
        } else {
            logd("Getting IMSI: " + this.mImsi);
        }
        return this.mImsi;
    }

    public void setImsi(String lImsi) {
        logd("Setting IMSI: " + lImsi);
        this.mImsi = lImsi;
    }

    public int getMncLength() {
        logd("Getting MncLength: " + Integer.toString(this.mMncLength));
        return this.mMncLength;
    }

    public void setMncLength(int lMncLength) {
        logd("Setting MncLength: " + Integer.toString(lMncLength));
        this.mMncLength = lMncLength;
    }

    private void logd(String sLog) {
    }

    private void loge(String sLog) {
        Rlog.e("UICCConfig", sLog);
    }
}
