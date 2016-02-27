package com.android.internal.telephony.cat;

import android.graphics.Bitmap;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class Item implements Parcelable {
    public static final Creator<Item> CREATOR;
    public Bitmap icon;
    public int id;
    public String text;

    /* renamed from: com.android.internal.telephony.cat.Item.1 */
    static class C00321 implements Creator<Item> {
        C00321() {
        }

        public Item createFromParcel(Parcel in) {
            return new Item(in);
        }

        public Item[] newArray(int size) {
            return new Item[size];
        }
    }

    public Item(int id, String text) {
        this(id, text, null);
    }

    public Item(int id, String text, Bitmap icon) {
        this.id = id;
        this.text = text;
        this.icon = icon;
    }

    public Item(Parcel in) {
        this.id = in.readInt();
        this.text = in.readString();
        this.icon = (Bitmap) in.readParcelable(null);
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.id);
        dest.writeString(this.text);
        dest.writeParcelable(this.icon, flags);
    }

    static {
        CREATOR = new C00321();
    }

    public String toString() {
        return this.text;
    }
}
