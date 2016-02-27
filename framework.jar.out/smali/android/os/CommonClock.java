package android.os;

import android.net.ProxyInfo;
import android.os.IBinder.DeathRecipient;
import java.net.InetSocketAddress;
import java.util.NoSuchElementException;

public class CommonClock {
    public static final int ERROR_ESTIMATE_UNKNOWN = Integer.MAX_VALUE;
    public static final long INVALID_TIMELINE_ID = 0;
    private static final int METHOD_CBK_ON_TIMELINE_CHANGED = 1;
    private static final int METHOD_COMMON_TIME_TO_LOCAL_TIME = 2;
    private static final int METHOD_GET_COMMON_FREQ = 5;
    private static final int METHOD_GET_COMMON_TIME = 4;
    private static final int METHOD_GET_ESTIMATED_ERROR = 8;
    private static final int METHOD_GET_LOCAL_FREQ = 7;
    private static final int METHOD_GET_LOCAL_TIME = 6;
    private static final int METHOD_GET_MASTER_ADDRESS = 11;
    private static final int METHOD_GET_STATE = 10;
    private static final int METHOD_GET_TIMELINE_ID = 9;
    private static final int METHOD_IS_COMMON_TIME_VALID = 1;
    private static final int METHOD_LOCAL_TIME_TO_COMMON_TIME = 3;
    private static final int METHOD_REGISTER_LISTENER = 12;
    private static final int METHOD_UNREGISTER_LISTENER = 13;
    public static final String SERVICE_NAME = "common_time.clock";
    public static final int STATE_CLIENT = 1;
    public static final int STATE_INITIAL = 0;
    public static final int STATE_INVALID = -1;
    public static final int STATE_MASTER = 2;
    public static final int STATE_RONIN = 3;
    public static final int STATE_WAIT_FOR_ELECTION = 4;
    public static final long TIME_NOT_SYNCED = -1;
    private TimelineChangedListener mCallbackTgt;
    private DeathRecipient mDeathHandler;
    private String mInterfaceDesc;
    private final Object mListenerLock;
    private IBinder mRemote;
    private OnServerDiedListener mServerDiedListener;
    private OnTimelineChangedListener mTimelineChangedListener;
    private CommonTimeUtils mUtils;

    /* renamed from: android.os.CommonClock.1 */
    class C05861 implements DeathRecipient {
        C05861() {
        }

        public void binderDied() {
            synchronized (CommonClock.this.mListenerLock) {
                if (CommonClock.this.mServerDiedListener != null) {
                    CommonClock.this.mServerDiedListener.onServerDied();
                }
            }
        }
    }

    public interface OnServerDiedListener {
        void onServerDied();
    }

    public interface OnTimelineChangedListener {
        void onTimelineChanged(long j);
    }

    private class TimelineChangedListener extends Binder {
        private static final String DESCRIPTOR = "android.os.ICommonClockListener";

        private TimelineChangedListener() {
        }

        protected boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
            switch (code) {
                case CommonClock.STATE_CLIENT /*1*/:
                    data.enforceInterface(DESCRIPTOR);
                    long timelineId = data.readLong();
                    synchronized (CommonClock.this.mListenerLock) {
                        if (CommonClock.this.mTimelineChangedListener != null) {
                            CommonClock.this.mTimelineChangedListener.onTimelineChanged(timelineId);
                        }
                        break;
                    }
                    return true;
                default:
                    return super.onTransact(code, data, reply, flags);
            }
        }
    }

    public CommonClock() throws RemoteException {
        this.mListenerLock = new Object();
        this.mTimelineChangedListener = null;
        this.mServerDiedListener = null;
        this.mRemote = null;
        this.mInterfaceDesc = ProxyInfo.LOCAL_EXCL_LIST;
        this.mDeathHandler = new C05861();
        this.mCallbackTgt = null;
        this.mRemote = ServiceManager.getService(SERVICE_NAME);
        if (this.mRemote == null) {
            throw new RemoteException();
        }
        this.mInterfaceDesc = this.mRemote.getInterfaceDescriptor();
        this.mUtils = new CommonTimeUtils(this.mRemote, this.mInterfaceDesc);
        this.mRemote.linkToDeath(this.mDeathHandler, STATE_INITIAL);
        registerTimelineChangeListener();
    }

    public static CommonClock create() {
        try {
            return new CommonClock();
        } catch (RemoteException e) {
            return null;
        }
    }

    public void release() {
        unregisterTimelineChangeListener();
        if (this.mRemote != null) {
            try {
                this.mRemote.unlinkToDeath(this.mDeathHandler, STATE_INITIAL);
            } catch (NoSuchElementException e) {
            }
            this.mRemote = null;
        }
        this.mUtils = null;
    }

    public long getTime() throws RemoteException {
        throwOnDeadServer();
        return this.mUtils.transactGetLong(STATE_WAIT_FOR_ELECTION, TIME_NOT_SYNCED);
    }

    public int getEstimatedError() throws RemoteException {
        throwOnDeadServer();
        return this.mUtils.transactGetInt(METHOD_GET_ESTIMATED_ERROR, ERROR_ESTIMATE_UNKNOWN);
    }

    public long getTimelineId() throws RemoteException {
        throwOnDeadServer();
        return this.mUtils.transactGetLong(METHOD_GET_TIMELINE_ID, INVALID_TIMELINE_ID);
    }

    public int getState() throws RemoteException {
        throwOnDeadServer();
        return this.mUtils.transactGetInt(METHOD_GET_STATE, STATE_INVALID);
    }

    public InetSocketAddress getMasterAddr() throws RemoteException {
        throwOnDeadServer();
        return this.mUtils.transactGetSockaddr(METHOD_GET_MASTER_ADDRESS);
    }

    public void setTimelineChangedListener(OnTimelineChangedListener listener) {
        synchronized (this.mListenerLock) {
            this.mTimelineChangedListener = listener;
        }
    }

    public void setServerDiedListener(OnServerDiedListener listener) {
        synchronized (this.mListenerLock) {
            this.mServerDiedListener = listener;
        }
    }

    protected void finalize() throws Throwable {
        release();
    }

    private void throwOnDeadServer() throws RemoteException {
        if (this.mRemote == null || this.mUtils == null) {
            throw new RemoteException();
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void registerTimelineChangeListener() throws android.os.RemoteException {
        /*
        r9 = this;
        r4 = 0;
        r8 = 0;
        r5 = r9.mCallbackTgt;
        if (r5 == 0) goto L_0x0007;
    L_0x0006:
        return;
    L_0x0007:
        r3 = 0;
        r0 = android.os.Parcel.obtain();
        r2 = android.os.Parcel.obtain();
        r5 = new android.os.CommonClock$TimelineChangedListener;
        r5.<init>(r8);
        r9.mCallbackTgt = r5;
        r5 = r9.mInterfaceDesc;	 Catch:{ RemoteException -> 0x0041, all -> 0x004a }
        r0.writeInterfaceToken(r5);	 Catch:{ RemoteException -> 0x0041, all -> 0x004a }
        r5 = r9.mCallbackTgt;	 Catch:{ RemoteException -> 0x0041, all -> 0x004a }
        r0.writeStrongBinder(r5);	 Catch:{ RemoteException -> 0x0041, all -> 0x004a }
        r5 = r9.mRemote;	 Catch:{ RemoteException -> 0x0041, all -> 0x004a }
        r6 = 12;
        r7 = 0;
        r5.transact(r6, r0, r2, r7);	 Catch:{ RemoteException -> 0x0041, all -> 0x004a }
        r5 = r2.readInt();	 Catch:{ RemoteException -> 0x0041, all -> 0x004a }
        if (r5 != 0) goto L_0x003f;
    L_0x002f:
        r3 = 1;
    L_0x0030:
        r2.recycle();
        r0.recycle();
    L_0x0036:
        if (r3 != 0) goto L_0x0006;
    L_0x0038:
        r9.mCallbackTgt = r8;
        r9.mRemote = r8;
        r9.mUtils = r8;
        goto L_0x0006;
    L_0x003f:
        r3 = r4;
        goto L_0x0030;
    L_0x0041:
        r1 = move-exception;
        r3 = 0;
        r2.recycle();
        r0.recycle();
        goto L_0x0036;
    L_0x004a:
        r4 = move-exception;
        r2.recycle();
        r0.recycle();
        throw r4;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.os.CommonClock.registerTimelineChangeListener():void");
    }

    private void unregisterTimelineChangeListener() {
        if (this.mCallbackTgt != null) {
            Parcel data = Parcel.obtain();
            Parcel reply = Parcel.obtain();
            try {
                data.writeInterfaceToken(this.mInterfaceDesc);
                data.writeStrongBinder(this.mCallbackTgt);
                this.mRemote.transact(METHOD_UNREGISTER_LISTENER, data, reply, STATE_INITIAL);
            } catch (RemoteException e) {
            } finally {
                reply.recycle();
                data.recycle();
                this.mCallbackTgt = null;
            }
        }
    }
}
