.class public Lcom/lge/app/floating/FloatingFunctionReflect;
.super Ljava/lang/Object;
.source "FloatingFunctionReflect.java"


# static fields
.field static final TAG:Ljava/lang/String;

.field static sActivityMLoadersStarted:Ljava/lang/reflect/Field;

.field private static sFinishInputLockedMethod:Ljava/lang/reflect/Method;

.field static sFragmentMLoadersStarted:Ljava/lang/reflect/Field;

.field static sFragmentManagerMActive:Ljava/lang/reflect/Field;

.field private static sGetServiceMethod:Ljava/lang/reflect/Method;

.field static sGetSystemBarShownState:Ljava/lang/reflect/Method;

.field private static sIWindowManager:Ljava/lang/Object;

.field private static sIWindowManagerStubAsInterfaceMethod:Ljava/lang/reflect/Method;

.field private static sLayoutField:Ljava/lang/reflect/Field;

.field static sMoveWindowTokenToTopMethodEx:Ljava/lang/reflect/Method;

.field private static sUpdateWindowMethod:Ljava/lang/reflect/Method;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .prologue
    const/4 v3, 0x0

    .line 19
    const-class v2, Lcom/lge/app/floating/FloatingFunctionReflect;

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    .line 24
    sput-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sLayoutField:Ljava/lang/reflect/Field;

    .line 29
    sput-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sIWindowManager:Ljava/lang/Object;

    .line 30
    sput-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sGetServiceMethod:Ljava/lang/reflect/Method;

    .line 31
    sput-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sIWindowManagerStubAsInterfaceMethod:Ljava/lang/reflect/Method;

    .line 33
    sput-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sActivityMLoadersStarted:Ljava/lang/reflect/Field;

    .line 34
    sput-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sFragmentMLoadersStarted:Ljava/lang/reflect/Field;

    .line 35
    sput-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sFragmentManagerMActive:Ljava/lang/reflect/Field;

    .line 40
    sput-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sUpdateWindowMethod:Ljava/lang/reflect/Method;

    .line 43
    sput-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sMoveWindowTokenToTopMethodEx:Ljava/lang/reflect/Method;

    .line 44
    sput-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sFinishInputLockedMethod:Ljava/lang/reflect/Method;

    .line 45
    sput-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sGetSystemBarShownState:Ljava/lang/reflect/Method;

    .line 49
    :try_start_0
    const-class v2, Landroid/app/Activity;

    const-string v3, "mLoadersStarted"

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    sput-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sActivityMLoadersStarted:Ljava/lang/reflect/Field;

    .line 50
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sActivityMLoadersStarted:Ljava/lang/reflect/Field;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 51
    const-class v2, Landroid/app/Fragment;

    const-string v3, "mLoadersStarted"

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    sput-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sFragmentMLoadersStarted:Ljava/lang/reflect/Field;

    .line 52
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sFragmentMLoadersStarted:Ljava/lang/reflect/Field;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 54
    const-class v2, Landroid/view/SurfaceView;

    const-string v3, "mLayout"

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    sput-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sLayoutField:Ljava/lang/reflect/Field;

    .line 55
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sLayoutField:Ljava/lang/reflect/Field;

    if-eqz v2, :cond_0

    .line 56
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sLayoutField:Ljava/lang/reflect/Field;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 58
    :cond_0
    const-class v2, Landroid/view/SurfaceView;

    const-string v3, "updateWindow"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    sget-object v6, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v6, v4, v5

    const/4 v5, 0x1

    sget-object v6, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    sput-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sUpdateWindowMethod:Ljava/lang/reflect/Method;

    .line 59
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sUpdateWindowMethod:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_1

    .line 60
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sUpdateWindowMethod:Ljava/lang/reflect/Method;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 63
    :cond_1
    const-string v2, "android.os.ServiceManager"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-string v3, "getService"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Ljava/lang/String;

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    sput-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sGetServiceMethod:Ljava/lang/reflect/Method;

    .line 64
    const-string v2, "com.lge.view.IWindowManagerEx$Stub"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-string v3, "asInterface"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Landroid/os/IBinder;

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    sput-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sIWindowManagerStubAsInterfaceMethod:Ljava/lang/reflect/Method;

    .line 66
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sGetServiceMethod:Ljava/lang/reflect/Method;

    const/4 v3, 0x0

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string/jumbo v6, "window"

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 67
    .local v0, "binderObject":Ljava/lang/Object;
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sIWindowManagerStubAsInterfaceMethod:Ljava/lang/reflect/Method;

    const/4 v3, 0x0

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v0, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    sput-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sIWindowManager:Ljava/lang/Object;

    .line 69
    const-string v2, "com.lge.view.IWindowManagerEx"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-string v3, "moveWindowTokenToTop"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Landroid/os/IBinder;

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    sput-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sMoveWindowTokenToTopMethodEx:Ljava/lang/reflect/Method;

    .line 71
    const-string v2, "com.lge.view.IWindowManagerEx"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-string v3, "getSystemBarShownState"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Class;

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    sput-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sGetSystemBarShownState:Ljava/lang/reflect/Method;

    .line 72
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sGetSystemBarShownState:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_2

    .line 73
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sGetSystemBarShownState:Ljava/lang/reflect/Method;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 76
    :cond_2
    const-class v2, Landroid/view/inputmethod/InputMethodManager;

    const-string v3, "finishInputLocked"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Class;

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    sput-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sFinishInputLockedMethod:Ljava/lang/reflect/Method;

    .line 77
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sFinishInputLockedMethod:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_3

    .line 78
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->sFinishInputLockedMethod:Ljava/lang/reflect/Method;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 80
    :cond_3
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    const-string v3, "reflection success"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 85
    :goto_0
    return-void

    .line 81
    :catch_0
    move-exception v1

    .line 82
    .local v1, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    const-string v3, "reflection fail"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 83
    sget-object v2, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static finishInputLocked(Landroid/view/inputmethod/InputMethodManager;)V
    .locals 4
    .param p0, "imm"    # Landroid/view/inputmethod/InputMethodManager;

    .prologue
    .line 101
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sFinishInputLockedMethod:Ljava/lang/reflect/Method;

    if-eqz v1, :cond_0

    .line 103
    :try_start_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sFinishInputLockedMethod:Ljava/lang/reflect/Method;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v1, p0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 110
    :goto_0
    return-void

    .line 105
    :catch_0
    move-exception v0

    .line 106
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "unable to call finishInputLocked. reason="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 109
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    const-string v2, "can not find finishInputLocked method"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static getFragmentList(Landroid/app/FragmentManager;)Ljava/util/List;
    .locals 5
    .param p0, "fm"    # Landroid/app/FragmentManager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/FragmentManager;",
            ")",
            "Ljava/util/List",
            "<",
            "Landroid/app/Fragment;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 162
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v3, "mActive"

    invoke-virtual {v1, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    sput-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sFragmentManagerMActive:Ljava/lang/reflect/Field;

    .line 163
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sFragmentManagerMActive:Ljava/lang/reflect/Field;

    const/4 v3, 0x1

    invoke-virtual {v1, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 169
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sFragmentManagerMActive:Ljava/lang/reflect/Field;

    if-eqz v1, :cond_0

    .line 171
    :try_start_1
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sFragmentManagerMActive:Ljava/lang/reflect/Field;

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 177
    :goto_0
    return-object v1

    .line 164
    :catch_0
    move-exception v0

    .line 165
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    const-string v3, "can not find mActive(Activity) field"

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move-object v1, v2

    .line 166
    goto :goto_0

    .line 172
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 173
    .restart local v0    # "e":Ljava/lang/Exception;
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "unable to call sFragmentManagerMActive. reason="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 176
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    const-string v3, "can not find sFragmentManagerMActive field"

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move-object v1, v2

    .line 177
    goto :goto_0
.end method

.method public static getSurfaceLayoutParams(Landroid/view/View;)Landroid/view/WindowManager$LayoutParams;
    .locals 4
    .param p0, "surfaceView"    # Landroid/view/View;

    .prologue
    .line 125
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sLayoutField:Ljava/lang/reflect/Field;

    if-eqz v1, :cond_0

    .line 127
    :try_start_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sLayoutField:Ljava/lang/reflect/Field;

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 133
    :goto_0
    return-object v1

    .line 128
    :catch_0
    move-exception v0

    .line 129
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "unable to call getSurfaceLayoutParams. reason="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 132
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    const-string v2, "can not find SurfaceLayoutParams field"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 133
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static moveWindowTokenToTopEx(Landroid/os/IBinder;)Z
    .locals 7
    .param p0, "token"    # Landroid/os/IBinder;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 88
    sget-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sMoveWindowTokenToTopMethodEx:Ljava/lang/reflect/Method;

    if-eqz v3, :cond_0

    .line 90
    :try_start_0
    sget-object v3, Lcom/lge/app/floating/FloatingFunctionReflect;->sMoveWindowTokenToTopMethodEx:Ljava/lang/reflect/Method;

    sget-object v4, Lcom/lge/app/floating/FloatingFunctionReflect;->sIWindowManager:Ljava/lang/Object;

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object p0, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 97
    :goto_0
    return v1

    .line 92
    :catch_0
    move-exception v0

    .line 93
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "unable to call moveWindowTokenToTop. reason="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 96
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    const-string v3, "can not find moveWindowTokenToTop method"

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v1, v2

    .line 97
    goto :goto_0
.end method

.method public static setActivityMLoadersStarted(Landroid/app/Activity;Z)V
    .locals 4
    .param p0, "activity"    # Landroid/app/Activity;
    .param p1, "loaderStarted"    # Z

    .prologue
    .line 137
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sActivityMLoadersStarted:Ljava/lang/reflect/Field;

    if-eqz v1, :cond_0

    .line 139
    :try_start_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sActivityMLoadersStarted:Ljava/lang/reflect/Field;

    invoke-virtual {v1, p0, p1}, Ljava/lang/reflect/Field;->setBoolean(Ljava/lang/Object;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 146
    :goto_0
    return-void

    .line 141
    :catch_0
    move-exception v0

    .line 142
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "unable to call setActivityMLoadersStarted. reason="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 145
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    const-string v2, "can not find ActivityMLoadersStarted field"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static setFragmentMLoadersStarted(Landroid/app/Fragment;Z)V
    .locals 4
    .param p0, "fragment"    # Landroid/app/Fragment;
    .param p1, "loaderStarted"    # Z

    .prologue
    .line 149
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sFragmentMLoadersStarted:Ljava/lang/reflect/Field;

    if-eqz v1, :cond_0

    .line 151
    :try_start_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sFragmentMLoadersStarted:Ljava/lang/reflect/Field;

    invoke-virtual {v1, p0, p1}, Ljava/lang/reflect/Field;->setBoolean(Ljava/lang/Object;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 158
    :goto_0
    return-void

    .line 153
    :catch_0
    move-exception v0

    .line 154
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "unable to call sFragmentMLoadersStarted. reason="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 157
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    const-string v2, "can not find FragmentMLoadersStarted field"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static updateWindow(Landroid/view/View;ZZ)V
    .locals 5
    .param p0, "v"    # Landroid/view/View;
    .param p1, "force"    # Z
    .param p2, "redrawNeeded"    # Z

    .prologue
    .line 113
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sUpdateWindowMethod:Ljava/lang/reflect/Method;

    if-eqz v1, :cond_0

    .line 115
    :try_start_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->sUpdateWindowMethod:Ljava/lang/reflect/Method;

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    aput-object v4, v2, v3

    const/4 v3, 0x1

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {v1, p0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 122
    :goto_0
    return-void

    .line 117
    :catch_0
    move-exception v0

    .line 118
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "unable to call updateWindow. reason="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 121
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    sget-object v1, Lcom/lge/app/floating/FloatingFunctionReflect;->TAG:Ljava/lang/String;

    const-string v2, "can not find updateWindow method"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
