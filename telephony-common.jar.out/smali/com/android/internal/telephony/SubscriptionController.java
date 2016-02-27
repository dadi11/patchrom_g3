package com.android.internal.telephony;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Binder;
import android.os.Process;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.UserHandle;
import android.provider.Settings.Global;
import android.provider.Telephony.Carriers;
import android.telephony.RadioAccessFamily;
import android.telephony.Rlog;
import android.telephony.SubscriptionInfo;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.text.format.Time;
import android.util.Log;
import com.android.internal.telephony.ISub.Stub;
import com.android.internal.telephony.IccCardConstants.State;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

public class SubscriptionController extends Stub {
    static final boolean DBG = true;
    static final String LOG_TAG = "SubscriptionController";
    static final int MAX_LOCAL_LOG_LINES = 500;
    static final boolean VDBG = false;
    private static int mDefaultFallbackSubId;
    private static int mDefaultPhoneId;
    private static HashMap<Integer, Integer> mSlotIdxToSubId;
    private static SubscriptionController sInstance;
    protected static PhoneProxy[] sProxyPhones;
    private int[] colorArr;
    protected CallManager mCM;
    protected Context mContext;
    private ScLocalLog mLocalLog;
    protected final Object mLock;
    protected TelephonyManager mTelephonyManager;

    /* renamed from: com.android.internal.telephony.SubscriptionController.1 */
    class C00211 implements Comparator<SubscriptionInfo> {
        C00211() {
        }

        public int compare(SubscriptionInfo arg0, SubscriptionInfo arg1) {
            int flag = arg0.getSimSlotIndex() - arg1.getSimSlotIndex();
            if (flag == 0) {
                return arg0.getSubscriptionId() - arg1.getSubscriptionId();
            }
            return flag;
        }
    }

    static class ScLocalLog {
        private LinkedList<String> mLog;
        private int mMaxLines;
        private Time mNow;

        public ScLocalLog(int maxLines) {
            this.mLog = new LinkedList();
            this.mMaxLines = maxLines;
            this.mNow = new Time();
        }

        public synchronized void log(String msg) {
            if (this.mMaxLines > 0) {
                int pid = Process.myPid();
                int tid = Process.myTid();
                this.mNow.setToNow();
                this.mLog.add(this.mNow.format("%m-%d %H:%M:%S") + " pid=" + pid + " tid=" + tid + " " + msg);
                while (this.mLog.size() > this.mMaxLines) {
                    this.mLog.remove();
                }
            }
        }

        public synchronized void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            Iterator<String> itr = this.mLog.listIterator(0);
            int i = 0;
            while (itr.hasNext()) {
                int i2 = i + 1;
                pw.println(Integer.toString(i) + ": " + ((String) itr.next()));
                if (i2 % 10 == 0) {
                    pw.flush();
                    i = i2;
                } else {
                    i = i2;
                }
            }
        }
    }

    static {
        sInstance = null;
        mSlotIdxToSubId = new HashMap();
        mDefaultFallbackSubId = -1;
        mDefaultPhoneId = Integer.MAX_VALUE;
    }

    public static SubscriptionController init(Phone phone) {
        SubscriptionController subscriptionController;
        synchronized (SubscriptionController.class) {
            if (sInstance == null) {
                sInstance = new SubscriptionController(phone);
            } else {
                Log.wtf(LOG_TAG, "init() called multiple times!  sInstance = " + sInstance);
            }
            subscriptionController = sInstance;
        }
        return subscriptionController;
    }

    public static SubscriptionController init(Context c, CommandsInterface[] ci) {
        SubscriptionController subscriptionController;
        synchronized (SubscriptionController.class) {
            if (sInstance == null) {
                sInstance = new SubscriptionController(c);
            } else {
                Log.wtf(LOG_TAG, "init() called multiple times!  sInstance = " + sInstance);
            }
            subscriptionController = sInstance;
        }
        return subscriptionController;
    }

    public static SubscriptionController getInstance() {
        if (sInstance == null) {
            Log.wtf(LOG_TAG, "getInstance null");
        }
        return sInstance;
    }

    private SubscriptionController(Context c) {
        this.mLocalLog = new ScLocalLog(MAX_LOCAL_LOG_LINES);
        this.mLock = new Object();
        this.mContext = c;
        this.mCM = CallManager.getInstance();
        this.mTelephonyManager = TelephonyManager.from(this.mContext);
        if (ServiceManager.getService("isub") == null) {
            ServiceManager.addService("isub", this);
        }
        logdl("[SubscriptionController] init by Context");
    }

    private boolean isSubInfoReady() {
        return mSlotIdxToSubId.size() > 0 ? DBG : false;
    }

    private SubscriptionController(Phone phone) {
        this.mLocalLog = new ScLocalLog(MAX_LOCAL_LOG_LINES);
        this.mLock = new Object();
        this.mContext = phone.getContext();
        this.mCM = CallManager.getInstance();
        if (ServiceManager.getService("isub") == null) {
            ServiceManager.addService("isub", this);
        }
        logdl("[SubscriptionController] init by Phone");
    }

    private void enforceSubscriptionPermission() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.READ_PHONE_STATE", "Requires READ_PHONE_STATE");
    }

    private void broadcastSimInfoContentChanged() {
        this.mContext.sendBroadcast(new Intent("android.intent.action.ACTION_SUBINFO_CONTENT_CHANGE"));
        this.mContext.sendBroadcast(new Intent("android.intent.action.ACTION_SUBINFO_RECORD_UPDATED"));
    }

    private boolean checkNotifyPermission(String method) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.MODIFY_PHONE_STATE") == 0) {
            return DBG;
        }
        logd("checkNotifyPermission Permission Denial: " + method + " from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
        return false;
    }

    public void notifySubscriptionInfoChanged() {
        if (checkNotifyPermission("notifySubscriptionInfoChanged")) {
            ITelephonyRegistry tr = ITelephonyRegistry.Stub.asInterface(ServiceManager.getService("telephony.registry"));
            try {
                logd("notifySubscriptionInfoChanged:");
                tr.notifySubscriptionInfoChanged();
            } catch (RemoteException e) {
            }
            broadcastSimInfoContentChanged();
        }
    }

    private SubscriptionInfo getSubInfoRecord(Cursor cursor) {
        int id = cursor.getInt(cursor.getColumnIndexOrThrow(HbpcdLookup.ID));
        String iccId = cursor.getString(cursor.getColumnIndexOrThrow("icc_id"));
        int simSlotIndex = cursor.getInt(cursor.getColumnIndexOrThrow("sim_id"));
        String displayName = cursor.getString(cursor.getColumnIndexOrThrow("display_name"));
        String carrierName = cursor.getString(cursor.getColumnIndexOrThrow("carrier_name"));
        int nameSource = cursor.getInt(cursor.getColumnIndexOrThrow("name_source"));
        int iconTint = cursor.getInt(cursor.getColumnIndexOrThrow("color"));
        String number = cursor.getString(cursor.getColumnIndexOrThrow("number"));
        int dataRoaming = cursor.getInt(cursor.getColumnIndexOrThrow("data_roaming"));
        Bitmap iconBitmap = BitmapFactory.decodeResource(this.mContext.getResources(), 17302581);
        int mcc = cursor.getInt(cursor.getColumnIndexOrThrow(Carriers.MCC));
        int mnc = cursor.getInt(cursor.getColumnIndexOrThrow(Carriers.MNC));
        String countryIso = getSubscriptionCountryIso(id);
        String str = " iccid:";
        str = " simSlotIndex:";
        str = " displayName:";
        str = " nameSource:";
        str = " iconTint:";
        str = " dataRoaming:";
        str = " mcc:";
        str = " mnc:";
        str = " countIso:";
        logd("[getSubInfoRecord] id:" + id + r16 + iccId + r16 + simSlotIndex + r16 + displayName + r16 + nameSource + r16 + iconTint + r16 + dataRoaming + r16 + mcc + r16 + mnc + r16 + countryIso);
        String line1Number = this.mTelephonyManager.getLine1NumberForSubscriber(id);
        if (!(TextUtils.isEmpty(line1Number) || line1Number.equals(number))) {
            logd("Line1Number is different: " + line1Number);
            number = line1Number;
        }
        return new SubscriptionInfo(id, iccId, simSlotIndex, displayName, carrierName, nameSource, iconTint, number, dataRoaming, iconBitmap, mcc, mnc, countryIso);
    }

    private String getSubscriptionCountryIso(int subId) {
        int phoneId = getPhoneId(subId);
        if (phoneId < 0) {
            return "";
        }
        return this.mTelephonyManager.getSimCountryIsoForPhone(phoneId);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private java.util.List<android.telephony.SubscriptionInfo> getSubInfo(java.lang.String r11, java.lang.Object r12) {
        /*
        r10 = this;
        r2 = 0;
        r0 = new java.lang.StringBuilder;
        r0.<init>();
        r1 = "selection:";
        r0 = r0.append(r1);
        r0 = r0.append(r11);
        r1 = " ";
        r0 = r0.append(r1);
        r0 = r0.append(r12);
        r0 = r0.toString();
        r10.logd(r0);
        r4 = 0;
        if (r12 == 0) goto L_0x002e;
    L_0x0024:
        r0 = 1;
        r4 = new java.lang.String[r0];
        r0 = 0;
        r1 = r12.toString();
        r4[r0] = r1;
    L_0x002e:
        r8 = 0;
        r0 = r10.mContext;
        r0 = r0.getContentResolver();
        r1 = android.telephony.SubscriptionManager.CONTENT_URI;
        r3 = r11;
        r5 = r2;
        r6 = r0.query(r1, r2, r3, r4, r5);
        if (r6 == 0) goto L_0x0058;
    L_0x003f:
        r9 = r8;
    L_0x0040:
        r0 = r6.moveToNext();	 Catch:{ all -> 0x0063 }
        if (r0 == 0) goto L_0x0071;
    L_0x0046:
        r7 = r10.getSubInfoRecord(r6);	 Catch:{ all -> 0x0063 }
        if (r7 == 0) goto L_0x006f;
    L_0x004c:
        if (r9 != 0) goto L_0x006d;
    L_0x004e:
        r8 = new java.util.ArrayList;	 Catch:{ all -> 0x0063 }
        r8.<init>();	 Catch:{ all -> 0x0063 }
    L_0x0053:
        r8.add(r7);	 Catch:{ all -> 0x006b }
    L_0x0056:
        r9 = r8;
        goto L_0x0040;
    L_0x0058:
        r0 = "Query fail";
        r10.logd(r0);	 Catch:{ all -> 0x006b }
    L_0x005d:
        if (r6 == 0) goto L_0x0062;
    L_0x005f:
        r6.close();
    L_0x0062:
        return r8;
    L_0x0063:
        r0 = move-exception;
        r8 = r9;
    L_0x0065:
        if (r6 == 0) goto L_0x006a;
    L_0x0067:
        r6.close();
    L_0x006a:
        throw r0;
    L_0x006b:
        r0 = move-exception;
        goto L_0x0065;
    L_0x006d:
        r8 = r9;
        goto L_0x0053;
    L_0x006f:
        r8 = r9;
        goto L_0x0056;
    L_0x0071:
        r8 = r9;
        goto L_0x005d;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.SubscriptionController.getSubInfo(java.lang.String, java.lang.Object):java.util.List<android.telephony.SubscriptionInfo>");
    }

    private int getUnusedColor() {
        List<SubscriptionInfo> availableSubInfos = getActiveSubscriptionInfoList();
        this.colorArr = this.mContext.getResources().getIntArray(17235978);
        int colorIdx = 0;
        if (availableSubInfos != null) {
            int i = 0;
            while (i < this.colorArr.length) {
                int j = 0;
                while (j < availableSubInfos.size() && this.colorArr[i] != ((SubscriptionInfo) availableSubInfos.get(j)).getIconTint()) {
                    j++;
                }
                if (j == availableSubInfos.size()) {
                    return this.colorArr[i];
                }
                i++;
            }
            colorIdx = availableSubInfos.size() % this.colorArr.length;
        }
        return this.colorArr[colorIdx];
    }

    public SubscriptionInfo getActiveSubscriptionInfo(int subId) {
        enforceSubscriptionPermission();
        List<SubscriptionInfo> subList = getActiveSubscriptionInfoList();
        if (subList != null) {
            for (SubscriptionInfo si : subList) {
                if (si.getSubscriptionId() == subId) {
                    logd("[getActiveSubInfoForSubscriber]+ subId=" + subId + " subInfo=" + si);
                    return si;
                }
            }
        }
        logd("[getActiveSubInfoForSubscriber]- subId=" + subId + " subList=" + subList + " subInfo=null");
        return null;
    }

    public SubscriptionInfo getActiveSubscriptionInfoForIccId(String iccId) {
        enforceSubscriptionPermission();
        List<SubscriptionInfo> subList = getActiveSubscriptionInfoList();
        if (subList != null) {
            for (SubscriptionInfo si : subList) {
                if (si.getIccId() == iccId) {
                    logd("[getActiveSubInfoUsingIccId]+ iccId=" + iccId + " subInfo=" + si);
                    return si;
                }
            }
        }
        logd("[getActiveSubInfoUsingIccId]+ iccId=" + iccId + " subList=" + subList + " subInfo=null");
        return null;
    }

    public SubscriptionInfo getActiveSubscriptionInfoForSimSlotIndex(int slotIdx) {
        enforceSubscriptionPermission();
        List<SubscriptionInfo> subList = getActiveSubscriptionInfoList();
        if (subList != null) {
            for (SubscriptionInfo si : subList) {
                if (si.getSimSlotIndex() == slotIdx) {
                    logd("[getActiveSubscriptionInfoForSimSlotIndex]+ slotIdx=" + slotIdx + " subId=" + si);
                    return si;
                }
            }
            logd("[getActiveSubscriptionInfoForSimSlotIndex]+ slotIdx=" + slotIdx + " subId=null");
        } else {
            logd("[getActiveSubscriptionInfoForSimSlotIndex]+ subList=null");
        }
        return null;
    }

    public List<SubscriptionInfo> getAllSubInfoList() {
        logd("[getAllSubInfoList]+");
        enforceSubscriptionPermission();
        List<SubscriptionInfo> subList = getSubInfo(null, null);
        if (subList != null) {
            logd("[getAllSubInfoList]- " + subList.size() + " infos return");
        } else {
            logd("[getAllSubInfoList]- no info return");
        }
        return subList;
    }

    public List<SubscriptionInfo> getActiveSubscriptionInfoList() {
        enforceSubscriptionPermission();
        logdl("[getActiveSubInfoList]+");
        if (isSubInfoReady()) {
            List<SubscriptionInfo> subList = getSubInfo("sim_id>=0", null);
            if (subList != null) {
                Collections.sort(subList, new C00211());
                logdl("[getActiveSubInfoList]- " + subList.size() + " infos return");
            } else {
                logdl("[getActiveSubInfoList]- no info return");
            }
            return subList;
        }
        logdl("[getActiveSubInfoList] Sub Controller not ready");
        return null;
    }

    public int getActiveSubInfoCount() {
        logd("[getActiveSubInfoCount]+");
        List<SubscriptionInfo> records = getActiveSubscriptionInfoList();
        if (records == null) {
            logd("[getActiveSubInfoCount] records null");
            return 0;
        }
        logd("[getActiveSubInfoCount]- count: " + records.size());
        return records.size();
    }

    public int getAllSubInfoCount() {
        logd("[getAllSubInfoCount]+");
        enforceSubscriptionPermission();
        Cursor cursor = this.mContext.getContentResolver().query(SubscriptionManager.CONTENT_URI, null, null, null, null);
        if (cursor != null) {
            try {
                int count = cursor.getCount();
                logd("[getAllSubInfoCount]- " + count + " SUB(s) in DB");
                if (cursor == null) {
                    return count;
                }
                cursor.close();
                return count;
            } catch (Throwable th) {
                if (cursor != null) {
                    cursor.close();
                }
            }
        } else {
            if (cursor != null) {
                cursor.close();
            }
            logd("[getAllSubInfoCount]- no SUB in DB");
            return 0;
        }
    }

    public int getActiveSubInfoCountMax() {
        return this.mTelephonyManager.getSimCount();
    }

    public int addSubInfoRecord(String iccId, int slotId) {
        logdl("[addSubInfoRecord]+ iccId:" + iccId + " slotId:" + slotId);
        enforceSubscriptionPermission();
        if (iccId == null) {
            logdl("[addSubInfoRecord]- null iccId");
            return -1;
        }
        Object subIds = getSubId(slotId);
        if (subIds == null || subIds.length == 0) {
            logdl("[addSubInfoRecord]- getSubId failed subIds == null || length == 0 subIds=" + subIds);
            return -1;
        }
        String nameToSet;
        int subId;
        ContentValues value;
        Integer currentSubId;
        String simCarrierName = this.mTelephonyManager.getSimOperatorNameForSubscription(subIds[0]);
        if (TextUtils.isEmpty(simCarrierName)) {
            nameToSet = "CARD " + Integer.toString(slotId + 1);
        } else {
            nameToSet = simCarrierName;
        }
        logdl("[addSubInfoRecord] sim name = " + nameToSet);
        logdl("[addSubInfoRecord] carrier name = " + simCarrierName);
        ContentResolver resolver = this.mContext.getContentResolver();
        Cursor cursor = resolver.query(SubscriptionManager.CONTENT_URI, new String[]{HbpcdLookup.ID, "sim_id", "name_source"}, "icc_id=?", new String[]{iccId}, null);
        int color = getUnusedColor();
        if (cursor != null) {
            try {
                if (cursor.moveToFirst()) {
                    subId = cursor.getInt(0);
                    int oldSimInfoId = cursor.getInt(1);
                    int nameSource = cursor.getInt(2);
                    value = new ContentValues();
                    if (slotId != oldSimInfoId) {
                        value.put("sim_id", Integer.valueOf(slotId));
                    }
                    if (nameSource != 2) {
                        value.put("display_name", nameToSet);
                    }
                    if (value.size() > 0) {
                        resolver.update(SubscriptionManager.CONTENT_URI, value, "_id=" + Long.toString((long) subId), null);
                    }
                    logdl("[addSubInfoRecord] Record already exists");
                    if (cursor != null) {
                        cursor.close();
                    }
                    cursor = resolver.query(SubscriptionManager.CONTENT_URI, null, "sim_id=?", new String[]{String.valueOf(slotId)}, null);
                    if (cursor != null) {
                        try {
                            if (cursor.moveToFirst()) {
                                do {
                                    subId = cursor.getInt(cursor.getColumnIndexOrThrow(HbpcdLookup.ID));
                                    currentSubId = (Integer) mSlotIdxToSubId.get(Integer.valueOf(slotId));
                                    if (currentSubId == null && SubscriptionManager.isValidSubscriptionId(currentSubId.intValue())) {
                                        logdl("[addSubInfoRecord] currentSubId != null && currentSubId is valid, IGNORE");
                                    } else {
                                        int subIdCountMax;
                                        int defaultSubId;
                                        mSlotIdxToSubId.put(Integer.valueOf(slotId), Integer.valueOf(subId));
                                        subIdCountMax = getActiveSubInfoCountMax();
                                        defaultSubId = getDefaultSubId();
                                        logdl("[addSubInfoRecord] mSlotIdxToSubId.size=" + mSlotIdxToSubId.size() + " slotId=" + slotId + " subId=" + subId + " defaultSubId=" + defaultSubId + " simCount=" + subIdCountMax);
                                        if (!SubscriptionManager.isValidSubscriptionId(defaultSubId) || subIdCountMax == 1) {
                                            setDefaultFallbackSubId(subId);
                                        }
                                        if (subIdCountMax == 1) {
                                            logdl("[addSubInfoRecord] one sim set defaults to subId=" + subId);
                                            setDefaultDataSubId(subId);
                                            setDefaultSmsSubId(subId);
                                            setDefaultVoiceSubId(subId);
                                        }
                                    }
                                    logdl("[addSubInfoRecord] hashmap(" + slotId + "," + subId + ")");
                                } while (cursor.moveToNext());
                            }
                        } catch (Throwable th) {
                            if (cursor != null) {
                                cursor.close();
                            }
                        }
                    }
                    if (cursor != null) {
                        cursor.close();
                    }
                    updateAllDataConnectionTrackers();
                    logdl("[addSubInfoRecord]- info size=" + mSlotIdxToSubId.size());
                    return 0;
                }
            } catch (Throwable th2) {
                if (cursor != null) {
                    cursor.close();
                }
            }
        }
        value = new ContentValues();
        value.put("icc_id", iccId);
        value.put("color", Integer.valueOf(color));
        value.put("sim_id", Integer.valueOf(slotId));
        value.put("display_name", nameToSet);
        value.put("carrier_name", "");
        logdl("[addSubInfoRecord] New record created: " + resolver.insert(SubscriptionManager.CONTENT_URI, value));
        if (cursor != null) {
            cursor.close();
        }
        cursor = resolver.query(SubscriptionManager.CONTENT_URI, null, "sim_id=?", new String[]{String.valueOf(slotId)}, null);
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                do {
                    subId = cursor.getInt(cursor.getColumnIndexOrThrow(HbpcdLookup.ID));
                    currentSubId = (Integer) mSlotIdxToSubId.get(Integer.valueOf(slotId));
                    if (currentSubId == null) {
                    }
                    mSlotIdxToSubId.put(Integer.valueOf(slotId), Integer.valueOf(subId));
                    subIdCountMax = getActiveSubInfoCountMax();
                    defaultSubId = getDefaultSubId();
                    logdl("[addSubInfoRecord] mSlotIdxToSubId.size=" + mSlotIdxToSubId.size() + " slotId=" + slotId + " subId=" + subId + " defaultSubId=" + defaultSubId + " simCount=" + subIdCountMax);
                    setDefaultFallbackSubId(subId);
                    if (subIdCountMax == 1) {
                        logdl("[addSubInfoRecord] one sim set defaults to subId=" + subId);
                        setDefaultDataSubId(subId);
                        setDefaultSmsSubId(subId);
                        setDefaultVoiceSubId(subId);
                    }
                    logdl("[addSubInfoRecord] hashmap(" + slotId + "," + subId + ")");
                } while (cursor.moveToNext());
            }
        }
        if (cursor != null) {
            cursor.close();
        }
        updateAllDataConnectionTrackers();
        logdl("[addSubInfoRecord]- info size=" + mSlotIdxToSubId.size());
        return 0;
    }

    public boolean setPlmnSpn(int slotId, boolean showPlmn, String plmn, boolean showSpn, String spn) {
        boolean z = false;
        synchronized (this.mLock) {
            int[] subIds = getSubId(slotId);
            if (this.mContext.getPackageManager().resolveContentProvider(SubscriptionManager.CONTENT_URI.getAuthority(), 0) == null || subIds == null || !SubscriptionManager.isValidSubscriptionId(subIds[0])) {
                logd("[setPlmnSpn] No valid subscription to store info");
                notifySubscriptionInfoChanged();
            } else {
                String carrierText = "";
                if (showPlmn) {
                    carrierText = plmn;
                    if (showSpn) {
                        carrierText = carrierText + this.mContext.getString(17040917).toString() + spn;
                    }
                } else if (showSpn) {
                    carrierText = spn;
                }
                for (int carrierText2 : subIds) {
                    setCarrierText(carrierText, carrierText2);
                }
                z = DBG;
            }
        }
        return z;
    }

    private int setCarrierText(String text, int subId) {
        logd("[setCarrierText]+ text:" + text + " subId:" + subId);
        enforceSubscriptionPermission();
        ContentValues value = new ContentValues(1);
        value.put("carrier_name", text);
        int result = this.mContext.getContentResolver().update(SubscriptionManager.CONTENT_URI, value, "_id=" + Long.toString((long) subId), null);
        notifySubscriptionInfoChanged();
        return result;
    }

    public int setIconTint(int tint, int subId) {
        logd("[setIconTint]+ tint:" + tint + " subId:" + subId);
        enforceSubscriptionPermission();
        validateSubId(subId);
        ContentValues value = new ContentValues(1);
        value.put("color", Integer.valueOf(tint));
        logd("[setIconTint]- tint:" + tint + " set");
        int result = this.mContext.getContentResolver().update(SubscriptionManager.CONTENT_URI, value, "_id=" + Long.toString((long) subId), null);
        notifySubscriptionInfoChanged();
        return result;
    }

    public int setDisplayName(String displayName, int subId) {
        return setDisplayNameUsingSrc(displayName, subId, -1);
    }

    public int setDisplayNameUsingSrc(String displayName, int subId, long nameSource) {
        String nameToSet;
        logd("[setDisplayName]+  displayName:" + displayName + " subId:" + subId + " nameSource:" + nameSource);
        enforceSubscriptionPermission();
        validateSubId(subId);
        if (displayName == null) {
            nameToSet = this.mContext.getString(17039374);
        } else {
            nameToSet = displayName;
        }
        ContentValues value = new ContentValues(1);
        value.put("display_name", nameToSet);
        if (nameSource >= 0) {
            logd("Set nameSource=" + nameSource);
            value.put("name_source", Long.valueOf(nameSource));
        }
        logd("[setDisplayName]- mDisplayName:" + nameToSet + " set");
        int result = this.mContext.getContentResolver().update(SubscriptionManager.CONTENT_URI, value, "_id=" + Long.toString((long) subId), null);
        notifySubscriptionInfoChanged();
        return result;
    }

    public int setDisplayNumber(String number, int subId) {
        logd("[setDisplayNumber]+ subId:" + subId);
        enforceSubscriptionPermission();
        validateSubId(subId);
        int phoneId = getPhoneId(subId);
        if (number == null || phoneId < 0 || phoneId >= this.mTelephonyManager.getPhoneCount()) {
            logd("[setDispalyNumber]- fail");
            return -1;
        }
        ContentValues value = new ContentValues(1);
        value.put("number", number);
        int result = this.mContext.getContentResolver().update(SubscriptionManager.CONTENT_URI, value, "_id=" + Long.toString((long) subId), null);
        logd("[setDisplayNumber]- update result :" + result);
        notifySubscriptionInfoChanged();
        return result;
    }

    public int setDataRoaming(int roaming, int subId) {
        logd("[setDataRoaming]+ roaming:" + roaming + " subId:" + subId);
        enforceSubscriptionPermission();
        validateSubId(subId);
        if (roaming < 0) {
            logd("[setDataRoaming]- fail");
            return -1;
        }
        ContentValues value = new ContentValues(1);
        value.put("data_roaming", Integer.valueOf(roaming));
        logd("[setDataRoaming]- roaming:" + roaming + " set");
        int result = this.mContext.getContentResolver().update(SubscriptionManager.CONTENT_URI, value, "_id=" + Long.toString((long) subId), null);
        notifySubscriptionInfoChanged();
        return result;
    }

    public int setMccMnc(String mccMnc, int subId) {
        int mcc = 0;
        int mnc = 0;
        try {
            mcc = Integer.parseInt(mccMnc.substring(0, 3));
            mnc = Integer.parseInt(mccMnc.substring(3));
        } catch (NumberFormatException e) {
            loge("[setMccMnc] - couldn't parse mcc/mnc: " + mccMnc);
        }
        logd("[setMccMnc]+ mcc/mnc:" + mcc + "/" + mnc + " subId:" + subId);
        ContentValues value = new ContentValues(2);
        value.put(Carriers.MCC, Integer.valueOf(mcc));
        value.put(Carriers.MNC, Integer.valueOf(mnc));
        int result = this.mContext.getContentResolver().update(SubscriptionManager.CONTENT_URI, value, "_id=" + Long.toString((long) subId), null);
        notifySubscriptionInfoChanged();
        return result;
    }

    public int getSlotId(int subId) {
        if (subId == Integer.MAX_VALUE) {
            subId = getDefaultSubId();
        }
        if (!SubscriptionManager.isValidSubscriptionId(subId)) {
            logd("[getSlotId]- subId invalid");
            return -1;
        } else if (mSlotIdxToSubId.size() == 0) {
            logd("[getSlotId]- size == 0, return SIM_NOT_INSERTED instead");
            return -1;
        } else {
            for (Entry<Integer, Integer> entry : mSlotIdxToSubId.entrySet()) {
                int sim = ((Integer) entry.getKey()).intValue();
                if (subId == ((Integer) entry.getValue()).intValue()) {
                    return sim;
                }
            }
            logd("[getSlotId]- return fail");
            return -1;
        }
    }

    @Deprecated
    public int[] getSubId(int slotIdx) {
        if (slotIdx == Integer.MAX_VALUE) {
            slotIdx = getSlotId(getDefaultSubId());
            logd("[getSubId] map default slotIdx=" + slotIdx);
        }
        if (!SubscriptionManager.isValidSlotId(slotIdx)) {
            logd("[getSubId]- invalid slotIdx=" + slotIdx);
            return null;
        } else if (mSlotIdxToSubId.size() == 0) {
            logd("[getSubId]- mSlotIdToSubIdMap.size == 0, return DummySubIds slotIdx=" + slotIdx);
            return getDummySubIds(slotIdx);
        } else {
            ArrayList<Integer> subIds = new ArrayList();
            for (Entry<Integer, Integer> entry : mSlotIdxToSubId.entrySet()) {
                int slot = ((Integer) entry.getKey()).intValue();
                int sub = ((Integer) entry.getValue()).intValue();
                if (slotIdx == slot) {
                    subIds.add(Integer.valueOf(sub));
                }
            }
            int numSubIds = subIds.size();
            if (numSubIds > 0) {
                int[] subIdArr = new int[numSubIds];
                for (int i = 0; i < numSubIds; i++) {
                    subIdArr[i] = ((Integer) subIds.get(i)).intValue();
                }
                return subIdArr;
            }
            logd("[getSubId]- numSubIds == 0, return DummySubIds slotIdx=" + slotIdx);
            return getDummySubIds(slotIdx);
        }
    }

    public int getPhoneId(int subId) {
        if (subId == Integer.MAX_VALUE) {
            subId = getDefaultSubId();
            logdl("[getPhoneId] asked for default subId=" + subId);
        }
        if (!SubscriptionManager.isValidSubscriptionId(subId)) {
            logdl("[getPhoneId]- invalid subId return=-1");
            return -1;
        } else if (mSlotIdxToSubId.size() == 0) {
            phoneId = mDefaultPhoneId;
            logdl("[getPhoneId]- no sims, returning default phoneId=" + phoneId);
            return phoneId;
        } else {
            for (Entry<Integer, Integer> entry : mSlotIdxToSubId.entrySet()) {
                int sim = ((Integer) entry.getKey()).intValue();
                if (subId == ((Integer) entry.getValue()).intValue()) {
                    return sim;
                }
            }
            phoneId = mDefaultPhoneId;
            logdl("[getPhoneId]- subId=" + subId + " not found return default phoneId=" + phoneId);
            return phoneId;
        }
    }

    private int[] getDummySubIds(int slotIdx) {
        int numSubs = getActiveSubInfoCountMax();
        if (numSubs <= 0) {
            return null;
        }
        int[] dummyValues = new int[numSubs];
        for (int i = 0; i < numSubs; i++) {
            dummyValues[i] = -2 - slotIdx;
        }
        logd("getDummySubIds: slotIdx=" + slotIdx + " return " + numSubs + " DummySubIds with each subId=" + dummyValues[0]);
        return dummyValues;
    }

    public int clearSubInfo() {
        enforceSubscriptionPermission();
        logd("[clearSubInfo]+");
        int size = mSlotIdxToSubId.size();
        if (size == 0) {
            logdl("[clearSubInfo]- no simInfo size=" + size);
            return 0;
        }
        mSlotIdxToSubId.clear();
        logdl("[clearSubInfo]- clear size=" + size);
        return size;
    }

    private void logvl(String msg) {
        logv(msg);
        this.mLocalLog.log(msg);
    }

    private void logv(String msg) {
        Rlog.v(LOG_TAG, msg);
    }

    private void logdl(String msg) {
        logd(msg);
        this.mLocalLog.log(msg);
    }

    private static void slogd(String msg) {
        Rlog.d(LOG_TAG, msg);
    }

    private void logd(String msg) {
        Rlog.d(LOG_TAG, msg);
    }

    private void logel(String msg) {
        loge(msg);
        this.mLocalLog.log(msg);
    }

    private void loge(String msg) {
        Rlog.e(LOG_TAG, msg);
    }

    public int getDefaultSubId() {
        int subId;
        if (this.mContext.getResources().getBoolean(17956946)) {
            subId = getDefaultVoiceSubId();
        } else {
            subId = getDefaultDataSubId();
        }
        if (isActiveSubId(subId)) {
            return subId;
        }
        return mDefaultFallbackSubId;
    }

    public void setDefaultSmsSubId(int subId) {
        if (subId == Integer.MAX_VALUE) {
            throw new RuntimeException("setDefaultSmsSubId called with DEFAULT_SUB_ID");
        }
        logdl("[setDefaultSmsSubId] subId=" + subId);
        Global.putInt(this.mContext.getContentResolver(), "multi_sim_sms", subId);
        broadcastDefaultSmsSubIdChanged(subId);
    }

    private void broadcastDefaultSmsSubIdChanged(int subId) {
        logdl("[broadcastDefaultSmsSubIdChanged] subId=" + subId);
        Intent intent = new Intent("android.intent.action.ACTION_DEFAULT_SMS_SUBSCRIPTION_CHANGED");
        intent.addFlags(536870912);
        intent.putExtra("subscription", subId);
        this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    public int getDefaultSmsSubId() {
        return Global.getInt(this.mContext.getContentResolver(), "multi_sim_sms", -1);
    }

    public void setDefaultVoiceSubId(int subId) {
        if (subId == Integer.MAX_VALUE) {
            throw new RuntimeException("setDefaultVoiceSubId called with DEFAULT_SUB_ID");
        }
        logdl("[setDefaultVoiceSubId] subId=" + subId);
        Global.putInt(this.mContext.getContentResolver(), "multi_sim_voice_call", subId);
        broadcastDefaultVoiceSubIdChanged(subId);
    }

    private void broadcastDefaultVoiceSubIdChanged(int subId) {
        logdl("[broadcastDefaultVoiceSubIdChanged] subId=" + subId);
        Intent intent = new Intent("android.intent.action.ACTION_DEFAULT_VOICE_SUBSCRIPTION_CHANGED");
        intent.addFlags(536870912);
        intent.putExtra("subscription", subId);
        this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    public int getDefaultVoiceSubId() {
        return Global.getInt(this.mContext.getContentResolver(), "multi_sim_voice_call", -1);
    }

    public int getDefaultDataSubId() {
        return Global.getInt(this.mContext.getContentResolver(), "multi_sim_data_call", -1);
    }

    public void setDefaultDataSubId(int subId) {
        if (subId == Integer.MAX_VALUE) {
            throw new RuntimeException("setDefaultDataSubId called with DEFAULT_SUB_ID");
        }
        logdl("[setDefaultDataSubId] subId=" + subId);
        int len = sProxyPhones.length;
        logdl("[setDefaultDataSubId] num phones=" + len);
        RadioAccessFamily[] rafs = new RadioAccessFamily[len];
        for (int phoneId = 0; phoneId < len; phoneId++) {
            PhoneProxy phone = sProxyPhones[phoneId];
            int raf = phone.getRadioAccessFamily();
            int id = phone.getSubId();
            logdl("[setDefaultDataSubId] phoneId=" + phoneId + " subId=" + id + " RAF=" + raf);
            raf |= 65536;
            if (id == subId) {
                raf |= 8;
            } else {
                raf &= -9;
            }
            logdl("[setDefaultDataSubId] reqRAF=" + raf);
            int networkType = PhoneFactory.calculatePreferredNetworkType(this.mContext, id);
            logdl("[setDefaultDataSubId] networkType=" + networkType);
            raf &= RadioAccessFamily.getRafFromNetworkType(networkType);
            logdl("[setDefaultDataSubId] newRAF=" + raf);
            rafs[phoneId] = new RadioAccessFamily(phoneId, raf);
        }
        ProxyController.getInstance().setRadioCapability(rafs);
        updateAllDataConnectionTrackers();
        Global.putInt(this.mContext.getContentResolver(), "multi_sim_data_call", subId);
        broadcastDefaultDataSubIdChanged(subId);
    }

    private void updateAllDataConnectionTrackers() {
        int len = sProxyPhones.length;
        logdl("[updateAllDataConnectionTrackers] sProxyPhones.length=" + len);
        for (int phoneId = 0; phoneId < len; phoneId++) {
            logdl("[updateAllDataConnectionTrackers] phoneId=" + phoneId);
            sProxyPhones[phoneId].updateDataConnectionTracker();
        }
    }

    private void broadcastDefaultDataSubIdChanged(int subId) {
        logdl("[broadcastDefaultDataSubIdChanged] subId=" + subId);
        Intent intent = new Intent("android.intent.action.ACTION_DEFAULT_DATA_SUBSCRIPTION_CHANGED");
        intent.addFlags(536870912);
        intent.putExtra("subscription", subId);
        this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    private void setDefaultFallbackSubId(int subId) {
        if (subId == Integer.MAX_VALUE) {
            throw new RuntimeException("setDefaultSubId called with DEFAULT_SUB_ID");
        }
        logdl("[setDefaultFallbackSubId] subId=" + subId);
        if (SubscriptionManager.isValidSubscriptionId(subId)) {
            int phoneId = getPhoneId(subId);
            if (phoneId < 0 || (phoneId >= this.mTelephonyManager.getPhoneCount() && this.mTelephonyManager.getSimCount() != 1)) {
                logdl("[setDefaultFallbackSubId] not set invalid phoneId=" + phoneId + " subId=" + subId);
                return;
            }
            logdl("[setDefaultFallbackSubId] set mDefaultFallbackSubId=" + subId);
            mDefaultFallbackSubId = subId;
            MccTable.updateMccMncConfiguration(this.mContext, this.mTelephonyManager.getSimOperatorNumericForPhone(phoneId), false);
            Intent intent = new Intent("android.intent.action.ACTION_DEFAULT_SUBSCRIPTION_CHANGED");
            intent.addFlags(536870912);
            SubscriptionManager.putPhoneIdAndSubIdExtra(intent, phoneId, subId);
            logdl("[setDefaultFallbackSubId] broadcast default subId changed phoneId=" + phoneId + " subId=" + subId);
            this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
        }
    }

    public void clearDefaultsForInactiveSubIds() {
        List<SubscriptionInfo> records = getActiveSubscriptionInfoList();
        logdl("[clearDefaultsForInactiveSubIds] records: " + records);
        if (shouldDefaultBeCleared(records, getDefaultDataSubId())) {
            logd("[clearDefaultsForInactiveSubIds] clearing default data sub id");
            setDefaultDataSubId(-1);
        }
        if (shouldDefaultBeCleared(records, getDefaultSmsSubId())) {
            logdl("[clearDefaultsForInactiveSubIds] clearing default sms sub id");
            setDefaultSmsSubId(-1);
        }
        if (shouldDefaultBeCleared(records, getDefaultVoiceSubId())) {
            logdl("[clearDefaultsForInactiveSubIds] clearing default voice sub id");
            setDefaultVoiceSubId(-1);
        }
    }

    private boolean shouldDefaultBeCleared(List<SubscriptionInfo> records, int subId) {
        logdl("[shouldDefaultBeCleared: subId] " + subId);
        if (records == null) {
            logdl("[shouldDefaultBeCleared] return true no records subId=" + subId);
            return DBG;
        } else if (SubscriptionManager.isValidSubscriptionId(subId)) {
            for (SubscriptionInfo record : records) {
                int id = record.getSubscriptionId();
                logdl("[shouldDefaultBeCleared] Record.id: " + id);
                if (id == subId) {
                    logdl("[shouldDefaultBeCleared] return false subId is active, subId=" + subId);
                    return false;
                }
            }
            logdl("[shouldDefaultBeCleared] return true not active subId=" + subId);
            return DBG;
        } else {
            logdl("[shouldDefaultBeCleared] return false only one subId, subId=" + subId);
            return false;
        }
    }

    public int getSubIdUsingPhoneId(int phoneId) {
        int[] subIds = getSubId(phoneId);
        if (subIds == null || subIds.length == 0) {
            return -1;
        }
        return subIds[0];
    }

    public int[] getSubIdUsingSlotId(int slotId) {
        return getSubId(slotId);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public java.util.List<android.telephony.SubscriptionInfo> getSubInfoUsingSlotIdWithCheck(int r12, boolean r13) {
        /*
        r11 = this;
        r2 = 0;
        r0 = new java.lang.StringBuilder;
        r0.<init>();
        r1 = "[getSubInfoUsingSlotIdWithCheck]+ slotId:";
        r0 = r0.append(r1);
        r0 = r0.append(r12);
        r0 = r0.toString();
        r11.logd(r0);
        r11.enforceSubscriptionPermission();
        r0 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        if (r12 != r0) goto L_0x0027;
    L_0x001f:
        r0 = r11.getDefaultSubId();
        r12 = r11.getSlotId(r0);
    L_0x0027:
        r0 = android.telephony.SubscriptionManager.isValidSlotId(r12);
        if (r0 != 0) goto L_0x0033;
    L_0x002d:
        r0 = "[getSubInfoUsingSlotIdWithCheck]- invalid slotId";
        r11.logd(r0);
    L_0x0032:
        return r2;
    L_0x0033:
        if (r13 == 0) goto L_0x0041;
    L_0x0035:
        r0 = r11.isSubInfoReady();
        if (r0 != 0) goto L_0x0041;
    L_0x003b:
        r0 = "[getSubInfoUsingSlotIdWithCheck]- not ready";
        r11.logd(r0);
        goto L_0x0032;
    L_0x0041:
        r0 = r11.mContext;
        r0 = r0.getContentResolver();
        r1 = android.telephony.SubscriptionManager.CONTENT_URI;
        r3 = "sim_id=?";
        r4 = 1;
        r4 = new java.lang.String[r4];
        r5 = 0;
        r10 = java.lang.String.valueOf(r12);
        r4[r5] = r10;
        r5 = r2;
        r6 = r0.query(r1, r2, r3, r4, r5);
        r8 = 0;
        if (r6 == 0) goto L_0x0077;
    L_0x005d:
        r9 = r8;
    L_0x005e:
        r0 = r6.moveToNext();	 Catch:{ all -> 0x0083 }
        if (r0 == 0) goto L_0x0076;
    L_0x0064:
        r7 = r11.getSubInfoRecord(r6);	 Catch:{ all -> 0x0083 }
        if (r7 == 0) goto L_0x008f;
    L_0x006a:
        if (r9 != 0) goto L_0x008d;
    L_0x006c:
        r8 = new java.util.ArrayList;	 Catch:{ all -> 0x0083 }
        r8.<init>();	 Catch:{ all -> 0x0083 }
    L_0x0071:
        r8.add(r7);	 Catch:{ all -> 0x008b }
    L_0x0074:
        r9 = r8;
        goto L_0x005e;
    L_0x0076:
        r8 = r9;
    L_0x0077:
        if (r6 == 0) goto L_0x007c;
    L_0x0079:
        r6.close();
    L_0x007c:
        r0 = "[getSubInfoUsingSlotId]- null info return";
        r11.logd(r0);
        r2 = r8;
        goto L_0x0032;
    L_0x0083:
        r0 = move-exception;
        r8 = r9;
    L_0x0085:
        if (r6 == 0) goto L_0x008a;
    L_0x0087:
        r6.close();
    L_0x008a:
        throw r0;
    L_0x008b:
        r0 = move-exception;
        goto L_0x0085;
    L_0x008d:
        r8 = r9;
        goto L_0x0071;
    L_0x008f:
        r8 = r9;
        goto L_0x0074;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.SubscriptionController.getSubInfoUsingSlotIdWithCheck(int, boolean):java.util.List<android.telephony.SubscriptionInfo>");
    }

    private void validateSubId(int subId) {
        logd("validateSubId subId: " + subId);
        if (!SubscriptionManager.isValidSubscriptionId(subId)) {
            throw new RuntimeException("Invalid sub id passed as parameter");
        } else if (subId == Integer.MAX_VALUE) {
            throw new RuntimeException("Default sub id passed as parameter");
        }
    }

    public void updatePhonesAvailability(PhoneProxy[] phones) {
        sProxyPhones = phones;
    }

    public int[] getActiveSubIdList() {
        Set<Entry<Integer, Integer>> simInfoSet = mSlotIdxToSubId.entrySet();
        logdl("[getActiveSubIdList] simInfoSet=" + simInfoSet);
        int[] subIdArr = new int[simInfoSet.size()];
        int i = 0;
        for (Entry<Integer, Integer> entry : simInfoSet) {
            subIdArr[i] = ((Integer) entry.getValue()).intValue();
            i++;
        }
        logdl("[getActiveSubIdList] X subIdArr.length=" + subIdArr.length);
        return subIdArr;
    }

    private boolean isActiveSubId(int subId) {
        if (!SubscriptionManager.isValidSubscriptionId(subId)) {
            return false;
        }
        for (Entry<Integer, Integer> entry : mSlotIdxToSubId.entrySet()) {
            if (subId == ((Integer) entry.getValue()).intValue()) {
                return DBG;
            }
        }
        return false;
    }

    public int getSimStateForSubscriber(int subId) {
        State simState;
        String err;
        int phoneIdx = getPhoneId(subId);
        if (phoneIdx < 0) {
            simState = State.UNKNOWN;
            err = "invalid PhoneIdx";
        } else {
            Phone phone = PhoneFactory.getPhone(phoneIdx);
            if (phone == null) {
                simState = State.UNKNOWN;
                err = "phone == null";
            } else {
                IccCard icc = phone.getIccCard();
                if (icc == null) {
                    simState = State.UNKNOWN;
                    err = "icc == null";
                } else {
                    simState = icc.getState();
                    err = "";
                }
            }
        }
        logd("getSimStateForSubscriber: " + err + " simState=" + simState + " ordinal=" + simState.ordinal());
        return simState.ordinal();
    }

    private static void printStackTrace(String msg) {
        RuntimeException re = new RuntimeException();
        slogd("StackTrace - " + msg);
        StackTraceElement[] st = re.getStackTrace();
        boolean first = DBG;
        for (StackTraceElement ste : st) {
            if (first) {
                first = false;
            } else {
                slogd(ste.toString());
            }
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DUMP", "Requires DUMP");
        long token = Binder.clearCallingIdentity();
        try {
            pw.println("SubscriptionController:");
            pw.println(" defaultSubId=" + getDefaultSubId());
            pw.println(" defaultDataSubId=" + getDefaultDataSubId());
            pw.println(" defaultVoiceSubId=" + getDefaultVoiceSubId());
            pw.println(" defaultSmsSubId=" + getDefaultSmsSubId());
            pw.println(" defaultDataPhoneId=" + SubscriptionManager.from(this.mContext).getDefaultDataPhoneId());
            pw.println(" defaultVoicePhoneId=" + SubscriptionManager.getDefaultVoicePhoneId());
            pw.println(" defaultSmsPhoneId=" + SubscriptionManager.from(this.mContext).getDefaultSmsPhoneId());
            pw.flush();
            for (Entry<Integer, Integer> entry : mSlotIdxToSubId.entrySet()) {
                pw.println(" mSlotIdToSubIdMap[" + entry.getKey() + "]: subId=" + entry.getValue());
            }
            pw.flush();
            pw.println("++++++++++++++++++++++++++++++++");
            List<SubscriptionInfo> sirl = getActiveSubscriptionInfoList();
            if (sirl != null) {
                pw.println(" ActiveSubInfoList:");
                for (SubscriptionInfo entry2 : sirl) {
                    pw.println("  " + entry2.toString());
                }
            } else {
                pw.println(" ActiveSubInfoList: is null");
            }
            pw.flush();
            pw.println("++++++++++++++++++++++++++++++++");
            sirl = getAllSubInfoList();
            if (sirl != null) {
                pw.println(" AllSubInfoList:");
                for (SubscriptionInfo entry22 : sirl) {
                    pw.println("  " + entry22.toString());
                }
            } else {
                pw.println(" AllSubInfoList: is null");
            }
            pw.flush();
            pw.println("++++++++++++++++++++++++++++++++");
            this.mLocalLog.dump(fd, pw, args);
            pw.flush();
            pw.println("++++++++++++++++++++++++++++++++");
            pw.flush();
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }
}
