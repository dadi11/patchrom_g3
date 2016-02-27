package android.content;

import android.accounts.Account;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class SyncInfo implements Parcelable {
    public static final Creator<SyncInfo> CREATOR;
    public final Account account;
    public final String authority;
    public final int authorityId;
    public final long startTime;

    /* renamed from: android.content.SyncInfo.1 */
    static class C01091 implements Creator<SyncInfo> {
        C01091() {
        }

        public SyncInfo createFromParcel(Parcel in) {
            return new SyncInfo(in);
        }

        public SyncInfo[] newArray(int size) {
            return new SyncInfo[size];
        }
    }

    public SyncInfo(int authorityId, Account account, String authority, long startTime) {
        this.authorityId = authorityId;
        this.account = account;
        this.authority = authority;
        this.startTime = startTime;
    }

    public SyncInfo(SyncInfo other) {
        this.authorityId = other.authorityId;
        this.account = new Account(other.account.name, other.account.type);
        this.authority = other.authority;
        this.startTime = other.startTime;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel parcel, int flags) {
        parcel.writeInt(this.authorityId);
        parcel.writeParcelable(this.account, flags);
        parcel.writeString(this.authority);
        parcel.writeLong(this.startTime);
    }

    SyncInfo(Parcel parcel) {
        this.authorityId = parcel.readInt();
        this.account = (Account) parcel.readParcelable(Account.class.getClassLoader());
        this.authority = parcel.readString();
        this.startTime = parcel.readLong();
    }

    static {
        CREATOR = new C01091();
    }
}
