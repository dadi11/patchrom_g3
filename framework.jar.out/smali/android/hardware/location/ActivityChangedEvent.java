package android.hardware.location;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.security.InvalidParameterException;
import java.util.Arrays;
import java.util.List;

public class ActivityChangedEvent implements Parcelable {
    public static final Creator<ActivityChangedEvent> CREATOR;
    private final List<ActivityRecognitionEvent> mActivityRecognitionEvents;

    /* renamed from: android.hardware.location.ActivityChangedEvent.1 */
    static class C02981 implements Creator<ActivityChangedEvent> {
        C02981() {
        }

        public ActivityChangedEvent createFromParcel(Parcel source) {
            ActivityRecognitionEvent[] activityRecognitionEvents = new ActivityRecognitionEvent[source.readInt()];
            source.readTypedArray(activityRecognitionEvents, ActivityRecognitionEvent.CREATOR);
            return new ActivityChangedEvent(activityRecognitionEvents);
        }

        public ActivityChangedEvent[] newArray(int size) {
            return new ActivityChangedEvent[size];
        }
    }

    public ActivityChangedEvent(ActivityRecognitionEvent[] activityRecognitionEvents) {
        if (activityRecognitionEvents == null) {
            throw new InvalidParameterException("Parameter 'activityRecognitionEvents' must not be null.");
        }
        this.mActivityRecognitionEvents = Arrays.asList(activityRecognitionEvents);
    }

    public Iterable<ActivityRecognitionEvent> getActivityRecognitionEvents() {
        return this.mActivityRecognitionEvents;
    }

    static {
        CREATOR = new C02981();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel parcel, int flags) {
        ActivityRecognitionEvent[] activityRecognitionEventArray = (ActivityRecognitionEvent[]) this.mActivityRecognitionEvents.toArray(new ActivityRecognitionEvent[0]);
        parcel.writeInt(activityRecognitionEventArray.length);
        parcel.writeTypedArray(activityRecognitionEventArray, flags);
    }

    public String toString() {
        StringBuilder builder = new StringBuilder("[ ActivityChangedEvent:");
        for (ActivityRecognitionEvent event : this.mActivityRecognitionEvents) {
            builder.append("\n    ");
            builder.append(event.toString());
        }
        builder.append("\n]");
        return builder.toString();
    }
}
