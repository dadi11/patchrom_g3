package android.net;

import android.content.Context;
import android.os.RemoteException;
import android.os.UserHandle;
import android.text.format.Time;
import java.io.PrintWriter;

public class NetworkPolicyManager {
    private static final boolean ALLOW_PLATFORM_APP_POLICY = true;
    public static final String EXTRA_NETWORK_TEMPLATE = "android.net.NETWORK_TEMPLATE";
    public static final int POLICY_ALLOW_BACKGROUND_BATTERY_SAVE = 2;
    public static final int POLICY_NONE = 0;
    public static final int POLICY_REJECT_METERED_BACKGROUND = 1;
    public static final int RULE_ALLOW_ALL = 0;
    public static final int RULE_REJECT_METERED = 1;
    private INetworkPolicyManager mService;

    public NetworkPolicyManager(INetworkPolicyManager service) {
        if (service == null) {
            throw new IllegalArgumentException("missing INetworkPolicyManager");
        }
        this.mService = service;
    }

    public static NetworkPolicyManager from(Context context) {
        return (NetworkPolicyManager) context.getSystemService(Context.NETWORK_POLICY_SERVICE);
    }

    public void setUidPolicy(int uid, int policy) {
        try {
            this.mService.setUidPolicy(uid, policy);
        } catch (RemoteException e) {
        }
    }

    public void addUidPolicy(int uid, int policy) {
        try {
            this.mService.addUidPolicy(uid, policy);
        } catch (RemoteException e) {
        }
    }

    public void removeUidPolicy(int uid, int policy) {
        try {
            this.mService.removeUidPolicy(uid, policy);
        } catch (RemoteException e) {
        }
    }

    public int getUidPolicy(int uid) {
        try {
            return this.mService.getUidPolicy(uid);
        } catch (RemoteException e) {
            return RULE_ALLOW_ALL;
        }
    }

    public int[] getUidsWithPolicy(int policy) {
        try {
            return this.mService.getUidsWithPolicy(policy);
        } catch (RemoteException e) {
            return new int[RULE_ALLOW_ALL];
        }
    }

    public int[] getPowerSaveAppIdWhitelist() {
        try {
            return this.mService.getPowerSaveAppIdWhitelist();
        } catch (RemoteException e) {
            return new int[RULE_ALLOW_ALL];
        }
    }

    public void registerListener(INetworkPolicyListener listener) {
        try {
            this.mService.registerListener(listener);
        } catch (RemoteException e) {
        }
    }

    public void unregisterListener(INetworkPolicyListener listener) {
        try {
            this.mService.unregisterListener(listener);
        } catch (RemoteException e) {
        }
    }

    public void setNetworkPolicies(NetworkPolicy[] policies) {
        try {
            this.mService.setNetworkPolicies(policies);
        } catch (RemoteException e) {
        }
    }

    public NetworkPolicy[] getNetworkPolicies() {
        try {
            return this.mService.getNetworkPolicies();
        } catch (RemoteException e) {
            return null;
        }
    }

    public void setRestrictBackground(boolean restrictBackground) {
        try {
            this.mService.setRestrictBackground(restrictBackground);
        } catch (RemoteException e) {
        }
    }

    public boolean getRestrictBackground() {
        try {
            return this.mService.getRestrictBackground();
        } catch (RemoteException e) {
            return false;
        }
    }

    public static long computeLastCycleBoundary(long currentTime, NetworkPolicy policy) {
        if (policy.cycleDay == -1) {
            throw new IllegalArgumentException("Unable to compute boundary without cycleDay");
        }
        Time now = new Time(policy.cycleTimezone);
        now.set(currentTime);
        Time cycle = new Time(now);
        cycle.second = RULE_ALLOW_ALL;
        cycle.minute = RULE_ALLOW_ALL;
        cycle.hour = RULE_ALLOW_ALL;
        snapToCycleDay(cycle, policy.cycleDay);
        if (Time.compare(cycle, now) >= 0) {
            Time lastMonth = new Time(now);
            lastMonth.second = RULE_ALLOW_ALL;
            lastMonth.minute = RULE_ALLOW_ALL;
            lastMonth.hour = RULE_ALLOW_ALL;
            lastMonth.monthDay = RULE_REJECT_METERED;
            lastMonth.month--;
            lastMonth.normalize(ALLOW_PLATFORM_APP_POLICY);
            cycle.set(lastMonth);
            snapToCycleDay(cycle, policy.cycleDay);
        }
        return cycle.toMillis(ALLOW_PLATFORM_APP_POLICY);
    }

    public static long computeNextCycleBoundary(long currentTime, NetworkPolicy policy) {
        if (policy.cycleDay == -1) {
            throw new IllegalArgumentException("Unable to compute boundary without cycleDay");
        }
        Time now = new Time(policy.cycleTimezone);
        now.set(currentTime);
        Time cycle = new Time(now);
        cycle.second = RULE_ALLOW_ALL;
        cycle.minute = RULE_ALLOW_ALL;
        cycle.hour = RULE_ALLOW_ALL;
        snapToCycleDay(cycle, policy.cycleDay);
        if (Time.compare(cycle, now) <= 0) {
            Time nextMonth = new Time(now);
            nextMonth.second = RULE_ALLOW_ALL;
            nextMonth.minute = RULE_ALLOW_ALL;
            nextMonth.hour = RULE_ALLOW_ALL;
            nextMonth.monthDay = RULE_REJECT_METERED;
            nextMonth.month += RULE_REJECT_METERED;
            nextMonth.normalize(ALLOW_PLATFORM_APP_POLICY);
            cycle.set(nextMonth);
            snapToCycleDay(cycle, policy.cycleDay);
        }
        return cycle.toMillis(ALLOW_PLATFORM_APP_POLICY);
    }

    public static void snapToCycleDay(Time time, int cycleDay) {
        if (cycleDay > time.getActualMaximum(4)) {
            time.month += RULE_REJECT_METERED;
            time.monthDay = RULE_REJECT_METERED;
            time.second = -1;
        } else {
            time.monthDay = cycleDay;
        }
        time.normalize(ALLOW_PLATFORM_APP_POLICY);
    }

    @Deprecated
    public static boolean isUidValidForPolicy(Context context, int uid) {
        if (UserHandle.isApp(uid)) {
            return ALLOW_PLATFORM_APP_POLICY;
        }
        return false;
    }

    public static void dumpPolicy(PrintWriter fout, int policy) {
        fout.write("[");
        if ((policy & RULE_REJECT_METERED) != 0) {
            fout.write("REJECT_METERED_BACKGROUND");
        }
        fout.write("]");
    }

    public static void dumpRules(PrintWriter fout, int rules) {
        fout.write("[");
        if ((rules & RULE_REJECT_METERED) != 0) {
            fout.write("REJECT_METERED");
        }
        fout.write("]");
    }
}
