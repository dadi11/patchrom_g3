package android.renderscript;

import android.opengl.GLES20;
import android.renderscript.Script.KernelID;
import android.renderscript.Script.LaunchOptions;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;

public final class ScriptIntrinsicLUT extends ScriptIntrinsic {
    private final byte[] mCache;
    private boolean mDirty;
    private final Matrix4f mMatrix;
    private Allocation mTables;

    private ScriptIntrinsicLUT(long id, RenderScript rs) {
        super(id, rs);
        this.mMatrix = new Matrix4f();
        this.mCache = new byte[AccessibilityNodeInfo.ACTION_NEXT_HTML_ELEMENT];
        this.mDirty = true;
        this.mTables = Allocation.createSized(rs, Element.U8(rs), AccessibilityNodeInfo.ACTION_NEXT_HTML_ELEMENT);
        for (int ct = 0; ct < InputMethodManager.CONTROL_START_INITIAL; ct++) {
            this.mCache[ct] = (byte) ct;
            this.mCache[ct + InputMethodManager.CONTROL_START_INITIAL] = (byte) ct;
            this.mCache[ct + AccessibilityNodeInfo.ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY] = (byte) ct;
            this.mCache[ct + GLES20.GL_SRC_COLOR] = (byte) ct;
        }
        setVar(0, this.mTables);
    }

    public static ScriptIntrinsicLUT create(RenderScript rs, Element e) {
        return new ScriptIntrinsicLUT(rs.nScriptIntrinsicCreate(3, e.getID(rs)), rs);
    }

    private void validate(int index, int value) {
        if (index < 0 || index > EditorInfo.IME_MASK_ACTION) {
            throw new RSIllegalArgumentException("Index out of range (0-255).");
        } else if (value < 0 || value > EditorInfo.IME_MASK_ACTION) {
            throw new RSIllegalArgumentException("Value out of range (0-255).");
        }
    }

    public void setRed(int index, int value) {
        validate(index, value);
        this.mCache[index] = (byte) value;
        this.mDirty = true;
    }

    public void setGreen(int index, int value) {
        validate(index, value);
        this.mCache[index + InputMethodManager.CONTROL_START_INITIAL] = (byte) value;
        this.mDirty = true;
    }

    public void setBlue(int index, int value) {
        validate(index, value);
        this.mCache[index + AccessibilityNodeInfo.ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY] = (byte) value;
        this.mDirty = true;
    }

    public void setAlpha(int index, int value) {
        validate(index, value);
        this.mCache[index + GLES20.GL_SRC_COLOR] = (byte) value;
        this.mDirty = true;
    }

    public void forEach(Allocation ain, Allocation aout) {
        forEach(ain, aout, null);
    }

    public void forEach(Allocation ain, Allocation aout, LaunchOptions opt) {
        if (this.mDirty) {
            this.mDirty = false;
            this.mTables.copyFromUnchecked(this.mCache);
        }
        forEach(0, ain, aout, null, opt);
    }

    public KernelID getKernelID() {
        return createKernelID(0, 3, null, null);
    }
}
