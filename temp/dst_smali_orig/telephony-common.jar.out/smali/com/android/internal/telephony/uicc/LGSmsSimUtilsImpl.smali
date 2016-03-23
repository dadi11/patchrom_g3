.class public Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;
.super Ljava/lang/Object;
.source "LGSmsSimUtilsImpl.java"

# interfaces
.implements Lcom/android/internal/telephony/uicc/ILGSmsSimUtils;


# static fields
.field public static final INDEX_ON_ICC:Ljava/lang/String; = "index_on_icc"

.field public static final IS_41_EMAIL_NETWORK_ADDRESS:Ljava/lang/String; = "6245"

.field public static final LGE_MSGTYPE_SIM:I = 0x7

.field public static final LGE_SERVICE_MSGTYPE:Ljava/lang/String; = "lgeMsgType"

.field private static final MAX_SIM_FORMAT:I = 0x2

.field private static final MAX_SLOT_NUM:I = 0x3

.field private static final MISSING_TEXT:Ljava/lang/String; = "/*missing text*/"

.field private static final SMS_FORMAT_CSIM:I = 0x2

.field private static final SMS_FORMAT_USIM:I = 0x1

.field public static final SMS_INBOX_URI:Landroid/net/Uri;

.field public static final SMS_OUTBOX_URI:Landroid/net/Uri;

.field public static final SMS_SENT_URI:Landroid/net/Uri;

.field public static final SMS_URI:Landroid/net/Uri;

.field public static final STATUS:Ljava/lang/String; = "status"

.field public static final STATUS_PENDING:I = 0x20

.field public static final SUB_ID:Ljava/lang/String; = "sub_id"

.field public static isSimSmsDeleteAll:Z

.field private static final sSMSLoadingLock:Ljava/lang/Object;

.field private static sSimSMSUpdateFlag:[[Z


# instance fields
.field private isUSimSmsUpdateStarted:Z

.field private mContext:Landroid/content/Context;

.field protected mSlotIdValue:I

.field private mUiccApp:Lcom/android/internal/telephony/uicc/UiccCardApplication;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .prologue
    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x0

    const-string v2, "content://sms"

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    sput-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_URI:Landroid/net/Uri;

    const-string v2, "content://sms/inbox"

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    sput-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_INBOX_URI:Landroid/net/Uri;

    const-string v2, "content://sms/sent"

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    sput-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_SENT_URI:Landroid/net/Uri;

    const-string v2, "content://sms/outbox"

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    sput-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_OUTBOX_URI:Landroid/net/Uri;

    filled-new-array {v5, v6}, [I

    move-result-object v2

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v2}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [[Z

    sput-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->sSimSMSUpdateFlag:[[Z

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v5, :cond_1

    const/4 v1, 0x0

    .local v1, "j":I
    :goto_1
    if-ge v1, v6, :cond_0

    sget-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->sSimSMSUpdateFlag:[[Z

    aget-object v2, v2, v0

    aput-boolean v4, v2, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .end local v1    # "j":I
    :cond_1
    sput-boolean v4, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isSimSmsDeleteAll:Z

    new-instance v2, Ljava/lang/Object;

    invoke-direct {v2}, Ljava/lang/Object;-><init>()V

    sput-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->sSMSLoadingLock:Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/uicc/UiccCardApplication;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "app"    # Lcom/android/internal/telephony/uicc/UiccCardApplication;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isUSimSmsUpdateStarted:Z

    const/4 v0, -0x1

    iput v0, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mSlotIdValue:I

    iput-object p1, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mUiccApp:Lcom/android/internal/telephony/uicc/UiccCardApplication;

    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;

    .prologue
    iget-boolean v0, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isUSimSmsUpdateStarted:Z

    return v0
.end method

.method static synthetic access$002(Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isUSimSmsUpdateStarted:Z

    return p1
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;Ljava/util/ArrayList;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;
    .param p1, "x1"    # Ljava/util/ArrayList;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->updateCurrentIccSimMessageProvider(Ljava/util/ArrayList;)Z

    move-result v0

    return v0
.end method

.method private checkValidConcat(ILandroid/database/Cursor;)Z
    .locals 4
    .param p1, "msgCount"    # I
    .param p2, "c"    # Landroid/database/Cursor;

    .prologue
    const/4 v0, 0x0

    .local v0, "numOfQueriedItem":I
    const/4 v1, 0x0

    .local v1, "saparate_flag":Z
    if-eqz p2, :cond_0

    invoke-interface {p2}, Landroid/database/Cursor;->getCount()I

    move-result v2

    add-int/lit8 v0, v2, 0x1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "insertSmsDBForConcat(), msgCount: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", numOfQueriedItem: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    if-ge p1, v0, :cond_0

    const-string v2, "insertSmsDBForConcat(), Abnormal case!, separate following concatenated messages"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    const/4 v1, 0x1

    :cond_0
    return v1
.end method

.method private emptySimCache()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const-string v0, "emptySimCache(), start"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "emptySimCache(), isSimSmsDeleteAll: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-boolean v1, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isSimSmsDeleteAll:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    sget-boolean v0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isSimSmsDeleteAll:Z

    if-nez v0, :cond_0

    const-string v0, "emptySimCache(), Delete ICC_URI"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    iget-object v0, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->ICC_URI:Landroid/net/Uri;

    invoke-static {v0, v1, v2, v3, v3}, Landroid/database/sqlite/SqliteWrapper;->delete(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    const/4 v0, 0x1

    sput-boolean v0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isSimSmsDeleteAll:Z

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "emptySimCache(), After isSimSmsDeleteAll: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-boolean v1, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isSimSmsDeleteAll:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    iget-object v0, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_CONCAT_URI:Landroid/net/Uri;

    invoke-static {v0, v1, v2, v3, v3}, Landroid/database/sqlite/SqliteWrapper;->delete(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method private extractEmailAddressFromMessageBody(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;
    .locals 11
    .param p1, "originatingAddress"    # Ljava/lang/String;
    .param p2, "messageBody"    # Ljava/lang/String;

    .prologue
    if-nez p2, :cond_0

    const/4 v5, 0x0

    :goto_0
    return-object v5

    :cond_0
    const-string v9, "( /)|( )"

    const/4 v10, 0x2

    invoke-virtual {p2, v9, v10}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v5

    .local v5, "parts":[Ljava/lang/String;
    array-length v9, v5

    const/4 v10, 0x2

    if-ge v9, v10, :cond_1

    const/4 v5, 0x0

    goto :goto_0

    :cond_1
    const/4 v9, 0x0

    aget-object v1, v5, v9

    .local v1, "emailFrom":Ljava/lang/String;
    const/4 v9, 0x1

    aget-object v0, v5, v9

    .local v0, "emailBody":Ljava/lang/String;
    invoke-direct {p0, p1, v1}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isEmail(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_2

    const/4 v5, 0x0

    goto :goto_0

    :cond_2
    invoke-static {v1}, Landroid/provider/Telephony$Mms;->isEmailAddress(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_3

    const-string v9, "("

    invoke-virtual {v1, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    if-nez v9, :cond_3

    const-string v9, ")"

    invoke-virtual {p2, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    .local v2, "parenthesis":I
    const-string v9, ")"

    invoke-virtual {v1, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    const/4 v10, -0x1

    if-ne v9, v10, :cond_3

    const/4 v9, -0x1

    if-eq v2, v9, :cond_3

    const/4 v9, 0x0

    add-int/lit8 v10, v2, 0x1

    invoke-virtual {p2, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    add-int/lit8 v9, v2, 0x2

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {p2, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .end local v2    # "parenthesis":I
    :cond_3
    const-string v9, "( /)|( )"

    const/4 v10, 0x2

    invoke-virtual {v0, v9, v10}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v6

    .local v6, "parts2":[Ljava/lang/String;
    array-length v9, v6

    const/4 v10, 0x1

    if-le v9, v10, :cond_5

    const/4 v9, 0x0

    aget-object v8, v6, v9

    .local v8, "tempFrom":Ljava/lang/String;
    const/4 v9, 0x1

    aget-object v7, v6, v9

    .local v7, "tempBody":Ljava/lang/String;
    const-string v9, "("

    invoke-virtual {v8, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    .local v4, "parenthesisStart":I
    const/4 v9, -0x1

    if-eq v4, v9, :cond_5

    const-string v9, ")"

    invoke-virtual {v8, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    .local v3, "parenthesisEnd":I
    const/4 v9, -0x1

    if-eq v3, v9, :cond_5

    if-le v3, v4, :cond_5

    add-int/lit8 v9, v4, 0x1

    invoke-virtual {v8, v9, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Landroid/provider/Telephony$Mms;->isEmailAddress(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_4

    invoke-static {v8}, Landroid/provider/Telephony$Mms;->isPhoneNumber(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_5

    :cond_4
    move-object v1, v8

    move-object v0, v7

    .end local v3    # "parenthesisEnd":I
    .end local v4    # "parenthesisStart":I
    .end local v7    # "tempBody":Ljava/lang/String;
    .end local v8    # "tempFrom":Ljava/lang/String;
    :cond_5
    const/4 v9, 0x0

    aput-object v1, v5, v9

    const/4 v9, 0x1

    aput-object v0, v5, v9

    goto/16 :goto_0
.end method

.method private getAddress(ILandroid/telephony/SmsMessage;)Ljava/lang/String;
    .locals 4
    .param p1, "boxType"    # I
    .param p2, "sms"    # Landroid/telephony/SmsMessage;

    .prologue
    const/4 v3, 0x0

    const/4 v0, 0x0

    .local v0, "address":Ljava/lang/String;
    invoke-direct {p0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isRuimCard()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-virtual {p2}, Landroid/telephony/SmsMessage;->getDisplayOriginatingAddress()Ljava/lang/String;

    move-result-object v0

    :cond_0
    :goto_0
    const-string v2, "parse_email_on_uicc"

    invoke-static {v3, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {p2}, Landroid/telephony/SmsMessage;->getDisplayMessageBody()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->extractEmailAddressFromMessageBody(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .local v1, "parts":[Ljava/lang/String;
    if-eqz v1, :cond_1

    const/4 v2, 0x0

    aget-object v0, v1, v2

    .end local v1    # "parts":[Ljava/lang/String;
    :cond_1
    if-nez v0, :cond_6

    const-string v0, "Unknown"

    :cond_2
    :goto_1
    return-object v0

    :cond_3
    const/4 v2, 0x1

    if-ne p1, v2, :cond_5

    invoke-virtual {p2}, Landroid/telephony/SmsMessage;->getDisplayOriginatingAddress()Ljava/lang/String;

    move-result-object v0

    const-string v2, "sms_separate_usimbox"

    invoke-static {v3, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {p2}, Landroid/telephony/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_4

    :goto_2
    goto :goto_0

    :cond_4
    invoke-virtual {p2}, Landroid/telephony/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_5
    invoke-virtual {p2}, Landroid/telephony/SmsMessage;->getDestinationAddress()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_6
    const-string v2, "dcm_support_sim_load_voice_mail_tp_oa_address_ntt_docomo"

    invoke-static {v3, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    if-eqz v0, :cond_2

    const-string v2, "(?i).*docomo.*"

    invoke-virtual {v0, v2}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    const-string v0, "NTT DOCOMO"

    goto :goto_1
.end method

.method private getBody(Landroid/telephony/SmsMessage;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "sms"    # Landroid/telephony/SmsMessage;
    .param p2, "address"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getDisplayMessageBody()Ljava/lang/String;

    move-result-object v0

    .local v0, "body":Ljava/lang/String;
    const/4 v2, 0x0

    const-string v3, "parse_email_on_uicc"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p2, v0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->extractEmailAddressFromMessageBody(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .local v1, "parts":[Ljava/lang/String;
    if-eqz v1, :cond_0

    const/4 v2, 0x1

    aget-object v0, v1, v2

    .end local v1    # "parts":[Ljava/lang/String;
    :cond_0
    if-nez v0, :cond_1

    const-string v0, "empty contents"

    :cond_1
    return-object v0
.end method

.method private getDate(ILandroid/telephony/SmsMessage;)J
    .locals 4
    .param p1, "boxType"    # I
    .param p2, "sms"    # Landroid/telephony/SmsMessage;

    .prologue
    const-wide/16 v0, -0x1

    .local v0, "date":J
    const/4 v2, 0x1

    if-ne p1, v2, :cond_0

    invoke-virtual {p2}, Landroid/telephony/SmsMessage;->getTimestampMillis()J

    move-result-wide v0

    :goto_0
    return-wide v0

    :cond_0
    iget-object v2, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    const-string v3, "insert_boottime_for_sim_mosms"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    goto :goto_0

    :cond_1
    const-wide/16 v0, -0x1

    goto :goto_0
.end method

.method private getDefaultValues(Landroid/telephony/SmsMessage;)Landroid/content/ContentValues;
    .locals 10
    .param p1, "sms"    # Landroid/telephony/SmsMessage;

    .prologue
    const/4 v9, 0x0

    const/4 v7, 0x1

    new-instance v5, Landroid/content/ContentValues;

    invoke-direct {v5}, Landroid/content/ContentValues;-><init>()V

    .local v5, "values":Landroid/content/ContentValues;
    invoke-direct {p0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isRuimCard()Z

    move-result v6

    if-nez v6, :cond_0

    const-string v6, "protocol"

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getProtocolIdentifier()I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v5, v6, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    :cond_0
    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getPseudoSubject()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    if-lez v6, :cond_1

    const-string v6, "subject"

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getPseudoSubject()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v6, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    const-string v8, "reply_path_present"

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->isReplyPathPresent()Z

    move-result v6

    if-eqz v6, :cond_5

    move v6, v7

    :goto_0
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v5, v8, v6}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v6, "service_center"

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getServiceCenterAddress()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v6, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v6, "lgeMsgType"

    const/4 v8, 0x7

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v5, v6, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v6, "index_on_icc"

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getIndexOnIcc()I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v6, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v6, "uicc_csim"

    invoke-static {v9, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    const-string v6, "sms_format"

    invoke-direct {p0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->getFormat()I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v5, v6, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "insertSmsDB(), SMS_FORMAT = "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-direct {p0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->getFormat()I

    move-result v8

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :cond_2
    const-string v6, "sms_separate_usimbox"

    invoke-static {v9, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    const-string v6, "dcs"

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getDataCodingScheme()I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v5, v6, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v6, "kr_address_spec"

    invoke-static {v9, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    const-string v8, "reply_address"

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v6

    if-nez v6, :cond_6

    const-string v6, ""

    :goto_1
    invoke-virtual {v5, v8, v6}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v6

    invoke-virtual {v6}, Landroid/telephony/TelephonyManager;->isMultiSimEnabled()Z

    move-result v6

    if-eqz v6, :cond_4

    iget v4, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mSlotIdValue:I

    .local v4, "slotId":I
    move v3, v4

    .local v3, "phoneid":I
    const-string v6, "phone_id"

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v5, v6, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    iget-object v6, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mUiccApp:Lcom/android/internal/telephony/uicc/UiccCardApplication;

    invoke-virtual {v6}, Lcom/android/internal/telephony/uicc/UiccCardApplication;->getIccRecords()Lcom/android/internal/telephony/uicc/IccRecords;

    move-result-object v6

    invoke-virtual {v6}, Lcom/android/internal/telephony/uicc/IccRecords;->getIccId()Ljava/lang/String;

    move-result-object v0

    .local v0, "iccd":Ljava/lang/String;
    iget-object v6, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mUiccApp:Lcom/android/internal/telephony/uicc/UiccCardApplication;

    invoke-virtual {v6}, Lcom/android/internal/telephony/uicc/UiccCardApplication;->getIccRecords()Lcom/android/internal/telephony/uicc/IccRecords;

    move-result-object v6

    invoke-virtual {v6}, Lcom/android/internal/telephony/uicc/IccRecords;->getIMSI()Ljava/lang/String;

    move-result-object v1

    .local v1, "imsi":Ljava/lang/String;
    const/4 v2, 0x0

    .local v2, "mIccImsi":Ljava/lang/String;
    if-nez v0, :cond_9

    if-nez v1, :cond_9

    if-ne v4, v7, :cond_7

    const-string v2, "sim2"

    :goto_2
    invoke-direct {p0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->getFormat()I

    move-result v6

    if-ne v6, v7, :cond_a

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "updateMessagefromUSim(), Normal SMS, Imsidata:["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "], slotId="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :goto_3
    const-string v6, "sms_imsi_data"

    invoke-virtual {v5, v6, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .end local v0    # "iccd":Ljava/lang/String;
    .end local v1    # "imsi":Ljava/lang/String;
    .end local v2    # "mIccImsi":Ljava/lang/String;
    .end local v3    # "phoneid":I
    .end local v4    # "slotId":I
    :cond_4
    return-object v5

    :cond_5
    const/4 v6, 0x0

    goto/16 :goto_0

    :cond_6
    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v6

    goto :goto_1

    .restart local v0    # "iccd":Ljava/lang/String;
    .restart local v1    # "imsi":Ljava/lang/String;
    .restart local v2    # "mIccImsi":Ljava/lang/String;
    .restart local v3    # "phoneid":I
    .restart local v4    # "slotId":I
    :cond_7
    const/4 v6, 0x2

    if-ne v4, v6, :cond_8

    const-string v2, "sim3"

    goto :goto_2

    :cond_8
    const-string v2, "sim1"

    goto :goto_2

    :cond_9
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_2

    :cond_a
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "updateMessagefromCSim(), Normal SMS, Imsidata:["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "], slotId="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_3
.end method

.method private getDefaultValuesForConcat(Landroid/telephony/SmsMessage;)Landroid/content/ContentValues;
    .locals 4
    .param p1, "sms"    # Landroid/telephony/SmsMessage;

    .prologue
    new-instance v1, Landroid/content/ContentValues;

    invoke-direct {v1}, Landroid/content/ContentValues;-><init>()V

    .local v1, "values":Landroid/content/ContentValues;
    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v0

    .local v0, "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    const-string v2, "reference"

    iget-object v3, v0, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v3, v3, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->refNumber:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v2, "count"

    iget-object v3, v0, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v3, v3, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->msgCount:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v2, "sequence"

    iget-object v3, v0, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v3, v3, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->seqNumber:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v2, "icc_index"

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getIndexOnIcc()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v2, "body"

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getDisplayMessageBody()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    return-object v1
.end method

.method private getFormat()I
    .locals 1

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isRuimCard()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x2

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private insertSmsDB(ILandroid/telephony/SmsMessage;)Landroid/net/Uri;
    .locals 10
    .param p1, "statsOnSim"    # I
    .param p2, "sms"    # Landroid/telephony/SmsMessage;

    .prologue
    const/4 v9, 0x1

    const/4 v1, 0x0

    .local v1, "boxType":I
    const/4 v2, 0x0

    .local v2, "boxTypeKR":I
    const/4 v0, 0x0

    .local v0, "address":Ljava/lang/String;
    const/4 v4, 0x0

    .local v4, "smsBoxUri":Landroid/net/Uri;
    const/4 v5, 0x0

    .local v5, "smsInsertUri":Landroid/net/Uri;
    invoke-direct {p0, p2}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->getDefaultValues(Landroid/telephony/SmsMessage;)Landroid/content/ContentValues;

    move-result-object v6

    .local v6, "values":Landroid/content/ContentValues;
    sparse-switch p1, :sswitch_data_0

    const/4 v1, 0x2

    const/4 v2, 0x2

    :try_start_0
    sget-object v4, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_SENT_URI:Landroid/net/Uri;

    const-string v7, "read"

    const/4 v8, 0x1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v7, "seen"

    const/4 v8, 0x1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    :cond_0
    :goto_0
    const-string v7, "type"

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    invoke-direct {p0, v1, p2}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->getAddress(ILandroid/telephony/SmsMessage;)Ljava/lang/String;

    move-result-object v0

    const-string v7, "address"

    invoke-virtual {v6, v7, v0}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v7, "body"

    invoke-direct {p0, p2, v0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->getBody(Landroid/telephony/SmsMessage;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v7, "date"

    invoke-direct {p0, v1, p2}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->getDate(ILandroid/telephony/SmsMessage;)J

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    const/4 v7, 0x0

    const-string v8, "sms_separate_usimbox"

    invoke-static {v7, v8}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_1

    const-string v7, "original_address"

    invoke-virtual {v6, v7, v0}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v7, "msg_boxtype"

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    :cond_1
    iget-object v7, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    const-string v8, "SafeSMS"

    invoke-static {v7, v8}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_2

    invoke-direct {p0, p2, v6, p1}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->putValueforSafeSms(Landroid/telephony/SmsMessage;Landroid/content/ContentValues;I)V
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_2
    :try_start_1
    iget-object v7, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    invoke-virtual {v7}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    invoke-virtual {v7, v4, v6}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v5

    if-nez v5, :cond_3

    const-string v7, "insertSmsDB(), smsInsertUri is null"

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/database/SQLException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_0

    :cond_3
    :goto_1
    return-object v5

    :sswitch_0
    const/4 v1, 0x1

    const/4 v2, 0x1

    :try_start_2
    sget-object v4, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_INBOX_URI:Landroid/net/Uri;

    const-string v7, "read"

    const/4 v8, 0x1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v7, "seen"

    const/4 v8, 0x1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V
    :try_end_2
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    :catch_0
    move-exception v3

    .local v3, "e":Ljava/lang/NullPointerException;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "insertSmsDB(), "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v3}, Ljava/lang/NullPointerException;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1

    .end local v3    # "e":Ljava/lang/NullPointerException;
    :sswitch_1
    const/4 v1, 0x1

    const/4 v2, 0x1

    :try_start_3
    sget-object v4, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_INBOX_URI:Landroid/net/Uri;

    const-string v7, "read"

    const/4 v8, 0x0

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v7, "seen"

    const/4 v8, 0x0

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    goto/16 :goto_0

    :sswitch_2
    const/4 v1, 0x5

    const/4 v2, 0x0

    sget-object v4, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_OUTBOX_URI:Landroid/net/Uri;

    const-string v7, "read"

    const/4 v8, 0x1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    const-string v7, "seen"

    const/4 v8, 0x1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    invoke-virtual {p2}, Landroid/telephony/SmsMessage;->getStatusReportReq()I

    move-result v7

    if-ne v7, v9, :cond_0

    const-string v7, "status"

    const/16 v8, 0x20

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    goto/16 :goto_0

    :catch_1
    move-exception v3

    .local v3, "e":Landroid/database/SQLException;
    const-string v7, "insertSmsDB(), SQL Insert error"

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_3
    .catch Ljava/lang/NullPointerException; {:try_start_3 .. :try_end_3} :catch_0

    goto/16 :goto_1

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x3 -> :sswitch_1
        0x7 -> :sswitch_2
    .end sparse-switch
.end method

.method private insertSmsDBForConcat(ILandroid/telephony/SmsMessage;)V
    .locals 28
    .param p1, "statusOnSim"    # I
    .param p2, "sms"    # Landroid/telephony/SmsMessage;

    .prologue
    invoke-virtual/range {p2 .. p2}, Landroid/telephony/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v22

    .local v22, "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    move-object/from16 v0, v22

    iget-object v4, v0, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v0, v4, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->msgCount:I

    move/from16 v18, v0

    .local v18, "msgCount":I
    move-object/from16 v0, v22

    iget-object v4, v0, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v0, v4, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->seqNumber:I

    move/from16 v21, v0

    .local v21, "seqNum":I
    move-object/from16 v0, v22

    iget-object v4, v0, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v0, v4, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->refNumber:I

    move/from16 v19, v0

    .local v19, "refNum":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "reference = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v19

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " and count = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v18

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .local v7, "selection":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    sget-object v5, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_CONCAT_URI:Landroid/net/Uri;

    const/4 v6, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v11

    .local v11, "c":Landroid/database/Cursor;
    if-eqz v11, :cond_7

    :try_start_0
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->getDefaultValuesForConcat(Landroid/telephony/SmsMessage;)Landroid/content/ContentValues;

    move-result-object v27

    .local v27, "values":Landroid/content/ContentValues;
    const/16 v23, 0x0

    .local v23, "smsUri":Landroid/net/Uri;
    const/16 v16, 0x0

    .local v16, "iccSring":Ljava/lang/String;
    const/16 v17, 0x0

    .local v17, "indexOnIcc":I
    const-wide/16 v24, 0x0

    .local v24, "smsId":J
    const/16 v20, 0x0

    .local v20, "seq":I
    invoke-interface {v11}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v4

    if-eqz v4, :cond_8

    move-object/from16 v0, p0

    move/from16 v1, v18

    invoke-direct {v0, v1, v11}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->checkValidConcat(ILandroid/database/Cursor;)Z

    move-result v4

    if-nez v4, :cond_8

    new-instance v10, Ljava/util/ArrayList;

    move/from16 v0, v18

    invoke-direct {v10, v0}, Ljava/util/ArrayList;-><init>(I)V

    .local v10, "body_part":Ljava/util/ArrayList;
    const/4 v15, 0x0

    .local v15, "i":I
    :goto_0
    move/from16 v0, v18

    if-ge v15, v0, :cond_0

    const-string v4, "/*missing text*/"

    invoke-virtual {v10, v15, v4}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    add-int/lit8 v15, v15, 0x1

    goto :goto_0

    :cond_0
    new-instance v16, Ljava/lang/String;

    .end local v16    # "iccSring":Ljava/lang/String;
    invoke-direct/range {v16 .. v16}, Ljava/lang/String;-><init>()V

    .restart local v16    # "iccSring":Ljava/lang/String;
    const-string v4, "sms_id"

    invoke-interface {v11, v4}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v4

    invoke-interface {v11, v4}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v24

    :cond_1
    const-string v4, "sequence"

    invoke-interface {v11, v4}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v4

    invoke-interface {v11, v4}, Landroid/database/Cursor;->getInt(I)I

    move-result v20

    add-int/lit8 v4, v20, -0x1

    const-string v5, "body"

    invoke-interface {v11, v5}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v5

    invoke-interface {v11, v5}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v10, v4, v5}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    const-string v4, "icc_index"

    invoke-interface {v11, v4}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v4

    invoke-interface {v11, v4}, Landroid/database/Cursor;->getInt(I)I

    move-result v17

    invoke-static/range {v17 .. v17}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, v16

    invoke-virtual {v0, v4}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v16

    const-string v4, ","

    move-object/from16 v0, v16

    invoke-virtual {v0, v4}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v16

    invoke-interface {v11}, Landroid/database/Cursor;->moveToNext()Z

    move-result v4

    if-nez v4, :cond_1

    add-int/lit8 v4, v21, -0x1

    invoke-virtual/range {p2 .. p2}, Landroid/telephony/SmsMessage;->getDisplayMessageBody()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v10, v4, v5}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    invoke-virtual/range {p2 .. p2}, Landroid/telephony/SmsMessage;->getIndexOnIcc()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, v16

    invoke-virtual {v0, v4}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v16

    const-string v12, ""

    .local v12, "concatBody":Ljava/lang/String;
    const/4 v15, 0x0

    :goto_1
    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-ge v15, v4, :cond_2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v10, v15}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    add-int/lit8 v15, v15, 0x1

    goto :goto_1

    :cond_2
    const-string v4, "sms_id"

    invoke-static/range {v24 .. v25}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    move-object/from16 v0, v27

    invoke-virtual {v0, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    sget-object v5, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_CONCAT_URI:Landroid/net/Uri;

    move-object/from16 v0, v27

    invoke-virtual {v4, v5, v0}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v23

    if-nez v23, :cond_3

    const-string v4, "insertSmsDBForConcat(), smsUri of SMS_CONCAT_URI is null"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/database/SQLException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_3
    :goto_2
    :try_start_2
    invoke-virtual/range {v27 .. v27}, Landroid/content/ContentValues;->clear()V

    const-string v4, "body"

    move-object/from16 v0, v27

    invoke-virtual {v0, v4, v12}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const-string v4, "index_on_icc"

    move-object/from16 v0, v27

    move-object/from16 v1, v16

    invoke-virtual {v0, v4, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v4, 0x0

    const-string v5, "uicc_csim"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    const-string v4, "sms_format"

    invoke-direct/range {p0 .. p0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->getFormat()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    move-object/from16 v0, v27

    invoke-virtual {v0, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    :cond_4
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    const-string v5, "SafeSMS"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, v27

    move/from16 v3, p1

    invoke-direct {v0, v1, v2, v3}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->putValueforSafeSms(Landroid/telephony/SmsMessage;Landroid/content/ContentValues;I)V
    :try_end_2
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :cond_5
    :try_start_3
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    sget-object v5, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_URI:Landroid/net/Uri;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "_id="

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    move-wide/from16 v0, v24

    invoke-virtual {v6, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const/4 v8, 0x0

    move-object/from16 v0, v27

    invoke-virtual {v4, v5, v0, v6, v8}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v26

    .local v26, "updateResult":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "insertSmsDBForConcat(), updateResult = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v26

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_3
    .catch Landroid/database/SQLException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/lang/NullPointerException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_3 .. :try_end_3} :catch_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .end local v10    # "body_part":Ljava/util/ArrayList;
    .end local v12    # "concatBody":Ljava/lang/String;
    .end local v15    # "i":I
    .end local v26    # "updateResult":I
    :cond_6
    :goto_3
    if-eqz v11, :cond_7

    invoke-interface {v11}, Landroid/database/Cursor;->close()V

    .end local v16    # "iccSring":Ljava/lang/String;
    .end local v17    # "indexOnIcc":I
    .end local v20    # "seq":I
    .end local v23    # "smsUri":Landroid/net/Uri;
    .end local v24    # "smsId":J
    .end local v27    # "values":Landroid/content/ContentValues;
    :cond_7
    :goto_4
    return-void

    .restart local v10    # "body_part":Ljava/util/ArrayList;
    .restart local v12    # "concatBody":Ljava/lang/String;
    .restart local v15    # "i":I
    .restart local v16    # "iccSring":Ljava/lang/String;
    .restart local v17    # "indexOnIcc":I
    .restart local v20    # "seq":I
    .restart local v23    # "smsUri":Landroid/net/Uri;
    .restart local v24    # "smsId":J
    .restart local v27    # "values":Landroid/content/ContentValues;
    :catch_0
    move-exception v13

    .local v13, "e":Landroid/database/SQLException;
    :try_start_4
    const-string v4, "insertSmsDBForConcat(), SQL Insert error"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_4
    .catch Ljava/lang/NullPointerException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_4 .. :try_end_4} :catch_3
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto/16 :goto_2

    .end local v10    # "body_part":Ljava/util/ArrayList;
    .end local v12    # "concatBody":Ljava/lang/String;
    .end local v13    # "e":Landroid/database/SQLException;
    .end local v15    # "i":I
    .end local v16    # "iccSring":Ljava/lang/String;
    .end local v17    # "indexOnIcc":I
    .end local v20    # "seq":I
    .end local v23    # "smsUri":Landroid/net/Uri;
    .end local v24    # "smsId":J
    .end local v27    # "values":Landroid/content/ContentValues;
    :catch_1
    move-exception v13

    .local v13, "e":Ljava/lang/NullPointerException;
    :try_start_5
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "insertSmsDBForConcat(), "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v13}, Ljava/lang/NullPointerException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    if-eqz v11, :cond_7

    invoke-interface {v11}, Landroid/database/Cursor;->close()V

    goto :goto_4

    .end local v13    # "e":Ljava/lang/NullPointerException;
    .restart local v10    # "body_part":Ljava/util/ArrayList;
    .restart local v12    # "concatBody":Ljava/lang/String;
    .restart local v15    # "i":I
    .restart local v16    # "iccSring":Ljava/lang/String;
    .restart local v17    # "indexOnIcc":I
    .restart local v20    # "seq":I
    .restart local v23    # "smsUri":Landroid/net/Uri;
    .restart local v24    # "smsId":J
    .restart local v27    # "values":Landroid/content/ContentValues;
    :catch_2
    move-exception v13

    .local v13, "e":Landroid/database/SQLException;
    :try_start_6
    const-string v4, "insertSmsDBForConcat(), SQL update error"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_6
    .catch Ljava/lang/NullPointerException; {:try_start_6 .. :try_end_6} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_6 .. :try_end_6} :catch_3
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_3

    .end local v10    # "body_part":Ljava/util/ArrayList;
    .end local v12    # "concatBody":Ljava/lang/String;
    .end local v13    # "e":Landroid/database/SQLException;
    .end local v15    # "i":I
    .end local v16    # "iccSring":Ljava/lang/String;
    .end local v17    # "indexOnIcc":I
    .end local v20    # "seq":I
    .end local v23    # "smsUri":Landroid/net/Uri;
    .end local v24    # "smsId":J
    .end local v27    # "values":Landroid/content/ContentValues;
    :catch_3
    move-exception v13

    .local v13, "e":Ljava/lang/IndexOutOfBoundsException;
    :try_start_7
    const-string v4, "insertSmsDBForConcat(), IndexOutOfBoundsException"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "insertSmsDBForConcat()"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v13}, Ljava/lang/IndexOutOfBoundsException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    if-eqz v11, :cond_7

    invoke-interface {v11}, Landroid/database/Cursor;->close()V

    goto :goto_4

    .end local v13    # "e":Ljava/lang/IndexOutOfBoundsException;
    .restart local v16    # "iccSring":Ljava/lang/String;
    .restart local v17    # "indexOnIcc":I
    .restart local v20    # "seq":I
    .restart local v23    # "smsUri":Landroid/net/Uri;
    .restart local v24    # "smsId":J
    .restart local v27    # "values":Landroid/content/ContentValues;
    :cond_8
    :try_start_8
    invoke-direct/range {p0 .. p2}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->insertSmsDB(ILandroid/telephony/SmsMessage;)Landroid/net/Uri;

    move-result-object v14

    .local v14, "firstInsertUri":Landroid/net/Uri;
    if-eqz v14, :cond_9

    const-string v5, "sms_id"

    invoke-virtual {v14}, Landroid/net/Uri;->getPathSegments()Ljava/util/List;

    move-result-object v4

    const/4 v6, 0x0

    invoke-interface {v4, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    move-object/from16 v0, v27

    invoke-virtual {v0, v5, v4}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V
    :try_end_8
    .catch Ljava/lang/NullPointerException; {:try_start_8 .. :try_end_8} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_8 .. :try_end_8} :catch_3
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    :cond_9
    :try_start_9
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    sget-object v5, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_CONCAT_URI:Landroid/net/Uri;

    move-object/from16 v0, v27

    invoke-virtual {v4, v5, v0}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v23

    if-nez v23, :cond_6

    const-string v4, "insertSmsDBForConcat(), smsUri of SMS_CONCAT_URI is null"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_9
    .catch Landroid/database/SQLException; {:try_start_9 .. :try_end_9} :catch_4
    .catch Ljava/lang/NullPointerException; {:try_start_9 .. :try_end_9} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_9 .. :try_end_9} :catch_3
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    goto/16 :goto_3

    :catch_4
    move-exception v13

    .local v13, "e":Landroid/database/SQLException;
    :try_start_a
    const-string v4, "insertSmsDBForConcat(), SQL Insert error"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_a
    .catch Ljava/lang/NullPointerException; {:try_start_a .. :try_end_a} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_a .. :try_end_a} :catch_3
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    goto/16 :goto_3

    .end local v13    # "e":Landroid/database/SQLException;
    .end local v14    # "firstInsertUri":Landroid/net/Uri;
    .end local v16    # "iccSring":Ljava/lang/String;
    .end local v17    # "indexOnIcc":I
    .end local v20    # "seq":I
    .end local v23    # "smsUri":Landroid/net/Uri;
    .end local v24    # "smsId":J
    .end local v27    # "values":Landroid/content/ContentValues;
    :catchall_0
    move-exception v4

    if-eqz v11, :cond_a

    invoke-interface {v11}, Landroid/database/Cursor;->close()V

    :cond_a
    throw v4
.end method

.method private isEmail(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p1, "originatingAddress"    # Ljava/lang/String;
    .param p2, "emailFrom"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x4

    if-ne v1, v2, :cond_0

    const-string v1, "6245"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    .local v0, "mIsEmail":Z
    :goto_0
    return v0

    .end local v0    # "mIsEmail":Z
    :cond_0
    invoke-static {p2}, Landroid/provider/Telephony$Mms;->isEmailAddress(Ljava/lang/String;)Z

    move-result v0

    .restart local v0    # "mIsEmail":Z
    goto :goto_0
.end method

.method private isRuimCard()Z
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mUiccApp:Lcom/android/internal/telephony/uicc/UiccCardApplication;

    invoke-virtual {v0}, Lcom/android/internal/telephony/uicc/UiccCardApplication;->getType()Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;

    move-result-object v0

    sget-object v1, Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;->APPTYPE_RUIM:Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mUiccApp:Lcom/android/internal/telephony/uicc/UiccCardApplication;

    invoke-virtual {v0}, Lcom/android/internal/telephony/uicc/UiccCardApplication;->getType()Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;

    move-result-object v0

    sget-object v1, Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;->APPTYPE_CSIM:Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private putValueforSafeSms(Landroid/telephony/SmsMessage;Landroid/content/ContentValues;I)V
    .locals 3
    .param p1, "sms"    # Landroid/telephony/SmsMessage;
    .param p2, "values"    # Landroid/content/ContentValues;
    .param p3, "statsOnSim"    # I

    .prologue
    const/4 v0, 0x0

    .local v0, "safeSmsField":B
    const/4 v1, 0x1

    if-eq p3, v1, :cond_0

    const/4 v1, 0x3

    if-ne p3, v1, :cond_1

    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v1

    iget-byte v0, v1, Lcom/android/internal/telephony/SmsHeader;->safeSMS:B

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "insert SAFE SMS DB() Value = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    :cond_1
    const-string v1, "c0_iei"

    invoke-static {v0}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v2

    invoke-virtual {p2, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Byte;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "insert SAFE SMS DB() Value = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    return-void
.end method

.method private updateCurrentIccSimMessageProvider(Ljava/util/ArrayList;)Z
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<[B>;)Z"
        }
    .end annotation

    .prologue
    .local p1, "messages":Ljava/util/ArrayList;, "Ljava/util/ArrayList<[B>;"
    const/4 v7, 0x0

    :try_start_0
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v1

    .local v1, "count":I
    const/4 v5, 0x0

    .local v5, "sms":Landroid/telephony/SmsMessage;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "updateCurrentIccSimMessageProvider(), messages size= "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    if-ge v4, v1, :cond_3

    invoke-virtual {p1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    .local v0, "ba":[B
    if-eqz v0, :cond_0

    const/4 v6, 0x0

    aget-byte v6, v0, v6

    if-eqz v6, :cond_0

    new-instance v2, Lcom/android/internal/telephony/SmsRawData;

    invoke-virtual {p1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, [B

    invoke-direct {v2, v6}, Lcom/android/internal/telephony/SmsRawData;-><init>([B)V

    .local v2, "data":Lcom/android/internal/telephony/SmsRawData;
    invoke-direct {p0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isRuimCard()Z

    move-result v6

    if-eqz v6, :cond_1

    add-int/lit8 v6, v4, 0x1

    invoke-virtual {v2}, Lcom/android/internal/telephony/SmsRawData;->getBytes()[B

    move-result-object v8

    invoke-static {v6, v8}, Landroid/telephony/SmsMessage;->createFromEfRecord(I[B)Landroid/telephony/SmsMessage;

    move-result-object v5

    :goto_1
    if-eqz v5, :cond_2

    invoke-direct {p0, v5}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->updateMessagefromSim(Landroid/telephony/SmsMessage;)V

    .end local v2    # "data":Lcom/android/internal/telephony/SmsRawData;
    :cond_0
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .restart local v2    # "data":Lcom/android/internal/telephony/SmsRawData;
    :cond_1
    add-int/lit8 v6, v4, 0x1

    invoke-virtual {v2}, Lcom/android/internal/telephony/SmsRawData;->getBytes()[B

    move-result-object v8

    const-string v9, "3gpp"

    invoke-static {v6, v8, v9}, Landroid/telephony/SmsMessage;->createFromEfRecord(I[BLjava/lang/String;)Landroid/telephony/SmsMessage;

    move-result-object v5

    goto :goto_1

    :cond_2
    const-string v6, "updateCurrentIccSimMessageProvider(), SmsMessage is null. It is created from createFromEfRecord()."

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Landroid/database/SQLException; {:try_start_0 .. :try_end_0} :catch_2

    goto :goto_2

    .end local v0    # "ba":[B
    .end local v1    # "count":I
    .end local v2    # "data":Lcom/android/internal/telephony/SmsRawData;
    .end local v4    # "i":I
    .end local v5    # "sms":Landroid/telephony/SmsMessage;
    :catch_0
    move-exception v3

    .local v3, "e":Ljava/lang/NullPointerException;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "updateCurrentIccSimMessageProvider(), NullPointerException"

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Ljava/lang/NullPointerException;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .end local v3    # "e":Ljava/lang/NullPointerException;
    :goto_3
    move v6, v7

    :goto_4
    return v6

    .restart local v1    # "count":I
    .restart local v4    # "i":I
    .restart local v5    # "sms":Landroid/telephony/SmsMessage;
    :cond_3
    :try_start_1
    iget-object v6, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    iget-object v8, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mContext:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v8

    sget-object v9, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->SMS_CONCAT_URI:Landroid/net/Uri;

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-static {v6, v8, v9, v10, v11}, Landroid/database/sqlite/SqliteWrapper;->delete(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Landroid/database/SQLException; {:try_start_1 .. :try_end_1} :catch_2

    const/4 v6, 0x1

    goto :goto_4

    .end local v1    # "count":I
    .end local v4    # "i":I
    .end local v5    # "sms":Landroid/telephony/SmsMessage;
    :catch_1
    move-exception v3

    .local v3, "e":Ljava/lang/IllegalArgumentException;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "updateCurrentIccSimMessageProvider(), IllegalArgumentException"

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_3

    .end local v3    # "e":Ljava/lang/IllegalArgumentException;
    :catch_2
    move-exception v3

    .local v3, "e":Landroid/database/SQLException;
    const-string v6, "updateCurrentIccSimMessageProvider(), Can\'t store current SMS in SIM to SQLite DB"

    invoke-static {v6, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_3
.end method

.method private updateMessagefromSim(Landroid/telephony/SmsMessage;)V
    .locals 2
    .param p1, "sms"    # Landroid/telephony/SmsMessage;

    .prologue
    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v0

    .local v0, "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    if-eqz v0, :cond_0

    iget-object v1, v0, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    if-nez v1, :cond_1

    :cond_0
    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getStatusOnIcc()I

    move-result v1

    invoke-direct {p0, v1, p1}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->insertSmsDB(ILandroid/telephony/SmsMessage;)Landroid/net/Uri;

    :goto_0
    return-void

    :cond_1
    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getStatusOnIcc()I

    move-result v1

    invoke-direct {p0, v1, p1}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->insertSmsDBForConcat(ILandroid/telephony/SmsMessage;)V

    goto :goto_0
.end method


# virtual methods
.method public handleSimSmses(Ljava/util/ArrayList;I)V
    .locals 3
    .param p2, "slotId"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<[B>;I)V"
        }
    .end annotation

    .prologue
    .local p1, "messages":Ljava/util/ArrayList;, "Ljava/util/ArrayList<[B>;"
    const-string v1, "handleSimSmses(), start"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    const/4 v1, 0x0

    const-string v2, "uicc_csim"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->emptySimCache()V

    :cond_0
    iput p2, p0, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->mSlotIdValue:I

    move-object v0, p1

    .local v0, "simSmsMessage":Ljava/util/ArrayList;, "Ljava/util/ArrayList<[B>;"
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl$1;

    invoke-direct {v2, p0, v0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl$1;-><init>(Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;Ljava/util/ArrayList;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public initSimSmsUpdate(I)V
    .locals 4
    .param p1, "slotId"    # I

    .prologue
    sget-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->sSMSLoadingLock:Ljava/lang/Object;

    monitor-enter v2

    const/4 v1, 0x3

    if-ge p1, v1, :cond_0

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    :try_start_0
    sget-object v1, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->sSimSMSUpdateFlag:[[Z

    aget-object v1, v1, v0

    const/4 v3, 0x0

    aput-boolean v3, v1, p1

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .end local v0    # "i":I
    :cond_0
    monitor-exit v2

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public mSimUpdateSimMsgProvider(Ljava/util/ArrayList;I)Z
    .locals 5
    .param p2, "slotId"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<[B>;I)Z"
        }
    .end annotation

    .prologue
    .local p1, "sim_messages":Ljava/util/ArrayList;, "Ljava/util/ArrayList<[B>;"
    const/4 v0, 0x0

    .local v0, "retval":Z
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mSimUpdateSimMsgProvider()++ slotId="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", sSMSLoadingLock="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->sSMSLoadingLock:Ljava/lang/Object;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    const/4 v2, 0x3

    if-lt p2, v2, :cond_0

    move v1, v0

    .end local v0    # "retval":Z
    .local v1, "retval":I
    :goto_0
    return v1

    .end local v1    # "retval":I
    .restart local v0    # "retval":Z
    :cond_0
    sget-object v3, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->sSMSLoadingLock:Ljava/lang/Object;

    monitor-enter v3

    :try_start_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mSimUpdateSimMsgProvider() trigger slotId="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, ", isRuimCard="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-direct {p0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isRuimCard()Z

    move-result v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->isRuimCard()Z

    move-result v2

    if-eqz v2, :cond_2

    sget-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->sSimSMSUpdateFlag:[[Z

    const/4 v4, 0x1

    aget-object v2, v2, v4

    aget-boolean v2, v2, p2

    if-nez v2, :cond_1

    sget-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->sSimSMSUpdateFlag:[[Z

    const/4 v4, 0x1

    aget-object v2, v2, v4

    const/4 v4, 0x1

    aput-boolean v4, v2, p2

    invoke-direct {p0, p1}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->updateCurrentIccSimMessageProvider(Ljava/util/ArrayList;)Z

    move-result v0

    :cond_1
    :goto_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mSimUpdateSimMsgProvider()-- slotId="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, ", retval="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    monitor-exit v3

    move v1, v0

    .restart local v1    # "retval":I
    goto :goto_0

    .end local v1    # "retval":I
    :cond_2
    sget-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->sSimSMSUpdateFlag:[[Z

    const/4 v4, 0x0

    aget-object v2, v2, v4

    aget-boolean v2, v2, p2

    if-nez v2, :cond_1

    sget-object v2, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->sSimSMSUpdateFlag:[[Z

    const/4 v4, 0x0

    aget-object v2, v2, v4

    const/4 v4, 0x1

    aput-boolean v4, v2, p2

    invoke-direct {p0, p1}, Lcom/android/internal/telephony/uicc/LGSmsSimUtilsImpl;->updateCurrentIccSimMessageProvider(Ljava/util/ArrayList;)Z

    move-result v0

    goto :goto_1

    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2
.end method
