package com.android.server.backup;

import android.app.backup.IBackupManager.Stub;
import android.app.backup.IFullBackupRestoreObserver;
import android.app.backup.IRestoreSession;
import android.content.Context;
import android.content.Intent;
import android.os.Binder;
import android.os.Environment;
import android.os.IBinder;
import android.os.ParcelFileDescriptor;
import android.os.RemoteException;
import android.os.SystemProperties;
import android.util.Slog;
import java.io.File;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.PrintWriter;

public class Trampoline extends Stub {
    static final String BACKUP_DISABLE_PROPERTY = "ro.backup.disable";
    static final String BACKUP_SUPPRESS_FILENAME = "backup-suppress";
    static final boolean DEBUG_TRAMPOLINE = false;
    static final String TAG = "BackupManagerService";
    final Context mContext;
    final boolean mGlobalDisable;
    volatile BackupManagerService mService;
    final File mSuppressFile;

    public Trampoline(Context context) {
        this.mContext = context;
        File dir = new File(Environment.getSecureDataDirectory(), "backup");
        dir.mkdirs();
        this.mSuppressFile = new File(dir, BACKUP_SUPPRESS_FILENAME);
        this.mGlobalDisable = SystemProperties.getBoolean(BACKUP_DISABLE_PROPERTY, DEBUG_TRAMPOLINE);
    }

    public void initialize(int whichUser) {
        if (whichUser != 0) {
            return;
        }
        if (this.mGlobalDisable) {
            Slog.i(TAG, "Backup/restore not supported");
            return;
        }
        synchronized (this) {
            if (this.mSuppressFile.exists()) {
                Slog.i(TAG, "Backup inactive in user " + whichUser);
            } else {
                this.mService = new BackupManagerService(this.mContext, this);
            }
        }
    }

    public void setBackupServiceActive(int userHandle, boolean makeActive) {
        int caller = Binder.getCallingUid();
        if (caller != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE && caller != 0) {
            throw new SecurityException("No permission to configure backup activity");
        } else if (this.mGlobalDisable) {
            Slog.i(TAG, "Backup/restore not supported");
        } else if (userHandle == 0) {
            synchronized (this) {
                if (makeActive != isBackupServiceActive(userHandle)) {
                    Slog.i(TAG, "Making backup " + (makeActive ? "" : "in") + "active in user " + userHandle);
                    if (makeActive) {
                        this.mService = new BackupManagerService(this.mContext, this);
                        this.mSuppressFile.delete();
                    } else {
                        this.mService = null;
                        try {
                            this.mSuppressFile.createNewFile();
                        } catch (IOException e) {
                            Slog.e(TAG, "Unable to persist backup service inactivity");
                        }
                    }
                }
            }
        }
    }

    public boolean isBackupServiceActive(int userHandle) {
        boolean z = DEBUG_TRAMPOLINE;
        if (userHandle == 0) {
            synchronized (this) {
                if (this.mService != null) {
                    z = true;
                }
            }
        }
        return z;
    }

    public void dataChanged(String packageName) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.dataChanged(packageName);
        }
    }

    public void clearBackupData(String transportName, String packageName) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.clearBackupData(transportName, packageName);
        }
    }

    public void agentConnected(String packageName, IBinder agent) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.agentConnected(packageName, agent);
        }
    }

    public void agentDisconnected(String packageName) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.agentDisconnected(packageName);
        }
    }

    public void restoreAtInstall(String packageName, int token) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.restoreAtInstall(packageName, token);
        }
    }

    public void setBackupEnabled(boolean isEnabled) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.setBackupEnabled(isEnabled);
        }
    }

    public void setAutoRestore(boolean doAutoRestore) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.setAutoRestore(doAutoRestore);
        }
    }

    public void setBackupProvisioned(boolean isProvisioned) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.setBackupProvisioned(isProvisioned);
        }
    }

    public boolean isBackupEnabled() throws RemoteException {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.isBackupEnabled() : DEBUG_TRAMPOLINE;
    }

    public boolean setBackupPassword(String currentPw, String newPw) throws RemoteException {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.setBackupPassword(currentPw, newPw) : DEBUG_TRAMPOLINE;
    }

    public boolean hasBackupPassword() throws RemoteException {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.hasBackupPassword() : DEBUG_TRAMPOLINE;
    }

    public void backupNow() throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.backupNow();
        }
    }

    public void fullBackup(ParcelFileDescriptor fd, boolean includeApks, boolean includeObbs, boolean includeShared, boolean doWidgets, boolean allApps, boolean allIncludesSystem, boolean doCompress, String[] packageNames) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.fullBackup(fd, includeApks, includeObbs, includeShared, doWidgets, allApps, allIncludesSystem, doCompress, packageNames);
        }
    }

    public void fullTransportBackup(String[] packageNames) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.fullTransportBackup(packageNames);
        }
    }

    public void fullRestore(ParcelFileDescriptor fd) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.fullRestore(fd);
        }
    }

    public void acknowledgeFullBackupOrRestore(int token, boolean allow, String curPassword, String encryptionPassword, IFullBackupRestoreObserver observer) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.acknowledgeFullBackupOrRestore(token, allow, curPassword, encryptionPassword, observer);
        }
    }

    public String getCurrentTransport() throws RemoteException {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.getCurrentTransport() : null;
    }

    public String[] listAllTransports() throws RemoteException {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.listAllTransports() : null;
    }

    public String selectBackupTransport(String transport) throws RemoteException {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.selectBackupTransport(transport) : null;
    }

    public Intent getConfigurationIntent(String transport) throws RemoteException {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.getConfigurationIntent(transport) : null;
    }

    public String getDestinationString(String transport) throws RemoteException {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.getDestinationString(transport) : null;
    }

    public Intent getDataManagementIntent(String transport) throws RemoteException {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.getDataManagementIntent(transport) : null;
    }

    public String getDataManagementLabel(String transport) throws RemoteException {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.getDataManagementLabel(transport) : null;
    }

    public IRestoreSession beginRestoreSession(String packageName, String transportID) throws RemoteException {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.beginRestoreSession(packageName, transportID) : null;
    }

    public void opComplete(int token) throws RemoteException {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.opComplete(token);
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.dump(fd, pw, args);
        } else {
            pw.println("Inactive");
        }
    }

    boolean beginFullBackup(FullBackupJob scheduledJob) {
        BackupManagerService svc = this.mService;
        return svc != null ? svc.beginFullBackup(scheduledJob) : DEBUG_TRAMPOLINE;
    }

    void endFullBackup() {
        BackupManagerService svc = this.mService;
        if (svc != null) {
            svc.endFullBackup();
        }
    }
}
