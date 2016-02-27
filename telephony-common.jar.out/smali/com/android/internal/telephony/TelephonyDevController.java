package com.android.internal.telephony;

import android.content.res.Resources;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.telephony.Rlog;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class TelephonyDevController extends Handler {
    private static final boolean DBG = true;
    private static final int EVENT_HARDWARE_CONFIG_CHANGED = 1;
    private static final String LOG_TAG = "TDC";
    private static final Object mLock;
    private static ArrayList<HardwareConfig> mModems;
    private static ArrayList<HardwareConfig> mSims;
    private static Message sRilHardwareConfig;
    private static TelephonyDevController sTelephonyDevController;

    static {
        mLock = new Object();
        mModems = new ArrayList();
        mSims = new ArrayList();
    }

    private static void logd(String s) {
        Rlog.d(LOG_TAG, s);
    }

    private static void loge(String s) {
        Rlog.e(LOG_TAG, s);
    }

    public static TelephonyDevController create() {
        TelephonyDevController telephonyDevController;
        synchronized (mLock) {
            if (sTelephonyDevController != null) {
                throw new RuntimeException("TelephonyDevController already created!?!");
            }
            sTelephonyDevController = new TelephonyDevController();
            telephonyDevController = sTelephonyDevController;
        }
        return telephonyDevController;
    }

    public static TelephonyDevController getInstance() {
        TelephonyDevController telephonyDevController;
        synchronized (mLock) {
            if (sTelephonyDevController == null) {
                throw new RuntimeException("TelephonyDevController not yet created!?!");
            }
            telephonyDevController = sTelephonyDevController;
        }
        return telephonyDevController;
    }

    private void initFromResource() {
        String[] hwStrings = Resources.getSystem().getStringArray(17236024);
        if (hwStrings != null) {
            String[] arr$ = hwStrings;
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += EVENT_HARDWARE_CONFIG_CHANGED) {
                HardwareConfig hw = new HardwareConfig(arr$[i$]);
                if (hw != null) {
                    if (hw.type == 0) {
                        updateOrInsert(hw, mModems);
                    } else if (hw.type == EVENT_HARDWARE_CONFIG_CHANGED) {
                        updateOrInsert(hw, mSims);
                    }
                }
            }
        }
    }

    private TelephonyDevController() {
        initFromResource();
        mModems.trimToSize();
        mSims.trimToSize();
    }

    public static void registerRIL(CommandsInterface cmdsIf) {
        cmdsIf.getHardwareConfig(sRilHardwareConfig);
        if (sRilHardwareConfig != null) {
            AsyncResult ar = sRilHardwareConfig.obj;
            if (ar.exception == null) {
                handleGetHardwareConfigChanged(ar);
            }
        }
        cmdsIf.registerForHardwareConfigChanged(sTelephonyDevController, EVENT_HARDWARE_CONFIG_CHANGED, null);
    }

    public static void unregisterRIL(CommandsInterface cmdsIf) {
        cmdsIf.unregisterForHardwareConfigChanged(sTelephonyDevController);
    }

    public void handleMessage(Message msg) {
        switch (msg.what) {
            case EVENT_HARDWARE_CONFIG_CHANGED /*1*/:
                logd("handleMessage: received EVENT_HARDWARE_CONFIG_CHANGED");
                handleGetHardwareConfigChanged(msg.obj);
            default:
                loge("handleMessage: Unknown Event " + msg.what);
        }
    }

    private static void updateOrInsert(HardwareConfig hw, ArrayList<HardwareConfig> list) {
        synchronized (mLock) {
            int size = list.size();
            for (int i = 0; i < size; i += EVENT_HARDWARE_CONFIG_CHANGED) {
                HardwareConfig item = (HardwareConfig) list.get(i);
                if (item.uuid.compareTo(hw.uuid) == 0) {
                    logd("updateOrInsert: removing: " + item);
                    list.remove(i);
                }
            }
            logd("updateOrInsert: inserting: " + hw);
            list.add(hw);
        }
    }

    private static void handleGetHardwareConfigChanged(AsyncResult ar) {
        if (ar.exception != null || ar.result == null) {
            loge("handleGetHardwareConfigChanged - returned an error.");
            return;
        }
        List hwcfg = ar.result;
        for (int i = 0; i < hwcfg.size(); i += EVENT_HARDWARE_CONFIG_CHANGED) {
            HardwareConfig hw = (HardwareConfig) hwcfg.get(i);
            if (hw != null) {
                if (hw.type == 0) {
                    updateOrInsert(hw, mModems);
                } else if (hw.type == EVENT_HARDWARE_CONFIG_CHANGED) {
                    updateOrInsert(hw, mSims);
                }
            }
        }
    }

    public static int getModemCount() {
        int count;
        synchronized (mLock) {
            count = mModems.size();
            logd("getModemCount: " + count);
        }
        return count;
    }

    public HardwareConfig getModem(int index) {
        HardwareConfig hardwareConfig = null;
        synchronized (mLock) {
            if (mModems.isEmpty()) {
                loge("getModem: no registered modem device?!?");
            } else if (index > getModemCount()) {
                loge("getModem: out-of-bounds access for modem device " + index + " max: " + getModemCount());
            } else {
                logd("getModem: " + index);
                hardwareConfig = (HardwareConfig) mModems.get(index);
            }
        }
        return hardwareConfig;
    }

    public int getSimCount() {
        int count;
        synchronized (mLock) {
            count = mSims.size();
            logd("getSimCount: " + count);
        }
        return count;
    }

    public HardwareConfig getSim(int index) {
        HardwareConfig hardwareConfig = null;
        synchronized (mLock) {
            if (mSims.isEmpty()) {
                loge("getSim: no registered sim device?!?");
            } else if (index > getSimCount()) {
                loge("getSim: out-of-bounds access for sim device " + index + " max: " + getSimCount());
            } else {
                logd("getSim: " + index);
                hardwareConfig = (HardwareConfig) mSims.get(index);
            }
        }
        return hardwareConfig;
    }

    public HardwareConfig getModemForSim(int simIndex) {
        synchronized (mLock) {
            if (mModems.isEmpty() || mSims.isEmpty()) {
                loge("getModemForSim: no registered modem/sim device?!?");
                return null;
            } else if (simIndex > getSimCount()) {
                loge("getModemForSim: out-of-bounds access for sim device " + simIndex + " max: " + getSimCount());
                return null;
            } else {
                logd("getModemForSim " + simIndex);
                HardwareConfig sim = getSim(simIndex);
                Iterator i$ = mModems.iterator();
                while (i$.hasNext()) {
                    HardwareConfig modem = (HardwareConfig) i$.next();
                    if (modem.uuid.equals(sim.modemUuid)) {
                        return modem;
                    }
                }
                return null;
            }
        }
    }

    public ArrayList<HardwareConfig> getAllSimsForModem(int modemIndex) {
        ArrayList<HardwareConfig> arrayList = null;
        synchronized (mLock) {
            if (mSims.isEmpty()) {
                loge("getAllSimsForModem: no registered sim device?!?");
            } else if (modemIndex > getModemCount()) {
                loge("getAllSimsForModem: out-of-bounds access for modem device " + modemIndex + " max: " + getModemCount());
            } else {
                logd("getAllSimsForModem " + modemIndex);
                arrayList = new ArrayList();
                HardwareConfig modem = getModem(modemIndex);
                Iterator i$ = mSims.iterator();
                while (i$.hasNext()) {
                    HardwareConfig sim = (HardwareConfig) i$.next();
                    if (sim.modemUuid.equals(modem.uuid)) {
                        arrayList.add(sim);
                    }
                }
            }
        }
        return arrayList;
    }

    public ArrayList<HardwareConfig> getAllModems() {
        ArrayList<HardwareConfig> modems;
        synchronized (mLock) {
            modems = new ArrayList();
            if (mModems.isEmpty()) {
                logd("getAllModems: empty list.");
            } else {
                Iterator i$ = mModems.iterator();
                while (i$.hasNext()) {
                    modems.add((HardwareConfig) i$.next());
                }
            }
        }
        return modems;
    }

    public ArrayList<HardwareConfig> getAllSims() {
        ArrayList<HardwareConfig> sims;
        synchronized (mLock) {
            sims = new ArrayList();
            if (mSims.isEmpty()) {
                logd("getAllSims: empty list.");
            } else {
                Iterator i$ = mSims.iterator();
                while (i$.hasNext()) {
                    sims.add((HardwareConfig) i$.next());
                }
            }
        }
        return sims;
    }
}
