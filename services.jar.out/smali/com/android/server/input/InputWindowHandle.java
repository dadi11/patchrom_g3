package com.android.server.input;

import android.graphics.Region;
import android.view.InputChannel;

public final class InputWindowHandle {
    public boolean canReceiveKeys;
    public long dispatchingTimeoutNanos;
    public final int displayId;
    public int frameBottom;
    public int frameLeft;
    public int frameRight;
    public int frameTop;
    public boolean hasFocus;
    public boolean hasWallpaper;
    public final InputApplicationHandle inputApplicationHandle;
    public InputChannel inputChannel;
    public int inputFeatures;
    public int layer;
    public int layoutParamsFlags;
    public int layoutParamsType;
    public String name;
    public int ownerPid;
    public int ownerUid;
    public boolean paused;
    private long ptr;
    public float scaleFactor;
    public final Region touchableRegion;
    public boolean visible;
    public final Object windowState;

    private native void nativeDispose();

    public InputWindowHandle(InputApplicationHandle inputApplicationHandle, Object windowState, int displayId) {
        this.touchableRegion = new Region();
        this.inputApplicationHandle = inputApplicationHandle;
        this.windowState = windowState;
        this.displayId = displayId;
    }

    protected void finalize() throws Throwable {
        try {
            nativeDispose();
        } finally {
            super.finalize();
        }
    }
}
