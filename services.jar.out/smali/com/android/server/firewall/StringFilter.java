package com.android.server.firewall;

import android.content.ComponentName;
import android.content.Intent;
import android.net.Uri;
import android.os.PatternMatcher;
import com.android.server.voiceinteraction.DatabaseHelper.SoundModelContract;
import java.io.IOException;
import java.util.regex.Pattern;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

abstract class StringFilter implements Filter {
    public static final FilterFactory ACTION;
    private static final String ATTR_CONTAINS = "contains";
    private static final String ATTR_EQUALS = "equals";
    private static final String ATTR_IS_NULL = "isNull";
    private static final String ATTR_PATTERN = "pattern";
    private static final String ATTR_REGEX = "regex";
    private static final String ATTR_STARTS_WITH = "startsWith";
    public static final ValueProvider COMPONENT;
    public static final ValueProvider COMPONENT_NAME;
    public static final ValueProvider COMPONENT_PACKAGE;
    public static final ValueProvider DATA;
    public static final ValueProvider HOST;
    public static final ValueProvider MIME_TYPE;
    public static final ValueProvider PATH;
    public static final ValueProvider SCHEME;
    public static final ValueProvider SSP;
    private final ValueProvider mValueProvider;

    private static abstract class ValueProvider extends FilterFactory {
        public abstract String getValue(ComponentName componentName, Intent intent, String str);

        protected ValueProvider(String tag) {
            super(tag);
        }

        public Filter newFilter(XmlPullParser parser) throws IOException, XmlPullParserException {
            return StringFilter.readFromXml(this, parser);
        }
    }

    /* renamed from: com.android.server.firewall.StringFilter.10 */
    static class AnonymousClass10 extends ValueProvider {
        AnonymousClass10(String x0) {
            super(x0);
        }

        public String getValue(ComponentName resolvedComponent, Intent intent, String resolvedType) {
            Uri data = intent.getData();
            if (data != null) {
                return data.getPath();
            }
            return null;
        }
    }

    /* renamed from: com.android.server.firewall.StringFilter.1 */
    static class C02641 extends ValueProvider {
        C02641(String x0) {
            super(x0);
        }

        public String getValue(ComponentName resolvedComponent, Intent intent, String resolvedType) {
            if (resolvedComponent != null) {
                return resolvedComponent.flattenToString();
            }
            return null;
        }
    }

    /* renamed from: com.android.server.firewall.StringFilter.2 */
    static class C02652 extends ValueProvider {
        C02652(String x0) {
            super(x0);
        }

        public String getValue(ComponentName resolvedComponent, Intent intent, String resolvedType) {
            if (resolvedComponent != null) {
                return resolvedComponent.getClassName();
            }
            return null;
        }
    }

    /* renamed from: com.android.server.firewall.StringFilter.3 */
    static class C02663 extends ValueProvider {
        C02663(String x0) {
            super(x0);
        }

        public String getValue(ComponentName resolvedComponent, Intent intent, String resolvedType) {
            if (resolvedComponent != null) {
                return resolvedComponent.getPackageName();
            }
            return null;
        }
    }

    /* renamed from: com.android.server.firewall.StringFilter.4 */
    static class C02674 extends ValueProvider {
        C02674(String x0) {
            super(x0);
        }

        public String getValue(ComponentName resolvedComponent, Intent intent, String resolvedType) {
            return intent.getAction();
        }
    }

    /* renamed from: com.android.server.firewall.StringFilter.5 */
    static class C02685 extends ValueProvider {
        C02685(String x0) {
            super(x0);
        }

        public String getValue(ComponentName resolvedComponent, Intent intent, String resolvedType) {
            Uri data = intent.getData();
            if (data != null) {
                return data.toString();
            }
            return null;
        }
    }

    /* renamed from: com.android.server.firewall.StringFilter.6 */
    static class C02696 extends ValueProvider {
        C02696(String x0) {
            super(x0);
        }

        public String getValue(ComponentName resolvedComponent, Intent intent, String resolvedType) {
            return resolvedType;
        }
    }

    /* renamed from: com.android.server.firewall.StringFilter.7 */
    static class C02707 extends ValueProvider {
        C02707(String x0) {
            super(x0);
        }

        public String getValue(ComponentName resolvedComponent, Intent intent, String resolvedType) {
            Uri data = intent.getData();
            if (data != null) {
                return data.getScheme();
            }
            return null;
        }
    }

    /* renamed from: com.android.server.firewall.StringFilter.8 */
    static class C02718 extends ValueProvider {
        C02718(String x0) {
            super(x0);
        }

        public String getValue(ComponentName resolvedComponent, Intent intent, String resolvedType) {
            Uri data = intent.getData();
            if (data != null) {
                return data.getSchemeSpecificPart();
            }
            return null;
        }
    }

    /* renamed from: com.android.server.firewall.StringFilter.9 */
    static class C02729 extends ValueProvider {
        C02729(String x0) {
            super(x0);
        }

        public String getValue(ComponentName resolvedComponent, Intent intent, String resolvedType) {
            Uri data = intent.getData();
            if (data != null) {
                return data.getHost();
            }
            return null;
        }
    }

    private static class ContainsFilter extends StringFilter {
        private final String mFilterValue;

        public ContainsFilter(ValueProvider valueProvider, String attrValue) {
            super(null);
            this.mFilterValue = attrValue;
        }

        public boolean matchesValue(String value) {
            return value != null && value.contains(this.mFilterValue);
        }
    }

    private static class EqualsFilter extends StringFilter {
        private final String mFilterValue;

        public EqualsFilter(ValueProvider valueProvider, String attrValue) {
            super(null);
            this.mFilterValue = attrValue;
        }

        public boolean matchesValue(String value) {
            return value != null && value.equals(this.mFilterValue);
        }
    }

    private static class IsNullFilter extends StringFilter {
        private final boolean mIsNull;

        public IsNullFilter(ValueProvider valueProvider, String attrValue) {
            super(null);
            this.mIsNull = Boolean.parseBoolean(attrValue);
        }

        public IsNullFilter(ValueProvider valueProvider, boolean isNull) {
            super(null);
            this.mIsNull = isNull;
        }

        public boolean matchesValue(String value) {
            return (value == null) == this.mIsNull;
        }
    }

    private static class PatternStringFilter extends StringFilter {
        private final PatternMatcher mPattern;

        public PatternStringFilter(ValueProvider valueProvider, String attrValue) {
            super(null);
            this.mPattern = new PatternMatcher(attrValue, 2);
        }

        public boolean matchesValue(String value) {
            return value != null && this.mPattern.match(value);
        }
    }

    private static class RegexFilter extends StringFilter {
        private final Pattern mPattern;

        public RegexFilter(ValueProvider valueProvider, String attrValue) {
            super(null);
            this.mPattern = Pattern.compile(attrValue);
        }

        public boolean matchesValue(String value) {
            return value != null && this.mPattern.matcher(value).matches();
        }
    }

    private static class StartsWithFilter extends StringFilter {
        private final String mFilterValue;

        public StartsWithFilter(ValueProvider valueProvider, String attrValue) {
            super(null);
            this.mFilterValue = attrValue;
        }

        public boolean matchesValue(String value) {
            return value != null && value.startsWith(this.mFilterValue);
        }
    }

    protected abstract boolean matchesValue(String str);

    private StringFilter(ValueProvider valueProvider) {
        this.mValueProvider = valueProvider;
    }

    public static StringFilter readFromXml(ValueProvider valueProvider, XmlPullParser parser) throws IOException, XmlPullParserException {
        StringFilter filter = null;
        for (int i = 0; i < parser.getAttributeCount(); i++) {
            StringFilter newFilter = getFilter(valueProvider, parser, i);
            if (newFilter != null) {
                if (filter != null) {
                    throw new XmlPullParserException("Multiple string filter attributes found");
                }
                filter = newFilter;
            }
        }
        if (filter == null) {
            return new IsNullFilter(valueProvider, false);
        }
        return filter;
    }

    private static StringFilter getFilter(ValueProvider valueProvider, XmlPullParser parser, int attributeIndex) {
        String attributeName = parser.getAttributeName(attributeIndex);
        switch (attributeName.charAt(0)) {
            case HdmiCecKeycode.CEC_KEYCODE_PAUSE_RECORD_FUNCTION /*99*/:
                if (attributeName.equals(ATTR_CONTAINS)) {
                    return new ContainsFilter(valueProvider, parser.getAttributeValue(attributeIndex));
                }
                return null;
            case HdmiCecKeycode.CEC_KEYCODE_MUTE_FUNCTION /*101*/:
                if (attributeName.equals(ATTR_EQUALS)) {
                    return new EqualsFilter(valueProvider, parser.getAttributeValue(attributeIndex));
                }
                return null;
            case HdmiCecKeycode.CEC_KEYCODE_SELECT_AV_INPUT_FUNCTION /*105*/:
                if (attributeName.equals(ATTR_IS_NULL)) {
                    return new IsNullFilter(valueProvider, parser.getAttributeValue(attributeIndex));
                }
                return null;
            case HdmiCecKeycode.UI_BROADCAST_DIGITAL_CABLE /*112*/:
                if (attributeName.equals(ATTR_PATTERN)) {
                    return new PatternStringFilter(valueProvider, parser.getAttributeValue(attributeIndex));
                }
                return null;
            case HdmiCecKeycode.CEC_KEYCODE_F2_RED /*114*/:
                if (attributeName.equals(ATTR_REGEX)) {
                    return new RegexFilter(valueProvider, parser.getAttributeValue(attributeIndex));
                }
                return null;
            case HdmiCecKeycode.CEC_KEYCODE_F3_GREEN /*115*/:
                if (attributeName.equals(ATTR_STARTS_WITH)) {
                    return new StartsWithFilter(valueProvider, parser.getAttributeValue(attributeIndex));
                }
                return null;
            default:
                return null;
        }
    }

    public boolean matches(IntentFirewall ifw, ComponentName resolvedComponent, Intent intent, int callerUid, int callerPid, String resolvedType, int receivingUid) {
        return matchesValue(this.mValueProvider.getValue(resolvedComponent, intent, resolvedType));
    }

    static {
        COMPONENT = new C02641("component");
        COMPONENT_NAME = new C02652("component-name");
        COMPONENT_PACKAGE = new C02663("component-package");
        ACTION = new C02674("action");
        DATA = new C02685(SoundModelContract.KEY_DATA);
        MIME_TYPE = new C02696("mime-type");
        SCHEME = new C02707("scheme");
        SSP = new C02718("scheme-specific-part");
        HOST = new C02729("host");
        PATH = new AnonymousClass10("path");
    }
}
