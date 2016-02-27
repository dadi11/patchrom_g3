package com.android.server.net;

import android.net.NetworkIdentity;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.HashSet;
import java.util.Iterator;

public class NetworkIdentitySet extends HashSet<NetworkIdentity> implements Comparable<NetworkIdentitySet> {
    private static final int VERSION_ADD_NETWORK_ID = 3;
    private static final int VERSION_ADD_ROAMING = 2;
    private static final int VERSION_INIT = 1;

    public NetworkIdentitySet(DataInputStream in) throws IOException {
        int version = in.readInt();
        int size = in.readInt();
        for (int i = 0; i < size; i += VERSION_INIT) {
            String networkId;
            if (version <= VERSION_INIT) {
                in.readInt();
            }
            int type = in.readInt();
            int subType = in.readInt();
            String subscriberId = readOptionalString(in);
            if (version >= VERSION_ADD_NETWORK_ID) {
                networkId = readOptionalString(in);
            } else {
                networkId = null;
            }
            if (version >= VERSION_ADD_ROAMING) {
                boolean roaming = in.readBoolean();
            }
            add(new NetworkIdentity(type, subType, subscriberId, networkId, false));
        }
    }

    public void writeToStream(DataOutputStream out) throws IOException {
        out.writeInt(VERSION_ADD_NETWORK_ID);
        out.writeInt(size());
        Iterator i$ = iterator();
        while (i$.hasNext()) {
            NetworkIdentity ident = (NetworkIdentity) i$.next();
            out.writeInt(ident.getType());
            out.writeInt(ident.getSubType());
            writeOptionalString(out, ident.getSubscriberId());
            writeOptionalString(out, ident.getNetworkId());
            out.writeBoolean(ident.getRoaming());
        }
    }

    private static void writeOptionalString(DataOutputStream out, String value) throws IOException {
        if (value != null) {
            out.writeByte(VERSION_INIT);
            out.writeUTF(value);
            return;
        }
        out.writeByte(0);
    }

    private static String readOptionalString(DataInputStream in) throws IOException {
        if (in.readByte() != null) {
            return in.readUTF();
        }
        return null;
    }

    public int compareTo(NetworkIdentitySet another) {
        if (isEmpty()) {
            return -1;
        }
        if (another.isEmpty()) {
            return VERSION_INIT;
        }
        return ((NetworkIdentity) iterator().next()).compareTo((NetworkIdentity) another.iterator().next());
    }
}
