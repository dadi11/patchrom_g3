package android.view.inputmethod;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class ExtractedTextRequest implements Parcelable {
    public static final Creator<ExtractedTextRequest> CREATOR;
    public int flags;
    public int hintMaxChars;
    public int hintMaxLines;
    public int token;

    /* renamed from: android.view.inputmethod.ExtractedTextRequest.1 */
    static class C08941 implements Creator<ExtractedTextRequest> {
        C08941() {
        }

        public ExtractedTextRequest createFromParcel(Parcel source) {
            ExtractedTextRequest res = new ExtractedTextRequest();
            res.token = source.readInt();
            res.flags = source.readInt();
            res.hintMaxLines = source.readInt();
            res.hintMaxChars = source.readInt();
            return res;
        }

        public ExtractedTextRequest[] newArray(int size) {
            return new ExtractedTextRequest[size];
        }
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.token);
        dest.writeInt(this.flags);
        dest.writeInt(this.hintMaxLines);
        dest.writeInt(this.hintMaxChars);
    }

    static {
        CREATOR = new C08941();
    }

    public int describeContents() {
        return 0;
    }
}
