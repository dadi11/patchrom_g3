package com.android.server.twilight;

import android.os.Handler;

public interface TwilightManager {
    TwilightState getCurrentState();

    void registerListener(TwilightListener twilightListener, Handler handler);
}
