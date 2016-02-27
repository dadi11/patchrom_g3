package android.content;

import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.os.RemoteException;
import android.util.AttributeSet;
import android.util.Log;
import android.util.Xml;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.Toast;
import com.android.internal.R;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.xmlpull.v1.XmlPullParserException;

public class RestrictionsManager {
    public static final String ACTION_PERMISSION_RESPONSE_RECEIVED = "android.content.action.PERMISSION_RESPONSE_RECEIVED";
    public static final String ACTION_REQUEST_LOCAL_APPROVAL = "android.content.action.REQUEST_LOCAL_APPROVAL";
    public static final String ACTION_REQUEST_PERMISSION = "android.content.action.REQUEST_PERMISSION";
    public static final String EXTRA_PACKAGE_NAME = "android.content.extra.PACKAGE_NAME";
    public static final String EXTRA_REQUEST_BUNDLE = "android.content.extra.REQUEST_BUNDLE";
    public static final String EXTRA_REQUEST_ID = "android.content.extra.REQUEST_ID";
    public static final String EXTRA_REQUEST_TYPE = "android.content.extra.REQUEST_TYPE";
    public static final String EXTRA_RESPONSE_BUNDLE = "android.content.extra.RESPONSE_BUNDLE";
    public static final String META_DATA_APP_RESTRICTIONS = "android.content.APP_RESTRICTIONS";
    public static final String REQUEST_KEY_APPROVE_LABEL = "android.request.approve_label";
    public static final String REQUEST_KEY_DATA = "android.request.data";
    public static final String REQUEST_KEY_DENY_LABEL = "android.request.deny_label";
    public static final String REQUEST_KEY_ICON = "android.request.icon";
    public static final String REQUEST_KEY_ID = "android.request.id";
    public static final String REQUEST_KEY_MESSAGE = "android.request.mesg";
    public static final String REQUEST_KEY_NEW_REQUEST = "android.request.new_request";
    public static final String REQUEST_KEY_TITLE = "android.request.title";
    public static final String REQUEST_TYPE_APPROVAL = "android.request.type.approval";
    public static final String RESPONSE_KEY_ERROR_CODE = "android.response.errorcode";
    public static final String RESPONSE_KEY_MESSAGE = "android.response.msg";
    public static final String RESPONSE_KEY_RESPONSE_TIMESTAMP = "android.response.timestamp";
    public static final String RESPONSE_KEY_RESULT = "android.response.result";
    public static final int RESULT_APPROVED = 1;
    public static final int RESULT_DENIED = 2;
    public static final int RESULT_ERROR = 5;
    public static final int RESULT_ERROR_BAD_REQUEST = 1;
    public static final int RESULT_ERROR_INTERNAL = 3;
    public static final int RESULT_ERROR_NETWORK = 2;
    public static final int RESULT_NO_RESPONSE = 3;
    public static final int RESULT_UNKNOWN_REQUEST = 4;
    private static final String TAG = "RestrictionsManager";
    private static final String TAG_RESTRICTION = "restriction";
    private final Context mContext;
    private final IRestrictionsManager mService;

    public RestrictionsManager(Context context, IRestrictionsManager service) {
        this.mContext = context;
        this.mService = service;
    }

    public Bundle getApplicationRestrictions() {
        try {
            if (this.mService != null) {
                return this.mService.getApplicationRestrictions(this.mContext.getPackageName());
            }
        } catch (RemoteException e) {
            Log.w(TAG, "Couldn't reach service");
        }
        return null;
    }

    public boolean hasRestrictionsProvider() {
        try {
            if (this.mService != null) {
                return this.mService.hasRestrictionsProvider();
            }
        } catch (RemoteException e) {
            Log.w(TAG, "Couldn't reach service");
        }
        return false;
    }

    public void requestPermission(String requestType, String requestId, PersistableBundle request) {
        if (requestType == null) {
            throw new NullPointerException("requestType cannot be null");
        } else if (requestId == null) {
            throw new NullPointerException("requestId cannot be null");
        } else if (request == null) {
            throw new NullPointerException("request cannot be null");
        } else {
            try {
                if (this.mService != null) {
                    this.mService.requestPermission(this.mContext.getPackageName(), requestType, requestId, request);
                }
            } catch (RemoteException e) {
                Log.w(TAG, "Couldn't reach service");
            }
        }
    }

    public Intent createLocalApprovalIntent() {
        try {
            if (this.mService != null) {
                return this.mService.createLocalApprovalIntent();
            }
        } catch (RemoteException e) {
            Log.w(TAG, "Couldn't reach service");
        }
        return null;
    }

    public void notifyPermissionResponse(String packageName, PersistableBundle response) {
        if (packageName == null) {
            throw new NullPointerException("packageName cannot be null");
        } else if (response == null) {
            throw new NullPointerException("request cannot be null");
        } else if (!response.containsKey(REQUEST_KEY_ID)) {
            throw new IllegalArgumentException("REQUEST_KEY_ID must be specified");
        } else if (response.containsKey(RESPONSE_KEY_RESULT)) {
            try {
                if (this.mService != null) {
                    this.mService.notifyPermissionResponse(packageName, response);
                }
            } catch (RemoteException e) {
                Log.w(TAG, "Couldn't reach service");
            }
        } else {
            throw new IllegalArgumentException("RESPONSE_KEY_RESULT must be specified");
        }
    }

    public List<RestrictionEntry> getManifestRestrictions(String packageName) {
        try {
            ApplicationInfo appInfo = this.mContext.getPackageManager().getApplicationInfo(packageName, AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
            if (appInfo == null || !appInfo.metaData.containsKey(META_DATA_APP_RESTRICTIONS)) {
                return null;
            }
            return loadManifestRestrictions(packageName, appInfo.loadXmlMetaData(this.mContext.getPackageManager(), META_DATA_APP_RESTRICTIONS));
        } catch (NameNotFoundException e) {
            throw new IllegalArgumentException("No such package " + packageName);
        }
    }

    private List<RestrictionEntry> loadManifestRestrictions(String packageName, XmlResourceParser xml) {
        try {
            Context appContext = this.mContext.createPackageContext(packageName, 0);
            List<RestrictionEntry> arrayList = new ArrayList();
            try {
                int tagType = xml.next();
                while (tagType != RESULT_ERROR_BAD_REQUEST) {
                    if (tagType == RESULT_ERROR_NETWORK && xml.getName().equals(TAG_RESTRICTION)) {
                        AttributeSet attrSet = Xml.asAttributeSet(xml);
                        if (attrSet != null) {
                            RestrictionEntry restriction = loadRestriction(appContext, appContext.obtainStyledAttributes(attrSet, R.styleable.RestrictionEntry));
                            if (restriction != null) {
                                arrayList.add(restriction);
                            }
                        }
                    }
                    tagType = xml.next();
                }
                return arrayList;
            } catch (XmlPullParserException e) {
                Log.w(TAG, "Reading restriction metadata for " + packageName, e);
                return null;
            } catch (IOException e2) {
                Log.w(TAG, "Reading restriction metadata for " + packageName, e2);
                return null;
            }
        } catch (NameNotFoundException e3) {
            return null;
        }
    }

    private RestrictionEntry loadRestriction(Context appContext, TypedArray a) {
        RestrictionEntry restrictionEntry = null;
        String key = a.getString(RESULT_NO_RESPONSE);
        int restrictionType = a.getInt(6, -1);
        String title = a.getString(RESULT_ERROR_NETWORK);
        String description = a.getString(0);
        int entries = a.getResourceId(RESULT_ERROR_BAD_REQUEST, 0);
        int entryValues = a.getResourceId(RESULT_ERROR, 0);
        if (restrictionType != -1) {
            if (key != null) {
                restrictionEntry = new RestrictionEntry(restrictionType, key);
                restrictionEntry.setTitle(title);
                restrictionEntry.setDescription(description);
                if (entries != 0) {
                    restrictionEntry.setChoiceEntries(appContext, entries);
                }
                if (entryValues != 0) {
                    restrictionEntry.setChoiceValues(appContext, entryValues);
                }
                switch (restrictionType) {
                    case Toast.LENGTH_SHORT /*0*/:
                    case RESULT_ERROR_NETWORK /*2*/:
                    case SetEmptyView.TAG /*6*/:
                        restrictionEntry.setSelectedString(a.getString(RESULT_UNKNOWN_REQUEST));
                        break;
                    case RESULT_ERROR_BAD_REQUEST /*1*/:
                        restrictionEntry.setSelectedState(a.getBoolean(RESULT_UNKNOWN_REQUEST, false));
                        break;
                    case RESULT_UNKNOWN_REQUEST /*4*/:
                        int resId = a.getResourceId(RESULT_UNKNOWN_REQUEST, 0);
                        if (resId != 0) {
                            restrictionEntry.setAllSelectedStrings(appContext.getResources().getStringArray(resId));
                            break;
                        }
                        break;
                    case RESULT_ERROR /*5*/:
                        restrictionEntry.setIntValue(a.getInt(RESULT_UNKNOWN_REQUEST, 0));
                        break;
                    default:
                        Log.w(TAG, "Unknown restriction type " + restrictionType);
                        break;
                }
            }
            Log.w(TAG, "key cannot be omitted");
        } else {
            Log.w(TAG, "restrictionType cannot be omitted");
        }
        return restrictionEntry;
    }
}
