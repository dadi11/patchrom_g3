package com.android.server.usb;

import android.alsa.AlsaCardsParser;
import android.alsa.AlsaDevicesParser;
import android.content.Context;
import android.content.Intent;
import android.hardware.usb.UsbDevice;
import android.os.UserHandle;
import android.util.Slog;
import java.io.File;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.HashMap;

public class UsbAudioManager {
    private static final boolean DEBUG = false;
    private static final String TAG;
    private final HashMap<UsbDevice, AudioDevice> mAudioDevices;
    private final Context mContext;

    private final class AudioDevice {
        public int mCard;
        public int mDevice;
        public boolean mHasCapture;
        public boolean mHasMIDI;
        public boolean mHasPlayback;

        public AudioDevice(int card, int device, boolean hasPlayback, boolean hasCapture, boolean hasMidi) {
            this.mCard = card;
            this.mDevice = device;
            this.mHasPlayback = hasPlayback;
            this.mHasCapture = hasCapture;
            this.mHasMIDI = hasMidi;
        }

        public String toString() {
            StringBuilder sb = new StringBuilder();
            sb.append("AudioDevice: [card: " + this.mCard);
            sb.append(", device: " + this.mDevice);
            sb.append(", hasPlayback: " + this.mHasPlayback);
            sb.append(", hasCapture: " + this.mHasCapture);
            sb.append(", hasMidi: " + this.mHasMIDI);
            sb.append("]");
            return sb.toString();
        }
    }

    static {
        TAG = UsbAudioManager.class.getSimpleName();
    }

    UsbAudioManager(Context context) {
        this.mAudioDevices = new HashMap();
        this.mContext = context;
    }

    private void sendDeviceNotification(AudioDevice audioDevice, boolean enabled) {
        Intent intent = new Intent("android.media.action.USB_AUDIO_DEVICE_PLUG");
        intent.addFlags(536870912);
        intent.addFlags(1073741824);
        intent.putExtra("state", enabled ? 1 : 0);
        intent.putExtra("card", audioDevice.mCard);
        intent.putExtra("device", audioDevice.mDevice);
        intent.putExtra("hasPlayback", audioDevice.mHasPlayback);
        intent.putExtra("hasCapture", audioDevice.mHasCapture);
        intent.putExtra("hasMIDI", audioDevice.mHasMIDI);
        this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    private boolean waitForAlsaFile(int card, int device, boolean capture) {
        File alsaDevFile = new File("/dev/snd/pcmC" + card + "D" + device + (capture ? "c" : "p"));
        boolean exists = false;
        int retry = 0;
        while (!exists && retry < 5) {
            exists = alsaDevFile.exists();
            if (!exists) {
                try {
                    Thread.sleep(500);
                } catch (IllegalThreadStateException e) {
                    Slog.d(TAG, "usb: IllegalThreadStateException while waiting for ALSA file.");
                } catch (InterruptedException e2) {
                    Slog.d(TAG, "usb: InterruptedException while waiting for ALSA file.");
                }
            }
            retry++;
        }
        return exists;
    }

    void deviceAdded(UsbDevice usbDevice) {
        boolean isAudioDevice = false;
        int interfaceCount = usbDevice.getInterfaceCount();
        int ntrfaceIndex = 0;
        while (!isAudioDevice && ntrfaceIndex < interfaceCount) {
            if (usbDevice.getInterface(ntrfaceIndex).getInterfaceClass() == 1) {
                isAudioDevice = true;
            }
            ntrfaceIndex++;
        }
        if (isAudioDevice) {
            AlsaCardsParser cardsParser = new AlsaCardsParser();
            cardsParser.scan();
            AlsaDevicesParser devicesParser = new AlsaDevicesParser();
            devicesParser.scan();
            int card = cardsParser.getNumCardRecords() - 1;
            for (int i = 0; i < cardsParser.getNumCardRecords(); i++) {
                if (cardsParser.getCardRecordAt(i).mCardName.contains("USB-Audio")) {
                    card = i;
                }
            }
            boolean hasPlayback = devicesParser.hasPlaybackDevices(card);
            boolean hasCapture = devicesParser.hasCaptureDevices(card);
            boolean hasMidi = devicesParser.hasMIDIDevices(card);
            if (hasPlayback && !waitForAlsaFile(card, 0, false)) {
                return;
            }
            if (!hasCapture || waitForAlsaFile(card, 0, true)) {
                AudioDevice audioDevice = new AudioDevice(card, 0, hasPlayback, hasCapture, hasMidi);
                this.mAudioDevices.put(usbDevice, audioDevice);
                sendDeviceNotification(audioDevice, true);
            }
        }
    }

    void deviceRemoved(UsbDevice device) {
        AudioDevice audioDevice = (AudioDevice) this.mAudioDevices.remove(device);
        if (audioDevice != null) {
            sendDeviceNotification(audioDevice, false);
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw) {
        pw.println("  USB AudioDevices:");
        for (UsbDevice device : this.mAudioDevices.keySet()) {
            pw.println("    " + device.getDeviceName() + ": " + this.mAudioDevices.get(device));
        }
    }
}
