package android.net;

import android.content.Context;
import android.net.SamplingDataTracker.SamplingSnapshot;
import android.os.Handler;
import android.os.Messenger;
import android.view.KeyEvent;
import com.android.internal.util.Preconditions;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class BaseNetworkStateTracker implements NetworkStateTracker {
    public static final String PROP_TCP_BUFFER_UNKNOWN = "net.tcp.buffersize.unknown";
    public static final String PROP_TCP_BUFFER_WIFI = "net.tcp.buffersize.wifi";
    protected Context mContext;
    private AtomicBoolean mDefaultRouteSet;
    protected LinkProperties mLinkProperties;
    protected Network mNetwork;
    protected NetworkCapabilities mNetworkCapabilities;
    protected NetworkInfo mNetworkInfo;
    private AtomicBoolean mPrivateDnsRouteSet;
    private Handler mTarget;
    private AtomicBoolean mTeardownRequested;

    public BaseNetworkStateTracker(int networkType) {
        this.mNetwork = new Network(0);
        this.mTeardownRequested = new AtomicBoolean(false);
        this.mPrivateDnsRouteSet = new AtomicBoolean(false);
        this.mDefaultRouteSet = new AtomicBoolean(false);
        this.mNetworkInfo = new NetworkInfo(networkType, -1, ConnectivityManager.getNetworkTypeName(networkType), null);
        this.mLinkProperties = new LinkProperties();
        this.mNetworkCapabilities = new NetworkCapabilities();
    }

    protected BaseNetworkStateTracker() {
        this.mNetwork = new Network(0);
        this.mTeardownRequested = new AtomicBoolean(false);
        this.mPrivateDnsRouteSet = new AtomicBoolean(false);
        this.mDefaultRouteSet = new AtomicBoolean(false);
    }

    @Deprecated
    protected Handler getTargetHandler() {
        return this.mTarget;
    }

    protected final void dispatchStateChanged() {
        this.mTarget.obtainMessage(KeyEvent.META_META_MASK, getNetworkInfo()).sendToTarget();
    }

    protected final void dispatchConfigurationChanged() {
        this.mTarget.obtainMessage(NetworkStateTracker.EVENT_CONFIGURATION_CHANGED, getNetworkInfo()).sendToTarget();
    }

    public void startMonitoring(Context context, Handler target) {
        this.mContext = (Context) Preconditions.checkNotNull(context);
        this.mTarget = (Handler) Preconditions.checkNotNull(target);
        startMonitoringInternal();
    }

    protected void startMonitoringInternal() {
    }

    public NetworkInfo getNetworkInfo() {
        return new NetworkInfo(this.mNetworkInfo);
    }

    public LinkProperties getLinkProperties() {
        return new LinkProperties(this.mLinkProperties);
    }

    public NetworkCapabilities getNetworkCapabilities() {
        return new NetworkCapabilities(this.mNetworkCapabilities);
    }

    public LinkQualityInfo getLinkQualityInfo() {
        return null;
    }

    public void captivePortalCheckCompleted(boolean isCaptivePortal) {
    }

    public boolean setRadio(boolean turnOn) {
        return true;
    }

    public boolean isAvailable() {
        return this.mNetworkInfo.isAvailable();
    }

    public void setUserDataEnable(boolean enabled) {
    }

    public void setPolicyDataEnable(boolean enabled) {
    }

    public boolean isPrivateDnsRouteSet() {
        return this.mPrivateDnsRouteSet.get();
    }

    public void privateDnsRouteSet(boolean enabled) {
        this.mPrivateDnsRouteSet.set(enabled);
    }

    public boolean isDefaultRouteSet() {
        return this.mDefaultRouteSet.get();
    }

    public void defaultRouteSet(boolean enabled) {
        this.mDefaultRouteSet.set(enabled);
    }

    public boolean isTeardownRequested() {
        return this.mTeardownRequested.get();
    }

    public void setTeardownRequested(boolean isRequested) {
        this.mTeardownRequested.set(isRequested);
    }

    public void setDependencyMet(boolean met) {
    }

    public void supplyMessenger(Messenger messenger) {
    }

    public String getNetworkInterfaceName() {
        if (this.mLinkProperties != null) {
            return this.mLinkProperties.getInterfaceName();
        }
        return null;
    }

    public void startSampling(SamplingSnapshot s) {
    }

    public void stopSampling(SamplingSnapshot s) {
    }

    public void setNetId(int netId) {
        this.mNetwork = new Network(netId);
    }

    public Network getNetwork() {
        return this.mNetwork;
    }
}
