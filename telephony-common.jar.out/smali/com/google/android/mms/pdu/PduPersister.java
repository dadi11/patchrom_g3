package com.google.android.mms.pdu;

import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.DatabaseUtils;
import android.database.sqlite.SQLiteException;
import android.drm.DrmManagerClient;
import android.net.Uri;
import android.net.Uri.Builder;
import android.provider.Telephony.BaseMmsColumns;
import android.provider.Telephony.Mms;
import android.provider.Telephony.Mms.Addr;
import android.provider.Telephony.Mms.Draft;
import android.provider.Telephony.Mms.Inbox;
import android.provider.Telephony.Mms.Outbox;
import android.provider.Telephony.Mms.Part;
import android.provider.Telephony.Mms.Sent;
import android.provider.Telephony.MmsSms.PendingMessages;
import android.provider.Telephony.TextBasedSmsColumns;
import android.provider.Telephony.Threads;
import android.provider.Telephony.ThreadsColumns;
import android.telephony.PhoneNumberUtils;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Log;
import com.android.internal.telephony.HbpcdLookup;
import com.android.internal.telephony.gsm.SmsCbConstants;
import com.google.android.mms.ContentType;
import com.google.android.mms.InvalidHeaderValueException;
import com.google.android.mms.MmsException;
import com.google.android.mms.util.DownloadDrmHelper;
import com.google.android.mms.util.DrmConvertSession;
import com.google.android.mms.util.PduCache;
import com.google.android.mms.util.PduCacheEntry;
import com.google.android.mms.util.SqliteWrapper;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map.Entry;
import java.util.Set;

public class PduPersister {
    static final /* synthetic */ boolean $assertionsDisabled;
    private static final int[] ADDRESS_FIELDS;
    private static final HashMap<Integer, Integer> CHARSET_COLUMN_INDEX_MAP;
    private static final HashMap<Integer, String> CHARSET_COLUMN_NAME_MAP;
    private static final boolean DEBUG = false;
    private static final long DUMMY_THREAD_ID = Long.MAX_VALUE;
    private static final HashMap<Integer, Integer> ENCODED_STRING_COLUMN_INDEX_MAP;
    private static final HashMap<Integer, String> ENCODED_STRING_COLUMN_NAME_MAP;
    private static final boolean LOCAL_LOGV = false;
    private static final HashMap<Integer, Integer> LONG_COLUMN_INDEX_MAP;
    private static final HashMap<Integer, String> LONG_COLUMN_NAME_MAP;
    private static final HashMap<Uri, Integer> MESSAGE_BOX_MAP;
    private static final HashMap<Integer, Integer> OCTET_COLUMN_INDEX_MAP;
    private static final HashMap<Integer, String> OCTET_COLUMN_NAME_MAP;
    private static final int PART_COLUMN_CHARSET = 1;
    private static final int PART_COLUMN_CONTENT_DISPOSITION = 2;
    private static final int PART_COLUMN_CONTENT_ID = 3;
    private static final int PART_COLUMN_CONTENT_LOCATION = 4;
    private static final int PART_COLUMN_CONTENT_TYPE = 5;
    private static final int PART_COLUMN_FILENAME = 6;
    private static final int PART_COLUMN_ID = 0;
    private static final int PART_COLUMN_NAME = 7;
    private static final int PART_COLUMN_TEXT = 8;
    private static final String[] PART_PROJECTION;
    private static final PduCache PDU_CACHE_INSTANCE;
    private static final int PDU_COLUMN_CONTENT_CLASS = 11;
    private static final int PDU_COLUMN_CONTENT_LOCATION = 5;
    private static final int PDU_COLUMN_CONTENT_TYPE = 6;
    private static final int PDU_COLUMN_DATE = 21;
    private static final int PDU_COLUMN_DELIVERY_REPORT = 12;
    private static final int PDU_COLUMN_DELIVERY_TIME = 22;
    private static final int PDU_COLUMN_EXPIRY = 23;
    private static final int PDU_COLUMN_ID = 0;
    private static final int PDU_COLUMN_MESSAGE_BOX = 1;
    private static final int PDU_COLUMN_MESSAGE_CLASS = 7;
    private static final int PDU_COLUMN_MESSAGE_ID = 8;
    private static final int PDU_COLUMN_MESSAGE_SIZE = 24;
    private static final int PDU_COLUMN_MESSAGE_TYPE = 13;
    private static final int PDU_COLUMN_MMS_VERSION = 14;
    private static final int PDU_COLUMN_PRIORITY = 15;
    private static final int PDU_COLUMN_READ_REPORT = 16;
    private static final int PDU_COLUMN_READ_STATUS = 17;
    private static final int PDU_COLUMN_REPORT_ALLOWED = 18;
    private static final int PDU_COLUMN_RESPONSE_TEXT = 9;
    private static final int PDU_COLUMN_RETRIEVE_STATUS = 19;
    private static final int PDU_COLUMN_RETRIEVE_TEXT = 3;
    private static final int PDU_COLUMN_RETRIEVE_TEXT_CHARSET = 26;
    private static final int PDU_COLUMN_STATUS = 20;
    private static final int PDU_COLUMN_SUBJECT = 4;
    private static final int PDU_COLUMN_SUBJECT_CHARSET = 25;
    private static final int PDU_COLUMN_THREAD_ID = 2;
    private static final int PDU_COLUMN_TRANSACTION_ID = 10;
    private static final String[] PDU_PROJECTION;
    public static final int PROC_STATUS_COMPLETED = 3;
    public static final int PROC_STATUS_PERMANENTLY_FAILURE = 2;
    public static final int PROC_STATUS_TRANSIENT_FAILURE = 1;
    private static final String TAG = "PduPersister";
    public static final String TEMPORARY_DRM_OBJECT_URI = "content://mms/9223372036854775807/part";
    private static final HashMap<Integer, Integer> TEXT_STRING_COLUMN_INDEX_MAP;
    private static final HashMap<Integer, String> TEXT_STRING_COLUMN_NAME_MAP;
    private static PduPersister sPersister;
    private final ContentResolver mContentResolver;
    private final Context mContext;
    private final DrmManagerClient mDrmManagerClient;
    private final TelephonyManager mTelephonyManager;

    static {
        boolean z;
        if (PduPersister.class.desiredAssertionStatus()) {
            z = LOCAL_LOGV;
        } else {
            z = true;
        }
        $assertionsDisabled = z;
        ADDRESS_FIELDS = new int[]{PduPart.P_DISPOSITION_ATTACHMENT, PduPart.P_LEVEL, PduPart.P_CT_MR_TYPE, PduPart.P_NAME};
        PDU_PROJECTION = new String[]{HbpcdLookup.ID, BaseMmsColumns.MESSAGE_BOX, TextBasedSmsColumns.THREAD_ID, BaseMmsColumns.RETRIEVE_TEXT, BaseMmsColumns.SUBJECT, BaseMmsColumns.CONTENT_LOCATION, BaseMmsColumns.CONTENT_TYPE, BaseMmsColumns.MESSAGE_CLASS, BaseMmsColumns.MESSAGE_ID, BaseMmsColumns.RESPONSE_TEXT, BaseMmsColumns.TRANSACTION_ID, BaseMmsColumns.CONTENT_CLASS, BaseMmsColumns.DELIVERY_REPORT, BaseMmsColumns.MESSAGE_TYPE, BaseMmsColumns.MMS_VERSION, BaseMmsColumns.PRIORITY, BaseMmsColumns.READ_REPORT, BaseMmsColumns.READ_STATUS, BaseMmsColumns.REPORT_ALLOWED, BaseMmsColumns.RETRIEVE_STATUS, BaseMmsColumns.STATUS, ThreadsColumns.DATE, BaseMmsColumns.DELIVERY_TIME, BaseMmsColumns.EXPIRY, BaseMmsColumns.MESSAGE_SIZE, BaseMmsColumns.SUBJECT_CHARSET, BaseMmsColumns.RETRIEVE_TEXT_CHARSET};
        String[] strArr = new String[PDU_COLUMN_RESPONSE_TEXT];
        strArr[PDU_COLUMN_ID] = HbpcdLookup.ID;
        strArr[PROC_STATUS_TRANSIENT_FAILURE] = Part.CHARSET;
        strArr[PROC_STATUS_PERMANENTLY_FAILURE] = Part.CONTENT_DISPOSITION;
        strArr[PROC_STATUS_COMPLETED] = Part.CONTENT_ID;
        strArr[PDU_COLUMN_SUBJECT] = Part.CONTENT_LOCATION;
        strArr[PDU_COLUMN_CONTENT_LOCATION] = Part.CONTENT_TYPE;
        strArr[PDU_COLUMN_CONTENT_TYPE] = Part.FILENAME;
        strArr[PDU_COLUMN_MESSAGE_CLASS] = Part.NAME;
        strArr[PDU_COLUMN_MESSAGE_ID] = Part.TEXT;
        PART_PROJECTION = strArr;
        MESSAGE_BOX_MAP = new HashMap();
        MESSAGE_BOX_MAP.put(Inbox.CONTENT_URI, Integer.valueOf(PROC_STATUS_TRANSIENT_FAILURE));
        MESSAGE_BOX_MAP.put(Sent.CONTENT_URI, Integer.valueOf(PROC_STATUS_PERMANENTLY_FAILURE));
        MESSAGE_BOX_MAP.put(Draft.CONTENT_URI, Integer.valueOf(PROC_STATUS_COMPLETED));
        MESSAGE_BOX_MAP.put(Outbox.CONTENT_URI, Integer.valueOf(PDU_COLUMN_SUBJECT));
        CHARSET_COLUMN_INDEX_MAP = new HashMap();
        CHARSET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_SIZE), Integer.valueOf(PDU_COLUMN_SUBJECT_CHARSET));
        CHARSET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_START_INFO), Integer.valueOf(PDU_COLUMN_RETRIEVE_TEXT_CHARSET));
        CHARSET_COLUMN_NAME_MAP = new HashMap();
        CHARSET_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_SIZE), BaseMmsColumns.SUBJECT_CHARSET);
        CHARSET_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_START_INFO), BaseMmsColumns.RETRIEVE_TEXT_CHARSET);
        ENCODED_STRING_COLUMN_INDEX_MAP = new HashMap();
        ENCODED_STRING_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_START_INFO), Integer.valueOf(PROC_STATUS_COMPLETED));
        ENCODED_STRING_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_SIZE), Integer.valueOf(PDU_COLUMN_SUBJECT));
        ENCODED_STRING_COLUMN_NAME_MAP = new HashMap();
        ENCODED_STRING_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_START_INFO), BaseMmsColumns.RETRIEVE_TEXT);
        ENCODED_STRING_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_SIZE), BaseMmsColumns.SUBJECT);
        TEXT_STRING_COLUMN_INDEX_MAP = new HashMap();
        TEXT_STRING_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_TYPE), Integer.valueOf(PDU_COLUMN_CONTENT_LOCATION));
        TEXT_STRING_COLUMN_INDEX_MAP.put(Integer.valueOf(PduHeaders.STATUS_UNRECOGNIZED), Integer.valueOf(PDU_COLUMN_CONTENT_TYPE));
        TEXT_STRING_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_DEP_START), Integer.valueOf(PDU_COLUMN_MESSAGE_CLASS));
        TEXT_STRING_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_DEP_START_INFO), Integer.valueOf(PDU_COLUMN_MESSAGE_ID));
        TEXT_STRING_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_CREATION_DATE), Integer.valueOf(PDU_COLUMN_RESPONSE_TEXT));
        TEXT_STRING_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_FILENAME), Integer.valueOf(PDU_COLUMN_TRANSACTION_ID));
        TEXT_STRING_COLUMN_NAME_MAP = new HashMap();
        TEXT_STRING_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_TYPE), BaseMmsColumns.CONTENT_LOCATION);
        TEXT_STRING_COLUMN_NAME_MAP.put(Integer.valueOf(PduHeaders.STATUS_UNRECOGNIZED), BaseMmsColumns.CONTENT_TYPE);
        TEXT_STRING_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_DEP_START), BaseMmsColumns.MESSAGE_CLASS);
        TEXT_STRING_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_DEP_START_INFO), BaseMmsColumns.MESSAGE_ID);
        TEXT_STRING_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_CREATION_DATE), BaseMmsColumns.RESPONSE_TEXT);
        TEXT_STRING_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_FILENAME), BaseMmsColumns.TRANSACTION_ID);
        OCTET_COLUMN_INDEX_MAP = new HashMap();
        OCTET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduHeaders.CONTENT_CLASS), Integer.valueOf(PDU_COLUMN_CONTENT_CLASS));
        OCTET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_DEP_FILENAME), Integer.valueOf(PDU_COLUMN_DELIVERY_REPORT));
        OCTET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_DEP_COMMENT), Integer.valueOf(PDU_COLUMN_MESSAGE_TYPE));
        OCTET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_DEP_DOMAIN), Integer.valueOf(PDU_COLUMN_MMS_VERSION));
        OCTET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_DEP_PATH), Integer.valueOf(PDU_COLUMN_PRIORITY));
        OCTET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_SECURE), Integer.valueOf(PDU_COLUMN_READ_REPORT));
        OCTET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_COMMENT), Integer.valueOf(PDU_COLUMN_READ_STATUS));
        OCTET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_SEC), Integer.valueOf(PDU_COLUMN_REPORT_ALLOWED));
        OCTET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_START), Integer.valueOf(PDU_COLUMN_RETRIEVE_STATUS));
        OCTET_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_READ_DATE), Integer.valueOf(PDU_COLUMN_STATUS));
        OCTET_COLUMN_NAME_MAP = new HashMap();
        OCTET_COLUMN_NAME_MAP.put(Integer.valueOf(PduHeaders.CONTENT_CLASS), BaseMmsColumns.CONTENT_CLASS);
        OCTET_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_DEP_FILENAME), BaseMmsColumns.DELIVERY_REPORT);
        OCTET_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_DEP_COMMENT), BaseMmsColumns.MESSAGE_TYPE);
        OCTET_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_DEP_DOMAIN), BaseMmsColumns.MMS_VERSION);
        OCTET_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_DEP_PATH), BaseMmsColumns.PRIORITY);
        OCTET_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_SECURE), BaseMmsColumns.READ_REPORT);
        OCTET_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_COMMENT), BaseMmsColumns.READ_STATUS);
        OCTET_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_SEC), BaseMmsColumns.REPORT_ALLOWED);
        OCTET_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_START), BaseMmsColumns.RETRIEVE_STATUS);
        OCTET_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_READ_DATE), BaseMmsColumns.STATUS);
        LONG_COLUMN_INDEX_MAP = new HashMap();
        LONG_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_DEP_NAME), Integer.valueOf(PDU_COLUMN_DATE));
        LONG_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_DIFFERENCES), Integer.valueOf(PDU_COLUMN_DELIVERY_TIME));
        LONG_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_PADDING), Integer.valueOf(PDU_COLUMN_EXPIRY));
        LONG_COLUMN_INDEX_MAP.put(Integer.valueOf(PduPart.P_MAX_AGE), Integer.valueOf(PDU_COLUMN_MESSAGE_SIZE));
        LONG_COLUMN_NAME_MAP = new HashMap();
        LONG_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_DEP_NAME), ThreadsColumns.DATE);
        LONG_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_DIFFERENCES), BaseMmsColumns.DELIVERY_TIME);
        LONG_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_PADDING), BaseMmsColumns.EXPIRY);
        LONG_COLUMN_NAME_MAP.put(Integer.valueOf(PduPart.P_MAX_AGE), BaseMmsColumns.MESSAGE_SIZE);
        PDU_CACHE_INSTANCE = PduCache.getInstance();
    }

    private PduPersister(Context context) {
        this.mContext = context;
        this.mContentResolver = context.getContentResolver();
        this.mDrmManagerClient = new DrmManagerClient(context);
        this.mTelephonyManager = (TelephonyManager) context.getSystemService("phone");
    }

    public static PduPersister getPduPersister(Context context) {
        if (sPersister == null) {
            sPersister = new PduPersister(context);
        } else if (!context.equals(sPersister.mContext)) {
            sPersister.release();
            sPersister = new PduPersister(context);
        }
        return sPersister;
    }

    private void setEncodedStringValueToHeaders(Cursor c, int columnIndex, PduHeaders headers, int mapColumn) {
        String s = c.getString(columnIndex);
        if (s != null && s.length() > 0) {
            headers.setEncodedStringValue(new EncodedStringValue(c.getInt(((Integer) CHARSET_COLUMN_INDEX_MAP.get(Integer.valueOf(mapColumn))).intValue()), getBytes(s)), mapColumn);
        }
    }

    private void setTextStringToHeaders(Cursor c, int columnIndex, PduHeaders headers, int mapColumn) {
        String s = c.getString(columnIndex);
        if (s != null) {
            headers.setTextString(getBytes(s), mapColumn);
        }
    }

    private void setOctetToHeaders(Cursor c, int columnIndex, PduHeaders headers, int mapColumn) throws InvalidHeaderValueException {
        if (!c.isNull(columnIndex)) {
            headers.setOctet(c.getInt(columnIndex), mapColumn);
        }
    }

    private void setLongToHeaders(Cursor c, int columnIndex, PduHeaders headers, int mapColumn) {
        if (!c.isNull(columnIndex)) {
            headers.setLongInteger(c.getLong(columnIndex), mapColumn);
        }
    }

    private Integer getIntegerFromPartColumn(Cursor c, int columnIndex) {
        if (c.isNull(columnIndex)) {
            return null;
        }
        return Integer.valueOf(c.getInt(columnIndex));
    }

    private byte[] getByteArrayFromPartColumn(Cursor c, int columnIndex) {
        if (c.isNull(columnIndex)) {
            return null;
        }
        return getBytes(c.getString(columnIndex));
    }

    private PduPart[] loadParts(long msgId) throws MmsException {
        Cursor c = SqliteWrapper.query(this.mContext, this.mContentResolver, Uri.parse("content://mms/" + msgId + "/part"), PART_PROJECTION, null, null, null);
        if (c != null) {
            if (c.getCount() != 0) {
                PduPart[] parts = new PduPart[c.getCount()];
                int partIdx = PDU_COLUMN_ID;
                while (c.moveToNext()) {
                    PduPart part = new PduPart();
                    Integer charset = getIntegerFromPartColumn(c, PROC_STATUS_TRANSIENT_FAILURE);
                    if (charset != null) {
                        part.setCharset(charset.intValue());
                    }
                    byte[] contentDisposition = getByteArrayFromPartColumn(c, PROC_STATUS_PERMANENTLY_FAILURE);
                    if (contentDisposition != null) {
                        part.setContentDisposition(contentDisposition);
                    }
                    byte[] contentId = getByteArrayFromPartColumn(c, PROC_STATUS_COMPLETED);
                    if (contentId != null) {
                        part.setContentId(contentId);
                    }
                    byte[] contentLocation = getByteArrayFromPartColumn(c, PDU_COLUMN_SUBJECT);
                    if (contentLocation != null) {
                        part.setContentLocation(contentLocation);
                    }
                    byte[] contentType = getByteArrayFromPartColumn(c, PDU_COLUMN_CONTENT_LOCATION);
                    if (contentType != null) {
                        part.setContentType(contentType);
                        byte[] fileName = getByteArrayFromPartColumn(c, PDU_COLUMN_CONTENT_TYPE);
                        if (fileName != null) {
                            part.setFilename(fileName);
                        }
                        byte[] name = getByteArrayFromPartColumn(c, PDU_COLUMN_MESSAGE_CLASS);
                        if (name != null) {
                            part.setName(name);
                        }
                        Uri partURI = Uri.parse("content://mms/part/" + c.getLong(PDU_COLUMN_ID));
                        part.setDataUri(partURI);
                        String type = toIsoString(contentType);
                        if (!(ContentType.isImageType(type) || ContentType.isAudioType(type) || ContentType.isVideoType(type))) {
                            ByteArrayOutputStream baos = new ByteArrayOutputStream();
                            InputStream is = null;
                            if (ContentType.TEXT_PLAIN.equals(type) || ContentType.APP_SMIL.equals(type) || ContentType.TEXT_HTML.equals(type)) {
                                String text = c.getString(PDU_COLUMN_MESSAGE_ID);
                                if (text == null) {
                                    try {
                                        text = "";
                                    } catch (Throwable e) {
                                        Log.e(TAG, "Failed to close stream", e);
                                    } catch (Throwable th) {
                                        if (c != null) {
                                            c.close();
                                        }
                                    }
                                }
                                byte[] blob = new EncodedStringValue(text).getTextString();
                                baos.write(blob, PDU_COLUMN_ID, blob.length);
                            } else {
                                try {
                                    is = this.mContentResolver.openInputStream(partURI);
                                    byte[] buffer = new byte[256];
                                    for (int len = is.read(buffer); len >= 0; len = is.read(buffer)) {
                                        baos.write(buffer, PDU_COLUMN_ID, len);
                                    }
                                    if (is != null) {
                                        is.close();
                                    }
                                } catch (Throwable e2) {
                                    Log.e(TAG, "Failed to load part data", e2);
                                    c.close();
                                    throw new MmsException(e2);
                                } catch (Throwable th2) {
                                    if (is != null) {
                                        try {
                                            is.close();
                                        } catch (Throwable e22) {
                                            Log.e(TAG, "Failed to close stream", e22);
                                        }
                                    }
                                }
                            }
                            part.setData(baos.toByteArray());
                        }
                        int partIdx2 = partIdx + PROC_STATUS_TRANSIENT_FAILURE;
                        parts[partIdx] = part;
                        partIdx = partIdx2;
                    } else {
                        throw new MmsException("Content-Type must be set.");
                    }
                }
                if (c != null) {
                    c.close();
                }
                return parts;
            }
        }
        if (c == null) {
            return null;
        }
        c.close();
        return null;
    }

    private void loadAddress(long msgId, PduHeaders headers) {
        Context context = this.mContext;
        ContentResolver contentResolver = this.mContentResolver;
        Uri parse = Uri.parse("content://mms/" + msgId + "/addr");
        String[] strArr = new String[PROC_STATUS_COMPLETED];
        strArr[PDU_COLUMN_ID] = TextBasedSmsColumns.ADDRESS;
        strArr[PROC_STATUS_TRANSIENT_FAILURE] = Addr.CHARSET;
        strArr[PROC_STATUS_PERMANENTLY_FAILURE] = ThreadsColumns.TYPE;
        Cursor c = SqliteWrapper.query(context, contentResolver, parse, strArr, null, null, null);
        if (c != null) {
            while (c.moveToNext()) {
                String addr = c.getString(PDU_COLUMN_ID);
                if (!TextUtils.isEmpty(addr)) {
                    int addrType = c.getInt(PROC_STATUS_PERMANENTLY_FAILURE);
                    switch (addrType) {
                        case PduPart.P_DISPOSITION_ATTACHMENT /*129*/:
                        case PduPart.P_LEVEL /*130*/:
                        case PduPart.P_NAME /*151*/:
                            headers.appendEncodedStringValue(new EncodedStringValue(c.getInt(PROC_STATUS_TRANSIENT_FAILURE), getBytes(addr)), addrType);
                            break;
                        case PduPart.P_CT_MR_TYPE /*137*/:
                            try {
                                headers.setEncodedStringValue(new EncodedStringValue(c.getInt(PROC_STATUS_TRANSIENT_FAILURE), getBytes(addr)), addrType);
                                break;
                            } finally {
                                c.close();
                            }
                        default:
                            Log.e(TAG, "Unknown address type: " + addrType);
                            break;
                    }
                }
            }
        }
    }

    public GenericPdu load(Uri uri) throws MmsException {
        Throwable th;
        Cursor c;
        PduCacheEntry cacheEntry = null;
        int msgBox = PDU_COLUMN_ID;
        long threadId = -1;
        PduCacheEntry cacheEntry2;
        try {
            synchronized (PDU_CACHE_INSTANCE) {
                try {
                    if (PDU_CACHE_INSTANCE.isUpdating(uri)) {
                        PDU_CACHE_INSTANCE.wait();
                        cacheEntry = (PduCacheEntry) PDU_CACHE_INSTANCE.get(uri);
                        if (cacheEntry != null) {
                            GenericPdu pdu = cacheEntry.getPdu();
                            synchronized (PDU_CACHE_INSTANCE) {
                                if (PDU_COLUMN_ID != null) {
                                    if ($assertionsDisabled || PDU_CACHE_INSTANCE.get(uri) == null) {
                                        try {
                                            cacheEntry2 = new PduCacheEntry(null, PDU_COLUMN_ID, -1);
                                            try {
                                                PDU_CACHE_INSTANCE.put(uri, cacheEntry2);
                                                cacheEntry = cacheEntry2;
                                            } catch (Throwable th2) {
                                                th = th2;
                                                cacheEntry = cacheEntry2;
                                                throw th;
                                            }
                                        } catch (Throwable th3) {
                                            th = th3;
                                            throw th;
                                        }
                                    }
                                    throw new AssertionError();
                                }
                                PDU_CACHE_INSTANCE.setUpdating(uri, LOCAL_LOGV);
                                PDU_CACHE_INSTANCE.notifyAll();
                                return pdu;
                            }
                        }
                    }
                } catch (InterruptedException e) {
                    Log.e(TAG, "load: ", e);
                } catch (Throwable th4) {
                    th = th4;
                    throw th;
                }
                cacheEntry2 = cacheEntry;
                try {
                    PDU_CACHE_INSTANCE.setUpdating(uri, true);
                    try {
                        c = SqliteWrapper.query(this.mContext, this.mContentResolver, uri, PDU_PROJECTION, null, null, null);
                        PduHeaders headers = new PduHeaders();
                        long msgId = ContentUris.parseId(uri);
                        if (c != null) {
                            if (c.getCount() == PROC_STATUS_TRANSIENT_FAILURE && c.moveToFirst()) {
                                msgBox = c.getInt(PROC_STATUS_TRANSIENT_FAILURE);
                                threadId = c.getLong(PROC_STATUS_PERMANENTLY_FAILURE);
                                for (Entry<Integer, Integer> e2 : ENCODED_STRING_COLUMN_INDEX_MAP.entrySet()) {
                                    setEncodedStringValueToHeaders(c, ((Integer) e2.getValue()).intValue(), headers, ((Integer) e2.getKey()).intValue());
                                }
                                for (Entry<Integer, Integer> e22 : TEXT_STRING_COLUMN_INDEX_MAP.entrySet()) {
                                    setTextStringToHeaders(c, ((Integer) e22.getValue()).intValue(), headers, ((Integer) e22.getKey()).intValue());
                                }
                                for (Entry<Integer, Integer> e222 : OCTET_COLUMN_INDEX_MAP.entrySet()) {
                                    setOctetToHeaders(c, ((Integer) e222.getValue()).intValue(), headers, ((Integer) e222.getKey()).intValue());
                                }
                                for (Entry<Integer, Integer> e2222 : LONG_COLUMN_INDEX_MAP.entrySet()) {
                                    setLongToHeaders(c, ((Integer) e2222.getValue()).intValue(), headers, ((Integer) e2222.getKey()).intValue());
                                }
                                if (c != null) {
                                    c.close();
                                }
                                if (msgId == -1) {
                                    throw new MmsException("Error! ID of the message: -1.");
                                }
                                GenericPdu pdu2;
                                loadAddress(msgId, headers);
                                int msgType = headers.getOctet(PduPart.P_DEP_COMMENT);
                                PduBody body = new PduBody();
                                if (msgType == 132 || msgType == 128) {
                                    PduPart[] parts = loadParts(msgId);
                                    if (parts != null) {
                                        int partsNum = parts.length;
                                        for (int i = PDU_COLUMN_ID; i < partsNum; i += PROC_STATUS_TRANSIENT_FAILURE) {
                                            body.addPart(parts[i]);
                                        }
                                    }
                                }
                                switch (msgType) {
                                    case PduPart.P_Q /*128*/:
                                        pdu2 = new SendReq(headers, body);
                                        break;
                                    case PduPart.P_DISPOSITION_ATTACHMENT /*129*/:
                                    case PduPart.P_CT_MR_TYPE /*137*/:
                                    case PduPart.P_DEP_START /*138*/:
                                    case PduPart.P_DEP_START_INFO /*139*/:
                                    case PduPart.P_DEP_COMMENT /*140*/:
                                    case PduPart.P_DEP_DOMAIN /*141*/:
                                    case PduPart.P_MAX_AGE /*142*/:
                                    case PduPart.P_DEP_PATH /*143*/:
                                    case PduPart.P_SECURE /*144*/:
                                    case PduPart.P_SEC /*145*/:
                                    case PduPart.P_MAC /*146*/:
                                    case PduPart.P_CREATION_DATE /*147*/:
                                    case PduPart.P_MODIFICATION_DATE /*148*/:
                                    case PduPart.P_READ_DATE /*149*/:
                                    case PduPart.P_SIZE /*150*/:
                                    case PduPart.P_NAME /*151*/:
                                        throw new MmsException("Unsupported PDU type: " + Integer.toHexString(msgType));
                                    case PduPart.P_LEVEL /*130*/:
                                        pdu2 = new NotificationInd(headers);
                                        break;
                                    case PduPart.P_TYPE /*131*/:
                                        pdu2 = new NotifyRespInd(headers);
                                        break;
                                    case PduHeaders.STATUS_UNRECOGNIZED /*132*/:
                                        pdu2 = new RetrieveConf(headers, body);
                                        break;
                                    case PduPart.P_DEP_NAME /*133*/:
                                        pdu2 = new AcknowledgeInd(headers);
                                        break;
                                    case PduPart.P_DEP_FILENAME /*134*/:
                                        pdu2 = new DeliveryInd(headers);
                                        break;
                                    case PduPart.P_DIFFERENCES /*135*/:
                                        pdu2 = new ReadRecInd(headers);
                                        break;
                                    case PduPart.P_PADDING /*136*/:
                                        pdu2 = new ReadOrigInd(headers);
                                        break;
                                    default:
                                        throw new MmsException("Unrecognized PDU type: " + Integer.toHexString(msgType));
                                }
                                synchronized (PDU_CACHE_INSTANCE) {
                                    if (pdu2 != null) {
                                        try {
                                            if ($assertionsDisabled || PDU_CACHE_INSTANCE.get(uri) == null) {
                                                PDU_CACHE_INSTANCE.put(uri, new PduCacheEntry(pdu2, msgBox, threadId));
                                            } else {
                                                throw new AssertionError();
                                            }
                                        } catch (Throwable th5) {
                                            th = th5;
                                            cacheEntry = cacheEntry2;
                                            try {
                                            } catch (Throwable th6) {
                                                th = th6;
                                                throw th;
                                            }
                                            throw th;
                                        }
                                    }
                                    PDU_CACHE_INSTANCE.setUpdating(uri, LOCAL_LOGV);
                                    PDU_CACHE_INSTANCE.notifyAll();
                                    return pdu2;
                                }
                            }
                        }
                        throw new MmsException("Bad uri: " + uri);
                    } catch (Throwable th7) {
                        th = th7;
                        synchronized (PDU_CACHE_INSTANCE) {
                            if (PDU_COLUMN_ID != null) {
                                try {
                                    if ($assertionsDisabled || PDU_CACHE_INSTANCE.get(uri) == null) {
                                        PDU_CACHE_INSTANCE.put(uri, new PduCacheEntry(null, msgBox, threadId));
                                    } else {
                                        throw new AssertionError();
                                    }
                                } catch (Throwable th8) {
                                    th = th8;
                                    cacheEntry = cacheEntry2;
                                    try {
                                    } catch (Throwable th9) {
                                        th = th9;
                                        throw th;
                                    }
                                    throw th;
                                }
                            }
                            PDU_CACHE_INSTANCE.setUpdating(uri, LOCAL_LOGV);
                            PDU_CACHE_INSTANCE.notifyAll();
                            throw th;
                        }
                    }
                } catch (Throwable th10) {
                    th = th10;
                    cacheEntry = cacheEntry2;
                    throw th;
                }
            }
        } catch (Throwable th11) {
            th = th11;
            cacheEntry2 = cacheEntry;
        }
    }

    private void persistAddress(long msgId, int type, EncodedStringValue[] array) {
        ContentValues values = new ContentValues(PROC_STATUS_COMPLETED);
        EncodedStringValue[] arr$ = array;
        int len$ = arr$.length;
        for (int i$ = PDU_COLUMN_ID; i$ < len$; i$ += PROC_STATUS_TRANSIENT_FAILURE) {
            EncodedStringValue addr = arr$[i$];
            values.clear();
            values.put(TextBasedSmsColumns.ADDRESS, toIsoString(addr.getTextString()));
            values.put(Addr.CHARSET, Integer.valueOf(addr.getCharacterSet()));
            values.put(ThreadsColumns.TYPE, Integer.valueOf(type));
            SqliteWrapper.insert(this.mContext, this.mContentResolver, Uri.parse("content://mms/" + msgId + "/addr"), values);
        }
    }

    private static String getPartContentType(PduPart part) {
        return part.getContentType() == null ? null : toIsoString(part.getContentType());
    }

    public Uri persistPart(PduPart part, long msgId, HashMap<Uri, InputStream> preOpenedFiles) throws MmsException {
        Uri uri = Uri.parse("content://mms/" + msgId + "/part");
        ContentValues values = new ContentValues(PDU_COLUMN_MESSAGE_ID);
        int charset = part.getCharset();
        if (charset != 0) {
            values.put(Part.CHARSET, Integer.valueOf(charset));
        }
        String contentType = getPartContentType(part);
        if (contentType != null) {
            if (ContentType.IMAGE_JPG.equals(contentType)) {
                contentType = ContentType.IMAGE_JPEG;
            }
            values.put(Part.CONTENT_TYPE, contentType);
            if (ContentType.APP_SMIL.equals(contentType)) {
                values.put(Part.SEQ, Integer.valueOf(-1));
            }
            if (part.getFilename() != null) {
                values.put(Part.FILENAME, new String(part.getFilename()));
            }
            if (part.getName() != null) {
                values.put(Part.NAME, new String(part.getName()));
            }
            if (part.getContentDisposition() != null) {
                values.put(Part.CONTENT_DISPOSITION, toIsoString(part.getContentDisposition()));
            }
            if (part.getContentId() != null) {
                values.put(Part.CONTENT_ID, toIsoString(part.getContentId()));
            }
            if (part.getContentLocation() != null) {
                values.put(Part.CONTENT_LOCATION, toIsoString(part.getContentLocation()));
            }
            Uri res = SqliteWrapper.insert(this.mContext, this.mContentResolver, uri, values);
            if (res == null) {
                throw new MmsException("Failed to persist part, return null.");
            }
            persistData(part, res, contentType, preOpenedFiles);
            part.setDataUri(res);
            return res;
        }
        throw new MmsException("MIME type of the part must be set.");
    }

    private void persistData(PduPart part, Uri uri, String contentType, HashMap<Uri, InputStream> preOpenedFiles) throws MmsException {
        OutputStream os = null;
        InputStream is = null;
        DrmConvertSession drmConvertSession = null;
        String path = null;
        File f;
        try {
            byte[] data = part.getData();
            if (ContentType.TEXT_PLAIN.equals(contentType) || ContentType.APP_SMIL.equals(contentType) || ContentType.TEXT_HTML.equals(contentType)) {
                ContentValues cv = new ContentValues();
                if (data == null) {
                    data = new String("").getBytes(CharacterSets.MIMENAME_UTF_8);
                }
                cv.put(Part.TEXT, new EncodedStringValue(data).getString());
                if (this.mContentResolver.update(uri, cv, null, null) != PROC_STATUS_TRANSIENT_FAILURE) {
                    throw new MmsException("unable to update " + uri.toString());
                }
            }
            boolean isDrm = DownloadDrmHelper.isDrmConvertNeeded(contentType);
            if (isDrm) {
                if (uri != null) {
                    try {
                        path = convertUriToPath(this.mContext, uri);
                        if (new File(path).length() > 0) {
                            if (os != null) {
                                try {
                                    os.close();
                                } catch (IOException e) {
                                    Log.e(TAG, "IOException while closing: " + os, e);
                                }
                            }
                            if (is != null) {
                                try {
                                    is.close();
                                } catch (IOException e2) {
                                    Log.e(TAG, "IOException while closing: " + is, e2);
                                }
                            }
                            if (drmConvertSession != null) {
                                drmConvertSession.close(path);
                                f = new File(path);
                                SqliteWrapper.update(this.mContext, this.mContentResolver, Uri.parse("content://mms/resetFilePerm/" + f.getName()), new ContentValues(PDU_COLUMN_ID), null, null);
                                return;
                            }
                            return;
                        }
                    } catch (Exception e3) {
                        Log.e(TAG, "Can't get file info for: " + part.getDataUri(), e3);
                    }
                }
                drmConvertSession = DrmConvertSession.open(this.mContext, contentType);
                if (drmConvertSession == null) {
                    throw new MmsException("Mimetype " + contentType + " can not be converted.");
                }
            }
            os = this.mContentResolver.openOutputStream(uri);
            Uri dataUri;
            byte[] convertedData;
            if (data == null) {
                dataUri = part.getDataUri();
                if (dataUri == null || dataUri == uri) {
                    Log.w(TAG, "Can't find data for this part.");
                    if (os != null) {
                        try {
                            os.close();
                        } catch (IOException e22) {
                            Log.e(TAG, "IOException while closing: " + os, e22);
                        }
                    }
                    if (is != null) {
                        try {
                            is.close();
                        } catch (IOException e222) {
                            Log.e(TAG, "IOException while closing: " + is, e222);
                        }
                    }
                    if (drmConvertSession != null) {
                        drmConvertSession.close(path);
                        f = new File(path);
                        SqliteWrapper.update(this.mContext, this.mContentResolver, Uri.parse("content://mms/resetFilePerm/" + f.getName()), new ContentValues(PDU_COLUMN_ID), null, null);
                        return;
                    }
                    return;
                }
                if (preOpenedFiles != null) {
                    if (preOpenedFiles.containsKey(dataUri)) {
                        is = (InputStream) preOpenedFiles.get(dataUri);
                    }
                }
                if (is == null) {
                    is = this.mContentResolver.openInputStream(dataUri);
                }
                byte[] buffer = new byte[SmsCbConstants.SERIAL_NUMBER_ETWS_EMERGENCY_USER_ALERT];
                while (true) {
                    int len = is.read(buffer);
                    if (len != -1) {
                        if (isDrm) {
                            convertedData = drmConvertSession.convert(buffer, len);
                            if (convertedData == null) {
                                break;
                            }
                            os.write(convertedData, PDU_COLUMN_ID, convertedData.length);
                        } else {
                            os.write(buffer, PDU_COLUMN_ID, len);
                        }
                    } else {
                        break;
                    }
                }
                throw new MmsException("Error converting drm data.");
            } else if (isDrm) {
                dataUri = uri;
                convertedData = drmConvertSession.convert(data, data.length);
                if (convertedData != null) {
                    os.write(convertedData, PDU_COLUMN_ID, convertedData.length);
                } else {
                    throw new MmsException("Error converting drm data.");
                }
            } else {
                os.write(data);
            }
            if (os != null) {
                try {
                    os.close();
                } catch (IOException e2222) {
                    Log.e(TAG, "IOException while closing: " + os, e2222);
                }
            }
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e22222) {
                    Log.e(TAG, "IOException while closing: " + is, e22222);
                }
            }
            if (drmConvertSession != null) {
                drmConvertSession.close(path);
                f = new File(path);
                SqliteWrapper.update(this.mContext, this.mContentResolver, Uri.parse("content://mms/resetFilePerm/" + f.getName()), new ContentValues(PDU_COLUMN_ID), null, null);
            }
        } catch (Throwable e4) {
            Log.e(TAG, "Failed to open Input/Output stream.", e4);
            throw new MmsException(e4);
        } catch (Throwable e42) {
            Log.e(TAG, "Failed to read/write data.", e42);
            throw new MmsException(e42);
        } catch (Throwable th) {
            Throwable th2 = th;
            if (os != null) {
                try {
                    os.close();
                } catch (IOException e222222) {
                    Log.e(TAG, "IOException while closing: " + os, e222222);
                }
            }
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e2222222) {
                    Log.e(TAG, "IOException while closing: " + is, e2222222);
                }
            }
            if (drmConvertSession != null) {
                drmConvertSession.close(path);
                f = new File(path);
                SqliteWrapper.update(this.mContext, this.mContentResolver, Uri.parse("content://mms/resetFilePerm/" + f.getName()), new ContentValues(PDU_COLUMN_ID), null, null);
            }
        }
    }

    public static String convertUriToPath(Context context, Uri uri) {
        if (uri == null) {
            return null;
        }
        String scheme = uri.getScheme();
        if (scheme == null || scheme.equals("") || scheme.equals("file")) {
            return uri.getPath();
        }
        if (scheme.equals("http")) {
            return uri.toString();
        }
        if (scheme.equals("content")) {
            String[] projection = new String[PROC_STATUS_TRANSIENT_FAILURE];
            projection[PDU_COLUMN_ID] = Part._DATA;
            Cursor cursor = null;
            try {
                cursor = context.getContentResolver().query(uri, projection, null, null, null);
                if (cursor == null || cursor.getCount() == 0 || !cursor.moveToFirst()) {
                    throw new IllegalArgumentException("Given Uri could not be found in media store");
                }
                String path = cursor.getString(cursor.getColumnIndexOrThrow(Part._DATA));
                if (cursor == null) {
                    return path;
                }
                cursor.close();
                return path;
            } catch (SQLiteException e) {
                throw new IllegalArgumentException("Given Uri is not formatted in a way so that it can be found in media store.");
            } catch (Throwable th) {
                if (cursor != null) {
                    cursor.close();
                }
            }
        } else {
            throw new IllegalArgumentException("Given Uri scheme is not supported");
        }
    }

    private void updateAddress(long msgId, int type, EncodedStringValue[] array) {
        SqliteWrapper.delete(this.mContext, this.mContentResolver, Uri.parse("content://mms/" + msgId + "/addr"), "type=" + type, null);
        persistAddress(msgId, type, array);
    }

    public void updateHeaders(Uri uri, SendReq sendReq) {
        synchronized (PDU_CACHE_INSTANCE) {
            if (PDU_CACHE_INSTANCE.isUpdating(uri)) {
                try {
                    PDU_CACHE_INSTANCE.wait();
                } catch (Throwable e) {
                    Log.e(TAG, "updateHeaders: ", e);
                }
            }
        }
        PDU_CACHE_INSTANCE.purge(uri);
        ContentValues values = new ContentValues(PDU_COLUMN_TRANSACTION_ID);
        byte[] contentType = sendReq.getContentType();
        if (contentType != null) {
            values.put(BaseMmsColumns.CONTENT_TYPE, toIsoString(contentType));
        }
        long date = sendReq.getDate();
        if (date != -1) {
            values.put(ThreadsColumns.DATE, Long.valueOf(date));
        }
        int deliveryReport = sendReq.getDeliveryReport();
        if (deliveryReport != 0) {
            values.put(BaseMmsColumns.DELIVERY_REPORT, Integer.valueOf(deliveryReport));
        }
        long expiry = sendReq.getExpiry();
        if (expiry != -1) {
            values.put(BaseMmsColumns.EXPIRY, Long.valueOf(expiry));
        }
        byte[] msgClass = sendReq.getMessageClass();
        if (msgClass != null) {
            values.put(BaseMmsColumns.MESSAGE_CLASS, toIsoString(msgClass));
        }
        int priority = sendReq.getPriority();
        if (priority != 0) {
            values.put(BaseMmsColumns.PRIORITY, Integer.valueOf(priority));
        }
        int readReport = sendReq.getReadReport();
        if (readReport != 0) {
            values.put(BaseMmsColumns.READ_REPORT, Integer.valueOf(readReport));
        }
        byte[] transId = sendReq.getTransactionId();
        if (transId != null) {
            values.put(BaseMmsColumns.TRANSACTION_ID, toIsoString(transId));
        }
        EncodedStringValue subject = sendReq.getSubject();
        if (subject != null) {
            values.put(BaseMmsColumns.SUBJECT, toIsoString(subject.getTextString()));
            values.put(BaseMmsColumns.SUBJECT_CHARSET, Integer.valueOf(subject.getCharacterSet()));
        } else {
            values.put(BaseMmsColumns.SUBJECT, "");
        }
        long messageSize = sendReq.getMessageSize();
        if (messageSize > 0) {
            values.put(BaseMmsColumns.MESSAGE_SIZE, Long.valueOf(messageSize));
        }
        PduHeaders headers = sendReq.getPduHeaders();
        HashSet<String> recipients = new HashSet();
        int[] iArr = ADDRESS_FIELDS;
        int length = iArr.length;
        for (int i$ = PDU_COLUMN_ID; i$ < length; i$ += PROC_STATUS_TRANSIENT_FAILURE) {
            EncodedStringValue v;
            int addrType = iArr[i$];
            EncodedStringValue[] array = null;
            if (addrType == PduPart.P_CT_MR_TYPE) {
                v = headers.getEncodedStringValue(addrType);
                if (v != null) {
                    array = new EncodedStringValue[PROC_STATUS_TRANSIENT_FAILURE];
                    array[PDU_COLUMN_ID] = v;
                }
            } else {
                array = headers.getEncodedStringValues(addrType);
            }
            if (array != null) {
                updateAddress(ContentUris.parseId(uri), addrType, array);
                if (addrType == PduPart.P_NAME) {
                    EncodedStringValue[] arr$ = array;
                    int len$ = arr$.length;
                    for (int i$2 = PDU_COLUMN_ID; i$2 < len$; i$2 += PROC_STATUS_TRANSIENT_FAILURE) {
                        v = arr$[i$2];
                        if (v != null) {
                            recipients.add(v.getString());
                        }
                    }
                }
            }
        }
        if (!recipients.isEmpty()) {
            values.put(TextBasedSmsColumns.THREAD_ID, Long.valueOf(Threads.getOrCreateThreadId(this.mContext, (Set) recipients)));
        }
        SqliteWrapper.update(this.mContext, this.mContentResolver, uri, values, null, null);
    }

    private void updatePart(Uri uri, PduPart part, HashMap<Uri, InputStream> preOpenedFiles) throws MmsException {
        ContentValues values = new ContentValues(PDU_COLUMN_MESSAGE_CLASS);
        int charset = part.getCharset();
        if (charset != 0) {
            values.put(Part.CHARSET, Integer.valueOf(charset));
        }
        if (part.getContentType() != null) {
            String contentType = toIsoString(part.getContentType());
            values.put(Part.CONTENT_TYPE, contentType);
            if (part.getFilename() != null) {
                values.put(Part.FILENAME, new String(part.getFilename()));
            }
            if (part.getName() != null) {
                values.put(Part.NAME, new String(part.getName()));
            }
            if (part.getContentDisposition() != null) {
                values.put(Part.CONTENT_DISPOSITION, toIsoString(part.getContentDisposition()));
            }
            if (part.getContentId() != null) {
                values.put(Part.CONTENT_ID, toIsoString(part.getContentId()));
            }
            if (part.getContentLocation() != null) {
                values.put(Part.CONTENT_LOCATION, toIsoString(part.getContentLocation()));
            }
            SqliteWrapper.update(this.mContext, this.mContentResolver, uri, values, null, null);
            if (part.getData() != null || uri != part.getDataUri()) {
                persistData(part, uri, contentType, preOpenedFiles);
                return;
            }
            return;
        }
        throw new MmsException("MIME type of the part must be set.");
    }

    public void updateParts(Uri uri, PduBody body, HashMap<Uri, InputStream> preOpenedFiles) throws MmsException {
        PduPart pduPart;
        try {
            synchronized (PDU_CACHE_INSTANCE) {
                if (PDU_CACHE_INSTANCE.isUpdating(uri)) {
                    try {
                        PDU_CACHE_INSTANCE.wait();
                    } catch (InterruptedException e) {
                        Log.e(TAG, "updateParts: ", e);
                    }
                    PduCacheEntry cacheEntry = (PduCacheEntry) PDU_CACHE_INSTANCE.get(uri);
                    if (cacheEntry != null) {
                        ((MultimediaMessagePdu) cacheEntry.getPdu()).setBody(body);
                    }
                }
                PDU_CACHE_INSTANCE.setUpdating(uri, true);
            }
            ArrayList<PduPart> toBeCreated = new ArrayList();
            HashMap<Uri, PduPart> toBeUpdated = new HashMap();
            int partsNum = body.getPartsNum();
            StringBuilder filter = new StringBuilder().append('(');
            for (int i = PDU_COLUMN_ID; i < partsNum; i += PROC_STATUS_TRANSIENT_FAILURE) {
                PduPart part = body.getPart(i);
                Uri partUri = part.getDataUri();
                if (partUri == null || !partUri.getAuthority().startsWith("mms")) {
                    toBeCreated.add(part);
                } else {
                    toBeUpdated.put(partUri, part);
                    if (filter.length() > PROC_STATUS_TRANSIENT_FAILURE) {
                        filter.append(" AND ");
                    }
                    filter.append(HbpcdLookup.ID);
                    filter.append("!=");
                    DatabaseUtils.appendEscapedSQLString(filter, partUri.getLastPathSegment());
                }
            }
            filter.append(')');
            long msgId = ContentUris.parseId(uri);
            pduPart = this.mContext;
            SqliteWrapper.delete(pduPart, this.mContentResolver, Uri.parse(Mms.CONTENT_URI + "/" + msgId + "/part"), filter.length() > PROC_STATUS_PERMANENTLY_FAILURE ? filter.toString() : null, null);
            Iterator i$ = toBeCreated.iterator();
            while (i$.hasNext()) {
                persistPart((PduPart) i$.next(), msgId, preOpenedFiles);
            }
            for (Entry<Uri, PduPart> e2 : toBeUpdated.entrySet()) {
                pduPart = (PduPart) e2.getValue();
                updatePart((Uri) e2.getKey(), pduPart, preOpenedFiles);
            }
            PDU_CACHE_INSTANCE.setUpdating(uri, LOCAL_LOGV);
            PDU_CACHE_INSTANCE.notifyAll();
        } finally {
            pduPart = PDU_CACHE_INSTANCE;
            synchronized (pduPart) {
            }
            PDU_CACHE_INSTANCE.setUpdating(uri, LOCAL_LOGV);
            PDU_CACHE_INSTANCE.notifyAll();
        }
    }

    public Uri persist(GenericPdu pdu, Uri uri, boolean createThreadId, boolean groupMmsEnabled, HashMap<Uri, InputStream> preOpenedFiles) throws MmsException {
        if (uri == null) {
            throw new MmsException("Uri may not be null.");
        }
        long msgId = -1;
        try {
            msgId = ContentUris.parseId(uri);
        } catch (NumberFormatException e) {
        }
        boolean existingUri = msgId != -1 ? true : LOCAL_LOGV;
        if (existingUri || MESSAGE_BOX_MAP.get(uri) != null) {
            int i$;
            int addrType;
            Uri res;
            synchronized (PDU_CACHE_INSTANCE) {
                if (PDU_CACHE_INSTANCE.isUpdating(uri)) {
                    try {
                        PDU_CACHE_INSTANCE.wait();
                    } catch (Throwable e2) {
                        Log.e(TAG, "persist1: ", e2);
                    }
                }
            }
            PDU_CACHE_INSTANCE.purge(uri);
            PduHeaders header = pdu.getPduHeaders();
            ContentValues values = new ContentValues();
            for (Entry<Integer, String> e3 : ENCODED_STRING_COLUMN_NAME_MAP.entrySet()) {
                int field = ((Integer) e3.getKey()).intValue();
                EncodedStringValue encodedString = header.getEncodedStringValue(field);
                if (encodedString != null) {
                    String charsetColumn = (String) CHARSET_COLUMN_NAME_MAP.get(Integer.valueOf(field));
                    values.put((String) e3.getValue(), toIsoString(encodedString.getTextString()));
                    values.put(charsetColumn, Integer.valueOf(encodedString.getCharacterSet()));
                }
            }
            for (Entry<Integer, String> e32 : TEXT_STRING_COLUMN_NAME_MAP.entrySet()) {
                byte[] text = header.getTextString(((Integer) e32.getKey()).intValue());
                if (text != null) {
                    values.put((String) e32.getValue(), toIsoString(text));
                }
            }
            for (Entry<Integer, String> e322 : OCTET_COLUMN_NAME_MAP.entrySet()) {
                int b = header.getOctet(((Integer) e322.getKey()).intValue());
                if (b != 0) {
                    values.put((String) e322.getValue(), Integer.valueOf(b));
                }
            }
            for (Entry<Integer, String> e3222 : LONG_COLUMN_NAME_MAP.entrySet()) {
                long l = header.getLongInteger(((Integer) e3222.getKey()).intValue());
                if (l != -1) {
                    values.put((String) e3222.getValue(), Long.valueOf(l));
                }
            }
            HashMap<Integer, EncodedStringValue[]> hashMap = new HashMap(ADDRESS_FIELDS.length);
            int[] arr$ = ADDRESS_FIELDS;
            int len$ = arr$.length;
            for (i$ = PDU_COLUMN_ID; i$ < len$; i$ += PROC_STATUS_TRANSIENT_FAILURE) {
                addrType = arr$[i$];
                Object array = null;
                if (addrType == 137) {
                    EncodedStringValue v = header.getEncodedStringValue(addrType);
                    if (v != null) {
                        array = new EncodedStringValue[PROC_STATUS_TRANSIENT_FAILURE];
                        array[PDU_COLUMN_ID] = v;
                    }
                } else {
                    array = header.getEncodedStringValues(addrType);
                }
                hashMap.put(Integer.valueOf(addrType), array);
            }
            HashSet<String> recipients = new HashSet();
            int msgType = pdu.getMessageType();
            if (msgType == 130 || msgType == 132 || msgType == 128) {
                switch (msgType) {
                    case PduPart.P_Q /*128*/:
                        loadRecipients(PduPart.P_NAME, recipients, hashMap, LOCAL_LOGV);
                        break;
                    case PduPart.P_LEVEL /*130*/:
                    case PduHeaders.STATUS_UNRECOGNIZED /*132*/:
                        loadRecipients(PduPart.P_CT_MR_TYPE, recipients, hashMap, LOCAL_LOGV);
                        if (groupMmsEnabled) {
                            loadRecipients(PduPart.P_NAME, recipients, hashMap, true);
                            loadRecipients(PduPart.P_LEVEL, recipients, hashMap, true);
                            break;
                        }
                        break;
                }
                long threadId = 0;
                if (createThreadId && !recipients.isEmpty()) {
                    threadId = Threads.getOrCreateThreadId(this.mContext, (Set) recipients);
                }
                values.put(TextBasedSmsColumns.THREAD_ID, Long.valueOf(threadId));
            }
            long dummyId = System.currentTimeMillis();
            boolean textOnly = true;
            int messageSize = PDU_COLUMN_ID;
            if (pdu instanceof MultimediaMessagePdu) {
                PduBody body = ((MultimediaMessagePdu) pdu).getBody();
                if (body != null) {
                    int partsNum = body.getPartsNum();
                    if (partsNum > PROC_STATUS_PERMANENTLY_FAILURE) {
                        textOnly = LOCAL_LOGV;
                    }
                    for (int i = PDU_COLUMN_ID; i < partsNum; i += PROC_STATUS_TRANSIENT_FAILURE) {
                        PduPart part = body.getPart(i);
                        messageSize += part.getDataLength();
                        persistPart(part, dummyId, preOpenedFiles);
                        String contentType = getPartContentType(part);
                        if (!(contentType == null || ContentType.APP_SMIL.equals(contentType) || ContentType.TEXT_PLAIN.equals(contentType))) {
                            textOnly = LOCAL_LOGV;
                        }
                    }
                }
            }
            values.put(BaseMmsColumns.TEXT_ONLY, Integer.valueOf(textOnly ? PROC_STATUS_TRANSIENT_FAILURE : PDU_COLUMN_ID));
            if (values.getAsInteger(BaseMmsColumns.MESSAGE_SIZE) == null) {
                values.put(BaseMmsColumns.MESSAGE_SIZE, Integer.valueOf(messageSize));
            }
            if (existingUri) {
                res = uri;
                SqliteWrapper.update(this.mContext, this.mContentResolver, res, values, null, null);
            } else {
                res = SqliteWrapper.insert(this.mContext, this.mContentResolver, uri, values);
                if (res == null) {
                    throw new MmsException("persist() failed: return null.");
                }
                msgId = ContentUris.parseId(res);
            }
            values = new ContentValues(PROC_STATUS_TRANSIENT_FAILURE);
            values.put(Part.MSG_ID, Long.valueOf(msgId));
            SqliteWrapper.update(this.mContext, this.mContentResolver, Uri.parse("content://mms/" + dummyId + "/part"), values, null, null);
            if (!existingUri) {
                res = Uri.parse(uri + "/" + msgId);
            }
            arr$ = ADDRESS_FIELDS;
            len$ = arr$.length;
            for (i$ = PDU_COLUMN_ID; i$ < len$; i$ += PROC_STATUS_TRANSIENT_FAILURE) {
                addrType = arr$[i$];
                EncodedStringValue[] array2 = (EncodedStringValue[]) hashMap.get(Integer.valueOf(addrType));
                if (array2 != null) {
                    persistAddress(msgId, addrType, array2);
                }
            }
            return res;
        }
        throw new MmsException("Bad destination, must be one of content://mms/inbox, content://mms/sent, content://mms/drafts, content://mms/outbox, content://mms/temp.");
    }

    private void loadRecipients(int addressType, HashSet<String> recipients, HashMap<Integer, EncodedStringValue[]> addressMap, boolean excludeMyNumber) {
        EncodedStringValue[] array = (EncodedStringValue[]) addressMap.get(Integer.valueOf(addressType));
        if (array != null) {
            if (!excludeMyNumber || array.length != PROC_STATUS_TRANSIENT_FAILURE) {
                String myNumber = excludeMyNumber ? this.mTelephonyManager.getLine1Number() : null;
                EncodedStringValue[] arr$ = array;
                int len$ = arr$.length;
                for (int i$ = PDU_COLUMN_ID; i$ < len$; i$ += PROC_STATUS_TRANSIENT_FAILURE) {
                    EncodedStringValue v = arr$[i$];
                    if (v != null) {
                        String number = v.getString();
                        if ((myNumber == null || !PhoneNumberUtils.compare(number, myNumber)) && !recipients.contains(number)) {
                            recipients.add(number);
                        }
                    }
                }
            }
        }
    }

    public Uri move(Uri from, Uri to) throws MmsException {
        long msgId = ContentUris.parseId(from);
        if (msgId == -1) {
            throw new MmsException("Error! ID of the message: -1.");
        }
        Integer msgBox = (Integer) MESSAGE_BOX_MAP.get(to);
        if (msgBox == null) {
            throw new MmsException("Bad destination, must be one of content://mms/inbox, content://mms/sent, content://mms/drafts, content://mms/outbox, content://mms/temp.");
        }
        ContentValues values = new ContentValues(PROC_STATUS_TRANSIENT_FAILURE);
        values.put(BaseMmsColumns.MESSAGE_BOX, msgBox);
        SqliteWrapper.update(this.mContext, this.mContentResolver, from, values, null, null);
        return ContentUris.withAppendedId(to, msgId);
    }

    public static String toIsoString(byte[] bytes) {
        try {
            return new String(bytes, CharacterSets.MIMENAME_ISO_8859_1);
        } catch (UnsupportedEncodingException e) {
            Log.e(TAG, "ISO_8859_1 must be supported!", e);
            return "";
        }
    }

    public static byte[] getBytes(String data) {
        try {
            return data.getBytes(CharacterSets.MIMENAME_ISO_8859_1);
        } catch (UnsupportedEncodingException e) {
            Log.e(TAG, "ISO_8859_1 must be supported!", e);
            return new byte[PDU_COLUMN_ID];
        }
    }

    public void release() {
        SqliteWrapper.delete(this.mContext, this.mContentResolver, Uri.parse(TEMPORARY_DRM_OBJECT_URI), null, null);
    }

    public Cursor getPendingMessages(long dueTime) {
        Builder uriBuilder = PendingMessages.CONTENT_URI.buildUpon();
        uriBuilder.appendQueryParameter(TextBasedSmsColumns.PROTOCOL, "mms");
        String[] selectionArgs = new String[PROC_STATUS_PERMANENTLY_FAILURE];
        selectionArgs[PDU_COLUMN_ID] = String.valueOf(PDU_COLUMN_TRANSACTION_ID);
        selectionArgs[PROC_STATUS_TRANSIENT_FAILURE] = String.valueOf(dueTime);
        return SqliteWrapper.query(this.mContext, this.mContentResolver, uriBuilder.build(), null, "err_type < ? AND due_time <= ?", selectionArgs, PendingMessages.DUE_TIME);
    }
}
