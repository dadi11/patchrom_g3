package com.android.server;

import android.app.ActivityManager;
import android.app.AppOpsManager;
import android.bluetooth.IBluetooth;
import android.bluetooth.IBluetoothCallback;
import android.bluetooth.IBluetoothGatt;
import android.bluetooth.IBluetoothHeadset;
import android.bluetooth.IBluetoothManager.Stub;
import android.bluetooth.IBluetoothManagerCallback;
import android.bluetooth.IBluetoothProfileServiceConnection;
import android.bluetooth.IBluetoothStateChangeCallback;
import android.bluetooth.IQBluetooth;
import android.bluetooth.IQBluetoothManagerCallback;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.UserInfo;
import android.os.Binder;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.UserManager;
import android.provider.Settings.Global;
import android.provider.Settings.Secure;
import android.util.Log;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

class BluetoothManagerService extends Stub {
    private static final String ACTION_SERVICE_STATE_CHANGED = "com.android.bluetooth.btservice.action.STATE_CHANGED";
    private static final int ADD_PROXY_DELAY_MS = 100;
    private static final String BLUETOOTH_ADMIN_PERM = "android.permission.BLUETOOTH_ADMIN";
    private static final int BLUETOOTH_OFF = 0;
    private static final int BLUETOOTH_ON_AIRPLANE = 2;
    private static final int BLUETOOTH_ON_BLUETOOTH = 1;
    private static final String BLUETOOTH_PERM = "android.permission.BLUETOOTH";
    private static final boolean DBG = true;
    private static final int ERROR_RESTART_TIME_MS = 3000;
    private static final String EXTRA_ACTION = "action";
    private static final int MAX_ERROR_RESTART_RETRIES = 6;
    private static final int MAX_SAVE_RETRIES = 3;
    private static final int MESSAGE_ADD_PROXY_DELAYED = 400;
    private static final int MESSAGE_BIND_PROFILE_SERVICE = 401;
    private static final int MESSAGE_BLUETOOTH_SERVICE_CONNECTED = 40;
    private static final int MESSAGE_BLUETOOTH_SERVICE_DISCONNECTED = 41;
    private static final int MESSAGE_BLUETOOTH_STATE_CHANGE = 60;
    private static final int MESSAGE_DISABLE = 2;
    private static final int MESSAGE_ENABLE = 1;
    private static final int MESSAGE_GET_NAME_AND_ADDRESS = 200;
    private static final int MESSAGE_REGISTER_ADAPTER = 20;
    private static final int MESSAGE_REGISTER_Q_ADAPTER = 22;
    private static final int MESSAGE_REGISTER_STATE_CHANGE_CALLBACK = 30;
    private static final int MESSAGE_RESTART_BLUETOOTH_SERVICE = 42;
    private static final int MESSAGE_SAVE_NAME_AND_ADDRESS = 201;
    private static final int MESSAGE_TIMEOUT_BIND = 100;
    private static final int MESSAGE_TIMEOUT_UNBIND = 101;
    private static final int MESSAGE_UNREGISTER_ADAPTER = 21;
    private static final int MESSAGE_UNREGISTER_Q_ADAPTER = 23;
    private static final int MESSAGE_UNREGISTER_STATE_CHANGE_CALLBACK = 31;
    private static final int MESSAGE_USER_SWITCHED = 300;
    private static final String SECURE_SETTINGS_BLUETOOTH_ADDRESS = "bluetooth_address";
    private static final String SECURE_SETTINGS_BLUETOOTH_ADDR_VALID = "bluetooth_addr_valid";
    private static final String SECURE_SETTINGS_BLUETOOTH_NAME = "bluetooth_name";
    private static final int SERVICE_IBLUETOOTH = 1;
    private static final int SERVICE_IBLUETOOTHGATT = 2;
    private static final int SERVICE_IBLUETOOTHQ = 3;
    private static final int SERVICE_RESTART_TIME_MS = 200;
    private static final String TAG = "BluetoothManagerService";
    private static final int TIMEOUT_BIND_MS = 3000;
    private static final int TIMEOUT_SAVE_MS = 500;
    private static final int USER_SWITCHED_TIME_MS = 200;
    private static final int WAIT_NORMAL = 10;
    private static final int WAIT_USERSWITCH = 30;
    private String mAddress;
    private boolean mBinding;
    private IBluetooth mBluetooth;
    private final IBluetoothCallback mBluetoothCallback;
    private IBluetoothGatt mBluetoothGatt;
    private final RemoteCallbackList<IBluetoothManagerCallback> mCallbacks;
    private BluetoothServiceConnection mConnection;
    private final ContentResolver mContentResolver;
    private final Context mContext;
    private boolean mEnable;
    private boolean mEnableExternal;
    private int mErrorRecoveryRetryCounter;
    private final BluetoothHandler mHandler;
    private boolean mIsBluetoothServiceConnected;
    private String mName;
    private final Map<Integer, ProfileServiceConnections> mProfileServices;
    private IQBluetooth mQBluetooth;
    private final RemoteCallbackList<IQBluetoothManagerCallback> mQCallbacks;
    private boolean mQuietEnable;
    private boolean mQuietEnableExternal;
    private final BroadcastReceiver mReceiver;
    private int mState;
    private final RemoteCallbackList<IBluetoothStateChangeCallback> mStateChangeCallbacks;
    private final int mSystemUiUid;
    private boolean mUnbinding;

    /* renamed from: com.android.server.BluetoothManagerService.1 */
    class C00171 extends IBluetoothCallback.Stub {
        C00171() {
        }

        public void onBluetoothStateChange(int prevState, int newState) throws RemoteException {
            BluetoothManagerService.this.mHandler.sendMessage(BluetoothManagerService.this.mHandler.obtainMessage(BluetoothManagerService.MESSAGE_BLUETOOTH_STATE_CHANGE, prevState, newState));
        }
    }

    /* renamed from: com.android.server.BluetoothManagerService.2 */
    class C00182 extends BroadcastReceiver {
        C00182() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if ("android.bluetooth.adapter.action.LOCAL_NAME_CHANGED".equals(action)) {
                String newName = intent.getStringExtra("android.bluetooth.adapter.extra.LOCAL_NAME");
                Log.d(BluetoothManagerService.TAG, "Bluetooth Adapter name changed to " + newName);
                if (newName != null) {
                    BluetoothManagerService.this.storeNameAndAddress(newName, null);
                }
            } else if ("android.intent.action.AIRPLANE_MODE".equals(action)) {
                synchronized (BluetoothManagerService.this.mReceiver) {
                    if (BluetoothManagerService.this.isBluetoothPersistedStateOn()) {
                        if (BluetoothManagerService.this.isAirplaneModeOn()) {
                            BluetoothManagerService.this.persistBluetoothSetting(BluetoothManagerService.SERVICE_IBLUETOOTHGATT);
                        } else {
                            BluetoothManagerService.this.persistBluetoothSetting(BluetoothManagerService.SERVICE_IBLUETOOTH);
                        }
                    }
                    if (BluetoothManagerService.this.isAirplaneModeOn()) {
                        BluetoothManagerService.this.sendDisableMsg();
                    } else if (BluetoothManagerService.this.mEnableExternal) {
                        BluetoothManagerService.this.sendEnableMsg(BluetoothManagerService.this.mQuietEnableExternal);
                    }
                }
            } else if ("android.intent.action.USER_SWITCHED".equals(action)) {
                BluetoothManagerService.this.mHandler.sendMessage(BluetoothManagerService.this.mHandler.obtainMessage(BluetoothManagerService.MESSAGE_USER_SWITCHED, intent.getIntExtra("android.intent.extra.user_handle", BluetoothManagerService.BLUETOOTH_OFF), BluetoothManagerService.BLUETOOTH_OFF));
            } else if ("android.intent.action.BOOT_COMPLETED".equals(action)) {
                synchronized (BluetoothManagerService.this.mReceiver) {
                    if (BluetoothManagerService.this.mEnableExternal && BluetoothManagerService.this.isBluetoothPersistedStateOnBluetooth()) {
                        Log.d(BluetoothManagerService.TAG, "Auto-enabling Bluetooth.");
                        BluetoothManagerService.this.sendEnableMsg(BluetoothManagerService.this.mQuietEnableExternal);
                    }
                }
                if (!BluetoothManagerService.this.isNameAndAddressSet()) {
                    Log.d(BluetoothManagerService.TAG, "Retrieving Bluetooth Adapter name and address...");
                    BluetoothManagerService.this.getNameAndAddress();
                }
            }
        }
    }

    private class BluetoothHandler extends Handler {
        public BluetoothHandler(Looper looper) {
            super(looper);
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void handleMessage(android.os.Message r31) {
            /*
            r30 = this;
            r25 = "BluetoothManagerService";
            r26 = new java.lang.StringBuilder;
            r26.<init>();
            r27 = "Message: ";
            r26 = r26.append(r27);
            r0 = r31;
            r0 = r0.what;
            r27 = r0;
            r26 = r26.append(r27);
            r26 = r26.toString();
            android.util.Log.d(r25, r26);
            r0 = r31;
            r0 = r0.what;
            r25 = r0;
            switch(r25) {
                case 1: goto L_0x0319;
                case 2: goto L_0x0377;
                case 20: goto L_0x03e8;
                case 21: goto L_0x046c;
                case 22: goto L_0x042a;
                case 23: goto L_0x04b0;
                case 30: goto L_0x04f4;
                case 31: goto L_0x050d;
                case 40: goto L_0x056c;
                case 41: goto L_0x086a;
                case 42: goto L_0x0a08;
                case 60: goto L_0x07d3;
                case 100: goto L_0x07ac;
                case 101: goto L_0x0a2f;
                case 200: goto L_0x0028;
                case 201: goto L_0x0141;
                case 300: goto L_0x0a56;
                case 400: goto L_0x0526;
                case 401: goto L_0x054e;
                default: goto L_0x0027;
            };
        L_0x0027:
            return;
        L_0x0028:
            r25 = "BluetoothManagerService";
            r26 = "MESSAGE_GET_NAME_AND_ADDRESS";
            android.util.Log.d(r25, r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = r25.mConnection;
            monitor-enter(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ all -> 0x00de }
            if (r25 != 0) goto L_0x00f1;
        L_0x0046:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r25 = r25.mBinding;	 Catch:{ all -> 0x00de }
            if (r25 != 0) goto L_0x00f1;
        L_0x0052:
            r25 = "BluetoothManagerService";
            r27 = "Binding to service to get name and address";
            r0 = r25;
            r1 = r27;
            android.util.Log.d(r0, r1);	 Catch:{ all -> 0x00de }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r25 = r25.mConnection;	 Catch:{ all -> 0x00de }
            r27 = 1;
            r0 = r25;
            r1 = r27;
            r0.setGetNameAddressOnly(r1);	 Catch:{ all -> 0x00de }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x00de }
            r27 = 100;
            r0 = r25;
            r1 = r27;
            r22 = r0.obtainMessage(r1);	 Catch:{ all -> 0x00de }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x00de }
            r28 = 3000; // 0xbb8 float:4.204E-42 double:1.482E-320;
            r0 = r25;
            r1 = r22;
            r2 = r28;
            r0.sendMessageDelayed(r1, r2);	 Catch:{ all -> 0x00de }
            r10 = new android.content.Intent;	 Catch:{ all -> 0x00de }
            r25 = android.bluetooth.IBluetooth.class;
            r25 = r25.getName();	 Catch:{ all -> 0x00de }
            r0 = r25;
            r10.<init>(r0);	 Catch:{ all -> 0x00de }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r27 = r0;
            r27 = r27.mConnection;	 Catch:{ all -> 0x00de }
            r28 = 65;
            r29 = android.os.UserHandle.CURRENT;	 Catch:{ all -> 0x00de }
            r0 = r25;
            r1 = r27;
            r2 = r28;
            r3 = r29;
            r25 = r0.doBind(r10, r1, r2, r3);	 Catch:{ all -> 0x00de }
            if (r25 != 0) goto L_0x00e1;
        L_0x00c8:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x00de }
            r27 = 100;
            r0 = r25;
            r1 = r27;
            r0.removeMessages(r1);	 Catch:{ all -> 0x00de }
        L_0x00db:
            monitor-exit(r26);	 Catch:{ all -> 0x00de }
            goto L_0x0027;
        L_0x00de:
            r25 = move-exception;
            monitor-exit(r26);	 Catch:{ all -> 0x00de }
            throw r25;
        L_0x00e1:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r27 = 1;
            r0 = r25;
            r1 = r27;
            r0.mBinding = r1;	 Catch:{ all -> 0x00de }
            goto L_0x00db;
        L_0x00f1:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x00de }
            r27 = 201; // 0xc9 float:2.82E-43 double:9.93E-322;
            r0 = r25;
            r1 = r27;
            r20 = r0.obtainMessage(r1);	 Catch:{ all -> 0x00de }
            r25 = 0;
            r0 = r25;
            r1 = r20;
            r1.arg1 = r0;	 Catch:{ all -> 0x00de }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ all -> 0x00de }
            if (r25 == 0) goto L_0x012b;
        L_0x0119:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x00de }
            r0 = r25;
            r1 = r20;
            r0.sendMessage(r1);	 Catch:{ all -> 0x00de }
            goto L_0x00db;
        L_0x012b:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x00de }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x00de }
            r28 = 500; // 0x1f4 float:7.0E-43 double:2.47E-321;
            r0 = r25;
            r1 = r20;
            r2 = r28;
            r0.sendMessageDelayed(r1, r2);	 Catch:{ all -> 0x00de }
            goto L_0x00db;
        L_0x0141:
            r23 = 0;
            r25 = "BluetoothManagerService";
            r26 = "MESSAGE_SAVE_NAME_AND_ADDRESS";
            android.util.Log.d(r25, r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = r25.mConnection;
            monitor-enter(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x0248 }
            r25 = r0;
            r25 = r25.mEnable;	 Catch:{ all -> 0x0248 }
            if (r25 != 0) goto L_0x017a;
        L_0x0161:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x0248 }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ all -> 0x0248 }
            if (r25 == 0) goto L_0x017a;
        L_0x016d:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x023a }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ RemoteException -> 0x023a }
            r25.enable();	 Catch:{ RemoteException -> 0x023a }
        L_0x017a:
            monitor-exit(r26);	 Catch:{ all -> 0x0248 }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mBluetooth;
            if (r25 == 0) goto L_0x0196;
        L_0x0187:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 1;
            r27 = 0;
            r28 = 10;
            r25.waitForOnOff(r26, r27, r28);
        L_0x0196:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = r25.mConnection;
            monitor-enter(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x025b }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ all -> 0x025b }
            if (r25 == 0) goto L_0x02f4;
        L_0x01ad:
            r11 = 0;
            r5 = 0;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x024b }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ RemoteException -> 0x024b }
            r11 = r25.getName();	 Catch:{ RemoteException -> 0x024b }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x024b }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ RemoteException -> 0x024b }
            r5 = r25.getAddress();	 Catch:{ RemoteException -> 0x024b }
        L_0x01cb:
            if (r11 == 0) goto L_0x025e;
        L_0x01cd:
            if (r5 == 0) goto L_0x025e;
        L_0x01cf:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x025b }
            r25 = r0;
            r0 = r25;
            r0.storeNameAndAddress(r11, r5);	 Catch:{ all -> 0x025b }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x025b }
            r25 = r0;
            r25 = r25.mConnection;	 Catch:{ all -> 0x025b }
            r25 = r25.isGetNameAddressOnly();	 Catch:{ all -> 0x025b }
            if (r25 == 0) goto L_0x01ec;
        L_0x01ea:
            r23 = 1;
        L_0x01ec:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x025b }
            r25 = r0;
            r25 = r25.mEnable;	 Catch:{ all -> 0x025b }
            if (r25 != 0) goto L_0x0205;
        L_0x01f8:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x02e6 }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ RemoteException -> 0x02e6 }
            r25.disable();	 Catch:{ RemoteException -> 0x02e6 }
        L_0x0205:
            monitor-exit(r26);	 Catch:{ all -> 0x025b }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mEnable;
            if (r25 != 0) goto L_0x022d;
        L_0x0212:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mBluetooth;
            if (r25 == 0) goto L_0x022d;
        L_0x021e:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 0;
            r27 = 1;
            r28 = 10;
            r25.waitForOnOff(r26, r27, r28);
        L_0x022d:
            if (r23 == 0) goto L_0x0027;
        L_0x022f:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25.unbindAndFinish();
            goto L_0x0027;
        L_0x023a:
            r7 = move-exception;
            r25 = "BluetoothManagerService";
            r27 = "Unable to call enable()";
            r0 = r25;
            r1 = r27;
            android.util.Log.e(r0, r1, r7);	 Catch:{ all -> 0x0248 }
            goto L_0x017a;
        L_0x0248:
            r25 = move-exception;
            monitor-exit(r26);	 Catch:{ all -> 0x0248 }
            throw r25;
        L_0x024b:
            r16 = move-exception;
            r25 = "BluetoothManagerService";
            r27 = "";
            r0 = r25;
            r1 = r27;
            r2 = r16;
            android.util.Log.e(r0, r1, r2);	 Catch:{ all -> 0x025b }
            goto L_0x01cb;
        L_0x025b:
            r25 = move-exception;
            monitor-exit(r26);	 Catch:{ all -> 0x025b }
            throw r25;
        L_0x025e:
            r0 = r31;
            r0 = r0.arg1;	 Catch:{ all -> 0x025b }
            r25 = r0;
            r27 = 3;
            r0 = r25;
            r1 = r27;
            if (r0 >= r1) goto L_0x02c7;
        L_0x026c:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x025b }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x025b }
            r27 = 201; // 0xc9 float:2.82E-43 double:9.93E-322;
            r0 = r25;
            r1 = r27;
            r19 = r0.obtainMessage(r1);	 Catch:{ all -> 0x025b }
            r0 = r31;
            r0 = r0.arg1;	 Catch:{ all -> 0x025b }
            r25 = r0;
            r25 = r25 + 1;
            r0 = r25;
            r1 = r19;
            r1.arg1 = r0;	 Catch:{ all -> 0x025b }
            r25 = "BluetoothManagerService";
            r27 = new java.lang.StringBuilder;	 Catch:{ all -> 0x025b }
            r27.<init>();	 Catch:{ all -> 0x025b }
            r28 = "Retrying name/address remote retrieval and save.....Retry count =";
            r27 = r27.append(r28);	 Catch:{ all -> 0x025b }
            r0 = r19;
            r0 = r0.arg1;	 Catch:{ all -> 0x025b }
            r28 = r0;
            r27 = r27.append(r28);	 Catch:{ all -> 0x025b }
            r27 = r27.toString();	 Catch:{ all -> 0x025b }
            r0 = r25;
            r1 = r27;
            android.util.Log.d(r0, r1);	 Catch:{ all -> 0x025b }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x025b }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x025b }
            r28 = 500; // 0x1f4 float:7.0E-43 double:2.47E-321;
            r0 = r25;
            r1 = r19;
            r2 = r28;
            r0.sendMessageDelayed(r1, r2);	 Catch:{ all -> 0x025b }
            goto L_0x01ec;
        L_0x02c7:
            r25 = "BluetoothManagerService";
            r27 = "Maximum name/address remote retrieval retry exceeded";
            r0 = r25;
            r1 = r27;
            android.util.Log.w(r0, r1);	 Catch:{ all -> 0x025b }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x025b }
            r25 = r0;
            r25 = r25.mConnection;	 Catch:{ all -> 0x025b }
            r25 = r25.isGetNameAddressOnly();	 Catch:{ all -> 0x025b }
            if (r25 == 0) goto L_0x01ec;
        L_0x02e2:
            r23 = 1;
            goto L_0x01ec;
        L_0x02e6:
            r7 = move-exception;
            r25 = "BluetoothManagerService";
            r27 = "Unable to call disable()";
            r0 = r25;
            r1 = r27;
            android.util.Log.e(r0, r1, r7);	 Catch:{ all -> 0x025b }
            goto L_0x0205;
        L_0x02f4:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x025b }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x025b }
            r27 = 200; // 0xc8 float:2.8E-43 double:9.9E-322;
            r0 = r25;
            r1 = r27;
            r9 = r0.obtainMessage(r1);	 Catch:{ all -> 0x025b }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x025b }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x025b }
            r0 = r25;
            r0.sendMessage(r9);	 Catch:{ all -> 0x025b }
            goto L_0x0205;
        L_0x0319:
            r25 = "BluetoothManagerService";
            r26 = new java.lang.StringBuilder;
            r26.<init>();
            r27 = "MESSAGE_ENABLE: mBluetooth = ";
            r26 = r26.append(r27);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r27 = r0;
            r27 = r27.mBluetooth;
            r26 = r26.append(r27);
            r26 = r26.toString();
            android.util.Log.d(r25, r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mHandler;
            r26 = 42;
            r25.removeMessages(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 1;
            r25.mEnable = r26;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r26 = r0;
            r0 = r31;
            r0 = r0.arg1;
            r25 = r0;
            r27 = 1;
            r0 = r25;
            r1 = r27;
            if (r0 != r1) goto L_0x0374;
        L_0x0369:
            r25 = 1;
        L_0x036b:
            r0 = r26;
            r1 = r25;
            r0.handleEnable(r1);
            goto L_0x0027;
        L_0x0374:
            r25 = 0;
            goto L_0x036b;
        L_0x0377:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mHandler;
            r26 = 42;
            r25.removeMessages(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mEnable;
            if (r25 == 0) goto L_0x03d2;
        L_0x0392:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mBluetooth;
            if (r25 == 0) goto L_0x03d2;
        L_0x039e:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 1;
            r27 = 0;
            r28 = 10;
            r25.waitForOnOff(r26, r27, r28);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 0;
            r25.mEnable = r26;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25.handleDisable();
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 0;
            r27 = 0;
            r28 = 10;
            r25.waitForOnOff(r26, r27, r28);
            goto L_0x0027;
        L_0x03d2:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 0;
            r25.mEnable = r26;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25.handleDisable();
            goto L_0x0027;
        L_0x03e8:
            r0 = r31;
            r6 = r0.obj;
            r6 = (android.bluetooth.IBluetoothManagerCallback) r6;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mCallbacks;
            r0 = r25;
            r4 = r0.register(r6);
            r25 = "BluetoothManagerService";
            r26 = new java.lang.StringBuilder;
            r26.<init>();
            r27 = "Added callback: ";
            r26 = r26.append(r27);
            if (r6 != 0) goto L_0x040f;
        L_0x040d:
            r6 = "null";
        L_0x040f:
            r0 = r26;
            r26 = r0.append(r6);
            r27 = ":";
            r26 = r26.append(r27);
            r0 = r26;
            r26 = r0.append(r4);
            r26 = r26.toString();
            android.util.Log.d(r25, r26);
            goto L_0x0027;
        L_0x042a:
            r0 = r31;
            r6 = r0.obj;
            r6 = (android.bluetooth.IQBluetoothManagerCallback) r6;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mQCallbacks;
            r0 = r25;
            r4 = r0.register(r6);
            r25 = "BluetoothManagerService";
            r26 = new java.lang.StringBuilder;
            r26.<init>();
            r27 = "Q Added callback: ";
            r26 = r26.append(r27);
            if (r6 != 0) goto L_0x0451;
        L_0x044f:
            r6 = "null";
        L_0x0451:
            r0 = r26;
            r26 = r0.append(r6);
            r27 = ":";
            r26 = r26.append(r27);
            r0 = r26;
            r26 = r0.append(r4);
            r26 = r26.toString();
            android.util.Log.d(r25, r26);
            goto L_0x0027;
        L_0x046c:
            r0 = r31;
            r6 = r0.obj;
            r6 = (android.bluetooth.IBluetoothManagerCallback) r6;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mCallbacks;
            r0 = r25;
            r17 = r0.unregister(r6);
            r25 = "BluetoothManagerService";
            r26 = new java.lang.StringBuilder;
            r26.<init>();
            r27 = "Removed callback: ";
            r26 = r26.append(r27);
            if (r6 != 0) goto L_0x0493;
        L_0x0491:
            r6 = "null";
        L_0x0493:
            r0 = r26;
            r26 = r0.append(r6);
            r27 = ":";
            r26 = r26.append(r27);
            r0 = r26;
            r1 = r17;
            r26 = r0.append(r1);
            r26 = r26.toString();
            android.util.Log.d(r25, r26);
            goto L_0x0027;
        L_0x04b0:
            r0 = r31;
            r6 = r0.obj;
            r6 = (android.bluetooth.IQBluetoothManagerCallback) r6;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mQCallbacks;
            r0 = r25;
            r17 = r0.unregister(r6);
            r25 = "BluetoothManagerService";
            r26 = new java.lang.StringBuilder;
            r26.<init>();
            r27 = "Q Removed callback: ";
            r26 = r26.append(r27);
            if (r6 != 0) goto L_0x04d7;
        L_0x04d5:
            r6 = "null";
        L_0x04d7:
            r0 = r26;
            r26 = r0.append(r6);
            r27 = ":";
            r26 = r26.append(r27);
            r0 = r26;
            r1 = r17;
            r26 = r0.append(r1);
            r26 = r26.toString();
            android.util.Log.d(r25, r26);
            goto L_0x0027;
        L_0x04f4:
            r0 = r31;
            r6 = r0.obj;
            r6 = (android.bluetooth.IBluetoothStateChangeCallback) r6;
            if (r6 == 0) goto L_0x0027;
        L_0x04fc:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mStateChangeCallbacks;
            r0 = r25;
            r0.register(r6);
            goto L_0x0027;
        L_0x050d:
            r0 = r31;
            r6 = r0.obj;
            r6 = (android.bluetooth.IBluetoothStateChangeCallback) r6;
            if (r6 == 0) goto L_0x0027;
        L_0x0515:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mStateChangeCallbacks;
            r0 = r25;
            r0.unregister(r6);
            goto L_0x0027;
        L_0x0526:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mProfileServices;
            r26 = new java.lang.Integer;
            r0 = r31;
            r0 = r0.arg1;
            r27 = r0;
            r26.<init>(r27);
            r15 = r25.get(r26);
            r15 = (com.android.server.BluetoothManagerService.ProfileServiceConnections) r15;
            if (r15 == 0) goto L_0x0027;
        L_0x0543:
            r0 = r31;
            r14 = r0.obj;
            r14 = (android.bluetooth.IBluetoothProfileServiceConnection) r14;
            r15.addProxy(r14);
            goto L_0x0027;
        L_0x054e:
            r0 = r31;
            r15 = r0.obj;
            r15 = (com.android.server.BluetoothManagerService.ProfileServiceConnections) r15;
            r25 = 401; // 0x191 float:5.62E-43 double:1.98E-321;
            r0 = r31;
            r0 = r0.obj;
            r26 = r0;
            r0 = r30;
            r1 = r25;
            r2 = r26;
            r0.removeMessages(r1, r2);
            if (r15 == 0) goto L_0x0027;
        L_0x0567:
            r15.bindService();
            goto L_0x0027;
        L_0x056c:
            r25 = "BluetoothManagerService";
            r26 = new java.lang.StringBuilder;
            r26.<init>();
            r27 = "MESSAGE_BLUETOOTH_SERVICE_CONNECTED: ";
            r26 = r26.append(r27);
            r0 = r31;
            r0 = r0.arg1;
            r27 = r0;
            r26 = r26.append(r27);
            r26 = r26.toString();
            android.util.Log.d(r25, r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 1;
            r25.mIsBluetoothServiceConnected = r26;
            r0 = r31;
            r0 = r0.obj;
            r21 = r0;
            r21 = (android.os.IBinder) r21;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = r25.mConnection;
            monitor-enter(r26);
            r0 = r31;
            r0 = r0.arg1;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r27 = 2;
            r0 = r25;
            r1 = r27;
            if (r0 != r1) goto L_0x05cd;
        L_0x05b6:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r27 = android.bluetooth.IBluetoothGatt.Stub.asInterface(r21);	 Catch:{ all -> 0x05ca }
            r0 = r25;
            r1 = r27;
            r0.mBluetoothGatt = r1;	 Catch:{ all -> 0x05ca }
            monitor-exit(r26);	 Catch:{ all -> 0x05ca }
            goto L_0x0027;
        L_0x05ca:
            r25 = move-exception;
            monitor-exit(r26);	 Catch:{ all -> 0x05ca }
            throw r25;
        L_0x05cd:
            r0 = r31;
            r0 = r0.arg1;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r27 = 3;
            r0 = r25;
            r1 = r27;
            if (r0 != r1) goto L_0x061e;
        L_0x05db:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r27 = android.bluetooth.IQBluetooth.Stub.asInterface(r21);	 Catch:{ all -> 0x05ca }
            r0 = r25;
            r1 = r27;
            r0.mQBluetooth = r1;	 Catch:{ all -> 0x05ca }
            r25 = "BluetoothManagerService";
            r27 = new java.lang.StringBuilder;	 Catch:{ all -> 0x05ca }
            r27.<init>();	 Catch:{ all -> 0x05ca }
            r28 = "mQBluetooth: ";
            r27 = r27.append(r28);	 Catch:{ all -> 0x05ca }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r28 = r0;
            r28 = r28.mQBluetooth;	 Catch:{ all -> 0x05ca }
            r27 = r27.append(r28);	 Catch:{ all -> 0x05ca }
            r27 = r27.toString();	 Catch:{ all -> 0x05ca }
            r0 = r25;
            r1 = r27;
            android.util.Log.d(r0, r1);	 Catch:{ all -> 0x05ca }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r25.sendQBluetoothServiceUpCallback();	 Catch:{ all -> 0x05ca }
            monitor-exit(r26);	 Catch:{ all -> 0x05ca }
            goto L_0x0027;
        L_0x061e:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x05ca }
            r27 = 100;
            r0 = r25;
            r1 = r27;
            r0.removeMessages(r1);	 Catch:{ all -> 0x05ca }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r27 = 0;
            r0 = r25;
            r1 = r27;
            r0.mBinding = r1;	 Catch:{ all -> 0x05ca }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r27 = android.bluetooth.IBluetooth.Stub.asInterface(r21);	 Catch:{ all -> 0x05ca }
            r0 = r25;
            r1 = r27;
            r0.mBluetooth = r1;	 Catch:{ all -> 0x05ca }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x06d3 }
            r25 = r0;
            r25 = r25.mContentResolver;	 Catch:{ RemoteException -> 0x06d3 }
            r27 = "bluetooth_hci_log";
            r28 = 0;
            r0 = r25;
            r1 = r27;
            r2 = r28;
            r25 = android.provider.Settings.Secure.getInt(r0, r1, r2);	 Catch:{ RemoteException -> 0x06d3 }
            r27 = 1;
            r0 = r25;
            r1 = r27;
            if (r0 != r1) goto L_0x06d1;
        L_0x0671:
            r8 = 1;
        L_0x0672:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x06d3 }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ RemoteException -> 0x06d3 }
            r0 = r25;
            r25 = r0.configHciSnoopLog(r8);	 Catch:{ RemoteException -> 0x06d3 }
            if (r25 != 0) goto L_0x068f;
        L_0x0684:
            r25 = "BluetoothManagerService";
            r27 = "IBluetooth.configHciSnoopLog return false";
            r0 = r25;
            r1 = r27;
            android.util.Log.e(r0, r1);	 Catch:{ RemoteException -> 0x06d3 }
        L_0x068f:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r25 = r25.mConnection;	 Catch:{ all -> 0x05ca }
            r25 = r25.isGetNameAddressOnly();	 Catch:{ all -> 0x05ca }
            if (r25 == 0) goto L_0x06e0;
        L_0x069f:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x05ca }
            r27 = 200; // 0xc8 float:2.8E-43 double:9.9E-322;
            r0 = r25;
            r1 = r27;
            r9 = r0.obtainMessage(r1);	 Catch:{ all -> 0x05ca }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r25 = r25.mHandler;	 Catch:{ all -> 0x05ca }
            r0 = r25;
            r0.sendMessage(r9);	 Catch:{ all -> 0x05ca }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r25 = r25.mEnable;	 Catch:{ all -> 0x05ca }
            if (r25 != 0) goto L_0x06e0;
        L_0x06ce:
            monitor-exit(r26);	 Catch:{ all -> 0x05ca }
            goto L_0x0027;
        L_0x06d1:
            r8 = 0;
            goto L_0x0672;
        L_0x06d3:
            r7 = move-exception;
            r25 = "BluetoothManagerService";
            r27 = "Unable to call configHciSnoopLog";
            r0 = r25;
            r1 = r27;
            android.util.Log.e(r0, r1, r7);	 Catch:{ all -> 0x05ca }
            goto L_0x068f;
        L_0x06e0:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r25 = r25.mConnection;	 Catch:{ all -> 0x05ca }
            r27 = 0;
            r0 = r25;
            r1 = r27;
            r0.setGetNameAddressOnly(r1);	 Catch:{ all -> 0x05ca }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x0774 }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ RemoteException -> 0x0774 }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x0774 }
            r27 = r0;
            r27 = r27.mBluetoothCallback;	 Catch:{ RemoteException -> 0x0774 }
            r0 = r25;
            r1 = r27;
            r0.registerCallback(r1);	 Catch:{ RemoteException -> 0x0774 }
        L_0x070e:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x05ca }
            r25 = r0;
            r25.sendBluetoothServiceUpCallback();	 Catch:{ all -> 0x05ca }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x079f }
            r25 = r0;
            r25 = r25.mQuietEnable;	 Catch:{ RemoteException -> 0x079f }
            if (r25 != 0) goto L_0x0783;
        L_0x0723:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x079f }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ RemoteException -> 0x079f }
            r25 = r25.enable();	 Catch:{ RemoteException -> 0x079f }
            if (r25 != 0) goto L_0x073e;
        L_0x0733:
            r25 = "BluetoothManagerService";
            r27 = "IBluetooth.enable() returned false";
            r0 = r25;
            r1 = r27;
            android.util.Log.e(r0, r1);	 Catch:{ RemoteException -> 0x079f }
        L_0x073e:
            monitor-exit(r26);	 Catch:{ all -> 0x05ca }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mEnable;
            if (r25 != 0) goto L_0x0027;
        L_0x074b:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 1;
            r27 = 0;
            r28 = 10;
            r25.waitForOnOff(r26, r27, r28);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25.handleDisable();
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 0;
            r27 = 0;
            r28 = 10;
            r25.waitForOnOff(r26, r27, r28);
            goto L_0x0027;
        L_0x0774:
            r16 = move-exception;
            r25 = "BluetoothManagerService";
            r27 = "Unable to register BluetoothCallback";
            r0 = r25;
            r1 = r27;
            r2 = r16;
            android.util.Log.e(r0, r1, r2);	 Catch:{ all -> 0x05ca }
            goto L_0x070e;
        L_0x0783:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x079f }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ RemoteException -> 0x079f }
            r25 = r25.enableNoAutoConnect();	 Catch:{ RemoteException -> 0x079f }
            if (r25 != 0) goto L_0x073e;
        L_0x0793:
            r25 = "BluetoothManagerService";
            r27 = "IBluetooth.enableNoAutoConnect() returned false";
            r0 = r25;
            r1 = r27;
            android.util.Log.e(r0, r1);	 Catch:{ RemoteException -> 0x079f }
            goto L_0x073e;
        L_0x079f:
            r7 = move-exception;
            r25 = "BluetoothManagerService";
            r27 = "Unable to call enable()";
            r0 = r25;
            r1 = r27;
            android.util.Log.e(r0, r1, r7);	 Catch:{ all -> 0x05ca }
            goto L_0x073e;
        L_0x07ac:
            r25 = "BluetoothManagerService";
            r26 = "MESSAGE_TIMEOUT_BIND";
            android.util.Log.e(r25, r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = r25.mConnection;
            monitor-enter(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x07d0 }
            r25 = r0;
            r27 = 0;
            r0 = r25;
            r1 = r27;
            r0.mBinding = r1;	 Catch:{ all -> 0x07d0 }
            monitor-exit(r26);	 Catch:{ all -> 0x07d0 }
            goto L_0x0027;
        L_0x07d0:
            r25 = move-exception;
            monitor-exit(r26);	 Catch:{ all -> 0x07d0 }
            throw r25;
        L_0x07d3:
            r0 = r31;
            r13 = r0.arg1;
            r0 = r31;
            r12 = r0.arg2;
            r25 = "BluetoothManagerService";
            r26 = new java.lang.StringBuilder;
            r26.<init>();
            r27 = "MESSAGE_BLUETOOTH_STATE_CHANGE: prevState = ";
            r26 = r26.append(r27);
            r0 = r26;
            r26 = r0.append(r13);
            r27 = ", newState=";
            r26 = r26.append(r27);
            r0 = r26;
            r26 = r0.append(r12);
            r26 = r26.toString();
            android.util.Log.d(r25, r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r0 = r25;
            r0.mState = r12;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r0 = r25;
            r0.bluetoothStateChangeHandler(r13, r12);
            r25 = 11;
            r0 = r25;
            if (r13 != r0) goto L_0x0844;
        L_0x081d:
            r25 = 10;
            r0 = r25;
            if (r12 != r0) goto L_0x0844;
        L_0x0823:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mBluetooth;
            if (r25 == 0) goto L_0x0844;
        L_0x082f:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mEnable;
            if (r25 == 0) goto L_0x0844;
        L_0x083b:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25.recoverBluetoothServiceFromError();
        L_0x0844:
            r25 = 12;
            r0 = r25;
            if (r12 != r0) goto L_0x0027;
        L_0x084a:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mErrorRecoveryRetryCounter;
            if (r25 == 0) goto L_0x0027;
        L_0x0856:
            r25 = "BluetoothManagerService";
            r26 = "bluetooth is recovered from error";
            android.util.Log.w(r25, r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 0;
            r25.mErrorRecoveryRetryCounter = r26;
            goto L_0x0027;
        L_0x086a:
            r25 = "BluetoothManagerService";
            r26 = new java.lang.StringBuilder;
            r26.<init>();
            r27 = "MESSAGE_BLUETOOTH_SERVICE_DISCONNECTED: ";
            r26 = r26.append(r27);
            r0 = r31;
            r0 = r0.arg1;
            r27 = r0;
            r26 = r26.append(r27);
            r26 = r26.toString();
            android.util.Log.e(r25, r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 0;
            r25.mIsBluetoothServiceConnected = r26;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = r25.mConnection;
            monitor-enter(r26);
            r0 = r31;
            r0 = r0.arg1;	 Catch:{ all -> 0x08bb }
            r25 = r0;
            r27 = 1;
            r0 = r25;
            r1 = r27;
            if (r0 != r1) goto L_0x09a3;
        L_0x08ac:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x08bb }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ all -> 0x08bb }
            if (r25 != 0) goto L_0x08be;
        L_0x08b8:
            monitor-exit(r26);	 Catch:{ all -> 0x08bb }
            goto L_0x0027;
        L_0x08bb:
            r25 = move-exception;
            monitor-exit(r26);	 Catch:{ all -> 0x08bb }
            throw r25;
        L_0x08be:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x08bb }
            r25 = r0;
            r27 = 0;
            r0 = r25;
            r1 = r27;
            r0.mBluetooth = r1;	 Catch:{ all -> 0x08bb }
            monitor-exit(r26);	 Catch:{ all -> 0x08bb }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mEnable;
            if (r25 == 0) goto L_0x090a;
        L_0x08da:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 0;
            r25.mEnable = r26;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mHandler;
            r26 = 42;
            r18 = r25.obtainMessage(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mHandler;
            r26 = 200; // 0xc8 float:2.8E-43 double:9.9E-322;
            r0 = r25;
            r1 = r18;
            r2 = r26;
            r0.sendMessageDelayed(r1, r2);
        L_0x090a:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mConnection;
            r25 = r25.isGetNameAddressOnly();
            if (r25 != 0) goto L_0x0027;
        L_0x091a:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25.sendBluetoothServiceDownCallback();
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25.sendQBluetoothServiceDownCallback();
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mState;
            r26 = 11;
            r0 = r25;
            r1 = r26;
            if (r0 == r1) goto L_0x0950;
        L_0x093e:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mState;
            r26 = 12;
            r0 = r25;
            r1 = r26;
            if (r0 != r1) goto L_0x0968;
        L_0x0950:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 12;
            r27 = 13;
            r25.bluetoothStateChangeHandler(r26, r27);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 13;
            r25.mState = r26;
        L_0x0968:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mState;
            r26 = 13;
            r0 = r25;
            r1 = r26;
            if (r0 != r1) goto L_0x0987;
        L_0x097a:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 13;
            r27 = 10;
            r25.bluetoothStateChangeHandler(r26, r27);
        L_0x0987:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mHandler;
            r26 = 60;
            r25.removeMessages(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 10;
            r25.mState = r26;
            goto L_0x0027;
        L_0x09a3:
            r0 = r31;
            r0 = r0.arg1;	 Catch:{ all -> 0x08bb }
            r25 = r0;
            r27 = 2;
            r0 = r25;
            r1 = r27;
            if (r0 != r1) goto L_0x09c3;
        L_0x09b1:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x08bb }
            r25 = r0;
            r27 = 0;
            r0 = r25;
            r1 = r27;
            r0.mBluetoothGatt = r1;	 Catch:{ all -> 0x08bb }
            monitor-exit(r26);	 Catch:{ all -> 0x08bb }
            goto L_0x0027;
        L_0x09c3:
            r0 = r31;
            r0 = r0.arg1;	 Catch:{ all -> 0x08bb }
            r25 = r0;
            r27 = 3;
            r0 = r25;
            r1 = r27;
            if (r0 != r1) goto L_0x09e3;
        L_0x09d1:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x08bb }
            r25 = r0;
            r27 = 0;
            r0 = r25;
            r1 = r27;
            r0.mQBluetooth = r1;	 Catch:{ all -> 0x08bb }
            monitor-exit(r26);	 Catch:{ all -> 0x08bb }
            goto L_0x0027;
        L_0x09e3:
            r25 = "BluetoothManagerService";
            r27 = new java.lang.StringBuilder;	 Catch:{ all -> 0x08bb }
            r27.<init>();	 Catch:{ all -> 0x08bb }
            r28 = "Bad msg.arg1: ";
            r27 = r27.append(r28);	 Catch:{ all -> 0x08bb }
            r0 = r31;
            r0 = r0.arg1;	 Catch:{ all -> 0x08bb }
            r28 = r0;
            r27 = r27.append(r28);	 Catch:{ all -> 0x08bb }
            r27 = r27.toString();	 Catch:{ all -> 0x08bb }
            r0 = r25;
            r1 = r27;
            android.util.Log.e(r0, r1);	 Catch:{ all -> 0x08bb }
            monitor-exit(r26);	 Catch:{ all -> 0x08bb }
            goto L_0x0027;
        L_0x0a08:
            r25 = "BluetoothManagerService";
            r26 = "MESSAGE_RESTART_BLUETOOTH_SERVICE: Restart IBluetooth service";
            android.util.Log.d(r25, r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 1;
            r25.mEnable = r26;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r26 = r0;
            r26 = r26.mQuietEnable;
            r25.handleEnable(r26);
            goto L_0x0027;
        L_0x0a2f:
            r25 = "BluetoothManagerService";
            r26 = "MESSAGE_TIMEOUT_UNBIND";
            android.util.Log.e(r25, r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = r25.mConnection;
            monitor-enter(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x0a53 }
            r25 = r0;
            r27 = 0;
            r0 = r25;
            r1 = r27;
            r0.mUnbinding = r1;	 Catch:{ all -> 0x0a53 }
            monitor-exit(r26);	 Catch:{ all -> 0x0a53 }
            goto L_0x0027;
        L_0x0a53:
            r25 = move-exception;
            monitor-exit(r26);	 Catch:{ all -> 0x0a53 }
            throw r25;
        L_0x0a56:
            r25 = "BluetoothManagerService";
            r26 = "MESSAGE_USER_SWITCHED";
            android.util.Log.d(r25, r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mHandler;
            r26 = 300; // 0x12c float:4.2E-43 double:1.48E-321;
            r25.removeMessages(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mEnable;
            if (r25 == 0) goto L_0x0c2a;
        L_0x0a78:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mBluetooth;
            if (r25 == 0) goto L_0x0c2a;
        L_0x0a84:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = r25.mConnection;
            monitor-enter(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x0c24 }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ all -> 0x0c24 }
            if (r25 == 0) goto L_0x0ab6;
        L_0x0a9b:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x0c14 }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ RemoteException -> 0x0c14 }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ RemoteException -> 0x0c14 }
            r27 = r0;
            r27 = r27.mBluetoothCallback;	 Catch:{ RemoteException -> 0x0c14 }
            r0 = r25;
            r1 = r27;
            r0.unregisterCallback(r1);	 Catch:{ RemoteException -> 0x0c14 }
        L_0x0ab6:
            monitor-exit(r26);	 Catch:{ all -> 0x0c24 }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mState;
            r26 = 13;
            r0 = r25;
            r1 = r26;
            if (r0 != r1) goto L_0x0ae9;
        L_0x0ac9:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r26 = r0;
            r26 = r26.mState;
            r27 = 10;
            r25.bluetoothStateChangeHandler(r26, r27);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 10;
            r25.mState = r26;
        L_0x0ae9:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mState;
            r26 = 10;
            r0 = r25;
            r1 = r26;
            if (r0 != r1) goto L_0x0b1b;
        L_0x0afb:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r26 = r0;
            r26 = r26.mState;
            r27 = 11;
            r25.bluetoothStateChangeHandler(r26, r27);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 11;
            r25.mState = r26;
        L_0x0b1b:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 1;
            r27 = 0;
            r28 = 30;
            r25.waitForOnOff(r26, r27, r28);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mState;
            r26 = 11;
            r0 = r25;
            r1 = r26;
            if (r0 != r1) goto L_0x0b51;
        L_0x0b3c:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r26 = r0;
            r26 = r26.mState;
            r27 = 12;
            r25.bluetoothStateChangeHandler(r26, r27);
        L_0x0b51:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25.unbindAllBluetoothProfileServices();
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25.handleDisable();
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 12;
            r27 = 13;
            r25.bluetoothStateChangeHandler(r26, r27);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 0;
            r27 = 1;
            r28 = 30;
            r25.waitForOnOff(r26, r27, r28);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 13;
            r27 = 10;
            r25.bluetoothStateChangeHandler(r26, r27);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25.sendBluetoothServiceDownCallback();
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25.sendQBluetoothServiceDownCallback();
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = r25.mConnection;
            monitor-enter(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x0c27 }
            r25 = r0;
            r25 = r25.mBluetooth;	 Catch:{ all -> 0x0c27 }
            if (r25 == 0) goto L_0x0bdf;
        L_0x0bb5:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x0c27 }
            r25 = r0;
            r27 = 0;
            r0 = r25;
            r1 = r27;
            r0.mBluetooth = r1;	 Catch:{ all -> 0x0c27 }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x0c27 }
            r25 = r0;
            r25 = r25.mContext;	 Catch:{ all -> 0x0c27 }
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;	 Catch:{ all -> 0x0c27 }
            r27 = r0;
            r27 = r27.mConnection;	 Catch:{ all -> 0x0c27 }
            r0 = r25;
            r1 = r27;
            r0.unbindService(r1);	 Catch:{ all -> 0x0c27 }
        L_0x0bdf:
            monitor-exit(r26);	 Catch:{ all -> 0x0c27 }
            r26 = 100;
            android.os.SystemClock.sleep(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mHandler;
            r26 = 60;
            r25.removeMessages(r26);
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r26 = 10;
            r25.mState = r26;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r26 = r0;
            r26 = r26.mQuietEnable;
            r25.handleEnable(r26);
            goto L_0x0027;
        L_0x0c14:
            r16 = move-exception;
            r25 = "BluetoothManagerService";
            r27 = "Unable to unregister";
            r0 = r25;
            r1 = r27;
            r2 = r16;
            android.util.Log.e(r0, r1, r2);	 Catch:{ all -> 0x0c24 }
            goto L_0x0ab6;
        L_0x0c24:
            r25 = move-exception;
            monitor-exit(r26);	 Catch:{ all -> 0x0c24 }
            throw r25;
        L_0x0c27:
            r25 = move-exception;
            monitor-exit(r26);	 Catch:{ all -> 0x0c27 }
            throw r25;
        L_0x0c2a:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mBinding;
            if (r25 != 0) goto L_0x0c42;
        L_0x0c36:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mBluetooth;
            if (r25 == 0) goto L_0x0027;
        L_0x0c42:
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mHandler;
            r26 = 300; // 0x12c float:4.2E-43 double:1.48E-321;
            r24 = r25.obtainMessage(r26);
            r0 = r31;
            r0 = r0.arg2;
            r25 = r0;
            r25 = r25 + 1;
            r0 = r25;
            r1 = r24;
            r1.arg2 = r0;
            r0 = r30;
            r0 = com.android.server.BluetoothManagerService.this;
            r25 = r0;
            r25 = r25.mHandler;
            r26 = 200; // 0xc8 float:2.8E-43 double:9.9E-322;
            r0 = r25;
            r1 = r24;
            r2 = r26;
            r0.sendMessageDelayed(r1, r2);
            r25 = "BluetoothManagerService";
            r26 = new java.lang.StringBuilder;
            r26.<init>();
            r27 = "delay MESSAGE_USER_SWITCHED ";
            r26 = r26.append(r27);
            r0 = r24;
            r0 = r0.arg2;
            r27 = r0;
            r26 = r26.append(r27);
            r26 = r26.toString();
            android.util.Log.d(r25, r26);
            goto L_0x0027;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.BluetoothManagerService.BluetoothHandler.handleMessage(android.os.Message):void");
        }
    }

    private class BluetoothServiceConnection implements ServiceConnection {
        private boolean mGetNameAddressOnly;

        private BluetoothServiceConnection() {
        }

        public void setGetNameAddressOnly(boolean getOnly) {
            this.mGetNameAddressOnly = getOnly;
        }

        public boolean isGetNameAddressOnly() {
            return this.mGetNameAddressOnly;
        }

        public void onServiceConnected(ComponentName className, IBinder service) {
            Log.d(BluetoothManagerService.TAG, "BluetoothServiceConnection: " + className.getClassName());
            Message msg = BluetoothManagerService.this.mHandler.obtainMessage(BluetoothManagerService.MESSAGE_BLUETOOTH_SERVICE_CONNECTED);
            if (className.getClassName().equals("com.android.bluetooth.btservice.AdapterService")) {
                msg.arg1 = BluetoothManagerService.SERVICE_IBLUETOOTH;
            } else if (className.getClassName().equals("com.android.bluetooth.gatt.GattService")) {
                msg.arg1 = BluetoothManagerService.SERVICE_IBLUETOOTHGATT;
            } else if (className.getClassName().equals("com.android.bluetooth.btservice.QAdapterService")) {
                msg.arg1 = BluetoothManagerService.SERVICE_IBLUETOOTHQ;
                Log.e(BluetoothManagerService.TAG, "Bluetooth Q service connected: " + className.getClassName());
            } else {
                Log.e(BluetoothManagerService.TAG, "Unknown service connected: " + className.getClassName());
                return;
            }
            msg.obj = service;
            BluetoothManagerService.this.mHandler.sendMessage(msg);
        }

        public void onServiceDisconnected(ComponentName className) {
            Log.d(BluetoothManagerService.TAG, "BluetoothServiceConnection, disconnected: " + className.getClassName());
            Message msg = BluetoothManagerService.this.mHandler.obtainMessage(BluetoothManagerService.MESSAGE_BLUETOOTH_SERVICE_DISCONNECTED);
            if (className.getClassName().equals("com.android.bluetooth.btservice.AdapterService")) {
                msg.arg1 = BluetoothManagerService.SERVICE_IBLUETOOTH;
            } else if (className.getClassName().equals("com.android.bluetooth.gatt.GattService")) {
                msg.arg1 = BluetoothManagerService.SERVICE_IBLUETOOTHGATT;
            } else if (className.getClassName().equals("com.android.bluetooth.btservice.QAdapterService")) {
                msg.arg1 = BluetoothManagerService.SERVICE_IBLUETOOTHQ;
            } else {
                Log.e(BluetoothManagerService.TAG, "Unknown service disconnected: " + className.getClassName());
                return;
            }
            BluetoothManagerService.this.mHandler.sendMessage(msg);
        }
    }

    private final class ProfileServiceConnections implements ServiceConnection, DeathRecipient {
        ComponentName mClassName;
        Intent mIntent;
        final RemoteCallbackList<IBluetoothProfileServiceConnection> mProxies;
        IBinder mService;

        ProfileServiceConnections(Intent intent) {
            this.mProxies = new RemoteCallbackList();
            this.mService = null;
            this.mClassName = null;
            this.mIntent = intent;
        }

        private boolean bindService() {
            if (this.mIntent != null && this.mService == null && BluetoothManagerService.this.doBind(this.mIntent, this, BluetoothManagerService.BLUETOOTH_OFF, UserHandle.CURRENT_OR_SELF)) {
                Message msg = BluetoothManagerService.this.mHandler.obtainMessage(BluetoothManagerService.MESSAGE_BIND_PROFILE_SERVICE);
                msg.obj = this;
                BluetoothManagerService.this.mHandler.sendMessageDelayed(msg, 3000);
                return BluetoothManagerService.DBG;
            }
            Log.w(BluetoothManagerService.TAG, "Unable to bind with intent: " + this.mIntent);
            return false;
        }

        private void addProxy(IBluetoothProfileServiceConnection proxy) {
            this.mProxies.register(proxy);
            if (this.mService != null) {
                try {
                    proxy.onServiceConnected(this.mClassName, this.mService);
                } catch (RemoteException e) {
                    Log.e(BluetoothManagerService.TAG, "Unable to connect to proxy", e);
                }
            } else if (!BluetoothManagerService.this.mHandler.hasMessages(BluetoothManagerService.MESSAGE_BIND_PROFILE_SERVICE, this)) {
                Message msg = BluetoothManagerService.this.mHandler.obtainMessage(BluetoothManagerService.MESSAGE_BIND_PROFILE_SERVICE);
                msg.obj = this;
                BluetoothManagerService.this.mHandler.sendMessage(msg);
            }
        }

        private void removeProxy(IBluetoothProfileServiceConnection proxy) {
            if (proxy == null) {
                Log.w(BluetoothManagerService.TAG, "Trying to remove a null proxy");
            } else if (this.mProxies.unregister(proxy)) {
                try {
                    proxy.onServiceDisconnected(this.mClassName);
                } catch (RemoteException e) {
                    Log.e(BluetoothManagerService.TAG, "Unable to disconnect proxy", e);
                }
            }
        }

        private void removeAllProxies() {
            onServiceDisconnected(this.mClassName);
            this.mProxies.kill();
        }

        public void onServiceConnected(ComponentName className, IBinder service) {
            BluetoothManagerService.this.mHandler.removeMessages(BluetoothManagerService.MESSAGE_BIND_PROFILE_SERVICE, this);
            synchronized (this) {
                this.mService = service;
                this.mClassName = className;
                try {
                    this.mService.linkToDeath(this, BluetoothManagerService.BLUETOOTH_OFF);
                } catch (RemoteException e) {
                    Log.e(BluetoothManagerService.TAG, "Unable to linkToDeath", e);
                }
            }
            int n = this.mProxies.beginBroadcast();
            for (int i = BluetoothManagerService.BLUETOOTH_OFF; i < n; i += BluetoothManagerService.SERVICE_IBLUETOOTH) {
                try {
                    ((IBluetoothProfileServiceConnection) this.mProxies.getBroadcastItem(i)).onServiceConnected(className, service);
                } catch (RemoteException e2) {
                    Log.e(BluetoothManagerService.TAG, "Unable to connect to proxy", e2);
                }
            }
            this.mProxies.finishBroadcast();
        }

        public void onServiceDisconnected(ComponentName className) {
            synchronized (this) {
                if (this.mService == null) {
                    Log.e(BluetoothManagerService.TAG, "onServiceDisconnected: service is already NULL");
                    return;
                }
                this.mService.unlinkToDeath(this, BluetoothManagerService.BLUETOOTH_OFF);
                this.mService = null;
                this.mClassName = null;
                int n = this.mProxies.beginBroadcast();
                for (int i = BluetoothManagerService.BLUETOOTH_OFF; i < n; i += BluetoothManagerService.SERVICE_IBLUETOOTH) {
                    try {
                        ((IBluetoothProfileServiceConnection) this.mProxies.getBroadcastItem(i)).onServiceDisconnected(className);
                    } catch (RemoteException e) {
                        Log.e(BluetoothManagerService.TAG, "Unable to disconnect from proxy", e);
                    }
                }
                this.mProxies.finishBroadcast();
            }
        }

        public void binderDied() {
            Log.w(BluetoothManagerService.TAG, "Profile service for profile: " + this.mClassName + " died.");
            onServiceDisconnected(this.mClassName);
            Message msg = BluetoothManagerService.this.mHandler.obtainMessage(BluetoothManagerService.MESSAGE_BIND_PROFILE_SERVICE);
            msg.obj = this;
            BluetoothManagerService.this.mHandler.sendMessageDelayed(msg, 3000);
        }
    }

    private void registerForAirplaneMode(IntentFilter filter) {
        ContentResolver resolver = this.mContext.getContentResolver();
        String airplaneModeRadios = Global.getString(resolver, "airplane_mode_radios");
        String toggleableRadios = Global.getString(resolver, "airplane_mode_toggleable_radios");
        if (airplaneModeRadios == null ? DBG : airplaneModeRadios.contains("bluetooth")) {
            filter.addAction("android.intent.action.AIRPLANE_MODE");
        }
    }

    BluetoothManagerService(Context context) {
        this.mQuietEnable = false;
        this.mIsBluetoothServiceConnected = false;
        this.mProfileServices = new HashMap();
        this.mBluetoothCallback = new C00171();
        this.mReceiver = new C00182();
        this.mConnection = new BluetoothServiceConnection();
        this.mHandler = new BluetoothHandler(IoThread.get().getLooper());
        this.mContext = context;
        this.mBluetooth = null;
        this.mQBluetooth = null;
        this.mBinding = false;
        this.mUnbinding = false;
        this.mEnable = false;
        this.mState = WAIT_NORMAL;
        this.mQuietEnableExternal = false;
        this.mEnableExternal = false;
        this.mAddress = null;
        this.mName = null;
        this.mErrorRecoveryRetryCounter = BLUETOOTH_OFF;
        this.mContentResolver = context.getContentResolver();
        this.mCallbacks = new RemoteCallbackList();
        this.mQCallbacks = new RemoteCallbackList();
        this.mStateChangeCallbacks = new RemoteCallbackList();
        IntentFilter filter = new IntentFilter("android.intent.action.BOOT_COMPLETED");
        filter.addAction("android.bluetooth.adapter.action.LOCAL_NAME_CHANGED");
        filter.addAction("android.intent.action.USER_SWITCHED");
        registerForAirplaneMode(filter);
        filter.setPriority(ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
        this.mContext.registerReceiver(this.mReceiver, filter);
        loadStoredNameAndAddress();
        if (isBluetoothPersistedStateOn()) {
            this.mEnableExternal = DBG;
        }
        int sysUiUid = -1;
        try {
            sysUiUid = this.mContext.getPackageManager().getPackageUid("com.android.systemui", BLUETOOTH_OFF);
        } catch (NameNotFoundException e) {
            Log.wtf(TAG, "Unable to resolve SystemUI's UID.", e);
        }
        this.mSystemUiUid = sysUiUid;
    }

    private final boolean isAirplaneModeOn() {
        return Global.getInt(this.mContext.getContentResolver(), "airplane_mode_on", BLUETOOTH_OFF) == SERVICE_IBLUETOOTH ? DBG : false;
    }

    private final boolean isBluetoothPersistedStateOn() {
        return Global.getInt(this.mContentResolver, "bluetooth_on", BLUETOOTH_OFF) != 0 ? DBG : false;
    }

    private final boolean isBluetoothPersistedStateOnBluetooth() {
        return Global.getInt(this.mContentResolver, "bluetooth_on", BLUETOOTH_OFF) == SERVICE_IBLUETOOTH ? DBG : false;
    }

    private void persistBluetoothSetting(int value) {
        Global.putInt(this.mContext.getContentResolver(), "bluetooth_on", value);
    }

    private boolean isNameAndAddressSet() {
        return (this.mName == null || this.mAddress == null || this.mName.length() <= 0 || this.mAddress.length() <= 0) ? false : DBG;
    }

    private void loadStoredNameAndAddress() {
        Log.d(TAG, "Loading stored name and address");
        if (this.mContext.getResources().getBoolean(17956944) && Secure.getInt(this.mContentResolver, SECURE_SETTINGS_BLUETOOTH_ADDR_VALID, BLUETOOTH_OFF) == 0) {
            Log.d(TAG, "invalid bluetooth name and address stored");
            return;
        }
        this.mName = Secure.getString(this.mContentResolver, SECURE_SETTINGS_BLUETOOTH_NAME);
        this.mAddress = Secure.getString(this.mContentResolver, SECURE_SETTINGS_BLUETOOTH_ADDRESS);
        Log.d(TAG, "Stored bluetooth Name=" + this.mName + ",Address=" + this.mAddress);
    }

    private void storeNameAndAddress(String name, String address) {
        if (name != null) {
            Secure.putString(this.mContentResolver, SECURE_SETTINGS_BLUETOOTH_NAME, name);
            this.mName = name;
            Log.d(TAG, "Stored Bluetooth name: " + Secure.getString(this.mContentResolver, SECURE_SETTINGS_BLUETOOTH_NAME));
        }
        if (address != null) {
            Secure.putString(this.mContentResolver, SECURE_SETTINGS_BLUETOOTH_ADDRESS, address);
            this.mAddress = address;
            Log.d(TAG, "Stored Bluetoothaddress: " + Secure.getString(this.mContentResolver, SECURE_SETTINGS_BLUETOOTH_ADDRESS));
        }
        if (name != null && address != null) {
            Secure.putInt(this.mContentResolver, SECURE_SETTINGS_BLUETOOTH_ADDR_VALID, SERVICE_IBLUETOOTH);
        }
    }

    public IBluetooth registerAdapter(IBluetoothManagerCallback callback) {
        if (callback == null) {
            Log.w(TAG, "Callback is null in registerAdapter");
            return null;
        }
        IBluetooth iBluetooth;
        Message msg = this.mHandler.obtainMessage(MESSAGE_REGISTER_ADAPTER);
        msg.obj = callback;
        this.mHandler.sendMessage(msg);
        synchronized (this.mConnection) {
            iBluetooth = this.mBluetooth;
        }
        return iBluetooth;
    }

    public void unregisterAdapter(IBluetoothManagerCallback callback) {
        if (callback == null) {
            Log.w(TAG, "Callback is null in unregisterAdapter");
            return;
        }
        this.mContext.enforceCallingOrSelfPermission(BLUETOOTH_PERM, "Need BLUETOOTH permission");
        Message msg = this.mHandler.obtainMessage(MESSAGE_UNREGISTER_ADAPTER);
        msg.obj = callback;
        this.mHandler.sendMessage(msg);
    }

    public IQBluetooth registerQAdapter(IQBluetoothManagerCallback callback) {
        IQBluetooth iQBluetooth;
        Message msg = this.mHandler.obtainMessage(MESSAGE_REGISTER_Q_ADAPTER);
        msg.obj = callback;
        this.mHandler.sendMessage(msg);
        synchronized (this.mConnection) {
            iQBluetooth = this.mQBluetooth;
        }
        return iQBluetooth;
    }

    public void unregisterQAdapter(IQBluetoothManagerCallback callback) {
        this.mContext.enforceCallingOrSelfPermission(BLUETOOTH_PERM, "Need BLUETOOTH permission");
        Message msg = this.mHandler.obtainMessage(MESSAGE_UNREGISTER_Q_ADAPTER);
        msg.obj = callback;
        this.mHandler.sendMessage(msg);
    }

    public void registerStateChangeCallback(IBluetoothStateChangeCallback callback) {
        this.mContext.enforceCallingOrSelfPermission(BLUETOOTH_PERM, "Need BLUETOOTH permission");
        Message msg = this.mHandler.obtainMessage(WAIT_USERSWITCH);
        msg.obj = callback;
        this.mHandler.sendMessage(msg);
    }

    public void unregisterStateChangeCallback(IBluetoothStateChangeCallback callback) {
        this.mContext.enforceCallingOrSelfPermission(BLUETOOTH_PERM, "Need BLUETOOTH permission");
        Message msg = this.mHandler.obtainMessage(MESSAGE_UNREGISTER_STATE_CHANGE_CALLBACK);
        msg.obj = callback;
        this.mHandler.sendMessage(msg);
    }

    public boolean isEnabled() {
        boolean z = false;
        if (Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || checkIfCallerIsForegroundUser()) {
            synchronized (this.mConnection) {
                try {
                    if (this.mBluetooth != null && this.mBluetooth.isEnabled()) {
                        z = DBG;
                    }
                } catch (RemoteException e) {
                    Log.e(TAG, "isEnabled()", e);
                }
            }
        } else {
            Log.w(TAG, "isEnabled(): not allowed for non-active and non system user");
        }
        return z;
    }

    public void getNameAndAddress() {
        Log.d(TAG, "getNameAndAddress(): mBluetooth = " + this.mBluetooth + " mBinding = " + this.mBinding);
        this.mHandler.sendMessage(this.mHandler.obtainMessage(USER_SWITCHED_TIME_MS));
    }

    public boolean enableNoAutoConnect() {
        this.mContext.enforceCallingOrSelfPermission(BLUETOOTH_ADMIN_PERM, "Need BLUETOOTH ADMIN permission");
        Log.d(TAG, "enableNoAutoConnect():  mBluetooth =" + this.mBluetooth + " mBinding = " + this.mBinding);
        if (UserHandle.getAppId(Binder.getCallingUid()) != 1027) {
            throw new SecurityException("no permission to enable Bluetooth quietly");
        }
        synchronized (this.mReceiver) {
            this.mQuietEnableExternal = DBG;
            this.mEnableExternal = DBG;
            sendEnableMsg(DBG);
        }
        return DBG;
    }

    public boolean enable(String callingPackage) {
        if (Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || checkIfCallerIsForegroundUser()) {
            this.mContext.enforceCallingOrSelfPermission(BLUETOOTH_ADMIN_PERM, "Need BLUETOOTH ADMIN permission");
            Log.d(TAG, "enable():  mBluetooth =" + this.mBluetooth + " mBinding = " + this.mBinding);
            if (((AppOpsManager) this.mContext.getSystemService("appops")).noteOp(49, Binder.getCallingUid(), callingPackage) != 0) {
                return false;
            }
            synchronized (this.mReceiver) {
                this.mQuietEnableExternal = false;
                this.mEnableExternal = DBG;
                long callingIdentity = Binder.clearCallingIdentity();
                persistBluetoothSetting(SERVICE_IBLUETOOTH);
                Binder.restoreCallingIdentity(callingIdentity);
                sendEnableMsg(false);
            }
            return DBG;
        }
        Log.w(TAG, "enable(): not allowed for non-active and non system user");
        return false;
    }

    public boolean disable(boolean persist) {
        this.mContext.enforceCallingOrSelfPermission(BLUETOOTH_ADMIN_PERM, "Need BLUETOOTH ADMIN permissicacheNameAndAddresson");
        if (Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || checkIfCallerIsForegroundUser()) {
            Log.d(TAG, "disable(): mBluetooth = " + this.mBluetooth + " mBinding = " + this.mBinding);
            synchronized (this.mReceiver) {
                if (persist) {
                    long callingIdentity = Binder.clearCallingIdentity();
                    persistBluetoothSetting(BLUETOOTH_OFF);
                    Binder.restoreCallingIdentity(callingIdentity);
                }
                this.mEnableExternal = false;
                sendDisableMsg();
            }
            return DBG;
        }
        Log.w(TAG, "disable(): not allowed for non-active and non system user");
        return false;
    }

    public void unbindAndFinish() {
        Log.d(TAG, "unbindAndFinish(): " + this.mBluetooth + " mBinding = " + this.mBinding);
        synchronized (this.mConnection) {
            if (this.mUnbinding) {
                return;
            }
            this.mUnbinding = DBG;
            if (this.mBluetooth != null) {
                if (!this.mConnection.isGetNameAddressOnly()) {
                    try {
                        this.mBluetooth.unregisterCallback(this.mBluetoothCallback);
                    } catch (RemoteException re) {
                        Log.e(TAG, "Unable to unregister BluetoothCallback", re);
                    }
                }
                Log.d(TAG, "Sending unbind request.");
                this.mBluetooth = null;
                this.mQBluetooth = null;
                this.mContext.unbindService(this.mConnection);
                this.mUnbinding = false;
                this.mBinding = false;
            } else {
                this.mUnbinding = false;
            }
        }
    }

    public IBluetoothGatt getBluetoothGatt() {
        return this.mBluetoothGatt;
    }

    public boolean bindBluetoothProfileService(int bluetoothProfile, IBluetoothProfileServiceConnection proxy) {
        if (this.mEnable) {
            synchronized (this.mProfileServices) {
                if (((ProfileServiceConnections) this.mProfileServices.get(new Integer(bluetoothProfile))) == null) {
                    Log.d(TAG, "Creating new ProfileServiceConnections object for profile: " + bluetoothProfile);
                    if (bluetoothProfile != SERVICE_IBLUETOOTH) {
                        return false;
                    }
                    ProfileServiceConnections psc = new ProfileServiceConnections(new Intent(IBluetoothHeadset.class.getName()));
                    if (psc.bindService()) {
                        this.mProfileServices.put(new Integer(bluetoothProfile), psc);
                    } else {
                        return false;
                    }
                }
                Message addProxyMsg = this.mHandler.obtainMessage(MESSAGE_ADD_PROXY_DELAYED);
                addProxyMsg.arg1 = bluetoothProfile;
                addProxyMsg.obj = proxy;
                this.mHandler.sendMessageDelayed(addProxyMsg, 100);
                return DBG;
            }
        }
        Log.d(TAG, "Trying to bind to profile: " + bluetoothProfile + ", while Bluetooth was disabled");
        return false;
    }

    public void unbindBluetoothProfileService(int bluetoothProfile, IBluetoothProfileServiceConnection proxy) {
        synchronized (this.mProfileServices) {
            ProfileServiceConnections psc = (ProfileServiceConnections) this.mProfileServices.get(new Integer(bluetoothProfile));
            if (psc == null) {
                return;
            }
            psc.removeProxy(proxy);
        }
    }

    private void unbindAllBluetoothProfileServices() {
        synchronized (this.mProfileServices) {
            for (Integer i : this.mProfileServices.keySet()) {
                ProfileServiceConnections psc = (ProfileServiceConnections) this.mProfileServices.get(i);
                try {
                    this.mContext.unbindService(psc);
                } catch (IllegalArgumentException e) {
                    Log.e(TAG, "Unable to unbind service with intent: " + psc.mIntent, e);
                }
                psc.removeAllProxies();
            }
            this.mProfileServices.clear();
        }
    }

    public IQBluetooth getQBluetooth() {
        return this.mQBluetooth;
    }

    private void sendBluetoothStateCallback(boolean isUp) {
        int n = this.mStateChangeCallbacks.beginBroadcast();
        Log.d(TAG, "Broadcasting onBluetoothStateChange(" + isUp + ") to " + n + " receivers.");
        for (int i = BLUETOOTH_OFF; i < n; i += SERVICE_IBLUETOOTH) {
            try {
                ((IBluetoothStateChangeCallback) this.mStateChangeCallbacks.getBroadcastItem(i)).onBluetoothStateChange(isUp);
            } catch (RemoteException e) {
                Log.e(TAG, "Unable to call onBluetoothStateChange() on callback #" + i, e);
            }
        }
        this.mStateChangeCallbacks.finishBroadcast();
    }

    private void sendBluetoothServiceUpCallback() {
        if (!this.mConnection.isGetNameAddressOnly()) {
            Log.d(TAG, "Calling onBluetoothServiceUp callbacks");
            int n = this.mCallbacks.beginBroadcast();
            Log.d(TAG, "Broadcasting onBluetoothServiceUp() to " + n + " receivers.");
            for (int i = BLUETOOTH_OFF; i < n; i += SERVICE_IBLUETOOTH) {
                try {
                    ((IBluetoothManagerCallback) this.mCallbacks.getBroadcastItem(i)).onBluetoothServiceUp(this.mBluetooth);
                } catch (RemoteException e) {
                    Log.e(TAG, "Unable to call onBluetoothServiceUp() on callback #" + i, e);
                }
            }
            this.mCallbacks.finishBroadcast();
        }
    }

    private void sendBluetoothServiceDownCallback() {
        if (!this.mConnection.isGetNameAddressOnly()) {
            Log.d(TAG, "Calling onBluetoothServiceDown callbacks");
            int n = this.mCallbacks.beginBroadcast();
            Log.d(TAG, "Broadcasting onBluetoothServiceDown() to " + n + " receivers.");
            for (int i = BLUETOOTH_OFF; i < n; i += SERVICE_IBLUETOOTH) {
                try {
                    ((IBluetoothManagerCallback) this.mCallbacks.getBroadcastItem(i)).onBluetoothServiceDown();
                } catch (RemoteException e) {
                    Log.e(TAG, "Unable to call onBluetoothServiceDown() on callback #" + i, e);
                }
            }
            this.mCallbacks.finishBroadcast();
        }
    }

    private void sendQBluetoothServiceUpCallback() {
        Log.d(TAG, "Calling onQBluetoothServiceUp callbacks");
        int n = this.mQCallbacks.beginBroadcast();
        Log.d(TAG, "Broadcasting onQBluetoothServiceUp() to " + n + " receivers.");
        for (int i = BLUETOOTH_OFF; i < n; i += SERVICE_IBLUETOOTH) {
            try {
                ((IQBluetoothManagerCallback) this.mQCallbacks.getBroadcastItem(i)).onQBluetoothServiceUp(this.mQBluetooth);
            } catch (RemoteException e) {
                Log.e(TAG, "Unable to call onQBluetoothServiceUp() on callback #" + i, e);
            }
        }
        this.mQCallbacks.finishBroadcast();
    }

    private void sendQBluetoothServiceDownCallback() {
        Log.d(TAG, "Calling onQBluetoothServiceDown callbacks");
        int n = this.mQCallbacks.beginBroadcast();
        Log.d(TAG, "Broadcasting onQBluetoothServiceDown() to " + n + " receivers.");
        for (int i = BLUETOOTH_OFF; i < n; i += SERVICE_IBLUETOOTH) {
            try {
                ((IQBluetoothManagerCallback) this.mQCallbacks.getBroadcastItem(i)).onQBluetoothServiceDown();
            } catch (RemoteException e) {
                Log.e(TAG, "Unable to call onQBluetoothServiceDown() on callback #" + i, e);
            }
        }
        this.mQCallbacks.finishBroadcast();
    }

    public String getAddress() {
        this.mContext.enforceCallingOrSelfPermission(BLUETOOTH_PERM, "Need BLUETOOTH permission");
        if (Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || checkIfCallerIsForegroundUser()) {
            synchronized (this.mConnection) {
                if (this.mBluetooth != null) {
                    try {
                        String address = this.mBluetooth.getAddress();
                        return address;
                    } catch (RemoteException e) {
                        Log.e(TAG, "getAddress(): Unable to retrieve address remotely..Returning cached address", e);
                    }
                }
                return this.mAddress;
            }
        }
        Log.w(TAG, "getAddress(): not allowed for non-active and non system user");
        return null;
    }

    public String getName() {
        this.mContext.enforceCallingOrSelfPermission(BLUETOOTH_PERM, "Need BLUETOOTH permission");
        if (Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || checkIfCallerIsForegroundUser()) {
            synchronized (this.mConnection) {
                if (this.mBluetooth != null) {
                    try {
                        String name = this.mBluetooth.getName();
                        return name;
                    } catch (RemoteException e) {
                        Log.e(TAG, "getName(): Unable to retrieve name remotely..Returning cached name", e);
                    }
                }
                return this.mName;
            }
        }
        Log.w(TAG, "getName(): not allowed for non-active and non system user");
        return null;
    }

    private void handleEnable(boolean quietMode) {
        this.mQuietEnable = quietMode;
        synchronized (this.mConnection) {
            if (this.mBluetooth == null && !this.mBinding) {
                this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(MESSAGE_TIMEOUT_BIND), 3000);
                this.mConnection.setGetNameAddressOnly(false);
                if (doBind(new Intent(IBluetooth.class.getName()), this.mConnection, 65, UserHandle.CURRENT)) {
                    this.mBinding = DBG;
                } else {
                    this.mHandler.removeMessages(MESSAGE_TIMEOUT_BIND);
                }
            } else if (this.mBluetooth != null) {
                if (this.mConnection.isGetNameAddressOnly()) {
                    this.mConnection.setGetNameAddressOnly(false);
                    try {
                        this.mBluetooth.registerCallback(this.mBluetoothCallback);
                    } catch (RemoteException re) {
                        Log.e(TAG, "Unable to register BluetoothCallback", re);
                    }
                    sendBluetoothServiceUpCallback();
                }
                try {
                    if (this.mQuietEnable) {
                        if (!this.mBluetooth.enableNoAutoConnect()) {
                            Log.e(TAG, "IBluetooth.enableNoAutoConnect() returned false");
                        }
                    } else if (!this.mBluetooth.enable()) {
                        Log.e(TAG, "IBluetooth.enable() returned false");
                    }
                } catch (RemoteException e) {
                    Log.e(TAG, "Unable to call enable()", e);
                }
            }
        }
    }

    boolean doBind(Intent intent, ServiceConnection conn, int flags, UserHandle user) {
        ComponentName comp = intent.resolveSystemService(this.mContext.getPackageManager(), BLUETOOTH_OFF);
        intent.setComponent(comp);
        if (comp != null && this.mContext.bindServiceAsUser(intent, conn, flags, user)) {
            return DBG;
        }
        Log.e(TAG, "Fail to bind to: " + intent);
        return false;
    }

    private void handleDisable() {
        synchronized (this.mConnection) {
            if (!(this.mBluetooth == null || this.mConnection.isGetNameAddressOnly())) {
                Log.d(TAG, "Sending off request.");
                try {
                    if (!this.mBluetooth.disable()) {
                        Log.e(TAG, "IBluetooth.disable() returned false");
                    }
                } catch (RemoteException e) {
                    Log.e(TAG, "Unable to call disable()", e);
                }
            }
        }
    }

    private boolean checkIfCallerIsForegroundUser() {
        int callingUser = UserHandle.getCallingUserId();
        int callingUid = Binder.getCallingUid();
        long callingIdentity = Binder.clearCallingIdentity();
        UserInfo ui = ((UserManager) this.mContext.getSystemService("user")).getProfileParent(callingUser);
        int parentUser = ui != null ? ui.id : -10000;
        int callingAppId = UserHandle.getAppId(callingUid);
        boolean z = false;
        try {
            int foregroundUser = ActivityManager.getCurrentUser();
            z = (callingUser == foregroundUser || parentUser == foregroundUser || callingAppId == 1027 || callingAppId == this.mSystemUiUid) ? DBG : false;
            Log.d(TAG, "checkIfCallerIsForegroundUser: valid=" + z + " callingUser=" + callingUser + " parentUser=" + parentUser + " foregroundUser=" + foregroundUser);
            return z;
        } finally {
            Binder.restoreCallingIdentity(callingIdentity);
        }
    }

    private void bluetoothStateChangeHandler(int prevState, int newState) {
        if (prevState != newState) {
            if (newState == 12 || newState == WAIT_NORMAL) {
                boolean isUp = newState == 12 ? DBG : false;
                sendBluetoothStateCallback(isUp);
                if (isUp) {
                    if (this.mContext.getPackageManager().hasSystemFeature("android.hardware.bluetooth_le")) {
                        doBind(new Intent(IBluetoothGatt.class.getName()), this.mConnection, 65, UserHandle.CURRENT);
                        doBind(new Intent(IQBluetooth.class.getName()), this.mConnection, 65, UserHandle.CURRENT);
                    }
                } else if (!isUp && canUnbindBluetoothService()) {
                    unbindAllBluetoothProfileServices();
                    sendBluetoothServiceDownCallback();
                    sendQBluetoothServiceDownCallback();
                    unbindAndFinish();
                }
            }
            Intent intent = new Intent("android.bluetooth.adapter.action.STATE_CHANGED");
            intent.putExtra("android.bluetooth.adapter.extra.PREVIOUS_STATE", prevState);
            intent.putExtra("android.bluetooth.adapter.extra.STATE", newState);
            intent.addFlags(67108864);
            intent.addFlags(268435456);
            Log.d(TAG, "Bluetooth State Change Intent: " + prevState + " -> " + newState);
            this.mContext.sendBroadcastAsUser(intent, UserHandle.CURRENT, BLUETOOTH_PERM);
        }
    }

    private boolean waitForOnOff(boolean on, boolean off, int loop) {
        int i = BLUETOOTH_OFF;
        while (i < loop) {
            synchronized (this.mConnection) {
                if (this.mBluetooth == null) {
                    Log.e(TAG, "waitForOnOff time out");
                    return false;
                }
                if (on) {
                    if (this.mBluetooth.getState() == 12) {
                        return DBG;
                    }
                } else if (!off) {
                    try {
                        if (this.mBluetooth.getState() != 12) {
                            return DBG;
                        }
                    } catch (RemoteException e) {
                        Log.e(TAG, "getState()", e);
                    }
                } else if (this.mBluetooth.getState() == WAIT_NORMAL) {
                    return DBG;
                }
                if (on || off) {
                    SystemClock.sleep(300);
                } else {
                    SystemClock.sleep(50);
                }
                i += SERVICE_IBLUETOOTH;
            }
        }
        Log.e(TAG, "waitForOnOff time out");
        return false;
    }

    private void sendDisableMsg() {
        this.mHandler.sendMessage(this.mHandler.obtainMessage(SERVICE_IBLUETOOTHGATT));
    }

    private void sendEnableMsg(boolean quietMode) {
        int i;
        BluetoothHandler bluetoothHandler = this.mHandler;
        BluetoothHandler bluetoothHandler2 = this.mHandler;
        if (quietMode) {
            i = SERVICE_IBLUETOOTH;
        } else {
            i = BLUETOOTH_OFF;
        }
        bluetoothHandler.sendMessage(bluetoothHandler2.obtainMessage(SERVICE_IBLUETOOTH, i, BLUETOOTH_OFF));
    }

    private boolean canUnbindBluetoothService() {
        boolean z = false;
        synchronized (this.mConnection) {
            try {
                if (this.mEnable || this.mBluetooth == null) {
                } else if (this.mHandler.hasMessages(MESSAGE_BLUETOOTH_STATE_CHANGE)) {
                } else {
                    if (this.mBluetooth.getState() == WAIT_NORMAL) {
                        z = DBG;
                    }
                }
            } catch (RemoteException e) {
                Log.e(TAG, "getState()", e);
            }
        }
        return z;
    }

    private void recoverBluetoothServiceFromError() {
        Log.e(TAG, "recoverBluetoothServiceFromError");
        synchronized (this.mConnection) {
            if (this.mBluetooth != null) {
                try {
                    this.mBluetooth.unregisterCallback(this.mBluetoothCallback);
                } catch (RemoteException re) {
                    Log.e(TAG, "Unable to unregister", re);
                }
            }
        }
        SystemClock.sleep(500);
        handleDisable();
        waitForOnOff(false, DBG, WAIT_NORMAL);
        sendBluetoothServiceDownCallback();
        sendQBluetoothServiceDownCallback();
        synchronized (this.mConnection) {
            if (this.mBluetooth != null) {
                this.mBluetooth = null;
                if (this.mQBluetooth != null) {
                    this.mQBluetooth = null;
                }
                this.mContext.unbindService(this.mConnection);
            }
        }
        this.mHandler.removeMessages(MESSAGE_BLUETOOTH_STATE_CHANGE);
        this.mState = WAIT_NORMAL;
        this.mEnable = false;
        int i = this.mErrorRecoveryRetryCounter;
        this.mErrorRecoveryRetryCounter = i + SERVICE_IBLUETOOTH;
        if (i < MAX_ERROR_RESTART_RETRIES) {
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(MESSAGE_RESTART_BLUETOOTH_SERVICE), 3000);
        }
    }

    public void dump(FileDescriptor fd, PrintWriter writer, String[] args) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DUMP", TAG);
        writer.println("enabled: " + this.mEnable);
        writer.println("state: " + this.mState);
        writer.println("address: " + this.mAddress);
        writer.println("name: " + this.mName);
        if (this.mBluetooth == null) {
            writer.println("Bluetooth Service not connected");
            return;
        }
        try {
            writer.println(this.mBluetooth.dump());
        } catch (RemoteException e) {
            writer.println("RemoteException while calling Bluetooth Service");
        }
    }
}
