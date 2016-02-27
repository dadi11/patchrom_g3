package com.android.server.firewall;

import android.content.ComponentName;
import android.content.Intent;
import java.io.IOException;
import java.util.Set;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

class CategoryFilter implements Filter {
    private static final String ATTR_NAME = "name";
    public static final FilterFactory FACTORY;
    private final String mCategoryName;

    /* renamed from: com.android.server.firewall.CategoryFilter.1 */
    static class C02521 extends FilterFactory {
        C02521(String x0) {
            super(x0);
        }

        public Filter newFilter(XmlPullParser parser) throws IOException, XmlPullParserException {
            String categoryName = parser.getAttributeValue(null, CategoryFilter.ATTR_NAME);
            if (categoryName != null) {
                return new CategoryFilter(null);
            }
            throw new XmlPullParserException("Category name must be specified.", parser, null);
        }
    }

    private CategoryFilter(String categoryName) {
        this.mCategoryName = categoryName;
    }

    public boolean matches(IntentFirewall ifw, ComponentName resolvedComponent, Intent intent, int callerUid, int callerPid, String resolvedType, int receivingUid) {
        Set<String> categories = intent.getCategories();
        if (categories == null) {
            return false;
        }
        return categories.contains(this.mCategoryName);
    }

    static {
        FACTORY = new C02521("category");
    }
}
