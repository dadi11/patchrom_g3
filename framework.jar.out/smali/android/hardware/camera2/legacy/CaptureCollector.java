package android.hardware.camera2.legacy;

import android.util.Log;
import android.util.MutableLong;
import android.util.Pair;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.TreeSet;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class CaptureCollector {
    private static final boolean DEBUG;
    private static final int FLAG_RECEIVED_ALL_JPEG = 3;
    private static final int FLAG_RECEIVED_ALL_PREVIEW = 12;
    private static final int FLAG_RECEIVED_JPEG = 1;
    private static final int FLAG_RECEIVED_JPEG_TS = 2;
    private static final int FLAG_RECEIVED_PREVIEW = 4;
    private static final int FLAG_RECEIVED_PREVIEW_TS = 8;
    private static final int MAX_JPEGS_IN_FLIGHT = 1;
    private static final String TAG = "CaptureCollector";
    private final TreeSet<CaptureHolder> mActiveRequests;
    private final ArrayList<CaptureHolder> mCompletedRequests;
    private final CameraDeviceState mDeviceState;
    private int mInFlight;
    private int mInFlightPreviews;
    private final Condition mIsEmpty;
    private final ArrayDeque<CaptureHolder> mJpegCaptureQueue;
    private final ArrayDeque<CaptureHolder> mJpegProduceQueue;
    private final ReentrantLock mLock;
    private final int mMaxInFlight;
    private final Condition mNotFull;
    private final ArrayDeque<CaptureHolder> mPreviewCaptureQueue;
    private final ArrayDeque<CaptureHolder> mPreviewProduceQueue;
    private final Condition mPreviewsEmpty;

    private class CaptureHolder implements Comparable<CaptureHolder> {
        private boolean mCompleted;
        private boolean mFailedJpeg;
        private boolean mFailedPreview;
        private boolean mHasStarted;
        private final LegacyRequest mLegacy;
        private boolean mPreviewCompleted;
        private int mReceivedFlags;
        private final RequestHolder mRequest;
        private long mTimestamp;
        public final boolean needsJpeg;
        public final boolean needsPreview;

        public CaptureHolder(RequestHolder request, LegacyRequest legacyHolder) {
            this.mTimestamp = 0;
            this.mReceivedFlags = 0;
            this.mHasStarted = CaptureCollector.DEBUG;
            this.mFailedJpeg = CaptureCollector.DEBUG;
            this.mFailedPreview = CaptureCollector.DEBUG;
            this.mCompleted = CaptureCollector.DEBUG;
            this.mPreviewCompleted = CaptureCollector.DEBUG;
            this.mRequest = request;
            this.mLegacy = legacyHolder;
            this.needsJpeg = request.hasJpegTargets();
            this.needsPreview = request.hasPreviewTargets();
        }

        public boolean isPreviewCompleted() {
            return (this.mReceivedFlags & CaptureCollector.FLAG_RECEIVED_ALL_PREVIEW) == CaptureCollector.FLAG_RECEIVED_ALL_PREVIEW ? true : CaptureCollector.DEBUG;
        }

        public boolean isJpegCompleted() {
            return (this.mReceivedFlags & CaptureCollector.FLAG_RECEIVED_ALL_JPEG) == CaptureCollector.FLAG_RECEIVED_ALL_JPEG ? true : CaptureCollector.DEBUG;
        }

        public boolean isCompleted() {
            return (this.needsJpeg == isJpegCompleted() && this.needsPreview == isPreviewCompleted()) ? true : CaptureCollector.DEBUG;
        }

        public void tryComplete() {
            if (!this.mPreviewCompleted && this.needsPreview && isPreviewCompleted()) {
                CaptureCollector.this.onPreviewCompleted();
                this.mPreviewCompleted = true;
            }
            if (isCompleted() && !this.mCompleted) {
                if (this.mFailedPreview || this.mFailedJpeg) {
                    if (this.mHasStarted) {
                        int i;
                        if (this.mFailedPreview) {
                            Log.w(CaptureCollector.TAG, "Preview buffers dropped for request: " + this.mRequest.getRequestId());
                            for (i = 0; i < this.mRequest.numPreviewTargets(); i += CaptureCollector.MAX_JPEGS_IN_FLIGHT) {
                                CaptureCollector.this.mDeviceState.setCaptureResult(this.mRequest, null, 5);
                            }
                        }
                        if (this.mFailedJpeg) {
                            Log.w(CaptureCollector.TAG, "Jpeg buffers dropped for request: " + this.mRequest.getRequestId());
                            for (i = 0; i < this.mRequest.numJpegTargets(); i += CaptureCollector.MAX_JPEGS_IN_FLIGHT) {
                                CaptureCollector.this.mDeviceState.setCaptureResult(this.mRequest, null, 5);
                            }
                        }
                    } else {
                        this.mRequest.failRequest();
                        CaptureCollector.this.mDeviceState.setCaptureStart(this.mRequest, this.mTimestamp, CaptureCollector.FLAG_RECEIVED_ALL_JPEG);
                    }
                }
                CaptureCollector.this.onRequestCompleted(this);
                this.mCompleted = true;
            }
        }

        public void setJpegTimestamp(long timestamp) {
            if (CaptureCollector.DEBUG) {
                Log.d(CaptureCollector.TAG, "setJpegTimestamp - called for request " + this.mRequest.getRequestId());
            }
            if (!this.needsJpeg) {
                throw new IllegalStateException("setJpegTimestamp called for capture with no jpeg targets.");
            } else if (isCompleted()) {
                throw new IllegalStateException("setJpegTimestamp called on already completed request.");
            } else {
                this.mReceivedFlags |= CaptureCollector.FLAG_RECEIVED_JPEG_TS;
                if (this.mTimestamp == 0) {
                    this.mTimestamp = timestamp;
                }
                if (!this.mHasStarted) {
                    this.mHasStarted = true;
                    CaptureCollector.this.mDeviceState.setCaptureStart(this.mRequest, this.mTimestamp, -1);
                }
                tryComplete();
            }
        }

        public void setJpegProduced() {
            if (CaptureCollector.DEBUG) {
                Log.d(CaptureCollector.TAG, "setJpegProduced - called for request " + this.mRequest.getRequestId());
            }
            if (!this.needsJpeg) {
                throw new IllegalStateException("setJpegProduced called for capture with no jpeg targets.");
            } else if (isCompleted()) {
                throw new IllegalStateException("setJpegProduced called on already completed request.");
            } else {
                this.mReceivedFlags |= CaptureCollector.MAX_JPEGS_IN_FLIGHT;
                tryComplete();
            }
        }

        public void setJpegFailed() {
            if (CaptureCollector.DEBUG) {
                Log.d(CaptureCollector.TAG, "setJpegFailed - called for request " + this.mRequest.getRequestId());
            }
            if (this.needsJpeg && !isJpegCompleted()) {
                this.mFailedJpeg = true;
                this.mReceivedFlags |= CaptureCollector.MAX_JPEGS_IN_FLIGHT;
                this.mReceivedFlags |= CaptureCollector.FLAG_RECEIVED_JPEG_TS;
                tryComplete();
            }
        }

        public void setPreviewTimestamp(long timestamp) {
            if (CaptureCollector.DEBUG) {
                Log.d(CaptureCollector.TAG, "setPreviewTimestamp - called for request " + this.mRequest.getRequestId());
            }
            if (!this.needsPreview) {
                throw new IllegalStateException("setPreviewTimestamp called for capture with no preview targets.");
            } else if (isCompleted()) {
                throw new IllegalStateException("setPreviewTimestamp called on already completed request.");
            } else {
                this.mReceivedFlags |= CaptureCollector.FLAG_RECEIVED_PREVIEW_TS;
                if (this.mTimestamp == 0) {
                    this.mTimestamp = timestamp;
                }
                if (!(this.needsJpeg || this.mHasStarted)) {
                    this.mHasStarted = true;
                    CaptureCollector.this.mDeviceState.setCaptureStart(this.mRequest, this.mTimestamp, -1);
                }
                tryComplete();
            }
        }

        public void setPreviewProduced() {
            if (CaptureCollector.DEBUG) {
                Log.d(CaptureCollector.TAG, "setPreviewProduced - called for request " + this.mRequest.getRequestId());
            }
            if (!this.needsPreview) {
                throw new IllegalStateException("setPreviewProduced called for capture with no preview targets.");
            } else if (isCompleted()) {
                throw new IllegalStateException("setPreviewProduced called on already completed request.");
            } else {
                this.mReceivedFlags |= CaptureCollector.FLAG_RECEIVED_PREVIEW;
                tryComplete();
            }
        }

        public void setPreviewFailed() {
            if (CaptureCollector.DEBUG) {
                Log.d(CaptureCollector.TAG, "setPreviewFailed - called for request " + this.mRequest.getRequestId());
            }
            if (this.needsPreview && !isPreviewCompleted()) {
                this.mFailedPreview = true;
                this.mReceivedFlags |= CaptureCollector.FLAG_RECEIVED_PREVIEW;
                this.mReceivedFlags |= CaptureCollector.FLAG_RECEIVED_PREVIEW_TS;
                tryComplete();
            }
        }

        public int compareTo(CaptureHolder captureHolder) {
            if (this.mRequest.getFrameNumber() > captureHolder.mRequest.getFrameNumber()) {
                return CaptureCollector.MAX_JPEGS_IN_FLIGHT;
            }
            return this.mRequest.getFrameNumber() == captureHolder.mRequest.getFrameNumber() ? 0 : -1;
        }

        public boolean equals(Object o) {
            return ((o instanceof CaptureHolder) && compareTo((CaptureHolder) o) == 0) ? true : CaptureCollector.DEBUG;
        }
    }

    static {
        DEBUG = Log.isLoggable(LegacyCameraDevice.DEBUG_PROP, FLAG_RECEIVED_ALL_JPEG);
    }

    public CaptureCollector(int maxInFlight, CameraDeviceState deviceState) {
        this.mCompletedRequests = new ArrayList();
        this.mLock = new ReentrantLock();
        this.mInFlight = 0;
        this.mInFlightPreviews = 0;
        this.mMaxInFlight = maxInFlight;
        this.mJpegCaptureQueue = new ArrayDeque(MAX_JPEGS_IN_FLIGHT);
        this.mJpegProduceQueue = new ArrayDeque(MAX_JPEGS_IN_FLIGHT);
        this.mPreviewCaptureQueue = new ArrayDeque(this.mMaxInFlight);
        this.mPreviewProduceQueue = new ArrayDeque(this.mMaxInFlight);
        this.mActiveRequests = new TreeSet();
        this.mIsEmpty = this.mLock.newCondition();
        this.mNotFull = this.mLock.newCondition();
        this.mPreviewsEmpty = this.mLock.newCondition();
        this.mDeviceState = deviceState;
    }

    public boolean queueRequest(RequestHolder holder, LegacyRequest legacy, long timeout, TimeUnit unit) throws InterruptedException {
        CaptureHolder h = new CaptureHolder(holder, legacy);
        long nanos = unit.toNanos(timeout);
        ReentrantLock lock = this.mLock;
        lock.lock();
        if (DEBUG) {
            Log.d(TAG, "queueRequest  for request " + holder.getRequestId() + " - " + this.mInFlight + " requests remain in flight.");
        }
        if (h.needsJpeg || h.needsPreview) {
            try {
                if (h.needsJpeg) {
                    while (this.mInFlight > 0) {
                        if (nanos <= 0) {
                            return DEBUG;
                        }
                        nanos = this.mIsEmpty.awaitNanos(nanos);
                    }
                    this.mJpegCaptureQueue.add(h);
                    this.mJpegProduceQueue.add(h);
                }
                if (h.needsPreview) {
                    while (this.mInFlight >= this.mMaxInFlight) {
                        if (nanos <= 0) {
                            lock.unlock();
                            return DEBUG;
                        }
                        nanos = this.mNotFull.awaitNanos(nanos);
                    }
                    this.mPreviewCaptureQueue.add(h);
                    this.mPreviewProduceQueue.add(h);
                    this.mInFlightPreviews += MAX_JPEGS_IN_FLIGHT;
                }
                this.mActiveRequests.add(h);
                this.mInFlight += MAX_JPEGS_IN_FLIGHT;
                lock.unlock();
                return true;
            } finally {
                lock.unlock();
            }
        } else {
            throw new IllegalStateException("Request must target at least one output surface!");
        }
    }

    public boolean waitForEmpty(long timeout, TimeUnit unit) throws InterruptedException {
        long nanos = unit.toNanos(timeout);
        ReentrantLock lock = this.mLock;
        lock.lock();
        while (this.mInFlight > 0) {
            if (nanos <= 0) {
                return DEBUG;
            }
            try {
                nanos = this.mIsEmpty.awaitNanos(nanos);
            } finally {
                lock.unlock();
            }
        }
        lock.unlock();
        return true;
    }

    public boolean waitForPreviewsEmpty(long timeout, TimeUnit unit) throws InterruptedException {
        long nanos = unit.toNanos(timeout);
        ReentrantLock lock = this.mLock;
        lock.lock();
        while (this.mInFlightPreviews > 0) {
            if (nanos <= 0) {
                return DEBUG;
            }
            try {
                nanos = this.mPreviewsEmpty.awaitNanos(nanos);
            } finally {
                lock.unlock();
            }
        }
        lock.unlock();
        return true;
    }

    public boolean waitForRequestCompleted(RequestHolder holder, long timeout, TimeUnit unit, MutableLong timestamp) throws InterruptedException {
        long nanos = unit.toNanos(timeout);
        ReentrantLock lock = this.mLock;
        lock.lock();
        while (!removeRequestIfCompleted(holder, timestamp)) {
            try {
                if (nanos <= 0) {
                    return DEBUG;
                }
                nanos = this.mNotFull.awaitNanos(nanos);
            } finally {
                lock.unlock();
            }
        }
        lock.unlock();
        return true;
    }

    private boolean removeRequestIfCompleted(RequestHolder holder, MutableLong timestamp) {
        int i = 0;
        Iterator i$ = this.mCompletedRequests.iterator();
        while (i$.hasNext()) {
            CaptureHolder h = (CaptureHolder) i$.next();
            if (h.mRequest.equals(holder)) {
                timestamp.value = h.mTimestamp;
                this.mCompletedRequests.remove(i);
                return true;
            }
            i += MAX_JPEGS_IN_FLIGHT;
        }
        return DEBUG;
    }

    public RequestHolder jpegCaptured(long timestamp) {
        ReentrantLock lock = this.mLock;
        lock.lock();
        try {
            CaptureHolder h = (CaptureHolder) this.mJpegCaptureQueue.poll();
            if (h == null) {
                Log.w(TAG, "jpegCaptured called with no jpeg request on queue!");
                return null;
            }
            h.setJpegTimestamp(timestamp);
            RequestHolder access$400 = h.mRequest;
            lock.unlock();
            return access$400;
        } finally {
            lock.unlock();
        }
    }

    public Pair<RequestHolder, Long> jpegProduced() {
        ReentrantLock lock = this.mLock;
        lock.lock();
        try {
            CaptureHolder h = (CaptureHolder) this.mJpegProduceQueue.poll();
            if (h == null) {
                Log.w(TAG, "jpegProduced called with no jpeg request on queue!");
                return null;
            }
            h.setJpegProduced();
            Pair<RequestHolder, Long> pair = new Pair(h.mRequest, Long.valueOf(h.mTimestamp));
            lock.unlock();
            return pair;
        } finally {
            lock.unlock();
        }
    }

    public boolean hasPendingPreviewCaptures() {
        ReentrantLock lock = this.mLock;
        lock.lock();
        try {
            boolean z = !this.mPreviewCaptureQueue.isEmpty() ? true : DEBUG;
            lock.unlock();
            return z;
        } catch (Throwable th) {
            lock.unlock();
        }
    }

    public Pair<RequestHolder, Long> previewCaptured(long timestamp) {
        ReentrantLock lock = this.mLock;
        lock.lock();
        try {
            CaptureHolder h = (CaptureHolder) this.mPreviewCaptureQueue.poll();
            if (h == null) {
                if (DEBUG) {
                    Log.d(TAG, "previewCaptured called with no preview request on queue!");
                }
                lock.unlock();
                return null;
            }
            h.setPreviewTimestamp(timestamp);
            Pair<RequestHolder, Long> pair = new Pair(h.mRequest, Long.valueOf(h.mTimestamp));
            lock.unlock();
            return pair;
        } catch (Throwable th) {
            lock.unlock();
        }
    }

    public RequestHolder previewProduced() {
        ReentrantLock lock = this.mLock;
        lock.lock();
        try {
            CaptureHolder h = (CaptureHolder) this.mPreviewProduceQueue.poll();
            if (h == null) {
                Log.w(TAG, "previewProduced called with no preview request on queue!");
                return null;
            }
            h.setPreviewProduced();
            RequestHolder access$400 = h.mRequest;
            lock.unlock();
            return access$400;
        } finally {
            lock.unlock();
        }
    }

    public void failNextPreview() {
        ReentrantLock lock = this.mLock;
        lock.lock();
        try {
            CaptureHolder h1 = (CaptureHolder) this.mPreviewCaptureQueue.peek();
            CaptureHolder h2 = (CaptureHolder) this.mPreviewProduceQueue.peek();
            CaptureHolder h = h1 == null ? h2 : h2 == null ? h1 : h1.compareTo(h2) <= 0 ? h1 : h2;
            if (h != null) {
                this.mPreviewCaptureQueue.remove(h);
                this.mPreviewProduceQueue.remove(h);
                this.mActiveRequests.remove(h);
                h.setPreviewFailed();
            }
            lock.unlock();
        } catch (Throwable th) {
            lock.unlock();
        }
    }

    public void failNextJpeg() {
        ReentrantLock lock = this.mLock;
        lock.lock();
        try {
            CaptureHolder h1 = (CaptureHolder) this.mJpegCaptureQueue.peek();
            CaptureHolder h2 = (CaptureHolder) this.mJpegProduceQueue.peek();
            CaptureHolder h = h1 == null ? h2 : h2 == null ? h1 : h1.compareTo(h2) <= 0 ? h1 : h2;
            if (h != null) {
                this.mJpegCaptureQueue.remove(h);
                this.mJpegProduceQueue.remove(h);
                this.mActiveRequests.remove(h);
                h.setJpegFailed();
            }
            lock.unlock();
        } catch (Throwable th) {
            lock.unlock();
        }
    }

    public void failAll() {
        ReentrantLock lock = this.mLock;
        lock.lock();
        while (true) {
            try {
                CaptureHolder h = (CaptureHolder) this.mActiveRequests.pollFirst();
                if (h == null) {
                    break;
                }
                h.setPreviewFailed();
                h.setJpegFailed();
            } finally {
                lock.unlock();
            }
        }
        this.mPreviewCaptureQueue.clear();
        this.mPreviewProduceQueue.clear();
        this.mJpegCaptureQueue.clear();
        this.mJpegProduceQueue.clear();
    }

    private void onPreviewCompleted() {
        this.mInFlightPreviews--;
        if (this.mInFlightPreviews < 0) {
            throw new IllegalStateException("More preview captures completed than requests queued.");
        } else if (this.mInFlightPreviews == 0) {
            this.mPreviewsEmpty.signalAll();
        }
    }

    private void onRequestCompleted(CaptureHolder capture) {
        RequestHolder request = capture.mRequest;
        this.mInFlight--;
        if (DEBUG) {
            Log.d(TAG, "Completed request " + request.getRequestId() + ", " + this.mInFlight + " requests remain in flight.");
        }
        if (this.mInFlight < 0) {
            throw new IllegalStateException("More captures completed than requests queued.");
        }
        this.mCompletedRequests.add(capture);
        this.mActiveRequests.remove(capture);
        this.mNotFull.signalAll();
        if (this.mInFlight == 0) {
            this.mIsEmpty.signalAll();
        }
    }
}
