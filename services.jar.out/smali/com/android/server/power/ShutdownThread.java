package com.android.server.power;

import android.app.ActivityManagerNative;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.IActivityManager;
import android.app.KeyguardManager;
import android.app.ProgressDialog;
import android.bluetooth.IBluetoothManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.DialogInterface.OnDismissListener;
import android.content.Intent;
import android.content.IntentFilter;
import android.media.AudioAttributes;
import android.media.AudioAttributes.Builder;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnCompletionListener;
import android.nfc.INfcAdapter;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.SystemVibrator;
import android.os.UserHandle;
import android.os.storage.IMountShutdownObserver.Stub;
import android.provider.Settings.Secure;
import android.util.Log;
import android.view.IWindowManager;
import com.android.internal.telephony.ITelephony;
import java.io.File;
import java.io.IOException;

public final class ShutdownThread extends Thread {
    private static final int MAX_BROADCAST_TIME = 10000;
    private static final int MAX_RADIO_WAIT_TIME = 12000;
    private static final int MAX_SHUTDOWN_WAIT_TIME = 20000;
    private static final String OEM_BOOTANIMATION_FILE = "/oem/media/shutdownanimation.zip";
    private static final String OEM_SHUTDOWN_MUSIC_FILE = "/oem/media/shutdown.wav";
    private static final int PHONE_STATE_POLL_SLEEP_MSEC = 500;
    public static final String REBOOT_SAFEMODE_PROPERTY = "persist.sys.safemode";
    public static final String SHUTDOWN_ACTION_PROPERTY = "sys.shutdown.requested";
    private static final String SHUTDOWN_MUSIC_FILE = "/system/media/shutdown.wav";
    private static final int SHUTDOWN_VIBRATE_MS = 500;
    private static final String SOFT_REBOOT = "soft_reboot";
    private static final String SYSTEM_BOOTANIMATION_FILE = "/system/media/shutdownanimation.zip";
    private static final String SYSTEM_ENCRYPTED_BOOTANIMATION_FILE = "/system/media/shutdownanimation-encrypted.zip";
    private static final String TAG = "ShutdownThread";
    private static final AudioAttributes VIBRATION_ATTRIBUTES;
    private static AudioManager mAudioManager;
    private static MediaPlayer mMediaPlayer;
    private static boolean mReboot;
    private static String mRebootReason;
    private static boolean mRebootSafeMode;
    private static AlertDialog sConfirmDialog;
    private static final ShutdownThread sInstance;
    private static boolean sIsStarted;
    private static Object sIsStartedGuard;
    private boolean isShutdownMusicPlaying;
    private boolean mActionDone;
    private final Object mActionDoneSync;
    private Context mContext;
    private WakeLock mCpuWakeLock;
    private Handler mHandler;
    private PowerManager mPowerManager;
    private WakeLock mScreenWakeLock;
    private Handler shutdownMusicHandler;

    /* renamed from: com.android.server.power.ShutdownThread.1 */
    static class C04721 implements OnClickListener {
        final /* synthetic */ boolean val$advancedReboot;
        final /* synthetic */ Context val$context;

        C04721(boolean z, Context context) {
            this.val$advancedReboot = z;
            this.val$context = context;
        }

        public void onClick(DialogInterface dialog, int which) {
            if (this.val$advancedReboot) {
                int selected = ((AlertDialog) dialog).getListView().getCheckedItemPosition();
                if (selected != -1) {
                    String[] actions = this.val$context.getResources().getStringArray(17236041);
                    if (selected >= 0 && selected < actions.length) {
                        ShutdownThread.mRebootReason = actions[selected];
                        if (actions[selected].equals(ShutdownThread.SOFT_REBOOT)) {
                            ShutdownThread.doSoftReboot();
                            return;
                        }
                    }
                }
                ShutdownThread.mReboot = true;
            }
            ShutdownThread.beginShutdownSequence(this.val$context);
        }
    }

    /* renamed from: com.android.server.power.ShutdownThread.2 */
    static class C04732 extends Handler {
        C04732() {
        }
    }

    /* renamed from: com.android.server.power.ShutdownThread.3 */
    class C04743 extends BroadcastReceiver {
        C04743() {
        }

        public void onReceive(Context context, Intent intent) {
            ShutdownThread.this.actionDone();
        }
    }

    /* renamed from: com.android.server.power.ShutdownThread.4 */
    class C04754 extends Stub {
        C04754() {
        }

        public void onShutDownComplete(int statusCode) throws RemoteException {
            Log.w(ShutdownThread.TAG, "Result code " + statusCode + " from MountService.shutdown");
            ShutdownThread.this.actionDone();
        }
    }

    /* renamed from: com.android.server.power.ShutdownThread.5 */
    class C04765 extends Thread {
        final /* synthetic */ boolean[] val$done;
        final /* synthetic */ long val$endTime;

        C04765(long j, boolean[] zArr) {
            this.val$endTime = j;
            this.val$done = zArr;
        }

        public void run() {
            boolean nfcOff;
            boolean bluetoothOff;
            boolean radioOff;
            INfcAdapter nfc = INfcAdapter.Stub.asInterface(ServiceManager.checkService("nfc"));
            ITelephony phone = ITelephony.Stub.asInterface(ServiceManager.checkService("phone"));
            IBluetoothManager bluetooth = IBluetoothManager.Stub.asInterface(ServiceManager.checkService("bluetooth_manager"));
            if (nfc != null) {
                try {
                    if (nfc.getState() != 1) {
                        nfcOff = false;
                        if (!nfcOff) {
                            Log.w(ShutdownThread.TAG, "Turning off NFC...");
                            nfc.disable(false);
                        }
                        if (bluetooth != null) {
                            try {
                                if (bluetooth.isEnabled()) {
                                    bluetoothOff = false;
                                    if (!bluetoothOff) {
                                        Log.w(ShutdownThread.TAG, "Disabling Bluetooth...");
                                        bluetooth.disable(false);
                                    }
                                    if (phone != null) {
                                        try {
                                            if (phone.needMobileRadioShutdown()) {
                                                radioOff = false;
                                                if (!radioOff) {
                                                    Log.w(ShutdownThread.TAG, "Turning off cellular radios...");
                                                    phone.shutdownMobileRadios();
                                                }
                                                Log.i(ShutdownThread.TAG, "Waiting for NFC, Bluetooth and Radio...");
                                                while (SystemClock.elapsedRealtime() < this.val$endTime) {
                                                    if (!bluetoothOff) {
                                                        try {
                                                            if (bluetooth.isEnabled()) {
                                                                bluetoothOff = true;
                                                            } else {
                                                                bluetoothOff = false;
                                                            }
                                                        } catch (RemoteException ex) {
                                                            Log.e(ShutdownThread.TAG, "RemoteException during bluetooth shutdown", ex);
                                                            bluetoothOff = true;
                                                        }
                                                        if (bluetoothOff) {
                                                            Log.i(ShutdownThread.TAG, "Bluetooth turned off.");
                                                        }
                                                    }
                                                    if (!radioOff) {
                                                        try {
                                                            if (phone.needMobileRadioShutdown()) {
                                                                radioOff = true;
                                                            } else {
                                                                radioOff = false;
                                                            }
                                                        } catch (RemoteException ex2) {
                                                            Log.e(ShutdownThread.TAG, "RemoteException during radio shutdown", ex2);
                                                            radioOff = true;
                                                        }
                                                        if (radioOff) {
                                                            Log.i(ShutdownThread.TAG, "Radio turned off.");
                                                        }
                                                    }
                                                    if (!nfcOff) {
                                                        try {
                                                            if (nfc.getState() != 1) {
                                                                nfcOff = true;
                                                            } else {
                                                                nfcOff = false;
                                                            }
                                                        } catch (RemoteException ex22) {
                                                            Log.e(ShutdownThread.TAG, "RemoteException during NFC shutdown", ex22);
                                                            nfcOff = true;
                                                        }
                                                        if (nfcOff) {
                                                            Log.i(ShutdownThread.TAG, "NFC turned off.");
                                                        }
                                                    }
                                                    if (!radioOff && bluetoothOff && nfcOff) {
                                                        Log.i(ShutdownThread.TAG, "NFC, Radio and Bluetooth shutdown complete.");
                                                        this.val$done[0] = true;
                                                        return;
                                                    }
                                                    SystemClock.sleep(500);
                                                }
                                            }
                                        } catch (RemoteException ex222) {
                                            Log.e(ShutdownThread.TAG, "RemoteException during radio shutdown", ex222);
                                            radioOff = true;
                                        }
                                    }
                                    radioOff = true;
                                    if (radioOff) {
                                        Log.w(ShutdownThread.TAG, "Turning off cellular radios...");
                                        phone.shutdownMobileRadios();
                                    }
                                    Log.i(ShutdownThread.TAG, "Waiting for NFC, Bluetooth and Radio...");
                                    while (SystemClock.elapsedRealtime() < this.val$endTime) {
                                        if (bluetoothOff) {
                                            if (bluetooth.isEnabled()) {
                                                bluetoothOff = false;
                                            } else {
                                                bluetoothOff = true;
                                            }
                                            if (bluetoothOff) {
                                                Log.i(ShutdownThread.TAG, "Bluetooth turned off.");
                                            }
                                        }
                                        if (radioOff) {
                                            if (phone.needMobileRadioShutdown()) {
                                                radioOff = false;
                                            } else {
                                                radioOff = true;
                                            }
                                            if (radioOff) {
                                                Log.i(ShutdownThread.TAG, "Radio turned off.");
                                            }
                                        }
                                        if (nfcOff) {
                                            if (nfc.getState() != 1) {
                                                nfcOff = false;
                                            } else {
                                                nfcOff = true;
                                            }
                                            if (nfcOff) {
                                                Log.i(ShutdownThread.TAG, "NFC turned off.");
                                            }
                                        }
                                        if (!radioOff) {
                                        }
                                        SystemClock.sleep(500);
                                    }
                                }
                            } catch (RemoteException ex2222) {
                                Log.e(ShutdownThread.TAG, "RemoteException during bluetooth shutdown", ex2222);
                                bluetoothOff = true;
                            }
                        }
                        bluetoothOff = true;
                        if (bluetoothOff) {
                            Log.w(ShutdownThread.TAG, "Disabling Bluetooth...");
                            bluetooth.disable(false);
                        }
                        if (phone != null) {
                            if (phone.needMobileRadioShutdown()) {
                                radioOff = false;
                                if (radioOff) {
                                    Log.w(ShutdownThread.TAG, "Turning off cellular radios...");
                                    phone.shutdownMobileRadios();
                                }
                                Log.i(ShutdownThread.TAG, "Waiting for NFC, Bluetooth and Radio...");
                                while (SystemClock.elapsedRealtime() < this.val$endTime) {
                                    if (bluetoothOff) {
                                        if (bluetooth.isEnabled()) {
                                            bluetoothOff = true;
                                        } else {
                                            bluetoothOff = false;
                                        }
                                        if (bluetoothOff) {
                                            Log.i(ShutdownThread.TAG, "Bluetooth turned off.");
                                        }
                                    }
                                    if (radioOff) {
                                        if (phone.needMobileRadioShutdown()) {
                                            radioOff = true;
                                        } else {
                                            radioOff = false;
                                        }
                                        if (radioOff) {
                                            Log.i(ShutdownThread.TAG, "Radio turned off.");
                                        }
                                    }
                                    if (nfcOff) {
                                        if (nfc.getState() != 1) {
                                            nfcOff = true;
                                        } else {
                                            nfcOff = false;
                                        }
                                        if (nfcOff) {
                                            Log.i(ShutdownThread.TAG, "NFC turned off.");
                                        }
                                    }
                                    if (!radioOff) {
                                    }
                                    SystemClock.sleep(500);
                                }
                            }
                        }
                        radioOff = true;
                        if (radioOff) {
                            Log.w(ShutdownThread.TAG, "Turning off cellular radios...");
                            phone.shutdownMobileRadios();
                        }
                        Log.i(ShutdownThread.TAG, "Waiting for NFC, Bluetooth and Radio...");
                        while (SystemClock.elapsedRealtime() < this.val$endTime) {
                            if (bluetoothOff) {
                                if (bluetooth.isEnabled()) {
                                    bluetoothOff = false;
                                } else {
                                    bluetoothOff = true;
                                }
                                if (bluetoothOff) {
                                    Log.i(ShutdownThread.TAG, "Bluetooth turned off.");
                                }
                            }
                            if (radioOff) {
                                if (phone.needMobileRadioShutdown()) {
                                    radioOff = false;
                                } else {
                                    radioOff = true;
                                }
                                if (radioOff) {
                                    Log.i(ShutdownThread.TAG, "Radio turned off.");
                                }
                            }
                            if (nfcOff) {
                                if (nfc.getState() != 1) {
                                    nfcOff = false;
                                } else {
                                    nfcOff = true;
                                }
                                if (nfcOff) {
                                    Log.i(ShutdownThread.TAG, "NFC turned off.");
                                }
                            }
                            if (!radioOff) {
                            }
                            SystemClock.sleep(500);
                        }
                    }
                } catch (RemoteException ex22222) {
                    Log.e(ShutdownThread.TAG, "RemoteException during NFC shutdown", ex22222);
                    nfcOff = true;
                }
            }
            nfcOff = true;
            if (nfcOff) {
                Log.w(ShutdownThread.TAG, "Turning off NFC...");
                nfc.disable(false);
            }
            if (bluetooth != null) {
                if (bluetooth.isEnabled()) {
                    bluetoothOff = false;
                    if (bluetoothOff) {
                        Log.w(ShutdownThread.TAG, "Disabling Bluetooth...");
                        bluetooth.disable(false);
                    }
                    if (phone != null) {
                        if (phone.needMobileRadioShutdown()) {
                            radioOff = false;
                            if (radioOff) {
                                Log.w(ShutdownThread.TAG, "Turning off cellular radios...");
                                phone.shutdownMobileRadios();
                            }
                            Log.i(ShutdownThread.TAG, "Waiting for NFC, Bluetooth and Radio...");
                            while (SystemClock.elapsedRealtime() < this.val$endTime) {
                                if (bluetoothOff) {
                                    if (bluetooth.isEnabled()) {
                                        bluetoothOff = true;
                                    } else {
                                        bluetoothOff = false;
                                    }
                                    if (bluetoothOff) {
                                        Log.i(ShutdownThread.TAG, "Bluetooth turned off.");
                                    }
                                }
                                if (radioOff) {
                                    if (phone.needMobileRadioShutdown()) {
                                        radioOff = true;
                                    } else {
                                        radioOff = false;
                                    }
                                    if (radioOff) {
                                        Log.i(ShutdownThread.TAG, "Radio turned off.");
                                    }
                                }
                                if (nfcOff) {
                                    if (nfc.getState() != 1) {
                                        nfcOff = true;
                                    } else {
                                        nfcOff = false;
                                    }
                                    if (nfcOff) {
                                        Log.i(ShutdownThread.TAG, "NFC turned off.");
                                    }
                                }
                                if (!radioOff) {
                                }
                                SystemClock.sleep(500);
                            }
                        }
                    }
                    radioOff = true;
                    if (radioOff) {
                        Log.w(ShutdownThread.TAG, "Turning off cellular radios...");
                        phone.shutdownMobileRadios();
                    }
                    Log.i(ShutdownThread.TAG, "Waiting for NFC, Bluetooth and Radio...");
                    while (SystemClock.elapsedRealtime() < this.val$endTime) {
                        if (bluetoothOff) {
                            if (bluetooth.isEnabled()) {
                                bluetoothOff = false;
                            } else {
                                bluetoothOff = true;
                            }
                            if (bluetoothOff) {
                                Log.i(ShutdownThread.TAG, "Bluetooth turned off.");
                            }
                        }
                        if (radioOff) {
                            if (phone.needMobileRadioShutdown()) {
                                radioOff = false;
                            } else {
                                radioOff = true;
                            }
                            if (radioOff) {
                                Log.i(ShutdownThread.TAG, "Radio turned off.");
                            }
                        }
                        if (nfcOff) {
                            if (nfc.getState() != 1) {
                                nfcOff = false;
                            } else {
                                nfcOff = true;
                            }
                            if (nfcOff) {
                                Log.i(ShutdownThread.TAG, "NFC turned off.");
                            }
                        }
                        if (!radioOff) {
                        }
                        SystemClock.sleep(500);
                    }
                }
            }
            bluetoothOff = true;
            if (bluetoothOff) {
                Log.w(ShutdownThread.TAG, "Disabling Bluetooth...");
                bluetooth.disable(false);
            }
            if (phone != null) {
                if (phone.needMobileRadioShutdown()) {
                    radioOff = false;
                    if (radioOff) {
                        Log.w(ShutdownThread.TAG, "Turning off cellular radios...");
                        phone.shutdownMobileRadios();
                    }
                    Log.i(ShutdownThread.TAG, "Waiting for NFC, Bluetooth and Radio...");
                    while (SystemClock.elapsedRealtime() < this.val$endTime) {
                        if (bluetoothOff) {
                            if (bluetooth.isEnabled()) {
                                bluetoothOff = true;
                            } else {
                                bluetoothOff = false;
                            }
                            if (bluetoothOff) {
                                Log.i(ShutdownThread.TAG, "Bluetooth turned off.");
                            }
                        }
                        if (radioOff) {
                            if (phone.needMobileRadioShutdown()) {
                                radioOff = true;
                            } else {
                                radioOff = false;
                            }
                            if (radioOff) {
                                Log.i(ShutdownThread.TAG, "Radio turned off.");
                            }
                        }
                        if (nfcOff) {
                            if (nfc.getState() != 1) {
                                nfcOff = true;
                            } else {
                                nfcOff = false;
                            }
                            if (nfcOff) {
                                Log.i(ShutdownThread.TAG, "NFC turned off.");
                            }
                        }
                        if (!radioOff) {
                        }
                        SystemClock.sleep(500);
                    }
                }
            }
            radioOff = true;
            if (radioOff) {
                Log.w(ShutdownThread.TAG, "Turning off cellular radios...");
                phone.shutdownMobileRadios();
            }
            Log.i(ShutdownThread.TAG, "Waiting for NFC, Bluetooth and Radio...");
            while (SystemClock.elapsedRealtime() < this.val$endTime) {
                if (bluetoothOff) {
                    if (bluetooth.isEnabled()) {
                        bluetoothOff = false;
                    } else {
                        bluetoothOff = true;
                    }
                    if (bluetoothOff) {
                        Log.i(ShutdownThread.TAG, "Bluetooth turned off.");
                    }
                }
                if (radioOff) {
                    if (phone.needMobileRadioShutdown()) {
                        radioOff = false;
                    } else {
                        radioOff = true;
                    }
                    if (radioOff) {
                        Log.i(ShutdownThread.TAG, "Radio turned off.");
                    }
                }
                if (nfcOff) {
                    if (nfc.getState() != 1) {
                        nfcOff = false;
                    } else {
                        nfcOff = true;
                    }
                    if (nfcOff) {
                        Log.i(ShutdownThread.TAG, "NFC turned off.");
                    }
                }
                if (!radioOff) {
                }
                SystemClock.sleep(500);
            }
        }
    }

    /* renamed from: com.android.server.power.ShutdownThread.6 */
    class C04786 extends Handler {

        /* renamed from: com.android.server.power.ShutdownThread.6.1 */
        class C04771 implements OnCompletionListener {
            C04771() {
            }

            public void onCompletion(MediaPlayer mp) {
                synchronized (ShutdownThread.this.mActionDoneSync) {
                    ShutdownThread.this.isShutdownMusicPlaying = false;
                    ShutdownThread.this.mActionDoneSync.notifyAll();
                }
            }
        }

        C04786() {
        }

        public void handleMessage(Message msg) {
            String path = msg.obj;
            ShutdownThread.mMediaPlayer = new MediaPlayer();
            try {
                ShutdownThread.mMediaPlayer.reset();
                ShutdownThread.mMediaPlayer.setDataSource(path);
                ShutdownThread.mMediaPlayer.prepare();
                ShutdownThread.mMediaPlayer.start();
                ShutdownThread.mMediaPlayer.setOnCompletionListener(new C04771());
            } catch (IOException e) {
                Log.d(ShutdownThread.TAG, "play shutdown music error:" + e);
            }
        }
    }

    private static class CloseDialogReceiver extends BroadcastReceiver implements OnDismissListener {
        public Dialog dialog;
        private Context mContext;

        CloseDialogReceiver(Context context) {
            this.mContext = context;
            context.registerReceiver(this, new IntentFilter("android.intent.action.CLOSE_SYSTEM_DIALOGS"));
        }

        public void onReceive(Context context, Intent intent) {
            this.dialog.cancel();
        }

        public void onDismiss(DialogInterface unused) {
            this.mContext.unregisterReceiver(this);
        }
    }

    static {
        sIsStartedGuard = new Object();
        sIsStarted = false;
        sInstance = new ShutdownThread();
        VIBRATION_ATTRIBUTES = new Builder().setContentType(4).setUsage(13).build();
    }

    private ShutdownThread() {
        this.mActionDoneSync = new Object();
        this.isShutdownMusicPlaying = false;
        this.shutdownMusicHandler = new C04786();
    }

    public static void shutdown(Context context, boolean confirm) {
        mReboot = false;
        mRebootSafeMode = false;
        shutdownInner(context, confirm);
    }

    private static boolean isAdvancedRebootPossible(Context context) {
        boolean advancedRebootEnabled;
        KeyguardManager km = (KeyguardManager) context.getSystemService("keyguard");
        boolean keyguardLocked;
        if (km.inKeyguardRestrictedInputMode() && km.isKeyguardSecure()) {
            keyguardLocked = true;
        } else {
            keyguardLocked = false;
        }
        if (Secure.getInt(context.getContentResolver(), "advanced_reboot", 0) == 1) {
            advancedRebootEnabled = true;
        } else {
            advancedRebootEnabled = false;
        }
        boolean isPrimaryUser;
        if (UserHandle.getCallingUserId() == 0) {
            isPrimaryUser = true;
        } else {
            isPrimaryUser = false;
        }
        if (advancedRebootEnabled && !keyguardLocked && isPrimaryUser) {
            return true;
        }
        return false;
    }

    static void shutdownInner(Context context, boolean confirm) {
        synchronized (sIsStartedGuard) {
            if (sIsStarted) {
                Log.d(TAG, "Request to shutdown already running, returning.");
                return;
            }
            boolean showRebootOption = false;
            String[] defaultActions = context.getResources().getStringArray(17236023);
            for (String equals : defaultActions) {
                if (equals.equals("reboot")) {
                    showRebootOption = true;
                    break;
                }
            }
            int longPressBehavior = context.getResources().getInteger(17694784);
            int resourceId = mRebootSafeMode ? 17039620 : longPressBehavior == 2 ? 17039618 : 17039617;
            if (showRebootOption && !mRebootSafeMode) {
                resourceId = 17039622;
            }
            Log.d(TAG, "Notifying thread to start shutdown longPressBehavior=" + longPressBehavior);
            if (confirm) {
                CloseDialogReceiver closer = new CloseDialogReceiver(context);
                boolean advancedReboot = isAdvancedRebootPossible(context);
                if (sConfirmDialog != null) {
                    sConfirmDialog.dismiss();
                    sConfirmDialog = null;
                }
                AlertDialog.Builder builder = new AlertDialog.Builder(context);
                int i = mRebootSafeMode ? 17039619 : showRebootOption ? 17039621 : 17039612;
                AlertDialog.Builder confirmDialogBuilder = builder.setTitle(i);
                if (advancedReboot) {
                    confirmDialogBuilder.setSingleChoiceItems(17236040, 0, null);
                } else {
                    confirmDialogBuilder.setMessage(resourceId);
                }
                confirmDialogBuilder.setPositiveButton(17039379, new C04721(advancedReboot, context));
                confirmDialogBuilder.setNegativeButton(17039369, null);
                sConfirmDialog = confirmDialogBuilder.create();
                closer.dialog = sConfirmDialog;
                sConfirmDialog.setOnDismissListener(closer);
                sConfirmDialog.getWindow().setType(2009);
                sConfirmDialog.show();
                return;
            }
            beginShutdownSequence(context);
        }
    }

    private static void doSoftReboot() {
        try {
            IActivityManager am = ActivityManagerNative.asInterface(ServiceManager.checkService("activity"));
            if (am != null) {
                am.restart();
            }
        } catch (RemoteException e) {
            Log.e(TAG, "failure trying to perform soft reboot", e);
        }
    }

    public static void reboot(Context context, String reason, boolean confirm) {
        mReboot = true;
        mRebootSafeMode = false;
        mRebootReason = reason;
        shutdownInner(context, confirm);
    }

    private static String getShutdownMusicFilePath() {
        for (String music : new String[]{OEM_SHUTDOWN_MUSIC_FILE, SHUTDOWN_MUSIC_FILE}) {
            if (new File(music).exists()) {
                return music;
            }
        }
        return null;
    }

    private static void lockDevice() {
        try {
            IWindowManager.Stub.asInterface(ServiceManager.getService("window")).updateRotation(false, false);
        } catch (RemoteException e) {
            Log.w(TAG, "boot animation can not lock device!");
        }
    }

    public static void rebootSafeMode(Context context, boolean confirm) {
        mReboot = true;
        mRebootSafeMode = true;
        mRebootReason = null;
        shutdownInner(context, confirm);
    }

    private static void beginShutdownSequence(Context context) {
        synchronized (sIsStartedGuard) {
            if (sIsStarted) {
                Log.d(TAG, "Shutdown sequence already running, returning.");
                return;
            }
            sIsStarted = true;
            mAudioManager = (AudioManager) context.getSystemService("audio");
            mAudioManager.requestAudioFocus(null, 3, 1);
            if (!checkAnimationFileExist()) {
                ProgressDialog pd = new ProgressDialog(context);
                pd.setTitle(context.getText(17039612));
                pd.setMessage(context.getText(17039616));
                pd.setIndeterminate(true);
                pd.setCancelable(false);
                pd.getWindow().setType(2009);
                pd.show();
            }
            sInstance.mContext = context;
            sInstance.mPowerManager = (PowerManager) context.getSystemService("power");
            sInstance.mCpuWakeLock = null;
            try {
                sInstance.mCpuWakeLock = sInstance.mPowerManager.newWakeLock(1, "ShutdownThread-cpu");
                sInstance.mCpuWakeLock.setReferenceCounted(false);
                sInstance.mCpuWakeLock.acquire();
            } catch (SecurityException e) {
                Log.w(TAG, "No permission to acquire wake lock", e);
                sInstance.mCpuWakeLock = null;
            }
            sInstance.mScreenWakeLock = null;
            if (sInstance.mPowerManager.isScreenOn()) {
                try {
                    sInstance.mScreenWakeLock = sInstance.mPowerManager.newWakeLock(26, "ShutdownThread-screen");
                    sInstance.mScreenWakeLock.setReferenceCounted(false);
                    sInstance.mScreenWakeLock.acquire();
                } catch (SecurityException e2) {
                    Log.w(TAG, "No permission to acquire wake lock", e2);
                    sInstance.mScreenWakeLock = null;
                }
            }
            sInstance.mHandler = new C04732();
            sInstance.start();
        }
    }

    void actionDone() {
        synchronized (this.mActionDoneSync) {
            this.mActionDone = true;
            this.mActionDoneSync.notifyAll();
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void run() {
        /*
        r26 = this;
        r6 = new com.android.server.power.ShutdownThread$3;
        r0 = r26;
        r6.<init>();
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r2 = mReboot;
        if (r2 == 0) goto L_0x017a;
    L_0x0010:
        r2 = "1";
    L_0x0012:
        r4 = r4.append(r2);
        r2 = mRebootReason;
        if (r2 == 0) goto L_0x017e;
    L_0x001a:
        r2 = mRebootReason;
    L_0x001c:
        r2 = r4.append(r2);
        r24 = r2.toString();
        r2 = "sys.shutdown.requested";
        r0 = r24;
        android.os.SystemProperties.set(r2, r0);
        r2 = mRebootSafeMode;
        if (r2 == 0) goto L_0x0036;
    L_0x002f:
        r2 = "persist.sys.safemode";
        r4 = "1";
        android.os.SystemProperties.set(r2, r4);
    L_0x0036:
        r2 = "ShutdownThread";
        r4 = "Sending shutdown broadcast...";
        android.util.Log.i(r2, r4);
        r2 = 0;
        r0 = r26;
        r0.mActionDone = r2;
        r3 = new android.content.Intent;
        r2 = "android.intent.action.ACTION_SHUTDOWN";
        r3.<init>(r2);
        r2 = 268435456; // 0x10000000 float:2.5243549E-29 double:1.32624737E-315;
        r3.addFlags(r2);
        r0 = r26;
        r2 = r0.mContext;
        r4 = android.os.UserHandle.ALL;
        r5 = 0;
        r0 = r26;
        r7 = r0.mHandler;
        r8 = 0;
        r9 = 0;
        r10 = 0;
        r2.sendOrderedBroadcastAsUser(r3, r4, r5, r6, r7, r8, r9, r10);
        r4 = android.os.SystemClock.elapsedRealtime();
        r8 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r18 = r4 + r8;
        r0 = r26;
        r4 = r0.mActionDoneSync;
        monitor-enter(r4);
    L_0x006c:
        r0 = r26;
        r2 = r0.mActionDone;	 Catch:{ all -> 0x018e }
        if (r2 != 0) goto L_0x0085;
    L_0x0072:
        r8 = android.os.SystemClock.elapsedRealtime();	 Catch:{ all -> 0x018e }
        r12 = r18 - r8;
        r8 = 0;
        r2 = (r12 > r8 ? 1 : (r12 == r8 ? 0 : -1));
        if (r2 > 0) goto L_0x0182;
    L_0x007e:
        r2 = "ShutdownThread";
        r5 = "Shutdown broadcast timed out";
        android.util.Log.w(r2, r5);	 Catch:{ all -> 0x018e }
    L_0x0085:
        monitor-exit(r4);	 Catch:{ all -> 0x018e }
        r2 = "ShutdownThread";
        r4 = "Shutting down activity manager...";
        android.util.Log.i(r2, r4);
        r2 = "activity";
        r2 = android.os.ServiceManager.checkService(r2);
        r11 = android.app.ActivityManagerNative.asInterface(r2);
        if (r11 == 0) goto L_0x009e;
    L_0x0099:
        r2 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r11.shutdown(r2);	 Catch:{ RemoteException -> 0x01be }
    L_0x009e:
        r2 = "ShutdownThread";
        r4 = "Shutting down package manager...";
        android.util.Log.i(r2, r4);
        r2 = "package";
        r23 = android.os.ServiceManager.getService(r2);
        r23 = (com.android.server.pm.PackageManagerService) r23;
        if (r23 == 0) goto L_0x00b2;
    L_0x00af:
        r23.shutdown();
    L_0x00b2:
        r25 = 0;
        r2 = checkAnimationFileExist();
        if (r2 == 0) goto L_0x00df;
    L_0x00ba:
        lockDevice();
        showShutdownAnimation();
        r2 = isSilentMode();
        if (r2 != 0) goto L_0x00df;
    L_0x00c6:
        r25 = getShutdownMusicFilePath();
        if (r25 == 0) goto L_0x00df;
    L_0x00cc:
        r2 = 1;
        r0 = r26;
        r0.isShutdownMusicPlaying = r2;
        r0 = r26;
        r2 = r0.shutdownMusicHandler;
        r4 = 0;
        r0 = r25;
        r2 = r2.obtainMessage(r4, r0);
        r2.sendToTarget();
    L_0x00df:
        r2 = "ShutdownThread";
        r4 = "wait for shutdown music";
        android.util.Log.i(r2, r4);
        r4 = android.os.SystemClock.elapsedRealtime();
        r8 = 10000; // 0x2710 float:1.4013E-41 double:4.9407E-320;
        r20 = r4 + r8;
        r0 = r26;
        r4 = r0.mActionDoneSync;
        monitor-enter(r4);
    L_0x00f3:
        r0 = r26;
        r2 = r0.isShutdownMusicPlaying;	 Catch:{ all -> 0x019d }
        if (r2 == 0) goto L_0x010c;
    L_0x00f9:
        r8 = android.os.SystemClock.elapsedRealtime();	 Catch:{ all -> 0x019d }
        r12 = r20 - r8;
        r8 = 0;
        r2 = (r12 > r8 ? 1 : (r12 == r8 ? 0 : -1));
        if (r2 > 0) goto L_0x0191;
    L_0x0105:
        r2 = "ShutdownThread";
        r5 = "play shutdown music timeout!";
        android.util.Log.w(r2, r5);	 Catch:{ all -> 0x019d }
    L_0x010c:
        r0 = r26;
        r2 = r0.isShutdownMusicPlaying;	 Catch:{ all -> 0x019d }
        if (r2 != 0) goto L_0x0119;
    L_0x0112:
        r2 = "ShutdownThread";
        r5 = "play shutdown music complete.";
        android.util.Log.i(r2, r5);	 Catch:{ all -> 0x019d }
    L_0x0119:
        monitor-exit(r4);	 Catch:{ all -> 0x019d }
        r2 = 12000; // 0x2ee0 float:1.6816E-41 double:5.929E-320;
        r0 = r26;
        r0.shutdownRadios(r2);
        r22 = new com.android.server.power.ShutdownThread$4;
        r0 = r22;
        r1 = r26;
        r0.<init>();
        r2 = "ShutdownThread";
        r4 = "Shutting down MountService";
        android.util.Log.i(r2, r4);
        r2 = 0;
        r0 = r26;
        r0.mActionDone = r2;
        r4 = android.os.SystemClock.elapsedRealtime();
        r8 = 20000; // 0x4e20 float:2.8026E-41 double:9.8813E-320;
        r16 = r4 + r8;
        r0 = r26;
        r4 = r0.mActionDoneSync;
        monitor-enter(r4);
        r2 = "mount";
        r2 = android.os.ServiceManager.checkService(r2);	 Catch:{ Exception -> 0x01a8 }
        r15 = android.os.storage.IMountService.Stub.asInterface(r2);	 Catch:{ Exception -> 0x01a8 }
        if (r15 == 0) goto L_0x01a0;
    L_0x014f:
        r0 = r22;
        r15.shutdown(r0);	 Catch:{ Exception -> 0x01a8 }
    L_0x0154:
        r0 = r26;
        r2 = r0.mActionDone;	 Catch:{ all -> 0x01b1 }
        if (r2 != 0) goto L_0x016d;
    L_0x015a:
        r8 = android.os.SystemClock.elapsedRealtime();	 Catch:{ all -> 0x01b1 }
        r12 = r16 - r8;
        r8 = 0;
        r2 = (r12 > r8 ? 1 : (r12 == r8 ? 0 : -1));
        if (r2 > 0) goto L_0x01b4;
    L_0x0166:
        r2 = "ShutdownThread";
        r5 = "Shutdown wait timed out";
        android.util.Log.w(r2, r5);	 Catch:{ all -> 0x01b1 }
    L_0x016d:
        monitor-exit(r4);	 Catch:{ all -> 0x01b1 }
        r0 = r26;
        r2 = r0.mContext;
        r4 = mReboot;
        r5 = mRebootReason;
        rebootOrShutdown(r2, r4, r5);
        return;
    L_0x017a:
        r2 = "0";
        goto L_0x0012;
    L_0x017e:
        r2 = "";
        goto L_0x001c;
    L_0x0182:
        r0 = r26;
        r2 = r0.mActionDoneSync;	 Catch:{ InterruptedException -> 0x018b }
        r2.wait(r12);	 Catch:{ InterruptedException -> 0x018b }
        goto L_0x006c;
    L_0x018b:
        r2 = move-exception;
        goto L_0x006c;
    L_0x018e:
        r2 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x018e }
        throw r2;
    L_0x0191:
        r0 = r26;
        r2 = r0.mActionDoneSync;	 Catch:{ InterruptedException -> 0x019a }
        r2.wait(r12);	 Catch:{ InterruptedException -> 0x019a }
        goto L_0x00f3;
    L_0x019a:
        r2 = move-exception;
        goto L_0x00f3;
    L_0x019d:
        r2 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x019d }
        throw r2;
    L_0x01a0:
        r2 = "ShutdownThread";
        r5 = "MountService unavailable for shutdown";
        android.util.Log.w(r2, r5);	 Catch:{ Exception -> 0x01a8 }
        goto L_0x0154;
    L_0x01a8:
        r14 = move-exception;
        r2 = "ShutdownThread";
        r5 = "Exception during MountService shutdown";
        android.util.Log.e(r2, r5, r14);	 Catch:{ all -> 0x01b1 }
        goto L_0x0154;
    L_0x01b1:
        r2 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x01b1 }
        throw r2;
    L_0x01b4:
        r0 = r26;
        r2 = r0.mActionDoneSync;	 Catch:{ InterruptedException -> 0x01bc }
        r2.wait(r12);	 Catch:{ InterruptedException -> 0x01bc }
        goto L_0x0154;
    L_0x01bc:
        r2 = move-exception;
        goto L_0x0154;
    L_0x01be:
        r2 = move-exception;
        goto L_0x009e;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.power.ShutdownThread.run():void");
    }

    private void shutdownRadios(int timeout) {
        boolean[] done = new boolean[1];
        Thread t = new C04765(SystemClock.elapsedRealtime() + ((long) timeout), done);
        t.start();
        try {
            t.join((long) timeout);
        } catch (InterruptedException e) {
        }
        if (!done[0]) {
            Log.w(TAG, "Timed out waiting for NFC, Radio and Bluetooth shutdown.");
        }
    }

    public static void rebootOrShutdown(Context context, boolean reboot, String reason) {
        deviceRebootOrShutdown(reboot, reason);
        if (reboot) {
            Log.i(TAG, "Rebooting, reason: " + reason);
            PowerManagerService.lowLevelReboot(reason);
            Log.e(TAG, "Reboot failed, will attempt shutdown instead");
        } else if (context != null) {
            try {
                new SystemVibrator(context).vibrate(500, VIBRATION_ATTRIBUTES);
            } catch (Exception e) {
                Log.w(TAG, "Failed to vibrate during shutdown.", e);
            }
            try {
                Thread.sleep(500);
            } catch (InterruptedException e2) {
            }
        }
        Log.i(TAG, "Performing low-level shutdown...");
        PowerManagerService.lowLevelShutdown();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private static void deviceRebootOrShutdown(boolean r10, java.lang.String r11) {
        /*
        r5 = new dalvik.system.PathClassLoader;
        r6 = "/system/framework/oem-services.jar";
        r7 = java.lang.ClassLoader.getSystemClassLoader();
        r5.<init>(r6, r7);
        r1 = "com.qti.server.power.ShutdownOem";
        r0 = java.lang.Class.forName(r1);	 Catch:{ ClassNotFoundException -> 0x0053, Exception -> 0x0076 }
        r6 = "rebootOrShutdown";
        r7 = 2;
        r7 = new java.lang.Class[r7];	 Catch:{ NoSuchMethodException -> 0x0039, Exception -> 0x006d, ClassNotFoundException -> 0x0053 }
        r8 = 0;
        r9 = java.lang.Boolean.TYPE;	 Catch:{ NoSuchMethodException -> 0x0039, Exception -> 0x006d, ClassNotFoundException -> 0x0053 }
        r7[r8] = r9;	 Catch:{ NoSuchMethodException -> 0x0039, Exception -> 0x006d, ClassNotFoundException -> 0x0053 }
        r8 = 1;
        r9 = java.lang.String.class;
        r7[r8] = r9;	 Catch:{ NoSuchMethodException -> 0x0039, Exception -> 0x006d, ClassNotFoundException -> 0x0053 }
        r4 = r0.getMethod(r6, r7);	 Catch:{ NoSuchMethodException -> 0x0039, Exception -> 0x006d, ClassNotFoundException -> 0x0053 }
        r6 = r0.newInstance();	 Catch:{ NoSuchMethodException -> 0x0039, Exception -> 0x006d, ClassNotFoundException -> 0x0053 }
        r7 = 2;
        r7 = new java.lang.Object[r7];	 Catch:{ NoSuchMethodException -> 0x0039, Exception -> 0x006d, ClassNotFoundException -> 0x0053 }
        r8 = 0;
        r9 = java.lang.Boolean.valueOf(r10);	 Catch:{ NoSuchMethodException -> 0x0039, Exception -> 0x006d, ClassNotFoundException -> 0x0053 }
        r7[r8] = r9;	 Catch:{ NoSuchMethodException -> 0x0039, Exception -> 0x006d, ClassNotFoundException -> 0x0053 }
        r8 = 1;
        r7[r8] = r11;	 Catch:{ NoSuchMethodException -> 0x0039, Exception -> 0x006d, ClassNotFoundException -> 0x0053 }
        r4.invoke(r6, r7);	 Catch:{ NoSuchMethodException -> 0x0039, Exception -> 0x006d, ClassNotFoundException -> 0x0053 }
    L_0x0038:
        return;
    L_0x0039:
        r3 = move-exception;
        r6 = "ShutdownThread";
        r7 = new java.lang.StringBuilder;	 Catch:{ ClassNotFoundException -> 0x0053, Exception -> 0x0076 }
        r7.<init>();	 Catch:{ ClassNotFoundException -> 0x0053, Exception -> 0x0076 }
        r8 = "rebootOrShutdown method not found in class ";
        r7 = r7.append(r8);	 Catch:{ ClassNotFoundException -> 0x0053, Exception -> 0x0076 }
        r7 = r7.append(r1);	 Catch:{ ClassNotFoundException -> 0x0053, Exception -> 0x0076 }
        r7 = r7.toString();	 Catch:{ ClassNotFoundException -> 0x0053, Exception -> 0x0076 }
        android.util.Log.e(r6, r7);	 Catch:{ ClassNotFoundException -> 0x0053, Exception -> 0x0076 }
        goto L_0x0038;
    L_0x0053:
        r2 = move-exception;
        r6 = "ShutdownThread";
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "Unable to find class ";
        r7 = r7.append(r8);
        r7 = r7.append(r1);
        r7 = r7.toString();
        android.util.Log.e(r6, r7);
        goto L_0x0038;
    L_0x006d:
        r3 = move-exception;
        r6 = "ShutdownThread";
        r7 = "Unknown exception hit while trying to invoke rebootOrShutdown";
        android.util.Log.e(r6, r7);	 Catch:{ ClassNotFoundException -> 0x0053, Exception -> 0x0076 }
        goto L_0x0038;
    L_0x0076:
        r2 = move-exception;
        r6 = "ShutdownThread";
        r7 = "Unknown exception while trying to invoke rebootOrShutdown";
        android.util.Log.e(r6, r7);
        goto L_0x0038;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.power.ShutdownThread.deviceRebootOrShutdown(boolean, java.lang.String):void");
    }

    private static boolean checkAnimationFileExist() {
        if (new File(OEM_BOOTANIMATION_FILE).exists() || new File(SYSTEM_BOOTANIMATION_FILE).exists() || new File(SYSTEM_ENCRYPTED_BOOTANIMATION_FILE).exists()) {
            return true;
        }
        return false;
    }

    private static boolean isSilentMode() {
        return mAudioManager.isSilentMode();
    }

    private static void showShutdownAnimation() {
        SystemProperties.set("service.bootanim.exit", "0");
        SystemProperties.set("ctl.start", "bootanim");
    }
}
