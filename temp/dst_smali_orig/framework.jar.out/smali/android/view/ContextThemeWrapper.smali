.class public Landroid/view/ContextThemeWrapper;
.super Landroid/content/ContextWrapper;
.source "ContextThemeWrapper.java"


# static fields
.field private static packagesRequireThemeOverride:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mInflater:Landroid/view/LayoutInflater;

.field private mOverrideConfiguration:Landroid/content/res/Configuration;

.field private mResources:Landroid/content/res/Resources;

.field private mTheme:Landroid/content/res/Resources$Theme;

.field private mThemeResource:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Landroid/view/ContextThemeWrapper;->packagesRequireThemeOverride:Ljava/util/Set;

    sget-object v0, Landroid/view/ContextThemeWrapper;->packagesRequireThemeOverride:Ljava/util/Set;

    const-string v1, "android"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    sget-object v0, Landroid/view/ContextThemeWrapper;->packagesRequireThemeOverride:Ljava/util/Set;

    const-string v1, "com.android.certinstaller"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    sget-object v0, Landroid/view/ContextThemeWrapper;->packagesRequireThemeOverride:Ljava/util/Set;

    const-string v1, "com.android.htmlviewer"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    sget-object v0, Landroid/view/ContextThemeWrapper;->packagesRequireThemeOverride:Ljava/util/Set;

    const-string v1, "com.android.packageinstaller"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Landroid/content/ContextWrapper;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;I)V
    .locals 0
    .param p1, "base"    # Landroid/content/Context;
    .param p2, "themeres"    # I

    .prologue
    invoke-direct {p0, p1}, Landroid/content/ContextWrapper;-><init>(Landroid/content/Context;)V

    iput p2, p0, Landroid/view/ContextThemeWrapper;->mThemeResource:I

    return-void
.end method

.method public static convertTheme(Landroid/content/Context;I)I
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "themeResourceId"    # I

    .prologue
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .local v0, "packageName":Ljava/lang/String;
    const-string v1, "ContextHelper"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "convertTheme. context->name="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " themeResourceId="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v1, Landroid/view/ContextThemeWrapper;->packagesRequireThemeOverride:Ljava/util/Set;

    invoke-interface {v1, v0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    sparse-switch p1, :sswitch_data_0

    .end local p1    # "themeResourceId":I
    :cond_0
    :goto_0
    return p1

    .restart local p1    # "themeResourceId":I
    :sswitch_0
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White:I

    goto :goto_0

    :sswitch_1
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog:I

    goto :goto_0

    :sswitch_2
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_Alert:I

    goto :goto_0

    :sswitch_3
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_MinWidth:I

    goto :goto_0

    :sswitch_4
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_NoActionBar:I

    goto :goto_0

    :sswitch_5
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_NoActionBar_MinWidth:I

    goto :goto_0

    :sswitch_6
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_DialogWhenLarge:I

    goto :goto_0

    :sswitch_7
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_DialogWhenLarge_NoActionBar:I

    goto :goto_0

    :sswitch_8
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White:I

    goto :goto_0

    :sswitch_9
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog:I

    goto :goto_0

    :sswitch_a
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_Alert:I

    goto :goto_0

    :sswitch_b
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_MinWidth:I

    goto :goto_0

    :sswitch_c
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_NoActionBar:I

    goto :goto_0

    :sswitch_d
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_NoActionBar_MinWidth:I

    goto :goto_0

    :sswitch_e
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_DialogWhenLarge:I

    goto :goto_0

    :sswitch_f
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_DialogWhenLarge_NoActionBar:I

    goto :goto_0

    :sswitch_10
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White:I

    goto :goto_0

    :sswitch_11
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog:I

    goto :goto_0

    :sswitch_12
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_Alert:I

    goto :goto_0

    :sswitch_13
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_MinWidth:I

    goto :goto_0

    :sswitch_14
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_NoActionBar:I

    goto :goto_0

    :sswitch_15
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_NoActionBar_MinWidth:I

    goto :goto_0

    :sswitch_16
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_DialogWhenLarge:I

    goto :goto_0

    :sswitch_17
    sget p1, Lcom/lge/internal/R$style;->Theme_LGE_White_DialogWhenLarge_NoActionBar:I

    goto :goto_0

    :sswitch_data_0
    .sparse-switch
        0x103006b -> :sswitch_0
        0x103006f -> :sswitch_1
        0x1030070 -> :sswitch_3
        0x1030071 -> :sswitch_4
        0x1030072 -> :sswitch_5
        0x1030077 -> :sswitch_6
        0x1030078 -> :sswitch_7
        0x1030128 -> :sswitch_8
        0x103012b -> :sswitch_10
        0x103012e -> :sswitch_9
        0x103012f -> :sswitch_b
        0x1030130 -> :sswitch_c
        0x1030131 -> :sswitch_d
        0x1030132 -> :sswitch_11
        0x1030133 -> :sswitch_13
        0x1030134 -> :sswitch_14
        0x1030135 -> :sswitch_15
        0x1030136 -> :sswitch_e
        0x1030137 -> :sswitch_f
        0x1030138 -> :sswitch_16
        0x1030139 -> :sswitch_17
        0x103059d -> :sswitch_2
        0x10305a5 -> :sswitch_a
        0x10305ab -> :sswitch_12
    .end sparse-switch
.end method

.method private initializeTheme()V
    .locals 4

    .prologue
    iget-object v2, p0, Landroid/view/ContextThemeWrapper;->mTheme:Landroid/content/res/Resources$Theme;

    if-nez v2, :cond_1

    const/4 v0, 0x1

    .local v0, "first":Z
    :goto_0
    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/view/ContextThemeWrapper;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->newTheme()Landroid/content/res/Resources$Theme;

    move-result-object v2

    iput-object v2, p0, Landroid/view/ContextThemeWrapper;->mTheme:Landroid/content/res/Resources$Theme;

    invoke-virtual {p0}, Landroid/view/ContextThemeWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v1

    .local v1, "theme":Landroid/content/res/Resources$Theme;
    if-eqz v1, :cond_0

    iget-object v2, p0, Landroid/view/ContextThemeWrapper;->mTheme:Landroid/content/res/Resources$Theme;

    invoke-virtual {v2, v1}, Landroid/content/res/Resources$Theme;->setTo(Landroid/content/res/Resources$Theme;)V

    .end local v1    # "theme":Landroid/content/res/Resources$Theme;
    :cond_0
    iget-object v2, p0, Landroid/view/ContextThemeWrapper;->mTheme:Landroid/content/res/Resources$Theme;

    iget v3, p0, Landroid/view/ContextThemeWrapper;->mThemeResource:I

    invoke-virtual {p0, v2, v3, v0}, Landroid/view/ContextThemeWrapper;->onApplyThemeResource(Landroid/content/res/Resources$Theme;IZ)V

    return-void

    .end local v0    # "first":Z
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public applyOverrideConfiguration(Landroid/content/res/Configuration;)V
    .locals 2
    .param p1, "overrideConfiguration"    # Landroid/content/res/Configuration;

    .prologue
    iget-object v0, p0, Landroid/view/ContextThemeWrapper;->mResources:Landroid/content/res/Resources;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "getResources() has already been called"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iget-object v0, p0, Landroid/view/ContextThemeWrapper;->mOverrideConfiguration:Landroid/content/res/Configuration;

    if-eqz v0, :cond_1

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Override configuration has already been set"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    new-instance v0, Landroid/content/res/Configuration;

    invoke-direct {v0, p1}, Landroid/content/res/Configuration;-><init>(Landroid/content/res/Configuration;)V

    iput-object v0, p0, Landroid/view/ContextThemeWrapper;->mOverrideConfiguration:Landroid/content/res/Configuration;

    return-void
.end method

.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 0
    .param p1, "newBase"    # Landroid/content/Context;

    .prologue
    invoke-super {p0, p1}, Landroid/content/ContextWrapper;->attachBaseContext(Landroid/content/Context;)V

    return-void
.end method

.method public getResources()Landroid/content/res/Resources;
    .locals 2

    .prologue
    iget-object v1, p0, Landroid/view/ContextThemeWrapper;->mResources:Landroid/content/res/Resources;

    if-eqz v1, :cond_0

    iget-object v1, p0, Landroid/view/ContextThemeWrapper;->mResources:Landroid/content/res/Resources;

    :goto_0
    return-object v1

    :cond_0
    iget-object v1, p0, Landroid/view/ContextThemeWrapper;->mOverrideConfiguration:Landroid/content/res/Configuration;

    if-nez v1, :cond_1

    invoke-super {p0}, Landroid/content/ContextWrapper;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    iput-object v1, p0, Landroid/view/ContextThemeWrapper;->mResources:Landroid/content/res/Resources;

    iget-object v1, p0, Landroid/view/ContextThemeWrapper;->mResources:Landroid/content/res/Resources;

    goto :goto_0

    :cond_1
    iget-object v1, p0, Landroid/view/ContextThemeWrapper;->mOverrideConfiguration:Landroid/content/res/Configuration;

    invoke-virtual {p0, v1}, Landroid/view/ContextThemeWrapper;->createConfigurationContext(Landroid/content/res/Configuration;)Landroid/content/Context;

    move-result-object v0

    .local v0, "resc":Landroid/content/Context;
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    iput-object v1, p0, Landroid/view/ContextThemeWrapper;->mResources:Landroid/content/res/Resources;

    iget-object v1, p0, Landroid/view/ContextThemeWrapper;->mResources:Landroid/content/res/Resources;

    goto :goto_0
.end method

.method public getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    const-string v0, "layout_inflater"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Landroid/view/ContextThemeWrapper;->mInflater:Landroid/view/LayoutInflater;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/view/ContextThemeWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/LayoutInflater;->cloneInContext(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iput-object v0, p0, Landroid/view/ContextThemeWrapper;->mInflater:Landroid/view/LayoutInflater;

    :cond_0
    iget-object v0, p0, Landroid/view/ContextThemeWrapper;->mInflater:Landroid/view/LayoutInflater;

    :goto_0
    return-object v0

    :cond_1
    invoke-virtual {p0}, Landroid/view/ContextThemeWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0
.end method

.method public getTheme()Landroid/content/res/Resources$Theme;
    .locals 2

    .prologue
    iget-object v0, p0, Landroid/view/ContextThemeWrapper;->mTheme:Landroid/content/res/Resources$Theme;

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroid/view/ContextThemeWrapper;->mTheme:Landroid/content/res/Resources$Theme;

    :goto_0
    return-object v0

    :cond_0
    iget v0, p0, Landroid/view/ContextThemeWrapper;->mThemeResource:I

    invoke-virtual {p0}, Landroid/view/ContextThemeWrapper;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget v1, v1, Landroid/content/pm/ApplicationInfo;->targetSdkVersion:I

    invoke-static {v0, v1}, Landroid/content/res/Resources;->selectDefaultTheme(II)I

    move-result v0

    iput v0, p0, Landroid/view/ContextThemeWrapper;->mThemeResource:I

    invoke-direct {p0}, Landroid/view/ContextThemeWrapper;->initializeTheme()V

    iget-object v0, p0, Landroid/view/ContextThemeWrapper;->mTheme:Landroid/content/res/Resources$Theme;

    goto :goto_0
.end method

.method public getThemeResId()I
    .locals 1

    .prologue
    iget v0, p0, Landroid/view/ContextThemeWrapper;->mThemeResource:I

    return v0
.end method

.method protected onApplyThemeResource(Landroid/content/res/Resources$Theme;IZ)V
    .locals 1
    .param p1, "theme"    # Landroid/content/res/Resources$Theme;
    .param p2, "resid"    # I
    .param p3, "first"    # Z

    .prologue
    const/4 v0, 0x1

    invoke-virtual {p1, p2, v0}, Landroid/content/res/Resources$Theme;->applyStyle(IZ)V

    return-void
.end method

.method public setTheme(I)V
    .locals 0
    .param p1, "resid"    # I

    .prologue
    invoke-static {p0, p1}, Landroid/view/ContextThemeWrapper;->convertTheme(Landroid/content/Context;I)I

    move-result p1

    iput p1, p0, Landroid/view/ContextThemeWrapper;->mThemeResource:I

    invoke-direct {p0}, Landroid/view/ContextThemeWrapper;->initializeTheme()V

    return-void
.end method
