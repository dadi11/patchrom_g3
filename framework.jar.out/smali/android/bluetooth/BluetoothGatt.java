package android.bluetooth;

import android.content.Context;
import android.net.ProxyInfo;
import android.os.ParcelUuid;
import android.os.RemoteException;
import android.util.Log;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public final class BluetoothGatt implements BluetoothProfile {
    static final int AUTHENTICATION_MITM = 2;
    static final int AUTHENTICATION_NONE = 0;
    static final int AUTHENTICATION_NO_MITM = 1;
    public static final int CONNECTION_PRIORITY_BALANCED = 0;
    public static final int CONNECTION_PRIORITY_HIGH = 1;
    public static final int CONNECTION_PRIORITY_LOW_POWER = 2;
    private static final int CONN_STATE_CLOSED = 4;
    private static final int CONN_STATE_CONNECTED = 2;
    private static final int CONN_STATE_CONNECTING = 1;
    private static final int CONN_STATE_DISCONNECTING = 3;
    private static final int CONN_STATE_IDLE = 0;
    private static final boolean DBG = true;
    public static final int GATT_CONNECTION_CONGESTED = 143;
    public static final int GATT_FAILURE = 257;
    public static final int GATT_INSUFFICIENT_AUTHENTICATION = 5;
    public static final int GATT_INSUFFICIENT_ENCRYPTION = 15;
    public static final int GATT_INVALID_ATTRIBUTE_LENGTH = 13;
    public static final int GATT_INVALID_OFFSET = 7;
    public static final int GATT_READ_NOT_PERMITTED = 2;
    public static final int GATT_REQUEST_NOT_SUPPORTED = 6;
    public static final int GATT_SUCCESS = 0;
    public static final int GATT_WRITE_NOT_PERMITTED = 3;
    private static final String TAG = "BluetoothGatt";
    private static final boolean VDBG = false;
    private boolean mAuthRetry;
    private boolean mAutoConnect;
    private final IBluetoothGattCallback mBluetoothGattCallback;
    private BluetoothGattCallback mCallback;
    private int mClientIf;
    private int mConnState;
    private final Context mContext;
    private BluetoothDevice mDevice;
    private Boolean mDeviceBusy;
    private IBluetoothGatt mService;
    private List<BluetoothGattService> mServices;
    private final Object mStateLock;
    private int mTransport;

    /* renamed from: android.bluetooth.BluetoothGatt.1 */
    class C00461 extends BluetoothGattCallbackWrapper {
        C00461() {
        }

        public void onClientRegistered(int status, int clientIf) {
            boolean z = false;
            Log.d(BluetoothGatt.TAG, "onClientRegistered() - status=" + status + " clientIf=" + clientIf);
            BluetoothGatt.this.mClientIf = clientIf;
            if (status != 0) {
                BluetoothGatt.this.mCallback.onConnectionStateChange(BluetoothGatt.this, BluetoothGatt.GATT_FAILURE, BluetoothGatt.GATT_SUCCESS);
                synchronized (BluetoothGatt.this.mStateLock) {
                    BluetoothGatt.this.mConnState = BluetoothGatt.GATT_SUCCESS;
                }
                return;
            }
            try {
                IBluetoothGatt access$700 = BluetoothGatt.this.mService;
                int access$000 = BluetoothGatt.this.mClientIf;
                String address = BluetoothGatt.this.mDevice.getAddress();
                if (!BluetoothGatt.this.mAutoConnect) {
                    z = BluetoothGatt.DBG;
                }
                access$700.clientConnect(access$000, address, z, BluetoothGatt.this.mTransport);
            } catch (RemoteException e) {
                Log.e(BluetoothGatt.TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            }
        }

        public void onClientConnectionState(int status, int clientIf, boolean connected, String address) {
            int profileState = BluetoothGatt.GATT_READ_NOT_PERMITTED;
            Log.d(BluetoothGatt.TAG, "onClientConnectionState() - status=" + status + " clientIf=" + clientIf + " device=" + address);
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                if (!connected) {
                    profileState = BluetoothGatt.GATT_SUCCESS;
                }
                try {
                    BluetoothGatt.this.mCallback.onConnectionStateChange(BluetoothGatt.this, status, profileState);
                } catch (Exception ex) {
                    Log.w(BluetoothGatt.TAG, "Unhandled exception in callback", ex);
                }
                synchronized (BluetoothGatt.this.mStateLock) {
                    if (connected) {
                        BluetoothGatt.this.mConnState = BluetoothGatt.GATT_READ_NOT_PERMITTED;
                    } else {
                        BluetoothGatt.this.mConnState = BluetoothGatt.GATT_SUCCESS;
                    }
                }
                synchronized (BluetoothGatt.this.mDeviceBusy) {
                    BluetoothGatt.this.mDeviceBusy = Boolean.valueOf(false);
                }
            }
        }

        public void onGetService(String address, int srvcType, int srvcInstId, ParcelUuid srvcUuid) {
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                BluetoothGatt.this.mServices.add(new BluetoothGattService(BluetoothGatt.this.mDevice, srvcUuid.getUuid(), srvcInstId, srvcType));
            }
        }

        public void onGetIncludedService(String address, int srvcType, int srvcInstId, ParcelUuid srvcUuid, int inclSrvcType, int inclSrvcInstId, ParcelUuid inclSrvcUuid) {
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                BluetoothGattService service = BluetoothGatt.this.getService(BluetoothGatt.this.mDevice, srvcUuid.getUuid(), srvcInstId, srvcType);
                BluetoothGattService includedService = BluetoothGatt.this.getService(BluetoothGatt.this.mDevice, inclSrvcUuid.getUuid(), inclSrvcInstId, inclSrvcType);
                if (service != null && includedService != null) {
                    service.addIncludedService(includedService);
                }
            }
        }

        public void onGetCharacteristic(String address, int srvcType, int srvcInstId, ParcelUuid srvcUuid, int charInstId, ParcelUuid charUuid, int charProps) {
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                BluetoothGattService service = BluetoothGatt.this.getService(BluetoothGatt.this.mDevice, srvcUuid.getUuid(), srvcInstId, srvcType);
                if (service != null) {
                    service.addCharacteristic(new BluetoothGattCharacteristic(service, charUuid.getUuid(), charInstId, charProps, BluetoothGatt.GATT_SUCCESS));
                }
            }
        }

        public void onGetDescriptor(String address, int srvcType, int srvcInstId, ParcelUuid srvcUuid, int charInstId, ParcelUuid charUuid, int descrInstId, ParcelUuid descUuid) {
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                BluetoothGattService service = BluetoothGatt.this.getService(BluetoothGatt.this.mDevice, srvcUuid.getUuid(), srvcInstId, srvcType);
                if (service != null) {
                    BluetoothGattCharacteristic characteristic = service.getCharacteristic(charUuid.getUuid(), charInstId);
                    if (characteristic != null) {
                        characteristic.addDescriptor(new BluetoothGattDescriptor(characteristic, descUuid.getUuid(), descrInstId, BluetoothGatt.GATT_SUCCESS));
                    }
                }
            }
        }

        public void onSearchComplete(String address, int status) {
            Log.d(BluetoothGatt.TAG, "onSearchComplete() = Device=" + address + " Status=" + status);
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                try {
                    BluetoothGatt.this.mCallback.onServicesDiscovered(BluetoothGatt.this, status);
                } catch (Exception ex) {
                    Log.w(BluetoothGatt.TAG, "Unhandled exception in callback", ex);
                }
            }
        }

        public void onCharacteristicRead(String address, int status, int srvcType, int srvcInstId, ParcelUuid srvcUuid, int charInstId, ParcelUuid charUuid, byte[] value) {
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                synchronized (BluetoothGatt.this.mDeviceBusy) {
                    BluetoothGatt.this.mDeviceBusy = Boolean.valueOf(false);
                }
                if ((status == BluetoothGatt.GATT_INSUFFICIENT_AUTHENTICATION || status == BluetoothGatt.GATT_INSUFFICIENT_ENCRYPTION) && !BluetoothGatt.this.mAuthRetry) {
                    try {
                        BluetoothGatt.this.mAuthRetry = BluetoothGatt.DBG;
                        BluetoothGatt.this.mService.readCharacteristic(BluetoothGatt.this.mClientIf, address, srvcType, srvcInstId, srvcUuid, charInstId, charUuid, BluetoothGatt.GATT_READ_NOT_PERMITTED);
                        return;
                    } catch (RemoteException e) {
                        Log.e(BluetoothGatt.TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                    }
                }
                BluetoothGatt.this.mAuthRetry = false;
                BluetoothGattService service = BluetoothGatt.this.getService(BluetoothGatt.this.mDevice, srvcUuid.getUuid(), srvcInstId, srvcType);
                if (service != null) {
                    BluetoothGattCharacteristic characteristic = service.getCharacteristic(charUuid.getUuid(), charInstId);
                    if (characteristic != null) {
                        if (status == 0) {
                            characteristic.setValue(value);
                        }
                        try {
                            BluetoothGatt.this.mCallback.onCharacteristicRead(BluetoothGatt.this, characteristic, status);
                        } catch (Exception ex) {
                            Log.w(BluetoothGatt.TAG, "Unhandled exception in callback", ex);
                        }
                    }
                }
            }
        }

        public void onCharacteristicWrite(String address, int status, int srvcType, int srvcInstId, ParcelUuid srvcUuid, int charInstId, ParcelUuid charUuid) {
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                synchronized (BluetoothGatt.this.mDeviceBusy) {
                    BluetoothGatt.this.mDeviceBusy = Boolean.valueOf(false);
                }
                BluetoothGattService service = BluetoothGatt.this.getService(BluetoothGatt.this.mDevice, srvcUuid.getUuid(), srvcInstId, srvcType);
                if (service != null) {
                    BluetoothGattCharacteristic characteristic = service.getCharacteristic(charUuid.getUuid(), charInstId);
                    if (characteristic != null) {
                        if ((status == BluetoothGatt.GATT_INSUFFICIENT_AUTHENTICATION || status == BluetoothGatt.GATT_INSUFFICIENT_ENCRYPTION) && !BluetoothGatt.this.mAuthRetry) {
                            try {
                                BluetoothGatt.this.mAuthRetry = BluetoothGatt.DBG;
                                BluetoothGatt.this.mService.writeCharacteristic(BluetoothGatt.this.mClientIf, address, srvcType, srvcInstId, srvcUuid, charInstId, charUuid, characteristic.getWriteType(), BluetoothGatt.GATT_READ_NOT_PERMITTED, characteristic.getValue());
                                return;
                            } catch (RemoteException e) {
                                Log.e(BluetoothGatt.TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                            }
                        }
                        BluetoothGatt.this.mAuthRetry = false;
                        try {
                            BluetoothGatt.this.mCallback.onCharacteristicWrite(BluetoothGatt.this, characteristic, status);
                        } catch (Exception ex) {
                            Log.w(BluetoothGatt.TAG, "Unhandled exception in callback", ex);
                        }
                    }
                }
            }
        }

        public void onNotify(String address, int srvcType, int srvcInstId, ParcelUuid srvcUuid, int charInstId, ParcelUuid charUuid, byte[] value) {
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                BluetoothGattService service = BluetoothGatt.this.getService(BluetoothGatt.this.mDevice, srvcUuid.getUuid(), srvcInstId, srvcType);
                if (service != null) {
                    BluetoothGattCharacteristic characteristic = service.getCharacteristic(charUuid.getUuid(), charInstId);
                    if (characteristic != null) {
                        characteristic.setValue(value);
                        try {
                            BluetoothGatt.this.mCallback.onCharacteristicChanged(BluetoothGatt.this, characteristic);
                        } catch (Exception ex) {
                            Log.w(BluetoothGatt.TAG, "Unhandled exception in callback", ex);
                        }
                    }
                }
            }
        }

        public void onDescriptorRead(String address, int status, int srvcType, int srvcInstId, ParcelUuid srvcUuid, int charInstId, ParcelUuid charUuid, int descrInstId, ParcelUuid descrUuid, byte[] value) {
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                synchronized (BluetoothGatt.this.mDeviceBusy) {
                    BluetoothGatt.this.mDeviceBusy = Boolean.valueOf(false);
                }
                BluetoothGattService service = BluetoothGatt.this.getService(BluetoothGatt.this.mDevice, srvcUuid.getUuid(), srvcInstId, srvcType);
                if (service != null) {
                    BluetoothGattCharacteristic characteristic = service.getCharacteristic(charUuid.getUuid(), charInstId);
                    if (characteristic != null) {
                        BluetoothGattDescriptor descriptor = characteristic.getDescriptor(descrUuid.getUuid(), descrInstId);
                        if (descriptor != null) {
                            if (status == 0) {
                                descriptor.setValue(value);
                            }
                            if ((status == BluetoothGatt.GATT_INSUFFICIENT_AUTHENTICATION || status == BluetoothGatt.GATT_INSUFFICIENT_ENCRYPTION) && !BluetoothGatt.this.mAuthRetry) {
                                try {
                                    BluetoothGatt.this.mAuthRetry = BluetoothGatt.DBG;
                                    BluetoothGatt.this.mService.readDescriptor(BluetoothGatt.this.mClientIf, address, srvcType, srvcInstId, srvcUuid, charInstId, charUuid, descrInstId, descrUuid, BluetoothGatt.GATT_READ_NOT_PERMITTED);
                                    return;
                                } catch (RemoteException e) {
                                    Log.e(BluetoothGatt.TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                                }
                            }
                            BluetoothGatt.this.mAuthRetry = BluetoothGatt.DBG;
                            try {
                                BluetoothGatt.this.mCallback.onDescriptorRead(BluetoothGatt.this, descriptor, status);
                            } catch (Throwable ex) {
                                Log.w(BluetoothGatt.TAG, "Unhandled exception in callback", ex);
                            }
                        }
                    }
                }
            }
        }

        public void onDescriptorWrite(String address, int status, int srvcType, int srvcInstId, ParcelUuid srvcUuid, int charInstId, ParcelUuid charUuid, int descrInstId, ParcelUuid descrUuid) {
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                synchronized (BluetoothGatt.this.mDeviceBusy) {
                    BluetoothGatt.this.mDeviceBusy = Boolean.valueOf(false);
                }
                BluetoothGattService service = BluetoothGatt.this.getService(BluetoothGatt.this.mDevice, srvcUuid.getUuid(), srvcInstId, srvcType);
                if (service != null) {
                    BluetoothGattCharacteristic characteristic = service.getCharacteristic(charUuid.getUuid(), charInstId);
                    if (characteristic != null) {
                        BluetoothGattDescriptor descriptor = characteristic.getDescriptor(descrUuid.getUuid(), descrInstId);
                        if (descriptor != null) {
                            if ((status == BluetoothGatt.GATT_INSUFFICIENT_AUTHENTICATION || status == BluetoothGatt.GATT_INSUFFICIENT_ENCRYPTION) && !BluetoothGatt.this.mAuthRetry) {
                                try {
                                    BluetoothGatt.this.mAuthRetry = BluetoothGatt.DBG;
                                    BluetoothGatt.this.mService.writeDescriptor(BluetoothGatt.this.mClientIf, address, srvcType, srvcInstId, srvcUuid, charInstId, charUuid, descrInstId, descrUuid, characteristic.getWriteType(), BluetoothGatt.GATT_READ_NOT_PERMITTED, descriptor.getValue());
                                    return;
                                } catch (Throwable e) {
                                    Log.e(BluetoothGatt.TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                                }
                            }
                            BluetoothGatt.this.mAuthRetry = false;
                            try {
                                BluetoothGatt.this.mCallback.onDescriptorWrite(BluetoothGatt.this, descriptor, status);
                            } catch (Throwable ex) {
                                Log.w(BluetoothGatt.TAG, "Unhandled exception in callback", ex);
                            }
                        }
                    }
                }
            }
        }

        public void onExecuteWrite(String address, int status) {
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                synchronized (BluetoothGatt.this.mDeviceBusy) {
                    BluetoothGatt.this.mDeviceBusy = Boolean.valueOf(false);
                }
                try {
                    BluetoothGatt.this.mCallback.onReliableWriteCompleted(BluetoothGatt.this, status);
                } catch (Exception ex) {
                    Log.w(BluetoothGatt.TAG, "Unhandled exception in callback", ex);
                }
            }
        }

        public void onReadRemoteRssi(String address, int rssi, int status) {
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                try {
                    BluetoothGatt.this.mCallback.onReadRemoteRssi(BluetoothGatt.this, rssi, status);
                } catch (Exception ex) {
                    Log.w(BluetoothGatt.TAG, "Unhandled exception in callback", ex);
                }
            }
        }

        public void onConfigureMTU(String address, int mtu, int status) {
            Log.d(BluetoothGatt.TAG, "onConfigureMTU() - Device=" + address + " mtu=" + mtu + " status=" + status);
            if (address.equals(BluetoothGatt.this.mDevice.getAddress())) {
                try {
                    BluetoothGatt.this.mCallback.onMtuChanged(BluetoothGatt.this, mtu, status);
                } catch (Exception ex) {
                    Log.w(BluetoothGatt.TAG, "Unhandled exception in callback", ex);
                }
            }
        }
    }

    BluetoothGatt(Context context, IBluetoothGatt iGatt, BluetoothDevice device, int transport) {
        this.mAuthRetry = false;
        this.mStateLock = new Object();
        this.mDeviceBusy = Boolean.valueOf(false);
        this.mBluetoothGattCallback = new C00461();
        this.mContext = context;
        this.mService = iGatt;
        this.mDevice = device;
        this.mTransport = transport;
        this.mServices = new ArrayList();
        this.mConnState = GATT_SUCCESS;
    }

    public void close() {
        Log.d(TAG, "close()");
        if (BluetoothAdapter.getDefaultAdapter().getState() == 12) {
            unregisterApp();
            this.mConnState = CONN_STATE_CLOSED;
        }
    }

    BluetoothGattService getService(BluetoothDevice device, UUID uuid, int instanceId, int type) {
        for (BluetoothGattService svc : this.mServices) {
            if (svc.getDevice().equals(device) && svc.getType() == type && svc.getInstanceId() == instanceId && svc.getUuid().equals(uuid)) {
                return svc;
            }
        }
        return null;
    }

    private boolean registerApp(BluetoothGattCallback callback) {
        Log.d(TAG, "registerApp()");
        if (this.mService == null) {
            return false;
        }
        this.mCallback = callback;
        UUID uuid = UUID.randomUUID();
        Log.d(TAG, "registerApp() - UUID=" + uuid);
        try {
            this.mService.registerClient(new ParcelUuid(uuid), this.mBluetoothGattCallback);
            return DBG;
        } catch (RemoteException e) {
            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            return false;
        }
    }

    private void unregisterApp() {
        Log.d(TAG, "unregisterApp() - mClientIf=" + this.mClientIf);
        if (this.mService != null && this.mClientIf != 0) {
            try {
                this.mCallback = null;
                this.mService.unregisterClient(this.mClientIf);
                this.mClientIf = GATT_SUCCESS;
            } catch (RemoteException e) {
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            }
        }
    }

    boolean connect(Boolean autoConnect, BluetoothGattCallback callback) {
        Log.d(TAG, "connect() - device: " + this.mDevice.getAddress() + ", auto: " + autoConnect);
        synchronized (this.mStateLock) {
            if (this.mConnState != 0) {
                throw new IllegalStateException("Not idle");
            }
            this.mConnState = CONN_STATE_CONNECTING;
        }
        if (registerApp(callback)) {
            this.mAutoConnect = autoConnect.booleanValue();
            return DBG;
        }
        synchronized (this.mStateLock) {
            this.mConnState = GATT_SUCCESS;
        }
        Log.e(TAG, "Failed to register callback");
        return false;
    }

    public void disconnect() {
        Log.d(TAG, "cancelOpen() - device: " + this.mDevice.getAddress());
        if (this.mService != null && this.mClientIf != 0 && BluetoothAdapter.getDefaultAdapter().getState() == 12) {
            try {
                this.mService.clientDisconnect(this.mClientIf, this.mDevice.getAddress());
            } catch (RemoteException e) {
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            }
        }
    }

    public boolean connect() {
        try {
            this.mService.clientConnect(this.mClientIf, this.mDevice.getAddress(), false, this.mTransport);
            return DBG;
        } catch (RemoteException e) {
            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            return false;
        }
    }

    public BluetoothDevice getDevice() {
        return this.mDevice;
    }

    public boolean discoverServices() {
        Log.d(TAG, "discoverServices() - device: " + this.mDevice.getAddress());
        if (this.mService == null || this.mClientIf == 0) {
            return false;
        }
        this.mServices.clear();
        try {
            this.mService.discoverServices(this.mClientIf, this.mDevice.getAddress());
            return DBG;
        } catch (RemoteException e) {
            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            return false;
        }
    }

    public List<BluetoothGattService> getServices() {
        List<BluetoothGattService> result = new ArrayList();
        for (BluetoothGattService service : this.mServices) {
            if (service.getDevice().equals(this.mDevice)) {
                result.add(service);
            }
        }
        return result;
    }

    public BluetoothGattService getService(UUID uuid) {
        for (BluetoothGattService service : this.mServices) {
            if (service.getDevice().equals(this.mDevice) && service.getUuid().equals(uuid)) {
                return service;
            }
        }
        return null;
    }

    public boolean readCharacteristic(BluetoothGattCharacteristic characteristic) {
        if ((characteristic.getProperties() & GATT_READ_NOT_PERMITTED) == 0) {
            return false;
        }
        if (this.mService == null || this.mClientIf == 0) {
            return false;
        }
        BluetoothGattService service = characteristic.getService();
        if (service == null) {
            return false;
        }
        BluetoothDevice device = service.getDevice();
        if (device == null) {
            return false;
        }
        synchronized (this.mDeviceBusy) {
            if (this.mDeviceBusy.booleanValue()) {
                return false;
            }
            this.mDeviceBusy = Boolean.valueOf(DBG);
            try {
                this.mService.readCharacteristic(this.mClientIf, device.getAddress(), service.getType(), service.getInstanceId(), new ParcelUuid(service.getUuid()), characteristic.getInstanceId(), new ParcelUuid(characteristic.getUuid()), GATT_SUCCESS);
                return DBG;
            } catch (RemoteException e) {
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                this.mDeviceBusy = Boolean.valueOf(false);
                return false;
            }
        }
    }

    public boolean writeCharacteristic(BluetoothGattCharacteristic characteristic) {
        if ((characteristic.getProperties() & 8) == 0 && (characteristic.getProperties() & CONN_STATE_CLOSED) == 0) {
            return false;
        }
        if (this.mService == null || this.mClientIf == 0 || characteristic.getValue() == null) {
            return false;
        }
        BluetoothGattService service = characteristic.getService();
        if (service == null) {
            return false;
        }
        BluetoothDevice device = service.getDevice();
        if (device == null) {
            return false;
        }
        synchronized (this.mDeviceBusy) {
            if (this.mDeviceBusy.booleanValue()) {
                return false;
            }
            this.mDeviceBusy = Boolean.valueOf(DBG);
            try {
                this.mService.writeCharacteristic(this.mClientIf, device.getAddress(), service.getType(), service.getInstanceId(), new ParcelUuid(service.getUuid()), characteristic.getInstanceId(), new ParcelUuid(characteristic.getUuid()), characteristic.getWriteType(), GATT_SUCCESS, characteristic.getValue());
                return DBG;
            } catch (RemoteException e) {
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                this.mDeviceBusy = Boolean.valueOf(false);
                return false;
            }
        }
    }

    public boolean readDescriptor(BluetoothGattDescriptor descriptor) {
        if (this.mService == null || this.mClientIf == 0) {
            return false;
        }
        BluetoothGattCharacteristic characteristic = descriptor.getCharacteristic();
        if (characteristic == null) {
            return false;
        }
        BluetoothGattService service = characteristic.getService();
        if (service == null) {
            return false;
        }
        BluetoothDevice device = service.getDevice();
        if (device == null) {
            return false;
        }
        synchronized (this.mDeviceBusy) {
            if (this.mDeviceBusy.booleanValue()) {
                return false;
            }
            this.mDeviceBusy = Boolean.valueOf(DBG);
            try {
                this.mService.readDescriptor(this.mClientIf, device.getAddress(), service.getType(), service.getInstanceId(), new ParcelUuid(service.getUuid()), characteristic.getInstanceId(), new ParcelUuid(characteristic.getUuid()), descriptor.getInstanceId(), new ParcelUuid(descriptor.getUuid()), GATT_SUCCESS);
                return DBG;
            } catch (RemoteException e) {
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                this.mDeviceBusy = Boolean.valueOf(false);
                return false;
            }
        }
    }

    public boolean writeDescriptor(BluetoothGattDescriptor descriptor) {
        if (this.mService == null || this.mClientIf == 0 || descriptor.getValue() == null) {
            return false;
        }
        BluetoothGattCharacteristic characteristic = descriptor.getCharacteristic();
        if (characteristic == null) {
            return false;
        }
        BluetoothGattService service = characteristic.getService();
        if (service == null) {
            return false;
        }
        BluetoothDevice device = service.getDevice();
        if (device == null) {
            return false;
        }
        synchronized (this.mDeviceBusy) {
            if (this.mDeviceBusy.booleanValue()) {
                return false;
            }
            this.mDeviceBusy = Boolean.valueOf(DBG);
            try {
                this.mService.writeDescriptor(this.mClientIf, device.getAddress(), service.getType(), service.getInstanceId(), new ParcelUuid(service.getUuid()), characteristic.getInstanceId(), new ParcelUuid(characteristic.getUuid()), descriptor.getInstanceId(), new ParcelUuid(descriptor.getUuid()), characteristic.getWriteType(), GATT_SUCCESS, descriptor.getValue());
                return DBG;
            } catch (Throwable e) {
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                this.mDeviceBusy = Boolean.valueOf(false);
                return false;
            }
        }
    }

    public boolean beginReliableWrite() {
        if (this.mService == null || this.mClientIf == 0) {
            return false;
        }
        try {
            this.mService.beginReliableWrite(this.mClientIf, this.mDevice.getAddress());
            return DBG;
        } catch (RemoteException e) {
            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            return false;
        }
    }

    public boolean executeReliableWrite() {
        if (this.mService == null || this.mClientIf == 0) {
            return false;
        }
        synchronized (this.mDeviceBusy) {
            if (this.mDeviceBusy.booleanValue()) {
                return false;
            }
            this.mDeviceBusy = Boolean.valueOf(DBG);
            try {
                this.mService.endReliableWrite(this.mClientIf, this.mDevice.getAddress(), DBG);
                return DBG;
            } catch (RemoteException e) {
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                this.mDeviceBusy = Boolean.valueOf(false);
                return false;
            }
        }
    }

    public void abortReliableWrite() {
        if (this.mService != null && this.mClientIf != 0) {
            try {
                this.mService.endReliableWrite(this.mClientIf, this.mDevice.getAddress(), false);
            } catch (RemoteException e) {
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            }
        }
    }

    public void abortReliableWrite(BluetoothDevice mDevice) {
        abortReliableWrite();
    }

    public boolean setCharacteristicNotification(BluetoothGattCharacteristic characteristic, boolean enable) {
        Log.d(TAG, "setCharacteristicNotification() - uuid: " + characteristic.getUuid() + " enable: " + enable);
        if (this.mService == null || this.mClientIf == 0) {
            return false;
        }
        BluetoothGattService service = characteristic.getService();
        if (service == null) {
            return false;
        }
        BluetoothDevice device = service.getDevice();
        if (device == null) {
            return false;
        }
        try {
            this.mService.registerForNotification(this.mClientIf, device.getAddress(), service.getType(), service.getInstanceId(), new ParcelUuid(service.getUuid()), characteristic.getInstanceId(), new ParcelUuid(characteristic.getUuid()), enable);
            return DBG;
        } catch (RemoteException e) {
            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            return false;
        }
    }

    public boolean refresh() {
        Log.d(TAG, "refresh() - device: " + this.mDevice.getAddress());
        if (this.mService == null || this.mClientIf == 0) {
            return false;
        }
        try {
            this.mService.refreshDevice(this.mClientIf, this.mDevice.getAddress());
            return DBG;
        } catch (RemoteException e) {
            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            return false;
        }
    }

    public boolean readRemoteRssi() {
        Log.d(TAG, "readRssi() - device: " + this.mDevice.getAddress());
        if (this.mService == null || this.mClientIf == 0) {
            return false;
        }
        try {
            this.mService.readRemoteRssi(this.mClientIf, this.mDevice.getAddress());
            return DBG;
        } catch (RemoteException e) {
            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            return false;
        }
    }

    public boolean requestMtu(int mtu) {
        Log.d(TAG, "configureMTU() - device: " + this.mDevice.getAddress() + " mtu: " + mtu);
        if (this.mService == null || this.mClientIf == 0) {
            return false;
        }
        try {
            this.mService.configureMTU(this.mClientIf, this.mDevice.getAddress(), mtu);
            return DBG;
        } catch (RemoteException e) {
            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            return false;
        }
    }

    public boolean requestConnectionPriority(int connectionPriority) {
        if (connectionPriority < 0 || connectionPriority > GATT_READ_NOT_PERMITTED) {
            throw new IllegalArgumentException("connectionPriority not within valid range");
        }
        Log.d(TAG, "requestConnectionPriority() - params: " + connectionPriority);
        if (this.mService == null || this.mClientIf == 0) {
            return false;
        }
        try {
            this.mService.connectionParameterUpdate(this.mClientIf, this.mDevice.getAddress(), connectionPriority);
            return DBG;
        } catch (RemoteException e) {
            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            return false;
        }
    }

    public int getConnectionState(BluetoothDevice device) {
        throw new UnsupportedOperationException("Use BluetoothManager#getConnectionState instead.");
    }

    public List<BluetoothDevice> getConnectedDevices() {
        throw new UnsupportedOperationException("Use BluetoothManager#getConnectedDevices instead.");
    }

    public List<BluetoothDevice> getDevicesMatchingConnectionStates(int[] states) {
        throw new UnsupportedOperationException("Use BluetoothManager#getDevicesMatchingConnectionStates instead.");
    }
}
