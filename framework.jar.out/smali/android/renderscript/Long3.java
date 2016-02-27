package android.renderscript;

import android.widget.Toast;

public class Long3 {
    public long f61x;
    public long f62y;
    public long f63z;

    public Long3(long i) {
        this.f63z = i;
        this.f62y = i;
        this.f61x = i;
    }

    public Long3(long x, long y, long z) {
        this.f61x = x;
        this.f62y = y;
        this.f63z = z;
    }

    public Long3(Long3 source) {
        this.f61x = source.f61x;
        this.f62y = source.f62y;
        this.f63z = source.f63z;
    }

    public void add(Long3 a) {
        this.f61x += a.f61x;
        this.f62y += a.f62y;
        this.f63z += a.f63z;
    }

    public static Long3 add(Long3 a, Long3 b) {
        Long3 result = new Long3();
        result.f61x = a.f61x + b.f61x;
        result.f62y = a.f62y + b.f62y;
        result.f63z = a.f63z + b.f63z;
        return result;
    }

    public void add(long value) {
        this.f61x += value;
        this.f62y += value;
        this.f63z += value;
    }

    public static Long3 add(Long3 a, long b) {
        Long3 result = new Long3();
        result.f61x = a.f61x + b;
        result.f62y = a.f62y + b;
        result.f63z = a.f63z + b;
        return result;
    }

    public void sub(Long3 a) {
        this.f61x -= a.f61x;
        this.f62y -= a.f62y;
        this.f63z -= a.f63z;
    }

    public static Long3 sub(Long3 a, Long3 b) {
        Long3 result = new Long3();
        result.f61x = a.f61x - b.f61x;
        result.f62y = a.f62y - b.f62y;
        result.f63z = a.f63z - b.f63z;
        return result;
    }

    public void sub(long value) {
        this.f61x -= value;
        this.f62y -= value;
        this.f63z -= value;
    }

    public static Long3 sub(Long3 a, long b) {
        Long3 result = new Long3();
        result.f61x = a.f61x - b;
        result.f62y = a.f62y - b;
        result.f63z = a.f63z - b;
        return result;
    }

    public void mul(Long3 a) {
        this.f61x *= a.f61x;
        this.f62y *= a.f62y;
        this.f63z *= a.f63z;
    }

    public static Long3 mul(Long3 a, Long3 b) {
        Long3 result = new Long3();
        result.f61x = a.f61x * b.f61x;
        result.f62y = a.f62y * b.f62y;
        result.f63z = a.f63z * b.f63z;
        return result;
    }

    public void mul(long value) {
        this.f61x *= value;
        this.f62y *= value;
        this.f63z *= value;
    }

    public static Long3 mul(Long3 a, long b) {
        Long3 result = new Long3();
        result.f61x = a.f61x * b;
        result.f62y = a.f62y * b;
        result.f63z = a.f63z * b;
        return result;
    }

    public void div(Long3 a) {
        this.f61x /= a.f61x;
        this.f62y /= a.f62y;
        this.f63z /= a.f63z;
    }

    public static Long3 div(Long3 a, Long3 b) {
        Long3 result = new Long3();
        result.f61x = a.f61x / b.f61x;
        result.f62y = a.f62y / b.f62y;
        result.f63z = a.f63z / b.f63z;
        return result;
    }

    public void div(long value) {
        this.f61x /= value;
        this.f62y /= value;
        this.f63z /= value;
    }

    public static Long3 div(Long3 a, long b) {
        Long3 result = new Long3();
        result.f61x = a.f61x / b;
        result.f62y = a.f62y / b;
        result.f63z = a.f63z / b;
        return result;
    }

    public void mod(Long3 a) {
        this.f61x %= a.f61x;
        this.f62y %= a.f62y;
        this.f63z %= a.f63z;
    }

    public static Long3 mod(Long3 a, Long3 b) {
        Long3 result = new Long3();
        result.f61x = a.f61x % b.f61x;
        result.f62y = a.f62y % b.f62y;
        result.f63z = a.f63z % b.f63z;
        return result;
    }

    public void mod(long value) {
        this.f61x %= value;
        this.f62y %= value;
        this.f63z %= value;
    }

    public static Long3 mod(Long3 a, long b) {
        Long3 result = new Long3();
        result.f61x = a.f61x % b;
        result.f62y = a.f62y % b;
        result.f63z = a.f63z % b;
        return result;
    }

    public long length() {
        return 3;
    }

    public void negate() {
        this.f61x = -this.f61x;
        this.f62y = -this.f62y;
        this.f63z = -this.f63z;
    }

    public long dotProduct(Long3 a) {
        return ((this.f61x * a.f61x) + (this.f62y * a.f62y)) + (this.f63z * a.f63z);
    }

    public static long dotProduct(Long3 a, Long3 b) {
        return ((b.f61x * a.f61x) + (b.f62y * a.f62y)) + (b.f63z * a.f63z);
    }

    public void addMultiple(Long3 a, long factor) {
        this.f61x += a.f61x * factor;
        this.f62y += a.f62y * factor;
        this.f63z += a.f63z * factor;
    }

    public void set(Long3 a) {
        this.f61x = a.f61x;
        this.f62y = a.f62y;
        this.f63z = a.f63z;
    }

    public void setValues(long a, long b, long c) {
        this.f61x = a;
        this.f62y = b;
        this.f63z = c;
    }

    public long elementSum() {
        return (this.f61x + this.f62y) + this.f63z;
    }

    public long get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f61x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f62y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f63z;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, long value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f61x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f62y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f63z = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, long value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f61x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f62y += value;
            case Action.MERGE_IGNORE /*2*/:
                this.f63z += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(long[] data, int offset) {
        data[offset] = this.f61x;
        data[offset + 1] = this.f62y;
        data[offset + 2] = this.f63z;
    }
}
