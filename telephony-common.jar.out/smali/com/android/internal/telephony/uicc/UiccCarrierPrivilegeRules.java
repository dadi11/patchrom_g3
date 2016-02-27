package com.android.internal.telephony.uicc;

import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.Signature;
import android.os.AsyncResult;
import android.os.Binder;
import android.os.Handler;
import android.os.Message;
import android.telephony.Rlog;
import com.google.android.mms.pdu.PduPart;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.atomic.AtomicInteger;

public class UiccCarrierPrivilegeRules extends Handler {
    private static final String AID = "A00000015141434C00";
    private static final int CLA = 128;
    private static final int COMMAND = 202;
    private static final String DATA = "";
    private static final int EVENT_CLOSE_LOGICAL_CHANNEL_DONE = 3;
    private static final int EVENT_OPEN_LOGICAL_CHANNEL_DONE = 1;
    private static final int EVENT_TRANSMIT_LOGICAL_CHANNEL_DONE = 2;
    private static final String LOG_TAG = "UiccCarrierPrivilegeRules";
    private static final int P1 = 255;
    private static final int P2 = 64;
    private static final int P2_EXTENDED_DATA = 96;
    private static final int P3 = 0;
    private static final int STATE_ERROR = 2;
    private static final int STATE_LOADED = 1;
    private static final int STATE_LOADING = 0;
    private static final String TAG_ALL_REF_AR_DO = "FF40";
    private static final String TAG_AR_DO = "E3";
    private static final String TAG_DEVICE_APP_ID_REF_DO = "C1";
    private static final String TAG_PERM_AR_DO = "DB";
    private static final String TAG_PKG_REF_DO = "CA";
    private static final String TAG_REF_AR_DO = "E2";
    private static final String TAG_REF_DO = "E1";
    private List<AccessRule> mAccessRules;
    private int mChannelId;
    private Message mLoadedCallback;
    private String mRules;
    private AtomicInteger mState;
    private String mStatusMessage;
    private UiccCard mUiccCard;

    private static class AccessRule {
        public long accessType;
        public byte[] certificateHash;
        public String packageName;

        AccessRule(byte[] certificateHash, String packageName, long accessType) {
            this.certificateHash = certificateHash;
            this.packageName = packageName;
            this.accessType = accessType;
        }

        boolean matches(byte[] certHash, String packageName) {
            return certHash != null && Arrays.equals(this.certificateHash, certHash) && (this.packageName == null || this.packageName.equals(packageName));
        }

        public String toString() {
            return "cert: " + IccUtils.bytesToHexString(this.certificateHash) + " pkg: " + this.packageName + " access: " + this.accessType;
        }
    }

    private static class TLV {
        private static final int SINGLE_BYTE_MAX_LENGTH = 128;
        private Integer length;
        private String lengthBytes;
        private String tag;
        private String value;

        public TLV(String tag) {
            this.tag = tag;
        }

        public String parseLength(String data) {
            int offset = this.tag.length();
            int firstByte = Integer.parseInt(data.substring(offset, offset + UiccCarrierPrivilegeRules.STATE_ERROR), 16);
            if (firstByte < SINGLE_BYTE_MAX_LENGTH) {
                this.length = Integer.valueOf(firstByte * UiccCarrierPrivilegeRules.STATE_ERROR);
                this.lengthBytes = data.substring(offset, offset + UiccCarrierPrivilegeRules.STATE_ERROR);
            } else {
                int numBytes = firstByte - 128;
                this.length = Integer.valueOf(Integer.parseInt(data.substring(offset + UiccCarrierPrivilegeRules.STATE_ERROR, (offset + UiccCarrierPrivilegeRules.STATE_ERROR) + (numBytes * UiccCarrierPrivilegeRules.STATE_ERROR)), 16) * UiccCarrierPrivilegeRules.STATE_ERROR);
                this.lengthBytes = data.substring(offset, (offset + UiccCarrierPrivilegeRules.STATE_ERROR) + (numBytes * UiccCarrierPrivilegeRules.STATE_ERROR));
            }
            Rlog.d(UiccCarrierPrivilegeRules.LOG_TAG, "TLV parseLength length=" + this.length + "lenghtBytes: " + this.lengthBytes);
            return this.lengthBytes;
        }

        public String parse(String data, boolean shouldConsumeAll) {
            Rlog.d(UiccCarrierPrivilegeRules.LOG_TAG, "Parse TLV: " + this.tag);
            if (data.startsWith(this.tag)) {
                int index = this.tag.length();
                if (index + UiccCarrierPrivilegeRules.STATE_ERROR > data.length()) {
                    throw new IllegalArgumentException("No length.");
                }
                parseLength(data);
                index += this.lengthBytes.length();
                Rlog.d(UiccCarrierPrivilegeRules.LOG_TAG, "index=" + index + " length=" + this.length + "data.length=" + data.length());
                int remainingLength = data.length() - (this.length.intValue() + index);
                if (remainingLength < 0) {
                    throw new IllegalArgumentException("Not enough data.");
                } else if (!shouldConsumeAll || remainingLength == 0) {
                    this.value = data.substring(index, this.length.intValue() + index);
                    Rlog.d(UiccCarrierPrivilegeRules.LOG_TAG, "Got TLV: " + this.tag + "," + this.length + "," + this.value);
                    return data.substring(this.length.intValue() + index);
                } else {
                    throw new IllegalArgumentException("Did not consume all.");
                }
            }
            throw new IllegalArgumentException("Tags don't match.");
        }
    }

    public UiccCarrierPrivilegeRules(UiccCard uiccCard, Message loadedCallback) {
        Rlog.d(LOG_TAG, "Creating UiccCarrierPrivilegeRules");
        this.mUiccCard = uiccCard;
        this.mState = new AtomicInteger(STATE_LOADING);
        this.mStatusMessage = "Not loaded.";
        this.mLoadedCallback = loadedCallback;
        this.mRules = DATA;
        this.mUiccCard.iccOpenLogicalChannel(AID, obtainMessage(STATE_LOADED, null));
    }

    public boolean areCarrierPriviligeRulesLoaded() {
        return this.mState.get() != 0;
    }

    public int getCarrierPrivilegeStatus(Signature signature, String packageName) {
        Rlog.d(LOG_TAG, "hasCarrierPrivileges: " + signature + " : " + packageName);
        int state = this.mState.get();
        if (state == 0) {
            Rlog.d(LOG_TAG, "Rules not loaded.");
            return -1;
        } else if (state == STATE_ERROR) {
            Rlog.d(LOG_TAG, "Error loading rules.");
            return -2;
        } else {
            byte[] certHash = getCertHash(signature, "SHA-1");
            byte[] certHash256 = getCertHash(signature, "SHA-256");
            Rlog.d(LOG_TAG, "Checking SHA1: " + IccUtils.bytesToHexString(certHash) + " : " + packageName);
            Rlog.d(LOG_TAG, "Checking SHA256: " + IccUtils.bytesToHexString(certHash256) + " : " + packageName);
            for (AccessRule ar : this.mAccessRules) {
                if (!ar.matches(certHash, packageName)) {
                    if (ar.matches(certHash256, packageName)) {
                    }
                }
                Rlog.d(LOG_TAG, "Match found!");
                return STATE_LOADED;
            }
            Rlog.d(LOG_TAG, "No matching rule found. Returning false.");
            return STATE_LOADING;
        }
    }

    public int getCarrierPrivilegeStatus(PackageManager packageManager, String packageName) {
        try {
            PackageInfo pInfo = packageManager.getPackageInfo(packageName, P2);
            Signature[] arr$ = pInfo.signatures;
            int len$ = arr$.length;
            for (int i$ = STATE_LOADING; i$ < len$; i$ += STATE_LOADED) {
                int accessStatus = getCarrierPrivilegeStatus(arr$[i$], pInfo.packageName);
                if (accessStatus != 0) {
                    return accessStatus;
                }
            }
        } catch (NameNotFoundException ex) {
            Rlog.e(LOG_TAG, "NameNotFoundException", ex);
        }
        return STATE_LOADING;
    }

    public int getCarrierPrivilegeStatusForCurrentTransaction(PackageManager packageManager) {
        String[] arr$ = packageManager.getPackagesForUid(Binder.getCallingUid());
        int len$ = arr$.length;
        for (int i$ = STATE_LOADING; i$ < len$; i$ += STATE_LOADED) {
            int accessStatus = getCarrierPrivilegeStatus(packageManager, arr$[i$]);
            if (accessStatus != 0) {
                return accessStatus;
            }
        }
        return STATE_LOADING;
    }

    public List<String> getCarrierPackageNamesForIntent(PackageManager packageManager, Intent intent) {
        List<String> packages = new ArrayList();
        List<ResolveInfo> receivers = new ArrayList();
        receivers.addAll(packageManager.queryBroadcastReceivers(intent, STATE_LOADING));
        receivers.addAll(packageManager.queryIntentContentProviders(intent, STATE_LOADING));
        receivers.addAll(packageManager.queryIntentActivities(intent, STATE_LOADING));
        receivers.addAll(packageManager.queryIntentServices(intent, STATE_LOADING));
        for (ResolveInfo resolveInfo : receivers) {
            String packageName = getPackageName(resolveInfo);
            if (packageName != null) {
                int status = getCarrierPrivilegeStatus(packageManager, packageName);
                if (status == STATE_LOADED) {
                    packages.add(packageName);
                } else if (status != 0) {
                    return null;
                }
            }
        }
        return packages;
    }

    private String getPackageName(ResolveInfo resolveInfo) {
        if (resolveInfo.activityInfo != null) {
            return resolveInfo.activityInfo.packageName;
        }
        if (resolveInfo.serviceInfo != null) {
            return resolveInfo.serviceInfo.packageName;
        }
        if (resolveInfo.providerInfo != null) {
            return resolveInfo.providerInfo.packageName;
        }
        return null;
    }

    public void handleMessage(Message msg) {
        AsyncResult ar;
        switch (msg.what) {
            case STATE_LOADED /*1*/:
                Rlog.d(LOG_TAG, "EVENT_OPEN_LOGICAL_CHANNEL_DONE");
                ar = msg.obj;
                if (ar.exception != null || ar.result == null) {
                    updateState(STATE_ERROR, "Error opening channel");
                    return;
                }
                this.mChannelId = ((int[]) ar.result)[STATE_LOADING];
                this.mUiccCard.iccTransmitApduLogicalChannel(this.mChannelId, CLA, COMMAND, P1, P2, STATE_LOADING, DATA, obtainMessage(STATE_ERROR, new Integer(this.mChannelId)));
            case STATE_ERROR /*2*/:
                Rlog.d(LOG_TAG, "EVENT_TRANSMIT_LOGICAL_CHANNEL_DONE");
                ar = (AsyncResult) msg.obj;
                if (ar.exception != null || ar.result == null) {
                    updateState(STATE_ERROR, "Error reading value from SIM.");
                } else {
                    IccIoResult response = ar.result;
                    if (response.sw1 != PduPart.P_SECURE || response.sw2 != 0 || response.payload == null || response.payload.length <= 0) {
                        updateState(STATE_ERROR, "Invalid response: payload=" + response.payload + " sw1=" + response.sw1 + " sw2=" + response.sw2);
                    } else {
                        try {
                            this.mRules += IccUtils.bytesToHexString(response.payload).toUpperCase(Locale.US);
                            if (isDataComplete()) {
                                this.mAccessRules = parseRules(this.mRules);
                                updateState(STATE_LOADED, "Success!");
                            } else {
                                this.mUiccCard.iccTransmitApduLogicalChannel(this.mChannelId, CLA, COMMAND, P1, P2_EXTENDED_DATA, STATE_LOADING, DATA, obtainMessage(STATE_ERROR, new Integer(this.mChannelId)));
                                return;
                            }
                        } catch (IllegalArgumentException ex) {
                            updateState(STATE_ERROR, "Error parsing rules: " + ex);
                        } catch (IndexOutOfBoundsException ex2) {
                            updateState(STATE_ERROR, "Error parsing rules: " + ex2);
                        }
                    }
                }
                this.mUiccCard.iccCloseLogicalChannel(this.mChannelId, obtainMessage(EVENT_CLOSE_LOGICAL_CHANNEL_DONE));
                this.mChannelId = -1;
            case EVENT_CLOSE_LOGICAL_CHANNEL_DONE /*3*/:
                Rlog.d(LOG_TAG, "EVENT_CLOSE_LOGICAL_CHANNEL_DONE");
            default:
                Rlog.e(LOG_TAG, "Unknown event " + msg.what);
        }
    }

    private boolean isDataComplete() {
        Rlog.d(LOG_TAG, "isDataComplete mRules:" + this.mRules);
        if (this.mRules.startsWith(TAG_ALL_REF_AR_DO)) {
            TLV allRules = new TLV(TAG_ALL_REF_AR_DO);
            String lengthBytes = allRules.parseLength(this.mRules);
            Rlog.d(LOG_TAG, "isDataComplete lengthBytes: " + lengthBytes);
            if (this.mRules.length() == (TAG_ALL_REF_AR_DO.length() + lengthBytes.length()) + allRules.length.intValue()) {
                Rlog.d(LOG_TAG, "isDataComplete yes");
                return true;
            }
            Rlog.d(LOG_TAG, "isDataComplete no");
            return false;
        }
        throw new IllegalArgumentException("Tags don't match.");
    }

    private static List<AccessRule> parseRules(String rules) {
        Rlog.d(LOG_TAG, "Got rules: " + rules);
        TLV allRefArDo = new TLV(TAG_ALL_REF_AR_DO);
        allRefArDo.parse(rules, true);
        String arDos = allRefArDo.value;
        List<AccessRule> accessRules = new ArrayList();
        while (!arDos.isEmpty()) {
            TLV refArDo = new TLV(TAG_REF_AR_DO);
            arDos = refArDo.parse(arDos, false);
            AccessRule accessRule = parseRefArdo(refArDo.value);
            if (accessRule != null) {
                accessRules.add(accessRule);
            } else {
                Rlog.e(LOG_TAG, "Skip unrecognized rule." + refArDo.value);
            }
        }
        return accessRules;
    }

    private static AccessRule parseRefArdo(String rule) {
        Rlog.d(LOG_TAG, "Got rule: " + rule);
        String certificateHash = null;
        String packageName = null;
        while (!rule.isEmpty()) {
            if (rule.startsWith(TAG_REF_DO)) {
                TLV refDo = new TLV(TAG_REF_DO);
                rule = refDo.parse(rule, false);
                if (!refDo.value.startsWith(TAG_DEVICE_APP_ID_REF_DO)) {
                    return null;
                }
                TLV deviceDo = new TLV(TAG_DEVICE_APP_ID_REF_DO);
                String tmp = deviceDo.parse(refDo.value, false);
                certificateHash = deviceDo.value;
                if (tmp.isEmpty()) {
                    packageName = null;
                } else if (!tmp.startsWith(TAG_PKG_REF_DO)) {
                    return null;
                } else {
                    TLV pkgDo = new TLV(TAG_PKG_REF_DO);
                    pkgDo.parse(tmp, true);
                    packageName = new String(IccUtils.hexStringToBytes(pkgDo.value));
                }
            } else if (rule.startsWith(TAG_AR_DO)) {
                TLV arDo = new TLV(TAG_AR_DO);
                rule = arDo.parse(rule, false);
                if (!arDo.value.startsWith(TAG_PERM_AR_DO)) {
                    return null;
                }
                TLV permDo = new TLV(TAG_PERM_AR_DO);
                permDo.parse(arDo.value, true);
                Rlog.e(LOG_TAG, permDo.value);
            } else {
                throw new RuntimeException("Invalid Rule type");
            }
        }
        Rlog.e(LOG_TAG, "Adding: " + certificateHash + " : " + packageName + " : " + 0);
        AccessRule accessRule = new AccessRule(IccUtils.hexStringToBytes(certificateHash), packageName, 0);
        Rlog.e(LOG_TAG, "Parsed rule: " + accessRule);
        return accessRule;
    }

    private static byte[] getCertHash(Signature signature, String algo) {
        try {
            return MessageDigest.getInstance(algo).digest(signature.toByteArray());
        } catch (NoSuchAlgorithmException ex) {
            Rlog.e(LOG_TAG, "NoSuchAlgorithmException: " + ex);
            return null;
        }
    }

    private void updateState(int newState, String statusMessage) {
        this.mState.set(newState);
        if (this.mLoadedCallback != null) {
            this.mLoadedCallback.sendToTarget();
        }
        this.mStatusMessage = statusMessage;
        Rlog.e(LOG_TAG, this.mStatusMessage);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("UiccCarrierPrivilegeRules: " + this);
        pw.println(" mState=" + getStateString(this.mState.get()));
        pw.println(" mStatusMessage='" + this.mStatusMessage + "'");
        if (this.mAccessRules != null) {
            pw.println(" mAccessRules: ");
            for (AccessRule ar : this.mAccessRules) {
                pw.println("  rule='" + ar + "'");
            }
        } else {
            pw.println(" mAccessRules: null");
        }
        pw.flush();
    }

    private String getStateString(int state) {
        switch (state) {
            case STATE_LOADING /*0*/:
                return "STATE_LOADING";
            case STATE_LOADED /*1*/:
                return "STATE_LOADED";
            case STATE_ERROR /*2*/:
                return "STATE_ERROR";
            default:
                return "UNKNOWN";
        }
    }
}
