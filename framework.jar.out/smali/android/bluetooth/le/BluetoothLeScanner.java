package android.bluetooth.le;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothGattCallbackWrapper;
import android.bluetooth.IBluetoothGatt;
import android.bluetooth.IBluetoothManager;
import android.bluetooth.le.ScanSettings.Builder;
import android.os.Handler;
import android.os.Looper;
import android.os.ParcelUuid;
import android.os.RemoteException;
import android.util.Log;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public final class BluetoothLeScanner {
    private static final boolean DBG = true;
    private static final String TAG = "BluetoothLeScanner";
    private static final boolean VDBG = false;
    private BluetoothAdapter mBluetoothAdapter;
    private final IBluetoothManager mBluetoothManager;
    private final Handler mHandler;
    private final Map<ScanCallback, BleScanCallbackWrapper> mLeScanClients;

    /* renamed from: android.bluetooth.le.BluetoothLeScanner.1 */
    class C00801 implements Runnable {
        final /* synthetic */ ScanCallback val$callback;
        final /* synthetic */ int val$errorCode;

        C00801(ScanCallback scanCallback, int i) {
            this.val$callback = scanCallback;
            this.val$errorCode = i;
        }

        public void run() {
            this.val$callback.onScanFailed(this.val$errorCode);
        }
    }

    private class BleScanCallbackWrapper extends BluetoothGattCallbackWrapper {
        private static final int REGISTRATION_CALLBACK_TIMEOUT_MILLIS = 2000;
        private IBluetoothGatt mBluetoothGatt;
        private int mClientIf;
        private final List<ScanFilter> mFilters;
        private List<List<ResultStorageDescriptor>> mResultStorages;
        private final ScanCallback mScanCallback;
        private ScanSettings mSettings;

        /* renamed from: android.bluetooth.le.BluetoothLeScanner.BleScanCallbackWrapper.1 */
        class C00811 implements Runnable {
            final /* synthetic */ ScanResult val$scanResult;

            C00811(ScanResult scanResult) {
                this.val$scanResult = scanResult;
            }

            public void run() {
                BleScanCallbackWrapper.this.mScanCallback.onScanResult(1, this.val$scanResult);
            }
        }

        /* renamed from: android.bluetooth.le.BluetoothLeScanner.BleScanCallbackWrapper.2 */
        class C00822 implements Runnable {
            final /* synthetic */ List val$results;

            C00822(List list) {
                this.val$results = list;
            }

            public void run() {
                BleScanCallbackWrapper.this.mScanCallback.onBatchScanResults(this.val$results);
            }
        }

        /* renamed from: android.bluetooth.le.BluetoothLeScanner.BleScanCallbackWrapper.3 */
        class C00833 implements Runnable {
            final /* synthetic */ boolean val$onFound;
            final /* synthetic */ ScanResult val$scanResult;

            C00833(boolean z, ScanResult scanResult) {
                this.val$onFound = z;
                this.val$scanResult = scanResult;
            }

            public void run() {
                if (this.val$onFound) {
                    BleScanCallbackWrapper.this.mScanCallback.onScanResult(2, this.val$scanResult);
                } else {
                    BleScanCallbackWrapper.this.mScanCallback.onScanResult(4, this.val$scanResult);
                }
            }
        }

        public BleScanCallbackWrapper(IBluetoothGatt bluetoothGatt, List<ScanFilter> filters, ScanSettings settings, ScanCallback scanCallback, List<List<ResultStorageDescriptor>> resultStorages) {
            this.mBluetoothGatt = bluetoothGatt;
            this.mFilters = filters;
            this.mSettings = settings;
            this.mScanCallback = scanCallback;
            this.mClientIf = 0;
            this.mResultStorages = resultStorages;
        }

        public void startRegisteration() {
            Exception e;
            synchronized (this) {
                if (this.mClientIf == -1) {
                    return;
                }
                try {
                    this.mBluetoothGatt.registerClient(new ParcelUuid(UUID.randomUUID()), this);
                    wait(2000);
                } catch (Exception e2) {
                    e = e2;
                    Log.e(BluetoothLeScanner.TAG, "application registeration exception", e);
                    BluetoothLeScanner.this.postCallbackError(this.mScanCallback, 3);
                    if (this.mClientIf > 0) {
                        BluetoothLeScanner.this.postCallbackError(this.mScanCallback, 2);
                    } else {
                        BluetoothLeScanner.this.mLeScanClients.put(this.mScanCallback, this);
                    }
                } catch (Exception e22) {
                    e = e22;
                    Log.e(BluetoothLeScanner.TAG, "application registeration exception", e);
                    BluetoothLeScanner.this.postCallbackError(this.mScanCallback, 3);
                    if (this.mClientIf > 0) {
                        BluetoothLeScanner.this.mLeScanClients.put(this.mScanCallback, this);
                    } else {
                        BluetoothLeScanner.this.postCallbackError(this.mScanCallback, 2);
                    }
                }
                if (this.mClientIf > 0) {
                    BluetoothLeScanner.this.mLeScanClients.put(this.mScanCallback, this);
                } else {
                    BluetoothLeScanner.this.postCallbackError(this.mScanCallback, 2);
                }
            }
        }

        public void stopLeScan() {
            synchronized (this) {
                if (this.mClientIf <= 0) {
                    Log.e(BluetoothLeScanner.TAG, "Error state, mLeHandle: " + this.mClientIf);
                    return;
                }
                try {
                    this.mBluetoothGatt.stopScan(this.mClientIf, false);
                    this.mBluetoothGatt.unregisterClient(this.mClientIf);
                } catch (RemoteException e) {
                    Log.e(BluetoothLeScanner.TAG, "Failed to stop scan and unregister", e);
                }
                this.mClientIf = -1;
            }
        }

        void flushPendingBatchResults() {
            synchronized (this) {
                if (this.mClientIf <= 0) {
                    Log.e(BluetoothLeScanner.TAG, "Error state, mLeHandle: " + this.mClientIf);
                    return;
                }
                try {
                    this.mBluetoothGatt.flushPendingBatchResults(this.mClientIf, false);
                } catch (RemoteException e) {
                    Log.e(BluetoothLeScanner.TAG, "Failed to get pending scan results", e);
                }
            }
        }

        public void onClientRegistered(int status, int clientIf) {
            Log.d(BluetoothLeScanner.TAG, "onClientRegistered() - status=" + status + " clientIf=" + clientIf);
            synchronized (this) {
                if (this.mClientIf == -1) {
                    Log.d(BluetoothLeScanner.TAG, "onClientRegistered LE scan canceled");
                }
                if (status == 0) {
                    this.mClientIf = clientIf;
                    try {
                        this.mBluetoothGatt.startScan(this.mClientIf, false, this.mSettings, this.mFilters, this.mResultStorages);
                    } catch (RemoteException e) {
                        Log.e(BluetoothLeScanner.TAG, "fail to start le scan: " + e);
                        this.mClientIf = -1;
                    }
                } else {
                    this.mClientIf = -1;
                }
                notifyAll();
            }
        }

        public void onScanResult(ScanResult scanResult) {
            synchronized (this) {
                if (this.mClientIf <= 0) {
                    return;
                }
                new Handler(Looper.getMainLooper()).post(new C00811(scanResult));
            }
        }

        public void onBatchScanResults(List<ScanResult> results) {
            new Handler(Looper.getMainLooper()).post(new C00822(results));
        }

        public void onFoundOrLost(boolean onFound, ScanResult scanResult) {
            synchronized (this) {
                if (this.mClientIf <= 0) {
                    return;
                }
                new Handler(Looper.getMainLooper()).post(new C00833(onFound, scanResult));
            }
        }
    }

    public BluetoothLeScanner(IBluetoothManager bluetoothManager) {
        this.mBluetoothManager = bluetoothManager;
        this.mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        this.mHandler = new Handler(Looper.getMainLooper());
        this.mLeScanClients = new HashMap();
    }

    public void startScan(ScanCallback callback) {
        if (callback == null) {
            throw new IllegalArgumentException("callback is null");
        }
        startScan(null, new Builder().build(), callback);
    }

    public void startScan(List<ScanFilter> filters, ScanSettings settings, ScanCallback callback) {
        startScan(filters, settings, callback, null);
    }

    private void startScan(List<ScanFilter> filters, ScanSettings settings, ScanCallback callback, List<List<ResultStorageDescriptor>> resultStorages) {
        BluetoothLeUtils.checkAdapterStateOn(this.mBluetoothAdapter);
        if (settings == null || callback == null) {
            throw new IllegalArgumentException("settings or callback is null");
        }
        synchronized (this.mLeScanClients) {
            if (this.mLeScanClients.containsKey(callback)) {
                postCallbackError(callback, 1);
                return;
            }
            IBluetoothGatt gatt;
            try {
                gatt = this.mBluetoothManager.getBluetoothGatt();
            } catch (RemoteException e) {
                gatt = null;
            }
            if (gatt == null) {
                postCallbackError(callback, 3);
                return;
            } else if (isSettingsConfigAllowedForScan(settings)) {
                new BleScanCallbackWrapper(gatt, filters, settings, callback, resultStorages).startRegisteration();
                return;
            } else {
                postCallbackError(callback, 4);
                return;
            }
        }
    }

    public void stopScan(ScanCallback callback) {
        BluetoothLeUtils.checkAdapterStateOn(this.mBluetoothAdapter);
        synchronized (this.mLeScanClients) {
            BleScanCallbackWrapper wrapper = (BleScanCallbackWrapper) this.mLeScanClients.remove(callback);
            if (wrapper == null) {
                Log.d(TAG, "could not find callback wrapper");
                return;
            }
            wrapper.stopLeScan();
        }
    }

    public void flushPendingScanResults(ScanCallback callback) {
        BluetoothLeUtils.checkAdapterStateOn(this.mBluetoothAdapter);
        if (callback == null) {
            throw new IllegalArgumentException("callback cannot be null!");
        }
        synchronized (this.mLeScanClients) {
            BleScanCallbackWrapper wrapper = (BleScanCallbackWrapper) this.mLeScanClients.get(callback);
            if (wrapper == null) {
                return;
            }
            wrapper.flushPendingBatchResults();
        }
    }

    public void startTruncatedScan(List<TruncatedFilter> truncatedFilters, ScanSettings settings, ScanCallback callback) {
        int filterSize = truncatedFilters.size();
        List<ScanFilter> scanFilters = new ArrayList(filterSize);
        List<List<ResultStorageDescriptor>> scanStorages = new ArrayList(filterSize);
        for (TruncatedFilter filter : truncatedFilters) {
            scanFilters.add(filter.getFilter());
            scanStorages.add(filter.getStorageDescriptors());
        }
        startScan(scanFilters, settings, callback, scanStorages);
    }

    public void cleanup() {
        this.mLeScanClients.clear();
    }

    private void postCallbackError(ScanCallback callback, int errorCode) {
        this.mHandler.post(new C00801(callback, errorCode));
    }

    private boolean isSettingsConfigAllowedForScan(ScanSettings settings) {
        if (this.mBluetoothAdapter.isOffloadedFilteringSupported()) {
            return DBG;
        }
        if (settings.getCallbackType() == 1 && settings.getReportDelayMillis() == 0) {
            return DBG;
        }
        return false;
    }
}
