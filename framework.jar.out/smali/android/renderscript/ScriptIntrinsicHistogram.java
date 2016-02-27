package android.renderscript;

import android.renderscript.Script.FieldID;
import android.renderscript.Script.KernelID;
import android.renderscript.Script.LaunchOptions;
import android.view.WindowManager.LayoutParams;
import android.view.inputmethod.InputMethodManager;

public final class ScriptIntrinsicHistogram extends ScriptIntrinsic {
    private Allocation mOut;

    private ScriptIntrinsicHistogram(long id, RenderScript rs) {
        super(id, rs);
    }

    public static ScriptIntrinsicHistogram create(RenderScript rs, Element e) {
        if (e.isCompatible(Element.U8_4(rs)) || e.isCompatible(Element.U8_3(rs)) || e.isCompatible(Element.U8_2(rs)) || e.isCompatible(Element.U8(rs))) {
            return new ScriptIntrinsicHistogram(rs.nScriptIntrinsicCreate(9, e.getID(rs)), rs);
        }
        throw new RSIllegalArgumentException("Unsuported element type.");
    }

    public void forEach(Allocation ain) {
        forEach(ain, null);
    }

    public void forEach(Allocation ain, LaunchOptions opt) {
        if (ain.getType().getElement().getVectorSize() < this.mOut.getType().getElement().getVectorSize()) {
            throw new RSIllegalArgumentException("Input vector size must be >= output vector size.");
        } else if (ain.getType().getElement().isCompatible(Element.U8(this.mRS)) || ain.getType().getElement().isCompatible(Element.U8_2(this.mRS)) || ain.getType().getElement().isCompatible(Element.U8_3(this.mRS)) || ain.getType().getElement().isCompatible(Element.U8_4(this.mRS))) {
            forEach(0, ain, null, null, opt);
        } else {
            throw new RSIllegalArgumentException("Input type must be U8, U8_1, U8_2 or U8_4.");
        }
    }

    public void setDotCoefficients(float r, float g, float b, float a) {
        if (r < 0.0f || g < 0.0f || b < 0.0f || a < 0.0f) {
            throw new RSIllegalArgumentException("Coefficient may not be negative.");
        } else if (((r + g) + b) + a > LayoutParams.BRIGHTNESS_OVERRIDE_FULL) {
            throw new RSIllegalArgumentException("Sum of coefficients must be 1.0 or less.");
        } else {
            FieldPacker fp = new FieldPacker(16);
            fp.addF32(r);
            fp.addF32(g);
            fp.addF32(b);
            fp.addF32(a);
            setVar(0, fp);
        }
    }

    public void setOutput(Allocation aout) {
        this.mOut = aout;
        if (this.mOut.getType().getElement() != Element.U32(this.mRS) && this.mOut.getType().getElement() != Element.U32_2(this.mRS) && this.mOut.getType().getElement() != Element.U32_3(this.mRS) && this.mOut.getType().getElement() != Element.U32_4(this.mRS) && this.mOut.getType().getElement() != Element.I32(this.mRS) && this.mOut.getType().getElement() != Element.I32_2(this.mRS) && this.mOut.getType().getElement() != Element.I32_3(this.mRS) && this.mOut.getType().getElement() != Element.I32_4(this.mRS)) {
            throw new RSIllegalArgumentException("Output type must be U32 or I32.");
        } else if (this.mOut.getType().getX() == InputMethodManager.CONTROL_START_INITIAL && this.mOut.getType().getY() == 0 && !this.mOut.getType().hasMipmaps() && this.mOut.getType().getYuv() == 0) {
            setVar(1, (BaseObj) aout);
        } else {
            throw new RSIllegalArgumentException("Output must be 1D, 256 elements.");
        }
    }

    public void forEach_Dot(Allocation ain) {
        forEach_Dot(ain, null);
    }

    public void forEach_Dot(Allocation ain, LaunchOptions opt) {
        if (this.mOut.getType().getElement().getVectorSize() != 1) {
            throw new RSIllegalArgumentException("Output vector size must be one.");
        } else if (ain.getType().getElement().isCompatible(Element.U8(this.mRS)) || ain.getType().getElement().isCompatible(Element.U8_2(this.mRS)) || ain.getType().getElement().isCompatible(Element.U8_3(this.mRS)) || ain.getType().getElement().isCompatible(Element.U8_4(this.mRS))) {
            forEach(1, ain, null, null, opt);
        } else {
            throw new RSIllegalArgumentException("Input type must be U8, U8_1, U8_2 or U8_4.");
        }
    }

    public KernelID getKernelID_Separate() {
        return createKernelID(0, 3, null, null);
    }

    public FieldID getFieldID_Input() {
        return createFieldID(1, null);
    }
}
