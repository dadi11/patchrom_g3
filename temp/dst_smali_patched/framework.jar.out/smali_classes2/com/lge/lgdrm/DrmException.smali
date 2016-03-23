.class public final Lcom/lge/lgdrm/DrmException;
.super Ljava/lang/Exception;
.source "DrmException.java"


# static fields
.field private static final serialVersionUID:J = 0x16e5c9499165dcf5L


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Exception;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    return-void
.end method
