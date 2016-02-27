package android.filterfw.geometry;

import android.view.WindowManager.LayoutParams;

public class Point {
    public float f5x;
    public float f6y;

    public Point(float x, float y) {
        this.f5x = x;
        this.f6y = y;
    }

    public void set(float x, float y) {
        this.f5x = x;
        this.f6y = y;
    }

    public boolean IsInUnitRange() {
        return this.f5x >= 0.0f && this.f5x <= LayoutParams.BRIGHTNESS_OVERRIDE_FULL && this.f6y >= 0.0f && this.f6y <= LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
    }

    public Point plus(float x, float y) {
        return new Point(this.f5x + x, this.f6y + y);
    }

    public Point plus(Point point) {
        return plus(point.f5x, point.f6y);
    }

    public Point minus(float x, float y) {
        return new Point(this.f5x - x, this.f6y - y);
    }

    public Point minus(Point point) {
        return minus(point.f5x, point.f6y);
    }

    public Point times(float s) {
        return new Point(this.f5x * s, this.f6y * s);
    }

    public Point mult(float x, float y) {
        return new Point(this.f5x * x, this.f6y * y);
    }

    public float length() {
        return (float) Math.sqrt((double) ((this.f5x * this.f5x) + (this.f6y * this.f6y)));
    }

    public float distanceTo(Point p) {
        return p.minus(this).length();
    }

    public Point scaledTo(float length) {
        return times(length / length());
    }

    public Point normalize() {
        return scaledTo(LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
    }

    public Point rotated90(int count) {
        float nx = this.f5x;
        float ny = this.f6y;
        for (int i = 0; i < count; i++) {
            float ox = nx;
            nx = ny;
            ny = -ox;
        }
        return new Point(nx, ny);
    }

    public Point rotated(float radians) {
        return new Point((float) ((Math.cos((double) radians) * ((double) this.f5x)) - (Math.sin((double) radians) * ((double) this.f6y))), (float) ((Math.sin((double) radians) * ((double) this.f5x)) + (Math.cos((double) radians) * ((double) this.f6y))));
    }

    public Point rotatedAround(Point center, float radians) {
        return minus(center).rotated(radians).plus(center);
    }

    public String toString() {
        return "(" + this.f5x + ", " + this.f6y + ")";
    }
}
