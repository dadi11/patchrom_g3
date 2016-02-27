package android.nfc.tech;

import android.bluetooth.BluetoothHidDevice;
import android.nfc.Tag;
import android.nfc.TagLostException;
import android.os.RemoteException;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;

public final class MifareClassic extends BasicTagTechnology {
    public static final int BLOCK_SIZE = 16;
    public static final byte[] KEY_DEFAULT;
    public static final byte[] KEY_MIFARE_APPLICATION_DIRECTORY;
    public static final byte[] KEY_NFC_FORUM;
    private static final int MAX_BLOCK_COUNT = 256;
    private static final int MAX_SECTOR_COUNT = 40;
    public static final int SIZE_1K = 1024;
    public static final int SIZE_2K = 2048;
    public static final int SIZE_4K = 4096;
    public static final int SIZE_MINI = 320;
    private static final String TAG = "NFC";
    public static final int TYPE_CLASSIC = 0;
    public static final int TYPE_PLUS = 1;
    public static final int TYPE_PRO = 2;
    public static final int TYPE_UNKNOWN = -1;
    private boolean mIsEmulated;
    private int mSize;
    private int mType;

    public /* bridge */ /* synthetic */ void close() throws IOException {
        super.close();
    }

    public /* bridge */ /* synthetic */ void connect() throws IOException {
        super.connect();
    }

    public /* bridge */ /* synthetic */ Tag getTag() {
        return super.getTag();
    }

    public /* bridge */ /* synthetic */ boolean isConnected() {
        return super.isConnected();
    }

    public /* bridge */ /* synthetic */ void reconnect() throws IOException {
        super.reconnect();
    }

    static {
        KEY_DEFAULT = new byte[]{(byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1, (byte) -1};
        KEY_MIFARE_APPLICATION_DIRECTORY = new byte[]{(byte) -96, (byte) -95, (byte) -94, (byte) -93, (byte) -92, (byte) -91};
        KEY_NFC_FORUM = new byte[]{(byte) -45, (byte) -9, (byte) -45, (byte) -9, (byte) -45, (byte) -9};
    }

    public static MifareClassic get(Tag tag) {
        if (!tag.hasTech(8)) {
            return null;
        }
        try {
            return new MifareClassic(tag);
        } catch (RemoteException e) {
            return null;
        }
    }

    public MifareClassic(Tag tag) throws RemoteException {
        super(tag, 8);
        NfcA a = NfcA.get(tag);
        this.mIsEmulated = false;
        switch (a.getSak()) {
            case TYPE_PLUS /*1*/:
            case SetPendingIntentTemplate.TAG /*8*/:
                this.mType = TYPE_CLASSIC;
                this.mSize = SIZE_1K;
            case SetOnClickFillInIntent.TAG /*9*/:
                this.mType = TYPE_CLASSIC;
                this.mSize = SIZE_MINI;
            case BLOCK_SIZE /*16*/:
                this.mType = TYPE_PLUS;
                this.mSize = SIZE_2K;
            case TextViewDrawableColorFilterAction.TAG /*17*/:
                this.mType = TYPE_PLUS;
                this.mSize = SIZE_4K;
            case MotionEvent.AXIS_DISTANCE /*24*/:
                this.mType = TYPE_CLASSIC;
                this.mSize = SIZE_4K;
            case MAX_SECTOR_COUNT /*40*/:
                this.mType = TYPE_CLASSIC;
                this.mSize = SIZE_1K;
                this.mIsEmulated = true;
            case KeyEvent.KEYCODE_PERIOD /*56*/:
                this.mType = TYPE_CLASSIC;
                this.mSize = SIZE_4K;
                this.mIsEmulated = true;
            case KeyEvent.KEYCODE_F6 /*136*/:
                this.mType = TYPE_CLASSIC;
                this.mSize = SIZE_1K;
            case KeyEvent.KEYCODE_NUMPAD_8 /*152*/:
            case KeyEvent.KEYCODE_PROG_GREEN /*184*/:
                this.mType = TYPE_PRO;
                this.mSize = SIZE_4K;
            default:
                throw new RuntimeException("Tag incorrectly enumerated as MIFARE Classic, SAK = " + a.getSak());
        }
    }

    public int getType() {
        return this.mType;
    }

    public int getSize() {
        return this.mSize;
    }

    public boolean isEmulated() {
        return this.mIsEmulated;
    }

    public int getSectorCount() {
        switch (this.mSize) {
            case SIZE_MINI /*320*/:
                return 5;
            case SIZE_1K /*1024*/:
                return BLOCK_SIZE;
            case SIZE_2K /*2048*/:
                return 32;
            case SIZE_4K /*4096*/:
                return MAX_SECTOR_COUNT;
            default:
                return TYPE_CLASSIC;
        }
    }

    public int getBlockCount() {
        return this.mSize / BLOCK_SIZE;
    }

    public int getBlockCountInSector(int sectorIndex) {
        validateSector(sectorIndex);
        if (sectorIndex < 32) {
            return 4;
        }
        return BLOCK_SIZE;
    }

    public int blockToSector(int blockIndex) {
        validateBlock(blockIndex);
        if (blockIndex < AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS) {
            return blockIndex / 4;
        }
        return ((blockIndex - 128) / BLOCK_SIZE) + 32;
    }

    public int sectorToBlock(int sectorIndex) {
        if (sectorIndex < 32) {
            return sectorIndex * 4;
        }
        return ((sectorIndex - 32) * BLOCK_SIZE) + AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS;
    }

    public boolean authenticateSectorWithKeyA(int sectorIndex, byte[] key) throws IOException {
        return authenticate(sectorIndex, key, true);
    }

    public boolean authenticateSectorWithKeyB(int sectorIndex, byte[] key) throws IOException {
        return authenticate(sectorIndex, key, false);
    }

    private boolean authenticate(int sector, byte[] key, boolean keyA) throws IOException {
        validateSector(sector);
        checkConnected();
        byte[] cmd = new byte[12];
        if (keyA) {
            cmd[TYPE_CLASSIC] = (byte) 96;
        } else {
            cmd[TYPE_CLASSIC] = (byte) 97;
        }
        cmd[TYPE_PLUS] = (byte) sectorToBlock(sector);
        byte[] uid = getTag().getId();
        System.arraycopy(uid, uid.length - 4, cmd, TYPE_PRO, 4);
        System.arraycopy(key, TYPE_CLASSIC, cmd, 6, 6);
        try {
            if (transceive(cmd, false) != null) {
                return true;
            }
        } catch (TagLostException e) {
            throw e;
        } catch (IOException e2) {
        }
        return false;
    }

    public byte[] readBlock(int blockIndex) throws IOException {
        validateBlock(blockIndex);
        checkConnected();
        byte[] cmd = new byte[TYPE_PRO];
        cmd[TYPE_CLASSIC] = (byte) 48;
        cmd[TYPE_PLUS] = (byte) blockIndex;
        return transceive(cmd, false);
    }

    public void writeBlock(int blockIndex, byte[] data) throws IOException {
        validateBlock(blockIndex);
        checkConnected();
        if (data.length != BLOCK_SIZE) {
            throw new IllegalArgumentException("must write 16-bytes");
        }
        byte[] cmd = new byte[(data.length + TYPE_PRO)];
        cmd[TYPE_CLASSIC] = (byte) -96;
        cmd[TYPE_PLUS] = (byte) blockIndex;
        System.arraycopy(data, TYPE_CLASSIC, cmd, TYPE_PRO, data.length);
        transceive(cmd, false);
    }

    public void increment(int blockIndex, int value) throws IOException {
        validateBlock(blockIndex);
        validateValueOperand(value);
        checkConnected();
        ByteBuffer cmd = ByteBuffer.allocate(6);
        cmd.order(ByteOrder.LITTLE_ENDIAN);
        cmd.put((byte) -63);
        cmd.put((byte) blockIndex);
        cmd.putInt(value);
        transceive(cmd.array(), false);
    }

    public void decrement(int blockIndex, int value) throws IOException {
        validateBlock(blockIndex);
        validateValueOperand(value);
        checkConnected();
        ByteBuffer cmd = ByteBuffer.allocate(6);
        cmd.order(ByteOrder.LITTLE_ENDIAN);
        cmd.put(BluetoothHidDevice.SUBCLASS1_COMBO);
        cmd.put((byte) blockIndex);
        cmd.putInt(value);
        transceive(cmd.array(), false);
    }

    public void transfer(int blockIndex) throws IOException {
        validateBlock(blockIndex);
        checkConnected();
        byte[] cmd = new byte[TYPE_PRO];
        cmd[TYPE_CLASSIC] = (byte) -80;
        cmd[TYPE_PLUS] = (byte) blockIndex;
        transceive(cmd, false);
    }

    public void restore(int blockIndex) throws IOException {
        validateBlock(blockIndex);
        checkConnected();
        byte[] cmd = new byte[TYPE_PRO];
        cmd[TYPE_CLASSIC] = (byte) -62;
        cmd[TYPE_PLUS] = (byte) blockIndex;
        transceive(cmd, false);
    }

    public byte[] transceive(byte[] data) throws IOException {
        return transceive(data, true);
    }

    public int getMaxTransceiveLength() {
        return getMaxTransceiveLengthInternal();
    }

    public void setTimeout(int timeout) {
        try {
            if (this.mTag.getTagService().setTimeout(8, timeout) != 0) {
                throw new IllegalArgumentException("The supplied timeout is not valid");
            }
        } catch (RemoteException e) {
            Log.e(TAG, "NFC service dead", e);
        }
    }

    public int getTimeout() {
        try {
            return this.mTag.getTagService().getTimeout(8);
        } catch (RemoteException e) {
            Log.e(TAG, "NFC service dead", e);
            return TYPE_CLASSIC;
        }
    }

    private static void validateSector(int sector) {
        if (sector < 0 || sector >= MAX_SECTOR_COUNT) {
            throw new IndexOutOfBoundsException("sector out of bounds: " + sector);
        }
    }

    private static void validateBlock(int block) {
        if (block < 0 || block >= MAX_BLOCK_COUNT) {
            throw new IndexOutOfBoundsException("block out of bounds: " + block);
        }
    }

    private static void validateValueOperand(int value) {
        if (value < 0) {
            throw new IllegalArgumentException("value operand negative");
        }
    }
}
