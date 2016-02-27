package android.inputmethodservice;

import android.content.Context;
import android.util.AttributeSet;
import android.view.ActionMode;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import com.android.internal.view.menu.MenuBuilder;
import com.android.internal.view.menu.MenuBuilder.Callback;
import com.android.internal.view.menu.MenuPopupHelper;

public class ExtractEditLayout extends LinearLayout {
    ExtractActionMode mActionMode;
    Button mEditButton;
    Button mExtractActionButton;

    /* renamed from: android.inputmethodservice.ExtractEditLayout.1 */
    class C03211 implements OnClickListener {
        C03211() {
        }

        public void onClick(View clicked) {
            if (ExtractEditLayout.this.mActionMode != null) {
                new MenuPopupHelper(ExtractEditLayout.this.getContext(), ExtractEditLayout.this.mActionMode.mMenu, clicked).show();
            }
        }
    }

    private class ExtractActionMode extends ActionMode implements Callback {
        private ActionMode.Callback mCallback;
        MenuBuilder mMenu;

        public ExtractActionMode(ActionMode.Callback cb) {
            this.mMenu = new MenuBuilder(ExtractEditLayout.this.getContext());
            this.mMenu.setCallback(this);
            this.mCallback = cb;
        }

        public void setTitle(CharSequence title) {
        }

        public void setTitle(int resId) {
        }

        public void setSubtitle(CharSequence subtitle) {
        }

        public void setSubtitle(int resId) {
        }

        public boolean isTitleOptional() {
            return true;
        }

        public void setCustomView(View view) {
        }

        public void invalidate() {
            this.mMenu.stopDispatchingItemsChanged();
            try {
                this.mCallback.onPrepareActionMode(this, this.mMenu);
            } finally {
                this.mMenu.startDispatchingItemsChanged();
            }
        }

        public boolean dispatchOnCreate() {
            this.mMenu.stopDispatchingItemsChanged();
            try {
                boolean onCreateActionMode = this.mCallback.onCreateActionMode(this, this.mMenu);
                return onCreateActionMode;
            } finally {
                this.mMenu.startDispatchingItemsChanged();
            }
        }

        public void finish() {
            if (ExtractEditLayout.this.mActionMode == this) {
                this.mCallback.onDestroyActionMode(this);
                this.mCallback = null;
                this.mMenu.close();
                ExtractEditLayout.this.mExtractActionButton.setVisibility(0);
                ExtractEditLayout.this.mEditButton.setVisibility(4);
                ExtractEditLayout.this.sendAccessibilityEvent(32);
                ExtractEditLayout.this.mActionMode = null;
            }
        }

        public Menu getMenu() {
            return this.mMenu;
        }

        public CharSequence getTitle() {
            return null;
        }

        public CharSequence getSubtitle() {
            return null;
        }

        public View getCustomView() {
            return null;
        }

        public MenuInflater getMenuInflater() {
            return new MenuInflater(ExtractEditLayout.this.getContext());
        }

        public boolean onMenuItemSelected(MenuBuilder menu, MenuItem item) {
            if (this.mCallback != null) {
                return this.mCallback.onActionItemClicked(this, item);
            }
            return false;
        }

        public void onMenuModeChange(MenuBuilder menu) {
        }
    }

    public ExtractEditLayout(Context context) {
        super(context);
    }

    public ExtractEditLayout(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public ActionMode startActionModeForChild(View sourceView, ActionMode.Callback cb) {
        ExtractActionMode mode = new ExtractActionMode(cb);
        if (!mode.dispatchOnCreate()) {
            return null;
        }
        mode.invalidate();
        this.mExtractActionButton.setVisibility(4);
        this.mEditButton.setVisibility(0);
        this.mActionMode = mode;
        sendAccessibilityEvent(32);
        return mode;
    }

    public boolean isActionModeStarted() {
        return this.mActionMode != null;
    }

    public void finishActionMode() {
        if (this.mActionMode != null) {
            this.mActionMode.finish();
        }
    }

    public void onFinishInflate() {
        super.onFinishInflate();
        this.mExtractActionButton = (Button) findViewById(16909072);
        this.mEditButton = (Button) findViewById(16909073);
        this.mEditButton.setOnClickListener(new C03211());
    }
}
