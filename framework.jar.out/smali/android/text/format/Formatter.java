package android.text.format;

import android.content.Context;
import android.hardware.SensorManager;
import android.net.NetworkUtils;
import android.net.ProxyInfo;
import android.view.WindowManager.LayoutParams;

public final class Formatter {
    private static final int MILLIS_PER_MINUTE = 60000;
    private static final int SECONDS_PER_DAY = 86400;
    private static final int SECONDS_PER_HOUR = 3600;
    private static final int SECONDS_PER_MINUTE = 60;

    public static String formatFileSize(Context context, long number) {
        return formatFileSize(context, number, false);
    }

    public static String formatShortFileSize(Context context, long number) {
        return formatFileSize(context, number, true);
    }

    private static String formatFileSize(Context context, long number, boolean shorter) {
        if (context == null) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        }
        String value;
        float result = (float) number;
        int suffix = 17039477;
        if (result > 900.0f) {
            suffix = 17039478;
            result /= 1024.0f;
        }
        if (result > 900.0f) {
            suffix = 17039479;
            result /= 1024.0f;
        }
        if (result > 900.0f) {
            suffix = 17039480;
            result /= 1024.0f;
        }
        if (result > 900.0f) {
            suffix = 17039481;
            result /= 1024.0f;
        }
        if (result > 900.0f) {
            suffix = 17039482;
            result /= 1024.0f;
        }
        if (result < LayoutParams.BRIGHTNESS_OVERRIDE_FULL) {
            value = String.format("%.2f", new Object[]{Float.valueOf(result)});
        } else if (result < 10.0f) {
            if (shorter) {
                value = String.format("%.1f", new Object[]{Float.valueOf(result)});
            } else {
                value = String.format("%.2f", new Object[]{Float.valueOf(result)});
            }
        } else if (result >= SensorManager.LIGHT_CLOUDY) {
            value = String.format("%.0f", new Object[]{Float.valueOf(result)});
        } else if (shorter) {
            value = String.format("%.0f", new Object[]{Float.valueOf(result)});
        } else {
            value = String.format("%.2f", new Object[]{Float.valueOf(result)});
        }
        return context.getResources().getString(17039483, value, context.getString(suffix));
    }

    @Deprecated
    public static String formatIpAddress(int ipv4Address) {
        return NetworkUtils.intToInetAddress(ipv4Address).getHostAddress();
    }

    public static String formatShortElapsedTime(Context context, long millis) {
        long secondsLong = millis / 1000;
        int days = 0;
        int hours = 0;
        int minutes = 0;
        if (secondsLong >= 86400) {
            days = (int) (secondsLong / 86400);
            secondsLong -= (long) (SECONDS_PER_DAY * days);
        }
        if (secondsLong >= 3600) {
            hours = (int) (secondsLong / 3600);
            secondsLong -= (long) (hours * SECONDS_PER_HOUR);
        }
        if (secondsLong >= 60) {
            minutes = (int) (secondsLong / 60);
            secondsLong -= (long) (minutes * SECONDS_PER_MINUTE);
        }
        int seconds = (int) secondsLong;
        if (days >= 2) {
            return context.getString(17039484, Integer.valueOf(days + ((hours + 12) / 24)));
        } else if (days > 0) {
            if (hours == 1) {
                return context.getString(17039486, Integer.valueOf(days), Integer.valueOf(hours));
            }
            return context.getString(17039485, Integer.valueOf(days), Integer.valueOf(hours));
        } else if (hours >= 2) {
            return context.getString(17039487, Integer.valueOf(hours + ((minutes + 30) / SECONDS_PER_MINUTE)));
        } else if (hours > 0) {
            if (minutes == 1) {
                return context.getString(17039489, Integer.valueOf(hours), Integer.valueOf(minutes));
            }
            return context.getString(17039488, Integer.valueOf(hours), Integer.valueOf(minutes));
        } else if (minutes >= 2) {
            return context.getString(17039490, Integer.valueOf(minutes + ((seconds + 30) / SECONDS_PER_MINUTE)));
        } else if (minutes > 0) {
            if (seconds == 1) {
                return context.getString(17039493, Integer.valueOf(minutes), Integer.valueOf(seconds));
            }
            return context.getString(17039492, Integer.valueOf(minutes), Integer.valueOf(seconds));
        } else if (seconds == 1) {
            return context.getString(17039495, Integer.valueOf(seconds));
        } else {
            return context.getString(17039494, Integer.valueOf(seconds));
        }
    }

    public static String formatShortElapsedTimeRoundingUpToMinutes(Context context, long millis) {
        long minutesRoundedUp = ((millis + DateUtils.MINUTE_IN_MILLIS) - 1) / DateUtils.MINUTE_IN_MILLIS;
        if (minutesRoundedUp == 0) {
            return context.getString(17039490, Integer.valueOf(0));
        } else if (minutesRoundedUp != 1) {
            return formatShortElapsedTime(context, minutesRoundedUp * DateUtils.MINUTE_IN_MILLIS);
        } else {
            return context.getString(17039491, Integer.valueOf(1));
        }
    }
}
