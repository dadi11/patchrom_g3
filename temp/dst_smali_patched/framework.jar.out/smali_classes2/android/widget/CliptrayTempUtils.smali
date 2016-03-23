.class Landroid/widget/CliptrayTempUtils;
.super Ljava/lang/Object;
.source "CliptrayTempUtils.java"


# static fields
.field private static final CLIPTRAY_HIDE:Ljava/lang/String; = "com.lge.systemservice.core.cliptray.HIDE_CLIPTRAY"

.field private static final CLIPTRAY_INPUTTYPE:Ljava/lang/String; = "com.lge.systemservice.core.cliptray.INPUTTYPE_CLIPTRAY"

.field private static final CLIPTRAY_SHOW:Ljava/lang/String; = "com.lge.systemservice.core.cliptray.SHOW_CLIPTRAY"

.field private static final INIT_CLIPTRAY:I = 0xa

.field private static final INPUT_TYPE_TEXT_IMAGE:I = 0x2

.field private static final INPUT_TYPE_TEXT_ONLY:I = 0x0

.field private static POPUP_TEXT_LAYOUT:I = 0x0

.field private static final TAG:Ljava/lang/String; = "Cliptray Temp Utils"

.field private static mCliptrayTextView:Landroid/widget/TextView;

.field private static mTextView:Landroid/widget/TextView;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const v0, 0x10900d8

    sput v0, Landroid/widget/CliptrayTempUtils;->POPUP_TEXT_LAYOUT:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static hideClipTray()V
    .locals 2

    .prologue
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.systemservice.core.cliptray.HIDE_CLIPTRAY"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    sget-object v1, Landroid/widget/CliptrayTempUtils;->mTextView:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    return-void
.end method

.method static hideClipTrayIfNeeded()V
    .locals 2

    .prologue
    sget-object v0, Landroid/widget/CliptrayTempUtils;->mTextView:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->isFocused()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "Cliptray Temp Utils"

    const-string v1, "hideClipTrayIfNeeded() TextView is focused!! hideClipTray()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Landroid/widget/CliptrayTempUtils;->hideClipTray()V

    :cond_0
    return-void
.end method

.method static initCliptrayPopupWindow(Landroid/view/LayoutInflater;Landroid/view/ViewGroup$LayoutParams;Landroid/view/ViewGroup;Landroid/view/View$OnClickListener;)V
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;
    .param p1, "wrapContent"    # Landroid/view/ViewGroup$LayoutParams;
    .param p2, "mContentView"    # Landroid/view/ViewGroup;
    .param p3, "listener"    # Landroid/view/View$OnClickListener;

    .prologue
    invoke-static {}, Landroid/widget/CliptrayTempUtils;->isOwnerforClipTray()Z

    move-result v0

    if-eqz v0, :cond_0

    sget v0, Landroid/widget/CliptrayTempUtils;->POPUP_TEXT_LAYOUT:I

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Landroid/widget/CliptrayTempUtils;->mCliptrayTextView:Landroid/widget/TextView;

    sget-object v0, Landroid/widget/CliptrayTempUtils;->mCliptrayTextView:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    sget-object v0, Landroid/widget/CliptrayTempUtils;->mCliptrayTextView:Landroid/widget/TextView;

    invoke-virtual {p2, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    sget-object v0, Landroid/widget/CliptrayTempUtils;->mCliptrayTextView:Landroid/widget/TextView;

    const-string v1, "Clip Tray"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget-object v0, Landroid/widget/CliptrayTempUtils;->mCliptrayTextView:Landroid/widget/TextView;

    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_0
    return-void
.end method

.method static isOwnerforClipTray()Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    .local v0, "mIsOwner":Z
    const-string v1, "kids"

    const-string v2, "service.plushome.currenthome"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x0

    :cond_0
    invoke-static {}, Landroid/os/UserHandle;->myUserId()I

    move-result v1

    if-eqz v1, :cond_1

    const/4 v0, 0x0

    :cond_1
    const-string v1, "Cliptray Temp Utils"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isOwnerforClipTray():mIsOwner :  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return v0
.end method

.method static setInputTypeIfNeeded(Landroid/widget/Editor$InputContentType;Z)V
    .locals 0
    .param p0, "mInputContentType"    # Landroid/widget/Editor$InputContentType;
    .param p1, "init"    # Z

    .prologue
    invoke-static {p0, p1}, Landroid/widget/CliptrayTempUtils;->setInputTypeforClipTray(Landroid/widget/Editor$InputContentType;Z)V

    return-void
.end method

.method private static setInputTypeforClipTray(Landroid/widget/Editor$InputContentType;Z)V
    .locals 6
    .param p0, "mInputContentType"    # Landroid/widget/Editor$InputContentType;
    .param p1, "init"    # Z

    .prologue
    new-instance v1, Landroid/content/Intent;

    const-string v3, "com.lge.systemservice.core.cliptray.INPUTTYPE_CLIPTRAY"

    invoke-direct {v1, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v1, "intent":Landroid/content/Intent;
    if-eqz p1, :cond_0

    const-string v3, "Inputtype"

    const/16 v4, 0xa

    invoke-virtual {v1, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    :goto_0
    sget-object v3, Landroid/widget/CliptrayTempUtils;->mTextView:Landroid/widget/TextView;

    invoke-virtual {v3}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    return-void

    :cond_0
    const/4 v3, 0x0

    const/4 v4, 0x1

    invoke-static {v3, v4}, Landroid/widget/CliptrayTempUtils;->setInputTypeforClipTray(Landroid/widget/Editor$InputContentType;Z)V

    const/4 v0, 0x0

    .local v0, "inputTypeforClipTray":I
    if-eqz p0, :cond_2

    iget-object v2, p0, Landroid/widget/Editor$InputContentType;->privateImeOptions:Ljava/lang/String;

    .local v2, "options":Ljava/lang/String;
    if-eqz v2, :cond_1

    const-string v3, "com.lge.cliptray.image"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v0, 0x2

    const-string v3, "Cliptray Temp Utils"

    const-string v4, "inputTypeforClipTray = INPUT_TYPE_TEXT_IMAGE"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    const-string v3, "Inputtype"

    invoke-virtual {v1, v3, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .end local v2    # "options":Ljava/lang/String;
    :cond_2
    const-string v3, "Cliptray Temp Utils"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "setInputTypeforClipTray(): "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method static setTextView(Landroid/widget/TextView;)V
    .locals 0
    .param p0, "textView"    # Landroid/widget/TextView;

    .prologue
    sput-object p0, Landroid/widget/CliptrayTempUtils;->mTextView:Landroid/widget/TextView;

    return-void
.end method

.method private static showClipTray()V
    .locals 2

    .prologue
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.systemservice.core.cliptray.SHOW_CLIPTRAY"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    sget-object v1, Landroid/widget/CliptrayTempUtils;->mTextView:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    return-void
.end method

.method static showCliptrayPopupWindow(ZZZ)V
    .locals 5
    .param p0, "canPaste"    # Z
    .param p1, "isPassword"    # Z
    .param p2, "isLockScreen"    # Z

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v4

    if-eqz v4, :cond_1

    invoke-static {}, Lcom/lge/cappuccino/Mdm;->getInstance()Lcom/lge/cappuccino/IMdm;

    move-result-object v4

    invoke-interface {v4, v3}, Lcom/lge/cappuccino/IMdm;->checkDisabledClipboard(Z)Z

    move-result v4

    if-eqz v4, :cond_1

    move v1, v2

    .local v1, "isMDMEnable":Z
    :goto_0
    if-nez v1, :cond_2

    if-eqz p0, :cond_2

    if-nez p1, :cond_2

    if-nez p2, :cond_2

    move v0, v2

    .local v0, "canClipTray":Z
    :goto_1
    sget-object v4, Landroid/widget/CliptrayTempUtils;->mCliptrayTextView:Landroid/widget/TextView;

    if-eqz v4, :cond_0

    sget-object v4, Landroid/widget/CliptrayTempUtils;->mCliptrayTextView:Landroid/widget/TextView;

    if-eqz v0, :cond_3

    :goto_2
    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_0
    const/4 v3, 0x0

    invoke-static {v3, v2}, Landroid/widget/CliptrayTempUtils;->setInputTypeforClipTray(Landroid/widget/Editor$InputContentType;Z)V

    return-void

    .end local v0    # "canClipTray":Z
    .end local v1    # "isMDMEnable":Z
    :cond_1
    move v1, v3

    goto :goto_0

    .restart local v1    # "isMDMEnable":Z
    :cond_2
    move v0, v3

    goto :goto_1

    .restart local v0    # "canClipTray":Z
    :cond_3
    const/16 v3, 0x8

    goto :goto_2
.end method

.method static showCliptrayfromPopupWindow(Landroid/view/View;Z)V
    .locals 4
    .param p0, "view"    # Landroid/view/View;
    .param p1, "mShowSoftInputOnFocus"    # Z

    .prologue
    sget-object v1, Landroid/widget/CliptrayTempUtils;->mCliptrayTextView:Landroid/widget/TextView;

    if-ne v1, p0, :cond_1

    sget-object v1, Landroid/widget/CliptrayTempUtils;->mTextView:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->isTextSelectable()Z

    move-result v1

    if-nez v1, :cond_0

    if-eqz p1, :cond_0

    invoke-static {}, Landroid/view/inputmethod/InputMethodManager;->peekInstance()Landroid/view/inputmethod/InputMethodManager;

    move-result-object v0

    .local v0, "imm":Landroid/view/inputmethod/InputMethodManager;
    if-eqz v0, :cond_0

    sget-object v1, Landroid/widget/CliptrayTempUtils;->mTextView:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->isTextEditable()Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Landroid/widget/CliptrayTempUtils;->mTextView:Landroid/widget/TextView;

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;ILandroid/os/ResultReceiver;)Z

    .end local v0    # "imm":Landroid/view/inputmethod/InputMethodManager;
    :cond_0
    invoke-static {}, Landroid/widget/CliptrayTempUtils;->showClipTray()V

    :cond_1
    return-void
.end method
