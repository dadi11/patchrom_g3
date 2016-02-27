package com.android.internal.telephony;

import android.app.ActivityManagerNative;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.preference.PreferenceManager;
import android.provider.Settings.Global;
import android.telephony.Rlog;
import android.telephony.SubscriptionInfo;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import com.android.internal.telephony.uicc.IccCardProxy;
import com.android.internal.telephony.uicc.IccConstants;
import com.android.internal.telephony.uicc.IccFileHandler;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.telephony.uicc.IccUtils;

public class SubscriptionInfoUpdater extends Handler {
    public static final String CURR_SUBID = "curr_subid";
    private static final int EVENT_GET_NETWORK_SELECTION_MODE_DONE = 2;
    private static final int EVENT_SIM_ABSENT = 4;
    private static final int EVENT_SIM_LOADED = 3;
    private static final int EVENT_SIM_LOCKED = 5;
    private static final int EVENT_SIM_LOCKED_QUERY_ICCID_DONE = 1;
    private static final String ICCID_STRING_FOR_NO_SIM = "";
    private static final String LOG_TAG = "SubscriptionInfoUpdater";
    private static final int PROJECT_SIM_NUM;
    public static final int SIM_CHANGED = -1;
    public static final int SIM_NEW = -2;
    public static final int SIM_NOT_CHANGE = 0;
    public static final int SIM_NOT_INSERT = -99;
    public static final int SIM_REPOSITION = -3;
    public static final int STATUS_NO_SIM_INSERTED = 0;
    public static final int STATUS_SIM1_INSERTED = 1;
    public static final int STATUS_SIM2_INSERTED = 2;
    public static final int STATUS_SIM3_INSERTED = 4;
    public static final int STATUS_SIM4_INSERTED = 8;
    private static Context mContext;
    private static String[] mIccId;
    private static int[] mInsertSimState;
    private static Phone[] mPhone;
    private SubscriptionManager mSubscriptionManager;
    private final BroadcastReceiver sReceiver;

    /* renamed from: com.android.internal.telephony.SubscriptionInfoUpdater.1 */
    class C00221 extends BroadcastReceiver {
        C00221() {
        }

        public void onReceive(Context context, Intent intent) {
            SubscriptionInfoUpdater.this.logd("[Receiver]+");
            String action = intent.getAction();
            SubscriptionInfoUpdater.this.logd("Action: " + action);
            if (action.equals("android.intent.action.SIM_STATE_CHANGED") || action.equals(IccCardProxy.ACTION_INTERNAL_SIM_STATE_CHANGED)) {
                int slotId = intent.getIntExtra("phone", SubscriptionInfoUpdater.SIM_CHANGED);
                SubscriptionInfoUpdater.this.logd("slotId: " + slotId);
                if (slotId != SubscriptionInfoUpdater.SIM_CHANGED) {
                    String simStatus = intent.getStringExtra("ss");
                    SubscriptionInfoUpdater.this.logd("simStatus: " + simStatus);
                    if (action.equals("android.intent.action.SIM_STATE_CHANGED")) {
                        if ("ABSENT".equals(simStatus)) {
                            SubscriptionInfoUpdater.this.sendMessage(SubscriptionInfoUpdater.this.obtainMessage(SubscriptionInfoUpdater.STATUS_SIM3_INSERTED, slotId, SubscriptionInfoUpdater.SIM_CHANGED));
                        } else {
                            SubscriptionInfoUpdater.this.logd("Ignoring simStatus: " + simStatus);
                        }
                    } else if (action.equals(IccCardProxy.ACTION_INTERNAL_SIM_STATE_CHANGED)) {
                        if ("LOCKED".equals(simStatus)) {
                            SubscriptionInfoUpdater.this.sendMessage(SubscriptionInfoUpdater.this.obtainMessage(SubscriptionInfoUpdater.EVENT_SIM_LOCKED, slotId, SubscriptionInfoUpdater.SIM_CHANGED, intent.getStringExtra("reason")));
                        } else if ("LOADED".equals(simStatus)) {
                            SubscriptionInfoUpdater.this.sendMessage(SubscriptionInfoUpdater.this.obtainMessage(SubscriptionInfoUpdater.EVENT_SIM_LOADED, slotId, SubscriptionInfoUpdater.SIM_CHANGED));
                        } else {
                            SubscriptionInfoUpdater.this.logd("Ignoring simStatus: " + simStatus);
                        }
                    }
                    SubscriptionInfoUpdater.this.logd("[Receiver]-");
                }
            }
        }
    }

    private static class QueryIccIdUserObj {
        public String reason;
        public int slotId;

        QueryIccIdUserObj(String reason, int slotId) {
            this.reason = reason;
            this.slotId = slotId;
        }
    }

    static {
        PROJECT_SIM_NUM = TelephonyManager.getDefault().getPhoneCount();
        mContext = null;
        mIccId = new String[PROJECT_SIM_NUM];
        mInsertSimState = new int[PROJECT_SIM_NUM];
    }

    public SubscriptionInfoUpdater(Context context, Phone[] phoneProxy, CommandsInterface[] ci) {
        this.mSubscriptionManager = null;
        this.sReceiver = new C00221();
        logd("Constructor invoked");
        mContext = context;
        mPhone = phoneProxy;
        this.mSubscriptionManager = SubscriptionManager.from(mContext);
        mContext.registerReceiver(this.sReceiver, new IntentFilter("android.intent.action.SIM_STATE_CHANGED"));
        mContext.registerReceiver(this.sReceiver, new IntentFilter(IccCardProxy.ACTION_INTERNAL_SIM_STATE_CHANGED));
    }

    private boolean isAllIccIdQueryDone() {
        for (int i = STATUS_NO_SIM_INSERTED; i < PROJECT_SIM_NUM; i += STATUS_SIM1_INSERTED) {
            if (mIccId[i] == null) {
                logd("Wait for SIM" + (i + STATUS_SIM1_INSERTED) + " IccId");
                return false;
            }
        }
        logd("All IccIds query complete");
        return true;
    }

    public void setDisplayNameForNewSub(String newSubName, int subId, int newNameSource) {
        SubscriptionInfo subInfo = this.mSubscriptionManager.getActiveSubscriptionInfo(subId);
        if (subInfo != null) {
            int oldNameSource = subInfo.getNameSource();
            CharSequence oldSubName = subInfo.getDisplayName();
            logd("[setDisplayNameForNewSub] subId = " + subInfo.getSubscriptionId() + ", oldSimName = " + oldSubName + ", oldNameSource = " + oldNameSource + ", newSubName = " + newSubName + ", newNameSource = " + newNameSource);
            if (oldSubName == null || ((oldNameSource == 0 && newSubName != null) || !(oldNameSource != STATUS_SIM1_INSERTED || newSubName == null || newSubName.equals(oldSubName)))) {
                this.mSubscriptionManager.setDisplayName(newSubName, subInfo.getSubscriptionId(), (long) newNameSource);
                return;
            }
            return;
        }
        logd("SUB" + (subId + STATUS_SIM1_INSERTED) + " SubInfo not created yet");
    }

    public void handleMessage(Message msg) {
        AsyncResult ar;
        switch (msg.what) {
            case STATUS_SIM1_INSERTED /*1*/:
                ar = msg.obj;
                QueryIccIdUserObj uObj = ar.userObj;
                int slotId = uObj.slotId;
                logd("handleMessage : <EVENT_SIM_LOCKED_QUERY_ICCID_DONE> SIM" + (slotId + STATUS_SIM1_INSERTED));
                if (ar.exception != null) {
                    mIccId[slotId] = ICCID_STRING_FOR_NO_SIM;
                    logd("Query IccId fail: " + ar.exception);
                } else if (ar.result != null) {
                    byte[] data = (byte[]) ar.result;
                    mIccId[slotId] = IccUtils.bcdToString(data, STATUS_NO_SIM_INSERTED, data.length);
                } else {
                    logd("Null ar");
                    mIccId[slotId] = ICCID_STRING_FOR_NO_SIM;
                }
                logd("sIccId[" + slotId + "] = " + mIccId[slotId]);
                if (isAllIccIdQueryDone()) {
                    updateSubscriptionInfoByIccId();
                }
                broadcastSimStateChanged(slotId, "LOCKED", uObj.reason);
            case STATUS_SIM2_INSERTED /*2*/:
                ar = (AsyncResult) msg.obj;
                Integer slotId2 = ar.userObj;
                if (ar.exception != null || ar.result == null) {
                    logd("EVENT_GET_NETWORK_SELECTION_MODE_DONE: error getting network mode.");
                    return;
                }
                if (((int[]) ar.result)[STATUS_NO_SIM_INSERTED] == STATUS_SIM1_INSERTED) {
                    mPhone[slotId2.intValue()].setNetworkSelectionModeAutomatic(null);
                }
            case EVENT_SIM_LOADED /*3*/:
                handleSimLoaded(msg.arg1);
            case STATUS_SIM3_INSERTED /*4*/:
                handleSimAbsent(msg.arg1);
            case EVENT_SIM_LOCKED /*5*/:
                handleSimLocked(msg.arg1, (String) msg.obj);
            default:
                logd("Unknown msg:" + msg.what);
        }
    }

    private void handleSimLocked(int slotId, String reason) {
        IccFileHandler fileHandler = null;
        if (mIccId[slotId] != null && mIccId[slotId].equals(ICCID_STRING_FOR_NO_SIM)) {
            logd("SIM" + (slotId + STATUS_SIM1_INSERTED) + " hot plug in");
            mIccId[slotId] = null;
        }
        if (mPhone[slotId].getIccCard() != null) {
            fileHandler = mPhone[slotId].getIccCard().getIccFileHandler();
        }
        if (fileHandler != null) {
            String iccId = mIccId[slotId];
            if (iccId == null) {
                logd("Querying IccId");
                fileHandler.loadEFTransparent(IccConstants.EF_ICCID, obtainMessage(STATUS_SIM1_INSERTED, new QueryIccIdUserObj(reason, slotId)));
                return;
            }
            logd("NOT Querying IccId its already set sIccid[" + slotId + "]=" + iccId);
            return;
        }
        logd("sFh[" + slotId + "] is null, ignore");
    }

    private void handleSimLoaded(int slotId) {
        logd("handleSimStateLoadedInternal: slotId: " + slotId);
        IccRecords records = mPhone[slotId].getIccCard().getIccRecords();
        if (records == null) {
            logd("onRecieve: IccRecords null");
        } else if (records.getIccId() == null) {
            logd("onRecieve: IccID null");
        } else {
            mIccId[slotId] = records.getIccId();
            if (isAllIccIdQueryDone()) {
                updateSubscriptionInfoByIccId();
            }
            int subId = Integer.MAX_VALUE;
            int[] subIds = SubscriptionController.getInstance().getSubId(slotId);
            if (subIds != null) {
                subId = subIds[STATUS_NO_SIM_INSERTED];
            }
            if (SubscriptionManager.isValidSubscriptionId(subId)) {
                String operator = records.getOperatorNumeric();
                if (operator != null) {
                    if (subId == SubscriptionController.getInstance().getDefaultSubId()) {
                        MccTable.updateMccMncConfiguration(mContext, operator, false);
                    }
                    SubscriptionController.getInstance().setMccMnc(operator, subId);
                } else {
                    logd("EVENT_RECORDS_LOADED Operator name is null");
                }
                TelephonyManager tm = TelephonyManager.getDefault();
                String msisdn = tm.getLine1NumberForSubscriber(subId);
                ContentResolver contentResolver = mContext.getContentResolver();
                if (msisdn != null) {
                    ContentValues number = new ContentValues(STATUS_SIM1_INSERTED);
                    number.put("number", msisdn);
                    contentResolver.update(SubscriptionManager.CONTENT_URI, number, "_id=" + Long.toString((long) subId), null);
                }
                SubscriptionInfo subInfo = this.mSubscriptionManager.getActiveSubscriptionInfo(subId);
                String simCarrierName = tm.getSimOperatorNameForSubscription(subId);
                ContentValues name = new ContentValues(STATUS_SIM1_INSERTED);
                if (!(subInfo == null || subInfo.getNameSource() == STATUS_SIM2_INSERTED)) {
                    String nameToSet;
                    if (TextUtils.isEmpty(simCarrierName)) {
                        nameToSet = "CARD " + Integer.toString(slotId + STATUS_SIM1_INSERTED);
                    } else {
                        nameToSet = simCarrierName;
                    }
                    name.put("display_name", nameToSet);
                    logd("sim name = " + nameToSet);
                    contentResolver.update(SubscriptionManager.CONTENT_URI, name, "_id=" + Long.toString((long) subId), null);
                }
                SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(mContext);
                if (sp.getInt(CURR_SUBID + slotId, SIM_CHANGED) != subId) {
                    int networkType = RILConstants.PREFERRED_NETWORK_MODE;
                    mPhone[slotId].setPreferredNetworkType(networkType, null);
                    Global.putInt(mPhone[slotId].getContext().getContentResolver(), "preferred_network_mode" + subId, networkType);
                    mPhone[slotId].getNetworkSelectionMode(obtainMessage(STATUS_SIM2_INSERTED, new Integer(slotId)));
                    Editor editor = sp.edit();
                    editor.putInt(CURR_SUBID + slotId, subId);
                    editor.apply();
                }
            } else {
                logd("Invalid subId, could not update ContentResolver");
            }
            broadcastSimStateChanged(slotId, "LOADED", null);
        }
    }

    private void handleSimAbsent(int slotId) {
        if (!(mIccId[slotId] == null || mIccId[slotId].equals(ICCID_STRING_FOR_NO_SIM))) {
            logd("SIM" + (slotId + STATUS_SIM1_INSERTED) + " hot plug out");
        }
        mIccId[slotId] = ICCID_STRING_FOR_NO_SIM;
        if (isAllIccIdQueryDone()) {
            updateSubscriptionInfoByIccId();
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private synchronized void updateSubscriptionInfoByIccId() {
        /*
        r21 = this;
        monitor-enter(r21);
        r18 = "updateSubscriptionInfoByIccId:+ Start";
        r0 = r21;
        r1 = r18;
        r0.logd(r1);	 Catch:{ all -> 0x01a8 }
        r0 = r21;
        r0 = r0.mSubscriptionManager;	 Catch:{ all -> 0x01a8 }
        r18 = r0;
        r18.clearSubscriptionInfo();	 Catch:{ all -> 0x01a8 }
        r5 = 0;
    L_0x0014:
        r18 = PROJECT_SIM_NUM;	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        if (r5 >= r0) goto L_0x0023;
    L_0x001a:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r19 = 0;
        r18[r5] = r19;	 Catch:{ all -> 0x01a8 }
        r5 = r5 + 1;
        goto L_0x0014;
    L_0x0023:
        r7 = PROJECT_SIM_NUM;	 Catch:{ all -> 0x01a8 }
        r5 = 0;
    L_0x0026:
        r18 = PROJECT_SIM_NUM;	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        if (r5 >= r0) goto L_0x0043;
    L_0x002c:
        r18 = "";
        r19 = mIccId;	 Catch:{ all -> 0x01a8 }
        r19 = r19[r5];	 Catch:{ all -> 0x01a8 }
        r18 = r18.equals(r19);	 Catch:{ all -> 0x01a8 }
        if (r18 == 0) goto L_0x0040;
    L_0x0038:
        r7 = r7 + -1;
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r19 = -99;
        r18[r5] = r19;	 Catch:{ all -> 0x01a8 }
    L_0x0040:
        r5 = r5 + 1;
        goto L_0x0026;
    L_0x0043:
        r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a8 }
        r18.<init>();	 Catch:{ all -> 0x01a8 }
        r19 = "insertedSimCount = ";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        r18 = r0.append(r7);	 Catch:{ all -> 0x01a8 }
        r18 = r18.toString();	 Catch:{ all -> 0x01a8 }
        r0 = r21;
        r1 = r18;
        r0.logd(r1);	 Catch:{ all -> 0x01a8 }
        r6 = 0;
        r5 = 0;
    L_0x0061:
        r18 = PROJECT_SIM_NUM;	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        if (r5 >= r0) goto L_0x00a2;
    L_0x0067:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r18 = r18[r5];	 Catch:{ all -> 0x01a8 }
        r19 = -99;
        r0 = r18;
        r1 = r19;
        if (r0 != r1) goto L_0x0076;
    L_0x0073:
        r5 = r5 + 1;
        goto L_0x0061;
    L_0x0076:
        r6 = 2;
        r8 = r5 + 1;
    L_0x0079:
        r18 = PROJECT_SIM_NUM;	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        if (r8 >= r0) goto L_0x0073;
    L_0x007f:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r18 = r18[r8];	 Catch:{ all -> 0x01a8 }
        if (r18 != 0) goto L_0x009f;
    L_0x0085:
        r18 = mIccId;	 Catch:{ all -> 0x01a8 }
        r18 = r18[r5];	 Catch:{ all -> 0x01a8 }
        r19 = mIccId;	 Catch:{ all -> 0x01a8 }
        r19 = r19[r8];	 Catch:{ all -> 0x01a8 }
        r18 = r18.equals(r19);	 Catch:{ all -> 0x01a8 }
        if (r18 == 0) goto L_0x009f;
    L_0x0093:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r19 = 1;
        r18[r5] = r19;	 Catch:{ all -> 0x01a8 }
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r18[r8] = r6;	 Catch:{ all -> 0x01a8 }
        r6 = r6 + 1;
    L_0x009f:
        r8 = r8 + 1;
        goto L_0x0079;
    L_0x00a2:
        r18 = mContext;	 Catch:{ all -> 0x01a8 }
        r4 = r18.getContentResolver();	 Catch:{ all -> 0x01a8 }
        r18 = PROJECT_SIM_NUM;	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        r13 = new java.lang.String[r0];	 Catch:{ all -> 0x01a8 }
        r5 = 0;
    L_0x00af:
        r18 = PROJECT_SIM_NUM;	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        if (r5 >= r0) goto L_0x01ab;
    L_0x00b5:
        r18 = 0;
        r13[r5] = r18;	 Catch:{ all -> 0x01a8 }
        r18 = com.android.internal.telephony.SubscriptionController.getInstance();	 Catch:{ all -> 0x01a8 }
        r19 = 0;
        r0 = r18;
        r1 = r19;
        r14 = r0.getSubInfoUsingSlotIdWithCheck(r5, r1);	 Catch:{ all -> 0x01a8 }
        if (r14 == 0) goto L_0x0175;
    L_0x00c9:
        r18 = 0;
        r0 = r18;
        r18 = r14.get(r0);	 Catch:{ all -> 0x01a8 }
        r18 = (android.telephony.SubscriptionInfo) r18;	 Catch:{ all -> 0x01a8 }
        r18 = r18.getIccId();	 Catch:{ all -> 0x01a8 }
        r13[r5] = r18;	 Catch:{ all -> 0x01a8 }
        r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a8 }
        r18.<init>();	 Catch:{ all -> 0x01a8 }
        r19 = "updateSubscriptionInfoByIccId: oldSubId = ";
        r19 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r18 = 0;
        r0 = r18;
        r18 = r14.get(r0);	 Catch:{ all -> 0x01a8 }
        r18 = (android.telephony.SubscriptionInfo) r18;	 Catch:{ all -> 0x01a8 }
        r18 = r18.getSubscriptionId();	 Catch:{ all -> 0x01a8 }
        r0 = r19;
        r1 = r18;
        r18 = r0.append(r1);	 Catch:{ all -> 0x01a8 }
        r18 = r18.toString();	 Catch:{ all -> 0x01a8 }
        r0 = r21;
        r1 = r18;
        r0.logd(r1);	 Catch:{ all -> 0x01a8 }
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r18 = r18[r5];	 Catch:{ all -> 0x01a8 }
        if (r18 != 0) goto L_0x011d;
    L_0x010b:
        r18 = mIccId;	 Catch:{ all -> 0x01a8 }
        r18 = r18[r5];	 Catch:{ all -> 0x01a8 }
        r19 = r13[r5];	 Catch:{ all -> 0x01a8 }
        r18 = r18.equals(r19);	 Catch:{ all -> 0x01a8 }
        if (r18 != 0) goto L_0x011d;
    L_0x0117:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r19 = -1;
        r18[r5] = r19;	 Catch:{ all -> 0x01a8 }
    L_0x011d:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r18 = r18[r5];	 Catch:{ all -> 0x01a8 }
        if (r18 == 0) goto L_0x0171;
    L_0x0123:
        r17 = new android.content.ContentValues;	 Catch:{ all -> 0x01a8 }
        r18 = 1;
        r17.<init>(r18);	 Catch:{ all -> 0x01a8 }
        r18 = "sim_id";
        r19 = -1;
        r19 = java.lang.Integer.valueOf(r19);	 Catch:{ all -> 0x01a8 }
        r17.put(r18, r19);	 Catch:{ all -> 0x01a8 }
        r19 = android.telephony.SubscriptionManager.CONTENT_URI;	 Catch:{ all -> 0x01a8 }
        r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a8 }
        r18.<init>();	 Catch:{ all -> 0x01a8 }
        r20 = "_id=";
        r0 = r18;
        r1 = r20;
        r20 = r0.append(r1);	 Catch:{ all -> 0x01a8 }
        r18 = 0;
        r0 = r18;
        r18 = r14.get(r0);	 Catch:{ all -> 0x01a8 }
        r18 = (android.telephony.SubscriptionInfo) r18;	 Catch:{ all -> 0x01a8 }
        r18 = r18.getSubscriptionId();	 Catch:{ all -> 0x01a8 }
        r18 = java.lang.Integer.toString(r18);	 Catch:{ all -> 0x01a8 }
        r0 = r20;
        r1 = r18;
        r18 = r0.append(r1);	 Catch:{ all -> 0x01a8 }
        r18 = r18.toString();	 Catch:{ all -> 0x01a8 }
        r20 = 0;
        r0 = r19;
        r1 = r17;
        r2 = r18;
        r3 = r20;
        r4.update(r0, r1, r2, r3);	 Catch:{ all -> 0x01a8 }
    L_0x0171:
        r5 = r5 + 1;
        goto L_0x00af;
    L_0x0175:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r18 = r18[r5];	 Catch:{ all -> 0x01a8 }
        if (r18 != 0) goto L_0x0181;
    L_0x017b:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r19 = -1;
        r18[r5] = r19;	 Catch:{ all -> 0x01a8 }
    L_0x0181:
        r18 = "";
        r13[r5] = r18;	 Catch:{ all -> 0x01a8 }
        r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a8 }
        r18.<init>();	 Catch:{ all -> 0x01a8 }
        r19 = "updateSubscriptionInfoByIccId: No SIM in slot ";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        r18 = r0.append(r5);	 Catch:{ all -> 0x01a8 }
        r19 = " last time";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r18 = r18.toString();	 Catch:{ all -> 0x01a8 }
        r0 = r21;
        r1 = r18;
        r0.logd(r1);	 Catch:{ all -> 0x01a8 }
        goto L_0x0171;
    L_0x01a8:
        r18 = move-exception;
        monitor-exit(r21);
        throw r18;
    L_0x01ab:
        r5 = 0;
    L_0x01ac:
        r18 = PROJECT_SIM_NUM;	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        if (r5 >= r0) goto L_0x01f7;
    L_0x01b2:
        r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a8 }
        r18.<init>();	 Catch:{ all -> 0x01a8 }
        r19 = "updateSubscriptionInfoByIccId: oldIccId[";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        r18 = r0.append(r5);	 Catch:{ all -> 0x01a8 }
        r19 = "] = ";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r19 = r13[r5];	 Catch:{ all -> 0x01a8 }
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r19 = ", sIccId[";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        r18 = r0.append(r5);	 Catch:{ all -> 0x01a8 }
        r19 = "] = ";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r19 = mIccId;	 Catch:{ all -> 0x01a8 }
        r19 = r19[r5];	 Catch:{ all -> 0x01a8 }
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r18 = r18.toString();	 Catch:{ all -> 0x01a8 }
        r0 = r21;
        r1 = r18;
        r0.logd(r1);	 Catch:{ all -> 0x01a8 }
        r5 = r5 + 1;
        goto L_0x01ac;
    L_0x01f7:
        r10 = 0;
        r11 = 0;
        r5 = 0;
    L_0x01fa:
        r18 = PROJECT_SIM_NUM;	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        if (r5 >= r0) goto L_0x02b8;
    L_0x0200:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r18 = r18[r5];	 Catch:{ all -> 0x01a8 }
        r19 = -99;
        r0 = r18;
        r1 = r19;
        if (r0 != r1) goto L_0x0231;
    L_0x020c:
        r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a8 }
        r18.<init>();	 Catch:{ all -> 0x01a8 }
        r19 = "updateSubscriptionInfoByIccId: No SIM inserted in slot ";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        r18 = r0.append(r5);	 Catch:{ all -> 0x01a8 }
        r19 = " this time";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r18 = r18.toString();	 Catch:{ all -> 0x01a8 }
        r0 = r21;
        r1 = r18;
        r0.logd(r1);	 Catch:{ all -> 0x01a8 }
    L_0x022e:
        r5 = r5 + 1;
        goto L_0x01fa;
    L_0x0231:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r18 = r18[r5];	 Catch:{ all -> 0x01a8 }
        if (r18 <= 0) goto L_0x029d;
    L_0x0237:
        r0 = r21;
        r0 = r0.mSubscriptionManager;	 Catch:{ all -> 0x01a8 }
        r18 = r0;
        r19 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a8 }
        r19.<init>();	 Catch:{ all -> 0x01a8 }
        r20 = mIccId;	 Catch:{ all -> 0x01a8 }
        r20 = r20[r5];	 Catch:{ all -> 0x01a8 }
        r19 = r19.append(r20);	 Catch:{ all -> 0x01a8 }
        r20 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r20 = r20[r5];	 Catch:{ all -> 0x01a8 }
        r20 = java.lang.Integer.toString(r20);	 Catch:{ all -> 0x01a8 }
        r19 = r19.append(r20);	 Catch:{ all -> 0x01a8 }
        r19 = r19.toString();	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        r1 = r19;
        r0.addSubscriptionInfoRecord(r1, r5);	 Catch:{ all -> 0x01a8 }
        r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a8 }
        r18.<init>();	 Catch:{ all -> 0x01a8 }
        r19 = "SUB";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r19 = r5 + 1;
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r19 = " has invalid IccId";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r18 = r18.toString();	 Catch:{ all -> 0x01a8 }
        r0 = r21;
        r1 = r18;
        r0.logd(r1);	 Catch:{ all -> 0x01a8 }
    L_0x0283:
        r18 = mIccId;	 Catch:{ all -> 0x01a8 }
        r18 = r18[r5];	 Catch:{ all -> 0x01a8 }
        r0 = r21;
        r1 = r18;
        r18 = r0.isNewSim(r1, r13);	 Catch:{ all -> 0x01a8 }
        if (r18 == 0) goto L_0x022e;
    L_0x0291:
        r10 = r10 + 1;
        switch(r5) {
            case 0: goto L_0x02af;
            case 1: goto L_0x02b2;
            case 2: goto L_0x02b5;
            default: goto L_0x0296;
        };	 Catch:{ all -> 0x01a8 }
    L_0x0296:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r19 = -2;
        r18[r5] = r19;	 Catch:{ all -> 0x01a8 }
        goto L_0x022e;
    L_0x029d:
        r0 = r21;
        r0 = r0.mSubscriptionManager;	 Catch:{ all -> 0x01a8 }
        r18 = r0;
        r19 = mIccId;	 Catch:{ all -> 0x01a8 }
        r19 = r19[r5];	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        r1 = r19;
        r0.addSubscriptionInfoRecord(r1, r5);	 Catch:{ all -> 0x01a8 }
        goto L_0x0283;
    L_0x02af:
        r11 = r11 | 1;
        goto L_0x0296;
    L_0x02b2:
        r11 = r11 | 2;
        goto L_0x0296;
    L_0x02b5:
        r11 = r11 | 4;
        goto L_0x0296;
    L_0x02b8:
        r5 = 0;
    L_0x02b9:
        r18 = PROJECT_SIM_NUM;	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        if (r5 >= r0) goto L_0x02fe;
    L_0x02bf:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r18 = r18[r5];	 Catch:{ all -> 0x01a8 }
        r19 = -1;
        r0 = r18;
        r1 = r19;
        if (r0 != r1) goto L_0x02d1;
    L_0x02cb:
        r18 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r19 = -3;
        r18[r5] = r19;	 Catch:{ all -> 0x01a8 }
    L_0x02d1:
        r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a8 }
        r18.<init>();	 Catch:{ all -> 0x01a8 }
        r19 = "updateSubscriptionInfoByIccId: sInsertSimState[";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        r18 = r0.append(r5);	 Catch:{ all -> 0x01a8 }
        r19 = "] = ";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r19 = mInsertSimState;	 Catch:{ all -> 0x01a8 }
        r19 = r19[r5];	 Catch:{ all -> 0x01a8 }
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r18 = r18.toString();	 Catch:{ all -> 0x01a8 }
        r0 = r21;
        r1 = r18;
        r0.logd(r1);	 Catch:{ all -> 0x01a8 }
        r5 = r5 + 1;
        goto L_0x02b9;
    L_0x02fe:
        r0 = r21;
        r0 = r0.mSubscriptionManager;	 Catch:{ all -> 0x01a8 }
        r18 = r0;
        r15 = r18.getActiveSubscriptionInfoList();	 Catch:{ all -> 0x01a8 }
        if (r15 != 0) goto L_0x037b;
    L_0x030a:
        r12 = 0;
    L_0x030b:
        r18 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a8 }
        r18.<init>();	 Catch:{ all -> 0x01a8 }
        r19 = "updateSubscriptionInfoByIccId: nSubCount = ";
        r18 = r18.append(r19);	 Catch:{ all -> 0x01a8 }
        r0 = r18;
        r18 = r0.append(r12);	 Catch:{ all -> 0x01a8 }
        r18 = r18.toString();	 Catch:{ all -> 0x01a8 }
        r0 = r21;
        r1 = r18;
        r0.logd(r1);	 Catch:{ all -> 0x01a8 }
        r5 = 0;
    L_0x0328:
        if (r5 >= r12) goto L_0x0380;
    L_0x032a:
        r16 = r15.get(r5);	 Catch:{ all -> 0x01a8 }
        r16 = (android.telephony.SubscriptionInfo) r16;	 Catch:{ all -> 0x01a8 }
        r18 = android.telephony.TelephonyManager.getDefault();	 Catch:{ all -> 0x01a8 }
        r19 = r16.getSubscriptionId();	 Catch:{ all -> 0x01a8 }
        r9 = r18.getLine1NumberForSubscriber(r19);	 Catch:{ all -> 0x01a8 }
        if (r9 == 0) goto L_0x0378;
    L_0x033e:
        r17 = new android.content.ContentValues;	 Catch:{ all -> 0x01a8 }
        r18 = 1;
        r17.<init>(r18);	 Catch:{ all -> 0x01a8 }
        r18 = "number";
        r0 = r17;
        r1 = r18;
        r0.put(r1, r9);	 Catch:{ all -> 0x01a8 }
        r18 = android.telephony.SubscriptionManager.CONTENT_URI;	 Catch:{ all -> 0x01a8 }
        r19 = new java.lang.StringBuilder;	 Catch:{ all -> 0x01a8 }
        r19.<init>();	 Catch:{ all -> 0x01a8 }
        r20 = "_id=";
        r19 = r19.append(r20);	 Catch:{ all -> 0x01a8 }
        r20 = r16.getSubscriptionId();	 Catch:{ all -> 0x01a8 }
        r20 = java.lang.Integer.toString(r20);	 Catch:{ all -> 0x01a8 }
        r19 = r19.append(r20);	 Catch:{ all -> 0x01a8 }
        r19 = r19.toString();	 Catch:{ all -> 0x01a8 }
        r20 = 0;
        r0 = r18;
        r1 = r17;
        r2 = r19;
        r3 = r20;
        r4.update(r0, r1, r2, r3);	 Catch:{ all -> 0x01a8 }
    L_0x0378:
        r5 = r5 + 1;
        goto L_0x0328;
    L_0x037b:
        r12 = r15.size();	 Catch:{ all -> 0x01a8 }
        goto L_0x030b;
    L_0x0380:
        r18 = com.android.internal.telephony.SubscriptionController.getInstance();	 Catch:{ all -> 0x01a8 }
        r18.notifySubscriptionInfoChanged();	 Catch:{ all -> 0x01a8 }
        r18 = "updateSubscriptionInfoByIccId:- SsubscriptionInfo update complete";
        r0 = r21;
        r1 = r18;
        r0.logd(r1);	 Catch:{ all -> 0x01a8 }
        monitor-exit(r21);
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.SubscriptionInfoUpdater.updateSubscriptionInfoByIccId():void");
    }

    private boolean isNewSim(String iccId, String[] oldIccId) {
        boolean newSim = true;
        for (int i = STATUS_NO_SIM_INSERTED; i < PROJECT_SIM_NUM; i += STATUS_SIM1_INSERTED) {
            if (iccId.equals(oldIccId[i])) {
                newSim = false;
                break;
            }
        }
        logd("newSim = " + newSim);
        return newSim;
    }

    private void broadcastSimStateChanged(int slotId, String state, String reason) {
        Intent i = new Intent("android.intent.action.SIM_STATE_CHANGED");
        i.addFlags(67108864);
        i.putExtra("phoneName", "Phone");
        i.putExtra("ss", state);
        i.putExtra("reason", reason);
        SubscriptionManager.putPhoneIdAndSubIdExtra(i, slotId);
        logd("Broadcasting intent ACTION_SIM_STATE_CHANGED LOADED reason " + null + " for mCardIndex : " + slotId);
        ActivityManagerNative.broadcastStickyIntent(i, "android.permission.READ_PHONE_STATE", SIM_CHANGED);
    }

    public void dispose() {
        logd("[dispose]");
        mContext.unregisterReceiver(this.sReceiver);
    }

    private void logd(String message) {
        Rlog.d(LOG_TAG, message);
    }
}
