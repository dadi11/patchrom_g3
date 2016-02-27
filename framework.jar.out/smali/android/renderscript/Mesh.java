package android.renderscript;

import android.hardware.Camera.Parameters;
import android.renderscript.Element.DataType;
import android.telephony.SubscriptionManager;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityNodeInfo;
import java.util.Vector;

public class Mesh extends BaseObj {
    Allocation[] mIndexBuffers;
    Primitive[] mPrimitives;
    Allocation[] mVertexBuffers;

    public static class AllocationBuilder {
        Vector mIndexTypes;
        RenderScript mRS;
        int mVertexTypeCount;
        Entry[] mVertexTypes;

        class Entry {
            Allocation f68a;
            Primitive prim;

            Entry() {
            }
        }

        public AllocationBuilder(RenderScript rs) {
            this.mRS = rs;
            this.mVertexTypeCount = 0;
            this.mVertexTypes = new Entry[16];
            this.mIndexTypes = new Vector();
        }

        public int getCurrentVertexTypeIndex() {
            return this.mVertexTypeCount - 1;
        }

        public int getCurrentIndexSetIndex() {
            return this.mIndexTypes.size() - 1;
        }

        public AllocationBuilder addVertexAllocation(Allocation a) throws IllegalStateException {
            if (this.mVertexTypeCount >= this.mVertexTypes.length) {
                throw new IllegalStateException("Max vertex types exceeded.");
            }
            this.mVertexTypes[this.mVertexTypeCount] = new Entry();
            this.mVertexTypes[this.mVertexTypeCount].f68a = a;
            this.mVertexTypeCount++;
            return this;
        }

        public AllocationBuilder addIndexSetAllocation(Allocation a, Primitive p) {
            Entry indexType = new Entry();
            indexType.f68a = a;
            indexType.prim = p;
            this.mIndexTypes.addElement(indexType);
            return this;
        }

        public AllocationBuilder addIndexSetType(Primitive p) {
            Entry indexType = new Entry();
            indexType.f68a = null;
            indexType.prim = p;
            this.mIndexTypes.addElement(indexType);
            return this;
        }

        public Mesh create() {
            int ct;
            this.mRS.validate();
            long[] vtx = new long[this.mVertexTypeCount];
            long[] idx = new long[this.mIndexTypes.size()];
            int[] prim = new int[this.mIndexTypes.size()];
            Allocation[] indexBuffers = new Allocation[this.mIndexTypes.size()];
            Primitive[] primitives = new Primitive[this.mIndexTypes.size()];
            Allocation[] vertexBuffers = new Allocation[this.mVertexTypeCount];
            for (ct = 0; ct < this.mVertexTypeCount; ct++) {
                Entry entry = this.mVertexTypes[ct];
                vertexBuffers[ct] = entry.f68a;
                vtx[ct] = entry.f68a.getID(this.mRS);
            }
            for (ct = 0; ct < this.mIndexTypes.size(); ct++) {
                long allocID;
                entry = (Entry) this.mIndexTypes.elementAt(ct);
                if (entry.f68a == null) {
                    allocID = 0;
                } else {
                    allocID = entry.f68a.getID(this.mRS);
                }
                indexBuffers[ct] = entry.f68a;
                primitives[ct] = entry.prim;
                idx[ct] = allocID;
                prim[ct] = entry.prim.mID;
            }
            Mesh newMesh = new Mesh(this.mRS.nMeshCreate(vtx, idx, prim), this.mRS);
            newMesh.mVertexBuffers = vertexBuffers;
            newMesh.mIndexBuffers = indexBuffers;
            newMesh.mPrimitives = primitives;
            return newMesh;
        }
    }

    public static class Builder {
        Vector mIndexTypes;
        RenderScript mRS;
        int mUsage;
        int mVertexTypeCount;
        Entry[] mVertexTypes;

        class Entry {
            Element f69e;
            Primitive prim;
            int size;
            Type f70t;
            int usage;

            Entry() {
            }
        }

        public Builder(RenderScript rs, int usage) {
            this.mRS = rs;
            this.mUsage = usage;
            this.mVertexTypeCount = 0;
            this.mVertexTypes = new Entry[16];
            this.mIndexTypes = new Vector();
        }

        public int getCurrentVertexTypeIndex() {
            return this.mVertexTypeCount - 1;
        }

        public int getCurrentIndexSetIndex() {
            return this.mIndexTypes.size() - 1;
        }

        public Builder addVertexType(Type t) throws IllegalStateException {
            if (this.mVertexTypeCount >= this.mVertexTypes.length) {
                throw new IllegalStateException("Max vertex types exceeded.");
            }
            this.mVertexTypes[this.mVertexTypeCount] = new Entry();
            this.mVertexTypes[this.mVertexTypeCount].f70t = t;
            this.mVertexTypes[this.mVertexTypeCount].f69e = null;
            this.mVertexTypeCount++;
            return this;
        }

        public Builder addVertexType(Element e, int size) throws IllegalStateException {
            if (this.mVertexTypeCount >= this.mVertexTypes.length) {
                throw new IllegalStateException("Max vertex types exceeded.");
            }
            this.mVertexTypes[this.mVertexTypeCount] = new Entry();
            this.mVertexTypes[this.mVertexTypeCount].f70t = null;
            this.mVertexTypes[this.mVertexTypeCount].f69e = e;
            this.mVertexTypes[this.mVertexTypeCount].size = size;
            this.mVertexTypeCount++;
            return this;
        }

        public Builder addIndexSetType(Type t, Primitive p) {
            Entry indexType = new Entry();
            indexType.f70t = t;
            indexType.f69e = null;
            indexType.size = 0;
            indexType.prim = p;
            this.mIndexTypes.addElement(indexType);
            return this;
        }

        public Builder addIndexSetType(Primitive p) {
            Entry indexType = new Entry();
            indexType.f70t = null;
            indexType.f69e = null;
            indexType.size = 0;
            indexType.prim = p;
            this.mIndexTypes.addElement(indexType);
            return this;
        }

        public Builder addIndexSetType(Element e, int size, Primitive p) {
            Entry indexType = new Entry();
            indexType.f70t = null;
            indexType.f69e = e;
            indexType.size = size;
            indexType.prim = p;
            this.mIndexTypes.addElement(indexType);
            return this;
        }

        Type newType(Element e, int size) {
            android.renderscript.Type.Builder tb = new android.renderscript.Type.Builder(this.mRS, e);
            tb.setX(size);
            return tb.create();
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public android.renderscript.Mesh create() {
            /*
            r20 = this;
            r0 = r20;
            r0 = r0.mRS;
            r16 = r0;
            r16.validate();
            r0 = r20;
            r0 = r0.mVertexTypeCount;
            r16 = r0;
            r0 = r16;
            r15 = new long[r0];
            r0 = r20;
            r0 = r0.mIndexTypes;
            r16 = r0;
            r16 = r16.size();
            r0 = r16;
            r7 = new long[r0];
            r0 = r20;
            r0 = r0.mIndexTypes;
            r16 = r0;
            r16 = r16.size();
            r0 = r16;
            r12 = new int[r0];
            r0 = r20;
            r0 = r0.mVertexTypeCount;
            r16 = r0;
            r0 = r16;
            r14 = new android.renderscript.Allocation[r0];
            r0 = r20;
            r0 = r0.mIndexTypes;
            r16 = r0;
            r16 = r16.size();
            r0 = r16;
            r10 = new android.renderscript.Allocation[r0];
            r0 = r20;
            r0 = r0.mIndexTypes;
            r16 = r0;
            r16 = r16.size();
            r0 = r16;
            r13 = new android.renderscript.Mesh.Primitive[r0];
            r3 = 0;
        L_0x0056:
            r0 = r20;
            r0 = r0.mVertexTypeCount;
            r16 = r0;
            r0 = r16;
            if (r3 >= r0) goto L_0x00bd;
        L_0x0060:
            r2 = 0;
            r0 = r20;
            r0 = r0.mVertexTypes;
            r16 = r0;
            r6 = r16[r3];
            r0 = r6.f70t;
            r16 = r0;
            if (r16 == 0) goto L_0x0096;
        L_0x006f:
            r0 = r20;
            r0 = r0.mRS;
            r16 = r0;
            r0 = r6.f70t;
            r17 = r0;
            r0 = r20;
            r0 = r0.mUsage;
            r18 = r0;
            r2 = android.renderscript.Allocation.createTyped(r16, r17, r18);
        L_0x0083:
            r14[r3] = r2;
            r0 = r20;
            r0 = r0.mRS;
            r16 = r0;
            r0 = r16;
            r16 = r2.getID(r0);
            r15[r3] = r16;
            r3 = r3 + 1;
            goto L_0x0056;
        L_0x0096:
            r0 = r6.f69e;
            r16 = r0;
            if (r16 == 0) goto L_0x00b5;
        L_0x009c:
            r0 = r20;
            r0 = r0.mRS;
            r16 = r0;
            r0 = r6.f69e;
            r17 = r0;
            r0 = r6.size;
            r18 = r0;
            r0 = r20;
            r0 = r0.mUsage;
            r19 = r0;
            r2 = android.renderscript.Allocation.createSized(r16, r17, r18, r19);
            goto L_0x0083;
        L_0x00b5:
            r16 = new java.lang.IllegalStateException;
            r17 = "Builder corrupt, no valid element in entry.";
            r16.<init>(r17);
            throw r16;
        L_0x00bd:
            r3 = 0;
        L_0x00be:
            r0 = r20;
            r0 = r0.mIndexTypes;
            r16 = r0;
            r16 = r16.size();
            r0 = r16;
            if (r3 >= r0) goto L_0x0146;
        L_0x00cc:
            r2 = 0;
            r0 = r20;
            r0 = r0.mIndexTypes;
            r16 = r0;
            r0 = r16;
            r6 = r0.elementAt(r3);
            r6 = (android.renderscript.Mesh.Builder.Entry) r6;
            r0 = r6.f70t;
            r16 = r0;
            if (r16 == 0) goto L_0x0112;
        L_0x00e1:
            r0 = r20;
            r0 = r0.mRS;
            r16 = r0;
            r0 = r6.f70t;
            r17 = r0;
            r0 = r20;
            r0 = r0.mUsage;
            r18 = r0;
            r2 = android.renderscript.Allocation.createTyped(r16, r17, r18);
        L_0x00f5:
            if (r2 != 0) goto L_0x0139;
        L_0x00f7:
            r4 = 0;
        L_0x00f9:
            r10[r3] = r2;
            r0 = r6.prim;
            r16 = r0;
            r13[r3] = r16;
            r7[r3] = r4;
            r0 = r6.prim;
            r16 = r0;
            r0 = r16;
            r0 = r0.mID;
            r16 = r0;
            r12[r3] = r16;
            r3 = r3 + 1;
            goto L_0x00be;
        L_0x0112:
            r0 = r6.f69e;
            r16 = r0;
            if (r16 == 0) goto L_0x0131;
        L_0x0118:
            r0 = r20;
            r0 = r0.mRS;
            r16 = r0;
            r0 = r6.f69e;
            r17 = r0;
            r0 = r6.size;
            r18 = r0;
            r0 = r20;
            r0 = r0.mUsage;
            r19 = r0;
            r2 = android.renderscript.Allocation.createSized(r16, r17, r18, r19);
            goto L_0x00f5;
        L_0x0131:
            r16 = new java.lang.IllegalStateException;
            r17 = "Builder corrupt, no valid element in entry.";
            r16.<init>(r17);
            throw r16;
        L_0x0139:
            r0 = r20;
            r0 = r0.mRS;
            r16 = r0;
            r0 = r16;
            r4 = r2.getID(r0);
            goto L_0x00f9;
        L_0x0146:
            r0 = r20;
            r0 = r0.mRS;
            r16 = r0;
            r0 = r16;
            r8 = r0.nMeshCreate(r15, r7, r12);
            r11 = new android.renderscript.Mesh;
            r0 = r20;
            r0 = r0.mRS;
            r16 = r0;
            r0 = r16;
            r11.<init>(r8, r0);
            r11.mVertexBuffers = r14;
            r11.mIndexBuffers = r10;
            r11.mPrimitives = r13;
            return r11;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.renderscript.Mesh.Builder.create():android.renderscript.Mesh");
        }
    }

    public enum Primitive {
        POINT(0),
        LINE(1),
        LINE_STRIP(2),
        TRIANGLE(3),
        TRIANGLE_STRIP(4),
        TRIANGLE_FAN(5);
        
        int mID;

        private Primitive(int id) {
            this.mID = id;
        }
    }

    public static class TriangleMeshBuilder {
        public static final int COLOR = 1;
        public static final int NORMAL = 2;
        public static final int TEXTURE_0 = 256;
        float mA;
        float mB;
        Element mElement;
        int mFlags;
        float mG;
        int mIndexCount;
        short[] mIndexData;
        int mMaxIndex;
        float mNX;
        float mNY;
        float mNZ;
        float mR;
        RenderScript mRS;
        float mS0;
        float mT0;
        int mVtxCount;
        float[] mVtxData;
        int mVtxSize;

        public TriangleMeshBuilder(RenderScript rs, int vtxSize, int flags) {
            this.mNX = 0.0f;
            this.mNY = 0.0f;
            this.mNZ = LayoutParams.BRIGHTNESS_OVERRIDE_NONE;
            this.mS0 = 0.0f;
            this.mT0 = 0.0f;
            this.mR = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
            this.mG = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
            this.mB = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
            this.mA = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
            this.mRS = rs;
            this.mVtxCount = 0;
            this.mMaxIndex = 0;
            this.mIndexCount = 0;
            this.mVtxData = new float[AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS];
            this.mIndexData = new short[AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS];
            this.mVtxSize = vtxSize;
            this.mFlags = flags;
            if (vtxSize < NORMAL || vtxSize > 3) {
                throw new IllegalArgumentException("Vertex size out of range.");
            }
        }

        private void makeSpace(int count) {
            if (this.mVtxCount + count >= this.mVtxData.length) {
                float[] t = new float[(this.mVtxData.length * NORMAL)];
                System.arraycopy(this.mVtxData, 0, t, 0, this.mVtxData.length);
                this.mVtxData = t;
            }
        }

        private void latch() {
            if ((this.mFlags & COLOR) != 0) {
                makeSpace(4);
                float[] fArr = this.mVtxData;
                int i = this.mVtxCount;
                this.mVtxCount = i + COLOR;
                fArr[i] = this.mR;
                fArr = this.mVtxData;
                i = this.mVtxCount;
                this.mVtxCount = i + COLOR;
                fArr[i] = this.mG;
                fArr = this.mVtxData;
                i = this.mVtxCount;
                this.mVtxCount = i + COLOR;
                fArr[i] = this.mB;
                fArr = this.mVtxData;
                i = this.mVtxCount;
                this.mVtxCount = i + COLOR;
                fArr[i] = this.mA;
            }
            if ((this.mFlags & TEXTURE_0) != 0) {
                makeSpace(NORMAL);
                fArr = this.mVtxData;
                i = this.mVtxCount;
                this.mVtxCount = i + COLOR;
                fArr[i] = this.mS0;
                fArr = this.mVtxData;
                i = this.mVtxCount;
                this.mVtxCount = i + COLOR;
                fArr[i] = this.mT0;
            }
            if ((this.mFlags & NORMAL) != 0) {
                makeSpace(4);
                fArr = this.mVtxData;
                i = this.mVtxCount;
                this.mVtxCount = i + COLOR;
                fArr[i] = this.mNX;
                fArr = this.mVtxData;
                i = this.mVtxCount;
                this.mVtxCount = i + COLOR;
                fArr[i] = this.mNY;
                fArr = this.mVtxData;
                i = this.mVtxCount;
                this.mVtxCount = i + COLOR;
                fArr[i] = this.mNZ;
                fArr = this.mVtxData;
                i = this.mVtxCount;
                this.mVtxCount = i + COLOR;
                fArr[i] = 0.0f;
            }
            this.mMaxIndex += COLOR;
        }

        public TriangleMeshBuilder addVertex(float x, float y) {
            if (this.mVtxSize != NORMAL) {
                throw new IllegalStateException("add mistmatch with declared components.");
            }
            makeSpace(NORMAL);
            float[] fArr = this.mVtxData;
            int i = this.mVtxCount;
            this.mVtxCount = i + COLOR;
            fArr[i] = x;
            fArr = this.mVtxData;
            i = this.mVtxCount;
            this.mVtxCount = i + COLOR;
            fArr[i] = y;
            latch();
            return this;
        }

        public TriangleMeshBuilder addVertex(float x, float y, float z) {
            if (this.mVtxSize != 3) {
                throw new IllegalStateException("add mistmatch with declared components.");
            }
            makeSpace(4);
            float[] fArr = this.mVtxData;
            int i = this.mVtxCount;
            this.mVtxCount = i + COLOR;
            fArr[i] = x;
            fArr = this.mVtxData;
            i = this.mVtxCount;
            this.mVtxCount = i + COLOR;
            fArr[i] = y;
            fArr = this.mVtxData;
            i = this.mVtxCount;
            this.mVtxCount = i + COLOR;
            fArr[i] = z;
            fArr = this.mVtxData;
            i = this.mVtxCount;
            this.mVtxCount = i + COLOR;
            fArr[i] = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
            latch();
            return this;
        }

        public TriangleMeshBuilder setTexture(float s, float t) {
            if ((this.mFlags & TEXTURE_0) == 0) {
                throw new IllegalStateException("add mistmatch with declared components.");
            }
            this.mS0 = s;
            this.mT0 = t;
            return this;
        }

        public TriangleMeshBuilder setNormal(float x, float y, float z) {
            if ((this.mFlags & NORMAL) == 0) {
                throw new IllegalStateException("add mistmatch with declared components.");
            }
            this.mNX = x;
            this.mNY = y;
            this.mNZ = z;
            return this;
        }

        public TriangleMeshBuilder setColor(float r, float g, float b, float a) {
            if ((this.mFlags & COLOR) == 0) {
                throw new IllegalStateException("add mistmatch with declared components.");
            }
            this.mR = r;
            this.mG = g;
            this.mB = b;
            this.mA = a;
            return this;
        }

        public TriangleMeshBuilder addTriangle(int idx1, int idx2, int idx3) {
            if (idx1 >= this.mMaxIndex || idx1 < 0 || idx2 >= this.mMaxIndex || idx2 < 0 || idx3 >= this.mMaxIndex || idx3 < 0) {
                throw new IllegalStateException("Index provided greater than vertex count.");
            }
            if (this.mIndexCount + 3 >= this.mIndexData.length) {
                short[] t = new short[(this.mIndexData.length * NORMAL)];
                System.arraycopy(this.mIndexData, 0, t, 0, this.mIndexData.length);
                this.mIndexData = t;
            }
            short[] sArr = this.mIndexData;
            int i = this.mIndexCount;
            this.mIndexCount = i + COLOR;
            sArr[i] = (short) idx1;
            sArr = this.mIndexData;
            i = this.mIndexCount;
            this.mIndexCount = i + COLOR;
            sArr[i] = (short) idx2;
            sArr = this.mIndexData;
            i = this.mIndexCount;
            this.mIndexCount = i + COLOR;
            sArr[i] = (short) idx3;
            return this;
        }

        public Mesh create(boolean uploadToBufferObject) {
            android.renderscript.Element.Builder b = new android.renderscript.Element.Builder(this.mRS);
            b.add(Element.createVector(this.mRS, DataType.FLOAT_32, this.mVtxSize), "position");
            if ((this.mFlags & COLOR) != 0) {
                b.add(Element.F32_4(this.mRS), SubscriptionManager.COLOR);
            }
            if ((this.mFlags & TEXTURE_0) != 0) {
                b.add(Element.F32_2(this.mRS), "texture0");
            }
            if ((this.mFlags & NORMAL) != 0) {
                b.add(Element.F32_3(this.mRS), Parameters.FOCUS_MODE_NORMAL);
            }
            this.mElement = b.create();
            int usage = COLOR;
            if (uploadToBufferObject) {
                usage = COLOR | 4;
            }
            Builder smb = new Builder(this.mRS, usage);
            smb.addVertexType(this.mElement, this.mMaxIndex);
            smb.addIndexSetType(Element.U16(this.mRS), this.mIndexCount, Primitive.TRIANGLE);
            Mesh sm = smb.create();
            sm.getVertexAllocation(0).copy1DRangeFromUnchecked(0, this.mMaxIndex, this.mVtxData);
            if (uploadToBufferObject && uploadToBufferObject) {
                sm.getVertexAllocation(0).syncAll(COLOR);
            }
            sm.getIndexSetAllocation(0).copy1DRangeFromUnchecked(0, this.mIndexCount, this.mIndexData);
            if (uploadToBufferObject) {
                sm.getIndexSetAllocation(0).syncAll(COLOR);
            }
            return sm;
        }
    }

    Mesh(long id, RenderScript rs) {
        super(id, rs);
    }

    public int getVertexAllocationCount() {
        if (this.mVertexBuffers == null) {
            return 0;
        }
        return this.mVertexBuffers.length;
    }

    public Allocation getVertexAllocation(int slot) {
        return this.mVertexBuffers[slot];
    }

    public int getPrimitiveCount() {
        if (this.mIndexBuffers == null) {
            return 0;
        }
        return this.mIndexBuffers.length;
    }

    public Allocation getIndexSetAllocation(int slot) {
        return this.mIndexBuffers[slot];
    }

    public Primitive getPrimitive(int slot) {
        return this.mPrimitives[slot];
    }

    void updateFromNative() {
        int i;
        super.updateFromNative();
        int vtxCount = this.mRS.nMeshGetVertexBufferCount(getID(this.mRS));
        int idxCount = this.mRS.nMeshGetIndexCount(getID(this.mRS));
        long[] vtxIDs = new long[vtxCount];
        long[] idxIDs = new long[idxCount];
        int[] primitives = new int[idxCount];
        this.mRS.nMeshGetVertices(getID(this.mRS), vtxIDs, vtxCount);
        this.mRS.nMeshGetIndices(getID(this.mRS), idxIDs, primitives, idxCount);
        this.mVertexBuffers = new Allocation[vtxCount];
        this.mIndexBuffers = new Allocation[idxCount];
        this.mPrimitives = new Primitive[idxCount];
        for (i = 0; i < vtxCount; i++) {
            if (vtxIDs[i] != 0) {
                this.mVertexBuffers[i] = new Allocation(vtxIDs[i], this.mRS, null, 1);
                this.mVertexBuffers[i].updateFromNative();
            }
        }
        for (i = 0; i < idxCount; i++) {
            if (idxIDs[i] != 0) {
                this.mIndexBuffers[i] = new Allocation(idxIDs[i], this.mRS, null, 1);
                this.mIndexBuffers[i].updateFromNative();
            }
            this.mPrimitives[i] = Primitive.values()[primitives[i]];
        }
    }
}
