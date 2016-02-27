package android.filterfw.core;

import java.util.Map.Entry;
import java.util.SortedMap;
import java.util.TreeMap;

public class CachedFrameManager extends SimpleFrameManager {
    private SortedMap<Integer, Frame> mAvailableFrames;
    private int mStorageCapacity;
    private int mStorageSize;
    private int mTimeStamp;

    public CachedFrameManager() {
        this.mStorageCapacity = 25165824;
        this.mStorageSize = 0;
        this.mTimeStamp = 0;
        this.mAvailableFrames = new TreeMap();
    }

    public Frame newFrame(FrameFormat format) {
        Frame result = findAvailableFrame(format, 0, 0);
        if (result == null) {
            result = super.newFrame(format);
        }
        result.setTimestamp(-2);
        return result;
    }

    public Frame newBoundFrame(FrameFormat format, int bindingType, long bindingId) {
        Frame result = findAvailableFrame(format, bindingType, bindingId);
        if (result == null) {
            result = super.newBoundFrame(format, bindingType, bindingId);
        }
        result.setTimestamp(-2);
        return result;
    }

    public Frame retainFrame(Frame frame) {
        return super.retainFrame(frame);
    }

    public Frame releaseFrame(Frame frame) {
        if (frame.isReusable()) {
            int refCount = frame.decRefCount();
            if (refCount == 0 && frame.hasNativeAllocation()) {
                if (!storeFrame(frame)) {
                    frame.releaseNativeAllocation();
                }
                return null;
            } else if (refCount >= 0) {
                return frame;
            } else {
                throw new RuntimeException("Frame reference count dropped below 0!");
            }
        }
        super.releaseFrame(frame);
        return frame;
    }

    public void clearCache() {
        for (Frame frame : this.mAvailableFrames.values()) {
            frame.releaseNativeAllocation();
        }
        this.mAvailableFrames.clear();
    }

    public void tearDown() {
        clearCache();
    }

    private boolean storeFrame(Frame frame) {
        boolean z;
        synchronized (this.mAvailableFrames) {
            int frameSize = frame.getFormat().getSize();
            if (frameSize > this.mStorageCapacity) {
                z = false;
            } else {
                int newStorageSize = this.mStorageSize + frameSize;
                while (newStorageSize > this.mStorageCapacity) {
                    dropOldestFrame();
                    newStorageSize = this.mStorageSize + frameSize;
                }
                frame.onFrameStore();
                this.mStorageSize = newStorageSize;
                this.mAvailableFrames.put(Integer.valueOf(this.mTimeStamp), frame);
                this.mTimeStamp++;
                z = true;
            }
        }
        return z;
    }

    private void dropOldestFrame() {
        int oldest = ((Integer) this.mAvailableFrames.firstKey()).intValue();
        Frame frame = (Frame) this.mAvailableFrames.get(Integer.valueOf(oldest));
        this.mStorageSize -= frame.getFormat().getSize();
        frame.releaseNativeAllocation();
        this.mAvailableFrames.remove(Integer.valueOf(oldest));
    }

    private Frame findAvailableFrame(FrameFormat format, int bindingType, long bindingId) {
        synchronized (this.mAvailableFrames) {
            for (Entry<Integer, Frame> entry : this.mAvailableFrames.entrySet()) {
                Frame frame = (Frame) entry.getValue();
                if (frame.getFormat().isReplaceableBy(format) && bindingType == frame.getBindingType()) {
                    if (bindingType == 0 || bindingId == frame.getBindingId()) {
                        super.retainFrame(frame);
                        this.mAvailableFrames.remove(entry.getKey());
                        frame.onFrameFetch();
                        frame.reset(format);
                        this.mStorageSize -= format.getSize();
                        return frame;
                    }
                }
            }
            return null;
        }
    }
}
