package android.telephony;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.provider.Telephony.CellBroadcasts;
import android.provider.Telephony.Mms.Part;
import android.provider.Telephony.TextBasedSmsColumns;
import android.provider.Telephony.ThreadsColumns;
import android.text.format.DateUtils;

public class CellBroadcastMessage implements Parcelable {
    public static final Creator<CellBroadcastMessage> CREATOR;
    public static final String SMS_CB_MESSAGE_EXTRA = "com.android.cellbroadcastreceiver.SMS_CB_MESSAGE";
    private final long mDeliveryTime;
    private boolean mIsRead;
    private final SmsCbMessage mSmsCbMessage;
    private int mSubId;

    /* renamed from: android.telephony.CellBroadcastMessage.1 */
    static class C00011 implements Creator<CellBroadcastMessage> {
        C00011() {
        }

        public CellBroadcastMessage createFromParcel(Parcel in) {
            return new CellBroadcastMessage(null);
        }

        public CellBroadcastMessage[] newArray(int size) {
            return new CellBroadcastMessage[size];
        }
    }

    public void setSubId(int subId) {
        this.mSubId = subId;
    }

    public int getSubId() {
        return this.mSubId;
    }

    public CellBroadcastMessage(SmsCbMessage message) {
        this.mSubId = 0;
        this.mSmsCbMessage = message;
        this.mDeliveryTime = System.currentTimeMillis();
        this.mIsRead = false;
    }

    private CellBroadcastMessage(SmsCbMessage message, long deliveryTime, boolean isRead) {
        this.mSubId = 0;
        this.mSmsCbMessage = message;
        this.mDeliveryTime = deliveryTime;
        this.mIsRead = isRead;
    }

    private CellBroadcastMessage(Parcel in) {
        boolean z = false;
        this.mSubId = 0;
        this.mSmsCbMessage = new SmsCbMessage(in);
        this.mDeliveryTime = in.readLong();
        if (in.readInt() != 0) {
            z = true;
        }
        this.mIsRead = z;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        this.mSmsCbMessage.writeToParcel(out, flags);
        out.writeLong(this.mDeliveryTime);
        out.writeInt(this.mIsRead ? 1 : 0);
    }

    static {
        CREATOR = new C00011();
    }

    public static CellBroadcastMessage createFromCursor(Cursor cursor) {
        String plmn;
        int lac;
        int cid;
        SmsCbEtwsInfo etwsInfo;
        SmsCbCmasInfo cmasInfo;
        int geoScope = cursor.getInt(cursor.getColumnIndexOrThrow(CellBroadcasts.GEOGRAPHICAL_SCOPE));
        int serialNum = cursor.getInt(cursor.getColumnIndexOrThrow(CellBroadcasts.SERIAL_NUMBER));
        int category = cursor.getInt(cursor.getColumnIndexOrThrow(CellBroadcasts.SERVICE_CATEGORY));
        String language = cursor.getString(cursor.getColumnIndexOrThrow(CellBroadcasts.LANGUAGE_CODE));
        String body = cursor.getString(cursor.getColumnIndexOrThrow(TextBasedSmsColumns.BODY));
        int format = cursor.getInt(cursor.getColumnIndexOrThrow(CellBroadcasts.MESSAGE_FORMAT));
        int priority = cursor.getInt(cursor.getColumnIndexOrThrow(CellBroadcasts.MESSAGE_PRIORITY));
        int plmnColumn = cursor.getColumnIndex(CellBroadcasts.PLMN);
        if (plmnColumn == -1 || cursor.isNull(plmnColumn)) {
            plmn = null;
        } else {
            plmn = cursor.getString(plmnColumn);
        }
        int lacColumn = cursor.getColumnIndex(CellBroadcasts.LAC);
        if (lacColumn == -1 || cursor.isNull(lacColumn)) {
            lac = -1;
        } else {
            lac = cursor.getInt(lacColumn);
        }
        int cidColumn = cursor.getColumnIndex(Part.CONTENT_ID);
        if (cidColumn == -1 || cursor.isNull(cidColumn)) {
            cid = -1;
        } else {
            cid = cursor.getInt(cidColumn);
        }
        SmsCbLocation smsCbLocation = new SmsCbLocation(plmn, lac, cid);
        int etwsWarningTypeColumn = cursor.getColumnIndex(CellBroadcasts.ETWS_WARNING_TYPE);
        if (etwsWarningTypeColumn == -1 || cursor.isNull(etwsWarningTypeColumn)) {
            etwsInfo = null;
        } else {
            SmsCbEtwsInfo smsCbEtwsInfo = new SmsCbEtwsInfo(cursor.getInt(etwsWarningTypeColumn), false, false, null);
        }
        int cmasMessageClassColumn = cursor.getColumnIndex(CellBroadcasts.CMAS_MESSAGE_CLASS);
        if (cmasMessageClassColumn == -1 || cursor.isNull(cmasMessageClassColumn)) {
            cmasInfo = null;
        } else {
            int cmasCategory;
            int responseType;
            int severity;
            int urgency;
            int certainty;
            int messageClass = cursor.getInt(cmasMessageClassColumn);
            int cmasCategoryColumn = cursor.getColumnIndex(CellBroadcasts.CMAS_CATEGORY);
            if (cmasCategoryColumn == -1 || cursor.isNull(cmasCategoryColumn)) {
                cmasCategory = -1;
            } else {
                cmasCategory = cursor.getInt(cmasCategoryColumn);
            }
            int cmasResponseTypeColumn = cursor.getColumnIndex(CellBroadcasts.CMAS_RESPONSE_TYPE);
            if (cmasResponseTypeColumn == -1 || cursor.isNull(cmasResponseTypeColumn)) {
                responseType = -1;
            } else {
                responseType = cursor.getInt(cmasResponseTypeColumn);
            }
            int cmasSeverityColumn = cursor.getColumnIndex(CellBroadcasts.CMAS_SEVERITY);
            if (cmasSeverityColumn == -1 || cursor.isNull(cmasSeverityColumn)) {
                severity = -1;
            } else {
                severity = cursor.getInt(cmasSeverityColumn);
            }
            int cmasUrgencyColumn = cursor.getColumnIndex(CellBroadcasts.CMAS_URGENCY);
            if (cmasUrgencyColumn == -1 || cursor.isNull(cmasUrgencyColumn)) {
                urgency = -1;
            } else {
                urgency = cursor.getInt(cmasUrgencyColumn);
            }
            int cmasCertaintyColumn = cursor.getColumnIndex(CellBroadcasts.CMAS_CERTAINTY);
            if (cmasCertaintyColumn == -1 || cursor.isNull(cmasCertaintyColumn)) {
                certainty = -1;
            } else {
                certainty = cursor.getInt(cmasCertaintyColumn);
            }
            cmasInfo = new SmsCbCmasInfo(messageClass, cmasCategory, responseType, severity, urgency, certainty);
        }
        return new CellBroadcastMessage(new SmsCbMessage(format, geoScope, serialNum, smsCbLocation, category, language, body, priority, etwsInfo, cmasInfo), cursor.getLong(cursor.getColumnIndexOrThrow(ThreadsColumns.DATE)), cursor.getInt(cursor.getColumnIndexOrThrow(SmsManager.MESSAGE_STATUS_READ)) != 0);
    }

    public ContentValues getContentValues() {
        ContentValues cv = new ContentValues(16);
        SmsCbMessage msg = this.mSmsCbMessage;
        cv.put(CellBroadcasts.GEOGRAPHICAL_SCOPE, Integer.valueOf(msg.getGeographicalScope()));
        SmsCbLocation location = msg.getLocation();
        if (location.getPlmn() != null) {
            cv.put(CellBroadcasts.PLMN, location.getPlmn());
        }
        if (location.getLac() != -1) {
            cv.put(CellBroadcasts.LAC, Integer.valueOf(location.getLac()));
        }
        if (location.getCid() != -1) {
            cv.put(Part.CONTENT_ID, Integer.valueOf(location.getCid()));
        }
        cv.put(CellBroadcasts.SERIAL_NUMBER, Integer.valueOf(msg.getSerialNumber()));
        cv.put(CellBroadcasts.SERVICE_CATEGORY, Integer.valueOf(msg.getServiceCategory()));
        cv.put(CellBroadcasts.LANGUAGE_CODE, msg.getLanguageCode());
        cv.put(TextBasedSmsColumns.BODY, msg.getMessageBody());
        cv.put(ThreadsColumns.DATE, Long.valueOf(this.mDeliveryTime));
        cv.put(SmsManager.MESSAGE_STATUS_READ, Boolean.valueOf(this.mIsRead));
        cv.put(CellBroadcasts.MESSAGE_FORMAT, Integer.valueOf(msg.getMessageFormat()));
        cv.put(CellBroadcasts.MESSAGE_PRIORITY, Integer.valueOf(msg.getMessagePriority()));
        SmsCbEtwsInfo etwsInfo = this.mSmsCbMessage.getEtwsWarningInfo();
        if (etwsInfo != null) {
            cv.put(CellBroadcasts.ETWS_WARNING_TYPE, Integer.valueOf(etwsInfo.getWarningType()));
        }
        SmsCbCmasInfo cmasInfo = this.mSmsCbMessage.getCmasWarningInfo();
        if (cmasInfo != null) {
            cv.put(CellBroadcasts.CMAS_MESSAGE_CLASS, Integer.valueOf(cmasInfo.getMessageClass()));
            cv.put(CellBroadcasts.CMAS_CATEGORY, Integer.valueOf(cmasInfo.getCategory()));
            cv.put(CellBroadcasts.CMAS_RESPONSE_TYPE, Integer.valueOf(cmasInfo.getResponseType()));
            cv.put(CellBroadcasts.CMAS_SEVERITY, Integer.valueOf(cmasInfo.getSeverity()));
            cv.put(CellBroadcasts.CMAS_URGENCY, Integer.valueOf(cmasInfo.getUrgency()));
            cv.put(CellBroadcasts.CMAS_CERTAINTY, Integer.valueOf(cmasInfo.getCertainty()));
        }
        return cv;
    }

    public void setIsRead(boolean isRead) {
        this.mIsRead = isRead;
    }

    public String getLanguageCode() {
        return this.mSmsCbMessage.getLanguageCode();
    }

    public int getServiceCategory() {
        return this.mSmsCbMessage.getServiceCategory();
    }

    public long getDeliveryTime() {
        return this.mDeliveryTime;
    }

    public String getMessageBody() {
        return this.mSmsCbMessage.getMessageBody();
    }

    public boolean isRead() {
        return this.mIsRead;
    }

    public int getSerialNumber() {
        return this.mSmsCbMessage.getSerialNumber();
    }

    public SmsCbCmasInfo getCmasWarningInfo() {
        return this.mSmsCbMessage.getCmasWarningInfo();
    }

    public SmsCbEtwsInfo getEtwsWarningInfo() {
        return this.mSmsCbMessage.getEtwsWarningInfo();
    }

    public boolean isPublicAlertMessage() {
        return this.mSmsCbMessage.isEmergencyMessage();
    }

    public boolean isEmergencyAlertMessage() {
        return this.mSmsCbMessage.isEmergencyMessage();
    }

    public boolean isEtwsMessage() {
        return this.mSmsCbMessage.isEtwsMessage();
    }

    public boolean isCmasMessage() {
        return this.mSmsCbMessage.isCmasMessage();
    }

    public int getCmasMessageClass() {
        if (this.mSmsCbMessage.isCmasMessage()) {
            return this.mSmsCbMessage.getCmasWarningInfo().getMessageClass();
        }
        return -1;
    }

    public boolean isEtwsPopupAlert() {
        SmsCbEtwsInfo etwsInfo = this.mSmsCbMessage.getEtwsWarningInfo();
        return etwsInfo != null && etwsInfo.isPopupAlert();
    }

    public boolean isEtwsEmergencyUserAlert() {
        SmsCbEtwsInfo etwsInfo = this.mSmsCbMessage.getEtwsWarningInfo();
        return etwsInfo != null && etwsInfo.isEmergencyUserAlert();
    }

    public boolean isEtwsTestMessage() {
        SmsCbEtwsInfo etwsInfo = this.mSmsCbMessage.getEtwsWarningInfo();
        return etwsInfo != null && etwsInfo.getWarningType() == 3;
    }

    public String getDateString(Context context) {
        return DateUtils.formatDateTime(context, this.mDeliveryTime, 527121);
    }

    public String getSpokenDateString(Context context) {
        return DateUtils.formatDateTime(context, this.mDeliveryTime, 17);
    }
}
