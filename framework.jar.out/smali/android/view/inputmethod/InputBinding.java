package android.view.inputmethod;

import android.os.IBinder;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class InputBinding implements Parcelable {
    public static final Creator<InputBinding> CREATOR;
    static final String TAG = "InputBinding";
    final InputConnection mConnection;
    final IBinder mConnectionToken;
    final int mPid;
    final int mUid;

    /* renamed from: android.view.inputmethod.InputBinding.1 */
    static class C08951 implements Creator<InputBinding> {
        C08951() {
        }

        public InputBinding createFromParcel(Parcel source) {
            return new InputBinding(source);
        }

        public InputBinding[] newArray(int size) {
            return new InputBinding[size];
        }
    }

    public InputBinding(InputConnection conn, IBinder connToken, int uid, int pid) {
        this.mConnection = conn;
        this.mConnectionToken = connToken;
        this.mUid = uid;
        this.mPid = pid;
    }

    public InputBinding(InputConnection conn, InputBinding binding) {
        this.mConnection = conn;
        this.mConnectionToken = binding.getConnectionToken();
        this.mUid = binding.getUid();
        this.mPid = binding.getPid();
    }

    InputBinding(Parcel source) {
        this.mConnection = null;
        this.mConnectionToken = source.readStrongBinder();
        this.mUid = source.readInt();
        this.mPid = source.readInt();
    }

    public InputConnection getConnection() {
        return this.mConnection;
    }

    public IBinder getConnectionToken() {
        return this.mConnectionToken;
    }

    public int getUid() {
        return this.mUid;
    }

    public int getPid() {
        return this.mPid;
    }

    public String toString() {
        return "InputBinding{" + this.mConnectionToken + " / uid " + this.mUid + " / pid " + this.mPid + "}";
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeStrongBinder(this.mConnectionToken);
        dest.writeInt(this.mUid);
        dest.writeInt(this.mPid);
    }

    static {
        CREATOR = new C08951();
    }

    public int describeContents() {
        return 0;
    }
}
