package android.service.fingerprint;

import android.content.ContentResolver;
import android.net.ProxyInfo;
import android.provider.Settings.Secure;
import android.text.TextUtils;
import java.util.Arrays;

public class FingerprintUtils {
    private static final boolean DEBUG = false;
    private static final String TAG = "FingerprintUtils";

    public static int[] getFingerprintIdsForUser(ContentResolver res, int userId) {
        String fingerIdsRaw = Secure.getStringForUser(res, "user_fingerprint_ids", userId);
        int[] result = new int[0];
        if (!TextUtils.isEmpty(fingerIdsRaw)) {
            String[] fingerStringIds = fingerIdsRaw.replace("[", ProxyInfo.LOCAL_EXCL_LIST).replace("]", ProxyInfo.LOCAL_EXCL_LIST).split(", ");
            result = new int[fingerStringIds.length];
            for (int i = 0; i < result.length; i++) {
                try {
                    result[i] = Integer.decode(fingerStringIds[i]).intValue();
                } catch (NumberFormatException e) {
                }
            }
        }
        return result;
    }

    public static void addFingerprintIdForUser(int fingerId, ContentResolver res, int userId) {
        int[] fingerIds = getFingerprintIdsForUser(res, userId);
        if (fingerId != 0) {
            int i = 0;
            while (i < fingerIds.length) {
                if (fingerIds[i] != fingerId) {
                    i++;
                } else {
                    return;
                }
            }
            int[] newList = Arrays.copyOf(fingerIds, fingerIds.length + 1);
            newList[fingerIds.length] = fingerId;
            Secure.putStringForUser(res, "user_fingerprint_ids", Arrays.toString(newList), userId);
        }
    }

    public static boolean removeFingerprintIdForUser(int fingerId, ContentResolver res, int userId) {
        if (fingerId == 0) {
            throw new IllegalStateException("Bad fingerId");
        }
        int[] fingerIds = getFingerprintIdsForUser(res, userId);
        int[] resultIds = Arrays.copyOf(fingerIds, fingerIds.length);
        int resultCount = 0;
        for (int i = 0; i < fingerIds.length; i++) {
            if (fingerId != fingerIds[i]) {
                int resultCount2 = resultCount + 1;
                resultIds[resultCount] = fingerIds[i];
                resultCount = resultCount2;
            }
        }
        if (resultCount <= 0) {
            return DEBUG;
        }
        Secure.putStringForUser(res, "user_fingerprint_ids", Arrays.toString(Arrays.copyOf(resultIds, resultCount)), userId);
        return true;
    }
}
