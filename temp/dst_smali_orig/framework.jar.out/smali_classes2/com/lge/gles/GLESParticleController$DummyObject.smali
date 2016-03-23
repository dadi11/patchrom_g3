.class public Lcom/lge/gles/GLESParticleController$DummyObject;
.super Lcom/lge/gles/GLESObject;
.source "GLESParticleController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/gles/GLESParticleController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4
    name = "DummyObject"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/gles/GLESParticleController;


# direct methods
.method public constructor <init>(Lcom/lge/gles/GLESParticleController;Landroid/content/Context;ZZ)V
    .locals 0
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "useTexture"    # Z
    .param p4, "useNormal"    # Z

    .prologue
    iput-object p1, p0, Lcom/lge/gles/GLESParticleController$DummyObject;->this$0:Lcom/lge/gles/GLESParticleController;

    invoke-direct {p0, p2, p3, p4}, Lcom/lge/gles/GLESObject;-><init>(Landroid/content/Context;ZZ)V

    return-void
.end method


# virtual methods
.method protected draw()V
    .locals 0

    .prologue
    return-void
.end method

.method protected getUniformLocations()V
    .locals 0

    .prologue
    return-void
.end method

.method protected update()V
    .locals 0

    .prologue
    return-void
.end method
