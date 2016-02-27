package com.android.internal.telephony;

import android.content.Context;
import android.os.AsyncResult;
import android.os.Message;
import android.os.Parcel;
import android.telephony.Rlog;
import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;

/* compiled from: RIL */
class RILRequest {
    static final String LOG_TAG = "RilRequest";
    private static final int MAX_POOL_SIZE = 4;
    static AtomicInteger sNextSerial;
    private static RILRequest sPool;
    private static int sPoolSize;
    private static Object sPoolSync;
    static Random sRandom;
    private Context mContext;
    RILRequest mNext;
    Parcel mParcel;
    int mRequest;
    Message mResult;
    int mSerial;

    static {
        sRandom = new Random();
        sNextSerial = new AtomicInteger(0);
        sPoolSync = new Object();
        sPool = null;
        sPoolSize = 0;
    }

    static RILRequest obtain(int request, Message result) {
        RILRequest rr = null;
        synchronized (sPoolSync) {
            if (sPool != null) {
                rr = sPool;
                sPool = rr.mNext;
                rr.mNext = null;
                sPoolSize--;
            }
        }
        if (rr == null) {
            rr = new RILRequest();
        }
        rr.mSerial = sNextSerial.getAndIncrement();
        rr.mRequest = request;
        rr.mResult = result;
        rr.mParcel = Parcel.obtain();
        if (result == null || result.getTarget() != null) {
            rr.mParcel.writeInt(request);
            rr.mParcel.writeInt(rr.mSerial);
            return rr;
        }
        throw new NullPointerException("Message target must not be null");
    }

    void release() {
        synchronized (sPoolSync) {
            if (sPoolSize < MAX_POOL_SIZE) {
                this.mNext = sPool;
                sPool = this;
                sPoolSize++;
                this.mResult = null;
            }
        }
    }

    private RILRequest() {
    }

    static void resetSerial() {
        sNextSerial.set(sRandom.nextInt());
    }

    String serialString() {
        StringBuilder sb = new StringBuilder(8);
        String sn = Long.toString((((long) this.mSerial) - -2147483648L) % 10000);
        sb.append('[');
        int s = sn.length();
        for (int i = 0; i < 4 - s; i++) {
            sb.append('0');
        }
        sb.append(sn);
        sb.append(']');
        return sb.toString();
    }

    void onError(int error, Object ret) {
        CommandException ex = CommandException.fromRilErrno(error);
        Rlog.d(LOG_TAG, serialString() + "< " + RIL.requestToString(this.mRequest) + " error: " + ex + " ret=" + RIL.retToString(this.mRequest, ret));
        if (this.mResult != null) {
            AsyncResult.forMessage(this.mResult, ret, ex);
            this.mResult.sendToTarget();
        }
        if (this.mParcel != null) {
            this.mParcel.recycle();
            this.mParcel = null;
        }
    }
}
