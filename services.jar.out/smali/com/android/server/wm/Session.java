package com.android.server.wm;

import android.content.ClipData;
import android.content.res.Configuration;
import android.graphics.Rect;
import android.graphics.Region;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Parcel;
import android.os.RemoteException;
import android.util.Slog;
import android.view.Display;
import android.view.IWindow;
import android.view.IWindowId;
import android.view.IWindowSession.Stub;
import android.view.IWindowSessionCallback;
import android.view.InputChannel;
import android.view.Surface;
import android.view.SurfaceControl;
import android.view.SurfaceSession;
import android.view.WindowManager.LayoutParams;
import com.android.internal.view.IInputContext;
import com.android.internal.view.IInputMethodClient;
import java.io.PrintWriter;

final class Session extends Stub implements DeathRecipient {
    final IWindowSessionCallback mCallback;
    final IInputMethodClient mClient;
    boolean mClientDead;
    final IInputContext mInputContext;
    float mLastReportedAnimatorScale;
    int mNumWindow;
    final int mPid;
    final WindowManagerService mService;
    final String mStringName;
    SurfaceSession mSurfaceSession;
    final int mUid;

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public Session(com.android.server.wm.WindowManagerService r9, android.view.IWindowSessionCallback r10, com.android.internal.view.IInputMethodClient r11, com.android.internal.view.IInputContext r12) {
        /*
        r8 = this;
        r5 = 0;
        r8.<init>();
        r8.mNumWindow = r5;
        r8.mClientDead = r5;
        r8.mService = r9;
        r8.mCallback = r10;
        r8.mClient = r11;
        r8.mInputContext = r12;
        r5 = android.os.Binder.getCallingUid();
        r8.mUid = r5;
        r5 = android.os.Binder.getCallingPid();
        r8.mPid = r5;
        r5 = r9.getCurrentAnimatorScale();
        r8.mLastReportedAnimatorScale = r5;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Session{";
        r4.append(r5);
        r5 = java.lang.System.identityHashCode(r8);
        r5 = java.lang.Integer.toHexString(r5);
        r4.append(r5);
        r5 = " ";
        r4.append(r5);
        r5 = r8.mPid;
        r4.append(r5);
        r5 = r8.mUid;
        r6 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        if (r5 >= r6) goto L_0x009d;
    L_0x0047:
        r5 = ":";
        r4.append(r5);
        r5 = r8.mUid;
        r4.append(r5);
    L_0x0051:
        r5 = "}";
        r4.append(r5);
        r5 = r4.toString();
        r8.mStringName = r5;
        r5 = r8.mService;
        r6 = r5.mWindowMap;
        monitor-enter(r6);
        r5 = r8.mService;	 Catch:{ all -> 0x00ba }
        r5 = r5.mInputMethodManager;	 Catch:{ all -> 0x00ba }
        if (r5 != 0) goto L_0x007b;
    L_0x0067:
        r5 = r8.mService;	 Catch:{ all -> 0x00ba }
        r5 = r5.mHaveInputMethods;	 Catch:{ all -> 0x00ba }
        if (r5 == 0) goto L_0x007b;
    L_0x006d:
        r5 = "input_method";
        r0 = android.os.ServiceManager.getService(r5);	 Catch:{ all -> 0x00ba }
        r5 = r8.mService;	 Catch:{ all -> 0x00ba }
        r7 = com.android.internal.view.IInputMethodManager.Stub.asInterface(r0);	 Catch:{ all -> 0x00ba }
        r5.mInputMethodManager = r7;	 Catch:{ all -> 0x00ba }
    L_0x007b:
        monitor-exit(r6);	 Catch:{ all -> 0x00ba }
        r2 = android.os.Binder.clearCallingIdentity();
        r5 = r8.mService;	 Catch:{ RemoteException -> 0x00c2, all -> 0x00d4 }
        r5 = r5.mInputMethodManager;	 Catch:{ RemoteException -> 0x00c2, all -> 0x00d4 }
        if (r5 == 0) goto L_0x00bd;
    L_0x0086:
        r5 = r8.mService;	 Catch:{ RemoteException -> 0x00c2, all -> 0x00d4 }
        r5 = r5.mInputMethodManager;	 Catch:{ RemoteException -> 0x00c2, all -> 0x00d4 }
        r6 = r8.mUid;	 Catch:{ RemoteException -> 0x00c2, all -> 0x00d4 }
        r7 = r8.mPid;	 Catch:{ RemoteException -> 0x00c2, all -> 0x00d4 }
        r5.addClient(r11, r12, r6, r7);	 Catch:{ RemoteException -> 0x00c2, all -> 0x00d4 }
    L_0x0091:
        r5 = r11.asBinder();	 Catch:{ RemoteException -> 0x00c2, all -> 0x00d4 }
        r6 = 0;
        r5.linkToDeath(r8, r6);	 Catch:{ RemoteException -> 0x00c2, all -> 0x00d4 }
        android.os.Binder.restoreCallingIdentity(r2);
    L_0x009c:
        return;
    L_0x009d:
        r5 = ":u";
        r4.append(r5);
        r5 = r8.mUid;
        r5 = android.os.UserHandle.getUserId(r5);
        r4.append(r5);
        r5 = 97;
        r4.append(r5);
        r5 = r8.mUid;
        r5 = android.os.UserHandle.getAppId(r5);
        r4.append(r5);
        goto L_0x0051;
    L_0x00ba:
        r5 = move-exception;
        monitor-exit(r6);	 Catch:{ all -> 0x00ba }
        throw r5;
    L_0x00bd:
        r5 = 0;
        r11.setUsingInputMethod(r5);	 Catch:{ RemoteException -> 0x00c2, all -> 0x00d4 }
        goto L_0x0091;
    L_0x00c2:
        r1 = move-exception;
        r5 = r8.mService;	 Catch:{ RemoteException -> 0x00d9, all -> 0x00d4 }
        r5 = r5.mInputMethodManager;	 Catch:{ RemoteException -> 0x00d9, all -> 0x00d4 }
        if (r5 == 0) goto L_0x00d0;
    L_0x00c9:
        r5 = r8.mService;	 Catch:{ RemoteException -> 0x00d9, all -> 0x00d4 }
        r5 = r5.mInputMethodManager;	 Catch:{ RemoteException -> 0x00d9, all -> 0x00d4 }
        r5.removeClient(r11);	 Catch:{ RemoteException -> 0x00d9, all -> 0x00d4 }
    L_0x00d0:
        android.os.Binder.restoreCallingIdentity(r2);
        goto L_0x009c;
    L_0x00d4:
        r5 = move-exception;
        android.os.Binder.restoreCallingIdentity(r2);
        throw r5;
    L_0x00d9:
        r5 = move-exception;
        goto L_0x00d0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.Session.<init>(com.android.server.wm.WindowManagerService, android.view.IWindowSessionCallback, com.android.internal.view.IInputMethodClient, com.android.internal.view.IInputContext):void");
    }

    public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
        try {
            return super.onTransact(code, data, reply, flags);
        } catch (RuntimeException e) {
            if (!(e instanceof SecurityException)) {
                Slog.wtf("WindowManager", "Window Session Crash", e);
            }
            throw e;
        }
    }

    public void binderDied() {
        try {
            if (this.mService.mInputMethodManager != null) {
                this.mService.mInputMethodManager.removeClient(this.mClient);
            }
        } catch (RemoteException e) {
        }
        synchronized (this.mService.mWindowMap) {
            this.mClient.asBinder().unlinkToDeath(this, 0);
            this.mClientDead = true;
            killSessionLocked();
        }
    }

    public int add(IWindow window, int seq, LayoutParams attrs, int viewVisibility, Rect outContentInsets, Rect outStableInsets, InputChannel outInputChannel) {
        return addToDisplay(window, seq, attrs, viewVisibility, 0, outContentInsets, outStableInsets, outInputChannel);
    }

    public int addToDisplay(IWindow window, int seq, LayoutParams attrs, int viewVisibility, int displayId, Rect outContentInsets, Rect outStableInsets, InputChannel outInputChannel) {
        return this.mService.addWindow(this, window, seq, attrs, viewVisibility, displayId, outContentInsets, outStableInsets, outInputChannel);
    }

    public int addWithoutInputChannel(IWindow window, int seq, LayoutParams attrs, int viewVisibility, Rect outContentInsets, Rect outStableInsets) {
        return addToDisplayWithoutInputChannel(window, seq, attrs, viewVisibility, 0, outContentInsets, outStableInsets);
    }

    public int addToDisplayWithoutInputChannel(IWindow window, int seq, LayoutParams attrs, int viewVisibility, int displayId, Rect outContentInsets, Rect outStableInsets) {
        return this.mService.addWindow(this, window, seq, attrs, viewVisibility, displayId, outContentInsets, outStableInsets, null);
    }

    public void remove(IWindow window) {
        this.mService.removeWindow(this, window);
    }

    public int relayout(IWindow window, int seq, LayoutParams attrs, int requestedWidth, int requestedHeight, int viewFlags, int flags, Rect outFrame, Rect outOverscanInsets, Rect outContentInsets, Rect outVisibleInsets, Rect outStableInsets, Configuration outConfig, Surface outSurface) {
        return this.mService.relayoutWindow(this, window, seq, attrs, requestedWidth, requestedHeight, viewFlags, flags, outFrame, outOverscanInsets, outContentInsets, outVisibleInsets, outStableInsets, outConfig, outSurface);
    }

    public void performDeferredDestroy(IWindow window) {
        this.mService.performDeferredDestroyWindow(this, window);
    }

    public boolean outOfMemory(IWindow window) {
        return this.mService.outOfMemoryWindow(this, window);
    }

    public void setTransparentRegion(IWindow window, Region region) {
        this.mService.setTransparentRegionWindow(this, window, region);
    }

    public void setInsets(IWindow window, int touchableInsets, Rect contentInsets, Rect visibleInsets, Region touchableArea) {
        this.mService.setInsetsWindow(this, window, touchableInsets, contentInsets, visibleInsets, touchableArea);
    }

    public void getDisplayFrame(IWindow window, Rect outDisplayFrame) {
        this.mService.getWindowDisplayFrame(this, window, outDisplayFrame);
    }

    public void finishDrawing(IWindow window) {
        this.mService.finishDrawingWindow(this, window);
    }

    public void setInTouchMode(boolean mode) {
        synchronized (this.mService.mWindowMap) {
            this.mService.mInTouchMode = mode;
        }
    }

    public boolean getInTouchMode() {
        boolean z;
        synchronized (this.mService.mWindowMap) {
            z = this.mService.mInTouchMode;
        }
        return z;
    }

    public boolean performHapticFeedback(IWindow window, int effectId, boolean always) {
        boolean performHapticFeedbackLw;
        synchronized (this.mService.mWindowMap) {
            long ident = Binder.clearCallingIdentity();
            try {
                performHapticFeedbackLw = this.mService.mPolicy.performHapticFeedbackLw(this.mService.windowForClientLocked(this, window, true), effectId, always);
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
        return performHapticFeedbackLw;
    }

    public IBinder prepareDrag(IWindow window, int flags, int width, int height, Surface outSurface) {
        return this.mService.prepareDragSurface(window, this.mSurfaceSession, flags, width, height, outSurface);
    }

    public boolean performDrag(IWindow window, IBinder dragToken, float touchX, float touchY, float thumbCenterX, float thumbCenterY, ClipData data) {
        synchronized (this.mService.mWindowMap) {
            if (this.mService.mDragState == null) {
                Slog.w("WindowManager", "No drag prepared");
                throw new IllegalStateException("performDrag() without prepareDrag()");
            } else if (dragToken != this.mService.mDragState.mToken) {
                Slog.w("WindowManager", "Performing mismatched drag");
                throw new IllegalStateException("performDrag() does not match prepareDrag()");
            } else {
                WindowState callingWin = this.mService.windowForClientLocked(null, window, false);
                if (callingWin == null) {
                    Slog.w("WindowManager", "Bad requesting window " + window);
                    return false;
                }
                this.mService.mH.removeMessages(20, window.asBinder());
                DisplayContent displayContent = callingWin.getDisplayContent();
                if (displayContent == null) {
                    return false;
                }
                Display display = displayContent.getDisplay();
                this.mService.mDragState.register(display);
                this.mService.mInputMonitor.updateInputWindowsLw(true);
                if (this.mService.mInputManager.transferTouchFocus(callingWin.mInputChannel, this.mService.mDragState.mServerChannel)) {
                    this.mService.mDragState.mData = data;
                    this.mService.mDragState.mCurrentX = touchX;
                    this.mService.mDragState.mCurrentY = touchY;
                    this.mService.mDragState.broadcastDragStartedLw(touchX, touchY);
                    this.mService.mDragState.mThumbOffsetX = thumbCenterX;
                    this.mService.mDragState.mThumbOffsetY = thumbCenterY;
                    SurfaceControl surfaceControl = this.mService.mDragState.mSurfaceControl;
                    SurfaceControl.openTransaction();
                    try {
                        surfaceControl.setPosition(touchX - thumbCenterX, touchY - thumbCenterY);
                        surfaceControl.setAlpha(0.7071f);
                        surfaceControl.setLayer(this.mService.mDragState.getDragLayerLw());
                        surfaceControl.setLayerStack(display.getLayerStack());
                        surfaceControl.show();
                        return true;
                    } finally {
                        SurfaceControl.closeTransaction();
                    }
                } else {
                    Slog.e("WindowManager", "Unable to transfer touch focus");
                    this.mService.mDragState.unregister();
                    this.mService.mDragState = null;
                    this.mService.mInputMonitor.updateInputWindowsLw(true);
                    return false;
                }
            }
        }
    }

    public void reportDropResult(IWindow window, boolean consumed) {
        IBinder token = window.asBinder();
        synchronized (this.mService.mWindowMap) {
            long ident = Binder.clearCallingIdentity();
            try {
                if (this.mService.mDragState == null) {
                    Slog.w("WindowManager", "Drop result given but no drag in progress");
                    Binder.restoreCallingIdentity(ident);
                    return;
                } else if (this.mService.mDragState.mToken != token) {
                    Slog.w("WindowManager", "Invalid drop-result claim by " + window);
                    throw new IllegalStateException("reportDropResult() by non-recipient");
                } else {
                    this.mService.mH.removeMessages(21, window.asBinder());
                    if (this.mService.windowForClientLocked(null, window, false) == null) {
                        Slog.w("WindowManager", "Bad result-reporting window " + window);
                        Binder.restoreCallingIdentity(ident);
                        return;
                    }
                    this.mService.mDragState.mDragResult = consumed;
                    this.mService.mDragState.endDragLw();
                    Binder.restoreCallingIdentity(ident);
                    return;
                }
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    public void dragRecipientEntered(IWindow window) {
    }

    public void dragRecipientExited(IWindow window) {
    }

    public void setWallpaperPosition(IBinder window, float x, float y, float xStep, float yStep) {
        synchronized (this.mService.mWindowMap) {
            long ident = Binder.clearCallingIdentity();
            try {
                this.mService.setWindowWallpaperPositionLocked(this.mService.windowForClientLocked(this, window, true), x, y, xStep, yStep);
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    public void wallpaperOffsetsComplete(IBinder window) {
        this.mService.wallpaperOffsetsComplete(window);
    }

    public void setWallpaperDisplayOffset(IBinder window, int x, int y) {
        synchronized (this.mService.mWindowMap) {
            long ident = Binder.clearCallingIdentity();
            try {
                this.mService.setWindowWallpaperDisplayOffsetLocked(this.mService.windowForClientLocked(this, window, true), x, y);
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    public Bundle sendWallpaperCommand(IBinder window, String action, int x, int y, int z, Bundle extras, boolean sync) {
        Bundle sendWindowWallpaperCommandLocked;
        synchronized (this.mService.mWindowMap) {
            long ident = Binder.clearCallingIdentity();
            try {
                sendWindowWallpaperCommandLocked = this.mService.sendWindowWallpaperCommandLocked(this.mService.windowForClientLocked(this, window, true), action, x, y, z, extras, sync);
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
        return sendWindowWallpaperCommandLocked;
    }

    public void wallpaperCommandComplete(IBinder window, Bundle result) {
        this.mService.wallpaperCommandComplete(window, result);
    }

    public void setUniverseTransform(IBinder window, float alpha, float offx, float offy, float dsdx, float dtdx, float dsdy, float dtdy) {
        synchronized (this.mService.mWindowMap) {
            long ident = Binder.clearCallingIdentity();
            try {
                this.mService.setUniverseTransformLocked(this.mService.windowForClientLocked(this, window, true), alpha, offx, offy, dsdx, dtdx, dsdy, dtdy);
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    public void onRectangleOnScreenRequested(IBinder token, Rect rectangle) {
        synchronized (this.mService.mWindowMap) {
            long identity = Binder.clearCallingIdentity();
            try {
                this.mService.onRectangleOnScreenRequested(token, rectangle);
                Binder.restoreCallingIdentity(identity);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(identity);
            }
        }
    }

    public IWindowId getWindowId(IBinder window) {
        return this.mService.getWindowId(window);
    }

    void windowAddedLocked() {
        if (this.mSurfaceSession == null) {
            this.mSurfaceSession = new SurfaceSession();
            this.mService.mSessions.add(this);
            if (this.mLastReportedAnimatorScale != this.mService.getCurrentAnimatorScale()) {
                this.mService.dispatchNewAnimatorScaleLocked(this);
            }
        }
        this.mNumWindow++;
    }

    void windowRemovedLocked() {
        this.mNumWindow--;
        killSessionLocked();
    }

    void killSessionLocked() {
        if (this.mNumWindow <= 0 && this.mClientDead) {
            this.mService.mSessions.remove(this);
            if (this.mSurfaceSession != null) {
                try {
                    this.mSurfaceSession.kill();
                } catch (Exception e) {
                    Slog.w("WindowManager", "Exception thrown when killing surface session " + this.mSurfaceSession + " in session " + this + ": " + e.toString());
                }
                this.mSurfaceSession = null;
            }
        }
    }

    void dump(PrintWriter pw, String prefix) {
        pw.print(prefix);
        pw.print("mNumWindow=");
        pw.print(this.mNumWindow);
        pw.print(" mClientDead=");
        pw.print(this.mClientDead);
        pw.print(" mSurfaceSession=");
        pw.println(this.mSurfaceSession);
    }

    public String toString() {
        return this.mStringName;
    }
}
