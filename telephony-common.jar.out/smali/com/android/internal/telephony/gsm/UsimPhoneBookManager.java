package com.android.internal.telephony.gsm;

import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.telephony.Rlog;
import com.android.internal.telephony.uicc.AdnRecord;
import com.android.internal.telephony.uicc.AdnRecordCache;
import com.android.internal.telephony.uicc.IccConstants;
import com.android.internal.telephony.uicc.IccFileHandler;
import com.android.internal.telephony.uicc.IccUtils;
import com.google.android.mms.pdu.PduHeaders;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class UsimPhoneBookManager extends Handler implements IccConstants {
    private static final boolean DBG = true;
    private static final int EVENT_EMAIL_LOAD_DONE = 4;
    private static final int EVENT_IAP_LOAD_DONE = 3;
    private static final int EVENT_PBR_LOAD_DONE = 1;
    private static final int EVENT_USIM_ADN_LOAD_DONE = 2;
    private static final String LOG_TAG = "UsimPhoneBookManager";
    private static final int USIM_EFAAS_TAG = 199;
    private static final int USIM_EFADN_TAG = 192;
    private static final int USIM_EFANR_TAG = 196;
    private static final int USIM_EFCCP1_TAG = 203;
    private static final int USIM_EFEMAIL_TAG = 202;
    private static final int USIM_EFEXT1_TAG = 194;
    private static final int USIM_EFGRP_TAG = 198;
    private static final int USIM_EFGSD_TAG = 200;
    private static final int USIM_EFIAP_TAG = 193;
    private static final int USIM_EFPBC_TAG = 197;
    private static final int USIM_EFSNE_TAG = 195;
    private static final int USIM_EFUID_TAG = 201;
    private static final int USIM_TYPE1_TAG = 168;
    private static final int USIM_TYPE2_TAG = 169;
    private static final int USIM_TYPE3_TAG = 170;
    private AdnRecordCache mAdnCache;
    private ArrayList<byte[]> mEmailFileRecord;
    private boolean mEmailPresentInIap;
    private int mEmailTagNumberInIap;
    private Map<Integer, ArrayList<String>> mEmailsForAdnRec;
    private IccFileHandler mFh;
    private ArrayList<byte[]> mIapFileRecord;
    private Boolean mIsPbrPresent;
    private Object mLock;
    private PbrFile mPbrFile;
    private ArrayList<AdnRecord> mPhoneBookRecords;
    private boolean mRefreshCache;

    private class PbrFile {
        HashMap<Integer, Map<Integer, Integer>> mFileIds;

        PbrFile(ArrayList<byte[]> records) {
            this.mFileIds = new HashMap();
            int recNum = 0;
            Iterator i$ = records.iterator();
            while (i$.hasNext()) {
                byte[] record = (byte[]) i$.next();
                parseTag(new SimTlv(record, 0, record.length), recNum);
                recNum += UsimPhoneBookManager.EVENT_PBR_LOAD_DONE;
            }
        }

        void parseTag(SimTlv tlv, int recNum) {
            Map<Integer, Integer> val = new HashMap();
            do {
                int tag = tlv.getTag();
                switch (tag) {
                    case UsimPhoneBookManager.USIM_TYPE1_TAG /*168*/:
                    case UsimPhoneBookManager.USIM_TYPE2_TAG /*169*/:
                    case UsimPhoneBookManager.USIM_TYPE3_TAG /*170*/:
                        byte[] data = tlv.getData();
                        parseEf(new SimTlv(data, 0, data.length), val, tag);
                        break;
                }
            } while (tlv.nextObject());
            this.mFileIds.put(Integer.valueOf(recNum), val);
        }

        void parseEf(SimTlv tlv, Map<Integer, Integer> val, int parentTag) {
            int tagNumberWithinParentTag = 0;
            do {
                int tag = tlv.getTag();
                if (parentTag == UsimPhoneBookManager.USIM_TYPE2_TAG && tag == UsimPhoneBookManager.USIM_EFEMAIL_TAG) {
                    UsimPhoneBookManager.this.mEmailPresentInIap = UsimPhoneBookManager.DBG;
                    UsimPhoneBookManager.this.mEmailTagNumberInIap = tagNumberWithinParentTag;
                }
                switch (tag) {
                    case UsimPhoneBookManager.USIM_EFADN_TAG /*192*/:
                    case UsimPhoneBookManager.USIM_EFIAP_TAG /*193*/:
                    case UsimPhoneBookManager.USIM_EFEXT1_TAG /*194*/:
                    case UsimPhoneBookManager.USIM_EFSNE_TAG /*195*/:
                    case UsimPhoneBookManager.USIM_EFANR_TAG /*196*/:
                    case UsimPhoneBookManager.USIM_EFPBC_TAG /*197*/:
                    case UsimPhoneBookManager.USIM_EFGRP_TAG /*198*/:
                    case UsimPhoneBookManager.USIM_EFAAS_TAG /*199*/:
                    case UsimPhoneBookManager.USIM_EFGSD_TAG /*200*/:
                    case UsimPhoneBookManager.USIM_EFUID_TAG /*201*/:
                    case UsimPhoneBookManager.USIM_EFEMAIL_TAG /*202*/:
                    case UsimPhoneBookManager.USIM_EFCCP1_TAG /*203*/:
                        byte[] data = tlv.getData();
                        val.put(Integer.valueOf(tag), Integer.valueOf(((data[0] & PduHeaders.STORE_STATUS_ERROR_END) << 8) | (data[UsimPhoneBookManager.EVENT_PBR_LOAD_DONE] & PduHeaders.STORE_STATUS_ERROR_END)));
                        break;
                }
                tagNumberWithinParentTag += UsimPhoneBookManager.EVENT_PBR_LOAD_DONE;
            } while (tlv.nextObject());
        }
    }

    public UsimPhoneBookManager(IccFileHandler fh, AdnRecordCache cache) {
        this.mLock = new Object();
        this.mEmailPresentInIap = false;
        this.mEmailTagNumberInIap = 0;
        this.mRefreshCache = false;
        this.mFh = fh;
        this.mPhoneBookRecords = new ArrayList();
        this.mPbrFile = null;
        this.mIsPbrPresent = Boolean.valueOf(DBG);
        this.mAdnCache = cache;
    }

    public void reset() {
        this.mPhoneBookRecords.clear();
        this.mIapFileRecord = null;
        this.mEmailFileRecord = null;
        this.mPbrFile = null;
        this.mIsPbrPresent = Boolean.valueOf(DBG);
        this.mRefreshCache = false;
    }

    public ArrayList<AdnRecord> loadEfFilesFromUsim() {
        synchronized (this.mLock) {
            if (!this.mPhoneBookRecords.isEmpty()) {
                if (this.mRefreshCache) {
                    this.mRefreshCache = false;
                    refreshCache();
                }
                ArrayList<AdnRecord> arrayList = this.mPhoneBookRecords;
                return arrayList;
            } else if (this.mIsPbrPresent.booleanValue()) {
                if (this.mPbrFile == null) {
                    readPbrFileAndWait();
                }
                if (this.mPbrFile == null) {
                    return null;
                }
                int numRecs = this.mPbrFile.mFileIds.size();
                for (int i = 0; i < numRecs; i += EVENT_PBR_LOAD_DONE) {
                    readAdnFileAndWait(i);
                    readEmailFileAndWait(i);
                }
                return this.mPhoneBookRecords;
            } else {
                return null;
            }
        }
    }

    private void refreshCache() {
        if (this.mPbrFile != null) {
            this.mPhoneBookRecords.clear();
            int numRecs = this.mPbrFile.mFileIds.size();
            for (int i = 0; i < numRecs; i += EVENT_PBR_LOAD_DONE) {
                readAdnFileAndWait(i);
            }
        }
    }

    public void invalidateCache() {
        this.mRefreshCache = DBG;
    }

    private void readPbrFileAndWait() {
        this.mFh.loadEFLinearFixedAll(IccConstants.EF_PBR, obtainMessage(EVENT_PBR_LOAD_DONE));
        try {
            this.mLock.wait();
        } catch (InterruptedException e) {
            Rlog.e(LOG_TAG, "Interrupted Exception in readAdnFileAndWait");
        }
    }

    private void readEmailFileAndWait(int recNum) {
        Map<Integer, Integer> fileIds = (Map) this.mPbrFile.mFileIds.get(Integer.valueOf(recNum));
        if (fileIds != null && fileIds.containsKey(Integer.valueOf(USIM_EFEMAIL_TAG))) {
            int efid = ((Integer) fileIds.get(Integer.valueOf(USIM_EFEMAIL_TAG))).intValue();
            if (this.mEmailPresentInIap) {
                readIapFileAndWait(((Integer) fileIds.get(Integer.valueOf(USIM_EFIAP_TAG))).intValue());
                if (this.mIapFileRecord == null) {
                    Rlog.e(LOG_TAG, "Error: IAP file is empty");
                    return;
                }
            }
            this.mFh.loadEFLinearFixedAll(((Integer) fileIds.get(Integer.valueOf(USIM_EFEMAIL_TAG))).intValue(), obtainMessage(EVENT_EMAIL_LOAD_DONE));
            try {
                this.mLock.wait();
            } catch (InterruptedException e) {
                Rlog.e(LOG_TAG, "Interrupted Exception in readEmailFileAndWait");
            }
            if (this.mEmailFileRecord == null) {
                Rlog.e(LOG_TAG, "Error: Email file is empty");
            } else {
                updatePhoneAdnRecord();
            }
        }
    }

    private void readIapFileAndWait(int efid) {
        this.mFh.loadEFLinearFixedAll(efid, obtainMessage(EVENT_IAP_LOAD_DONE));
        try {
            this.mLock.wait();
        } catch (InterruptedException e) {
            Rlog.e(LOG_TAG, "Interrupted Exception in readIapFileAndWait");
        }
    }

    private void updatePhoneAdnRecord() {
        if (this.mEmailFileRecord != null) {
            int i;
            String[] emails;
            AdnRecord rec;
            int numAdnRecs = this.mPhoneBookRecords.size();
            if (this.mIapFileRecord != null) {
                i = 0;
                while (i < numAdnRecs) {
                    try {
                        int recNum = ((byte[]) this.mIapFileRecord.get(i))[this.mEmailTagNumberInIap];
                        if (recNum != -1) {
                            emails = new String[EVENT_PBR_LOAD_DONE];
                            emails[0] = readEmailRecord(recNum - 1);
                            rec = (AdnRecord) this.mPhoneBookRecords.get(i);
                            if (rec != null) {
                                rec.setEmails(emails);
                            } else {
                                rec = new AdnRecord("", "", emails);
                            }
                            this.mPhoneBookRecords.set(i, rec);
                        }
                        i += EVENT_PBR_LOAD_DONE;
                    } catch (IndexOutOfBoundsException e) {
                        Rlog.e(LOG_TAG, "Error: Improper ICC card: No IAP record for ADN, continuing");
                    }
                }
            }
            int len = this.mPhoneBookRecords.size();
            if (this.mEmailsForAdnRec == null) {
                parseType1EmailFile(len);
            }
            i = 0;
            while (i < numAdnRecs) {
                try {
                    ArrayList<String> emailList = (ArrayList) this.mEmailsForAdnRec.get(Integer.valueOf(i));
                    if (emailList != null) {
                        rec = (AdnRecord) this.mPhoneBookRecords.get(i);
                        emails = new String[emailList.size()];
                        System.arraycopy(emailList.toArray(), 0, emails, 0, emailList.size());
                        rec.setEmails(emails);
                        this.mPhoneBookRecords.set(i, rec);
                    }
                    i += EVENT_PBR_LOAD_DONE;
                } catch (IndexOutOfBoundsException e2) {
                    return;
                }
            }
        }
    }

    void parseType1EmailFile(int numRecs) {
        this.mEmailsForAdnRec = new HashMap();
        int i = 0;
        while (i < numRecs) {
            try {
                byte[] emailRec = (byte[]) this.mEmailFileRecord.get(i);
                int adnRecNum = emailRec[emailRec.length - 1];
                if (adnRecNum != -1) {
                    String email = readEmailRecord(i);
                    if (!(email == null || email.equals(""))) {
                        ArrayList<String> val = (ArrayList) this.mEmailsForAdnRec.get(Integer.valueOf(adnRecNum - 1));
                        if (val == null) {
                            val = new ArrayList();
                        }
                        val.add(email);
                        this.mEmailsForAdnRec.put(Integer.valueOf(adnRecNum - 1), val);
                    }
                }
                i += EVENT_PBR_LOAD_DONE;
            } catch (IndexOutOfBoundsException e) {
                Rlog.e(LOG_TAG, "Error: Improper ICC card: No email record for ADN, continuing");
                return;
            }
        }
    }

    private String readEmailRecord(int recNum) {
        try {
            byte[] emailRec = (byte[]) this.mEmailFileRecord.get(recNum);
            return IccUtils.adnStringFieldToString(emailRec, 0, emailRec.length - 2);
        } catch (IndexOutOfBoundsException e) {
            return null;
        }
    }

    private void readAdnFileAndWait(int recNum) {
        Map<Integer, Integer> fileIds = (Map) this.mPbrFile.mFileIds.get(Integer.valueOf(recNum));
        if (fileIds != null && !fileIds.isEmpty()) {
            int extEf = 0;
            if (fileIds.containsKey(Integer.valueOf(USIM_EFEXT1_TAG))) {
                extEf = ((Integer) fileIds.get(Integer.valueOf(USIM_EFEXT1_TAG))).intValue();
            }
            this.mAdnCache.requestLoadAllAdnLike(((Integer) fileIds.get(Integer.valueOf(USIM_EFADN_TAG))).intValue(), extEf, obtainMessage(EVENT_USIM_ADN_LOAD_DONE));
            try {
                this.mLock.wait();
            } catch (InterruptedException e) {
                Rlog.e(LOG_TAG, "Interrupted Exception in readAdnFileAndWait");
            }
        }
    }

    private void createPbrFile(ArrayList<byte[]> records) {
        if (records == null) {
            this.mPbrFile = null;
            this.mIsPbrPresent = Boolean.valueOf(false);
            return;
        }
        this.mPbrFile = new PbrFile(records);
    }

    public void handleMessage(Message msg) {
        AsyncResult ar;
        switch (msg.what) {
            case EVENT_PBR_LOAD_DONE /*1*/:
                ar = msg.obj;
                if (ar.exception == null) {
                    createPbrFile((ArrayList) ar.result);
                }
                synchronized (this.mLock) {
                    this.mLock.notify();
                    break;
                }
            case EVENT_USIM_ADN_LOAD_DONE /*2*/:
                log("Loading USIM ADN records done");
                ar = (AsyncResult) msg.obj;
                if (ar.exception == null) {
                    this.mPhoneBookRecords.addAll((ArrayList) ar.result);
                }
                synchronized (this.mLock) {
                    this.mLock.notify();
                    break;
                }
            case EVENT_IAP_LOAD_DONE /*3*/:
                log("Loading USIM IAP records done");
                ar = (AsyncResult) msg.obj;
                if (ar.exception == null) {
                    this.mIapFileRecord = (ArrayList) ar.result;
                }
                synchronized (this.mLock) {
                    this.mLock.notify();
                    break;
                }
            case EVENT_EMAIL_LOAD_DONE /*4*/:
                log("Loading USIM Email records done");
                ar = (AsyncResult) msg.obj;
                if (ar.exception == null) {
                    this.mEmailFileRecord = (ArrayList) ar.result;
                }
                synchronized (this.mLock) {
                    this.mLock.notify();
                    break;
                }
            default:
        }
    }

    private void log(String msg) {
        Rlog.d(LOG_TAG, msg);
    }
}
