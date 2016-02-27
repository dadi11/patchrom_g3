package android.bluetooth;

import android.bluetooth.IBluetoothManagerCallback.Stub;
import android.net.ProxyInfo;
import android.os.RemoteException;
import android.util.Log;
import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;

public final class QBluetoothAdapter {
    private static final boolean DBG = false;
    private static final String TAG = "QBluetoothAdapter";
    private static final boolean VDBG = false;
    private static BluetoothAdapter mAdapter;
    private static QBluetoothAdapter sAdapter;
    private final IBluetoothManagerCallback mAdapterServiceCallback;
    private final Map<LeLppCallback, LeLppClientWrapper> mLppClients;
    private final IQBluetoothManagerCallback mManagerCallback;
    private final IBluetoothManager mManagerService;
    private IQBluetooth mQService;
    private IBluetooth mService;

    /* renamed from: android.bluetooth.QBluetoothAdapter.1 */
    class C00741 extends Stub {
        C00741() {
        }

        public void onBluetoothServiceUp(IBluetooth bluetoothService) {
            synchronized (QBluetoothAdapter.this.mAdapterServiceCallback) {
                QBluetoothAdapter.this.mService = bluetoothService;
                Log.i(QBluetoothAdapter.TAG, "onBluetoothServiceUp Adapter ON: mService: " + QBluetoothAdapter.this.mService + " mQService: " + QBluetoothAdapter.this.mQService + " ManagerService:" + QBluetoothAdapter.this.mManagerService);
            }
        }

        public void onBluetoothServiceDown() {
            synchronized (QBluetoothAdapter.this.mAdapterServiceCallback) {
                QBluetoothAdapter.this.mService = null;
                Log.i(QBluetoothAdapter.TAG, "onBluetoothServiceDown Adapter OFF: mService: " + QBluetoothAdapter.this.mService + " mQService: " + QBluetoothAdapter.this.mQService);
            }
        }
    }

    /* renamed from: android.bluetooth.QBluetoothAdapter.2 */
    class C00752 extends IQBluetoothManagerCallback.Stub {
        C00752() {
        }

        public void onQBluetoothServiceUp(IQBluetooth qcbluetoothService) {
            synchronized (QBluetoothAdapter.this.mManagerCallback) {
                QBluetoothAdapter.this.mQService = qcbluetoothService;
                Log.i(QBluetoothAdapter.TAG, "onQBluetoothServiceUp: Adapter ON: mService: " + QBluetoothAdapter.this.mService + " mQService: " + QBluetoothAdapter.this.mQService + " ManagerService:" + QBluetoothAdapter.this.mManagerService);
            }
        }

        public void onQBluetoothServiceDown() {
            synchronized (QBluetoothAdapter.this.mManagerCallback) {
                QBluetoothAdapter.this.mQService = null;
                Log.i(QBluetoothAdapter.TAG, "onQBluetoothServiceDown: Adapter OFF: mService: " + QBluetoothAdapter.this.mService + " mQService: " + QBluetoothAdapter.this.mQService);
            }
        }
    }

    public interface LeLppCallback {
        void onEnableRssiMonitor(int i, int i2);

        void onReadRssiThreshold(int i, int i2, int i3, int i4);

        void onRssiThresholdEvent(int i, int i2);

        boolean onUpdateLease();

        void onWriteRssiThreshold(int i);
    }

    private static class LeLppClientWrapper extends IQBluetoothAdapterCallback.Stub {
        private final LeLppCallback client;
        private final WeakReference<QBluetoothAdapter> mAdapter;
        private final String mDevice;
        private final IQBluetooth mQBluetoothAdapterService;

        public LeLppClientWrapper(QBluetoothAdapter adapter, IQBluetooth adapterService, String address, LeLppCallback callback) {
            this.mAdapter = new WeakReference(adapter);
            this.mQBluetoothAdapterService = adapterService;
            this.mDevice = address;
            this.client = callback;
        }

        public boolean register2(boolean add) {
            if (this.mQBluetoothAdapterService != null) {
                try {
                    return this.mQBluetoothAdapterService.registerLeLppRssiMonitorClient(this.mDevice, this, add);
                } catch (RemoteException e) {
                    Log.w(QBluetoothAdapter.TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                }
            }
            return QBluetoothAdapter.DBG;
        }

        public void writeRssiThreshold(byte min, byte max) {
            if (this.mQBluetoothAdapterService != null) {
                try {
                    this.mQBluetoothAdapterService.writeLeLppRssiThreshold(this.mDevice, min, max);
                } catch (RemoteException e) {
                    Log.w(QBluetoothAdapter.TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                }
            }
        }

        public void enableMonitor(boolean enable) {
            if (this.mQBluetoothAdapterService != null) {
                try {
                    this.mQBluetoothAdapterService.enableLeLppRssiMonitor(this.mDevice, enable);
                } catch (RemoteException e) {
                    Log.w(QBluetoothAdapter.TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                }
            }
        }

        public void readRssiThreshold() {
            if (this.mQBluetoothAdapterService != null) {
                try {
                    this.mQBluetoothAdapterService.readLeLppRssiThreshold(this.mDevice);
                } catch (RemoteException e) {
                    Log.w(QBluetoothAdapter.TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
                }
            }
        }

        public void onWriteRssiThreshold(String address, int status) {
            if (this.client != null) {
                try {
                    this.client.onWriteRssiThreshold(status);
                } catch (Exception ex) {
                    Log.w(QBluetoothAdapter.TAG, "Unhandled exception: " + ex);
                }
            }
        }

        public void onReadRssiThreshold(String address, int low, int upper, int alert, int status) {
            if (this.client != null) {
                try {
                    this.client.onReadRssiThreshold(low, upper, alert, status);
                } catch (Exception ex) {
                    Log.w(QBluetoothAdapter.TAG, "Unhandled exception: " + ex);
                }
            }
        }

        public void onEnableRssiMonitor(String address, int enable, int status) {
            if (this.client != null) {
                try {
                    this.client.onEnableRssiMonitor(enable, status);
                } catch (Exception ex) {
                    Log.w(QBluetoothAdapter.TAG, "Unhandled exception: " + ex);
                }
            }
        }

        public void onRssiThresholdEvent(String address, int evtType, int rssi) {
            if (this.client != null) {
                try {
                    this.client.onRssiThresholdEvent(evtType, rssi);
                } catch (Exception ex) {
                    Log.w(QBluetoothAdapter.TAG, "Unhandled exception: " + ex);
                }
            }
        }

        public boolean onUpdateLease() {
            boolean z = QBluetoothAdapter.DBG;
            if (this.client != null) {
                try {
                    z = this.client.onUpdateLease();
                } catch (Exception ex) {
                    Log.w(QBluetoothAdapter.TAG, "Unhandled exception: " + ex);
                }
            }
            return z;
        }
    }

    public static synchronized QBluetoothAdapter getDefaultAdapter() {
        QBluetoothAdapter qBluetoothAdapter;
        synchronized (QBluetoothAdapter.class) {
            mAdapter = BluetoothAdapter.getDefaultAdapter();
            sAdapter = new QBluetoothAdapter(mAdapter.getBluetoothManager());
            qBluetoothAdapter = sAdapter;
        }
        return qBluetoothAdapter;
    }

    QBluetoothAdapter(IBluetoothManager managerService) {
        this.mLppClients = new HashMap();
        this.mAdapterServiceCallback = new C00741();
        this.mManagerCallback = new C00752();
        if (managerService == null) {
            throw new IllegalArgumentException("bluetooth manager service is null");
        }
        try {
            this.mService = mAdapter.getBluetoothService(this.mAdapterServiceCallback);
            this.mQService = managerService.registerQAdapter(this.mManagerCallback);
            Log.i(TAG, "mQService= :" + this.mQService);
        } catch (RemoteException e) {
            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
        }
        this.mManagerService = managerService;
    }

    public boolean registerLppClient(LeLppCallback client, String address, boolean add) {
        synchronized (this.mLppClients) {
            LeLppClientWrapper wrapper;
            if (!add) {
                wrapper = (LeLppClientWrapper) this.mLppClients.remove(client);
                if (wrapper != null) {
                    wrapper.register2(DBG);
                    return true;
                }
                return DBG;
            } else if (this.mLppClients.containsKey(client)) {
                Log.e(TAG, "Lpp Client has been already registered");
                return DBG;
            } else {
                wrapper = new LeLppClientWrapper(this, this.mQService, address, client);
                if (wrapper == null || !wrapper.register2(true)) {
                    return DBG;
                }
                this.mLppClients.put(client, wrapper);
                return true;
            }
        }
    }

    public boolean writeRssiThreshold(LeLppCallback client, int min, int max) {
        synchronized (this.mLppClients) {
            LeLppClientWrapper wrapper = (LeLppClientWrapper) this.mLppClients.get(client);
        }
        if (wrapper == null) {
            return DBG;
        }
        wrapper.writeRssiThreshold((byte) min, (byte) max);
        return true;
    }

    public boolean enableRssiMonitor(LeLppCallback client, boolean enable) {
        synchronized (this.mLppClients) {
            LeLppClientWrapper wrapper = (LeLppClientWrapper) this.mLppClients.get(client);
        }
        if (wrapper == null) {
            return DBG;
        }
        wrapper.enableMonitor(enable);
        return true;
    }

    public boolean readRssiThreshold(LeLppCallback client) {
        synchronized (this.mLppClients) {
            LeLppClientWrapper wrapper = (LeLppClientWrapper) this.mLppClients.get(client);
        }
        if (wrapper == null) {
            return DBG;
        }
        wrapper.readRssiThreshold();
        return true;
    }

    protected void finalize() throws Throwable {
        try {
            this.mManagerService.unregisterQAdapter(this.mManagerCallback);
        } catch (RemoteException e) {
            Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
        } finally {
            super.finalize();
        }
    }
}
