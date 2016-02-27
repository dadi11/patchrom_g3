package android.renderscript;

import android.renderscript.Program.BaseProgramBuilder;
import android.renderscript.Program.TextureType;
import android.view.WindowManager.LayoutParams;
import android.widget.Toast;

public class ProgramFragmentFixedFunction extends ProgramFragment {

    /* renamed from: android.renderscript.ProgramFragmentFixedFunction.1 */
    static /* synthetic */ class C06591 {
        static final /* synthetic */ int[] f71x21e46749;
        static final /* synthetic */ int[] f72xa802c1be;

        static {
            f71x21e46749 = new int[EnvMode.values().length];
            try {
                f71x21e46749[EnvMode.REPLACE.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                f71x21e46749[EnvMode.MODULATE.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                f71x21e46749[EnvMode.DECAL.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            f72xa802c1be = new int[Format.values().length];
            try {
                f72xa802c1be[Format.ALPHA.ordinal()] = 1;
            } catch (NoSuchFieldError e4) {
            }
            try {
                f72xa802c1be[Format.LUMINANCE_ALPHA.ordinal()] = 2;
            } catch (NoSuchFieldError e5) {
            }
            try {
                f72xa802c1be[Format.RGB.ordinal()] = 3;
            } catch (NoSuchFieldError e6) {
            }
            try {
                f72xa802c1be[Format.RGBA.ordinal()] = 4;
            } catch (NoSuchFieldError e7) {
            }
        }
    }

    public static class Builder {
        public static final int MAX_TEXTURE = 2;
        int mNumTextures;
        boolean mPointSpriteEnable;
        RenderScript mRS;
        String mShader;
        Slot[] mSlots;
        boolean mVaryingColorEnable;

        public enum EnvMode {
            REPLACE(1),
            MODULATE(Builder.MAX_TEXTURE),
            DECAL(3);
            
            int mID;

            private EnvMode(int id) {
                this.mID = id;
            }
        }

        public enum Format {
            ALPHA(1),
            LUMINANCE_ALPHA(Builder.MAX_TEXTURE),
            RGB(3),
            RGBA(4);
            
            int mID;

            private Format(int id) {
                this.mID = id;
            }
        }

        private class Slot {
            EnvMode env;
            Format format;

            Slot(EnvMode _env, Format _fmt) {
                this.env = _env;
                this.format = _fmt;
            }
        }

        private void buildShaderString() {
            this.mShader = "//rs_shader_internal\n";
            this.mShader += "varying lowp vec4 varColor;\n";
            this.mShader += "varying vec2 varTex0;\n";
            this.mShader += "void main() {\n";
            if (this.mVaryingColorEnable) {
                this.mShader += "  lowp vec4 col = varColor;\n";
            } else {
                this.mShader += "  lowp vec4 col = UNI_Color;\n";
            }
            if (this.mNumTextures != 0) {
                if (this.mPointSpriteEnable) {
                    this.mShader += "  vec2 t0 = gl_PointCoord;\n";
                } else {
                    this.mShader += "  vec2 t0 = varTex0.xy;\n";
                }
            }
            for (int i = 0; i < this.mNumTextures; i++) {
                switch (C06591.f71x21e46749[this.mSlots[i].env.ordinal()]) {
                    case Toast.LENGTH_LONG /*1*/:
                        switch (C06591.f72xa802c1be[this.mSlots[i].format.ordinal()]) {
                            case Toast.LENGTH_LONG /*1*/:
                                this.mShader += "  col.a = texture2D(UNI_Tex0, t0).a;\n";
                                break;
                            case MAX_TEXTURE /*2*/:
                                this.mShader += "  col.rgba = texture2D(UNI_Tex0, t0).rgba;\n";
                                break;
                            case SetDrawableParameters.TAG /*3*/:
                                this.mShader += "  col.rgb = texture2D(UNI_Tex0, t0).rgb;\n";
                                break;
                            case ViewGroupAction.TAG /*4*/:
                                this.mShader += "  col.rgba = texture2D(UNI_Tex0, t0).rgba;\n";
                                break;
                            default:
                                break;
                        }
                    case MAX_TEXTURE /*2*/:
                        switch (C06591.f72xa802c1be[this.mSlots[i].format.ordinal()]) {
                            case Toast.LENGTH_LONG /*1*/:
                                this.mShader += "  col.a *= texture2D(UNI_Tex0, t0).a;\n";
                                break;
                            case MAX_TEXTURE /*2*/:
                                this.mShader += "  col.rgba *= texture2D(UNI_Tex0, t0).rgba;\n";
                                break;
                            case SetDrawableParameters.TAG /*3*/:
                                this.mShader += "  col.rgb *= texture2D(UNI_Tex0, t0).rgb;\n";
                                break;
                            case ViewGroupAction.TAG /*4*/:
                                this.mShader += "  col.rgba *= texture2D(UNI_Tex0, t0).rgba;\n";
                                break;
                            default:
                                break;
                        }
                    case SetDrawableParameters.TAG /*3*/:
                        this.mShader += "  col = texture2D(UNI_Tex0, t0);\n";
                        break;
                    default:
                        break;
                }
            }
            this.mShader += "  gl_FragColor = col;\n";
            this.mShader += "}\n";
        }

        public Builder(RenderScript rs) {
            this.mRS = rs;
            this.mSlots = new Slot[MAX_TEXTURE];
            this.mPointSpriteEnable = false;
        }

        public Builder setTexture(EnvMode env, Format fmt, int slot) throws IllegalArgumentException {
            if (slot < 0 || slot >= MAX_TEXTURE) {
                throw new IllegalArgumentException("MAX_TEXTURE exceeded.");
            }
            this.mSlots[slot] = new Slot(env, fmt);
            return this;
        }

        public Builder setPointSpriteTexCoordinateReplacement(boolean enable) {
            this.mPointSpriteEnable = enable;
            return this;
        }

        public Builder setVaryingColor(boolean enable) {
            this.mVaryingColorEnable = enable;
            return this;
        }

        public ProgramFragmentFixedFunction create() {
            int i;
            InternalBuilder sb = new InternalBuilder(this.mRS);
            this.mNumTextures = 0;
            for (i = 0; i < MAX_TEXTURE; i++) {
                if (this.mSlots[i] != null) {
                    this.mNumTextures++;
                }
            }
            buildShaderString();
            sb.setShader(this.mShader);
            Type constType = null;
            if (!this.mVaryingColorEnable) {
                android.renderscript.Element.Builder b = new android.renderscript.Element.Builder(this.mRS);
                b.add(Element.F32_4(this.mRS), "Color");
                android.renderscript.Type.Builder typeBuilder = new android.renderscript.Type.Builder(this.mRS, b.create());
                typeBuilder.setX(1);
                constType = typeBuilder.create();
                sb.addConstant(constType);
            }
            for (i = 0; i < this.mNumTextures; i++) {
                sb.addTexture(TextureType.TEXTURE_2D);
            }
            ProgramFragmentFixedFunction pf = sb.create();
            pf.mTextureCount = MAX_TEXTURE;
            if (!this.mVaryingColorEnable) {
                Allocation constantData = Allocation.createTyped(this.mRS, constType);
                FieldPacker fp = new FieldPacker(16);
                fp.addF32(new Float4(LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL));
                constantData.setFromFieldPacker(0, fp);
                pf.bindConstants(constantData, 0);
            }
            return pf;
        }
    }

    static class InternalBuilder extends BaseProgramBuilder {
        public InternalBuilder(RenderScript rs) {
            super(rs);
        }

        public ProgramFragmentFixedFunction create() {
            int i;
            this.mRS.validate();
            long[] tmp = new long[((((this.mInputCount + this.mOutputCount) + this.mConstantCount) + this.mTextureCount) * 2)];
            String[] texNames = new String[this.mTextureCount];
            int idx = 0;
            for (i = 0; i < this.mInputCount; i++) {
                int i2 = idx + 1;
                tmp[idx] = (long) ProgramParam.INPUT.mID;
                idx = i2 + 1;
                tmp[i2] = this.mInputs[i].getID(this.mRS);
            }
            for (i = 0; i < this.mOutputCount; i++) {
                i2 = idx + 1;
                tmp[idx] = (long) ProgramParam.OUTPUT.mID;
                idx = i2 + 1;
                tmp[i2] = this.mOutputs[i].getID(this.mRS);
            }
            for (i = 0; i < this.mConstantCount; i++) {
                i2 = idx + 1;
                tmp[idx] = (long) ProgramParam.CONSTANT.mID;
                idx = i2 + 1;
                tmp[i2] = this.mConstants[i].getID(this.mRS);
            }
            for (i = 0; i < this.mTextureCount; i++) {
                i2 = idx + 1;
                tmp[idx] = (long) ProgramParam.TEXTURE_TYPE.mID;
                idx = i2 + 1;
                tmp[i2] = (long) this.mTextureTypes[i].mID;
                texNames[i] = this.mTextureNames[i];
            }
            ProgramFragmentFixedFunction pf = new ProgramFragmentFixedFunction(this.mRS.nProgramFragmentCreate(this.mShader, texNames, tmp), this.mRS);
            initProgram(pf);
            return pf;
        }
    }

    ProgramFragmentFixedFunction(long id, RenderScript rs) {
        super(id, rs);
    }
}
