package com.android.internal.telephony.uicc;

import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.util.SparseArray;
import com.android.internal.telephony.gsm.UsimPhoneBookManager;
import java.util.ArrayList;
import java.util.Iterator;

public final class AdnRecordCache extends Handler implements IccConstants {
    static final int EVENT_LOAD_ALL_ADN_LIKE_DONE = 1;
    static final int EVENT_UPDATE_ADN_DONE = 2;
    SparseArray<ArrayList<AdnRecord>> mAdnLikeFiles;
    SparseArray<ArrayList<Message>> mAdnLikeWaiters;
    private IccFileHandler mFh;
    SparseArray<Message> mUserWriteResponse;
    private UsimPhoneBookManager mUsimPhoneBookManager;

    AdnRecordCache(IccFileHandler fh) {
        this.mAdnLikeFiles = new SparseArray();
        this.mAdnLikeWaiters = new SparseArray();
        this.mUserWriteResponse = new SparseArray();
        this.mFh = fh;
        this.mUsimPhoneBookManager = new UsimPhoneBookManager(this.mFh, this);
    }

    public void reset() {
        this.mAdnLikeFiles.clear();
        this.mUsimPhoneBookManager.reset();
        clearWaiters();
        clearUserWriters();
    }

    private void clearWaiters() {
        int size = this.mAdnLikeWaiters.size();
        for (int i = 0; i < size; i += EVENT_LOAD_ALL_ADN_LIKE_DONE) {
            notifyWaiters((ArrayList) this.mAdnLikeWaiters.valueAt(i), new AsyncResult(null, null, new RuntimeException("AdnCache reset")));
        }
        this.mAdnLikeWaiters.clear();
    }

    private void clearUserWriters() {
        int size = this.mUserWriteResponse.size();
        for (int i = 0; i < size; i += EVENT_LOAD_ALL_ADN_LIKE_DONE) {
            sendErrorResponse((Message) this.mUserWriteResponse.valueAt(i), "AdnCace reset");
        }
        this.mUserWriteResponse.clear();
    }

    public ArrayList<AdnRecord> getRecordsIfLoaded(int efid) {
        return (ArrayList) this.mAdnLikeFiles.get(efid);
    }

    public int extensionEfForEf(int efid) {
        switch (efid) {
            case IccConstants.EF_PBR /*20272*/:
                return 0;
            case IccConstants.EF_CSIM_LI /*28474*/:
            case IccConstants.EF_MSISDN /*28480*/:
                return IccConstants.EF_EXT1;
            case IccConstants.EF_FDN /*28475*/:
                return IccConstants.EF_EXT2;
            case IccConstants.EF_SDN /*28489*/:
                return IccConstants.EF_EXT3;
            case IccConstants.EF_MBDN /*28615*/:
                return IccConstants.EF_EXT6;
            default:
                return -1;
        }
    }

    private void sendErrorResponse(Message response, String errString) {
        if (response != null) {
            AsyncResult.forMessage(response).exception = new RuntimeException(errString);
            response.sendToTarget();
        }
    }

    public void updateAdnByIndex(int efid, AdnRecord adn, int recordIndex, String pin2, Message response) {
        int extensionEF = extensionEfForEf(efid);
        if (extensionEF < 0) {
            sendErrorResponse(response, "EF is not known ADN-like EF:" + efid);
        } else if (((Message) this.mUserWriteResponse.get(efid)) != null) {
            sendErrorResponse(response, "Have pending update for EF:" + efid);
        } else {
            this.mUserWriteResponse.put(efid, response);
            new AdnRecordLoader(this.mFh).updateEF(adn, efid, extensionEF, recordIndex, pin2, obtainMessage(EVENT_UPDATE_ADN_DONE, efid, recordIndex, adn));
        }
    }

    public void updateAdnBySearch(int efid, AdnRecord oldAdn, AdnRecord newAdn, String pin2, Message response) {
        int extensionEF = extensionEfForEf(efid);
        if (extensionEF < 0) {
            sendErrorResponse(response, "EF is not known ADN-like EF:" + efid);
            return;
        }
        ArrayList<AdnRecord> oldAdnList;
        if (efid == IccConstants.EF_PBR) {
            oldAdnList = this.mUsimPhoneBookManager.loadEfFilesFromUsim();
        } else {
            oldAdnList = getRecordsIfLoaded(efid);
        }
        if (oldAdnList == null) {
            sendErrorResponse(response, "Adn list not exist for EF:" + efid);
            return;
        }
        int index = -1;
        int count = EVENT_LOAD_ALL_ADN_LIKE_DONE;
        Iterator<AdnRecord> it = oldAdnList.iterator();
        while (it.hasNext()) {
            if (oldAdn.isEqual((AdnRecord) it.next())) {
                index = count;
                break;
            }
            count += EVENT_LOAD_ALL_ADN_LIKE_DONE;
        }
        if (index == -1) {
            sendErrorResponse(response, "Adn record don't exist for " + oldAdn);
            return;
        }
        if (efid == IccConstants.EF_PBR) {
            AdnRecord foundAdn = (AdnRecord) oldAdnList.get(index - 1);
            efid = foundAdn.mEfid;
            extensionEF = foundAdn.mExtRecord;
            index = foundAdn.mRecordNumber;
            newAdn.mEfid = efid;
            newAdn.mExtRecord = extensionEF;
            newAdn.mRecordNumber = index;
        }
        if (((Message) this.mUserWriteResponse.get(efid)) != null) {
            sendErrorResponse(response, "Have pending update for EF:" + efid);
            return;
        }
        this.mUserWriteResponse.put(efid, response);
        new AdnRecordLoader(this.mFh).updateEF(newAdn, efid, extensionEF, index, pin2, obtainMessage(EVENT_UPDATE_ADN_DONE, efid, index, newAdn));
    }

    public void requestLoadAllAdnLike(int efid, int extensionEf, Message response) {
        ArrayList<AdnRecord> result;
        if (efid == IccConstants.EF_PBR) {
            result = this.mUsimPhoneBookManager.loadEfFilesFromUsim();
        } else {
            result = getRecordsIfLoaded(efid);
        }
        if (result == null) {
            ArrayList<Message> waiters = (ArrayList) this.mAdnLikeWaiters.get(efid);
            if (waiters != null) {
                waiters.add(response);
                return;
            }
            waiters = new ArrayList();
            waiters.add(response);
            this.mAdnLikeWaiters.put(efid, waiters);
            if (extensionEf >= 0) {
                new AdnRecordLoader(this.mFh).loadAllFromEF(efid, extensionEf, obtainMessage(EVENT_LOAD_ALL_ADN_LIKE_DONE, efid, 0));
            } else if (response != null) {
                AsyncResult.forMessage(response).exception = new RuntimeException("EF is not known ADN-like EF:" + efid);
                response.sendToTarget();
            }
        } else if (response != null) {
            AsyncResult.forMessage(response).result = result;
            response.sendToTarget();
        }
    }

    private void notifyWaiters(ArrayList<Message> waiters, AsyncResult ar) {
        if (waiters != null) {
            int s = waiters.size();
            for (int i = 0; i < s; i += EVENT_LOAD_ALL_ADN_LIKE_DONE) {
                Message waiter = (Message) waiters.get(i);
                AsyncResult.forMessage(waiter, ar.result, ar.exception);
                waiter.sendToTarget();
            }
        }
    }

    public void handleMessage(Message msg) {
        AsyncResult ar;
        int efid;
        switch (msg.what) {
            case EVENT_LOAD_ALL_ADN_LIKE_DONE /*1*/:
                ar = msg.obj;
                efid = msg.arg1;
                ArrayList<Message> waiters = (ArrayList) this.mAdnLikeWaiters.get(efid);
                this.mAdnLikeWaiters.delete(efid);
                if (ar.exception == null) {
                    this.mAdnLikeFiles.put(efid, (ArrayList) ar.result);
                }
                notifyWaiters(waiters, ar);
            case EVENT_UPDATE_ADN_DONE /*2*/:
                ar = (AsyncResult) msg.obj;
                efid = msg.arg1;
                int index = msg.arg2;
                AdnRecord adn = (AdnRecord) ar.userObj;
                if (ar.exception == null) {
                    ((ArrayList) this.mAdnLikeFiles.get(efid)).set(index - 1, adn);
                    this.mUsimPhoneBookManager.invalidateCache();
                }
                Message response = (Message) this.mUserWriteResponse.get(efid);
                this.mUserWriteResponse.delete(efid);
                AsyncResult.forMessage(response, null, ar.exception);
                response.sendToTarget();
            default:
        }
    }
}
