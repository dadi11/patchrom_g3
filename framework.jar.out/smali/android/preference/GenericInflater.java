package android.preference;

import android.content.Context;
import android.util.AttributeSet;
import android.view.InflateException;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.util.HashMap;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

abstract class GenericInflater<T, P extends Parent> {
    private static final Class[] mConstructorSignature;
    private static final HashMap sConstructorMap;
    private final boolean DEBUG;
    private final Object[] mConstructorArgs;
    protected final Context mContext;
    private String mDefaultPackage;
    private Factory<T> mFactory;
    private boolean mFactorySet;

    public interface Factory<T> {
        T onCreateItem(String str, Context context, AttributeSet attributeSet);
    }

    private static class FactoryMerger<T> implements Factory<T> {
        private final Factory<T> mF1;
        private final Factory<T> mF2;

        FactoryMerger(Factory<T> f1, Factory<T> f2) {
            this.mF1 = f1;
            this.mF2 = f2;
        }

        public T onCreateItem(String name, Context context, AttributeSet attrs) {
            T v = this.mF1.onCreateItem(name, context, attrs);
            return v != null ? v : this.mF2.onCreateItem(name, context, attrs);
        }
    }

    public interface Parent<T> {
        void addItemFromInflater(T t);
    }

    public abstract GenericInflater cloneInContext(Context context);

    static {
        mConstructorSignature = new Class[]{Context.class, AttributeSet.class};
        sConstructorMap = new HashMap();
    }

    protected GenericInflater(Context context) {
        this.DEBUG = false;
        this.mConstructorArgs = new Object[2];
        this.mContext = context;
    }

    protected GenericInflater(GenericInflater<T, P> original, Context newContext) {
        this.DEBUG = false;
        this.mConstructorArgs = new Object[2];
        this.mContext = newContext;
        this.mFactory = original.mFactory;
    }

    public void setDefaultPackage(String defaultPackage) {
        this.mDefaultPackage = defaultPackage;
    }

    public String getDefaultPackage() {
        return this.mDefaultPackage;
    }

    public Context getContext() {
        return this.mContext;
    }

    public final Factory<T> getFactory() {
        return this.mFactory;
    }

    public void setFactory(Factory<T> factory) {
        if (this.mFactorySet) {
            throw new IllegalStateException("A factory has already been set on this inflater");
        } else if (factory == null) {
            throw new NullPointerException("Given factory can not be null");
        } else {
            this.mFactorySet = true;
            if (this.mFactory == null) {
                this.mFactory = factory;
            } else {
                this.mFactory = new FactoryMerger(factory, this.mFactory);
            }
        }
    }

    public T inflate(int resource, P root) {
        return inflate(resource, (Parent) root, root != null);
    }

    public T inflate(XmlPullParser parser, P root) {
        return inflate(parser, (Parent) root, root != null);
    }

    public T inflate(int resource, P root, boolean attachToRoot) {
        XmlPullParser parser = getContext().getResources().getXml(resource);
        try {
            T inflate = inflate(parser, (Parent) root, attachToRoot);
            return inflate;
        } finally {
            parser.close();
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public T inflate(org.xmlpull.v1.XmlPullParser r12, P r13, boolean r14) {
        /*
        r11 = this;
        r10 = 2;
        r7 = r11.mConstructorArgs;
        monitor-enter(r7);
        r0 = android.util.Xml.asAttributeSet(r12);	 Catch:{ all -> 0x003a }
        r6 = r11.mConstructorArgs;	 Catch:{ all -> 0x003a }
        r8 = 0;
        r9 = r11.mContext;	 Catch:{ all -> 0x003a }
        r6[r8] = r9;	 Catch:{ all -> 0x003a }
        r3 = r13;
    L_0x0010:
        r4 = r12.next();	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        if (r4 == r10) goto L_0x0019;
    L_0x0016:
        r6 = 1;
        if (r4 != r6) goto L_0x0010;
    L_0x0019:
        if (r4 == r10) goto L_0x003d;
    L_0x001b:
        r6 = new android.view.InflateException;	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        r8 = new java.lang.StringBuilder;	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        r8.<init>();	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        r9 = r12.getPositionDescription();	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        r8 = r8.append(r9);	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        r9 = ": No start tag found!";
        r8 = r8.append(r9);	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        r8 = r8.toString();	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        r6.<init>(r8);	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        throw r6;	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
    L_0x0038:
        r1 = move-exception;
        throw r1;	 Catch:{ all -> 0x003a }
    L_0x003a:
        r6 = move-exception;
        monitor-exit(r7);	 Catch:{ all -> 0x003a }
        throw r6;
    L_0x003d:
        r6 = r12.getName();	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        r5 = r11.createItemFromTag(r12, r6, r0);	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        r5 = (android.preference.GenericInflater.Parent) r5;	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        r3 = r11.onMergeRoots(r13, r14, r5);	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        r11.rInflate(r12, r3, r0);	 Catch:{ InflateException -> 0x0038, XmlPullParserException -> 0x0050, IOException -> 0x005e }
        monitor-exit(r7);	 Catch:{ all -> 0x003a }
        return r3;
    L_0x0050:
        r1 = move-exception;
        r2 = new android.view.InflateException;	 Catch:{ all -> 0x003a }
        r6 = r1.getMessage();	 Catch:{ all -> 0x003a }
        r2.<init>(r6);	 Catch:{ all -> 0x003a }
        r2.initCause(r1);	 Catch:{ all -> 0x003a }
        throw r2;	 Catch:{ all -> 0x003a }
    L_0x005e:
        r1 = move-exception;
        r2 = new android.view.InflateException;	 Catch:{ all -> 0x003a }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x003a }
        r6.<init>();	 Catch:{ all -> 0x003a }
        r8 = r12.getPositionDescription();	 Catch:{ all -> 0x003a }
        r6 = r6.append(r8);	 Catch:{ all -> 0x003a }
        r8 = ": ";
        r6 = r6.append(r8);	 Catch:{ all -> 0x003a }
        r8 = r1.getMessage();	 Catch:{ all -> 0x003a }
        r6 = r6.append(r8);	 Catch:{ all -> 0x003a }
        r6 = r6.toString();	 Catch:{ all -> 0x003a }
        r2.<init>(r6);	 Catch:{ all -> 0x003a }
        r2.initCause(r1);	 Catch:{ all -> 0x003a }
        throw r2;	 Catch:{ all -> 0x003a }
        */
        throw new UnsupportedOperationException("Method not decompiled: android.preference.GenericInflater.inflate(org.xmlpull.v1.XmlPullParser, android.preference.GenericInflater$Parent, boolean):T");
    }

    public final T createItem(String name, String prefix, AttributeSet attrs) throws ClassNotFoundException, InflateException {
        Constructor constructor = (Constructor) sConstructorMap.get(name);
        if (constructor == null) {
            try {
                String str;
                ClassLoader classLoader = this.mContext.getClassLoader();
                if (prefix != null) {
                    str = prefix + name;
                } else {
                    str = name;
                }
                constructor = classLoader.loadClass(str).getConstructor(mConstructorSignature);
                sConstructorMap.put(name, constructor);
            } catch (NoSuchMethodException e) {
                StringBuilder append = new StringBuilder().append(attrs.getPositionDescription()).append(": Error inflating class ");
                if (prefix != null) {
                    name = prefix + name;
                }
                InflateException ie = new InflateException(append.append(name).toString());
                ie.initCause(e);
                throw ie;
            } catch (ClassNotFoundException e2) {
                throw e2;
            } catch (Exception e3) {
                ie = new InflateException(attrs.getPositionDescription() + ": Error inflating class " + constructor.getClass().getName());
                ie.initCause(e3);
                throw ie;
            }
        }
        Object[] args = this.mConstructorArgs;
        args[1] = attrs;
        return constructor.newInstance(args);
    }

    protected T onCreateItem(String name, AttributeSet attrs) throws ClassNotFoundException {
        return createItem(name, this.mDefaultPackage, attrs);
    }

    private final T createItemFromTag(XmlPullParser parser, String name, AttributeSet attrs) {
        InflateException ie;
        T item = null;
        try {
            if (this.mFactory != null) {
                item = this.mFactory.onCreateItem(name, this.mContext, attrs);
            }
            if (item != null) {
                return item;
            }
            if (-1 == name.indexOf(46)) {
                return onCreateItem(name, attrs);
            }
            return createItem(name, null, attrs);
        } catch (InflateException e) {
            throw e;
        } catch (ClassNotFoundException e2) {
            ie = new InflateException(attrs.getPositionDescription() + ": Error inflating class " + name);
            ie.initCause(e2);
            throw ie;
        } catch (Exception e3) {
            ie = new InflateException(attrs.getPositionDescription() + ": Error inflating class " + name);
            ie.initCause(e3);
            throw ie;
        }
    }

    private void rInflate(XmlPullParser parser, T parent, AttributeSet attrs) throws XmlPullParserException, IOException {
        int depth = parser.getDepth();
        while (true) {
            int type = parser.next();
            if ((type == 3 && parser.getDepth() <= depth) || type == 1) {
                return;
            }
            if (type == 2 && !onCreateCustomFromTag(parser, parent, attrs)) {
                T item = createItemFromTag(parser, parser.getName(), attrs);
                ((Parent) parent).addItemFromInflater(item);
                rInflate(parser, item, attrs);
            }
        }
    }

    protected boolean onCreateCustomFromTag(XmlPullParser parser, T t, AttributeSet attrs) throws XmlPullParserException {
        return false;
    }

    protected P onMergeRoots(P p, boolean attachToGivenRoot, P xmlRoot) {
        return xmlRoot;
    }
}
