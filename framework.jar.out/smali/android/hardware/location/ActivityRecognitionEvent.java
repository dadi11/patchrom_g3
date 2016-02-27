package android.hardware.location;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class ActivityRecognitionEvent implements Parcelable {
    public static final Creator<ActivityRecognitionEvent> CREATOR;
    private final String mActivity;
    private final int mEventType;
    private final long mTimestampNs;

    /* renamed from: android.hardware.location.ActivityRecognitionEvent.1 */
    static class C02991 implements Creator<ActivityRecognitionEvent> {
        C02991() {
        }

        public ActivityRecognitionEvent createFromParcel(Parcel source) {
            return new ActivityRecognitionEvent(source.readString(), source.readInt(), source.readLong());
        }

        public ActivityRecognitionEvent[] newArray(int size) {
            return new ActivityRecognitionEvent[size];
        }
    }

    public ActivityRecognitionEvent(String activity, int eventType, long timestampNs) {
        this.mActivity = activity;
        this.mEventType = eventType;
        this.mTimestampNs = timestampNs;
    }

    public String getActivity() {
        return this.mActivity;
    }

    public int getEventType() {
        return this.mEventType;
    }

    public long getTimestampNs() {
        return this.mTimestampNs;
    }

    static {
        CREATOR = new C02991();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel parcel, int flags) {
        parcel.writeString(this.mActivity);
        parcel.writeInt(this.mEventType);
        parcel.writeLong(this.mTimestampNs);
    }

    public String toString() {
        return String.format("Activity='%s', EventType=%s, TimestampNs=%s", new Object[]{this.mActivity, Integer.valueOf(this.mEventType), Long.valueOf(this.mTimestampNs)});
    }
}
