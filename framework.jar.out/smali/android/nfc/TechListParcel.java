package android.nfc;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class TechListParcel implements Parcelable {
    public static final Creator<TechListParcel> CREATOR;
    private String[][] mTechLists;

    /* renamed from: android.nfc.TechListParcel.1 */
    static class C05681 implements Creator<TechListParcel> {
        C05681() {
        }

        public TechListParcel createFromParcel(Parcel source) {
            int count = source.readInt();
            String[][] techLists = new String[count][];
            for (int i = 0; i < count; i++) {
                techLists[i] = source.readStringArray();
            }
            return new TechListParcel(techLists);
        }

        public TechListParcel[] newArray(int size) {
            return new TechListParcel[size];
        }
    }

    public TechListParcel(String[]... strings) {
        this.mTechLists = strings;
    }

    public String[][] getTechLists() {
        return this.mTechLists;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(count);
        for (String[] techList : this.mTechLists) {
            dest.writeStringArray(techList);
        }
    }

    static {
        CREATOR = new C05681();
    }
}
