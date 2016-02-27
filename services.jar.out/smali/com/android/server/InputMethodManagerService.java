package com.android.server;

import android.app.ActivityManagerNative;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.app.AppGlobals;
import android.app.AppOpsManager;
import android.app.IUserSwitchObserver;
import android.app.KeyguardManager;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnCancelListener;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.pm.ApplicationInfo;
import android.content.pm.IPackageManager;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.content.pm.UserInfo;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.database.ContentObserver;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Binder;
import android.os.Environment;
import android.os.Handler;
import android.os.Handler.Callback;
import android.os.IBinder;
import android.os.IInterface;
import android.os.IRemoteCallback;
import android.os.Message;
import android.os.Parcel;
import android.os.RemoteException;
import android.os.ResultReceiver;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.UserManager;
import android.provider.Settings.Secure;
import android.text.TextUtils;
import android.text.style.SuggestionSpan;
import android.util.AtomicFile;
import android.util.EventLog;
import android.util.LruCache;
import android.util.Pair;
import android.util.PrintWriterPrinter;
import android.util.Printer;
import android.util.Slog;
import android.view.ContextThemeWrapper;
import android.view.IWindowManager;
import android.view.InputChannel;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager.LayoutParams;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputBinding;
import android.view.inputmethod.InputMethodInfo;
import android.view.inputmethod.InputMethodSubtype;
import android.widget.ArrayAdapter;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.RadioButton;
import android.widget.Switch;
import android.widget.TextView;
import com.android.internal.R;
import com.android.internal.content.PackageMonitor;
import com.android.internal.inputmethod.InputMethodSubtypeSwitchingController;
import com.android.internal.inputmethod.InputMethodSubtypeSwitchingController.ImeSubtypeListItem;
import com.android.internal.inputmethod.InputMethodUtils;
import com.android.internal.inputmethod.InputMethodUtils.InputMethodSettings;
import com.android.internal.os.HandlerCaller;
import com.android.internal.os.SomeArgs;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.view.IInputContext;
import com.android.internal.view.IInputMethod;
import com.android.internal.view.IInputMethodClient;
import com.android.internal.view.IInputMethodManager.Stub;
import com.android.internal.view.IInputMethodSession;
import com.android.internal.view.IInputSessionCallback;
import com.android.internal.view.InputBindResult;
import com.android.server.statusbar.StatusBarManagerService;
import com.android.server.wm.WindowManagerService;
import com.android.server.wm.WindowManagerService.OnHardKeyboardStatusChangeListener;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class InputMethodManagerService extends Stub implements ServiceConnection, Callback {
    static final boolean DEBUG = false;
    static final int MSG_ATTACH_TOKEN = 1040;
    static final int MSG_BIND_INPUT = 1010;
    static final int MSG_BIND_METHOD = 3010;
    static final int MSG_CREATE_SESSION = 1050;
    static final int MSG_HARD_KEYBOARD_SWITCH_CHANGED = 4000;
    static final int MSG_HIDE_SOFT_INPUT = 1030;
    static final int MSG_RESTART_INPUT = 2010;
    static final int MSG_SET_ACTIVE = 3020;
    static final int MSG_SET_USER_ACTION_NOTIFICATION_SEQUENCE_NUMBER = 3040;
    static final int MSG_SHOW_IM_CONFIG = 4;
    static final int MSG_SHOW_IM_PICKER = 1;
    static final int MSG_SHOW_IM_SUBTYPE_ENABLER = 3;
    static final int MSG_SHOW_IM_SUBTYPE_PICKER = 2;
    static final int MSG_SHOW_SOFT_INPUT = 1020;
    static final int MSG_START_INPUT = 2000;
    static final int MSG_UNBIND_INPUT = 1000;
    static final int MSG_UNBIND_METHOD = 3000;
    private static final int NOT_A_SUBTYPE_ID = -1;
    static final int SECURE_SUGGESTION_SPANS_MAX_SIZE = 20;
    static final String TAG = "InputMethodManagerService";
    private static final String TAG_TRY_SUPPRESSING_IME_SWITCHER = "TrySuppressingImeSwitcher";
    static final long TIME_TO_RECONNECT = 3000;
    private final AppOpsManager mAppOpsManager;
    int mBackDisposition;
    boolean mBoundToMethod;
    final HandlerCaller mCaller;
    final HashMap<IBinder, ClientState> mClients;
    final Context mContext;
    EditorInfo mCurAttribute;
    ClientState mCurClient;
    private boolean mCurClientInKeyguard;
    IBinder mCurFocusedWindow;
    String mCurId;
    IInputContext mCurInputContext;
    Intent mCurIntent;
    IInputMethod mCurMethod;
    String mCurMethodId;
    int mCurSeq;
    IBinder mCurToken;
    int mCurUserActionNotificationSequenceNumber;
    private InputMethodSubtype mCurrentSubtype;
    private Builder mDialogBuilder;
    SessionState mEnabledSession;
    private InputMethodFileManager mFileManager;
    final Handler mHandler;
    private final HardKeyboardListener mHardKeyboardListener;
    final boolean mHasFeature;
    boolean mHaveConnection;
    private final IPackageManager mIPackageManager;
    final IWindowManager mIWindowManager;
    private final boolean mImeSelectedOnBoot;
    private PendingIntent mImeSwitchPendingIntent;
    private Notification mImeSwitcherNotification;
    int mImeWindowVis;
    private InputMethodInfo[] mIms;
    boolean mInputShown;
    private KeyguardManager mKeyguardManager;
    long mLastBindTime;
    private Locale mLastSystemLocale;
    final ArrayList<InputMethodInfo> mMethodList;
    final HashMap<String, InputMethodInfo> mMethodMap;
    private final MyPackageMonitor mMyPackageMonitor;
    final InputBindResult mNoBinding;
    private NotificationManager mNotificationManager;
    private boolean mNotificationShown;
    final Resources mRes;
    boolean mScreenOn;
    private final LruCache<SuggestionSpan, InputMethodInfo> mSecureSuggestionSpans;
    final InputMethodSettings mSettings;
    final SettingsObserver mSettingsObserver;
    private final HashMap<InputMethodInfo, ArrayList<InputMethodSubtype>> mShortcutInputMethodsAndSubtypes;
    boolean mShowExplicitlyRequested;
    boolean mShowForced;
    private boolean mShowImeWithHardKeyboard;
    private boolean mShowOngoingImeSwitcherForPhones;
    boolean mShowRequested;
    private StatusBarManagerService mStatusBar;
    private int[] mSubtypeIds;
    private final InputMethodSubtypeSwitchingController mSwitchingController;
    private AlertDialog mSwitchingDialog;
    private View mSwitchingDialogTitleView;
    boolean mSystemReady;
    boolean mVisibleBound;
    final ServiceConnection mVisibleConnection;
    private final WindowManagerService mWindowManagerService;

    /* renamed from: com.android.server.InputMethodManagerService.1 */
    class C00411 implements ServiceConnection {
        C00411() {
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
        }

        public void onServiceDisconnected(ComponentName name) {
        }
    }

    /* renamed from: com.android.server.InputMethodManagerService.2 */
    class C00422 implements HandlerCaller.Callback {
        C00422() {
        }

        public void executeMessage(Message msg) {
            InputMethodManagerService.this.handleMessage(msg);
        }
    }

    /* renamed from: com.android.server.InputMethodManagerService.3 */
    class C00433 extends IUserSwitchObserver.Stub {
        C00433() {
        }

        public void onUserSwitching(int newUserId, IRemoteCallback reply) {
            synchronized (InputMethodManagerService.this.mMethodMap) {
                InputMethodManagerService.this.switchUserLocked(newUserId);
            }
            if (reply != null) {
                try {
                    reply.sendResult(null);
                } catch (RemoteException e) {
                }
            }
        }

        public void onUserSwitchComplete(int newUserId) throws RemoteException {
        }
    }

    /* renamed from: com.android.server.InputMethodManagerService.4 */
    class C00444 extends BroadcastReceiver {
        C00444() {
        }

        public void onReceive(Context context, Intent intent) {
            synchronized (InputMethodManagerService.this.mMethodMap) {
                InputMethodManagerService.this.resetStateIfCurrentLocaleChangedLocked();
            }
        }
    }

    /* renamed from: com.android.server.InputMethodManagerService.5 */
    class C00455 implements OnCancelListener {
        C00455() {
        }

        public void onCancel(DialogInterface dialog) {
            InputMethodManagerService.this.hideInputMethodMenu();
        }
    }

    /* renamed from: com.android.server.InputMethodManagerService.6 */
    class C00466 implements OnCheckedChangeListener {
        C00466() {
        }

        public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
            InputMethodManagerService.this.mSettings.setShowImeWithHardKeyboard(isChecked);
            InputMethodManagerService.this.hideInputMethodMenu();
        }
    }

    /* renamed from: com.android.server.InputMethodManagerService.7 */
    class C00477 implements OnClickListener {
        final /* synthetic */ ImeSubtypeListAdapter val$adapter;

        C00477(ImeSubtypeListAdapter imeSubtypeListAdapter) {
            this.val$adapter = imeSubtypeListAdapter;
        }

        public void onClick(DialogInterface dialog, int which) {
            synchronized (InputMethodManagerService.this.mMethodMap) {
                if (InputMethodManagerService.this.mIms == null || InputMethodManagerService.this.mIms.length <= which || InputMethodManagerService.this.mSubtypeIds == null || InputMethodManagerService.this.mSubtypeIds.length <= which) {
                    return;
                }
                InputMethodInfo im = InputMethodManagerService.this.mIms[which];
                int subtypeId = InputMethodManagerService.this.mSubtypeIds[which];
                this.val$adapter.mCheckedItem = which;
                this.val$adapter.notifyDataSetChanged();
                InputMethodManagerService.this.hideInputMethodMenu();
                if (im != null) {
                    if (subtypeId < 0 || subtypeId >= im.getSubtypeCount()) {
                        subtypeId = InputMethodManagerService.NOT_A_SUBTYPE_ID;
                    }
                    InputMethodManagerService.this.setInputMethodLocked(im.getId(), subtypeId);
                }
            }
        }
    }

    /* renamed from: com.android.server.InputMethodManagerService.8 */
    class C00488 implements OnClickListener {
        C00488() {
        }

        public void onClick(DialogInterface dialog, int whichButton) {
            InputMethodManagerService.this.showConfigureInputMethods();
        }
    }

    static final class ClientState {
        final InputBinding binding;
        final IInputMethodClient client;
        SessionState curSession;
        final IInputContext inputContext;
        final int pid;
        boolean sessionRequested;
        final int uid;

        public String toString() {
            return "ClientState{" + Integer.toHexString(System.identityHashCode(this)) + " uid " + this.uid + " pid " + this.pid + "}";
        }

        ClientState(IInputMethodClient _client, IInputContext _inputContext, int _uid, int _pid) {
            this.client = _client;
            this.inputContext = _inputContext;
            this.uid = _uid;
            this.pid = _pid;
            this.binding = new InputBinding(null, this.inputContext.asBinder(), this.uid, this.pid);
        }
    }

    private class HardKeyboardListener implements OnHardKeyboardStatusChangeListener {
        private HardKeyboardListener() {
        }

        public void onHardKeyboardStatusChange(boolean available) {
            InputMethodManagerService.this.mHandler.sendMessage(InputMethodManagerService.this.mHandler.obtainMessage(InputMethodManagerService.MSG_HARD_KEYBOARD_SWITCH_CHANGED, Integer.valueOf(available ? InputMethodManagerService.MSG_SHOW_IM_PICKER : 0)));
        }

        public void handleHardKeyboardStatusChange(boolean available) {
            synchronized (InputMethodManagerService.this.mMethodMap) {
                if (!(InputMethodManagerService.this.mSwitchingDialog == null || InputMethodManagerService.this.mSwitchingDialogTitleView == null || !InputMethodManagerService.this.mSwitchingDialog.isShowing())) {
                    InputMethodManagerService.this.mSwitchingDialogTitleView.findViewById(16909074).setVisibility(available ? 0 : 8);
                }
            }
        }
    }

    private static class ImeSubtypeListAdapter extends ArrayAdapter<ImeSubtypeListItem> {
        public int mCheckedItem;
        private final LayoutInflater mInflater;
        private final List<ImeSubtypeListItem> mItemsList;
        private final int mTextViewResourceId;

        public ImeSubtypeListAdapter(Context context, int textViewResourceId, List<ImeSubtypeListItem> itemsList, int checkedItem) {
            super(context, textViewResourceId, itemsList);
            this.mTextViewResourceId = textViewResourceId;
            this.mItemsList = itemsList;
            this.mCheckedItem = checkedItem;
            this.mInflater = (LayoutInflater) context.getSystemService("layout_inflater");
        }

        public View getView(int position, View convertView, ViewGroup parent) {
            boolean z = InputMethodManagerService.DEBUG;
            View view = convertView != null ? convertView : this.mInflater.inflate(this.mTextViewResourceId, null);
            if (position >= 0 && position < this.mItemsList.size()) {
                ImeSubtypeListItem item = (ImeSubtypeListItem) this.mItemsList.get(position);
                CharSequence imeName = item.mImeName;
                CharSequence subtypeName = item.mSubtypeName;
                TextView firstTextView = (TextView) view.findViewById(16908308);
                TextView secondTextView = (TextView) view.findViewById(16908309);
                if (TextUtils.isEmpty(subtypeName)) {
                    firstTextView.setText(imeName);
                    secondTextView.setVisibility(8);
                } else {
                    firstTextView.setText(subtypeName);
                    secondTextView.setText(imeName);
                    secondTextView.setVisibility(0);
                }
                RadioButton radioButton = (RadioButton) view.findViewById(16909076);
                if (position == this.mCheckedItem) {
                    z = true;
                }
                radioButton.setChecked(z);
            }
            return view;
        }
    }

    class ImmsBroadcastReceiver extends BroadcastReceiver {
        ImmsBroadcastReceiver() {
        }

        private void updateActive() {
            if (InputMethodManagerService.this.mCurClient != null && InputMethodManagerService.this.mCurClient.client != null) {
                InputMethodManagerService.this.executeOrSendMessage(InputMethodManagerService.this.mCurClient.client, InputMethodManagerService.this.mCaller.obtainMessageIO(InputMethodManagerService.MSG_SET_ACTIVE, InputMethodManagerService.this.mScreenOn ? InputMethodManagerService.MSG_SHOW_IM_PICKER : 0, InputMethodManagerService.this.mCurClient));
            }
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if ("android.intent.action.SCREEN_ON".equals(action)) {
                InputMethodManagerService.this.mScreenOn = true;
                InputMethodManagerService.this.refreshImeWindowVisibilityLocked();
                updateActive();
            } else if ("android.intent.action.SCREEN_OFF".equals(action)) {
                InputMethodManagerService.this.mScreenOn = InputMethodManagerService.DEBUG;
                InputMethodManagerService.this.setImeWindowVisibilityStatusHiddenLocked();
                updateActive();
            } else if ("android.intent.action.CLOSE_SYSTEM_DIALOGS".equals(action)) {
                InputMethodManagerService.this.hideInputMethodMenu();
            } else if ("android.intent.action.USER_ADDED".equals(action) || "android.intent.action.USER_REMOVED".equals(action)) {
                InputMethodManagerService.this.updateCurrentProfileIds();
            } else {
                Slog.w(InputMethodManagerService.TAG, "Unexpected intent " + intent);
            }
        }
    }

    private static class InputMethodFileManager {
        private static final String ADDITIONAL_SUBTYPES_FILE_NAME = "subtypes.xml";
        private static final String ATTR_ICON = "icon";
        private static final String ATTR_ID = "id";
        private static final String ATTR_IME_SUBTYPE_EXTRA_VALUE = "imeSubtypeExtraValue";
        private static final String ATTR_IME_SUBTYPE_LOCALE = "imeSubtypeLocale";
        private static final String ATTR_IME_SUBTYPE_MODE = "imeSubtypeMode";
        private static final String ATTR_IS_AUXILIARY = "isAuxiliary";
        private static final String ATTR_LABEL = "label";
        private static final String INPUT_METHOD_PATH = "inputmethod";
        private static final String NODE_IMI = "imi";
        private static final String NODE_SUBTYPE = "subtype";
        private static final String NODE_SUBTYPES = "subtypes";
        private static final String SYSTEM_PATH = "system";
        private final AtomicFile mAdditionalInputMethodSubtypeFile;
        private final HashMap<String, List<InputMethodSubtype>> mAdditionalSubtypesMap;
        private final HashMap<String, InputMethodInfo> mMethodMap;

        public InputMethodFileManager(HashMap<String, InputMethodInfo> methodMap, int userId) {
            this.mAdditionalSubtypesMap = new HashMap();
            if (methodMap == null) {
                throw new NullPointerException("methodMap is null");
            }
            this.mMethodMap = methodMap;
            File inputMethodDir = new File(userId == 0 ? new File(Environment.getDataDirectory(), SYSTEM_PATH) : Environment.getUserSystemDirectory(userId), INPUT_METHOD_PATH);
            if (!inputMethodDir.mkdirs()) {
                Slog.w(InputMethodManagerService.TAG, "Couldn't create dir.: " + inputMethodDir.getAbsolutePath());
            }
            File subtypeFile = new File(inputMethodDir, ADDITIONAL_SUBTYPES_FILE_NAME);
            this.mAdditionalInputMethodSubtypeFile = new AtomicFile(subtypeFile);
            if (subtypeFile.exists()) {
                readAdditionalInputMethodSubtypes(this.mAdditionalSubtypesMap, this.mAdditionalInputMethodSubtypeFile);
            } else {
                writeAdditionalInputMethodSubtypes(this.mAdditionalSubtypesMap, this.mAdditionalInputMethodSubtypeFile, methodMap);
            }
        }

        private void deleteAllInputMethodSubtypes(String imiId) {
            synchronized (this.mMethodMap) {
                this.mAdditionalSubtypesMap.remove(imiId);
                writeAdditionalInputMethodSubtypes(this.mAdditionalSubtypesMap, this.mAdditionalInputMethodSubtypeFile, this.mMethodMap);
            }
        }

        public void addInputMethodSubtypes(InputMethodInfo imi, InputMethodSubtype[] additionalSubtypes) {
            synchronized (this.mMethodMap) {
                ArrayList<InputMethodSubtype> subtypes = new ArrayList();
                int N = additionalSubtypes.length;
                for (int i = 0; i < N; i += InputMethodManagerService.MSG_SHOW_IM_PICKER) {
                    InputMethodSubtype subtype = additionalSubtypes[i];
                    if (subtypes.contains(subtype)) {
                        Slog.w(InputMethodManagerService.TAG, "Duplicated subtype definition found: " + subtype.getLocale() + ", " + subtype.getMode());
                    } else {
                        subtypes.add(subtype);
                    }
                }
                this.mAdditionalSubtypesMap.put(imi.getId(), subtypes);
                writeAdditionalInputMethodSubtypes(this.mAdditionalSubtypesMap, this.mAdditionalInputMethodSubtypeFile, this.mMethodMap);
            }
        }

        public HashMap<String, List<InputMethodSubtype>> getAllAdditionalInputMethodSubtypes() {
            HashMap<String, List<InputMethodSubtype>> hashMap;
            synchronized (this.mMethodMap) {
                hashMap = this.mAdditionalSubtypesMap;
            }
            return hashMap;
        }

        private static void writeAdditionalInputMethodSubtypes(HashMap<String, List<InputMethodSubtype>> allSubtypes, AtomicFile subtypesFile, HashMap<String, InputMethodInfo> methodMap) {
            boolean isSetMethodMap = (methodMap == null || methodMap.size() <= 0) ? InputMethodManagerService.DEBUG : true;
            FileOutputStream fos = null;
            try {
                fos = subtypesFile.startWrite();
                XmlSerializer out = new FastXmlSerializer();
                out.setOutput(fos, StandardCharsets.UTF_8.name());
                out.startDocument(null, Boolean.valueOf(true));
                out.setFeature("http://xmlpull.org/v1/doc/features.html#indent-output", true);
                out.startTag(null, NODE_SUBTYPES);
                for (String imiId : allSubtypes.keySet()) {
                    if (!isSetMethodMap || methodMap.containsKey(imiId)) {
                        out.startTag(null, NODE_IMI);
                        out.attribute(null, ATTR_ID, imiId);
                        List<InputMethodSubtype> subtypesList = (List) allSubtypes.get(imiId);
                        int N = subtypesList.size();
                        for (int i = 0; i < N; i += InputMethodManagerService.MSG_SHOW_IM_PICKER) {
                            InputMethodSubtype subtype = (InputMethodSubtype) subtypesList.get(i);
                            out.startTag(null, NODE_SUBTYPE);
                            out.attribute(null, ATTR_ICON, String.valueOf(subtype.getIconResId()));
                            out.attribute(null, ATTR_LABEL, String.valueOf(subtype.getNameResId()));
                            out.attribute(null, ATTR_IME_SUBTYPE_LOCALE, subtype.getLocale());
                            out.attribute(null, ATTR_IME_SUBTYPE_MODE, subtype.getMode());
                            out.attribute(null, ATTR_IME_SUBTYPE_EXTRA_VALUE, subtype.getExtraValue());
                            out.attribute(null, ATTR_IS_AUXILIARY, String.valueOf(subtype.isAuxiliary() ? InputMethodManagerService.MSG_SHOW_IM_PICKER : 0));
                            out.endTag(null, NODE_SUBTYPE);
                        }
                        out.endTag(null, NODE_IMI);
                    } else {
                        Slog.w(InputMethodManagerService.TAG, "IME uninstalled or not valid.: " + imiId);
                    }
                }
                out.endTag(null, NODE_SUBTYPES);
                out.endDocument();
                subtypesFile.finishWrite(fos);
            } catch (IOException e) {
                Slog.w(InputMethodManagerService.TAG, "Error writing subtypes", e);
                if (fos != null) {
                    subtypesFile.failWrite(fos);
                }
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private static void readAdditionalInputMethodSubtypes(java.util.HashMap<java.lang.String, java.util.List<android.view.inputmethod.InputMethodSubtype>> r22, android.util.AtomicFile r23) {
            /*
            if (r22 == 0) goto L_0x0004;
        L_0x0002:
            if (r23 != 0) goto L_0x0005;
        L_0x0004:
            return;
        L_0x0005:
            r22.clear();
            r7 = 0;
            r7 = r23.openRead();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r15 = android.util.Xml.newPullParser();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = r19.name();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r0 = r19;
            r15.setInput(r7, r0);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r18 = r15.getEventType();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
        L_0x0020:
            r18 = r15.next();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = 2;
            r0 = r18;
            r1 = r19;
            if (r0 == r1) goto L_0x0034;
        L_0x002c:
            r19 = 1;
            r0 = r18;
            r1 = r19;
            if (r0 != r1) goto L_0x0020;
        L_0x0034:
            r6 = r15.getName();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = "subtypes";
            r0 = r19;
            r19 = r0.equals(r6);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            if (r19 != 0) goto L_0x0074;
        L_0x0042:
            r19 = new org.xmlpull.v1.XmlPullParserException;	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r20 = "Xml doesn't start with subtypes";
            r19.<init>(r20);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            throw r19;	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
        L_0x004a:
            r4 = move-exception;
            r19 = "InputMethodManagerService";
            r20 = new java.lang.StringBuilder;	 Catch:{ all -> 0x015b }
            r20.<init>();	 Catch:{ all -> 0x015b }
            r21 = "Error reading subtypes: ";
            r20 = r20.append(r21);	 Catch:{ all -> 0x015b }
            r0 = r20;
            r20 = r0.append(r4);	 Catch:{ all -> 0x015b }
            r20 = r20.toString();	 Catch:{ all -> 0x015b }
            android.util.Slog.w(r19, r20);	 Catch:{ all -> 0x015b }
            if (r7 == 0) goto L_0x0004;
        L_0x0067:
            r7.close();	 Catch:{ IOException -> 0x006b }
            goto L_0x0004;
        L_0x006b:
            r5 = move-exception;
            r19 = "InputMethodManagerService";
            r20 = "Failed to close.";
            android.util.Slog.w(r19, r20);
            goto L_0x0004;
        L_0x0074:
            r3 = r15.getDepth();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r2 = 0;
            r17 = 0;
        L_0x007b:
            r18 = r15.next();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = 3;
            r0 = r18;
            r1 = r19;
            if (r0 != r1) goto L_0x008f;
        L_0x0087:
            r19 = r15.getDepth();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r0 = r19;
            if (r0 <= r3) goto L_0x01fa;
        L_0x008f:
            r19 = 1;
            r0 = r18;
            r1 = r19;
            if (r0 == r1) goto L_0x01fa;
        L_0x0097:
            r19 = 2;
            r0 = r18;
            r1 = r19;
            if (r0 != r1) goto L_0x007b;
        L_0x009f:
            r14 = r15.getName();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = "imi";
            r0 = r19;
            r19 = r0.equals(r14);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            if (r19 == 0) goto L_0x012d;
        L_0x00ad:
            r19 = 0;
            r20 = "id";
            r0 = r19;
            r1 = r20;
            r2 = r15.getAttributeValue(r0, r1);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = android.text.TextUtils.isEmpty(r2);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            if (r19 == 0) goto L_0x00f3;
        L_0x00bf:
            r19 = "InputMethodManagerService";
            r20 = "Invalid imi id found in subtypes.xml";
            android.util.Slog.w(r19, r20);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            goto L_0x007b;
        L_0x00c7:
            r4 = move-exception;
            r19 = "InputMethodManagerService";
            r20 = new java.lang.StringBuilder;	 Catch:{ all -> 0x015b }
            r20.<init>();	 Catch:{ all -> 0x015b }
            r21 = "Error reading subtypes: ";
            r20 = r20.append(r21);	 Catch:{ all -> 0x015b }
            r0 = r20;
            r20 = r0.append(r4);	 Catch:{ all -> 0x015b }
            r20 = r20.toString();	 Catch:{ all -> 0x015b }
            android.util.Slog.w(r19, r20);	 Catch:{ all -> 0x015b }
            if (r7 == 0) goto L_0x0004;
        L_0x00e4:
            r7.close();	 Catch:{ IOException -> 0x00e9 }
            goto L_0x0004;
        L_0x00e9:
            r5 = move-exception;
            r19 = "InputMethodManagerService";
            r20 = "Failed to close.";
            android.util.Slog.w(r19, r20);
            goto L_0x0004;
        L_0x00f3:
            r17 = new java.util.ArrayList;	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r17.<init>();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r0 = r22;
            r1 = r17;
            r0.put(r2, r1);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            goto L_0x007b;
        L_0x0101:
            r4 = move-exception;
            r19 = "InputMethodManagerService";
            r20 = new java.lang.StringBuilder;	 Catch:{ all -> 0x015b }
            r20.<init>();	 Catch:{ all -> 0x015b }
            r21 = "Error reading subtypes: ";
            r20 = r20.append(r21);	 Catch:{ all -> 0x015b }
            r0 = r20;
            r20 = r0.append(r4);	 Catch:{ all -> 0x015b }
            r20 = r20.toString();	 Catch:{ all -> 0x015b }
            android.util.Slog.w(r19, r20);	 Catch:{ all -> 0x015b }
            if (r7 == 0) goto L_0x0004;
        L_0x011e:
            r7.close();	 Catch:{ IOException -> 0x0123 }
            goto L_0x0004;
        L_0x0123:
            r5 = move-exception;
            r19 = "InputMethodManagerService";
            r20 = "Failed to close.";
            android.util.Slog.w(r19, r20);
            goto L_0x0004;
        L_0x012d:
            r19 = "subtype";
            r0 = r19;
            r19 = r0.equals(r14);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            if (r19 == 0) goto L_0x007b;
        L_0x0137:
            r19 = android.text.TextUtils.isEmpty(r2);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            if (r19 != 0) goto L_0x013f;
        L_0x013d:
            if (r17 != 0) goto L_0x0162;
        L_0x013f:
            r19 = "InputMethodManagerService";
            r20 = new java.lang.StringBuilder;	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r20.<init>();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r21 = "IME uninstalled or not valid.: ";
            r20 = r20.append(r21);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r0 = r20;
            r20 = r0.append(r2);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r20 = r20.toString();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            android.util.Slog.w(r19, r20);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            goto L_0x007b;
        L_0x015b:
            r19 = move-exception;
            if (r7 == 0) goto L_0x0161;
        L_0x015e:
            r7.close();	 Catch:{ IOException -> 0x020b }
        L_0x0161:
            throw r19;
        L_0x0162:
            r19 = 0;
            r20 = "icon";
            r0 = r19;
            r1 = r20;
            r19 = r15.getAttributeValue(r0, r1);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = java.lang.Integer.valueOf(r19);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r8 = r19.intValue();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = 0;
            r20 = "label";
            r0 = r19;
            r1 = r20;
            r19 = r15.getAttributeValue(r0, r1);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = java.lang.Integer.valueOf(r19);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r13 = r19.intValue();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = 0;
            r20 = "imeSubtypeLocale";
            r0 = r19;
            r1 = r20;
            r10 = r15.getAttributeValue(r0, r1);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = 0;
            r20 = "imeSubtypeMode";
            r0 = r19;
            r1 = r20;
            r11 = r15.getAttributeValue(r0, r1);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = 0;
            r20 = "imeSubtypeExtraValue";
            r0 = r19;
            r1 = r20;
            r9 = r15.getAttributeValue(r0, r1);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = "1";
            r20 = 0;
            r21 = "isAuxiliary";
            r0 = r20;
            r1 = r21;
            r20 = r15.getAttributeValue(r0, r1);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r20 = java.lang.String.valueOf(r20);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r12 = r19.equals(r20);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19 = new android.view.inputmethod.InputMethodSubtype$InputMethodSubtypeBuilder;	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r19.<init>();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r0 = r19;
            r19 = r0.setSubtypeNameResId(r13);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r0 = r19;
            r19 = r0.setSubtypeIconResId(r8);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r0 = r19;
            r19 = r0.setSubtypeLocale(r10);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r0 = r19;
            r19 = r0.setSubtypeMode(r11);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r0 = r19;
            r19 = r0.setSubtypeExtraValue(r9);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r0 = r19;
            r19 = r0.setIsAuxiliary(r12);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r16 = r19.build();	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            r0 = r17;
            r1 = r16;
            r0.add(r1);	 Catch:{ XmlPullParserException -> 0x004a, IOException -> 0x00c7, NumberFormatException -> 0x0101 }
            goto L_0x007b;
        L_0x01fa:
            if (r7 == 0) goto L_0x0004;
        L_0x01fc:
            r7.close();	 Catch:{ IOException -> 0x0201 }
            goto L_0x0004;
        L_0x0201:
            r5 = move-exception;
            r19 = "InputMethodManagerService";
            r20 = "Failed to close.";
            android.util.Slog.w(r19, r20);
            goto L_0x0004;
        L_0x020b:
            r5 = move-exception;
            r20 = "InputMethodManagerService";
            r21 = "Failed to close.";
            android.util.Slog.w(r20, r21);
            goto L_0x0161;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.InputMethodManagerService.InputMethodFileManager.readAdditionalInputMethodSubtypes(java.util.HashMap, android.util.AtomicFile):void");
        }
    }

    private static final class MethodCallback extends IInputSessionCallback.Stub {
        private final InputChannel mChannel;
        private final IInputMethod mMethod;
        private final InputMethodManagerService mParentIMMS;

        MethodCallback(InputMethodManagerService imms, IInputMethod method, InputChannel channel) {
            this.mParentIMMS = imms;
            this.mMethod = method;
            this.mChannel = channel;
        }

        public void sessionCreated(IInputMethodSession session) {
            long ident = Binder.clearCallingIdentity();
            try {
                this.mParentIMMS.onSessionCreated(this.mMethod, session, this.mChannel);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    class MyPackageMonitor extends PackageMonitor {
        MyPackageMonitor() {
        }

        private boolean isChangingPackagesOfCurrentUser() {
            return getChangingUserId() == InputMethodManagerService.this.mSettings.getCurrentUserId() ? true : InputMethodManagerService.DEBUG;
        }

        public boolean onHandleForceStop(Intent intent, String[] packages, int uid, boolean doit) {
            if (!isChangingPackagesOfCurrentUser()) {
                return InputMethodManagerService.DEBUG;
            }
            synchronized (InputMethodManagerService.this.mMethodMap) {
                String curInputMethodId = InputMethodManagerService.this.mSettings.getSelectedInputMethod();
                int N = InputMethodManagerService.this.mMethodList.size();
                if (curInputMethodId != null) {
                    for (int i = 0; i < N; i += InputMethodManagerService.MSG_SHOW_IM_PICKER) {
                        InputMethodInfo imi = (InputMethodInfo) InputMethodManagerService.this.mMethodList.get(i);
                        if (imi.getId().equals(curInputMethodId)) {
                            String[] arr$ = packages;
                            int len$ = arr$.length;
                            int i$ = 0;
                            while (i$ < len$) {
                                if (!imi.getPackageName().equals(arr$[i$])) {
                                    i$ += InputMethodManagerService.MSG_SHOW_IM_PICKER;
                                } else if (doit) {
                                    InputMethodManagerService.this.resetSelectedInputMethodAndSubtypeLocked("");
                                    InputMethodManagerService.this.chooseNewDefaultIMELocked();
                                    return true;
                                } else {
                                    return true;
                                }
                            }
                            continue;
                        }
                    }
                }
                return InputMethodManagerService.DEBUG;
            }
        }

        public void onSomePackagesChanged() {
            if (isChangingPackagesOfCurrentUser()) {
                synchronized (InputMethodManagerService.this.mMethodMap) {
                    int change;
                    InputMethodInfo curIm = null;
                    String curInputMethodId = InputMethodManagerService.this.mSettings.getSelectedInputMethod();
                    int N = InputMethodManagerService.this.mMethodList.size();
                    if (curInputMethodId != null) {
                        for (int i = 0; i < N; i += InputMethodManagerService.MSG_SHOW_IM_PICKER) {
                            InputMethodInfo imi = (InputMethodInfo) InputMethodManagerService.this.mMethodList.get(i);
                            String imiId = imi.getId();
                            if (imiId.equals(curInputMethodId)) {
                                curIm = imi;
                            }
                            change = isPackageDisappearing(imi.getPackageName());
                            if (isPackageModified(imi.getPackageName())) {
                                InputMethodManagerService.this.mFileManager.deleteAllInputMethodSubtypes(imiId);
                            }
                            if (change == InputMethodManagerService.MSG_SHOW_IM_SUBTYPE_PICKER || change == InputMethodManagerService.MSG_SHOW_IM_SUBTYPE_ENABLER) {
                                Slog.i(InputMethodManagerService.TAG, "Input method uninstalled, disabling: " + imi.getComponent());
                                InputMethodManagerService.this.setInputMethodEnabledLocked(imi.getId(), InputMethodManagerService.DEBUG);
                            }
                        }
                    }
                    InputMethodManagerService.this.buildInputMethodListLocked(InputMethodManagerService.this.mMethodList, InputMethodManagerService.this.mMethodMap, InputMethodManagerService.DEBUG);
                    boolean changed = InputMethodManagerService.DEBUG;
                    if (curIm != null) {
                        change = isPackageDisappearing(curIm.getPackageName());
                        if (change == InputMethodManagerService.MSG_SHOW_IM_SUBTYPE_PICKER || change == InputMethodManagerService.MSG_SHOW_IM_SUBTYPE_ENABLER) {
                            ServiceInfo si = null;
                            try {
                                si = InputMethodManagerService.this.mIPackageManager.getServiceInfo(curIm.getComponent(), 0, InputMethodManagerService.this.mSettings.getCurrentUserId());
                            } catch (RemoteException e) {
                            }
                            if (si == null) {
                                Slog.i(InputMethodManagerService.TAG, "Current input method removed: " + curInputMethodId);
                                InputMethodManagerService.this.setImeWindowVisibilityStatusHiddenLocked();
                                if (!InputMethodManagerService.this.chooseNewDefaultIMELocked()) {
                                    changed = true;
                                    curIm = null;
                                    Slog.i(InputMethodManagerService.TAG, "Unsetting current input method");
                                    InputMethodManagerService.this.resetSelectedInputMethodAndSubtypeLocked("");
                                }
                            }
                        }
                    }
                    if (curIm == null) {
                        changed = InputMethodManagerService.this.chooseNewDefaultIMELocked();
                    }
                    if (changed) {
                        InputMethodManagerService.this.updateFromSettingsLocked(InputMethodManagerService.DEBUG);
                    }
                }
            }
        }
    }

    static class SessionState {
        InputChannel channel;
        final ClientState client;
        final IInputMethod method;
        IInputMethodSession session;

        public String toString() {
            return "SessionState{uid " + this.client.uid + " pid " + this.client.pid + " method " + Integer.toHexString(System.identityHashCode(this.method)) + " session " + Integer.toHexString(System.identityHashCode(this.session)) + " channel " + this.channel + "}";
        }

        SessionState(ClientState _client, IInputMethod _method, IInputMethodSession _session, InputChannel _channel) {
            this.client = _client;
            this.method = _method;
            this.session = _session;
            this.channel = _channel;
        }
    }

    class SettingsObserver extends ContentObserver {
        String mLastEnabled;

        SettingsObserver(Handler handler) {
            super(handler);
            this.mLastEnabled = "";
            ContentResolver resolver = InputMethodManagerService.this.mContext.getContentResolver();
            resolver.registerContentObserver(Secure.getUriFor("default_input_method"), InputMethodManagerService.DEBUG, this);
            resolver.registerContentObserver(Secure.getUriFor("enabled_input_methods"), InputMethodManagerService.DEBUG, this);
            resolver.registerContentObserver(Secure.getUriFor("selected_input_method_subtype"), InputMethodManagerService.DEBUG, this);
            resolver.registerContentObserver(Secure.getUriFor("show_ime_with_hard_keyboard"), InputMethodManagerService.DEBUG, this);
        }

        public void onChange(boolean selfChange, Uri uri) {
            Uri showImeUri = Secure.getUriFor("show_ime_with_hard_keyboard");
            synchronized (InputMethodManagerService.this.mMethodMap) {
                if (showImeUri.equals(uri)) {
                    InputMethodManagerService.this.updateKeyboardFromSettingsLocked();
                } else {
                    boolean enabledChanged = InputMethodManagerService.DEBUG;
                    String newEnabled = InputMethodManagerService.this.mSettings.getEnabledInputMethodsStr();
                    if (!this.mLastEnabled.equals(newEnabled)) {
                        this.mLastEnabled = newEnabled;
                        enabledChanged = true;
                    }
                    InputMethodManagerService.this.updateInputMethodsFromSettingsLocked(enabledChanged);
                }
            }
        }
    }

    public InputMethodManagerService(Context context, WindowManagerService windowManager) {
        boolean z;
        boolean z2 = true;
        this.mNoBinding = new InputBindResult(null, null, null, NOT_A_SUBTYPE_ID, NOT_A_SUBTYPE_ID);
        this.mMethodList = new ArrayList();
        this.mMethodMap = new HashMap();
        this.mSecureSuggestionSpans = new LruCache(SECURE_SUGGESTION_SPANS_MAX_SIZE);
        this.mVisibleConnection = new C00411();
        this.mVisibleBound = DEBUG;
        this.mClients = new HashMap();
        this.mShortcutInputMethodsAndSubtypes = new HashMap();
        this.mScreenOn = true;
        this.mCurUserActionNotificationSequenceNumber = 0;
        this.mBackDisposition = 0;
        this.mMyPackageMonitor = new MyPackageMonitor();
        this.mIPackageManager = AppGlobals.getPackageManager();
        this.mContext = context;
        this.mRes = context.getResources();
        this.mHandler = new Handler(this);
        this.mIWindowManager = IWindowManager.Stub.asInterface(ServiceManager.getService("window"));
        this.mCaller = new HandlerCaller(context, null, new C00422(), true);
        this.mWindowManagerService = windowManager;
        this.mAppOpsManager = (AppOpsManager) this.mContext.getSystemService("appops");
        this.mHardKeyboardListener = new HardKeyboardListener();
        this.mHasFeature = context.getPackageManager().hasSystemFeature("android.software.input_methods");
        this.mImeSwitcherNotification = new Notification();
        this.mImeSwitcherNotification.icon = 17302537;
        this.mImeSwitcherNotification.when = 0;
        this.mImeSwitcherNotification.flags = MSG_SHOW_IM_SUBTYPE_PICKER;
        this.mImeSwitcherNotification.tickerText = null;
        this.mImeSwitcherNotification.defaults = 0;
        this.mImeSwitcherNotification.sound = null;
        this.mImeSwitcherNotification.vibrate = null;
        this.mImeSwitcherNotification.extras.putBoolean("android.allowDuringSetup", true);
        this.mImeSwitcherNotification.category = "sys";
        this.mImeSwitchPendingIntent = PendingIntent.getBroadcast(this.mContext, 0, new Intent("android.settings.SHOW_INPUT_METHOD_PICKER"), 0);
        this.mShowOngoingImeSwitcherForPhones = DEBUG;
        IntentFilter broadcastFilter = new IntentFilter();
        broadcastFilter.addAction("android.intent.action.SCREEN_ON");
        broadcastFilter.addAction("android.intent.action.SCREEN_OFF");
        broadcastFilter.addAction("android.intent.action.CLOSE_SYSTEM_DIALOGS");
        broadcastFilter.addAction("android.intent.action.USER_ADDED");
        broadcastFilter.addAction("android.intent.action.USER_REMOVED");
        this.mContext.registerReceiver(new ImmsBroadcastReceiver(), broadcastFilter);
        this.mNotificationShown = DEBUG;
        int userId = 0;
        try {
            ActivityManagerNative.getDefault().registerUserSwitchObserver(new C00433());
            userId = ActivityManagerNative.getDefault().getCurrentUser().id;
        } catch (RemoteException e) {
            Slog.w(TAG, "Couldn't get current user ID; guessing it's 0", e);
        }
        this.mMyPackageMonitor.register(this.mContext, null, UserHandle.ALL, true);
        this.mSettings = new InputMethodSettings(this.mRes, context.getContentResolver(), this.mMethodMap, this.mMethodList, userId);
        updateCurrentProfileIds();
        this.mFileManager = new InputMethodFileManager(this.mMethodMap, userId);
        synchronized (this.mMethodMap) {
            this.mSwitchingController = InputMethodSubtypeSwitchingController.createInstanceLocked(this.mSettings, context);
        }
        if (TextUtils.isEmpty(this.mSettings.getSelectedInputMethod())) {
            z = DEBUG;
        } else {
            z = true;
        }
        this.mImeSelectedOnBoot = z;
        synchronized (this.mMethodMap) {
            ArrayList arrayList = this.mMethodList;
            HashMap hashMap = this.mMethodMap;
            if (this.mImeSelectedOnBoot) {
                z2 = DEBUG;
            }
            buildInputMethodListLocked(arrayList, hashMap, z2);
        }
        this.mSettings.enableAllIMEsIfThereIsNoEnabledIME();
        if (!this.mImeSelectedOnBoot) {
            Slog.w(TAG, "No IME selected. Choose the most applicable IME.");
            synchronized (this.mMethodMap) {
                resetDefaultImeLocked(context);
            }
        }
        this.mSettingsObserver = new SettingsObserver(this.mHandler);
        synchronized (this.mMethodMap) {
            updateFromSettingsLocked(true);
        }
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.LOCALE_CHANGED");
        this.mContext.registerReceiver(new C00444(), filter);
    }

    private void resetDefaultImeLocked(Context context) {
        if (this.mCurMethodId == null || InputMethodUtils.isSystemIme((InputMethodInfo) this.mMethodMap.get(this.mCurMethodId))) {
            InputMethodInfo defIm = null;
            Iterator i$ = this.mMethodList.iterator();
            while (i$.hasNext()) {
                InputMethodInfo imi = (InputMethodInfo) i$.next();
                if (defIm == null && InputMethodUtils.isValidSystemDefaultIme(this.mSystemReady, imi, context)) {
                    defIm = imi;
                    Slog.i(TAG, "Selected default: " + imi.getId());
                }
            }
            if (defIm == null && this.mMethodList.size() > 0) {
                defIm = InputMethodUtils.getMostApplicableDefaultIME(this.mSettings.getEnabledInputMethodListLocked());
                if (defIm != null) {
                    Slog.i(TAG, "Default found, using " + defIm.getId());
                } else {
                    Slog.i(TAG, "No default found");
                }
            }
            if (defIm != null) {
                setSelectedInputMethodAndSubtypeLocked(defIm, NOT_A_SUBTYPE_ID, DEBUG);
            }
        }
    }

    private void resetAllInternalStateLocked(boolean updateOnlyWhenLocaleChanged, boolean resetDefaultEnabledIme) {
        if (this.mSystemReady) {
            Locale newLocale = this.mRes.getConfiguration().locale;
            if (!updateOnlyWhenLocaleChanged || (newLocale != null && !newLocale.equals(this.mLastSystemLocale))) {
                if (!updateOnlyWhenLocaleChanged) {
                    hideCurrentInputLocked(0, null);
                    this.mCurMethodId = null;
                    unbindCurrentMethodLocked(true, DEBUG);
                }
                buildInputMethodListLocked(this.mMethodList, this.mMethodMap, resetDefaultEnabledIme);
                if (updateOnlyWhenLocaleChanged) {
                    resetDefaultImeLocked(this.mContext);
                } else if (TextUtils.isEmpty(this.mSettings.getSelectedInputMethod())) {
                    resetDefaultImeLocked(this.mContext);
                }
                updateFromSettingsLocked(true);
                this.mLastSystemLocale = newLocale;
                if (!updateOnlyWhenLocaleChanged) {
                    try {
                        startInputInnerLocked();
                    } catch (RuntimeException e) {
                        Slog.w(TAG, "Unexpected exception", e);
                    }
                }
            }
        }
    }

    private void resetStateIfCurrentLocaleChangedLocked() {
        resetAllInternalStateLocked(true, true);
    }

    private void switchUserLocked(int newUserId) {
        this.mSettings.setCurrentUserId(newUserId);
        updateCurrentProfileIds();
        this.mFileManager = new InputMethodFileManager(this.mMethodMap, newUserId);
        boolean initialUserSwitch = TextUtils.isEmpty(this.mSettings.getSelectedInputMethod());
        resetAllInternalStateLocked(DEBUG, initialUserSwitch);
        if (initialUserSwitch) {
            InputMethodUtils.setNonSelectedSystemImesDisabledUntilUsed(this.mContext.getPackageManager(), this.mSettings.getEnabledInputMethodListLocked());
        }
    }

    void updateCurrentProfileIds() {
        List<UserInfo> profiles = UserManager.get(this.mContext).getProfiles(this.mSettings.getCurrentUserId());
        int[] currentProfileIds = new int[profiles.size()];
        for (int i = 0; i < currentProfileIds.length; i += MSG_SHOW_IM_PICKER) {
            currentProfileIds[i] = ((UserInfo) profiles.get(i)).id;
        }
        this.mSettings.setCurrentProfileIds(currentProfileIds);
    }

    public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
        try {
            return super.onTransact(code, data, reply, flags);
        } catch (RuntimeException e) {
            if (!(e instanceof SecurityException)) {
                Slog.wtf(TAG, "Input Method Manager Crash", e);
            }
            throw e;
        }
    }

    public void systemRunning(StatusBarManagerService statusBar) {
        synchronized (this.mMethodMap) {
            if (!this.mSystemReady) {
                this.mSystemReady = true;
                this.mKeyguardManager = (KeyguardManager) this.mContext.getSystemService("keyguard");
                this.mNotificationManager = (NotificationManager) this.mContext.getSystemService("notification");
                this.mStatusBar = statusBar;
                statusBar.setIconVisibility("ime", DEBUG);
                updateImeWindowStatusLocked();
                this.mShowOngoingImeSwitcherForPhones = this.mRes.getBoolean(17956871);
                if (this.mShowOngoingImeSwitcherForPhones) {
                    this.mWindowManagerService.setOnHardKeyboardStatusChangeListener(this.mHardKeyboardListener);
                }
                buildInputMethodListLocked(this.mMethodList, this.mMethodMap, !this.mImeSelectedOnBoot ? true : DEBUG);
                if (!this.mImeSelectedOnBoot) {
                    Slog.w(TAG, "Reset the default IME as \"Resource\" is ready here.");
                    resetStateIfCurrentLocaleChangedLocked();
                    InputMethodUtils.setNonSelectedSystemImesDisabledUntilUsed(this.mContext.getPackageManager(), this.mSettings.getEnabledInputMethodListLocked());
                }
                this.mLastSystemLocale = this.mRes.getConfiguration().locale;
                try {
                    startInputInnerLocked();
                } catch (RuntimeException e) {
                    Slog.w(TAG, "Unexpected exception", e);
                }
            }
        }
    }

    private void setImeWindowVisibilityStatusHiddenLocked() {
        this.mImeWindowVis = 0;
        updateImeWindowStatusLocked();
    }

    private void refreshImeWindowVisibilityLocked() {
        boolean haveHardKeyboard;
        boolean inputActive;
        boolean inputVisible;
        int i = MSG_SHOW_IM_PICKER;
        int i2 = 0;
        Configuration conf = this.mRes.getConfiguration();
        if (conf.keyboard != MSG_SHOW_IM_PICKER) {
            haveHardKeyboard = true;
        } else {
            haveHardKeyboard = DEBUG;
        }
        boolean hardKeyShown;
        if (!haveHardKeyboard || conf.hardKeyboardHidden == MSG_SHOW_IM_SUBTYPE_PICKER) {
            hardKeyShown = DEBUG;
        } else {
            hardKeyShown = true;
        }
        if (isKeyguardLocked() || !(this.mInputShown || hardKeyShown)) {
            inputActive = DEBUG;
        } else {
            inputActive = true;
        }
        if (!inputActive || hardKeyShown) {
            inputVisible = DEBUG;
        } else {
            inputVisible = true;
        }
        if (!inputActive) {
            i = 0;
        }
        if (inputVisible) {
            i2 = MSG_SHOW_IM_SUBTYPE_PICKER;
        }
        this.mImeWindowVis = i | i2;
        updateImeWindowStatusLocked();
    }

    private void updateImeWindowStatusLocked() {
        setImeWindowStatus(this.mCurToken, this.mImeWindowVis, this.mBackDisposition);
    }

    private boolean calledFromValidUser() {
        int uid = Binder.getCallingUid();
        int userId = UserHandle.getUserId(uid);
        if (uid == MSG_UNBIND_INPUT || this.mSettings.isCurrentProfile(userId) || this.mContext.checkCallingOrSelfPermission("android.permission.INTERACT_ACROSS_USERS_FULL") == 0) {
            return true;
        }
        Slog.w(TAG, "--- IPC called from background users. Ignore. \n" + InputMethodUtils.getStackTrace());
        return DEBUG;
    }

    private boolean calledWithValidToken(IBinder token) {
        if (token == null || this.mCurToken != token) {
            return DEBUG;
        }
        return true;
    }

    private boolean bindCurrentInputMethodService(Intent service, ServiceConnection conn, int flags) {
        if (service != null && conn != null) {
            return this.mContext.bindServiceAsUser(service, conn, flags, new UserHandle(this.mSettings.getCurrentUserId()));
        }
        Slog.e(TAG, "--- bind failed: service = " + service + ", conn = " + conn);
        return DEBUG;
    }

    public List<InputMethodInfo> getInputMethodList() {
        if (!calledFromValidUser()) {
            return Collections.emptyList();
        }
        List<InputMethodInfo> arrayList;
        synchronized (this.mMethodMap) {
            arrayList = new ArrayList(this.mMethodList);
        }
        return arrayList;
    }

    public List<InputMethodInfo> getEnabledInputMethodList() {
        if (!calledFromValidUser()) {
            return Collections.emptyList();
        }
        List<InputMethodInfo> enabledInputMethodListLocked;
        synchronized (this.mMethodMap) {
            enabledInputMethodListLocked = this.mSettings.getEnabledInputMethodListLocked();
        }
        return enabledInputMethodListLocked;
    }

    public List<InputMethodSubtype> getEnabledInputMethodSubtypeList(String imiId, boolean allowsImplicitlySelectedSubtypes) {
        if (!calledFromValidUser()) {
            return Collections.emptyList();
        }
        synchronized (this.mMethodMap) {
            InputMethodInfo imi;
            List<InputMethodSubtype> emptyList;
            if (imiId == null) {
                if (this.mCurMethodId != null) {
                    imi = (InputMethodInfo) this.mMethodMap.get(this.mCurMethodId);
                    if (imi != null) {
                        emptyList = Collections.emptyList();
                        return emptyList;
                    }
                    emptyList = this.mSettings.getEnabledInputMethodSubtypeListLocked(this.mContext, imi, allowsImplicitlySelectedSubtypes);
                    return emptyList;
                }
            }
            imi = (InputMethodInfo) this.mMethodMap.get(imiId);
            if (imi != null) {
                emptyList = this.mSettings.getEnabledInputMethodSubtypeListLocked(this.mContext, imi, allowsImplicitlySelectedSubtypes);
                return emptyList;
            }
            emptyList = Collections.emptyList();
            return emptyList;
        }
    }

    public void addClient(IInputMethodClient client, IInputContext inputContext, int uid, int pid) {
        if (calledFromValidUser()) {
            synchronized (this.mMethodMap) {
                this.mClients.put(client.asBinder(), new ClientState(client, inputContext, uid, pid));
            }
        }
    }

    public void removeClient(IInputMethodClient client) {
        if (calledFromValidUser()) {
            synchronized (this.mMethodMap) {
                ClientState cs = (ClientState) this.mClients.remove(client.asBinder());
                if (cs != null) {
                    clearClientSessionLocked(cs);
                }
            }
        }
    }

    void executeOrSendMessage(IInterface target, Message msg) {
        if (target.asBinder() instanceof Binder) {
            this.mCaller.sendMessage(msg);
            return;
        }
        handleMessage(msg);
        msg.recycle();
    }

    void unbindCurrentClientLocked() {
        if (this.mCurClient != null) {
            if (this.mBoundToMethod) {
                this.mBoundToMethod = DEBUG;
                if (this.mCurMethod != null) {
                    executeOrSendMessage(this.mCurMethod, this.mCaller.obtainMessageO(MSG_UNBIND_INPUT, this.mCurMethod));
                }
            }
            executeOrSendMessage(this.mCurClient.client, this.mCaller.obtainMessageIO(MSG_SET_ACTIVE, 0, this.mCurClient));
            executeOrSendMessage(this.mCurClient.client, this.mCaller.obtainMessageIO(MSG_UNBIND_METHOD, this.mCurSeq, this.mCurClient.client));
            this.mCurClient.sessionRequested = DEBUG;
            this.mCurClient = null;
            hideInputMethodMenuLocked();
        }
    }

    private int getImeShowFlags() {
        if (this.mShowForced) {
            return 0 | MSG_SHOW_IM_SUBTYPE_ENABLER;
        }
        if (this.mShowExplicitlyRequested) {
            return 0 | MSG_SHOW_IM_PICKER;
        }
        return 0;
    }

    private int getAppShowFlags() {
        if (this.mShowForced) {
            return 0 | MSG_SHOW_IM_SUBTYPE_PICKER;
        }
        if (this.mShowExplicitlyRequested) {
            return 0;
        }
        return 0 | MSG_SHOW_IM_PICKER;
    }

    InputBindResult attachNewInputLocked(boolean initial) {
        InputChannel inputChannel = null;
        if (!this.mBoundToMethod) {
            executeOrSendMessage(this.mCurMethod, this.mCaller.obtainMessageOO(MSG_BIND_INPUT, this.mCurMethod, this.mCurClient.binding));
            this.mBoundToMethod = true;
        }
        SessionState session = this.mCurClient.curSession;
        if (initial) {
            executeOrSendMessage(session.method, this.mCaller.obtainMessageOOO(MSG_START_INPUT, session, this.mCurInputContext, this.mCurAttribute));
        } else {
            executeOrSendMessage(session.method, this.mCaller.obtainMessageOOO(MSG_RESTART_INPUT, session, this.mCurInputContext, this.mCurAttribute));
        }
        if (this.mShowRequested) {
            showCurrentInputLocked(getAppShowFlags(), null);
        }
        IInputMethodSession iInputMethodSession = session.session;
        if (session.channel != null) {
            inputChannel = session.channel.dup();
        }
        return new InputBindResult(iInputMethodSession, inputChannel, this.mCurId, this.mCurSeq, this.mCurUserActionNotificationSequenceNumber);
    }

    InputBindResult startInputLocked(IInputMethodClient client, IInputContext inputContext, EditorInfo attribute, int controlFlags) {
        if (this.mCurMethodId == null) {
            return this.mNoBinding;
        }
        ClientState cs = (ClientState) this.mClients.get(client.asBinder());
        if (cs == null) {
            throw new IllegalArgumentException("unknown client " + client.asBinder());
        }
        try {
            if (!this.mIWindowManager.inputMethodClientHasFocus(cs.client)) {
                Slog.w(TAG, "Starting input on non-focused client " + cs.client + " (uid=" + cs.uid + " pid=" + cs.pid + ")");
                return null;
            }
        } catch (RemoteException e) {
        }
        return startInputUncheckedLocked(cs, inputContext, attribute, controlFlags);
    }

    InputBindResult startInputUncheckedLocked(ClientState cs, IInputContext inputContext, EditorInfo attribute, int controlFlags) {
        if (this.mCurMethodId == null) {
            return this.mNoBinding;
        }
        if (this.mCurClient != cs) {
            this.mCurClientInKeyguard = isKeyguardLocked();
            unbindCurrentClientLocked();
            if (this.mScreenOn) {
                executeOrSendMessage(cs.client, this.mCaller.obtainMessageIO(MSG_SET_ACTIVE, this.mScreenOn ? MSG_SHOW_IM_PICKER : 0, cs));
            }
        }
        this.mCurSeq += MSG_SHOW_IM_PICKER;
        if (this.mCurSeq <= 0) {
            this.mCurSeq = MSG_SHOW_IM_PICKER;
        }
        this.mCurClient = cs;
        this.mCurInputContext = inputContext;
        this.mCurAttribute = attribute;
        if (this.mCurId != null && this.mCurId.equals(this.mCurMethodId)) {
            if (cs.curSession != null) {
                boolean z;
                if ((controlFlags & DumpState.DUMP_VERIFIERS) != 0) {
                    z = true;
                } else {
                    z = DEBUG;
                }
                return attachNewInputLocked(z);
            } else if (this.mHaveConnection) {
                if (this.mCurMethod != null) {
                    requestClientSessionLocked(cs);
                    return new InputBindResult(null, null, this.mCurId, this.mCurSeq, this.mCurUserActionNotificationSequenceNumber);
                } else if (SystemClock.uptimeMillis() < this.mLastBindTime + TIME_TO_RECONNECT) {
                    return new InputBindResult(null, null, this.mCurId, this.mCurSeq, this.mCurUserActionNotificationSequenceNumber);
                } else {
                    Object[] objArr = new Object[MSG_SHOW_IM_SUBTYPE_ENABLER];
                    objArr[0] = this.mCurMethodId;
                    objArr[MSG_SHOW_IM_PICKER] = Long.valueOf(SystemClock.uptimeMillis() - this.mLastBindTime);
                    objArr[MSG_SHOW_IM_SUBTYPE_PICKER] = Integer.valueOf(0);
                    EventLog.writeEvent(EventLogTags.IMF_FORCE_RECONNECT_IME, objArr);
                }
            }
        }
        try {
            return startInputInnerLocked();
        } catch (RuntimeException e) {
            Slog.w(TAG, "Unexpected exception", e);
            return null;
        }
    }

    InputBindResult startInputInnerLocked() {
        if (this.mCurMethodId == null) {
            return this.mNoBinding;
        }
        if (this.mSystemReady) {
            InputMethodInfo info = (InputMethodInfo) this.mMethodMap.get(this.mCurMethodId);
            if (info == null) {
                throw new IllegalArgumentException("Unknown id: " + this.mCurMethodId);
            }
            unbindCurrentMethodLocked(DEBUG, true);
            this.mCurIntent = new Intent("android.view.InputMethod");
            this.mCurIntent.setComponent(info.getComponent());
            this.mCurIntent.putExtra("android.intent.extra.client_label", 17040723);
            this.mCurIntent.putExtra("android.intent.extra.client_intent", PendingIntent.getActivity(this.mContext, 0, new Intent("android.settings.INPUT_METHOD_SETTINGS"), 0));
            if (bindCurrentInputMethodService(this.mCurIntent, this, 1610612741)) {
                this.mLastBindTime = SystemClock.uptimeMillis();
                this.mHaveConnection = true;
                this.mCurId = info.getId();
                this.mCurToken = new Binder();
                try {
                    Slog.v(TAG, "Adding window token: " + this.mCurToken);
                    this.mIWindowManager.addWindowToken(this.mCurToken, 2011);
                } catch (RemoteException e) {
                }
                return new InputBindResult(null, null, this.mCurId, this.mCurSeq, this.mCurUserActionNotificationSequenceNumber);
            }
            this.mCurIntent = null;
            Slog.w(TAG, "Failure connecting to input method service: " + this.mCurIntent);
            return null;
        }
        return new InputBindResult(null, null, this.mCurMethodId, this.mCurSeq, this.mCurUserActionNotificationSequenceNumber);
    }

    public InputBindResult startInput(IInputMethodClient client, IInputContext inputContext, EditorInfo attribute, int controlFlags) {
        if (!calledFromValidUser()) {
            return null;
        }
        InputBindResult startInputLocked;
        synchronized (this.mMethodMap) {
            long ident = Binder.clearCallingIdentity();
            try {
                startInputLocked = startInputLocked(client, inputContext, attribute, controlFlags);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
        return startInputLocked;
    }

    public void finishInput(IInputMethodClient client) {
    }

    public void onServiceConnected(ComponentName name, IBinder service) {
        synchronized (this.mMethodMap) {
            if (this.mCurIntent != null && name.equals(this.mCurIntent.getComponent())) {
                this.mCurMethod = IInputMethod.Stub.asInterface(service);
                if (this.mCurToken == null) {
                    Slog.w(TAG, "Service connected without a token!");
                    unbindCurrentMethodLocked(DEBUG, DEBUG);
                    return;
                }
                executeOrSendMessage(this.mCurMethod, this.mCaller.obtainMessageOO(MSG_ATTACH_TOKEN, this.mCurMethod, this.mCurToken));
                if (this.mCurClient != null) {
                    clearClientSessionLocked(this.mCurClient);
                    requestClientSessionLocked(this.mCurClient);
                }
            }
        }
    }

    void onSessionCreated(IInputMethod method, IInputMethodSession session, InputChannel channel) {
        synchronized (this.mMethodMap) {
            if (this.mCurMethod == null || method == null || this.mCurMethod.asBinder() != method.asBinder() || this.mCurClient == null) {
                channel.dispose();
                return;
            }
            clearClientSessionLocked(this.mCurClient);
            this.mCurClient.curSession = new SessionState(this.mCurClient, method, session, channel);
            InputBindResult res = attachNewInputLocked(true);
            if (res.method != null) {
                executeOrSendMessage(this.mCurClient.client, this.mCaller.obtainMessageOO(MSG_BIND_METHOD, this.mCurClient.client, res));
            }
        }
    }

    void unbindCurrentMethodLocked(boolean reportToClient, boolean savePosition) {
        if (this.mVisibleBound) {
            this.mContext.unbindService(this.mVisibleConnection);
            this.mVisibleBound = DEBUG;
        }
        if (this.mHaveConnection) {
            this.mContext.unbindService(this);
            this.mHaveConnection = DEBUG;
        }
        if (this.mCurToken != null) {
            try {
                if ((this.mImeWindowVis & MSG_SHOW_IM_PICKER) != 0 && savePosition) {
                    this.mWindowManagerService.saveLastInputMethodWindowForTransition();
                }
                this.mIWindowManager.removeWindowToken(this.mCurToken);
            } catch (RemoteException e) {
            }
            this.mCurToken = null;
        }
        this.mCurId = null;
        clearCurMethodLocked();
        if (reportToClient && this.mCurClient != null) {
            executeOrSendMessage(this.mCurClient.client, this.mCaller.obtainMessageIO(MSG_UNBIND_METHOD, this.mCurSeq, this.mCurClient.client));
        }
    }

    void requestClientSessionLocked(ClientState cs) {
        if (!cs.sessionRequested) {
            InputChannel[] channels = InputChannel.openInputChannelPair(cs.toString());
            cs.sessionRequested = true;
            executeOrSendMessage(this.mCurMethod, this.mCaller.obtainMessageOOO(MSG_CREATE_SESSION, this.mCurMethod, channels[MSG_SHOW_IM_PICKER], new MethodCallback(this, this.mCurMethod, channels[0])));
        }
    }

    void clearClientSessionLocked(ClientState cs) {
        finishSessionLocked(cs.curSession);
        cs.curSession = null;
        cs.sessionRequested = DEBUG;
    }

    private void finishSessionLocked(SessionState sessionState) {
        if (sessionState != null) {
            if (sessionState.session != null) {
                try {
                    sessionState.session.finishSession();
                } catch (RemoteException e) {
                    Slog.w(TAG, "Session failed to close due to remote exception", e);
                    setImeWindowVisibilityStatusHiddenLocked();
                }
                sessionState.session = null;
            }
            if (sessionState.channel != null) {
                sessionState.channel.dispose();
                sessionState.channel = null;
            }
        }
    }

    void clearCurMethodLocked() {
        if (this.mCurMethod != null) {
            for (ClientState cs : this.mClients.values()) {
                clearClientSessionLocked(cs);
            }
            finishSessionLocked(this.mEnabledSession);
            this.mEnabledSession = null;
            this.mCurMethod = null;
        }
        if (this.mStatusBar != null) {
            this.mStatusBar.setIconVisibility("ime", DEBUG);
        }
    }

    public void onServiceDisconnected(ComponentName name) {
        synchronized (this.mMethodMap) {
            if (!(this.mCurMethod == null || this.mCurIntent == null || !name.equals(this.mCurIntent.getComponent()))) {
                clearCurMethodLocked();
                this.mLastBindTime = SystemClock.uptimeMillis();
                this.mShowRequested = this.mInputShown;
                this.mInputShown = DEBUG;
                if (this.mCurClient != null) {
                    executeOrSendMessage(this.mCurClient.client, this.mCaller.obtainMessageIO(MSG_UNBIND_METHOD, this.mCurSeq, this.mCurClient.client));
                }
            }
        }
    }

    public void updateStatusIcon(IBinder token, String packageName, int iconId) {
        long ident = Binder.clearCallingIdentity();
        try {
            synchronized (this.mMethodMap) {
                if (calledWithValidToken(token)) {
                    if (iconId == 0) {
                        if (this.mStatusBar != null) {
                            this.mStatusBar.setIconVisibility("ime", DEBUG);
                        }
                    } else if (packageName != null) {
                        CharSequence contentDescription = null;
                        try {
                            contentDescription = this.mContext.getPackageManager().getApplicationLabel(this.mIPackageManager.getApplicationInfo(packageName, 0, this.mSettings.getCurrentUserId()));
                        } catch (RemoteException e) {
                        }
                        if (this.mStatusBar != null) {
                            this.mStatusBar.setIcon("ime", packageName, iconId, 0, contentDescription != null ? contentDescription.toString() : null);
                            this.mStatusBar.setIconVisibility("ime", true);
                        }
                    }
                    Binder.restoreCallingIdentity(ident);
                    return;
                }
                Slog.e(TAG, "Ignoring updateStatusIcon due to an invalid token. uid:" + Binder.getCallingUid() + " token:" + token);
            }
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private boolean needsToShowImeSwitchOngoingNotification() {
        if (!this.mShowOngoingImeSwitcherForPhones) {
            return DEBUG;
        }
        if (this.mSwitchingDialog != null) {
            return DEBUG;
        }
        if (isScreenLocked()) {
            return DEBUG;
        }
        synchronized (this.mMethodMap) {
            List<InputMethodInfo> imis = this.mSettings.getEnabledInputMethodListLocked();
            int N = imis.size();
            if (N > MSG_SHOW_IM_SUBTYPE_PICKER) {
                return true;
            } else if (N < MSG_SHOW_IM_PICKER) {
                return DEBUG;
            } else {
                int nonAuxCount = 0;
                int auxCount = 0;
                InputMethodSubtype nonAuxSubtype = null;
                InputMethodSubtype auxSubtype = null;
                for (int i = 0; i < N; i += MSG_SHOW_IM_PICKER) {
                    List<InputMethodSubtype> subtypes = this.mSettings.getEnabledInputMethodSubtypeListLocked(this.mContext, (InputMethodInfo) imis.get(i), true);
                    int subtypeCount = subtypes.size();
                    if (subtypeCount == 0) {
                        nonAuxCount += MSG_SHOW_IM_PICKER;
                    } else {
                        for (int j = 0; j < subtypeCount; j += MSG_SHOW_IM_PICKER) {
                            InputMethodSubtype subtype = (InputMethodSubtype) subtypes.get(j);
                            if (subtype.isAuxiliary()) {
                                auxCount += MSG_SHOW_IM_PICKER;
                                auxSubtype = subtype;
                            } else {
                                nonAuxCount += MSG_SHOW_IM_PICKER;
                                nonAuxSubtype = subtype;
                            }
                        }
                    }
                }
                if (nonAuxCount > MSG_SHOW_IM_PICKER || auxCount > MSG_SHOW_IM_PICKER) {
                    return true;
                } else if (nonAuxCount != MSG_SHOW_IM_PICKER || auxCount != MSG_SHOW_IM_PICKER) {
                    return DEBUG;
                } else if (nonAuxSubtype == null || auxSubtype == null || !((nonAuxSubtype.getLocale().equals(auxSubtype.getLocale()) || auxSubtype.overridesImplicitlyEnabledSubtype() || nonAuxSubtype.overridesImplicitlyEnabledSubtype()) && nonAuxSubtype.containsExtraValueKey(TAG_TRY_SUPPRESSING_IME_SWITCHER))) {
                    return true;
                } else {
                    return DEBUG;
                }
            }
        }
    }

    private boolean isKeyguardLocked() {
        return (this.mKeyguardManager == null || !this.mKeyguardManager.isKeyguardLocked()) ? DEBUG : true;
    }

    public void setImeWindowStatus(IBinder token, int vis, int backDisposition) {
        long ident = Binder.clearCallingIdentity();
        try {
            if (calledWithValidToken(token)) {
                synchronized (this.mMethodMap) {
                    if (vis != 0) {
                        if (isKeyguardLocked() && !this.mCurClientInKeyguard) {
                            vis = 0;
                        }
                    }
                    this.mImeWindowVis = vis;
                    this.mBackDisposition = backDisposition;
                    boolean iconVisibility = ((vis & MSG_SHOW_IM_PICKER) == 0 || (!this.mWindowManagerService.isHardKeyboardAvailable() && (vis & MSG_SHOW_IM_SUBTYPE_PICKER) == 0)) ? DEBUG : true;
                    boolean needsToShowImeSwitcher = (iconVisibility && needsToShowImeSwitchOngoingNotification()) ? true : DEBUG;
                    if (this.mStatusBar != null) {
                        this.mStatusBar.setImeWindowStatus(token, vis, backDisposition, needsToShowImeSwitcher);
                    }
                    InputMethodInfo imi = (InputMethodInfo) this.mMethodMap.get(this.mCurMethodId);
                    if (imi != null && needsToShowImeSwitcher) {
                        CharSequence title = this.mRes.getText(17040657);
                        CharSequence summary = InputMethodUtils.getImeAndSubtypeDisplayName(this.mContext, imi, this.mCurrentSubtype);
                        this.mImeSwitcherNotification.color = this.mContext.getResources().getColor(17170521);
                        this.mImeSwitcherNotification.setLatestEventInfo(this.mContext, title, summary, this.mImeSwitchPendingIntent);
                        if (!(this.mNotificationManager == null || this.mWindowManagerService.hasNavigationBar())) {
                            this.mNotificationManager.notifyAsUser(null, 17040657, this.mImeSwitcherNotification, UserHandle.ALL);
                            this.mNotificationShown = true;
                        }
                    } else if (this.mNotificationShown && this.mNotificationManager != null) {
                        this.mNotificationManager.cancelAsUser(null, 17040657, UserHandle.ALL);
                        this.mNotificationShown = DEBUG;
                    }
                }
                Binder.restoreCallingIdentity(ident);
                return;
            }
            Slog.e(TAG, "Ignoring setImeWindowStatus due to an invalid token. uid:" + Binder.getCallingUid() + " token:" + token);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public void registerSuggestionSpansForNotification(SuggestionSpan[] spans) {
        if (calledFromValidUser()) {
            synchronized (this.mMethodMap) {
                InputMethodInfo currentImi = (InputMethodInfo) this.mMethodMap.get(this.mCurMethodId);
                for (int i = 0; i < spans.length; i += MSG_SHOW_IM_PICKER) {
                    SuggestionSpan ss = spans[i];
                    if (!TextUtils.isEmpty(ss.getNotificationTargetClassName())) {
                        this.mSecureSuggestionSpans.put(ss, currentImi);
                    }
                }
            }
        }
    }

    public boolean notifySuggestionPicked(SuggestionSpan span, String originalString, int index) {
        boolean z = DEBUG;
        if (calledFromValidUser()) {
            synchronized (this.mMethodMap) {
                InputMethodInfo targetImi = (InputMethodInfo) this.mSecureSuggestionSpans.get(span);
                if (targetImi != null) {
                    String[] suggestions = span.getSuggestions();
                    if (index < 0 || index >= suggestions.length) {
                    } else {
                        String className = span.getNotificationTargetClassName();
                        Intent intent = new Intent();
                        intent.setClassName(targetImi.getPackageName(), className);
                        intent.setAction("android.text.style.SUGGESTION_PICKED");
                        intent.putExtra("before", originalString);
                        intent.putExtra("after", suggestions[index]);
                        intent.putExtra("hashcode", span.hashCode());
                        long ident = Binder.clearCallingIdentity();
                        try {
                            this.mContext.sendBroadcastAsUser(intent, UserHandle.CURRENT);
                            z = true;
                        } finally {
                            Binder.restoreCallingIdentity(ident);
                        }
                    }
                }
            }
        }
        return z;
    }

    void updateFromSettingsLocked(boolean enabledMayChange) {
        updateInputMethodsFromSettingsLocked(enabledMayChange);
        updateKeyboardFromSettingsLocked();
    }

    void updateInputMethodsFromSettingsLocked(boolean enabledMayChange) {
        if (enabledMayChange) {
            List<InputMethodInfo> enabled = this.mSettings.getEnabledInputMethodListLocked();
            for (int i = 0; i < enabled.size(); i += MSG_SHOW_IM_PICKER) {
                InputMethodInfo imm = (InputMethodInfo) enabled.get(i);
                try {
                    ApplicationInfo ai = this.mIPackageManager.getApplicationInfo(imm.getPackageName(), 32768, this.mSettings.getCurrentUserId());
                    if (ai != null && ai.enabledSetting == MSG_SHOW_IM_CONFIG) {
                        this.mIPackageManager.setApplicationEnabledSetting(imm.getPackageName(), 0, MSG_SHOW_IM_PICKER, this.mSettings.getCurrentUserId(), this.mContext.getBasePackageName());
                    }
                } catch (RemoteException e) {
                }
            }
        }
        String id = this.mSettings.getSelectedInputMethod();
        if (TextUtils.isEmpty(id) && chooseNewDefaultIMELocked()) {
            id = this.mSettings.getSelectedInputMethod();
        }
        if (TextUtils.isEmpty(id)) {
            this.mCurMethodId = null;
            unbindCurrentMethodLocked(true, DEBUG);
        } else {
            try {
                setInputMethodLocked(id, this.mSettings.getSelectedInputMethodSubtypeId(id));
            } catch (IllegalArgumentException e2) {
                Slog.w(TAG, "Unknown input method from prefs: " + id, e2);
                this.mCurMethodId = null;
                unbindCurrentMethodLocked(true, DEBUG);
            }
            this.mShortcutInputMethodsAndSubtypes.clear();
        }
        this.mSwitchingController.resetCircularListLocked(this.mContext);
    }

    public void updateKeyboardFromSettingsLocked() {
        this.mShowImeWithHardKeyboard = this.mSettings.isShowImeWithHardKeyboardEnabled();
        if (this.mSwitchingDialog != null && this.mSwitchingDialogTitleView != null && this.mSwitchingDialog.isShowing()) {
            ((Switch) this.mSwitchingDialogTitleView.findViewById(16909075)).setChecked(this.mShowImeWithHardKeyboard);
        }
    }

    void setInputMethodLocked(String id, int subtypeId) {
        InputMethodInfo info = (InputMethodInfo) this.mMethodMap.get(id);
        if (info == null) {
            throw new IllegalArgumentException("Unknown id: " + id);
        }
        if (!(this.mCurClient == null || this.mCurAttribute == null)) {
            int uid = this.mCurClient.uid;
            String packageName = this.mCurAttribute.packageName;
            if (SystemConfig.getInstance().getFixedImeApps().contains(packageName)) {
                if (!InputMethodUtils.checkIfPackageBelongsToUid(this.mAppOpsManager, uid, packageName)) {
                    Slog.e(TAG, "Ignoring FixedImeApps due to the validation failure. uid=" + uid + " package=" + packageName);
                } else {
                    return;
                }
            }
        }
        if (id.equals(this.mCurMethodId)) {
            int subtypeCount = info.getSubtypeCount();
            if (subtypeCount > 0) {
                InputMethodSubtype newSubtype;
                InputMethodSubtype oldSubtype = this.mCurrentSubtype;
                if (subtypeId < 0 || subtypeId >= subtypeCount) {
                    newSubtype = getCurrentInputMethodSubtypeLocked();
                } else {
                    newSubtype = info.getSubtypeAt(subtypeId);
                }
                if (newSubtype == null || oldSubtype == null) {
                    Slog.w(TAG, "Illegal subtype state: old subtype = " + oldSubtype + ", new subtype = " + newSubtype);
                    return;
                } else if (newSubtype != oldSubtype) {
                    setSelectedInputMethodAndSubtypeLocked(info, subtypeId, true);
                    if (this.mCurMethod != null) {
                        try {
                            refreshImeWindowVisibilityLocked();
                            this.mCurMethod.changeInputMethodSubtype(newSubtype);
                            return;
                        } catch (RemoteException e) {
                            Slog.w(TAG, "Failed to call changeInputMethodSubtype");
                            return;
                        }
                    }
                    return;
                } else {
                    return;
                }
            }
            return;
        }
        long ident = Binder.clearCallingIdentity();
        try {
            setSelectedInputMethodAndSubtypeLocked(info, subtypeId, DEBUG);
            this.mCurMethodId = id;
            if (ActivityManagerNative.isSystemReady()) {
                Intent intent = new Intent("android.intent.action.INPUT_METHOD_CHANGED");
                intent.addFlags(536870912);
                intent.putExtra("input_method_id", id);
                this.mContext.sendBroadcastAsUser(intent, UserHandle.CURRENT);
            }
            unbindCurrentClientLocked();
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public boolean showSoftInput(IInputMethodClient client, int flags, ResultReceiver resultReceiver) {
        boolean z = DEBUG;
        if (calledFromValidUser()) {
            int uid = Binder.getCallingUid();
            long ident = Binder.clearCallingIdentity();
            try {
                synchronized (this.mMethodMap) {
                    if (this.mCurClient == null || client == null || this.mCurClient.client.asBinder() != client.asBinder()) {
                        try {
                            if (!this.mIWindowManager.inputMethodClientHasFocus(client)) {
                                Slog.w(TAG, "Ignoring showSoftInput of uid " + uid + ": " + client);
                                while (true) {
                                    break;
                                }
                            }
                        } catch (RemoteException e) {
                            Binder.restoreCallingIdentity(ident);
                        }
                    }
                    z = showCurrentInputLocked(flags, resultReceiver);
                    Binder.restoreCallingIdentity(ident);
                }
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
        return z;
    }

    boolean showCurrentInputLocked(int flags, ResultReceiver resultReceiver) {
        this.mShowRequested = true;
        if ((flags & MSG_SHOW_IM_PICKER) == 0) {
            this.mShowExplicitlyRequested = true;
        }
        if ((flags & MSG_SHOW_IM_SUBTYPE_PICKER) != 0) {
            this.mShowExplicitlyRequested = true;
            this.mShowForced = true;
        }
        if (!this.mSystemReady) {
            return DEBUG;
        }
        if (this.mCurMethod != null) {
            executeOrSendMessage(this.mCurMethod, this.mCaller.obtainMessageIOO(MSG_SHOW_SOFT_INPUT, getImeShowFlags(), this.mCurMethod, resultReceiver));
            this.mInputShown = true;
            if (this.mHaveConnection && !this.mVisibleBound) {
                bindCurrentInputMethodService(this.mCurIntent, this.mVisibleConnection, 134217729);
                this.mVisibleBound = true;
            }
            return true;
        } else if (!this.mHaveConnection || SystemClock.uptimeMillis() < this.mLastBindTime + TIME_TO_RECONNECT) {
            return DEBUG;
        } else {
            Object[] objArr = new Object[MSG_SHOW_IM_SUBTYPE_ENABLER];
            objArr[0] = this.mCurMethodId;
            objArr[MSG_SHOW_IM_PICKER] = Long.valueOf(SystemClock.uptimeMillis() - this.mLastBindTime);
            objArr[MSG_SHOW_IM_SUBTYPE_PICKER] = Integer.valueOf(MSG_SHOW_IM_PICKER);
            EventLog.writeEvent(EventLogTags.IMF_FORCE_RECONNECT_IME, objArr);
            Slog.w(TAG, "Force disconnect/connect to the IME in showCurrentInputLocked()");
            this.mContext.unbindService(this);
            bindCurrentInputMethodService(this.mCurIntent, this, 1073741825);
            return DEBUG;
        }
    }

    public boolean hideSoftInput(IInputMethodClient client, int flags, ResultReceiver resultReceiver) {
        boolean z = DEBUG;
        if (calledFromValidUser()) {
            int uid = Binder.getCallingUid();
            long ident = Binder.clearCallingIdentity();
            try {
                synchronized (this.mMethodMap) {
                    if (this.mCurClient == null || client == null || this.mCurClient.client.asBinder() != client.asBinder()) {
                        try {
                            if (!this.mIWindowManager.inputMethodClientHasFocus(client)) {
                                setImeWindowVisibilityStatusHiddenLocked();
                                while (true) {
                                    break;
                                }
                            }
                        } catch (RemoteException e) {
                            setImeWindowVisibilityStatusHiddenLocked();
                            Binder.restoreCallingIdentity(ident);
                        }
                    }
                    z = hideCurrentInputLocked(flags, resultReceiver);
                    Binder.restoreCallingIdentity(ident);
                }
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
        return z;
    }

    boolean hideCurrentInputLocked(int flags, ResultReceiver resultReceiver) {
        if ((flags & MSG_SHOW_IM_PICKER) != 0 && (this.mShowExplicitlyRequested || this.mShowForced)) {
            return DEBUG;
        }
        if (this.mShowForced && (flags & MSG_SHOW_IM_SUBTYPE_PICKER) != 0) {
            return DEBUG;
        }
        boolean res;
        if (!this.mInputShown || this.mCurMethod == null) {
            res = DEBUG;
        } else {
            executeOrSendMessage(this.mCurMethod, this.mCaller.obtainMessageOO(MSG_HIDE_SOFT_INPUT, this.mCurMethod, resultReceiver));
            res = true;
        }
        if (this.mHaveConnection && this.mVisibleBound) {
            this.mContext.unbindService(this.mVisibleConnection);
            this.mVisibleBound = DEBUG;
        }
        this.mInputShown = DEBUG;
        this.mShowRequested = DEBUG;
        this.mShowExplicitlyRequested = DEBUG;
        this.mShowForced = DEBUG;
        return res;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public com.android.internal.view.InputBindResult windowGainedFocus(com.android.internal.view.IInputMethodClient r17, android.os.IBinder r18, int r19, int r20, int r21, android.view.inputmethod.EditorInfo r22, com.android.internal.view.IInputContext r23) {
        /*
        r16 = this;
        r4 = r16.calledFromValidUser();
        r11 = 0;
        r8 = android.os.Binder.clearCallingIdentity();
        r0 = r16;
        r13 = r0.mMethodMap;	 Catch:{ all -> 0x003e }
        monitor-enter(r13);	 Catch:{ all -> 0x003e }
        r0 = r16;
        r12 = r0.mClients;	 Catch:{ all -> 0x003b }
        r14 = r17.asBinder();	 Catch:{ all -> 0x003b }
        r5 = r12.get(r14);	 Catch:{ all -> 0x003b }
        r5 = (com.android.server.InputMethodManagerService.ClientState) r5;	 Catch:{ all -> 0x003b }
        if (r5 != 0) goto L_0x0043;
    L_0x001e:
        r12 = new java.lang.IllegalArgumentException;	 Catch:{ all -> 0x003b }
        r14 = new java.lang.StringBuilder;	 Catch:{ all -> 0x003b }
        r14.<init>();	 Catch:{ all -> 0x003b }
        r15 = "unknown client ";
        r14 = r14.append(r15);	 Catch:{ all -> 0x003b }
        r15 = r17.asBinder();	 Catch:{ all -> 0x003b }
        r14 = r14.append(r15);	 Catch:{ all -> 0x003b }
        r14 = r14.toString();	 Catch:{ all -> 0x003b }
        r12.<init>(r14);	 Catch:{ all -> 0x003b }
        throw r12;	 Catch:{ all -> 0x003b }
    L_0x003b:
        r12 = move-exception;
        monitor-exit(r13);	 Catch:{ all -> 0x003b }
        throw r12;	 Catch:{ all -> 0x003e }
    L_0x003e:
        r12 = move-exception;
        android.os.Binder.restoreCallingIdentity(r8);
        throw r12;
    L_0x0043:
        r0 = r16;
        r12 = r0.mIWindowManager;	 Catch:{ RemoteException -> 0x008d }
        r14 = r5.client;	 Catch:{ RemoteException -> 0x008d }
        r12 = r12.inputMethodClientHasFocus(r14);	 Catch:{ RemoteException -> 0x008d }
        if (r12 != 0) goto L_0x008e;
    L_0x004f:
        r12 = "InputMethodManagerService";
        r14 = new java.lang.StringBuilder;	 Catch:{ RemoteException -> 0x008d }
        r14.<init>();	 Catch:{ RemoteException -> 0x008d }
        r15 = "Focus gain on non-focused client ";
        r14 = r14.append(r15);	 Catch:{ RemoteException -> 0x008d }
        r15 = r5.client;	 Catch:{ RemoteException -> 0x008d }
        r14 = r14.append(r15);	 Catch:{ RemoteException -> 0x008d }
        r15 = " (uid=";
        r14 = r14.append(r15);	 Catch:{ RemoteException -> 0x008d }
        r15 = r5.uid;	 Catch:{ RemoteException -> 0x008d }
        r14 = r14.append(r15);	 Catch:{ RemoteException -> 0x008d }
        r15 = " pid=";
        r14 = r14.append(r15);	 Catch:{ RemoteException -> 0x008d }
        r15 = r5.pid;	 Catch:{ RemoteException -> 0x008d }
        r14 = r14.append(r15);	 Catch:{ RemoteException -> 0x008d }
        r15 = ")";
        r14 = r14.append(r15);	 Catch:{ RemoteException -> 0x008d }
        r14 = r14.toString();	 Catch:{ RemoteException -> 0x008d }
        android.util.Slog.w(r12, r14);	 Catch:{ RemoteException -> 0x008d }
        r12 = 0;
        monitor-exit(r13);	 Catch:{ all -> 0x003b }
        android.os.Binder.restoreCallingIdentity(r8);
    L_0x008c:
        return r12;
    L_0x008d:
        r12 = move-exception;
    L_0x008e:
        if (r4 != 0) goto L_0x00ab;
    L_0x0090:
        r12 = "InputMethodManagerService";
        r14 = "A background user is requesting window. Hiding IME.";
        android.util.Slog.w(r12, r14);	 Catch:{ all -> 0x003b }
        r12 = "InputMethodManagerService";
        r14 = "If you want to interect with IME, you need android.permission.INTERACT_ACROSS_USERS_FULL";
        android.util.Slog.w(r12, r14);	 Catch:{ all -> 0x003b }
        r12 = 0;
        r14 = 0;
        r0 = r16;
        r0.hideCurrentInputLocked(r12, r14);	 Catch:{ all -> 0x003b }
        r12 = 0;
        monitor-exit(r13);	 Catch:{ all -> 0x003b }
        android.os.Binder.restoreCallingIdentity(r8);
        goto L_0x008c;
    L_0x00ab:
        r0 = r16;
        r12 = r0.mCurFocusedWindow;	 Catch:{ all -> 0x003b }
        r0 = r18;
        if (r12 != r0) goto L_0x00fe;
    L_0x00b3:
        r12 = "InputMethodManagerService";
        r14 = new java.lang.StringBuilder;	 Catch:{ all -> 0x003b }
        r14.<init>();	 Catch:{ all -> 0x003b }
        r15 = "Window already focused, ignoring focus gain of: ";
        r14 = r14.append(r15);	 Catch:{ all -> 0x003b }
        r0 = r17;
        r14 = r14.append(r0);	 Catch:{ all -> 0x003b }
        r15 = " attribute=";
        r14 = r14.append(r15);	 Catch:{ all -> 0x003b }
        r0 = r22;
        r14 = r14.append(r0);	 Catch:{ all -> 0x003b }
        r15 = ", token = ";
        r14 = r14.append(r15);	 Catch:{ all -> 0x003b }
        r0 = r18;
        r14 = r14.append(r0);	 Catch:{ all -> 0x003b }
        r14 = r14.toString();	 Catch:{ all -> 0x003b }
        android.util.Slog.w(r12, r14);	 Catch:{ all -> 0x003b }
        if (r22 == 0) goto L_0x00f8;
    L_0x00e7:
        r0 = r16;
        r1 = r23;
        r2 = r22;
        r3 = r19;
        r12 = r0.startInputUncheckedLocked(r5, r1, r2, r3);	 Catch:{ all -> 0x003b }
        monitor-exit(r13);	 Catch:{ all -> 0x003b }
        android.os.Binder.restoreCallingIdentity(r8);
        goto L_0x008c;
    L_0x00f8:
        r12 = 0;
        monitor-exit(r13);	 Catch:{ all -> 0x003b }
        android.os.Binder.restoreCallingIdentity(r8);
        goto L_0x008c;
    L_0x00fe:
        r0 = r18;
        r1 = r16;
        r1.mCurFocusedWindow = r0;	 Catch:{ all -> 0x003b }
        r0 = r20;
        r12 = r0 & 240;
        r14 = 16;
        if (r12 == r14) goto L_0x011b;
    L_0x010c:
        r0 = r16;
        r12 = r0.mRes;	 Catch:{ all -> 0x003b }
        r12 = r12.getConfiguration();	 Catch:{ all -> 0x003b }
        r14 = 3;
        r12 = r12.isLayoutSizeAtLeast(r14);	 Catch:{ all -> 0x003b }
        if (r12 == 0) goto L_0x013e;
    L_0x011b:
        r7 = 1;
    L_0x011c:
        r12 = r19 & 2;
        if (r12 == 0) goto L_0x0140;
    L_0x0120:
        r10 = 1;
    L_0x0121:
        r6 = 0;
        r12 = r20 & 15;
        switch(r12) {
            case 0: goto L_0x0142;
            case 1: goto L_0x0127;
            case 2: goto L_0x0175;
            case 3: goto L_0x0183;
            case 4: goto L_0x018b;
            case 5: goto L_0x01a8;
            default: goto L_0x0127;
        };	 Catch:{ all -> 0x003b }
    L_0x0127:
        if (r6 != 0) goto L_0x0137;
    L_0x0129:
        if (r22 == 0) goto L_0x0137;
    L_0x012b:
        r0 = r16;
        r1 = r23;
        r2 = r22;
        r3 = r19;
        r11 = r0.startInputUncheckedLocked(r5, r1, r2, r3);	 Catch:{ all -> 0x003b }
    L_0x0137:
        monitor-exit(r13);	 Catch:{ all -> 0x003b }
        android.os.Binder.restoreCallingIdentity(r8);
        r12 = r11;
        goto L_0x008c;
    L_0x013e:
        r7 = 0;
        goto L_0x011c;
    L_0x0140:
        r10 = 0;
        goto L_0x0121;
    L_0x0142:
        if (r10 == 0) goto L_0x0146;
    L_0x0144:
        if (r7 != 0) goto L_0x0154;
    L_0x0146:
        r12 = android.view.WindowManager.LayoutParams.mayUseInputMethod(r21);	 Catch:{ all -> 0x003b }
        if (r12 == 0) goto L_0x0127;
    L_0x014c:
        r12 = 2;
        r14 = 0;
        r0 = r16;
        r0.hideCurrentInputLocked(r12, r14);	 Catch:{ all -> 0x003b }
        goto L_0x0127;
    L_0x0154:
        if (r10 == 0) goto L_0x0127;
    L_0x0156:
        if (r7 == 0) goto L_0x0127;
    L_0x0158:
        r0 = r20;
        r12 = r0 & 256;
        if (r12 == 0) goto L_0x0127;
    L_0x015e:
        if (r22 == 0) goto L_0x016d;
    L_0x0160:
        r0 = r16;
        r1 = r23;
        r2 = r22;
        r3 = r19;
        r11 = r0.startInputUncheckedLocked(r5, r1, r2, r3);	 Catch:{ all -> 0x003b }
        r6 = 1;
    L_0x016d:
        r12 = 1;
        r14 = 0;
        r0 = r16;
        r0.showCurrentInputLocked(r12, r14);	 Catch:{ all -> 0x003b }
        goto L_0x0127;
    L_0x0175:
        r0 = r20;
        r12 = r0 & 256;
        if (r12 == 0) goto L_0x0127;
    L_0x017b:
        r12 = 0;
        r14 = 0;
        r0 = r16;
        r0.hideCurrentInputLocked(r12, r14);	 Catch:{ all -> 0x003b }
        goto L_0x0127;
    L_0x0183:
        r12 = 0;
        r14 = 0;
        r0 = r16;
        r0.hideCurrentInputLocked(r12, r14);	 Catch:{ all -> 0x003b }
        goto L_0x0127;
    L_0x018b:
        r0 = r20;
        r12 = r0 & 256;
        if (r12 == 0) goto L_0x0127;
    L_0x0191:
        if (r22 == 0) goto L_0x01a0;
    L_0x0193:
        r0 = r16;
        r1 = r23;
        r2 = r22;
        r3 = r19;
        r11 = r0.startInputUncheckedLocked(r5, r1, r2, r3);	 Catch:{ all -> 0x003b }
        r6 = 1;
    L_0x01a0:
        r12 = 1;
        r14 = 0;
        r0 = r16;
        r0.showCurrentInputLocked(r12, r14);	 Catch:{ all -> 0x003b }
        goto L_0x0127;
    L_0x01a8:
        if (r22 == 0) goto L_0x01b7;
    L_0x01aa:
        r0 = r16;
        r1 = r23;
        r2 = r22;
        r3 = r19;
        r11 = r0.startInputUncheckedLocked(r5, r1, r2, r3);	 Catch:{ all -> 0x003b }
        r6 = 1;
    L_0x01b7:
        r12 = 1;
        r14 = 0;
        r0 = r16;
        r0.showCurrentInputLocked(r12, r14);	 Catch:{ all -> 0x003b }
        goto L_0x0127;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.InputMethodManagerService.windowGainedFocus(com.android.internal.view.IInputMethodClient, android.os.IBinder, int, int, int, android.view.inputmethod.EditorInfo, com.android.internal.view.IInputContext):com.android.internal.view.InputBindResult");
    }

    public void showInputMethodPickerFromClient(IInputMethodClient client) {
        if (calledFromValidUser()) {
            synchronized (this.mMethodMap) {
                if (this.mCurClient == null || client == null || this.mCurClient.client.asBinder() != client.asBinder()) {
                    Slog.w(TAG, "Ignoring showInputMethodPickerFromClient of uid " + Binder.getCallingUid() + ": " + client);
                }
                this.mHandler.sendEmptyMessage(MSG_SHOW_IM_SUBTYPE_PICKER);
            }
        }
    }

    public void setInputMethod(IBinder token, String id) {
        if (calledFromValidUser()) {
            setInputMethodWithSubtypeId(token, id, NOT_A_SUBTYPE_ID);
        }
    }

    public void setInputMethodAndSubtype(IBinder token, String id, InputMethodSubtype subtype) {
        if (calledFromValidUser()) {
            synchronized (this.mMethodMap) {
                if (subtype != null) {
                    setInputMethodWithSubtypeIdLocked(token, id, InputMethodUtils.getSubtypeIdFromHashCode((InputMethodInfo) this.mMethodMap.get(id), subtype.hashCode()));
                } else {
                    setInputMethod(token, id);
                }
            }
        }
    }

    public void showInputMethodAndSubtypeEnablerFromClient(IInputMethodClient client, String inputMethodId) {
        if (calledFromValidUser()) {
            synchronized (this.mMethodMap) {
                if (this.mCurClient == null || client == null || this.mCurClient.client.asBinder() != client.asBinder()) {
                    Slog.w(TAG, "Ignoring showInputMethodAndSubtypeEnablerFromClient of: " + client);
                }
                executeOrSendMessage(this.mCurMethod, this.mCaller.obtainMessageO(MSG_SHOW_IM_SUBTYPE_ENABLER, inputMethodId));
            }
        }
    }

    public boolean switchToLastInputMethod(IBinder token) {
        if (!calledFromValidUser()) {
            return DEBUG;
        }
        synchronized (this.mMethodMap) {
            InputMethodInfo lastImi;
            Pair<String, String> lastIme = this.mSettings.getLastInputMethodAndSubtypeLocked();
            if (lastIme != null) {
                lastImi = (InputMethodInfo) this.mMethodMap.get(lastIme.first);
            } else {
                lastImi = null;
            }
            String targetLastImiId = null;
            int subtypeId = NOT_A_SUBTYPE_ID;
            if (!(lastIme == null || lastImi == null)) {
                boolean imiIdIsSame = lastImi.getId().equals(this.mCurMethodId);
                int lastSubtypeHash = Integer.valueOf((String) lastIme.second).intValue();
                int currentSubtypeHash;
                if (this.mCurrentSubtype == null) {
                    currentSubtypeHash = NOT_A_SUBTYPE_ID;
                } else {
                    currentSubtypeHash = this.mCurrentSubtype.hashCode();
                }
                if (!(imiIdIsSame && lastSubtypeHash == currentSubtypeHash)) {
                    targetLastImiId = lastIme.first;
                    subtypeId = InputMethodUtils.getSubtypeIdFromHashCode(lastImi, lastSubtypeHash);
                }
            }
            if (TextUtils.isEmpty(targetLastImiId)) {
                if (!InputMethodUtils.canAddToLastInputMethod(this.mCurrentSubtype)) {
                    List<InputMethodInfo> enabled = this.mSettings.getEnabledInputMethodListLocked();
                    if (enabled != null) {
                        String locale;
                        int N = enabled.size();
                        if (this.mCurrentSubtype == null) {
                            locale = this.mRes.getConfiguration().locale.toString();
                        } else {
                            locale = this.mCurrentSubtype.getLocale();
                        }
                        for (int i = 0; i < N; i += MSG_SHOW_IM_PICKER) {
                            InputMethodInfo imi = (InputMethodInfo) enabled.get(i);
                            if (imi.getSubtypeCount() > 0 && InputMethodUtils.isSystemIme(imi)) {
                                InputMethodSubtype keyboardSubtype = InputMethodUtils.findLastResortApplicableSubtypeLocked(this.mRes, InputMethodUtils.getSubtypes(imi), "keyboard", locale, true);
                                if (keyboardSubtype != null) {
                                    targetLastImiId = imi.getId();
                                    subtypeId = InputMethodUtils.getSubtypeIdFromHashCode(imi, keyboardSubtype.hashCode());
                                    if (keyboardSubtype.getLocale().equals(locale)) {
                                        break;
                                    }
                                } else {
                                    continue;
                                }
                            }
                        }
                    }
                }
            }
            if (TextUtils.isEmpty(targetLastImiId)) {
                return DEBUG;
            }
            setInputMethodWithSubtypeIdLocked(token, targetLastImiId, subtypeId);
            return true;
        }
    }

    public boolean switchToNextInputMethod(IBinder token, boolean onlyCurrentIme) {
        if (!calledFromValidUser()) {
            return DEBUG;
        }
        synchronized (this.mMethodMap) {
            if (calledWithValidToken(token)) {
                ImeSubtypeListItem nextSubtype = this.mSwitchingController.getNextInputMethodLocked(onlyCurrentIme, (InputMethodInfo) this.mMethodMap.get(this.mCurMethodId), this.mCurrentSubtype);
                if (nextSubtype == null) {
                    return DEBUG;
                }
                setInputMethodWithSubtypeIdLocked(token, nextSubtype.mImi.getId(), nextSubtype.mSubtypeId);
                return true;
            }
            Slog.e(TAG, "Ignoring switchToNextInputMethod due to an invalid token. uid:" + Binder.getCallingUid() + " token:" + token);
            return DEBUG;
        }
    }

    public boolean shouldOfferSwitchingToNextInputMethod(IBinder token) {
        if (!calledFromValidUser()) {
            return DEBUG;
        }
        synchronized (this.mMethodMap) {
            if (!calledWithValidToken(token)) {
                Slog.e(TAG, "Ignoring shouldOfferSwitchingToNextInputMethod due to an invalid token. uid:" + Binder.getCallingUid() + " token:" + token);
                return DEBUG;
            } else if (this.mSwitchingController.getNextInputMethodLocked(DEBUG, (InputMethodInfo) this.mMethodMap.get(this.mCurMethodId), this.mCurrentSubtype) == null) {
                return DEBUG;
            } else {
                return true;
            }
        }
    }

    public InputMethodSubtype getLastInputMethodSubtype() {
        if (!calledFromValidUser()) {
            return null;
        }
        synchronized (this.mMethodMap) {
            Pair<String, String> lastIme = this.mSettings.getLastInputMethodAndSubtypeLocked();
            if (lastIme == null || TextUtils.isEmpty((CharSequence) lastIme.first) || TextUtils.isEmpty((CharSequence) lastIme.second)) {
                return null;
            }
            InputMethodInfo lastImi = (InputMethodInfo) this.mMethodMap.get(lastIme.first);
            if (lastImi == null) {
                return null;
            }
            try {
                int lastSubtypeId = InputMethodUtils.getSubtypeIdFromHashCode(lastImi, Integer.valueOf((String) lastIme.second).intValue());
                if (lastSubtypeId < 0 || lastSubtypeId >= lastImi.getSubtypeCount()) {
                    return null;
                }
                InputMethodSubtype subtypeAt = lastImi.getSubtypeAt(lastSubtypeId);
                return subtypeAt;
            } catch (NumberFormatException e) {
                return null;
            }
        }
    }

    public void setAdditionalInputMethodSubtypes(String imiId, InputMethodSubtype[] subtypes) {
        long ident;
        if (calledFromValidUser() && !TextUtils.isEmpty(imiId) && subtypes != null && subtypes.length != 0) {
            synchronized (this.mMethodMap) {
                InputMethodInfo imi = (InputMethodInfo) this.mMethodMap.get(imiId);
                if (imi == null) {
                    return;
                }
                try {
                    String[] packageInfos = this.mIPackageManager.getPackagesForUid(Binder.getCallingUid());
                    if (packageInfos != null) {
                        int packageNum = packageInfos.length;
                        for (int i = 0; i < packageNum; i += MSG_SHOW_IM_PICKER) {
                            if (packageInfos[i].equals(imi.getPackageName())) {
                                this.mFileManager.addInputMethodSubtypes(imi, subtypes);
                                ident = Binder.clearCallingIdentity();
                                buildInputMethodListLocked(this.mMethodList, this.mMethodMap, DEBUG);
                                Binder.restoreCallingIdentity(ident);
                                return;
                            }
                        }
                    }
                } catch (RemoteException e) {
                    Slog.e(TAG, "Failed to get package infos");
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(ident);
                }
            }
        }
    }

    public int getInputMethodWindowVisibleHeight() {
        return this.mWindowManagerService.getInputMethodWindowVisibleHeight();
    }

    public void notifyUserAction(int sequenceNumber) {
        synchronized (this.mMethodMap) {
            if (this.mCurUserActionNotificationSequenceNumber != sequenceNumber) {
                return;
            }
            InputMethodInfo imi = (InputMethodInfo) this.mMethodMap.get(this.mCurMethodId);
            if (imi != null) {
                this.mSwitchingController.onUserActionLocked(imi, this.mCurrentSubtype);
            }
        }
    }

    private void setInputMethodWithSubtypeId(IBinder token, String id, int subtypeId) {
        synchronized (this.mMethodMap) {
            setInputMethodWithSubtypeIdLocked(token, id, subtypeId);
        }
    }

    private void setInputMethodWithSubtypeIdLocked(IBinder token, String id, int subtypeId) {
        if (token == null) {
            if (this.mContext.checkCallingOrSelfPermission("android.permission.WRITE_SECURE_SETTINGS") != 0) {
                throw new SecurityException("Using null token requires permission android.permission.WRITE_SECURE_SETTINGS");
            }
        } else if (this.mCurToken != token) {
            Slog.w(TAG, "Ignoring setInputMethod of uid " + Binder.getCallingUid() + " token: " + token);
            return;
        }
        long ident = Binder.clearCallingIdentity();
        try {
            setInputMethodLocked(id, subtypeId);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public void hideMySoftInput(IBinder token, int flags) {
        if (calledFromValidUser()) {
            synchronized (this.mMethodMap) {
                if (calledWithValidToken(token)) {
                    long ident = Binder.clearCallingIdentity();
                    try {
                        hideCurrentInputLocked(flags, null);
                    } finally {
                        Binder.restoreCallingIdentity(ident);
                    }
                } else {
                    Slog.e(TAG, "Ignoring hideInputMethod due to an invalid token. uid:" + Binder.getCallingUid() + " token:" + token);
                }
            }
        }
    }

    public void showMySoftInput(IBinder token, int flags) {
        if (calledFromValidUser()) {
            synchronized (this.mMethodMap) {
                if (calledWithValidToken(token)) {
                    long ident = Binder.clearCallingIdentity();
                    try {
                        showCurrentInputLocked(flags, null);
                    } finally {
                        Binder.restoreCallingIdentity(ident);
                    }
                } else {
                    Slog.e(TAG, "Ignoring showMySoftInput due to an invalid token. uid:" + Binder.getCallingUid() + " token:" + token);
                }
            }
        }
    }

    void setEnabledSessionInMainThread(SessionState session) {
        if (this.mEnabledSession != session) {
            if (!(this.mEnabledSession == null || this.mEnabledSession.session == null)) {
                try {
                    this.mEnabledSession.method.setSessionEnabled(this.mEnabledSession.session, DEBUG);
                } catch (RemoteException e) {
                }
            }
            this.mEnabledSession = session;
            if (this.mEnabledSession != null && this.mEnabledSession.session != null) {
                try {
                    this.mEnabledSession.method.setSessionEnabled(this.mEnabledSession.session, true);
                } catch (RemoteException e2) {
                }
            }
        }
    }

    public boolean handleMessage(Message msg) {
        boolean z = DEBUG;
        SomeArgs args;
        SessionState session;
        switch (msg.what) {
            case MSG_SHOW_IM_PICKER /*1*/:
                showInputMethodMenu();
                return true;
            case MSG_SHOW_IM_SUBTYPE_PICKER /*2*/:
                showInputMethodSubtypeMenu();
                return true;
            case MSG_SHOW_IM_SUBTYPE_ENABLER /*3*/:
                args = msg.obj;
                showInputMethodAndSubtypeEnabler((String) args.arg1);
                args.recycle();
                return true;
            case MSG_SHOW_IM_CONFIG /*4*/:
                showConfigureInputMethods();
                return true;
            case MSG_UNBIND_INPUT /*1000*/:
                try {
                    ((IInputMethod) msg.obj).unbindInput();
                    return true;
                } catch (RemoteException e) {
                    return true;
                }
            case MSG_BIND_INPUT /*1010*/:
                args = (SomeArgs) msg.obj;
                try {
                    ((IInputMethod) args.arg1).bindInput((InputBinding) args.arg2);
                } catch (RemoteException e2) {
                }
                args.recycle();
                return true;
            case MSG_SHOW_SOFT_INPUT /*1020*/:
                args = (SomeArgs) msg.obj;
                try {
                    ((IInputMethod) args.arg1).showSoftInput(msg.arg1, (ResultReceiver) args.arg2);
                } catch (RemoteException e3) {
                }
                args.recycle();
                return true;
            case MSG_HIDE_SOFT_INPUT /*1030*/:
                args = (SomeArgs) msg.obj;
                try {
                    ((IInputMethod) args.arg1).hideSoftInput(0, (ResultReceiver) args.arg2);
                } catch (RemoteException e4) {
                }
                args.recycle();
                return true;
            case MSG_ATTACH_TOKEN /*1040*/:
                args = (SomeArgs) msg.obj;
                try {
                    ((IInputMethod) args.arg1).attachToken((IBinder) args.arg2);
                } catch (RemoteException e5) {
                }
                args.recycle();
                return true;
            case MSG_CREATE_SESSION /*1050*/:
                args = (SomeArgs) msg.obj;
                IInputMethod method = args.arg1;
                InputChannel channel = args.arg2;
                try {
                    method.createSession(channel, (IInputSessionCallback) args.arg3);
                    if (channel != null && Binder.isProxy(method)) {
                        channel.dispose();
                    }
                } catch (RemoteException e6) {
                    if (channel != null && Binder.isProxy(method)) {
                        channel.dispose();
                    }
                } catch (Throwable th) {
                    if (channel != null && Binder.isProxy(method)) {
                        channel.dispose();
                    }
                }
                args.recycle();
                return true;
            case MSG_START_INPUT /*2000*/:
                args = (SomeArgs) msg.obj;
                try {
                    session = args.arg1;
                    setEnabledSessionInMainThread(session);
                    session.method.startInput((IInputContext) args.arg2, (EditorInfo) args.arg3);
                } catch (RemoteException e7) {
                }
                args.recycle();
                return true;
            case MSG_RESTART_INPUT /*2010*/:
                args = (SomeArgs) msg.obj;
                try {
                    session = (SessionState) args.arg1;
                    setEnabledSessionInMainThread(session);
                    session.method.restartInput((IInputContext) args.arg2, (EditorInfo) args.arg3);
                } catch (RemoteException e8) {
                }
                args.recycle();
                return true;
            case MSG_UNBIND_METHOD /*3000*/:
                try {
                    ((IInputMethodClient) msg.obj).onUnbindMethod(msg.arg1);
                    return true;
                } catch (RemoteException e9) {
                    return true;
                }
            case MSG_BIND_METHOD /*3010*/:
                args = (SomeArgs) msg.obj;
                IInputMethodClient client = args.arg1;
                InputBindResult res = args.arg2;
                try {
                    client.onBindMethod(res);
                    if (res.channel != null && Binder.isProxy(client)) {
                        res.channel.dispose();
                    }
                } catch (RemoteException e10) {
                    Slog.w(TAG, "Client died receiving input method " + args.arg2);
                    if (res.channel != null && Binder.isProxy(client)) {
                        res.channel.dispose();
                    }
                } catch (Throwable th2) {
                    if (res.channel != null && Binder.isProxy(client)) {
                        res.channel.dispose();
                    }
                }
                args.recycle();
                return true;
            case MSG_SET_ACTIVE /*3020*/:
                try {
                    IInputMethodClient iInputMethodClient = ((ClientState) msg.obj).client;
                    if (msg.arg1 != 0) {
                        z = true;
                    }
                    iInputMethodClient.setActive(z);
                    return true;
                } catch (RemoteException e11) {
                    Slog.w(TAG, "Got RemoteException sending setActive(false) notification to pid " + ((ClientState) msg.obj).pid + " uid " + ((ClientState) msg.obj).uid);
                    return true;
                }
            case MSG_SET_USER_ACTION_NOTIFICATION_SEQUENCE_NUMBER /*3040*/:
                int sequenceNumber = msg.arg1;
                ClientState clientState = msg.obj;
                try {
                    clientState.client.setUserActionNotificationSequenceNumber(sequenceNumber);
                    return true;
                } catch (RemoteException e12) {
                    Slog.w(TAG, "Got RemoteException sending setUserActionNotificationSequenceNumber(" + sequenceNumber + ") notification to pid " + clientState.pid + " uid " + clientState.uid);
                    return true;
                }
            case MSG_HARD_KEYBOARD_SWITCH_CHANGED /*4000*/:
                this.mHardKeyboardListener.handleHardKeyboardStatusChange(msg.arg1 == MSG_SHOW_IM_PICKER ? true : DEBUG);
                return true;
            default:
                return DEBUG;
        }
    }

    private boolean chooseNewDefaultIMELocked() {
        InputMethodInfo imi = InputMethodUtils.getMostApplicableDefaultIME(this.mSettings.getEnabledInputMethodListLocked());
        if (imi == null) {
            return DEBUG;
        }
        resetSelectedInputMethodAndSubtypeLocked(imi.getId());
        return true;
    }

    void buildInputMethodListLocked(ArrayList<InputMethodInfo> list, HashMap<String, InputMethodInfo> map, boolean resetDefaultEnabledIme) {
        int i;
        list.clear();
        map.clear();
        PackageManager pm = this.mContext.getPackageManager();
        if (this.mSettings.getDisabledSystemInputMethods() == null) {
            String disabledSysImes = "";
        }
        List<ResolveInfo> services = pm.queryIntentServicesAsUser(new Intent("android.view.InputMethod"), 32896, this.mSettings.getCurrentUserId());
        HashMap<String, List<InputMethodSubtype>> additionalSubtypes = this.mFileManager.getAllAdditionalInputMethodSubtypes();
        for (i = 0; i < services.size(); i += MSG_SHOW_IM_PICKER) {
            ResolveInfo ri = (ResolveInfo) services.get(i);
            ServiceInfo si = ri.serviceInfo;
            ComponentName compName = new ComponentName(si.packageName, si.name);
            if ("android.permission.BIND_INPUT_METHOD".equals(si.permission)) {
                try {
                    InputMethodInfo p = new InputMethodInfo(this.mContext, ri, additionalSubtypes);
                    list.add(p);
                    map.put(p.getId(), p);
                } catch (XmlPullParserException e) {
                    Slog.w(TAG, "Unable to load input method " + compName, e);
                } catch (IOException e2) {
                    Slog.w(TAG, "Unable to load input method " + compName, e2);
                }
            } else {
                Slog.w(TAG, "Skipping input method " + compName + ": it does not require the permission " + "android.permission.BIND_INPUT_METHOD");
            }
        }
        if (resetDefaultEnabledIme) {
            ArrayList<InputMethodInfo> defaultEnabledIme = InputMethodUtils.getDefaultEnabledImes(this.mContext, this.mSystemReady, list);
            for (i = 0; i < defaultEnabledIme.size(); i += MSG_SHOW_IM_PICKER) {
                setInputMethodEnabledLocked(((InputMethodInfo) defaultEnabledIme.get(i)).getId(), true);
            }
        }
        String defaultImiId = this.mSettings.getSelectedInputMethod();
        if (!TextUtils.isEmpty(defaultImiId)) {
            if (map.containsKey(defaultImiId)) {
                setInputMethodEnabledLocked(defaultImiId, true);
            } else {
                Slog.w(TAG, "Default IME is uninstalled. Choose new default IME.");
                if (chooseNewDefaultIMELocked()) {
                    updateInputMethodsFromSettingsLocked(true);
                }
            }
        }
        this.mSwitchingController.resetCircularListLocked(this.mContext);
    }

    private void showInputMethodMenu() {
        showInputMethodMenuInternal(DEBUG);
    }

    private void showInputMethodSubtypeMenu() {
        showInputMethodMenuInternal(true);
    }

    private void showInputMethodAndSubtypeEnabler(String inputMethodId) {
        Intent intent = new Intent("android.settings.INPUT_METHOD_SUBTYPE_SETTINGS");
        intent.setFlags(337641472);
        if (!TextUtils.isEmpty(inputMethodId)) {
            intent.putExtra("input_method_id", inputMethodId);
        }
        this.mContext.startActivityAsUser(intent, null, UserHandle.CURRENT);
    }

    private void showConfigureInputMethods() {
        Intent intent = new Intent("android.settings.INPUT_METHOD_SETTINGS");
        intent.setFlags(337641472);
        this.mContext.startActivityAsUser(intent, null, UserHandle.CURRENT);
    }

    private boolean isScreenLocked() {
        return (this.mKeyguardManager != null && this.mKeyguardManager.isKeyguardLocked() && this.mKeyguardManager.isKeyguardSecure()) ? true : DEBUG;
    }

    private void showInputMethodMenuInternal(boolean showSubtypes) {
        Context context = this.mContext;
        boolean isScreenLocked = isScreenLocked();
        String lastInputMethodId = this.mSettings.getSelectedInputMethod();
        int lastInputMethodSubtypeId = this.mSettings.getSelectedInputMethodSubtypeId(lastInputMethodId);
        synchronized (this.mMethodMap) {
            HashMap<InputMethodInfo, List<InputMethodSubtype>> immis = this.mSettings.getExplicitlyOrImplicitlyEnabledInputMethodsAndSubtypeListLocked(this.mContext);
            if (immis == null || immis.size() == 0) {
                return;
            }
            hideInputMethodMenuLocked();
            List<ImeSubtypeListItem> imList = this.mSwitchingController.getSortedInputMethodAndSubtypeListLocked(showSubtypes, this.mInputShown, isScreenLocked);
            if (lastInputMethodSubtypeId == NOT_A_SUBTYPE_ID) {
                InputMethodSubtype currentSubtype = getCurrentInputMethodSubtypeLocked();
                if (currentSubtype != null) {
                    lastInputMethodSubtypeId = InputMethodUtils.getSubtypeIdFromHashCode((InputMethodInfo) this.mMethodMap.get(this.mCurMethodId), currentSubtype.hashCode());
                }
            }
            int N = imList.size();
            this.mIms = new InputMethodInfo[N];
            this.mSubtypeIds = new int[N];
            int checkedItem = 0;
            for (int i = 0; i < N; i += MSG_SHOW_IM_PICKER) {
                ImeSubtypeListItem item = (ImeSubtypeListItem) imList.get(i);
                this.mIms[i] = item.mImi;
                this.mSubtypeIds[i] = item.mSubtypeId;
                if (this.mIms[i].getId().equals(lastInputMethodId)) {
                    int subtypeId = this.mSubtypeIds[i];
                    if (subtypeId == NOT_A_SUBTYPE_ID || ((lastInputMethodSubtypeId == NOT_A_SUBTYPE_ID && subtypeId == 0) || subtypeId == lastInputMethodSubtypeId)) {
                        checkedItem = i;
                    }
                }
            }
            this.mDialogBuilder = new Builder(new ContextThemeWrapper(context, 16974371));
            this.mDialogBuilder.setOnCancelListener(new C00455());
            Context dialogContext = this.mDialogBuilder.getContext();
            TypedArray a = dialogContext.obtainStyledAttributes(null, R.styleable.DialogPreference, 16842845, 0);
            Drawable dialogIcon = a.getDrawable(MSG_SHOW_IM_SUBTYPE_PICKER);
            a.recycle();
            this.mDialogBuilder.setIcon(dialogIcon);
            View tv = ((LayoutInflater) dialogContext.getSystemService("layout_inflater")).inflate(17367133, null);
            this.mDialogBuilder.setCustomTitle(tv);
            this.mSwitchingDialogTitleView = tv;
            this.mSwitchingDialogTitleView.findViewById(16909074).setVisibility(this.mWindowManagerService.isHardKeyboardAvailable() ? 0 : 8);
            Switch hardKeySwitch = (Switch) this.mSwitchingDialogTitleView.findViewById(16909075);
            hardKeySwitch.setChecked(this.mShowImeWithHardKeyboard);
            hardKeySwitch.setOnCheckedChangeListener(new C00466());
            ImeSubtypeListAdapter adapter = new ImeSubtypeListAdapter(dialogContext, 17367134, imList, checkedItem);
            this.mDialogBuilder.setSingleChoiceItems(adapter, checkedItem, new C00477(adapter));
            if (showSubtypes && !isScreenLocked) {
                this.mDialogBuilder.setPositiveButton(17040658, new C00488());
            }
            this.mSwitchingDialog = this.mDialogBuilder.create();
            this.mSwitchingDialog.setCanceledOnTouchOutside(true);
            this.mSwitchingDialog.getWindow().setType(2012);
            LayoutParams attributes = this.mSwitchingDialog.getWindow().getAttributes();
            attributes.privateFlags |= 16;
            this.mSwitchingDialog.getWindow().getAttributes().setTitle("Select input method");
            updateImeWindowStatusLocked();
            this.mSwitchingDialog.show();
        }
    }

    void hideInputMethodMenu() {
        synchronized (this.mMethodMap) {
            hideInputMethodMenuLocked();
        }
    }

    void hideInputMethodMenuLocked() {
        if (this.mSwitchingDialog != null) {
            this.mSwitchingDialog.dismiss();
            this.mSwitchingDialog = null;
        }
        updateImeWindowStatusLocked();
        this.mDialogBuilder = null;
        this.mIms = null;
    }

    public boolean setInputMethodEnabled(String id, boolean enabled) {
        if (!calledFromValidUser()) {
            return DEBUG;
        }
        boolean inputMethodEnabledLocked;
        synchronized (this.mMethodMap) {
            if (this.mContext.checkCallingOrSelfPermission("android.permission.WRITE_SECURE_SETTINGS") != 0) {
                throw new SecurityException("Requires permission android.permission.WRITE_SECURE_SETTINGS");
            }
            long ident = Binder.clearCallingIdentity();
            try {
                inputMethodEnabledLocked = setInputMethodEnabledLocked(id, enabled);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
        return inputMethodEnabledLocked;
    }

    boolean setInputMethodEnabledLocked(String id, boolean enabled) {
        if (((InputMethodInfo) this.mMethodMap.get(id)) == null) {
            throw new IllegalArgumentException("Unknown id: " + this.mCurMethodId);
        }
        List<Pair<String, ArrayList<String>>> enabledInputMethodsList = this.mSettings.getEnabledInputMethodsAndSubtypeListLocked();
        if (enabled) {
            for (Pair<String, ArrayList<String>> pair : enabledInputMethodsList) {
                if (((String) pair.first).equals(id)) {
                    return true;
                }
            }
            this.mSettings.appendAndPutEnabledInputMethodLocked(id, DEBUG);
            return DEBUG;
        }
        if (!this.mSettings.buildAndPutEnabledInputMethodsStrRemovingIdLocked(new StringBuilder(), enabledInputMethodsList, id)) {
            return DEBUG;
        }
        if (id.equals(this.mSettings.getSelectedInputMethod()) && !chooseNewDefaultIMELocked()) {
            Slog.i(TAG, "Can't find new IME, unsetting the current input method.");
            resetSelectedInputMethodAndSubtypeLocked("");
        }
        return true;
    }

    private void setSelectedInputMethodAndSubtypeLocked(InputMethodInfo imi, int subtypeId, boolean setSubtypeOnly) {
        this.mSettings.saveCurrentInputMethodAndSubtypeToHistory(this.mCurMethodId, this.mCurrentSubtype);
        this.mCurUserActionNotificationSequenceNumber = Math.max(this.mCurUserActionNotificationSequenceNumber + MSG_SHOW_IM_PICKER, MSG_SHOW_IM_PICKER);
        if (!(this.mCurClient == null || this.mCurClient.client == null)) {
            executeOrSendMessage(this.mCurClient.client, this.mCaller.obtainMessageIO(MSG_SET_USER_ACTION_NOTIFICATION_SEQUENCE_NUMBER, this.mCurUserActionNotificationSequenceNumber, this.mCurClient));
        }
        if (imi == null || subtypeId < 0) {
            this.mSettings.putSelectedSubtype(NOT_A_SUBTYPE_ID);
            this.mCurrentSubtype = null;
        } else if (subtypeId < imi.getSubtypeCount()) {
            InputMethodSubtype subtype = imi.getSubtypeAt(subtypeId);
            this.mSettings.putSelectedSubtype(subtype.hashCode());
            this.mCurrentSubtype = subtype;
        } else {
            this.mSettings.putSelectedSubtype(NOT_A_SUBTYPE_ID);
            this.mCurrentSubtype = getCurrentInputMethodSubtypeLocked();
        }
        if (this.mSystemReady && !setSubtypeOnly) {
            this.mSettings.putSelectedInputMethod(imi != null ? imi.getId() : "");
        }
    }

    private void resetSelectedInputMethodAndSubtypeLocked(String newDefaultIme) {
        InputMethodInfo imi = (InputMethodInfo) this.mMethodMap.get(newDefaultIme);
        int lastSubtypeId = NOT_A_SUBTYPE_ID;
        if (!(imi == null || TextUtils.isEmpty(newDefaultIme))) {
            String subtypeHashCode = this.mSettings.getLastSubtypeForInputMethodLocked(newDefaultIme);
            if (subtypeHashCode != null) {
                try {
                    lastSubtypeId = InputMethodUtils.getSubtypeIdFromHashCode(imi, Integer.valueOf(subtypeHashCode).intValue());
                } catch (NumberFormatException e) {
                    Slog.w(TAG, "HashCode for subtype looks broken: " + subtypeHashCode, e);
                }
            }
        }
        setSelectedInputMethodAndSubtypeLocked(imi, lastSubtypeId, DEBUG);
    }

    private Pair<InputMethodInfo, InputMethodSubtype> findLastResortApplicableShortcutInputMethodAndSubtypeLocked(String mode) {
        List<InputMethodInfo> imis = this.mSettings.getEnabledInputMethodListLocked();
        InputMethodInfo mostApplicableIMI = null;
        InputMethodSubtype mostApplicableSubtype = null;
        boolean foundInSystemIME = DEBUG;
        for (InputMethodInfo imi : imis) {
            String imiId = imi.getId();
            if (!foundInSystemIME || imiId.equals(this.mCurMethodId)) {
                ArrayList<InputMethodSubtype> subtypesForSearch;
                InputMethodSubtype subtype = null;
                List<InputMethodSubtype> enabledSubtypes = this.mSettings.getEnabledInputMethodSubtypeListLocked(this.mContext, imi, true);
                if (this.mCurrentSubtype != null) {
                    subtype = InputMethodUtils.findLastResortApplicableSubtypeLocked(this.mRes, enabledSubtypes, mode, this.mCurrentSubtype.getLocale(), DEBUG);
                }
                if (subtype == null) {
                    subtype = InputMethodUtils.findLastResortApplicableSubtypeLocked(this.mRes, enabledSubtypes, mode, null, true);
                }
                ArrayList<InputMethodSubtype> overridingImplicitlyEnabledSubtypes = InputMethodUtils.getOverridingImplicitlyEnabledSubtypes(imi, mode);
                if (overridingImplicitlyEnabledSubtypes.isEmpty()) {
                    subtypesForSearch = InputMethodUtils.getSubtypes(imi);
                } else {
                    subtypesForSearch = overridingImplicitlyEnabledSubtypes;
                }
                if (subtype == null && this.mCurrentSubtype != null) {
                    subtype = InputMethodUtils.findLastResortApplicableSubtypeLocked(this.mRes, subtypesForSearch, mode, this.mCurrentSubtype.getLocale(), DEBUG);
                }
                if (subtype == null) {
                    subtype = InputMethodUtils.findLastResortApplicableSubtypeLocked(this.mRes, subtypesForSearch, mode, null, true);
                }
                if (subtype == null) {
                    continue;
                } else if (imiId.equals(this.mCurMethodId)) {
                    mostApplicableIMI = imi;
                    mostApplicableSubtype = subtype;
                    break;
                } else if (!foundInSystemIME) {
                    mostApplicableIMI = imi;
                    mostApplicableSubtype = subtype;
                    if ((imi.getServiceInfo().applicationInfo.flags & MSG_SHOW_IM_PICKER) != 0) {
                        foundInSystemIME = true;
                    }
                }
            }
        }
        if (mostApplicableIMI != null) {
            return new Pair(mostApplicableIMI, mostApplicableSubtype);
        }
        return null;
    }

    public InputMethodSubtype getCurrentInputMethodSubtype() {
        if (!calledFromValidUser()) {
            return null;
        }
        InputMethodSubtype currentInputMethodSubtypeLocked;
        synchronized (this.mMethodMap) {
            currentInputMethodSubtypeLocked = getCurrentInputMethodSubtypeLocked();
        }
        return currentInputMethodSubtypeLocked;
    }

    private InputMethodSubtype getCurrentInputMethodSubtypeLocked() {
        if (this.mCurMethodId == null) {
            return null;
        }
        boolean subtypeIsSelected = this.mSettings.isSubtypeSelected();
        InputMethodInfo imi = (InputMethodInfo) this.mMethodMap.get(this.mCurMethodId);
        if (imi == null || imi.getSubtypeCount() == 0) {
            return null;
        }
        if (!(subtypeIsSelected && this.mCurrentSubtype != null && InputMethodUtils.isValidSubtypeId(imi, this.mCurrentSubtype.hashCode()))) {
            int subtypeId = this.mSettings.getSelectedInputMethodSubtypeId(this.mCurMethodId);
            if (subtypeId == NOT_A_SUBTYPE_ID) {
                List<InputMethodSubtype> explicitlyOrImplicitlyEnabledSubtypes = this.mSettings.getEnabledInputMethodSubtypeListLocked(this.mContext, imi, true);
                if (explicitlyOrImplicitlyEnabledSubtypes.size() == MSG_SHOW_IM_PICKER) {
                    this.mCurrentSubtype = (InputMethodSubtype) explicitlyOrImplicitlyEnabledSubtypes.get(0);
                } else if (explicitlyOrImplicitlyEnabledSubtypes.size() > MSG_SHOW_IM_PICKER) {
                    this.mCurrentSubtype = InputMethodUtils.findLastResortApplicableSubtypeLocked(this.mRes, explicitlyOrImplicitlyEnabledSubtypes, "keyboard", null, true);
                    if (this.mCurrentSubtype == null) {
                        this.mCurrentSubtype = InputMethodUtils.findLastResortApplicableSubtypeLocked(this.mRes, explicitlyOrImplicitlyEnabledSubtypes, null, null, true);
                    }
                }
            } else {
                this.mCurrentSubtype = (InputMethodSubtype) InputMethodUtils.getSubtypes(imi).get(subtypeId);
            }
        }
        return this.mCurrentSubtype;
    }

    private void addShortcutInputMethodAndSubtypes(InputMethodInfo imi, InputMethodSubtype subtype) {
        if (this.mShortcutInputMethodsAndSubtypes.containsKey(imi)) {
            ((ArrayList) this.mShortcutInputMethodsAndSubtypes.get(imi)).add(subtype);
            return;
        }
        ArrayList<InputMethodSubtype> subtypes = new ArrayList();
        subtypes.add(subtype);
        this.mShortcutInputMethodsAndSubtypes.put(imi, subtypes);
    }

    public List getShortcutInputMethodsAndSubtypes() {
        ArrayList<Object> ret;
        synchronized (this.mMethodMap) {
            ret = new ArrayList();
            if (this.mShortcutInputMethodsAndSubtypes.size() == 0) {
                Pair<InputMethodInfo, InputMethodSubtype> info = findLastResortApplicableShortcutInputMethodAndSubtypeLocked("voice");
                if (info != null) {
                    ret.add(info.first);
                    ret.add(info.second);
                }
            } else {
                for (InputMethodInfo imi : this.mShortcutInputMethodsAndSubtypes.keySet()) {
                    ret.add(imi);
                    Iterator i$ = ((ArrayList) this.mShortcutInputMethodsAndSubtypes.get(imi)).iterator();
                    while (i$.hasNext()) {
                        ret.add((InputMethodSubtype) i$.next());
                    }
                }
            }
        }
        return ret;
    }

    public boolean setCurrentInputMethodSubtype(InputMethodSubtype subtype) {
        boolean z = DEBUG;
        if (calledFromValidUser()) {
            synchronized (this.mMethodMap) {
                if (subtype != null) {
                    if (this.mCurMethodId != null) {
                        int subtypeId = InputMethodUtils.getSubtypeIdFromHashCode((InputMethodInfo) this.mMethodMap.get(this.mCurMethodId), subtype.hashCode());
                        if (subtypeId != NOT_A_SUBTYPE_ID) {
                            setInputMethodLocked(this.mCurMethodId, subtypeId);
                            z = true;
                        }
                    }
                }
            }
        }
        return z;
    }

    protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump InputMethodManager from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            return;
        }
        Printer p = new PrintWriterPrinter(pw);
        synchronized (this.mMethodMap) {
            p.println("Current Input Method Manager state:");
            int N = this.mMethodList.size();
            p.println("  Input Methods:");
            for (int i = 0; i < N; i += MSG_SHOW_IM_PICKER) {
                InputMethodInfo info = (InputMethodInfo) this.mMethodList.get(i);
                p.println("  InputMethod #" + i + ":");
                info.dump(p, "    ");
            }
            p.println("  Clients:");
            for (ClientState ci : this.mClients.values()) {
                p.println("  Client " + ci + ":");
                p.println("    client=" + ci.client);
                p.println("    inputContext=" + ci.inputContext);
                p.println("    sessionRequested=" + ci.sessionRequested);
                p.println("    curSession=" + ci.curSession);
            }
            p.println("  mCurMethodId=" + this.mCurMethodId);
            ClientState client = this.mCurClient;
            p.println("  mCurClient=" + client + " mCurSeq=" + this.mCurSeq);
            p.println("  mCurFocusedWindow=" + this.mCurFocusedWindow);
            p.println("  mCurId=" + this.mCurId + " mHaveConnect=" + this.mHaveConnection + " mBoundToMethod=" + this.mBoundToMethod);
            p.println("  mCurToken=" + this.mCurToken);
            p.println("  mCurIntent=" + this.mCurIntent);
            IInputMethod method = this.mCurMethod;
            p.println("  mCurMethod=" + this.mCurMethod);
            p.println("  mEnabledSession=" + this.mEnabledSession);
            p.println("  mShowRequested=" + this.mShowRequested + " mShowExplicitlyRequested=" + this.mShowExplicitlyRequested + " mShowForced=" + this.mShowForced + " mInputShown=" + this.mInputShown);
            p.println("  mCurUserActionNotificationSequenceNumber=" + this.mCurUserActionNotificationSequenceNumber);
            p.println("  mSystemReady=" + this.mSystemReady + " mInteractive=" + this.mScreenOn);
        }
        p.println(" ");
        if (client != null) {
            pw.flush();
            try {
                client.client.asBinder().dump(fd, args);
            } catch (RemoteException e) {
                p.println("Input method client dead: " + e);
            }
        } else {
            p.println("No input method client.");
        }
        p.println(" ");
        if (method != null) {
            pw.flush();
            try {
                method.asBinder().dump(fd, args);
                return;
            } catch (RemoteException e2) {
                p.println("Input method service dead: " + e2);
                return;
            }
        }
        p.println("No input method service.");
    }
}
