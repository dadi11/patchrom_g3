package com.android.internal.telephony;

import android.content.Context;
import android.content.Intent;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.provider.Settings.Global;
import android.provider.Settings.SettingNotFoundException;
import android.telephony.Rlog;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import com.android.internal.telephony.cdma.CDMALTEPhone;
import com.android.internal.telephony.dataconnection.DctController;
import com.android.internal.telephony.gsm.GSMPhone;
import com.android.internal.telephony.imsphone.ImsPhone;
import com.android.internal.telephony.imsphone.ImsPhoneFactory;
import com.android.internal.telephony.sip.SipPhone;
import com.android.internal.telephony.sip.SipPhoneFactory;
import com.android.internal.telephony.uicc.IccCardProxy;
import com.android.internal.telephony.uicc.UiccController;
import java.io.FileDescriptor;
import java.io.PrintWriter;

public class PhoneFactory {
    static final String LOG_TAG = "PhoneFactory";
    static final int SOCKET_OPEN_MAX_RETRY = 3;
    static final int SOCKET_OPEN_RETRY_MILLIS = 2000;
    private static ProxyController mProxyController;
    private static UiccController mUiccController;
    private static CommandsInterface sCommandsInterface;
    private static CommandsInterface[] sCommandsInterfaces;
    private static Context sContext;
    static final Object sLockProxyPhones;
    private static boolean sMadeDefaults;
    private static PhoneNotifier sPhoneNotifier;
    private static PhoneProxy sProxyPhone;
    private static PhoneProxy[] sProxyPhones;
    private static SubscriptionInfoUpdater sSubInfoRecordUpdater;

    static {
        sLockProxyPhones = new Object();
        sProxyPhones = null;
        sProxyPhone = null;
        sCommandsInterfaces = null;
        sCommandsInterface = null;
        sSubInfoRecordUpdater = null;
        sMadeDefaults = false;
    }

    public static void makeDefaultPhones(Context context) {
        makeDefaultPhone(context);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public static void makeDefaultPhone(android.content.Context r22) {
        /*
        r18 = sLockProxyPhones;
        monitor-enter(r18);
        r17 = sMadeDefaults;	 Catch:{ all -> 0x00e6 }
        if (r17 != 0) goto L_0x021e;
    L_0x0007:
        sContext = r22;	 Catch:{ all -> 0x00e6 }
        com.android.internal.telephony.TelephonyDevController.create();	 Catch:{ all -> 0x00e6 }
        r15 = 0;
    L_0x000d:
        r8 = 0;
        r15 = r15 + 1;
        r17 = new android.net.LocalServerSocket;	 Catch:{ IOException -> 0x00d0 }
        r19 = "com.android.internal.telephony";
        r0 = r17;
        r1 = r19;
        r0.<init>(r1);	 Catch:{ IOException -> 0x00d0 }
    L_0x001b:
        if (r8 != 0) goto L_0x00d4;
    L_0x001d:
        r17 = new com.android.internal.telephony.DefaultPhoneNotifier;	 Catch:{ all -> 0x00e6 }
        r17.<init>();	 Catch:{ all -> 0x00e6 }
        sPhoneNotifier = r17;	 Catch:{ all -> 0x00e6 }
        r4 = com.android.internal.telephony.cdma.CdmaSubscriptionSourceManager.getDefault(r22);	 Catch:{ all -> 0x00e6 }
        r17 = "PhoneFactory";
        r19 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00e6 }
        r19.<init>();	 Catch:{ all -> 0x00e6 }
        r20 = "Cdma Subscription set to ";
        r19 = r19.append(r20);	 Catch:{ all -> 0x00e6 }
        r0 = r19;
        r19 = r0.append(r4);	 Catch:{ all -> 0x00e6 }
        r19 = r19.toString();	 Catch:{ all -> 0x00e6 }
        r0 = r17;
        r1 = r19;
        android.telephony.Rlog.i(r0, r1);	 Catch:{ all -> 0x00e6 }
        r17 = android.telephony.TelephonyManager.getDefault();	 Catch:{ all -> 0x00e6 }
        r11 = r17.getPhoneCount();	 Catch:{ all -> 0x00e6 }
        r10 = new int[r11];	 Catch:{ all -> 0x00e6 }
        r0 = new com.android.internal.telephony.PhoneProxy[r11];	 Catch:{ all -> 0x00e6 }
        r17 = r0;
        sProxyPhones = r17;	 Catch:{ all -> 0x00e6 }
        r0 = new com.android.internal.telephony.RIL[r11];	 Catch:{ all -> 0x00e6 }
        r17 = r0;
        sCommandsInterfaces = r17;	 Catch:{ all -> 0x00e6 }
        r17 = "ro.telephony.ril_class";
        r19 = "RIL";
        r0 = r17;
        r1 = r19;
        r17 = android.os.SystemProperties.get(r0, r1);	 Catch:{ all -> 0x00e6 }
        r16 = r17.trim();	 Catch:{ all -> 0x00e6 }
        r17 = "PhoneFactory";
        r19 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00e6 }
        r19.<init>();	 Catch:{ all -> 0x00e6 }
        r20 = "RILClassname is ";
        r19 = r19.append(r20);	 Catch:{ all -> 0x00e6 }
        r0 = r19;
        r1 = r16;
        r19 = r0.append(r1);	 Catch:{ all -> 0x00e6 }
        r19 = r19.toString();	 Catch:{ all -> 0x00e6 }
        r0 = r17;
        r1 = r19;
        android.telephony.Rlog.i(r0, r1);	 Catch:{ all -> 0x00e6 }
        r9 = 0;
    L_0x008d:
        if (r9 >= r11) goto L_0x0107;
    L_0x008f:
        r17 = com.android.internal.telephony.RILConstants.PREFERRED_NETWORK_MODE;	 Catch:{ all -> 0x00e6 }
        r10[r9] = r17;	 Catch:{ all -> 0x00e6 }
        r17 = "PhoneFactory";
        r19 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00e6 }
        r19.<init>();	 Catch:{ all -> 0x00e6 }
        r20 = "Network Mode set to ";
        r19 = r19.append(r20);	 Catch:{ all -> 0x00e6 }
        r20 = r10[r9];	 Catch:{ all -> 0x00e6 }
        r20 = java.lang.Integer.toString(r20);	 Catch:{ all -> 0x00e6 }
        r19 = r19.append(r20);	 Catch:{ all -> 0x00e6 }
        r19 = r19.toString();	 Catch:{ all -> 0x00e6 }
        r0 = r17;
        r1 = r19;
        android.telephony.Rlog.i(r0, r1);	 Catch:{ all -> 0x00e6 }
        r19 = sCommandsInterfaces;	 Catch:{ Exception -> 0x00f3 }
        r17 = r10[r9];	 Catch:{ Exception -> 0x00f3 }
        r20 = java.lang.Integer.valueOf(r9);	 Catch:{ Exception -> 0x00f3 }
        r0 = r16;
        r1 = r22;
        r2 = r17;
        r3 = r20;
        r17 = instantiateCustomRIL(r0, r1, r2, r4, r3);	 Catch:{ Exception -> 0x00f3 }
        r17 = (com.android.internal.telephony.CommandsInterface) r17;	 Catch:{ Exception -> 0x00f3 }
        r19[r9] = r17;	 Catch:{ Exception -> 0x00f3 }
        r9 = r9 + 1;
        goto L_0x008d;
    L_0x00d0:
        r7 = move-exception;
        r8 = 1;
        goto L_0x001b;
    L_0x00d4:
        r17 = 3;
        r0 = r17;
        if (r15 <= r0) goto L_0x00e9;
    L_0x00da:
        r17 = new java.lang.RuntimeException;	 Catch:{ all -> 0x00e6 }
        r19 = "PhoneFactory probably already running";
        r0 = r17;
        r1 = r19;
        r0.<init>(r1);	 Catch:{ all -> 0x00e6 }
        throw r17;	 Catch:{ all -> 0x00e6 }
    L_0x00e6:
        r17 = move-exception;
        monitor-exit(r18);	 Catch:{ all -> 0x00e6 }
        throw r17;
    L_0x00e9:
        r20 = 2000; // 0x7d0 float:2.803E-42 double:9.88E-321;
        java.lang.Thread.sleep(r20);	 Catch:{ InterruptedException -> 0x00f0 }
        goto L_0x000d;
    L_0x00f0:
        r17 = move-exception;
        goto L_0x000d;
    L_0x00f3:
        r6 = move-exception;
    L_0x00f4:
        r17 = "PhoneFactory";
        r19 = "Unable to construct custom RIL class";
        r0 = r17;
        r1 = r19;
        android.telephony.Rlog.e(r0, r1, r6);	 Catch:{ all -> 0x00e6 }
        r20 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        java.lang.Thread.sleep(r20);	 Catch:{ InterruptedException -> 0x0105 }
        goto L_0x00f4;
    L_0x0105:
        r17 = move-exception;
        goto L_0x00f4;
    L_0x0107:
        r17 = "PhoneFactory";
        r19 = "Creating SubscriptionController";
        r0 = r17;
        r1 = r19;
        android.telephony.Rlog.i(r0, r1);	 Catch:{ all -> 0x00e6 }
        r17 = sCommandsInterfaces;	 Catch:{ all -> 0x00e6 }
        r0 = r22;
        r1 = r17;
        com.android.internal.telephony.SubscriptionController.init(r0, r1);	 Catch:{ all -> 0x00e6 }
        r17 = sCommandsInterfaces;	 Catch:{ all -> 0x00e6 }
        r0 = r22;
        r1 = r17;
        r17 = com.android.internal.telephony.uicc.UiccController.make(r0, r1);	 Catch:{ all -> 0x00e6 }
        mUiccController = r17;	 Catch:{ all -> 0x00e6 }
        r9 = 0;
    L_0x0128:
        if (r9 >= r11) goto L_0x0198;
    L_0x012a:
        r13 = 0;
        r17 = r10[r9];	 Catch:{ all -> 0x00e6 }
        r14 = android.telephony.TelephonyManager.getPhoneType(r17);	 Catch:{ all -> 0x00e6 }
        r17 = 1;
        r0 = r17;
        if (r14 != r0) goto L_0x0180;
    L_0x0137:
        r13 = new com.android.internal.telephony.gsm.GSMPhone;	 Catch:{ all -> 0x00e6 }
        r17 = sCommandsInterfaces;	 Catch:{ all -> 0x00e6 }
        r17 = r17[r9];	 Catch:{ all -> 0x00e6 }
        r19 = sPhoneNotifier;	 Catch:{ all -> 0x00e6 }
        r0 = r22;
        r1 = r17;
        r2 = r19;
        r13.<init>(r0, r1, r2, r9);	 Catch:{ all -> 0x00e6 }
    L_0x0148:
        r17 = "PhoneFactory";
        r19 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00e6 }
        r19.<init>();	 Catch:{ all -> 0x00e6 }
        r20 = "Creating Phone with type = ";
        r19 = r19.append(r20);	 Catch:{ all -> 0x00e6 }
        r0 = r19;
        r19 = r0.append(r14);	 Catch:{ all -> 0x00e6 }
        r20 = " sub = ";
        r19 = r19.append(r20);	 Catch:{ all -> 0x00e6 }
        r0 = r19;
        r19 = r0.append(r9);	 Catch:{ all -> 0x00e6 }
        r19 = r19.toString();	 Catch:{ all -> 0x00e6 }
        r0 = r17;
        r1 = r19;
        android.telephony.Rlog.i(r0, r1);	 Catch:{ all -> 0x00e6 }
        r17 = sProxyPhones;	 Catch:{ all -> 0x00e6 }
        r19 = new com.android.internal.telephony.PhoneProxy;	 Catch:{ all -> 0x00e6 }
        r0 = r19;
        r0.<init>(r13);	 Catch:{ all -> 0x00e6 }
        r17[r9] = r19;	 Catch:{ all -> 0x00e6 }
        r9 = r9 + 1;
        goto L_0x0128;
    L_0x0180:
        r17 = 2;
        r0 = r17;
        if (r14 != r0) goto L_0x0148;
    L_0x0186:
        r13 = new com.android.internal.telephony.cdma.CDMALTEPhone;	 Catch:{ all -> 0x00e6 }
        r17 = sCommandsInterfaces;	 Catch:{ all -> 0x00e6 }
        r17 = r17[r9];	 Catch:{ all -> 0x00e6 }
        r19 = sPhoneNotifier;	 Catch:{ all -> 0x00e6 }
        r0 = r22;
        r1 = r17;
        r2 = r19;
        r13.<init>(r0, r1, r2, r9);	 Catch:{ all -> 0x00e6 }
        goto L_0x0148;
    L_0x0198:
        r17 = sProxyPhones;	 Catch:{ all -> 0x00e6 }
        r19 = mUiccController;	 Catch:{ all -> 0x00e6 }
        r20 = sCommandsInterfaces;	 Catch:{ all -> 0x00e6 }
        r0 = r22;
        r1 = r17;
        r2 = r19;
        r3 = r20;
        r17 = com.android.internal.telephony.ProxyController.getInstance(r0, r1, r2, r3);	 Catch:{ all -> 0x00e6 }
        mProxyController = r17;	 Catch:{ all -> 0x00e6 }
        r17 = sProxyPhones;	 Catch:{ all -> 0x00e6 }
        r19 = 0;
        r17 = r17[r19];	 Catch:{ all -> 0x00e6 }
        sProxyPhone = r17;	 Catch:{ all -> 0x00e6 }
        r17 = sCommandsInterfaces;	 Catch:{ all -> 0x00e6 }
        r19 = 0;
        r17 = r17[r19];	 Catch:{ all -> 0x00e6 }
        sCommandsInterface = r17;	 Catch:{ all -> 0x00e6 }
        r17 = 1;
        r0 = r22;
        r1 = r17;
        r5 = com.android.internal.telephony.SmsApplication.getDefaultSmsApplication(r0, r1);	 Catch:{ all -> 0x00e6 }
        r12 = "NONE";
        if (r5 == 0) goto L_0x01ce;
    L_0x01ca:
        r12 = r5.getPackageName();	 Catch:{ all -> 0x00e6 }
    L_0x01ce:
        r17 = "PhoneFactory";
        r19 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00e6 }
        r19.<init>();	 Catch:{ all -> 0x00e6 }
        r20 = "defaultSmsApplication: ";
        r19 = r19.append(r20);	 Catch:{ all -> 0x00e6 }
        r0 = r19;
        r19 = r0.append(r12);	 Catch:{ all -> 0x00e6 }
        r19 = r19.toString();	 Catch:{ all -> 0x00e6 }
        r0 = r17;
        r1 = r19;
        android.telephony.Rlog.i(r0, r1);	 Catch:{ all -> 0x00e6 }
        com.android.internal.telephony.SmsApplication.initSmsPackageMonitor(r22);	 Catch:{ all -> 0x00e6 }
        r17 = 1;
        sMadeDefaults = r17;	 Catch:{ all -> 0x00e6 }
        r17 = "PhoneFactory";
        r19 = "Creating SubInfoRecordUpdater ";
        r0 = r17;
        r1 = r19;
        android.telephony.Rlog.i(r0, r1);	 Catch:{ all -> 0x00e6 }
        r17 = new com.android.internal.telephony.SubscriptionInfoUpdater;	 Catch:{ all -> 0x00e6 }
        r19 = sProxyPhones;	 Catch:{ all -> 0x00e6 }
        r20 = sCommandsInterfaces;	 Catch:{ all -> 0x00e6 }
        r0 = r17;
        r1 = r22;
        r2 = r19;
        r3 = r20;
        r0.<init>(r1, r2, r3);	 Catch:{ all -> 0x00e6 }
        sSubInfoRecordUpdater = r17;	 Catch:{ all -> 0x00e6 }
        r17 = com.android.internal.telephony.SubscriptionController.getInstance();	 Catch:{ all -> 0x00e6 }
        r19 = sProxyPhones;	 Catch:{ all -> 0x00e6 }
        r0 = r17;
        r1 = r19;
        r0.updatePhonesAvailability(r1);	 Catch:{ all -> 0x00e6 }
    L_0x021e:
        monitor-exit(r18);	 Catch:{ all -> 0x00e6 }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.PhoneFactory.makeDefaultPhone(android.content.Context):void");
    }

    public static Phone getCdmaPhone(int phoneId) {
        Phone phone;
        synchronized (PhoneProxy.lockForRadioTechnologyChange) {
            phone = new CDMALTEPhone(sContext, sCommandsInterfaces[phoneId], sPhoneNotifier, phoneId);
        }
        return phone;
    }

    public static Phone getGsmPhone(int phoneId) {
        Phone phone;
        synchronized (PhoneProxy.lockForRadioTechnologyChange) {
            phone = new GSMPhone(sContext, sCommandsInterfaces[phoneId], sPhoneNotifier, phoneId);
        }
        return phone;
    }

    private static <T> T instantiateCustomRIL(String sRILClassname, Context context, int networkMode, int cdmaSubscription, Integer instanceId) throws Exception {
        Class<?> clazz = Class.forName("com.android.internal.telephony." + sRILClassname);
        return clazz.cast(clazz.getConstructor(new Class[]{Context.class, Integer.TYPE, Integer.TYPE, Integer.class}).newInstance(new Object[]{context, Integer.valueOf(networkMode), Integer.valueOf(cdmaSubscription), instanceId}));
    }

    public static Phone getDefaultPhone() {
        Phone phone;
        synchronized (sLockProxyPhones) {
            if (sMadeDefaults) {
                phone = sProxyPhone;
            } else {
                throw new IllegalStateException("Default phones haven't been made yet!");
            }
        }
        return phone;
    }

    public static Phone getPhone(int phoneId) {
        Phone phone;
        String dbgInfo = "";
        synchronized (sLockProxyPhones) {
            if (sMadeDefaults) {
                if (phoneId == Integer.MAX_VALUE) {
                    dbgInfo = "phoneId == DEFAULT_PHONE_ID return sProxyPhone";
                    phone = sProxyPhone;
                } else {
                    dbgInfo = "phoneId != DEFAULT_PHONE_ID return sProxyPhones[phoneId]";
                    phone = (phoneId < 0 || phoneId >= TelephonyManager.getDefault().getPhoneCount()) ? null : sProxyPhones[phoneId];
                }
                Rlog.d(LOG_TAG, "getPhone:- " + dbgInfo + " phoneId=" + phoneId + " phone=" + phone);
            } else {
                throw new IllegalStateException("Default phones haven't been made yet!");
            }
        }
        return phone;
    }

    public static Phone[] getPhones() {
        Phone[] phoneArr;
        synchronized (sLockProxyPhones) {
            if (sMadeDefaults) {
                phoneArr = sProxyPhones;
            } else {
                throw new IllegalStateException("Default phones haven't been made yet!");
            }
        }
        return phoneArr;
    }

    public static SipPhone makeSipPhone(String sipUri) {
        return SipPhoneFactory.makePhone(sipUri, sContext, sPhoneNotifier);
    }

    public static void setDefaultSubscription(int subId) {
        SystemProperties.set("persist.radio.default.sub", Integer.toString(subId));
        int phoneId = SubscriptionController.getInstance().getPhoneId(subId);
        synchronized (sLockProxyPhones) {
            if (phoneId >= 0) {
                if (phoneId < sProxyPhones.length) {
                    sProxyPhone = sProxyPhones[phoneId];
                    sCommandsInterface = sCommandsInterfaces[phoneId];
                    sMadeDefaults = true;
                }
            }
        }
        String defaultMccMnc = TelephonyManager.getDefault().getSimOperatorNumericForPhone(phoneId);
        Rlog.d(LOG_TAG, "update mccmnc=" + defaultMccMnc);
        MccTable.updateMccMncConfiguration(sContext, defaultMccMnc, false);
        Intent intent = new Intent("android.intent.action.ACTION_DEFAULT_SUBSCRIPTION_CHANGED");
        intent.addFlags(536870912);
        SubscriptionManager.putPhoneIdAndSubIdExtra(intent, phoneId);
        Rlog.d(LOG_TAG, "setDefaultSubscription : " + subId + " Broadcasting Default Subscription Changed...");
        sContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    public static int calculatePreferredNetworkType(Context context, int phoneSubId) {
        int networkType = Global.getInt(context.getContentResolver(), "preferred_network_mode" + phoneSubId, RILConstants.PREFERRED_NETWORK_MODE);
        Rlog.d(LOG_TAG, "calculatePreferredNetworkType: phoneSubId = " + phoneSubId + " networkType = " + networkType);
        return networkType;
    }

    public static int getDefaultSubscription() {
        return SubscriptionController.getInstance().getDefaultSubId();
    }

    public static int getVoiceSubscription() {
        int subId = -1;
        try {
            subId = Global.getInt(sContext.getContentResolver(), "multi_sim_voice_call");
        } catch (SettingNotFoundException e) {
            Rlog.e(LOG_TAG, "Settings Exception Reading Dual Sim Voice Call Values");
        }
        return subId;
    }

    public static boolean isPromptEnabled() {
        int value = 0;
        try {
            value = Global.getInt(sContext.getContentResolver(), "multi_sim_voice_prompt");
        } catch (SettingNotFoundException e) {
            Rlog.e(LOG_TAG, "Settings Exception Reading Dual Sim Voice Prompt Values");
        }
        boolean prompt = value != 0;
        Rlog.d(LOG_TAG, "Prompt option:" + prompt);
        return prompt;
    }

    public static void setPromptEnabled(boolean enabled) {
        Global.putInt(sContext.getContentResolver(), "multi_sim_voice_prompt", !enabled ? 0 : 1);
        Rlog.d(LOG_TAG, "setVoicePromptOption to " + enabled);
    }

    public static boolean isSMSPromptEnabled() {
        int value = 0;
        try {
            value = Global.getInt(sContext.getContentResolver(), "multi_sim_sms_prompt");
        } catch (SettingNotFoundException e) {
            Rlog.e(LOG_TAG, "Settings Exception Reading Dual Sim SMS Prompt Values");
        }
        boolean prompt = value != 0;
        Rlog.d(LOG_TAG, "SMS Prompt option:" + prompt);
        return prompt;
    }

    public static void setSMSPromptEnabled(boolean enabled) {
        Global.putInt(sContext.getContentResolver(), "multi_sim_sms_prompt", !enabled ? 0 : 1);
        Rlog.d(LOG_TAG, "setSMSPromptOption to " + enabled);
    }

    public static long getDataSubscription() {
        int subId = -1;
        try {
            subId = Global.getInt(sContext.getContentResolver(), "multi_sim_data_call");
        } catch (SettingNotFoundException e) {
            Rlog.e(LOG_TAG, "Settings Exception Reading Dual Sim Data Call Values");
        }
        return (long) subId;
    }

    public static int getSMSSubscription() {
        int subId = -1;
        try {
            subId = Global.getInt(sContext.getContentResolver(), "multi_sim_sms");
        } catch (SettingNotFoundException e) {
            Rlog.e(LOG_TAG, "Settings Exception Reading Dual Sim SMS Values");
        }
        return subId;
    }

    public static ImsPhone makeImsPhone(PhoneNotifier phoneNotifier, Phone defaultPhone) {
        return ImsPhoneFactory.makePhone(sContext, phoneNotifier, defaultPhone);
    }

    public static void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("PhoneFactory:");
        int i = -1;
        for (PhoneProxy phoneProxy : (PhoneProxy[]) getPhones()) {
            i++;
            try {
                ((PhoneBase) phoneProxy.getActivePhone()).dump(fd, pw, args);
                pw.flush();
                pw.println("++++++++++++++++++++++++++++++++");
                try {
                    ((IccCardProxy) phoneProxy.getIccCard()).dump(fd, pw, args);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                pw.flush();
                pw.println("++++++++++++++++++++++++++++++++");
            } catch (Exception e2) {
                pw.println("Telephony DebugService: Could not get Phone[" + i + "] e=" + e2);
            }
        }
        try {
            DctController.getInstance().dump(fd, pw, args);
        } catch (Exception e22) {
            e22.printStackTrace();
        }
        try {
            mUiccController.dump(fd, pw, args);
        } catch (Exception e222) {
            e222.printStackTrace();
        }
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
        try {
            SubscriptionController.getInstance().dump(fd, pw, args);
        } catch (Exception e2222) {
            e2222.printStackTrace();
        }
        pw.flush();
    }
}
