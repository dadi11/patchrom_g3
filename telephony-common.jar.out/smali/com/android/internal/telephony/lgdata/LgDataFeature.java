package com.android.internal.telephony.lgdata;

public class LgDataFeature {
    private static LgDataFeature sLgDataFeature;
    public boolean LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG;

    static {
        sLgDataFeature = null;
    }

    private LgDataFeature(String paramString) {
        this.LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG = false;
    }

    public static LgDataFeature getInstance() {
        sLgDataFeature = new LgDataFeature("none");
        return sLgDataFeature;
    }
}
