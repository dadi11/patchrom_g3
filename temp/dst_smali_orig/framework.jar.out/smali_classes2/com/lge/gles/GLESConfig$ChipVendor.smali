.class public final enum Lcom/lge/gles/GLESConfig$ChipVendor;
.super Ljava/lang/Enum;
.source "GLESConfig.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/gles/GLESConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "ChipVendor"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/lge/gles/GLESConfig$ChipVendor;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/lge/gles/GLESConfig$ChipVendor;

.field public static final enum CHIPSET_QUALCOMM:Lcom/lge/gles/GLESConfig$ChipVendor;

.field public static final enum CHIPSET_TI:Lcom/lge/gles/GLESConfig$ChipVendor;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    new-instance v0, Lcom/lge/gles/GLESConfig$ChipVendor;

    const-string v1, "CHIPSET_TI"

    invoke-direct {v0, v1, v2}, Lcom/lge/gles/GLESConfig$ChipVendor;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/lge/gles/GLESConfig$ChipVendor;->CHIPSET_TI:Lcom/lge/gles/GLESConfig$ChipVendor;

    new-instance v0, Lcom/lge/gles/GLESConfig$ChipVendor;

    const-string v1, "CHIPSET_QUALCOMM"

    invoke-direct {v0, v1, v3}, Lcom/lge/gles/GLESConfig$ChipVendor;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/lge/gles/GLESConfig$ChipVendor;->CHIPSET_QUALCOMM:Lcom/lge/gles/GLESConfig$ChipVendor;

    const/4 v0, 0x2

    new-array v0, v0, [Lcom/lge/gles/GLESConfig$ChipVendor;

    sget-object v1, Lcom/lge/gles/GLESConfig$ChipVendor;->CHIPSET_TI:Lcom/lge/gles/GLESConfig$ChipVendor;

    aput-object v1, v0, v2

    sget-object v1, Lcom/lge/gles/GLESConfig$ChipVendor;->CHIPSET_QUALCOMM:Lcom/lge/gles/GLESConfig$ChipVendor;

    aput-object v1, v0, v3

    sput-object v0, Lcom/lge/gles/GLESConfig$ChipVendor;->$VALUES:[Lcom/lge/gles/GLESConfig$ChipVendor;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/lge/gles/GLESConfig$ChipVendor;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    const-class v0, Lcom/lge/gles/GLESConfig$ChipVendor;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/lge/gles/GLESConfig$ChipVendor;

    return-object v0
.end method

.method public static values()[Lcom/lge/gles/GLESConfig$ChipVendor;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/gles/GLESConfig$ChipVendor;->$VALUES:[Lcom/lge/gles/GLESConfig$ChipVendor;

    invoke-virtual {v0}, [Lcom/lge/gles/GLESConfig$ChipVendor;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/lge/gles/GLESConfig$ChipVendor;

    return-object v0
.end method
