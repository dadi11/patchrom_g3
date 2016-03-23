.class Lcom/lge/wfds/session/AspSessionProtoOpcode$SendReqProto;
.super Ljava/lang/Object;
.source "AspSessionProtoOpcode.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/session/AspSessionProtoOpcode;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "SendReqProto"
.end annotation


# instance fields
.field mReqType:I

.field mSession:Lcom/lge/wfds/session/AspSession;

.field final synthetic this$0:Lcom/lge/wfds/session/AspSessionProtoOpcode;


# direct methods
.method public constructor <init>(Lcom/lge/wfds/session/AspSessionProtoOpcode;ILcom/lge/wfds/session/AspSession;)V
    .locals 0
    .param p2, "reqType"    # I
    .param p3, "session"    # Lcom/lge/wfds/session/AspSession;

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/session/AspSessionProtoOpcode$SendReqProto;->this$0:Lcom/lge/wfds/session/AspSessionProtoOpcode;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p2, p0, Lcom/lge/wfds/session/AspSessionProtoOpcode$SendReqProto;->mReqType:I

    iput-object p3, p0, Lcom/lge/wfds/session/AspSessionProtoOpcode$SendReqProto;->mSession:Lcom/lge/wfds/session/AspSession;

    return-void
.end method
