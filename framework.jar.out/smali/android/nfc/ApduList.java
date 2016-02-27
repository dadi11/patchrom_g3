package android.nfc;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ApduList implements Parcelable {
    public static final Creator<ApduList> CREATOR;
    private ArrayList<byte[]> commands;

    /* renamed from: android.nfc.ApduList.1 */
    static class C05611 implements Creator<ApduList> {
        C05611() {
        }

        public ApduList createFromParcel(Parcel in) {
            return new ApduList(null);
        }

        public ApduList[] newArray(int size) {
            return new ApduList[size];
        }
    }

    public ApduList() {
        this.commands = new ArrayList();
    }

    public void add(byte[] command) {
        this.commands.add(command);
    }

    public List<byte[]> get() {
        return this.commands;
    }

    static {
        CREATOR = new C05611();
    }

    private ApduList(Parcel in) {
        this.commands = new ArrayList();
        int count = in.readInt();
        for (int i = 0; i < count; i++) {
            byte[] cmd = new byte[in.readInt()];
            in.readByteArray(cmd);
            this.commands.add(cmd);
        }
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.commands.size());
        Iterator i$ = this.commands.iterator();
        while (i$.hasNext()) {
            byte[] cmd = (byte[]) i$.next();
            dest.writeInt(cmd.length);
            dest.writeByteArray(cmd);
        }
    }
}
