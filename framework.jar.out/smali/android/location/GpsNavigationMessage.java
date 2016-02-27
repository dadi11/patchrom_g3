package android.location;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;
import android.widget.Toast;
import java.security.InvalidParameterException;

public class GpsNavigationMessage implements Parcelable {
    public static final Creator<GpsNavigationMessage> CREATOR;
    private static final byte[] EMPTY_ARRAY;
    private static final String TAG = "GpsNavigationMessage";
    public static final byte TYPE_CNAV2 = (byte) 4;
    public static final byte TYPE_L1CA = (byte) 1;
    public static final byte TYPE_L2CNAV = (byte) 2;
    public static final byte TYPE_L5CNAV = (byte) 3;
    public static final byte TYPE_UNKNOWN = (byte) 0;
    private byte[] mData;
    private short mMessageId;
    private byte mPrn;
    private short mSubmessageId;
    private byte mType;

    /* renamed from: android.location.GpsNavigationMessage.1 */
    static class C03411 implements Creator<GpsNavigationMessage> {
        C03411() {
        }

        public GpsNavigationMessage createFromParcel(Parcel parcel) {
            GpsNavigationMessage navigationMessage = new GpsNavigationMessage();
            navigationMessage.setType(parcel.readByte());
            navigationMessage.setPrn(parcel.readByte());
            navigationMessage.setMessageId((short) parcel.readInt());
            navigationMessage.setSubmessageId((short) parcel.readInt());
            byte[] data = new byte[parcel.readInt()];
            parcel.readByteArray(data);
            navigationMessage.setData(data);
            return navigationMessage;
        }

        public GpsNavigationMessage[] newArray(int size) {
            return new GpsNavigationMessage[size];
        }
    }

    static {
        EMPTY_ARRAY = new byte[0];
        CREATOR = new C03411();
    }

    GpsNavigationMessage() {
        initialize();
    }

    public void set(GpsNavigationMessage navigationMessage) {
        this.mType = navigationMessage.mType;
        this.mPrn = navigationMessage.mPrn;
        this.mMessageId = navigationMessage.mMessageId;
        this.mSubmessageId = navigationMessage.mSubmessageId;
        this.mData = navigationMessage.mData;
    }

    public void reset() {
        initialize();
    }

    public byte getType() {
        return this.mType;
    }

    public void setType(byte value) {
        switch (value) {
            case Toast.LENGTH_SHORT /*0*/:
            case Toast.LENGTH_LONG /*1*/:
            case Action.MERGE_IGNORE /*2*/:
            case SetDrawableParameters.TAG /*3*/:
            case ViewGroupAction.TAG /*4*/:
                this.mType = value;
            default:
                Log.d(TAG, "Sanitizing invalid 'type': " + value);
                this.mType = (byte) 0;
        }
    }

    private String getTypeString() {
        switch (this.mType) {
            case Toast.LENGTH_SHORT /*0*/:
                return "Unknown";
            case Toast.LENGTH_LONG /*1*/:
                return "L1 C/A";
            case Action.MERGE_IGNORE /*2*/:
                return "L2-CNAV";
            case SetDrawableParameters.TAG /*3*/:
                return "L5-CNAV";
            case ViewGroupAction.TAG /*4*/:
                return "CNAV-2";
            default:
                return "<Invalid>";
        }
    }

    public byte getPrn() {
        return this.mPrn;
    }

    public void setPrn(byte value) {
        this.mPrn = value;
    }

    public short getMessageId() {
        return this.mMessageId;
    }

    public void setMessageId(short value) {
        this.mMessageId = value;
    }

    public short getSubmessageId() {
        return this.mSubmessageId;
    }

    public void setSubmessageId(short value) {
        this.mSubmessageId = value;
    }

    public byte[] getData() {
        return this.mData;
    }

    public void setData(byte[] value) {
        if (value == null) {
            throw new InvalidParameterException("Data must be a non-null array");
        }
        this.mData = value;
    }

    public void writeToParcel(Parcel parcel, int flags) {
        parcel.writeByte(this.mType);
        parcel.writeByte(this.mPrn);
        parcel.writeInt(this.mMessageId);
        parcel.writeInt(this.mSubmessageId);
        parcel.writeInt(this.mData.length);
        parcel.writeByteArray(this.mData);
    }

    public int describeContents() {
        return 0;
    }

    public String toString() {
        String format = "   %-15s = %s\n";
        StringBuilder builder = new StringBuilder("GpsNavigationMessage:\n");
        builder.append(String.format("   %-15s = %s\n", new Object[]{"Type", getTypeString()}));
        builder.append(String.format("   %-15s = %s\n", new Object[]{"Prn", Byte.valueOf(this.mPrn)}));
        builder.append(String.format("   %-15s = %s\n", new Object[]{"MessageId", Short.valueOf(this.mMessageId)}));
        builder.append(String.format("   %-15s = %s\n", new Object[]{"SubmessageId", Short.valueOf(this.mSubmessageId)}));
        builder.append(String.format("   %-15s = %s\n", new Object[]{"Data", "{"}));
        String prefix = "        ";
        for (byte value : this.mData) {
            builder.append(prefix);
            builder.append(value);
            prefix = ", ";
        }
        builder.append(" }");
        return builder.toString();
    }

    private void initialize() {
        this.mType = (byte) 0;
        this.mPrn = (byte) 0;
        this.mMessageId = (short) -1;
        this.mSubmessageId = (short) -1;
        this.mData = EMPTY_ARRAY;
    }
}
