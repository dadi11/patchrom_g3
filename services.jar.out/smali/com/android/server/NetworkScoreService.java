package com.android.server;

import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.INetworkScoreCache;
import android.net.INetworkScoreService.Stub;
import android.net.NetworkScorerAppManager;
import android.net.NetworkScorerAppManager.NetworkScorerAppData;
import android.net.ScoredNetwork;
import android.os.Binder;
import android.os.RemoteException;
import android.os.UserHandle;
import android.provider.Settings.Global;
import android.text.TextUtils;
import android.util.Log;
import com.android.internal.annotations.GuardedBy;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class NetworkScoreService extends Stub {
    private static final String TAG = "NetworkScoreService";
    private final Context mContext;
    @GuardedBy("mReceiverLock")
    private ScorerChangedReceiver mReceiver;
    private Object mReceiverLock;
    private final Map<Integer, INetworkScoreCache> mScoreCaches;

    private class ScorerChangedReceiver extends BroadcastReceiver {
        final String mRegisteredPackage;

        ScorerChangedReceiver(String packageName) {
            this.mRegisteredPackage = packageName;
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (("android.intent.action.PACKAGE_CHANGED".equals(action) || "android.intent.action.PACKAGE_REPLACED".equals(action) || "android.intent.action.PACKAGE_FULLY_REMOVED".equals(action)) && NetworkScorerAppManager.getActiveScorer(NetworkScoreService.this.mContext) == null) {
                Log.i(NetworkScoreService.TAG, "Package " + this.mRegisteredPackage + " is no longer valid, disabling scoring");
                NetworkScoreService.this.setScorerInternal(null);
            }
        }
    }

    public NetworkScoreService(Context context) {
        this.mReceiverLock = new Object[0];
        this.mContext = context;
        this.mScoreCaches = new HashMap();
    }

    void systemReady() {
        ContentResolver cr = this.mContext.getContentResolver();
        if (Global.getInt(cr, "network_scoring_provisioned", 0) == 0) {
            String defaultPackage = this.mContext.getResources().getString(17039432);
            if (!TextUtils.isEmpty(defaultPackage)) {
                NetworkScorerAppManager.setActiveScorer(this.mContext, defaultPackage);
            }
            Global.putInt(cr, "network_scoring_provisioned", 1);
        }
        registerPackageReceiverIfNeeded();
    }

    private void registerPackageReceiverIfNeeded() {
        NetworkScorerAppData scorer = NetworkScorerAppManager.getActiveScorer(this.mContext);
        synchronized (this.mReceiverLock) {
            if (this.mReceiver != null) {
                if (Log.isLoggable(TAG, 2)) {
                    Log.v(TAG, "Unregistering receiver for " + this.mReceiver.mRegisteredPackage);
                }
                this.mContext.unregisterReceiver(this.mReceiver);
                this.mReceiver = null;
            }
            if (scorer != null) {
                IntentFilter filter = new IntentFilter();
                filter.addAction("android.intent.action.PACKAGE_CHANGED");
                filter.addAction("android.intent.action.PACKAGE_REPLACED");
                filter.addAction("android.intent.action.PACKAGE_FULLY_REMOVED");
                filter.addDataScheme("package");
                filter.addDataSchemeSpecificPart(scorer.mPackageName, 0);
                this.mReceiver = new ScorerChangedReceiver(scorer.mPackageName);
                this.mContext.registerReceiverAsUser(this.mReceiver, UserHandle.OWNER, filter, null, null);
                if (Log.isLoggable(TAG, 2)) {
                    Log.v(TAG, "Registered receiver for " + scorer.mPackageName);
                }
            }
        }
    }

    public boolean updateScores(ScoredNetwork[] networks) {
        if (NetworkScorerAppManager.isCallerActiveScorer(this.mContext, getCallingUid())) {
            Map<Integer, List<ScoredNetwork>> networksByType = new HashMap();
            for (ScoredNetwork network : networks) {
                List<ScoredNetwork> networkList = (List) networksByType.get(Integer.valueOf(network.networkKey.type));
                if (networkList == null) {
                    networkList = new ArrayList();
                    networksByType.put(Integer.valueOf(network.networkKey.type), networkList);
                }
                networkList.add(network);
            }
            for (Entry<Integer, List<ScoredNetwork>> entry : networksByType.entrySet()) {
                INetworkScoreCache scoreCache = (INetworkScoreCache) this.mScoreCaches.get(entry.getKey());
                if (scoreCache != null) {
                    try {
                        scoreCache.updateScores((List) entry.getValue());
                    } catch (RemoteException e) {
                        if (Log.isLoggable(TAG, 2)) {
                            Log.v(TAG, "Unable to update scores of type " + entry.getKey(), e);
                        }
                    }
                } else if (Log.isLoggable(TAG, 2)) {
                    Log.v(TAG, "No scorer registered for type " + entry.getKey() + ", discarding");
                }
            }
            return true;
        }
        throw new SecurityException("Caller with UID " + getCallingUid() + " is not the active scorer.");
    }

    public boolean clearScores() {
        if (NetworkScorerAppManager.isCallerActiveScorer(this.mContext, getCallingUid()) || this.mContext.checkCallingOrSelfPermission("android.permission.BROADCAST_NETWORK_PRIVILEGED") == 0) {
            clearInternal();
            return true;
        }
        throw new SecurityException("Caller is neither the active scorer nor the scorer manager.");
    }

    public boolean setActiveScorer(String packageName) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.SCORE_NETWORKS", TAG);
        return setScorerInternal(packageName);
    }

    public void disableScoring() {
        if (NetworkScorerAppManager.isCallerActiveScorer(this.mContext, getCallingUid()) || this.mContext.checkCallingOrSelfPermission("android.permission.BROADCAST_NETWORK_PRIVILEGED") == 0) {
            setScorerInternal(null);
            return;
        }
        throw new SecurityException("Caller is neither the active scorer nor the scorer manager.");
    }

    private boolean setScorerInternal(String packageName) {
        long token = Binder.clearCallingIdentity();
        try {
            clearInternal();
            boolean result = NetworkScorerAppManager.setActiveScorer(this.mContext, packageName);
            if (result) {
                registerPackageReceiverIfNeeded();
                Intent intent = new Intent("android.net.scoring.SCORER_CHANGED");
                intent.putExtra("newScorer", packageName);
                this.mContext.sendBroadcastAsUser(intent, UserHandle.ALL);
            }
            Binder.restoreCallingIdentity(token);
            return result;
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(token);
        }
    }

    private void clearInternal() {
        for (INetworkScoreCache scoreCache : getScoreCaches()) {
            try {
                scoreCache.clearScores();
            } catch (RemoteException e) {
                if (Log.isLoggable(TAG, 2)) {
                    Log.v(TAG, "Unable to clear scores", e);
                }
            }
        }
    }

    public void registerNetworkScoreCache(int networkType, INetworkScoreCache scoreCache) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.BROADCAST_NETWORK_PRIVILEGED", TAG);
        synchronized (this.mScoreCaches) {
            if (this.mScoreCaches.containsKey(Integer.valueOf(networkType))) {
                throw new IllegalArgumentException("Score cache already registered for type " + networkType);
            }
            this.mScoreCaches.put(Integer.valueOf(networkType), scoreCache);
        }
    }

    protected void dump(FileDescriptor fd, PrintWriter writer, String[] args) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DUMP", TAG);
        NetworkScorerAppData currentScorer = NetworkScorerAppManager.getActiveScorer(this.mContext);
        if (currentScorer == null) {
            writer.println("Scoring is disabled.");
            return;
        }
        writer.println("Current scorer: " + currentScorer.mPackageName);
        writer.flush();
        for (INetworkScoreCache scoreCache : getScoreCaches()) {
            try {
                scoreCache.asBinder().dump(fd, args);
            } catch (RemoteException e) {
                writer.println("Unable to dump score cache");
                if (Log.isLoggable(TAG, 2)) {
                    Log.v(TAG, "Unable to dump score cache", e);
                }
            }
        }
    }

    private Set<INetworkScoreCache> getScoreCaches() {
        Set hashSet;
        synchronized (this.mScoreCaches) {
            hashSet = new HashSet(this.mScoreCaches.values());
        }
        return hashSet;
    }
}
