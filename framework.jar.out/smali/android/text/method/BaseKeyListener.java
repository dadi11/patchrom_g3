package android.text.method;

import android.text.Editable;
import android.text.Layout;
import android.text.NoCopySpan.Concrete;
import android.text.Selection;
import android.text.Spannable;
import android.text.TextUtils;
import android.text.method.TextKeyListener.Capitalize;
import android.view.KeyEvent;
import android.view.View;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.TextView;
import android.widget.Toast;

public abstract class BaseKeyListener extends MetaKeyKeyListener implements KeyListener {
    static final Object OLD_SEL_START;

    /* renamed from: android.text.method.BaseKeyListener.1 */
    static /* synthetic */ class C08021 {
        static final /* synthetic */ int[] $SwitchMap$android$text$method$TextKeyListener$Capitalize;

        static {
            $SwitchMap$android$text$method$TextKeyListener$Capitalize = new int[Capitalize.values().length];
            try {
                $SwitchMap$android$text$method$TextKeyListener$Capitalize[Capitalize.CHARACTERS.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$android$text$method$TextKeyListener$Capitalize[Capitalize.WORDS.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$android$text$method$TextKeyListener$Capitalize[Capitalize.SENTENCES.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
        }
    }

    static {
        OLD_SEL_START = new Concrete();
    }

    public boolean backspace(View view, Editable content, int keyCode, KeyEvent event) {
        return backspaceOrForwardDelete(view, content, keyCode, event, false);
    }

    public boolean forwardDelete(View view, Editable content, int keyCode, KeyEvent event) {
        return backspaceOrForwardDelete(view, content, keyCode, event, true);
    }

    private boolean backspaceOrForwardDelete(View view, Editable content, int keyCode, KeyEvent event, boolean isForwardDelete) {
        if (!KeyEvent.metaStateHasNoModifiers(event.getMetaState() & -244)) {
            return false;
        }
        if (deleteSelection(view, content)) {
            return true;
        }
        if (MetaKeyKeyListener.getMetaState(content, 2, event) == 1 && deleteLine(view, content)) {
            return true;
        }
        int end;
        int start = Selection.getSelectionEnd(content);
        if (isForwardDelete || event.isShiftPressed() || MetaKeyKeyListener.getMetaState((CharSequence) content, 1) == 1) {
            end = TextUtils.getOffsetAfter(content, start);
        } else {
            end = TextUtils.getOffsetBefore(content, start);
        }
        if (start == end) {
            return false;
        }
        content.delete(Math.min(start, end), Math.max(start, end));
        return true;
    }

    private boolean deleteSelection(View view, Editable content) {
        int selectionStart = Selection.getSelectionStart(content);
        int selectionEnd = Selection.getSelectionEnd(content);
        if (selectionEnd < selectionStart) {
            int temp = selectionEnd;
            selectionEnd = selectionStart;
            selectionStart = temp;
        }
        if (selectionStart == selectionEnd) {
            return false;
        }
        content.delete(selectionStart, selectionEnd);
        return true;
    }

    private boolean deleteLine(View view, Editable content) {
        if (view instanceof TextView) {
            Layout layout = ((TextView) view).getLayout();
            if (layout != null) {
                int line = layout.getLineForOffset(Selection.getSelectionStart(content));
                int start = layout.getLineStart(line);
                int end = layout.getLineEnd(line);
                if (end != start) {
                    content.delete(start, end);
                    return true;
                }
            }
        }
        return false;
    }

    static int makeTextContentType(Capitalize caps, boolean autoText) {
        int contentType = 1;
        switch (C08021.$SwitchMap$android$text$method$TextKeyListener$Capitalize[caps.ordinal()]) {
            case Toast.LENGTH_LONG /*1*/:
                contentType = 1 | AccessibilityNodeInfo.ACTION_SCROLL_FORWARD;
                break;
            case Action.MERGE_IGNORE /*2*/:
                contentType = 1 | AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD;
                break;
            case SetDrawableParameters.TAG /*3*/:
                contentType = 1 | AccessibilityNodeInfo.ACTION_COPY;
                break;
        }
        if (autoText) {
            return contentType | AccessibilityNodeInfo.ACTION_PASTE;
        }
        return contentType;
    }

    public boolean onKeyDown(View view, Editable content, int keyCode, KeyEvent event) {
        boolean handled;
        switch (keyCode) {
            case KeyEvent.KEYCODE_DEL /*67*/:
                handled = backspace(view, content, keyCode, event);
                break;
            case KeyEvent.KEYCODE_FORWARD_DEL /*112*/:
                handled = forwardDelete(view, content, keyCode, event);
                break;
            default:
                handled = false;
                break;
        }
        if (handled) {
            MetaKeyKeyListener.adjustMetaAfterKeypress((Spannable) content);
        }
        return super.onKeyDown(view, content, keyCode, event);
    }

    public boolean onKeyOther(View view, Editable content, KeyEvent event) {
        if (event.getAction() != 2 || event.getKeyCode() != 0) {
            return false;
        }
        int selectionStart = Selection.getSelectionStart(content);
        int selectionEnd = Selection.getSelectionEnd(content);
        if (selectionEnd < selectionStart) {
            int temp = selectionEnd;
            selectionEnd = selectionStart;
            selectionStart = temp;
        }
        CharSequence text = event.getCharacters();
        if (text == null) {
            return false;
        }
        content.replace(selectionStart, selectionEnd, text);
        return true;
    }
}
