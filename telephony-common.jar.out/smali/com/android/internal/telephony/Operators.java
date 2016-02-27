package com.android.internal.telephony;

import android.os.Environment;
import android.provider.Telephony.Carriers;
import android.telephony.Rlog;
import android.util.Xml;
import com.android.internal.util.XmlUtils;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

public class Operators {
    private static String stored;
    private static String storedOperators;
    private Map<String, String> unOptOperators;

    public Operators() {
        this.unOptOperators = null;
    }

    private HashMap<String, String> initList() {
        HashMap<String, String> init = new HashMap();
        try {
            FileReader spnReader = new FileReader(new File(Environment.getRootDirectory(), "etc/selective-spn-conf.xml"));
            try {
                XmlPullParser parser = Xml.newPullParser();
                parser.setInput(spnReader);
                XmlUtils.beginDocument(parser, "spnOverrides");
                while (true) {
                    XmlUtils.nextElement(parser);
                    if (!"spnOverride".equals(parser.getName())) {
                        break;
                    }
                    init.put(parser.getAttributeValue(null, Carriers.NUMERIC), parser.getAttributeValue(null, "spn"));
                }
            } catch (XmlPullParserException e) {
                Rlog.w("Operatorcheck", "Exception in spn-conf parser " + e);
            } catch (IOException e2) {
                Rlog.w("Operatorcheck", "Exception in spn-conf parser " + e2);
            }
        } catch (FileNotFoundException e3) {
            Rlog.w("Operatorcheck", "Can not open " + Environment.getRootDirectory() + "/etc/selective-spn-conf.xml");
        }
        return init;
    }

    static {
        stored = null;
        storedOperators = null;
    }

    public static String operatorReplace(String response) {
        if (response == null) {
            return response;
        }
        if (5 != response.length() && response.length() != 6) {
            return response;
        }
        if (storedOperators != null && stored != null && stored.equals(response)) {
            return storedOperators;
        }
        stored = response;
        try {
            String str;
            Integer.parseInt(response);
            Map<String, String> operators = new Operators().initList();
            if (operators.containsKey(response)) {
                str = (String) operators.get(response);
            } else {
                str = response;
            }
            storedOperators = str;
            return storedOperators;
        } catch (NumberFormatException e) {
            storedOperators = response;
            return storedOperators;
        }
    }

    public String unOptimizedOperatorReplace(String response) {
        if (response == null) {
            return response;
        }
        if (5 != response.length() && response.length() != 6) {
            return response;
        }
        try {
            String str;
            Integer.parseInt(response);
            if (this.unOptOperators == null) {
                this.unOptOperators = initList();
            }
            if (this.unOptOperators.containsKey(response)) {
                str = (String) this.unOptOperators.get(response);
            } else {
                str = response;
            }
            return str;
        } catch (NumberFormatException e) {
            return response;
        }
    }
}
