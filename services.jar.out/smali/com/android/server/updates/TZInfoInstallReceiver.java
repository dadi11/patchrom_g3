package com.android.server.updates;

import android.util.Base64;
import java.io.IOException;

public class TZInfoInstallReceiver extends ConfigUpdateInstallReceiver {
    public TZInfoInstallReceiver() {
        super("/data/misc/zoneinfo/", "tzdata", "metadata/", "version");
    }

    protected void install(byte[] encodedContent, int version) throws IOException {
        super.install(Base64.decode(encodedContent, 0), version);
    }
}
