.class public abstract Lcom/lge/internal/hardware/fmradio/ScanCase;
.super Lcom/lge/internal/hardware/fmradio/FmRadioCommandCase;
.source "ScanCase.java"


# direct methods
.method public constructor <init>(Landroid/os/Message;)V
    .locals 12
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    sget-object v3, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN_REQUESTED:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    sget-object v4, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN_STARTED:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    sget-object v5, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN_ONGOING:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    sget-object v6, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN_FINISHED:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    sget-object v7, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN_FAIL:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    sget-object v8, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN_IGNORED:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    const-wide/16 v10, 0x7530

    move-object v1, p0

    move-object v9, p1

    invoke-direct/range {v1 .. v11}, Lcom/lge/internal/hardware/fmradio/FmRadioCommandCase;-><init>(Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Landroid/os/Message;J)V

    return-void
.end method
