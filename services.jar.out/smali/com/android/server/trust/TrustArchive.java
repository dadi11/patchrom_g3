package com.android.server.trust;

import android.content.ComponentName;
import android.os.SystemClock;
import android.util.TimeUtils;
import java.io.PrintWriter;
import java.util.ArrayDeque;
import java.util.Iterator;

public class TrustArchive {
    private static final int HISTORY_LIMIT = 200;
    private static final int TYPE_AGENT_CONNECTED = 4;
    private static final int TYPE_AGENT_DIED = 3;
    private static final int TYPE_AGENT_STOPPED = 5;
    private static final int TYPE_GRANT_TRUST = 0;
    private static final int TYPE_MANAGING_TRUST = 6;
    private static final int TYPE_REVOKE_TRUST = 1;
    private static final int TYPE_TRUST_TIMEOUT = 2;
    ArrayDeque<Event> mEvents;

    private static class Event {
        final ComponentName agent;
        final long duration;
        final long elapsedTimestamp;
        final boolean managingTrust;
        final String message;
        final int type;
        final int userId;
        final boolean userInitiated;

        private Event(int type, int userId, ComponentName agent, String message, long duration, boolean userInitiated, boolean managingTrust) {
            this.type = type;
            this.userId = userId;
            this.agent = agent;
            this.elapsedTimestamp = SystemClock.elapsedRealtime();
            this.message = message;
            this.duration = duration;
            this.userInitiated = userInitiated;
            this.managingTrust = managingTrust;
        }
    }

    public TrustArchive() {
        this.mEvents = new ArrayDeque();
    }

    public void logGrantTrust(int userId, ComponentName agent, String message, long duration, boolean userInitiated) {
        addEvent(new Event(userId, agent, message, duration, userInitiated, false, null));
    }

    public void logRevokeTrust(int userId, ComponentName agent) {
        addEvent(new Event(userId, agent, null, 0, false, false, null));
    }

    public void logTrustTimeout(int userId, ComponentName agent) {
        addEvent(new Event(userId, agent, null, 0, false, false, null));
    }

    public void logAgentDied(int userId, ComponentName agent) {
        addEvent(new Event(userId, agent, null, 0, false, false, null));
    }

    public void logAgentConnected(int userId, ComponentName agent) {
        addEvent(new Event(userId, agent, null, 0, false, false, null));
    }

    public void logAgentStopped(int userId, ComponentName agent) {
        addEvent(new Event(userId, agent, null, 0, false, false, null));
    }

    public void logManagingTrust(int userId, ComponentName agent, boolean managing) {
        addEvent(new Event(userId, agent, null, 0, false, managing, null));
    }

    private void addEvent(Event e) {
        if (this.mEvents.size() >= HISTORY_LIMIT) {
            this.mEvents.removeFirst();
        }
        this.mEvents.addLast(e);
    }

    public void dump(PrintWriter writer, int limit, int userId, String linePrefix, boolean duplicateSimpleNames) {
        int count = TYPE_GRANT_TRUST;
        Iterator<Event> iter = this.mEvents.descendingIterator();
        while (iter.hasNext() && count < limit) {
            Event ev = (Event) iter.next();
            if (userId == -1 || userId == ev.userId) {
                writer.print(linePrefix);
                Object[] objArr = new Object[TYPE_AGENT_DIED];
                objArr[TYPE_GRANT_TRUST] = Integer.valueOf(count);
                objArr[TYPE_REVOKE_TRUST] = formatElapsed(ev.elapsedTimestamp);
                objArr[TYPE_TRUST_TIMEOUT] = dumpType(ev.type);
                writer.printf("#%-2d %s %s: ", objArr);
                if (userId == -1) {
                    writer.print("user=");
                    writer.print(ev.userId);
                    writer.print(", ");
                }
                writer.print("agent=");
                if (duplicateSimpleNames) {
                    writer.print(ev.agent.flattenToShortString());
                } else {
                    writer.print(getSimpleName(ev.agent));
                }
                switch (ev.type) {
                    case TYPE_GRANT_TRUST /*0*/:
                        String str = ", message=\"%s\", duration=%s, initiatedByUser=%d";
                        Object[] objArr2 = new Object[TYPE_AGENT_DIED];
                        objArr2[TYPE_GRANT_TRUST] = ev.message;
                        objArr2[TYPE_REVOKE_TRUST] = formatDuration(ev.duration);
                        objArr2[TYPE_TRUST_TIMEOUT] = Integer.valueOf(ev.userInitiated ? TYPE_REVOKE_TRUST : TYPE_GRANT_TRUST);
                        writer.printf(str, objArr2);
                        break;
                    case TYPE_MANAGING_TRUST /*6*/:
                        writer.printf(", managingTrust=" + ev.managingTrust, new Object[TYPE_GRANT_TRUST]);
                        break;
                }
                writer.println();
                count += TYPE_REVOKE_TRUST;
            }
        }
    }

    public static String formatDuration(long duration) {
        StringBuilder sb = new StringBuilder();
        TimeUtils.formatDuration(duration, sb);
        return sb.toString();
    }

    private static String formatElapsed(long elapsed) {
        return TimeUtils.logTimeOfDay((elapsed - SystemClock.elapsedRealtime()) + System.currentTimeMillis());
    }

    static String getSimpleName(ComponentName cn) {
        String name = cn.getClassName();
        int idx = name.lastIndexOf(46);
        if (idx >= name.length() || idx < 0) {
            return name;
        }
        return name.substring(idx + TYPE_REVOKE_TRUST);
    }

    private String dumpType(int type) {
        switch (type) {
            case TYPE_GRANT_TRUST /*0*/:
                return "GrantTrust";
            case TYPE_REVOKE_TRUST /*1*/:
                return "RevokeTrust";
            case TYPE_TRUST_TIMEOUT /*2*/:
                return "TrustTimeout";
            case TYPE_AGENT_DIED /*3*/:
                return "AgentDied";
            case TYPE_AGENT_CONNECTED /*4*/:
                return "AgentConnected";
            case TYPE_AGENT_STOPPED /*5*/:
                return "AgentStopped";
            case TYPE_MANAGING_TRUST /*6*/:
                return "ManagingTrust";
            default:
                return "Unknown(" + type + ")";
        }
    }
}
