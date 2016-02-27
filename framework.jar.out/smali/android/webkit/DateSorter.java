package android.webkit;

import android.content.Context;
import android.content.res.Resources;
import android.net.ProxyInfo;
import java.util.Calendar;
import java.util.Locale;
import libcore.icu.LocaleData;

public class DateSorter {
    public static final int DAY_COUNT = 5;
    private static final String LOGTAG = "webkit";
    private static final int NUM_DAYS_AGO = 7;
    private long[] mBins;
    private String[] mLabels;

    public DateSorter(Context context) {
        this.mBins = new long[4];
        this.mLabels = new String[DAY_COUNT];
        Resources resources = context.getResources();
        Calendar c = Calendar.getInstance();
        beginningOfDay(c);
        this.mBins[0] = c.getTimeInMillis();
        c.add(6, -1);
        this.mBins[1] = c.getTimeInMillis();
        c.add(6, -6);
        this.mBins[2] = c.getTimeInMillis();
        c.add(6, NUM_DAYS_AGO);
        c.add(2, -1);
        this.mBins[3] = c.getTimeInMillis();
        Locale locale = resources.getConfiguration().locale;
        if (locale == null) {
            locale = Locale.getDefault();
        }
        LocaleData localeData = LocaleData.get(locale);
        this.mLabels[0] = localeData.today;
        this.mLabels[1] = localeData.yesterday;
        String format = resources.getQuantityString(18087940, NUM_DAYS_AGO);
        this.mLabels[2] = String.format(format, new Object[]{Integer.valueOf(NUM_DAYS_AGO)});
        this.mLabels[3] = context.getString(17040472);
        this.mLabels[4] = context.getString(17040473);
    }

    public int getIndex(long time) {
        for (int i = 0; i < 4; i++) {
            if (time > this.mBins[i]) {
                return i;
            }
        }
        return 4;
    }

    public String getLabel(int index) {
        if (index < 0 || index >= DAY_COUNT) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        }
        return this.mLabels[index];
    }

    public long getBoundary(int index) {
        if (index < 0 || index > 4) {
            index = 0;
        }
        if (index == 4) {
            return Long.MIN_VALUE;
        }
        return this.mBins[index];
    }

    private void beginningOfDay(Calendar c) {
        c.set(11, 0);
        c.set(12, 0);
        c.set(13, 0);
        c.set(14, 0);
    }
}
