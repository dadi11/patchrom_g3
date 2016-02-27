package android.view.inputmethod;

import android.os.Parcel;
import android.util.Slog;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

public class InputMethodSubtypeArray {
    private static final String TAG = "InputMethodSubtypeArray";
    private volatile byte[] mCompressedData;
    private final int mCount;
    private volatile int mDecompressedSize;
    private volatile InputMethodSubtype[] mInstance;
    private final Object mLockObject;

    public InputMethodSubtypeArray(List<InputMethodSubtype> subtypes) {
        this.mLockObject = new Object();
        if (subtypes == null) {
            this.mCount = 0;
            return;
        }
        this.mCount = subtypes.size();
        this.mInstance = (InputMethodSubtype[]) subtypes.toArray(new InputMethodSubtype[this.mCount]);
    }

    public InputMethodSubtypeArray(Parcel source) {
        this.mLockObject = new Object();
        this.mCount = source.readInt();
        if (this.mCount > 0) {
            this.mDecompressedSize = source.readInt();
            this.mCompressedData = source.createByteArray();
        }
    }

    public void writeToParcel(Parcel dest) {
        if (this.mCount == 0) {
            dest.writeInt(this.mCount);
            return;
        }
        byte[] compressedData = this.mCompressedData;
        int decompressedSize = this.mDecompressedSize;
        if (compressedData == null && decompressedSize == 0) {
            synchronized (this.mLockObject) {
                compressedData = this.mCompressedData;
                decompressedSize = this.mDecompressedSize;
                if (compressedData == null && decompressedSize == 0) {
                    byte[] decompressedData = marshall(this.mInstance);
                    compressedData = compress(decompressedData);
                    if (compressedData == null) {
                        decompressedSize = -1;
                        Slog.i(TAG, "Failed to compress data.");
                    } else {
                        decompressedSize = decompressedData.length;
                    }
                    this.mDecompressedSize = decompressedSize;
                    this.mCompressedData = compressedData;
                }
            }
        }
        if (compressedData == null || decompressedSize <= 0) {
            Slog.i(TAG, "Unexpected state. Behaving as an empty array.");
            dest.writeInt(0);
            return;
        }
        dest.writeInt(this.mCount);
        dest.writeInt(decompressedSize);
        dest.writeByteArray(compressedData);
    }

    public InputMethodSubtype get(int index) {
        if (index < 0 || this.mCount <= index) {
            throw new ArrayIndexOutOfBoundsException();
        }
        InputMethodSubtype[] instance = this.mInstance;
        if (instance == null) {
            synchronized (this.mLockObject) {
                instance = this.mInstance;
                if (instance == null) {
                    byte[] decompressedData = decompress(this.mCompressedData, this.mDecompressedSize);
                    this.mCompressedData = null;
                    this.mDecompressedSize = 0;
                    if (decompressedData != null) {
                        instance = unmarshall(decompressedData);
                    } else {
                        Slog.e(TAG, "Failed to decompress data. Returns null as fallback.");
                        instance = new InputMethodSubtype[this.mCount];
                    }
                    this.mInstance = instance;
                }
            }
        }
        return instance[index];
    }

    public int getCount() {
        return this.mCount;
    }

    private static byte[] marshall(InputMethodSubtype[] array) {
        Parcel parcel = null;
        try {
            parcel = Parcel.obtain();
            parcel.writeTypedArray(array, 0);
            byte[] marshall = parcel.marshall();
            return marshall;
        } finally {
            if (parcel != null) {
                parcel.recycle();
            }
        }
    }

    private static InputMethodSubtype[] unmarshall(byte[] data) {
        Parcel parcel = null;
        try {
            parcel = Parcel.obtain();
            parcel.unmarshall(data, 0, data.length);
            parcel.setDataPosition(0);
            InputMethodSubtype[] inputMethodSubtypeArr = (InputMethodSubtype[]) parcel.createTypedArray(InputMethodSubtype.CREATOR);
            return inputMethodSubtypeArr;
        } finally {
            if (parcel != null) {
                parcel.recycle();
            }
        }
    }

    private static byte[] compress(byte[] data) {
        Throwable th;
        ByteArrayOutputStream resultStream = null;
        GZIPOutputStream zipper = null;
        try {
            ByteArrayOutputStream resultStream2 = new ByteArrayOutputStream();
            try {
                GZIPOutputStream zipper2 = new GZIPOutputStream(resultStream2);
                try {
                    zipper2.write(data);
                    if (zipper2 != null) {
                        try {
                            zipper2.close();
                        } catch (IOException e) {
                            Slog.e(TAG, "Failed to close the stream.", e);
                        }
                    }
                    zipper = zipper2;
                    if (resultStream2 != null) {
                        try {
                            resultStream2.close();
                        } catch (IOException e2) {
                            resultStream = null;
                            Slog.e(TAG, "Failed to close the stream.", e2);
                        }
                    }
                    resultStream = resultStream2;
                    if (resultStream != null) {
                        return resultStream.toByteArray();
                    }
                    return null;
                } catch (IOException e3) {
                    zipper = zipper2;
                    resultStream = resultStream2;
                    if (zipper != null) {
                        try {
                            zipper.close();
                        } catch (IOException e22) {
                            Slog.e(TAG, "Failed to close the stream.", e22);
                        }
                    }
                    if (resultStream != null) {
                        return null;
                    }
                    try {
                        resultStream.close();
                        return null;
                    } catch (IOException e222) {
                        Slog.e(TAG, "Failed to close the stream.", e222);
                        return null;
                    }
                } catch (Throwable th2) {
                    th = th2;
                    zipper = zipper2;
                    resultStream = resultStream2;
                    if (zipper != null) {
                        try {
                            zipper.close();
                        } catch (IOException e2222) {
                            Slog.e(TAG, "Failed to close the stream.", e2222);
                        }
                    }
                    if (resultStream != null) {
                        try {
                            resultStream.close();
                        } catch (IOException e22222) {
                            Slog.e(TAG, "Failed to close the stream.", e22222);
                        }
                    }
                    throw th;
                }
            } catch (IOException e4) {
                resultStream = resultStream2;
                if (zipper != null) {
                    zipper.close();
                }
                if (resultStream != null) {
                    return null;
                }
                resultStream.close();
                return null;
            } catch (Throwable th3) {
                th = th3;
                resultStream = resultStream2;
                if (zipper != null) {
                    zipper.close();
                }
                if (resultStream != null) {
                    resultStream.close();
                }
                throw th;
            }
        } catch (IOException e5) {
            if (zipper != null) {
                zipper.close();
            }
            if (resultStream != null) {
                return null;
            }
            resultStream.close();
            return null;
        } catch (Throwable th4) {
            th = th4;
            if (zipper != null) {
                zipper.close();
            }
            if (resultStream != null) {
                resultStream.close();
            }
            throw th;
        }
    }

    private static byte[] decompress(byte[] data, int expectedSize) {
        Throwable th;
        ByteArrayInputStream inputStream = null;
        GZIPInputStream unzipper = null;
        try {
            ByteArrayInputStream inputStream2 = new ByteArrayInputStream(data);
            try {
                GZIPInputStream unzipper2 = new GZIPInputStream(inputStream2);
                try {
                    byte[] result = new byte[expectedSize];
                    int totalReadBytes = 0;
                    while (totalReadBytes < result.length) {
                        int readBytes = unzipper2.read(result, totalReadBytes, result.length - totalReadBytes);
                        if (readBytes < 0) {
                            break;
                        }
                        totalReadBytes += readBytes;
                    }
                    if (expectedSize != totalReadBytes) {
                        if (unzipper2 != null) {
                            try {
                                unzipper2.close();
                            } catch (IOException e) {
                                Slog.e(TAG, "Failed to close the stream.", e);
                            }
                        }
                        if (inputStream2 != null) {
                            try {
                                inputStream2.close();
                            } catch (IOException e2) {
                                Slog.e(TAG, "Failed to close the stream.", e2);
                            }
                        }
                        unzipper = unzipper2;
                        inputStream = inputStream2;
                        return null;
                    }
                    if (unzipper2 != null) {
                        try {
                            unzipper2.close();
                        } catch (IOException e22) {
                            Slog.e(TAG, "Failed to close the stream.", e22);
                        }
                    }
                    if (inputStream2 != null) {
                        try {
                            inputStream2.close();
                        } catch (IOException e222) {
                            Slog.e(TAG, "Failed to close the stream.", e222);
                        }
                    }
                    unzipper = unzipper2;
                    inputStream = inputStream2;
                    return result;
                } catch (IOException e3) {
                    unzipper = unzipper2;
                    inputStream = inputStream2;
                    if (unzipper != null) {
                        try {
                            unzipper.close();
                        } catch (IOException e2222) {
                            Slog.e(TAG, "Failed to close the stream.", e2222);
                        }
                    }
                    if (inputStream != null) {
                        try {
                            inputStream.close();
                        } catch (IOException e22222) {
                            Slog.e(TAG, "Failed to close the stream.", e22222);
                        }
                    }
                    return null;
                } catch (Throwable th2) {
                    th = th2;
                    unzipper = unzipper2;
                    inputStream = inputStream2;
                    if (unzipper != null) {
                        try {
                            unzipper.close();
                        } catch (IOException e222222) {
                            Slog.e(TAG, "Failed to close the stream.", e222222);
                        }
                    }
                    if (inputStream != null) {
                        try {
                            inputStream.close();
                        } catch (IOException e2222222) {
                            Slog.e(TAG, "Failed to close the stream.", e2222222);
                        }
                    }
                    throw th;
                }
            } catch (IOException e4) {
                inputStream = inputStream2;
                if (unzipper != null) {
                    unzipper.close();
                }
                if (inputStream != null) {
                    inputStream.close();
                }
                return null;
            } catch (Throwable th3) {
                th = th3;
                inputStream = inputStream2;
                if (unzipper != null) {
                    unzipper.close();
                }
                if (inputStream != null) {
                    inputStream.close();
                }
                throw th;
            }
        } catch (IOException e5) {
            if (unzipper != null) {
                unzipper.close();
            }
            if (inputStream != null) {
                inputStream.close();
            }
            return null;
        } catch (Throwable th4) {
            th = th4;
            if (unzipper != null) {
                unzipper.close();
            }
            if (inputStream != null) {
                inputStream.close();
            }
            throw th;
        }
    }
}
