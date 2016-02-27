package android.content;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class RestrictionEntry implements Parcelable {
    public static final Creator<RestrictionEntry> CREATOR;
    public static final int TYPE_BOOLEAN = 1;
    public static final int TYPE_CHOICE = 2;
    public static final int TYPE_CHOICE_LEVEL = 3;
    public static final int TYPE_INTEGER = 5;
    public static final int TYPE_MULTI_SELECT = 4;
    public static final int TYPE_NULL = 0;
    public static final int TYPE_STRING = 6;
    private String[] mChoiceEntries;
    private String[] mChoiceValues;
    private String mCurrentValue;
    private String[] mCurrentValues;
    private String mDescription;
    private String mKey;
    private String mTitle;
    private int mType;

    /* renamed from: android.content.RestrictionEntry.1 */
    static class C01071 implements Creator<RestrictionEntry> {
        C01071() {
        }

        public RestrictionEntry createFromParcel(Parcel source) {
            return new RestrictionEntry(source);
        }

        public RestrictionEntry[] newArray(int size) {
            return new RestrictionEntry[size];
        }
    }

    public RestrictionEntry(int type, String key) {
        this.mType = type;
        this.mKey = key;
    }

    public RestrictionEntry(String key, String selectedString) {
        this.mKey = key;
        this.mType = TYPE_CHOICE;
        this.mCurrentValue = selectedString;
    }

    public RestrictionEntry(String key, boolean selectedState) {
        this.mKey = key;
        this.mType = TYPE_BOOLEAN;
        setSelectedState(selectedState);
    }

    public RestrictionEntry(String key, String[] selectedStrings) {
        this.mKey = key;
        this.mType = TYPE_MULTI_SELECT;
        this.mCurrentValues = selectedStrings;
    }

    public RestrictionEntry(String key, int selectedInt) {
        this.mKey = key;
        this.mType = TYPE_INTEGER;
        setIntValue(selectedInt);
    }

    public void setType(int type) {
        this.mType = type;
    }

    public int getType() {
        return this.mType;
    }

    public String getSelectedString() {
        return this.mCurrentValue;
    }

    public String[] getAllSelectedStrings() {
        return this.mCurrentValues;
    }

    public boolean getSelectedState() {
        return Boolean.parseBoolean(this.mCurrentValue);
    }

    public int getIntValue() {
        return Integer.parseInt(this.mCurrentValue);
    }

    public void setIntValue(int value) {
        this.mCurrentValue = Integer.toString(value);
    }

    public void setSelectedString(String selectedString) {
        this.mCurrentValue = selectedString;
    }

    public void setSelectedState(boolean state) {
        this.mCurrentValue = Boolean.toString(state);
    }

    public void setAllSelectedStrings(String[] allSelectedStrings) {
        this.mCurrentValues = allSelectedStrings;
    }

    public void setChoiceValues(String[] choiceValues) {
        this.mChoiceValues = choiceValues;
    }

    public void setChoiceValues(Context context, int stringArrayResId) {
        this.mChoiceValues = context.getResources().getStringArray(stringArrayResId);
    }

    public String[] getChoiceValues() {
        return this.mChoiceValues;
    }

    public void setChoiceEntries(String[] choiceEntries) {
        this.mChoiceEntries = choiceEntries;
    }

    public void setChoiceEntries(Context context, int stringArrayResId) {
        this.mChoiceEntries = context.getResources().getStringArray(stringArrayResId);
    }

    public String[] getChoiceEntries() {
        return this.mChoiceEntries;
    }

    public String getDescription() {
        return this.mDescription;
    }

    public void setDescription(String description) {
        this.mDescription = description;
    }

    public String getKey() {
        return this.mKey;
    }

    public String getTitle() {
        return this.mTitle;
    }

    public void setTitle(String title) {
        this.mTitle = title;
    }

    private boolean equalArrays(String[] one, String[] other) {
        if (one.length != other.length) {
            return false;
        }
        for (int i = TYPE_NULL; i < one.length; i += TYPE_BOOLEAN) {
            if (!one[i].equals(other[i])) {
                return false;
            }
        }
        return true;
    }

    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        if (!(o instanceof RestrictionEntry)) {
            return false;
        }
        RestrictionEntry other = (RestrictionEntry) o;
        if (this.mType == other.mType && this.mKey.equals(other.mKey)) {
            if (this.mCurrentValues == null && other.mCurrentValues == null && this.mCurrentValue != null && this.mCurrentValue.equals(other.mCurrentValue)) {
                return true;
            }
            if (this.mCurrentValue == null && other.mCurrentValue == null && this.mCurrentValues != null && equalArrays(this.mCurrentValues, other.mCurrentValues)) {
                return true;
            }
        }
        return false;
    }

    public int hashCode() {
        int result = this.mKey.hashCode() + 527;
        if (this.mCurrentValue != null) {
            return (result * 31) + this.mCurrentValue.hashCode();
        }
        if (this.mCurrentValues == null) {
            return result;
        }
        String[] arr$ = this.mCurrentValues;
        int len$ = arr$.length;
        for (int i$ = TYPE_NULL; i$ < len$; i$ += TYPE_BOOLEAN) {
            String value = arr$[i$];
            if (value != null) {
                result = (result * 31) + value.hashCode();
            }
        }
        return result;
    }

    private String[] readArray(Parcel in) {
        int count = in.readInt();
        String[] values = new String[count];
        for (int i = TYPE_NULL; i < count; i += TYPE_BOOLEAN) {
            values[i] = in.readString();
        }
        return values;
    }

    public RestrictionEntry(Parcel in) {
        this.mType = in.readInt();
        this.mKey = in.readString();
        this.mTitle = in.readString();
        this.mDescription = in.readString();
        this.mChoiceEntries = readArray(in);
        this.mChoiceValues = readArray(in);
        this.mCurrentValue = in.readString();
        this.mCurrentValues = readArray(in);
    }

    public int describeContents() {
        return TYPE_NULL;
    }

    private void writeArray(Parcel dest, String[] values) {
        if (values == null) {
            dest.writeInt(TYPE_NULL);
            return;
        }
        dest.writeInt(values.length);
        for (int i = TYPE_NULL; i < values.length; i += TYPE_BOOLEAN) {
            dest.writeString(values[i]);
        }
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mType);
        dest.writeString(this.mKey);
        dest.writeString(this.mTitle);
        dest.writeString(this.mDescription);
        writeArray(dest, this.mChoiceEntries);
        writeArray(dest, this.mChoiceValues);
        dest.writeString(this.mCurrentValue);
        writeArray(dest, this.mCurrentValues);
    }

    static {
        CREATOR = new C01071();
    }

    public String toString() {
        return "RestrictionsEntry {type=" + this.mType + ", key=" + this.mKey + ", value=" + this.mCurrentValue + "}";
    }
}
