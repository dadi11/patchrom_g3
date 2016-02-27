package android.test;

import android.app.Activity;
import android.app.Instrumentation;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.inputmethod.EditorInfo;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import junit.framework.TestCase;

public class InstrumentationTestCase extends TestCase {
    private Instrumentation mInstrumentation;

    /* renamed from: android.test.InstrumentationTestCase.1 */
    class C07941 implements Runnable {
        final /* synthetic */ Throwable[] val$exceptions;
        final /* synthetic */ Runnable val$r;

        C07941(Runnable runnable, Throwable[] thArr) {
            this.val$r = runnable;
            this.val$exceptions = thArr;
        }

        public void run() {
            try {
                this.val$r.run();
            } catch (Throwable throwable) {
                this.val$exceptions[0] = throwable;
            }
        }
    }

    /* renamed from: android.test.InstrumentationTestCase.2 */
    class C07952 implements Runnable {
        final /* synthetic */ Throwable[] val$exceptions;
        final /* synthetic */ boolean val$repetitive;
        final /* synthetic */ Method val$testMethod;
        final /* synthetic */ int val$tolerance;

        C07952(Method method, int i, boolean z, Throwable[] thArr) {
            this.val$testMethod = method;
            this.val$tolerance = i;
            this.val$repetitive = z;
            this.val$exceptions = thArr;
        }

        public void run() {
            try {
                InstrumentationTestCase.this.runMethod(this.val$testMethod, this.val$tolerance, this.val$repetitive);
            } catch (Throwable throwable) {
                this.val$exceptions[0] = throwable;
            }
        }
    }

    public void injectInstrumentation(Instrumentation instrumentation) {
        this.mInstrumentation = instrumentation;
    }

    @Deprecated
    public void injectInsrumentation(Instrumentation instrumentation) {
        injectInstrumentation(instrumentation);
    }

    public Instrumentation getInstrumentation() {
        return this.mInstrumentation;
    }

    public final <T extends Activity> T launchActivity(String pkg, Class<T> activityCls, Bundle extras) {
        Intent intent = new Intent(Intent.ACTION_MAIN);
        if (extras != null) {
            intent.putExtras(extras);
        }
        return launchActivityWithIntent(pkg, activityCls, intent);
    }

    public final <T extends Activity> T launchActivityWithIntent(String pkg, Class<T> activityCls, Intent intent) {
        intent.setClassName(pkg, activityCls.getName());
        intent.addFlags(EditorInfo.IME_FLAG_NO_EXTRACT_UI);
        T activity = getInstrumentation().startActivitySync(intent);
        getInstrumentation().waitForIdleSync();
        return activity;
    }

    public void runTestOnUiThread(Runnable r) throws Throwable {
        Throwable[] exceptions = new Throwable[1];
        getInstrumentation().runOnMainSync(new C07941(r, exceptions));
        if (exceptions[0] != null) {
            throw exceptions[0];
        }
    }

    protected void runTest() throws Throwable {
        String fName = getName();
        assertNotNull(fName);
        Method method = null;
        try {
            method = getClass().getMethod(fName, (Class[]) null);
        } catch (NoSuchMethodException e) {
            fail("Method \"" + fName + "\" not found");
        }
        if (!Modifier.isPublic(method.getModifiers())) {
            fail("Method \"" + fName + "\" should be public");
        }
        int runCount = 1;
        boolean isRepetitive = false;
        if (method.isAnnotationPresent(FlakyTest.class)) {
            runCount = ((FlakyTest) method.getAnnotation(FlakyTest.class)).tolerance();
        } else if (method.isAnnotationPresent(RepetitiveTest.class)) {
            runCount = ((RepetitiveTest) method.getAnnotation(RepetitiveTest.class)).numIterations();
            isRepetitive = true;
        }
        if (method.isAnnotationPresent(UiThreadTest.class)) {
            Method testMethod = method;
            Throwable[] exceptions = new Throwable[1];
            getInstrumentation().runOnMainSync(new C07952(testMethod, runCount, isRepetitive, exceptions));
            if (exceptions[0] != null) {
                throw exceptions[0];
            }
            return;
        }
        runMethod(method, runCount, isRepetitive);
    }

    private void runMethod(Method runMethod, int tolerance) throws Throwable {
        runMethod(runMethod, tolerance, false);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void runMethod(java.lang.reflect.Method r8, int r9, boolean r10) throws java.lang.Throwable {
        /*
        r7 = this;
        r6 = 2;
        r1 = 0;
        r3 = 0;
    L_0x0003:
        r4 = 0;
        r4 = (java.lang.Object[]) r4;	 Catch:{ InvocationTargetException -> 0x0028, IllegalAccessException -> 0x0046 }
        r8.invoke(r7, r4);	 Catch:{ InvocationTargetException -> 0x0028, IllegalAccessException -> 0x0046 }
        r1 = 0;
        r3 = r3 + 1;
        if (r10 == 0) goto L_0x001f;
    L_0x000e:
        r2 = new android.os.Bundle;
        r2.<init>();
        r4 = "currentiterations";
        r2.putInt(r4, r3);
        r4 = r7.getInstrumentation();
        r4.sendStatus(r6, r2);
    L_0x001f:
        if (r3 >= r9) goto L_0x0025;
    L_0x0021:
        if (r10 != 0) goto L_0x0003;
    L_0x0023:
        if (r1 != 0) goto L_0x0003;
    L_0x0025:
        if (r1 == 0) goto L_0x0078;
    L_0x0027:
        throw r1;
    L_0x0028:
        r0 = move-exception;
        r0.fillInStackTrace();	 Catch:{ all -> 0x0061 }
        r1 = r0.getTargetException();	 Catch:{ all -> 0x0061 }
        r3 = r3 + 1;
        if (r10 == 0) goto L_0x001f;
    L_0x0034:
        r2 = new android.os.Bundle;
        r2.<init>();
        r4 = "currentiterations";
        r2.putInt(r4, r3);
        r4 = r7.getInstrumentation();
        r4.sendStatus(r6, r2);
        goto L_0x001f;
    L_0x0046:
        r0 = move-exception;
        r0.fillInStackTrace();	 Catch:{ all -> 0x0061 }
        r1 = r0;
        r3 = r3 + 1;
        if (r10 == 0) goto L_0x001f;
    L_0x004f:
        r2 = new android.os.Bundle;
        r2.<init>();
        r4 = "currentiterations";
        r2.putInt(r4, r3);
        r4 = r7.getInstrumentation();
        r4.sendStatus(r6, r2);
        goto L_0x001f;
    L_0x0061:
        r4 = move-exception;
        r3 = r3 + 1;
        if (r10 == 0) goto L_0x0077;
    L_0x0066:
        r2 = new android.os.Bundle;
        r2.<init>();
        r5 = "currentiterations";
        r2.putInt(r5, r3);
        r5 = r7.getInstrumentation();
        r5.sendStatus(r6, r2);
    L_0x0077:
        throw r4;
    L_0x0078:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.test.InstrumentationTestCase.runMethod(java.lang.reflect.Method, int, boolean):void");
    }

    public void sendKeys(String keysSequence) {
        Instrumentation instrumentation = getInstrumentation();
        for (String key : keysSequence.split(" ")) {
            String key2;
            int keyCount;
            int repeater = key2.indexOf(42);
            if (repeater == -1) {
                keyCount = 1;
            } else {
                try {
                    keyCount = Integer.parseInt(key2.substring(0, repeater));
                } catch (NumberFormatException e) {
                    Log.w("ActivityTestCase", "Invalid repeat count: " + key2);
                }
            }
            if (repeater != -1) {
                key2 = key2.substring(repeater + 1);
            }
            int j = 0;
            while (j < keyCount) {
                try {
                    try {
                        instrumentation.sendKeyDownUpSync(KeyEvent.class.getField("KEYCODE_" + key2).getInt(null));
                    } catch (SecurityException e2) {
                    }
                    j++;
                } catch (NoSuchFieldException e3) {
                    Log.w("ActivityTestCase", "Unknown keycode: KEYCODE_" + key2);
                } catch (IllegalAccessException e4) {
                    Log.w("ActivityTestCase", "Unknown keycode: KEYCODE_" + key2);
                }
            }
        }
        instrumentation.waitForIdleSync();
    }

    public void sendKeys(int... keys) {
        Instrumentation instrumentation = getInstrumentation();
        for (int sendKeyDownUpSync : keys) {
            try {
                instrumentation.sendKeyDownUpSync(sendKeyDownUpSync);
            } catch (SecurityException e) {
            }
        }
        instrumentation.waitForIdleSync();
    }

    public void sendRepeatedKeys(int... keys) {
        int count = keys.length;
        if ((count & 1) == 1) {
            throw new IllegalArgumentException("The size of the keys array must be a multiple of 2");
        }
        Instrumentation instrumentation = getInstrumentation();
        for (int i = 0; i < count; i += 2) {
            int keyCount = keys[i];
            int keyCode = keys[i + 1];
            for (int j = 0; j < keyCount; j++) {
                try {
                    instrumentation.sendKeyDownUpSync(keyCode);
                } catch (SecurityException e) {
                }
            }
        }
        instrumentation.waitForIdleSync();
    }

    protected void tearDown() throws Exception {
        Runtime.getRuntime().gc();
        Runtime.getRuntime().runFinalization();
        Runtime.getRuntime().gc();
        super.tearDown();
    }
}
