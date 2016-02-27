package android.gesture;

import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Paint.Cap;
import android.graphics.Paint.Join;
import android.graphics.Paint.Style;
import android.graphics.Path;
import android.graphics.RectF;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;
import android.view.accessibility.AccessibilityNodeInfo;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicInteger;

public class Gesture implements Parcelable {
    private static final boolean BITMAP_RENDERING_ANTIALIAS = true;
    private static final boolean BITMAP_RENDERING_DITHER = true;
    private static final int BITMAP_RENDERING_WIDTH = 2;
    public static final Creator<Gesture> CREATOR;
    private static final long GESTURE_ID_BASE;
    private static final AtomicInteger sGestureCount;
    private final RectF mBoundingBox;
    private long mGestureID;
    private final ArrayList<GestureStroke> mStrokes;

    /* renamed from: android.gesture.Gesture.1 */
    static class C01691 implements Creator<Gesture> {
        C01691() {
        }

        public Gesture createFromParcel(Parcel in) {
            Gesture gesture = null;
            long gestureID = in.readLong();
            DataInputStream inStream = new DataInputStream(new ByteArrayInputStream(in.createByteArray()));
            try {
                gesture = Gesture.deserialize(inStream);
            } catch (IOException e) {
                Log.e(GestureConstants.LOG_TAG, "Error reading Gesture from parcel:", e);
            } finally {
                GestureUtils.closeStream(inStream);
            }
            if (gesture != null) {
                gesture.mGestureID = gestureID;
            }
            return gesture;
        }

        public Gesture[] newArray(int size) {
            return new Gesture[size];
        }
    }

    static {
        GESTURE_ID_BASE = System.currentTimeMillis();
        sGestureCount = new AtomicInteger(0);
        CREATOR = new C01691();
    }

    public Gesture() {
        this.mBoundingBox = new RectF();
        this.mStrokes = new ArrayList();
        this.mGestureID = GESTURE_ID_BASE + ((long) sGestureCount.incrementAndGet());
    }

    public Object clone() {
        Gesture gesture = new Gesture();
        gesture.mBoundingBox.set(this.mBoundingBox.left, this.mBoundingBox.top, this.mBoundingBox.right, this.mBoundingBox.bottom);
        int count = this.mStrokes.size();
        for (int i = 0; i < count; i++) {
            gesture.mStrokes.add((GestureStroke) ((GestureStroke) this.mStrokes.get(i)).clone());
        }
        return gesture;
    }

    public ArrayList<GestureStroke> getStrokes() {
        return this.mStrokes;
    }

    public int getStrokesCount() {
        return this.mStrokes.size();
    }

    public void addStroke(GestureStroke stroke) {
        this.mStrokes.add(stroke);
        this.mBoundingBox.union(stroke.boundingBox);
    }

    public float getLength() {
        int len = 0;
        ArrayList<GestureStroke> strokes = this.mStrokes;
        for (int i = 0; i < strokes.size(); i++) {
            len = (int) (((GestureStroke) strokes.get(i)).length + ((float) len));
        }
        return (float) len;
    }

    public RectF getBoundingBox() {
        return this.mBoundingBox;
    }

    public Path toPath() {
        return toPath(null);
    }

    public Path toPath(Path path) {
        if (path == null) {
            path = new Path();
        }
        ArrayList<GestureStroke> strokes = this.mStrokes;
        int count = strokes.size();
        for (int i = 0; i < count; i++) {
            path.addPath(((GestureStroke) strokes.get(i)).getPath());
        }
        return path;
    }

    public Path toPath(int width, int height, int edge, int numSample) {
        return toPath(null, width, height, edge, numSample);
    }

    public Path toPath(Path path, int width, int height, int edge, int numSample) {
        if (path == null) {
            path = new Path();
        }
        ArrayList<GestureStroke> strokes = this.mStrokes;
        int count = strokes.size();
        for (int i = 0; i < count; i++) {
            path.addPath(((GestureStroke) strokes.get(i)).toPath((float) (width - (edge * BITMAP_RENDERING_WIDTH)), (float) (height - (edge * BITMAP_RENDERING_WIDTH)), numSample));
        }
        return path;
    }

    void setID(long id) {
        this.mGestureID = id;
    }

    public long getID() {
        return this.mGestureID;
    }

    public Bitmap toBitmap(int width, int height, int edge, int numSample, int color) {
        Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        canvas.translate((float) edge, (float) edge);
        Paint paint = new Paint();
        paint.setAntiAlias(BITMAP_RENDERING_DITHER);
        paint.setDither(BITMAP_RENDERING_DITHER);
        paint.setColor(color);
        paint.setStyle(Style.STROKE);
        paint.setStrokeJoin(Join.ROUND);
        paint.setStrokeCap(Cap.ROUND);
        paint.setStrokeWidth(2.0f);
        ArrayList<GestureStroke> strokes = this.mStrokes;
        int count = strokes.size();
        for (int i = 0; i < count; i++) {
            canvas.drawPath(((GestureStroke) strokes.get(i)).toPath((float) (width - (edge * BITMAP_RENDERING_WIDTH)), (float) (height - (edge * BITMAP_RENDERING_WIDTH)), numSample), paint);
        }
        return bitmap;
    }

    public Bitmap toBitmap(int width, int height, int inset, int color) {
        float scale;
        Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        Paint paint = new Paint();
        paint.setAntiAlias(BITMAP_RENDERING_DITHER);
        paint.setDither(BITMAP_RENDERING_DITHER);
        paint.setColor(color);
        paint.setStyle(Style.STROKE);
        paint.setStrokeJoin(Join.ROUND);
        paint.setStrokeCap(Cap.ROUND);
        paint.setStrokeWidth(2.0f);
        Path path = toPath();
        RectF bounds = new RectF();
        path.computeBounds(bounds, BITMAP_RENDERING_DITHER);
        float sx = ((float) (width - (inset * BITMAP_RENDERING_WIDTH))) / bounds.width();
        float sy = ((float) (height - (inset * BITMAP_RENDERING_WIDTH))) / bounds.height();
        if (sx > sy) {
            scale = sy;
        } else {
            scale = sx;
        }
        paint.setStrokeWidth(2.0f / scale);
        path.offset((-bounds.left) + ((((float) width) - (bounds.width() * scale)) / 2.0f), (-bounds.top) + ((((float) height) - (bounds.height() * scale)) / 2.0f));
        canvas.translate((float) inset, (float) inset);
        canvas.scale(scale, scale);
        canvas.drawPath(path, paint);
        return bitmap;
    }

    void serialize(DataOutputStream out) throws IOException {
        ArrayList<GestureStroke> strokes = this.mStrokes;
        int count = strokes.size();
        out.writeLong(this.mGestureID);
        out.writeInt(count);
        for (int i = 0; i < count; i++) {
            ((GestureStroke) strokes.get(i)).serialize(out);
        }
    }

    static Gesture deserialize(DataInputStream in) throws IOException {
        Gesture gesture = new Gesture();
        gesture.mGestureID = in.readLong();
        int count = in.readInt();
        for (int i = 0; i < count; i++) {
            gesture.addStroke(GestureStroke.deserialize(in));
        }
        return gesture;
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeLong(this.mGestureID);
        boolean result = false;
        ByteArrayOutputStream byteStream = new ByteArrayOutputStream(AccessibilityNodeInfo.ACTION_PASTE);
        DataOutputStream outStream = new DataOutputStream(byteStream);
        try {
            serialize(outStream);
            result = BITMAP_RENDERING_DITHER;
        } catch (IOException e) {
            Log.e(GestureConstants.LOG_TAG, "Error writing Gesture to parcel:", e);
        } finally {
            GestureUtils.closeStream(outStream);
            GestureUtils.closeStream(byteStream);
        }
        if (result) {
            out.writeByteArray(byteStream.toByteArray());
        }
    }

    public int describeContents() {
        return 0;
    }
}
