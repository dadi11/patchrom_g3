package android.test;

import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.view.inputmethod.EditorInfo;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import junit.framework.TestCase;

public class AndroidTestCase extends TestCase {
    protected Context mContext;
    private Context mTestContext;

    protected void setUp() throws Exception {
        super.setUp();
    }

    protected void tearDown() throws Exception {
        super.tearDown();
    }

    public void testAndroidTestCaseSetupProperly() {
        assertNotNull("Context is null. setContext should be called before tests are run", this.mContext);
    }

    public void setContext(Context context) {
        this.mContext = context;
    }

    public Context getContext() {
        return this.mContext;
    }

    public void setTestContext(Context context) {
        this.mTestContext = context;
    }

    public Context getTestContext() {
        return this.mTestContext;
    }

    public void assertActivityRequiresPermission(String packageName, String className, String permission) {
        Intent intent = new Intent();
        intent.setClassName(packageName, className);
        intent.addFlags(EditorInfo.IME_FLAG_NO_EXTRACT_UI);
        try {
            getContext().startActivity(intent);
            fail("expected security exception for " + permission);
        } catch (SecurityException expected) {
            assertNotNull("security exception's error message.", expected.getMessage());
            assertTrue("error message should contain " + permission + ".", expected.getMessage().contains(permission));
        }
    }

    public void assertReadingContentUriRequiresPermission(Uri uri, String permission) {
        try {
            getContext().getContentResolver().query(uri, null, null, null, null);
            fail("expected SecurityException requiring " + permission);
        } catch (SecurityException expected) {
            assertNotNull("security exception's error message.", expected.getMessage());
            assertTrue("error message should contain " + permission + ".", expected.getMessage().contains(permission));
        }
    }

    public void assertWritingContentUriRequiresPermission(Uri uri, String permission) {
        try {
            getContext().getContentResolver().insert(uri, new ContentValues());
            fail("expected SecurityException requiring " + permission);
        } catch (SecurityException expected) {
            assertNotNull("security exception's error message.", expected.getMessage());
            assertTrue("error message should contain \"" + permission + "\". Got: \"" + expected.getMessage() + "\".", expected.getMessage().contains(permission));
        }
    }

    protected void scrubClass(Class<?> cls) throws IllegalAccessException {
        for (Field field : getClass().getDeclaredFields()) {
            if (!(field.getType().isPrimitive() || Modifier.isStatic(field.getModifiers()))) {
                try {
                    field.setAccessible(true);
                    field.set(this, null);
                } catch (Exception e) {
                    Log.d("TestCase", "Error: Could not nullify field!");
                }
                if (field.get(this) != null) {
                    Log.d("TestCase", "Error: Could not nullify field!");
                }
            }
        }
    }
}
