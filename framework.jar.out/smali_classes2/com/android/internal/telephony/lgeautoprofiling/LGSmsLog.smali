.class public Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;
.super Ljava/lang/Object;
.source "LGSmsLog.java"


# static fields
.field public static final DEBUG:I = 0x2

.field private static final DISABLELOG:I

.field public static final ERROR:I = 0x10

.field public static final FLOW:I = 0x20

.field public static final INFO:I = 0x4

.field public static final PRIVACY:I = 0x40

.field private static final PROPERTY_DISABLELOG:Ljava/lang/String; = "persist.gsm.sms.disablelog"

.field private static final TAG_DEBUG:Ljava/lang/String; = "[SMS_LD]"

.field private static final TAG_ERROR:Ljava/lang/String; = "[SMS_LE]"

.field private static final TAG_FLOW:Ljava/lang/String; = "[SMS_LF]"

.field private static final TAG_INFO:Ljava/lang/String; = "[SMS_LI]"

.field private static final TAG_PRIVACY:Ljava/lang/String; = "[SMS_LP]"

.field private static final TAG_VERBOSE:Ljava/lang/String; = "[SMS_LV]"

.field private static final TAG_WARN:Ljava/lang/String; = "[SMS_LW]"

.field public static final VERBOSE:I = 0x1

.field public static final WARN:I = 0x8


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 89
    const-string v0, "persist.gsm.sms.disablelog"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v0

    sput v0, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->DISABLELOG:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static d(Ljava/lang/String;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 123
    if-nez p0, :cond_1

    .line 130
    :cond_0
    :goto_0
    return v0

    .line 127
    :cond_1
    const/4 v1, 0x2

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 128
    const-string v0, "[SMS_LD]"

    invoke-static {v0, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public static d(Ljava/lang/String;Ljava/lang/Throwable;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "tr"    # Ljava/lang/Throwable;

    .prologue
    const/4 v0, 0x0

    .line 134
    if-nez p0, :cond_1

    .line 141
    :cond_0
    :goto_0
    return v0

    .line 138
    :cond_1
    const/4 v1, 0x2

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 139
    const-string v0, "[SMS_LD]"

    invoke-static {v0, p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v0

    goto :goto_0
.end method

.method public static e(Ljava/lang/String;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 189
    if-nez p0, :cond_1

    .line 196
    :cond_0
    :goto_0
    return v0

    .line 193
    :cond_1
    const/16 v1, 0x10

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 194
    const-string v0, "[SMS_LW]"

    invoke-static {v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public static e(Ljava/lang/String;Ljava/lang/Throwable;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "tr"    # Ljava/lang/Throwable;

    .prologue
    const/4 v0, 0x0

    .line 200
    if-nez p0, :cond_1

    .line 207
    :cond_0
    :goto_0
    return v0

    .line 204
    :cond_1
    const/16 v1, 0x10

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 205
    const-string v0, "[SMS_LE]"

    invoke-static {v0, p0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v0

    goto :goto_0
.end method

.method public static f(Ljava/lang/String;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 212
    if-nez p0, :cond_1

    .line 219
    :cond_0
    :goto_0
    return v0

    .line 216
    :cond_1
    const/16 v1, 0x20

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 217
    const-string v0, "[SMS_LF]"

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public static i(Ljava/lang/String;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 145
    if-nez p0, :cond_1

    .line 152
    :cond_0
    :goto_0
    return v0

    .line 149
    :cond_1
    const/4 v1, 0x4

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 150
    const-string v0, "[SMS_LI]"

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public static i(Ljava/lang/String;Ljava/lang/Throwable;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "tr"    # Ljava/lang/Throwable;

    .prologue
    const/4 v0, 0x0

    .line 156
    if-nez p0, :cond_1

    .line 163
    :cond_0
    :goto_0
    return v0

    .line 160
    :cond_1
    const/4 v1, 0x4

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 161
    const-string v0, "[SMS_LI]"

    invoke-static {v0, p0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v0

    goto :goto_0
.end method

.method public static isLoggable(I)Z
    .locals 1
    .param p0, "priority"    # I

    .prologue
    .line 93
    sget v0, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->DISABLELOG:I

    and-int/2addr v0, p0

    if-nez v0, :cond_0

    .line 94
    const/4 v0, 0x1

    .line 97
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static p(Ljava/lang/String;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 223
    if-nez p0, :cond_1

    .line 230
    :cond_0
    :goto_0
    return v0

    .line 227
    :cond_1
    const/16 v1, 0x40

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 228
    const-string v0, "[SMS_LP]"

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public static v(Ljava/lang/String;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 101
    if-nez p0, :cond_1

    .line 108
    :cond_0
    :goto_0
    return v0

    .line 105
    :cond_1
    const/4 v1, 0x1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 106
    const-string v0, "[SMS_LV]"

    invoke-static {v0, p0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public static v(Ljava/lang/String;Ljava/lang/Throwable;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "tr"    # Ljava/lang/Throwable;

    .prologue
    const/4 v0, 0x0

    .line 112
    if-nez p0, :cond_1

    .line 119
    :cond_0
    :goto_0
    return v0

    .line 116
    :cond_1
    const/4 v1, 0x1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 117
    const-string v0, "[SMS_LV]"

    invoke-static {v0, p0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v0

    goto :goto_0
.end method

.method public static w(Ljava/lang/String;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 167
    if-nez p0, :cond_1

    .line 174
    :cond_0
    :goto_0
    return v0

    .line 171
    :cond_1
    const/16 v1, 0x8

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 172
    const-string v0, "[SMS_LW]"

    invoke-static {v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public static w(Ljava/lang/String;Ljava/lang/Throwable;)I
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "tr"    # Ljava/lang/Throwable;

    .prologue
    const/4 v0, 0x0

    .line 178
    if-nez p0, :cond_1

    .line 185
    :cond_0
    :goto_0
    return v0

    .line 182
    :cond_1
    const/16 v1, 0x8

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->isLoggable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 183
    const-string v0, "[SMS_LW]"

    invoke-static {v0, p0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v0

    goto :goto_0
.end method
