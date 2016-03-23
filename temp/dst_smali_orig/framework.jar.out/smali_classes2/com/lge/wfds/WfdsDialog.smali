.class public Lcom/lge/wfds/WfdsDialog;
.super Ljava/lang/Object;
.source "WfdsDialog.java"


# static fields
.field private static final BASE:I = 0x901028

.field private static final TAG:Ljava/lang/String; = "WfdsDialog"

.field public static final WFDS_PEER_CONNECT_USER_ACCEPT:I = 0x901029

.field public static final WFDS_PEER_CONNECT_USER_REJECT:I = 0x90102a


# instance fields
.field private mContext:Landroid/content/Context;

.field private mProvDialog:Landroid/app/AlertDialog;

.field private mProvEnterPinDialog:Landroid/app/AlertDialog;

.field private mProvShowPinDialog:Landroid/app/AlertDialog;

.field private mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;

.field private mWfdsStateMachine:Lcom/android/internal/util/StateMachine;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/util/StateMachine;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "stateMachine"    # Lcom/android/internal/util/StateMachine;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/wfds/WfdsDialog;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/lge/wfds/WfdsDialog;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wfds/WfdsDialog;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/util/StateMachine;Lcom/lge/wfds/WfdsPeerList;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "stateMachine"    # Lcom/android/internal/util/StateMachine;
    .param p3, "peerList"    # Lcom/lge/wfds/WfdsPeerList;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/wfds/WfdsDialog;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/lge/wfds/WfdsDialog;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    iput-object p3, p0, Lcom/lge/wfds/WfdsDialog;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;

    return-void
.end method

.method static synthetic access$000(Lcom/lge/wfds/WfdsDialog;)Lcom/android/internal/util/StateMachine;
    .locals 1
    .param p0, "x0"    # Lcom/lge/wfds/WfdsDialog;

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDialog;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;

    return-object v0
.end method

.method private addRowToDialog(Landroid/view/ViewGroup;ILjava/lang/String;)V
    .locals 5
    .param p1, "group"    # Landroid/view/ViewGroup;
    .param p2, "stringId"    # I
    .param p3, "value"    # Ljava/lang/String;

    .prologue
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    .local v0, "r":Landroid/content/res/Resources;
    iget-object v2, p0, Lcom/lge/wfds/WfdsDialog;->mContext:Landroid/content/Context;

    invoke-static {v2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$layout;->wifi_p2p_dialog_row:I

    const/4 v4, 0x0

    invoke-virtual {v2, v3, p1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v1

    .local v1, "row":Landroid/view/View;
    sget v2, Lcom/lge/internal/R$id;->p2p_dialog_name:I

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    invoke-virtual {v0, p2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget v2, Lcom/lge/internal/R$id;->p2p_dialog_value:I

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    invoke-virtual {v2, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-void
.end method

.method private getDeviceName(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "deviceAddress"    # Ljava/lang/String;

    .prologue
    iget-object v1, p0, Lcom/lge/wfds/WfdsDialog;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/wfds/WfdsDialog;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;

    invoke-virtual {v1, p1}, Lcom/lge/wfds/WfdsPeerList;->getPeerDevice(Ljava/lang/String;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    .local v0, "wfdsDevice":Lcom/lge/wfds/WfdsDevice;
    if-eqz v0, :cond_0

    iget-object p1, v0, Lcom/lge/wfds/WfdsDevice;->deviceName:Ljava/lang/String;

    .end local v0    # "wfdsDevice":Lcom/lge/wfds/WfdsDevice;
    .end local p1    # "deviceAddress":Ljava/lang/String;
    :cond_0
    return-object p1
.end method


# virtual methods
.method public dismissEnterPinDialog()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDialog;->mProvEnterPinDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsDialog;->mProvEnterPinDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsDialog;->mProvEnterPinDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    :cond_0
    return-void
.end method

.method public dismissShowPinDialog()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDialog;->mProvShowPinDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsDialog;->mProvShowPinDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsDialog;->mProvShowPinDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    :cond_0
    return-void
.end method

.method public dismissUserInputDialog()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsDialog;->mProvDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsDialog;->mProvDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsDialog;->mProvDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    :cond_0
    return-void
.end method

.method public showProvDeferUserInputDialog(Ljava/lang/String;)Z
    .locals 7
    .param p1, "deviceAddress"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    if-nez p1, :cond_1

    :cond_0
    :goto_0
    return v3

    :cond_1
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    .local v1, "r":Landroid/content/res/Resources;
    iget-object v4, p0, Lcom/lge/wfds/WfdsDialog;->mContext:Landroid/content/Context;

    invoke-static {v4}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v4

    const v5, 0x10900ef

    const/4 v6, 0x0

    invoke-virtual {v4, v5, v6}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    .local v2, "view":Landroid/view/View;
    const v4, 0x1020334

    invoke-virtual {v2, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    .local v0, "group":Landroid/view/ViewGroup;
    const v4, 0x10404c7

    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsDialog;->getDeviceName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v0, v4, v5}, Lcom/lge/wfds/WfdsDialog;->addRowToDialog(Landroid/view/ViewGroup;ILjava/lang/String;)V

    new-instance v4, Landroid/app/AlertDialog$Builder;

    iget-object v5, p0, Lcom/lge/wfds/WfdsDialog;->mContext:Landroid/content/Context;

    invoke-direct {v4, v5}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v5, 0x10404c5

    invoke-virtual {v1, v5}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    invoke-virtual {v4, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    const v5, 0x10404c2

    invoke-virtual {v1, v5}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lcom/lge/wfds/WfdsDialog$3;

    invoke-direct {v6, p0}, Lcom/lge/wfds/WfdsDialog$3;-><init>(Lcom/lge/wfds/WfdsDialog;)V

    invoke-virtual {v4, v5, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    const v5, 0x10404c3

    invoke-virtual {v1, v5}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lcom/lge/wfds/WfdsDialog$2;

    invoke-direct {v6, p0}, Lcom/lge/wfds/WfdsDialog$2;-><init>(Lcom/lge/wfds/WfdsDialog;)V

    invoke-virtual {v4, v5, v6}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    new-instance v5, Lcom/lge/wfds/WfdsDialog$1;

    invoke-direct {v5, p0}, Lcom/lge/wfds/WfdsDialog$1;-><init>(Lcom/lge/wfds/WfdsDialog;)V

    invoke-virtual {v4, v5}, Landroid/app/AlertDialog$Builder;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    invoke-virtual {v4}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/wfds/WfdsDialog;->mProvDialog:Landroid/app/AlertDialog;

    iget-object v4, p0, Lcom/lge/wfds/WfdsDialog;->mProvDialog:Landroid/app/AlertDialog;

    invoke-virtual {v4}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v4

    const/16 v5, 0x7d3

    invoke-virtual {v4, v5}, Landroid/view/Window;->setType(I)V

    iget-object v4, p0, Lcom/lge/wfds/WfdsDialog;->mProvDialog:Landroid/app/AlertDialog;

    invoke-virtual {v4}, Landroid/app/AlertDialog;->show()V

    iget-object v4, p0, Lcom/lge/wfds/WfdsDialog;->mProvDialog:Landroid/app/AlertDialog;

    if-eqz v4, :cond_0

    const/4 v3, 0x1

    goto :goto_0
.end method

.method public showProvDiscEnterPinDialog(Ljava/lang/String;Landroid/net/wifi/WpsInfo;)Z
    .locals 9
    .param p1, "deviceAddress"    # Ljava/lang/String;
    .param p2, "wpsInfo"    # Landroid/net/wifi/WpsInfo;

    .prologue
    const/4 v5, 0x0

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v2

    .local v2, "r":Landroid/content/res/Resources;
    move-object v4, p2

    .local v4, "wpsInfoValue":Landroid/net/wifi/WpsInfo;
    iget-object v6, p0, Lcom/lge/wfds/WfdsDialog;->mContext:Landroid/content/Context;

    invoke-static {v6}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v6

    const v7, 0x10900ef

    const/4 v8, 0x0

    invoke-virtual {v6, v7, v8}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v3

    .local v3, "view":Landroid/view/View;
    const v6, 0x1020334

    invoke-virtual {v3, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    .local v0, "group":Landroid/view/ViewGroup;
    const v6, 0x10404c7

    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsDialog;->getDeviceName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {p0, v0, v6, v7}, Lcom/lge/wfds/WfdsDialog;->addRowToDialog(Landroid/view/ViewGroup;ILjava/lang/String;)V

    const v6, 0x10203d0

    invoke-virtual {v3, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    .local v1, "pin":Landroid/widget/EditText;
    const-string v6, "DISABLE_BUBBLE_POPUP"

    invoke-virtual {v1, v6}, Landroid/widget/EditText;->setPrivateImeOptions(Ljava/lang/String;)V

    new-instance v6, Landroid/app/AlertDialog$Builder;

    iget-object v7, p0, Lcom/lge/wfds/WfdsDialog;->mContext:Landroid/content/Context;

    invoke-direct {v6, v7}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v7, 0x10404c5

    invoke-virtual {v2, v7}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    invoke-virtual {v6, v3}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    const v7, 0x10404c2

    invoke-virtual {v2, v7}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Lcom/lge/wfds/WfdsDialog$6;

    invoke-direct {v8, p0, v4, v1}, Lcom/lge/wfds/WfdsDialog$6;-><init>(Lcom/lge/wfds/WfdsDialog;Landroid/net/wifi/WpsInfo;Landroid/widget/EditText;)V

    invoke-virtual {v6, v7, v8}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    const v7, 0x10404c3

    invoke-virtual {v2, v7}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Lcom/lge/wfds/WfdsDialog$5;

    invoke-direct {v8, p0}, Lcom/lge/wfds/WfdsDialog$5;-><init>(Lcom/lge/wfds/WfdsDialog;)V

    invoke-virtual {v6, v7, v8}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    new-instance v7, Lcom/lge/wfds/WfdsDialog$4;

    invoke-direct {v7, p0}, Lcom/lge/wfds/WfdsDialog$4;-><init>(Lcom/lge/wfds/WfdsDialog;)V

    invoke-virtual {v6, v7}, Landroid/app/AlertDialog$Builder;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    invoke-virtual {v6}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v6

    iput-object v6, p0, Lcom/lge/wfds/WfdsDialog;->mProvEnterPinDialog:Landroid/app/AlertDialog;

    const v6, 0x10203cf

    invoke-virtual {v3, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6, v5}, Landroid/view/View;->setVisibility(I)V

    iget-object v6, p0, Lcom/lge/wfds/WfdsDialog;->mProvEnterPinDialog:Landroid/app/AlertDialog;

    invoke-virtual {v6}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v6

    const/4 v7, 0x4

    invoke-virtual {v6, v7}, Landroid/view/Window;->setSoftInputMode(I)V

    iget-object v6, p0, Lcom/lge/wfds/WfdsDialog;->mProvEnterPinDialog:Landroid/app/AlertDialog;

    invoke-virtual {v6}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v6

    const/16 v7, 0x7d3

    invoke-virtual {v6, v7}, Landroid/view/Window;->setType(I)V

    iget-object v6, p0, Lcom/lge/wfds/WfdsDialog;->mProvEnterPinDialog:Landroid/app/AlertDialog;

    invoke-virtual {v6}, Landroid/app/AlertDialog;->show()V

    iget-object v6, p0, Lcom/lge/wfds/WfdsDialog;->mProvEnterPinDialog:Landroid/app/AlertDialog;

    if-eqz v6, :cond_0

    const/4 v5, 0x1

    :cond_0
    return v5
.end method

.method public showProvDiscShowPinDialog(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 6
    .param p1, "deviceAddress"    # Ljava/lang/String;
    .param p2, "pin"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x0

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    .local v1, "r":Landroid/content/res/Resources;
    iget-object v3, p0, Lcom/lge/wfds/WfdsDialog;->mContext:Landroid/content/Context;

    invoke-static {v3}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v3

    const v4, 0x10900ef

    invoke-virtual {v3, v4, v5}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    .local v2, "view":Landroid/view/View;
    const v3, 0x1020334

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    .local v0, "group":Landroid/view/ViewGroup;
    const v3, 0x10404c8

    invoke-direct {p0, p1}, Lcom/lge/wfds/WfdsDialog;->getDeviceName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v0, v3, v4}, Lcom/lge/wfds/WfdsDialog;->addRowToDialog(Landroid/view/ViewGroup;ILjava/lang/String;)V

    const v3, 0x10404ca

    invoke-direct {p0, v0, v3, p2}, Lcom/lge/wfds/WfdsDialog;->addRowToDialog(Landroid/view/ViewGroup;ILjava/lang/String;)V

    new-instance v3, Landroid/app/AlertDialog$Builder;

    iget-object v4, p0, Lcom/lge/wfds/WfdsDialog;->mContext:Landroid/content/Context;

    invoke-direct {v3, v4}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v4, 0x10404c4

    invoke-virtual {v1, v4}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    invoke-virtual {v3, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    const v4, 0x104000a

    invoke-virtual {v1, v4}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    invoke-virtual {v3}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v3

    iput-object v3, p0, Lcom/lge/wfds/WfdsDialog;->mProvShowPinDialog:Landroid/app/AlertDialog;

    iget-object v3, p0, Lcom/lge/wfds/WfdsDialog;->mProvShowPinDialog:Landroid/app/AlertDialog;

    invoke-virtual {v3}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    const/16 v4, 0x7d3

    invoke-virtual {v3, v4}, Landroid/view/Window;->setType(I)V

    iget-object v3, p0, Lcom/lge/wfds/WfdsDialog;->mProvShowPinDialog:Landroid/app/AlertDialog;

    invoke-virtual {v3}, Landroid/app/AlertDialog;->show()V

    iget-object v3, p0, Lcom/lge/wfds/WfdsDialog;->mProvShowPinDialog:Landroid/app/AlertDialog;

    if-eqz v3, :cond_0

    const/4 v3, 0x1

    :goto_0
    return v3

    :cond_0
    const/4 v3, 0x0

    goto :goto_0
.end method
