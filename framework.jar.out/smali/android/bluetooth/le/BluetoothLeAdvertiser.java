package android.bluetooth.le;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothGattCallbackWrapper;
import android.bluetooth.BluetoothUuid;
import android.bluetooth.IBluetoothGatt;
import android.bluetooth.IBluetoothManager;
import android.os.Handler;
import android.os.Looper;
import android.os.ParcelUuid;
import android.os.RemoteException;
import android.util.Log;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public final class BluetoothLeAdvertiser {
    private static final int FLAGS_FIELD_BYTES = 3;
    private static final int MANUFACTURER_SPECIFIC_DATA_LENGTH = 2;
    private static final int MAX_ADVERTISING_DATA_BYTES = 31;
    private static final int OVERHEAD_BYTES_PER_FIELD = 2;
    private static final int SERVICE_DATA_UUID_LENGTH = 2;
    private static final String TAG = "BluetoothLeAdvertiser";
    private BluetoothAdapter mBluetoothAdapter;
    private final IBluetoothManager mBluetoothManager;
    private final Handler mHandler;
    private final Map<AdvertiseCallback, AdvertiseCallbackWrapper> mLeAdvertisers;

    /* renamed from: android.bluetooth.le.BluetoothLeAdvertiser.1 */
    class C00781 implements Runnable {
        final /* synthetic */ AdvertiseCallback val$callback;
        final /* synthetic */ int val$error;

        C00781(AdvertiseCallback advertiseCallback, int i) {
            this.val$callback = advertiseCallback;
            this.val$error = i;
        }

        public void run() {
            this.val$callback.onStartFailure(this.val$error);
        }
    }

    /* renamed from: android.bluetooth.le.BluetoothLeAdvertiser.2 */
    class C00792 implements Runnable {
        final /* synthetic */ AdvertiseCallback val$callback;
        final /* synthetic */ AdvertiseSettings val$settings;

        C00792(AdvertiseCallback advertiseCallback, AdvertiseSettings advertiseSettings) {
            this.val$callback = advertiseCallback;
            this.val$settings = advertiseSettings;
        }

        public void run() {
            this.val$callback.onStartSuccess(this.val$settings);
        }
    }

    private class AdvertiseCallbackWrapper extends BluetoothGattCallbackWrapper {
        private static final int LE_CALLBACK_TIMEOUT_MILLIS = 2000;
        private final AdvertiseCallback mAdvertiseCallback;
        private final AdvertiseData mAdvertisement;
        private final IBluetoothGatt mBluetoothGatt;
        private int mClientIf;
        private boolean mIsAdvertising;
        private final AdvertiseData mScanResponse;
        private final AdvertiseSettings mSettings;

        public AdvertiseCallbackWrapper(AdvertiseCallback advertiseCallback, AdvertiseData advertiseData, AdvertiseData scanResponse, AdvertiseSettings settings, IBluetoothGatt bluetoothGatt) {
            this.mIsAdvertising = false;
            this.mAdvertiseCallback = advertiseCallback;
            this.mAdvertisement = advertiseData;
            this.mScanResponse = scanResponse;
            this.mSettings = settings;
            this.mBluetoothGatt = bluetoothGatt;
            this.mClientIf = 0;
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
                    Log.e(BluetoothLeAdvertiser.TAG, "Failed to start registeration", e);
                    if (this.mClientIf > 0) {
                    }
                    if (this.mClientIf <= 0) {
                        try {
                            this.mBluetoothGatt.unregisterClient(this.mClientIf);
                            this.mClientIf = -1;
                        } catch (RemoteException e3) {
                            Log.e(BluetoothLeAdvertiser.TAG, "remote exception when unregistering", e3);
                        }
                    } else {
                        BluetoothLeAdvertiser.this.postStartFailure(this.mAdvertiseCallback, 4);
                    }
                } catch (Exception e22) {
                    e = e22;
                    Log.e(BluetoothLeAdvertiser.TAG, "Failed to start registeration", e);
                    if (this.mClientIf > 0) {
                    }
                    if (this.mClientIf <= 0) {
                        BluetoothLeAdvertiser.this.postStartFailure(this.mAdvertiseCallback, 4);
                    } else {
                        this.mBluetoothGatt.unregisterClient(this.mClientIf);
                        this.mClientIf = -1;
                    }
                }
                if (this.mClientIf > 0 || !this.mIsAdvertising) {
                    if (this.mClientIf <= 0) {
                        BluetoothLeAdvertiser.this.postStartFailure(this.mAdvertiseCallback, 4);
                    } else {
                        this.mBluetoothGatt.unregisterClient(this.mClientIf);
                        this.mClientIf = -1;
                    }
                } else if (!BluetoothLeAdvertiser.this.mLeAdvertisers.containsKey(this.mAdvertiseCallback)) {
                    BluetoothLeAdvertiser.this.mLeAdvertisers.put(this.mAdvertiseCallback, this);
                }
            }
        }

        public void stopAdvertising() {
            synchronized (this) {
                try {
                    this.mBluetoothGatt.stopMultiAdvertising(this.mClientIf);
                    wait(2000);
                } catch (Exception e) {
                    Exception e2 = e;
                    Log.e(BluetoothLeAdvertiser.TAG, "Failed to stop advertising", e2);
                    if (BluetoothLeAdvertiser.this.mLeAdvertisers.containsKey(this.mAdvertiseCallback)) {
                        BluetoothLeAdvertiser.this.mLeAdvertisers.remove(this.mAdvertiseCallback);
                    }
                } catch (Exception e3) {
                    e2 = e3;
                    Log.e(BluetoothLeAdvertiser.TAG, "Failed to stop advertising", e2);
                    if (BluetoothLeAdvertiser.this.mLeAdvertisers.containsKey(this.mAdvertiseCallback)) {
                        BluetoothLeAdvertiser.this.mLeAdvertisers.remove(this.mAdvertiseCallback);
                    }
                }
                if (BluetoothLeAdvertiser.this.mLeAdvertisers.containsKey(this.mAdvertiseCallback)) {
                    BluetoothLeAdvertiser.this.mLeAdvertisers.remove(this.mAdvertiseCallback);
                }
            }
        }

        public void onClientRegistered(int status, int clientIf) {
            Log.d(BluetoothLeAdvertiser.TAG, "onClientRegistered() - status=" + status + " clientIf=" + clientIf);
            synchronized (this) {
                if (status == 0) {
                    if (BluetoothLeAdvertiser.this.mBluetoothAdapter.isEnabled()) {
                        this.mClientIf = clientIf;
                        try {
                            this.mBluetoothGatt.startMultiAdvertising(this.mClientIf, this.mAdvertisement, this.mScanResponse, this.mSettings);
                            return;
                        } catch (RemoteException e) {
                            Log.e(BluetoothLeAdvertiser.TAG, "failed to start advertising", e);
                        }
                    }
                }
                this.mClientIf = -1;
                notifyAll();
            }
        }

        public void onMultiAdvertiseCallback(int status, boolean isStart, AdvertiseSettings settings) {
            synchronized (this) {
                if (!isStart) {
                    try {
                        this.mBluetoothGatt.unregisterClient(this.mClientIf);
                        this.mClientIf = -1;
                        this.mIsAdvertising = false;
                        BluetoothLeAdvertiser.this.mLeAdvertisers.remove(this.mAdvertiseCallback);
                    } catch (RemoteException e) {
                        Log.e(BluetoothLeAdvertiser.TAG, "remote exception when unregistering", e);
                    }
                } else if (status == 0) {
                    this.mIsAdvertising = true;
                    BluetoothLeAdvertiser.this.postStartSuccess(this.mAdvertiseCallback, settings);
                    if (!BluetoothLeAdvertiser.this.mLeAdvertisers.containsKey(this.mAdvertiseCallback)) {
                        BluetoothLeAdvertiser.this.mLeAdvertisers.put(this.mAdvertiseCallback, this);
                    }
                } else {
                    BluetoothLeAdvertiser.this.postStartFailure(this.mAdvertiseCallback, status);
                }
                notifyAll();
            }
        }
    }

    public BluetoothLeAdvertiser(IBluetoothManager bluetoothManager) {
        this.mLeAdvertisers = new HashMap();
        this.mBluetoothManager = bluetoothManager;
        this.mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        this.mHandler = new Handler(Looper.getMainLooper());
    }

    public void startAdvertising(AdvertiseSettings settings, AdvertiseData advertiseData, AdvertiseCallback callback) {
        startAdvertising(settings, advertiseData, null, callback);
    }

    public void startAdvertising(AdvertiseSettings settings, AdvertiseData advertiseData, AdvertiseData scanResponse, AdvertiseCallback callback) {
        synchronized (this.mLeAdvertisers) {
            BluetoothLeUtils.checkAdapterStateOn(this.mBluetoothAdapter);
            if (callback == null) {
                throw new IllegalArgumentException("callback cannot be null");
            } else if (!this.mBluetoothAdapter.isMultipleAdvertisementSupported() && !this.mBluetoothAdapter.isPeripheralModeSupported()) {
                postStartFailure(callback, 5);
            } else if (totalBytes(advertiseData, settings.isConnectable()) > MAX_ADVERTISING_DATA_BYTES || totalBytes(scanResponse, false) > MAX_ADVERTISING_DATA_BYTES) {
                postStartFailure(callback, 1);
            } else if (this.mLeAdvertisers.containsKey(callback)) {
                postStartFailure(callback, FLAGS_FIELD_BYTES);
            } else {
                try {
                    new AdvertiseCallbackWrapper(callback, advertiseData, scanResponse, settings, this.mBluetoothManager.getBluetoothGatt()).startRegisteration();
                } catch (RemoteException e) {
                    Log.e(TAG, "Failed to get Bluetooth gatt - ", e);
                    postStartFailure(callback, 4);
                }
            }
        }
    }

    public void stopAdvertising(AdvertiseCallback callback) {
        synchronized (this.mLeAdvertisers) {
            BluetoothLeUtils.checkAdapterStateOn(this.mBluetoothAdapter);
            if (callback == null) {
                throw new IllegalArgumentException("callback cannot be null");
            }
            AdvertiseCallbackWrapper wrapper = (AdvertiseCallbackWrapper) this.mLeAdvertisers.get(callback);
            if (wrapper == null) {
                return;
            }
            wrapper.stopAdvertising();
        }
    }

    public void cleanup() {
        this.mLeAdvertisers.clear();
    }

    private int totalBytes(AdvertiseData data, boolean isFlagsIncluded) {
        int size = 0;
        if (data == null) {
            return 0;
        }
        if (isFlagsIncluded) {
            size = FLAGS_FIELD_BYTES;
        }
        if (data.getServiceUuids() != null) {
            int num16BitUuids = 0;
            int num32BitUuids = 0;
            int num128BitUuids = 0;
            for (ParcelUuid uuid : data.getServiceUuids()) {
                if (BluetoothUuid.is16BitUuid(uuid)) {
                    num16BitUuids++;
                } else if (BluetoothUuid.is32BitUuid(uuid)) {
                    num32BitUuids++;
                } else {
                    num128BitUuids++;
                }
            }
            if (num16BitUuids != 0) {
                size += (num16BitUuids * SERVICE_DATA_UUID_LENGTH) + SERVICE_DATA_UUID_LENGTH;
            }
            if (num32BitUuids != 0) {
                size += (num32BitUuids * 4) + SERVICE_DATA_UUID_LENGTH;
            }
            if (num128BitUuids != 0) {
                size += (num128BitUuids * 16) + SERVICE_DATA_UUID_LENGTH;
            }
        }
        for (ParcelUuid uuid2 : data.getServiceData().keySet()) {
            size += byteLength((byte[]) data.getServiceData().get(uuid2)) + 4;
        }
        for (int i = 0; i < data.getManufacturerSpecificData().size(); i++) {
            size += byteLength((byte[]) data.getManufacturerSpecificData().valueAt(i)) + 4;
        }
        if (data.getIncludeTxPowerLevel()) {
            size += FLAGS_FIELD_BYTES;
        }
        if (!data.getIncludeDeviceName() || this.mBluetoothAdapter.getName() == null) {
            return size;
        }
        return size + (this.mBluetoothAdapter.getName().length() + SERVICE_DATA_UUID_LENGTH);
    }

    private int byteLength(byte[] array) {
        return array == null ? 0 : array.length;
    }

    private void postStartFailure(AdvertiseCallback callback, int error) {
        this.mHandler.post(new C00781(callback, error));
    }

    private void postStartSuccess(AdvertiseCallback callback, AdvertiseSettings settings) {
        this.mHandler.post(new C00792(callback, settings));
    }
}
