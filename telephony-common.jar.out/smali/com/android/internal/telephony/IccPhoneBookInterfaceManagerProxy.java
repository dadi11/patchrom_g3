package com.android.internal.telephony;

import com.android.internal.telephony.uicc.AdnRecord;
import java.util.List;

public class IccPhoneBookInterfaceManagerProxy {
    private IccPhoneBookInterfaceManager mIccPhoneBookInterfaceManager;

    public IccPhoneBookInterfaceManagerProxy(IccPhoneBookInterfaceManager iccPhoneBookInterfaceManager) {
        this.mIccPhoneBookInterfaceManager = iccPhoneBookInterfaceManager;
    }

    public void setmIccPhoneBookInterfaceManager(IccPhoneBookInterfaceManager iccPhoneBookInterfaceManager) {
        this.mIccPhoneBookInterfaceManager = iccPhoneBookInterfaceManager;
    }

    public boolean updateAdnRecordsInEfBySearch(int efid, String oldTag, String oldPhoneNumber, String newTag, String newPhoneNumber, String pin2) {
        return this.mIccPhoneBookInterfaceManager.updateAdnRecordsInEfBySearch(efid, oldTag, oldPhoneNumber, newTag, newPhoneNumber, pin2);
    }

    public boolean updateAdnRecordsInEfByIndex(int efid, String newTag, String newPhoneNumber, int index, String pin2) {
        return this.mIccPhoneBookInterfaceManager.updateAdnRecordsInEfByIndex(efid, newTag, newPhoneNumber, index, pin2);
    }

    public int[] getAdnRecordsSize(int efid) {
        return this.mIccPhoneBookInterfaceManager.getAdnRecordsSize(efid);
    }

    public List<AdnRecord> getAdnRecordsInEf(int efid) {
        return this.mIccPhoneBookInterfaceManager.getAdnRecordsInEf(efid);
    }
}
