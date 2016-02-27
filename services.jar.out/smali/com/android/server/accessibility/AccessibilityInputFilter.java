package com.android.server.accessibility;

import android.content.Context;
import android.os.PowerManager;
import android.util.Pools.SimplePool;
import android.view.Choreographer;
import android.view.InputEvent;
import android.view.InputFilter;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.accessibility.AccessibilityEvent;

class AccessibilityInputFilter extends InputFilter implements EventStreamTransformation {
    private static final boolean DEBUG = false;
    static final int FLAG_FEATURE_FILTER_KEY_EVENTS = 4;
    static final int FLAG_FEATURE_SCREEN_MAGNIFIER = 1;
    static final int FLAG_FEATURE_TOUCH_EXPLORATION = 2;
    private static final String TAG;
    private final AccessibilityManagerService mAms;
    private final Choreographer mChoreographer;
    private final Context mContext;
    private int mCurrentTouchDeviceId;
    private int mEnabledFeatures;
    private EventStreamTransformation mEventHandler;
    private MotionEventHolder mEventQueue;
    private boolean mFilterKeyEvents;
    private boolean mHoverEventSequenceStarted;
    private boolean mInstalled;
    private boolean mKeyEventSequenceStarted;
    private boolean mMotionEventSequenceStarted;
    private final PowerManager mPm;
    private final Runnable mProcessBatchedEventsRunnable;
    private ScreenMagnifier mScreenMagnifier;
    private TouchExplorer mTouchExplorer;

    /* renamed from: com.android.server.accessibility.AccessibilityInputFilter.1 */
    class C00971 implements Runnable {
        C00971() {
        }

        public void run() {
            AccessibilityInputFilter.this.processBatchedEvents(AccessibilityInputFilter.this.mChoreographer.getFrameTimeNanos());
            if (AccessibilityInputFilter.this.mEventQueue != null) {
                AccessibilityInputFilter.this.scheduleProcessBatchedEvents();
            }
        }
    }

    private static class MotionEventHolder {
        private static final int MAX_POOL_SIZE = 32;
        private static final SimplePool<MotionEventHolder> sPool;
        public MotionEvent event;
        public MotionEventHolder next;
        public int policyFlags;
        public MotionEventHolder previous;

        private MotionEventHolder() {
        }

        static {
            sPool = new SimplePool(MAX_POOL_SIZE);
        }

        public static MotionEventHolder obtain(MotionEvent event, int policyFlags) {
            MotionEventHolder holder = (MotionEventHolder) sPool.acquire();
            if (holder == null) {
                holder = new MotionEventHolder();
            }
            holder.event = MotionEvent.obtain(event);
            holder.policyFlags = policyFlags;
            return holder;
        }

        public void recycle() {
            this.event.recycle();
            this.event = null;
            this.policyFlags = 0;
            this.next = null;
            this.previous = null;
            sPool.release(this);
        }
    }

    static {
        TAG = AccessibilityInputFilter.class.getSimpleName();
    }

    AccessibilityInputFilter(Context context, AccessibilityManagerService service) {
        super(context.getMainLooper());
        this.mProcessBatchedEventsRunnable = new C00971();
        this.mContext = context;
        this.mAms = service;
        this.mPm = (PowerManager) context.getSystemService("power");
        this.mChoreographer = Choreographer.getInstance();
    }

    public void onInstalled() {
        this.mInstalled = true;
        disableFeatures();
        enableFeatures();
        super.onInstalled();
    }

    public void onUninstalled() {
        this.mInstalled = DEBUG;
        disableFeatures();
        super.onUninstalled();
    }

    public void onInputEvent(InputEvent event, int policyFlags) {
        if ((event instanceof MotionEvent) && event.isFromSource(4098)) {
            onMotionEvent((MotionEvent) event, policyFlags);
        } else if ((event instanceof KeyEvent) && event.isFromSource(257)) {
            onKeyEvent((KeyEvent) event, policyFlags);
        } else {
            super.onInputEvent(event, policyFlags);
        }
    }

    private void onMotionEvent(MotionEvent event, int policyFlags) {
        if (this.mEventHandler == null) {
            super.onInputEvent(event, policyFlags);
        } else if ((1073741824 & policyFlags) == 0) {
            this.mMotionEventSequenceStarted = DEBUG;
            this.mHoverEventSequenceStarted = DEBUG;
            this.mEventHandler.clear();
            super.onInputEvent(event, policyFlags);
        } else {
            int deviceId = event.getDeviceId();
            if (this.mCurrentTouchDeviceId != deviceId) {
                this.mCurrentTouchDeviceId = deviceId;
                this.mMotionEventSequenceStarted = DEBUG;
                this.mHoverEventSequenceStarted = DEBUG;
                this.mEventHandler.clear();
            }
            if (this.mCurrentTouchDeviceId < 0) {
                super.onInputEvent(event, policyFlags);
            } else if (event.getActionMasked() == 8) {
                super.onInputEvent(event, policyFlags);
            } else {
                if (event.isTouchEvent()) {
                    if (!this.mMotionEventSequenceStarted) {
                        if (event.getActionMasked() == 0) {
                            this.mMotionEventSequenceStarted = true;
                        } else {
                            return;
                        }
                    }
                } else if (!this.mHoverEventSequenceStarted) {
                    if (event.getActionMasked() == 9) {
                        this.mHoverEventSequenceStarted = true;
                    } else {
                        return;
                    }
                }
                batchMotionEvent(event, policyFlags);
            }
        }
    }

    private void onKeyEvent(KeyEvent event, int policyFlags) {
        if (!this.mFilterKeyEvents) {
            super.onInputEvent(event, policyFlags);
        } else if ((1073741824 & policyFlags) == 0) {
            this.mKeyEventSequenceStarted = DEBUG;
            super.onInputEvent(event, policyFlags);
        } else {
            if (!this.mKeyEventSequenceStarted) {
                if (event.getAction() != 0) {
                    super.onInputEvent(event, policyFlags);
                    return;
                }
                this.mKeyEventSequenceStarted = true;
            }
            this.mAms.notifyKeyEvent(event, policyFlags);
        }
    }

    private void scheduleProcessBatchedEvents() {
        this.mChoreographer.postCallback(0, this.mProcessBatchedEventsRunnable, null);
    }

    private void batchMotionEvent(MotionEvent event, int policyFlags) {
        if (this.mEventQueue == null) {
            this.mEventQueue = MotionEventHolder.obtain(event, policyFlags);
            scheduleProcessBatchedEvents();
        } else if (!this.mEventQueue.event.addBatch(event)) {
            MotionEventHolder holder = MotionEventHolder.obtain(event, policyFlags);
            holder.next = this.mEventQueue;
            this.mEventQueue.previous = holder;
            this.mEventQueue = holder;
        }
    }

    private void processBatchedEvents(long frameNanos) {
        MotionEventHolder current = this.mEventQueue;
        while (current.next != null) {
            current = current.next;
        }
        while (current != null) {
            if (current.event.getEventTimeNano() >= frameNanos) {
                current.next = null;
                return;
            }
            handleMotionEvent(current.event, current.policyFlags);
            MotionEventHolder prior = current;
            current = current.previous;
            prior.recycle();
        }
        this.mEventQueue = null;
    }

    private void handleMotionEvent(MotionEvent event, int policyFlags) {
        if (this.mEventHandler != null) {
            this.mPm.userActivity(event.getEventTime(), DEBUG);
            MotionEvent transformedEvent = MotionEvent.obtain(event);
            this.mEventHandler.onMotionEvent(transformedEvent, event, policyFlags);
            transformedEvent.recycle();
        }
    }

    public void onMotionEvent(MotionEvent transformedEvent, MotionEvent rawEvent, int policyFlags) {
        sendInputEvent(transformedEvent, policyFlags);
    }

    public void onAccessibilityEvent(AccessibilityEvent event) {
    }

    public void setNext(EventStreamTransformation sink) {
    }

    public void clear() {
    }

    void setEnabledFeatures(int enabledFeatures) {
        if (this.mEnabledFeatures != enabledFeatures) {
            if (this.mInstalled) {
                disableFeatures();
            }
            this.mEnabledFeatures = enabledFeatures;
            if (this.mInstalled) {
                enableFeatures();
            }
        }
    }

    void notifyAccessibilityEvent(AccessibilityEvent event) {
        if (this.mEventHandler != null) {
            this.mEventHandler.onAccessibilityEvent(event);
        }
    }

    private void enableFeatures() {
        this.mMotionEventSequenceStarted = DEBUG;
        this.mHoverEventSequenceStarted = DEBUG;
        if ((this.mEnabledFeatures & FLAG_FEATURE_SCREEN_MAGNIFIER) != 0) {
            EventStreamTransformation screenMagnifier = new ScreenMagnifier(this.mContext, 0, this.mAms);
            this.mScreenMagnifier = screenMagnifier;
            this.mEventHandler = screenMagnifier;
            this.mEventHandler.setNext(this);
        }
        if ((this.mEnabledFeatures & FLAG_FEATURE_TOUCH_EXPLORATION) != 0) {
            this.mTouchExplorer = new TouchExplorer(this.mContext, this.mAms);
            this.mTouchExplorer.setNext(this);
            if (this.mEventHandler != null) {
                this.mEventHandler.setNext(this.mTouchExplorer);
            } else {
                this.mEventHandler = this.mTouchExplorer;
            }
        }
        if ((this.mEnabledFeatures & FLAG_FEATURE_FILTER_KEY_EVENTS) != 0) {
            this.mFilterKeyEvents = true;
        }
    }

    void disableFeatures() {
        if (this.mTouchExplorer != null) {
            this.mTouchExplorer.clear();
            this.mTouchExplorer.onDestroy();
            this.mTouchExplorer = null;
        }
        if (this.mScreenMagnifier != null) {
            this.mScreenMagnifier.clear();
            this.mScreenMagnifier.onDestroy();
            this.mScreenMagnifier = null;
        }
        this.mEventHandler = null;
        this.mKeyEventSequenceStarted = DEBUG;
        this.mMotionEventSequenceStarted = DEBUG;
        this.mHoverEventSequenceStarted = DEBUG;
        this.mFilterKeyEvents = DEBUG;
    }

    public void onDestroy() {
    }
}
