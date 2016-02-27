package android.view;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public abstract class AbsSavedState implements Parcelable {
    public static final Creator<AbsSavedState> CREATOR;
    public static final AbsSavedState EMPTY_STATE;
    private final Parcelable mSuperState;

    /* renamed from: android.view.AbsSavedState.1 */
    static class C08081 extends AbsSavedState {
        C08081() {
            super();
        }
    }

    /* renamed from: android.view.AbsSavedState.2 */
    static class C08092 implements Creator<AbsSavedState> {
        C08092() {
        }

        public AbsSavedState createFromParcel(Parcel in) {
            if (in.readParcelable(null) == null) {
                return AbsSavedState.EMPTY_STATE;
            }
            throw new IllegalStateException("superState must be null");
        }

        public AbsSavedState[] newArray(int size) {
            return new AbsSavedState[size];
        }
    }

    static {
        EMPTY_STATE = new C08081();
        CREATOR = new C08092();
    }

    private AbsSavedState() {
        this.mSuperState = null;
    }

    protected AbsSavedState(Parcelable superState) {
        if (superState == null) {
            throw new IllegalArgumentException("superState must not be null");
        }
        if (superState == EMPTY_STATE) {
            superState = null;
        }
        this.mSuperState = superState;
    }

    protected AbsSavedState(Parcel source) {
        Parcelable superState = source.readParcelable(null);
        if (superState == null) {
            superState = EMPTY_STATE;
        }
        this.mSuperState = superState;
    }

    public final Parcelable getSuperState() {
        return this.mSuperState;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeParcelable(this.mSuperState, flags);
    }
}
