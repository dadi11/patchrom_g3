.class final Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;
.super Ljava/lang/Object;
.source "SMSDispatcher.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;
.implements Landroid/content/DialogInterface$OnCancelListener;
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/SMSDispatcher;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "ConfirmDialogListener"
.end annotation


# instance fields
.field private backupDialog:Landroid/content/DialogInterface;

.field private mNegativeButton:Landroid/widget/Button;

.field private mPositiveButton:Landroid/widget/Button;

.field private mRememberChoice:Z

.field private final mRememberUndoInstruction:Landroid/widget/TextView;

.field private final mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

.field final synthetic this$0:Lcom/android/internal/telephony/SMSDispatcher;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/SMSDispatcher;Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;Landroid/widget/TextView;)V
    .locals 1
    .param p2, "tracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    .param p3, "textView"    # Landroid/widget/TextView;

    .prologue
    .line 1504
    iput-object p1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1501
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->backupDialog:Landroid/content/DialogInterface;

    .line 1505
    iput-object p2, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .line 1506
    iput-object p3, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mRememberUndoInstruction:Landroid/widget/TextView;

    .line 1507
    return-void
.end method

.method private userPermitClickProcess(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;I)V
    .locals 9
    .param p1, "pTracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    .param p2, "event"    # I

    .prologue
    const/4 v8, 0x0

    .line 1519
    iget-object v2, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mData:Ljava/util/HashMap;

    .line 1520
    .local v2, "map":Ljava/util/HashMap;
    const-string v5, "pdu"

    invoke-virtual {v2, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [B

    move-object v3, v5

    check-cast v3, [B

    .line 1521
    .local v3, "pdu":[B
    const-string v5, "smsHeader"

    invoke-virtual {v2, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/SmsHeader;

    .line 1522
    .local v0, "currentConcat":Lcom/android/internal/telephony/SmsHeader;
    if-eqz v0, :cond_2

    .line 1524
    iget-object v5, v0, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v5, v5, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->refNumber:I

    rem-int/lit8 v1, v5, 0x5

    .line 1525
    .local v1, "currentConcatIndex":I
    const/4 v4, 0x0

    .local v4, "segIndex":I
    :goto_0
    iget-object v5, v0, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v5, v5, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->msgCount:I

    if-ge v4, v5, :cond_1

    .line 1526
    sget-object v5, Lcom/android/internal/telephony/SMSDispatcher;->mTrackerForConcat:[[Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    aget-object v5, v5, v1

    if-eqz v5, :cond_0

    sget-object v5, Lcom/android/internal/telephony/SMSDispatcher;->mTrackerForConcat:[[Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    aget-object v5, v5, v1

    aget-object v5, v5, v4

    if-eqz v5, :cond_0

    .line 1527
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    sget-object v7, Lcom/android/internal/telephony/SMSDispatcher;->mTrackerForConcat:[[Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    aget-object v7, v7, v1

    aget-object v7, v7, v4

    invoke-virtual {v6, p2, v7}, Lcom/android/internal/telephony/SMSDispatcher;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/android/internal/telephony/SMSDispatcher;->sendMessage(Landroid/os/Message;)Z

    .line 1529
    :cond_0
    sget-object v5, Lcom/android/internal/telephony/SMSDispatcher;->mTrackerForConcat:[[Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    aget-object v5, v5, v1

    aput-object v8, v5, v4

    .line 1525
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 1532
    :cond_1
    sget-object v5, Lcom/android/internal/telephony/SMSDispatcher;->mTrackerForConcat:[[Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    aput-object v8, v5, v1

    .line 1533
    sget-object v5, Lcom/android/internal/telephony/SMSDispatcherEx;->isInProgressWithUserPermit:[Z

    const/4 v6, 0x0

    aput-boolean v6, v5, v1

    .line 1538
    .end local v1    # "currentConcatIndex":I
    .end local v4    # "segIndex":I
    :goto_1
    return-void

    .line 1536
    :cond_2
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    invoke-virtual {v6, p2, p1}, Lcom/android/internal/telephony/SMSDispatcher;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/android/internal/telephony/SMSDispatcher;->sendMessage(Landroid/os/Message;)Z

    goto :goto_1
.end method


# virtual methods
.method public onCancel(Landroid/content/DialogInterface;)V
    .locals 4
    .param p1, "dialog"    # Landroid/content/DialogInterface;

    .prologue
    .line 1592
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->backupDialog:Landroid/content/DialogInterface;

    if-ne p1, v0, :cond_0

    .line 1593
    const-string v0, "SMSDispatcher"

    const-string v1, "Duplicated dialog onCancel event - throw"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1600
    :goto_0
    return-void

    .line 1596
    :cond_0
    iput-object p1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->backupDialog:Landroid/content/DialogInterface;

    .line 1598
    const-string v0, "SMSDispatcher"

    const-string v1, "dialog dismissed: don\'t send SMS"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1599
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    const/4 v2, 0x7

    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    invoke-virtual {v1, v2, v3}, Lcom/android/internal/telephony/SMSDispatcher;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/SMSDispatcher;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method

.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 4
    .param p1, "buttonView"    # Landroid/widget/CompoundButton;
    .param p2, "isChecked"    # Z

    .prologue
    const/4 v3, 0x0

    .line 1604
    const-string v0, "SMSDispatcher"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "remember this choice: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1605
    iput-boolean p2, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mRememberChoice:Z

    .line 1606
    invoke-virtual {p1, v3}, Landroid/widget/CompoundButton;->playSoundEffect(I)V

    .line 1607
    if-eqz p2, :cond_1

    .line 1608
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mPositiveButton:Landroid/widget/Button;

    const v1, 0x10404d8

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    .line 1609
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mNegativeButton:Landroid/widget/Button;

    const v1, 0x10404d9

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    .line 1610
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mRememberUndoInstruction:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    .line 1611
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mRememberUndoInstruction:Landroid/widget/TextView;

    const v1, 0x10404d7

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    .line 1613
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mRememberUndoInstruction:Landroid/widget/TextView;

    const/16 v1, 0x20

    invoke-virtual {v0, v3, v3, v3, v1}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 1623
    :cond_0
    :goto_0
    return-void

    .line 1616
    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mPositiveButton:Landroid/widget/Button;

    const v1, 0x10404d4

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    .line 1617
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mNegativeButton:Landroid/widget/Button;

    const v1, 0x10404d5

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    .line 1618
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mRememberUndoInstruction:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    .line 1619
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mRememberUndoInstruction:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1620
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mRememberUndoInstruction:Landroid/widget/TextView;

    invoke-virtual {v0, v3, v3, v3, v3}, Landroid/widget/TextView;->setPadding(IIII)V

    goto :goto_0
.end method

.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 6
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .prologue
    const/4 v5, 0x7

    const/4 v4, 0x5

    const/4 v1, -0x1

    .line 1545
    const/4 v0, 0x1

    .line 1547
    .local v0, "newSmsPermission":I
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->backupDialog:Landroid/content/DialogInterface;

    if-ne p1, v2, :cond_0

    .line 1548
    const-string v1, "SMSDispatcher"

    const-string v2, "Duplicated dialog onClick event - throw"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1587
    :goto_0
    return-void

    .line 1551
    :cond_0
    iput-object p1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->backupDialog:Landroid/content/DialogInterface;

    .line 1553
    if-ne p2, v1, :cond_4

    .line 1554
    const-string v2, "SMSDispatcher"

    const-string v3, "CONFIRM sending SMS"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1556
    const v2, 0xc3d0

    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    iget-object v3, v3, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mAppInfo:Landroid/content/pm/PackageInfo;

    iget-object v3, v3, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    if-nez v3, :cond_2

    :goto_1
    invoke-static {v2, v1}, Landroid/util/EventLog;->writeEvent(II)I

    .line 1560
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    iget-object v1, v1, Lcom/android/internal/telephony/SMSDispatcher;->mContext:Landroid/content/Context;

    const-string v2, "modify_check_confirm_popup_concat_message_mo"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 1561
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    invoke-direct {p0, v1, v4}, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->userPermitClickProcess(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;I)V

    .line 1566
    :goto_2
    iget-boolean v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mRememberChoice:Z

    if-eqz v1, :cond_1

    .line 1567
    const/4 v0, 0x3

    .line 1586
    :cond_1
    :goto_3
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mAppInfo:Landroid/content/pm/PackageInfo;

    iget-object v2, v2, Landroid/content/pm/PackageInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v1, v2, v0}, Lcom/android/internal/telephony/SMSDispatcher;->setPremiumSmsPermission(Ljava/lang/String;I)V

    goto :goto_0

    .line 1556
    :cond_2
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    iget-object v1, v1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mAppInfo:Landroid/content/pm/PackageInfo;

    iget-object v1, v1, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget v1, v1, Landroid/content/pm/ApplicationInfo;->uid:I

    goto :goto_1

    .line 1564
    :cond_3
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    invoke-virtual {v2, v4, v3}, Lcom/android/internal/telephony/SMSDispatcher;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/SMSDispatcher;->sendMessage(Landroid/os/Message;)Z

    goto :goto_2

    .line 1569
    :cond_4
    const/4 v2, -0x2

    if-ne p2, v2, :cond_1

    .line 1570
    const-string v2, "SMSDispatcher"

    const-string v3, "DENY sending SMS"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1572
    const v2, 0xc3cd

    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    iget-object v3, v3, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mAppInfo:Landroid/content/pm/PackageInfo;

    iget-object v3, v3, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    if-nez v3, :cond_5

    :goto_4
    invoke-static {v2, v1}, Landroid/util/EventLog;->writeEvent(II)I

    .line 1576
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    iget-object v1, v1, Lcom/android/internal/telephony/SMSDispatcher;->mContext:Landroid/content/Context;

    const-string v2, "modify_check_confirm_popup_concat_message_mo"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 1577
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    invoke-direct {p0, v1, v5}, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->userPermitClickProcess(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;I)V

    .line 1582
    :goto_5
    iget-boolean v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mRememberChoice:Z

    if-eqz v1, :cond_1

    .line 1583
    const/4 v0, 0x2

    goto :goto_3

    .line 1572
    :cond_5
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    iget-object v1, v1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mAppInfo:Landroid/content/pm/PackageInfo;

    iget-object v1, v1, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget v1, v1, Landroid/content/pm/ApplicationInfo;->uid:I

    goto :goto_4

    .line 1580
    :cond_6
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->this$0:Lcom/android/internal/telephony/SMSDispatcher;

    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mTracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    invoke-virtual {v2, v5, v3}, Lcom/android/internal/telephony/SMSDispatcher;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/SMSDispatcher;->sendMessage(Landroid/os/Message;)Z

    goto :goto_5
.end method

.method setNegativeButton(Landroid/widget/Button;)V
    .locals 0
    .param p1, "button"    # Landroid/widget/Button;

    .prologue
    .line 1514
    iput-object p1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mNegativeButton:Landroid/widget/Button;

    .line 1515
    return-void
.end method

.method setPositiveButton(Landroid/widget/Button;)V
    .locals 0
    .param p1, "button"    # Landroid/widget/Button;

    .prologue
    .line 1510
    iput-object p1, p0, Lcom/android/internal/telephony/SMSDispatcher$ConfirmDialogListener;->mPositiveButton:Landroid/widget/Button;

    .line 1511
    return-void
.end method
