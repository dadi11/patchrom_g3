.class public Landroid/view/ObjectFinderEngineProxy;
.super Ljava/lang/Object;
.source "ObjectFinderEngineProxy.java"

# interfaces
.implements Landroid/view/ViewRootImpl$IObjectFinderEngineProxy;


# static fields
.field private static final BASE64_ENCODED_CLAYBOX_CERTIFICATE:Ljava/lang/String; = "MIIDJDCCAgygAwIBAgIET9A5qzANBgkqhkiG9w0BAQUFADBTMQswCQYDVQQGEwJrbzEMMAoGA1UECBMDbGdlMQwwCgYDVQQHEwNsZ2UxDDAKBgNVBAoTA2xnZTEMMAoGA1UECxMDbGdlMQwwCgYDVQQDEwNsZ2UwIBcNMTIwNjA3MDUxODM1WhgPMjI4NjAzMjMwNTE4MzVaMFMxCzAJBgNVBAYTAmtvMQwwCgYDVQQIEwNsZ2UxDDAKBgNVBAcTA2xnZTEMMAoGA1UEChMDbGdlMQwwCgYDVQQLEwNsZ2UxDDAKBgNVBAMTA2xnZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOZe8xG85261iyweZIbTu/0oFFlTLGqCF5CRXS+jcs8eHgpEO6H07XX9gVlQ2da5SEjjJeDoEUQhDlygR/z1kSmEDwYwX/s3bDhghKpXHPkOsXIWKj7/hO76e4kPlKtck2KzhdSbjkQEktCXkRRTpNB+mlUc1BQsRFGVKCEyIEiypP0jwtR9+yLjUfsBhgI9V3EWsRP5Af0WJ07wPONgr7rZqBBWzIc3lQP1jX8jk8ycJG22+j5wlAJ5je+gdvxX4JyI9QPlDYQEsExeV8kHopjkL6bGDjmoBLP5h5Z6Q+ht2oBkRrstSm7oXGaBsBZd9Hid3Dx3FGwEixcp9BaQqZ8CAwEAATANBgkqhkiG9w0BAQUFAAOCAQEAX3grEnXhx/QapiBK0FMTRwQXnODncpM7Mqq++DiyTfRC0Yh8ARr2TySRdT8wLKH/bsgwIV/GGKArYUvvvI3bmLsKYskYO38U1PHedBvpKLVHLkTVJ0qVJHpRVPGYOaXzb82MOzxzm9Hn5rg4HQf6k4Wwl5jU8ofwczicdcf/CSQb0SnzJKZJhO1okYqanFTm5WBbb+9WoWlHyQDt7GEm3akDwVd/gdQ8LItmbPGv1gI3Yax+ww0CJVoCvkdtWwwcjCpq0Wb3q+HAEGzbQNOJHLnKBzF/bNdVne3aTkEHpTKjWxnDDms7d/nrqK+Vz2IKLt1Izy3OMvH7OlbC1UZiRA=="

.field public static CLAYBOX_OFEIMPL_PATH:Ljava/lang/String; = null

.field private static final TAG:Ljava/lang/String; = "ObjectFinderEngineProxy"

.field public static final VERSION:Ljava/lang/String; = "1.0"

.field private static final instance:Landroid/view/ObjectFinderEngineProxy;


# instance fields
.field mExecuteMethod:Ljava/lang/reflect/Method;

.field mObjectFinderImpl:Ljava/lang/Object;

.field mRetSize:[B


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-string v0, "/data/data/com.lge.art/files/claybox/clayboxofeimpl.jar"

    sput-object v0, Landroid/view/ObjectFinderEngineProxy;->CLAYBOX_OFEIMPL_PATH:Ljava/lang/String;

    new-instance v0, Landroid/view/ObjectFinderEngineProxy;

    invoke-direct {v0}, Landroid/view/ObjectFinderEngineProxy;-><init>()V

    sput-object v0, Landroid/view/ObjectFinderEngineProxy;->instance:Landroid/view/ObjectFinderEngineProxy;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x4

    new-array v0, v0, [B

    iput-object v0, p0, Landroid/view/ObjectFinderEngineProxy;->mRetSize:[B

    return-void
.end method

.method public static getInstance()Landroid/view/ObjectFinderEngineProxy;
    .locals 1

    .prologue
    sget-object v0, Landroid/view/ObjectFinderEngineProxy;->instance:Landroid/view/ObjectFinderEngineProxy;

    return-object v0
.end method

.method private loadImpl()V
    .locals 7

    .prologue
    sget-object v5, Landroid/view/ObjectFinderEngineProxy;->CLAYBOX_OFEIMPL_PATH:Ljava/lang/String;

    invoke-static {v5}, Landroid/view/ObjectFinderEngineProxy;->verifyJarFile(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    :try_start_0
    new-instance v0, Ldalvik/system/PathClassLoader;

    sget-object v5, Landroid/view/ObjectFinderEngineProxy;->CLAYBOX_OFEIMPL_PATH:Ljava/lang/String;

    invoke-static {}, Ljava/lang/ClassLoader;->getSystemClassLoader()Ljava/lang/ClassLoader;

    move-result-object v6

    invoke-direct {v0, v5, v6}, Ldalvik/system/PathClassLoader;-><init>(Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .local v0, "classLoader":Ljava/lang/ClassLoader;
    const-string v5, "ObjectFinderEngineProxy"

    const-string v6, "certificate compare ok!"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v5, "android.view.ObjectFinderEngineImpl"

    invoke-virtual {v0, v5}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .local v1, "cls":Ljava/lang/Class;
    if-eqz v1, :cond_1

    const-string v5, "getInstance"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Class;

    invoke-virtual {v1, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    .local v4, "mainMethod":Ljava/lang/reflect/Method;
    if-eqz v4, :cond_0

    const/4 v5, 0x0

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    iput-object v5, p0, Landroid/view/ObjectFinderEngineProxy;->mObjectFinderImpl:Ljava/lang/Object;

    :cond_0
    const/4 v5, 0x4

    new-array v3, v5, [Ljava/lang/Class;

    .local v3, "executeParamTypes":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    const/4 v5, 0x0

    const-class v6, Ljava/lang/String;

    aput-object v6, v3, v5

    const/4 v5, 0x1

    const-class v6, Landroid/view/View;

    aput-object v6, v3, v5

    const/4 v5, 0x2

    const-class v6, Ljava/lang/String;

    aput-object v6, v3, v5

    const/4 v5, 0x3

    const-class v6, Ljava/io/OutputStream;

    aput-object v6, v3, v5

    const-string v5, "execute"

    invoke-virtual {v1, v5, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    iput-object v5, p0, Landroid/view/ObjectFinderEngineProxy;->mExecuteMethod:Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .end local v0    # "classLoader":Ljava/lang/ClassLoader;
    .end local v1    # "cls":Ljava/lang/Class;
    .end local v3    # "executeParamTypes":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    .end local v4    # "mainMethod":Ljava/lang/reflect/Method;
    :cond_1
    :goto_0
    return-void

    :catch_0
    move-exception v2

    .local v2, "e":Ljava/lang/ClassNotFoundException;
    :try_start_1
    invoke-virtual {v2}, Ljava/lang/ClassNotFoundException;->printStackTrace()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .end local v2    # "e":Ljava/lang/ClassNotFoundException;
    :catch_1
    move-exception v2

    .local v2, "e":Ljava/lang/Exception;
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .end local v2    # "e":Ljava/lang/Exception;
    :catch_2
    move-exception v2

    .local v2, "e":Ljava/lang/NoSuchMethodException;
    :try_start_2
    invoke-virtual {v2}, Ljava/lang/NoSuchMethodException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "e":Ljava/lang/NoSuchMethodException;
    :catch_3
    move-exception v2

    .local v2, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v2}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "e":Ljava/lang/IllegalArgumentException;
    :catch_4
    move-exception v2

    .local v2, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v2}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "e":Ljava/lang/IllegalAccessException;
    :catch_5
    move-exception v2

    .local v2, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v2}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0
.end method

.method private static verifyJarFile(Ljava/lang/String;)Z
    .locals 15
    .param p0, "jarfile"    # Ljava/lang/String;

    .prologue
    const/4 v12, 0x0

    const/4 v10, 0x0

    .local v10, "jarFile":Ljava/util/jar/JarFile;
    :try_start_0
    new-instance v11, Ljava/util/jar/JarFile;

    invoke-direct {v11, p0}, Ljava/util/jar/JarFile;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .end local v10    # "jarFile":Ljava/util/jar/JarFile;
    .local v11, "jarFile":Ljava/util/jar/JarFile;
    :try_start_1
    const-string v13, "classes.dex"

    invoke-virtual {v11, v13}, Ljava/util/jar/JarFile;->getJarEntry(Ljava/lang/String;)Ljava/util/jar/JarEntry;

    move-result-object v9

    .local v9, "jarEntry":Ljava/util/jar/JarEntry;
    invoke-virtual {v11, v9}, Ljava/util/jar/JarFile;->getInputStream(Ljava/util/zip/ZipEntry;)Ljava/io/InputStream;

    move-result-object v8

    .local v8, "in":Ljava/io/InputStream;
    const/16 v13, 0x400

    new-array v2, v13, [B

    .local v2, "buffer":[B
    :cond_0
    invoke-virtual {v8, v2}, Ljava/io/InputStream;->read([B)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    move-result v13

    if-gez v13, :cond_0

    :try_start_2
    const-string v13, "MIIDJDCCAgygAwIBAgIET9A5qzANBgkqhkiG9w0BAQUFADBTMQswCQYDVQQGEwJrbzEMMAoGA1UECBMDbGdlMQwwCgYDVQQHEwNsZ2UxDDAKBgNVBAoTA2xnZTEMMAoGA1UECxMDbGdlMQwwCgYDVQQDEwNsZ2UwIBcNMTIwNjA3MDUxODM1WhgPMjI4NjAzMjMwNTE4MzVaMFMxCzAJBgNVBAYTAmtvMQwwCgYDVQQIEwNsZ2UxDDAKBgNVBAcTA2xnZTEMMAoGA1UEChMDbGdlMQwwCgYDVQQLEwNsZ2UxDDAKBgNVBAMTA2xnZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOZe8xG85261iyweZIbTu/0oFFlTLGqCF5CRXS+jcs8eHgpEO6H07XX9gVlQ2da5SEjjJeDoEUQhDlygR/z1kSmEDwYwX/s3bDhghKpXHPkOsXIWKj7/hO76e4kPlKtck2KzhdSbjkQEktCXkRRTpNB+mlUc1BQsRFGVKCEyIEiypP0jwtR9+yLjUfsBhgI9V3EWsRP5Af0WJ07wPONgr7rZqBBWzIc3lQP1jX8jk8ycJG22+j5wlAJ5je+gdvxX4JyI9QPlDYQEsExeV8kHopjkL6bGDjmoBLP5h5Z6Q+ht2oBkRrstSm7oXGaBsBZd9Hid3Dx3FGwEixcp9BaQqZ8CAwEAATANBgkqhkiG9w0BAQUFAAOCAQEAX3grEnXhx/QapiBK0FMTRwQXnODncpM7Mqq++DiyTfRC0Yh8ARr2TySRdT8wLKH/bsgwIV/GGKArYUvvvI3bmLsKYskYO38U1PHedBvpKLVHLkTVJ0qVJHpRVPGYOaXzb82MOzxzm9Hn5rg4HQf6k4Wwl5jU8ofwczicdcf/CSQb0SnzJKZJhO1okYqanFTm5WBbb+9WoWlHyQDt7GEm3akDwVd/gdQ8LItmbPGv1gI3Yax+ww0CJVoCvkdtWwwcjCpq0Wb3q+HAEGzbQNOJHLnKBzF/bNdVne3aTkEHpTKjWxnDDms7d/nrqK+Vz2IKLt1Izy3OMvH7OlbC1UZiRA=="

    const/4 v14, 0x0

    invoke-static {v13, v14}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v6

    .local v6, "encoded":[B
    const-string v13, "X.509"

    invoke-static {v13}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object v4

    .local v4, "cf":Ljava/security/cert/CertificateFactory;
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, v6}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .local v1, "bais":Ljava/io/ByteArrayInputStream;
    invoke-virtual {v4, v1}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    move-result-object v0

    .local v0, "artitecert":Ljava/security/cert/Certificate;
    invoke-virtual {v9}, Ljava/util/jar/JarEntry;->getCertificates()[Ljava/security/cert/Certificate;

    move-result-object v3

    .local v3, "certs":[Ljava/security/cert/Certificate;
    invoke-virtual {v8}, Ljava/io/InputStream;->close()V

    if-eqz v3, :cond_3

    const/4 v7, 0x0

    .local v7, "i":I
    :goto_0
    array-length v13, v3

    if-ge v7, v13, :cond_3

    aget-object v13, v3, v7

    invoke-virtual {v0}, Ljava/security/cert/Certificate;->getPublicKey()Ljava/security/PublicKey;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/security/cert/Certificate;->verify(Ljava/security/PublicKey;)V

    aget-object v13, v3, v7

    invoke-virtual {v13}, Ljava/security/cert/Certificate;->getEncoded()[B

    move-result-object v13

    invoke-virtual {v0}, Ljava/security/cert/Certificate;->getEncoded()[B

    move-result-object v14

    invoke-static {v13, v14}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v13

    if-eqz v13, :cond_2

    const-string v13, "ObjectFinderEngineProxy"

    const-string v14, "certificate compare ok!"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v11, :cond_1

    invoke-virtual {v11}, Ljava/util/jar/JarFile;->close()V

    :cond_1
    const/4 v12, 0x1

    move-object v10, v11

    .end local v0    # "artitecert":Ljava/security/cert/Certificate;
    .end local v1    # "bais":Ljava/io/ByteArrayInputStream;
    .end local v2    # "buffer":[B
    .end local v3    # "certs":[Ljava/security/cert/Certificate;
    .end local v4    # "cf":Ljava/security/cert/CertificateFactory;
    .end local v6    # "encoded":[B
    .end local v7    # "i":I
    .end local v8    # "in":Ljava/io/InputStream;
    .end local v9    # "jarEntry":Ljava/util/jar/JarEntry;
    .end local v11    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v10    # "jarFile":Ljava/util/jar/JarFile;
    :goto_1
    return v12

    .end local v10    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v0    # "artitecert":Ljava/security/cert/Certificate;
    .restart local v1    # "bais":Ljava/io/ByteArrayInputStream;
    .restart local v2    # "buffer":[B
    .restart local v3    # "certs":[Ljava/security/cert/Certificate;
    .restart local v4    # "cf":Ljava/security/cert/CertificateFactory;
    .restart local v6    # "encoded":[B
    .restart local v7    # "i":I
    .restart local v8    # "in":Ljava/io/InputStream;
    .restart local v9    # "jarEntry":Ljava/util/jar/JarEntry;
    .restart local v11    # "jarFile":Ljava/util/jar/JarFile;
    :cond_2
    const-string v13, "ObjectFinderEngineProxy"

    const-string v14, "certificate compare fail!"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .end local v0    # "artitecert":Ljava/security/cert/Certificate;
    .end local v1    # "bais":Ljava/io/ByteArrayInputStream;
    .end local v3    # "certs":[Ljava/security/cert/Certificate;
    .end local v4    # "cf":Ljava/security/cert/CertificateFactory;
    .end local v6    # "encoded":[B
    .end local v7    # "i":I
    :catch_0
    move-exception v5

    .local v5, "e":Ljava/lang/Exception;
    :try_start_3
    invoke-virtual {v5}, Ljava/lang/Exception;->printStackTrace()V

    .end local v5    # "e":Ljava/lang/Exception;
    :cond_3
    invoke-virtual {v11}, Ljava/util/jar/JarFile;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    move-object v10, v11

    .end local v11    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v10    # "jarFile":Ljava/util/jar/JarFile;
    goto :goto_1

    .end local v2    # "buffer":[B
    .end local v8    # "in":Ljava/io/InputStream;
    .end local v9    # "jarEntry":Ljava/util/jar/JarEntry;
    :catch_1
    move-exception v5

    .restart local v5    # "e":Ljava/lang/Exception;
    :goto_2
    invoke-virtual {v5}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1

    .end local v5    # "e":Ljava/lang/Exception;
    .end local v10    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v11    # "jarFile":Ljava/util/jar/JarFile;
    :catch_2
    move-exception v5

    move-object v10, v11

    .end local v11    # "jarFile":Ljava/util/jar/JarFile;
    .restart local v10    # "jarFile":Ljava/util/jar/JarFile;
    goto :goto_2
.end method


# virtual methods
.method public execute(Ljava/lang/String;Landroid/view/View;Ljava/lang/String;Ljava/io/OutputStream;)Z
    .locals 7
    .param p1, "cmd"    # Ljava/lang/String;
    .param p2, "view"    # Landroid/view/View;
    .param p3, "parameters"    # Ljava/lang/String;
    .param p4, "ostream"    # Ljava/io/OutputStream;

    .prologue
    const/4 v2, 0x0

    const-string v3, "ObjectFinderEngineProxy"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "execute() - command: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", parameters: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v3, p0, Landroid/view/ObjectFinderEngineProxy;->mObjectFinderImpl:Ljava/lang/Object;

    if-nez v3, :cond_0

    invoke-direct {p0}, Landroid/view/ObjectFinderEngineProxy;->loadImpl()V

    iget-object v3, p0, Landroid/view/ObjectFinderEngineProxy;->mObjectFinderImpl:Ljava/lang/Object;

    if-nez v3, :cond_0

    :goto_0
    return v2

    :cond_0
    :try_start_0
    iget-object v3, p0, Landroid/view/ObjectFinderEngineProxy;->mExecuteMethod:Ljava/lang/reflect/Method;

    iget-object v4, p0, Landroid/view/ObjectFinderEngineProxy;->mObjectFinderImpl:Ljava/lang/Object;

    const/4 v5, 0x4

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object p1, v5, v6

    const/4 v6, 0x1

    aput-object p2, v5, v6

    const/4 v6, 0x2

    aput-object p3, v5, v6

    const/4 v6, 0x3

    aput-object p4, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    .local v1, "retval":Ljava/lang/Boolean;
    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    goto :goto_0

    .end local v1    # "retval":Ljava/lang/Boolean;
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Throwable;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_0
.end method

.method protected sendInt(ILjava/io/OutputStream;)V
    .locals 3
    .param p1, "length"    # I
    .param p2, "ostream"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Landroid/view/ObjectFinderEngineProxy;->mRetSize:[B

    const/4 v1, 0x3

    and-int/lit16 v2, p1, 0xff

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    iget-object v0, p0, Landroid/view/ObjectFinderEngineProxy;->mRetSize:[B

    const/4 v1, 0x2

    shr-int/lit8 v2, p1, 0x8

    and-int/lit16 v2, v2, 0xff

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    iget-object v0, p0, Landroid/view/ObjectFinderEngineProxy;->mRetSize:[B

    const/4 v1, 0x1

    shr-int/lit8 v2, p1, 0x10

    and-int/lit16 v2, v2, 0xff

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    iget-object v0, p0, Landroid/view/ObjectFinderEngineProxy;->mRetSize:[B

    const/4 v1, 0x0

    shr-int/lit8 v2, p1, 0x18

    and-int/lit16 v2, v2, 0xff

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    iget-object v0, p0, Landroid/view/ObjectFinderEngineProxy;->mRetSize:[B

    invoke-virtual {p2, v0}, Ljava/io/OutputStream;->write([B)V

    return-void
.end method

.method public sendString(Ljava/lang/String;Ljava/io/OutputStream;)V
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "ostream"    # Ljava/io/OutputStream;

    .prologue
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    array-length v1, v1

    invoke-virtual {p0, v1, p2}, Landroid/view/ObjectFinderEngineProxy;->sendInt(ILjava/io/OutputStream;)V

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-virtual {p2, v1}, Ljava/io/OutputStream;->write([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method
