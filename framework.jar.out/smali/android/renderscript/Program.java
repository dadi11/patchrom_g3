package android.renderscript;

import android.content.res.Resources;
import android.content.res.Resources.NotFoundException;
import android.util.Log;
import android.view.accessibility.AccessibilityNodeInfo;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

public class Program extends BaseObj {
    static final int MAX_CONSTANT = 8;
    static final int MAX_INPUT = 8;
    static final int MAX_OUTPUT = 8;
    static final int MAX_TEXTURE = 8;
    Type[] mConstants;
    Element[] mInputs;
    Element[] mOutputs;
    String mShader;
    int mTextureCount;
    String[] mTextureNames;
    TextureType[] mTextures;

    public static class BaseProgramBuilder {
        int mConstantCount;
        Type[] mConstants;
        int mInputCount;
        Element[] mInputs;
        int mOutputCount;
        Element[] mOutputs;
        RenderScript mRS;
        String mShader;
        int mTextureCount;
        String[] mTextureNames;
        TextureType[] mTextureTypes;
        Type[] mTextures;

        protected BaseProgramBuilder(RenderScript rs) {
            this.mRS = rs;
            this.mInputs = new Element[Program.MAX_TEXTURE];
            this.mOutputs = new Element[Program.MAX_TEXTURE];
            this.mConstants = new Type[Program.MAX_TEXTURE];
            this.mInputCount = 0;
            this.mOutputCount = 0;
            this.mConstantCount = 0;
            this.mTextureCount = 0;
            this.mTextureTypes = new TextureType[Program.MAX_TEXTURE];
            this.mTextureNames = new String[Program.MAX_TEXTURE];
        }

        public BaseProgramBuilder setShader(String s) {
            this.mShader = s;
            return this;
        }

        public BaseProgramBuilder setShader(Resources resources, int resourceID) {
            InputStream is = resources.openRawResource(resourceID);
            try {
                byte[] str = new byte[AccessibilityNodeInfo.ACTION_NEXT_HTML_ELEMENT];
                int strLength = 0;
                while (true) {
                    int bytesLeft = str.length - strLength;
                    if (bytesLeft == 0) {
                        byte[] buf2 = new byte[(str.length * 2)];
                        System.arraycopy(str, 0, buf2, 0, str.length);
                        str = buf2;
                        bytesLeft = str.length - strLength;
                    }
                    int bytesRead = is.read(str, strLength, bytesLeft);
                    if (bytesRead <= 0) {
                        break;
                    }
                    strLength += bytesRead;
                }
                is.close();
                try {
                    this.mShader = new String(str, 0, strLength, "UTF-8");
                } catch (UnsupportedEncodingException e) {
                    Log.e("RenderScript shader creation", "Could not decode shader string");
                }
                return this;
            } catch (IOException e2) {
                throw new NotFoundException();
            } catch (Throwable th) {
                is.close();
            }
        }

        public int getCurrentConstantIndex() {
            return this.mConstantCount - 1;
        }

        public int getCurrentTextureIndex() {
            return this.mTextureCount - 1;
        }

        public BaseProgramBuilder addConstant(Type t) throws IllegalStateException {
            if (this.mConstantCount >= Program.MAX_TEXTURE) {
                throw new RSIllegalArgumentException("Max input count exceeded.");
            } else if (t.getElement().isComplex()) {
                throw new RSIllegalArgumentException("Complex elements not allowed.");
            } else {
                this.mConstants[this.mConstantCount] = t;
                this.mConstantCount++;
                return this;
            }
        }

        public BaseProgramBuilder addTexture(TextureType texType) throws IllegalArgumentException {
            addTexture(texType, "Tex" + this.mTextureCount);
            return this;
        }

        public BaseProgramBuilder addTexture(TextureType texType, String texName) throws IllegalArgumentException {
            if (this.mTextureCount >= Program.MAX_TEXTURE) {
                throw new IllegalArgumentException("Max texture count exceeded.");
            }
            this.mTextureTypes[this.mTextureCount] = texType;
            this.mTextureNames[this.mTextureCount] = texName;
            this.mTextureCount++;
            return this;
        }

        protected void initProgram(Program p) {
            p.mInputs = new Element[this.mInputCount];
            System.arraycopy(this.mInputs, 0, p.mInputs, 0, this.mInputCount);
            p.mOutputs = new Element[this.mOutputCount];
            System.arraycopy(this.mOutputs, 0, p.mOutputs, 0, this.mOutputCount);
            p.mConstants = new Type[this.mConstantCount];
            System.arraycopy(this.mConstants, 0, p.mConstants, 0, this.mConstantCount);
            p.mTextureCount = this.mTextureCount;
            p.mTextures = new TextureType[this.mTextureCount];
            System.arraycopy(this.mTextureTypes, 0, p.mTextures, 0, this.mTextureCount);
            p.mTextureNames = new String[this.mTextureCount];
            System.arraycopy(this.mTextureNames, 0, p.mTextureNames, 0, this.mTextureCount);
        }
    }

    enum ProgramParam {
        INPUT(0),
        OUTPUT(1),
        CONSTANT(2),
        TEXTURE_TYPE(3);
        
        int mID;

        private ProgramParam(int id) {
            this.mID = id;
        }
    }

    public enum TextureType {
        TEXTURE_2D(0),
        TEXTURE_CUBE(1);
        
        int mID;

        private TextureType(int id) {
            this.mID = id;
        }
    }

    Program(long id, RenderScript rs) {
        super(id, rs);
    }

    public int getConstantCount() {
        return this.mConstants != null ? this.mConstants.length : 0;
    }

    public Type getConstant(int slot) {
        if (slot >= 0 && slot < this.mConstants.length) {
            return this.mConstants[slot];
        }
        throw new IllegalArgumentException("Slot ID out of range.");
    }

    public int getTextureCount() {
        return this.mTextureCount;
    }

    public TextureType getTextureType(int slot) {
        if (slot >= 0 && slot < this.mTextureCount) {
            return this.mTextures[slot];
        }
        throw new IllegalArgumentException("Slot ID out of range.");
    }

    public String getTextureName(int slot) {
        if (slot >= 0 && slot < this.mTextureCount) {
            return this.mTextureNames[slot];
        }
        throw new IllegalArgumentException("Slot ID out of range.");
    }

    public void bindConstants(Allocation a, int slot) {
        if (slot < 0 || slot >= this.mConstants.length) {
            throw new IllegalArgumentException("Slot ID out of range.");
        } else if (a == null || a.getType().getID(this.mRS) == this.mConstants[slot].getID(this.mRS)) {
            this.mRS.nProgramBindConstants(getID(this.mRS), slot, a != null ? a.getID(this.mRS) : 0);
        } else {
            throw new IllegalArgumentException("Allocation type does not match slot type.");
        }
    }

    public void bindTexture(Allocation va, int slot) throws IllegalArgumentException {
        this.mRS.validate();
        if (slot < 0 || slot >= this.mTextureCount) {
            throw new IllegalArgumentException("Slot ID out of range.");
        } else if (va == null || !va.getType().hasFaces() || this.mTextures[slot] == TextureType.TEXTURE_CUBE) {
            this.mRS.nProgramBindTexture(getID(this.mRS), slot, va != null ? va.getID(this.mRS) : 0);
        } else {
            throw new IllegalArgumentException("Cannot bind cubemap to 2d texture slot");
        }
    }

    public void bindSampler(Sampler vs, int slot) throws IllegalArgumentException {
        this.mRS.validate();
        if (slot < 0 || slot >= this.mTextureCount) {
            throw new IllegalArgumentException("Slot ID out of range.");
        }
        this.mRS.nProgramBindSampler(getID(this.mRS), slot, vs != null ? vs.getID(this.mRS) : 0);
    }
}
