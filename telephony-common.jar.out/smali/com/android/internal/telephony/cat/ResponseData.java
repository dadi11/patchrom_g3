package com.android.internal.telephony.cat;

import com.google.android.mms.pdu.PduPart;
import java.io.ByteArrayOutputStream;

abstract class ResponseData {
    public abstract void format(ByteArrayOutputStream byteArrayOutputStream);

    ResponseData() {
    }

    public static void writeLength(ByteArrayOutputStream buf, int length) {
        if (length > 127) {
            buf.write(PduPart.P_DISPOSITION_ATTACHMENT);
        }
        buf.write(length);
    }
}
