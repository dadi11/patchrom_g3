package android.telecom;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.TextUtils;

public class GatewayInfo implements Parcelable {
    public static final Creator<GatewayInfo> CREATOR;
    private final Uri mGatewayAddress;
    private final String mGatewayProviderPackageName;
    private final Uri mOriginalAddress;

    /* renamed from: android.telecom.GatewayInfo.1 */
    static class C07461 implements Creator<GatewayInfo> {
        C07461() {
        }

        public GatewayInfo createFromParcel(Parcel source) {
            return new GatewayInfo(source.readString(), (Uri) Uri.CREATOR.createFromParcel(source), (Uri) Uri.CREATOR.createFromParcel(source));
        }

        public GatewayInfo[] newArray(int size) {
            return new GatewayInfo[size];
        }
    }

    public GatewayInfo(String packageName, Uri gatewayUri, Uri originalAddress) {
        this.mGatewayProviderPackageName = packageName;
        this.mGatewayAddress = gatewayUri;
        this.mOriginalAddress = originalAddress;
    }

    public String getGatewayProviderPackageName() {
        return this.mGatewayProviderPackageName;
    }

    public Uri getGatewayAddress() {
        return this.mGatewayAddress;
    }

    public Uri getOriginalAddress() {
        return this.mOriginalAddress;
    }

    public boolean isEmpty() {
        return TextUtils.isEmpty(this.mGatewayProviderPackageName) || this.mGatewayAddress == null;
    }

    static {
        CREATOR = new C07461();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel destination, int flags) {
        destination.writeString(this.mGatewayProviderPackageName);
        this.mGatewayAddress.writeToParcel(destination, 0);
        this.mOriginalAddress.writeToParcel(destination, 0);
    }
}
