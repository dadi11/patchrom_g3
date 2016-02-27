package com.android.server.net;

import android.os.Handler;
import android.os.HandlerThread;
import android.text.TextUtils;
import android.util.Log;
import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class DelayedDiskWrite {
    private final String TAG;
    private Handler mDiskWriteHandler;
    private HandlerThread mDiskWriteHandlerThread;
    private int mWriteSequence;

    /* renamed from: com.android.server.net.DelayedDiskWrite.1 */
    class C03871 implements Runnable {
        final /* synthetic */ String val$filePath;
        final /* synthetic */ Writer val$w;

        C03871(String str, Writer writer) {
            this.val$filePath = str;
            this.val$w = writer;
        }

        public void run() {
            DelayedDiskWrite.this.doWrite(this.val$filePath, this.val$w);
        }
    }

    public interface Writer {
        void onWriteCalled(DataOutputStream dataOutputStream) throws IOException;
    }

    public DelayedDiskWrite() {
        this.mWriteSequence = 0;
        this.TAG = "DelayedDiskWrite";
    }

    public void write(String filePath, Writer w) {
        if (TextUtils.isEmpty(filePath)) {
            throw new IllegalArgumentException("empty file path");
        }
        synchronized (this) {
            int i = this.mWriteSequence + 1;
            this.mWriteSequence = i;
            if (i == 1) {
                this.mDiskWriteHandlerThread = new HandlerThread("DelayedDiskWriteThread");
                this.mDiskWriteHandlerThread.start();
                this.mDiskWriteHandler = new Handler(this.mDiskWriteHandlerThread.getLooper());
            }
        }
        this.mDiskWriteHandler.post(new C03871(filePath, w));
    }

    private void doWrite(String filePath, Writer w) {
        Throwable th;
        int i;
        DataOutputStream out = null;
        int i2;
        try {
            DataOutputStream out2 = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(filePath)));
            try {
                w.onWriteCalled(out2);
                if (out2 != null) {
                    try {
                        out2.close();
                    } catch (Exception e) {
                    }
                }
                synchronized (this) {
                    i2 = this.mWriteSequence - 1;
                    this.mWriteSequence = i2;
                    if (i2 == 0) {
                        this.mDiskWriteHandler.getLooper().quit();
                        this.mDiskWriteHandler = null;
                        this.mDiskWriteHandlerThread = null;
                    }
                }
                out = out2;
            } catch (IOException e2) {
                out = out2;
                try {
                    loge("Error writing data file " + filePath);
                    if (out != null) {
                        try {
                            out.close();
                        } catch (Exception e3) {
                        }
                    }
                    synchronized (this) {
                        i2 = this.mWriteSequence - 1;
                        this.mWriteSequence = i2;
                        if (i2 == 0) {
                            this.mDiskWriteHandler.getLooper().quit();
                            this.mDiskWriteHandler = null;
                            this.mDiskWriteHandlerThread = null;
                        }
                    }
                } catch (Throwable th2) {
                    th = th2;
                    if (out != null) {
                        try {
                            out.close();
                        } catch (Exception e4) {
                        }
                    }
                    synchronized (this) {
                        i = this.mWriteSequence - 1;
                        this.mWriteSequence = i;
                        if (i == 0) {
                            this.mDiskWriteHandler.getLooper().quit();
                            this.mDiskWriteHandler = null;
                            this.mDiskWriteHandlerThread = null;
                        }
                    }
                    throw th;
                }
            } catch (Throwable th3) {
                th = th3;
                out = out2;
                if (out != null) {
                    out.close();
                }
                synchronized (this) {
                    i = this.mWriteSequence - 1;
                    this.mWriteSequence = i;
                    if (i == 0) {
                        this.mDiskWriteHandler.getLooper().quit();
                        this.mDiskWriteHandler = null;
                        this.mDiskWriteHandlerThread = null;
                    }
                }
                throw th;
            }
        } catch (IOException e5) {
            loge("Error writing data file " + filePath);
            if (out != null) {
                out.close();
            }
            synchronized (this) {
                i2 = this.mWriteSequence - 1;
                this.mWriteSequence = i2;
                if (i2 == 0) {
                    this.mDiskWriteHandler.getLooper().quit();
                    this.mDiskWriteHandler = null;
                    this.mDiskWriteHandlerThread = null;
                }
            }
        }
    }

    private void loge(String s) {
        Log.e("DelayedDiskWrite", s);
    }
}
