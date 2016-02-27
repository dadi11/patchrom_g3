package android.hardware.input;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class InputDeviceIdentifier implements Parcelable {
    public static final Creator<InputDeviceIdentifier> CREATOR;
    private final String mDescriptor;
    private final int mProductId;
    private final int mVendorId;

    /* renamed from: android.hardware.input.InputDeviceIdentifier.1 */
    static class C02941 implements Creator<InputDeviceIdentifier> {
        C02941() {
        }

        public InputDeviceIdentifier createFromParcel(Parcel source) {
            return new InputDeviceIdentifier(null);
        }

        public InputDeviceIdentifier[] newArray(int size) {
            return new InputDeviceIdentifier[size];
        }
    }

    public InputDeviceIdentifier(String descriptor, int vendorId, int productId) {
        this.mDescriptor = descriptor;
        this.mVendorId = vendorId;
        this.mProductId = productId;
    }

    private InputDeviceIdentifier(Parcel src) {
        this.mDescriptor = src.readString();
        this.mVendorId = src.readInt();
        this.mProductId = src.readInt();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(this.mDescriptor);
        dest.writeInt(this.mVendorId);
        dest.writeInt(this.mProductId);
    }

    public String getDescriptor() {
        return this.mDescriptor;
    }

    public int getVendorId() {
        return this.mVendorId;
    }

    public int getProductId() {
        return this.mProductId;
    }

    static {
        CREATOR = new C02941();
    }
}
