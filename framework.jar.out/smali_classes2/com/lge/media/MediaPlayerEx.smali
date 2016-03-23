.class public Lcom/lge/media/MediaPlayerEx;
.super Landroid/media/MediaPlayer;
.source "MediaPlayerEx.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/media/MediaPlayerEx$OnTimedTextExListener;
    }
.end annotation


# static fields
.field private static final IMEDIA_PLAYER:Ljava/lang/String; = "android.media.IMediaPlayer"

.field private static final LGE_INVOKE_GET_PARAM:I = 0x7e000002

.field private static final LGE_INVOKE_SET_PARAM:I = 0x7e000001

.field public static final LGE_MEDIAPLAYER_KEYPARAM_AUDIO_ZOOM_INFO:I = 0x23f0

.field public static final LGE_MEDIAPLAYER_KEYPARAM_AUDIO_ZOOM_INIT:I = 0x23f1

.field public static final LGE_MEDIAPLAYER_KEYPARAM_AUDIO_ZOOM_START:I = 0x23f2

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_ADD_HEADER:I = 0x2329

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_DLNAPLAYBACK:I = 0x2392

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_FB_SCAN_MODE_START:I = 0x2334

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_FF_SCAN_MODE_START:I = 0x2332

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_GET_RESPONSE:I = 0x232b

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_REMOVE_HEADER:I = 0x232a

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_REQUEST_OPTION_CONNECTION_TIMEOUT:I = 0x238c

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_REQUEST_OPTION_ENABLE_HTTPRANGE:I = 0x2390

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_REQUEST_OPTION_ENABLE_TIMESEEK:I = 0x2391

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_REQUEST_OPTION_KEEPCONNECTION_ON_PAUSE:I = 0x238f

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_REQUEST_OPTION_KEEPCONNECTION_ON_PLAY:I = 0x238e

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_REQUEST_OPTION_READ_TIMEOUT:I = 0x238d

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_SB_SCAN_MODE_START:I = 0x2335

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_SCAN_MODE_END:I = 0x2336

.field public static final LGE_MEDIAPLAYER_KEYPARAM_HTTP_SF_SCAN_MODE_START:I = 0x2333

.field private static final LGE_MEDIAPLAYER_KEYPARAM_LGEAUDIO_3DMUSIC:I = 0x6f001002

.field private static final LGE_MEDIAPLAYER_KEYPARAM_LGEAUDIO_CUSTOMEQ:I = 0x6f001001

.field private static final LGE_MEDIAPLAYER_KEYPARAM_LGEAUDIO_EFFECT:I = 0x6f001000

.field public static final LGE_MEDIAPLAYER_KEYPARAM_LGE_HIFI_ENABLED:I = 0x1770

.field public static final LGE_MEDIAPLAYER_KEYPARAM_PLAYBACK_FRAMERATE:I = 0x1390

.field public static final LGE_MEDIAPLAYER_KEYPARAM_PLAY_ON_LOCKSCREEN:I = 0x251c

.field private static final LGE_MEDIAPLAYER_KEYPARAM_SCREENCAPTURE:I = 0x2455

.field private static final LGE_MEDIAPLAYER_KEYPARAM_SET_NORMALIZER:I = 0x6f001010

.field public static final LGE_MEDIAPLAYER_KEYPARAM_SYSTEM_INFO_DIVXSUPPORT:I = 0x24b9

.field public static final LGE_MEDIAPLAYER_KEYPARAM_SYSTEM_INFO_HIFISUPPORT:I = 0x24ba

.field public static final MEDIA_IMPLEMENT_ERROR_DRM_NOT_AUTHORIZED:I = 0x24b8

.field public static final MEDIA_IMPLEMENT_ERROR_NOT_AVAILABLE_NETWORK:I = 0x2454

.field public static final MEDIA_IMPLEMENT_ERROR_NOT_EXIST_AUDIO:I = 0x2396

.field public static final MEDIA_IMPLEMENT_ERROR_NOT_EXIST_VIDEO:I = 0x23a0

.field public static final MEDIA_IMPLEMENT_ERROR_NOT_SUPPORT_AUDIO:I = 0x23f0

.field public static final MEDIA_IMPLEMENT_ERROR_NOT_SUPPORT_BITRATE:I = 0x23aa

.field public static final MEDIA_IMPLEMENT_ERROR_NOT_SUPPORT_MEDIA:I = 0x2404

.field public static final MEDIA_IMPLEMENT_ERROR_NOT_SUPPORT_RESOLUTIONS:I = 0x238c

.field public static final MEDIA_IMPLEMENT_ERROR_NOT_SUPPORT_VIDEO:I = 0x23fa

.field public static final MEDIA_MIMETYPE_CONTAINER_MPEG2TS:Ljava/lang/String; = "video/mp2ts"

.field public static final MEDIA_MIMETYPE_TEXT_ASS:Ljava/lang/String; = "text/ass"

.field public static final MEDIA_MIMETYPE_TEXT_CLOSEDCAPTION:Ljava/lang/String; = "text/closedcaption"

.field public static final MEDIA_MIMETYPE_TEXT_EX:Ljava/lang/String; = "text/ex"

.field public static final MEDIA_MIMETYPE_TEXT_SSA:Ljava/lang/String; = "text/ssa"

.field public static final MEDIA_MIMETYPE_TEXT_XSUB:Ljava/lang/String; = "text/xsub"

.field private static final MEDIA_TIMED_TEXT_EX:I = 0x258

.field private static final TAG:Ljava/lang/String; = "MediaPlayerEX"


# instance fields
.field private mOnTimedTextExListener:Lcom/lge/media/MediaPlayerEx$OnTimedTextExListener;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 60
    const-string v0, "hook_jni"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 61
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 504
    invoke-direct {p0}, Landroid/media/MediaPlayer;-><init>()V

    .line 521
    return-void
.end method

.method private native _screenCapture()Landroid/graphics/Bitmap;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method


# virtual methods
.method public getIntParameter(I)I
    .locals 2
    .param p1, "key"    # I

    .prologue
    .line 880
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .line 881
    .local v0, "p":Landroid/os/Parcel;
    invoke-virtual {p0, p1, v0}, Lcom/lge/media/MediaPlayerEx;->getParameter(ILandroid/os/Parcel;)V

    .line 882
    invoke-virtual {v0}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .line 883
    .local v1, "ret":I
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V

    .line 884
    return v1
.end method

.method public getParameter(ILandroid/os/Parcel;)V
    .locals 3
    .param p1, "key"    # I
    .param p2, "reply"    # Landroid/os/Parcel;

    .prologue
    .line 816
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 820
    .local v1, "request":Landroid/os/Parcel;
    :try_start_0
    const-string v2, "android.media.IMediaPlayer"

    invoke-virtual {v1, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 821
    const v2, 0x7e000002

    invoke-virtual {v1, v2}, Landroid/os/Parcel;->writeInt(I)V

    .line 822
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeInt(I)V

    .line 823
    invoke-virtual {p0, v1, p2}, Lcom/lge/media/MediaPlayerEx;->invoke(Landroid/os/Parcel;Landroid/os/Parcel;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 833
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    .line 835
    :goto_0
    return-void

    .line 826
    :catch_0
    move-exception v0

    .line 833
    .local v0, "ex":Ljava/lang/RuntimeException;
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    goto :goto_0

    .end local v0    # "ex":Ljava/lang/RuntimeException;
    :catchall_0
    move-exception v2

    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v2
.end method

.method public getParcelParameter(I)Landroid/os/Parcel;
    .locals 1
    .param p1, "key"    # I

    .prologue
    .line 848
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .line 849
    .local v0, "p":Landroid/os/Parcel;
    invoke-virtual {p0, p1, v0}, Lcom/lge/media/MediaPlayerEx;->getParameter(ILandroid/os/Parcel;)V

    .line 850
    return-object v0
.end method

.method public getStringParameter(I)Ljava/lang/String;
    .locals 2
    .param p1, "key"    # I

    .prologue
    .line 863
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .line 864
    .local v0, "p":Landroid/os/Parcel;
    invoke-virtual {p0, p1, v0}, Lcom/lge/media/MediaPlayerEx;->getParameter(ILandroid/os/Parcel;)V

    .line 865
    invoke-virtual {v0}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 866
    .local v1, "ret":Ljava/lang/String;
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V

    .line 867
    return-object v1
.end method

.method public screenCapture()Landroid/graphics/Bitmap;
    .locals 3

    .prologue
    .line 1003
    const-string v1, "MediaPlayerEX"

    const-string v2, "[screenCapture] screenCapture start"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1004
    invoke-direct {p0}, Lcom/lge/media/MediaPlayerEx;->_screenCapture()Landroid/graphics/Bitmap;

    move-result-object v0

    .line 1006
    .local v0, "vFrame":Landroid/graphics/Bitmap;
    return-object v0
.end method

.method public setLGAudioEffect(IIII)I
    .locals 5
    .param p1, "iEnable"    # I
    .param p2, "iType"    # I
    .param p3, "iPath"    # I
    .param p4, "iMedia"    # I

    .prologue
    const/4 v2, 0x1

    .line 929
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 930
    .local v1, "parcel":Landroid/os/Parcel;
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeInt(I)V

    .line 931
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 932
    invoke-virtual {v1, p3}, Landroid/os/Parcel;->writeInt(I)V

    .line 933
    invoke-virtual {v1, p4}, Landroid/os/Parcel;->writeInt(I)V

    .line 935
    const v3, 0x6f001000

    invoke-virtual {p0, v3, v1}, Lcom/lge/media/MediaPlayerEx;->setParameter(ILandroid/os/Parcel;)Z

    move-result v0

    .line 936
    .local v0, "isAudioEffect":Z
    if-eq v0, v2, :cond_0

    .line 938
    const-string v3, "MediaPlayerEX"

    const-string v4, "[setLGAudioEffect] setParameter fail"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 941
    :goto_0
    return v2

    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public setLGSoleCustomEQ(II)I
    .locals 5
    .param p1, "iNumBand"    # I
    .param p2, "iNumGain"    # I

    .prologue
    const/4 v2, 0x1

    .line 959
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 960
    .local v1, "parcel":Landroid/os/Parcel;
    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeInt(I)V

    .line 961
    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 963
    const v3, 0x6f001001

    invoke-virtual {p0, v3, v1}, Lcom/lge/media/MediaPlayerEx;->setParameter(ILandroid/os/Parcel;)Z

    move-result v0

    .line 964
    .local v0, "isCustomEQ":Z
    if-eq v0, v2, :cond_0

    .line 966
    const-string v3, "MediaPlayerEX"

    const-string v4, "[setLGSoleCustomEQ] setParameter fail"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 969
    :goto_0
    return v2

    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public setLGSoundNormalizerOnOff(I)V
    .locals 4
    .param p1, "normalizerOnOff"    # I

    .prologue
    .line 982
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .line 983
    .local v0, "parcel":Landroid/os/Parcel;
    invoke-virtual {v0, p1}, Landroid/os/Parcel;->writeInt(I)V

    .line 985
    const v2, 0x6f001010

    invoke-virtual {p0, v2, v0}, Lcom/lge/media/MediaPlayerEx;->setParameter(ILandroid/os/Parcel;)Z

    move-result v1

    .line 986
    .local v1, "ret":Z
    const/4 v2, 0x1

    if-eq v1, v2, :cond_0

    .line 988
    const-string v2, "MediaPlayerEX"

    const-string v3, "[setLGSoundNormalizerOnOff] setParameter fail"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 991
    :cond_0
    return-void
.end method

.method public setOnTimedTextExListener(Lcom/lge/media/MediaPlayerEx$OnTimedTextExListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/lge/media/MediaPlayerEx$OnTimedTextExListener;

    .prologue
    .line 561
    iput-object p1, p0, Lcom/lge/media/MediaPlayerEx;->mOnTimedTextExListener:Lcom/lge/media/MediaPlayerEx$OnTimedTextExListener;

    .line 562
    return-void
.end method

.method public setParameter(II)Z
    .locals 2
    .param p1, "key"    # I
    .param p2, "value"    # I

    .prologue
    .line 799
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .line 800
    .local v0, "p":Landroid/os/Parcel;
    invoke-virtual {v0, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 801
    invoke-virtual {p0, p1, v0}, Lcom/lge/media/MediaPlayerEx;->setParameter(ILandroid/os/Parcel;)Z

    move-result v1

    .line 802
    .local v1, "ret":Z
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V

    .line 803
    return v1
.end method

.method public setParameter(ILandroid/os/Parcel;)Z
    .locals 8
    .param p1, "key"    # I
    .param p2, "value"    # Landroid/os/Parcel;

    .prologue
    const/4 v5, 0x0

    .line 741
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 742
    .local v2, "request":Landroid/os/Parcel;
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v1

    .line 743
    .local v1, "reply":Landroid/os/Parcel;
    const/4 v3, 0x0

    .line 747
    .local v3, "ret":Z
    :try_start_0
    const-string v6, "android.media.IMediaPlayer"

    invoke-virtual {v2, v6}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    .line 748
    const v6, 0x7e000001

    invoke-virtual {v2, v6}, Landroid/os/Parcel;->writeInt(I)V

    .line 749
    invoke-virtual {v2, p1}, Landroid/os/Parcel;->writeInt(I)V

    .line 750
    const/4 v6, 0x0

    invoke-virtual {p2}, Landroid/os/Parcel;->dataSize()I

    move-result v7

    invoke-virtual {v2, p2, v6, v7}, Landroid/os/Parcel;->appendFrom(Landroid/os/Parcel;II)V

    .line 752
    invoke-virtual {p0, v2, v1}, Lcom/lge/media/MediaPlayerEx;->invoke(Landroid/os/Parcel;Landroid/os/Parcel;)V

    .line 753
    invoke-virtual {v1}, Landroid/os/Parcel;->readInt()I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v6

    if-nez v6, :cond_0

    const/4 v3, 0x1

    .line 763
    :goto_0
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 764
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    move v4, v3

    .line 767
    .end local v3    # "ret":Z
    .local v4, "ret":I
    :goto_1
    return v4

    .end local v4    # "ret":I
    .restart local v3    # "ret":Z
    :cond_0
    move v3, v5

    .line 753
    goto :goto_0

    .line 756
    :catch_0
    move-exception v0

    .line 763
    .local v0, "ex":Ljava/lang/RuntimeException;
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 764
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    move v4, v3

    .restart local v4    # "ret":I
    goto :goto_1

    .line 763
    .end local v0    # "ex":Ljava/lang/RuntimeException;
    .end local v4    # "ret":I
    :catchall_0
    move-exception v5

    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V

    .line 764
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V

    throw v5
.end method

.method public setParameter(ILjava/lang/String;)Z
    .locals 2
    .param p1, "key"    # I
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    .line 781
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .line 782
    .local v0, "p":Landroid/os/Parcel;
    invoke-virtual {v0, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 783
    invoke-virtual {p0, p1, v0}, Lcom/lge/media/MediaPlayerEx;->setParameter(ILandroid/os/Parcel;)Z

    move-result v1

    .line 784
    .local v1, "ret":Z
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V

    .line 785
    return v1
.end method
