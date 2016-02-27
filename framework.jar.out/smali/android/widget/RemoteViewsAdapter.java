package android.widget;

import android.appwidget.AppWidgetManager;
import android.content.Context;
import android.content.Intent;
import android.content.Intent.FilterComparison;
import android.os.Handler;
import android.os.Handler.Callback;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.util.Log;
import android.util.Slog;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.MeasureSpec;
import android.view.ViewGroup;
import android.widget.RemoteViews.OnClickHandler;
import com.android.internal.widget.IRemoteViewsAdapterConnection.Stub;
import com.android.internal.widget.IRemoteViewsFactory;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;

public class RemoteViewsAdapter extends BaseAdapter implements Callback {
    private static final String MULTI_USER_PERM = "android.permission.INTERACT_ACROSS_USERS_FULL";
    private static final int REMOTE_VIEWS_CACHE_DURATION = 5000;
    private static final String TAG = "RemoteViewsAdapter";
    private static Handler sCacheRemovalQueue = null;
    private static HandlerThread sCacheRemovalThread = null;
    private static final HashMap<RemoteViewsCacheKey, FixedSizeRemoteViewsCache> sCachedRemoteViewsCaches;
    private static final int sDefaultCacheSize = 40;
    private static final int sDefaultLoadingViewHeight = 50;
    private static final int sDefaultMessageType = 0;
    private static final HashMap<RemoteViewsCacheKey, Runnable> sRemoteViewsCacheRemoveRunnables;
    private static final int sUnbindServiceDelay = 5000;
    private static final int sUnbindServiceMessageType = 1;
    private final int mAppWidgetId;
    private FixedSizeRemoteViewsCache mCache;
    private WeakReference<RemoteAdapterConnectionCallback> mCallback;
    private final Context mContext;
    private boolean mDataReady;
    private final Intent mIntent;
    private LayoutInflater mLayoutInflater;
    private Handler mMainQueue;
    private boolean mNotifyDataSetChangedAfterOnServiceConnected;
    private OnClickHandler mRemoteViewsOnClickHandler;
    private RemoteViewsFrameLayoutRefSet mRequestedViews;
    private RemoteViewsAdapterServiceConnection mServiceConnection;
    private int mVisibleWindowLowerBound;
    private int mVisibleWindowUpperBound;
    private Handler mWorkerQueue;
    private HandlerThread mWorkerThread;

    public interface RemoteAdapterConnectionCallback {
        void deferNotifyDataSetChanged();

        boolean onRemoteAdapterConnected();

        void onRemoteAdapterDisconnected();
    }

    /* renamed from: android.widget.RemoteViewsAdapter.1 */
    class C10261 implements Runnable {
        final /* synthetic */ RemoteViewsCacheKey val$key;

        C10261(RemoteViewsCacheKey remoteViewsCacheKey) {
            this.val$key = remoteViewsCacheKey;
        }

        public void run() {
            synchronized (RemoteViewsAdapter.sCachedRemoteViewsCaches) {
                if (RemoteViewsAdapter.sCachedRemoteViewsCaches.containsKey(this.val$key)) {
                    RemoteViewsAdapter.sCachedRemoteViewsCaches.remove(this.val$key);
                }
                if (RemoteViewsAdapter.sRemoteViewsCacheRemoveRunnables.containsKey(this.val$key)) {
                    RemoteViewsAdapter.sRemoteViewsCacheRemoveRunnables.remove(this.val$key);
                }
            }
        }
    }

    /* renamed from: android.widget.RemoteViewsAdapter.2 */
    class C10272 implements Runnable {
        C10272() {
        }

        public void run() {
            if (RemoteViewsAdapter.this.mServiceConnection.isConnected()) {
                int position;
                synchronized (RemoteViewsAdapter.this.mCache) {
                    position = RemoteViewsAdapter.this.mCache.getNextIndexToLoad()[RemoteViewsAdapter.sDefaultMessageType];
                }
                if (position > -1) {
                    RemoteViewsAdapter.this.updateRemoteViews(position, true);
                    RemoteViewsAdapter.this.loadNextIndexInBackground();
                    return;
                }
                RemoteViewsAdapter.this.enqueueDeferredUnbindServiceMessage();
            }
        }
    }

    /* renamed from: android.widget.RemoteViewsAdapter.3 */
    class C10283 implements Runnable {
        C10283() {
        }

        public void run() {
            RemoteViewsAdapter.this.superNotifyDataSetChanged();
        }
    }

    /* renamed from: android.widget.RemoteViewsAdapter.4 */
    class C10294 implements Runnable {
        final /* synthetic */ int val$position;
        final /* synthetic */ RemoteViews val$rv;

        C10294(int i, RemoteViews remoteViews) {
            this.val$position = i;
            this.val$rv = remoteViews;
        }

        public void run() {
            RemoteViewsAdapter.this.mRequestedViews.notifyOnRemoteViewsLoaded(this.val$position, this.val$rv);
        }
    }

    /* renamed from: android.widget.RemoteViewsAdapter.5 */
    class C10305 implements Runnable {
        C10305() {
        }

        public void run() {
            synchronized (RemoteViewsAdapter.this.mCache) {
                RemoteViewsAdapter.this.mCache.commitTemporaryMetaData();
            }
            RemoteViewsAdapter.this.superNotifyDataSetChanged();
            RemoteViewsAdapter.this.enqueueDeferredUnbindServiceMessage();
        }
    }

    /* renamed from: android.widget.RemoteViewsAdapter.6 */
    class C10316 implements Runnable {
        C10316() {
        }

        public void run() {
            RemoteViewsAdapter.this.onNotifyDataSetChanged();
        }
    }

    private static class FixedSizeRemoteViewsCache {
        private static final String TAG = "FixedSizeRemoteViewsCache";
        private static final float sMaxCountSlackPercent = 0.75f;
        private static final int sMaxMemoryLimitInBytes = 2097152;
        private HashMap<Integer, RemoteViewsIndexMetaData> mIndexMetaData;
        private HashMap<Integer, RemoteViews> mIndexRemoteViews;
        private int mLastRequestedIndex;
        private HashSet<Integer> mLoadIndices;
        private int mMaxCount;
        private int mMaxCountSlack;
        private final RemoteViewsMetaData mMetaData;
        private int mPreloadLowerBound;
        private int mPreloadUpperBound;
        private HashSet<Integer> mRequestedIndices;
        private final RemoteViewsMetaData mTemporaryMetaData;

        public FixedSizeRemoteViewsCache(int maxCacheSize) {
            this.mMaxCount = maxCacheSize;
            this.mMaxCountSlack = Math.round(sMaxCountSlackPercent * ((float) (this.mMaxCount / 2)));
            this.mPreloadLowerBound = RemoteViewsAdapter.sDefaultMessageType;
            this.mPreloadUpperBound = -1;
            this.mMetaData = new RemoteViewsMetaData();
            this.mTemporaryMetaData = new RemoteViewsMetaData();
            this.mIndexMetaData = new HashMap();
            this.mIndexRemoteViews = new HashMap();
            this.mRequestedIndices = new HashSet();
            this.mLastRequestedIndex = -1;
            this.mLoadIndices = new HashSet();
        }

        public void insert(int position, RemoteViews v, long itemId, ArrayList<Integer> visibleWindow) {
            int pruneFromPosition;
            if (this.mIndexRemoteViews.size() >= this.mMaxCount) {
                this.mIndexRemoteViews.remove(Integer.valueOf(getFarthestPositionFrom(position, visibleWindow)));
            }
            if (this.mLastRequestedIndex > -1) {
                pruneFromPosition = this.mLastRequestedIndex;
            } else {
                pruneFromPosition = position;
            }
            while (getRemoteViewsBitmapMemoryUsage() >= sMaxMemoryLimitInBytes) {
                int trimIndex = getFarthestPositionFrom(pruneFromPosition, visibleWindow);
                if (trimIndex < 0) {
                    break;
                }
                this.mIndexRemoteViews.remove(Integer.valueOf(trimIndex));
            }
            if (this.mIndexMetaData.containsKey(Integer.valueOf(position))) {
                ((RemoteViewsIndexMetaData) this.mIndexMetaData.get(Integer.valueOf(position))).set(v, itemId);
            } else {
                this.mIndexMetaData.put(Integer.valueOf(position), new RemoteViewsIndexMetaData(v, itemId));
            }
            this.mIndexRemoteViews.put(Integer.valueOf(position), v);
        }

        public RemoteViewsMetaData getMetaData() {
            return this.mMetaData;
        }

        public RemoteViewsMetaData getTemporaryMetaData() {
            return this.mTemporaryMetaData;
        }

        public RemoteViews getRemoteViewsAt(int position) {
            if (this.mIndexRemoteViews.containsKey(Integer.valueOf(position))) {
                return (RemoteViews) this.mIndexRemoteViews.get(Integer.valueOf(position));
            }
            return null;
        }

        public RemoteViewsIndexMetaData getMetaDataAt(int position) {
            if (this.mIndexMetaData.containsKey(Integer.valueOf(position))) {
                return (RemoteViewsIndexMetaData) this.mIndexMetaData.get(Integer.valueOf(position));
            }
            return null;
        }

        public void commitTemporaryMetaData() {
            synchronized (this.mTemporaryMetaData) {
                synchronized (this.mMetaData) {
                    this.mMetaData.set(this.mTemporaryMetaData);
                }
            }
        }

        private int getRemoteViewsBitmapMemoryUsage() {
            int mem = RemoteViewsAdapter.sDefaultMessageType;
            for (Integer i : this.mIndexRemoteViews.keySet()) {
                RemoteViews v = (RemoteViews) this.mIndexRemoteViews.get(i);
                if (v != null) {
                    mem += v.estimateMemoryUsage();
                }
            }
            return mem;
        }

        private int getFarthestPositionFrom(int pos, ArrayList<Integer> visibleWindow) {
            int maxDist = RemoteViewsAdapter.sDefaultMessageType;
            int maxDistIndex = -1;
            int maxDistNotVisible = RemoteViewsAdapter.sDefaultMessageType;
            int maxDistIndexNotVisible = -1;
            for (Integer intValue : this.mIndexRemoteViews.keySet()) {
                int i = intValue.intValue();
                int dist = Math.abs(i - pos);
                if (dist > maxDistNotVisible && !visibleWindow.contains(Integer.valueOf(i))) {
                    maxDistIndexNotVisible = i;
                    maxDistNotVisible = dist;
                }
                if (dist >= maxDist) {
                    maxDistIndex = i;
                    maxDist = dist;
                }
            }
            return maxDistIndexNotVisible > -1 ? maxDistIndexNotVisible : maxDistIndex;
        }

        public void queueRequestedPositionToLoad(int position) {
            this.mLastRequestedIndex = position;
            synchronized (this.mLoadIndices) {
                this.mRequestedIndices.add(Integer.valueOf(position));
                this.mLoadIndices.add(Integer.valueOf(position));
            }
        }

        public boolean queuePositionsToBePreloadedFromRequestedPosition(int position) {
            if (this.mPreloadLowerBound <= position && position <= this.mPreloadUpperBound && Math.abs(position - ((this.mPreloadUpperBound + this.mPreloadLowerBound) / 2)) < this.mMaxCountSlack) {
                return false;
            }
            synchronized (this.mMetaData) {
                int count = this.mMetaData.count;
            }
            synchronized (this.mLoadIndices) {
                this.mLoadIndices.clear();
                this.mLoadIndices.addAll(this.mRequestedIndices);
                int halfMaxCount = this.mMaxCount / 2;
                this.mPreloadLowerBound = position - halfMaxCount;
                this.mPreloadUpperBound = position + halfMaxCount;
                int effectiveLowerBound = Math.max(RemoteViewsAdapter.sDefaultMessageType, this.mPreloadLowerBound);
                int effectiveUpperBound = Math.min(this.mPreloadUpperBound, count - 1);
                for (int i = effectiveLowerBound; i <= effectiveUpperBound; i += RemoteViewsAdapter.sUnbindServiceMessageType) {
                    this.mLoadIndices.add(Integer.valueOf(i));
                }
                this.mLoadIndices.removeAll(this.mIndexRemoteViews.keySet());
            }
            return true;
        }

        public int[] getNextIndexToLoad() {
            int[] iArr;
            synchronized (this.mLoadIndices) {
                Integer i;
                if (!this.mRequestedIndices.isEmpty()) {
                    i = (Integer) this.mRequestedIndices.iterator().next();
                    this.mRequestedIndices.remove(i);
                    this.mLoadIndices.remove(i);
                    iArr = new int[]{i.intValue(), RemoteViewsAdapter.sUnbindServiceMessageType};
                } else if (this.mLoadIndices.isEmpty()) {
                    iArr = new int[]{-1, RemoteViewsAdapter.sDefaultMessageType};
                } else {
                    this.mLoadIndices.remove((Integer) this.mLoadIndices.iterator().next());
                    iArr = new int[]{i.intValue(), RemoteViewsAdapter.sDefaultMessageType};
                }
            }
            return iArr;
        }

        public boolean containsRemoteViewAt(int position) {
            return this.mIndexRemoteViews.containsKey(Integer.valueOf(position));
        }

        public boolean containsMetaDataAt(int position) {
            return this.mIndexMetaData.containsKey(Integer.valueOf(position));
        }

        public void reset() {
            this.mPreloadLowerBound = RemoteViewsAdapter.sDefaultMessageType;
            this.mPreloadUpperBound = -1;
            this.mLastRequestedIndex = -1;
            this.mIndexRemoteViews.clear();
            this.mIndexMetaData.clear();
            synchronized (this.mLoadIndices) {
                this.mRequestedIndices.clear();
                this.mLoadIndices.clear();
            }
        }
    }

    private static class RemoteViewsAdapterServiceConnection extends Stub {
        private WeakReference<RemoteViewsAdapter> mAdapter;
        private boolean mIsConnected;
        private boolean mIsConnecting;
        private IRemoteViewsFactory mRemoteViewsFactory;

        /* renamed from: android.widget.RemoteViewsAdapter.RemoteViewsAdapterServiceConnection.1 */
        class C10331 implements Runnable {
            final /* synthetic */ RemoteViewsAdapter val$adapter;

            /* renamed from: android.widget.RemoteViewsAdapter.RemoteViewsAdapterServiceConnection.1.1 */
            class C10321 implements Runnable {
                C10321() {
                }

                public void run() {
                    synchronized (C10331.this.val$adapter.mCache) {
                        C10331.this.val$adapter.mCache.commitTemporaryMetaData();
                    }
                    RemoteAdapterConnectionCallback callback = (RemoteAdapterConnectionCallback) C10331.this.val$adapter.mCallback.get();
                    if (callback != null) {
                        callback.onRemoteAdapterConnected();
                    }
                }
            }

            C10331(RemoteViewsAdapter remoteViewsAdapter) {
                this.val$adapter = remoteViewsAdapter;
            }

            public void run() {
                if (this.val$adapter.mNotifyDataSetChangedAfterOnServiceConnected) {
                    this.val$adapter.onNotifyDataSetChanged();
                } else {
                    IRemoteViewsFactory factory = this.val$adapter.mServiceConnection.getRemoteViewsFactory();
                    try {
                        if (!factory.isCreated()) {
                            factory.onDataSetChanged();
                        }
                    } catch (RemoteException e) {
                        Log.e(RemoteViewsAdapter.TAG, "Error notifying factory of data set changed in onServiceConnected(): " + e.getMessage());
                        return;
                    } catch (RuntimeException e2) {
                        Log.e(RemoteViewsAdapter.TAG, "Error notifying factory of data set changed in onServiceConnected(): " + e2.getMessage());
                    }
                    this.val$adapter.updateTemporaryMetaData();
                    this.val$adapter.mMainQueue.post(new C10321());
                }
                this.val$adapter.enqueueDeferredUnbindServiceMessage();
                RemoteViewsAdapterServiceConnection.this.mIsConnected = true;
                RemoteViewsAdapterServiceConnection.this.mIsConnecting = false;
            }
        }

        /* renamed from: android.widget.RemoteViewsAdapter.RemoteViewsAdapterServiceConnection.2 */
        class C10342 implements Runnable {
            final /* synthetic */ RemoteViewsAdapter val$adapter;

            C10342(RemoteViewsAdapter remoteViewsAdapter) {
                this.val$adapter = remoteViewsAdapter;
            }

            public void run() {
                this.val$adapter.mMainQueue.removeMessages(RemoteViewsAdapter.sUnbindServiceMessageType);
                RemoteAdapterConnectionCallback callback = (RemoteAdapterConnectionCallback) this.val$adapter.mCallback.get();
                if (callback != null) {
                    callback.onRemoteAdapterDisconnected();
                }
            }
        }

        public RemoteViewsAdapterServiceConnection(RemoteViewsAdapter adapter) {
            this.mAdapter = new WeakReference(adapter);
        }

        public synchronized void bind(Context context, int appWidgetId, Intent intent) {
            if (!this.mIsConnecting) {
                try {
                    AppWidgetManager mgr = AppWidgetManager.getInstance(context);
                    if (((RemoteViewsAdapter) this.mAdapter.get()) != null) {
                        mgr.bindRemoteViewsService(context.getOpPackageName(), appWidgetId, intent, asBinder());
                    } else {
                        Slog.w(RemoteViewsAdapter.TAG, "bind: adapter was null");
                    }
                    this.mIsConnecting = true;
                } catch (Exception e) {
                    Log.e("RemoteViewsAdapterServiceConnection", "bind(): " + e.getMessage());
                    this.mIsConnecting = false;
                    this.mIsConnected = false;
                }
            }
        }

        public synchronized void unbind(Context context, int appWidgetId, Intent intent) {
            try {
                AppWidgetManager mgr = AppWidgetManager.getInstance(context);
                if (((RemoteViewsAdapter) this.mAdapter.get()) != null) {
                    mgr.unbindRemoteViewsService(context.getOpPackageName(), appWidgetId, intent);
                } else {
                    Slog.w(RemoteViewsAdapter.TAG, "unbind: adapter was null");
                }
                this.mIsConnecting = false;
            } catch (Exception e) {
                Log.e("RemoteViewsAdapterServiceConnection", "unbind(): " + e.getMessage());
                this.mIsConnecting = false;
                this.mIsConnected = false;
            }
        }

        public synchronized void onServiceConnected(IBinder service) {
            this.mRemoteViewsFactory = IRemoteViewsFactory.Stub.asInterface(service);
            RemoteViewsAdapter adapter = (RemoteViewsAdapter) this.mAdapter.get();
            if (adapter != null) {
                adapter.mWorkerQueue.post(new C10331(adapter));
            }
        }

        public synchronized void onServiceDisconnected() {
            this.mIsConnected = false;
            this.mIsConnecting = false;
            this.mRemoteViewsFactory = null;
            RemoteViewsAdapter adapter = (RemoteViewsAdapter) this.mAdapter.get();
            if (adapter != null) {
                adapter.mMainQueue.post(new C10342(adapter));
            }
        }

        public synchronized IRemoteViewsFactory getRemoteViewsFactory() {
            return this.mRemoteViewsFactory;
        }

        public synchronized boolean isConnected() {
            return this.mIsConnected;
        }
    }

    static class RemoteViewsCacheKey {
        final FilterComparison filter;
        final int widgetId;

        RemoteViewsCacheKey(FilterComparison filter, int widgetId) {
            this.filter = filter;
            this.widgetId = widgetId;
        }

        public boolean equals(Object o) {
            if (!(o instanceof RemoteViewsCacheKey)) {
                return false;
            }
            RemoteViewsCacheKey other = (RemoteViewsCacheKey) o;
            if (other.filter.equals(this.filter) && other.widgetId == this.widgetId) {
                return true;
            }
            return false;
        }

        public int hashCode() {
            return (this.filter == null ? RemoteViewsAdapter.sDefaultMessageType : this.filter.hashCode()) ^ (this.widgetId << 2);
        }
    }

    private static class RemoteViewsFrameLayout extends FrameLayout {
        public RemoteViewsFrameLayout(Context context) {
            super(context);
        }

        public void onRemoteViewsLoaded(RemoteViews view, OnClickHandler handler) {
            try {
                removeAllViews();
                addView(view.apply(getContext(), this, handler));
            } catch (Exception e) {
                Log.e(RemoteViewsAdapter.TAG, "Failed to apply RemoteViews.");
            }
        }
    }

    private class RemoteViewsFrameLayoutRefSet {
        private HashMap<Integer, LinkedList<RemoteViewsFrameLayout>> mReferences;
        private HashMap<RemoteViewsFrameLayout, LinkedList<RemoteViewsFrameLayout>> mViewToLinkedList;

        public RemoteViewsFrameLayoutRefSet() {
            this.mReferences = new HashMap();
            this.mViewToLinkedList = new HashMap();
        }

        public void add(int position, RemoteViewsFrameLayout layout) {
            LinkedList<RemoteViewsFrameLayout> refs;
            Integer pos = Integer.valueOf(position);
            if (this.mReferences.containsKey(pos)) {
                refs = (LinkedList) this.mReferences.get(pos);
            } else {
                refs = new LinkedList();
                this.mReferences.put(pos, refs);
            }
            this.mViewToLinkedList.put(layout, refs);
            refs.add(layout);
        }

        public void notifyOnRemoteViewsLoaded(int position, RemoteViews view) {
            if (view != null) {
                Integer pos = Integer.valueOf(position);
                if (this.mReferences.containsKey(pos)) {
                    LinkedList<RemoteViewsFrameLayout> refs = (LinkedList) this.mReferences.get(pos);
                    Iterator i$ = refs.iterator();
                    while (i$.hasNext()) {
                        RemoteViewsFrameLayout ref = (RemoteViewsFrameLayout) i$.next();
                        ref.onRemoteViewsLoaded(view, RemoteViewsAdapter.this.mRemoteViewsOnClickHandler);
                        if (this.mViewToLinkedList.containsKey(ref)) {
                            this.mViewToLinkedList.remove(ref);
                        }
                    }
                    refs.clear();
                    this.mReferences.remove(pos);
                }
            }
        }

        public void removeView(RemoteViewsFrameLayout rvfl) {
            if (this.mViewToLinkedList.containsKey(rvfl)) {
                ((LinkedList) this.mViewToLinkedList.get(rvfl)).remove(rvfl);
                this.mViewToLinkedList.remove(rvfl);
            }
        }

        public void clear() {
            this.mReferences.clear();
            this.mViewToLinkedList.clear();
        }
    }

    private static class RemoteViewsIndexMetaData {
        long itemId;
        int typeId;

        public RemoteViewsIndexMetaData(RemoteViews v, long itemId) {
            set(v, itemId);
        }

        public void set(RemoteViews v, long id) {
            this.itemId = id;
            if (v != null) {
                this.typeId = v.getLayoutId();
            } else {
                this.typeId = RemoteViewsAdapter.sDefaultMessageType;
            }
        }
    }

    private static class RemoteViewsMetaData {
        int count;
        boolean hasStableIds;
        RemoteViews mFirstView;
        int mFirstViewHeight;
        private final HashMap<Integer, Integer> mTypeIdIndexMap;
        RemoteViews mUserLoadingView;
        int viewTypeCount;

        public RemoteViewsMetaData() {
            this.mTypeIdIndexMap = new HashMap();
            reset();
        }

        public void set(RemoteViewsMetaData d) {
            synchronized (d) {
                this.count = d.count;
                this.viewTypeCount = d.viewTypeCount;
                this.hasStableIds = d.hasStableIds;
                setLoadingViewTemplates(d.mUserLoadingView, d.mFirstView);
            }
        }

        public void reset() {
            this.count = RemoteViewsAdapter.sDefaultMessageType;
            this.viewTypeCount = RemoteViewsAdapter.sUnbindServiceMessageType;
            this.hasStableIds = true;
            this.mUserLoadingView = null;
            this.mFirstView = null;
            this.mFirstViewHeight = RemoteViewsAdapter.sDefaultMessageType;
            this.mTypeIdIndexMap.clear();
        }

        public void setLoadingViewTemplates(RemoteViews loadingView, RemoteViews firstView) {
            this.mUserLoadingView = loadingView;
            if (firstView != null) {
                this.mFirstView = firstView;
                this.mFirstViewHeight = -1;
            }
        }

        public int getMappedViewType(int typeId) {
            if (this.mTypeIdIndexMap.containsKey(Integer.valueOf(typeId))) {
                return ((Integer) this.mTypeIdIndexMap.get(Integer.valueOf(typeId))).intValue();
            }
            int incrementalTypeId = this.mTypeIdIndexMap.size() + RemoteViewsAdapter.sUnbindServiceMessageType;
            this.mTypeIdIndexMap.put(Integer.valueOf(typeId), Integer.valueOf(incrementalTypeId));
            return incrementalTypeId;
        }

        public boolean isViewTypeInRange(int typeId) {
            if (getMappedViewType(typeId) >= this.viewTypeCount) {
                return false;
            }
            return true;
        }

        private RemoteViewsFrameLayout createLoadingView(int position, View convertView, ViewGroup parent, Object lock, LayoutInflater layoutInflater, OnClickHandler handler) {
            Context context = parent.getContext();
            ViewGroup layout = new RemoteViewsFrameLayout(context);
            synchronized (lock) {
                boolean customLoadingViewAvailable = false;
                if (this.mUserLoadingView != null) {
                    try {
                        View loadingView = this.mUserLoadingView.apply(parent.getContext(), parent, handler);
                        loadingView.setTagInternal(16908346, new Integer(RemoteViewsAdapter.sDefaultMessageType));
                        layout.addView(loadingView);
                        customLoadingViewAvailable = true;
                    } catch (Exception e) {
                        Log.w(RemoteViewsAdapter.TAG, "Error inflating custom loading view, using default loadingview instead", e);
                    }
                }
                if (!customLoadingViewAvailable) {
                    if (this.mFirstViewHeight < 0) {
                        try {
                            View firstView = this.mFirstView.apply(parent.getContext(), parent, handler);
                            firstView.measure(MeasureSpec.makeMeasureSpec(RemoteViewsAdapter.sDefaultMessageType, RemoteViewsAdapter.sDefaultMessageType), MeasureSpec.makeMeasureSpec(RemoteViewsAdapter.sDefaultMessageType, RemoteViewsAdapter.sDefaultMessageType));
                            this.mFirstViewHeight = firstView.getMeasuredHeight();
                            this.mFirstView = null;
                        } catch (Exception e2) {
                            this.mFirstViewHeight = Math.round(50.0f * context.getResources().getDisplayMetrics().density);
                            this.mFirstView = null;
                            Log.w(RemoteViewsAdapter.TAG, "Error inflating first RemoteViews" + e2);
                        }
                    }
                    TextView loadingTextView = (TextView) layoutInflater.inflate(17367212, layout, false);
                    loadingTextView.setHeight(this.mFirstViewHeight);
                    loadingTextView.setTag(new Integer(RemoteViewsAdapter.sDefaultMessageType));
                    layout.addView(loadingTextView);
                }
            }
            return layout;
        }
    }

    static {
        sCachedRemoteViewsCaches = new HashMap();
        sRemoteViewsCacheRemoveRunnables = new HashMap();
    }

    public RemoteViewsAdapter(Context context, Intent intent, RemoteAdapterConnectionCallback callback) {
        this.mNotifyDataSetChangedAfterOnServiceConnected = false;
        this.mDataReady = false;
        this.mContext = context;
        this.mIntent = intent;
        this.mAppWidgetId = intent.getIntExtra("remoteAdapterAppWidgetId", -1);
        this.mLayoutInflater = LayoutInflater.from(context);
        if (this.mIntent == null) {
            throw new IllegalArgumentException("Non-null Intent must be specified.");
        }
        this.mRequestedViews = new RemoteViewsFrameLayoutRefSet();
        if (intent.hasExtra("remoteAdapterAppWidgetId")) {
            intent.removeExtra("remoteAdapterAppWidgetId");
        }
        this.mWorkerThread = new HandlerThread("RemoteViewsCache-loader");
        this.mWorkerThread.start();
        this.mWorkerQueue = new Handler(this.mWorkerThread.getLooper());
        this.mMainQueue = new Handler(Looper.myLooper(), (Callback) this);
        if (sCacheRemovalThread == null) {
            sCacheRemovalThread = new HandlerThread("RemoteViewsAdapter-cachePruner");
            sCacheRemovalThread.start();
            sCacheRemovalQueue = new Handler(sCacheRemovalThread.getLooper());
        }
        this.mCallback = new WeakReference(callback);
        this.mServiceConnection = new RemoteViewsAdapterServiceConnection(this);
        RemoteViewsCacheKey key = new RemoteViewsCacheKey(new FilterComparison(this.mIntent), this.mAppWidgetId);
        synchronized (sCachedRemoteViewsCaches) {
            if (sCachedRemoteViewsCaches.containsKey(key)) {
                this.mCache = (FixedSizeRemoteViewsCache) sCachedRemoteViewsCaches.get(key);
                synchronized (this.mCache.mMetaData) {
                    if (this.mCache.mMetaData.count > 0) {
                        this.mDataReady = true;
                    }
                }
            } else {
                this.mCache = new FixedSizeRemoteViewsCache(sDefaultCacheSize);
            }
            if (!this.mDataReady) {
                requestBindService();
            }
        }
    }

    protected void finalize() throws Throwable {
        try {
            if (this.mWorkerThread != null) {
                this.mWorkerThread.quit();
            }
            super.finalize();
        } catch (Throwable th) {
            super.finalize();
        }
    }

    public boolean isDataReady() {
        return this.mDataReady;
    }

    public void setRemoteViewsOnClickHandler(OnClickHandler handler) {
        this.mRemoteViewsOnClickHandler = handler;
    }

    public void saveRemoteViewsCache() {
        RemoteViewsCacheKey key = new RemoteViewsCacheKey(new FilterComparison(this.mIntent), this.mAppWidgetId);
        synchronized (sCachedRemoteViewsCaches) {
            if (sRemoteViewsCacheRemoveRunnables.containsKey(key)) {
                sCacheRemovalQueue.removeCallbacks((Runnable) sRemoteViewsCacheRemoveRunnables.get(key));
                sRemoteViewsCacheRemoveRunnables.remove(key);
            }
            synchronized (this.mCache.mMetaData) {
                int metaDataCount = this.mCache.mMetaData.count;
            }
            synchronized (this.mCache) {
                int numRemoteViewsCached = this.mCache.mIndexRemoteViews.size();
            }
            if (metaDataCount > 0 && numRemoteViewsCached > 0) {
                sCachedRemoteViewsCaches.put(key, this.mCache);
            }
            Runnable r = new C10261(key);
            sRemoteViewsCacheRemoveRunnables.put(key, r);
            sCacheRemovalQueue.postDelayed(r, 5000);
        }
    }

    private void loadNextIndexInBackground() {
        this.mWorkerQueue.post(new C10272());
    }

    private void processException(String method, Exception e) {
        Log.e(TAG, "Error in " + method + ": " + e.getMessage());
        RemoteViewsMetaData metaData = this.mCache.getMetaData();
        synchronized (metaData) {
            metaData.reset();
        }
        synchronized (this.mCache) {
            this.mCache.reset();
        }
        this.mMainQueue.post(new C10283());
    }

    private void updateTemporaryMetaData() {
        IRemoteViewsFactory factory = this.mServiceConnection.getRemoteViewsFactory();
        try {
            boolean hasStableIds = factory.hasStableIds();
            int viewTypeCount = factory.getViewTypeCount();
            int count = factory.getCount();
            RemoteViews loadingView = factory.getLoadingView();
            RemoteViews firstView = null;
            if (count > 0 && loadingView == null) {
                firstView = factory.getViewAt(sDefaultMessageType);
            }
            RemoteViewsMetaData tmpMetaData = this.mCache.getTemporaryMetaData();
            synchronized (tmpMetaData) {
                tmpMetaData.hasStableIds = hasStableIds;
                tmpMetaData.viewTypeCount = viewTypeCount + sUnbindServiceMessageType;
                tmpMetaData.count = count;
                tmpMetaData.setLoadingViewTemplates(loadingView, firstView);
            }
        } catch (RemoteException e) {
            processException("updateMetaData", e);
        } catch (RuntimeException e2) {
            processException("updateMetaData", e2);
        }
    }

    private void updateRemoteViews(int position, boolean notifyWhenLoaded) {
        IRemoteViewsFactory factory = this.mServiceConnection.getRemoteViewsFactory();
        try {
            RemoteViews remoteViews = factory.getViewAt(position);
            long itemId = factory.getItemId(position);
            if (remoteViews == null) {
                Log.e(TAG, "Error in updateRemoteViews(" + position + "): " + " null RemoteViews " + "returned from RemoteViewsFactory.");
                return;
            }
            boolean viewTypeInRange;
            int cacheCount;
            int layoutId = remoteViews.getLayoutId();
            RemoteViewsMetaData metaData = this.mCache.getMetaData();
            synchronized (metaData) {
                viewTypeInRange = metaData.isViewTypeInRange(layoutId);
                cacheCount = this.mCache.mMetaData.count;
            }
            synchronized (this.mCache) {
                if (viewTypeInRange) {
                    this.mCache.insert(position, remoteViews, itemId, getVisibleWindow(this.mVisibleWindowLowerBound, this.mVisibleWindowUpperBound, cacheCount));
                    RemoteViews rv = remoteViews;
                    if (notifyWhenLoaded) {
                        this.mMainQueue.post(new C10294(position, rv));
                    }
                } else {
                    Log.e(TAG, "Error: widget's RemoteViewsFactory returns more view types than  indicated by getViewTypeCount() ");
                }
            }
        } catch (RemoteException e) {
            Log.e(TAG, "Error in updateRemoteViews(" + position + "): " + e.getMessage());
        } catch (RuntimeException e2) {
            Log.e(TAG, "Error in updateRemoteViews(" + position + "): " + e2.getMessage());
        }
    }

    public Intent getRemoteViewsServiceIntent() {
        return this.mIntent;
    }

    public int getCount() {
        int i;
        RemoteViewsMetaData metaData = this.mCache.getMetaData();
        synchronized (metaData) {
            i = metaData.count;
        }
        return i;
    }

    public Object getItem(int position) {
        return null;
    }

    public long getItemId(int position) {
        long j;
        synchronized (this.mCache) {
            if (this.mCache.containsMetaDataAt(position)) {
                j = this.mCache.getMetaDataAt(position).itemId;
            } else {
                j = 0;
            }
        }
        return j;
    }

    public int getItemViewType(int position) {
        int mappedViewType;
        synchronized (this.mCache) {
            if (this.mCache.containsMetaDataAt(position)) {
                int typeId = this.mCache.getMetaDataAt(position).typeId;
                RemoteViewsMetaData metaData = this.mCache.getMetaData();
                synchronized (metaData) {
                    mappedViewType = metaData.getMappedViewType(typeId);
                }
            } else {
                mappedViewType = sDefaultMessageType;
            }
        }
        return mappedViewType;
    }

    private int getConvertViewTypeId(View convertView) {
        if (convertView == null) {
            return -1;
        }
        Object tag = convertView.getTag(16908346);
        if (tag != null) {
            return ((Integer) tag).intValue();
        }
        return -1;
    }

    public void setVisibleRangeHint(int lowerBound, int upperBound) {
        this.mVisibleWindowLowerBound = lowerBound;
        this.mVisibleWindowUpperBound = upperBound;
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        View layout;
        Exception e;
        RemoteViewsMetaData metaData;
        View loadingView;
        Throwable th;
        synchronized (this.mCache) {
            boolean isInCache = this.mCache.containsRemoteViewAt(position);
            boolean isConnected = this.mServiceConnection.isConnected();
            boolean hasNewItems = false;
            if (convertView != null && (convertView instanceof RemoteViewsFrameLayout)) {
                this.mRequestedViews.removeView((RemoteViewsFrameLayout) convertView);
            }
            if (isInCache || isConnected) {
                hasNewItems = this.mCache.queuePositionsToBePreloadedFromRequestedPosition(position);
            } else {
                requestBindService();
            }
            if (isInCache) {
                View layout2;
                View convertViewChild = null;
                int convertViewTypeId = sDefaultMessageType;
                if (convertView instanceof RemoteViewsFrameLayout) {
                    layout2 = (RemoteViewsFrameLayout) convertView;
                    convertViewChild = layout2.getChildAt(sDefaultMessageType);
                    convertViewTypeId = getConvertViewTypeId(convertViewChild);
                    layout = layout2;
                } else {
                    layout = null;
                }
                Context context = parent.getContext();
                RemoteViews rv = this.mCache.getRemoteViewsAt(position);
                int typeId = this.mCache.getMetaDataAt(position).typeId;
                if (layout == null) {
                    View remoteViewsFrameLayout = new RemoteViewsFrameLayout(context);
                } else if (convertViewTypeId == typeId) {
                    try {
                        rv.reapply(context, convertViewChild, this.mRemoteViewsOnClickHandler);
                        if (hasNewItems) {
                            loadNextIndexInBackground();
                        }
                        return layout;
                    } catch (Exception e2) {
                        e = e2;
                        layout2 = layout;
                        try {
                            Log.w(TAG, "Error inflating RemoteViews at position: " + position + ", using" + "loading view instead" + e);
                            metaData = this.mCache.getMetaData();
                            synchronized (metaData) {
                                loadingView = metaData.createLoadingView(position, convertView, parent, this.mCache, this.mLayoutInflater, this.mRemoteViewsOnClickHandler);
                            }
                            if (hasNewItems) {
                                loadNextIndexInBackground();
                            }
                            return loadingView;
                        } catch (Throwable th2) {
                            th = th2;
                        }
                    } catch (Throwable th3) {
                        th = th3;
                        layout2 = layout;
                        if (hasNewItems) {
                            loadNextIndexInBackground();
                        }
                        throw th;
                    }
                } else {
                    layout.removeAllViews();
                    layout2 = layout;
                }
                try {
                    View newView = rv.apply(context, parent, this.mRemoteViewsOnClickHandler);
                    newView.setTagInternal(16908346, new Integer(typeId));
                    layout2.addView(newView);
                    if (hasNewItems) {
                        loadNextIndexInBackground();
                    }
                    return layout2;
                } catch (Exception e3) {
                    e = e3;
                    Log.w(TAG, "Error inflating RemoteViews at position: " + position + ", using" + "loading view instead" + e);
                    metaData = this.mCache.getMetaData();
                    synchronized (metaData) {
                        loadingView = metaData.createLoadingView(position, convertView, parent, this.mCache, this.mLayoutInflater, this.mRemoteViewsOnClickHandler);
                    }
                    if (hasNewItems) {
                        loadNextIndexInBackground();
                    }
                    return loadingView;
                }
            }
            metaData = this.mCache.getMetaData();
            synchronized (metaData) {
                loadingView = metaData.createLoadingView(position, convertView, parent, this.mCache, this.mLayoutInflater, this.mRemoteViewsOnClickHandler);
            }
            this.mRequestedViews.add(position, loadingView);
            this.mCache.queueRequestedPositionToLoad(position);
            loadNextIndexInBackground();
            return loadingView;
        }
    }

    public int getViewTypeCount() {
        int i;
        RemoteViewsMetaData metaData = this.mCache.getMetaData();
        synchronized (metaData) {
            i = metaData.viewTypeCount;
        }
        return i;
    }

    public boolean hasStableIds() {
        boolean z;
        RemoteViewsMetaData metaData = this.mCache.getMetaData();
        synchronized (metaData) {
            z = metaData.hasStableIds;
        }
        return z;
    }

    public boolean isEmpty() {
        return getCount() <= 0;
    }

    private void onNotifyDataSetChanged() {
        try {
            int newCount;
            ArrayList<Integer> visibleWindow;
            this.mServiceConnection.getRemoteViewsFactory().onDataSetChanged();
            synchronized (this.mCache) {
                this.mCache.reset();
            }
            updateTemporaryMetaData();
            synchronized (this.mCache.getTemporaryMetaData()) {
                newCount = this.mCache.getTemporaryMetaData().count;
                visibleWindow = getVisibleWindow(this.mVisibleWindowLowerBound, this.mVisibleWindowUpperBound, newCount);
            }
            Iterator i$ = visibleWindow.iterator();
            while (i$.hasNext()) {
                int i = ((Integer) i$.next()).intValue();
                if (i < newCount) {
                    updateRemoteViews(i, false);
                }
            }
            this.mMainQueue.post(new C10305());
            this.mNotifyDataSetChangedAfterOnServiceConnected = false;
        } catch (RemoteException e) {
            Log.e(TAG, "Error in updateNotifyDataSetChanged(): " + e.getMessage());
        } catch (RuntimeException e2) {
            Log.e(TAG, "Error in updateNotifyDataSetChanged(): " + e2.getMessage());
        }
    }

    private ArrayList<Integer> getVisibleWindow(int lower, int upper, int count) {
        ArrayList<Integer> window = new ArrayList();
        if (!(lower == 0 && upper == 0) && lower >= 0 && upper >= 0) {
            int i;
            if (lower <= upper) {
                for (i = lower; i <= upper; i += sUnbindServiceMessageType) {
                    window.add(Integer.valueOf(i));
                }
            } else {
                for (i = lower; i < count; i += sUnbindServiceMessageType) {
                    window.add(Integer.valueOf(i));
                }
                for (i = sDefaultMessageType; i <= upper; i += sUnbindServiceMessageType) {
                    window.add(Integer.valueOf(i));
                }
            }
        }
        return window;
    }

    public void notifyDataSetChanged() {
        this.mMainQueue.removeMessages(sUnbindServiceMessageType);
        if (this.mServiceConnection.isConnected()) {
            this.mWorkerQueue.post(new C10316());
        } else if (!this.mNotifyDataSetChangedAfterOnServiceConnected) {
            this.mNotifyDataSetChangedAfterOnServiceConnected = true;
            requestBindService();
        }
    }

    void superNotifyDataSetChanged() {
        super.notifyDataSetChanged();
    }

    public boolean handleMessage(Message msg) {
        switch (msg.what) {
            case sUnbindServiceMessageType /*1*/:
                if (this.mServiceConnection.isConnected()) {
                    this.mServiceConnection.unbind(this.mContext, this.mAppWidgetId, this.mIntent);
                }
                return true;
            default:
                return false;
        }
    }

    private void enqueueDeferredUnbindServiceMessage() {
        this.mMainQueue.removeMessages(sUnbindServiceMessageType);
        this.mMainQueue.sendEmptyMessageDelayed(sUnbindServiceMessageType, 5000);
    }

    private boolean requestBindService() {
        if (!this.mServiceConnection.isConnected()) {
            this.mServiceConnection.bind(this.mContext, this.mAppWidgetId, this.mIntent);
        }
        this.mMainQueue.removeMessages(sUnbindServiceMessageType);
        return this.mServiceConnection.isConnected();
    }
}
