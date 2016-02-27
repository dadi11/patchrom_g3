package android.net.wifi;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.ArrayList;
import java.util.List;

public class BatchedScanResult implements Parcelable {
    public static final Creator<BatchedScanResult> CREATOR;
    private static final String TAG = "BatchedScanResult";
    public final List<ScanResult> scanResults;
    public boolean truncated;

    /* renamed from: android.net.wifi.BatchedScanResult.1 */
    static class C05201 implements Creator<BatchedScanResult> {
        C05201() {
        }

        public BatchedScanResult createFromParcel(Parcel in) {
            boolean z = true;
            BatchedScanResult result = new BatchedScanResult();
            if (in.readInt() != 1) {
                z = false;
            }
            result.truncated = z;
            int count = in.readInt();
            while (true) {
                int count2 = count - 1;
                if (count <= 0) {
                    return result;
                }
                result.scanResults.add(ScanResult.CREATOR.createFromParcel(in));
                count = count2;
            }
        }

        public BatchedScanResult[] newArray(int size) {
            return new BatchedScanResult[size];
        }
    }

    public BatchedScanResult() {
        this.scanResults = new ArrayList();
    }

    public BatchedScanResult(BatchedScanResult source) {
        this.scanResults = new ArrayList();
        this.truncated = source.truncated;
        for (ScanResult s : source.scanResults) {
            this.scanResults.add(new ScanResult(s));
        }
    }

    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("BatchedScanResult: ").append("truncated: ").append(String.valueOf(this.truncated)).append("scanResults: [");
        for (ScanResult s : this.scanResults) {
            sb.append(" <").append(s.toString()).append("> ");
        }
        sb.append(" ]");
        return sb.toString();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.truncated ? 1 : 0);
        dest.writeInt(this.scanResults.size());
        for (ScanResult s : this.scanResults) {
            s.writeToParcel(dest, flags);
        }
    }

    static {
        CREATOR = new C05201();
    }
}
