package android.content.pm;

import android.os.Binder;
import android.os.IBinder;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.ClassLoaderCreator;
import android.os.Parcelable.Creator;
import android.os.RemoteException;
import android.util.Log;
import java.util.ArrayList;
import java.util.List;

public class ParceledListSlice<T extends Parcelable> implements Parcelable {
    public static final ClassLoaderCreator<ParceledListSlice> CREATOR;
    private static boolean DEBUG = false;
    private static final int MAX_FIRST_IPC_SIZE = 131072;
    private static final int MAX_IPC_SIZE = 262144;
    private static String TAG;
    private final List<T> mList;

    /* renamed from: android.content.pm.ParceledListSlice.1 */
    class C01331 extends Binder {
        final /* synthetic */ int val$N;
        final /* synthetic */ int val$callFlags;
        final /* synthetic */ Class val$listElementClass;

        C01331(int i, Class cls, int i2) {
            this.val$N = i;
            this.val$listElementClass = cls;
            this.val$callFlags = i2;
        }

        protected boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            if (code != 1) {
                return super.onTransact(code, data, reply, flags);
            }
            int i = data.readInt();
            if (ParceledListSlice.DEBUG) {
                Log.d(ParceledListSlice.TAG, "Writing more @" + i + " of " + this.val$N);
            }
            while (i < this.val$N && reply.dataSize() < ParceledListSlice.MAX_IPC_SIZE) {
                reply.writeInt(1);
                Parcelable parcelable = (Parcelable) ParceledListSlice.this.mList.get(i);
                ParceledListSlice.verifySameType(this.val$listElementClass, parcelable.getClass());
                parcelable.writeToParcel(reply, this.val$callFlags);
                if (ParceledListSlice.DEBUG) {
                    Log.d(ParceledListSlice.TAG, "Wrote extra #" + i + ": " + ParceledListSlice.this.mList.get(i));
                }
                i++;
            }
            if (i >= this.val$N) {
                return true;
            }
            if (ParceledListSlice.DEBUG) {
                Log.d(ParceledListSlice.TAG, "Breaking @" + i + " of " + this.val$N);
            }
            reply.writeInt(0);
            return true;
        }
    }

    /* renamed from: android.content.pm.ParceledListSlice.2 */
    static class C01342 implements ClassLoaderCreator<ParceledListSlice> {
        C01342() {
        }

        public ParceledListSlice createFromParcel(Parcel in) {
            return new ParceledListSlice(null, null);
        }

        public ParceledListSlice createFromParcel(Parcel in, ClassLoader loader) {
            return new ParceledListSlice(loader, null);
        }

        public ParceledListSlice[] newArray(int size) {
            return new ParceledListSlice[size];
        }
    }

    static {
        TAG = "ParceledListSlice";
        DEBUG = false;
        CREATOR = new C01342();
    }

    public ParceledListSlice(List<T> list) {
        this.mList = list;
    }

    private ParceledListSlice(Parcel p, ClassLoader loader) {
        int N = p.readInt();
        this.mList = new ArrayList(N);
        if (DEBUG) {
            Log.d(TAG, "Retrieving " + N + " items");
        }
        if (N > 0) {
            T parcelable;
            Creator<T> creator = p.readParcelableCreator(loader);
            Class<?> listElementClass = null;
            int i = 0;
            while (i < N && p.readInt() != 0) {
                parcelable = p.readCreator(creator, loader);
                if (listElementClass == null) {
                    listElementClass = parcelable.getClass();
                } else {
                    verifySameType(listElementClass, parcelable.getClass());
                }
                this.mList.add(parcelable);
                if (DEBUG) {
                    Log.d(TAG, "Read inline #" + i + ": " + this.mList.get(this.mList.size() - 1));
                }
                i++;
            }
            if (i < N) {
                IBinder retriever = p.readStrongBinder();
                while (i < N) {
                    if (DEBUG) {
                        Log.d(TAG, "Reading more @" + i + " of " + N + ": retriever=" + retriever);
                    }
                    Parcel data = Parcel.obtain();
                    Parcel reply = Parcel.obtain();
                    data.writeInt(i);
                    try {
                        retriever.transact(1, data, reply, 0);
                        while (i < N && reply.readInt() != 0) {
                            parcelable = reply.readCreator(creator, loader);
                            verifySameType(listElementClass, parcelable.getClass());
                            this.mList.add(parcelable);
                            if (DEBUG) {
                                Log.d(TAG, "Read extra #" + i + ": " + this.mList.get(this.mList.size() - 1));
                            }
                            i++;
                        }
                        reply.recycle();
                        data.recycle();
                    } catch (RemoteException e) {
                        Log.w(TAG, "Failure retrieving array; only received " + i + " of " + N, e);
                        return;
                    }
                }
            }
        }
    }

    private static void verifySameType(Class<?> expected, Class<?> actual) {
        if (!actual.equals(expected)) {
            throw new IllegalArgumentException("Can't unparcel type " + actual.getName() + " in list of type " + expected.getName());
        }
    }

    public List<T> getList() {
        return this.mList;
    }

    public int describeContents() {
        int contents = 0;
        for (int i = 0; i < this.mList.size(); i++) {
            contents |= ((Parcelable) this.mList.get(i)).describeContents();
        }
        return contents;
    }

    public void writeToParcel(Parcel dest, int flags) {
        int N = this.mList.size();
        int callFlags = flags;
        dest.writeInt(N);
        if (DEBUG) {
            Log.d(TAG, "Writing " + N + " items");
        }
        if (N > 0) {
            Class<?> listElementClass = ((Parcelable) this.mList.get(0)).getClass();
            dest.writeParcelableCreator((Parcelable) this.mList.get(0));
            int i = 0;
            while (i < N && dest.dataSize() < MAX_FIRST_IPC_SIZE) {
                dest.writeInt(1);
                Parcelable parcelable = (Parcelable) this.mList.get(i);
                verifySameType(listElementClass, parcelable.getClass());
                parcelable.writeToParcel(dest, callFlags);
                if (DEBUG) {
                    Log.d(TAG, "Wrote inline #" + i + ": " + this.mList.get(i));
                }
                i++;
            }
            if (i < N) {
                dest.writeInt(0);
                Binder retriever = new C01331(N, listElementClass, callFlags);
                if (DEBUG) {
                    Log.d(TAG, "Breaking @" + i + " of " + N + ": retriever=" + retriever);
                }
                dest.writeStrongBinder(retriever);
            }
        }
    }
}
