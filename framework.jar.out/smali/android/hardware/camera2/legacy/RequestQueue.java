package android.hardware.camera2.legacy;

import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.utils.LongParcelable;
import android.util.Log;
import android.util.Pair;
import java.util.ArrayDeque;
import java.util.Iterator;
import java.util.List;

public class RequestQueue {
    private static final long INVALID_FRAME = -1;
    private static final String TAG = "RequestQueue";
    private long mCurrentFrameNumber;
    private long mCurrentRepeatingFrameNumber;
    private int mCurrentRequestId;
    private final List<Long> mJpegSurfaceIds;
    private BurstHolder mRepeatingRequest;
    private final ArrayDeque<BurstHolder> mRequestQueue;

    public RequestQueue(List<Long> jpegSurfaceIds) {
        this.mRepeatingRequest = null;
        this.mRequestQueue = new ArrayDeque();
        this.mCurrentFrameNumber = 0;
        this.mCurrentRepeatingFrameNumber = INVALID_FRAME;
        this.mCurrentRequestId = 0;
        this.mJpegSurfaceIds = jpegSurfaceIds;
    }

    public synchronized Pair<BurstHolder, Long> getNext() {
        Pair<BurstHolder, Long> pair;
        BurstHolder next = (BurstHolder) this.mRequestQueue.poll();
        if (next == null && this.mRepeatingRequest != null) {
            next = this.mRepeatingRequest;
            this.mCurrentRepeatingFrameNumber = this.mCurrentFrameNumber + ((long) next.getNumberOfRequests());
        }
        if (next == null) {
            pair = null;
        } else {
            pair = new Pair(next, Long.valueOf(this.mCurrentFrameNumber));
            this.mCurrentFrameNumber += (long) next.getNumberOfRequests();
        }
        return pair;
    }

    public synchronized long stopRepeating(int requestId) {
        long ret;
        ret = INVALID_FRAME;
        if (this.mRepeatingRequest == null || this.mRepeatingRequest.getRequestId() != requestId) {
            Log.e(TAG, "cancel failed: no repeating request exists for request id: " + requestId);
        } else {
            this.mRepeatingRequest = null;
            ret = this.mCurrentRepeatingFrameNumber == INVALID_FRAME ? INVALID_FRAME : this.mCurrentRepeatingFrameNumber - 1;
            this.mCurrentRepeatingFrameNumber = INVALID_FRAME;
            Log.i(TAG, "Repeating capture request cancelled.");
        }
        return ret;
    }

    public synchronized long stopRepeating() {
        long j;
        if (this.mRepeatingRequest == null) {
            Log.e(TAG, "cancel failed: no repeating request exists.");
            j = INVALID_FRAME;
        } else {
            j = stopRepeating(this.mRepeatingRequest.getRequestId());
        }
        return j;
    }

    public synchronized int submit(List<CaptureRequest> requests, boolean repeating, LongParcelable frameNumber) {
        int requestId;
        requestId = this.mCurrentRequestId;
        this.mCurrentRequestId = requestId + 1;
        BurstHolder burst = new BurstHolder(requestId, repeating, requests, this.mJpegSurfaceIds);
        long ret = INVALID_FRAME;
        if (burst.isRepeating()) {
            Log.i(TAG, "Repeating capture request set.");
            if (this.mRepeatingRequest != null) {
                ret = this.mCurrentRepeatingFrameNumber == INVALID_FRAME ? INVALID_FRAME : this.mCurrentRepeatingFrameNumber - 1;
            }
            this.mCurrentRepeatingFrameNumber = INVALID_FRAME;
            this.mRepeatingRequest = burst;
        } else {
            this.mRequestQueue.offer(burst);
            ret = calculateLastFrame(burst.getRequestId());
        }
        frameNumber.setNumber(ret);
        return requestId;
    }

    private long calculateLastFrame(int requestId) {
        long total = this.mCurrentFrameNumber;
        Iterator i$ = this.mRequestQueue.iterator();
        while (i$.hasNext()) {
            BurstHolder b = (BurstHolder) i$.next();
            total += (long) b.getNumberOfRequests();
            if (b.getRequestId() == requestId) {
                return total - 1;
            }
        }
        throw new IllegalStateException("At least one request must be in the queue to calculate frame number");
    }
}
