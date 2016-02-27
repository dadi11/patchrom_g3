package com.android.internal.policy.impl;

import android.accessibilityservice.AccessibilityServiceInfo;
import android.app.ActivityManager;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.pm.ServiceInfo;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.os.Handler;
import android.os.Message;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.UserManager;
import android.provider.Settings.Global;
import android.provider.Settings.Secure;
import android.provider.Settings.System;
import android.speech.tts.TextToSpeech;
import android.speech.tts.TextToSpeech.OnInitListener;
import android.util.MathUtils;
import android.view.IWindowManager;
import android.view.IWindowManager.Stub;
import android.view.MotionEvent;
import android.view.accessibility.AccessibilityManager;
import android.view.accessibility.IAccessibilityManager;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class EnableAccessibilityController {
    private static final int ENABLE_ACCESSIBILITY_DELAY_MILLIS = 6000;
    public static final int MESSAGE_ENABLE_ACCESSIBILITY = 3;
    public static final int MESSAGE_SPEAK_ENABLE_CANCELED = 2;
    public static final int MESSAGE_SPEAK_WARNING = 1;
    private static final int SPEAK_WARNING_DELAY_MILLIS = 2000;
    private final IAccessibilityManager mAccessibilityManager;
    private boolean mCanceled;
    private final Context mContext;
    private boolean mDestroyed;
    private float mFirstPointerDownX;
    private float mFirstPointerDownY;
    private final Handler mHandler;
    private final Runnable mOnAccessibilityEnabledCallback;
    private float mSecondPointerDownX;
    private float mSecondPointerDownY;
    private final Ringtone mTone;
    private final float mTouchSlop;
    private final TextToSpeech mTts;
    private final UserManager mUserManager;
    private final IWindowManager mWindowManager;

    /* renamed from: com.android.internal.policy.impl.EnableAccessibilityController.1 */
    class C00011 extends Handler {
        C00011() {
        }

        public void handleMessage(Message message) {
            switch (message.what) {
                case EnableAccessibilityController.MESSAGE_SPEAK_WARNING /*1*/:
                    EnableAccessibilityController.this.mTts.speak(EnableAccessibilityController.this.mContext.getString(17040920), 0, null);
                case EnableAccessibilityController.MESSAGE_SPEAK_ENABLE_CANCELED /*2*/:
                    EnableAccessibilityController.this.mTts.speak(EnableAccessibilityController.this.mContext.getString(17040922), 0, null);
                case EnableAccessibilityController.MESSAGE_ENABLE_ACCESSIBILITY /*3*/:
                    EnableAccessibilityController.this.enableAccessibility();
                    EnableAccessibilityController.this.mTone.play();
                    EnableAccessibilityController.this.mTts.speak(EnableAccessibilityController.this.mContext.getString(17040921), 0, null);
                default:
            }
        }
    }

    /* renamed from: com.android.internal.policy.impl.EnableAccessibilityController.2 */
    class C00022 implements OnInitListener {
        C00022() {
        }

        public void onInit(int status) {
            if (EnableAccessibilityController.this.mDestroyed) {
                EnableAccessibilityController.this.mTts.shutdown();
            }
        }
    }

    public EnableAccessibilityController(Context context, Runnable onAccessibilityEnabledCallback) {
        this.mHandler = new C00011();
        this.mWindowManager = Stub.asInterface(ServiceManager.getService("window"));
        this.mAccessibilityManager = IAccessibilityManager.Stub.asInterface(ServiceManager.getService("accessibility"));
        this.mContext = context;
        this.mOnAccessibilityEnabledCallback = onAccessibilityEnabledCallback;
        this.mUserManager = (UserManager) this.mContext.getSystemService("user");
        this.mTts = new TextToSpeech(context, new C00022());
        this.mTone = RingtoneManager.getRingtone(context, System.DEFAULT_NOTIFICATION_URI);
        this.mTone.setStreamType(MESSAGE_ENABLE_ACCESSIBILITY);
        this.mTouchSlop = (float) context.getResources().getDimensionPixelSize(17105008);
    }

    public static boolean canEnableAccessibilityViaGesture(Context context) {
        boolean z = true;
        AccessibilityManager accessibilityManager = AccessibilityManager.getInstance(context);
        if (accessibilityManager.isEnabled() && !accessibilityManager.getEnabledAccessibilityServiceList(MESSAGE_SPEAK_WARNING).isEmpty()) {
            return false;
        }
        if (Global.getInt(context.getContentResolver(), "enable_accessibility_global_gesture_enabled", 0) != MESSAGE_SPEAK_WARNING || getInstalledSpeakingAccessibilityServices(context).isEmpty()) {
            z = false;
        }
        return z;
    }

    private static List<AccessibilityServiceInfo> getInstalledSpeakingAccessibilityServices(Context context) {
        List<AccessibilityServiceInfo> services = new ArrayList();
        services.addAll(AccessibilityManager.getInstance(context).getInstalledAccessibilityServiceList());
        Iterator<AccessibilityServiceInfo> iterator = services.iterator();
        while (iterator.hasNext()) {
            if ((((AccessibilityServiceInfo) iterator.next()).feedbackType & MESSAGE_SPEAK_WARNING) == 0) {
                iterator.remove();
            }
        }
        return services;
    }

    public void onDestroy() {
        this.mDestroyed = true;
    }

    public boolean onInterceptTouchEvent(MotionEvent event) {
        if (event.getActionMasked() != 5 || event.getPointerCount() != MESSAGE_SPEAK_ENABLE_CANCELED) {
            return false;
        }
        this.mFirstPointerDownX = event.getX(0);
        this.mFirstPointerDownY = event.getY(0);
        this.mSecondPointerDownX = event.getX(MESSAGE_SPEAK_WARNING);
        this.mSecondPointerDownY = event.getY(MESSAGE_SPEAK_WARNING);
        this.mHandler.sendEmptyMessageDelayed(MESSAGE_SPEAK_WARNING, 2000);
        this.mHandler.sendEmptyMessageDelayed(MESSAGE_ENABLE_ACCESSIBILITY, 6000);
        return true;
    }

    public boolean onTouchEvent(MotionEvent event) {
        int pointerCount = event.getPointerCount();
        int action = event.getActionMasked();
        if (!this.mCanceled) {
            switch (action) {
                case MESSAGE_SPEAK_ENABLE_CANCELED /*2*/:
                    if (Math.abs(MathUtils.dist(event.getX(0), event.getY(0), this.mFirstPointerDownX, this.mFirstPointerDownY)) > this.mTouchSlop) {
                        cancel();
                    }
                    if (Math.abs(MathUtils.dist(event.getX(MESSAGE_SPEAK_WARNING), event.getY(MESSAGE_SPEAK_WARNING), this.mSecondPointerDownX, this.mSecondPointerDownY)) > this.mTouchSlop) {
                        cancel();
                        break;
                    }
                    break;
                case MESSAGE_ENABLE_ACCESSIBILITY /*3*/:
                case 6:
                    cancel();
                    break;
                case 5:
                    if (pointerCount > MESSAGE_SPEAK_ENABLE_CANCELED) {
                        cancel();
                        break;
                    }
                    break;
                default:
                    break;
            }
        } else if (action == MESSAGE_SPEAK_WARNING) {
            this.mCanceled = false;
        }
        return true;
    }

    private void cancel() {
        this.mCanceled = true;
        if (this.mHandler.hasMessages(MESSAGE_SPEAK_WARNING)) {
            this.mHandler.removeMessages(MESSAGE_SPEAK_WARNING);
        } else if (this.mHandler.hasMessages(MESSAGE_ENABLE_ACCESSIBILITY)) {
            this.mHandler.sendEmptyMessage(MESSAGE_SPEAK_ENABLE_CANCELED);
        }
        this.mHandler.removeMessages(MESSAGE_ENABLE_ACCESSIBILITY);
    }

    private void enableAccessibility() {
        List<AccessibilityServiceInfo> services = getInstalledSpeakingAccessibilityServices(this.mContext);
        if (!services.isEmpty()) {
            boolean keyguardLocked = false;
            try {
                keyguardLocked = this.mWindowManager.isKeyguardLocked();
            } catch (RemoteException e) {
            }
            boolean hasMoreThanOneUser = this.mUserManager.getUsers().size() > MESSAGE_SPEAK_WARNING;
            AccessibilityServiceInfo service = (AccessibilityServiceInfo) services.get(0);
            boolean enableTouchExploration = (service.flags & 4) != 0;
            if (!enableTouchExploration) {
                int serviceCount = services.size();
                for (int i = MESSAGE_SPEAK_WARNING; i < serviceCount; i += MESSAGE_SPEAK_WARNING) {
                    AccessibilityServiceInfo candidate = (AccessibilityServiceInfo) services.get(i);
                    if ((candidate.flags & 4) != 0) {
                        enableTouchExploration = true;
                        service = candidate;
                        break;
                    }
                }
            }
            ServiceInfo serviceInfo = service.getResolveInfo().serviceInfo;
            ComponentName componentName = new ComponentName(serviceInfo.packageName, serviceInfo.name);
            if (!keyguardLocked || !hasMoreThanOneUser) {
                int userId = ActivityManager.getCurrentUser();
                String enabledServiceString = componentName.flattenToString();
                ContentResolver resolver = this.mContext.getContentResolver();
                Secure.putStringForUser(resolver, "enabled_accessibility_services", enabledServiceString, userId);
                Secure.putStringForUser(resolver, "touch_exploration_granted_accessibility_services", enabledServiceString, userId);
                if (enableTouchExploration) {
                    Secure.putIntForUser(resolver, "touch_exploration_enabled", MESSAGE_SPEAK_WARNING, userId);
                }
                Secure.putIntForUser(resolver, "accessibility_script_injection", MESSAGE_SPEAK_WARNING, userId);
                Secure.putIntForUser(resolver, "accessibility_enabled", MESSAGE_SPEAK_WARNING, userId);
            } else if (keyguardLocked) {
                try {
                    this.mAccessibilityManager.temporaryEnableAccessibilityStateUntilKeyguardRemoved(componentName, enableTouchExploration);
                } catch (RemoteException e2) {
                }
            }
            this.mOnAccessibilityEnabledCallback.run();
        }
    }
}
