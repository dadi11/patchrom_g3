package android.net.http;

import android.C0000R;
import android.content.Context;
import android.util.Log;
import android.webkit.WebViewClient;
import android.widget.ListPopupWindow;
import android.widget.Toast;

public class ErrorStrings {
    private static final String LOGTAG = "Http";

    private ErrorStrings() {
    }

    public static String getString(int errorCode, Context context) {
        return context.getText(getResource(errorCode)).toString();
    }

    public static int getResource(int errorCode) {
        switch (errorCode) {
            case WebViewClient.ERROR_TOO_MANY_REQUESTS /*-15*/:
                return 17039591;
            case WebViewClient.ERROR_FILE_NOT_FOUND /*-14*/:
                return 17039590;
            case WebViewClient.ERROR_FILE /*-13*/:
                return 17039589;
            case WebViewClient.ERROR_BAD_URL /*-12*/:
                return C0000R.string.httpErrorBadUrl;
            case WebViewClient.ERROR_FAILED_SSL_HANDSHAKE /*-11*/:
                return 17039588;
            case WebViewClient.ERROR_UNSUPPORTED_SCHEME /*-10*/:
                return C0000R.string.httpErrorUnsupportedScheme;
            case WebViewClient.ERROR_REDIRECT_LOOP /*-9*/:
                return 17039587;
            case WebViewClient.ERROR_TIMEOUT /*-8*/:
                return 17039586;
            case WebViewClient.ERROR_IO /*-7*/:
                return 17039585;
            case WebViewClient.ERROR_CONNECT /*-6*/:
                return 17039584;
            case WebViewClient.ERROR_PROXY_AUTHENTICATION /*-5*/:
                return 17039583;
            case WebViewClient.ERROR_AUTHENTICATION /*-4*/:
                return 17039582;
            case WebViewClient.ERROR_UNSUPPORTED_AUTH_SCHEME /*-3*/:
                return 17039581;
            case ListPopupWindow.WRAP_CONTENT /*-2*/:
                return 17039580;
            case ListPopupWindow.MATCH_PARENT /*-1*/:
                return 17039579;
            case Toast.LENGTH_SHORT /*0*/:
                return 17039578;
            default:
                Log.w(LOGTAG, "Using generic message for unknown error code: " + errorCode);
                return 17039579;
        }
    }
}
