package com.android.internal.policy.impl;

import android.app.ActivityManager;
import android.app.ActivityManagerNative;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.app.Dialog;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.DialogInterface.OnDismissListener;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.UserInfo;
import android.database.ContentObserver;
import android.graphics.drawable.Drawable;
import android.media.AudioManager;
import android.net.ConnectivityManager;
import android.os.Build;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.Handler;
import android.os.IPowerManager.Stub;
import android.os.Message;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.os.UserManager;
import android.os.Vibrator;
import android.provider.Settings.Global;
import android.provider.Settings.System;
import android.service.dreams.IDreamManager;
import android.telephony.PhoneStateListener;
import android.telephony.ServiceState;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.ArraySet;
import android.util.Log;
import android.util.TypedValue;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.WindowManager.LayoutParams;
import android.view.WindowManagerGlobal;
import android.view.WindowManagerPolicy.WindowManagerFuncs;
import android.view.accessibility.AccessibilityEvent;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemLongClickListener;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ImageView.ScaleType;
import android.widget.ListView;
import android.widget.TextView;
import com.android.internal.app.AlertController;
import com.android.internal.app.AlertController.AlertParams;
import com.android.internal.widget.LockPatternUtils;
import java.util.ArrayList;
import java.util.List;

class GlobalActions implements OnDismissListener, OnClickListener {
    private static final int DIALOG_DISMISS_DELAY = 300;
    private static final String GLOBAL_ACTION_KEY_AIRPLANE = "airplane";
    private static final String GLOBAL_ACTION_KEY_BUGREPORT = "bugreport";
    private static final String GLOBAL_ACTION_KEY_LOCKDOWN = "lockdown";
    private static final String GLOBAL_ACTION_KEY_POWER = "power";
    private static final String GLOBAL_ACTION_KEY_REBOOT = "reboot";
    private static final String GLOBAL_ACTION_KEY_SETTINGS = "settings";
    private static final String GLOBAL_ACTION_KEY_SILENT = "silent";
    private static final String GLOBAL_ACTION_KEY_USERS = "users";
    private static final int MESSAGE_DISMISS = 0;
    private static final int MESSAGE_REFRESH = 1;
    private static final int MESSAGE_SHOW = 2;
    private static final boolean SHOW_SILENT_TOGGLE = true;
    private static final String TAG = "GlobalActions";
    private MyAdapter mAdapter;
    private ContentObserver mAirplaneModeObserver;
    private ToggleAction mAirplaneModeOn;
    private State mAirplaneState;
    private final AudioManager mAudioManager;
    private BroadcastReceiver mBroadcastReceiver;
    private final Context mContext;
    private boolean mDeviceProvisioned;
    private GlobalActionsDialog mDialog;
    private final IDreamManager mDreamManager;
    private Handler mHandler;
    private boolean mHasTelephony;
    private boolean mHasVibrator;
    private boolean mIsWaitingForEcmExit;
    private ArrayList<Action> mItems;
    private boolean mKeyguardShowing;
    PhoneStateListener mPhoneStateListener;
    private BroadcastReceiver mRingerModeReceiver;
    private final boolean mShowSilentToggle;
    private Action mSilentModeAction;
    private final WindowManagerFuncs mWindowManagerFuncs;

    /* renamed from: com.android.internal.policy.impl.GlobalActions.10 */
    class AnonymousClass10 extends ContentObserver {
        AnonymousClass10(Handler x0) {
            super(x0);
        }

        public void onChange(boolean selfChange) {
            GlobalActions.this.onAirplaneModeChanged();
        }
    }

    private interface Action {
        View create(Context context, View view, ViewGroup viewGroup, LayoutInflater layoutInflater);

        CharSequence getLabelForAccessibility(Context context);

        boolean isEnabled();

        void onPress();

        boolean showBeforeProvisioning();

        boolean showDuringKeyguard();
    }

    private static abstract class ToggleAction implements Action {
        protected int mDisabledIconResid;
        protected int mDisabledStatusMessageResId;
        protected int mEnabledIconResId;
        protected int mEnabledStatusMessageResId;
        protected int mMessageResId;
        protected State mState;

        enum State {
            Off(false),
            TurningOn(GlobalActions.SHOW_SILENT_TOGGLE),
            TurningOff(GlobalActions.SHOW_SILENT_TOGGLE),
            On(false);
            
            private final boolean inTransition;

            private State(boolean intermediate) {
                this.inTransition = intermediate;
            }

            public boolean inTransition() {
                return this.inTransition;
            }
        }

        abstract void onToggle(boolean z);

        public ToggleAction(int enabledIconResId, int disabledIconResid, int message, int enabledStatusMessageResId, int disabledStatusMessageResId) {
            this.mState = State.Off;
            this.mEnabledIconResId = enabledIconResId;
            this.mDisabledIconResid = disabledIconResid;
            this.mMessageResId = message;
            this.mEnabledStatusMessageResId = enabledStatusMessageResId;
            this.mDisabledStatusMessageResId = disabledStatusMessageResId;
        }

        void willCreate() {
        }

        public CharSequence getLabelForAccessibility(Context context) {
            return context.getString(this.mMessageResId);
        }

        public View create(Context context, View convertView, ViewGroup parent, LayoutInflater inflater) {
            boolean on;
            willCreate();
            View v = inflater.inflate(17367124, parent, false);
            ImageView icon = (ImageView) v.findViewById(16908294);
            TextView messageView = (TextView) v.findViewById(16908299);
            TextView statusView = (TextView) v.findViewById(16909046);
            boolean enabled = isEnabled();
            if (messageView != null) {
                messageView.setText(this.mMessageResId);
                messageView.setEnabled(enabled);
            }
            if (this.mState == State.On || this.mState == State.TurningOn) {
                on = GlobalActions.SHOW_SILENT_TOGGLE;
            } else {
                on = false;
            }
            if (icon != null) {
                icon.setImageDrawable(context.getDrawable(on ? this.mEnabledIconResId : this.mDisabledIconResid));
                icon.setEnabled(enabled);
            }
            if (statusView != null) {
                statusView.setText(on ? this.mEnabledStatusMessageResId : this.mDisabledStatusMessageResId);
                statusView.setVisibility(GlobalActions.MESSAGE_DISMISS);
                statusView.setEnabled(enabled);
            }
            v.setEnabled(enabled);
            return v;
        }

        public final void onPress() {
            if (this.mState.inTransition()) {
                Log.w(GlobalActions.TAG, "shouldn't be able to toggle when in transition");
                return;
            }
            boolean nowOn = this.mState != State.On ? GlobalActions.SHOW_SILENT_TOGGLE : false;
            onToggle(nowOn);
            changeStateFromPress(nowOn);
        }

        public boolean isEnabled() {
            return !this.mState.inTransition() ? GlobalActions.SHOW_SILENT_TOGGLE : false;
        }

        protected void changeStateFromPress(boolean buttonOn) {
            this.mState = buttonOn ? State.On : State.Off;
        }

        public void updateState(State state) {
            this.mState = state;
        }
    }

    /* renamed from: com.android.internal.policy.impl.GlobalActions.1 */
    class C00031 extends ToggleAction {
        C00031(int x0, int x1, int x2, int x3, int x4) {
            super(x0, x1, x2, x3, x4);
        }

        void onToggle(boolean on) {
            if (GlobalActions.this.mHasTelephony && Boolean.parseBoolean(SystemProperties.get("ril.cdma.inecmmode"))) {
                GlobalActions.this.mIsWaitingForEcmExit = GlobalActions.SHOW_SILENT_TOGGLE;
                Intent ecmDialogIntent = new Intent("android.intent.action.ACTION_SHOW_NOTICE_ECM_BLOCK_OTHERS", null);
                ecmDialogIntent.addFlags(268435456);
                GlobalActions.this.mContext.startActivity(ecmDialogIntent);
                return;
            }
            GlobalActions.this.changeAirplaneModeSystemSetting(on);
        }

        protected void changeStateFromPress(boolean buttonOn) {
            if (GlobalActions.this.mHasTelephony && !Boolean.parseBoolean(SystemProperties.get("ril.cdma.inecmmode"))) {
                this.mState = buttonOn ? State.TurningOn : State.TurningOff;
                GlobalActions.this.mAirplaneState = this.mState;
            }
        }

        public boolean showDuringKeyguard() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public boolean showBeforeProvisioning() {
            return false;
        }
    }

    /* renamed from: com.android.internal.policy.impl.GlobalActions.2 */
    class C00042 implements OnItemLongClickListener {
        C00042() {
        }

        public boolean onItemLongClick(AdapterView<?> adapterView, View view, int position, long id) {
            Action action = GlobalActions.this.mAdapter.getItem(position);
            if (action instanceof LongPressAction) {
                return ((LongPressAction) action).onLongPress();
            }
            return false;
        }
    }

    private static abstract class SinglePressAction implements Action {
        private final Drawable mIcon;
        private final int mIconResId;
        private final CharSequence mMessage;
        private final int mMessageResId;

        public abstract void onPress();

        protected SinglePressAction(int iconResId, int messageResId) {
            this.mIconResId = iconResId;
            this.mMessageResId = messageResId;
            this.mMessage = null;
            this.mIcon = null;
        }

        protected SinglePressAction(int iconResId, Drawable icon, CharSequence message) {
            this.mIconResId = iconResId;
            this.mMessageResId = GlobalActions.MESSAGE_DISMISS;
            this.mMessage = message;
            this.mIcon = icon;
        }

        protected SinglePressAction(int iconResId, CharSequence message) {
            this.mIconResId = iconResId;
            this.mMessageResId = GlobalActions.MESSAGE_DISMISS;
            this.mMessage = message;
            this.mIcon = null;
        }

        public boolean isEnabled() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public String getStatus() {
            return null;
        }

        public CharSequence getLabelForAccessibility(Context context) {
            if (this.mMessage != null) {
                return this.mMessage;
            }
            return context.getString(this.mMessageResId);
        }

        public View create(Context context, View convertView, ViewGroup parent, LayoutInflater inflater) {
            View v = inflater.inflate(17367124, parent, false);
            ImageView icon = (ImageView) v.findViewById(16908294);
            TextView messageView = (TextView) v.findViewById(16908299);
            TextView statusView = (TextView) v.findViewById(16909046);
            String status = getStatus();
            if (TextUtils.isEmpty(status)) {
                statusView.setVisibility(8);
            } else {
                statusView.setText(status);
            }
            if (this.mIcon != null) {
                icon.setImageDrawable(this.mIcon);
                icon.setScaleType(ScaleType.CENTER_CROP);
            } else if (this.mIconResId != 0) {
                icon.setImageDrawable(context.getDrawable(this.mIconResId));
            }
            if (this.mMessage != null) {
                messageView.setText(this.mMessage);
            } else {
                messageView.setText(this.mMessageResId);
            }
            return v;
        }
    }

    /* renamed from: com.android.internal.policy.impl.GlobalActions.3 */
    class C00073 extends SinglePressAction {

        /* renamed from: com.android.internal.policy.impl.GlobalActions.3.1 */
        class C00061 implements OnClickListener {

            /* renamed from: com.android.internal.policy.impl.GlobalActions.3.1.1 */
            class C00051 implements Runnable {
                C00051() {
                }

                public void run() {
                    try {
                        ActivityManagerNative.getDefault().requestBugReport();
                    } catch (RemoteException e) {
                    }
                }
            }

            C00061() {
            }

            public void onClick(DialogInterface dialog, int which) {
                if (!ActivityManager.isUserAMonkey()) {
                    GlobalActions.this.mHandler.postDelayed(new C00051(), 500);
                }
            }
        }

        C00073(int x0, int x1) {
            super(x0, x1);
        }

        public void onPress() {
            Builder builder = new Builder(GlobalActions.this.mContext);
            builder.setTitle(17039630);
            builder.setMessage(17039631);
            builder.setNegativeButton(17039360, null);
            builder.setPositiveButton(17040536, new C00061());
            AlertDialog dialog = builder.create();
            dialog.getWindow().setType(2009);
            dialog.show();
        }

        public boolean showDuringKeyguard() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public boolean showBeforeProvisioning() {
            return false;
        }

        public String getStatus() {
            Context access$200 = GlobalActions.this.mContext;
            Object[] objArr = new Object[GlobalActions.MESSAGE_SHOW];
            objArr[GlobalActions.MESSAGE_DISMISS] = VERSION.RELEASE;
            objArr[GlobalActions.MESSAGE_REFRESH] = Build.ID;
            return access$200.getString(17039632, objArr);
        }
    }

    /* renamed from: com.android.internal.policy.impl.GlobalActions.4 */
    class C00084 extends SinglePressAction {
        C00084(int x0, int x1) {
            super(x0, x1);
        }

        public void onPress() {
            Intent intent = new Intent("android.settings.SETTINGS");
            intent.addFlags(335544320);
            GlobalActions.this.mContext.startActivity(intent);
        }

        public boolean showDuringKeyguard() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public boolean showBeforeProvisioning() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }
    }

    /* renamed from: com.android.internal.policy.impl.GlobalActions.5 */
    class C00095 extends SinglePressAction {
        C00095(int x0, int x1) {
            super(x0, x1);
        }

        public void onPress() {
            new LockPatternUtils(GlobalActions.this.mContext).requireCredentialEntry(-1);
            try {
                WindowManagerGlobal.getWindowManagerService().lockNow(null);
            } catch (RemoteException e) {
                Log.e(GlobalActions.TAG, "Error while trying to lock device.", e);
            }
        }

        public boolean showDuringKeyguard() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public boolean showBeforeProvisioning() {
            return false;
        }
    }

    /* renamed from: com.android.internal.policy.impl.GlobalActions.6 */
    class C00106 extends SinglePressAction {
        final /* synthetic */ UserInfo val$user;

        C00106(int x0, Drawable x1, CharSequence x2, UserInfo userInfo) {
            this.val$user = userInfo;
            super(x0, x1, x2);
        }

        public void onPress() {
            try {
                ActivityManagerNative.getDefault().switchUser(this.val$user.id);
            } catch (RemoteException re) {
                Log.e(GlobalActions.TAG, "Couldn't switch user " + re);
            }
        }

        public boolean showDuringKeyguard() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public boolean showBeforeProvisioning() {
            return false;
        }
    }

    /* renamed from: com.android.internal.policy.impl.GlobalActions.7 */
    class C00117 extends BroadcastReceiver {
        C00117() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if ("android.intent.action.CLOSE_SYSTEM_DIALOGS".equals(action) || "android.intent.action.SCREEN_OFF".equals(action)) {
                if (!PhoneWindowManager.SYSTEM_DIALOG_REASON_GLOBAL_ACTIONS.equals(intent.getStringExtra(PhoneWindowManager.SYSTEM_DIALOG_REASON_KEY))) {
                    GlobalActions.this.mHandler.sendEmptyMessage(GlobalActions.MESSAGE_DISMISS);
                }
            } else if ("android.intent.action.EMERGENCY_CALLBACK_MODE_CHANGED".equals(action) && !intent.getBooleanExtra("PHONE_IN_ECM_STATE", false) && GlobalActions.this.mIsWaitingForEcmExit) {
                GlobalActions.this.mIsWaitingForEcmExit = false;
                GlobalActions.this.changeAirplaneModeSystemSetting(GlobalActions.SHOW_SILENT_TOGGLE);
            }
        }
    }

    /* renamed from: com.android.internal.policy.impl.GlobalActions.8 */
    class C00128 extends PhoneStateListener {
        C00128() {
        }

        public void onServiceStateChanged(ServiceState serviceState) {
            if (GlobalActions.this.mHasTelephony) {
                GlobalActions.this.mAirplaneState = serviceState.getState() == 3 ? GlobalActions.SHOW_SILENT_TOGGLE : false ? State.On : State.Off;
                GlobalActions.this.mAirplaneModeOn.updateState(GlobalActions.this.mAirplaneState);
                GlobalActions.this.mAdapter.notifyDataSetChanged();
            }
        }
    }

    /* renamed from: com.android.internal.policy.impl.GlobalActions.9 */
    class C00139 extends BroadcastReceiver {
        C00139() {
        }

        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals("android.media.RINGER_MODE_CHANGED")) {
                GlobalActions.this.mHandler.sendEmptyMessage(GlobalActions.MESSAGE_REFRESH);
            }
        }
    }

    private static final class GlobalActionsDialog extends Dialog implements DialogInterface {
        private final MyAdapter mAdapter;
        private final AlertController mAlert;
        private boolean mCancelOnUp;
        private final Context mContext;
        private EnableAccessibilityController mEnableAccessibilityController;
        private boolean mIntercepted;
        private final int mWindowTouchSlop;

        /* renamed from: com.android.internal.policy.impl.GlobalActions.GlobalActionsDialog.1 */
        class C00141 implements Runnable {
            C00141() {
            }

            public void run() {
                GlobalActionsDialog.this.dismiss();
            }
        }

        public GlobalActionsDialog(Context context, AlertParams params) {
            super(context, getDialogTheme(context));
            this.mContext = context;
            this.mAlert = new AlertController(this.mContext, this, getWindow());
            this.mAdapter = (MyAdapter) params.mAdapter;
            this.mWindowTouchSlop = ViewConfiguration.get(context).getScaledWindowTouchSlop();
            params.apply(this.mAlert);
        }

        private static int getDialogTheme(Context context) {
            TypedValue outValue = new TypedValue();
            context.getTheme().resolveAttribute(16843529, outValue, GlobalActions.SHOW_SILENT_TOGGLE);
            return outValue.resourceId;
        }

        protected void onStart() {
            if (EnableAccessibilityController.canEnableAccessibilityViaGesture(this.mContext)) {
                this.mEnableAccessibilityController = new EnableAccessibilityController(this.mContext, new C00141());
                super.setCanceledOnTouchOutside(false);
            } else {
                this.mEnableAccessibilityController = null;
                super.setCanceledOnTouchOutside(GlobalActions.SHOW_SILENT_TOGGLE);
            }
            super.onStart();
        }

        protected void onStop() {
            if (this.mEnableAccessibilityController != null) {
                this.mEnableAccessibilityController.onDestroy();
            }
            super.onStop();
        }

        public boolean dispatchTouchEvent(MotionEvent event) {
            if (this.mEnableAccessibilityController != null) {
                int action = event.getActionMasked();
                if (action == 0) {
                    View decor = getWindow().getDecorView();
                    int eventX = (int) event.getX();
                    int eventY = (int) event.getY();
                    if (eventX < (-this.mWindowTouchSlop) || eventY < (-this.mWindowTouchSlop) || eventX >= decor.getWidth() + this.mWindowTouchSlop || eventY >= decor.getHeight() + this.mWindowTouchSlop) {
                        this.mCancelOnUp = GlobalActions.SHOW_SILENT_TOGGLE;
                    }
                }
                try {
                    if (this.mIntercepted) {
                        boolean onTouchEvent = this.mEnableAccessibilityController.onTouchEvent(event);
                        if (action != GlobalActions.MESSAGE_REFRESH) {
                            return onTouchEvent;
                        }
                        if (this.mCancelOnUp) {
                            cancel();
                        }
                        this.mCancelOnUp = false;
                        this.mIntercepted = false;
                        return onTouchEvent;
                    }
                    this.mIntercepted = this.mEnableAccessibilityController.onInterceptTouchEvent(event);
                    if (this.mIntercepted) {
                        long now = SystemClock.uptimeMillis();
                        event = MotionEvent.obtain(now, now, 3, 0.0f, 0.0f, GlobalActions.MESSAGE_DISMISS);
                        event.setSource(4098);
                        this.mCancelOnUp = GlobalActions.SHOW_SILENT_TOGGLE;
                    }
                    if (action == GlobalActions.MESSAGE_REFRESH) {
                        if (this.mCancelOnUp) {
                            cancel();
                        }
                        this.mCancelOnUp = false;
                        this.mIntercepted = false;
                    }
                } catch (Throwable th) {
                    if (action == GlobalActions.MESSAGE_REFRESH) {
                        if (this.mCancelOnUp) {
                            cancel();
                        }
                        this.mCancelOnUp = false;
                        this.mIntercepted = false;
                    }
                }
            }
            return super.dispatchTouchEvent(event);
        }

        public ListView getListView() {
            return this.mAlert.getListView();
        }

        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            this.mAlert.installContent();
        }

        public boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent event) {
            if (event.getEventType() == 32) {
                for (int i = GlobalActions.MESSAGE_DISMISS; i < this.mAdapter.getCount(); i += GlobalActions.MESSAGE_REFRESH) {
                    CharSequence label = this.mAdapter.getItem(i).getLabelForAccessibility(getContext());
                    if (label != null) {
                        event.getText().add(label);
                    }
                }
            }
            return super.dispatchPopulateAccessibilityEvent(event);
        }

        public boolean onKeyDown(int keyCode, KeyEvent event) {
            if (this.mAlert.onKeyDown(keyCode, event)) {
                return GlobalActions.SHOW_SILENT_TOGGLE;
            }
            return super.onKeyDown(keyCode, event);
        }

        public boolean onKeyUp(int keyCode, KeyEvent event) {
            if (this.mAlert.onKeyUp(keyCode, event)) {
                return GlobalActions.SHOW_SILENT_TOGGLE;
            }
            return super.onKeyUp(keyCode, event);
        }
    }

    private interface LongPressAction extends Action {
        boolean onLongPress();
    }

    private class MyAdapter extends BaseAdapter {
        private MyAdapter() {
        }

        public int getCount() {
            int count = GlobalActions.MESSAGE_DISMISS;
            for (int i = GlobalActions.MESSAGE_DISMISS; i < GlobalActions.this.mItems.size(); i += GlobalActions.MESSAGE_REFRESH) {
                Action action = (Action) GlobalActions.this.mItems.get(i);
                if ((!GlobalActions.this.mKeyguardShowing || action.showDuringKeyguard()) && (GlobalActions.this.mDeviceProvisioned || action.showBeforeProvisioning())) {
                    count += GlobalActions.MESSAGE_REFRESH;
                }
            }
            return count;
        }

        public boolean isEnabled(int position) {
            return getItem(position).isEnabled();
        }

        public boolean areAllItemsEnabled() {
            return false;
        }

        public Action getItem(int position) {
            int filteredPos = GlobalActions.MESSAGE_DISMISS;
            for (int i = GlobalActions.MESSAGE_DISMISS; i < GlobalActions.this.mItems.size(); i += GlobalActions.MESSAGE_REFRESH) {
                Action action = (Action) GlobalActions.this.mItems.get(i);
                if ((!GlobalActions.this.mKeyguardShowing || action.showDuringKeyguard()) && (GlobalActions.this.mDeviceProvisioned || action.showBeforeProvisioning())) {
                    if (filteredPos == position) {
                        return action;
                    }
                    filteredPos += GlobalActions.MESSAGE_REFRESH;
                }
            }
            throw new IllegalArgumentException("position " + position + " out of range of showable actions" + ", filtered count=" + getCount() + ", keyguardshowing=" + GlobalActions.this.mKeyguardShowing + ", provisioned=" + GlobalActions.this.mDeviceProvisioned);
        }

        public long getItemId(int position) {
            return (long) position;
        }

        public View getView(int position, View convertView, ViewGroup parent) {
            return getItem(position).create(GlobalActions.this.mContext, convertView, parent, LayoutInflater.from(GlobalActions.this.mContext));
        }
    }

    private final class PowerAction extends SinglePressAction implements LongPressAction {
        private PowerAction() {
            super(17301552, 17039627);
        }

        public boolean onLongPress() {
            GlobalActions.this.mWindowManagerFuncs.rebootSafeMode(GlobalActions.SHOW_SILENT_TOGGLE);
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public boolean showDuringKeyguard() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public boolean showBeforeProvisioning() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public void onPress() {
            boolean quickbootEnabled = GlobalActions.SHOW_SILENT_TOGGLE;
            if (System.getInt(GlobalActions.this.mContext.getContentResolver(), "enable_quickboot", GlobalActions.MESSAGE_DISMISS) != GlobalActions.MESSAGE_REFRESH) {
                quickbootEnabled = false;
            }
            if (quickbootEnabled) {
                GlobalActions.this.startQuickBoot();
            } else {
                GlobalActions.this.mWindowManagerFuncs.shutdown(false);
            }
        }
    }

    private final class RebootAction extends SinglePressAction {
        private RebootAction() {
            super(17302393, 17039628);
        }

        public boolean showDuringKeyguard() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public boolean showBeforeProvisioning() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public void onPress() {
            try {
                Stub.asInterface(ServiceManager.getService(GlobalActions.GLOBAL_ACTION_KEY_POWER)).reboot(GlobalActions.SHOW_SILENT_TOGGLE, null, false);
            } catch (RemoteException e) {
                Log.e(GlobalActions.TAG, "PowerManager service died!", e);
            }
        }
    }

    private class SilentModeToggleAction extends ToggleAction {
        public SilentModeToggleAction() {
            super(17302306, 17302305, 17039633, 17039634, 17039635);
        }

        void onToggle(boolean on) {
            if (on) {
                GlobalActions.this.mAudioManager.setRingerMode(GlobalActions.MESSAGE_DISMISS);
            } else {
                GlobalActions.this.mAudioManager.setRingerMode(GlobalActions.MESSAGE_SHOW);
            }
        }

        public boolean showDuringKeyguard() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public boolean showBeforeProvisioning() {
            return false;
        }
    }

    private static class SilentModeTriStateAction implements Action, View.OnClickListener {
        private final int[] ITEM_IDS;
        private final AudioManager mAudioManager;
        private final Context mContext;
        private final Handler mHandler;

        SilentModeTriStateAction(Context context, AudioManager audioManager, Handler handler) {
            this.ITEM_IDS = new int[]{16909047, 16909048, 16909049};
            this.mAudioManager = audioManager;
            this.mHandler = handler;
            this.mContext = context;
        }

        private int ringerModeToIndex(int ringerMode) {
            return ringerMode;
        }

        private int indexToRingerMode(int index) {
            return index;
        }

        public CharSequence getLabelForAccessibility(Context context) {
            return null;
        }

        public View create(Context context, View convertView, ViewGroup parent, LayoutInflater inflater) {
            View v = inflater.inflate(17367125, parent, false);
            int selectedIndex = ringerModeToIndex(this.mAudioManager.getRingerMode());
            for (int i = GlobalActions.MESSAGE_DISMISS; i < 3; i += GlobalActions.MESSAGE_REFRESH) {
                boolean z;
                View itemView = v.findViewById(this.ITEM_IDS[i]);
                if (selectedIndex == i) {
                    z = GlobalActions.SHOW_SILENT_TOGGLE;
                } else {
                    z = false;
                }
                itemView.setSelected(z);
                itemView.setTag(Integer.valueOf(i));
                itemView.setOnClickListener(this);
            }
            return v;
        }

        public void onPress() {
        }

        public boolean showDuringKeyguard() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        public boolean showBeforeProvisioning() {
            return false;
        }

        public boolean isEnabled() {
            return GlobalActions.SHOW_SILENT_TOGGLE;
        }

        void willCreate() {
        }

        public void onClick(View v) {
            if (v.getTag() instanceof Integer) {
                this.mAudioManager.setRingerMode(indexToRingerMode(((Integer) v.getTag()).intValue()));
                this.mHandler.sendEmptyMessageDelayed(GlobalActions.MESSAGE_DISMISS, 300);
            }
        }
    }

    public GlobalActions(Context context, WindowManagerFuncs windowManagerFuncs) {
        boolean z;
        boolean z2 = SHOW_SILENT_TOGGLE;
        this.mKeyguardShowing = false;
        this.mDeviceProvisioned = false;
        this.mAirplaneState = State.Off;
        this.mIsWaitingForEcmExit = false;
        this.mBroadcastReceiver = new C00117();
        this.mPhoneStateListener = new C00128();
        this.mRingerModeReceiver = new C00139();
        this.mAirplaneModeObserver = new AnonymousClass10(new Handler());
        this.mHandler = new Handler() {
            public void handleMessage(Message msg) {
                switch (msg.what) {
                    case GlobalActions.MESSAGE_DISMISS /*0*/:
                        if (GlobalActions.this.mDialog != null) {
                            GlobalActions.this.mDialog.dismiss();
                            GlobalActions.this.mDialog = null;
                        }
                    case GlobalActions.MESSAGE_REFRESH /*1*/:
                        GlobalActions.this.refreshSilentMode();
                        GlobalActions.this.mAdapter.notifyDataSetChanged();
                    case GlobalActions.MESSAGE_SHOW /*2*/:
                        GlobalActions.this.handleShow();
                    default:
                }
            }
        };
        this.mContext = context;
        this.mWindowManagerFuncs = windowManagerFuncs;
        this.mAudioManager = (AudioManager) this.mContext.getSystemService("audio");
        this.mDreamManager = IDreamManager.Stub.asInterface(ServiceManager.getService("dreams"));
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.CLOSE_SYSTEM_DIALOGS");
        filter.addAction("android.intent.action.SCREEN_OFF");
        filter.addAction("android.intent.action.EMERGENCY_CALLBACK_MODE_CHANGED");
        context.registerReceiver(this.mBroadcastReceiver, filter);
        this.mHasTelephony = ((ConnectivityManager) context.getSystemService("connectivity")).isNetworkSupported(MESSAGE_DISMISS);
        ((TelephonyManager) context.getSystemService("phone")).listen(this.mPhoneStateListener, MESSAGE_REFRESH);
        this.mContext.getContentResolver().registerContentObserver(Global.getUriFor("airplane_mode_on"), SHOW_SILENT_TOGGLE, this.mAirplaneModeObserver);
        Vibrator vibrator = (Vibrator) this.mContext.getSystemService("vibrator");
        if (vibrator == null || !vibrator.hasVibrator()) {
            z = false;
        } else {
            z = SHOW_SILENT_TOGGLE;
        }
        this.mHasVibrator = z;
        if (this.mContext.getResources().getBoolean(17956985)) {
            z2 = false;
        }
        this.mShowSilentToggle = z2;
    }

    public void showDialog(boolean keyguardShowing, boolean isDeviceProvisioned) {
        this.mKeyguardShowing = keyguardShowing;
        this.mDeviceProvisioned = isDeviceProvisioned;
        if (this.mDialog != null) {
            this.mDialog.dismiss();
            this.mDialog = null;
            this.mHandler.sendEmptyMessage(MESSAGE_SHOW);
            return;
        }
        handleShow();
    }

    private void awakenIfNecessary() {
        if (this.mDreamManager != null) {
            try {
                if (this.mDreamManager.isDreaming()) {
                    this.mDreamManager.awaken();
                }
            } catch (RemoteException e) {
            }
        }
    }

    private void handleShow() {
        awakenIfNecessary();
        this.mDialog = createDialog();
        prepareDialog();
        if (this.mAdapter.getCount() == MESSAGE_REFRESH && (this.mAdapter.getItem((int) MESSAGE_DISMISS) instanceof SinglePressAction) && !(this.mAdapter.getItem((int) MESSAGE_DISMISS) instanceof LongPressAction)) {
            ((SinglePressAction) this.mAdapter.getItem((int) MESSAGE_DISMISS)).onPress();
            return;
        }
        LayoutParams attrs = this.mDialog.getWindow().getAttributes();
        attrs.setTitle(TAG);
        this.mDialog.getWindow().setAttributes(attrs);
        this.mDialog.show();
        this.mDialog.getWindow().getDecorView().setSystemUiVisibility(65536);
    }

    private GlobalActionsDialog createDialog() {
        if (this.mHasVibrator) {
            this.mSilentModeAction = new SilentModeTriStateAction(this.mContext, this.mAudioManager, this.mHandler);
        } else {
            this.mSilentModeAction = new SilentModeToggleAction();
        }
        this.mAirplaneModeOn = new C00031(17302383, 17302385, 17039636, 17039637, 17039638);
        onAirplaneModeChanged();
        this.mItems = new ArrayList();
        String[] defaultActions = this.mContext.getResources().getStringArray(17236023);
        ArraySet<String> addedKeys = new ArraySet();
        for (int i = MESSAGE_DISMISS; i < defaultActions.length; i += MESSAGE_REFRESH) {
            String actionKey = defaultActions[i];
            if (!addedKeys.contains(actionKey)) {
                if (GLOBAL_ACTION_KEY_POWER.equals(actionKey)) {
                    this.mItems.add(new PowerAction());
                } else if (GLOBAL_ACTION_KEY_REBOOT.equals(actionKey)) {
                    this.mItems.add(new RebootAction());
                } else if (GLOBAL_ACTION_KEY_AIRPLANE.equals(actionKey)) {
                    this.mItems.add(this.mAirplaneModeOn);
                } else if (GLOBAL_ACTION_KEY_BUGREPORT.equals(actionKey)) {
                    if (Global.getInt(this.mContext.getContentResolver(), "bugreport_in_power_menu", MESSAGE_DISMISS) != 0 && isCurrentUserOwner()) {
                        this.mItems.add(getBugReportAction());
                    }
                } else if (GLOBAL_ACTION_KEY_SILENT.equals(actionKey)) {
                    if (this.mShowSilentToggle) {
                        this.mItems.add(this.mSilentModeAction);
                    }
                } else if (GLOBAL_ACTION_KEY_USERS.equals(actionKey)) {
                    if (SystemProperties.getBoolean("fw.power_user_switcher", false)) {
                        addUsersToMenu(this.mItems);
                    }
                } else if (GLOBAL_ACTION_KEY_SETTINGS.equals(actionKey)) {
                    this.mItems.add(getSettingsAction());
                } else if (GLOBAL_ACTION_KEY_LOCKDOWN.equals(actionKey)) {
                    this.mItems.add(getLockdownAction());
                } else {
                    Log.e(TAG, "Invalid global action key " + actionKey);
                }
                addedKeys.add(actionKey);
            }
        }
        this.mAdapter = new MyAdapter();
        AlertParams params = new AlertParams(this.mContext);
        params.mAdapter = this.mAdapter;
        params.mOnClickListener = this;
        params.mForceInverseBackground = SHOW_SILENT_TOGGLE;
        GlobalActionsDialog dialog = new GlobalActionsDialog(this.mContext, params);
        dialog.setCanceledOnTouchOutside(false);
        dialog.getListView().setItemsCanFocus(SHOW_SILENT_TOGGLE);
        dialog.getListView().setLongClickable(SHOW_SILENT_TOGGLE);
        dialog.getListView().setOnItemLongClickListener(new C00042());
        dialog.getWindow().setType(2009);
        dialog.setOnDismissListener(this);
        return dialog;
    }

    private Action getBugReportAction() {
        return new C00073(17302387, 17039630);
    }

    private Action getSettingsAction() {
        return new C00084(17302579, 17039639);
    }

    private Action getLockdownAction() {
        return new C00095(17301551, 17039640);
    }

    private UserInfo getCurrentUser() {
        try {
            return ActivityManagerNative.getDefault().getCurrentUser();
        } catch (RemoteException e) {
            return null;
        }
    }

    private boolean isCurrentUserOwner() {
        UserInfo currentUser = getCurrentUser();
        return (currentUser == null || currentUser.isPrimary()) ? SHOW_SILENT_TOGGLE : false;
    }

    private void addUsersToMenu(ArrayList<Action> items) {
        UserManager um = (UserManager) this.mContext.getSystemService("user");
        if (um.isUserSwitcherEnabled()) {
            List<UserInfo> users = um.getUsers();
            UserInfo currentUser = getCurrentUser();
            for (UserInfo user : users) {
                if (user.supportsSwitchTo()) {
                    String str;
                    boolean isCurrentUser = currentUser == null ? user.id == 0 ? SHOW_SILENT_TOGGLE : false : currentUser.id == user.id ? SHOW_SILENT_TOGGLE : false;
                    Drawable icon = user.iconPath != null ? Drawable.createFromPath(user.iconPath) : null;
                    StringBuilder stringBuilder = new StringBuilder();
                    if (user.name != null) {
                        str = user.name;
                    } else {
                        str = "Primary";
                    }
                    stringBuilder = stringBuilder.append(str);
                    if (isCurrentUser) {
                        str = " \u2714";
                    } else {
                        str = "";
                    }
                    items.add(new C00106(17302477, icon, stringBuilder.append(str).toString(), user));
                }
            }
        }
    }

    private void prepareDialog() {
        refreshSilentMode();
        this.mAirplaneModeOn.updateState(this.mAirplaneState);
        this.mAdapter.notifyDataSetChanged();
        this.mDialog.getWindow().setType(2009);
        if (this.mShowSilentToggle) {
            this.mContext.registerReceiver(this.mRingerModeReceiver, new IntentFilter("android.media.RINGER_MODE_CHANGED"));
        }
    }

    private void refreshSilentMode() {
        if (!this.mHasVibrator) {
            ((ToggleAction) this.mSilentModeAction).updateState(this.mAudioManager.getRingerMode() != MESSAGE_SHOW ? SHOW_SILENT_TOGGLE : false ? State.On : State.Off);
        }
    }

    public void onDismiss(DialogInterface dialog) {
        if (this.mShowSilentToggle) {
            try {
                this.mContext.unregisterReceiver(this.mRingerModeReceiver);
            } catch (IllegalArgumentException ie) {
                Log.w(TAG, ie);
            }
        }
    }

    public void onClick(DialogInterface dialog, int which) {
        if (!(this.mAdapter.getItem(which) instanceof SilentModeTriStateAction)) {
            dialog.dismiss();
        }
        this.mAdapter.getItem(which).onPress();
    }

    private void onAirplaneModeChanged() {
        boolean airplaneModeOn = SHOW_SILENT_TOGGLE;
        if (!this.mHasTelephony) {
            if (Global.getInt(this.mContext.getContentResolver(), "airplane_mode_on", MESSAGE_DISMISS) != MESSAGE_REFRESH) {
                airplaneModeOn = false;
            }
            this.mAirplaneState = airplaneModeOn ? State.On : State.Off;
            this.mAirplaneModeOn.updateState(this.mAirplaneState);
        }
    }

    private void changeAirplaneModeSystemSetting(boolean on) {
        Global.putInt(this.mContext.getContentResolver(), "airplane_mode_on", on ? MESSAGE_REFRESH : MESSAGE_DISMISS);
        Intent intent = new Intent("android.intent.action.AIRPLANE_MODE");
        intent.addFlags(536870912);
        intent.putExtra("state", on);
        this.mContext.sendBroadcastAsUser(intent, UserHandle.ALL);
        if (!this.mHasTelephony) {
            this.mAirplaneState = on ? State.On : State.Off;
        }
    }

    private void startQuickBoot() {
        Intent intent = new Intent("org.codeaurora.action.QUICKBOOT");
        intent.putExtra("mode", MESSAGE_DISMISS);
        try {
            this.mContext.startActivityAsUser(intent, UserHandle.CURRENT);
        } catch (ActivityNotFoundException e) {
        }
    }
}
