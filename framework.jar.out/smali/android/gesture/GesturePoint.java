package android.gesture;

import java.io.DataInputStream;
import java.io.IOException;

public class GesturePoint {
    public final long timestamp;
    public final float f7x;
    public final float f8y;

    public GesturePoint(float x, float y, long t) {
        this.f7x = x;
        this.f8y = y;
        this.timestamp = t;
    }

    static GesturePoint deserialize(DataInputStream in) throws IOException {
        return new GesturePoint(in.readFloat(), in.readFloat(), in.readLong());
    }

    public Object clone() {
        return new GesturePoint(this.f7x, this.f8y, this.timestamp);
    }
}
