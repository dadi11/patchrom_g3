package android.telecom;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import java.util.Locale;

public final class AudioState implements Parcelable {
    public static final Creator<AudioState> CREATOR;
    public static final int ROUTE_ALL = 15;
    public static final int ROUTE_BLUETOOTH = 2;
    public static final int ROUTE_EARPIECE = 1;
    public static final int ROUTE_SPEAKER = 8;
    public static final int ROUTE_WIRED_HEADSET = 4;
    public static final int ROUTE_WIRED_OR_EARPIECE = 5;
    public final boolean isMuted;
    public final int route;
    public final int supportedRouteMask;

    /* renamed from: android.telecom.AudioState.1 */
    static class C07261 implements Creator<AudioState> {
        C07261() {
        }

        public AudioState createFromParcel(Parcel source) {
            return new AudioState(source.readByte() != null, source.readInt(), source.readInt());
        }

        public AudioState[] newArray(int size) {
            return new AudioState[size];
        }
    }

    public AudioState(boolean muted, int route, int supportedRouteMask) {
        this.isMuted = muted;
        this.route = route;
        this.supportedRouteMask = supportedRouteMask;
    }

    public AudioState(AudioState state) {
        this.isMuted = state.isMuted();
        this.route = state.getRoute();
        this.supportedRouteMask = state.getSupportedRouteMask();
    }

    public boolean equals(Object obj) {
        if (obj == null || !(obj instanceof AudioState)) {
            return false;
        }
        AudioState state = (AudioState) obj;
        if (isMuted() == state.isMuted() && getRoute() == state.getRoute() && getSupportedRouteMask() == state.getSupportedRouteMask()) {
            return true;
        }
        return false;
    }

    public String toString() {
        return String.format(Locale.US, "[AudioState isMuted: %b, route: %s, supportedRouteMask: %s]", new Object[]{Boolean.valueOf(this.isMuted), audioRouteToString(this.route), audioRouteToString(this.supportedRouteMask)});
    }

    public static String audioRouteToString(int route) {
        if (route == 0 || (route & -16) != 0) {
            return "UNKNOWN";
        }
        StringBuffer buffer = new StringBuffer();
        if ((route & ROUTE_EARPIECE) == ROUTE_EARPIECE) {
            listAppend(buffer, "EARPIECE");
        }
        if ((route & ROUTE_BLUETOOTH) == ROUTE_BLUETOOTH) {
            listAppend(buffer, "BLUETOOTH");
        }
        if ((route & ROUTE_WIRED_HEADSET) == ROUTE_WIRED_HEADSET) {
            listAppend(buffer, "WIRED_HEADSET");
        }
        if ((route & ROUTE_SPEAKER) == ROUTE_SPEAKER) {
            listAppend(buffer, "SPEAKER");
        }
        return buffer.toString();
    }

    private static void listAppend(StringBuffer buffer, String str) {
        if (buffer.length() > 0) {
            buffer.append(", ");
        }
        buffer.append(str);
    }

    static {
        CREATOR = new C07261();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel destination, int flags) {
        destination.writeByte((byte) (this.isMuted ? ROUTE_EARPIECE : 0));
        destination.writeInt(this.route);
        destination.writeInt(this.supportedRouteMask);
    }

    public boolean isMuted() {
        return this.isMuted;
    }

    public int getRoute() {
        return this.route;
    }

    public int getSupportedRouteMask() {
        return this.supportedRouteMask;
    }
}
