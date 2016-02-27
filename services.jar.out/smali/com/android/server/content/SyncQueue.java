package com.android.server.content;

import android.content.ComponentName;
import android.content.SyncAdapterType;
import android.content.SyncAdaptersCache;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.RegisteredServicesCache.ServiceInfo;
import android.os.Bundle;
import android.os.SystemClock;
import android.text.format.DateUtils;
import android.util.Log;
import android.util.Pair;
import com.android.server.content.SyncStorageEngine.EndPoint;
import com.android.server.content.SyncStorageEngine.PendingOperation;
import com.google.android.collect.Maps;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;

public class SyncQueue {
    private static final String TAG = "SyncManager";
    private final HashMap<String, SyncOperation> mOperationsMap;
    private final PackageManager mPackageManager;
    private final SyncAdaptersCache mSyncAdapters;
    private final SyncStorageEngine mSyncStorageEngine;

    public SyncQueue(PackageManager packageManager, SyncStorageEngine syncStorageEngine, SyncAdaptersCache syncAdapters) {
        this.mOperationsMap = Maps.newHashMap();
        this.mPackageManager = packageManager;
        this.mSyncStorageEngine = syncStorageEngine;
        this.mSyncAdapters = syncAdapters;
    }

    public void addPendingOperations(int userId) {
        Iterator i$ = this.mSyncStorageEngine.getPendingOperations().iterator();
        while (i$.hasNext()) {
            PendingOperation op = (PendingOperation) i$.next();
            EndPoint info = op.target;
            if (info.userId == userId) {
                Pair<Long, Long> backoff = this.mSyncStorageEngine.getBackoff(info);
                SyncOperation operationToAdd;
                if (info.target_provider) {
                    ServiceInfo<SyncAdapterType> syncAdapterInfo = this.mSyncAdapters.getServiceInfo(SyncAdapterType.newKey(info.provider, info.account.type), info.userId);
                    if (syncAdapterInfo != null) {
                        operationToAdd = new SyncOperation(info.account, info.userId, op.reason, op.syncSource, info.provider, op.extras, op.expedited ? -1 : 0, 0, backoff != null ? ((Long) backoff.first).longValue() : 0, this.mSyncStorageEngine.getDelayUntilTime(info), ((SyncAdapterType) syncAdapterInfo.type).allowParallelSyncs());
                        operationToAdd.pendingOperation = op;
                        add(operationToAdd, op);
                    } else if (Log.isLoggable(TAG, 2)) {
                        Log.v(TAG, "Missing sync adapter info for authority " + op.target);
                    }
                } else if (info.target_service) {
                    try {
                        long longValue;
                        this.mPackageManager.getServiceInfo(info.service, 0);
                        ComponentName componentName = info.service;
                        int i = info.userId;
                        int i2 = op.reason;
                        int i3 = op.syncSource;
                        Bundle bundle = op.extras;
                        long j = op.expedited ? -1 : 0;
                        if (backoff != null) {
                            longValue = ((Long) backoff.first).longValue();
                        } else {
                            longValue = 0;
                        }
                        operationToAdd = new SyncOperation(componentName, i, i2, i3, bundle, j, 0, longValue, this.mSyncStorageEngine.getDelayUntilTime(info));
                        operationToAdd.pendingOperation = op;
                        add(operationToAdd, op);
                    } catch (NameNotFoundException e) {
                        if (Log.isLoggable(TAG, 2)) {
                            Log.w(TAG, "Missing sync service for authority " + op.target);
                        }
                    }
                }
            }
        }
    }

    public boolean add(SyncOperation operation) {
        return add(operation, null);
    }

    private boolean add(SyncOperation operation, PendingOperation pop) {
        String operationKey = operation.key;
        SyncOperation existingOperation = (SyncOperation) this.mOperationsMap.get(operationKey);
        if (existingOperation == null) {
            operation.pendingOperation = pop;
            if (operation.pendingOperation == null) {
                pop = this.mSyncStorageEngine.insertIntoPending(operation);
                if (pop == null) {
                    throw new IllegalStateException("error adding pending sync operation " + operation);
                }
                operation.pendingOperation = pop;
            }
            this.mOperationsMap.put(operationKey, operation);
            return true;
        } else if (operation.compareTo(existingOperation) > 0) {
            return false;
        } else {
            existingOperation.latestRunTime = Math.min(existingOperation.latestRunTime, operation.latestRunTime);
            existingOperation.flexTime = operation.flexTime;
            return true;
        }
    }

    public void removeUserLocked(int userId) {
        ArrayList<SyncOperation> opsToRemove = new ArrayList();
        for (SyncOperation op : this.mOperationsMap.values()) {
            if (op.target.userId == userId) {
                opsToRemove.add(op);
            }
        }
        Iterator i$ = opsToRemove.iterator();
        while (i$.hasNext()) {
            remove((SyncOperation) i$.next());
        }
    }

    public void remove(SyncOperation operation) {
        boolean isLoggable = Log.isLoggable(TAG, 2);
        SyncOperation operationToRemove = (SyncOperation) this.mOperationsMap.remove(operation.key);
        if (isLoggable) {
            Log.v(TAG, "Attempting to remove: " + operation.key);
        }
        if (operationToRemove == null) {
            if (isLoggable) {
                Log.v(TAG, "Could not find: " + operation.key);
            }
        } else if (!this.mSyncStorageEngine.deleteFromPending(operationToRemove.pendingOperation)) {
            String errorMessage = "unable to find pending row for " + operationToRemove;
            Log.e(TAG, errorMessage, new IllegalStateException(errorMessage));
        }
    }

    public void clearBackoffs() {
        for (SyncOperation op : this.mOperationsMap.values()) {
            op.backoff = 0;
            op.updateEffectiveRunTime();
        }
    }

    public void onBackoffChanged(EndPoint target, long backoff) {
        for (SyncOperation op : this.mOperationsMap.values()) {
            if (op.target.matchesSpec(target)) {
                op.backoff = backoff;
                op.updateEffectiveRunTime();
            }
        }
    }

    public void onDelayUntilTimeChanged(EndPoint target, long delayUntil) {
        for (SyncOperation op : this.mOperationsMap.values()) {
            if (op.target.matchesSpec(target)) {
                op.delayUntil = delayUntil;
                op.updateEffectiveRunTime();
            }
        }
    }

    public void remove(EndPoint info, Bundle extras) {
        Iterator<Entry<String, SyncOperation>> entries = this.mOperationsMap.entrySet().iterator();
        while (entries.hasNext()) {
            SyncOperation syncOperation = (SyncOperation) ((Entry) entries.next()).getValue();
            if (syncOperation.target.matchesSpec(info) && (extras == null || SyncManager.syncExtrasEquals(syncOperation.extras, extras, false))) {
                entries.remove();
                if (!this.mSyncStorageEngine.deleteFromPending(syncOperation.pendingOperation)) {
                    String errorMessage = "unable to find pending row for " + syncOperation;
                    Log.e(TAG, errorMessage, new IllegalStateException(errorMessage));
                }
            }
        }
    }

    public Collection<SyncOperation> getOperations() {
        return this.mOperationsMap.values();
    }

    public void dump(StringBuilder sb) {
        long now = SystemClock.elapsedRealtime();
        sb.append("SyncQueue: ").append(this.mOperationsMap.size()).append(" operation(s)\n");
        for (SyncOperation operation : this.mOperationsMap.values()) {
            sb.append("  ");
            if (operation.effectiveRunTime <= now) {
                sb.append("READY");
            } else {
                sb.append(DateUtils.formatElapsedTime((operation.effectiveRunTime - now) / 1000));
            }
            sb.append(" - ");
            sb.append(operation.dump(this.mPackageManager, false)).append("\n");
        }
    }
}
