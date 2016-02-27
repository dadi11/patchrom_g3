package android.view;

import android.app.Activity;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.util.AttributeSet;
import android.util.Log;
import android.util.Xml;
import android.view.MenuItem.OnMenuItemClickListener;
import android.widget.AppSecurityPermissions;
import android.widget.Toast;
import com.android.internal.R;
import com.android.internal.view.menu.MenuItemImpl;
import java.io.IOException;
import java.lang.reflect.Method;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

public class MenuInflater {
    private static final Class<?>[] ACTION_PROVIDER_CONSTRUCTOR_SIGNATURE;
    private static final Class<?>[] ACTION_VIEW_CONSTRUCTOR_SIGNATURE;
    private static final String LOG_TAG = "MenuInflater";
    private static final int NO_ID = 0;
    private static final String XML_GROUP = "group";
    private static final String XML_ITEM = "item";
    private static final String XML_MENU = "menu";
    private final Object[] mActionProviderConstructorArguments;
    private final Object[] mActionViewConstructorArguments;
    private Context mContext;
    private Object mRealOwner;

    private static class InflatedOnMenuItemClickListener implements OnMenuItemClickListener {
        private static final Class<?>[] PARAM_TYPES;
        private Method mMethod;
        private Object mRealOwner;

        static {
            PARAM_TYPES = new Class[]{MenuItem.class};
        }

        public InflatedOnMenuItemClickListener(Object realOwner, String methodName) {
            this.mRealOwner = realOwner;
            Class<?> c = realOwner.getClass();
            try {
                this.mMethod = c.getMethod(methodName, PARAM_TYPES);
            } catch (Exception e) {
                InflateException ex = new InflateException("Couldn't resolve menu item onClick handler " + methodName + " in class " + c.getName());
                ex.initCause(e);
                throw ex;
            }
        }

        public boolean onMenuItemClick(MenuItem item) {
            try {
                if (this.mMethod.getReturnType() == Boolean.TYPE) {
                    return ((Boolean) this.mMethod.invoke(this.mRealOwner, new Object[]{item})).booleanValue();
                }
                this.mMethod.invoke(this.mRealOwner, new Object[]{item});
                return true;
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }

    private class MenuState {
        private static final int defaultGroupId = 0;
        private static final int defaultItemCategory = 0;
        private static final int defaultItemCheckable = 0;
        private static final boolean defaultItemChecked = false;
        private static final boolean defaultItemEnabled = true;
        private static final int defaultItemId = 0;
        private static final int defaultItemOrder = 0;
        private static final boolean defaultItemVisible = true;
        private int groupCategory;
        private int groupCheckable;
        private boolean groupEnabled;
        private int groupId;
        private int groupOrder;
        private boolean groupVisible;
        private ActionProvider itemActionProvider;
        private String itemActionProviderClassName;
        private String itemActionViewClassName;
        private int itemActionViewLayout;
        private boolean itemAdded;
        private char itemAlphabeticShortcut;
        private int itemCategoryOrder;
        private int itemCheckable;
        private boolean itemChecked;
        private boolean itemEnabled;
        private int itemIconResId;
        private int itemId;
        private String itemListenerMethodName;
        private char itemNumericShortcut;
        private int itemShowAsAction;
        private CharSequence itemTitle;
        private CharSequence itemTitleCondensed;
        private boolean itemVisible;
        private Menu menu;

        public MenuState(Menu menu) {
            this.menu = menu;
            resetGroup();
        }

        public void resetGroup() {
            this.groupId = defaultItemOrder;
            this.groupCategory = defaultItemOrder;
            this.groupOrder = defaultItemOrder;
            this.groupCheckable = defaultItemOrder;
            this.groupVisible = defaultItemVisible;
            this.groupEnabled = defaultItemVisible;
        }

        public void readGroup(AttributeSet attrs) {
            TypedArray a = MenuInflater.this.mContext.obtainStyledAttributes(attrs, R.styleable.MenuGroup);
            this.groupId = a.getResourceId(1, defaultItemOrder);
            this.groupCategory = a.getInt(3, defaultItemOrder);
            this.groupOrder = a.getInt(4, defaultItemOrder);
            this.groupCheckable = a.getInt(5, defaultItemOrder);
            this.groupVisible = a.getBoolean(2, defaultItemVisible);
            this.groupEnabled = a.getBoolean(defaultItemOrder, defaultItemVisible);
            a.recycle();
        }

        public void readItem(AttributeSet attrs) {
            TypedArray a = MenuInflater.this.mContext.obtainStyledAttributes(attrs, R.styleable.MenuItem);
            this.itemId = a.getResourceId(2, defaultItemOrder);
            this.itemCategoryOrder = (Menu.CATEGORY_MASK & a.getInt(5, this.groupCategory)) | (AppSecurityPermissions.WHICH_ALL & a.getInt(6, this.groupOrder));
            this.itemTitle = a.getText(7);
            this.itemTitleCondensed = a.getText(8);
            this.itemIconResId = a.getResourceId(defaultItemOrder, defaultItemOrder);
            this.itemAlphabeticShortcut = getShortcut(a.getString(9));
            this.itemNumericShortcut = getShortcut(a.getString(10));
            if (a.hasValue(11)) {
                int i;
                if (a.getBoolean(11, defaultItemChecked)) {
                    i = 1;
                } else {
                    i = defaultItemOrder;
                }
                this.itemCheckable = i;
            } else {
                this.itemCheckable = this.groupCheckable;
            }
            this.itemChecked = a.getBoolean(3, defaultItemChecked);
            this.itemVisible = a.getBoolean(4, this.groupVisible);
            this.itemEnabled = a.getBoolean(1, this.groupEnabled);
            this.itemShowAsAction = a.getInt(13, -1);
            this.itemListenerMethodName = a.getString(12);
            this.itemActionViewLayout = a.getResourceId(14, defaultItemOrder);
            this.itemActionViewClassName = a.getString(15);
            this.itemActionProviderClassName = a.getString(16);
            boolean hasActionProvider = this.itemActionProviderClassName != null ? defaultItemVisible : defaultItemChecked;
            if (hasActionProvider && this.itemActionViewLayout == 0 && this.itemActionViewClassName == null) {
                this.itemActionProvider = (ActionProvider) newInstance(this.itemActionProviderClassName, MenuInflater.ACTION_PROVIDER_CONSTRUCTOR_SIGNATURE, MenuInflater.this.mActionProviderConstructorArguments);
            } else {
                if (hasActionProvider) {
                    Log.w(MenuInflater.LOG_TAG, "Ignoring attribute 'actionProviderClass'. Action view already specified.");
                }
                this.itemActionProvider = null;
            }
            a.recycle();
            this.itemAdded = defaultItemChecked;
        }

        private char getShortcut(String shortcutString) {
            if (shortcutString == null) {
                return '\u0000';
            }
            return shortcutString.charAt(defaultItemOrder);
        }

        private void setItem(MenuItem item) {
            item.setChecked(this.itemChecked).setVisible(this.itemVisible).setEnabled(this.itemEnabled).setCheckable(this.itemCheckable >= 1 ? defaultItemVisible : defaultItemChecked).setTitleCondensed(this.itemTitleCondensed).setIcon(this.itemIconResId).setAlphabeticShortcut(this.itemAlphabeticShortcut).setNumericShortcut(this.itemNumericShortcut);
            if (this.itemShowAsAction >= 0) {
                item.setShowAsAction(this.itemShowAsAction);
            }
            if (this.itemListenerMethodName != null) {
                if (MenuInflater.this.mContext.isRestricted()) {
                    throw new IllegalStateException("The android:onClick attribute cannot be used within a restricted context");
                }
                item.setOnMenuItemClickListener(new InflatedOnMenuItemClickListener(MenuInflater.this.getRealOwner(), this.itemListenerMethodName));
            }
            if (item instanceof MenuItemImpl) {
                MenuItemImpl impl = (MenuItemImpl) item;
                if (this.itemCheckable >= 2) {
                    impl.setExclusiveCheckable(defaultItemVisible);
                }
            }
            boolean actionViewSpecified = defaultItemChecked;
            if (this.itemActionViewClassName != null) {
                item.setActionView((View) newInstance(this.itemActionViewClassName, MenuInflater.ACTION_VIEW_CONSTRUCTOR_SIGNATURE, MenuInflater.this.mActionViewConstructorArguments));
                actionViewSpecified = defaultItemVisible;
            }
            if (this.itemActionViewLayout > 0) {
                if (actionViewSpecified) {
                    Log.w(MenuInflater.LOG_TAG, "Ignoring attribute 'itemActionViewLayout'. Action view already specified.");
                } else {
                    item.setActionView(this.itemActionViewLayout);
                }
            }
            if (this.itemActionProvider != null) {
                item.setActionProvider(this.itemActionProvider);
            }
        }

        public MenuItem addItem() {
            this.itemAdded = defaultItemVisible;
            MenuItem item = this.menu.add(this.groupId, this.itemId, this.itemCategoryOrder, this.itemTitle);
            setItem(item);
            return item;
        }

        public SubMenu addSubMenuItem() {
            this.itemAdded = defaultItemVisible;
            SubMenu subMenu = this.menu.addSubMenu(this.groupId, this.itemId, this.itemCategoryOrder, this.itemTitle);
            setItem(subMenu.getItem());
            return subMenu;
        }

        public boolean hasAddedItem() {
            return this.itemAdded;
        }

        private <T> T newInstance(String className, Class<?>[] constructorSignature, Object[] arguments) {
            try {
                return MenuInflater.this.mContext.getClassLoader().loadClass(className).getConstructor(constructorSignature).newInstance(arguments);
            } catch (Exception e) {
                Log.w(MenuInflater.LOG_TAG, "Cannot instantiate class: " + className, e);
                return null;
            }
        }
    }

    static {
        ACTION_VIEW_CONSTRUCTOR_SIGNATURE = new Class[]{Context.class};
        ACTION_PROVIDER_CONSTRUCTOR_SIGNATURE = ACTION_VIEW_CONSTRUCTOR_SIGNATURE;
    }

    public MenuInflater(Context context) {
        this.mContext = context;
        this.mActionViewConstructorArguments = new Object[]{context};
        this.mActionProviderConstructorArguments = this.mActionViewConstructorArguments;
    }

    public MenuInflater(Context context, Object realOwner) {
        this.mContext = context;
        this.mRealOwner = realOwner;
        this.mActionViewConstructorArguments = new Object[]{context};
        this.mActionProviderConstructorArguments = this.mActionViewConstructorArguments;
    }

    public void inflate(int menuRes, Menu menu) {
        XmlResourceParser parser = null;
        try {
            parser = this.mContext.getResources().getLayout(menuRes);
            parseMenu(parser, Xml.asAttributeSet(parser), menu);
            if (parser != null) {
                parser.close();
            }
        } catch (XmlPullParserException e) {
            throw new InflateException("Error inflating menu XML", e);
        } catch (IOException e2) {
            throw new InflateException("Error inflating menu XML", e2);
        } catch (Throwable th) {
            if (parser != null) {
                parser.close();
            }
        }
    }

    private void parseMenu(XmlPullParser parser, AttributeSet attrs, Menu menu) throws XmlPullParserException, IOException {
        MenuState menuState = new MenuState(menu);
        int eventType = parser.getEventType();
        boolean lookingForEndOfUnknownTag = false;
        String unknownTagName = null;
        while (eventType != 2) {
            eventType = parser.next();
            if (eventType == 1) {
                break;
            }
        }
        String tagName = parser.getName();
        if (tagName.equals(XML_MENU)) {
            eventType = parser.next();
            boolean reachedEndOfMenu = false;
            while (!reachedEndOfMenu) {
                switch (eventType) {
                    case Toast.LENGTH_LONG /*1*/:
                        throw new RuntimeException("Unexpected end of document");
                    case Action.MERGE_IGNORE /*2*/:
                        if (!lookingForEndOfUnknownTag) {
                            tagName = parser.getName();
                            if (!tagName.equals(XML_GROUP)) {
                                if (!tagName.equals(XML_ITEM)) {
                                    if (!tagName.equals(XML_MENU)) {
                                        lookingForEndOfUnknownTag = true;
                                        unknownTagName = tagName;
                                        break;
                                    }
                                    SubMenu subMenu = menuState.addSubMenuItem();
                                    registerMenu(subMenu, attrs);
                                    parseMenu(parser, attrs, subMenu);
                                    break;
                                }
                                menuState.readItem(attrs);
                                break;
                            }
                            menuState.readGroup(attrs);
                            break;
                        }
                        break;
                    case SetDrawableParameters.TAG /*3*/:
                        tagName = parser.getName();
                        if (!lookingForEndOfUnknownTag || !tagName.equals(unknownTagName)) {
                            if (!tagName.equals(XML_GROUP)) {
                                if (!tagName.equals(XML_ITEM)) {
                                    if (!tagName.equals(XML_MENU)) {
                                        break;
                                    }
                                    reachedEndOfMenu = true;
                                    break;
                                } else if (!menuState.hasAddedItem()) {
                                    if (menuState.itemActionProvider != null && menuState.itemActionProvider.hasSubMenu()) {
                                        registerMenu(menuState.addSubMenuItem(), attrs);
                                        break;
                                    } else {
                                        registerMenu(menuState.addItem(), attrs);
                                        break;
                                    }
                                } else {
                                    break;
                                }
                            }
                            menuState.resetGroup();
                            break;
                        }
                        lookingForEndOfUnknownTag = false;
                        unknownTagName = null;
                        break;
                        break;
                    default:
                        break;
                }
                eventType = parser.next();
            }
            return;
        }
        throw new RuntimeException("Expecting menu, got " + tagName);
    }

    private void registerMenu(MenuItem item, AttributeSet set) {
    }

    private void registerMenu(SubMenu subMenu, AttributeSet set) {
    }

    Context getContext() {
        return this.mContext;
    }

    private Object getRealOwner() {
        if (this.mRealOwner == null) {
            this.mRealOwner = findRealOwner(this.mContext);
        }
        return this.mRealOwner;
    }

    private Object findRealOwner(Object owner) {
        if (!(owner instanceof Activity) && (owner instanceof ContextWrapper)) {
            return findRealOwner(((ContextWrapper) owner).getBaseContext());
        }
        return owner;
    }
}
