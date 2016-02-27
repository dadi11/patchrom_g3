package com.android.internal.telephony.cat;

import android.content.res.Resources;
import android.content.res.Resources.NotFoundException;
import com.android.internal.telephony.GsmAlphabet;
import com.android.internal.telephony.cat.Duration.TimeUnit;
import com.android.internal.telephony.uicc.IccUtils;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPart;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

abstract class ValueParser {
    ValueParser() {
    }

    static CommandDetails retrieveCommandDetails(ComprehensionTlv ctlv) throws ResultException {
        CommandDetails cmdDet = new CommandDetails();
        byte[] rawValue = ctlv.getRawValue();
        int valueIndex = ctlv.getValueIndex();
        try {
            cmdDet.compRequired = ctlv.isComprehensionRequired();
            cmdDet.commandNumber = rawValue[valueIndex] & PduHeaders.STORE_STATUS_ERROR_END;
            cmdDet.typeOfCommand = rawValue[valueIndex + 1] & PduHeaders.STORE_STATUS_ERROR_END;
            cmdDet.commandQualifier = rawValue[valueIndex + 2] & PduHeaders.STORE_STATUS_ERROR_END;
            return cmdDet;
        } catch (IndexOutOfBoundsException e) {
            throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
        }
    }

    static DeviceIdentities retrieveDeviceIdentities(ComprehensionTlv ctlv) throws ResultException {
        DeviceIdentities devIds = new DeviceIdentities();
        byte[] rawValue = ctlv.getRawValue();
        int valueIndex = ctlv.getValueIndex();
        try {
            devIds.sourceId = rawValue[valueIndex] & PduHeaders.STORE_STATUS_ERROR_END;
            devIds.destinationId = rawValue[valueIndex + 1] & PduHeaders.STORE_STATUS_ERROR_END;
            return devIds;
        } catch (IndexOutOfBoundsException e) {
            throw new ResultException(ResultCode.REQUIRED_VALUES_MISSING);
        }
    }

    static Duration retrieveDuration(ComprehensionTlv ctlv) throws ResultException {
        TimeUnit timeUnit = TimeUnit.SECOND;
        byte[] rawValue = ctlv.getRawValue();
        int valueIndex = ctlv.getValueIndex();
        try {
            return new Duration(rawValue[valueIndex + 1] & PduHeaders.STORE_STATUS_ERROR_END, TimeUnit.values()[rawValue[valueIndex] & PduHeaders.STORE_STATUS_ERROR_END]);
        } catch (IndexOutOfBoundsException e) {
            throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
        }
    }

    static Item retrieveItem(ComprehensionTlv ctlv) throws ResultException {
        byte[] rawValue = ctlv.getRawValue();
        int valueIndex = ctlv.getValueIndex();
        int length = ctlv.getLength();
        if (length == 0) {
            return null;
        }
        try {
            return new Item(rawValue[valueIndex] & PduHeaders.STORE_STATUS_ERROR_END, IccUtils.adnStringFieldToString(rawValue, valueIndex + 1, length - 1));
        } catch (IndexOutOfBoundsException e) {
            throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
        }
    }

    static int retrieveItemId(ComprehensionTlv ctlv) throws ResultException {
        try {
            return ctlv.getRawValue()[ctlv.getValueIndex()] & PduHeaders.STORE_STATUS_ERROR_END;
        } catch (IndexOutOfBoundsException e) {
            throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
        }
    }

    static IconId retrieveIconId(ComprehensionTlv ctlv) throws ResultException {
        IconId id = new IconId();
        byte[] rawValue = ctlv.getRawValue();
        int valueIndex = ctlv.getValueIndex();
        int valueIndex2 = valueIndex + 1;
        try {
            id.selfExplanatory = (rawValue[valueIndex] & PduHeaders.STORE_STATUS_ERROR_END) == 0;
            id.recordNumber = rawValue[valueIndex2] & PduHeaders.STORE_STATUS_ERROR_END;
            return id;
        } catch (IndexOutOfBoundsException e) {
            throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
        }
    }

    static ItemsIconId retrieveItemsIconId(ComprehensionTlv ctlv) throws ResultException {
        CatLog.m1d("ValueParser", "retrieveItemsIconId:");
        ItemsIconId id = new ItemsIconId();
        byte[] rawValue = ctlv.getRawValue();
        int valueIndex = ctlv.getValueIndex();
        int numOfItems = ctlv.getLength() - 1;
        id.recordNumbers = new int[numOfItems];
        int valueIndex2 = valueIndex + 1;
        try {
            id.selfExplanatory = (rawValue[valueIndex] & PduHeaders.STORE_STATUS_ERROR_END) == 0;
            int i = 0;
            while (i < numOfItems) {
                int index = i + 1;
                valueIndex = valueIndex2 + 1;
                try {
                    id.recordNumbers[i] = rawValue[valueIndex2];
                    i = index;
                    valueIndex2 = valueIndex;
                } catch (IndexOutOfBoundsException e) {
                }
            }
            return id;
        } catch (IndexOutOfBoundsException e2) {
            valueIndex = valueIndex2;
            throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
        }
    }

    static List<TextAttribute> retrieveTextAttribute(ComprehensionTlv ctlv) throws ResultException {
        ArrayList<TextAttribute> lst = new ArrayList();
        byte[] rawValue = ctlv.getRawValue();
        int valueIndex = ctlv.getValueIndex();
        int length = ctlv.getLength();
        if (length == 0) {
            return null;
        }
        int itemCount = length / 4;
        int i = 0;
        while (i < itemCount) {
            try {
                int start = rawValue[valueIndex] & PduHeaders.STORE_STATUS_ERROR_END;
                int textLength = rawValue[valueIndex + 1] & PduHeaders.STORE_STATUS_ERROR_END;
                int format = rawValue[valueIndex + 2] & PduHeaders.STORE_STATUS_ERROR_END;
                int colorValue = rawValue[valueIndex + 3] & PduHeaders.STORE_STATUS_ERROR_END;
                TextAlignment align = TextAlignment.fromInt(format & 3);
                FontSize size = FontSize.fromInt((format >> 2) & 3);
                if (size == null) {
                    size = FontSize.NORMAL;
                }
                lst.add(new TextAttribute(start, textLength, align, size, (format & 16) != 0, (format & 32) != 0, (format & 64) != 0, (format & PduPart.P_Q) != 0, TextColor.fromInt(colorValue)));
                i++;
                valueIndex += 4;
            } catch (IndexOutOfBoundsException e) {
                throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
            }
        }
        return lst;
    }

    static String retrieveAlphaId(ComprehensionTlv ctlv) throws ResultException {
        if (ctlv != null) {
            byte[] rawValue = ctlv.getRawValue();
            int valueIndex = ctlv.getValueIndex();
            int length = ctlv.getLength();
            if (length != 0) {
                try {
                    return IccUtils.adnStringFieldToString(rawValue, valueIndex, length);
                } catch (IndexOutOfBoundsException e) {
                    throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
                }
            }
            CatLog.m1d("ValueParser", "Alpha Id length=" + length);
            return null;
        }
        boolean noAlphaUsrCnf;
        try {
            noAlphaUsrCnf = Resources.getSystem().getBoolean(17956987);
        } catch (NotFoundException e2) {
            noAlphaUsrCnf = false;
        }
        if (noAlphaUsrCnf) {
            return null;
        }
        return "Default Message";
    }

    static String retrieveTextString(ComprehensionTlv ctlv) throws ResultException {
        byte[] rawValue = ctlv.getRawValue();
        int valueIndex = ctlv.getValueIndex();
        int textLen = ctlv.getLength();
        if (textLen == 0) {
            return null;
        }
        textLen--;
        try {
            String text;
            byte codingScheme = (byte) (rawValue[valueIndex] & 12);
            if (codingScheme == null) {
                text = GsmAlphabet.gsm7BitPackedToString(rawValue, valueIndex + 1, (textLen * 8) / 7);
            } else if (codingScheme == 4) {
                text = GsmAlphabet.gsm8BitUnpackedToString(rawValue, valueIndex + 1, textLen);
            } else if (codingScheme == 8) {
                text = new String(rawValue, valueIndex + 1, textLen, "UTF-16");
            } else {
                throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
            }
            return text;
        } catch (IndexOutOfBoundsException e) {
            throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
        } catch (UnsupportedEncodingException e2) {
            throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
        }
    }
}
