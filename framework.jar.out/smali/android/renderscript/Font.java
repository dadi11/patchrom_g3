package android.renderscript;

import android.content.res.AssetManager.AssetInputStream;
import android.content.res.Resources;
import android.os.Environment;
import android.widget.Toast;
import java.io.File;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

public class Font extends BaseObj {
    private static Map<String, FontFamily> sFontFamilyMap;
    private static final String[] sMonoNames;
    private static final String[] sSansNames;
    private static final String[] sSerifNames;

    /* renamed from: android.renderscript.Font.1 */
    static /* synthetic */ class C06581 {
        static final /* synthetic */ int[] $SwitchMap$android$renderscript$Font$Style;

        static {
            $SwitchMap$android$renderscript$Font$Style = new int[Style.values().length];
            try {
                $SwitchMap$android$renderscript$Font$Style[Style.NORMAL.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$android$renderscript$Font$Style[Style.BOLD.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$android$renderscript$Font$Style[Style.ITALIC.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$android$renderscript$Font$Style[Style.BOLD_ITALIC.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
        }
    }

    private static class FontFamily {
        String mBoldFileName;
        String mBoldItalicFileName;
        String mItalicFileName;
        String[] mNames;
        String mNormalFileName;

        private FontFamily() {
        }
    }

    public enum Style {
        NORMAL,
        BOLD,
        ITALIC,
        BOLD_ITALIC
    }

    static {
        sSansNames = new String[]{"sans-serif", "arial", "helvetica", "tahoma", "verdana"};
        sSerifNames = new String[]{"serif", "times", "times new roman", "palatino", "georgia", "baskerville", "goudy", "fantasy", "cursive", "ITC Stone Serif"};
        sMonoNames = new String[]{"monospace", "courier", "courier new", "monaco"};
        initFontFamilyMap();
    }

    private static void addFamilyToMap(FontFamily family) {
        for (Object put : family.mNames) {
            sFontFamilyMap.put(put, family);
        }
    }

    private static void initFontFamilyMap() {
        sFontFamilyMap = new HashMap();
        FontFamily sansFamily = new FontFamily();
        sansFamily.mNames = sSansNames;
        sansFamily.mNormalFileName = "Roboto-Regular.ttf";
        sansFamily.mBoldFileName = "Roboto-Bold.ttf";
        sansFamily.mItalicFileName = "Roboto-Italic.ttf";
        sansFamily.mBoldItalicFileName = "Roboto-BoldItalic.ttf";
        addFamilyToMap(sansFamily);
        FontFamily serifFamily = new FontFamily();
        serifFamily.mNames = sSerifNames;
        serifFamily.mNormalFileName = "NotoSerif-Regular.ttf";
        serifFamily.mBoldFileName = "NotoSerif-Bold.ttf";
        serifFamily.mItalicFileName = "NotoSerif-Italic.ttf";
        serifFamily.mBoldItalicFileName = "NotoSerif-BoldItalic.ttf";
        addFamilyToMap(serifFamily);
        FontFamily monoFamily = new FontFamily();
        monoFamily.mNames = sMonoNames;
        monoFamily.mNormalFileName = "DroidSansMono.ttf";
        monoFamily.mBoldFileName = "DroidSansMono.ttf";
        monoFamily.mItalicFileName = "DroidSansMono.ttf";
        monoFamily.mBoldItalicFileName = "DroidSansMono.ttf";
        addFamilyToMap(monoFamily);
    }

    static String getFontFileName(String familyName, Style style) {
        FontFamily family = (FontFamily) sFontFamilyMap.get(familyName);
        if (family != null) {
            switch (C06581.$SwitchMap$android$renderscript$Font$Style[style.ordinal()]) {
                case Toast.LENGTH_LONG /*1*/:
                    return family.mNormalFileName;
                case Action.MERGE_IGNORE /*2*/:
                    return family.mBoldFileName;
                case SetDrawableParameters.TAG /*3*/:
                    return family.mItalicFileName;
                case ViewGroupAction.TAG /*4*/:
                    return family.mBoldItalicFileName;
            }
        }
        return "DroidSans.ttf";
    }

    Font(long id, RenderScript rs) {
        super(id, rs);
    }

    public static Font createFromFile(RenderScript rs, Resources res, String path, float pointSize) {
        rs.validate();
        long fontId = rs.nFontCreateFromFile(path, pointSize, res.getDisplayMetrics().densityDpi);
        if (fontId != 0) {
            return new Font(fontId, rs);
        }
        throw new RSRuntimeException("Unable to create font from file " + path);
    }

    public static Font createFromFile(RenderScript rs, Resources res, File path, float pointSize) {
        return createFromFile(rs, res, path.getAbsolutePath(), pointSize);
    }

    public static Font createFromAsset(RenderScript rs, Resources res, String path, float pointSize) {
        rs.validate();
        long fontId = rs.nFontCreateFromAsset(res.getAssets(), path, pointSize, res.getDisplayMetrics().densityDpi);
        if (fontId != 0) {
            return new Font(fontId, rs);
        }
        throw new RSRuntimeException("Unable to create font from asset " + path);
    }

    public static Font createFromResource(RenderScript rs, Resources res, int id, float pointSize) {
        String name = "R." + Integer.toString(id);
        rs.validate();
        try {
            InputStream is = res.openRawResource(id);
            int dpi = res.getDisplayMetrics().densityDpi;
            if (is instanceof AssetInputStream) {
                long fontId = rs.nFontCreateFromAssetStream(name, pointSize, dpi, ((AssetInputStream) is).getNativeAsset());
                if (fontId != 0) {
                    return new Font(fontId, rs);
                }
                throw new RSRuntimeException("Unable to create font from resource " + id);
            }
            throw new RSRuntimeException("Unsupported asset stream created");
        } catch (Exception e) {
            throw new RSRuntimeException("Unable to open resource " + id);
        }
    }

    public static Font create(RenderScript rs, Resources res, String familyName, Style fontStyle, float pointSize) {
        return createFromFile(rs, res, Environment.getRootDirectory().getAbsolutePath() + "/fonts/" + getFontFileName(familyName, fontStyle), pointSize);
    }
}
