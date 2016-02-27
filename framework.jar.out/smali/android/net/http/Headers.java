package android.net.http;

import android.net.wifi.WifiEnterpriseConfig;
import android.telephony.PhoneNumberUtils;
import java.util.ArrayList;
import org.apache.http.HeaderElement;
import org.apache.http.message.BasicHeaderValueParser;
import org.apache.http.message.ParserCursor;
import org.apache.http.util.CharArrayBuffer;

public final class Headers {
    public static final String ACCEPT_RANGES = "accept-ranges";
    public static final String CACHE_CONTROL = "cache-control";
    public static final int CONN_CLOSE = 1;
    public static final String CONN_DIRECTIVE = "connection";
    public static final int CONN_KEEP_ALIVE = 2;
    public static final String CONTENT_DISPOSITION = "content-disposition";
    public static final String CONTENT_ENCODING = "content-encoding";
    public static final String CONTENT_LEN = "content-length";
    public static final String CONTENT_TYPE = "content-type";
    public static final String ETAG = "etag";
    public static final String EXPIRES = "expires";
    private static final int HASH_ACCEPT_RANGES = 1397189435;
    private static final int HASH_CACHE_CONTROL = -208775662;
    private static final int HASH_CONN_DIRECTIVE = -775651618;
    private static final int HASH_CONTENT_DISPOSITION = -1267267485;
    private static final int HASH_CONTENT_ENCODING = 2095084583;
    private static final int HASH_CONTENT_LEN = -1132779846;
    private static final int HASH_CONTENT_TYPE = 785670158;
    private static final int HASH_ETAG = 3123477;
    private static final int HASH_EXPIRES = -1309235404;
    private static final int HASH_LAST_MODIFIED = 150043680;
    private static final int HASH_LOCATION = 1901043637;
    private static final int HASH_PRAGMA = -980228804;
    private static final int HASH_PROXY_AUTHENTICATE = -301767724;
    private static final int HASH_PROXY_CONNECTION = 285929373;
    private static final int HASH_REFRESH = 1085444827;
    private static final int HASH_SET_COOKIE = 1237214767;
    private static final int HASH_TRANSFER_ENCODING = 1274458357;
    private static final int HASH_WWW_AUTHENTICATE = -243037365;
    private static final int HASH_X_PERMITTED_CROSS_DOMAIN_POLICIES = -1345594014;
    private static final int HEADER_COUNT = 19;
    private static final int IDX_ACCEPT_RANGES = 10;
    private static final int IDX_CACHE_CONTROL = 12;
    private static final int IDX_CONN_DIRECTIVE = 4;
    private static final int IDX_CONTENT_DISPOSITION = 9;
    private static final int IDX_CONTENT_ENCODING = 3;
    private static final int IDX_CONTENT_LEN = 1;
    private static final int IDX_CONTENT_TYPE = 2;
    private static final int IDX_ETAG = 14;
    private static final int IDX_EXPIRES = 11;
    private static final int IDX_LAST_MODIFIED = 13;
    private static final int IDX_LOCATION = 5;
    private static final int IDX_PRAGMA = 16;
    private static final int IDX_PROXY_AUTHENTICATE = 8;
    private static final int IDX_PROXY_CONNECTION = 6;
    private static final int IDX_REFRESH = 17;
    private static final int IDX_SET_COOKIE = 15;
    private static final int IDX_TRANSFER_ENCODING = 0;
    private static final int IDX_WWW_AUTHENTICATE = 7;
    private static final int IDX_X_PERMITTED_CROSS_DOMAIN_POLICIES = 18;
    public static final String LAST_MODIFIED = "last-modified";
    public static final String LOCATION = "location";
    private static final String LOGTAG = "Http";
    public static final int NO_CONN_TYPE = 0;
    public static final long NO_CONTENT_LENGTH = -1;
    public static final long NO_TRANSFER_ENCODING = 0;
    public static final String PRAGMA = "pragma";
    public static final String PROXY_AUTHENTICATE = "proxy-authenticate";
    public static final String PROXY_CONNECTION = "proxy-connection";
    public static final String REFRESH = "refresh";
    public static final String SET_COOKIE = "set-cookie";
    public static final String TRANSFER_ENCODING = "transfer-encoding";
    public static final String WWW_AUTHENTICATE = "www-authenticate";
    public static final String X_PERMITTED_CROSS_DOMAIN_POLICIES = "x-permitted-cross-domain-policies";
    private static final String[] sHeaderNames;
    private int connectionType;
    private long contentLength;
    private ArrayList<String> cookies;
    private ArrayList<String> mExtraHeaderNames;
    private ArrayList<String> mExtraHeaderValues;
    private String[] mHeaders;
    private long transferEncoding;

    public interface HeaderCallback {
        void header(String str, String str2);
    }

    static {
        String[] strArr = new String[HEADER_COUNT];
        strArr[NO_CONN_TYPE] = TRANSFER_ENCODING;
        strArr[IDX_CONTENT_LEN] = CONTENT_LEN;
        strArr[IDX_CONTENT_TYPE] = CONTENT_TYPE;
        strArr[IDX_CONTENT_ENCODING] = CONTENT_ENCODING;
        strArr[IDX_CONN_DIRECTIVE] = CONN_DIRECTIVE;
        strArr[IDX_LOCATION] = LOCATION;
        strArr[IDX_PROXY_CONNECTION] = PROXY_CONNECTION;
        strArr[IDX_WWW_AUTHENTICATE] = WWW_AUTHENTICATE;
        strArr[IDX_PROXY_AUTHENTICATE] = PROXY_AUTHENTICATE;
        strArr[IDX_CONTENT_DISPOSITION] = CONTENT_DISPOSITION;
        strArr[IDX_ACCEPT_RANGES] = ACCEPT_RANGES;
        strArr[IDX_EXPIRES] = EXPIRES;
        strArr[IDX_CACHE_CONTROL] = CACHE_CONTROL;
        strArr[IDX_LAST_MODIFIED] = LAST_MODIFIED;
        strArr[IDX_ETAG] = ETAG;
        strArr[IDX_SET_COOKIE] = SET_COOKIE;
        strArr[IDX_PRAGMA] = PRAGMA;
        strArr[IDX_REFRESH] = REFRESH;
        strArr[IDX_X_PERMITTED_CROSS_DOMAIN_POLICIES] = X_PERMITTED_CROSS_DOMAIN_POLICIES;
        sHeaderNames = strArr;
    }

    public Headers() {
        this.cookies = new ArrayList(IDX_CONTENT_TYPE);
        this.mHeaders = new String[HEADER_COUNT];
        this.mExtraHeaderNames = new ArrayList(IDX_CONN_DIRECTIVE);
        this.mExtraHeaderValues = new ArrayList(IDX_CONN_DIRECTIVE);
        this.transferEncoding = NO_TRANSFER_ENCODING;
        this.contentLength = NO_CONTENT_LENGTH;
        this.connectionType = NO_CONN_TYPE;
    }

    public void parseHeader(CharArrayBuffer buffer) {
        int pos = CharArrayBuffers.setLowercaseIndexOf(buffer, 58);
        if (pos != -1) {
            String name = buffer.substringTrimmed(NO_CONN_TYPE, pos);
            if (name.length() != 0) {
                pos += IDX_CONTENT_LEN;
                String val = buffer.substringTrimmed(pos, buffer.length());
                switch (name.hashCode()) {
                    case HASH_X_PERMITTED_CROSS_DOMAIN_POLICIES /*-1345594014*/:
                        if (name.equals(X_PERMITTED_CROSS_DOMAIN_POLICIES)) {
                            this.mHeaders[IDX_X_PERMITTED_CROSS_DOMAIN_POLICIES] = val;
                        }
                    case HASH_EXPIRES /*-1309235404*/:
                        if (name.equals(EXPIRES)) {
                            this.mHeaders[IDX_EXPIRES] = val;
                        }
                    case HASH_CONTENT_DISPOSITION /*-1267267485*/:
                        if (name.equals(CONTENT_DISPOSITION)) {
                            this.mHeaders[IDX_CONTENT_DISPOSITION] = val;
                        }
                    case HASH_CONTENT_LEN /*-1132779846*/:
                        if (name.equals(CONTENT_LEN)) {
                            this.mHeaders[IDX_CONTENT_LEN] = val;
                            try {
                                this.contentLength = Long.parseLong(val);
                            } catch (NumberFormatException e) {
                            }
                        }
                    case HASH_PRAGMA /*-980228804*/:
                        if (name.equals(PRAGMA)) {
                            this.mHeaders[IDX_PRAGMA] = val;
                        }
                    case HASH_CONN_DIRECTIVE /*-775651618*/:
                        if (name.equals(CONN_DIRECTIVE)) {
                            this.mHeaders[IDX_CONN_DIRECTIVE] = val;
                            setConnectionType(buffer, pos);
                        }
                    case HASH_PROXY_AUTHENTICATE /*-301767724*/:
                        if (name.equals(PROXY_AUTHENTICATE)) {
                            this.mHeaders[IDX_PROXY_AUTHENTICATE] = val;
                        }
                    case HASH_WWW_AUTHENTICATE /*-243037365*/:
                        if (name.equals(WWW_AUTHENTICATE)) {
                            this.mHeaders[IDX_WWW_AUTHENTICATE] = val;
                        }
                    case HASH_CACHE_CONTROL /*-208775662*/:
                        if (!name.equals(CACHE_CONTROL)) {
                            return;
                        }
                        if (this.mHeaders[IDX_CACHE_CONTROL] == null || this.mHeaders[IDX_CACHE_CONTROL].length() <= 0) {
                            this.mHeaders[IDX_CACHE_CONTROL] = val;
                            return;
                        }
                        StringBuilder stringBuilder = new StringBuilder();
                        String[] strArr = this.mHeaders;
                        strArr[IDX_CACHE_CONTROL] = stringBuilder.append(strArr[IDX_CACHE_CONTROL]).append(PhoneNumberUtils.PAUSE).append(val).toString();
                    case HASH_ETAG /*3123477*/:
                        if (name.equals(ETAG)) {
                            this.mHeaders[IDX_ETAG] = val;
                        }
                    case HASH_LAST_MODIFIED /*150043680*/:
                        if (name.equals(LAST_MODIFIED)) {
                            this.mHeaders[IDX_LAST_MODIFIED] = val;
                        }
                    case HASH_PROXY_CONNECTION /*285929373*/:
                        if (name.equals(PROXY_CONNECTION)) {
                            this.mHeaders[IDX_PROXY_CONNECTION] = val;
                            setConnectionType(buffer, pos);
                        }
                    case HASH_CONTENT_TYPE /*785670158*/:
                        if (name.equals(CONTENT_TYPE)) {
                            this.mHeaders[IDX_CONTENT_TYPE] = val;
                        }
                    case HASH_REFRESH /*1085444827*/:
                        if (name.equals(REFRESH)) {
                            this.mHeaders[IDX_REFRESH] = val;
                        }
                    case HASH_SET_COOKIE /*1237214767*/:
                        if (name.equals(SET_COOKIE)) {
                            this.mHeaders[IDX_SET_COOKIE] = val;
                            this.cookies.add(val);
                        }
                    case HASH_TRANSFER_ENCODING /*1274458357*/:
                        if (name.equals(TRANSFER_ENCODING)) {
                            this.mHeaders[NO_CONN_TYPE] = val;
                            HeaderElement[] encodings = BasicHeaderValueParser.DEFAULT.parseElements(buffer, new ParserCursor(pos, buffer.length()));
                            int len = encodings.length;
                            if (WifiEnterpriseConfig.IDENTITY_KEY.equalsIgnoreCase(val)) {
                                this.transferEncoding = NO_CONTENT_LENGTH;
                            } else if (len <= 0 || !"chunked".equalsIgnoreCase(encodings[len - 1].getName())) {
                                this.transferEncoding = NO_CONTENT_LENGTH;
                            } else {
                                this.transferEncoding = -2;
                            }
                        }
                    case HASH_ACCEPT_RANGES /*1397189435*/:
                        if (name.equals(ACCEPT_RANGES)) {
                            this.mHeaders[IDX_ACCEPT_RANGES] = val;
                        }
                    case HASH_LOCATION /*1901043637*/:
                        if (name.equals(LOCATION)) {
                            this.mHeaders[IDX_LOCATION] = val;
                        }
                    case HASH_CONTENT_ENCODING /*2095084583*/:
                        if (name.equals(CONTENT_ENCODING)) {
                            this.mHeaders[IDX_CONTENT_ENCODING] = val;
                        }
                    default:
                        this.mExtraHeaderNames.add(name);
                        this.mExtraHeaderValues.add(val);
                }
            }
        }
    }

    public long getTransferEncoding() {
        return this.transferEncoding;
    }

    public long getContentLength() {
        return this.contentLength;
    }

    public int getConnectionType() {
        return this.connectionType;
    }

    public String getContentType() {
        return this.mHeaders[IDX_CONTENT_TYPE];
    }

    public String getContentEncoding() {
        return this.mHeaders[IDX_CONTENT_ENCODING];
    }

    public String getLocation() {
        return this.mHeaders[IDX_LOCATION];
    }

    public String getWwwAuthenticate() {
        return this.mHeaders[IDX_WWW_AUTHENTICATE];
    }

    public String getProxyAuthenticate() {
        return this.mHeaders[IDX_PROXY_AUTHENTICATE];
    }

    public String getContentDisposition() {
        return this.mHeaders[IDX_CONTENT_DISPOSITION];
    }

    public String getAcceptRanges() {
        return this.mHeaders[IDX_ACCEPT_RANGES];
    }

    public String getExpires() {
        return this.mHeaders[IDX_EXPIRES];
    }

    public String getCacheControl() {
        return this.mHeaders[IDX_CACHE_CONTROL];
    }

    public String getLastModified() {
        return this.mHeaders[IDX_LAST_MODIFIED];
    }

    public String getEtag() {
        return this.mHeaders[IDX_ETAG];
    }

    public ArrayList<String> getSetCookie() {
        return this.cookies;
    }

    public String getPragma() {
        return this.mHeaders[IDX_PRAGMA];
    }

    public String getRefresh() {
        return this.mHeaders[IDX_REFRESH];
    }

    public String getXPermittedCrossDomainPolicies() {
        return this.mHeaders[IDX_X_PERMITTED_CROSS_DOMAIN_POLICIES];
    }

    public void setContentLength(long value) {
        this.contentLength = value;
    }

    public void setContentType(String value) {
        this.mHeaders[IDX_CONTENT_TYPE] = value;
    }

    public void setContentEncoding(String value) {
        this.mHeaders[IDX_CONTENT_ENCODING] = value;
    }

    public void setLocation(String value) {
        this.mHeaders[IDX_LOCATION] = value;
    }

    public void setWwwAuthenticate(String value) {
        this.mHeaders[IDX_WWW_AUTHENTICATE] = value;
    }

    public void setProxyAuthenticate(String value) {
        this.mHeaders[IDX_PROXY_AUTHENTICATE] = value;
    }

    public void setContentDisposition(String value) {
        this.mHeaders[IDX_CONTENT_DISPOSITION] = value;
    }

    public void setAcceptRanges(String value) {
        this.mHeaders[IDX_ACCEPT_RANGES] = value;
    }

    public void setExpires(String value) {
        this.mHeaders[IDX_EXPIRES] = value;
    }

    public void setCacheControl(String value) {
        this.mHeaders[IDX_CACHE_CONTROL] = value;
    }

    public void setLastModified(String value) {
        this.mHeaders[IDX_LAST_MODIFIED] = value;
    }

    public void setEtag(String value) {
        this.mHeaders[IDX_ETAG] = value;
    }

    public void setXPermittedCrossDomainPolicies(String value) {
        this.mHeaders[IDX_X_PERMITTED_CROSS_DOMAIN_POLICIES] = value;
    }

    public void getHeaders(HeaderCallback hcb) {
        int i;
        for (i = NO_CONN_TYPE; i < HEADER_COUNT; i += IDX_CONTENT_LEN) {
            String h = this.mHeaders[i];
            if (h != null) {
                hcb.header(sHeaderNames[i], h);
            }
        }
        int extraLen = this.mExtraHeaderNames.size();
        for (i = NO_CONN_TYPE; i < extraLen; i += IDX_CONTENT_LEN) {
            hcb.header((String) this.mExtraHeaderNames.get(i), (String) this.mExtraHeaderValues.get(i));
        }
    }

    private void setConnectionType(CharArrayBuffer buffer, int pos) {
        if (CharArrayBuffers.containsIgnoreCaseTrimmed(buffer, pos, "Close")) {
            this.connectionType = IDX_CONTENT_LEN;
        } else if (CharArrayBuffers.containsIgnoreCaseTrimmed(buffer, pos, "Keep-Alive")) {
            this.connectionType = IDX_CONTENT_TYPE;
        }
    }
}
