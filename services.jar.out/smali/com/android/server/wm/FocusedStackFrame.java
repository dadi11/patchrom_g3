package com.android.server.wm;

import android.graphics.Canvas;
import android.graphics.Rect;
import android.graphics.Region.Op;
import android.view.Display;
import android.view.Surface;
import android.view.Surface.OutOfResourcesException;
import android.view.SurfaceControl;
import android.view.SurfaceSession;

class FocusedStackFrame {
    private static final float ALPHA = 0.3f;
    private static final String TAG = "FocusedStackFrame";
    private static final int THICKNESS = 10;
    final Rect mBounds;
    private final Rect mLastBounds;
    private final Surface mSurface;
    private final SurfaceControl mSurfaceControl;
    private final Rect mTmpDrawRect;

    public FocusedStackFrame(Display display, SurfaceSession session) {
        SurfaceControl ctrl;
        this.mSurface = new Surface();
        this.mLastBounds = new Rect();
        this.mBounds = new Rect();
        this.mTmpDrawRect = new Rect();
        try {
            ctrl = new SurfaceControl(session, TAG, 1, 1, -3, 4);
            try {
                ctrl.setLayerStack(display.getLayerStack());
                ctrl.setAlpha(ALPHA);
                this.mSurface.copyFrom(ctrl);
            } catch (OutOfResourcesException e) {
            }
        } catch (OutOfResourcesException e2) {
            ctrl = null;
        }
        this.mSurfaceControl = ctrl;
    }

    private void draw(Rect bounds, int color) {
        this.mTmpDrawRect.set(bounds);
        Canvas c = null;
        try {
            c = this.mSurface.lockCanvas(this.mTmpDrawRect);
        } catch (IllegalArgumentException e) {
        } catch (OutOfResourcesException e2) {
        }
        if (c != null) {
            int w = bounds.width();
            int h = bounds.height();
            this.mTmpDrawRect.set(0, 0, w, THICKNESS);
            c.clipRect(this.mTmpDrawRect, Op.REPLACE);
            c.drawColor(color);
            this.mTmpDrawRect.set(0, THICKNESS, THICKNESS, h - 10);
            c.clipRect(this.mTmpDrawRect, Op.REPLACE);
            c.drawColor(color);
            this.mTmpDrawRect.set(w - 10, THICKNESS, w, h - 10);
            c.clipRect(this.mTmpDrawRect, Op.REPLACE);
            c.drawColor(color);
            this.mTmpDrawRect.set(0, h - 10, w, h);
            c.clipRect(this.mTmpDrawRect, Op.REPLACE);
            c.drawColor(color);
            this.mSurface.unlockCanvasAndPost(c);
        }
    }

    private void positionSurface(Rect bounds) {
        this.mSurfaceControl.setSize(bounds.width(), bounds.height());
        this.mSurfaceControl.setPosition((float) bounds.left, (float) bounds.top);
    }

    public void setVisibility(boolean on) {
        if (this.mSurfaceControl != null) {
            if (on) {
                if (!this.mLastBounds.equals(this.mBounds)) {
                    positionSurface(this.mLastBounds);
                    draw(this.mLastBounds, 0);
                    positionSurface(this.mBounds);
                    draw(this.mBounds, -1);
                    this.mLastBounds.set(this.mBounds);
                }
                this.mSurfaceControl.show();
                return;
            }
            this.mSurfaceControl.hide();
        }
    }

    public void setBounds(TaskStack stack) {
        stack.getBounds(this.mBounds);
    }

    public void setLayer(int layer) {
        this.mSurfaceControl.setLayer(layer);
    }
}
