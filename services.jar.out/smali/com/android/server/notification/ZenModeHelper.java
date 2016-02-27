package com.android.server.notification;

import android.app.AppOpsManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.XmlResourceParser;
import android.database.ContentObserver;
import android.media.AudioManagerInternal;
import android.media.AudioManagerInternal.RingerModeDelegate;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.UserHandle;
import android.provider.Settings.Global;
import android.provider.Settings.Secure;
import android.service.notification.ZenModeConfig;
import android.telecom.TelecomManager;
import android.util.Log;
import android.util.Slog;
import com.android.server.LocalServices;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Objects;
import libcore.io.IoUtils;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class ZenModeHelper implements RingerModeDelegate {
    private static final boolean DEBUG;
    private static final String TAG = "ZenModeHelper";
    private final AppOpsManager mAppOps;
    private AudioManagerInternal mAudioManager;
    private final ArrayList<Callback> mCallbacks;
    private ZenModeConfig mConfig;
    private final Context mContext;
    private final ZenModeConfig mDefaultConfig;
    private ComponentName mDefaultPhoneApp;
    private boolean mEffectsSuppressed;
    private final C0439H mHandler;
    private int mPreviousRingerMode;
    private final SettingsObserver mSettingsObserver;
    private int mZenMode;

    public static class Callback {
        void onConfigChanged() {
        }

        void onZenModeChanged() {
        }
    }

    /* renamed from: com.android.server.notification.ZenModeHelper.H */
    private class C0439H extends Handler {
        private static final int MSG_DISPATCH = 1;

        private C0439H(Looper looper) {
            super(looper);
        }

        private void postDispatchOnZenModeChanged() {
            removeMessages(MSG_DISPATCH);
            sendEmptyMessage(MSG_DISPATCH);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case MSG_DISPATCH /*1*/:
                    ZenModeHelper.this.dispatchOnZenModeChanged();
                default:
            }
        }
    }

    private class SettingsObserver extends ContentObserver {
        private final Uri ZEN_MODE;

        public SettingsObserver(Handler handler) {
            super(handler);
            this.ZEN_MODE = Global.getUriFor("zen_mode");
        }

        public void observe() {
            ZenModeHelper.this.mContext.getContentResolver().registerContentObserver(this.ZEN_MODE, ZenModeHelper.DEBUG, this);
            update(null);
        }

        public void onChange(boolean selfChange, Uri uri) {
            update(uri);
        }

        public void update(Uri uri) {
            if (this.ZEN_MODE.equals(uri)) {
                ZenModeHelper.this.readZenModeFromSetting();
            }
        }
    }

    static {
        DEBUG = Log.isLoggable(TAG, 3);
    }

    public ZenModeHelper(Context context, Looper looper) {
        this.mCallbacks = new ArrayList();
        this.mPreviousRingerMode = -1;
        this.mContext = context;
        this.mHandler = new C0439H(looper, null);
        this.mAppOps = (AppOpsManager) context.getSystemService("appops");
        this.mDefaultConfig = readDefaultConfig(context.getResources());
        this.mConfig = this.mDefaultConfig;
        this.mSettingsObserver = new SettingsObserver(this.mHandler);
        this.mSettingsObserver.observe();
    }

    public static ZenModeConfig readDefaultConfig(Resources resources) {
        XmlResourceParser parser = null;
        try {
            parser = resources.getXml(17891331);
            while (parser.next() != 1) {
                ZenModeConfig config = ZenModeConfig.readXml(parser);
                if (config != null) {
                    return config;
                }
            }
            IoUtils.closeQuietly(parser);
        } catch (Exception e) {
            Slog.w(TAG, "Error reading default zen mode config from resource", e);
        } finally {
            IoUtils.closeQuietly(parser);
        }
        return new ZenModeConfig();
    }

    public void addCallback(Callback callback) {
        this.mCallbacks.add(callback);
    }

    public void removeCallback(Callback callback) {
        this.mCallbacks.remove(callback);
    }

    public void onSystemReady() {
        this.mAudioManager = (AudioManagerInternal) LocalServices.getService(AudioManagerInternal.class);
        if (this.mAudioManager != null) {
            this.mAudioManager.setRingerModeDelegate(this);
        }
    }

    public int getZenModeListenerInterruptionFilter() {
        switch (this.mZenMode) {
            case AppTransition.TRANSIT_NONE /*0*/:
                return 1;
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                return 2;
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                return 3;
            default:
                return 0;
        }
    }

    private static int zenModeFromListenerInterruptionFilter(int listenerInterruptionFilter, int defValue) {
        switch (listenerInterruptionFilter) {
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                return 0;
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                return 1;
            case C0569H.REPORT_LOSING_FOCUS /*3*/:
                return 2;
            default:
                return defValue;
        }
    }

    public void requestFromListener(ComponentName name, int interruptionFilter) {
        int newZen = zenModeFromListenerInterruptionFilter(interruptionFilter, -1);
        if (newZen != -1) {
            setZenMode(newZen, "listener:" + (name != null ? name.flattenToShortString() : null));
        }
    }

    public void setEffectsSuppressed(boolean effectsSuppressed) {
        if (this.mEffectsSuppressed != effectsSuppressed) {
            this.mEffectsSuppressed = effectsSuppressed;
            applyRestrictions();
        }
    }

    public boolean shouldIntercept(NotificationRecord record) {
        if (isSystem(record)) {
            return DEBUG;
        }
        switch (this.mZenMode) {
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                if (isAlarm(record)) {
                    return DEBUG;
                }
                if (record.getPackagePriority() == 2) {
                    ZenLog.traceNotIntercepted(record, "priorityApp");
                    return DEBUG;
                } else if (isCall(record)) {
                    if (this.mConfig.allowCalls) {
                        return shouldInterceptAudience(record);
                    }
                    ZenLog.traceIntercepted(record, "!allowCalls");
                    return true;
                } else if (isMessage(record)) {
                    if (this.mConfig.allowMessages) {
                        return shouldInterceptAudience(record);
                    }
                    ZenLog.traceIntercepted(record, "!allowMessages");
                    return true;
                } else if (!isEvent(record)) {
                    ZenLog.traceIntercepted(record, "!priority");
                    return true;
                } else if (this.mConfig.allowEvents) {
                    return DEBUG;
                } else {
                    ZenLog.traceIntercepted(record, "!allowEvents");
                    return true;
                }
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                ZenLog.traceIntercepted(record, "none");
                return true;
            default:
                return DEBUG;
        }
    }

    private boolean shouldInterceptAudience(NotificationRecord record) {
        if (audienceMatches(record.getContactAffinity())) {
            return DEBUG;
        }
        ZenLog.traceIntercepted(record, "!audienceMatches");
        return true;
    }

    public int getZenMode() {
        return this.mZenMode;
    }

    public void setZenMode(int zenMode, String reason) {
        setZenMode(zenMode, reason, true);
    }

    private void setZenMode(int zenMode, String reason, boolean setRingerMode) {
        ZenLog.traceSetZenMode(zenMode, reason);
        if (this.mZenMode != zenMode) {
            ZenLog.traceUpdateZenMode(this.mZenMode, zenMode);
            this.mZenMode = zenMode;
            Global.putInt(this.mContext.getContentResolver(), "zen_mode", this.mZenMode);
            if (setRingerMode) {
                applyZenToRingerMode();
            }
            applyRestrictions();
            this.mHandler.postDispatchOnZenModeChanged();
        }
    }

    public void readZenModeFromSetting() {
        setZenMode(Global.getInt(this.mContext.getContentResolver(), "zen_mode", 0), "setting");
    }

    private void applyRestrictions() {
        boolean zen;
        boolean muteCalls;
        boolean muteAlarms;
        if (this.mZenMode != 0) {
            zen = true;
        } else {
            zen = DEBUG;
        }
        applyRestrictions(this.mEffectsSuppressed, 5);
        if ((!zen || this.mConfig.allowCalls) && !this.mEffectsSuppressed) {
            muteCalls = DEBUG;
        } else {
            muteCalls = true;
        }
        applyRestrictions(muteCalls, 6);
        if (this.mZenMode == 2) {
            muteAlarms = true;
        } else {
            muteAlarms = DEBUG;
        }
        applyRestrictions(muteAlarms, 4);
    }

    private void applyRestrictions(boolean mute, int usage) {
        int i = 1;
        this.mAppOps.setRestriction(3, usage, mute ? 1 : 0, null);
        AppOpsManager appOpsManager = this.mAppOps;
        if (!mute) {
            i = 0;
        }
        appOpsManager.setRestriction(28, usage, i, null);
    }

    public void dump(PrintWriter pw, String prefix) {
        pw.print(prefix);
        pw.print("mZenMode=");
        pw.println(Global.zenModeToString(this.mZenMode));
        pw.print(prefix);
        pw.print("mConfig=");
        pw.println(this.mConfig);
        pw.print(prefix);
        pw.print("mDefaultConfig=");
        pw.println(this.mDefaultConfig);
        pw.print(prefix);
        pw.print("mPreviousRingerMode=");
        pw.println(this.mPreviousRingerMode);
        pw.print(prefix);
        pw.print("mDefaultPhoneApp=");
        pw.println(this.mDefaultPhoneApp);
        pw.print(prefix);
        pw.print("mEffectsSuppressed=");
        pw.println(this.mEffectsSuppressed);
    }

    public void readXml(XmlPullParser parser) throws XmlPullParserException, IOException {
        ZenModeConfig config = ZenModeConfig.readXml(parser);
        if (config != null) {
            setConfig(config);
        }
    }

    public void writeXml(XmlSerializer out) throws IOException {
        this.mConfig.writeXml(out);
    }

    public ZenModeConfig getConfig() {
        return this.mConfig;
    }

    public boolean setConfig(ZenModeConfig config) {
        if (config == null || !config.isValid()) {
            return DEBUG;
        }
        if (config.equals(this.mConfig)) {
            return true;
        }
        ZenLog.traceConfig(this.mConfig, config);
        this.mConfig = config;
        dispatchOnConfigChanged();
        Global.putString(this.mContext.getContentResolver(), "zen_mode_config_etag", Integer.toString(this.mConfig.hashCode()));
        applyRestrictions();
        return true;
    }

    private void applyZenToRingerMode() {
        if (this.mAudioManager != null) {
            int ringerModeInternal = this.mAudioManager.getRingerModeInternal();
            int newRingerModeInternal = ringerModeInternal;
            switch (this.mZenMode) {
                case AppTransition.TRANSIT_NONE /*0*/:
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                    if (ringerModeInternal == 0) {
                        newRingerModeInternal = this.mPreviousRingerMode != -1 ? this.mPreviousRingerMode : 2;
                        this.mPreviousRingerMode = -1;
                        break;
                    }
                    break;
                case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                    if (ringerModeInternal != 0) {
                        this.mPreviousRingerMode = ringerModeInternal;
                        newRingerModeInternal = 0;
                        break;
                    }
                    break;
            }
            if (newRingerModeInternal != -1) {
                this.mAudioManager.setRingerModeInternal(newRingerModeInternal, TAG);
            }
        }
    }

    public int onSetRingerModeInternal(int ringerModeOld, int ringerModeNew, String caller, int ringerModeExternal) {
        boolean isChange;
        if (ringerModeOld != ringerModeNew) {
            isChange = true;
        } else {
            isChange = DEBUG;
        }
        int ringerModeExternalOut = ringerModeNew;
        int newZen = -1;
        switch (ringerModeNew) {
            case AppTransition.TRANSIT_NONE /*0*/:
                if (isChange && this.mZenMode != 2) {
                    newZen = 2;
                    break;
                }
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                if (!isChange || ringerModeOld != 0 || this.mZenMode != 2) {
                    if (this.mZenMode != 0) {
                        ringerModeExternalOut = 0;
                        break;
                    }
                }
                newZen = 0;
                break;
                break;
        }
        if (newZen != -1) {
            setZenMode(newZen, "ringerModeInternal", DEBUG);
        }
        if (!(!isChange && newZen == -1 && ringerModeExternal == ringerModeExternalOut)) {
            ZenLog.traceSetRingerModeInternal(ringerModeOld, ringerModeNew, caller, ringerModeExternal, ringerModeExternalOut);
        }
        return ringerModeExternalOut;
    }

    public int onSetRingerModeExternal(int ringerModeOld, int ringerModeNew, String caller, int ringerModeInternal) {
        boolean isChange;
        boolean isVibrate;
        int ringerModeInternalOut = ringerModeNew;
        if (ringerModeOld != ringerModeNew) {
            isChange = true;
        } else {
            isChange = DEBUG;
        }
        if (ringerModeInternal == 1) {
            isVibrate = true;
        } else {
            isVibrate = DEBUG;
        }
        int newZen = -1;
        switch (ringerModeNew) {
            case AppTransition.TRANSIT_NONE /*0*/:
                if (!isChange) {
                    ringerModeInternalOut = ringerModeInternal;
                    break;
                }
                if (this.mZenMode == 0) {
                    newZen = 1;
                }
                ringerModeInternalOut = !isVibrate ? 1 : 0;
                break;
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                if (this.mZenMode != 0) {
                    newZen = 0;
                    break;
                }
                break;
        }
        if (newZen != -1) {
            setZenMode(newZen, "ringerModeExternal", DEBUG);
        }
        ZenLog.traceSetRingerModeExternal(ringerModeOld, ringerModeNew, caller, ringerModeInternal, ringerModeInternalOut);
        return ringerModeInternalOut;
    }

    private void dispatchOnConfigChanged() {
        Iterator i$ = this.mCallbacks.iterator();
        while (i$.hasNext()) {
            ((Callback) i$.next()).onConfigChanged();
        }
    }

    private void dispatchOnZenModeChanged() {
        Iterator i$ = this.mCallbacks.iterator();
        while (i$.hasNext()) {
            ((Callback) i$.next()).onZenModeChanged();
        }
    }

    private static boolean isSystem(NotificationRecord record) {
        return record.isCategory("sys");
    }

    private static boolean isAlarm(NotificationRecord record) {
        return (record.isCategory("alarm") || record.isAudioStream(4) || record.isAudioAttributesUsage(4)) ? true : DEBUG;
    }

    private static boolean isEvent(NotificationRecord record) {
        return record.isCategory("event");
    }

    public boolean isCall(NotificationRecord record) {
        return (record == null || !(isDefaultPhoneApp(record.sbn.getPackageName()) || record.isCategory("call"))) ? DEBUG : true;
    }

    private boolean isDefaultPhoneApp(String pkg) {
        if (this.mDefaultPhoneApp == null) {
            TelecomManager telecomm = (TelecomManager) this.mContext.getSystemService("telecom");
            this.mDefaultPhoneApp = telecomm != null ? telecomm.getDefaultPhoneApp() : null;
            if (DEBUG) {
                Slog.d(TAG, "Default phone app: " + this.mDefaultPhoneApp);
            }
        }
        return (pkg == null || this.mDefaultPhoneApp == null || !pkg.equals(this.mDefaultPhoneApp.getPackageName())) ? DEBUG : true;
    }

    private boolean isDefaultMessagingApp(NotificationRecord record) {
        int userId = record.getUserId();
        if (userId == -10000 || userId == -1) {
            return DEBUG;
        }
        return Objects.equals(Secure.getStringForUser(this.mContext.getContentResolver(), "sms_default_application", userId), record.sbn.getPackageName());
    }

    private boolean isMessage(NotificationRecord record) {
        return (record.isCategory("msg") || isDefaultMessagingApp(record)) ? true : DEBUG;
    }

    public boolean matchesCallFilter(UserHandle userHandle, Bundle extras, ValidateNotificationPeople validator, int contactsTimeoutMs, float timeoutAffinity) {
        int zen = this.mZenMode;
        if (zen == 2) {
            return DEBUG;
        }
        if (zen == 1) {
            if (!this.mConfig.allowCalls) {
                return DEBUG;
            }
            if (validator != null) {
                return audienceMatches(validator.getContactAffinity(userHandle, extras, contactsTimeoutMs, timeoutAffinity));
            }
        }
        return true;
    }

    public String toString() {
        return TAG;
    }

    private boolean audienceMatches(float contactAffinity) {
        switch (this.mConfig.allowFrom) {
            case AppTransition.TRANSIT_NONE /*0*/:
                return true;
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                if (contactAffinity < 0.5f) {
                    return DEBUG;
                }
                return true;
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                return contactAffinity < 1.0f ? DEBUG : true;
            default:
                Slog.w(TAG, "Encountered unknown source: " + this.mConfig.allowFrom);
                return true;
        }
    }
}
