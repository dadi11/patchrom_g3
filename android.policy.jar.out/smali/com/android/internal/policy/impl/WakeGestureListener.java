package com.android.internal.policy.impl;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.TriggerEvent;
import android.hardware.TriggerEventListener;
import android.os.Handler;
import java.io.PrintWriter;

public abstract class WakeGestureListener {
    private static final String TAG = "WakeGestureListener";
    private final Handler mHandler;
    private final TriggerEventListener mListener;
    private final Object mLock;
    private Sensor mSensor;
    private final SensorManager mSensorManager;
    private boolean mTriggerRequested;
    private final Runnable mWakeUpRunnable;

    /* renamed from: com.android.internal.policy.impl.WakeGestureListener.1 */
    class C00401 extends TriggerEventListener {
        C00401() {
        }

        public void onTrigger(TriggerEvent event) {
            synchronized (WakeGestureListener.this.mLock) {
                WakeGestureListener.this.mTriggerRequested = false;
                WakeGestureListener.this.mHandler.post(WakeGestureListener.this.mWakeUpRunnable);
            }
        }
    }

    /* renamed from: com.android.internal.policy.impl.WakeGestureListener.2 */
    class C00412 implements Runnable {
        C00412() {
        }

        public void run() {
            WakeGestureListener.this.onWakeUp();
        }
    }

    public abstract void onWakeUp();

    public WakeGestureListener(Context context, Handler handler) {
        this.mLock = new Object();
        this.mListener = new C00401();
        this.mWakeUpRunnable = new C00412();
        this.mSensorManager = (SensorManager) context.getSystemService("sensor");
        this.mHandler = handler;
        this.mSensor = this.mSensorManager.getDefaultSensor(23);
    }

    public boolean isSupported() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mSensor != null;
        }
        return z;
    }

    public void requestWakeUpTrigger() {
        synchronized (this.mLock) {
            if (!(this.mSensor == null || this.mTriggerRequested)) {
                this.mTriggerRequested = true;
                this.mSensorManager.requestTriggerSensor(this.mListener, this.mSensor);
            }
        }
    }

    public void cancelWakeUpTrigger() {
        synchronized (this.mLock) {
            if (this.mSensor != null && this.mTriggerRequested) {
                this.mTriggerRequested = false;
                this.mSensorManager.cancelTriggerSensor(this.mListener, this.mSensor);
            }
        }
    }

    public void dump(PrintWriter pw, String prefix) {
        synchronized (this.mLock) {
            pw.println(prefix + TAG);
            prefix = prefix + "  ";
            pw.println(prefix + "mTriggerRequested=" + this.mTriggerRequested);
            pw.println(prefix + "mSensor=" + this.mSensor);
        }
    }
}
