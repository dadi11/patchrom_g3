.class public Lcom/lge/bnr/framework/LGBackupException;
.super Ljava/lang/Exception;
.source "LGBackupException.java"


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field public error:Lcom/lge/bnr/framework/LGBackupErrorCode;


# direct methods
.method public constructor <init>(Lcom/lge/bnr/framework/LGBackupErrorCode;)V
    .locals 1
    .param p1, "error"    # Lcom/lge/bnr/framework/LGBackupErrorCode;

    .prologue
    invoke-direct {p0}, Ljava/lang/Exception;-><init>()V

    sget-object v0, Lcom/lge/bnr/framework/LGBackupErrorCode;->UNDEFINED_ERROR:Lcom/lge/bnr/framework/LGBackupErrorCode;

    iput-object v0, p0, Lcom/lge/bnr/framework/LGBackupException;->error:Lcom/lge/bnr/framework/LGBackupErrorCode;

    iput-object p1, p0, Lcom/lge/bnr/framework/LGBackupException;->error:Lcom/lge/bnr/framework/LGBackupErrorCode;

    return-void
.end method

.method public constructor <init>(Lcom/lge/bnr/framework/LGBackupErrorCode;Ljava/lang/Exception;)V
    .locals 1
    .param p1, "code"    # Lcom/lge/bnr/framework/LGBackupErrorCode;
    .param p2, "e"    # Ljava/lang/Exception;

    .prologue
    invoke-direct {p0, p2}, Ljava/lang/Exception;-><init>(Ljava/lang/Throwable;)V

    sget-object v0, Lcom/lge/bnr/framework/LGBackupErrorCode;->UNDEFINED_ERROR:Lcom/lge/bnr/framework/LGBackupErrorCode;

    iput-object v0, p0, Lcom/lge/bnr/framework/LGBackupException;->error:Lcom/lge/bnr/framework/LGBackupErrorCode;

    iput-object p1, p0, Lcom/lge/bnr/framework/LGBackupException;->error:Lcom/lge/bnr/framework/LGBackupErrorCode;

    return-void
.end method

.method public constructor <init>(Lcom/lge/bnr/framework/LGBackupErrorCode;Ljava/lang/Exception;Ljava/lang/String;)V
    .locals 1
    .param p1, "code"    # Lcom/lge/bnr/framework/LGBackupErrorCode;
    .param p2, "e"    # Ljava/lang/Exception;
    .param p3, "msg"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p3, p2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    sget-object v0, Lcom/lge/bnr/framework/LGBackupErrorCode;->UNDEFINED_ERROR:Lcom/lge/bnr/framework/LGBackupErrorCode;

    iput-object v0, p0, Lcom/lge/bnr/framework/LGBackupException;->error:Lcom/lge/bnr/framework/LGBackupErrorCode;

    iput-object p1, p0, Lcom/lge/bnr/framework/LGBackupException;->error:Lcom/lge/bnr/framework/LGBackupErrorCode;

    return-void
.end method

.method public constructor <init>(Lcom/lge/bnr/framework/LGBackupErrorCode;Ljava/lang/String;)V
    .locals 1
    .param p1, "error"    # Lcom/lge/bnr/framework/LGBackupErrorCode;
    .param p2, "msg"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    sget-object v0, Lcom/lge/bnr/framework/LGBackupErrorCode;->UNDEFINED_ERROR:Lcom/lge/bnr/framework/LGBackupErrorCode;

    iput-object v0, p0, Lcom/lge/bnr/framework/LGBackupException;->error:Lcom/lge/bnr/framework/LGBackupErrorCode;

    iput-object p1, p0, Lcom/lge/bnr/framework/LGBackupException;->error:Lcom/lge/bnr/framework/LGBackupErrorCode;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    sget-object v0, Lcom/lge/bnr/framework/LGBackupErrorCode;->UNDEFINED_ERROR:Lcom/lge/bnr/framework/LGBackupErrorCode;

    iput-object v0, p0, Lcom/lge/bnr/framework/LGBackupException;->error:Lcom/lge/bnr/framework/LGBackupErrorCode;

    return-void
.end method


# virtual methods
.method public getErrorCode()Lcom/lge/bnr/framework/LGBackupErrorCode;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/bnr/framework/LGBackupException;->error:Lcom/lge/bnr/framework/LGBackupErrorCode;

    return-object v0
.end method

.method public getMessage()Ljava/lang/String;
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    .local v0, "sb":Ljava/lang/StringBuffer;
    iget-object v1, p0, Lcom/lge/bnr/framework/LGBackupException;->error:Lcom/lge/bnr/framework/LGBackupErrorCode;

    invoke-virtual {v1}, Lcom/lge/bnr/framework/LGBackupErrorCode;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-super {p0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string v1, " : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-super {p0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
