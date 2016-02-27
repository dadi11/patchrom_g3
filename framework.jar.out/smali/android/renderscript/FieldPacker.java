package android.renderscript;

import android.util.Log;
import android.view.inputmethod.EditorInfo;
import android.widget.AppSecurityPermissions;
import android.widget.ExpandableListView;
import java.util.BitSet;

public class FieldPacker {
    private BitSet mAlignment;
    private final byte[] mData;
    private int mLen;
    private int mPos;

    public FieldPacker(int len) {
        this.mPos = 0;
        this.mLen = len;
        this.mData = new byte[len];
        this.mAlignment = new BitSet();
    }

    public FieldPacker(byte[] data) {
        this.mPos = data.length;
        this.mLen = data.length;
        this.mData = data;
        this.mAlignment = new BitSet();
    }

    public void align(int v) {
        if (v <= 0 || ((v - 1) & v) != 0) {
            throw new RSIllegalArgumentException("argument must be a non-negative non-zero power of 2: " + v);
        }
        while ((this.mPos & (v - 1)) != 0) {
            this.mAlignment.flip(this.mPos);
            byte[] bArr = this.mData;
            int i = this.mPos;
            this.mPos = i + 1;
            bArr[i] = (byte) 0;
        }
    }

    public void subalign(int v) {
        if (((v - 1) & v) != 0) {
            throw new RSIllegalArgumentException("argument must be a non-negative non-zero power of 2: " + v);
        }
        while ((this.mPos & (v - 1)) != 0) {
            this.mPos--;
        }
        if (this.mPos > 0) {
            while (this.mAlignment.get(this.mPos - 1)) {
                this.mPos--;
                this.mAlignment.flip(this.mPos);
            }
        }
    }

    public void reset() {
        this.mPos = 0;
    }

    public void reset(int i) {
        if (i < 0 || i > this.mLen) {
            throw new RSIllegalArgumentException("out of range argument: " + i);
        }
        this.mPos = i;
    }

    public void skip(int i) {
        int res = this.mPos + i;
        if (res < 0 || res > this.mLen) {
            throw new RSIllegalArgumentException("out of range argument: " + i);
        }
        this.mPos = res;
    }

    public void addI8(byte v) {
        byte[] bArr = this.mData;
        int i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = v;
    }

    public byte subI8() {
        subalign(1);
        byte[] bArr = this.mData;
        int i = this.mPos - 1;
        this.mPos = i;
        return bArr[i];
    }

    public void addI16(short v) {
        align(2);
        byte[] bArr = this.mData;
        int i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) (v & EditorInfo.IME_MASK_ACTION);
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) (v >> 8);
    }

    public short subI16() {
        subalign(2);
        byte[] bArr = this.mData;
        int i = this.mPos - 1;
        this.mPos = i;
        short v = (short) ((bArr[i] & EditorInfo.IME_MASK_ACTION) << 8);
        bArr = this.mData;
        i = this.mPos - 1;
        this.mPos = i;
        return (short) (((short) (bArr[i] & EditorInfo.IME_MASK_ACTION)) | v);
    }

    public void addI32(int v) {
        align(4);
        byte[] bArr = this.mData;
        int i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) (v & EditorInfo.IME_MASK_ACTION);
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((v >> 8) & EditorInfo.IME_MASK_ACTION);
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((v >> 16) & EditorInfo.IME_MASK_ACTION);
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((v >> 24) & EditorInfo.IME_MASK_ACTION);
    }

    public int subI32() {
        subalign(4);
        byte[] bArr = this.mData;
        int i = this.mPos - 1;
        this.mPos = i;
        int v = (bArr[i] & EditorInfo.IME_MASK_ACTION) << 24;
        bArr = this.mData;
        i = this.mPos - 1;
        this.mPos = i;
        v |= (bArr[i] & EditorInfo.IME_MASK_ACTION) << 16;
        bArr = this.mData;
        i = this.mPos - 1;
        this.mPos = i;
        v |= (bArr[i] & EditorInfo.IME_MASK_ACTION) << 8;
        bArr = this.mData;
        i = this.mPos - 1;
        this.mPos = i;
        return v | (bArr[i] & EditorInfo.IME_MASK_ACTION);
    }

    public void addI64(long v) {
        align(8);
        byte[] bArr = this.mData;
        int i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) (v & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 8) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 16) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 24) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 32) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 40) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 48) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 56) & 255));
    }

    public long subI64() {
        subalign(8);
        byte[] bArr = this.mData;
        int i = this.mPos - 1;
        this.mPos = i;
        long v = 0 | ((((long) bArr[i]) & 255) << 56);
        bArr = this.mData;
        i = this.mPos - 1;
        this.mPos = i;
        v |= (((long) bArr[i]) & 255) << 48;
        bArr = this.mData;
        i = this.mPos - 1;
        this.mPos = i;
        v |= (((long) bArr[i]) & 255) << 40;
        bArr = this.mData;
        i = this.mPos - 1;
        this.mPos = i;
        v |= (((long) bArr[i]) & 255) << 32;
        bArr = this.mData;
        i = this.mPos - 1;
        this.mPos = i;
        v |= (((long) bArr[i]) & 255) << 24;
        bArr = this.mData;
        i = this.mPos - 1;
        this.mPos = i;
        v |= (((long) bArr[i]) & 255) << 16;
        bArr = this.mData;
        i = this.mPos - 1;
        this.mPos = i;
        v |= (((long) bArr[i]) & 255) << 8;
        bArr = this.mData;
        i = this.mPos - 1;
        this.mPos = i;
        return v | (((long) bArr[i]) & 255);
    }

    public void addU8(short v) {
        if (v < (short) 0 || v > (short) 255) {
            Log.e("rs", "FieldPacker.addU8( " + v + " )");
            throw new IllegalArgumentException("Saving value out of range for type");
        }
        byte[] bArr = this.mData;
        int i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) v;
    }

    public void addU16(int v) {
        if (v < 0 || v > AppSecurityPermissions.WHICH_ALL) {
            Log.e("rs", "FieldPacker.addU16( " + v + " )");
            throw new IllegalArgumentException("Saving value out of range for type");
        }
        align(2);
        byte[] bArr = this.mData;
        int i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) (v & EditorInfo.IME_MASK_ACTION);
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) (v >> 8);
    }

    public void addU32(long v) {
        if (v < 0 || v > ExpandableListView.PACKED_POSITION_VALUE_NULL) {
            Log.e("rs", "FieldPacker.addU32( " + v + " )");
            throw new IllegalArgumentException("Saving value out of range for type");
        }
        align(4);
        byte[] bArr = this.mData;
        int i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) (v & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 8) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 16) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 24) & 255));
    }

    public void addU64(long v) {
        if (v < 0) {
            Log.e("rs", "FieldPacker.addU64( " + v + " )");
            throw new IllegalArgumentException("Saving value out of range for type");
        }
        align(8);
        byte[] bArr = this.mData;
        int i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) (v & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 8) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 16) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 24) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 32) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 40) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 48) & 255));
        bArr = this.mData;
        i = this.mPos;
        this.mPos = i + 1;
        bArr[i] = (byte) ((int) ((v >> 56) & 255));
    }

    public void addF32(float v) {
        addI32(Float.floatToRawIntBits(v));
    }

    public float subF32() {
        return Float.intBitsToFloat(subI32());
    }

    public void addF64(double v) {
        addI64(Double.doubleToRawLongBits(v));
    }

    public double subF64() {
        return Double.longBitsToDouble(subI64());
    }

    public void addObj(BaseObj obj) {
        if (obj != null) {
            if (RenderScript.sPointerSize == 8) {
                addI64(obj.getID(null));
                addI64(0);
                addI64(0);
                addI64(0);
                return;
            }
            addI32((int) obj.getID(null));
        } else if (RenderScript.sPointerSize == 8) {
            addI64(0);
            addI64(0);
            addI64(0);
            addI64(0);
        } else {
            addI32(0);
        }
    }

    public void addF32(Float2 v) {
        addF32(v.f41x);
        addF32(v.f42y);
    }

    public void addF32(Float3 v) {
        addF32(v.f43x);
        addF32(v.f44y);
        addF32(v.f45z);
    }

    public void addF32(Float4 v) {
        addF32(v.f47x);
        addF32(v.f48y);
        addF32(v.f49z);
        addF32(v.f46w);
    }

    public void addF64(Double2 v) {
        addF64(v.f32x);
        addF64(v.f33y);
    }

    public void addF64(Double3 v) {
        addF64(v.f34x);
        addF64(v.f35y);
        addF64(v.f36z);
    }

    public void addF64(Double4 v) {
        addF64(v.f38x);
        addF64(v.f39y);
        addF64(v.f40z);
        addF64(v.f37w);
    }

    public void addI8(Byte2 v) {
        addI8(v.f23x);
        addI8(v.f24y);
    }

    public void addI8(Byte3 v) {
        addI8(v.f25x);
        addI8(v.f26y);
        addI8(v.f27z);
    }

    public void addI8(Byte4 v) {
        addI8(v.f29x);
        addI8(v.f30y);
        addI8(v.f31z);
        addI8(v.f28w);
    }

    public void addU8(Short2 v) {
        addU8(v.f73x);
        addU8(v.f74y);
    }

    public void addU8(Short3 v) {
        addU8(v.f75x);
        addU8(v.f76y);
        addU8(v.f77z);
    }

    public void addU8(Short4 v) {
        addU8(v.f79x);
        addU8(v.f80y);
        addU8(v.f81z);
        addU8(v.f78w);
    }

    public void addI16(Short2 v) {
        addI16(v.f73x);
        addI16(v.f74y);
    }

    public void addI16(Short3 v) {
        addI16(v.f75x);
        addI16(v.f76y);
        addI16(v.f77z);
    }

    public void addI16(Short4 v) {
        addI16(v.f79x);
        addI16(v.f80y);
        addI16(v.f81z);
        addI16(v.f78w);
    }

    public void addU16(Int2 v) {
        addU16(v.f50x);
        addU16(v.f51y);
    }

    public void addU16(Int3 v) {
        addU16(v.f52x);
        addU16(v.f53y);
        addU16(v.f54z);
    }

    public void addU16(Int4 v) {
        addU16(v.f56x);
        addU16(v.f57y);
        addU16(v.f58z);
        addU16(v.f55w);
    }

    public void addI32(Int2 v) {
        addI32(v.f50x);
        addI32(v.f51y);
    }

    public void addI32(Int3 v) {
        addI32(v.f52x);
        addI32(v.f53y);
        addI32(v.f54z);
    }

    public void addI32(Int4 v) {
        addI32(v.f56x);
        addI32(v.f57y);
        addI32(v.f58z);
        addI32(v.f55w);
    }

    public void addU32(Long2 v) {
        addU32(v.f59x);
        addU32(v.f60y);
    }

    public void addU32(Long3 v) {
        addU32(v.f61x);
        addU32(v.f62y);
        addU32(v.f63z);
    }

    public void addU32(Long4 v) {
        addU32(v.f65x);
        addU32(v.f66y);
        addU32(v.f67z);
        addU32(v.f64w);
    }

    public void addI64(Long2 v) {
        addI64(v.f59x);
        addI64(v.f60y);
    }

    public void addI64(Long3 v) {
        addI64(v.f61x);
        addI64(v.f62y);
        addI64(v.f63z);
    }

    public void addI64(Long4 v) {
        addI64(v.f65x);
        addI64(v.f66y);
        addI64(v.f67z);
        addI64(v.f64w);
    }

    public void addU64(Long2 v) {
        addU64(v.f59x);
        addU64(v.f60y);
    }

    public void addU64(Long3 v) {
        addU64(v.f61x);
        addU64(v.f62y);
        addU64(v.f63z);
    }

    public void addU64(Long4 v) {
        addU64(v.f65x);
        addU64(v.f66y);
        addU64(v.f67z);
        addU64(v.f64w);
    }

    public Float2 subFloat2() {
        Float2 v = new Float2();
        v.f42y = subF32();
        v.f41x = subF32();
        return v;
    }

    public Float3 subFloat3() {
        Float3 v = new Float3();
        v.f45z = subF32();
        v.f44y = subF32();
        v.f43x = subF32();
        return v;
    }

    public Float4 subFloat4() {
        Float4 v = new Float4();
        v.f46w = subF32();
        v.f49z = subF32();
        v.f48y = subF32();
        v.f47x = subF32();
        return v;
    }

    public Double2 subDouble2() {
        Double2 v = new Double2();
        v.f33y = subF64();
        v.f32x = subF64();
        return v;
    }

    public Double3 subDouble3() {
        Double3 v = new Double3();
        v.f36z = subF64();
        v.f35y = subF64();
        v.f34x = subF64();
        return v;
    }

    public Double4 subDouble4() {
        Double4 v = new Double4();
        v.f37w = subF64();
        v.f40z = subF64();
        v.f39y = subF64();
        v.f38x = subF64();
        return v;
    }

    public Byte2 subByte2() {
        Byte2 v = new Byte2();
        v.f24y = subI8();
        v.f23x = subI8();
        return v;
    }

    public Byte3 subByte3() {
        Byte3 v = new Byte3();
        v.f27z = subI8();
        v.f26y = subI8();
        v.f25x = subI8();
        return v;
    }

    public Byte4 subByte4() {
        Byte4 v = new Byte4();
        v.f28w = subI8();
        v.f31z = subI8();
        v.f30y = subI8();
        v.f29x = subI8();
        return v;
    }

    public Short2 subShort2() {
        Short2 v = new Short2();
        v.f74y = subI16();
        v.f73x = subI16();
        return v;
    }

    public Short3 subShort3() {
        Short3 v = new Short3();
        v.f77z = subI16();
        v.f76y = subI16();
        v.f75x = subI16();
        return v;
    }

    public Short4 subShort4() {
        Short4 v = new Short4();
        v.f78w = subI16();
        v.f81z = subI16();
        v.f80y = subI16();
        v.f79x = subI16();
        return v;
    }

    public Int2 subInt2() {
        Int2 v = new Int2();
        v.f51y = subI32();
        v.f50x = subI32();
        return v;
    }

    public Int3 subInt3() {
        Int3 v = new Int3();
        v.f54z = subI32();
        v.f53y = subI32();
        v.f52x = subI32();
        return v;
    }

    public Int4 subInt4() {
        Int4 v = new Int4();
        v.f55w = subI32();
        v.f58z = subI32();
        v.f57y = subI32();
        v.f56x = subI32();
        return v;
    }

    public Long2 subLong2() {
        Long2 v = new Long2();
        v.f60y = subI64();
        v.f59x = subI64();
        return v;
    }

    public Long3 subLong3() {
        Long3 v = new Long3();
        v.f63z = subI64();
        v.f62y = subI64();
        v.f61x = subI64();
        return v;
    }

    public Long4 subLong4() {
        Long4 v = new Long4();
        v.f64w = subI64();
        v.f67z = subI64();
        v.f66y = subI64();
        v.f65x = subI64();
        return v;
    }

    public void addMatrix(Matrix4f v) {
        for (float addF32 : v.mMat) {
            addF32(addF32);
        }
    }

    public Matrix4f subMatrix4f() {
        Matrix4f v = new Matrix4f();
        for (int i = v.mMat.length - 1; i >= 0; i--) {
            v.mMat[i] = subF32();
        }
        return v;
    }

    public void addMatrix(Matrix3f v) {
        for (float addF32 : v.mMat) {
            addF32(addF32);
        }
    }

    public Matrix3f subMatrix3f() {
        Matrix3f v = new Matrix3f();
        for (int i = v.mMat.length - 1; i >= 0; i--) {
            v.mMat[i] = subF32();
        }
        return v;
    }

    public void addMatrix(Matrix2f v) {
        for (float addF32 : v.mMat) {
            addF32(addF32);
        }
    }

    public Matrix2f subMatrix2f() {
        Matrix2f v = new Matrix2f();
        for (int i = v.mMat.length - 1; i >= 0; i--) {
            v.mMat[i] = subF32();
        }
        return v;
    }

    public void addBoolean(boolean v) {
        addI8((byte) (v ? 1 : 0));
    }

    public boolean subBoolean() {
        if (subI8() == (byte) 1) {
            return true;
        }
        return false;
    }

    public final byte[] getData() {
        return this.mData;
    }

    public int getPos() {
        return this.mPos;
    }
}
