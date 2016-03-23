.class public Landroid/opengl/EGLExt;
.super Ljava/lang/Object;
.source "EGLExt.java"


# static fields
.field public static final EGL_CONTEXT_FLAGS_KHR:I = 0x30fc

.field public static final EGL_CONTEXT_MAJOR_VERSION_KHR:I = 0x3098

.field public static final EGL_CONTEXT_MINOR_VERSION_KHR:I = 0x30fb

.field public static final EGL_OPENGL_ES3_BIT_KHR:I = 0x40


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 35
    :try_start_0
    const-string v1, "android.opengl.EGL14"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 39
    invoke-static {}, Landroid/opengl/EGLExt;->_nativeClassInit()V

    .line 40
    return-void

    .line 36
    :catch_0
    move-exception v0

    .line 37
    .local v0, "e":Ljava/lang/ClassNotFoundException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static native _nativeClassInit()V
.end method

.method public static native eglPresentationTimeANDROID(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;J)Z
.end method
