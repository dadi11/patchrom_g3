package com.android.internal.telephony;

import android.os.AsyncResult;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import com.android.internal.telephony.uicc.AdnRecord;
import com.android.internal.telephony.uicc.AdnRecordCache;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppType;
import com.android.internal.telephony.uicc.IccConstants;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.telephony.uicc.UiccCardApplication;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class IccPhoneBookInterfaceManager {
    protected static final boolean ALLOW_SIM_OP_IN_UI_THREAD = false;
    protected static final boolean DBG = true;
    protected static final int EVENT_GET_SIZE_DONE = 1;
    protected static final int EVENT_LOAD_DONE = 2;
    protected static final int EVENT_UPDATE_DONE = 3;
    protected AdnRecordCache mAdnCache;
    protected Handler mBaseHandler;
    private UiccCardApplication mCurrentApp;
    private boolean mIs3gCard;
    protected final Object mLock;
    protected PhoneBase mPhone;
    protected int[] mRecordSize;
    protected List<AdnRecord> mRecords;
    protected boolean mSuccess;

    /* renamed from: com.android.internal.telephony.IccPhoneBookInterfaceManager.1 */
    class C00101 extends Handler {
        C00101() {
        }

        public void handleMessage(Message msg) {
            boolean z = IccPhoneBookInterfaceManager.DBG;
            AsyncResult ar;
            switch (msg.what) {
                case IccPhoneBookInterfaceManager.EVENT_GET_SIZE_DONE /*1*/:
                    ar = msg.obj;
                    synchronized (IccPhoneBookInterfaceManager.this.mLock) {
                        if (ar.exception == null) {
                            IccPhoneBookInterfaceManager.this.mRecordSize = (int[]) ar.result;
                            IccPhoneBookInterfaceManager.this.logd("GET_RECORD_SIZE Size " + IccPhoneBookInterfaceManager.this.mRecordSize[0] + " total " + IccPhoneBookInterfaceManager.this.mRecordSize[IccPhoneBookInterfaceManager.EVENT_GET_SIZE_DONE] + " #record " + IccPhoneBookInterfaceManager.this.mRecordSize[IccPhoneBookInterfaceManager.EVENT_LOAD_DONE]);
                        }
                        notifyPending(ar);
                        break;
                    }
                case IccPhoneBookInterfaceManager.EVENT_LOAD_DONE /*2*/:
                    ar = (AsyncResult) msg.obj;
                    synchronized (IccPhoneBookInterfaceManager.this.mLock) {
                        if (ar.exception != null) {
                            IccPhoneBookInterfaceManager.this.logd("Cannot load ADN records");
                            if (IccPhoneBookInterfaceManager.this.mRecords != null) {
                                IccPhoneBookInterfaceManager.this.mRecords.clear();
                            }
                            break;
                        }
                        IccPhoneBookInterfaceManager.this.mRecords = (List) ar.result;
                        notifyPending(ar);
                        break;
                    }
                case IccPhoneBookInterfaceManager.EVENT_UPDATE_DONE /*3*/:
                    ar = (AsyncResult) msg.obj;
                    synchronized (IccPhoneBookInterfaceManager.this.mLock) {
                        IccPhoneBookInterfaceManager iccPhoneBookInterfaceManager = IccPhoneBookInterfaceManager.this;
                        if (ar.exception != null) {
                            z = IccPhoneBookInterfaceManager.ALLOW_SIM_OP_IN_UI_THREAD;
                        }
                        iccPhoneBookInterfaceManager.mSuccess = z;
                        notifyPending(ar);
                        break;
                    }
                default:
            }
        }

        private void notifyPending(AsyncResult ar) {
            if (ar.userObj != null) {
                ar.userObj.set(IccPhoneBookInterfaceManager.DBG);
            }
            IccPhoneBookInterfaceManager.this.mLock.notifyAll();
        }
    }

    public abstract int[] getAdnRecordsSize(int i);

    protected abstract void logd(String str);

    protected abstract void loge(String str);

    public IccPhoneBookInterfaceManager(PhoneBase phone) {
        this.mCurrentApp = null;
        this.mLock = new Object();
        this.mIs3gCard = ALLOW_SIM_OP_IN_UI_THREAD;
        this.mBaseHandler = new C00101();
        this.mPhone = phone;
        IccRecords r = (IccRecords) phone.mIccRecords.get();
        if (r != null) {
            this.mAdnCache = r.getAdnCache();
        }
    }

    public void dispose() {
    }

    public void updateIccRecords(IccRecords iccRecords) {
        if (iccRecords != null) {
            this.mAdnCache = iccRecords.getAdnCache();
        } else {
            this.mAdnCache = null;
        }
    }

    public boolean updateAdnRecordsInEfBySearch(int efid, String oldTag, String oldPhoneNumber, String newTag, String newPhoneNumber, String pin2) {
        if (this.mPhone.getContext().checkCallingOrSelfPermission("android.permission.WRITE_CONTACTS") != 0) {
            throw new SecurityException("Requires android.permission.WRITE_CONTACTS permission");
        }
        logd("updateAdnRecordsInEfBySearch: efid=" + efid + " (" + oldTag + "," + oldPhoneNumber + ")" + "==>" + " (" + newTag + "," + newPhoneNumber + ")" + " pin2=" + pin2);
        efid = updateEfForIccType(efid);
        synchronized (this.mLock) {
            checkThread();
            this.mSuccess = ALLOW_SIM_OP_IN_UI_THREAD;
            AtomicBoolean status = new AtomicBoolean(ALLOW_SIM_OP_IN_UI_THREAD);
            Message response = this.mBaseHandler.obtainMessage(EVENT_UPDATE_DONE, status);
            AdnRecord oldAdn = new AdnRecord(oldTag, oldPhoneNumber);
            AdnRecord newAdn = new AdnRecord(newTag, newPhoneNumber);
            if (this.mAdnCache != null) {
                this.mAdnCache.updateAdnBySearch(efid, oldAdn, newAdn, pin2, response);
                waitForResult(status);
            } else {
                loge("Failure while trying to update by search due to uninitialised adncache");
            }
        }
        return this.mSuccess;
    }

    public boolean updateAdnRecordsInEfByIndex(int efid, String newTag, String newPhoneNumber, int index, String pin2) {
        if (this.mPhone.getContext().checkCallingOrSelfPermission("android.permission.WRITE_CONTACTS") != 0) {
            throw new SecurityException("Requires android.permission.WRITE_CONTACTS permission");
        }
        logd("updateAdnRecordsInEfByIndex: efid=" + efid + " Index=" + index + " ==> " + "(" + newTag + "," + newPhoneNumber + ")" + " pin2=" + pin2);
        synchronized (this.mLock) {
            checkThread();
            this.mSuccess = ALLOW_SIM_OP_IN_UI_THREAD;
            AtomicBoolean status = new AtomicBoolean(ALLOW_SIM_OP_IN_UI_THREAD);
            Message response = this.mBaseHandler.obtainMessage(EVENT_UPDATE_DONE, status);
            AdnRecord newAdn = new AdnRecord(newTag, newPhoneNumber);
            if (this.mAdnCache != null) {
                this.mAdnCache.updateAdnByIndex(efid, newAdn, index, pin2, response);
                waitForResult(status);
            } else {
                loge("Failure while trying to update by index due to uninitialised adncache");
            }
        }
        return this.mSuccess;
    }

    public List<AdnRecord> getAdnRecordsInEf(int efid) {
        if (this.mPhone.getContext().checkCallingOrSelfPermission("android.permission.READ_CONTACTS") != 0) {
            throw new SecurityException("Requires android.permission.READ_CONTACTS permission");
        }
        efid = updateEfForIccType(efid);
        logd("getAdnRecordsInEF: efid=" + efid);
        synchronized (this.mLock) {
            checkThread();
            AtomicBoolean status = new AtomicBoolean(ALLOW_SIM_OP_IN_UI_THREAD);
            Message response = this.mBaseHandler.obtainMessage(EVENT_LOAD_DONE, status);
            if (this.mAdnCache != null) {
                this.mAdnCache.requestLoadAllAdnLike(efid, this.mAdnCache.extensionEfForEf(efid), response);
                waitForResult(status);
            } else {
                loge("Failure while trying to load from SIM due to uninitialised adncache");
            }
        }
        return this.mRecords;
    }

    protected void checkThread() {
        if (this.mBaseHandler.getLooper().equals(Looper.myLooper())) {
            loge("query() called on the main UI thread!");
            throw new IllegalStateException("You cannot call query on this provder from the main UI thread.");
        }
    }

    protected void waitForResult(AtomicBoolean status) {
        while (!status.get()) {
            try {
                this.mLock.wait();
            } catch (InterruptedException e) {
                logd("interrupted while trying to update by search");
            }
        }
    }

    private int updateEfForIccType(int efid) {
        if (efid == IccConstants.EF_CSIM_LI && this.mPhone.getCurrentUiccAppType() == AppType.APPTYPE_USIM) {
            return IccConstants.EF_PBR;
        }
        return efid;
    }
}
