package android.hardware.usb;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class UsbAccessory implements Parcelable {
    public static final Creator<UsbAccessory> CREATOR;
    public static final int DESCRIPTION_STRING = 2;
    public static final int MANUFACTURER_STRING = 0;
    public static final int MODEL_STRING = 1;
    public static final int SERIAL_STRING = 5;
    private static final String TAG = "UsbAccessory";
    public static final int URI_STRING = 4;
    public static final int VERSION_STRING = 3;
    private final String mDescription;
    private final String mManufacturer;
    private final String mModel;
    private final String mSerial;
    private final String mUri;
    private final String mVersion;

    /* renamed from: android.hardware.usb.UsbAccessory.1 */
    static class C03161 implements Creator<UsbAccessory> {
        C03161() {
        }

        public UsbAccessory createFromParcel(Parcel in) {
            return new UsbAccessory(in.readString(), in.readString(), in.readString(), in.readString(), in.readString(), in.readString());
        }

        public UsbAccessory[] newArray(int size) {
            return new UsbAccessory[size];
        }
    }

    public UsbAccessory(String manufacturer, String model, String description, String version, String uri, String serial) {
        this.mManufacturer = manufacturer;
        this.mModel = model;
        this.mDescription = description;
        this.mVersion = version;
        this.mUri = uri;
        this.mSerial = serial;
    }

    public UsbAccessory(String[] strings) {
        this.mManufacturer = strings[MANUFACTURER_STRING];
        this.mModel = strings[MODEL_STRING];
        this.mDescription = strings[DESCRIPTION_STRING];
        this.mVersion = strings[VERSION_STRING];
        this.mUri = strings[URI_STRING];
        this.mSerial = strings[SERIAL_STRING];
    }

    public String getManufacturer() {
        return this.mManufacturer;
    }

    public String getModel() {
        return this.mModel;
    }

    public String getDescription() {
        return this.mDescription;
    }

    public String getVersion() {
        return this.mVersion;
    }

    public String getUri() {
        return this.mUri;
    }

    public String getSerial() {
        return this.mSerial;
    }

    private static boolean compare(String s1, String s2) {
        if (s1 == null) {
            return s2 == null;
        } else {
            return s1.equals(s2);
        }
    }

    public boolean equals(Object obj) {
        if (!(obj instanceof UsbAccessory)) {
            return false;
        }
        UsbAccessory accessory = (UsbAccessory) obj;
        if (compare(this.mManufacturer, accessory.getManufacturer()) && compare(this.mModel, accessory.getModel()) && compare(this.mDescription, accessory.getDescription()) && compare(this.mVersion, accessory.getVersion()) && compare(this.mUri, accessory.getUri()) && compare(this.mSerial, accessory.getSerial())) {
            return true;
        }
        return false;
    }

    public int hashCode() {
        int i = MANUFACTURER_STRING;
        int hashCode = (this.mUri == null ? MANUFACTURER_STRING : this.mUri.hashCode()) ^ ((((this.mModel == null ? MANUFACTURER_STRING : this.mModel.hashCode()) ^ (this.mManufacturer == null ? MANUFACTURER_STRING : this.mManufacturer.hashCode())) ^ (this.mDescription == null ? MANUFACTURER_STRING : this.mDescription.hashCode())) ^ (this.mVersion == null ? MANUFACTURER_STRING : this.mVersion.hashCode()));
        if (this.mSerial != null) {
            i = this.mSerial.hashCode();
        }
        return hashCode ^ i;
    }

    public String toString() {
        return "UsbAccessory[mManufacturer=" + this.mManufacturer + ", mModel=" + this.mModel + ", mDescription=" + this.mDescription + ", mVersion=" + this.mVersion + ", mUri=" + this.mUri + ", mSerial=" + this.mSerial + "]";
    }

    static {
        CREATOR = new C03161();
    }

    public int describeContents() {
        return MANUFACTURER_STRING;
    }

    public void writeToParcel(Parcel parcel, int flags) {
        parcel.writeString(this.mManufacturer);
        parcel.writeString(this.mModel);
        parcel.writeString(this.mDescription);
        parcel.writeString(this.mVersion);
        parcel.writeString(this.mUri);
        parcel.writeString(this.mSerial);
    }
}
