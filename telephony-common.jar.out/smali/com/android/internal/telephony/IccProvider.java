package com.android.internal.telephony;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.UriMatcher;
import android.database.Cursor;
import android.database.MatrixCursor;
import android.database.MergeCursor;
import android.net.Uri;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.provider.Telephony.Mms.Part;
import android.telephony.Rlog;
import android.telephony.SubscriptionInfo;
import android.telephony.SubscriptionManager;
import android.text.TextUtils;
import com.android.internal.telephony.IIccPhoneBook.Stub;
import com.android.internal.telephony.uicc.AdnRecord;
import com.android.internal.telephony.uicc.IccConstants;
import java.util.List;

public class IccProvider extends ContentProvider {
    private static final String[] ADDRESS_BOOK_COLUMN_NAMES;
    protected static final int ADN = 1;
    protected static final int ADN_ALL = 7;
    protected static final int ADN_SUB = 2;
    private static final boolean DBG = true;
    protected static final int FDN = 3;
    protected static final int FDN_SUB = 4;
    protected static final int SDN = 5;
    protected static final int SDN_SUB = 6;
    protected static final String STR_EMAILS = "emails";
    protected static final String STR_NUMBER = "number";
    protected static final String STR_PIN2 = "pin2";
    protected static final String STR_TAG = "tag";
    private static final String TAG = "IccProvider";
    private static final UriMatcher URL_MATCHER;
    private SubscriptionManager mSubscriptionManager;

    static {
        String[] strArr = new String[FDN_SUB];
        strArr[0] = Part.NAME;
        strArr[ADN] = STR_NUMBER;
        strArr[ADN_SUB] = STR_EMAILS;
        strArr[FDN] = HbpcdLookup.ID;
        ADDRESS_BOOK_COLUMN_NAMES = strArr;
        URL_MATCHER = new UriMatcher(-1);
        URL_MATCHER.addURI("icc", "adn", ADN);
        URL_MATCHER.addURI("icc", "adn/subId/#", ADN_SUB);
        URL_MATCHER.addURI("icc", "fdn", FDN);
        URL_MATCHER.addURI("icc", "fdn/subId/#", FDN_SUB);
        URL_MATCHER.addURI("icc", "sdn", SDN);
        URL_MATCHER.addURI("icc", "sdn/subId/#", SDN_SUB);
    }

    public boolean onCreate() {
        this.mSubscriptionManager = SubscriptionManager.from(getContext());
        return DBG;
    }

    public Cursor query(Uri url, String[] projection, String selection, String[] selectionArgs, String sort) {
        log("query");
        switch (URL_MATCHER.match(url)) {
            case ADN /*1*/:
                return loadFromEf(IccConstants.EF_CSIM_LI, SubscriptionManager.getDefaultSubId());
            case ADN_SUB /*2*/:
                return loadFromEf(IccConstants.EF_CSIM_LI, getRequestSubId(url));
            case FDN /*3*/:
                return loadFromEf(IccConstants.EF_FDN, SubscriptionManager.getDefaultSubId());
            case FDN_SUB /*4*/:
                return loadFromEf(IccConstants.EF_FDN, getRequestSubId(url));
            case SDN /*5*/:
                return loadFromEf(IccConstants.EF_SDN, SubscriptionManager.getDefaultSubId());
            case SDN_SUB /*6*/:
                return loadFromEf(IccConstants.EF_SDN, getRequestSubId(url));
            case ADN_ALL /*7*/:
                return loadAllSimContacts(IccConstants.EF_CSIM_LI);
            default:
                throw new IllegalArgumentException("Unknown URL " + url);
        }
    }

    private Cursor loadAllSimContacts(int efType) {
        Cursor[] result;
        List<SubscriptionInfo> subInfoList = this.mSubscriptionManager.getActiveSubscriptionInfoList();
        if (subInfoList == null || subInfoList.size() == 0) {
            result = new Cursor[0];
        } else {
            int subIdCount = subInfoList.size();
            result = new Cursor[subIdCount];
            for (int i = 0; i < subIdCount; i += ADN) {
                int subId = ((SubscriptionInfo) subInfoList.get(i)).getSubscriptionId();
                result[i] = loadFromEf(efType, subId);
                Rlog.i(TAG, "ADN Records loaded for Subscription ::" + subId);
            }
        }
        return new MergeCursor(result);
    }

    public String getType(Uri url) {
        switch (URL_MATCHER.match(url)) {
            case ADN /*1*/:
            case ADN_SUB /*2*/:
            case FDN /*3*/:
            case FDN_SUB /*4*/:
            case SDN /*5*/:
            case SDN_SUB /*6*/:
            case ADN_ALL /*7*/:
                return "vnd.android.cursor.dir/sim-contact";
            default:
                throw new IllegalArgumentException("Unknown URL " + url);
        }
    }

    public Uri insert(Uri url, ContentValues initialValues) {
        int efType;
        int subId;
        String pin2 = null;
        log("insert");
        int match = URL_MATCHER.match(url);
        switch (match) {
            case ADN /*1*/:
                efType = IccConstants.EF_CSIM_LI;
                subId = SubscriptionManager.getDefaultSubId();
                break;
            case ADN_SUB /*2*/:
                efType = IccConstants.EF_CSIM_LI;
                subId = getRequestSubId(url);
                break;
            case FDN /*3*/:
                efType = IccConstants.EF_FDN;
                subId = SubscriptionManager.getDefaultSubId();
                pin2 = initialValues.getAsString(STR_PIN2);
                break;
            case FDN_SUB /*4*/:
                efType = IccConstants.EF_FDN;
                subId = getRequestSubId(url);
                pin2 = initialValues.getAsString(STR_PIN2);
                break;
            default:
                throw new UnsupportedOperationException("Cannot insert into URL: " + url);
        }
        if (!addIccRecordToEf(efType, initialValues.getAsString(STR_TAG), initialValues.getAsString(STR_NUMBER), null, pin2, subId)) {
            return null;
        }
        StringBuilder buf = new StringBuilder("content://icc/");
        switch (match) {
            case ADN /*1*/:
                buf.append("adn/");
                break;
            case ADN_SUB /*2*/:
                buf.append("adn/subId/");
                break;
            case FDN /*3*/:
                buf.append("fdn/");
                break;
            case FDN_SUB /*4*/:
                buf.append("fdn/subId/");
                break;
        }
        buf.append(0);
        Uri resultUri = Uri.parse(buf.toString());
        getContext().getContentResolver().notifyChange(url, null);
        return resultUri;
    }

    private String normalizeValue(String inVal) {
        int len = inVal.length();
        if (len == 0) {
            log("len of input String is 0");
            return inVal;
        }
        String retVal = inVal;
        if (inVal.charAt(0) == '\'' && inVal.charAt(len - 1) == '\'') {
            retVal = inVal.substring(ADN, len - 1);
        }
        return retVal;
    }

    public int delete(Uri url, String where, String[] whereArgs) {
        int efType;
        int subId;
        switch (URL_MATCHER.match(url)) {
            case ADN /*1*/:
                efType = IccConstants.EF_CSIM_LI;
                subId = SubscriptionManager.getDefaultSubId();
                break;
            case ADN_SUB /*2*/:
                efType = IccConstants.EF_CSIM_LI;
                subId = getRequestSubId(url);
                break;
            case FDN /*3*/:
                efType = IccConstants.EF_FDN;
                subId = SubscriptionManager.getDefaultSubId();
                break;
            case FDN_SUB /*4*/:
                efType = IccConstants.EF_FDN;
                subId = getRequestSubId(url);
                break;
            default:
                throw new UnsupportedOperationException("Cannot insert into URL: " + url);
        }
        log("delete");
        String tag = null;
        String number = null;
        String[] emails = null;
        String pin2 = null;
        String[] tokens = where.split("AND");
        int n = tokens.length;
        while (true) {
            n--;
            if (n >= 0) {
                String param = tokens[n];
                String str = "'";
                log("parsing '" + param + r17);
                String[] pair = param.split("=");
                if (pair.length != ADN_SUB) {
                    Rlog.e(TAG, "resolve: bad whereClause parameter: " + param);
                } else {
                    String key = pair[0].trim();
                    String val = pair[ADN].trim();
                    if (STR_TAG.equals(key)) {
                        tag = normalizeValue(val);
                    } else if (STR_NUMBER.equals(key)) {
                        number = normalizeValue(val);
                    } else if (STR_EMAILS.equals(key)) {
                        emails = null;
                    } else if (STR_PIN2.equals(key)) {
                        pin2 = normalizeValue(val);
                    }
                }
            } else if (efType == FDN && TextUtils.isEmpty(pin2)) {
                return 0;
            } else {
                if (!deleteIccRecordFromEf(efType, tag, number, emails, pin2, subId)) {
                    return 0;
                }
                getContext().getContentResolver().notifyChange(url, null);
                return ADN;
            }
        }
    }

    public int update(Uri url, ContentValues values, String where, String[] whereArgs) {
        int efType;
        int subId;
        String pin2 = null;
        log("update");
        switch (URL_MATCHER.match(url)) {
            case ADN /*1*/:
                efType = IccConstants.EF_CSIM_LI;
                subId = SubscriptionManager.getDefaultSubId();
                break;
            case ADN_SUB /*2*/:
                efType = IccConstants.EF_CSIM_LI;
                subId = getRequestSubId(url);
                break;
            case FDN /*3*/:
                efType = IccConstants.EF_FDN;
                subId = SubscriptionManager.getDefaultSubId();
                pin2 = values.getAsString(STR_PIN2);
                break;
            case FDN_SUB /*4*/:
                efType = IccConstants.EF_FDN;
                subId = getRequestSubId(url);
                pin2 = values.getAsString(STR_PIN2);
                break;
            default:
                throw new UnsupportedOperationException("Cannot insert into URL: " + url);
        }
        if (!updateIccRecordInEf(efType, values.getAsString(STR_TAG), values.getAsString(STR_NUMBER), values.getAsString("newTag"), values.getAsString("newNumber"), pin2, subId)) {
            return 0;
        }
        getContext().getContentResolver().notifyChange(url, null);
        return ADN;
    }

    private MatrixCursor loadFromEf(int efType, int subId) {
        log("loadFromEf: efType=" + efType + ", subscription=" + subId);
        List<AdnRecord> adnRecords = null;
        try {
            IIccPhoneBook iccIpb = Stub.asInterface(ServiceManager.getService("simphonebook"));
            if (iccIpb != null) {
                adnRecords = iccIpb.getAdnRecordsInEfForSubscriber(subId, efType);
            }
        } catch (RemoteException e) {
        } catch (SecurityException ex) {
            log(ex.toString());
        }
        if (adnRecords != null) {
            int N = adnRecords.size();
            MatrixCursor matrixCursor = new MatrixCursor(ADDRESS_BOOK_COLUMN_NAMES, N);
            log("adnRecords.size=" + N);
            for (int i = 0; i < N; i += ADN) {
                loadRecord((AdnRecord) adnRecords.get(i), matrixCursor, i);
            }
            return matrixCursor;
        }
        Rlog.w(TAG, "Cannot load ADN records");
        return new MatrixCursor(ADDRESS_BOOK_COLUMN_NAMES);
    }

    private boolean addIccRecordToEf(int efType, String name, String number, String[] emails, String pin2, int subId) {
        log("addIccRecordToEf: efType=" + efType + ", name=" + name + ", number=" + number + ", emails=" + emails + ", subscription=" + subId);
        boolean success = false;
        try {
            IIccPhoneBook iccIpb = Stub.asInterface(ServiceManager.getService("simphonebook"));
            if (iccIpb != null) {
                success = iccIpb.updateAdnRecordsInEfBySearchForSubscriber(subId, efType, "", "", name, number, pin2);
            }
        } catch (RemoteException e) {
        } catch (SecurityException ex) {
            log(ex.toString());
        }
        log("addIccRecordToEf: " + success);
        return success;
    }

    private boolean updateIccRecordInEf(int efType, String oldName, String oldNumber, String newName, String newNumber, String pin2, int subId) {
        log("updateIccRecordInEf: efType=" + efType + ", oldname=" + oldName + ", oldnumber=" + oldNumber + ", newname=" + newName + ", newnumber=" + newNumber + ", subscription=" + subId);
        boolean success = false;
        try {
            IIccPhoneBook iccIpb = Stub.asInterface(ServiceManager.getService("simphonebook"));
            if (iccIpb != null) {
                success = iccIpb.updateAdnRecordsInEfBySearchForSubscriber(subId, efType, oldName, oldNumber, newName, newNumber, pin2);
            }
        } catch (RemoteException e) {
        } catch (SecurityException ex) {
            log(ex.toString());
        }
        log("updateIccRecordInEf: " + success);
        return success;
    }

    private boolean deleteIccRecordFromEf(int efType, String name, String number, String[] emails, String pin2, int subId) {
        log("deleteIccRecordFromEf: efType=" + efType + ", name=" + name + ", number=" + number + ", emails=" + emails + ", pin2=" + pin2 + ", subscription=" + subId);
        boolean success = false;
        try {
            IIccPhoneBook iccIpb = Stub.asInterface(ServiceManager.getService("simphonebook"));
            if (iccIpb != null) {
                success = iccIpb.updateAdnRecordsInEfBySearchForSubscriber(subId, efType, name, number, "", "", pin2);
            }
        } catch (RemoteException e) {
        } catch (SecurityException ex) {
            log(ex.toString());
        }
        log("deleteIccRecordFromEf: " + success);
        return success;
    }

    private void loadRecord(AdnRecord record, MatrixCursor cursor, int id) {
        if (!record.isEmpty()) {
            Object[] contact = new Object[FDN_SUB];
            String alphaTag = record.getAlphaTag();
            String number = record.getNumber();
            log("loadRecord: " + alphaTag + ", " + number + ",");
            contact[0] = alphaTag;
            contact[ADN] = number;
            String[] emails = record.getEmails();
            if (emails != null) {
                StringBuilder emailString = new StringBuilder();
                String[] arr$ = emails;
                int len$ = arr$.length;
                for (int i$ = 0; i$ < len$; i$ += ADN) {
                    String email = arr$[i$];
                    log("Adding email:" + email);
                    emailString.append(email);
                    emailString.append(",");
                }
                contact[ADN_SUB] = emailString.toString();
            }
            contact[FDN] = Integer.valueOf(id);
            cursor.addRow(contact);
        }
    }

    private void log(String msg) {
        Rlog.d(TAG, "[IccProvider] " + msg);
    }

    private int getRequestSubId(Uri url) {
        log("getRequestSubId url: " + url);
        try {
            return Integer.parseInt(url.getLastPathSegment());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Unknown URL " + url);
        }
    }
}
