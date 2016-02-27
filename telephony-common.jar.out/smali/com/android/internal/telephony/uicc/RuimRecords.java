package com.android.internal.telephony.uicc;

import android.content.Context;
import android.content.res.Resources;
import android.os.AsyncResult;
import android.os.Message;
import android.os.SystemProperties;
import android.telephony.Rlog;
import android.telephony.SubscriptionManager;
import android.text.TextUtils;
import android.util.Log;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.MccTable;
import com.android.internal.telephony.SubscriptionController;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppType;
import com.android.internal.telephony.uicc.IccRecords.IccRecordLoaded;
import com.android.internal.util.BitwiseInputStream;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPart;
import com.google.android.mms.pdu.PduPersister;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Locale;

public final class RuimRecords extends IccRecords {
    private static final int EVENT_GET_ALL_SMS_DONE = 18;
    private static final int EVENT_GET_CDMA_SUBSCRIPTION_DONE = 10;
    private static final int EVENT_GET_DEVICE_IDENTITY_DONE = 4;
    private static final int EVENT_GET_ICCID_DONE = 5;
    private static final int EVENT_GET_IMSI_DONE = 3;
    private static final int EVENT_GET_SMS_DONE = 22;
    private static final int EVENT_GET_SST_DONE = 17;
    private static final int EVENT_MARK_SMS_READ_DONE = 19;
    private static final int EVENT_RUIM_REFRESH = 31;
    private static final int EVENT_SMS_ON_RUIM = 21;
    private static final int EVENT_UPDATE_DONE = 14;
    static final String LOG_TAG = "RuimRecords";
    boolean mCsimSpnDisplayCondition;
    private byte[] mEFli;
    private byte[] mEFpl;
    private String mHomeNetworkId;
    private String mHomeSystemId;
    private String mMdn;
    private String mMin;
    private String mMin2Min1;
    private String mMyMobileNumber;
    private String mNai;
    private boolean mOtaCommited;
    private String mPrlVersion;

    private class EfCsimCdmaHomeLoaded implements IccRecordLoaded {
        private EfCsimCdmaHomeLoaded() {
        }

        public String getEfName() {
            return "EF_CSIM_CDMAHOME";
        }

        public void onRecordLoaded(AsyncResult ar) {
            ArrayList<byte[]> dataList = ar.result;
            RuimRecords.this.log("CSIM_CDMAHOME data size=" + dataList.size());
            if (!dataList.isEmpty()) {
                StringBuilder sidBuf = new StringBuilder();
                StringBuilder nidBuf = new StringBuilder();
                Iterator i$ = dataList.iterator();
                while (i$.hasNext()) {
                    byte[] data = (byte[]) i$.next();
                    if (data.length == RuimRecords.EVENT_GET_ICCID_DONE) {
                        int nid = ((data[RuimRecords.EVENT_GET_IMSI_DONE] & PduHeaders.STORE_STATUS_ERROR_END) << 8) | (data[2] & PduHeaders.STORE_STATUS_ERROR_END);
                        sidBuf.append(((data[1] & PduHeaders.STORE_STATUS_ERROR_END) << 8) | (data[0] & PduHeaders.STORE_STATUS_ERROR_END)).append(',');
                        nidBuf.append(nid).append(',');
                    }
                }
                sidBuf.setLength(sidBuf.length() - 1);
                nidBuf.setLength(nidBuf.length() - 1);
                RuimRecords.this.mHomeSystemId = sidBuf.toString();
                RuimRecords.this.mHomeNetworkId = nidBuf.toString();
            }
        }
    }

    private class EfCsimEprlLoaded implements IccRecordLoaded {
        private EfCsimEprlLoaded() {
        }

        public String getEfName() {
            return "EF_CSIM_EPRL";
        }

        public void onRecordLoaded(AsyncResult ar) {
            RuimRecords.this.onGetCSimEprlDone(ar);
        }
    }

    private class EfCsimImsimLoaded implements IccRecordLoaded {
        private EfCsimImsimLoaded() {
        }

        public String getEfName() {
            return "EF_CSIM_IMSIM";
        }

        public void onRecordLoaded(AsyncResult ar) {
            boolean provisioned;
            byte[] data = (byte[]) ar.result;
            RuimRecords.this.log("CSIM_IMSIM=" + IccUtils.bytesToHexString(data));
            if ((data[7] & PduPart.P_Q) == PduPart.P_Q) {
                provisioned = true;
            } else {
                provisioned = false;
            }
            if (provisioned) {
                int first3digits = ((data[2] & RuimRecords.EVENT_GET_IMSI_DONE) << 8) + (data[1] & PduHeaders.STORE_STATUS_ERROR_END);
                int second3digits = (((data[RuimRecords.EVENT_GET_ICCID_DONE] & PduHeaders.STORE_STATUS_ERROR_END) << 8) | (data[RuimRecords.EVENT_GET_DEVICE_IDENTITY_DONE] & PduHeaders.STORE_STATUS_ERROR_END)) >> 6;
                int digit7 = (data[RuimRecords.EVENT_GET_DEVICE_IDENTITY_DONE] >> 2) & 15;
                if (digit7 > 9) {
                    digit7 = 0;
                }
                int last3digits = ((data[RuimRecords.EVENT_GET_DEVICE_IDENTITY_DONE] & RuimRecords.EVENT_GET_IMSI_DONE) << 8) | (data[RuimRecords.EVENT_GET_IMSI_DONE] & PduHeaders.STORE_STATUS_ERROR_END);
                first3digits = RuimRecords.this.adjstMinDigits(first3digits);
                second3digits = RuimRecords.this.adjstMinDigits(second3digits);
                last3digits = RuimRecords.this.adjstMinDigits(last3digits);
                StringBuilder builder = new StringBuilder();
                builder.append(String.format(Locale.US, "%03d", new Object[]{Integer.valueOf(first3digits)}));
                builder.append(String.format(Locale.US, "%03d", new Object[]{Integer.valueOf(second3digits)}));
                builder.append(String.format(Locale.US, "%d", new Object[]{Integer.valueOf(digit7)}));
                builder.append(String.format(Locale.US, "%03d", new Object[]{Integer.valueOf(last3digits)}));
                RuimRecords.this.mMin = builder.toString();
                RuimRecords.this.log("min present=" + RuimRecords.this.mMin);
                return;
            }
            RuimRecords.this.log("min not present");
        }
    }

    private class EfCsimLiLoaded implements IccRecordLoaded {
        private EfCsimLiLoaded() {
        }

        public String getEfName() {
            return "EF_CSIM_LI";
        }

        public void onRecordLoaded(AsyncResult ar) {
            RuimRecords.this.mEFli = (byte[]) ar.result;
            for (int i = 0; i < RuimRecords.this.mEFli.length; i += 2) {
                switch (RuimRecords.this.mEFli[i + 1]) {
                    case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                        RuimRecords.this.mEFli[i] = (byte) 101;
                        RuimRecords.this.mEFli[i + 1] = (byte) 110;
                        break;
                    case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                        RuimRecords.this.mEFli[i] = (byte) 102;
                        RuimRecords.this.mEFli[i + 1] = (byte) 114;
                        break;
                    case RuimRecords.EVENT_GET_IMSI_DONE /*3*/:
                        RuimRecords.this.mEFli[i] = (byte) 101;
                        RuimRecords.this.mEFli[i + 1] = (byte) 115;
                        break;
                    case RuimRecords.EVENT_GET_DEVICE_IDENTITY_DONE /*4*/:
                        RuimRecords.this.mEFli[i] = (byte) 106;
                        RuimRecords.this.mEFli[i + 1] = (byte) 97;
                        break;
                    case RuimRecords.EVENT_GET_ICCID_DONE /*5*/:
                        RuimRecords.this.mEFli[i] = (byte) 107;
                        RuimRecords.this.mEFli[i + 1] = (byte) 111;
                        break;
                    case CharacterSets.ISO_8859_3 /*6*/:
                        RuimRecords.this.mEFli[i] = (byte) 122;
                        RuimRecords.this.mEFli[i + 1] = (byte) 104;
                        break;
                    case CharacterSets.ISO_8859_4 /*7*/:
                        RuimRecords.this.mEFli[i] = (byte) 104;
                        RuimRecords.this.mEFli[i + 1] = (byte) 101;
                        break;
                    default:
                        RuimRecords.this.mEFli[i] = (byte) 32;
                        RuimRecords.this.mEFli[i + 1] = (byte) 32;
                        break;
                }
            }
            RuimRecords.this.log("EF_LI=" + IccUtils.bytesToHexString(RuimRecords.this.mEFli));
        }
    }

    private class EfCsimMdnLoaded implements IccRecordLoaded {
        private EfCsimMdnLoaded() {
        }

        public String getEfName() {
            return "EF_CSIM_MDN";
        }

        public void onRecordLoaded(AsyncResult ar) {
            byte[] data = (byte[]) ar.result;
            RuimRecords.this.log("CSIM_MDN=" + IccUtils.bytesToHexString(data));
            RuimRecords.this.mMdn = IccUtils.cdmaBcdToString(data, 1, data[0] & 15);
            RuimRecords.this.log("CSIM MDN=" + RuimRecords.this.mMdn);
        }
    }

    private class EfCsimMipUppLoaded implements IccRecordLoaded {
        private EfCsimMipUppLoaded() {
        }

        public String getEfName() {
            return "EF_CSIM_MIPUPP";
        }

        boolean checkLengthLegal(int length, int expectLength) {
            if (length >= expectLength) {
                return true;
            }
            Log.e(RuimRecords.LOG_TAG, "CSIM MIPUPP format error, length = " + length + "expected length at least =" + expectLength);
            return false;
        }

        public void onRecordLoaded(AsyncResult ar) {
            byte[] data = (byte[]) ar.result;
            if (data.length < 1) {
                Log.e(RuimRecords.LOG_TAG, "MIPUPP read error");
                return;
            }
            BitwiseInputStream bitStream = new BitwiseInputStream(data);
            try {
                int mipUppLength = bitStream.read(8) << RuimRecords.EVENT_GET_IMSI_DONE;
                if (checkLengthLegal(mipUppLength, 1)) {
                    mipUppLength--;
                    if (bitStream.read(1) == 1) {
                        if (checkLengthLegal(mipUppLength, 11)) {
                            bitStream.skip(11);
                            mipUppLength -= 11;
                        } else {
                            return;
                        }
                    }
                    if (checkLengthLegal(mipUppLength, RuimRecords.EVENT_GET_DEVICE_IDENTITY_DONE)) {
                        int numNai = bitStream.read(RuimRecords.EVENT_GET_DEVICE_IDENTITY_DONE);
                        mipUppLength -= 4;
                        int index = 0;
                        while (index < numNai && checkLengthLegal(mipUppLength, RuimRecords.EVENT_GET_DEVICE_IDENTITY_DONE)) {
                            int naiEntryIndex = bitStream.read(RuimRecords.EVENT_GET_DEVICE_IDENTITY_DONE);
                            mipUppLength -= 4;
                            if (checkLengthLegal(mipUppLength, 8)) {
                                int naiLength = bitStream.read(8);
                                mipUppLength -= 8;
                                if (naiEntryIndex == 0) {
                                    if (checkLengthLegal(mipUppLength, naiLength << RuimRecords.EVENT_GET_IMSI_DONE)) {
                                        char[] naiCharArray = new char[naiLength];
                                        for (int index1 = 0; index1 < naiLength; index1++) {
                                            naiCharArray[index1] = (char) (bitStream.read(8) & PduHeaders.STORE_STATUS_ERROR_END);
                                        }
                                        RuimRecords.this.mNai = new String(naiCharArray);
                                        if (Log.isLoggable(RuimRecords.LOG_TAG, 2)) {
                                            Log.v(RuimRecords.LOG_TAG, "MIPUPP Nai = " + RuimRecords.this.mNai);
                                            return;
                                        }
                                        return;
                                    }
                                    return;
                                } else if (checkLengthLegal(mipUppLength, (naiLength << RuimRecords.EVENT_GET_IMSI_DONE) + 102)) {
                                    bitStream.skip((naiLength << RuimRecords.EVENT_GET_IMSI_DONE) + 101);
                                    mipUppLength -= (naiLength << RuimRecords.EVENT_GET_IMSI_DONE) + 102;
                                    if (bitStream.read(1) == 1) {
                                        if (checkLengthLegal(mipUppLength, 32)) {
                                            bitStream.skip(32);
                                            mipUppLength -= 32;
                                        } else {
                                            return;
                                        }
                                    }
                                    if (checkLengthLegal(mipUppLength, RuimRecords.EVENT_GET_ICCID_DONE)) {
                                        bitStream.skip(RuimRecords.EVENT_GET_DEVICE_IDENTITY_DONE);
                                        mipUppLength = (mipUppLength - 4) - 1;
                                        if (bitStream.read(1) == 1) {
                                            if (checkLengthLegal(mipUppLength, 32)) {
                                                bitStream.skip(32);
                                                mipUppLength -= 32;
                                            } else {
                                                return;
                                            }
                                        }
                                        index++;
                                    } else {
                                        return;
                                    }
                                } else {
                                    return;
                                }
                            }
                            return;
                        }
                    }
                }
            } catch (Exception e) {
                Log.e(RuimRecords.LOG_TAG, "MIPUPP read Exception error!");
            }
        }
    }

    private class EfCsimSpnLoaded implements IccRecordLoaded {
        private EfCsimSpnLoaded() {
        }

        public String getEfName() {
            return "EF_CSIM_SPN";
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onRecordLoaded(android.os.AsyncResult r14) {
            /*
            r13 = this;
            r9 = 1;
            r4 = 32;
            r10 = 0;
            r8 = r14.result;
            r8 = (byte[]) r8;
            r0 = r8;
            r0 = (byte[]) r0;
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;
            r11 = new java.lang.StringBuilder;
            r11.<init>();
            r12 = "CSIM_SPN=";
            r11 = r11.append(r12);
            r12 = com.android.internal.telephony.uicc.IccUtils.bytesToHexString(r0);
            r11 = r11.append(r12);
            r11 = r11.toString();
            r8.log(r11);
            r11 = com.android.internal.telephony.uicc.RuimRecords.this;
            r8 = r0[r10];
            r8 = r8 & 1;
            if (r8 == 0) goto L_0x005b;
        L_0x002f:
            r8 = r9;
        L_0x0030:
            r11.mCsimSpnDisplayCondition = r8;
            r2 = r0[r9];
            r8 = 2;
            r3 = r0[r8];
            r7 = new byte[r4];
            r8 = r0.length;
            r8 = r8 + -3;
            if (r8 >= r4) goto L_0x0041;
        L_0x003e:
            r8 = r0.length;
            r4 = r8 + -3;
        L_0x0041:
            r8 = 3;
            java.lang.System.arraycopy(r0, r8, r7, r10, r4);
            r5 = 0;
        L_0x0046:
            r8 = r7.length;
            if (r5 >= r8) goto L_0x0051;
        L_0x0049:
            r8 = r7[r5];
            r8 = r8 & 255;
            r9 = 255; // 0xff float:3.57E-43 double:1.26E-321;
            if (r8 != r9) goto L_0x005d;
        L_0x0051:
            if (r5 != 0) goto L_0x0060;
        L_0x0053:
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;
            r9 = "";
            r8.setServiceProviderName(r9);
        L_0x005a:
            return;
        L_0x005b:
            r8 = r10;
            goto L_0x0030;
        L_0x005d:
            r5 = r5 + 1;
            goto L_0x0046;
        L_0x0060:
            switch(r2) {
                case 0: goto L_0x00ba;
                case 1: goto L_0x0063;
                case 2: goto L_0x00f2;
                case 3: goto L_0x00e2;
                case 4: goto L_0x0136;
                case 5: goto L_0x0063;
                case 6: goto L_0x0063;
                case 7: goto L_0x0063;
                case 8: goto L_0x00ba;
                case 9: goto L_0x00e2;
                default: goto L_0x0063;
            };
        L_0x0063:
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;	 Catch:{ Exception -> 0x00c8 }
            r9 = "SPN encoding not supported";
            r8.log(r9);	 Catch:{ Exception -> 0x00c8 }
        L_0x006a:
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;
            r9 = new java.lang.StringBuilder;
            r9.<init>();
            r10 = "spn=";
            r9 = r9.append(r10);
            r10 = com.android.internal.telephony.uicc.RuimRecords.this;
            r10 = r10.getServiceProviderName();
            r9 = r9.append(r10);
            r9 = r9.toString();
            r8.log(r9);
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;
            r9 = new java.lang.StringBuilder;
            r9.<init>();
            r10 = "spnCondition=";
            r9 = r9.append(r10);
            r10 = com.android.internal.telephony.uicc.RuimRecords.this;
            r10 = r10.mCsimSpnDisplayCondition;
            r9 = r9.append(r10);
            r9 = r9.toString();
            r8.log(r9);
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;
            r8 = r8.mTelephonyManager;
            r9 = com.android.internal.telephony.uicc.RuimRecords.this;
            r9 = r9.mParentApp;
            r9 = r9.getPhoneId();
            r10 = com.android.internal.telephony.uicc.RuimRecords.this;
            r10 = r10.getServiceProviderName();
            r8.setSimOperatorNameForPhone(r9, r10);
            goto L_0x005a;
        L_0x00ba:
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;	 Catch:{ Exception -> 0x00c8 }
            r9 = new java.lang.String;	 Catch:{ Exception -> 0x00c8 }
            r10 = 0;
            r11 = "ISO-8859-1";
            r9.<init>(r7, r10, r5, r11);	 Catch:{ Exception -> 0x00c8 }
            r8.setServiceProviderName(r9);	 Catch:{ Exception -> 0x00c8 }
            goto L_0x006a;
        L_0x00c8:
            r1 = move-exception;
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;
            r9 = new java.lang.StringBuilder;
            r9.<init>();
            r10 = "spn decode error: ";
            r9 = r9.append(r10);
            r9 = r9.append(r1);
            r9 = r9.toString();
            r8.log(r9);
            goto L_0x006a;
        L_0x00e2:
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;	 Catch:{ Exception -> 0x00c8 }
            r9 = 0;
            r10 = r5 * 8;
            r10 = r10 / 7;
            r9 = com.android.internal.telephony.GsmAlphabet.gsm7BitPackedToString(r7, r9, r10);	 Catch:{ Exception -> 0x00c8 }
            r8.setServiceProviderName(r9);	 Catch:{ Exception -> 0x00c8 }
            goto L_0x006a;
        L_0x00f2:
            r6 = new java.lang.String;	 Catch:{ Exception -> 0x00c8 }
            r8 = 0;
            r9 = "US-ASCII";
            r6.<init>(r7, r8, r5, r9);	 Catch:{ Exception -> 0x00c8 }
            r8 = android.text.TextUtils.isPrintableAsciiOnly(r6);	 Catch:{ Exception -> 0x00c8 }
            if (r8 == 0) goto L_0x0107;
        L_0x0100:
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;	 Catch:{ Exception -> 0x00c8 }
            r8.setServiceProviderName(r6);	 Catch:{ Exception -> 0x00c8 }
            goto L_0x006a;
        L_0x0107:
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;	 Catch:{ Exception -> 0x00c8 }
            r9 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x00c8 }
            r9.<init>();	 Catch:{ Exception -> 0x00c8 }
            r10 = "Some corruption in SPN decoding = ";
            r9 = r9.append(r10);	 Catch:{ Exception -> 0x00c8 }
            r9 = r9.append(r6);	 Catch:{ Exception -> 0x00c8 }
            r9 = r9.toString();	 Catch:{ Exception -> 0x00c8 }
            r8.log(r9);	 Catch:{ Exception -> 0x00c8 }
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;	 Catch:{ Exception -> 0x00c8 }
            r9 = "Using ENCODING_GSM_7BIT_ALPHABET scheme...";
            r8.log(r9);	 Catch:{ Exception -> 0x00c8 }
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;	 Catch:{ Exception -> 0x00c8 }
            r9 = 0;
            r10 = r5 * 8;
            r10 = r10 / 7;
            r9 = com.android.internal.telephony.GsmAlphabet.gsm7BitPackedToString(r7, r9, r10);	 Catch:{ Exception -> 0x00c8 }
            r8.setServiceProviderName(r9);	 Catch:{ Exception -> 0x00c8 }
            goto L_0x006a;
        L_0x0136:
            r8 = com.android.internal.telephony.uicc.RuimRecords.this;	 Catch:{ Exception -> 0x00c8 }
            r9 = new java.lang.String;	 Catch:{ Exception -> 0x00c8 }
            r10 = 0;
            r11 = "utf-16";
            r9.<init>(r7, r10, r5, r11);	 Catch:{ Exception -> 0x00c8 }
            r8.setServiceProviderName(r9);	 Catch:{ Exception -> 0x00c8 }
            goto L_0x006a;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.uicc.RuimRecords.EfCsimSpnLoaded.onRecordLoaded(android.os.AsyncResult):void");
        }
    }

    private class EfPlLoaded implements IccRecordLoaded {
        private EfPlLoaded() {
        }

        public String getEfName() {
            return "EF_PL";
        }

        public void onRecordLoaded(AsyncResult ar) {
            RuimRecords.this.mEFpl = (byte[]) ar.result;
            RuimRecords.this.log("EF_PL=" + IccUtils.bytesToHexString(RuimRecords.this.mEFpl));
        }
    }

    public String toString() {
        return "RuimRecords: " + super.toString() + " m_ota_commited" + this.mOtaCommited + " mMyMobileNumber=" + "xxxx" + " mMin2Min1=" + this.mMin2Min1 + " mPrlVersion=" + this.mPrlVersion + " mEFpl=" + this.mEFpl + " mEFli=" + this.mEFli + " mCsimSpnDisplayCondition=" + this.mCsimSpnDisplayCondition + " mMdn=" + this.mMdn + " mMin=" + this.mMin + " mHomeSystemId=" + this.mHomeSystemId + " mHomeNetworkId=" + this.mHomeNetworkId;
    }

    public RuimRecords(UiccCardApplication app, Context c, CommandsInterface ci) {
        super(app, c, ci);
        this.mOtaCommited = false;
        this.mEFpl = null;
        this.mEFli = null;
        this.mCsimSpnDisplayCondition = false;
        this.mAdnCache = new AdnRecordCache(this.mFh);
        this.mRecordsRequested = false;
        this.mRecordsToLoad = 0;
        this.mCi.registerForIccRefresh(this, EVENT_RUIM_REFRESH, null);
        resetRecords();
        this.mParentApp.registerForReady(this, 1, null);
        log("RuimRecords X ctor this=" + this);
    }

    public void dispose() {
        log("Disposing RuimRecords " + this);
        this.mCi.unregisterForIccRefresh(this);
        this.mParentApp.unregisterForReady(this);
        resetRecords();
        super.dispose();
    }

    protected void finalize() {
        log("RuimRecords finalized");
    }

    protected void resetRecords() {
        this.mMncLength = -1;
        log("setting0 mMncLength" + this.mMncLength);
        this.mIccId = null;
        this.mAdnCache.reset();
        this.mRecordsRequested = false;
    }

    public String getIMSI() {
        return this.mImsi;
    }

    public String getMdnNumber() {
        return this.mMyMobileNumber;
    }

    public String getCdmaMin() {
        return this.mMin2Min1;
    }

    public String getPrlVersion() {
        return this.mPrlVersion;
    }

    public String getNAI() {
        return this.mNai;
    }

    public void setVoiceMailNumber(String alphaTag, String voiceNumber, Message onComplete) {
        AsyncResult.forMessage(onComplete).exception = new IccException("setVoiceMailNumber not implemented");
        onComplete.sendToTarget();
        loge("method setVoiceMailNumber is not implemented");
    }

    public void onRefresh(boolean fileChanged, int[] fileList) {
        if (fileChanged) {
            fetchRuimRecords();
        }
    }

    private int adjstMinDigits(int digits) {
        digits += 111;
        if (digits % EVENT_GET_CDMA_SUBSCRIPTION_DONE == 0) {
            digits -= 10;
        }
        if ((digits / EVENT_GET_CDMA_SUBSCRIPTION_DONE) % EVENT_GET_CDMA_SUBSCRIPTION_DONE == 0) {
            digits -= 100;
        }
        if ((digits / 100) % EVENT_GET_CDMA_SUBSCRIPTION_DONE == 0) {
            return digits - 1000;
        }
        return digits;
    }

    public String getRUIMOperatorNumeric() {
        if (this.mImsi == null) {
            return null;
        }
        if (SystemProperties.getBoolean("ro.telephony.get_imsi_from_sim", false)) {
            String imsi = this.mParentApp.getUICCConfig().getImsi();
            int mnclength = this.mParentApp.getUICCConfig().getMncLength();
            if (imsi != null) {
                log("Overriding with Operator Numeric: " + imsi.substring(0, mnclength + EVENT_GET_IMSI_DONE));
                return imsi.substring(0, mnclength + EVENT_GET_IMSI_DONE);
            }
        }
        if (this.mMncLength != -1 && this.mMncLength != 0) {
            return this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE);
        }
        return this.mImsi.substring(0, MccTable.smallestDigitsMccForMnc(Integer.parseInt(this.mImsi.substring(0, EVENT_GET_IMSI_DONE))) + EVENT_GET_IMSI_DONE);
    }

    private void onGetCSimEprlDone(AsyncResult ar) {
        byte[] data = (byte[]) ar.result;
        log("CSIM_EPRL=" + IccUtils.bytesToHexString(data));
        if (data.length > EVENT_GET_IMSI_DONE) {
            this.mPrlVersion = Integer.toString(((data[2] & PduHeaders.STORE_STATUS_ERROR_END) << 8) | (data[EVENT_GET_IMSI_DONE] & PduHeaders.STORE_STATUS_ERROR_END));
        }
        log("CSIM PRL version=" + this.mPrlVersion);
    }

    public void handleMessage(Message msg) {
        boolean isRecordLoadResponse = false;
        if (this.mDestroyed.get()) {
            loge("Received message " + msg + "[" + msg.what + "] while being destroyed. Ignoring.");
            return;
        }
        try {
            AsyncResult ar;
            switch (msg.what) {
                case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                    onReady();
                    break;
                case EVENT_GET_IMSI_DONE /*3*/:
                    isRecordLoadResponse = true;
                    ar = msg.obj;
                    if (ar.exception == null) {
                        this.mImsi = (String) ar.result;
                        if (this.mImsi != null && (this.mImsi.length() < 6 || this.mImsi.length() > 15)) {
                            loge("invalid IMSI " + this.mImsi);
                            this.mImsi = null;
                        }
                        log("NO update mccmnc=" + getRUIMOperatorNumeric());
                        break;
                    }
                    loge("Exception querying IMSI, Exception:" + ar.exception);
                    break;
                case EVENT_GET_DEVICE_IDENTITY_DONE /*4*/:
                    log("Event EVENT_GET_DEVICE_IDENTITY_DONE Received");
                    break;
                case EVENT_GET_ICCID_DONE /*5*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    byte[] data = (byte[]) ar.result;
                    if (ar.exception == null) {
                        this.mIccId = IccUtils.bcdToString(data, 0, data.length);
                        log("iccid: " + this.mIccId);
                        break;
                    }
                    break;
                case EVENT_GET_CDMA_SUBSCRIPTION_DONE /*10*/:
                    ar = (AsyncResult) msg.obj;
                    String[] localTemp = (String[]) ar.result;
                    if (ar.exception == null) {
                        this.mMyMobileNumber = localTemp[0];
                        this.mMin2Min1 = localTemp[EVENT_GET_IMSI_DONE];
                        this.mPrlVersion = localTemp[EVENT_GET_DEVICE_IDENTITY_DONE];
                        log("MDN: " + this.mMyMobileNumber + " MIN: " + this.mMin2Min1);
                        break;
                    }
                    break;
                case EVENT_UPDATE_DONE /*14*/:
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception != null) {
                        Rlog.i(LOG_TAG, "RuimRecords update failed", ar.exception);
                        break;
                    }
                    break;
                case EVENT_GET_SST_DONE /*17*/:
                    log("Event EVENT_GET_SST_DONE Received");
                    break;
                case EVENT_GET_ALL_SMS_DONE /*18*/:
                case EVENT_MARK_SMS_READ_DONE /*19*/:
                case EVENT_SMS_ON_RUIM /*21*/:
                case EVENT_GET_SMS_DONE /*22*/:
                    Rlog.w(LOG_TAG, "Event not supported: " + msg.what);
                    break;
                case EVENT_RUIM_REFRESH /*31*/:
                    isRecordLoadResponse = false;
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        handleRuimRefresh((IccRefreshResponse) ar.result);
                        break;
                    }
                    break;
                default:
                    super.handleMessage(msg);
                    break;
            }
            if (isRecordLoadResponse) {
                onRecordLoaded();
            }
        } catch (RuntimeException exc) {
            Rlog.w(LOG_TAG, "Exception parsing RUIM record", exc);
            if (isRecordLoadResponse) {
                onRecordLoaded();
            }
        } catch (Throwable th) {
            if (isRecordLoadResponse) {
                onRecordLoaded();
            }
        }
    }

    private static String[] getAssetLanguages(Context ctx) {
        String[] locales = ctx.getAssets().getLocales();
        String[] localeLangs = new String[locales.length];
        for (int i = 0; i < locales.length; i++) {
            String localeStr = locales[i];
            int separator = localeStr.indexOf(45);
            if (separator < 0) {
                localeLangs[i] = localeStr;
            } else {
                localeLangs[i] = localeStr.substring(0, separator);
            }
        }
        return localeLangs;
    }

    private String findBestLanguage(byte[] languages) {
        String[] assetLanguages = getAssetLanguages(this.mContext);
        if (languages == null || assetLanguages == null) {
            return null;
        }
        for (int i = 0; i + 1 < languages.length; i += 2) {
            try {
                String lang = new String(languages, i, 2, "ISO-8859-1");
                for (String equals : assetLanguages) {
                    if (equals.equals(lang)) {
                        return lang;
                    }
                }
                continue;
            } catch (UnsupportedEncodingException e) {
                log("Failed to parse SIM language records");
            }
        }
        return null;
    }

    private void setLocaleFromCsim() {
        String prefLang = findBestLanguage(this.mEFli);
        if (prefLang == null) {
            prefLang = findBestLanguage(this.mEFpl);
        }
        if (prefLang != null) {
            String imsi = getIMSI();
            String country = null;
            if (imsi != null) {
                country = MccTable.countryCodeForMcc(Integer.parseInt(imsi.substring(0, EVENT_GET_IMSI_DONE)));
            }
            log("Setting locale to " + prefLang + "_" + country);
            MccTable.setSystemLocale(this.mContext, prefLang, country);
            return;
        }
        log("No suitable CSIM selected locale");
    }

    protected void onRecordLoaded() {
        this.mRecordsToLoad--;
        log("onRecordLoaded " + this.mRecordsToLoad + " requested: " + this.mRecordsRequested);
        if (this.mRecordsToLoad == 0 && this.mRecordsRequested) {
            onAllRecordsLoaded();
        } else if (this.mRecordsToLoad < 0) {
            loge("recordsToLoad <0, programmer error suspected");
            this.mRecordsToLoad = 0;
        }
    }

    protected void onAllRecordsLoaded() {
        log("record load complete");
        setLocaleFromCsim();
        this.mRecordsLoadedRegistrants.notifyRegistrants(new AsyncResult(null, null, null));
        if (!TextUtils.isEmpty(this.mMdn)) {
            int[] subIds = SubscriptionController.getInstance().getSubId(this.mParentApp.getUiccCard().getPhoneId());
            if (subIds != null) {
                SubscriptionManager.from(this.mContext).setDisplayNumber(this.mMdn, subIds[0]);
            } else {
                log("Cannot call setDisplayNumber: invalid subId");
            }
        }
    }

    public void onReady() {
        fetchRuimRecords();
        this.mCi.getCDMASubscription(obtainMessage(EVENT_GET_CDMA_SUBSCRIPTION_DONE));
    }

    private void fetchRuimRecords() {
        this.mRecordsRequested = true;
        log("fetchRuimRecords " + this.mRecordsToLoad);
        this.mCi.getIMSIForApp(this.mParentApp.getAid(), obtainMessage(EVENT_GET_IMSI_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_ICCID, obtainMessage(EVENT_GET_ICCID_DONE));
        this.mRecordsToLoad++;
        if (Resources.getSystem().getBoolean(17957012)) {
            this.mFh.loadEFTransparent(IccConstants.EF_PL, obtainMessage(100, new EfPlLoaded()));
            this.mRecordsToLoad++;
            this.mFh.loadEFTransparent(IccConstants.EF_CSIM_LI, obtainMessage(100, new EfCsimLiLoaded()));
            this.mRecordsToLoad++;
        }
        this.mFh.loadEFTransparent(IccConstants.EF_RUIM_SPN, obtainMessage(100, new EfCsimSpnLoaded()));
        this.mRecordsToLoad++;
        this.mFh.loadEFLinearFixed(IccConstants.EF_CSIM_MDN, 1, obtainMessage(100, new EfCsimMdnLoaded()));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_CSIM_IMSIM, obtainMessage(100, new EfCsimImsimLoaded()));
        this.mRecordsToLoad++;
        this.mFh.loadEFLinearFixedAll(IccConstants.EF_CSIM_CDMAHOME, obtainMessage(100, new EfCsimCdmaHomeLoaded()));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_CSIM_EPRL, EVENT_GET_DEVICE_IDENTITY_DONE, obtainMessage(100, new EfCsimEprlLoaded()));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_CSIM_MIPUPP, obtainMessage(100, new EfCsimMipUppLoaded()));
        this.mRecordsToLoad++;
        log("fetchRuimRecords " + this.mRecordsToLoad + " requested: " + this.mRecordsRequested);
    }

    public int getDisplayRule(String plmn) {
        return 0;
    }

    public boolean isProvisioned() {
        if (SystemProperties.getBoolean("persist.radio.test-csim", false)) {
            return true;
        }
        if (this.mParentApp == null) {
            return false;
        }
        if (this.mParentApp.getType() != AppType.APPTYPE_CSIM) {
            return true;
        }
        if (this.mMdn == null || this.mMin == null) {
            return false;
        }
        return true;
    }

    public void setVoiceMessageWaiting(int line, int countWaiting) {
        log("RuimRecords:setVoiceMessageWaiting - NOP for CDMA");
    }

    public int getVoiceMessageCount() {
        log("RuimRecords:getVoiceMessageCount - NOP for CDMA");
        return 0;
    }

    private void handleRuimRefresh(IccRefreshResponse refreshResponse) {
        if (refreshResponse == null) {
            log("handleRuimRefresh received without input");
        } else if (refreshResponse.aid == null || refreshResponse.aid.equals(this.mParentApp.getAid())) {
            switch (refreshResponse.refreshResult) {
                case CharacterSets.ANY_CHARSET /*0*/:
                    log("handleRuimRefresh with SIM_REFRESH_FILE_UPDATED");
                    this.mAdnCache.reset();
                    fetchRuimRecords();
                case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                    log("handleRuimRefresh with SIM_REFRESH_INIT");
                    onIccRefreshInit();
                case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                    log("handleRuimRefresh with SIM_REFRESH_RESET");
                default:
                    log("handleRuimRefresh with unknown operation");
            }
        }
    }

    public String getMdn() {
        return this.mMdn;
    }

    public String getMin() {
        return this.mMin;
    }

    public String getSid() {
        return this.mHomeSystemId;
    }

    public String getNid() {
        return this.mHomeNetworkId;
    }

    public boolean getCsimSpnDisplayCondition() {
        return this.mCsimSpnDisplayCondition;
    }

    protected void log(String s) {
        Rlog.d(LOG_TAG, "[RuimRecords] " + s);
    }

    protected void loge(String s) {
        Rlog.e(LOG_TAG, "[RuimRecords] " + s);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("RuimRecords: " + this);
        pw.println(" extends:");
        super.dump(fd, pw, args);
        pw.println(" mOtaCommited=" + this.mOtaCommited);
        pw.println(" mMyMobileNumber=" + this.mMyMobileNumber);
        pw.println(" mMin2Min1=" + this.mMin2Min1);
        pw.println(" mPrlVersion=" + this.mPrlVersion);
        pw.println(" mEFpl[]=" + Arrays.toString(this.mEFpl));
        pw.println(" mEFli[]=" + Arrays.toString(this.mEFli));
        pw.println(" mCsimSpnDisplayCondition=" + this.mCsimSpnDisplayCondition);
        pw.println(" mMdn=" + this.mMdn);
        pw.println(" mMin=" + this.mMin);
        pw.println(" mHomeSystemId=" + this.mHomeSystemId);
        pw.println(" mHomeNetworkId=" + this.mHomeNetworkId);
        pw.flush();
    }
}
