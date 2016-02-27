package com.android.server.pm;

import android.app.ActivityManager;
import android.app.AppOpsManager;
import android.app.PackageDeleteObserver;
import android.app.PackageInstallObserver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentSender;
import android.content.IntentSender.SendIntentException;
import android.content.pm.IPackageInstaller.Stub;
import android.content.pm.IPackageInstallerCallback;
import android.content.pm.IPackageInstallerSession;
import android.content.pm.PackageInstaller.SessionInfo;
import android.content.pm.PackageInstaller.SessionParams;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.Environment;
import android.os.FileUtils;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.os.SELinux;
import android.os.UserHandle;
import android.system.ErrnoException;
import android.system.Os;
import android.text.TextUtils;
import android.util.ArraySet;
import android.util.AtomicFile;
import android.util.ExceptionUtils;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseBooleanArray;
import android.util.Xml;
import com.android.internal.annotations.GuardedBy;
import com.android.internal.content.PackageHelper;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.util.IndentingPrintWriter;
import com.android.internal.util.XmlUtils;
import com.android.server.IoThread;
import com.google.android.collect.Sets;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Iterator;
import java.util.Random;
import libcore.io.IoUtils;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class PackageInstallerService extends Stub {
    private static final String ATTR_ABI_OVERRIDE = "abiOverride";
    @Deprecated
    private static final String ATTR_APP_ICON = "appIcon";
    private static final String ATTR_APP_LABEL = "appLabel";
    private static final String ATTR_APP_PACKAGE_NAME = "appPackageName";
    private static final String ATTR_CREATED_MILLIS = "createdMillis";
    private static final String ATTR_INSTALLER_PACKAGE_NAME = "installerPackageName";
    private static final String ATTR_INSTALLER_UID = "installerUid";
    private static final String ATTR_INSTALL_FLAGS = "installFlags";
    private static final String ATTR_INSTALL_LOCATION = "installLocation";
    private static final String ATTR_MODE = "mode";
    private static final String ATTR_ORIGINATING_URI = "originatingUri";
    private static final String ATTR_PREPARED = "prepared";
    private static final String ATTR_REFERRER_URI = "referrerUri";
    private static final String ATTR_SEALED = "sealed";
    private static final String ATTR_SESSION_ID = "sessionId";
    private static final String ATTR_SESSION_STAGE_CID = "sessionStageCid";
    private static final String ATTR_SESSION_STAGE_DIR = "sessionStageDir";
    private static final String ATTR_SIZE_BYTES = "sizeBytes";
    private static final String ATTR_USER_ID = "userId";
    private static final boolean LOGD = false;
    private static final long MAX_ACTIVE_SESSIONS = 1024;
    private static final long MAX_AGE_MILLIS = 259200000;
    private static final long MAX_HISTORICAL_SESSIONS = 1048576;
    private static final String TAG = "PackageInstaller";
    private static final String TAG_SESSION = "session";
    private static final String TAG_SESSIONS = "sessions";
    private static final FilenameFilter sStageFilter;
    private final AppOpsManager mAppOps;
    private final Callbacks mCallbacks;
    private final Context mContext;
    @GuardedBy("mSessions")
    private final SparseArray<PackageInstallerSession> mHistoricalSessions;
    private final Handler mInstallHandler;
    private final HandlerThread mInstallThread;
    private final InternalCallback mInternalCallback;
    @GuardedBy("mSessions")
    private final SparseBooleanArray mLegacySessions;
    private final PackageManagerService mPm;
    private final Random mRandom;
    @GuardedBy("mSessions")
    private final SparseArray<PackageInstallerSession> mSessions;
    private final File mSessionsDir;
    private final AtomicFile mSessionsFile;
    private final File mStagingDir;

    /* renamed from: com.android.server.pm.PackageInstallerService.1 */
    static class C04421 implements FilenameFilter {
        C04421() {
        }

        public boolean accept(File dir, String name) {
            return PackageInstallerService.isStageName(name);
        }
    }

    /* renamed from: com.android.server.pm.PackageInstallerService.2 */
    class C04432 implements Runnable {
        C04432() {
        }

        public void run() {
            synchronized (PackageInstallerService.this.mSessions) {
                PackageInstallerService.this.writeSessionsLocked();
            }
        }
    }

    private static class Callbacks extends Handler {
        private static final int MSG_SESSION_ACTIVE_CHANGED = 3;
        private static final int MSG_SESSION_BADGING_CHANGED = 2;
        private static final int MSG_SESSION_CREATED = 1;
        private static final int MSG_SESSION_FINISHED = 5;
        private static final int MSG_SESSION_PROGRESS_CHANGED = 4;
        private final RemoteCallbackList<IPackageInstallerCallback> mCallbacks;

        public Callbacks(Looper looper) {
            super(looper);
            this.mCallbacks = new RemoteCallbackList();
        }

        public void register(IPackageInstallerCallback callback, int userId) {
            this.mCallbacks.register(callback, new UserHandle(userId));
        }

        public void unregister(IPackageInstallerCallback callback) {
            this.mCallbacks.unregister(callback);
        }

        public void handleMessage(Message msg) {
            int userId = msg.arg2;
            int n = this.mCallbacks.beginBroadcast();
            for (int i = 0; i < n; i += MSG_SESSION_CREATED) {
                IPackageInstallerCallback callback = (IPackageInstallerCallback) this.mCallbacks.getBroadcastItem(i);
                if (userId == ((UserHandle) this.mCallbacks.getBroadcastCookie(i)).getIdentifier()) {
                    try {
                        invokeCallback(callback, msg);
                    } catch (RemoteException e) {
                    }
                }
            }
            this.mCallbacks.finishBroadcast();
        }

        private void invokeCallback(IPackageInstallerCallback callback, Message msg) throws RemoteException {
            int sessionId = msg.arg1;
            switch (msg.what) {
                case MSG_SESSION_CREATED /*1*/:
                    callback.onSessionCreated(sessionId);
                case MSG_SESSION_BADGING_CHANGED /*2*/:
                    callback.onSessionBadgingChanged(sessionId);
                case MSG_SESSION_ACTIVE_CHANGED /*3*/:
                    callback.onSessionActiveChanged(sessionId, ((Boolean) msg.obj).booleanValue());
                case MSG_SESSION_PROGRESS_CHANGED /*4*/:
                    callback.onSessionProgressChanged(sessionId, ((Float) msg.obj).floatValue());
                case MSG_SESSION_FINISHED /*5*/:
                    callback.onSessionFinished(sessionId, ((Boolean) msg.obj).booleanValue());
                default:
            }
        }

        private void notifySessionCreated(int sessionId, int userId) {
            obtainMessage(MSG_SESSION_CREATED, sessionId, userId).sendToTarget();
        }

        private void notifySessionBadgingChanged(int sessionId, int userId) {
            obtainMessage(MSG_SESSION_BADGING_CHANGED, sessionId, userId).sendToTarget();
        }

        private void notifySessionActiveChanged(int sessionId, int userId, boolean active) {
            obtainMessage(MSG_SESSION_ACTIVE_CHANGED, sessionId, userId, Boolean.valueOf(active)).sendToTarget();
        }

        private void notifySessionProgressChanged(int sessionId, int userId, float progress) {
            obtainMessage(MSG_SESSION_PROGRESS_CHANGED, sessionId, userId, Float.valueOf(progress)).sendToTarget();
        }

        public void notifySessionFinished(int sessionId, int userId, boolean success) {
            obtainMessage(MSG_SESSION_FINISHED, sessionId, userId, Boolean.valueOf(success)).sendToTarget();
        }
    }

    class InternalCallback {

        /* renamed from: com.android.server.pm.PackageInstallerService.InternalCallback.1 */
        class C04441 implements Runnable {
            final /* synthetic */ PackageInstallerSession val$session;

            C04441(PackageInstallerSession packageInstallerSession) {
                this.val$session = packageInstallerSession;
            }

            public void run() {
                synchronized (PackageInstallerService.this.mSessions) {
                    PackageInstallerService.this.mSessions.remove(this.val$session.sessionId);
                    PackageInstallerService.this.mHistoricalSessions.put(this.val$session.sessionId, this.val$session);
                    File appIconFile = PackageInstallerService.this.buildAppIconFile(this.val$session.sessionId);
                    if (appIconFile.exists()) {
                        appIconFile.delete();
                    }
                    PackageInstallerService.this.writeSessionsLocked();
                }
            }
        }

        InternalCallback() {
        }

        public void onSessionBadgingChanged(PackageInstallerSession session) {
            PackageInstallerService.this.mCallbacks.notifySessionBadgingChanged(session.sessionId, session.userId);
            PackageInstallerService.this.writeSessionsAsync();
        }

        public void onSessionActiveChanged(PackageInstallerSession session, boolean active) {
            PackageInstallerService.this.mCallbacks.notifySessionActiveChanged(session.sessionId, session.userId, active);
        }

        public void onSessionProgressChanged(PackageInstallerSession session, float progress) {
            PackageInstallerService.this.mCallbacks.notifySessionProgressChanged(session.sessionId, session.userId, progress);
        }

        public void onSessionFinished(PackageInstallerSession session, boolean success) {
            PackageInstallerService.this.mCallbacks.notifySessionFinished(session.sessionId, session.userId, success);
            PackageInstallerService.this.mInstallHandler.post(new C04441(session));
        }

        public void onSessionPrepared(PackageInstallerSession session) {
            PackageInstallerService.this.writeSessionsAsync();
        }

        public void onSessionSealedBlocking(PackageInstallerSession session) {
            synchronized (PackageInstallerService.this.mSessions) {
                PackageInstallerService.this.writeSessionsLocked();
            }
        }
    }

    static class PackageDeleteObserverAdapter extends PackageDeleteObserver {
        private final Context mContext;
        private final String mPackageName;
        private final IntentSender mTarget;

        public PackageDeleteObserverAdapter(Context context, IntentSender target, String packageName) {
            this.mContext = context;
            this.mTarget = target;
            this.mPackageName = packageName;
        }

        public void onUserActionRequired(Intent intent) {
            Intent fillIn = new Intent();
            fillIn.putExtra("android.content.pm.extra.PACKAGE_NAME", this.mPackageName);
            fillIn.putExtra("android.content.pm.extra.STATUS", -1);
            fillIn.putExtra("android.intent.extra.INTENT", intent);
            try {
                this.mTarget.sendIntent(this.mContext, 0, fillIn, null, null);
            } catch (SendIntentException e) {
            }
        }

        public void onPackageDeleted(String basePackageName, int returnCode, String msg) {
            Intent fillIn = new Intent();
            fillIn.putExtra("android.content.pm.extra.PACKAGE_NAME", this.mPackageName);
            fillIn.putExtra("android.content.pm.extra.STATUS", PackageManager.deleteStatusToPublicStatus(returnCode));
            fillIn.putExtra("android.content.pm.extra.STATUS_MESSAGE", PackageManager.deleteStatusToString(returnCode, msg));
            fillIn.putExtra("android.content.pm.extra.LEGACY_STATUS", returnCode);
            try {
                this.mTarget.sendIntent(this.mContext, 0, fillIn, null, null);
            } catch (SendIntentException e) {
            }
        }
    }

    static class PackageInstallObserverAdapter extends PackageInstallObserver {
        private final Context mContext;
        private final int mSessionId;
        private final IntentSender mTarget;

        public PackageInstallObserverAdapter(Context context, IntentSender target, int sessionId) {
            this.mContext = context;
            this.mTarget = target;
            this.mSessionId = sessionId;
        }

        public void onUserActionRequired(Intent intent) {
            Intent fillIn = new Intent();
            fillIn.putExtra("android.content.pm.extra.SESSION_ID", this.mSessionId);
            fillIn.putExtra("android.content.pm.extra.STATUS", -1);
            fillIn.putExtra("android.intent.extra.INTENT", intent);
            try {
                this.mTarget.sendIntent(this.mContext, 0, fillIn, null, null);
            } catch (SendIntentException e) {
            }
        }

        public void onPackageInstalled(String basePackageName, int returnCode, String msg, Bundle extras) {
            Intent fillIn = new Intent();
            fillIn.putExtra("android.content.pm.extra.SESSION_ID", this.mSessionId);
            fillIn.putExtra("android.content.pm.extra.STATUS", PackageManager.installStatusToPublicStatus(returnCode));
            fillIn.putExtra("android.content.pm.extra.STATUS_MESSAGE", PackageManager.installStatusToString(returnCode, msg));
            fillIn.putExtra("android.content.pm.extra.LEGACY_STATUS", returnCode);
            if (extras != null) {
                String existing = extras.getString("android.content.pm.extra.FAILURE_EXISTING_PACKAGE");
                if (!TextUtils.isEmpty(existing)) {
                    fillIn.putExtra("android.content.pm.extra.OTHER_PACKAGE_NAME", existing);
                }
            }
            try {
                this.mTarget.sendIntent(this.mContext, 0, fillIn, null, null);
            } catch (SendIntentException e) {
            }
        }
    }

    static {
        sStageFilter = new C04421();
    }

    public PackageInstallerService(Context context, PackageManagerService pm, File stagingDir) {
        this.mInternalCallback = new InternalCallback();
        this.mRandom = new SecureRandom();
        this.mSessions = new SparseArray();
        this.mHistoricalSessions = new SparseArray();
        this.mLegacySessions = new SparseBooleanArray();
        this.mContext = context;
        this.mPm = pm;
        this.mAppOps = (AppOpsManager) this.mContext.getSystemService("appops");
        this.mStagingDir = stagingDir;
        this.mInstallThread = new HandlerThread(TAG);
        this.mInstallThread.start();
        this.mInstallHandler = new Handler(this.mInstallThread.getLooper());
        this.mCallbacks = new Callbacks(this.mInstallThread.getLooper());
        this.mSessionsFile = new AtomicFile(new File(Environment.getSystemSecureDirectory(), "install_sessions.xml"));
        this.mSessionsDir = new File(Environment.getSystemSecureDirectory(), "install_sessions");
        this.mSessionsDir.mkdirs();
        synchronized (this.mSessions) {
            readSessionsLocked();
            ArraySet<File> unclaimedStages = Sets.newArraySet(this.mStagingDir.listFiles(sStageFilter));
            ArraySet<File> unclaimedIcons = Sets.newArraySet(this.mSessionsDir.listFiles());
            for (int i = 0; i < this.mSessions.size(); i++) {
                PackageInstallerSession session = (PackageInstallerSession) this.mSessions.valueAt(i);
                unclaimedStages.remove(session.stageDir);
                unclaimedIcons.remove(buildAppIconFile(session.sessionId));
            }
            Iterator i$ = unclaimedStages.iterator();
            while (i$.hasNext()) {
                File stage = (File) i$.next();
                Slog.w(TAG, "Deleting orphan stage " + stage);
                if (stage.isDirectory()) {
                    FileUtils.deleteContents(stage);
                }
                stage.delete();
            }
            i$ = unclaimedIcons.iterator();
            while (i$.hasNext()) {
                File icon = (File) i$.next();
                Slog.w(TAG, "Deleting orphan icon " + icon);
                icon.delete();
            }
        }
    }

    public void onSecureContainersAvailable() {
        synchronized (this.mSessions) {
            String cid;
            ArraySet<String> unclaimed = new ArraySet();
            for (String cid2 : PackageHelper.getSecureContainerList()) {
                if (isStageName(cid2)) {
                    unclaimed.add(cid2);
                }
            }
            for (int i = 0; i < this.mSessions.size(); i++) {
                cid2 = ((PackageInstallerSession) this.mSessions.valueAt(i)).stageCid;
                if (unclaimed.remove(cid2)) {
                    PackageHelper.mountSdDir(cid2, PackageManagerService.getEncryptKey(), ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
                }
            }
            Iterator i$ = unclaimed.iterator();
            while (i$.hasNext()) {
                cid2 = (String) i$.next();
                Slog.w(TAG, "Deleting orphan container " + cid2);
                PackageHelper.destroySdDir(cid2);
            }
        }
    }

    public static boolean isStageName(String name) {
        boolean isFile;
        if (name.startsWith("vmdl") && name.endsWith(".tmp")) {
            isFile = true;
        } else {
            isFile = LOGD;
        }
        boolean isContainer;
        if (name.startsWith("smdl") && name.endsWith(".tmp")) {
            isContainer = true;
        } else {
            isContainer = LOGD;
        }
        boolean isLegacyContainer = name.startsWith("smdl2tmp");
        if (isFile || isContainer || isLegacyContainer) {
            return true;
        }
        return LOGD;
    }

    @Deprecated
    public File allocateInternalStageDirLegacy() throws IOException {
        File stageDir;
        synchronized (this.mSessions) {
            try {
                int sessionId = allocateSessionIdLocked();
                this.mLegacySessions.put(sessionId, true);
                stageDir = buildInternalStageDir(sessionId);
                prepareInternalStageDir(stageDir);
            } catch (IllegalStateException e) {
                throw new IOException(e);
            }
        }
        return stageDir;
    }

    @Deprecated
    public String allocateExternalStageCidLegacy() {
        String str;
        synchronized (this.mSessions) {
            int sessionId = allocateSessionIdLocked();
            this.mLegacySessions.put(sessionId, true);
            str = "smdl" + sessionId + ".tmp";
        }
        return str;
    }

    private void readSessionsLocked() {
        this.mSessions.clear();
        FileInputStream fis = null;
        try {
            fis = this.mSessionsFile.openRead();
            XmlPullParser in = Xml.newPullParser();
            in.setInput(fis, StandardCharsets.UTF_8.name());
            while (true) {
                int type = in.next();
                if (type == 1) {
                    break;
                } else if (type == 2) {
                    if (TAG_SESSION.equals(in.getName())) {
                        boolean valid;
                        PackageInstallerSession session = readSessionLocked(in);
                        if (System.currentTimeMillis() - session.createdMillis >= MAX_AGE_MILLIS) {
                            Slog.w(TAG, "Abandoning old session first created at " + session.createdMillis);
                            valid = LOGD;
                        } else if (session.stageDir == null || session.stageDir.exists()) {
                            valid = true;
                        } else {
                            Slog.w(TAG, "Abandoning internal session with missing stage " + session.stageDir);
                            valid = LOGD;
                        }
                        if (valid) {
                            this.mSessions.put(session.sessionId, session);
                        } else {
                            this.mHistoricalSessions.put(session.sessionId, session);
                        }
                    } else {
                        continue;
                    }
                }
            }
        } catch (FileNotFoundException e) {
        } catch (IOException e2) {
            Slog.wtf(TAG, "Failed reading install sessions", e2);
        } catch (XmlPullParserException e3) {
            Slog.wtf(TAG, "Failed reading install sessions", e3);
        } finally {
            IoUtils.closeQuietly(fis);
        }
    }

    private PackageInstallerSession readSessionLocked(XmlPullParser in) throws IOException {
        int sessionId = XmlUtils.readIntAttribute(in, ATTR_SESSION_ID);
        int userId = XmlUtils.readIntAttribute(in, ATTR_USER_ID);
        String installerPackageName = XmlUtils.readStringAttribute(in, ATTR_INSTALLER_PACKAGE_NAME);
        int installerUid = XmlUtils.readIntAttribute(in, ATTR_INSTALLER_UID, this.mPm.getPackageUid(installerPackageName, userId));
        long createdMillis = XmlUtils.readLongAttribute(in, ATTR_CREATED_MILLIS);
        String stageDirRaw = XmlUtils.readStringAttribute(in, ATTR_SESSION_STAGE_DIR);
        File stageDir = stageDirRaw != null ? new File(stageDirRaw) : null;
        String stageCid = XmlUtils.readStringAttribute(in, ATTR_SESSION_STAGE_CID);
        boolean prepared = XmlUtils.readBooleanAttribute(in, ATTR_PREPARED, true);
        boolean sealed = XmlUtils.readBooleanAttribute(in, ATTR_SEALED);
        SessionParams params = new SessionParams(-1);
        params.mode = XmlUtils.readIntAttribute(in, ATTR_MODE);
        params.installFlags = XmlUtils.readIntAttribute(in, ATTR_INSTALL_FLAGS);
        params.installLocation = XmlUtils.readIntAttribute(in, ATTR_INSTALL_LOCATION);
        params.sizeBytes = XmlUtils.readLongAttribute(in, ATTR_SIZE_BYTES);
        params.appPackageName = XmlUtils.readStringAttribute(in, ATTR_APP_PACKAGE_NAME);
        params.appIcon = XmlUtils.readBitmapAttribute(in, ATTR_APP_ICON);
        params.appLabel = XmlUtils.readStringAttribute(in, ATTR_APP_LABEL);
        params.originatingUri = XmlUtils.readUriAttribute(in, ATTR_ORIGINATING_URI);
        params.referrerUri = XmlUtils.readUriAttribute(in, ATTR_REFERRER_URI);
        params.abiOverride = XmlUtils.readStringAttribute(in, ATTR_ABI_OVERRIDE);
        File appIconFile = buildAppIconFile(sessionId);
        if (appIconFile.exists()) {
            params.appIcon = BitmapFactory.decodeFile(appIconFile.getAbsolutePath());
            params.appIconLastModified = appIconFile.lastModified();
        }
        return new PackageInstallerSession(this.mInternalCallback, this.mContext, this.mPm, this.mInstallThread.getLooper(), sessionId, userId, installerPackageName, installerUid, params, createdMillis, stageDir, stageCid, prepared, sealed);
    }

    private void writeSessionsLocked() {
        try {
            FileOutputStream fos = this.mSessionsFile.startWrite();
            XmlSerializer out = new FastXmlSerializer();
            out.setOutput(fos, StandardCharsets.UTF_8.name());
            out.startDocument(null, Boolean.valueOf(true));
            out.startTag(null, TAG_SESSIONS);
            int size = this.mSessions.size();
            for (int i = 0; i < size; i++) {
                writeSessionLocked(out, (PackageInstallerSession) this.mSessions.valueAt(i));
            }
            out.endTag(null, TAG_SESSIONS);
            out.endDocument();
            this.mSessionsFile.finishWrite(fos);
        } catch (IOException e) {
            if (null != null) {
                this.mSessionsFile.failWrite(null);
            }
        }
    }

    private void writeSessionLocked(XmlSerializer out, PackageInstallerSession session) throws IOException {
        IOException e;
        Throwable th;
        SessionParams params = session.params;
        out.startTag(null, TAG_SESSION);
        XmlUtils.writeIntAttribute(out, ATTR_SESSION_ID, session.sessionId);
        XmlUtils.writeIntAttribute(out, ATTR_USER_ID, session.userId);
        XmlUtils.writeStringAttribute(out, ATTR_INSTALLER_PACKAGE_NAME, session.installerPackageName);
        XmlUtils.writeIntAttribute(out, ATTR_INSTALLER_UID, session.installerUid);
        XmlUtils.writeLongAttribute(out, ATTR_CREATED_MILLIS, session.createdMillis);
        if (session.stageDir != null) {
            XmlUtils.writeStringAttribute(out, ATTR_SESSION_STAGE_DIR, session.stageDir.getAbsolutePath());
        }
        if (session.stageCid != null) {
            XmlUtils.writeStringAttribute(out, ATTR_SESSION_STAGE_CID, session.stageCid);
        }
        XmlUtils.writeBooleanAttribute(out, ATTR_PREPARED, session.isPrepared());
        XmlUtils.writeBooleanAttribute(out, ATTR_SEALED, session.isSealed());
        XmlUtils.writeIntAttribute(out, ATTR_MODE, params.mode);
        XmlUtils.writeIntAttribute(out, ATTR_INSTALL_FLAGS, params.installFlags);
        XmlUtils.writeIntAttribute(out, ATTR_INSTALL_LOCATION, params.installLocation);
        XmlUtils.writeLongAttribute(out, ATTR_SIZE_BYTES, params.sizeBytes);
        XmlUtils.writeStringAttribute(out, ATTR_APP_PACKAGE_NAME, params.appPackageName);
        XmlUtils.writeStringAttribute(out, ATTR_APP_LABEL, params.appLabel);
        XmlUtils.writeUriAttribute(out, ATTR_ORIGINATING_URI, params.originatingUri);
        XmlUtils.writeUriAttribute(out, ATTR_REFERRER_URI, params.referrerUri);
        XmlUtils.writeStringAttribute(out, ATTR_ABI_OVERRIDE, params.abiOverride);
        File appIconFile = buildAppIconFile(session.sessionId);
        if (params.appIcon == null && appIconFile.exists()) {
            appIconFile.delete();
        } else if (!(params.appIcon == null || appIconFile.lastModified() == params.appIconLastModified)) {
            FileOutputStream os = null;
            try {
                FileOutputStream os2 = new FileOutputStream(appIconFile);
                try {
                    params.appIcon.compress(CompressFormat.PNG, 90, os2);
                    IoUtils.closeQuietly(os2);
                    os = os2;
                } catch (IOException e2) {
                    e = e2;
                    os = os2;
                    try {
                        Slog.w(TAG, "Failed to write icon " + appIconFile + ": " + e.getMessage());
                        IoUtils.closeQuietly(os);
                        params.appIconLastModified = appIconFile.lastModified();
                        out.endTag(null, TAG_SESSION);
                    } catch (Throwable th2) {
                        th = th2;
                        IoUtils.closeQuietly(os);
                        throw th;
                    }
                } catch (Throwable th3) {
                    th = th3;
                    os = os2;
                    IoUtils.closeQuietly(os);
                    throw th;
                }
            } catch (IOException e3) {
                e = e3;
                Slog.w(TAG, "Failed to write icon " + appIconFile + ": " + e.getMessage());
                IoUtils.closeQuietly(os);
                params.appIconLastModified = appIconFile.lastModified();
                out.endTag(null, TAG_SESSION);
            }
            params.appIconLastModified = appIconFile.lastModified();
        }
        out.endTag(null, TAG_SESSION);
    }

    private File buildAppIconFile(int sessionId) {
        return new File(this.mSessionsDir, "app_icon." + sessionId + ".png");
    }

    private void writeSessionsAsync() {
        IoThread.getHandler().post(new C04432());
    }

    public int createSession(SessionParams params, String installerPackageName, int userId) {
        try {
            return createSessionInternal(params, installerPackageName, userId);
        } catch (IOException e) {
            throw ExceptionUtils.wrap(e);
        }
    }

    private int createSessionInternal(SessionParams params, String installerPackageName, int userId) throws IOException {
        int callingUid = Binder.getCallingUid();
        this.mPm.enforceCrossUserPermission(callingUid, userId, true, true, "createSession");
        if (this.mPm.isUserRestricted(userId, "no_install_apps")) {
            throw new SecurityException("User restriction prevents installing");
        }
        if (callingUid == 2000 || callingUid == 0) {
            params.installFlags |= 32;
        } else {
            this.mAppOps.checkPackage(callingUid, installerPackageName);
            params.installFlags &= -33;
            params.installFlags &= -65;
            params.installFlags |= 2;
        }
        if (params.appIcon != null) {
            int iconSize = ((ActivityManager) this.mContext.getSystemService("activity")).getLauncherLargeIconSize();
            if (params.appIcon.getWidth() > iconSize * 2 || params.appIcon.getHeight() > iconSize * 2) {
                params.appIcon = Bitmap.createScaledBitmap(params.appIcon, iconSize, iconSize, true);
            }
        }
        if (params.mode == 1 || params.mode == 2) {
            long ident = Binder.clearCallingIdentity();
            try {
                int sessionId;
                PackageInstallerSession session;
                int resolved = PackageHelper.resolveInstallLocation(this.mContext, params.appPackageName, params.installLocation, params.sizeBytes, params.installFlags);
                if (resolved == 1) {
                    params.setInstallFlagsInternal();
                } else if (resolved == 2) {
                    params.setInstallFlagsExternal();
                } else {
                    throw new IOException("No storage with enough free space; res=" + resolved);
                }
                Binder.restoreCallingIdentity(ident);
                synchronized (this.mSessions) {
                    if (((long) getSessionCount(this.mSessions, callingUid)) >= MAX_ACTIVE_SESSIONS) {
                        throw new IllegalStateException("Too many active sessions for UID " + callingUid);
                    }
                    if (((long) getSessionCount(this.mHistoricalSessions, callingUid)) >= MAX_HISTORICAL_SESSIONS) {
                        throw new IllegalStateException("Too many historical sessions for UID " + callingUid);
                    }
                    long createdMillis = System.currentTimeMillis();
                    sessionId = allocateSessionIdLocked();
                    File stageDir = null;
                    String stageCid = null;
                    if ((params.installFlags & 16) != 0) {
                        stageDir = buildInternalStageDir(sessionId);
                    } else {
                        stageCid = buildExternalStageCid(sessionId);
                    }
                    session = new PackageInstallerSession(this.mInternalCallback, this.mContext, this.mPm, this.mInstallThread.getLooper(), sessionId, userId, installerPackageName, callingUid, params, createdMillis, stageDir, stageCid, LOGD, LOGD);
                    this.mSessions.put(sessionId, session);
                }
                this.mCallbacks.notifySessionCreated(session.sessionId, session.userId);
                writeSessionsAsync();
                return sessionId;
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        } else {
            throw new IllegalArgumentException("Invalid install mode: " + params.mode);
        }
    }

    public void updateSessionAppIcon(int sessionId, Bitmap appIcon) {
        synchronized (this.mSessions) {
            PackageInstallerSession session = (PackageInstallerSession) this.mSessions.get(sessionId);
            if (session == null || !isCallingUidOwner(session)) {
                throw new SecurityException("Caller has no access to session " + sessionId);
            }
            if (appIcon != null) {
                int iconSize = ((ActivityManager) this.mContext.getSystemService("activity")).getLauncherLargeIconSize();
                if (appIcon.getWidth() > iconSize * 2 || appIcon.getHeight() > iconSize * 2) {
                    appIcon = Bitmap.createScaledBitmap(appIcon, iconSize, iconSize, true);
                }
            }
            session.params.appIcon = appIcon;
            session.params.appIconLastModified = -1;
            this.mInternalCallback.onSessionBadgingChanged(session);
        }
    }

    public void updateSessionAppLabel(int sessionId, String appLabel) {
        synchronized (this.mSessions) {
            PackageInstallerSession session = (PackageInstallerSession) this.mSessions.get(sessionId);
            if (session == null || !isCallingUidOwner(session)) {
                throw new SecurityException("Caller has no access to session " + sessionId);
            }
            session.params.appLabel = appLabel;
            this.mInternalCallback.onSessionBadgingChanged(session);
        }
    }

    public void abandonSession(int sessionId) {
        synchronized (this.mSessions) {
            PackageInstallerSession session = (PackageInstallerSession) this.mSessions.get(sessionId);
            if (session == null || !isCallingUidOwner(session)) {
                throw new SecurityException("Caller has no access to session " + sessionId);
            }
            session.abandon();
        }
    }

    public IPackageInstallerSession openSession(int sessionId) {
        try {
            return openSessionInternal(sessionId);
        } catch (IOException e) {
            throw ExceptionUtils.wrap(e);
        }
    }

    private IPackageInstallerSession openSessionInternal(int sessionId) throws IOException {
        PackageInstallerSession session;
        synchronized (this.mSessions) {
            session = (PackageInstallerSession) this.mSessions.get(sessionId);
            if (session == null || !isCallingUidOwner(session)) {
                throw new SecurityException("Caller has no access to session " + sessionId);
            }
            session.open();
        }
        return session;
    }

    private int allocateSessionIdLocked() {
        int n = 0;
        while (true) {
            int sessionId = this.mRandom.nextInt(2147483646) + 1;
            if (this.mSessions.get(sessionId) == null && this.mHistoricalSessions.get(sessionId) == null && !this.mLegacySessions.get(sessionId, LOGD)) {
                return sessionId;
            }
            int n2 = n + 1;
            if (n >= 32) {
                break;
            }
            n = n2;
        }
        throw new IllegalStateException("Failed to allocate session ID");
    }

    private File buildInternalStageDir(int sessionId) {
        return new File(this.mStagingDir, "vmdl" + sessionId + ".tmp");
    }

    static void prepareInternalStageDir(File stageDir) throws IOException {
        if (stageDir.exists()) {
            throw new IOException("Session dir already exists: " + stageDir);
        }
        try {
            Os.mkdir(stageDir.getAbsolutePath(), 493);
            Os.chmod(stageDir.getAbsolutePath(), 493);
            if (!SELinux.restorecon(stageDir)) {
                throw new IOException("Failed to restorecon session dir: " + stageDir);
            }
        } catch (ErrnoException e) {
            throw new IOException("Failed to prepare session dir: " + stageDir, e);
        }
    }

    private String buildExternalStageCid(int sessionId) {
        return "smdl" + sessionId + ".tmp";
    }

    static void prepareExternalStageCid(String stageCid, long sizeBytes) throws IOException {
        if (PackageHelper.createSdDir(sizeBytes, stageCid, PackageManagerService.getEncryptKey(), ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, true) == null) {
            throw new IOException("Failed to create session cid: " + stageCid);
        }
    }

    public SessionInfo getSessionInfo(int sessionId) {
        SessionInfo generateInfo;
        synchronized (this.mSessions) {
            PackageInstallerSession session = (PackageInstallerSession) this.mSessions.get(sessionId);
            generateInfo = session != null ? session.generateInfo() : null;
        }
        return generateInfo;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public android.content.pm.ParceledListSlice<android.content.pm.PackageInstaller.SessionInfo> getAllSessions(int r10) {
        /*
        r9 = this;
        r0 = r9.mPm;
        r1 = android.os.Binder.getCallingUid();
        r3 = 1;
        r4 = 0;
        r5 = "getAllSessions";
        r2 = r10;
        r0.enforceCrossUserPermission(r1, r2, r3, r4, r5);
        r7 = new java.util.ArrayList;
        r7.<init>();
        r1 = r9.mSessions;
        monitor-enter(r1);
        r6 = 0;
    L_0x0017:
        r0 = r9.mSessions;	 Catch:{ all -> 0x003c }
        r0 = r0.size();	 Catch:{ all -> 0x003c }
        if (r6 >= r0) goto L_0x0035;
    L_0x001f:
        r0 = r9.mSessions;	 Catch:{ all -> 0x003c }
        r8 = r0.valueAt(r6);	 Catch:{ all -> 0x003c }
        r8 = (com.android.server.pm.PackageInstallerSession) r8;	 Catch:{ all -> 0x003c }
        r0 = r8.userId;	 Catch:{ all -> 0x003c }
        if (r0 != r10) goto L_0x0032;
    L_0x002b:
        r0 = r8.generateInfo();	 Catch:{ all -> 0x003c }
        r7.add(r0);	 Catch:{ all -> 0x003c }
    L_0x0032:
        r6 = r6 + 1;
        goto L_0x0017;
    L_0x0035:
        monitor-exit(r1);	 Catch:{ all -> 0x003c }
        r0 = new android.content.pm.ParceledListSlice;
        r0.<init>(r7);
        return r0;
    L_0x003c:
        r0 = move-exception;
        monitor-exit(r1);	 Catch:{ all -> 0x003c }
        throw r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageInstallerService.getAllSessions(int):android.content.pm.ParceledListSlice<android.content.pm.PackageInstaller$SessionInfo>");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public android.content.pm.ParceledListSlice<android.content.pm.PackageInstaller.SessionInfo> getMySessions(java.lang.String r10, int r11) {
        /*
        r9 = this;
        r0 = r9.mPm;
        r1 = android.os.Binder.getCallingUid();
        r3 = 1;
        r4 = 0;
        r5 = "getMySessions";
        r2 = r11;
        r0.enforceCrossUserPermission(r1, r2, r3, r4, r5);
        r0 = r9.mAppOps;
        r1 = android.os.Binder.getCallingUid();
        r0.checkPackage(r1, r10);
        r7 = new java.util.ArrayList;
        r7.<init>();
        r1 = r9.mSessions;
        monitor-enter(r1);
        r6 = 0;
    L_0x0020:
        r0 = r9.mSessions;	 Catch:{ all -> 0x004d }
        r0 = r0.size();	 Catch:{ all -> 0x004d }
        if (r6 >= r0) goto L_0x0046;
    L_0x0028:
        r0 = r9.mSessions;	 Catch:{ all -> 0x004d }
        r8 = r0.valueAt(r6);	 Catch:{ all -> 0x004d }
        r8 = (com.android.server.pm.PackageInstallerSession) r8;	 Catch:{ all -> 0x004d }
        r0 = r8.installerPackageName;	 Catch:{ all -> 0x004d }
        r0 = java.util.Objects.equals(r0, r10);	 Catch:{ all -> 0x004d }
        if (r0 == 0) goto L_0x0043;
    L_0x0038:
        r0 = r8.userId;	 Catch:{ all -> 0x004d }
        if (r0 != r11) goto L_0x0043;
    L_0x003c:
        r0 = r8.generateInfo();	 Catch:{ all -> 0x004d }
        r7.add(r0);	 Catch:{ all -> 0x004d }
    L_0x0043:
        r6 = r6 + 1;
        goto L_0x0020;
    L_0x0046:
        monitor-exit(r1);	 Catch:{ all -> 0x004d }
        r0 = new android.content.pm.ParceledListSlice;
        r0.<init>(r7);
        return r0;
    L_0x004d:
        r0 = move-exception;
        monitor-exit(r1);	 Catch:{ all -> 0x004d }
        throw r0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.pm.PackageInstallerService.getMySessions(java.lang.String, int):android.content.pm.ParceledListSlice<android.content.pm.PackageInstaller$SessionInfo>");
    }

    public void uninstall(String packageName, int flags, IntentSender statusReceiver, int userId) {
        this.mPm.enforceCrossUserPermission(Binder.getCallingUid(), userId, true, true, "uninstall");
        PackageDeleteObserverAdapter adapter = new PackageDeleteObserverAdapter(this.mContext, statusReceiver, packageName);
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DELETE_PACKAGES") == 0) {
            this.mPm.deletePackage(packageName, adapter.getBinder(), userId, flags);
            return;
        }
        Intent intent = new Intent("android.intent.action.UNINSTALL_PACKAGE");
        intent.setData(Uri.fromParts("package", packageName, null));
        intent.putExtra("android.content.pm.extra.CALLBACK", adapter.getBinder().asBinder());
        adapter.onUserActionRequired(intent);
    }

    public void setPermissionsResult(int sessionId, boolean accepted) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.INSTALL_PACKAGES", TAG);
        synchronized (this.mSessions) {
            ((PackageInstallerSession) this.mSessions.get(sessionId)).setPermissionsResult(accepted);
        }
    }

    public void registerCallback(IPackageInstallerCallback callback, int userId) {
        this.mPm.enforceCrossUserPermission(Binder.getCallingUid(), userId, true, LOGD, "registerCallback");
        this.mCallbacks.register(callback, userId);
    }

    public void unregisterCallback(IPackageInstallerCallback callback) {
        this.mCallbacks.unregister(callback);
    }

    private static int getSessionCount(SparseArray<PackageInstallerSession> sessions, int installerUid) {
        int count = 0;
        int size = sessions.size();
        for (int i = 0; i < size; i++) {
            if (((PackageInstallerSession) sessions.valueAt(i)).installerUid == installerUid) {
                count++;
            }
        }
        return count;
    }

    private boolean isCallingUidOwner(PackageInstallerSession session) {
        int callingUid = Binder.getCallingUid();
        if (callingUid == 0) {
            return true;
        }
        if (session == null || callingUid != session.installerUid) {
            return LOGD;
        }
        return true;
    }

    void dump(IndentingPrintWriter pw) {
        synchronized (this.mSessions) {
            int i;
            pw.println("Active install sessions:");
            pw.increaseIndent();
            int N = this.mSessions.size();
            for (i = 0; i < N; i++) {
                ((PackageInstallerSession) this.mSessions.valueAt(i)).dump(pw);
                pw.println();
            }
            pw.println();
            pw.decreaseIndent();
            pw.println("Historical install sessions:");
            pw.increaseIndent();
            N = this.mHistoricalSessions.size();
            for (i = 0; i < N; i++) {
                ((PackageInstallerSession) this.mHistoricalSessions.valueAt(i)).dump(pw);
                pw.println();
            }
            pw.println();
            pw.decreaseIndent();
            pw.println("Legacy install sessions:");
            pw.increaseIndent();
            pw.println(this.mLegacySessions.toString());
            pw.decreaseIndent();
        }
    }
}
