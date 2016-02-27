package android.nfc.cardemulation;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public final class AidGroup implements Parcelable {
    public static final Creator<AidGroup> CREATOR;
    public static final int MAX_NUM_AIDS = 256;
    static final String TAG = "AidGroup";
    final List<String> aids;
    final String category;
    final String description;

    /* renamed from: android.nfc.cardemulation.AidGroup.1 */
    static class C05701 implements Creator<AidGroup> {
        C05701() {
        }

        public AidGroup createFromParcel(Parcel source) {
            String category = source.readString();
            int listSize = source.readInt();
            List aidList = new ArrayList();
            if (listSize > 0) {
                source.readStringList(aidList);
            }
            return new AidGroup(aidList, category);
        }

        public AidGroup[] newArray(int size) {
            return new AidGroup[size];
        }
    }

    public AidGroup(List<String> aids, String category) {
        if (aids == null || aids.size() == 0) {
            throw new IllegalArgumentException("No AIDS in AID group.");
        } else if (aids.size() > MAX_NUM_AIDS) {
            throw new IllegalArgumentException("Too many AIDs in AID group.");
        } else {
            for (String aid : aids) {
                if (!CardEmulation.isValidAid(aid)) {
                    throw new IllegalArgumentException("AID " + aid + " is not a valid AID.");
                }
            }
            if (isValidCategory(category)) {
                this.category = category;
            } else {
                this.category = CardEmulation.CATEGORY_OTHER;
            }
            this.aids = new ArrayList(aids.size());
            for (String aid2 : aids) {
                this.aids.add(aid2.toUpperCase());
            }
            this.description = null;
        }
    }

    AidGroup(String category, String description) {
        this.aids = new ArrayList();
        this.category = category;
        this.description = description;
    }

    public String getCategory() {
        return this.category;
    }

    public List<String> getAids() {
        return this.aids;
    }

    public String toString() {
        StringBuilder out = new StringBuilder("Category: " + this.category + ", AIDs:");
        for (String aid : this.aids) {
            out.append(aid);
            out.append(", ");
        }
        return out.toString();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(this.category);
        dest.writeInt(this.aids.size());
        if (this.aids.size() > 0) {
            dest.writeStringList(this.aids);
        }
    }

    static {
        CREATOR = new C05701();
    }

    public static AidGroup createFromXml(XmlPullParser parser) throws XmlPullParserException, IOException {
        String category = null;
        List aids = new ArrayList();
        AidGroup group = null;
        boolean inGroup = false;
        int eventType = parser.getEventType();
        int minDepth = parser.getDepth();
        while (eventType != 1 && parser.getDepth() >= minDepth) {
            String tagName = parser.getName();
            if (eventType != 2) {
                if (eventType == 3 && tagName.equals("aid-group") && inGroup && aids.size() > 0) {
                    group = new AidGroup(aids, category);
                    break;
                }
            } else if (tagName.equals("aid")) {
                if (inGroup) {
                    String aid = parser.getAttributeValue(null, "value");
                    if (aid != null) {
                        aids.add(aid.toUpperCase());
                    }
                } else {
                    Log.d(TAG, "Ignoring <aid> tag while not in group");
                }
            } else if (tagName.equals("aid-group")) {
                category = parser.getAttributeValue(null, CardEmulation.EXTRA_CATEGORY);
                if (category == null) {
                    Log.e(TAG, "<aid-group> tag without valid category");
                    return null;
                }
                inGroup = true;
            } else {
                Log.d(TAG, "Ignoring unexpected tag: " + tagName);
            }
            eventType = parser.next();
        }
        return group;
    }

    public void writeAsXml(XmlSerializer out) throws IOException {
        out.startTag(null, "aid-group");
        out.attribute(null, CardEmulation.EXTRA_CATEGORY, this.category);
        for (String aid : this.aids) {
            out.startTag(null, "aid");
            out.attribute(null, "value", aid);
            out.endTag(null, "aid");
        }
        out.endTag(null, "aid-group");
    }

    static boolean isValidCategory(String category) {
        return CardEmulation.CATEGORY_PAYMENT.equals(category) || CardEmulation.CATEGORY_OTHER.equals(category);
    }
}
