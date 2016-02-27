package android.view.accessibility;

import android.os.Build;
import android.util.ArraySet;
import android.util.Log;
import android.util.LongArray;
import android.util.LongSparseArray;
import android.util.SparseArray;
import java.util.ArrayList;
import java.util.List;

final class AccessibilityCache {
    private static final boolean CHECK_INTEGRITY;
    private static final boolean DEBUG = false;
    private static final String LOG_TAG = "AccessibilityCache";
    private long mAccessibilityFocus;
    private long mInputFocus;
    private final Object mLock;
    private final SparseArray<LongSparseArray<AccessibilityNodeInfo>> mNodeCache;
    private final SparseArray<AccessibilityWindowInfo> mTempWindowArray;
    private final SparseArray<AccessibilityWindowInfo> mWindowCache;

    AccessibilityCache() {
        this.mLock = new Object();
        this.mAccessibilityFocus = 2147483647L;
        this.mInputFocus = 2147483647L;
        this.mWindowCache = new SparseArray();
        this.mNodeCache = new SparseArray();
        this.mTempWindowArray = new SparseArray();
    }

    static {
        CHECK_INTEGRITY = "eng".equals(Build.TYPE);
    }

    public void addWindow(AccessibilityWindowInfo window) {
        synchronized (this.mLock) {
            int windowId = window.getId();
            AccessibilityWindowInfo oldWindow = (AccessibilityWindowInfo) this.mWindowCache.get(windowId);
            if (oldWindow != null) {
                oldWindow.recycle();
            }
            this.mWindowCache.put(windowId, AccessibilityWindowInfo.obtain(window));
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void onAccessibilityEvent(android.view.accessibility.AccessibilityEvent r11) {
        /*
        r10 = this;
        r8 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        r5 = r10.mLock;
        monitor-enter(r5);
        r0 = r11.getEventType();	 Catch:{ all -> 0x0035 }
        switch(r0) {
            case 1: goto L_0x0070;
            case 4: goto L_0x0070;
            case 8: goto L_0x0051;
            case 16: goto L_0x0070;
            case 32: goto L_0x00a9;
            case 2048: goto L_0x007c;
            case 4096: goto L_0x009c;
            case 8192: goto L_0x0070;
            case 32768: goto L_0x0016;
            case 65536: goto L_0x0038;
            case 4194304: goto L_0x00a9;
            default: goto L_0x000d;
        };	 Catch:{ all -> 0x0035 }
    L_0x000d:
        monitor-exit(r5);	 Catch:{ all -> 0x0035 }
        r4 = CHECK_INTEGRITY;
        if (r4 == 0) goto L_0x0015;
    L_0x0012:
        r10.checkIntegrity();
    L_0x0015:
        return;
    L_0x0016:
        r6 = r10.mAccessibilityFocus;	 Catch:{ all -> 0x0035 }
        r4 = (r6 > r8 ? 1 : (r6 == r8 ? 0 : -1));
        if (r4 == 0) goto L_0x0025;
    L_0x001c:
        r4 = r11.getWindowId();	 Catch:{ all -> 0x0035 }
        r6 = r10.mAccessibilityFocus;	 Catch:{ all -> 0x0035 }
        r10.refreshCachedNodeLocked(r4, r6);	 Catch:{ all -> 0x0035 }
    L_0x0025:
        r6 = r11.getSourceNodeId();	 Catch:{ all -> 0x0035 }
        r10.mAccessibilityFocus = r6;	 Catch:{ all -> 0x0035 }
        r4 = r11.getWindowId();	 Catch:{ all -> 0x0035 }
        r6 = r10.mAccessibilityFocus;	 Catch:{ all -> 0x0035 }
        r10.refreshCachedNodeLocked(r4, r6);	 Catch:{ all -> 0x0035 }
        goto L_0x000d;
    L_0x0035:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0035 }
        throw r4;
    L_0x0038:
        r6 = r10.mAccessibilityFocus;	 Catch:{ all -> 0x0035 }
        r8 = r11.getSourceNodeId();	 Catch:{ all -> 0x0035 }
        r4 = (r6 > r8 ? 1 : (r6 == r8 ? 0 : -1));
        if (r4 != 0) goto L_0x000d;
    L_0x0042:
        r4 = r11.getWindowId();	 Catch:{ all -> 0x0035 }
        r6 = r10.mAccessibilityFocus;	 Catch:{ all -> 0x0035 }
        r10.refreshCachedNodeLocked(r4, r6);	 Catch:{ all -> 0x0035 }
        r6 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        r10.mAccessibilityFocus = r6;	 Catch:{ all -> 0x0035 }
        goto L_0x000d;
    L_0x0051:
        r6 = r10.mInputFocus;	 Catch:{ all -> 0x0035 }
        r4 = (r6 > r8 ? 1 : (r6 == r8 ? 0 : -1));
        if (r4 == 0) goto L_0x0060;
    L_0x0057:
        r4 = r11.getWindowId();	 Catch:{ all -> 0x0035 }
        r6 = r10.mInputFocus;	 Catch:{ all -> 0x0035 }
        r10.refreshCachedNodeLocked(r4, r6);	 Catch:{ all -> 0x0035 }
    L_0x0060:
        r6 = r11.getSourceNodeId();	 Catch:{ all -> 0x0035 }
        r10.mInputFocus = r6;	 Catch:{ all -> 0x0035 }
        r4 = r11.getWindowId();	 Catch:{ all -> 0x0035 }
        r6 = r10.mInputFocus;	 Catch:{ all -> 0x0035 }
        r10.refreshCachedNodeLocked(r4, r6);	 Catch:{ all -> 0x0035 }
        goto L_0x000d;
    L_0x0070:
        r4 = r11.getWindowId();	 Catch:{ all -> 0x0035 }
        r6 = r11.getSourceNodeId();	 Catch:{ all -> 0x0035 }
        r10.refreshCachedNodeLocked(r4, r6);	 Catch:{ all -> 0x0035 }
        goto L_0x000d;
    L_0x007c:
        r6 = r10.mLock;	 Catch:{ all -> 0x0035 }
        monitor-enter(r6);	 Catch:{ all -> 0x0035 }
        r1 = r11.getWindowId();	 Catch:{ all -> 0x0095 }
        r2 = r11.getSourceNodeId();	 Catch:{ all -> 0x0095 }
        r4 = r11.getContentChangeTypes();	 Catch:{ all -> 0x0095 }
        r4 = r4 & 1;
        if (r4 == 0) goto L_0x0098;
    L_0x008f:
        r10.clearSubTreeLocked(r1, r2);	 Catch:{ all -> 0x0095 }
    L_0x0092:
        monitor-exit(r6);	 Catch:{ all -> 0x0095 }
        goto L_0x000d;
    L_0x0095:
        r4 = move-exception;
        monitor-exit(r6);	 Catch:{ all -> 0x0095 }
        throw r4;	 Catch:{ all -> 0x0035 }
    L_0x0098:
        r10.refreshCachedNodeLocked(r1, r2);	 Catch:{ all -> 0x0095 }
        goto L_0x0092;
    L_0x009c:
        r4 = r11.getWindowId();	 Catch:{ all -> 0x0035 }
        r6 = r11.getSourceNodeId();	 Catch:{ all -> 0x0035 }
        r10.clearSubTreeLocked(r4, r6);	 Catch:{ all -> 0x0035 }
        goto L_0x000d;
    L_0x00a9:
        r10.clear();	 Catch:{ all -> 0x0035 }
        goto L_0x000d;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.view.accessibility.AccessibilityCache.onAccessibilityEvent(android.view.accessibility.AccessibilityEvent):void");
    }

    private void refreshCachedNodeLocked(int windowId, long sourceId) {
        LongSparseArray<AccessibilityNodeInfo> nodes = (LongSparseArray) this.mNodeCache.get(windowId);
        if (nodes != null) {
            AccessibilityNodeInfo cachedInfo = (AccessibilityNodeInfo) nodes.get(sourceId);
            if (cachedInfo != null && !cachedInfo.refresh(true)) {
                clearSubTreeLocked(windowId, sourceId);
            }
        }
    }

    public AccessibilityNodeInfo getNode(int windowId, long accessibilityNodeId) {
        AccessibilityNodeInfo accessibilityNodeInfo;
        synchronized (this.mLock) {
            LongSparseArray<AccessibilityNodeInfo> nodes = (LongSparseArray) this.mNodeCache.get(windowId);
            if (nodes == null) {
                accessibilityNodeInfo = null;
            } else {
                accessibilityNodeInfo = (AccessibilityNodeInfo) nodes.get(accessibilityNodeId);
                if (accessibilityNodeInfo != null) {
                    accessibilityNodeInfo = AccessibilityNodeInfo.obtain(accessibilityNodeInfo);
                }
            }
        }
        return accessibilityNodeInfo;
    }

    public List<AccessibilityWindowInfo> getWindows() {
        List<AccessibilityWindowInfo> windows;
        synchronized (this.mLock) {
            int windowCount = this.mWindowCache.size();
            if (windowCount > 0) {
                int i;
                SparseArray<AccessibilityWindowInfo> sortedWindows = this.mTempWindowArray;
                sortedWindows.clear();
                for (i = 0; i < windowCount; i++) {
                    AccessibilityWindowInfo window = (AccessibilityWindowInfo) this.mWindowCache.valueAt(i);
                    sortedWindows.put(window.getLayer(), window);
                }
                windows = new ArrayList(windowCount);
                for (i = windowCount - 1; i >= 0; i--) {
                    windows.add(AccessibilityWindowInfo.obtain((AccessibilityWindowInfo) sortedWindows.valueAt(i)));
                    sortedWindows.removeAt(i);
                }
            } else {
                windows = null;
            }
        }
        return windows;
    }

    public AccessibilityWindowInfo getWindow(int windowId) {
        AccessibilityWindowInfo obtain;
        synchronized (this.mLock) {
            AccessibilityWindowInfo window = (AccessibilityWindowInfo) this.mWindowCache.get(windowId);
            if (window != null) {
                obtain = AccessibilityWindowInfo.obtain(window);
            } else {
                obtain = null;
            }
        }
        return obtain;
    }

    public void add(AccessibilityNodeInfo info) {
        synchronized (this.mLock) {
            int windowId = info.getWindowId();
            LongSparseArray<AccessibilityNodeInfo> nodes = (LongSparseArray) this.mNodeCache.get(windowId);
            if (nodes == null) {
                nodes = new LongSparseArray();
                this.mNodeCache.put(windowId, nodes);
            }
            long sourceId = info.getSourceNodeId();
            AccessibilityNodeInfo oldInfo = (AccessibilityNodeInfo) nodes.get(sourceId);
            if (oldInfo != null) {
                LongArray newChildrenIds = info.getChildNodeIds();
                int oldChildCount = oldInfo.getChildCount();
                for (int i = 0; i < oldChildCount; i++) {
                    long oldChildId = oldInfo.getChildId(i);
                    if (newChildrenIds == null || newChildrenIds.indexOf(oldChildId) < 0) {
                        clearSubTreeLocked(windowId, oldChildId);
                    }
                }
                long oldParentId = oldInfo.getParentNodeId();
                if (info.getParentNodeId() != oldParentId) {
                    clearSubTreeLocked(windowId, oldParentId);
                }
            }
            nodes.put(sourceId, AccessibilityNodeInfo.obtain(info));
        }
    }

    public void clear() {
        synchronized (this.mLock) {
            int i;
            for (i = this.mWindowCache.size() - 1; i >= 0; i--) {
                ((AccessibilityWindowInfo) this.mWindowCache.valueAt(i)).recycle();
                this.mWindowCache.removeAt(i);
            }
            int nodesForWindowCount = this.mNodeCache.size();
            for (i = 0; i < nodesForWindowCount; i++) {
                clearNodesForWindowLocked(this.mNodeCache.keyAt(i));
            }
            this.mAccessibilityFocus = 2147483647L;
            this.mInputFocus = 2147483647L;
        }
    }

    private void clearNodesForWindowLocked(int windowId) {
        LongSparseArray<AccessibilityNodeInfo> nodes = (LongSparseArray) this.mNodeCache.get(windowId);
        if (nodes != null) {
            for (int i = nodes.size() - 1; i >= 0; i--) {
                AccessibilityNodeInfo info = (AccessibilityNodeInfo) nodes.valueAt(i);
                nodes.removeAt(i);
                info.recycle();
            }
            this.mNodeCache.remove(windowId);
        }
    }

    private void clearSubTreeLocked(int windowId, long rootNodeId) {
        LongSparseArray<AccessibilityNodeInfo> nodes = (LongSparseArray) this.mNodeCache.get(windowId);
        if (nodes != null) {
            clearSubTreeRecursiveLocked(nodes, rootNodeId);
        }
    }

    private void clearSubTreeRecursiveLocked(LongSparseArray<AccessibilityNodeInfo> nodes, long rootNodeId) {
        AccessibilityNodeInfo current = (AccessibilityNodeInfo) nodes.get(rootNodeId);
        if (current != null) {
            nodes.remove(rootNodeId);
            int childCount = current.getChildCount();
            for (int i = 0; i < childCount; i++) {
                clearSubTreeRecursiveLocked(nodes, current.getChildId(i));
            }
        }
    }

    public void checkIntegrity() {
        synchronized (this.mLock) {
            int i;
            if (this.mWindowCache.size() <= 0) {
                if (this.mNodeCache.size() == 0) {
                    return;
                }
            }
            AccessibilityWindowInfo focusedWindow = null;
            AccessibilityWindowInfo activeWindow = null;
            int windowCount = this.mWindowCache.size();
            for (i = 0; i < windowCount; i++) {
                AccessibilityWindowInfo window = (AccessibilityWindowInfo) this.mWindowCache.valueAt(i);
                if (window.isActive()) {
                    if (activeWindow != null) {
                        Log.e(LOG_TAG, "Duplicate active window:" + window);
                    } else {
                        activeWindow = window;
                    }
                }
                if (window.isFocused()) {
                    if (focusedWindow != null) {
                        Log.e(LOG_TAG, "Duplicate focused window:" + window);
                    } else {
                        focusedWindow = window;
                    }
                }
            }
            AccessibilityNodeInfo accessFocus = null;
            AccessibilityNodeInfo inputFocus = null;
            int nodesForWindowCount = this.mNodeCache.size();
            for (i = 0; i < nodesForWindowCount; i++) {
                LongSparseArray<AccessibilityNodeInfo> nodes = (LongSparseArray) this.mNodeCache.valueAt(i);
                if (nodes.size() > 0) {
                    ArraySet<AccessibilityNodeInfo> seen = new ArraySet();
                    int windowId = this.mNodeCache.keyAt(i);
                    int nodeCount = nodes.size();
                    for (int j = 0; j < nodeCount; j++) {
                        AccessibilityNodeInfo node = (AccessibilityNodeInfo) nodes.valueAt(j);
                        if (seen.add(node)) {
                            int childCount;
                            int k;
                            if (node.isAccessibilityFocused()) {
                                if (accessFocus != null) {
                                    Log.e(LOG_TAG, "Duplicate accessibility focus:" + node + " in window:" + windowId);
                                } else {
                                    accessFocus = node;
                                }
                            }
                            if (node.isFocused()) {
                                if (inputFocus != null) {
                                    Log.e(LOG_TAG, "Duplicate input focus: " + node + " in window:" + windowId);
                                } else {
                                    inputFocus = node;
                                }
                            }
                            AccessibilityNodeInfo nodeParent = (AccessibilityNodeInfo) nodes.get(node.getParentNodeId());
                            if (nodeParent != null) {
                                boolean childOfItsParent = DEBUG;
                                childCount = nodeParent.getChildCount();
                                for (k = 0; k < childCount; k++) {
                                    if (((AccessibilityNodeInfo) nodes.get(nodeParent.getChildId(k))) == node) {
                                        childOfItsParent = true;
                                        break;
                                    }
                                }
                                if (!childOfItsParent) {
                                    Log.e(LOG_TAG, "Invalid parent-child relation between parent: " + nodeParent + " and child: " + node);
                                }
                            }
                            childCount = node.getChildCount();
                            for (k = 0; k < childCount; k++) {
                                AccessibilityNodeInfo child = (AccessibilityNodeInfo) nodes.get(node.getChildId(k));
                                if (child != null) {
                                    if (((AccessibilityNodeInfo) nodes.get(child.getParentNodeId())) != node) {
                                        Log.e(LOG_TAG, "Invalid child-parent relation between child: " + node + " and parent: " + nodeParent);
                                    }
                                }
                            }
                        } else {
                            Log.e(LOG_TAG, "Duplicate node: " + node + " in window:" + windowId);
                        }
                    }
                }
            }
        }
    }
}
