package com.android.server.accessibility;

import android.accessibilityservice.AccessibilityServiceInfo;
import android.accessibilityservice.IAccessibilityServiceClient;
import android.accessibilityservice.IAccessibilityServiceConnection;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.app.PendingIntent;
import android.app.StatusBarManager;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.content.pm.UserInfo;
import android.database.ContentObserver;
import android.graphics.Point;
import android.graphics.Rect;
import android.graphics.Region;
import android.graphics.Region.Op;
import android.hardware.display.DisplayManager;
import android.hardware.input.InputManager;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.Process;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.UserManager;
import android.provider.Settings.Secure;
import android.text.TextUtils.SimpleStringSplitter;
import android.util.Pools.Pool;
import android.util.Pools.SimplePool;
import android.util.Slog;
import android.util.SparseArray;
import android.view.Display;
import android.view.IWindow;
import android.view.InputEvent;
import android.view.InputEventConsistencyVerifier;
import android.view.KeyEvent;
import android.view.MagnificationSpec;
import android.view.WindowInfo;
import android.view.WindowManager.LayoutParams;
import android.view.WindowManagerInternal;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityInteractionClient;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.accessibility.AccessibilityWindowInfo;
import android.view.accessibility.IAccessibilityInteractionConnection;
import android.view.accessibility.IAccessibilityInteractionConnectionCallback;
import android.view.accessibility.IAccessibilityManager.Stub;
import android.view.accessibility.IAccessibilityManagerClient;
import com.android.internal.content.PackageMonitor;
import com.android.internal.statusbar.IStatusBarService;
import com.android.internal.widget.LockPatternUtils;
import com.android.server.LocalServices;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;
import org.xmlpull.v1.XmlPullParserException;

public class AccessibilityManagerService extends Stub {
    private static final char COMPONENT_NAME_SEPARATOR = ':';
    private static final boolean DEBUG = false;
    private static final String FUNCTION_DUMP = "dump";
    private static final String FUNCTION_REGISTER_UI_TEST_AUTOMATION_SERVICE = "registerUiTestAutomationService";
    private static final String GET_WINDOW_TOKEN = "getWindowToken";
    private static final String LOG_TAG = "AccessibilityManagerService";
    private static final int MAX_POOL_SIZE = 10;
    private static final int OWN_PROCESS_ID;
    private static final String TEMPORARY_ENABLE_ACCESSIBILITY_UNTIL_KEYGUARD_REMOVED = "temporaryEnableAccessibilityStateUntilKeyguardRemoved";
    private static final int WAIT_FOR_USER_STATE_FULLY_INITIALIZED_MILLIS = 3000;
    private static final int WAIT_WINDOWS_TIMEOUT_MILLIS = 5000;
    private static final int WINDOW_ID_UNKNOWN = -1;
    private static final ComponentName sFakeAccessibilityServiceComponentName;
    private static int sIdCounter;
    private static int sNextWindowId;
    private final Context mContext;
    private int mCurrentUserId;
    private AlertDialog mEnableTouchExplorationDialog;
    private final List<AccessibilityServiceInfo> mEnabledServicesForFeedbackTempList;
    private final RemoteCallbackList<IAccessibilityManagerClient> mGlobalClients;
    private final SparseArray<AccessibilityConnectionWrapper> mGlobalInteractionConnections;
    private final SparseArray<IBinder> mGlobalWindowTokens;
    private boolean mHasInputFilter;
    private boolean mInitialized;
    private AccessibilityInputFilter mInputFilter;
    private InteractionBridge mInteractionBridge;
    private final Object mLock;
    private final LockPatternUtils mLockPatternUtils;
    private final MainHandler mMainHandler;
    private final PackageManager mPackageManager;
    private final Pool<PendingEvent> mPendingEventPool;
    private final SecurityPolicy mSecurityPolicy;
    private final SimpleStringSplitter mStringColonSplitter;
    private final List<AccessibilityServiceInfo> mTempAccessibilityServiceInfoList;
    private final Set<ComponentName> mTempComponentNameSet;
    private final Point mTempPoint;
    private final Rect mTempRect;
    private final Rect mTempRect1;
    private final Region mTempRegion;
    private final UserManager mUserManager;
    private final SparseArray<UserState> mUserStates;
    private final WindowManagerInternal mWindowManagerService;
    private WindowsForAccessibilityCallback mWindowsForAccessibilityCallback;

    /* renamed from: com.android.server.accessibility.AccessibilityManagerService.1 */
    class C00981 extends PackageMonitor {
        C00981() {
        }

        public void onSomePackagesChanged() {
            synchronized (AccessibilityManagerService.this.mLock) {
                if (getChangingUserId() != AccessibilityManagerService.this.mCurrentUserId) {
                    return;
                }
                UserState userState = AccessibilityManagerService.this.getCurrentUserStateLocked();
                userState.mInstalledServices.clear();
                if (userState.mUiAutomationService == null && AccessibilityManagerService.this.readConfigurationForUserStateLocked(userState)) {
                    AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                }
            }
        }

        public void onPackageRemoved(String packageName, int uid) {
            synchronized (AccessibilityManagerService.this.mLock) {
                int userId = getChangingUserId();
                if (userId != AccessibilityManagerService.this.mCurrentUserId) {
                    return;
                }
                UserState userState = AccessibilityManagerService.this.getUserStateLocked(userId);
                Iterator<ComponentName> it = userState.mEnabledServices.iterator();
                while (it.hasNext()) {
                    ComponentName comp = (ComponentName) it.next();
                    if (comp.getPackageName().equals(packageName)) {
                        it.remove();
                        AccessibilityManagerService.this.persistComponentNamesToSettingLocked("enabled_accessibility_services", userState.mEnabledServices, userId);
                        userState.mTouchExplorationGrantedServices.remove(comp);
                        AccessibilityManagerService.this.persistComponentNamesToSettingLocked("touch_exploration_granted_accessibility_services", userState.mTouchExplorationGrantedServices, userId);
                        if (userState.mUiAutomationService == null) {
                            AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                        }
                        return;
                    }
                }
            }
        }

        public boolean onHandleForceStop(Intent intent, String[] packages, int uid, boolean doit) {
            boolean z;
            synchronized (AccessibilityManagerService.this.mLock) {
                int userId = getChangingUserId();
                if (userId != AccessibilityManagerService.this.mCurrentUserId) {
                    z = AccessibilityManagerService.DEBUG;
                } else {
                    UserState userState = AccessibilityManagerService.this.getUserStateLocked(userId);
                    Iterator<ComponentName> it = userState.mEnabledServices.iterator();
                    loop0:
                    while (it.hasNext()) {
                        String compPkg = ((ComponentName) it.next()).getPackageName();
                        String[] arr$ = packages;
                        int len$ = arr$.length;
                        for (int i$ = AccessibilityManagerService.OWN_PROCESS_ID; i$ < len$; i$++) {
                            if (compPkg.equals(arr$[i$])) {
                                if (!doit) {
                                    z = true;
                                    break loop0;
                                }
                                it.remove();
                                AccessibilityManagerService.this.persistComponentNamesToSettingLocked("enabled_accessibility_services", userState.mEnabledServices, userId);
                                if (userState.mUiAutomationService == null) {
                                    AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                                }
                            }
                        }
                    }
                    z = AccessibilityManagerService.DEBUG;
                }
            }
            return z;
        }
    }

    /* renamed from: com.android.server.accessibility.AccessibilityManagerService.2 */
    class C00992 extends BroadcastReceiver {
        C00992() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if ("android.intent.action.USER_SWITCHED".equals(action)) {
                AccessibilityManagerService.this.switchUser(intent.getIntExtra("android.intent.extra.user_handle", AccessibilityManagerService.OWN_PROCESS_ID));
            } else if ("android.intent.action.USER_REMOVED".equals(action)) {
                AccessibilityManagerService.this.removeUser(intent.getIntExtra("android.intent.extra.user_handle", AccessibilityManagerService.OWN_PROCESS_ID));
            } else if ("android.intent.action.USER_PRESENT".equals(action)) {
                UserState userState = AccessibilityManagerService.this.getCurrentUserStateLocked();
                if (userState.mUiAutomationService == null && AccessibilityManagerService.this.readConfigurationForUserStateLocked(userState)) {
                    AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                }
            }
        }
    }

    /* renamed from: com.android.server.accessibility.AccessibilityManagerService.3 */
    class C01003 implements OnClickListener {
        C01003() {
        }

        public void onClick(DialogInterface dialog, int which) {
            dialog.dismiss();
        }
    }

    /* renamed from: com.android.server.accessibility.AccessibilityManagerService.4 */
    class C01014 implements OnClickListener {
        final /* synthetic */ Service val$service;
        final /* synthetic */ UserState val$state;

        C01014(UserState userState, Service service) {
            this.val$state = userState;
            this.val$service = service;
        }

        public void onClick(DialogInterface dialog, int which) {
            this.val$state.mTouchExplorationGrantedServices.add(this.val$service.mComponentName);
            AccessibilityManagerService.this.persistComponentNamesToSettingLocked("touch_exploration_granted_accessibility_services", this.val$state.mTouchExplorationGrantedServices, this.val$state.mUserId);
            UserState userState = AccessibilityManagerService.this.getUserStateLocked(this.val$service.mUserId);
            userState.mIsTouchExplorationEnabled = true;
            Secure.putIntForUser(AccessibilityManagerService.this.mContext.getContentResolver(), "touch_exploration_enabled", 1, this.val$service.mUserId);
            AccessibilityManagerService.this.onUserStateChangedLocked(userState);
        }
    }

    private class AccessibilityConnectionWrapper implements DeathRecipient {
        private final IAccessibilityInteractionConnection mConnection;
        private final int mUserId;
        private final int mWindowId;

        public AccessibilityConnectionWrapper(int windowId, IAccessibilityInteractionConnection connection, int userId) {
            this.mWindowId = windowId;
            this.mUserId = userId;
            this.mConnection = connection;
        }

        public void linkToDeath() throws RemoteException {
            this.mConnection.asBinder().linkToDeath(this, AccessibilityManagerService.OWN_PROCESS_ID);
        }

        public void unlinkToDeath() {
            this.mConnection.asBinder().unlinkToDeath(this, AccessibilityManagerService.OWN_PROCESS_ID);
        }

        public void binderDied() {
            unlinkToDeath();
            synchronized (AccessibilityManagerService.this.mLock) {
                AccessibilityManagerService.this.removeAccessibilityInteractionConnectionLocked(this.mWindowId, this.mUserId);
            }
        }
    }

    private final class AccessibilityContentObserver extends ContentObserver {
        private final Uri mAccessibilityEnabledUri;
        private final Uri mDisplayDaltonizerEnabledUri;
        private final Uri mDisplayDaltonizerUri;
        private final Uri mDisplayInversionEnabledUri;
        private final Uri mDisplayMagnificationEnabledUri;
        private final Uri mEnabledAccessibilityServicesUri;
        private final Uri mEnhancedWebAccessibilityUri;
        private final Uri mHighTextContrastUri;
        private final Uri mTouchExplorationEnabledUri;
        private final Uri mTouchExplorationGrantedAccessibilityServicesUri;

        public AccessibilityContentObserver(Handler handler) {
            super(handler);
            this.mAccessibilityEnabledUri = Secure.getUriFor("accessibility_enabled");
            this.mTouchExplorationEnabledUri = Secure.getUriFor("touch_exploration_enabled");
            this.mDisplayMagnificationEnabledUri = Secure.getUriFor("accessibility_display_magnification_enabled");
            this.mEnabledAccessibilityServicesUri = Secure.getUriFor("enabled_accessibility_services");
            this.mTouchExplorationGrantedAccessibilityServicesUri = Secure.getUriFor("touch_exploration_granted_accessibility_services");
            this.mEnhancedWebAccessibilityUri = Secure.getUriFor("accessibility_script_injection");
            this.mDisplayInversionEnabledUri = Secure.getUriFor("accessibility_display_inversion_enabled");
            this.mDisplayDaltonizerEnabledUri = Secure.getUriFor("accessibility_display_daltonizer_enabled");
            this.mDisplayDaltonizerUri = Secure.getUriFor("accessibility_display_daltonizer");
            this.mHighTextContrastUri = Secure.getUriFor("high_text_contrast_enabled");
        }

        public void register(ContentResolver contentResolver) {
            contentResolver.registerContentObserver(this.mAccessibilityEnabledUri, AccessibilityManagerService.DEBUG, this, AccessibilityManagerService.WINDOW_ID_UNKNOWN);
            contentResolver.registerContentObserver(this.mTouchExplorationEnabledUri, AccessibilityManagerService.DEBUG, this, AccessibilityManagerService.WINDOW_ID_UNKNOWN);
            contentResolver.registerContentObserver(this.mDisplayMagnificationEnabledUri, AccessibilityManagerService.DEBUG, this, AccessibilityManagerService.WINDOW_ID_UNKNOWN);
            contentResolver.registerContentObserver(this.mEnabledAccessibilityServicesUri, AccessibilityManagerService.DEBUG, this, AccessibilityManagerService.WINDOW_ID_UNKNOWN);
            contentResolver.registerContentObserver(this.mTouchExplorationGrantedAccessibilityServicesUri, AccessibilityManagerService.DEBUG, this, AccessibilityManagerService.WINDOW_ID_UNKNOWN);
            contentResolver.registerContentObserver(this.mEnhancedWebAccessibilityUri, AccessibilityManagerService.DEBUG, this, AccessibilityManagerService.WINDOW_ID_UNKNOWN);
            contentResolver.registerContentObserver(this.mDisplayInversionEnabledUri, AccessibilityManagerService.DEBUG, this, AccessibilityManagerService.WINDOW_ID_UNKNOWN);
            contentResolver.registerContentObserver(this.mDisplayDaltonizerEnabledUri, AccessibilityManagerService.DEBUG, this, AccessibilityManagerService.WINDOW_ID_UNKNOWN);
            contentResolver.registerContentObserver(this.mDisplayDaltonizerUri, AccessibilityManagerService.DEBUG, this, AccessibilityManagerService.WINDOW_ID_UNKNOWN);
            contentResolver.registerContentObserver(this.mHighTextContrastUri, AccessibilityManagerService.DEBUG, this, AccessibilityManagerService.WINDOW_ID_UNKNOWN);
        }

        public void onChange(boolean selfChange, Uri uri) {
            synchronized (AccessibilityManagerService.this.mLock) {
                UserState userState = AccessibilityManagerService.this.getCurrentUserStateLocked();
                if (userState.mUiAutomationService != null) {
                    return;
                }
                if (this.mAccessibilityEnabledUri.equals(uri)) {
                    if (AccessibilityManagerService.this.readAccessibilityEnabledSettingLocked(userState)) {
                        AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                    }
                } else if (this.mTouchExplorationEnabledUri.equals(uri)) {
                    if (AccessibilityManagerService.this.readTouchExplorationEnabledSettingLocked(userState)) {
                        AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                    }
                } else if (this.mDisplayMagnificationEnabledUri.equals(uri)) {
                    if (AccessibilityManagerService.this.readDisplayMagnificationEnabledSettingLocked(userState)) {
                        AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                    }
                } else if (this.mEnabledAccessibilityServicesUri.equals(uri)) {
                    if (AccessibilityManagerService.this.readEnabledAccessibilityServicesLocked(userState)) {
                        AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                    }
                } else if (this.mTouchExplorationGrantedAccessibilityServicesUri.equals(uri)) {
                    if (AccessibilityManagerService.this.readTouchExplorationGrantedAccessibilityServicesLocked(userState)) {
                        AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                    }
                } else if (this.mEnhancedWebAccessibilityUri.equals(uri)) {
                    if (AccessibilityManagerService.this.readEnhancedWebAccessibilityEnabledChangedLocked(userState)) {
                        AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                    }
                } else if (this.mDisplayInversionEnabledUri.equals(uri) || this.mDisplayDaltonizerEnabledUri.equals(uri) || this.mDisplayDaltonizerUri.equals(uri)) {
                    if (AccessibilityManagerService.this.readDisplayColorAdjustmentSettingsLocked(userState)) {
                        AccessibilityManagerService.this.updateDisplayColorAdjustmentSettingsLocked(userState);
                    }
                } else if (this.mHighTextContrastUri.equals(uri) && AccessibilityManagerService.this.readHighTextContrastEnabledSettingLocked(userState)) {
                    AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                }
            }
        }
    }

    private final class InteractionBridge {
        private final AccessibilityInteractionClient mClient;
        private final int mConnectionId;
        private final Display mDefaultDisplay;

        public InteractionBridge() {
            AccessibilityServiceInfo info = new AccessibilityServiceInfo();
            info.setCapabilities(1);
            info.flags |= 64;
            info.flags |= 2;
            Service service = new Service(-10000, AccessibilityManagerService.sFakeAccessibilityServiceComponentName, info);
            this.mConnectionId = service.mId;
            this.mClient = AccessibilityInteractionClient.getInstance();
            this.mClient.addConnection(this.mConnectionId, service);
            this.mDefaultDisplay = ((DisplayManager) AccessibilityManagerService.this.mContext.getSystemService("display")).getDisplay(AccessibilityManagerService.OWN_PROCESS_ID);
        }

        public void clearAccessibilityFocusNotLocked(int windowId) {
            AccessibilityNodeInfo focus = getAccessibilityFocusNotLocked(windowId);
            if (focus != null) {
                focus.performAction(DumpState.DUMP_PROVIDERS);
            }
        }

        public boolean getAccessibilityFocusClickPointInScreenNotLocked(Point outPoint) {
            AccessibilityNodeInfo focus = getAccessibilityFocusNotLocked();
            if (focus == null) {
                return AccessibilityManagerService.DEBUG;
            }
            synchronized (AccessibilityManagerService.this.mLock) {
                Rect boundsInScreen = AccessibilityManagerService.this.mTempRect;
                focus.getBoundsInScreen(boundsInScreen);
                Rect windowBounds = AccessibilityManagerService.this.mTempRect1;
                AccessibilityManagerService.this.getWindowBounds(focus.getWindowId(), windowBounds);
                boundsInScreen.intersect(windowBounds);
                if (boundsInScreen.isEmpty()) {
                    return AccessibilityManagerService.DEBUG;
                }
                MagnificationSpec spec = AccessibilityManagerService.this.getCompatibleMagnificationSpecLocked(focus.getWindowId());
                if (!(spec == null || spec.isNop())) {
                    boundsInScreen.offset((int) (-spec.offsetX), (int) (-spec.offsetY));
                    boundsInScreen.scale(1.0f / spec.scale);
                }
                Point screenSize = AccessibilityManagerService.this.mTempPoint;
                this.mDefaultDisplay.getRealSize(screenSize);
                boundsInScreen.intersect(AccessibilityManagerService.OWN_PROCESS_ID, AccessibilityManagerService.OWN_PROCESS_ID, screenSize.x, screenSize.y);
                if (boundsInScreen.isEmpty()) {
                    return AccessibilityManagerService.DEBUG;
                }
                outPoint.set(boundsInScreen.centerX(), boundsInScreen.centerY());
                return true;
            }
        }

        private AccessibilityNodeInfo getAccessibilityFocusNotLocked() {
            synchronized (AccessibilityManagerService.this.mLock) {
                int focusedWindowId = AccessibilityManagerService.this.mSecurityPolicy.mAccessibilityFocusedWindowId;
                if (focusedWindowId == AccessibilityManagerService.WINDOW_ID_UNKNOWN) {
                    return null;
                }
                return getAccessibilityFocusNotLocked(focusedWindowId);
            }
        }

        private AccessibilityNodeInfo getAccessibilityFocusNotLocked(int windowId) {
            return this.mClient.findFocus(this.mConnectionId, windowId, AccessibilityNodeInfo.ROOT_NODE_ID, 2);
        }
    }

    private final class MainHandler extends Handler {
        public static final int MSG_ANNOUNCE_NEW_USER_IF_NEEDED = 5;
        public static final int MSG_CLEAR_ACCESSIBILITY_FOCUS = 9;
        public static final int MSG_SEND_ACCESSIBILITY_EVENT_TO_INPUT_FILTER = 1;
        public static final int MSG_SEND_CLEARED_STATE_TO_CLIENTS_FOR_USER = 3;
        public static final int MSG_SEND_KEY_EVENT_TO_INPUT_FILTER = 8;
        public static final int MSG_SEND_STATE_TO_CLIENTS = 2;
        public static final int MSG_SHOW_ENABLED_TOUCH_EXPLORATION_DIALOG = 7;
        public static final int MSG_UPDATE_INPUT_FILTER = 6;

        public MainHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case MSG_SEND_ACCESSIBILITY_EVENT_TO_INPUT_FILTER /*1*/:
                    AccessibilityEvent event = msg.obj;
                    synchronized (AccessibilityManagerService.this.mLock) {
                        if (AccessibilityManagerService.this.mHasInputFilter && AccessibilityManagerService.this.mInputFilter != null) {
                            AccessibilityManagerService.this.mInputFilter.notifyAccessibilityEvent(event);
                        }
                        break;
                    }
                    event.recycle();
                case MSG_SEND_STATE_TO_CLIENTS /*2*/:
                    int clientState = msg.arg1;
                    int userId = msg.arg2;
                    sendStateToClients(clientState, AccessibilityManagerService.this.mGlobalClients);
                    sendStateToClientsForUser(clientState, userId);
                case MSG_SEND_CLEARED_STATE_TO_CLIENTS_FOR_USER /*3*/:
                    sendStateToClientsForUser(AccessibilityManagerService.OWN_PROCESS_ID, msg.arg1);
                case MSG_ANNOUNCE_NEW_USER_IF_NEEDED /*5*/:
                    announceNewUserIfNeeded();
                case MSG_UPDATE_INPUT_FILTER /*6*/:
                    AccessibilityManagerService.this.updateInputFilter(msg.obj);
                case MSG_SHOW_ENABLED_TOUCH_EXPLORATION_DIALOG /*7*/:
                    AccessibilityManagerService.this.showEnableTouchExplorationDialog(msg.obj);
                case MSG_SEND_KEY_EVENT_TO_INPUT_FILTER /*8*/:
                    KeyEvent event2 = msg.obj;
                    int policyFlags = msg.arg1;
                    synchronized (AccessibilityManagerService.this.mLock) {
                        if (AccessibilityManagerService.this.mHasInputFilter && AccessibilityManagerService.this.mInputFilter != null) {
                            AccessibilityManagerService.this.mInputFilter.sendInputEvent(event2, policyFlags);
                        }
                        break;
                    }
                    event2.recycle();
                case MSG_CLEAR_ACCESSIBILITY_FOCUS /*9*/:
                    InteractionBridge bridge;
                    int windowId = msg.arg1;
                    synchronized (AccessibilityManagerService.this.mLock) {
                        bridge = AccessibilityManagerService.this.getInteractionBridgeLocked();
                        break;
                    }
                    bridge.clearAccessibilityFocusNotLocked(windowId);
                default:
            }
        }

        private void announceNewUserIfNeeded() {
            synchronized (AccessibilityManagerService.this.mLock) {
                if (AccessibilityManagerService.this.getCurrentUserStateLocked().mIsAccessibilityEnabled) {
                    UserManager userManager = (UserManager) AccessibilityManagerService.this.mContext.getSystemService("user");
                    Context access$1600 = AccessibilityManagerService.this.mContext;
                    Object[] objArr = new Object[MSG_SEND_ACCESSIBILITY_EVENT_TO_INPUT_FILTER];
                    objArr[AccessibilityManagerService.OWN_PROCESS_ID] = userManager.getUserInfo(AccessibilityManagerService.this.mCurrentUserId).name;
                    String message = access$1600.getString(17040923, objArr);
                    AccessibilityEvent event = AccessibilityEvent.obtain(16384);
                    event.getText().add(message);
                    AccessibilityManagerService.this.sendAccessibilityEvent(event, AccessibilityManagerService.this.mCurrentUserId);
                }
            }
        }

        private void sendStateToClientsForUser(int clientState, int userId) {
            UserState userState;
            synchronized (AccessibilityManagerService.this.mLock) {
                userState = AccessibilityManagerService.this.getUserStateLocked(userId);
            }
            sendStateToClients(clientState, userState.mClients);
        }

        private void sendStateToClients(int clientState, RemoteCallbackList<IAccessibilityManagerClient> clients) {
            try {
                int userClientCount = clients.beginBroadcast();
                for (int i = AccessibilityManagerService.OWN_PROCESS_ID; i < userClientCount; i += MSG_SEND_ACCESSIBILITY_EVENT_TO_INPUT_FILTER) {
                    try {
                        ((IAccessibilityManagerClient) clients.getBroadcastItem(i)).setState(clientState);
                    } catch (RemoteException e) {
                    }
                }
            } finally {
                clients.finishBroadcast();
            }
        }
    }

    private static final class PendingEvent {
        KeyEvent event;
        boolean handled;
        PendingEvent next;
        int policyFlags;
        int sequence;

        private PendingEvent() {
        }

        public void clear() {
            if (this.event != null) {
                this.event.recycle();
                this.event = null;
            }
            this.next = null;
            this.policyFlags = AccessibilityManagerService.OWN_PROCESS_ID;
            this.sequence = AccessibilityManagerService.OWN_PROCESS_ID;
            this.handled = AccessibilityManagerService.DEBUG;
        }
    }

    final class SecurityPolicy {
        public static final int INVALID_WINDOW_ID = -1;
        private static final int RETRIEVAL_ALLOWING_EVENT_TYPES = 244159;
        public long mAccessibilityFocusNodeId;
        public int mAccessibilityFocusedWindowId;
        public int mActiveWindowId;
        public int mFocusedWindowId;
        private boolean mTouchInteractionInProgress;
        public List<AccessibilityWindowInfo> mWindows;

        SecurityPolicy() {
            this.mActiveWindowId = INVALID_WINDOW_ID;
            this.mFocusedWindowId = INVALID_WINDOW_ID;
            this.mAccessibilityFocusedWindowId = INVALID_WINDOW_ID;
            this.mAccessibilityFocusNodeId = 2147483647L;
        }

        private boolean canDispatchAccessibilityEventLocked(AccessibilityEvent event) {
            switch (event.getEventType()) {
                case C0569H.NOTIFY_ACTIVITY_DRAWN /*32*/:
                case DumpState.DUMP_MESSAGES /*64*/:
                case DumpState.DUMP_PROVIDERS /*128*/:
                case DumpState.DUMP_VERIFIERS /*256*/:
                case DumpState.DUMP_PREFERRED /*512*/:
                case DumpState.DUMP_PREFERRED_XML /*1024*/:
                case 16384:
                case 262144:
                case 524288:
                case 1048576:
                case 2097152:
                case 4194304:
                    return true;
                default:
                    return isRetrievalAllowingWindow(event.getWindowId());
            }
        }

        public void clearWindowsLocked() {
            List<AccessibilityWindowInfo> windows = Collections.emptyList();
            int activeWindowId = this.mActiveWindowId;
            updateWindowsLocked(windows);
            this.mActiveWindowId = activeWindowId;
            this.mWindows = null;
        }

        public void updateWindowsLocked(List<AccessibilityWindowInfo> windows) {
            int i;
            if (this.mWindows == null) {
                this.mWindows = new ArrayList();
            }
            for (i = this.mWindows.size() + INVALID_WINDOW_ID; i >= 0; i += INVALID_WINDOW_ID) {
                ((AccessibilityWindowInfo) this.mWindows.remove(i)).recycle();
            }
            this.mFocusedWindowId = INVALID_WINDOW_ID;
            if (!this.mTouchInteractionInProgress) {
                this.mActiveWindowId = INVALID_WINDOW_ID;
            }
            boolean activeWindowGone = true;
            int windowCount = windows.size();
            if (windowCount > 0) {
                AccessibilityWindowInfo window;
                for (i = AccessibilityManagerService.OWN_PROCESS_ID; i < windowCount; i++) {
                    window = (AccessibilityWindowInfo) windows.get(i);
                    int windowId = window.getId();
                    if (window.isFocused()) {
                        this.mFocusedWindowId = windowId;
                        if (!this.mTouchInteractionInProgress) {
                            this.mActiveWindowId = windowId;
                            window.setActive(true);
                        } else if (windowId == this.mActiveWindowId) {
                            activeWindowGone = AccessibilityManagerService.DEBUG;
                        }
                    }
                    this.mWindows.add(window);
                }
                if (this.mTouchInteractionInProgress && activeWindowGone) {
                    this.mActiveWindowId = this.mFocusedWindowId;
                }
                for (i = AccessibilityManagerService.OWN_PROCESS_ID; i < windowCount; i++) {
                    window = (AccessibilityWindowInfo) this.mWindows.get(i);
                    if (window.getId() == this.mActiveWindowId) {
                        window.setActive(true);
                    }
                    if (window.getId() == this.mAccessibilityFocusedWindowId) {
                        window.setAccessibilityFocused(true);
                    }
                }
            }
            notifyWindowsChanged();
        }

        public boolean computePartialInteractiveRegionForWindowLocked(int windowId, Region outRegion) {
            if (this.mWindows == null) {
                return AccessibilityManagerService.DEBUG;
            }
            Region windowInteractiveRegion = null;
            boolean windowInteractiveRegionChanged = AccessibilityManagerService.DEBUG;
            for (int i = this.mWindows.size() + INVALID_WINDOW_ID; i >= 0; i += INVALID_WINDOW_ID) {
                AccessibilityWindowInfo currentWindow = (AccessibilityWindowInfo) this.mWindows.get(i);
                Rect currentWindowBounds;
                if (windowInteractiveRegion == null) {
                    if (currentWindow.getId() == windowId) {
                        currentWindowBounds = AccessibilityManagerService.this.mTempRect;
                        currentWindow.getBoundsInScreen(currentWindowBounds);
                        outRegion.set(currentWindowBounds);
                        windowInteractiveRegion = outRegion;
                    }
                } else if (currentWindow.getType() != 4) {
                    currentWindowBounds = AccessibilityManagerService.this.mTempRect;
                    currentWindow.getBoundsInScreen(currentWindowBounds);
                    if (windowInteractiveRegion.op(currentWindowBounds, Op.DIFFERENCE)) {
                        windowInteractiveRegionChanged = true;
                    }
                }
            }
            return windowInteractiveRegionChanged;
        }

        public void updateEventSourceLocked(AccessibilityEvent event) {
            if ((event.getEventType() & RETRIEVAL_ALLOWING_EVENT_TYPES) == 0) {
                event.setSource(null);
            }
        }

        public void updateActiveAndAccessibilityFocusedWindowLocked(int windowId, long nodeId, int eventType) {
            switch (eventType) {
                case C0569H.NOTIFY_ACTIVITY_DRAWN /*32*/:
                    synchronized (AccessibilityManagerService.this.mLock) {
                        if (AccessibilityManagerService.this.mWindowsForAccessibilityCallback == null) {
                            this.mFocusedWindowId = getFocusedWindowId();
                            if (windowId == this.mFocusedWindowId) {
                                this.mActiveWindowId = windowId;
                            }
                        }
                        break;
                    }
                case DumpState.DUMP_PROVIDERS /*128*/:
                    synchronized (AccessibilityManagerService.this.mLock) {
                        if (this.mTouchInteractionInProgress && this.mActiveWindowId != windowId) {
                            setActiveWindowLocked(windowId);
                        }
                        break;
                    }
                case 32768:
                    synchronized (AccessibilityManagerService.this.mLock) {
                        if (this.mAccessibilityFocusedWindowId != windowId) {
                            AccessibilityManagerService.this.mMainHandler.obtainMessage(9, this.mAccessibilityFocusedWindowId, AccessibilityManagerService.OWN_PROCESS_ID).sendToTarget();
                            AccessibilityManagerService.this.mSecurityPolicy.setAccessibilityFocusedWindowLocked(windowId);
                            this.mAccessibilityFocusNodeId = nodeId;
                        }
                        break;
                    }
                case 65536:
                    synchronized (AccessibilityManagerService.this.mLock) {
                        if (this.mAccessibilityFocusNodeId == nodeId) {
                            this.mAccessibilityFocusNodeId = 2147483647L;
                        }
                        if (this.mAccessibilityFocusNodeId == 2147483647L && this.mAccessibilityFocusedWindowId == windowId) {
                            this.mAccessibilityFocusedWindowId = INVALID_WINDOW_ID;
                        }
                        break;
                    }
                default:
            }
        }

        public void onTouchInteractionStart() {
            synchronized (AccessibilityManagerService.this.mLock) {
                this.mTouchInteractionInProgress = true;
            }
        }

        public void onTouchInteractionEnd() {
            synchronized (AccessibilityManagerService.this.mLock) {
                this.mTouchInteractionInProgress = AccessibilityManagerService.DEBUG;
                int oldActiveWindow = AccessibilityManagerService.this.mSecurityPolicy.mActiveWindowId;
                setActiveWindowLocked(this.mFocusedWindowId);
                if (oldActiveWindow != AccessibilityManagerService.this.mSecurityPolicy.mActiveWindowId && this.mAccessibilityFocusedWindowId == oldActiveWindow && AccessibilityManagerService.this.getCurrentUserStateLocked().mAccessibilityFocusOnlyInActiveWindow) {
                    AccessibilityManagerService.this.mMainHandler.obtainMessage(9, oldActiveWindow, AccessibilityManagerService.OWN_PROCESS_ID).sendToTarget();
                }
            }
        }

        public int getActiveWindowId() {
            if (this.mActiveWindowId == INVALID_WINDOW_ID && !this.mTouchInteractionInProgress) {
                this.mActiveWindowId = getFocusedWindowId();
            }
            return this.mActiveWindowId;
        }

        private void setActiveWindowLocked(int windowId) {
            if (this.mActiveWindowId != windowId) {
                this.mActiveWindowId = windowId;
                if (this.mWindows != null) {
                    int windowCount = this.mWindows.size();
                    for (int i = AccessibilityManagerService.OWN_PROCESS_ID; i < windowCount; i++) {
                        AccessibilityWindowInfo window = (AccessibilityWindowInfo) this.mWindows.get(i);
                        window.setActive(window.getId() == windowId ? true : AccessibilityManagerService.DEBUG);
                    }
                }
                notifyWindowsChanged();
            }
        }

        private void setAccessibilityFocusedWindowLocked(int windowId) {
            if (this.mAccessibilityFocusedWindowId != windowId) {
                this.mAccessibilityFocusedWindowId = windowId;
                if (this.mWindows != null) {
                    int windowCount = this.mWindows.size();
                    for (int i = AccessibilityManagerService.OWN_PROCESS_ID; i < windowCount; i++) {
                        AccessibilityWindowInfo window = (AccessibilityWindowInfo) this.mWindows.get(i);
                        window.setAccessibilityFocused(window.getId() == windowId ? true : AccessibilityManagerService.DEBUG);
                    }
                }
                notifyWindowsChanged();
            }
        }

        private void notifyWindowsChanged() {
            if (AccessibilityManagerService.this.mWindowsForAccessibilityCallback != null) {
                long identity = Binder.clearCallingIdentity();
                try {
                    AccessibilityEvent event = AccessibilityEvent.obtain(4194304);
                    event.setEventTime(SystemClock.uptimeMillis());
                    AccessibilityManagerService.this.sendAccessibilityEvent(event, AccessibilityManagerService.this.mCurrentUserId);
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }

        public boolean canGetAccessibilityNodeInfoLocked(Service service, int windowId) {
            return (canRetrieveWindowContentLocked(service) && isRetrievalAllowingWindow(windowId)) ? true : AccessibilityManagerService.DEBUG;
        }

        public boolean canRetrieveWindowsLocked(Service service) {
            return (canRetrieveWindowContentLocked(service) && service.mRetrieveInteractiveWindows) ? true : AccessibilityManagerService.DEBUG;
        }

        public boolean canRetrieveWindowContentLocked(Service service) {
            return (service.mAccessibilityServiceInfo.getCapabilities() & 1) != 0 ? true : AccessibilityManagerService.DEBUG;
        }

        private int resolveProfileParentLocked(int userId) {
            if (userId != AccessibilityManagerService.this.mCurrentUserId) {
                long identity = Binder.clearCallingIdentity();
                try {
                    UserInfo parent = AccessibilityManagerService.this.mUserManager.getProfileParent(userId);
                    if (parent != null) {
                        userId = parent.getUserHandle().getIdentifier();
                    } else {
                        Binder.restoreCallingIdentity(identity);
                    }
                } finally {
                    Binder.restoreCallingIdentity(identity);
                }
            }
            return userId;
        }

        public int resolveCallingUserIdEnforcingPermissionsLocked(int userId) {
            int callingUid = Binder.getCallingUid();
            if (callingUid != 0 && callingUid != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE && callingUid != 2000) {
                int callingUserId = UserHandle.getUserId(callingUid);
                if (callingUserId == userId) {
                    return resolveProfileParentLocked(userId);
                }
                if (resolveProfileParentLocked(callingUserId) == AccessibilityManagerService.this.mCurrentUserId && (userId == -2 || userId == -3)) {
                    return AccessibilityManagerService.this.mCurrentUserId;
                }
                if (!hasPermission("android.permission.INTERACT_ACROSS_USERS") && !hasPermission("android.permission.INTERACT_ACROSS_USERS_FULL")) {
                    throw new SecurityException("Call from user " + callingUserId + " as user " + userId + " without permission INTERACT_ACROSS_USERS or " + "INTERACT_ACROSS_USERS_FULL not allowed.");
                } else if (userId == -2 || userId == -3) {
                    return AccessibilityManagerService.this.mCurrentUserId;
                } else {
                    throw new IllegalArgumentException("Calling user can be changed to only UserHandle.USER_CURRENT or UserHandle.USER_CURRENT_OR_SELF.");
                }
            } else if (userId == -2 || userId == -3) {
                return AccessibilityManagerService.this.mCurrentUserId;
            } else {
                return resolveProfileParentLocked(userId);
            }
        }

        public boolean isCallerInteractingAcrossUsers(int userId) {
            return (Binder.getCallingPid() == Process.myPid() || Binder.getCallingUid() == 2000 || userId == -2 || userId == -3) ? true : AccessibilityManagerService.DEBUG;
        }

        private boolean isRetrievalAllowingWindow(int windowId) {
            if (Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || windowId == this.mActiveWindowId || findWindowById(windowId) != null) {
                return true;
            }
            return AccessibilityManagerService.DEBUG;
        }

        private AccessibilityWindowInfo findWindowById(int windowId) {
            if (this.mWindows != null) {
                int windowCount = this.mWindows.size();
                for (int i = AccessibilityManagerService.OWN_PROCESS_ID; i < windowCount; i++) {
                    AccessibilityWindowInfo window = (AccessibilityWindowInfo) this.mWindows.get(i);
                    if (window.getId() == windowId) {
                        return window;
                    }
                }
            }
            return null;
        }

        private void enforceCallingPermission(String permission, String function) {
            if (AccessibilityManagerService.OWN_PROCESS_ID != Binder.getCallingPid() && !hasPermission(permission)) {
                throw new SecurityException("You do not have " + permission + " required to call " + function + " from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            }
        }

        private boolean hasPermission(String permission) {
            return AccessibilityManagerService.this.mContext.checkCallingPermission(permission) == 0 ? true : AccessibilityManagerService.DEBUG;
        }

        private int getFocusedWindowId() {
            int access$4400;
            IBinder token = AccessibilityManagerService.this.mWindowManagerService.getFocusedWindowToken();
            synchronized (AccessibilityManagerService.this.mLock) {
                access$4400 = AccessibilityManagerService.this.findWindowIdLocked(token);
            }
            return access$4400;
        }
    }

    class Service extends IAccessibilityServiceConnection.Stub implements ServiceConnection, DeathRecipient {
        AccessibilityServiceInfo mAccessibilityServiceInfo;
        ComponentName mComponentName;
        public Handler mEventDispatchHandler;
        int mEventTypes;
        int mFeedbackType;
        int mFetchFlags;
        int mId;
        Intent mIntent;
        public InvocationHandler mInvocationHandler;
        boolean mIsAutomation;
        boolean mIsDefault;
        final KeyEventDispatcher mKeyEventDispatcher;
        long mNotificationTimeout;
        final IBinder mOverlayWindowToken;
        Set<String> mPackageNames;
        final SparseArray<AccessibilityEvent> mPendingEvents;
        boolean mRequestEnhancedWebAccessibility;
        boolean mRequestFilterKeyEvents;
        boolean mRequestTouchExplorationMode;
        final ResolveInfo mResolveInfo;
        boolean mRetrieveInteractiveWindows;
        IBinder mService;
        IAccessibilityServiceClient mServiceInterface;
        final int mUserId;
        boolean mWasConnectedAndDied;

        /* renamed from: com.android.server.accessibility.AccessibilityManagerService.Service.1 */
        class C01021 extends Handler {
            C01021(Looper x0) {
                super(x0);
            }

            public void handleMessage(Message message) {
                Service.this.notifyAccessibilityEventInternal(message.what);
            }
        }

        /* renamed from: com.android.server.accessibility.AccessibilityManagerService.Service.2 */
        class C01032 implements Runnable {
            C01032() {
            }

            public void run() {
                Service.this.onServiceConnected(Service.this.mComponentName, Service.this.mService);
            }
        }

        private final class InvocationHandler extends Handler {
            public static final int MSG_CLEAR_ACCESSIBILITY_CACHE = 3;
            public static final int MSG_ON_GESTURE = 1;
            public static final int MSG_ON_KEY_EVENT = 2;
            public static final int MSG_ON_KEY_EVENT_TIMEOUT = 4;

            public InvocationHandler(Looper looper) {
                super(looper, null, true);
            }

            public void handleMessage(Message message) {
                int type = message.what;
                switch (type) {
                    case MSG_ON_GESTURE /*1*/:
                        Service.this.notifyGestureInternal(message.arg1);
                    case MSG_ON_KEY_EVENT /*2*/:
                        Service.this.notifyKeyEventInternal(message.obj, message.arg1);
                    case MSG_CLEAR_ACCESSIBILITY_CACHE /*3*/:
                        Service.this.notifyClearAccessibilityCacheInternal();
                    case MSG_ON_KEY_EVENT_TIMEOUT /*4*/:
                        Service.this.setOnKeyEventResult(AccessibilityManagerService.DEBUG, message.obj.sequence);
                    default:
                        throw new IllegalArgumentException("Unknown message: " + type);
                }
            }
        }

        private final class KeyEventDispatcher {
            private static final long ON_KEY_EVENT_TIMEOUT_MILLIS = 500;
            private PendingEvent mPendingEvents;
            private final InputEventConsistencyVerifier mSentEventsVerifier;

            private KeyEventDispatcher() {
                this.mSentEventsVerifier = InputEventConsistencyVerifier.isInstrumentationEnabled() ? new InputEventConsistencyVerifier(this, AccessibilityManagerService.OWN_PROCESS_ID, KeyEventDispatcher.class.getSimpleName()) : null;
            }

            public void notifyKeyEvent(KeyEvent event, int policyFlags) {
                PendingEvent pendingEvent;
                synchronized (AccessibilityManagerService.this.mLock) {
                    pendingEvent = addPendingEventLocked(event, policyFlags);
                }
                Service.this.mInvocationHandler.sendMessageDelayed(Service.this.mInvocationHandler.obtainMessage(4, pendingEvent), ON_KEY_EVENT_TIMEOUT_MILLIS);
                try {
                    Service.this.mServiceInterface.onKeyEvent(pendingEvent.event, pendingEvent.sequence);
                } catch (RemoteException e) {
                    setOnKeyEventResult(AccessibilityManagerService.DEBUG, pendingEvent.sequence);
                }
            }

            public void setOnKeyEventResult(boolean handled, int sequence) {
                synchronized (AccessibilityManagerService.this.mLock) {
                    PendingEvent pendingEvent = removePendingEventLocked(sequence);
                    if (pendingEvent != null) {
                        Service.this.mInvocationHandler.removeMessages(4, pendingEvent);
                        pendingEvent.handled = handled;
                        finishPendingEventLocked(pendingEvent);
                    }
                }
            }

            public void flush() {
                synchronized (AccessibilityManagerService.this.mLock) {
                    cancelAllPendingEventsLocked();
                    if (this.mSentEventsVerifier != null) {
                        this.mSentEventsVerifier.reset();
                    }
                }
            }

            private PendingEvent addPendingEventLocked(KeyEvent event, int policyFlags) {
                PendingEvent pendingEvent = AccessibilityManagerService.this.obtainPendingEventLocked(event, policyFlags, event.getSequenceNumber());
                pendingEvent.next = this.mPendingEvents;
                this.mPendingEvents = pendingEvent;
                return pendingEvent;
            }

            private PendingEvent removePendingEventLocked(int sequence) {
                PendingEvent previous = null;
                for (PendingEvent current = this.mPendingEvents; current != null; current = current.next) {
                    if (current.sequence == sequence) {
                        if (previous != null) {
                            previous.next = current.next;
                        } else {
                            this.mPendingEvents = current.next;
                        }
                        current.next = null;
                        return current;
                    }
                    previous = current;
                }
                return null;
            }

            private void finishPendingEventLocked(PendingEvent pendingEvent) {
                if (!pendingEvent.handled) {
                    sendKeyEventToInputFilter(pendingEvent.event, pendingEvent.policyFlags);
                }
                pendingEvent.event = null;
                AccessibilityManagerService.this.recyclePendingEventLocked(pendingEvent);
            }

            private void sendKeyEventToInputFilter(KeyEvent event, int policyFlags) {
                if (this.mSentEventsVerifier != null) {
                    this.mSentEventsVerifier.onKeyEvent(event, AccessibilityManagerService.OWN_PROCESS_ID);
                }
                AccessibilityManagerService.this.mMainHandler.obtainMessage(8, policyFlags | 1073741824, AccessibilityManagerService.OWN_PROCESS_ID, event).sendToTarget();
            }

            private void cancelAllPendingEventsLocked() {
                while (this.mPendingEvents != null) {
                    PendingEvent pendingEvent = removePendingEventLocked(this.mPendingEvents.sequence);
                    pendingEvent.handled = AccessibilityManagerService.DEBUG;
                    Service.this.mInvocationHandler.removeMessages(4, pendingEvent);
                    finishPendingEventLocked(pendingEvent);
                }
            }
        }

        public Service(int userId, ComponentName componentName, AccessibilityServiceInfo accessibilityServiceInfo) {
            this.mId = AccessibilityManagerService.OWN_PROCESS_ID;
            this.mPackageNames = new HashSet();
            this.mOverlayWindowToken = new Binder();
            this.mPendingEvents = new SparseArray();
            this.mKeyEventDispatcher = new KeyEventDispatcher();
            this.mEventDispatchHandler = new C01021(AccessibilityManagerService.this.mMainHandler.getLooper());
            this.mInvocationHandler = new InvocationHandler(AccessibilityManagerService.this.mMainHandler.getLooper());
            this.mUserId = userId;
            this.mResolveInfo = accessibilityServiceInfo.getResolveInfo();
            this.mId = AccessibilityManagerService.access$2808();
            this.mComponentName = componentName;
            this.mAccessibilityServiceInfo = accessibilityServiceInfo;
            this.mIsAutomation = AccessibilityManagerService.sFakeAccessibilityServiceComponentName.equals(componentName);
            if (!this.mIsAutomation) {
                this.mIntent = new Intent().setComponent(this.mComponentName);
                this.mIntent.putExtra("android.intent.extra.client_label", 17040725);
                this.mIntent.putExtra("android.intent.extra.client_intent", PendingIntent.getActivity(AccessibilityManagerService.this.mContext, AccessibilityManagerService.OWN_PROCESS_ID, new Intent("android.settings.ACCESSIBILITY_SETTINGS"), AccessibilityManagerService.OWN_PROCESS_ID));
            }
            setDynamicallyConfigurableProperties(accessibilityServiceInfo);
        }

        public void setDynamicallyConfigurableProperties(AccessibilityServiceInfo info) {
            boolean z;
            boolean z2 = true;
            this.mEventTypes = info.eventTypes;
            this.mFeedbackType = info.feedbackType;
            String[] packageNames = info.packageNames;
            if (packageNames != null) {
                this.mPackageNames.addAll(Arrays.asList(packageNames));
            }
            this.mNotificationTimeout = info.notificationTimeout;
            this.mIsDefault = (info.flags & 1) != 0 ? true : AccessibilityManagerService.DEBUG;
            if (this.mIsAutomation || info.getResolveInfo().serviceInfo.applicationInfo.targetSdkVersion >= 16) {
                if ((info.flags & 2) != 0) {
                    this.mFetchFlags |= 8;
                } else {
                    this.mFetchFlags &= -9;
                }
            }
            if ((info.flags & 16) != 0) {
                this.mFetchFlags |= 16;
            } else {
                this.mFetchFlags &= -17;
            }
            if ((info.flags & 4) != 0) {
                z = true;
            } else {
                z = AccessibilityManagerService.DEBUG;
            }
            this.mRequestTouchExplorationMode = z;
            if ((info.flags & 8) != 0) {
                z = true;
            } else {
                z = AccessibilityManagerService.DEBUG;
            }
            this.mRequestEnhancedWebAccessibility = z;
            if ((info.flags & 32) != 0) {
                z = true;
            } else {
                z = AccessibilityManagerService.DEBUG;
            }
            this.mRequestFilterKeyEvents = z;
            if ((info.flags & 64) == 0) {
                z2 = AccessibilityManagerService.DEBUG;
            }
            this.mRetrieveInteractiveWindows = z2;
        }

        public boolean bindLocked() {
            UserState userState = AccessibilityManagerService.this.getUserStateLocked(this.mUserId);
            if (this.mIsAutomation) {
                userState.mBindingServices.add(this.mComponentName);
                this.mService = userState.mUiAutomationServiceClient.asBinder();
                AccessibilityManagerService.this.mMainHandler.post(new C01032());
                userState.mUiAutomationService = this;
            } else if (this.mService == null && AccessibilityManagerService.this.mContext.bindServiceAsUser(this.mIntent, this, 1, new UserHandle(this.mUserId))) {
                userState.mBindingServices.add(this.mComponentName);
            }
            return AccessibilityManagerService.DEBUG;
        }

        public boolean unbindLocked() {
            if (this.mService == null) {
                return AccessibilityManagerService.DEBUG;
            }
            UserState userState = AccessibilityManagerService.this.getUserStateLocked(this.mUserId);
            this.mKeyEventDispatcher.flush();
            if (this.mIsAutomation) {
                userState.destroyUiAutomationService();
            } else {
                AccessibilityManagerService.this.mContext.unbindService(this);
            }
            AccessibilityManagerService.this.removeServiceLocked(this, userState);
            resetLocked();
            return true;
        }

        public boolean canReceiveEventsLocked() {
            return (this.mEventTypes == 0 || this.mFeedbackType == 0 || this.mService == null) ? AccessibilityManagerService.DEBUG : true;
        }

        public void setOnKeyEventResult(boolean handled, int sequence) {
            this.mKeyEventDispatcher.setOnKeyEventResult(handled, sequence);
        }

        public AccessibilityServiceInfo getServiceInfo() {
            AccessibilityServiceInfo accessibilityServiceInfo;
            synchronized (AccessibilityManagerService.this.mLock) {
                accessibilityServiceInfo = this.mAccessibilityServiceInfo;
            }
            return accessibilityServiceInfo;
        }

        public boolean canRetrieveInteractiveWindowsLocked() {
            return (AccessibilityManagerService.this.mSecurityPolicy.canRetrieveWindowContentLocked(this) && this.mRetrieveInteractiveWindows) ? true : AccessibilityManagerService.DEBUG;
        }

        public void setServiceInfo(AccessibilityServiceInfo info) {
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (AccessibilityManagerService.this.mLock) {
                    AccessibilityServiceInfo oldInfo = this.mAccessibilityServiceInfo;
                    if (oldInfo != null) {
                        oldInfo.updateDynamicallyConfigurableProperties(info);
                        setDynamicallyConfigurableProperties(oldInfo);
                    } else {
                        setDynamicallyConfigurableProperties(info);
                    }
                    AccessibilityManagerService.this.onUserStateChangedLocked(AccessibilityManagerService.this.getUserStateLocked(this.mUserId));
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void onServiceConnected(ComponentName componentName, IBinder service) {
            synchronized (AccessibilityManagerService.this.mLock) {
                this.mService = service;
                this.mServiceInterface = IAccessibilityServiceClient.Stub.asInterface(service);
                UserState userState = AccessibilityManagerService.this.getUserStateLocked(this.mUserId);
                AccessibilityManagerService.this.addServiceLocked(this, userState);
                if (userState.mBindingServices.contains(this.mComponentName) || this.mWasConnectedAndDied) {
                    userState.mBindingServices.remove(this.mComponentName);
                    this.mWasConnectedAndDied = AccessibilityManagerService.DEBUG;
                    try {
                        this.mServiceInterface.init(this, this.mId, this.mOverlayWindowToken);
                        AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                    } catch (RemoteException re) {
                        Slog.w(AccessibilityManagerService.LOG_TAG, "Error while setting connection for service: " + service, re);
                        binderDied();
                    }
                } else {
                    binderDied();
                }
            }
        }

        public List<AccessibilityWindowInfo> getWindows() {
            List<AccessibilityWindowInfo> list = null;
            AccessibilityManagerService.this.ensureWindowsAvailableTimed();
            synchronized (AccessibilityManagerService.this.mLock) {
                if (AccessibilityManagerService.this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(-2) != AccessibilityManagerService.this.mCurrentUserId) {
                } else if (!AccessibilityManagerService.this.mSecurityPolicy.canRetrieveWindowsLocked(this)) {
                } else if (AccessibilityManagerService.this.mSecurityPolicy.mWindows == null) {
                } else {
                    list = new ArrayList();
                    int windowCount = AccessibilityManagerService.this.mSecurityPolicy.mWindows.size();
                    for (int i = AccessibilityManagerService.OWN_PROCESS_ID; i < windowCount; i++) {
                        AccessibilityWindowInfo windowClone = AccessibilityWindowInfo.obtain((AccessibilityWindowInfo) AccessibilityManagerService.this.mSecurityPolicy.mWindows.get(i));
                        windowClone.setConnectionId(this.mId);
                        list.add(windowClone);
                    }
                }
            }
            return list;
        }

        public AccessibilityWindowInfo getWindow(int windowId) {
            AccessibilityWindowInfo accessibilityWindowInfo = null;
            AccessibilityManagerService.this.ensureWindowsAvailableTimed();
            synchronized (AccessibilityManagerService.this.mLock) {
                if (AccessibilityManagerService.this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(-2) != AccessibilityManagerService.this.mCurrentUserId) {
                } else if (AccessibilityManagerService.this.mSecurityPolicy.canRetrieveWindowsLocked(this)) {
                    AccessibilityWindowInfo window = AccessibilityManagerService.this.mSecurityPolicy.findWindowById(windowId);
                    if (window != null) {
                        accessibilityWindowInfo = AccessibilityWindowInfo.obtain(window);
                        accessibilityWindowInfo.setConnectionId(this.mId);
                    }
                }
            }
            return accessibilityWindowInfo;
        }

        public boolean findAccessibilityNodeInfosByViewId(int accessibilityWindowId, long accessibilityNodeId, String viewIdResName, int interactionId, IAccessibilityInteractionConnectionCallback callback, long interrogatingTid) throws RemoteException {
            Region partialInteractiveRegion = AccessibilityManagerService.this.mTempRegion;
            synchronized (AccessibilityManagerService.this.mLock) {
                if (AccessibilityManagerService.this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(-2) != AccessibilityManagerService.this.mCurrentUserId) {
                    return AccessibilityManagerService.DEBUG;
                }
                int resolvedWindowId = resolveAccessibilityWindowIdLocked(accessibilityWindowId);
                if (AccessibilityManagerService.this.mSecurityPolicy.canGetAccessibilityNodeInfoLocked(this, resolvedWindowId)) {
                    IAccessibilityInteractionConnection connection = getConnectionLocked(resolvedWindowId);
                    if (connection == null) {
                        return AccessibilityManagerService.DEBUG;
                    }
                    if (!AccessibilityManagerService.this.mSecurityPolicy.computePartialInteractiveRegionForWindowLocked(resolvedWindowId, partialInteractiveRegion)) {
                        partialInteractiveRegion = null;
                    }
                    int interrogatingPid = Binder.getCallingPid();
                    long identityToken = Binder.clearCallingIdentity();
                    boolean z;
                    try {
                        connection.findAccessibilityNodeInfosByViewId(accessibilityNodeId, viewIdResName, partialInteractiveRegion, interactionId, callback, this.mFetchFlags, interrogatingPid, interrogatingTid, AccessibilityManagerService.this.getCompatibleMagnificationSpecLocked(resolvedWindowId));
                        z = true;
                        return z;
                    } catch (RemoteException e) {
                        z = e;
                        return AccessibilityManagerService.DEBUG;
                    } finally {
                        Binder.restoreCallingIdentity(identityToken);
                    }
                } else {
                    return AccessibilityManagerService.DEBUG;
                }
            }
        }

        public boolean findAccessibilityNodeInfosByText(int accessibilityWindowId, long accessibilityNodeId, String text, int interactionId, IAccessibilityInteractionConnectionCallback callback, long interrogatingTid) throws RemoteException {
            Region partialInteractiveRegion = AccessibilityManagerService.this.mTempRegion;
            synchronized (AccessibilityManagerService.this.mLock) {
                if (AccessibilityManagerService.this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(-2) != AccessibilityManagerService.this.mCurrentUserId) {
                    return AccessibilityManagerService.DEBUG;
                }
                int resolvedWindowId = resolveAccessibilityWindowIdLocked(accessibilityWindowId);
                if (AccessibilityManagerService.this.mSecurityPolicy.canGetAccessibilityNodeInfoLocked(this, resolvedWindowId)) {
                    IAccessibilityInteractionConnection connection = getConnectionLocked(resolvedWindowId);
                    if (connection == null) {
                        return AccessibilityManagerService.DEBUG;
                    }
                    if (!AccessibilityManagerService.this.mSecurityPolicy.computePartialInteractiveRegionForWindowLocked(resolvedWindowId, partialInteractiveRegion)) {
                        partialInteractiveRegion = null;
                    }
                    int interrogatingPid = Binder.getCallingPid();
                    long identityToken = Binder.clearCallingIdentity();
                    boolean z;
                    try {
                        connection.findAccessibilityNodeInfosByText(accessibilityNodeId, text, partialInteractiveRegion, interactionId, callback, this.mFetchFlags, interrogatingPid, interrogatingTid, AccessibilityManagerService.this.getCompatibleMagnificationSpecLocked(resolvedWindowId));
                        z = true;
                        return z;
                    } catch (RemoteException e) {
                        z = e;
                        return AccessibilityManagerService.DEBUG;
                    } finally {
                        Binder.restoreCallingIdentity(identityToken);
                    }
                } else {
                    return AccessibilityManagerService.DEBUG;
                }
            }
        }

        public boolean findAccessibilityNodeInfoByAccessibilityId(int accessibilityWindowId, long accessibilityNodeId, int interactionId, IAccessibilityInteractionConnectionCallback callback, int flags, long interrogatingTid) throws RemoteException {
            Region partialInteractiveRegion = AccessibilityManagerService.this.mTempRegion;
            synchronized (AccessibilityManagerService.this.mLock) {
                if (AccessibilityManagerService.this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(-2) != AccessibilityManagerService.this.mCurrentUserId) {
                    return AccessibilityManagerService.DEBUG;
                }
                int resolvedWindowId = resolveAccessibilityWindowIdLocked(accessibilityWindowId);
                if (AccessibilityManagerService.this.mSecurityPolicy.canGetAccessibilityNodeInfoLocked(this, resolvedWindowId)) {
                    IAccessibilityInteractionConnection connection = getConnectionLocked(resolvedWindowId);
                    if (connection == null) {
                        return AccessibilityManagerService.DEBUG;
                    }
                    if (!AccessibilityManagerService.this.mSecurityPolicy.computePartialInteractiveRegionForWindowLocked(resolvedWindowId, partialInteractiveRegion)) {
                        partialInteractiveRegion = null;
                    }
                    int interrogatingPid = Binder.getCallingPid();
                    long identityToken = Binder.clearCallingIdentity();
                    boolean z;
                    try {
                        connection.findAccessibilityNodeInfoByAccessibilityId(accessibilityNodeId, partialInteractiveRegion, interactionId, callback, this.mFetchFlags | flags, interrogatingPid, interrogatingTid, AccessibilityManagerService.this.getCompatibleMagnificationSpecLocked(resolvedWindowId));
                        z = true;
                        return z;
                    } catch (RemoteException e) {
                        z = e;
                        return AccessibilityManagerService.DEBUG;
                    } finally {
                        Binder.restoreCallingIdentity(identityToken);
                    }
                } else {
                    return AccessibilityManagerService.DEBUG;
                }
            }
        }

        public boolean findFocus(int accessibilityWindowId, long accessibilityNodeId, int focusType, int interactionId, IAccessibilityInteractionConnectionCallback callback, long interrogatingTid) throws RemoteException {
            Region partialInteractiveRegion = AccessibilityManagerService.this.mTempRegion;
            synchronized (AccessibilityManagerService.this.mLock) {
                if (AccessibilityManagerService.this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(-2) != AccessibilityManagerService.this.mCurrentUserId) {
                    return AccessibilityManagerService.DEBUG;
                }
                int resolvedWindowId = resolveAccessibilityWindowIdForFindFocusLocked(accessibilityWindowId, focusType);
                if (AccessibilityManagerService.this.mSecurityPolicy.canGetAccessibilityNodeInfoLocked(this, resolvedWindowId)) {
                    IAccessibilityInteractionConnection connection = getConnectionLocked(resolvedWindowId);
                    if (connection == null) {
                        return AccessibilityManagerService.DEBUG;
                    }
                    if (!AccessibilityManagerService.this.mSecurityPolicy.computePartialInteractiveRegionForWindowLocked(resolvedWindowId, partialInteractiveRegion)) {
                        partialInteractiveRegion = null;
                    }
                    int interrogatingPid = Binder.getCallingPid();
                    long identityToken = Binder.clearCallingIdentity();
                    boolean z;
                    try {
                        connection.findFocus(accessibilityNodeId, focusType, partialInteractiveRegion, interactionId, callback, this.mFetchFlags, interrogatingPid, interrogatingTid, AccessibilityManagerService.this.getCompatibleMagnificationSpecLocked(resolvedWindowId));
                        z = true;
                        return z;
                    } catch (RemoteException e) {
                        z = e;
                        return AccessibilityManagerService.DEBUG;
                    } finally {
                        Binder.restoreCallingIdentity(identityToken);
                    }
                } else {
                    return AccessibilityManagerService.DEBUG;
                }
            }
        }

        public boolean focusSearch(int accessibilityWindowId, long accessibilityNodeId, int direction, int interactionId, IAccessibilityInteractionConnectionCallback callback, long interrogatingTid) throws RemoteException {
            Region partialInteractiveRegion = AccessibilityManagerService.this.mTempRegion;
            synchronized (AccessibilityManagerService.this.mLock) {
                if (AccessibilityManagerService.this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(-2) != AccessibilityManagerService.this.mCurrentUserId) {
                    return AccessibilityManagerService.DEBUG;
                }
                int resolvedWindowId = resolveAccessibilityWindowIdLocked(accessibilityWindowId);
                if (AccessibilityManagerService.this.mSecurityPolicy.canGetAccessibilityNodeInfoLocked(this, resolvedWindowId)) {
                    IAccessibilityInteractionConnection connection = getConnectionLocked(resolvedWindowId);
                    if (connection == null) {
                        return AccessibilityManagerService.DEBUG;
                    }
                    if (!AccessibilityManagerService.this.mSecurityPolicy.computePartialInteractiveRegionForWindowLocked(resolvedWindowId, partialInteractiveRegion)) {
                        partialInteractiveRegion = null;
                    }
                    int interrogatingPid = Binder.getCallingPid();
                    long identityToken = Binder.clearCallingIdentity();
                    boolean z;
                    try {
                        connection.focusSearch(accessibilityNodeId, direction, partialInteractiveRegion, interactionId, callback, this.mFetchFlags, interrogatingPid, interrogatingTid, AccessibilityManagerService.this.getCompatibleMagnificationSpecLocked(resolvedWindowId));
                        z = true;
                        return z;
                    } catch (RemoteException e) {
                        z = e;
                        return AccessibilityManagerService.DEBUG;
                    } finally {
                        Binder.restoreCallingIdentity(identityToken);
                    }
                } else {
                    return AccessibilityManagerService.DEBUG;
                }
            }
        }

        public boolean performAccessibilityAction(int accessibilityWindowId, long accessibilityNodeId, int action, Bundle arguments, int interactionId, IAccessibilityInteractionConnectionCallback callback, long interrogatingTid) throws RemoteException {
            synchronized (AccessibilityManagerService.this.mLock) {
                if (AccessibilityManagerService.this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(-2) != AccessibilityManagerService.this.mCurrentUserId) {
                    return AccessibilityManagerService.DEBUG;
                }
                int resolvedWindowId = resolveAccessibilityWindowIdLocked(accessibilityWindowId);
                if (AccessibilityManagerService.this.mSecurityPolicy.canGetAccessibilityNodeInfoLocked(this, resolvedWindowId)) {
                    IAccessibilityInteractionConnection connection = getConnectionLocked(resolvedWindowId);
                    if (connection == null) {
                        return AccessibilityManagerService.DEBUG;
                    }
                    int interrogatingPid = Binder.getCallingPid();
                    long identityToken = Binder.clearCallingIdentity();
                    try {
                        connection.performAccessibilityAction(accessibilityNodeId, action, arguments, interactionId, callback, this.mFetchFlags, interrogatingPid, interrogatingTid);
                    } catch (RemoteException e) {
                    } finally {
                        Binder.restoreCallingIdentity(identityToken);
                    }
                    return true;
                }
                return AccessibilityManagerService.DEBUG;
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public boolean performGlobalAction(int r9) {
            /*
            r8 = this;
            r3 = 0;
            r4 = 1;
            r5 = com.android.server.accessibility.AccessibilityManagerService.this;
            r5 = r5.mLock;
            monitor-enter(r5);
            r6 = com.android.server.accessibility.AccessibilityManagerService.this;	 Catch:{ all -> 0x002a }
            r6 = r6.mSecurityPolicy;	 Catch:{ all -> 0x002a }
            r7 = -2;
            r2 = r6.resolveCallingUserIdEnforcingPermissionsLocked(r7);	 Catch:{ all -> 0x002a }
            r6 = com.android.server.accessibility.AccessibilityManagerService.this;	 Catch:{ all -> 0x002a }
            r6 = r6.mCurrentUserId;	 Catch:{ all -> 0x002a }
            if (r2 == r6) goto L_0x001e;
        L_0x001c:
            monitor-exit(r5);	 Catch:{ all -> 0x002a }
        L_0x001d:
            return r3;
        L_0x001e:
            monitor-exit(r5);	 Catch:{ all -> 0x002a }
            r0 = android.os.Binder.clearCallingIdentity();
            switch(r9) {
                case 1: goto L_0x002d;
                case 2: goto L_0x0036;
                case 3: goto L_0x003f;
                case 4: goto L_0x0047;
                case 5: goto L_0x004f;
                case 6: goto L_0x0057;
                default: goto L_0x0026;
            };
        L_0x0026:
            android.os.Binder.restoreCallingIdentity(r0);
            goto L_0x001d;
        L_0x002a:
            r3 = move-exception;
            monitor-exit(r5);	 Catch:{ all -> 0x002a }
            throw r3;
        L_0x002d:
            r3 = 4;
            r8.sendDownAndUpKeyEvents(r3);	 Catch:{ all -> 0x005f }
            android.os.Binder.restoreCallingIdentity(r0);
            r3 = r4;
            goto L_0x001d;
        L_0x0036:
            r3 = 3;
            r8.sendDownAndUpKeyEvents(r3);	 Catch:{ all -> 0x005f }
            android.os.Binder.restoreCallingIdentity(r0);
            r3 = r4;
            goto L_0x001d;
        L_0x003f:
            r8.openRecents();	 Catch:{ all -> 0x005f }
            android.os.Binder.restoreCallingIdentity(r0);
            r3 = r4;
            goto L_0x001d;
        L_0x0047:
            r8.expandNotifications();	 Catch:{ all -> 0x005f }
            android.os.Binder.restoreCallingIdentity(r0);
            r3 = r4;
            goto L_0x001d;
        L_0x004f:
            r8.expandQuickSettings();	 Catch:{ all -> 0x005f }
            android.os.Binder.restoreCallingIdentity(r0);
            r3 = r4;
            goto L_0x001d;
        L_0x0057:
            r8.showGlobalActions();	 Catch:{ all -> 0x005f }
            android.os.Binder.restoreCallingIdentity(r0);
            r3 = r4;
            goto L_0x001d;
        L_0x005f:
            r3 = move-exception;
            android.os.Binder.restoreCallingIdentity(r0);
            throw r3;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.accessibility.AccessibilityManagerService.Service.performGlobalAction(int):boolean");
        }

        public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            AccessibilityManagerService.this.mSecurityPolicy.enforceCallingPermission("android.permission.DUMP", AccessibilityManagerService.FUNCTION_DUMP);
            synchronized (AccessibilityManagerService.this.mLock) {
                pw.append("Service[label=" + this.mAccessibilityServiceInfo.getResolveInfo().loadLabel(AccessibilityManagerService.this.mContext.getPackageManager()));
                pw.append(", feedbackType" + AccessibilityServiceInfo.feedbackTypeToString(this.mFeedbackType));
                pw.append(", capabilities=" + this.mAccessibilityServiceInfo.getCapabilities());
                pw.append(", eventTypes=" + AccessibilityEvent.eventTypeToString(this.mEventTypes));
                pw.append(", notificationTimeout=" + this.mNotificationTimeout);
                pw.append("]");
            }
        }

        public void onServiceDisconnected(ComponentName componentName) {
        }

        public void onAdded() throws RemoteException {
            linkToOwnDeathLocked();
            long identity = Binder.clearCallingIdentity();
            try {
                AccessibilityManagerService.this.mWindowManagerService.addWindowToken(this.mOverlayWindowToken, 2032);
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void onRemoved() {
            long identity = Binder.clearCallingIdentity();
            try {
                AccessibilityManagerService.this.mWindowManagerService.removeWindowToken(this.mOverlayWindowToken, true);
                unlinkToOwnDeathLocked();
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }

        public void linkToOwnDeathLocked() throws RemoteException {
            this.mService.linkToDeath(this, AccessibilityManagerService.OWN_PROCESS_ID);
        }

        public void unlinkToOwnDeathLocked() {
            this.mService.unlinkToDeath(this, AccessibilityManagerService.OWN_PROCESS_ID);
        }

        public void resetLocked() {
            try {
                this.mServiceInterface.init(null, this.mId, null);
            } catch (RemoteException e) {
            }
            this.mService = null;
            this.mServiceInterface = null;
        }

        public boolean isConnectedLocked() {
            return this.mService != null ? true : AccessibilityManagerService.DEBUG;
        }

        public void binderDied() {
            synchronized (AccessibilityManagerService.this.mLock) {
                if (isConnectedLocked()) {
                    this.mWasConnectedAndDied = true;
                    this.mKeyEventDispatcher.flush();
                    UserState userState = AccessibilityManagerService.this.getUserStateLocked(this.mUserId);
                    AccessibilityManagerService.this.removeServiceLocked(this, userState);
                    resetLocked();
                    if (this.mIsAutomation) {
                        userState.mInstalledServices.remove(this.mAccessibilityServiceInfo);
                        userState.mEnabledServices.remove(this.mComponentName);
                        userState.destroyUiAutomationService();
                        if (AccessibilityManagerService.this.readConfigurationForUserStateLocked(userState)) {
                            AccessibilityManagerService.this.onUserStateChangedLocked(userState);
                        }
                    }
                    return;
                }
            }
        }

        public void notifyAccessibilityEvent(AccessibilityEvent event) {
            synchronized (AccessibilityManagerService.this.mLock) {
                int eventType = event.getEventType();
                AccessibilityEvent oldEvent = (AccessibilityEvent) this.mPendingEvents.get(eventType);
                this.mPendingEvents.put(eventType, AccessibilityEvent.obtain(event));
                int what = eventType;
                if (oldEvent != null) {
                    this.mEventDispatchHandler.removeMessages(what);
                    oldEvent.recycle();
                }
                this.mEventDispatchHandler.sendMessageDelayed(this.mEventDispatchHandler.obtainMessage(what), this.mNotificationTimeout);
            }
        }

        private void notifyAccessibilityEventInternal(int eventType) {
            synchronized (AccessibilityManagerService.this.mLock) {
                IAccessibilityServiceClient listener = this.mServiceInterface;
                if (listener == null) {
                    return;
                }
                AccessibilityEvent event = (AccessibilityEvent) this.mPendingEvents.get(eventType);
                if (event == null) {
                    return;
                }
                this.mPendingEvents.remove(eventType);
                if (AccessibilityManagerService.this.mSecurityPolicy.canRetrieveWindowContentLocked(this)) {
                    event.setConnectionId(this.mId);
                } else {
                    event.setSource(null);
                }
                event.setSealed(true);
                try {
                    listener.onAccessibilityEvent(event);
                } catch (RemoteException re) {
                    Slog.e(AccessibilityManagerService.LOG_TAG, "Error during sending " + event + " to " + listener, re);
                } finally {
                    event.recycle();
                }
            }
        }

        public void notifyGesture(int gestureId) {
            this.mInvocationHandler.obtainMessage(1, gestureId, AccessibilityManagerService.OWN_PROCESS_ID).sendToTarget();
        }

        public void notifyKeyEvent(KeyEvent event, int policyFlags) {
            this.mInvocationHandler.obtainMessage(2, policyFlags, AccessibilityManagerService.OWN_PROCESS_ID, event).sendToTarget();
        }

        public void notifyClearAccessibilityNodeInfoCache() {
            this.mInvocationHandler.sendEmptyMessage(3);
        }

        private void notifyGestureInternal(int gestureId) {
            synchronized (AccessibilityManagerService.this.mLock) {
                IAccessibilityServiceClient listener = this.mServiceInterface;
            }
            if (listener != null) {
                try {
                    listener.onGesture(gestureId);
                } catch (RemoteException re) {
                    Slog.e(AccessibilityManagerService.LOG_TAG, "Error during sending gesture " + gestureId + " to " + this.mService, re);
                }
            }
        }

        private void notifyKeyEventInternal(KeyEvent event, int policyFlags) {
            this.mKeyEventDispatcher.notifyKeyEvent(event, policyFlags);
        }

        private void notifyClearAccessibilityCacheInternal() {
            synchronized (AccessibilityManagerService.this.mLock) {
                IAccessibilityServiceClient listener = this.mServiceInterface;
            }
            if (listener != null) {
                try {
                    listener.clearAccessibilityCache();
                } catch (RemoteException re) {
                    Slog.e(AccessibilityManagerService.LOG_TAG, "Error during requesting accessibility info cache to be cleared.", re);
                }
            }
        }

        private void sendDownAndUpKeyEvents(int keyCode) {
            long token = Binder.clearCallingIdentity();
            long downTime = SystemClock.uptimeMillis();
            KeyEvent down = KeyEvent.obtain(downTime, downTime, AccessibilityManagerService.OWN_PROCESS_ID, keyCode, AccessibilityManagerService.OWN_PROCESS_ID, AccessibilityManagerService.OWN_PROCESS_ID, AccessibilityManagerService.WINDOW_ID_UNKNOWN, AccessibilityManagerService.OWN_PROCESS_ID, 8, 257, null);
            InputManager.getInstance().injectInputEvent(down, AccessibilityManagerService.OWN_PROCESS_ID);
            down.recycle();
            InputEvent up = KeyEvent.obtain(downTime, SystemClock.uptimeMillis(), 1, keyCode, AccessibilityManagerService.OWN_PROCESS_ID, AccessibilityManagerService.OWN_PROCESS_ID, AccessibilityManagerService.WINDOW_ID_UNKNOWN, AccessibilityManagerService.OWN_PROCESS_ID, 8, 257, null);
            InputManager.getInstance().injectInputEvent(up, AccessibilityManagerService.OWN_PROCESS_ID);
            up.recycle();
            Binder.restoreCallingIdentity(token);
        }

        private void expandNotifications() {
            long token = Binder.clearCallingIdentity();
            ((StatusBarManager) AccessibilityManagerService.this.mContext.getSystemService("statusbar")).expandNotificationsPanel();
            Binder.restoreCallingIdentity(token);
        }

        private void expandQuickSettings() {
            long token = Binder.clearCallingIdentity();
            ((StatusBarManager) AccessibilityManagerService.this.mContext.getSystemService("statusbar")).expandSettingsPanel();
            Binder.restoreCallingIdentity(token);
        }

        private void openRecents() {
            long token = Binder.clearCallingIdentity();
            try {
                IStatusBarService.Stub.asInterface(ServiceManager.getService("statusbar")).toggleRecentApps();
            } catch (RemoteException e) {
                Slog.e(AccessibilityManagerService.LOG_TAG, "Error toggling recent apps.");
            }
            Binder.restoreCallingIdentity(token);
        }

        private void showGlobalActions() {
            AccessibilityManagerService.this.mWindowManagerService.showGlobalActions();
        }

        private IAccessibilityInteractionConnection getConnectionLocked(int windowId) {
            AccessibilityConnectionWrapper wrapper = (AccessibilityConnectionWrapper) AccessibilityManagerService.this.mGlobalInteractionConnections.get(windowId);
            if (wrapper == null) {
                wrapper = (AccessibilityConnectionWrapper) AccessibilityManagerService.this.getCurrentUserStateLocked().mInteractionConnections.get(windowId);
            }
            if (wrapper == null || wrapper.mConnection == null) {
                return null;
            }
            return wrapper.mConnection;
        }

        private int resolveAccessibilityWindowIdLocked(int accessibilityWindowId) {
            if (accessibilityWindowId == Integer.MAX_VALUE) {
                return AccessibilityManagerService.this.mSecurityPolicy.getActiveWindowId();
            }
            return accessibilityWindowId;
        }

        private int resolveAccessibilityWindowIdForFindFocusLocked(int windowId, int focusType) {
            if (windowId == Integer.MAX_VALUE) {
                return AccessibilityManagerService.this.mSecurityPolicy.mActiveWindowId;
            }
            if (windowId != -2) {
                return windowId;
            }
            if (focusType == 1) {
                return AccessibilityManagerService.this.mSecurityPolicy.mFocusedWindowId;
            }
            if (focusType == 2) {
                return AccessibilityManagerService.this.mSecurityPolicy.mAccessibilityFocusedWindowId;
            }
            return windowId;
        }
    }

    private class UserState {
        public boolean mAccessibilityFocusOnlyInActiveWindow;
        public final Set<ComponentName> mBindingServices;
        public final CopyOnWriteArrayList<Service> mBoundServices;
        public final RemoteCallbackList<IAccessibilityManagerClient> mClients;
        public final Map<ComponentName, Service> mComponentNameToServiceMap;
        public final Set<ComponentName> mEnabledServices;
        public int mHandledFeedbackTypes;
        public boolean mHasDisplayColorAdjustment;
        public final List<AccessibilityServiceInfo> mInstalledServices;
        public final SparseArray<AccessibilityConnectionWrapper> mInteractionConnections;
        public boolean mIsAccessibilityEnabled;
        public boolean mIsDisplayMagnificationEnabled;
        public boolean mIsEnhancedWebAccessibilityEnabled;
        public boolean mIsFilterKeyEventsEnabled;
        public boolean mIsTextHighContrastEnabled;
        public boolean mIsTouchExplorationEnabled;
        public int mLastSentClientState;
        public final Set<ComponentName> mTouchExplorationGrantedServices;
        private final DeathRecipient mUiAutomationSerivceOnwerDeathRecipient;
        private Service mUiAutomationService;
        private IAccessibilityServiceClient mUiAutomationServiceClient;
        private IBinder mUiAutomationServiceOwner;
        public final int mUserId;
        public final SparseArray<IBinder> mWindowTokens;

        /* renamed from: com.android.server.accessibility.AccessibilityManagerService.UserState.1 */
        class C01041 implements DeathRecipient {
            C01041() {
            }

            public void binderDied() {
                UserState.this.mUiAutomationServiceOwner.unlinkToDeath(UserState.this.mUiAutomationSerivceOnwerDeathRecipient, AccessibilityManagerService.OWN_PROCESS_ID);
                UserState.this.mUiAutomationServiceOwner = null;
                if (UserState.this.mUiAutomationService != null) {
                    UserState.this.mUiAutomationService.binderDied();
                }
            }
        }

        public UserState(int userId) {
            this.mClients = new RemoteCallbackList();
            this.mInteractionConnections = new SparseArray();
            this.mWindowTokens = new SparseArray();
            this.mBoundServices = new CopyOnWriteArrayList();
            this.mComponentNameToServiceMap = new HashMap();
            this.mInstalledServices = new ArrayList();
            this.mBindingServices = new HashSet();
            this.mEnabledServices = new HashSet();
            this.mTouchExplorationGrantedServices = new HashSet();
            this.mHandledFeedbackTypes = AccessibilityManagerService.OWN_PROCESS_ID;
            this.mLastSentClientState = AccessibilityManagerService.WINDOW_ID_UNKNOWN;
            this.mUiAutomationSerivceOnwerDeathRecipient = new C01041();
            this.mUserId = userId;
        }

        public int getClientState() {
            int clientState = AccessibilityManagerService.OWN_PROCESS_ID;
            if (this.mIsAccessibilityEnabled) {
                clientState = AccessibilityManagerService.OWN_PROCESS_ID | 1;
            }
            if (this.mIsAccessibilityEnabled && this.mIsTouchExplorationEnabled) {
                clientState |= 2;
            }
            if (this.mIsTextHighContrastEnabled) {
                return clientState | 4;
            }
            return clientState;
        }

        public void onSwitchToAnotherUser() {
            if (this.mUiAutomationService != null) {
                this.mUiAutomationService.binderDied();
            }
            AccessibilityManagerService.this.unbindAllServicesLocked(this);
            this.mBoundServices.clear();
            this.mBindingServices.clear();
            this.mHandledFeedbackTypes = AccessibilityManagerService.OWN_PROCESS_ID;
            this.mLastSentClientState = AccessibilityManagerService.WINDOW_ID_UNKNOWN;
            this.mEnabledServices.clear();
            this.mTouchExplorationGrantedServices.clear();
            this.mIsAccessibilityEnabled = AccessibilityManagerService.DEBUG;
            this.mIsTouchExplorationEnabled = AccessibilityManagerService.DEBUG;
            this.mIsEnhancedWebAccessibilityEnabled = AccessibilityManagerService.DEBUG;
            this.mIsDisplayMagnificationEnabled = AccessibilityManagerService.DEBUG;
        }

        public void destroyUiAutomationService() {
            this.mUiAutomationService = null;
            this.mUiAutomationServiceClient = null;
            if (this.mUiAutomationServiceOwner != null) {
                this.mUiAutomationServiceOwner.unlinkToDeath(this.mUiAutomationSerivceOnwerDeathRecipient, AccessibilityManagerService.OWN_PROCESS_ID);
                this.mUiAutomationServiceOwner = null;
            }
        }
    }

    final class WindowsForAccessibilityCallback implements android.view.WindowManagerInternal.WindowsForAccessibilityCallback {
        WindowsForAccessibilityCallback() {
        }

        public void onWindowsForAccessibilityChanged(List<WindowInfo> windows) {
            synchronized (AccessibilityManagerService.this.mLock) {
                List<AccessibilityWindowInfo> reportedWindows = new ArrayList();
                int receivedWindowCount = windows.size();
                for (int i = AccessibilityManagerService.OWN_PROCESS_ID; i < receivedWindowCount; i++) {
                    AccessibilityWindowInfo reportedWindow = populateReportedWindow((WindowInfo) windows.get(i));
                    if (reportedWindow != null) {
                        reportedWindows.add(reportedWindow);
                    }
                }
                AccessibilityManagerService.this.mSecurityPolicy.updateWindowsLocked(reportedWindows);
                AccessibilityManagerService.this.mLock.notifyAll();
            }
        }

        private AccessibilityWindowInfo populateReportedWindow(WindowInfo window) {
            int windowId = AccessibilityManagerService.this.findWindowIdLocked(window.token);
            if (windowId < 0) {
                return null;
            }
            AccessibilityWindowInfo reportedWindow = AccessibilityWindowInfo.obtain();
            reportedWindow.setId(windowId);
            reportedWindow.setType(getTypeForWindowManagerWindowType(window.type));
            reportedWindow.setLayer(window.layer);
            reportedWindow.setFocused(window.focused);
            reportedWindow.setBoundsInScreen(window.boundsInScreen);
            int parentId = AccessibilityManagerService.this.findWindowIdLocked(window.parentToken);
            if (parentId >= 0) {
                reportedWindow.setParentId(parentId);
            }
            if (window.childTokens == null) {
                return reportedWindow;
            }
            int childCount = window.childTokens.size();
            for (int i = AccessibilityManagerService.OWN_PROCESS_ID; i < childCount; i++) {
                int childId = AccessibilityManagerService.this.findWindowIdLocked((IBinder) window.childTokens.get(i));
                if (childId >= 0) {
                    reportedWindow.addChild(childId);
                }
            }
            return reportedWindow;
        }

        private int getTypeForWindowManagerWindowType(int windowType) {
            switch (windowType) {
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                case C0569H.REPORT_LOSING_FOCUS /*3*/:
                case ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE /*1000*/:
                case 1001:
                case 1002:
                case 1003:
                case 2002:
                case 2005:
                case 2007:
                    return 1;
                case 2000:
                case 2001:
                case 2003:
                case 2006:
                case 2008:
                case 2009:
                case 2010:
                case 2014:
                case 2017:
                case 2019:
                case 2020:
                case 2024:
                    return 3;
                case 2011:
                case 2012:
                    return 2;
                case 2032:
                    return 4;
                default:
                    return AccessibilityManagerService.WINDOW_ID_UNKNOWN;
            }
        }
    }

    static /* synthetic */ int access$2808() {
        int i = sIdCounter;
        sIdCounter = i + 1;
        return i;
    }

    static {
        sFakeAccessibilityServiceComponentName = new ComponentName("foo.bar", "FakeService");
        OWN_PROCESS_ID = Process.myPid();
        sIdCounter = OWN_PROCESS_ID;
    }

    private UserState getCurrentUserStateLocked() {
        return getUserStateLocked(this.mCurrentUserId);
    }

    public AccessibilityManagerService(Context context) {
        this.mLock = new Object();
        this.mPendingEventPool = new SimplePool(MAX_POOL_SIZE);
        this.mStringColonSplitter = new SimpleStringSplitter(COMPONENT_NAME_SEPARATOR);
        this.mEnabledServicesForFeedbackTempList = new ArrayList();
        this.mTempRegion = new Region();
        this.mTempRect = new Rect();
        this.mTempRect1 = new Rect();
        this.mTempPoint = new Point();
        this.mTempComponentNameSet = new HashSet();
        this.mTempAccessibilityServiceInfoList = new ArrayList();
        this.mGlobalClients = new RemoteCallbackList();
        this.mGlobalInteractionConnections = new SparseArray();
        this.mGlobalWindowTokens = new SparseArray();
        this.mUserStates = new SparseArray();
        this.mCurrentUserId = OWN_PROCESS_ID;
        this.mContext = context;
        this.mPackageManager = this.mContext.getPackageManager();
        this.mWindowManagerService = (WindowManagerInternal) LocalServices.getService(WindowManagerInternal.class);
        this.mUserManager = (UserManager) context.getSystemService("user");
        this.mSecurityPolicy = new SecurityPolicy();
        this.mMainHandler = new MainHandler(this.mContext.getMainLooper());
        this.mLockPatternUtils = new LockPatternUtils(context);
        registerBroadcastReceivers();
        new AccessibilityContentObserver(this.mMainHandler).register(context.getContentResolver());
    }

    private UserState getUserStateLocked(int userId) {
        UserState state = (UserState) this.mUserStates.get(userId);
        if (state != null) {
            return state;
        }
        state = new UserState(userId);
        this.mUserStates.put(userId, state);
        return state;
    }

    private void registerBroadcastReceivers() {
        new C00981().register(this.mContext, null, UserHandle.ALL, true);
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.intent.action.USER_SWITCHED");
        intentFilter.addAction("android.intent.action.USER_REMOVED");
        intentFilter.addAction("android.intent.action.USER_PRESENT");
        this.mContext.registerReceiverAsUser(new C00992(), UserHandle.ALL, intentFilter, null, null);
    }

    public int addClient(IAccessibilityManagerClient client, int userId) {
        int clientState;
        synchronized (this.mLock) {
            int resolvedUserId = this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(userId);
            UserState userState = getUserStateLocked(resolvedUserId);
            if (this.mSecurityPolicy.isCallerInteractingAcrossUsers(userId)) {
                this.mGlobalClients.register(client);
                clientState = userState.getClientState();
            } else {
                userState.mClients.register(client);
                clientState = resolvedUserId == this.mCurrentUserId ? userState.getClientState() : OWN_PROCESS_ID;
            }
        }
        return clientState;
    }

    public boolean sendAccessibilityEvent(AccessibilityEvent event, int userId) {
        synchronized (this.mLock) {
            int resolvedUserId = this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(userId);
            if (resolvedUserId != this.mCurrentUserId) {
                return true;
            }
            if (this.mSecurityPolicy.canDispatchAccessibilityEventLocked(event)) {
                this.mSecurityPolicy.updateActiveAndAccessibilityFocusedWindowLocked(event.getWindowId(), event.getSourceNodeId(), event.getEventType());
                this.mSecurityPolicy.updateEventSourceLocked(event);
                notifyAccessibilityServicesDelayedLocked(event, DEBUG);
                notifyAccessibilityServicesDelayedLocked(event, true);
            }
            if (this.mHasInputFilter && this.mInputFilter != null) {
                this.mMainHandler.obtainMessage(1, AccessibilityEvent.obtain(event)).sendToTarget();
            }
            event.recycle();
            getUserStateLocked(resolvedUserId).mHandledFeedbackTypes = OWN_PROCESS_ID;
            if (OWN_PROCESS_ID == Binder.getCallingPid()) {
                return DEBUG;
            }
            return true;
        }
    }

    public List<AccessibilityServiceInfo> getInstalledAccessibilityServiceList(int userId) {
        List<AccessibilityServiceInfo> installedServices;
        synchronized (this.mLock) {
            UserState userState = getUserStateLocked(this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(userId));
            if (userState.mUiAutomationService != null) {
                installedServices = new ArrayList();
                installedServices.addAll(userState.mInstalledServices);
                installedServices.remove(userState.mUiAutomationService.mAccessibilityServiceInfo);
            } else {
                installedServices = userState.mInstalledServices;
            }
        }
        return installedServices;
    }

    public List<AccessibilityServiceInfo> getEnabledAccessibilityServiceList(int feedbackType, int userId) {
        synchronized (this.mLock) {
            UserState userState = getUserStateLocked(this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(userId));
            if (userState.mUiAutomationService != null) {
                List<AccessibilityServiceInfo> emptyList = Collections.emptyList();
                return emptyList;
            }
            List<AccessibilityServiceInfo> result = this.mEnabledServicesForFeedbackTempList;
            result.clear();
            List<Service> services = userState.mBoundServices;
            while (feedbackType != 0) {
                int feedbackTypeBit = 1 << Integer.numberOfTrailingZeros(feedbackType);
                feedbackType &= feedbackTypeBit ^ WINDOW_ID_UNKNOWN;
                int serviceCount = services.size();
                for (int i = OWN_PROCESS_ID; i < serviceCount; i++) {
                    Service service = (Service) services.get(i);
                    if ((service.mFeedbackType & feedbackTypeBit) != 0) {
                        result.add(service.mAccessibilityServiceInfo);
                    }
                }
            }
            return result;
        }
    }

    public void interrupt(int userId) {
        synchronized (this.mLock) {
            int resolvedUserId = this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(userId);
            if (resolvedUserId != this.mCurrentUserId) {
                return;
            }
            CopyOnWriteArrayList<Service> services = getUserStateLocked(resolvedUserId).mBoundServices;
            int count = services.size();
            for (int i = OWN_PROCESS_ID; i < count; i++) {
                Service service = (Service) services.get(i);
                try {
                    service.mServiceInterface.onInterrupt();
                } catch (RemoteException re) {
                    Slog.e(LOG_TAG, "Error during sending interrupt request to " + service.mService, re);
                }
            }
        }
    }

    public int addAccessibilityInteractionConnection(IWindow windowToken, IAccessibilityInteractionConnection connection, int userId) throws RemoteException {
        int windowId;
        synchronized (this.mLock) {
            int resolvedUserId = this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(userId);
            windowId = sNextWindowId;
            sNextWindowId = windowId + 1;
            AccessibilityConnectionWrapper wrapper;
            if (this.mSecurityPolicy.isCallerInteractingAcrossUsers(userId)) {
                wrapper = new AccessibilityConnectionWrapper(windowId, connection, WINDOW_ID_UNKNOWN);
                wrapper.linkToDeath();
                this.mGlobalInteractionConnections.put(windowId, wrapper);
                this.mGlobalWindowTokens.put(windowId, windowToken.asBinder());
            } else {
                wrapper = new AccessibilityConnectionWrapper(windowId, connection, resolvedUserId);
                wrapper.linkToDeath();
                UserState userState = getUserStateLocked(resolvedUserId);
                userState.mInteractionConnections.put(windowId, wrapper);
                userState.mWindowTokens.put(windowId, windowToken.asBinder());
            }
        }
        return windowId;
    }

    public void removeAccessibilityInteractionConnection(IWindow window) {
        synchronized (this.mLock) {
            this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(UserHandle.getCallingUserId());
            IBinder token = window.asBinder();
            if (removeAccessibilityInteractionConnectionInternalLocked(token, this.mGlobalWindowTokens, this.mGlobalInteractionConnections) >= 0) {
                return;
            }
            int userCount = this.mUserStates.size();
            for (int i = OWN_PROCESS_ID; i < userCount; i++) {
                UserState userState = (UserState) this.mUserStates.valueAt(i);
                if (removeAccessibilityInteractionConnectionInternalLocked(token, userState.mWindowTokens, userState.mInteractionConnections) >= 0) {
                    return;
                }
            }
        }
    }

    private int removeAccessibilityInteractionConnectionInternalLocked(IBinder windowToken, SparseArray<IBinder> windowTokens, SparseArray<AccessibilityConnectionWrapper> interactionConnections) {
        int count = windowTokens.size();
        for (int i = OWN_PROCESS_ID; i < count; i++) {
            if (windowTokens.valueAt(i) == windowToken) {
                int windowId = windowTokens.keyAt(i);
                windowTokens.removeAt(i);
                ((AccessibilityConnectionWrapper) interactionConnections.get(windowId)).unlinkToDeath();
                interactionConnections.remove(windowId);
                return windowId;
            }
        }
        return WINDOW_ID_UNKNOWN;
    }

    public void registerUiTestAutomationService(IBinder owner, IAccessibilityServiceClient serviceClient, AccessibilityServiceInfo accessibilityServiceInfo) {
        this.mSecurityPolicy.enforceCallingPermission("android.permission.RETRIEVE_WINDOW_CONTENT", FUNCTION_REGISTER_UI_TEST_AUTOMATION_SERVICE);
        accessibilityServiceInfo.setComponentName(sFakeAccessibilityServiceComponentName);
        synchronized (this.mLock) {
            UserState userState = getCurrentUserStateLocked();
            if (userState.mUiAutomationService != null) {
                throw new IllegalStateException("UiAutomationService " + serviceClient + "already registered!");
            }
            try {
                owner.linkToDeath(userState.mUiAutomationSerivceOnwerDeathRecipient, OWN_PROCESS_ID);
                userState.mUiAutomationServiceOwner = owner;
                userState.mUiAutomationServiceClient = serviceClient;
                userState.mIsAccessibilityEnabled = true;
                userState.mIsTouchExplorationEnabled = DEBUG;
                userState.mIsEnhancedWebAccessibilityEnabled = DEBUG;
                userState.mIsDisplayMagnificationEnabled = DEBUG;
                userState.mInstalledServices.add(accessibilityServiceInfo);
                userState.mEnabledServices.clear();
                userState.mEnabledServices.add(sFakeAccessibilityServiceComponentName);
                userState.mTouchExplorationGrantedServices.add(sFakeAccessibilityServiceComponentName);
                onUserStateChangedLocked(userState);
            } catch (RemoteException re) {
                Slog.e(LOG_TAG, "Couldn't register for the death of a UiTestAutomationService!", re);
            }
        }
    }

    public void unregisterUiTestAutomationService(IAccessibilityServiceClient serviceClient) {
        synchronized (this.mLock) {
            UserState userState = getCurrentUserStateLocked();
            if (userState.mUiAutomationService == null || serviceClient == null || userState.mUiAutomationService.mServiceInterface == null || userState.mUiAutomationService.mServiceInterface.asBinder() != serviceClient.asBinder()) {
                throw new IllegalStateException("UiAutomationService " + serviceClient + " not registered!");
            }
            userState.mUiAutomationService.binderDied();
        }
    }

    public void temporaryEnableAccessibilityStateUntilKeyguardRemoved(ComponentName service, boolean touchExplorationEnabled) {
        this.mSecurityPolicy.enforceCallingPermission("android.permission.TEMPORARY_ENABLE_ACCESSIBILITY", TEMPORARY_ENABLE_ACCESSIBILITY_UNTIL_KEYGUARD_REMOVED);
        if (this.mWindowManagerService.isKeyguardLocked()) {
            synchronized (this.mLock) {
                UserState userState = getCurrentUserStateLocked();
                if (userState.mUiAutomationService != null) {
                    return;
                }
                userState.mIsAccessibilityEnabled = true;
                userState.mIsTouchExplorationEnabled = touchExplorationEnabled;
                userState.mIsEnhancedWebAccessibilityEnabled = DEBUG;
                userState.mIsDisplayMagnificationEnabled = DEBUG;
                userState.mEnabledServices.clear();
                userState.mEnabledServices.add(service);
                userState.mBindingServices.clear();
                userState.mTouchExplorationGrantedServices.clear();
                userState.mTouchExplorationGrantedServices.add(service);
                onUserStateChangedLocked(userState);
            }
        }
    }

    public IBinder getWindowToken(int windowId) {
        this.mSecurityPolicy.enforceCallingPermission("android.permission.RETRIEVE_WINDOW_TOKEN", GET_WINDOW_TOKEN);
        synchronized (this.mLock) {
            if (this.mSecurityPolicy.resolveCallingUserIdEnforcingPermissionsLocked(UserHandle.getCallingUserId()) != this.mCurrentUserId) {
                return null;
            } else if (this.mSecurityPolicy.findWindowById(windowId) == null) {
                return null;
            } else {
                IBinder token = (IBinder) this.mGlobalWindowTokens.get(windowId);
                if (token != null) {
                    return token;
                }
                IBinder iBinder = (IBinder) getCurrentUserStateLocked().mWindowTokens.get(windowId);
                return iBinder;
            }
        }
    }

    boolean onGesture(int gestureId) {
        boolean handled;
        synchronized (this.mLock) {
            handled = notifyGestureLocked(gestureId, DEBUG);
            if (!handled) {
                handled = notifyGestureLocked(gestureId, true);
            }
        }
        return handled;
    }

    boolean notifyKeyEvent(KeyEvent event, int policyFlags) {
        boolean handled;
        synchronized (this.mLock) {
            KeyEvent localClone = KeyEvent.obtain(event);
            handled = notifyKeyEventLocked(localClone, policyFlags, DEBUG);
            if (!handled) {
                handled = notifyKeyEventLocked(localClone, policyFlags, true);
            }
        }
        return handled;
    }

    boolean getAccessibilityFocusClickPointInScreen(Point outPoint) {
        return getInteractionBridgeLocked().getAccessibilityFocusClickPointInScreenNotLocked(outPoint);
    }

    boolean getWindowBounds(int windowId, Rect outBounds) {
        IBinder token;
        synchronized (this.mLock) {
            token = (IBinder) this.mGlobalWindowTokens.get(windowId);
            if (token == null) {
                token = (IBinder) getCurrentUserStateLocked().mWindowTokens.get(windowId);
            }
        }
        this.mWindowManagerService.getWindowFrame(token, outBounds);
        if (outBounds.isEmpty()) {
            return DEBUG;
        }
        return true;
    }

    boolean accessibilityFocusOnlyInActiveWindow() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mWindowsForAccessibilityCallback == null ? true : DEBUG;
        }
        return z;
    }

    int getActiveWindowId() {
        return this.mSecurityPolicy.getActiveWindowId();
    }

    void onTouchInteractionStart() {
        this.mSecurityPolicy.onTouchInteractionStart();
    }

    void onTouchInteractionEnd() {
        this.mSecurityPolicy.onTouchInteractionEnd();
    }

    void onMagnificationStateChanged() {
        notifyClearAccessibilityCacheLocked();
    }

    private void switchUser(int userId) {
        boolean announceNewUser = true;
        synchronized (this.mLock) {
            if (this.mCurrentUserId == userId && this.mInitialized) {
                return;
            }
            UserState oldUserState = getCurrentUserStateLocked();
            oldUserState.onSwitchToAnotherUser();
            if (oldUserState.mClients.getRegisteredCallbackCount() > 0) {
                this.mMainHandler.obtainMessage(3, oldUserState.mUserId, OWN_PROCESS_ID).sendToTarget();
            }
            if (((UserManager) this.mContext.getSystemService("user")).getUsers().size() <= 1) {
                announceNewUser = DEBUG;
            }
            this.mCurrentUserId = userId;
            UserState userState = getCurrentUserStateLocked();
            if (userState.mUiAutomationService != null) {
                userState.mUiAutomationService.binderDied();
            }
            readConfigurationForUserStateLocked(userState);
            onUserStateChangedLocked(userState);
            if (announceNewUser) {
                this.mMainHandler.sendEmptyMessageDelayed(5, 3000);
            }
        }
    }

    private void removeUser(int userId) {
        synchronized (this.mLock) {
            this.mUserStates.remove(userId);
        }
    }

    private InteractionBridge getInteractionBridgeLocked() {
        if (this.mInteractionBridge == null) {
            this.mInteractionBridge = new InteractionBridge();
        }
        return this.mInteractionBridge;
    }

    private boolean notifyGestureLocked(int gestureId, boolean isDefault) {
        UserState state = getCurrentUserStateLocked();
        for (int i = state.mBoundServices.size() + WINDOW_ID_UNKNOWN; i >= 0; i += WINDOW_ID_UNKNOWN) {
            Service service = (Service) state.mBoundServices.get(i);
            if (service.mRequestTouchExplorationMode && service.mIsDefault == isDefault) {
                service.notifyGesture(gestureId);
                return true;
            }
        }
        return DEBUG;
    }

    private boolean notifyKeyEventLocked(KeyEvent event, int policyFlags, boolean isDefault) {
        UserState state = getCurrentUserStateLocked();
        for (int i = state.mBoundServices.size() + WINDOW_ID_UNKNOWN; i >= 0; i += WINDOW_ID_UNKNOWN) {
            Service service = (Service) state.mBoundServices.get(i);
            if (service.mRequestFilterKeyEvents && (service.mAccessibilityServiceInfo.getCapabilities() & 8) != 0 && service.mIsDefault == isDefault) {
                service.notifyKeyEvent(event, policyFlags);
                return true;
            }
        }
        return DEBUG;
    }

    private void notifyClearAccessibilityCacheLocked() {
        UserState state = getCurrentUserStateLocked();
        for (int i = state.mBoundServices.size() + WINDOW_ID_UNKNOWN; i >= 0; i += WINDOW_ID_UNKNOWN) {
            ((Service) state.mBoundServices.get(i)).notifyClearAccessibilityNodeInfoCache();
        }
    }

    private void removeAccessibilityInteractionConnectionLocked(int windowId, int userId) {
        if (userId == WINDOW_ID_UNKNOWN) {
            this.mGlobalWindowTokens.remove(windowId);
            this.mGlobalInteractionConnections.remove(windowId);
            return;
        }
        UserState userState = getCurrentUserStateLocked();
        userState.mWindowTokens.remove(windowId);
        userState.mInteractionConnections.remove(windowId);
    }

    private boolean readInstalledAccessibilityServiceLocked(UserState userState) {
        Exception xppe;
        this.mTempAccessibilityServiceInfoList.clear();
        List<ResolveInfo> installedServices = this.mPackageManager.queryIntentServicesAsUser(new Intent("android.accessibilityservice.AccessibilityService"), 132, this.mCurrentUserId);
        int count = installedServices.size();
        for (int i = OWN_PROCESS_ID; i < count; i++) {
            ResolveInfo resolveInfo = (ResolveInfo) installedServices.get(i);
            ServiceInfo serviceInfo = resolveInfo.serviceInfo;
            if ("android.permission.BIND_ACCESSIBILITY_SERVICE".equals(serviceInfo.permission)) {
                try {
                    this.mTempAccessibilityServiceInfoList.add(new AccessibilityServiceInfo(resolveInfo, this.mContext));
                } catch (XmlPullParserException e) {
                    xppe = e;
                    Slog.e(LOG_TAG, "Error while initializing AccessibilityServiceInfo", xppe);
                } catch (IOException e2) {
                    xppe = e2;
                    Slog.e(LOG_TAG, "Error while initializing AccessibilityServiceInfo", xppe);
                }
            } else {
                Slog.w(LOG_TAG, "Skipping accessibilty service " + new ComponentName(serviceInfo.packageName, serviceInfo.name).flattenToShortString() + ": it does not require the permission " + "android.permission.BIND_ACCESSIBILITY_SERVICE");
            }
        }
        if (this.mTempAccessibilityServiceInfoList.equals(userState.mInstalledServices)) {
            this.mTempAccessibilityServiceInfoList.clear();
            return DEBUG;
        }
        userState.mInstalledServices.clear();
        userState.mInstalledServices.addAll(this.mTempAccessibilityServiceInfoList);
        this.mTempAccessibilityServiceInfoList.clear();
        return true;
    }

    private boolean readEnabledAccessibilityServicesLocked(UserState userState) {
        this.mTempComponentNameSet.clear();
        readComponentNamesFromSettingLocked("enabled_accessibility_services", userState.mUserId, this.mTempComponentNameSet);
        if (this.mTempComponentNameSet.equals(userState.mEnabledServices)) {
            this.mTempComponentNameSet.clear();
            return DEBUG;
        }
        userState.mEnabledServices.clear();
        userState.mEnabledServices.addAll(this.mTempComponentNameSet);
        this.mTempComponentNameSet.clear();
        return true;
    }

    private boolean readTouchExplorationGrantedAccessibilityServicesLocked(UserState userState) {
        this.mTempComponentNameSet.clear();
        readComponentNamesFromSettingLocked("touch_exploration_granted_accessibility_services", userState.mUserId, this.mTempComponentNameSet);
        if (this.mTempComponentNameSet.equals(userState.mTouchExplorationGrantedServices)) {
            this.mTempComponentNameSet.clear();
            return DEBUG;
        }
        userState.mTouchExplorationGrantedServices.clear();
        userState.mTouchExplorationGrantedServices.addAll(this.mTempComponentNameSet);
        this.mTempComponentNameSet.clear();
        return true;
    }

    private void notifyAccessibilityServicesDelayedLocked(AccessibilityEvent event, boolean isDefault) {
        try {
            UserState state = getCurrentUserStateLocked();
            int count = state.mBoundServices.size();
            for (int i = OWN_PROCESS_ID; i < count; i++) {
                Service service = (Service) state.mBoundServices.get(i);
                if (service.mIsDefault == isDefault && canDispatchEventToServiceLocked(service, event, state.mHandledFeedbackTypes)) {
                    state.mHandledFeedbackTypes |= service.mFeedbackType;
                    service.notifyAccessibilityEvent(event);
                }
            }
        } catch (IndexOutOfBoundsException e) {
        }
    }

    private void addServiceLocked(Service service, UserState userState) {
        try {
            service.onAdded();
            userState.mBoundServices.add(service);
            userState.mComponentNameToServiceMap.put(service.mComponentName, service);
        } catch (RemoteException e) {
        }
    }

    private void removeServiceLocked(Service service, UserState userState) {
        userState.mBoundServices.remove(service);
        userState.mComponentNameToServiceMap.remove(service.mComponentName);
        service.onRemoved();
    }

    private boolean canDispatchEventToServiceLocked(Service service, AccessibilityEvent event, int handledFeedbackTypes) {
        if (!service.canReceiveEventsLocked()) {
            return DEBUG;
        }
        if (event.getWindowId() != WINDOW_ID_UNKNOWN && !event.isImportantForAccessibility() && (service.mFetchFlags & 8) == 0) {
            return DEBUG;
        }
        int eventType = event.getEventType();
        if ((service.mEventTypes & eventType) != eventType) {
            return DEBUG;
        }
        Set<String> packageNames = service.mPackageNames;
        String packageName = event.getPackageName() != null ? event.getPackageName().toString() : null;
        if (!packageNames.isEmpty() && !packageNames.contains(packageName)) {
            return DEBUG;
        }
        int feedbackType = service.mFeedbackType;
        if ((handledFeedbackTypes & feedbackType) != feedbackType || feedbackType == 16) {
            return true;
        }
        return DEBUG;
    }

    private void unbindAllServicesLocked(UserState userState) {
        List<Service> services = userState.mBoundServices;
        int i = OWN_PROCESS_ID;
        int count = services.size();
        while (i < count) {
            if (((Service) services.get(i)).unbindLocked()) {
                i += WINDOW_ID_UNKNOWN;
                count += WINDOW_ID_UNKNOWN;
            }
            i++;
        }
    }

    private void readComponentNamesFromSettingLocked(String settingName, int userId, Set<ComponentName> outComponentNames) {
        String settingValue = Secure.getStringForUser(this.mContext.getContentResolver(), settingName, userId);
        outComponentNames.clear();
        if (settingValue != null) {
            SimpleStringSplitter splitter = this.mStringColonSplitter;
            splitter.setString(settingValue);
            while (splitter.hasNext()) {
                String str = splitter.next();
                if (str != null && str.length() > 0) {
                    ComponentName enabledService = ComponentName.unflattenFromString(str);
                    if (enabledService != null) {
                        outComponentNames.add(enabledService);
                    }
                }
            }
        }
    }

    private void persistComponentNamesToSettingLocked(String settingName, Set<ComponentName> componentNames, int userId) {
        StringBuilder builder = new StringBuilder();
        for (ComponentName componentName : componentNames) {
            if (builder.length() > 0) {
                builder.append(COMPONENT_NAME_SEPARATOR);
            }
            builder.append(componentName.flattenToShortString());
        }
        Secure.putStringForUser(this.mContext.getContentResolver(), settingName, builder.toString(), userId);
    }

    private void manageServicesLocked(UserState userState) {
        Map<ComponentName, Service> componentNameToServiceMap = userState.mComponentNameToServiceMap;
        boolean isEnabled = userState.mIsAccessibilityEnabled;
        int count = userState.mInstalledServices.size();
        for (int i = OWN_PROCESS_ID; i < count; i++) {
            AccessibilityServiceInfo installedService = (AccessibilityServiceInfo) userState.mInstalledServices.get(i);
            ComponentName componentName = ComponentName.unflattenFromString(installedService.getId());
            Service service = (Service) componentNameToServiceMap.get(componentName);
            if (isEnabled) {
                if (!userState.mBindingServices.contains(componentName)) {
                    if (userState.mEnabledServices.contains(componentName)) {
                        if (service == null) {
                            service = new Service(userState.mUserId, componentName, installedService);
                        } else if (userState.mBoundServices.contains(service)) {
                        }
                        service.bindLocked();
                    } else if (service != null) {
                        service.unbindLocked();
                    }
                }
            } else if (service != null) {
                service.unbindLocked();
            } else {
                userState.mBindingServices.remove(componentName);
            }
        }
        if (isEnabled && userState.mBoundServices.isEmpty() && userState.mBindingServices.isEmpty()) {
            userState.mIsAccessibilityEnabled = DEBUG;
            Secure.putIntForUser(this.mContext.getContentResolver(), "accessibility_enabled", OWN_PROCESS_ID, userState.mUserId);
        }
    }

    private void scheduleUpdateClientsIfNeededLocked(UserState userState) {
        int clientState = userState.getClientState();
        if (userState.mLastSentClientState == clientState) {
            return;
        }
        if (this.mGlobalClients.getRegisteredCallbackCount() > 0 || userState.mClients.getRegisteredCallbackCount() > 0) {
            userState.mLastSentClientState = clientState;
            this.mMainHandler.obtainMessage(2, clientState, userState.mUserId).sendToTarget();
        }
    }

    private void scheduleUpdateInputFilter(UserState userState) {
        this.mMainHandler.obtainMessage(6, userState).sendToTarget();
    }

    private void updateInputFilter(UserState userState) {
        boolean setInputFilter = DEBUG;
        AccessibilityInputFilter inputFilter = null;
        synchronized (this.mLock) {
            int flags = OWN_PROCESS_ID;
            if (userState.mIsDisplayMagnificationEnabled) {
                flags = OWN_PROCESS_ID | 1;
            }
            if (userState.mIsAccessibilityEnabled && userState.mIsTouchExplorationEnabled) {
                flags |= 2;
            }
            if (userState.mIsFilterKeyEventsEnabled) {
                flags |= 4;
            }
            if (flags != 0) {
                if (!this.mHasInputFilter) {
                    this.mHasInputFilter = true;
                    if (this.mInputFilter == null) {
                        this.mInputFilter = new AccessibilityInputFilter(this.mContext, this);
                    }
                    inputFilter = this.mInputFilter;
                    setInputFilter = true;
                }
                this.mInputFilter.setEnabledFeatures(flags);
            } else if (this.mHasInputFilter) {
                this.mHasInputFilter = DEBUG;
                this.mInputFilter.disableFeatures();
                inputFilter = null;
                setInputFilter = true;
            }
        }
        if (setInputFilter) {
            this.mWindowManagerService.setInputFilter(inputFilter);
        }
    }

    private void showEnableTouchExplorationDialog(Service service) {
        synchronized (this.mLock) {
            String label = service.mResolveInfo.loadLabel(this.mContext.getPackageManager()).toString();
            UserState state = getCurrentUserStateLocked();
            if (state.mIsTouchExplorationEnabled) {
            } else if (this.mEnableTouchExplorationDialog == null || !this.mEnableTouchExplorationDialog.isShowing()) {
                this.mEnableTouchExplorationDialog = new Builder(this.mContext).setIconAttribute(16843605).setPositiveButton(17039370, new C01014(state, service)).setNegativeButton(17039360, new C01003()).setTitle(17040468).setMessage(this.mContext.getString(17040469, new Object[]{label})).create();
                this.mEnableTouchExplorationDialog.getWindow().setType(2003);
                LayoutParams attributes = this.mEnableTouchExplorationDialog.getWindow().getAttributes();
                attributes.privateFlags |= 16;
                this.mEnableTouchExplorationDialog.setCanceledOnTouchOutside(true);
                this.mEnableTouchExplorationDialog.show();
            }
        }
    }

    private void onUserStateChangedLocked(UserState userState) {
        this.mInitialized = true;
        updateLegacyCapabilitiesLocked(userState);
        updateServicesLocked(userState);
        updateWindowsForAccessibilityCallbackLocked(userState);
        updateAccessibilityFocusBehaviorLocked(userState);
        updateFilterKeyEventsLocked(userState);
        updateTouchExplorationLocked(userState);
        updateEnhancedWebAccessibilityLocked(userState);
        updateDisplayColorAdjustmentSettingsLocked(userState);
        scheduleUpdateInputFilter(userState);
        scheduleUpdateClientsIfNeededLocked(userState);
    }

    private void updateAccessibilityFocusBehaviorLocked(UserState userState) {
        List<Service> boundServices = userState.mBoundServices;
        int boundServiceCount = boundServices.size();
        for (int i = OWN_PROCESS_ID; i < boundServiceCount; i++) {
            if (((Service) boundServices.get(i)).canRetrieveInteractiveWindowsLocked()) {
                userState.mAccessibilityFocusOnlyInActiveWindow = DEBUG;
                return;
            }
        }
        userState.mAccessibilityFocusOnlyInActiveWindow = true;
    }

    private void updateWindowsForAccessibilityCallbackLocked(UserState userState) {
        if (userState.mIsAccessibilityEnabled) {
            boolean boundServiceCanRetrieveInteractiveWindows = DEBUG;
            List<Service> boundServices = userState.mBoundServices;
            int boundServiceCount = boundServices.size();
            for (int i = OWN_PROCESS_ID; i < boundServiceCount; i++) {
                if (((Service) boundServices.get(i)).canRetrieveInteractiveWindowsLocked()) {
                    boundServiceCanRetrieveInteractiveWindows = true;
                    break;
                }
            }
            if (boundServiceCanRetrieveInteractiveWindows) {
                if (this.mWindowsForAccessibilityCallback == null) {
                    this.mWindowsForAccessibilityCallback = new WindowsForAccessibilityCallback();
                    this.mWindowManagerService.setWindowsForAccessibilityCallback(this.mWindowsForAccessibilityCallback);
                    return;
                }
                return;
            }
        }
        if (this.mWindowsForAccessibilityCallback != null) {
            this.mWindowsForAccessibilityCallback = null;
            this.mWindowManagerService.setWindowsForAccessibilityCallback(null);
            this.mSecurityPolicy.clearWindowsLocked();
        }
    }

    private void updateLegacyCapabilitiesLocked(UserState userState) {
        int installedServiceCount = userState.mInstalledServices.size();
        for (int i = OWN_PROCESS_ID; i < installedServiceCount; i++) {
            AccessibilityServiceInfo serviceInfo = (AccessibilityServiceInfo) userState.mInstalledServices.get(i);
            ResolveInfo resolveInfo = serviceInfo.getResolveInfo();
            if ((serviceInfo.getCapabilities() & 2) == 0 && resolveInfo.serviceInfo.applicationInfo.targetSdkVersion <= 17) {
                if (userState.mTouchExplorationGrantedServices.contains(new ComponentName(resolveInfo.serviceInfo.packageName, resolveInfo.serviceInfo.name))) {
                    serviceInfo.setCapabilities(serviceInfo.getCapabilities() | 2);
                }
            }
        }
    }

    private void updateFilterKeyEventsLocked(UserState userState) {
        int serviceCount = userState.mBoundServices.size();
        int i = OWN_PROCESS_ID;
        while (i < serviceCount) {
            Service service = (Service) userState.mBoundServices.get(i);
            if (!service.mRequestFilterKeyEvents || (service.mAccessibilityServiceInfo.getCapabilities() & 8) == 0) {
                i++;
            } else {
                userState.mIsFilterKeyEventsEnabled = true;
                return;
            }
        }
        userState.mIsFilterKeyEventsEnabled = DEBUG;
    }

    private void updateServicesLocked(UserState userState) {
        if (userState.mIsAccessibilityEnabled) {
            manageServicesLocked(userState);
        } else {
            unbindAllServicesLocked(userState);
        }
    }

    private boolean readConfigurationForUserStateLocked(UserState userState) {
        return (((((((readAccessibilityEnabledSettingLocked(userState) | readInstalledAccessibilityServiceLocked(userState)) | readEnabledAccessibilityServicesLocked(userState)) | readTouchExplorationGrantedAccessibilityServicesLocked(userState)) | readTouchExplorationEnabledSettingLocked(userState)) | readHighTextContrastEnabledSettingLocked(userState)) | readEnhancedWebAccessibilityEnabledChangedLocked(userState)) | readDisplayMagnificationEnabledSettingLocked(userState)) | readDisplayColorAdjustmentSettingsLocked(userState);
    }

    private boolean readAccessibilityEnabledSettingLocked(UserState userState) {
        boolean accessibilityEnabled;
        if (Secure.getIntForUser(this.mContext.getContentResolver(), "accessibility_enabled", OWN_PROCESS_ID, userState.mUserId) == 1) {
            accessibilityEnabled = true;
        } else {
            accessibilityEnabled = DEBUG;
        }
        if (accessibilityEnabled == userState.mIsAccessibilityEnabled) {
            return DEBUG;
        }
        userState.mIsAccessibilityEnabled = accessibilityEnabled;
        return true;
    }

    private boolean readTouchExplorationEnabledSettingLocked(UserState userState) {
        boolean touchExplorationEnabled;
        if (Secure.getIntForUser(this.mContext.getContentResolver(), "touch_exploration_enabled", OWN_PROCESS_ID, userState.mUserId) == 1) {
            touchExplorationEnabled = true;
        } else {
            touchExplorationEnabled = DEBUG;
        }
        if (touchExplorationEnabled == userState.mIsTouchExplorationEnabled) {
            return DEBUG;
        }
        userState.mIsTouchExplorationEnabled = touchExplorationEnabled;
        return true;
    }

    private boolean readDisplayMagnificationEnabledSettingLocked(UserState userState) {
        boolean displayMagnificationEnabled;
        if (Secure.getIntForUser(this.mContext.getContentResolver(), "accessibility_display_magnification_enabled", OWN_PROCESS_ID, userState.mUserId) == 1) {
            displayMagnificationEnabled = true;
        } else {
            displayMagnificationEnabled = DEBUG;
        }
        if (displayMagnificationEnabled == userState.mIsDisplayMagnificationEnabled) {
            return DEBUG;
        }
        userState.mIsDisplayMagnificationEnabled = displayMagnificationEnabled;
        return true;
    }

    private boolean readEnhancedWebAccessibilityEnabledChangedLocked(UserState userState) {
        boolean enhancedWeAccessibilityEnabled;
        if (Secure.getIntForUser(this.mContext.getContentResolver(), "accessibility_script_injection", OWN_PROCESS_ID, userState.mUserId) == 1) {
            enhancedWeAccessibilityEnabled = true;
        } else {
            enhancedWeAccessibilityEnabled = DEBUG;
        }
        if (enhancedWeAccessibilityEnabled == userState.mIsEnhancedWebAccessibilityEnabled) {
            return DEBUG;
        }
        userState.mIsEnhancedWebAccessibilityEnabled = enhancedWeAccessibilityEnabled;
        return true;
    }

    private boolean readDisplayColorAdjustmentSettingsLocked(UserState userState) {
        boolean displayAdjustmentsEnabled = DisplayAdjustmentUtils.hasAdjustments(this.mContext, userState.mUserId);
        if (displayAdjustmentsEnabled == userState.mHasDisplayColorAdjustment) {
            return displayAdjustmentsEnabled;
        }
        userState.mHasDisplayColorAdjustment = displayAdjustmentsEnabled;
        return true;
    }

    private boolean readHighTextContrastEnabledSettingLocked(UserState userState) {
        boolean highTextContrastEnabled;
        if (Secure.getIntForUser(this.mContext.getContentResolver(), "high_text_contrast_enabled", OWN_PROCESS_ID, userState.mUserId) == 1) {
            highTextContrastEnabled = true;
        } else {
            highTextContrastEnabled = DEBUG;
        }
        if (highTextContrastEnabled == userState.mIsTextHighContrastEnabled) {
            return DEBUG;
        }
        userState.mIsTextHighContrastEnabled = highTextContrastEnabled;
        return true;
    }

    private void updateTouchExplorationLocked(UserState userState) {
        boolean enabled = DEBUG;
        int serviceCount = userState.mBoundServices.size();
        for (int i = OWN_PROCESS_ID; i < serviceCount; i++) {
            if (canRequestAndRequestsTouchExplorationLocked((Service) userState.mBoundServices.get(i))) {
                enabled = true;
                break;
            }
        }
        if (enabled != userState.mIsTouchExplorationEnabled) {
            userState.mIsTouchExplorationEnabled = enabled;
            Secure.putIntForUser(this.mContext.getContentResolver(), "touch_exploration_enabled", enabled ? 1 : OWN_PROCESS_ID, userState.mUserId);
        }
    }

    private boolean canRequestAndRequestsTouchExplorationLocked(Service service) {
        if (!service.canReceiveEventsLocked() || !service.mRequestTouchExplorationMode) {
            return DEBUG;
        }
        if (service.mIsAutomation) {
            return true;
        }
        if (service.mResolveInfo.serviceInfo.applicationInfo.targetSdkVersion <= 17) {
            if (getUserStateLocked(service.mUserId).mTouchExplorationGrantedServices.contains(service.mComponentName)) {
                return true;
            }
            if (this.mEnableTouchExplorationDialog == null || !this.mEnableTouchExplorationDialog.isShowing()) {
                this.mMainHandler.obtainMessage(7, service).sendToTarget();
            }
        } else if ((service.mAccessibilityServiceInfo.getCapabilities() & 2) != 0) {
            return true;
        }
        return DEBUG;
    }

    private void updateEnhancedWebAccessibilityLocked(UserState userState) {
        boolean enabled = DEBUG;
        int serviceCount = userState.mBoundServices.size();
        for (int i = OWN_PROCESS_ID; i < serviceCount; i++) {
            if (canRequestAndRequestsEnhancedWebAccessibilityLocked((Service) userState.mBoundServices.get(i))) {
                enabled = true;
                break;
            }
        }
        if (enabled != userState.mIsEnhancedWebAccessibilityEnabled) {
            userState.mIsEnhancedWebAccessibilityEnabled = enabled;
            Secure.putIntForUser(this.mContext.getContentResolver(), "accessibility_script_injection", enabled ? 1 : OWN_PROCESS_ID, userState.mUserId);
        }
    }

    private boolean canRequestAndRequestsEnhancedWebAccessibilityLocked(Service service) {
        if (!service.canReceiveEventsLocked() || !service.mRequestEnhancedWebAccessibility) {
            return DEBUG;
        }
        if (service.mIsAutomation || (service.mAccessibilityServiceInfo.getCapabilities() & 4) != 0) {
            return true;
        }
        return DEBUG;
    }

    private void updateDisplayColorAdjustmentSettingsLocked(UserState userState) {
        DisplayAdjustmentUtils.applyAdjustments(this.mContext, userState.mUserId);
    }

    private boolean hasRunningServicesLocked(UserState userState) {
        return (userState.mBoundServices.isEmpty() && userState.mBindingServices.isEmpty()) ? DEBUG : true;
    }

    private MagnificationSpec getCompatibleMagnificationSpecLocked(int windowId) {
        IBinder windowToken = (IBinder) this.mGlobalWindowTokens.get(windowId);
        if (windowToken == null) {
            windowToken = (IBinder) getCurrentUserStateLocked().mWindowTokens.get(windowId);
        }
        if (windowToken != null) {
            return this.mWindowManagerService.getCompatibleMagnificationSpecForWindow(windowToken);
        }
        return null;
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        this.mSecurityPolicy.enforceCallingPermission("android.permission.DUMP", FUNCTION_DUMP);
        synchronized (this.mLock) {
            pw.println("ACCESSIBILITY MANAGER (dumpsys accessibility)");
            pw.println();
            int userCount = this.mUserStates.size();
            for (int i = OWN_PROCESS_ID; i < userCount; i++) {
                int j;
                UserState userState = (UserState) this.mUserStates.valueAt(i);
                pw.append("User state[attributes:{id=" + userState.mUserId);
                pw.append(", currentUser=" + (userState.mUserId == this.mCurrentUserId ? true : DEBUG));
                pw.append(", accessibilityEnabled=" + userState.mIsAccessibilityEnabled);
                pw.append(", touchExplorationEnabled=" + userState.mIsTouchExplorationEnabled);
                pw.append(", displayMagnificationEnabled=" + userState.mIsDisplayMagnificationEnabled);
                if (userState.mUiAutomationService != null) {
                    pw.append(", ");
                    userState.mUiAutomationService.dump(fd, pw, args);
                    pw.println();
                }
                pw.append("}");
                pw.println();
                pw.append("           services:{");
                int serviceCount = userState.mBoundServices.size();
                for (j = OWN_PROCESS_ID; j < serviceCount; j++) {
                    if (j > 0) {
                        pw.append(", ");
                        pw.println();
                        pw.append("                     ");
                    }
                    ((Service) userState.mBoundServices.get(j)).dump(fd, pw, args);
                }
                pw.println("}]");
                pw.println();
            }
            if (this.mSecurityPolicy.mWindows != null) {
                int windowCount = this.mSecurityPolicy.mWindows.size();
                for (j = OWN_PROCESS_ID; j < windowCount; j++) {
                    if (j > 0) {
                        pw.append(',');
                        pw.println();
                    }
                    pw.append("Window[");
                    pw.append(((AccessibilityWindowInfo) this.mSecurityPolicy.mWindows.get(j)).toString());
                    pw.append(']');
                }
            }
        }
    }

    private PendingEvent obtainPendingEventLocked(KeyEvent event, int policyFlags, int sequence) {
        PendingEvent pendingEvent = (PendingEvent) this.mPendingEventPool.acquire();
        if (pendingEvent == null) {
            pendingEvent = new PendingEvent();
        }
        pendingEvent.event = event;
        pendingEvent.policyFlags = policyFlags;
        pendingEvent.sequence = sequence;
        return pendingEvent;
    }

    private void recyclePendingEventLocked(PendingEvent pendingEvent) {
        pendingEvent.clear();
        this.mPendingEventPool.release(pendingEvent);
    }

    private int findWindowIdLocked(IBinder token) {
        int globalIndex = this.mGlobalWindowTokens.indexOfValue(token);
        if (globalIndex >= 0) {
            return this.mGlobalWindowTokens.keyAt(globalIndex);
        }
        UserState userState = getCurrentUserStateLocked();
        int userIndex = userState.mWindowTokens.indexOfValue(token);
        if (userIndex >= 0) {
            return userState.mWindowTokens.keyAt(userIndex);
        }
        return WINDOW_ID_UNKNOWN;
    }

    private void ensureWindowsAvailableTimed() {
        synchronized (this.mLock) {
            if (this.mSecurityPolicy.mWindows != null) {
                return;
            }
            if (this.mWindowsForAccessibilityCallback == null) {
                onUserStateChangedLocked(getCurrentUserStateLocked());
            }
            if (this.mWindowsForAccessibilityCallback == null) {
                return;
            }
            long startMillis = SystemClock.uptimeMillis();
            while (this.mSecurityPolicy.mWindows == null) {
                long remainMillis = 5000 - (SystemClock.uptimeMillis() - startMillis);
                if (remainMillis <= 0) {
                    return;
                }
                try {
                    this.mLock.wait(remainMillis);
                } catch (InterruptedException e) {
                }
            }
        }
    }
}
