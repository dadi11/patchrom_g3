package com.android.internal.telephony.cat;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

class CommandDetails extends ValueObject implements Parcelable {
    public static final Creator<CommandDetails> CREATOR;
    public int commandNumber;
    public int commandQualifier;
    public boolean compRequired;
    public int typeOfCommand;

    /* renamed from: com.android.internal.telephony.cat.CommandDetails.1 */
    static class C00281 implements Creator<CommandDetails> {
        C00281() {
        }

        public CommandDetails createFromParcel(Parcel in) {
            return new CommandDetails(in);
        }

        public CommandDetails[] newArray(int size) {
            return new CommandDetails[size];
        }
    }

    public ComprehensionTlvTag getTag() {
        return ComprehensionTlvTag.COMMAND_DETAILS;
    }

    CommandDetails() {
    }

    public boolean compareTo(CommandDetails other) {
        return this.compRequired == other.compRequired && this.commandNumber == other.commandNumber && this.commandQualifier == other.commandQualifier && this.typeOfCommand == other.typeOfCommand;
    }

    public CommandDetails(Parcel in) {
        this.compRequired = in.readInt() != 0;
        this.commandNumber = in.readInt();
        this.typeOfCommand = in.readInt();
        this.commandQualifier = in.readInt();
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.compRequired ? 1 : 0);
        dest.writeInt(this.commandNumber);
        dest.writeInt(this.typeOfCommand);
        dest.writeInt(this.commandQualifier);
    }

    static {
        CREATOR = new C00281();
    }

    public int describeContents() {
        return 0;
    }

    public String toString() {
        return "CmdDetails: compRequired=" + this.compRequired + " commandNumber=" + this.commandNumber + " typeOfCommand=" + this.typeOfCommand + " commandQualifier=" + this.commandQualifier;
    }
}
