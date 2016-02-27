package android.renderscript;

import android.renderscript.Script.FieldID;
import android.renderscript.Script.KernelID;
import java.util.ArrayList;

public final class ScriptGroup extends BaseObj {
    IO[] mInputs;
    IO[] mOutputs;

    public static final class Builder {
        private int mKernelCount;
        private ArrayList<ConnectLine> mLines;
        private ArrayList<Node> mNodes;
        private RenderScript mRS;

        public Builder(RenderScript rs) {
            this.mNodes = new ArrayList();
            this.mLines = new ArrayList();
            this.mRS = rs;
        }

        private void validateCycle(Node target, Node original) {
            for (int ct = 0; ct < target.mOutputs.size(); ct++) {
                Node tn;
                ConnectLine cl = (ConnectLine) target.mOutputs.get(ct);
                if (cl.mToK != null) {
                    tn = findNode(cl.mToK.mScript);
                    if (tn.equals(original)) {
                        throw new RSInvalidStateException("Loops in group not allowed.");
                    }
                    validateCycle(tn, original);
                }
                if (cl.mToF != null) {
                    tn = findNode(cl.mToF.mScript);
                    if (tn.equals(original)) {
                        throw new RSInvalidStateException("Loops in group not allowed.");
                    }
                    validateCycle(tn, original);
                }
            }
        }

        private void mergeDAGs(int valueUsed, int valueKilled) {
            for (int ct = 0; ct < this.mNodes.size(); ct++) {
                if (((Node) this.mNodes.get(ct)).dagNumber == valueKilled) {
                    ((Node) this.mNodes.get(ct)).dagNumber = valueUsed;
                }
            }
        }

        private void validateDAGRecurse(Node n, int dagNumber) {
            if (n.dagNumber == 0 || n.dagNumber == dagNumber) {
                n.dagNumber = dagNumber;
                for (int ct = 0; ct < n.mOutputs.size(); ct++) {
                    ConnectLine cl = (ConnectLine) n.mOutputs.get(ct);
                    if (cl.mToK != null) {
                        validateDAGRecurse(findNode(cl.mToK.mScript), dagNumber);
                    }
                    if (cl.mToF != null) {
                        validateDAGRecurse(findNode(cl.mToF.mScript), dagNumber);
                    }
                }
                return;
            }
            mergeDAGs(n.dagNumber, dagNumber);
        }

        private void validateDAG() {
            int ct;
            for (ct = 0; ct < this.mNodes.size(); ct++) {
                Node n = (Node) this.mNodes.get(ct);
                if (n.mInputs.size() == 0) {
                    if (n.mOutputs.size() != 0 || this.mNodes.size() <= 1) {
                        validateDAGRecurse(n, ct + 1);
                    } else {
                        throw new RSInvalidStateException("Groups cannot contain unconnected scripts");
                    }
                }
            }
            int dagNumber = ((Node) this.mNodes.get(0)).dagNumber;
            for (ct = 0; ct < this.mNodes.size(); ct++) {
                if (((Node) this.mNodes.get(ct)).dagNumber != dagNumber) {
                    throw new RSInvalidStateException("Multiple DAGs in group not allowed.");
                }
            }
        }

        private Node findNode(Script s) {
            for (int ct = 0; ct < this.mNodes.size(); ct++) {
                if (s == ((Node) this.mNodes.get(ct)).mScript) {
                    return (Node) this.mNodes.get(ct);
                }
            }
            return null;
        }

        private Node findNode(KernelID k) {
            for (int ct = 0; ct < this.mNodes.size(); ct++) {
                Node n = (Node) this.mNodes.get(ct);
                for (int ct2 = 0; ct2 < n.mKernels.size(); ct2++) {
                    if (k == n.mKernels.get(ct2)) {
                        return n;
                    }
                }
            }
            return null;
        }

        public Builder addKernel(KernelID k) {
            if (this.mLines.size() != 0) {
                throw new RSInvalidStateException("Kernels may not be added once connections exist.");
            }
            if (findNode(k) == null) {
                this.mKernelCount++;
                Node n = findNode(k.mScript);
                if (n == null) {
                    n = new Node(k.mScript);
                    this.mNodes.add(n);
                }
                n.mKernels.add(k);
            }
            return this;
        }

        public Builder addConnection(Type t, KernelID from, FieldID to) {
            Node nf = findNode(from);
            if (nf == null) {
                throw new RSInvalidStateException("From script not found.");
            }
            Node nt = findNode(to.mScript);
            if (nt == null) {
                throw new RSInvalidStateException("To script not found.");
            }
            ConnectLine cl = new ConnectLine(t, from, to);
            this.mLines.add(new ConnectLine(t, from, to));
            nf.mOutputs.add(cl);
            nt.mInputs.add(cl);
            validateCycle(nf, nf);
            return this;
        }

        public Builder addConnection(Type t, KernelID from, KernelID to) {
            Node nf = findNode(from);
            if (nf == null) {
                throw new RSInvalidStateException("From script not found.");
            }
            Node nt = findNode(to);
            if (nt == null) {
                throw new RSInvalidStateException("To script not found.");
            }
            ConnectLine cl = new ConnectLine(t, from, to);
            this.mLines.add(new ConnectLine(t, from, to));
            nf.mOutputs.add(cl);
            nt.mInputs.add(cl);
            validateCycle(nf, nf);
            return this;
        }

        public ScriptGroup create() {
            if (this.mNodes.size() == 0) {
                throw new RSInvalidStateException("Empty script groups are not allowed");
            }
            int ct;
            for (ct = 0; ct < this.mNodes.size(); ct++) {
                ((Node) this.mNodes.get(ct)).dagNumber = 0;
            }
            validateDAG();
            ArrayList<IO> inputs = new ArrayList();
            ArrayList<IO> outputs = new ArrayList();
            long[] kernels = new long[this.mKernelCount];
            int idx = 0;
            for (ct = 0; ct < this.mNodes.size(); ct++) {
                Node n = (Node) this.mNodes.get(ct);
                int ct2 = 0;
                while (ct2 < n.mKernels.size()) {
                    int ct3;
                    KernelID kid = (KernelID) n.mKernels.get(ct2);
                    int idx2 = idx + 1;
                    kernels[idx] = kid.getID(this.mRS);
                    boolean hasInput = false;
                    boolean hasOutput = false;
                    for (ct3 = 0; ct3 < n.mInputs.size(); ct3++) {
                        if (((ConnectLine) n.mInputs.get(ct3)).mToK == kid) {
                            hasInput = true;
                        }
                    }
                    for (ct3 = 0; ct3 < n.mOutputs.size(); ct3++) {
                        if (((ConnectLine) n.mOutputs.get(ct3)).mFrom == kid) {
                            hasOutput = true;
                        }
                    }
                    if (!hasInput) {
                        inputs.add(new IO(kid));
                    }
                    if (!hasOutput) {
                        outputs.add(new IO(kid));
                    }
                    ct2++;
                    idx = idx2;
                }
            }
            if (idx != this.mKernelCount) {
                throw new RSRuntimeException("Count mismatch, should not happen.");
            }
            long[] src = new long[this.mLines.size()];
            long[] dstk = new long[this.mLines.size()];
            long[] dstf = new long[this.mLines.size()];
            long[] types = new long[this.mLines.size()];
            for (ct = 0; ct < this.mLines.size(); ct++) {
                ConnectLine cl = (ConnectLine) this.mLines.get(ct);
                src[ct] = cl.mFrom.getID(this.mRS);
                if (cl.mToK != null) {
                    dstk[ct] = cl.mToK.getID(this.mRS);
                }
                if (cl.mToF != null) {
                    dstf[ct] = cl.mToF.getID(this.mRS);
                }
                types[ct] = cl.mAllocationType.getID(this.mRS);
            }
            long id = this.mRS.nScriptGroupCreate(kernels, src, dstk, dstf, types);
            if (id == 0) {
                throw new RSRuntimeException("Object creation error, should not happen.");
            }
            ScriptGroup scriptGroup = new ScriptGroup(id, this.mRS);
            scriptGroup.mOutputs = new IO[outputs.size()];
            for (ct = 0; ct < outputs.size(); ct++) {
                scriptGroup.mOutputs[ct] = (IO) outputs.get(ct);
            }
            scriptGroup.mInputs = new IO[inputs.size()];
            for (ct = 0; ct < inputs.size(); ct++) {
                scriptGroup.mInputs[ct] = (IO) inputs.get(ct);
            }
            return scriptGroup;
        }
    }

    static class ConnectLine {
        Type mAllocationType;
        KernelID mFrom;
        FieldID mToF;
        KernelID mToK;

        ConnectLine(Type t, KernelID from, KernelID to) {
            this.mFrom = from;
            this.mToK = to;
            this.mAllocationType = t;
        }

        ConnectLine(Type t, KernelID from, FieldID to) {
            this.mFrom = from;
            this.mToF = to;
            this.mAllocationType = t;
        }
    }

    static class IO {
        Allocation mAllocation;
        KernelID mKID;

        IO(KernelID s) {
            this.mKID = s;
        }
    }

    static class Node {
        int dagNumber;
        ArrayList<ConnectLine> mInputs;
        ArrayList<KernelID> mKernels;
        Node mNext;
        ArrayList<ConnectLine> mOutputs;
        Script mScript;

        Node(Script s) {
            this.mKernels = new ArrayList();
            this.mInputs = new ArrayList();
            this.mOutputs = new ArrayList();
            this.mScript = s;
        }
    }

    ScriptGroup(long id, RenderScript rs) {
        super(id, rs);
    }

    public void setInput(KernelID s, Allocation a) {
        for (int ct = 0; ct < this.mInputs.length; ct++) {
            if (this.mInputs[ct].mKID == s) {
                this.mInputs[ct].mAllocation = a;
                this.mRS.nScriptGroupSetInput(getID(this.mRS), s.getID(this.mRS), this.mRS.safeID(a));
                return;
            }
        }
        throw new RSIllegalArgumentException("Script not found");
    }

    public void setOutput(KernelID s, Allocation a) {
        for (int ct = 0; ct < this.mOutputs.length; ct++) {
            if (this.mOutputs[ct].mKID == s) {
                this.mOutputs[ct].mAllocation = a;
                this.mRS.nScriptGroupSetOutput(getID(this.mRS), s.getID(this.mRS), this.mRS.safeID(a));
                return;
            }
        }
        throw new RSIllegalArgumentException("Script not found");
    }

    public void execute() {
        this.mRS.nScriptGroupExecute(getID(this.mRS));
    }
}
