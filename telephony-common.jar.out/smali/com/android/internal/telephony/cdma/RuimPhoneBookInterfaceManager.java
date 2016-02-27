package com.android.internal.telephony.cdma;

import android.os.Message;
import android.telephony.Rlog;
import com.android.internal.telephony.IccPhoneBookInterfaceManager;
import com.android.internal.telephony.uicc.IccFileHandler;
import java.util.concurrent.atomic.AtomicBoolean;

public class RuimPhoneBookInterfaceManager extends IccPhoneBookInterfaceManager {
    static final String LOG_TAG = "RuimPhoneBookIM";

    public RuimPhoneBookInterfaceManager(CDMAPhone phone) {
        super(phone);
    }

    public void dispose() {
        super.dispose();
    }

    protected void finalize() {
        try {
            super.finalize();
        } catch (Throwable throwable) {
            Rlog.e(LOG_TAG, "Error while finalizing:", throwable);
        }
        Rlog.d(LOG_TAG, "RuimPhoneBookInterfaceManager finalized");
    }

    public int[] getAdnRecordsSize(int efid) {
        logd("getAdnRecordsSize: efid=" + efid);
        synchronized (this.mLock) {
            checkThread();
            this.mRecordSize = new int[3];
            AtomicBoolean status = new AtomicBoolean(false);
            Message response = this.mBaseHandler.obtainMessage(1, status);
            IccFileHandler fh = this.mPhone.getIccFileHandler();
            if (fh != null) {
                fh.getEFLinearRecordSize(efid, response);
                waitForResult(status);
            }
        }
        return this.mRecordSize;
    }

    protected void logd(String msg) {
        Rlog.d(LOG_TAG, "[RuimPbInterfaceManager] " + msg);
    }

    protected void loge(String msg) {
        Rlog.e(LOG_TAG, "[RuimPbInterfaceManager] " + msg);
    }
}
