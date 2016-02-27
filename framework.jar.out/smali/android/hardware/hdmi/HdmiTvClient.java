package android.hardware.hdmi;

import android.hardware.hdmi.HdmiRecordListener.TimerStatusData;
import android.hardware.hdmi.HdmiRecordSources.RecordSource;
import android.hardware.hdmi.HdmiTimerRecordSources.TimerRecordSource;
import android.hardware.hdmi.IHdmiControlCallback.Stub;
import android.os.RemoteException;
import android.util.Log;
import android.widget.Toast;
import java.util.Collections;
import java.util.List;
import libcore.util.EmptyArray;

public final class HdmiTvClient extends HdmiClient {
    private static final String TAG = "HdmiTvClient";
    public static final int VENDOR_DATA_SIZE = 16;

    /* renamed from: android.hardware.hdmi.HdmiTvClient.1 */
    static class C02901 extends Stub {
        final /* synthetic */ SelectCallback val$callback;

        C02901(SelectCallback selectCallback) {
            this.val$callback = selectCallback;
        }

        public void onComplete(int result) {
            this.val$callback.onComplete(result);
        }
    }

    /* renamed from: android.hardware.hdmi.HdmiTvClient.2 */
    static class C02912 extends IHdmiInputChangeListener.Stub {
        final /* synthetic */ InputChangeListener val$listener;

        C02912(InputChangeListener inputChangeListener) {
            this.val$listener = inputChangeListener;
        }

        public void onChanged(HdmiDeviceInfo info) {
            this.val$listener.onChanged(info);
        }
    }

    /* renamed from: android.hardware.hdmi.HdmiTvClient.3 */
    static class C02923 extends IHdmiRecordListener.Stub {
        final /* synthetic */ HdmiRecordListener val$callback;

        C02923(HdmiRecordListener hdmiRecordListener) {
            this.val$callback = hdmiRecordListener;
        }

        public byte[] getOneTouchRecordSource(int recorderAddress) {
            RecordSource source = this.val$callback.onOneTouchRecordSourceRequested(recorderAddress);
            if (source == null) {
                return EmptyArray.BYTE;
            }
            byte[] data = new byte[source.getDataSize(true)];
            source.toByteArray(true, data, 0);
            return data;
        }

        public void onOneTouchRecordResult(int recorderAddress, int result) {
            this.val$callback.onOneTouchRecordResult(recorderAddress, result);
        }

        public void onTimerRecordingResult(int recorderAddress, int result) {
            this.val$callback.onTimerRecordingResult(recorderAddress, TimerStatusData.parseFrom(result));
        }

        public void onClearTimerRecordingResult(int recorderAddress, int result) {
            this.val$callback.onClearTimerRecordingResult(recorderAddress, result);
        }
    }

    /* renamed from: android.hardware.hdmi.HdmiTvClient.4 */
    class C02934 extends IHdmiMhlVendorCommandListener.Stub {
        final /* synthetic */ HdmiMhlVendorCommandListener val$listener;

        C02934(HdmiMhlVendorCommandListener hdmiMhlVendorCommandListener) {
            this.val$listener = hdmiMhlVendorCommandListener;
        }

        public void onReceived(int portId, int offset, int length, byte[] data) {
            this.val$listener.onReceived(portId, offset, length, data);
        }
    }

    public interface HdmiMhlVendorCommandListener {
        void onReceived(int i, int i2, int i3, byte[] bArr);
    }

    public interface InputChangeListener {
        void onChanged(HdmiDeviceInfo hdmiDeviceInfo);
    }

    public interface SelectCallback {
        void onComplete(int i);
    }

    HdmiTvClient(IHdmiControlService service) {
        super(service);
    }

    static HdmiTvClient create(IHdmiControlService service) {
        return new HdmiTvClient(service);
    }

    public int getDeviceType() {
        return 0;
    }

    public void deviceSelect(int logicalAddress, SelectCallback callback) {
        if (callback == null) {
            throw new IllegalArgumentException("callback must not be null.");
        }
        try {
            this.mService.deviceSelect(logicalAddress, getCallbackWrapper(callback));
        } catch (RemoteException e) {
            Log.e(TAG, "failed to select device: ", e);
        }
    }

    private static IHdmiControlCallback getCallbackWrapper(SelectCallback callback) {
        return new C02901(callback);
    }

    public void portSelect(int portId, SelectCallback callback) {
        if (callback == null) {
            throw new IllegalArgumentException("Callback must not be null");
        }
        try {
            this.mService.portSelect(portId, getCallbackWrapper(callback));
        } catch (RemoteException e) {
            Log.e(TAG, "failed to select port: ", e);
        }
    }

    public void setInputChangeListener(InputChangeListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null.");
        }
        try {
            this.mService.setInputChangeListener(getListenerWrapper(listener));
        } catch (RemoteException e) {
            Log.e("TAG", "Failed to set InputChangeListener:", e);
        }
    }

    private static IHdmiInputChangeListener getListenerWrapper(InputChangeListener listener) {
        return new C02912(listener);
    }

    public List<HdmiDeviceInfo> getDeviceList() {
        try {
            return this.mService.getDeviceList();
        } catch (RemoteException e) {
            Log.e("TAG", "Failed to call getDeviceList():", e);
            return Collections.emptyList();
        }
    }

    public void setSystemAudioVolume(int oldIndex, int newIndex, int maxIndex) {
        try {
            this.mService.setSystemAudioVolume(oldIndex, newIndex, maxIndex);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to set volume: ", e);
        }
    }

    public void setSystemAudioMute(boolean mute) {
        try {
            this.mService.setSystemAudioMute(mute);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to set mute: ", e);
        }
    }

    public void setRecordListener(HdmiRecordListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null.");
        }
        try {
            this.mService.setHdmiRecordListener(getListenerWrapper(listener));
        } catch (RemoteException e) {
            Log.e(TAG, "failed to set record listener.", e);
        }
    }

    private static IHdmiRecordListener getListenerWrapper(HdmiRecordListener callback) {
        return new C02923(callback);
    }

    public void startOneTouchRecord(int recorderAddress, RecordSource source) {
        if (source == null) {
            throw new IllegalArgumentException("source must not be null.");
        }
        try {
            byte[] data = new byte[source.getDataSize(true)];
            source.toByteArray(true, data, 0);
            this.mService.startOneTouchRecord(recorderAddress, data);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to start record: ", e);
        }
    }

    public void stopOneTouchRecord(int recorderAddress) {
        try {
            this.mService.stopOneTouchRecord(recorderAddress);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to stop record: ", e);
        }
    }

    public void startTimerRecording(int recorderAddress, int sourceType, TimerRecordSource source) {
        if (source == null) {
            throw new IllegalArgumentException("source must not be null.");
        }
        checkTimerRecordingSourceType(sourceType);
        try {
            byte[] data = new byte[source.getDataSize()];
            source.toByteArray(data, 0);
            this.mService.startTimerRecording(recorderAddress, sourceType, data);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to start record: ", e);
        }
    }

    private void checkTimerRecordingSourceType(int sourceType) {
        switch (sourceType) {
            case Toast.LENGTH_LONG /*1*/:
            case Action.MERGE_IGNORE /*2*/:
            case SetDrawableParameters.TAG /*3*/:
            default:
                throw new IllegalArgumentException("Invalid source type:" + sourceType);
        }
    }

    public void clearTimerRecording(int recorderAddress, int sourceType, TimerRecordSource source) {
        if (source == null) {
            throw new IllegalArgumentException("source must not be null.");
        }
        checkTimerRecordingSourceType(sourceType);
        try {
            byte[] data = new byte[source.getDataSize()];
            source.toByteArray(data, 0);
            this.mService.clearTimerRecording(recorderAddress, sourceType, data);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to start record: ", e);
        }
    }

    public void setHdmiMhlVendorCommandListener(HdmiMhlVendorCommandListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null.");
        }
        try {
            this.mService.addHdmiMhlVendorCommandListener(getListenerWrapper(listener));
        } catch (RemoteException e) {
            Log.e(TAG, "failed to set hdmi mhl vendor command listener: ", e);
        }
    }

    private IHdmiMhlVendorCommandListener getListenerWrapper(HdmiMhlVendorCommandListener listener) {
        return new C02934(listener);
    }

    public void sendMhlVendorCommand(int portId, int offset, int length, byte[] data) {
        if (data == null || data.length != VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid vendor command data.");
        } else if (offset < 0 || offset >= VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid offset:" + offset);
        } else if (length < 0 || offset + length > VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid length:" + length);
        } else {
            try {
                this.mService.sendMhlVendorCommand(portId, offset, length, data);
            } catch (RemoteException e) {
                Log.e(TAG, "failed to send vendor command: ", e);
            }
        }
    }
}
