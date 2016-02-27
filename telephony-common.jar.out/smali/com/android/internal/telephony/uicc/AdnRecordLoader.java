package com.android.internal.telephony.uicc;

import android.os.AsyncResult;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.telephony.Rlog;
import java.util.ArrayList;

public class AdnRecordLoader extends Handler {
    static final int EVENT_ADN_LOAD_ALL_DONE = 3;
    static final int EVENT_ADN_LOAD_DONE = 1;
    static final int EVENT_EF_LINEAR_RECORD_SIZE_DONE = 4;
    static final int EVENT_EXT_RECORD_LOAD_DONE = 2;
    static final int EVENT_UPDATE_RECORD_DONE = 5;
    static final String LOG_TAG = "AdnRecordLoader";
    static final boolean VDBG = false;
    ArrayList<AdnRecord> mAdns;
    int mEf;
    int mExtensionEF;
    private IccFileHandler mFh;
    int mPendingExtLoads;
    String mPin2;
    int mRecordNumber;
    Object mResult;
    Message mUserResponse;

    AdnRecordLoader(IccFileHandler fh) {
        super(Looper.getMainLooper());
        this.mFh = fh;
    }

    public void loadFromEF(int ef, int extensionEF, int recordNumber, Message response) {
        this.mEf = ef;
        this.mExtensionEF = extensionEF;
        this.mRecordNumber = recordNumber;
        this.mUserResponse = response;
        this.mFh.loadEFLinearFixed(ef, recordNumber, obtainMessage(EVENT_ADN_LOAD_DONE));
    }

    public void loadAllFromEF(int ef, int extensionEF, Message response) {
        this.mEf = ef;
        this.mExtensionEF = extensionEF;
        this.mUserResponse = response;
        this.mFh.loadEFLinearFixedAll(ef, obtainMessage(EVENT_ADN_LOAD_ALL_DONE));
    }

    public void updateEF(AdnRecord adn, int ef, int extensionEF, int recordNumber, String pin2, Message response) {
        this.mEf = ef;
        this.mExtensionEF = extensionEF;
        this.mRecordNumber = recordNumber;
        this.mUserResponse = response;
        this.mPin2 = pin2;
        this.mFh.getEFLinearRecordSize(ef, obtainMessage(EVENT_EF_LINEAR_RECORD_SIZE_DONE, adn));
    }

    public void handleMessage(Message msg) {
        try {
            AsyncResult ar;
            byte[] data;
            AdnRecord adn;
            switch (msg.what) {
                case EVENT_ADN_LOAD_DONE /*1*/:
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    if (ar.exception == null) {
                        adn = new AdnRecord(this.mEf, this.mRecordNumber, data);
                        this.mResult = adn;
                        if (adn.hasExtendedRecord()) {
                            this.mPendingExtLoads = EVENT_ADN_LOAD_DONE;
                            this.mFh.loadEFLinearFixed(this.mExtensionEF, adn.mExtRecord, obtainMessage(EVENT_EXT_RECORD_LOAD_DONE, adn));
                            break;
                        }
                    }
                    throw new RuntimeException("load failed", ar.exception);
                    break;
                case EVENT_EXT_RECORD_LOAD_DONE /*2*/:
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    adn = (AdnRecord) ar.userObj;
                    if (ar.exception == null) {
                        Rlog.d(LOG_TAG, "ADN extension EF: 0x" + Integer.toHexString(this.mExtensionEF) + ":" + adn.mExtRecord + "\n" + IccUtils.bytesToHexString(data));
                        adn.appendExtRecord(data);
                        this.mPendingExtLoads--;
                        break;
                    }
                    throw new RuntimeException("load failed", ar.exception);
                case EVENT_ADN_LOAD_ALL_DONE /*3*/:
                    ar = (AsyncResult) msg.obj;
                    ArrayList<byte[]> datas = (ArrayList) ar.result;
                    if (ar.exception == null) {
                        this.mAdns = new ArrayList(datas.size());
                        this.mResult = this.mAdns;
                        this.mPendingExtLoads = 0;
                        int s = datas.size();
                        for (int i = 0; i < s; i += EVENT_ADN_LOAD_DONE) {
                            adn = new AdnRecord(this.mEf, i + EVENT_ADN_LOAD_DONE, (byte[]) datas.get(i));
                            this.mAdns.add(adn);
                            if (adn.hasExtendedRecord()) {
                                this.mPendingExtLoads += EVENT_ADN_LOAD_DONE;
                                this.mFh.loadEFLinearFixed(this.mExtensionEF, adn.mExtRecord, obtainMessage(EVENT_EXT_RECORD_LOAD_DONE, adn));
                            }
                        }
                        break;
                    }
                    throw new RuntimeException("load failed", ar.exception);
                case EVENT_EF_LINEAR_RECORD_SIZE_DONE /*4*/:
                    ar = (AsyncResult) msg.obj;
                    adn = (AdnRecord) ar.userObj;
                    if (ar.exception == null) {
                        int[] recordSize = (int[]) ar.result;
                        if (recordSize.length == EVENT_ADN_LOAD_ALL_DONE && this.mRecordNumber <= recordSize[EVENT_EXT_RECORD_LOAD_DONE]) {
                            data = adn.buildAdnString(recordSize[0]);
                            if (data != null) {
                                this.mFh.updateEFLinearFixed(this.mEf, this.mRecordNumber, data, this.mPin2, obtainMessage(EVENT_UPDATE_RECORD_DONE));
                                this.mPendingExtLoads = EVENT_ADN_LOAD_DONE;
                                break;
                            }
                            throw new RuntimeException("wrong ADN format", ar.exception);
                        }
                        throw new RuntimeException("get wrong EF record size format", ar.exception);
                    }
                    throw new RuntimeException("get EF record size failed", ar.exception);
                    break;
                case EVENT_UPDATE_RECORD_DONE /*5*/:
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        this.mPendingExtLoads = 0;
                        this.mResult = null;
                        break;
                    }
                    throw new RuntimeException("update EF adn record failed", ar.exception);
            }
            if (this.mUserResponse != null && this.mPendingExtLoads == 0) {
                AsyncResult.forMessage(this.mUserResponse).result = this.mResult;
                this.mUserResponse.sendToTarget();
                this.mUserResponse = null;
            }
        } catch (RuntimeException exc) {
            if (this.mUserResponse != null) {
                AsyncResult.forMessage(this.mUserResponse).exception = exc;
                this.mUserResponse.sendToTarget();
                this.mUserResponse = null;
            }
        }
    }
}
