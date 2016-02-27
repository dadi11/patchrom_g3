package android.renderscript;

import android.widget.Toast;

public class Float2 {
    public float f41x;
    public float f42y;

    public Float2(Float2 data) {
        this.f41x = data.f41x;
        this.f42y = data.f42y;
    }

    public Float2(float x, float y) {
        this.f41x = x;
        this.f42y = y;
    }

    public static Float2 add(Float2 a, Float2 b) {
        Float2 res = new Float2();
        res.f41x = a.f41x + b.f41x;
        res.f42y = a.f42y + b.f42y;
        return res;
    }

    public void add(Float2 value) {
        this.f41x += value.f41x;
        this.f42y += value.f42y;
    }

    public void add(float value) {
        this.f41x += value;
        this.f42y += value;
    }

    public static Float2 add(Float2 a, float b) {
        Float2 res = new Float2();
        res.f41x = a.f41x + b;
        res.f42y = a.f42y + b;
        return res;
    }

    public void sub(Float2 value) {
        this.f41x -= value.f41x;
        this.f42y -= value.f42y;
    }

    public static Float2 sub(Float2 a, Float2 b) {
        Float2 res = new Float2();
        res.f41x = a.f41x - b.f41x;
        res.f42y = a.f42y - b.f42y;
        return res;
    }

    public void sub(float value) {
        this.f41x -= value;
        this.f42y -= value;
    }

    public static Float2 sub(Float2 a, float b) {
        Float2 res = new Float2();
        res.f41x = a.f41x - b;
        res.f42y = a.f42y - b;
        return res;
    }

    public void mul(Float2 value) {
        this.f41x *= value.f41x;
        this.f42y *= value.f42y;
    }

    public static Float2 mul(Float2 a, Float2 b) {
        Float2 res = new Float2();
        res.f41x = a.f41x * b.f41x;
        res.f42y = a.f42y * b.f42y;
        return res;
    }

    public void mul(float value) {
        this.f41x *= value;
        this.f42y *= value;
    }

    public static Float2 mul(Float2 a, float b) {
        Float2 res = new Float2();
        res.f41x = a.f41x * b;
        res.f42y = a.f42y * b;
        return res;
    }

    public void div(Float2 value) {
        this.f41x /= value.f41x;
        this.f42y /= value.f42y;
    }

    public static Float2 div(Float2 a, Float2 b) {
        Float2 res = new Float2();
        res.f41x = a.f41x / b.f41x;
        res.f42y = a.f42y / b.f42y;
        return res;
    }

    public void div(float value) {
        this.f41x /= value;
        this.f42y /= value;
    }

    public static Float2 div(Float2 a, float b) {
        Float2 res = new Float2();
        res.f41x = a.f41x / b;
        res.f42y = a.f42y / b;
        return res;
    }

    public float dotProduct(Float2 a) {
        return (this.f41x * a.f41x) + (this.f42y * a.f42y);
    }

    public static float dotProduct(Float2 a, Float2 b) {
        return (b.f41x * a.f41x) + (b.f42y * a.f42y);
    }

    public void addMultiple(Float2 a, float factor) {
        this.f41x += a.f41x * factor;
        this.f42y += a.f42y * factor;
    }

    public void set(Float2 a) {
        this.f41x = a.f41x;
        this.f42y = a.f42y;
    }

    public void negate() {
        this.f41x = -this.f41x;
        this.f42y = -this.f42y;
    }

    public int length() {
        return 2;
    }

    public float elementSum() {
        return this.f41x + this.f42y;
    }

    public float get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f41x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f42y;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, float value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f41x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f42y = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, float value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f41x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f42y += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setValues(float x, float y) {
        this.f41x = x;
        this.f42y = y;
    }

    public void copyTo(float[] data, int offset) {
        data[offset] = this.f41x;
        data[offset + 1] = this.f42y;
    }
}
