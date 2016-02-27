package com.android.internal.telephony;

import java.util.ArrayList;
import java.util.Iterator;

public abstract class IntRangeManager {
    private static final int INITIAL_CLIENTS_ARRAY_SIZE = 4;
    private ArrayList<IntRange> mRanges;

    private class ClientRange {
        final String mClient;
        final int mEndId;
        final int mStartId;

        ClientRange(int startId, int endId, String client) {
            this.mStartId = startId;
            this.mEndId = endId;
            this.mClient = client;
        }

        public boolean equals(Object o) {
            if (o == null || !(o instanceof ClientRange)) {
                return false;
            }
            ClientRange other = (ClientRange) o;
            if (this.mStartId == other.mStartId && this.mEndId == other.mEndId && this.mClient.equals(other.mClient)) {
                return true;
            }
            return false;
        }

        public int hashCode() {
            return (((this.mStartId * 31) + this.mEndId) * 31) + this.mClient.hashCode();
        }
    }

    private class IntRange {
        final ArrayList<ClientRange> mClients;
        int mEndId;
        int mStartId;

        IntRange(int startId, int endId, String client) {
            this.mStartId = startId;
            this.mEndId = endId;
            this.mClients = new ArrayList(IntRangeManager.INITIAL_CLIENTS_ARRAY_SIZE);
            this.mClients.add(new ClientRange(startId, endId, client));
        }

        IntRange(ClientRange clientRange) {
            this.mStartId = clientRange.mStartId;
            this.mEndId = clientRange.mEndId;
            this.mClients = new ArrayList(IntRangeManager.INITIAL_CLIENTS_ARRAY_SIZE);
            this.mClients.add(clientRange);
        }

        IntRange(IntRange intRange, int numElements) {
            this.mStartId = intRange.mStartId;
            this.mEndId = intRange.mEndId;
            this.mClients = new ArrayList(intRange.mClients.size());
            for (int i = 0; i < numElements; i++) {
                this.mClients.add(intRange.mClients.get(i));
            }
        }

        void insert(ClientRange range) {
            int len = this.mClients.size();
            int insert = -1;
            for (int i = 0; i < len; i++) {
                ClientRange nextRange = (ClientRange) this.mClients.get(i);
                if (range.mStartId <= nextRange.mStartId) {
                    if (!range.equals(nextRange)) {
                        if (range.mStartId == nextRange.mStartId && range.mEndId > nextRange.mEndId) {
                            insert = i + 1;
                            if (insert >= len) {
                                break;
                            }
                        } else {
                            this.mClients.add(i, range);
                            return;
                        }
                    }
                    return;
                }
            }
            if (insert == -1 || insert >= len) {
                this.mClients.add(range);
            } else {
                this.mClients.add(insert, range);
            }
        }
    }

    protected abstract void addRange(int i, int i2, boolean z);

    protected abstract boolean finishUpdate();

    protected abstract void startUpdate();

    protected IntRangeManager() {
        this.mRanges = new ArrayList();
    }

    public synchronized boolean enableRange(int startId, int endId, String client) {
        boolean z;
        int len = this.mRanges.size();
        if (len != 0) {
            int startIndex = 0;
            while (startIndex < len) {
                IntRange range = (IntRange) this.mRanges.get(startIndex);
                if (startId >= range.mStartId && endId <= range.mEndId) {
                    range.insert(new ClientRange(startId, endId, client));
                    z = true;
                    break;
                }
                int newRangeEndId;
                if (startId - 1 == range.mEndId) {
                    newRangeEndId = endId;
                    IntRange nextRange = null;
                    if (startIndex + 1 < len) {
                        nextRange = (IntRange) this.mRanges.get(startIndex + 1);
                        if (nextRange.mStartId - 1 <= endId) {
                            if (endId <= nextRange.mEndId) {
                                newRangeEndId = nextRange.mStartId - 1;
                            }
                        } else {
                            nextRange = null;
                        }
                    }
                    if (tryAddRanges(startId, newRangeEndId, true)) {
                        range.mEndId = endId;
                        range.insert(new ClientRange(startId, endId, client));
                        if (nextRange != null) {
                            if (range.mEndId < nextRange.mEndId) {
                                range.mEndId = nextRange.mEndId;
                            }
                            range.mClients.addAll(nextRange.mClients);
                            this.mRanges.remove(nextRange);
                        }
                        z = true;
                    } else {
                        z = false;
                    }
                } else {
                    int endIndex;
                    IntRange endRange;
                    int joinIndex;
                    int i;
                    IntRange joinRange;
                    if (startId < range.mStartId) {
                        if (endId + 1 >= range.mStartId) {
                            if (endId <= range.mEndId) {
                                if (tryAddRanges(startId, range.mStartId - 1, true)) {
                                    range.mStartId = startId;
                                    range.mClients.add(0, new ClientRange(startId, endId, client));
                                    z = true;
                                } else {
                                    z = false;
                                }
                            } else {
                                endIndex = startIndex + 1;
                                while (endIndex < len) {
                                    endRange = (IntRange) this.mRanges.get(endIndex);
                                    if (endId + 1 >= endRange.mStartId) {
                                        if (endId <= endRange.mEndId) {
                                            if (tryAddRanges(startId, endRange.mStartId - 1, true)) {
                                                range.mStartId = startId;
                                                range.mEndId = endRange.mEndId;
                                                range.mClients.add(0, new ClientRange(startId, endId, client));
                                                joinIndex = startIndex + 1;
                                                for (i = joinIndex; i <= endIndex; i++) {
                                                    joinRange = (IntRange) this.mRanges.get(joinIndex);
                                                    range.mClients.addAll(joinRange.mClients);
                                                    this.mRanges.remove(joinRange);
                                                }
                                                z = true;
                                            } else {
                                                z = false;
                                            }
                                        } else {
                                            endIndex++;
                                        }
                                    } else if (tryAddRanges(startId, endId, true)) {
                                        range.mStartId = startId;
                                        range.mEndId = endId;
                                        range.mClients.add(0, new ClientRange(startId, endId, client));
                                        joinIndex = startIndex + 1;
                                        for (i = joinIndex; i < endIndex; i++) {
                                            joinRange = (IntRange) this.mRanges.get(joinIndex);
                                            range.mClients.addAll(joinRange.mClients);
                                            this.mRanges.remove(joinRange);
                                        }
                                        z = true;
                                    } else {
                                        z = false;
                                    }
                                }
                                if (tryAddRanges(startId, endId, true)) {
                                    range.mStartId = startId;
                                    range.mEndId = endId;
                                    range.mClients.add(0, new ClientRange(startId, endId, client));
                                    joinIndex = startIndex + 1;
                                    for (i = joinIndex; i < len; i++) {
                                        joinRange = (IntRange) this.mRanges.get(joinIndex);
                                        range.mClients.addAll(joinRange.mClients);
                                        this.mRanges.remove(joinRange);
                                    }
                                    z = true;
                                } else {
                                    z = false;
                                }
                            }
                        } else if (tryAddRanges(startId, endId, true)) {
                            this.mRanges.add(startIndex, new IntRange(startId, endId, client));
                            z = true;
                        } else {
                            z = false;
                        }
                    } else {
                        if (startId + 1 <= range.mEndId) {
                            if (endId <= range.mEndId) {
                                range.insert(new ClientRange(startId, endId, client));
                                z = true;
                            } else {
                                endIndex = startIndex;
                                for (int testIndex = startIndex + 1; testIndex < len; testIndex++) {
                                    if (endId + 1 < ((IntRange) this.mRanges.get(testIndex)).mStartId) {
                                        break;
                                    }
                                    endIndex = testIndex;
                                }
                                if (endIndex == startIndex) {
                                    if (tryAddRanges(range.mEndId + 1, endId, true)) {
                                        range.mEndId = endId;
                                        range.insert(new ClientRange(startId, endId, client));
                                        z = true;
                                    } else {
                                        z = false;
                                    }
                                } else {
                                    endRange = (IntRange) this.mRanges.get(endIndex);
                                    if (endId <= endRange.mEndId) {
                                        newRangeEndId = endRange.mStartId - 1;
                                    } else {
                                        newRangeEndId = endId;
                                    }
                                    if (tryAddRanges(range.mEndId + 1, newRangeEndId, true)) {
                                        if (endId <= endRange.mEndId) {
                                            newRangeEndId = endRange.mEndId;
                                        } else {
                                            newRangeEndId = endId;
                                        }
                                        range.mEndId = newRangeEndId;
                                        range.insert(new ClientRange(startId, endId, client));
                                        joinIndex = startIndex + 1;
                                        for (i = joinIndex; i <= endIndex; i++) {
                                            joinRange = (IntRange) this.mRanges.get(joinIndex);
                                            range.mClients.addAll(joinRange.mClients);
                                            this.mRanges.remove(joinRange);
                                        }
                                        z = true;
                                    } else {
                                        z = false;
                                    }
                                }
                            }
                        } else {
                            startIndex++;
                        }
                    }
                }
            }
            if (tryAddRanges(startId, endId, true)) {
                this.mRanges.add(new IntRange(startId, endId, client));
                z = true;
            } else {
                z = false;
            }
        } else if (tryAddRanges(startId, endId, true)) {
            this.mRanges.add(new IntRange(startId, endId, client));
            z = true;
        } else {
            z = false;
        }
        return z;
    }

    public synchronized boolean disableRange(int startId, int endId, String client) {
        boolean z;
        int len = this.mRanges.size();
        for (int i = 0; i < len; i++) {
            IntRange range = (IntRange) this.mRanges.get(i);
            if (startId < range.mStartId) {
                z = false;
                break;
            }
            if (endId <= range.mEndId) {
                ArrayList<ClientRange> clients = range.mClients;
                int crLength = clients.size();
                ClientRange cr;
                int i2;
                if (crLength == 1) {
                    cr = (ClientRange) clients.get(0);
                    i2 = cr.mStartId;
                    if (r0 == startId) {
                        i2 = cr.mEndId;
                        if (r0 == endId) {
                            if (cr.mClient.equals(client)) {
                                this.mRanges.remove(i);
                                if (updateRanges()) {
                                    z = true;
                                } else {
                                    this.mRanges.add(i, range);
                                    z = false;
                                }
                            }
                        }
                    }
                    z = false;
                } else {
                    int largestEndId = Integer.MIN_VALUE;
                    boolean updateStarted = false;
                    for (int crIndex = 0; crIndex < crLength; crIndex++) {
                        cr = (ClientRange) clients.get(crIndex);
                        i2 = cr.mStartId;
                        if (r0 == startId) {
                            i2 = cr.mEndId;
                            if (r0 == endId) {
                                if (cr.mClient.equals(client)) {
                                    if (crIndex == crLength - 1) {
                                        i2 = range.mEndId;
                                        if (r0 == largestEndId) {
                                            clients.remove(crIndex);
                                            z = true;
                                        } else {
                                            clients.remove(crIndex);
                                            range.mEndId = largestEndId;
                                            if (updateRanges()) {
                                                z = true;
                                            } else {
                                                clients.add(crIndex, cr);
                                                range.mEndId = cr.mEndId;
                                                z = false;
                                            }
                                        }
                                    } else {
                                        IntRange rangeCopy = new IntRange(range, crIndex);
                                        if (crIndex == 0) {
                                            int nextStartId = ((ClientRange) clients.get(1)).mStartId;
                                            i2 = range.mStartId;
                                            if (nextStartId != r0) {
                                                updateStarted = true;
                                                rangeCopy.mStartId = nextStartId;
                                            }
                                            largestEndId = ((ClientRange) clients.get(1)).mEndId;
                                        }
                                        ArrayList<IntRange> newRanges = new ArrayList();
                                        IntRange currentRange = rangeCopy;
                                        for (int nextIndex = crIndex + 1; nextIndex < crLength; nextIndex++) {
                                            ClientRange nextCr = (ClientRange) clients.get(nextIndex);
                                            i2 = nextCr.mStartId;
                                            if (r0 > largestEndId + 1) {
                                                updateStarted = true;
                                                currentRange.mEndId = largestEndId;
                                                newRanges.add(currentRange);
                                                currentRange = new IntRange(nextCr);
                                            } else {
                                                if (currentRange.mEndId < nextCr.mEndId) {
                                                    currentRange.mEndId = nextCr.mEndId;
                                                }
                                                currentRange.mClients.add(nextCr);
                                            }
                                            i2 = nextCr.mEndId;
                                            if (r0 > largestEndId) {
                                                largestEndId = nextCr.mEndId;
                                            }
                                        }
                                        if (largestEndId < endId) {
                                            updateStarted = true;
                                            currentRange.mEndId = largestEndId;
                                        }
                                        newRanges.add(currentRange);
                                        this.mRanges.remove(i);
                                        this.mRanges.addAll(i, newRanges);
                                        if (!updateStarted || updateRanges()) {
                                            z = true;
                                        } else {
                                            this.mRanges.removeAll(newRanges);
                                            this.mRanges.add(i, range);
                                            z = false;
                                        }
                                    }
                                }
                            }
                        }
                        i2 = cr.mEndId;
                        if (r0 > largestEndId) {
                            largestEndId = cr.mEndId;
                        }
                    }
                    continue;
                }
            }
        }
        z = false;
        return z;
    }

    public boolean updateRanges() {
        startUpdate();
        populateAllRanges();
        return finishUpdate();
    }

    protected boolean tryAddRanges(int startId, int endId, boolean selected) {
        startUpdate();
        populateAllRanges();
        addRange(startId, endId, selected);
        return finishUpdate();
    }

    public boolean isEmpty() {
        return this.mRanges.isEmpty();
    }

    private void populateAllRanges() {
        Iterator<IntRange> itr = this.mRanges.iterator();
        while (itr.hasNext()) {
            IntRange currRange = (IntRange) itr.next();
            addRange(currRange.mStartId, currRange.mEndId, true);
        }
    }

    private void populateAllClientRanges() {
        int len = this.mRanges.size();
        for (int i = 0; i < len; i++) {
            IntRange range = (IntRange) this.mRanges.get(i);
            int clientLen = range.mClients.size();
            for (int j = 0; j < clientLen; j++) {
                ClientRange nextRange = (ClientRange) range.mClients.get(j);
                addRange(nextRange.mStartId, nextRange.mEndId, true);
            }
        }
    }
}
