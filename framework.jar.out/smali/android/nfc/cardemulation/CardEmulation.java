package android.nfc.cardemulation;

import android.app.Activity;
import android.app.ActivityThread;
import android.content.ComponentName;
import android.content.Context;
import android.content.pm.IPackageManager;
import android.content.pm.PackageManager;
import android.nfc.INfcCardEmulation;
import android.nfc.NfcAdapter;
import android.os.RemoteException;
import android.os.UserHandle;
import android.provider.Settings.Secure;
import android.provider.Settings.SettingNotFoundException;
import android.util.Log;
import java.util.HashMap;
import java.util.List;

public final class CardEmulation {
    public static final String ACTION_CHANGE_DEFAULT = "android.nfc.cardemulation.action.ACTION_CHANGE_DEFAULT";
    public static final String CATEGORY_OTHER = "other";
    public static final String CATEGORY_PAYMENT = "payment";
    public static final String EXTRA_CATEGORY = "category";
    public static final String EXTRA_SERVICE_COMPONENT = "component";
    public static final int SELECTION_MODE_ALWAYS_ASK = 1;
    public static final int SELECTION_MODE_ASK_IF_CONFLICT = 2;
    public static final int SELECTION_MODE_PREFER_DEFAULT = 0;
    static final String TAG = "CardEmulation";
    static HashMap<Context, CardEmulation> sCardEmus;
    static boolean sIsInitialized;
    static INfcCardEmulation sService;
    final Context mContext;

    static {
        sIsInitialized = false;
        sCardEmus = new HashMap();
    }

    private CardEmulation(Context context, INfcCardEmulation service) {
        this.mContext = context.getApplicationContext();
        sService = service;
    }

    public static synchronized CardEmulation getInstance(NfcAdapter adapter) {
        CardEmulation manager;
        synchronized (CardEmulation.class) {
            if (adapter == null) {
                throw new NullPointerException("NfcAdapter is null");
            }
            Context context = adapter.getContext();
            if (context == null) {
                Log.e(TAG, "NfcAdapter context is null.");
                throw new UnsupportedOperationException();
            }
            if (!sIsInitialized) {
                IPackageManager pm = ActivityThread.getPackageManager();
                if (pm == null) {
                    Log.e(TAG, "Cannot get PackageManager");
                    throw new UnsupportedOperationException();
                }
                try {
                    if (pm.hasSystemFeature(PackageManager.FEATURE_NFC_HOST_CARD_EMULATION)) {
                        sIsInitialized = true;
                    } else {
                        Log.e(TAG, "This device does not support card emulation");
                        throw new UnsupportedOperationException();
                    }
                } catch (RemoteException e) {
                    Log.e(TAG, "PackageManager query failed.");
                    throw new UnsupportedOperationException();
                }
            }
            manager = (CardEmulation) sCardEmus.get(context);
            if (manager == null) {
                INfcCardEmulation service = adapter.getCardEmulationService();
                if (service == null) {
                    Log.e(TAG, "This device does not implement the INfcCardEmulation interface.");
                    throw new UnsupportedOperationException();
                }
                manager = new CardEmulation(context, service);
                sCardEmus.put(context, manager);
            }
        }
        return manager;
    }

    public boolean isDefaultServiceForCategory(ComponentName service, String category) {
        boolean z = false;
        try {
            z = sService.isDefaultServiceForCategory(UserHandle.myUserId(), service, category);
        } catch (RemoteException e) {
            recoverService();
            if (sService == null) {
                Log.e(TAG, "Failed to recover CardEmulationService.");
            } else {
                try {
                    z = sService.isDefaultServiceForCategory(UserHandle.myUserId(), service, category);
                } catch (RemoteException e2) {
                    Log.e(TAG, "Failed to recover CardEmulationService.");
                }
            }
        }
        return z;
    }

    public boolean isDefaultServiceForAid(ComponentName service, String aid) {
        boolean z = false;
        try {
            z = sService.isDefaultServiceForAid(UserHandle.myUserId(), service, aid);
        } catch (RemoteException e) {
            recoverService();
            if (sService == null) {
                Log.e(TAG, "Failed to recover CardEmulationService.");
            } else {
                try {
                    z = sService.isDefaultServiceForAid(UserHandle.myUserId(), service, aid);
                } catch (RemoteException e2) {
                    Log.e(TAG, "Failed to reach CardEmulationService.");
                }
            }
        }
        return z;
    }

    public boolean categoryAllowsForegroundPreference(String category) {
        if (!CATEGORY_PAYMENT.equals(category)) {
            return true;
        }
        try {
            return Secure.getInt(this.mContext.getContentResolver(), "nfc_payment_foreground") != 0;
        } catch (SettingNotFoundException e) {
            return false;
        }
    }

    public int getSelectionModeForCategory(String category) {
        if (!CATEGORY_PAYMENT.equals(category)) {
            return SELECTION_MODE_ASK_IF_CONFLICT;
        }
        if (Secure.getString(this.mContext.getContentResolver(), "nfc_payment_default_component") != null) {
            return SELECTION_MODE_PREFER_DEFAULT;
        }
        return SELECTION_MODE_ALWAYS_ASK;
    }

    public boolean registerAidsForService(ComponentName service, String category, List<String> aids) {
        boolean z = false;
        AidGroup aidGroup = new AidGroup((List) aids, category);
        try {
            z = sService.registerAidGroupForService(UserHandle.myUserId(), service, aidGroup);
        } catch (RemoteException e) {
            recoverService();
            if (sService == null) {
                Log.e(TAG, "Failed to recover CardEmulationService.");
            } else {
                try {
                    z = sService.registerAidGroupForService(UserHandle.myUserId(), service, aidGroup);
                } catch (RemoteException e2) {
                    Log.e(TAG, "Failed to reach CardEmulationService.");
                }
            }
        }
        return z;
    }

    public List<String> getAidsForService(ComponentName service, String category) {
        AidGroup group;
        List<String> list = null;
        try {
            group = sService.getAidGroupForService(UserHandle.myUserId(), service, category);
            if (group != null) {
                list = group.getAids();
            }
        } catch (RemoteException e) {
            recoverService();
            if (sService == null) {
                Log.e(TAG, "Failed to recover CardEmulationService.");
            } else {
                try {
                    group = sService.getAidGroupForService(UserHandle.myUserId(), service, category);
                    if (group != null) {
                        list = group.getAids();
                    }
                } catch (RemoteException e2) {
                    Log.e(TAG, "Failed to recover CardEmulationService.");
                }
            }
        }
        return list;
    }

    public boolean removeAidsForService(ComponentName service, String category) {
        boolean z = false;
        try {
            z = sService.removeAidGroupForService(UserHandle.myUserId(), service, category);
        } catch (RemoteException e) {
            recoverService();
            if (sService == null) {
                Log.e(TAG, "Failed to recover CardEmulationService.");
            } else {
                try {
                    z = sService.removeAidGroupForService(UserHandle.myUserId(), service, category);
                } catch (RemoteException e2) {
                    Log.e(TAG, "Failed to reach CardEmulationService.");
                }
            }
        }
        return z;
    }

    public boolean setPreferredService(Activity activity, ComponentName service) {
        boolean z = false;
        if (activity == null || service == null) {
            throw new NullPointerException("activity or service or category is null");
        } else if (activity.isResumed()) {
            try {
                z = sService.setPreferredService(service);
            } catch (RemoteException e) {
                recoverService();
                if (sService == null) {
                    Log.e(TAG, "Failed to recover CardEmulationService.");
                } else {
                    try {
                        z = sService.setPreferredService(service);
                    } catch (RemoteException e2) {
                        Log.e(TAG, "Failed to reach CardEmulationService.");
                    }
                }
            }
            return z;
        } else {
            throw new IllegalArgumentException("Activity must be resumed.");
        }
    }

    public boolean unsetPreferredService(Activity activity) {
        boolean z = false;
        if (activity == null) {
            throw new NullPointerException("activity is null");
        } else if (activity.isResumed()) {
            try {
                z = sService.unsetPreferredService();
            } catch (RemoteException e) {
                recoverService();
                if (sService == null) {
                    Log.e(TAG, "Failed to recover CardEmulationService.");
                } else {
                    try {
                        z = sService.unsetPreferredService();
                    } catch (RemoteException e2) {
                        Log.e(TAG, "Failed to reach CardEmulationService.");
                    }
                }
            }
            return z;
        } else {
            throw new IllegalArgumentException("Activity must be resumed.");
        }
    }

    public boolean supportsAidPrefixRegistration() {
        boolean z = false;
        try {
            z = sService.supportsAidPrefixRegistration();
        } catch (RemoteException e) {
            recoverService();
            if (sService == null) {
                Log.e(TAG, "Failed to recover CardEmulationService.");
            } else {
                try {
                    z = sService.supportsAidPrefixRegistration();
                } catch (RemoteException e2) {
                    Log.e(TAG, "Failed to reach CardEmulationService.");
                }
            }
        }
        return z;
    }

    public boolean setDefaultServiceForCategory(ComponentName service, String category) {
        boolean z = false;
        try {
            z = sService.setDefaultServiceForCategory(UserHandle.myUserId(), service, category);
        } catch (RemoteException e) {
            recoverService();
            if (sService == null) {
                Log.e(TAG, "Failed to recover CardEmulationService.");
            } else {
                try {
                    z = sService.setDefaultServiceForCategory(UserHandle.myUserId(), service, category);
                } catch (RemoteException e2) {
                    Log.e(TAG, "Failed to reach CardEmulationService.");
                }
            }
        }
        return z;
    }

    public boolean setDefaultForNextTap(ComponentName service) {
        boolean z = false;
        try {
            z = sService.setDefaultForNextTap(UserHandle.myUserId(), service);
        } catch (RemoteException e) {
            recoverService();
            if (sService == null) {
                Log.e(TAG, "Failed to recover CardEmulationService.");
            } else {
                try {
                    z = sService.setDefaultForNextTap(UserHandle.myUserId(), service);
                } catch (RemoteException e2) {
                    Log.e(TAG, "Failed to reach CardEmulationService.");
                }
            }
        }
        return z;
    }

    public List<ApduServiceInfo> getServices(String category) {
        List<ApduServiceInfo> list = null;
        try {
            list = sService.getServices(UserHandle.myUserId(), category);
        } catch (RemoteException e) {
            recoverService();
            if (sService == null) {
                Log.e(TAG, "Failed to recover CardEmulationService.");
            } else {
                try {
                    list = sService.getServices(UserHandle.myUserId(), category);
                } catch (RemoteException e2) {
                    Log.e(TAG, "Failed to reach CardEmulationService.");
                }
            }
        }
        return list;
    }

    public static boolean isValidAid(String aid) {
        if (aid == null) {
            return false;
        }
        if (aid.endsWith("*") && aid.length() % SELECTION_MODE_ASK_IF_CONFLICT == 0) {
            Log.e(TAG, "AID " + aid + " is not a valid AID.");
            return false;
        } else if (!aid.endsWith("*") && aid.length() % SELECTION_MODE_ASK_IF_CONFLICT != 0) {
            Log.e(TAG, "AID " + aid + " is not a valid AID.");
            return false;
        } else if (aid.matches("[0-9A-Fa-f]{10,32}\\*?")) {
            return true;
        } else {
            Log.e(TAG, "AID " + aid + " is not a valid AID.");
            return false;
        }
    }

    void recoverService() {
        sService = NfcAdapter.getDefaultAdapter(this.mContext).getCardEmulationService();
    }
}
