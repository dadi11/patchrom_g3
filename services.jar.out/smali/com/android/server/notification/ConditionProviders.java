package com.android.server.notification;

import android.content.ComponentName;
import android.content.Context;
import android.net.Uri;
import android.os.Handler;
import android.os.IBinder;
import android.os.IInterface;
import android.os.RemoteException;
import android.service.notification.Condition;
import android.service.notification.IConditionListener;
import android.service.notification.IConditionProvider;
import android.service.notification.IConditionProvider.Stub;
import android.service.notification.ZenModeConfig;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.Slog;
import com.android.server.notification.ManagedServices.ManagedServiceInfo;
import com.android.server.notification.ManagedServices.UserProfiles;
import com.android.server.notification.NotificationManagerService.DumpFilter;
import com.android.server.notification.ZenModeHelper.Callback;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Objects;

public class ConditionProviders extends ManagedServices {
    private static final Condition[] NO_CONDITIONS;
    private final CountdownConditionProvider mCountdown;
    private final DowntimeConditionProvider mDowntime;
    private Condition mExitCondition;
    private ComponentName mExitConditionComponent;
    private final ArrayMap<IBinder, IConditionListener> mListeners;
    private final NextAlarmConditionProvider mNextAlarm;
    private final NextAlarmTracker mNextAlarmTracker;
    private final ArrayList<ConditionRecord> mRecords;
    private final ArraySet<String> mSystemConditionProviders;
    private final ZenModeHelper mZenModeHelper;

    private static class ConditionRecord {
        public final ComponentName component;
        public Condition condition;
        public final Uri id;
        public ManagedServiceInfo info;
        public boolean isAutomatic;
        public boolean isManual;

        private ConditionRecord(Uri id, ComponentName component) {
            this.id = id;
            this.component = component;
        }

        public String toString() {
            StringBuilder sb = new StringBuilder("ConditionRecord[id=").append(this.id).append(",component=").append(this.component);
            if (this.isAutomatic) {
                sb.append(",automatic");
            }
            if (this.isManual) {
                sb.append(",manual");
            }
            return sb.append(']').toString();
        }
    }

    private class ZenModeHelperCallback extends Callback {
        private ZenModeHelperCallback() {
        }

        void onConfigChanged() {
            ConditionProviders.this.loadZenConfig();
        }

        void onZenModeChanged() {
            if (ConditionProviders.this.mZenModeHelper.getZenMode() == 0) {
                ConditionProviders.this.setZenModeCondition(null, "zenOff");
            }
        }
    }

    static {
        NO_CONDITIONS = new Condition[0];
    }

    public ConditionProviders(Context context, Handler handler, UserProfiles userProfiles, ZenModeHelper zenModeHelper) {
        CountdownConditionProvider countdownConditionProvider;
        DowntimeConditionProvider downtimeConditionProvider;
        NextAlarmConditionProvider nextAlarmConditionProvider = null;
        super(context, handler, new Object(), userProfiles);
        this.mListeners = new ArrayMap();
        this.mRecords = new ArrayList();
        this.mZenModeHelper = zenModeHelper;
        this.mZenModeHelper.addCallback(new ZenModeHelperCallback());
        this.mSystemConditionProviders = safeSet(PropConfig.getStringArray(this.mContext, "system.condition.providers", 17236031));
        boolean countdown = this.mSystemConditionProviders.contains("countdown");
        boolean downtime = this.mSystemConditionProviders.contains("downtime");
        boolean nextAlarm = this.mSystemConditionProviders.contains("next_alarm");
        NextAlarmTracker nextAlarmTracker = (downtime || nextAlarm) ? new NextAlarmTracker(this.mContext) : null;
        this.mNextAlarmTracker = nextAlarmTracker;
        if (countdown) {
            countdownConditionProvider = new CountdownConditionProvider();
        } else {
            countdownConditionProvider = null;
        }
        this.mCountdown = countdownConditionProvider;
        if (downtime) {
            downtimeConditionProvider = new DowntimeConditionProvider(this, this.mNextAlarmTracker, this.mZenModeHelper);
        } else {
            downtimeConditionProvider = null;
        }
        this.mDowntime = downtimeConditionProvider;
        if (nextAlarm) {
            nextAlarmConditionProvider = new NextAlarmConditionProvider(this.mNextAlarmTracker);
        }
        this.mNextAlarm = nextAlarmConditionProvider;
        loadZenConfig();
    }

    public boolean isSystemConditionProviderEnabled(String path) {
        return this.mSystemConditionProviders.contains(path);
    }

    protected Config getConfig() {
        Config c = new Config();
        c.caption = "condition provider";
        c.serviceInterface = "android.service.notification.ConditionProviderService";
        c.secureSettingName = "enabled_condition_providers";
        c.bindPermission = "android.permission.BIND_CONDITION_PROVIDER_SERVICE";
        c.settingsAction = "android.settings.ACTION_CONDITION_PROVIDER_SETTINGS";
        c.clientLabel = 17040729;
        return c;
    }

    public void dump(PrintWriter pw, DumpFilter filter) {
        super.dump(pw, filter);
        synchronized (this.mMutex) {
            int i;
            if (filter == null) {
                pw.print("    mListeners(");
                pw.print(this.mListeners.size());
                pw.println("):");
                for (i = 0; i < this.mListeners.size(); i++) {
                    pw.print("      ");
                    pw.println(this.mListeners.keyAt(i));
                }
            }
            pw.print("    mRecords(");
            pw.print(this.mRecords.size());
            pw.println("):");
            for (i = 0; i < this.mRecords.size(); i++) {
                ConditionRecord r = (ConditionRecord) this.mRecords.get(i);
                if (filter == null || filter.matches(r.component)) {
                    pw.print("      ");
                    pw.println(r);
                    String countdownDesc = CountdownConditionProvider.tryParseDescription(r.id);
                    if (countdownDesc != null) {
                        pw.print("        (");
                        pw.print(countdownDesc);
                        pw.println(")");
                    }
                }
            }
        }
        pw.print("    mSystemConditionProviders: ");
        pw.println(this.mSystemConditionProviders);
        if (this.mCountdown != null) {
            this.mCountdown.dump(pw, filter);
        }
        if (this.mDowntime != null) {
            this.mDowntime.dump(pw, filter);
        }
        if (this.mNextAlarm != null) {
            this.mNextAlarm.dump(pw, filter);
        }
        if (this.mNextAlarmTracker != null) {
            this.mNextAlarmTracker.dump(pw, filter);
        }
    }

    protected IInterface asInterface(IBinder binder) {
        return Stub.asInterface(binder);
    }

    public void onBootPhaseAppsCanStart() {
        super.onBootPhaseAppsCanStart();
        if (this.mNextAlarmTracker != null) {
            this.mNextAlarmTracker.init();
        }
        if (this.mCountdown != null) {
            this.mCountdown.attachBase(this.mContext);
            registerService(this.mCountdown.asInterface(), CountdownConditionProvider.COMPONENT, 0);
        }
        if (this.mDowntime != null) {
            this.mDowntime.attachBase(this.mContext);
            registerService(this.mDowntime.asInterface(), DowntimeConditionProvider.COMPONENT, 0);
        }
        if (this.mNextAlarm != null) {
            this.mNextAlarm.attachBase(this.mContext);
            registerService(this.mNextAlarm.asInterface(), NextAlarmConditionProvider.COMPONENT, 0);
        }
    }

    public void onUserSwitched() {
        super.onUserSwitched();
        if (this.mNextAlarmTracker != null) {
            this.mNextAlarmTracker.onUserSwitched();
        }
    }

    protected void onServiceAdded(ManagedServiceInfo info) {
        try {
            provider(info).onConnected();
        } catch (RemoteException e) {
        }
        synchronized (this.mMutex) {
            if (info.component.equals(this.mExitConditionComponent)) {
                getRecordLocked(this.mExitCondition.id, this.mExitConditionComponent).isManual = true;
            }
            int N = this.mRecords.size();
            for (int i = 0; i < N; i++) {
                ConditionRecord r = (ConditionRecord) this.mRecords.get(i);
                if (r.component.equals(info.component)) {
                    r.info = info;
                    if (r.isAutomatic || r.isManual) {
                        subscribeLocked(r);
                    }
                }
            }
        }
    }

    protected void onServiceRemovedLocked(ManagedServiceInfo removed) {
        if (removed != null) {
            for (int i = this.mRecords.size() - 1; i >= 0; i--) {
                ConditionRecord r = (ConditionRecord) this.mRecords.get(i);
                if (r.component.equals(removed.component)) {
                    if (r.isManual) {
                        onManualConditionClearing();
                        this.mZenModeHelper.setZenMode(0, "manualServiceRemoved");
                    }
                    if (r.isAutomatic) {
                        this.mZenModeHelper.setZenMode(0, "automaticServiceRemoved");
                    }
                    this.mRecords.remove(i);
                }
            }
        }
    }

    public ManagedServiceInfo checkServiceToken(IConditionProvider provider) {
        ManagedServiceInfo checkServiceTokenLocked;
        synchronized (this.mMutex) {
            checkServiceTokenLocked = checkServiceTokenLocked(provider);
        }
        return checkServiceTokenLocked;
    }

    public void requestZenModeConditions(IConditionListener callback, int relevance) {
        synchronized (this.mMutex) {
            if (this.DEBUG) {
                Slog.d(this.TAG, "requestZenModeConditions callback=" + callback + " relevance=" + Condition.relevanceToString(relevance));
            }
            if (callback == null) {
                return;
            }
            relevance &= 3;
            if (relevance != 0) {
                this.mListeners.put(callback.asBinder(), callback);
                requestConditionsLocked(relevance);
            } else {
                this.mListeners.remove(callback.asBinder());
                if (this.mListeners.isEmpty()) {
                    requestConditionsLocked(0);
                }
            }
        }
    }

    private Condition[] validateConditions(String pkg, Condition[] conditions) {
        if (conditions == null || conditions.length == 0) {
            return null;
        }
        int i;
        int N = conditions.length;
        ArrayMap<Uri, Condition> valid = new ArrayMap(N);
        for (i = 0; i < N; i++) {
            Uri id = conditions[i].id;
            if (!Condition.isValidId(id, pkg)) {
                Slog.w(this.TAG, "Ignoring condition from " + pkg + " for invalid id: " + id);
            } else if (valid.containsKey(id)) {
                Slog.w(this.TAG, "Ignoring condition from " + pkg + " for duplicate id: " + id);
            } else {
                valid.put(id, conditions[i]);
            }
        }
        if (valid.size() == 0) {
            return null;
        }
        if (valid.size() == N) {
            return conditions;
        }
        Condition[] rt = new Condition[valid.size()];
        for (i = 0; i < rt.length; i++) {
            rt[i] = (Condition) valid.valueAt(i);
        }
        return rt;
    }

    private ConditionRecord getRecordLocked(Uri id, ComponentName component) {
        ConditionRecord r;
        int N = this.mRecords.size();
        for (int i = 0; i < N; i++) {
            r = (ConditionRecord) this.mRecords.get(i);
            if (r.id.equals(id) && r.component.equals(component)) {
                return r;
            }
        }
        r = new ConditionRecord(component, null);
        this.mRecords.add(r);
        return r;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyConditions(java.lang.String r18, com.android.server.notification.ManagedServices.ManagedServiceInfo r19, android.service.notification.Condition[] r20) {
        /*
        r17 = this;
        r0 = r17;
        r14 = r0.mMutex;
        monitor-enter(r14);
        r0 = r17;
        r13 = r0.DEBUG;	 Catch:{ all -> 0x009d }
        if (r13 == 0) goto L_0x0048;
    L_0x000b:
        r0 = r17;
        r15 = r0.TAG;	 Catch:{ all -> 0x009d }
        r13 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009d }
        r13.<init>();	 Catch:{ all -> 0x009d }
        r16 = "notifyConditions pkg=";
        r0 = r16;
        r13 = r13.append(r0);	 Catch:{ all -> 0x009d }
        r0 = r18;
        r13 = r13.append(r0);	 Catch:{ all -> 0x009d }
        r16 = " info=";
        r0 = r16;
        r13 = r13.append(r0);	 Catch:{ all -> 0x009d }
        r0 = r19;
        r13 = r13.append(r0);	 Catch:{ all -> 0x009d }
        r16 = " conditions=";
        r0 = r16;
        r16 = r13.append(r0);	 Catch:{ all -> 0x009d }
        if (r20 != 0) goto L_0x005b;
    L_0x003a:
        r13 = 0;
    L_0x003b:
        r0 = r16;
        r13 = r0.append(r13);	 Catch:{ all -> 0x009d }
        r13 = r13.toString();	 Catch:{ all -> 0x009d }
        android.util.Slog.d(r15, r13);	 Catch:{ all -> 0x009d }
    L_0x0048:
        r0 = r17;
        r1 = r18;
        r2 = r20;
        r20 = r0.validateConditions(r1, r2);	 Catch:{ all -> 0x009d }
        if (r20 == 0) goto L_0x0059;
    L_0x0054:
        r0 = r20;
        r13 = r0.length;	 Catch:{ all -> 0x009d }
        if (r13 != 0) goto L_0x0060;
    L_0x0059:
        monitor-exit(r14);	 Catch:{ all -> 0x009d }
    L_0x005a:
        return;
    L_0x005b:
        r13 = java.util.Arrays.asList(r20);	 Catch:{ all -> 0x009d }
        goto L_0x003b;
    L_0x0060:
        r0 = r20;
        r3 = r0.length;	 Catch:{ all -> 0x009d }
        r0 = r17;
        r13 = r0.mListeners;	 Catch:{ all -> 0x009d }
        r13 = r13.values();	 Catch:{ all -> 0x009d }
        r9 = r13.iterator();	 Catch:{ all -> 0x009d }
    L_0x006f:
        r13 = r9.hasNext();	 Catch:{ all -> 0x009d }
        if (r13 == 0) goto L_0x00a0;
    L_0x0075:
        r10 = r9.next();	 Catch:{ all -> 0x009d }
        r10 = (android.service.notification.IConditionListener) r10;	 Catch:{ all -> 0x009d }
        r0 = r20;
        r10.onConditionsReceived(r0);	 Catch:{ RemoteException -> 0x0081 }
        goto L_0x006f;
    L_0x0081:
        r6 = move-exception;
        r0 = r17;
        r13 = r0.TAG;	 Catch:{ all -> 0x009d }
        r15 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009d }
        r15.<init>();	 Catch:{ all -> 0x009d }
        r16 = "Error sending conditions to listener ";
        r15 = r15.append(r16);	 Catch:{ all -> 0x009d }
        r15 = r15.append(r10);	 Catch:{ all -> 0x009d }
        r15 = r15.toString();	 Catch:{ all -> 0x009d }
        android.util.Slog.w(r13, r15, r6);	 Catch:{ all -> 0x009d }
        goto L_0x006f;
    L_0x009d:
        r13 = move-exception;
        monitor-exit(r14);	 Catch:{ all -> 0x009d }
        throw r13;
    L_0x00a0:
        r8 = 0;
    L_0x00a1:
        if (r8 >= r3) goto L_0x01f9;
    L_0x00a3:
        r4 = r20[r8];	 Catch:{ all -> 0x009d }
        r13 = r4.id;	 Catch:{ all -> 0x009d }
        r0 = r19;
        r15 = r0.component;	 Catch:{ all -> 0x009d }
        r0 = r17;
        r12 = r0.getRecordLocked(r13, r15);	 Catch:{ all -> 0x009d }
        r11 = r12.condition;	 Catch:{ all -> 0x009d }
        if (r11 == 0) goto L_0x0147;
    L_0x00b5:
        r13 = r11.equals(r4);	 Catch:{ all -> 0x009d }
        if (r13 != 0) goto L_0x0147;
    L_0x00bb:
        r5 = 1;
    L_0x00bc:
        r0 = r19;
        r12.info = r0;	 Catch:{ all -> 0x009d }
        r12.condition = r4;	 Catch:{ all -> 0x009d }
        r13 = r12.isManual;	 Catch:{ all -> 0x009d }
        if (r13 == 0) goto L_0x0108;
    L_0x00c6:
        r13 = r4.state;	 Catch:{ all -> 0x009d }
        if (r13 == 0) goto L_0x00cf;
    L_0x00ca:
        r13 = r4.state;	 Catch:{ all -> 0x009d }
        r15 = 3;
        if (r13 != r15) goto L_0x016d;
    L_0x00cf:
        r13 = r4.state;	 Catch:{ all -> 0x009d }
        r15 = 3;
        if (r13 != r15) goto L_0x014a;
    L_0x00d4:
        r7 = 1;
    L_0x00d5:
        if (r7 == 0) goto L_0x014c;
    L_0x00d7:
        r0 = r17;
        r13 = r0.TAG;	 Catch:{ all -> 0x009d }
        r15 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009d }
        r15.<init>();	 Catch:{ all -> 0x009d }
        r16 = "Exit zen: manual condition failed: ";
        r15 = r15.append(r16);	 Catch:{ all -> 0x009d }
        r15 = r15.append(r4);	 Catch:{ all -> 0x009d }
        r15 = r15.toString();	 Catch:{ all -> 0x009d }
        android.util.Slog.w(r13, r15);	 Catch:{ all -> 0x009d }
    L_0x00f1:
        r17.onManualConditionClearing();	 Catch:{ all -> 0x009d }
        r0 = r17;
        r13 = r0.mZenModeHelper;	 Catch:{ all -> 0x009d }
        r15 = 0;
        r16 = "manualConditionExit";
        r0 = r16;
        r13.setZenMode(r15, r0);	 Catch:{ all -> 0x009d }
        r0 = r17;
        r0.unsubscribeLocked(r12);	 Catch:{ all -> 0x009d }
        r13 = 0;
        r12.isManual = r13;	 Catch:{ all -> 0x009d }
    L_0x0108:
        r13 = r12.isAutomatic;	 Catch:{ all -> 0x009d }
        if (r13 == 0) goto L_0x0143;
    L_0x010c:
        r13 = r4.state;	 Catch:{ all -> 0x009d }
        if (r13 == 0) goto L_0x0115;
    L_0x0110:
        r13 = r4.state;	 Catch:{ all -> 0x009d }
        r15 = 3;
        if (r13 != r15) goto L_0x01cc;
    L_0x0115:
        r13 = r4.state;	 Catch:{ all -> 0x009d }
        r15 = 3;
        if (r13 != r15) goto L_0x01a7;
    L_0x011a:
        r7 = 1;
    L_0x011b:
        if (r7 == 0) goto L_0x01aa;
    L_0x011d:
        r0 = r17;
        r13 = r0.TAG;	 Catch:{ all -> 0x009d }
        r15 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009d }
        r15.<init>();	 Catch:{ all -> 0x009d }
        r16 = "Exit zen: automatic condition failed: ";
        r15 = r15.append(r16);	 Catch:{ all -> 0x009d }
        r15 = r15.append(r4);	 Catch:{ all -> 0x009d }
        r15 = r15.toString();	 Catch:{ all -> 0x009d }
        android.util.Slog.w(r13, r15);	 Catch:{ all -> 0x009d }
    L_0x0137:
        r0 = r17;
        r13 = r0.mZenModeHelper;	 Catch:{ all -> 0x009d }
        r15 = 0;
        r16 = "automaticConditionExit";
        r0 = r16;
        r13.setZenMode(r15, r0);	 Catch:{ all -> 0x009d }
    L_0x0143:
        r8 = r8 + 1;
        goto L_0x00a1;
    L_0x0147:
        r5 = 0;
        goto L_0x00bc;
    L_0x014a:
        r7 = 0;
        goto L_0x00d5;
    L_0x014c:
        r0 = r17;
        r13 = r0.DEBUG;	 Catch:{ all -> 0x009d }
        if (r13 == 0) goto L_0x00f1;
    L_0x0152:
        r0 = r17;
        r13 = r0.TAG;	 Catch:{ all -> 0x009d }
        r15 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009d }
        r15.<init>();	 Catch:{ all -> 0x009d }
        r16 = "Exit zen: manual condition false: ";
        r15 = r15.append(r16);	 Catch:{ all -> 0x009d }
        r15 = r15.append(r4);	 Catch:{ all -> 0x009d }
        r15 = r15.toString();	 Catch:{ all -> 0x009d }
        android.util.Slog.d(r13, r15);	 Catch:{ all -> 0x009d }
        goto L_0x00f1;
    L_0x016d:
        r13 = r4.state;	 Catch:{ all -> 0x009d }
        r15 = 1;
        if (r13 != r15) goto L_0x0108;
    L_0x0172:
        if (r5 == 0) goto L_0x0108;
    L_0x0174:
        r0 = r17;
        r13 = r0.DEBUG;	 Catch:{ all -> 0x009d }
        if (r13 == 0) goto L_0x019e;
    L_0x017a:
        r0 = r17;
        r13 = r0.TAG;	 Catch:{ all -> 0x009d }
        r15 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009d }
        r15.<init>();	 Catch:{ all -> 0x009d }
        r16 = "Current condition updated, still true. old=";
        r15 = r15.append(r16);	 Catch:{ all -> 0x009d }
        r15 = r15.append(r11);	 Catch:{ all -> 0x009d }
        r16 = " new=";
        r15 = r15.append(r16);	 Catch:{ all -> 0x009d }
        r15 = r15.append(r4);	 Catch:{ all -> 0x009d }
        r15 = r15.toString();	 Catch:{ all -> 0x009d }
        android.util.Slog.d(r13, r15);	 Catch:{ all -> 0x009d }
    L_0x019e:
        r13 = "conditionUpdate";
        r0 = r17;
        r0.setZenModeCondition(r4, r13);	 Catch:{ all -> 0x009d }
        goto L_0x0108;
    L_0x01a7:
        r7 = 0;
        goto L_0x011b;
    L_0x01aa:
        r0 = r17;
        r13 = r0.DEBUG;	 Catch:{ all -> 0x009d }
        if (r13 == 0) goto L_0x0137;
    L_0x01b0:
        r0 = r17;
        r13 = r0.TAG;	 Catch:{ all -> 0x009d }
        r15 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009d }
        r15.<init>();	 Catch:{ all -> 0x009d }
        r16 = "Exit zen: automatic condition false: ";
        r15 = r15.append(r16);	 Catch:{ all -> 0x009d }
        r15 = r15.append(r4);	 Catch:{ all -> 0x009d }
        r15 = r15.toString();	 Catch:{ all -> 0x009d }
        android.util.Slog.d(r13, r15);	 Catch:{ all -> 0x009d }
        goto L_0x0137;
    L_0x01cc:
        r13 = r4.state;	 Catch:{ all -> 0x009d }
        r15 = 1;
        if (r13 != r15) goto L_0x0143;
    L_0x01d1:
        r0 = r17;
        r13 = r0.TAG;	 Catch:{ all -> 0x009d }
        r15 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009d }
        r15.<init>();	 Catch:{ all -> 0x009d }
        r16 = "Enter zen: automatic condition true: ";
        r15 = r15.append(r16);	 Catch:{ all -> 0x009d }
        r15 = r15.append(r4);	 Catch:{ all -> 0x009d }
        r15 = r15.toString();	 Catch:{ all -> 0x009d }
        android.util.Slog.d(r13, r15);	 Catch:{ all -> 0x009d }
        r0 = r17;
        r13 = r0.mZenModeHelper;	 Catch:{ all -> 0x009d }
        r15 = 1;
        r16 = "automaticConditionEnter";
        r0 = r16;
        r13.setZenMode(r15, r0);	 Catch:{ all -> 0x009d }
        goto L_0x0143;
    L_0x01f9:
        monitor-exit(r14);	 Catch:{ all -> 0x009d }
        goto L_0x005a;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.notification.ConditionProviders.notifyConditions(java.lang.String, com.android.server.notification.ManagedServices$ManagedServiceInfo, android.service.notification.Condition[]):void");
    }

    private void ensureRecordExists(Condition condition, IConditionProvider provider, ComponentName component) {
        ConditionRecord r = getRecordLocked(condition.id, component);
        if (r.info == null) {
            r.info = checkServiceTokenLocked(provider);
        }
    }

    public void setZenModeCondition(Condition condition, String reason) {
        if (this.DEBUG) {
            Slog.d(this.TAG, "setZenModeCondition " + condition + " reason=" + reason);
        }
        synchronized (this.mMutex) {
            ComponentName conditionComponent = null;
            if (condition != null) {
                if (this.mCountdown != null && ZenModeConfig.isValidCountdownConditionId(condition.id)) {
                    ensureRecordExists(condition, this.mCountdown.asInterface(), CountdownConditionProvider.COMPONENT);
                }
                if (this.mDowntime != null && ZenModeConfig.isValidDowntimeConditionId(condition.id)) {
                    ensureRecordExists(condition, this.mDowntime.asInterface(), DowntimeConditionProvider.COMPONENT);
                }
            }
            int N = this.mRecords.size();
            for (int i = 0; i < N; i++) {
                boolean idEqual;
                ConditionRecord r = (ConditionRecord) this.mRecords.get(i);
                if (condition == null || !r.id.equals(condition.id)) {
                    idEqual = false;
                } else {
                    idEqual = true;
                }
                if (r.isManual && !idEqual) {
                    unsubscribeLocked(r);
                    r.isManual = false;
                } else if (idEqual && !r.isManual) {
                    subscribeLocked(r);
                    r.isManual = true;
                }
                if (idEqual) {
                    conditionComponent = r.component;
                }
            }
            if (!Objects.equals(this.mExitCondition, condition)) {
                this.mExitCondition = condition;
                this.mExitConditionComponent = conditionComponent;
                ZenLog.traceExitCondition(this.mExitCondition, this.mExitConditionComponent, reason);
                saveZenConfigLocked();
            }
        }
    }

    private void subscribeLocked(ConditionRecord r) {
        if (this.DEBUG) {
            Slog.d(this.TAG, "subscribeLocked " + r);
        }
        IConditionProvider provider = provider(r);
        RemoteException re = null;
        if (provider != null) {
            try {
                Slog.d(this.TAG, "Subscribing to " + r.id + " with " + provider);
                provider.onSubscribe(r.id);
            } catch (RemoteException e) {
                Slog.w(this.TAG, "Error subscribing to " + r, e);
                re = e;
            }
        }
        ZenLog.traceSubscribe(r != null ? r.id : null, provider, re);
    }

    @SafeVarargs
    private static <T> ArraySet<T> safeSet(T... items) {
        ArraySet<T> rt = new ArraySet();
        if (!(items == null || items.length == 0)) {
            for (T item : items) {
                if (item != null) {
                    rt.add(item);
                }
            }
        }
        return rt;
    }

    public void setAutomaticZenModeConditions(Uri[] conditionIds) {
        setAutomaticZenModeConditions(conditionIds, true);
    }

    private void setAutomaticZenModeConditions(Uri[] conditionIds, boolean save) {
        if (this.DEBUG) {
            Slog.d(this.TAG, "setAutomaticZenModeConditions " + (conditionIds == null ? null : Arrays.asList(conditionIds)));
        }
        synchronized (this.mMutex) {
            ArraySet<Uri> newIds = safeSet(conditionIds);
            int N = this.mRecords.size();
            boolean changed = false;
            for (int i = 0; i < N; i++) {
                ConditionRecord r = (ConditionRecord) this.mRecords.get(i);
                boolean automatic = newIds.contains(r.id);
                if (!r.isAutomatic && automatic) {
                    subscribeLocked(r);
                    r.isAutomatic = true;
                    changed = true;
                } else if (r.isAutomatic && !automatic) {
                    unsubscribeLocked(r);
                    r.isAutomatic = false;
                    changed = true;
                }
            }
            if (save && changed) {
                saveZenConfigLocked();
            }
        }
    }

    public Condition[] getAutomaticZenModeConditions() {
        Condition[] conditionArr;
        synchronized (this.mMutex) {
            int N = this.mRecords.size();
            ArrayList<Condition> rt = null;
            for (int i = 0; i < N; i++) {
                ConditionRecord r = (ConditionRecord) this.mRecords.get(i);
                if (r.isAutomatic && r.condition != null) {
                    if (rt == null) {
                        rt = new ArrayList();
                    }
                    rt.add(r.condition);
                }
            }
            conditionArr = rt == null ? NO_CONDITIONS : (Condition[]) rt.toArray(new Condition[rt.size()]);
        }
        return conditionArr;
    }

    private void unsubscribeLocked(ConditionRecord r) {
        if (this.DEBUG) {
            Slog.d(this.TAG, "unsubscribeLocked " + r);
        }
        IConditionProvider provider = provider(r);
        RemoteException re = null;
        if (provider != null) {
            try {
                provider.onUnsubscribe(r.id);
            } catch (RemoteException e) {
                Slog.w(this.TAG, "Error unsubscribing to " + r, e);
                re = e;
            }
        }
        ZenLog.traceUnsubscribe(r != null ? r.id : null, provider, re);
    }

    private static IConditionProvider provider(ConditionRecord r) {
        return r == null ? null : provider(r.info);
    }

    private static IConditionProvider provider(ManagedServiceInfo info) {
        return info == null ? null : (IConditionProvider) info.service;
    }

    private void requestConditionsLocked(int flags) {
        Iterator i$ = this.mServices.iterator();
        while (i$.hasNext()) {
            ManagedServiceInfo info = (ManagedServiceInfo) i$.next();
            IConditionProvider provider = provider(info);
            if (provider != null) {
                for (int i = this.mRecords.size() - 1; i >= 0; i--) {
                    ConditionRecord r = (ConditionRecord) this.mRecords.get(i);
                    if (!(r.info != info || r.isManual || r.isAutomatic)) {
                        this.mRecords.remove(i);
                    }
                }
                try {
                    provider.onRequestConditions(flags);
                } catch (RemoteException e) {
                    Slog.w(this.TAG, "Error requesting conditions from " + info.component, e);
                }
            }
        }
    }

    private void loadZenConfig() {
        boolean changingExit = false;
        ZenModeConfig config = this.mZenModeHelper.getConfig();
        if (config != null) {
            synchronized (this.mMutex) {
                if (!Objects.equals(this.mExitCondition, config.exitCondition)) {
                    changingExit = true;
                }
                this.mExitCondition = config.exitCondition;
                this.mExitConditionComponent = config.exitConditionComponent;
                if (changingExit) {
                    ZenLog.traceExitCondition(this.mExitCondition, this.mExitConditionComponent, "config");
                }
                if (this.mDowntime != null) {
                    this.mDowntime.setConfig(config);
                }
                if (config.conditionComponents == null || config.conditionIds == null || config.conditionComponents.length != config.conditionIds.length) {
                    if (this.DEBUG) {
                        Slog.d(this.TAG, "loadZenConfig: no conditions");
                    }
                    setAutomaticZenModeConditions(null, false);
                    return;
                }
                ArraySet<Uri> newIds = new ArraySet();
                int N = config.conditionComponents.length;
                for (int i = 0; i < N; i++) {
                    ComponentName component = config.conditionComponents[i];
                    Uri id = config.conditionIds[i];
                    if (!(component == null || id == null)) {
                        getRecordLocked(id, component);
                        newIds.add(id);
                    }
                }
                if (this.DEBUG) {
                    Slog.d(this.TAG, "loadZenConfig: N=" + N);
                }
                setAutomaticZenModeConditions((Uri[]) newIds.toArray(new Uri[newIds.size()]), false);
            }
        } else if (this.DEBUG) {
            Slog.d(this.TAG, "loadZenConfig: no config");
        }
    }

    private void saveZenConfigLocked() {
        ZenModeConfig config = this.mZenModeHelper.getConfig();
        if (config != null) {
            int i;
            ConditionRecord r;
            config = config.copy();
            ArrayList<ConditionRecord> automatic = new ArrayList();
            int automaticN = this.mRecords.size();
            for (i = 0; i < automaticN; i++) {
                r = (ConditionRecord) this.mRecords.get(i);
                if (r.isAutomatic) {
                    automatic.add(r);
                }
            }
            if (automatic.isEmpty()) {
                config.conditionComponents = null;
                config.conditionIds = null;
            } else {
                int N = automatic.size();
                config.conditionComponents = new ComponentName[N];
                config.conditionIds = new Uri[N];
                for (i = 0; i < N; i++) {
                    r = (ConditionRecord) automatic.get(i);
                    config.conditionComponents[i] = r.component;
                    config.conditionIds[i] = r.id;
                }
            }
            config.exitCondition = this.mExitCondition;
            config.exitConditionComponent = this.mExitConditionComponent;
            if (this.DEBUG) {
                Slog.d(this.TAG, "Setting zen config to: " + config);
            }
            this.mZenModeHelper.setConfig(config);
        }
    }

    private void onManualConditionClearing() {
        if (this.mDowntime != null) {
            this.mDowntime.onManualConditionClearing();
        }
    }
}
