package com.android.internal.telephony.uicc;

import com.google.android.mms.pdu.PduHeaders;

public class UiccTlvData {
    private static final int TAG_FILE_DESCRIPTOR = 130;
    private static final int TAG_FILE_IDENTIFIER = 131;
    private static final int TAG_FILE_SIZE = 128;
    private static final int TAG_LIFECYCLE_STATUS = 138;
    private static final int TAG_PROPRIETARY_INFO = 165;
    private static final int TAG_SECURITY_ATTR_1 = 139;
    private static final int TAG_SECURITY_ATTR_2 = 140;
    private static final int TAG_SECURITY_ATTR_3 = 171;
    private static final int TAG_SHORT_FILE_IDENTIFIER = 136;
    private static final int TAG_TOTAL_FILE_SIZE = 129;
    private static final int TLV_FORMAT_ID = 98;
    private static final int TYPE_2 = 2;
    private static final int TYPE_5 = 5;
    int mFileSize;
    private int mFileType;
    boolean mIsDataEnough;
    int mNumRecords;
    int mRecordSize;

    private UiccTlvData() {
        this.mFileType = -1;
        this.mNumRecords = -1;
        this.mFileSize = -1;
        this.mRecordSize = -1;
    }

    public boolean isIncomplete() {
        return this.mNumRecords == -1 || this.mFileSize == -1 || this.mRecordSize == -1 || this.mFileType == -1;
    }

    public static boolean isUiccTlvData(byte[] data) {
        if (data == null || data.length <= 0 || TLV_FORMAT_ID != (data[0] & PduHeaders.STORE_STATUS_ERROR_END)) {
            return false;
        }
        return true;
    }

    public static UiccTlvData parse(byte[] data) throws IccFileTypeMismatch {
        UiccTlvData parsedData = new UiccTlvData();
        if (data == null || data.length == 0 || TLV_FORMAT_ID != (data[0] & PduHeaders.STORE_STATUS_ERROR_END)) {
            throw new IccFileTypeMismatch();
        }
        int currentLocation = TYPE_2;
        while (currentLocation < data.length) {
            int currentLocation2;
            try {
                currentLocation2 = currentLocation + 1;
                try {
                    switch (data[currentLocation] & PduHeaders.STORE_STATUS_ERROR_END) {
                        case TAG_FILE_SIZE /*128*/:
                            currentLocation = parsedData.parseFileSize(data, currentLocation2);
                            break;
                        case TAG_TOTAL_FILE_SIZE /*129*/:
                        case TAG_FILE_IDENTIFIER /*131*/:
                        case TAG_SHORT_FILE_IDENTIFIER /*136*/:
                        case TAG_LIFECYCLE_STATUS /*138*/:
                        case TAG_SECURITY_ATTR_1 /*139*/:
                        case TAG_SECURITY_ATTR_2 /*140*/:
                        case TAG_PROPRIETARY_INFO /*165*/:
                        case TAG_SECURITY_ATTR_3 /*171*/:
                            currentLocation = parsedData.parseSomeTag(data, currentLocation2);
                            break;
                        case TAG_FILE_DESCRIPTOR /*130*/:
                            currentLocation = parsedData.parseFileDescriptor(data, currentLocation2);
                            break;
                        default:
                            throw new IccFileTypeMismatch();
                    }
                } catch (ArrayIndexOutOfBoundsException e) {
                }
            } catch (ArrayIndexOutOfBoundsException e2) {
                currentLocation2 = currentLocation;
            }
        }
        return parsedData;
    }

    private int parseFileSize(byte[] data, int currentLocation) {
        int currentLocation2 = currentLocation + 1;
        int length = data[currentLocation] & PduHeaders.STORE_STATUS_ERROR_END;
        int fileSize = 0;
        for (int i = 0; i < length; i++) {
            fileSize += (data[currentLocation2 + i] & PduHeaders.STORE_STATUS_ERROR_END) << (((length - i) - 1) * 8);
        }
        this.mFileSize = fileSize;
        if (this.mFileType == TYPE_2) {
            this.mRecordSize = fileSize;
        }
        return currentLocation2 + length;
    }

    private int parseSomeTag(byte[] data, int currentLocation) {
        return (currentLocation + 1) + (data[currentLocation] & PduHeaders.STORE_STATUS_ERROR_END);
    }

    private int parseFileDescriptor(byte[] data, int currentLocation) throws IccFileTypeMismatch {
        int currentLocation2 = currentLocation + 1;
        int length = data[currentLocation] & PduHeaders.STORE_STATUS_ERROR_END;
        if (length == TYPE_5) {
            this.mRecordSize = ((data[currentLocation2 + TYPE_2] & PduHeaders.STORE_STATUS_ERROR_END) << 8) + (data[currentLocation2 + 3] & PduHeaders.STORE_STATUS_ERROR_END);
            this.mNumRecords = data[currentLocation2 + 4] & PduHeaders.STORE_STATUS_ERROR_END;
            this.mFileSize = this.mRecordSize * this.mNumRecords;
            this.mFileType = TYPE_5;
            return currentLocation2 + TYPE_5;
        } else if (length == TYPE_2) {
            int descriptorByte = data[currentLocation2 + 1] & PduHeaders.STORE_STATUS_ERROR_END;
            this.mNumRecords = 1;
            this.mFileType = TYPE_2;
            return currentLocation2 + TYPE_2;
        } else {
            throw new IccFileTypeMismatch();
        }
    }
}
