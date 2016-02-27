package android.net.wifi;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.ArrayList;
import java.util.Iterator;

public class WifiEapSimInfo implements Parcelable {
    public static final Creator<WifiEapSimInfo> CREATOR;
    private static final boolean DBG = false;
    public static final int MAX_NUM_OF_SIMS_SUPPORTED = 4;
    private static final String NUM_OF_SIMS_STR = "no_of_sims=";
    public static final int SIM_2G = 1;
    public static final int SIM_3G = 3;
    private static final String SIM_FOUR_TYPE_STR = "sim4=";
    private static final String SIM_ONE_TYPE_STR = "sim1=";
    private static final String SIM_THREE_TYPE_STR = "sim3=";
    private static final String SIM_TWO_TYPE_STR = "sim2=";
    public static final int SIM_UNSUPPORTED = 0;
    private static final String TAG = "WifiEapSimInfo";
    public static final String[] m2GSupportedTypes;
    public static final String[] m3GSupportedTypes;
    public int mNumOfSims;
    public ArrayList<Integer> mSimTypes;

    /* renamed from: android.net.wifi.WifiEapSimInfo.1 */
    static class C05361 implements Creator<WifiEapSimInfo> {
        C05361() {
        }

        public WifiEapSimInfo createFromParcel(Parcel in) {
            WifiEapSimInfo mWifiEapSimInfo = new WifiEapSimInfo();
            mWifiEapSimInfo.mNumOfSims = in.readInt();
            int count = in.readInt();
            while (true) {
                int count2 = count - 1;
                if (count <= 0) {
                    return mWifiEapSimInfo;
                }
                mWifiEapSimInfo.mSimTypes.add(new Integer(in.readInt()));
                count = count2;
            }
        }

        public WifiEapSimInfo[] newArray(int size) {
            return new WifiEapSimInfo[size];
        }
    }

    static {
        String[] strArr = new String[SIM_2G];
        strArr[SIM_UNSUPPORTED] = "SIM";
        m2GSupportedTypes = strArr;
        m3GSupportedTypes = new String[]{"SIM", "AKA"};
        CREATOR = new C05361();
    }

    public WifiEapSimInfo() {
        this.mSimTypes = new ArrayList();
    }

    public WifiEapSimInfo(WifiEapSimInfo source) {
        this.mSimTypes = new ArrayList();
        if (source != null) {
            this.mNumOfSims = source.mNumOfSims;
            this.mSimTypes = source.mSimTypes;
        }
    }

    public WifiEapSimInfo(String dataString) throws IllegalArgumentException {
        this.mSimTypes = new ArrayList();
        String[] sims = dataString.split(" ");
        if (sims.length < SIM_2G || sims.length > MAX_NUM_OF_SIMS_SUPPORTED) {
            throw new IllegalArgumentException();
        }
        String[] arr$ = sims;
        int len$ = arr$.length;
        for (int i$ = SIM_UNSUPPORTED; i$ < len$; i$ += SIM_2G) {
            String sim = arr$[i$];
            if (sim.startsWith(NUM_OF_SIMS_STR)) {
                try {
                    this.mNumOfSims = Integer.parseInt(sim.substring(NUM_OF_SIMS_STR.length()));
                } catch (NumberFormatException e) {
                    this.mNumOfSims = SIM_UNSUPPORTED;
                }
            } else if (sim.startsWith(SIM_ONE_TYPE_STR)) {
                try {
                    mSimInfo = Integer.parseInt(sim.substring(SIM_ONE_TYPE_STR.length()));
                } catch (NumberFormatException e2) {
                    mSimInfo = SIM_UNSUPPORTED;
                }
                this.mSimTypes.add(Integer.valueOf(mSimInfo));
            } else if (sim.startsWith(SIM_TWO_TYPE_STR)) {
                try {
                    mSimInfo = Integer.parseInt(sim.substring(SIM_TWO_TYPE_STR.length()));
                } catch (NumberFormatException e3) {
                    mSimInfo = SIM_UNSUPPORTED;
                }
                this.mSimTypes.add(Integer.valueOf(mSimInfo));
            } else if (sim.startsWith(SIM_THREE_TYPE_STR)) {
                try {
                    mSimInfo = Integer.parseInt(sim.substring(SIM_THREE_TYPE_STR.length()));
                } catch (NumberFormatException e4) {
                    mSimInfo = SIM_UNSUPPORTED;
                }
                this.mSimTypes.add(Integer.valueOf(mSimInfo));
            } else if (sim.startsWith(SIM_FOUR_TYPE_STR)) {
                try {
                    mSimInfo = Integer.parseInt(sim.substring(SIM_FOUR_TYPE_STR.length()));
                } catch (NumberFormatException e5) {
                    mSimInfo = SIM_UNSUPPORTED;
                }
                this.mSimTypes.add(Integer.valueOf(mSimInfo));
            } else {
                throw new IllegalArgumentException();
            }
        }
    }

    public int describeContents() {
        return SIM_UNSUPPORTED;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mNumOfSims);
        dest.writeInt(this.mSimTypes.size());
        Iterator i$ = this.mSimTypes.iterator();
        while (i$.hasNext()) {
            dest.writeInt(((Integer) i$.next()).intValue());
        }
    }
}
