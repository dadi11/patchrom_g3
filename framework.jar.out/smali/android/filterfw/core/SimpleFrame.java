package android.filterfw.core;

import android.filterfw.format.ObjectFormat;
import android.graphics.Bitmap;
import java.nio.ByteBuffer;

public class SimpleFrame extends Frame {
    private Object mObject;

    SimpleFrame(FrameFormat format, FrameManager frameManager) {
        super(format, frameManager);
        initWithFormat(format);
        setReusable(false);
    }

    static SimpleFrame wrapObject(Object object, FrameManager frameManager) {
        SimpleFrame result = new SimpleFrame(ObjectFormat.fromObject(object, 1), frameManager);
        result.setObjectValue(object);
        return result;
    }

    private void initWithFormat(FrameFormat format) {
        int count = format.getLength();
        switch (format.getBaseType()) {
            case Action.MERGE_IGNORE /*2*/:
                this.mObject = new byte[count];
            case SetDrawableParameters.TAG /*3*/:
                this.mObject = new short[count];
            case ViewGroupAction.TAG /*4*/:
                this.mObject = new int[count];
            case ReflectionActionWithoutParams.TAG /*5*/:
                this.mObject = new float[count];
            case SetEmptyView.TAG /*6*/:
                this.mObject = new double[count];
            default:
                this.mObject = null;
        }
    }

    protected boolean hasNativeAllocation() {
        return false;
    }

    protected void releaseNativeAllocation() {
    }

    public Object getObjectValue() {
        return this.mObject;
    }

    public void setInts(int[] ints) {
        assertFrameMutable();
        setGenericObjectValue(ints);
    }

    public int[] getInts() {
        return this.mObject instanceof int[] ? (int[]) this.mObject : null;
    }

    public void setFloats(float[] floats) {
        assertFrameMutable();
        setGenericObjectValue(floats);
    }

    public float[] getFloats() {
        return this.mObject instanceof float[] ? (float[]) this.mObject : null;
    }

    public void setData(ByteBuffer buffer, int offset, int length) {
        assertFrameMutable();
        setGenericObjectValue(ByteBuffer.wrap(buffer.array(), offset, length));
    }

    public ByteBuffer getData() {
        return this.mObject instanceof ByteBuffer ? (ByteBuffer) this.mObject : null;
    }

    public void setBitmap(Bitmap bitmap) {
        assertFrameMutable();
        setGenericObjectValue(bitmap);
    }

    public Bitmap getBitmap() {
        return this.mObject instanceof Bitmap ? (Bitmap) this.mObject : null;
    }

    private void setFormatObjectClass(Class objectClass) {
        MutableFrameFormat format = getFormat().mutableCopy();
        format.setObjectClass(objectClass);
        setFormat(format);
    }

    protected void setGenericObjectValue(Object object) {
        FrameFormat format = getFormat();
        if (format.getObjectClass() == null) {
            setFormatObjectClass(object.getClass());
        } else if (!format.getObjectClass().isAssignableFrom(object.getClass())) {
            throw new RuntimeException("Attempting to set object value of type '" + object.getClass() + "' on " + "SimpleFrame of type '" + format.getObjectClass() + "'!");
        }
        this.mObject = object;
    }

    public String toString() {
        return "SimpleFrame (" + getFormat() + ")";
    }
}
