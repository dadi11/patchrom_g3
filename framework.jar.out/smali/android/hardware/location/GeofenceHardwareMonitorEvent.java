package android.hardware.location;

import android.location.Location;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class GeofenceHardwareMonitorEvent implements Parcelable {
    public static final Creator<GeofenceHardwareMonitorEvent> CREATOR;
    private final Location mLocation;
    private final int mMonitoringStatus;
    private final int mMonitoringType;
    private final int mSourceTechnologies;

    /* renamed from: android.hardware.location.GeofenceHardwareMonitorEvent.1 */
    static class C03031 implements Creator<GeofenceHardwareMonitorEvent> {
        C03031() {
        }

        public GeofenceHardwareMonitorEvent createFromParcel(Parcel source) {
            return new GeofenceHardwareMonitorEvent(source.readInt(), source.readInt(), source.readInt(), (Location) source.readParcelable(GeofenceHardwareMonitorEvent.class.getClassLoader()));
        }

        public GeofenceHardwareMonitorEvent[] newArray(int size) {
            return new GeofenceHardwareMonitorEvent[size];
        }
    }

    public GeofenceHardwareMonitorEvent(int monitoringType, int monitoringStatus, int sourceTechnologies, Location location) {
        this.mMonitoringType = monitoringType;
        this.mMonitoringStatus = monitoringStatus;
        this.mSourceTechnologies = sourceTechnologies;
        this.mLocation = location;
    }

    public int getMonitoringType() {
        return this.mMonitoringType;
    }

    public int getMonitoringStatus() {
        return this.mMonitoringStatus;
    }

    public int getSourceTechnologies() {
        return this.mSourceTechnologies;
    }

    public Location getLocation() {
        return this.mLocation;
    }

    static {
        CREATOR = new C03031();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel parcel, int flags) {
        parcel.writeInt(this.mMonitoringType);
        parcel.writeInt(this.mMonitoringStatus);
        parcel.writeInt(this.mSourceTechnologies);
        parcel.writeParcelable(this.mLocation, flags);
    }

    public String toString() {
        return String.format("GeofenceHardwareMonitorEvent: type=%d, status=%d, sources=%d, location=%s", new Object[]{Integer.valueOf(this.mMonitoringType), Integer.valueOf(this.mMonitoringStatus), Integer.valueOf(this.mSourceTechnologies), this.mLocation});
    }
}
