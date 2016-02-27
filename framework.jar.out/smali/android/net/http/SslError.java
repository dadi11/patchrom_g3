package android.net.http;

import android.net.ProxyInfo;
import java.security.cert.X509Certificate;

public class SslError {
    static final /* synthetic */ boolean $assertionsDisabled;
    public static final int SSL_DATE_INVALID = 4;
    public static final int SSL_EXPIRED = 1;
    public static final int SSL_IDMISMATCH = 2;
    public static final int SSL_INVALID = 5;
    @Deprecated
    public static final int SSL_MAX_ERROR = 6;
    public static final int SSL_NOTYETVALID = 0;
    public static final int SSL_UNTRUSTED = 3;
    final SslCertificate mCertificate;
    int mErrors;
    final String mUrl;

    static {
        $assertionsDisabled = !SslError.class.desiredAssertionStatus() ? true : $assertionsDisabled;
    }

    @Deprecated
    public SslError(int error, SslCertificate certificate) {
        this(error, certificate, ProxyInfo.LOCAL_EXCL_LIST);
    }

    @Deprecated
    public SslError(int error, X509Certificate certificate) {
        this(error, certificate, ProxyInfo.LOCAL_EXCL_LIST);
    }

    public SslError(int error, SslCertificate certificate, String url) {
        if (!$assertionsDisabled && certificate == null) {
            throw new AssertionError();
        } else if ($assertionsDisabled || url != null) {
            addError(error);
            this.mCertificate = certificate;
            this.mUrl = url;
        } else {
            throw new AssertionError();
        }
    }

    public SslError(int error, X509Certificate certificate, String url) {
        this(error, new SslCertificate(certificate), url);
    }

    public static SslError SslErrorFromChromiumErrorCode(int error, SslCertificate cert, String url) {
        if (!$assertionsDisabled && (error < -299 || error > -200)) {
            throw new AssertionError();
        } else if (error == -200) {
            return new SslError((int) SSL_IDMISMATCH, cert, url);
        } else {
            if (error == -201) {
                return new SslError((int) SSL_DATE_INVALID, cert, url);
            }
            if (error == -202) {
                return new SslError((int) SSL_UNTRUSTED, cert, url);
            }
            return new SslError((int) SSL_INVALID, cert, url);
        }
    }

    public SslCertificate getCertificate() {
        return this.mCertificate;
    }

    public String getUrl() {
        return this.mUrl;
    }

    public boolean addError(int error) {
        boolean rval = (error < 0 || error >= SSL_MAX_ERROR) ? $assertionsDisabled : true;
        if (rval) {
            this.mErrors = (SSL_EXPIRED << error) | this.mErrors;
        }
        return rval;
    }

    public boolean hasError(int error) {
        boolean rval;
        if (error < 0 || error >= SSL_MAX_ERROR) {
            rval = $assertionsDisabled;
        } else {
            rval = true;
        }
        if (!rval) {
            return rval;
        }
        if ((this.mErrors & (SSL_EXPIRED << error)) != 0) {
            return true;
        }
        return $assertionsDisabled;
    }

    public int getPrimaryError() {
        if (this.mErrors != 0) {
            for (int error = SSL_INVALID; error >= 0; error--) {
                if ((this.mErrors & (SSL_EXPIRED << error)) != 0) {
                    return error;
                }
            }
            if (!$assertionsDisabled) {
                throw new AssertionError();
            }
        }
        return -1;
    }

    public String toString() {
        return "primary error: " + getPrimaryError() + " certificate: " + getCertificate() + " on URL: " + getUrl();
    }
}
