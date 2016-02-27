package android.filterfw.core;

import android.widget.Toast;

public class SimpleFrameManager extends FrameManager {
    public Frame newFrame(FrameFormat format) {
        return createNewFrame(format);
    }

    public Frame newBoundFrame(FrameFormat format, int bindingType, long bindingId) {
        switch (format.getTarget()) {
            case SetDrawableParameters.TAG /*3*/:
                Frame glFrame = new GLFrame(format, this, bindingType, bindingId);
                glFrame.init(getGLEnvironment());
                return glFrame;
            default:
                throw new RuntimeException("Attached frames are not supported for target type: " + FrameFormat.targetToString(format.getTarget()) + "!");
        }
    }

    private Frame createNewFrame(FrameFormat format) {
        switch (format.getTarget()) {
            case Toast.LENGTH_LONG /*1*/:
                return new SimpleFrame(format, this);
            case Action.MERGE_IGNORE /*2*/:
                return new NativeFrame(format, this);
            case SetDrawableParameters.TAG /*3*/:
                Frame glFrame = new GLFrame(format, this);
                glFrame.init(getGLEnvironment());
                return glFrame;
            case ViewGroupAction.TAG /*4*/:
                return new VertexFrame(format, this);
            default:
                throw new RuntimeException("Unsupported frame target type: " + FrameFormat.targetToString(format.getTarget()) + "!");
        }
    }

    public Frame retainFrame(Frame frame) {
        frame.incRefCount();
        return frame;
    }

    public Frame releaseFrame(Frame frame) {
        int refCount = frame.decRefCount();
        if (refCount == 0 && frame.hasNativeAllocation()) {
            frame.releaseNativeAllocation();
            return null;
        } else if (refCount >= 0) {
            return frame;
        } else {
            throw new RuntimeException("Frame reference count dropped below 0!");
        }
    }
}
