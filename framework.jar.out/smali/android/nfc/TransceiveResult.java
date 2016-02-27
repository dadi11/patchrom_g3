package android.nfc;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.io.IOException;

public final class TransceiveResult implements Parcelable {
    public static final Creator<TransceiveResult> CREATOR;
    public static final int RESULT_EXCEEDED_LENGTH = 3;
    public static final int RESULT_FAILURE = 1;
    public static final int RESULT_SUCCESS = 0;
    public static final int RESULT_TAGLOST = 2;
    final byte[] mResponseData;
    final int mResult;

    /* renamed from: android.nfc.TransceiveResult.1 */
    static class C05691 implements Creator<TransceiveResult> {
        C05691() {
        }

        public TransceiveResult createFromParcel(Parcel in) {
            byte[] responseData;
            int result = in.readInt();
            if (result == 0) {
                responseData = new byte[in.readInt()];
                in.readByteArray(responseData);
            } else {
                responseData = null;
            }
            return new TransceiveResult(result, responseData);
        }

        public TransceiveResult[] newArray(int size) {
            return new TransceiveResult[size];
        }
    }

    public TransceiveResult(int result, byte[] data) {
        this.mResult = result;
        this.mResponseData = data;
    }

    public byte[] getResponseOrThrow() throws IOException {
        switch (this.mResult) {
            case RESULT_SUCCESS /*0*/:
                return this.mResponseData;
            case RESULT_TAGLOST /*2*/:
                throw new TagLostException("Tag was lost.");
            case RESULT_EXCEEDED_LENGTH /*3*/:
                throw new IOException("Transceive length exceeds supported maximum");
            default:
                throw new IOException("Transceive failed");
        }
    }

    public int describeContents() {
        return RESULT_SUCCESS;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mResult);
        if (this.mResult == 0) {
            dest.writeInt(this.mResponseData.length);
            dest.writeByteArray(this.mResponseData);
        }
    }

    static {
        CREATOR = new C05691();
    }
}
