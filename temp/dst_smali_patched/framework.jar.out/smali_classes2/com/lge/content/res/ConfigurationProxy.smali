.class public Lcom/lge/content/res/ConfigurationProxy;
.super Ljava/lang/Object;
.source "ConfigurationProxy.java"


# static fields
.field private static sFontTypeIndex:Ljava/lang/Object;


# instance fields
.field private mConfiguration:Landroid/content/res/Configuration;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/content/res/ConfigurationProxy;->sFontTypeIndex:Ljava/lang/Object;

    const-class v0, Landroid/content/res/Configuration;

    const-string v1, "fontTypeIndex"

    invoke-static {v0, v1}, Lcom/lge/util/ProxyUtil;->loadField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    sput-object v0, Lcom/lge/content/res/ConfigurationProxy;->sFontTypeIndex:Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "configuration"    # Landroid/content/res/Configuration;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/content/res/ConfigurationProxy;->mConfiguration:Landroid/content/res/Configuration;

    return-void
.end method


# virtual methods
.method public getFontTypeIndex()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    sget-object v0, Lcom/lge/content/res/ConfigurationProxy;->sFontTypeIndex:Ljava/lang/Object;

    iget-object v1, p0, Lcom/lge/content/res/ConfigurationProxy;->mConfiguration:Landroid/content/res/Configuration;

    invoke-static {v0, v1}, Lcom/lge/util/ProxyUtil;->getField(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method public setFontTypeIndex(I)V
    .locals 3
    .param p1, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    sget-object v0, Lcom/lge/content/res/ConfigurationProxy;->sFontTypeIndex:Ljava/lang/Object;

    iget-object v1, p0, Lcom/lge/content/res/ConfigurationProxy;->mConfiguration:Landroid/content/res/Configuration;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/lge/util/ProxyUtil;->setField(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-void
.end method
