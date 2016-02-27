package android.media.audiopolicy;

import android.media.AudioAttributes;
import android.os.Parcel;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Objects;

public class AudioMixingRule {
    public static final int RULE_EXCLUDE_ATTRIBUTE_CAPTURE_PRESET = 32770;
    public static final int RULE_EXCLUDE_ATTRIBUTE_USAGE = 32769;
    private static final int RULE_EXCLUSION_MASK = 32768;
    public static final int RULE_MATCH_ATTRIBUTE_CAPTURE_PRESET = 2;
    public static final int RULE_MATCH_ATTRIBUTE_USAGE = 1;
    private final ArrayList<AttributeMatchCriterion> mCriteria;
    private final int mTargetMixType;

    static final class AttributeMatchCriterion {
        AudioAttributes mAttr;
        int mRule;

        AttributeMatchCriterion(AudioAttributes attributes, int rule) {
            this.mAttr = attributes;
            this.mRule = rule;
        }

        public int hashCode() {
            Object[] objArr = new Object[AudioMixingRule.RULE_MATCH_ATTRIBUTE_CAPTURE_PRESET];
            objArr[0] = this.mAttr;
            objArr[AudioMixingRule.RULE_MATCH_ATTRIBUTE_USAGE] = Integer.valueOf(this.mRule);
            return Objects.hash(objArr);
        }

        void writeToParcel(Parcel dest) {
            dest.writeInt(this.mRule);
            if (this.mRule == AudioMixingRule.RULE_MATCH_ATTRIBUTE_USAGE || this.mRule == AudioMixingRule.RULE_EXCLUDE_ATTRIBUTE_USAGE) {
                dest.writeInt(this.mAttr.getUsage());
            } else {
                dest.writeInt(this.mAttr.getCapturePreset());
            }
        }
    }

    public static class Builder {
        private ArrayList<AttributeMatchCriterion> mCriteria;
        private int mTargetMixType;

        public Builder() {
            this.mTargetMixType = -1;
            this.mCriteria = new ArrayList();
        }

        public Builder addRule(AudioAttributes attrToMatch, int rule) throws IllegalArgumentException {
            if (AudioMixingRule.isValidSystemApiRule(rule)) {
                return addRuleInt(attrToMatch, rule);
            }
            throw new IllegalArgumentException("Illegal rule value " + rule);
        }

        public Builder excludeRule(AudioAttributes attrToMatch, int rule) throws IllegalArgumentException {
            if (AudioMixingRule.isValidSystemApiRule(rule)) {
                return addRuleInt(attrToMatch, AudioMixingRule.RULE_EXCLUSION_MASK | rule);
            }
            throw new IllegalArgumentException("Illegal rule value " + rule);
        }

        Builder addRuleInt(AudioAttributes attrToMatch, int rule) throws IllegalArgumentException {
            if (attrToMatch == null) {
                throw new IllegalArgumentException("Illegal null AudioAttributes argument");
            } else if (AudioMixingRule.isValidIntRule(rule)) {
                if (this.mTargetMixType == -1) {
                    if (AudioMixingRule.isPlayerRule(rule)) {
                        this.mTargetMixType = 0;
                    } else {
                        this.mTargetMixType = AudioMixingRule.RULE_MATCH_ATTRIBUTE_USAGE;
                    }
                } else if ((this.mTargetMixType == 0 && !AudioMixingRule.isPlayerRule(rule)) || (this.mTargetMixType == AudioMixingRule.RULE_MATCH_ATTRIBUTE_USAGE && AudioMixingRule.isPlayerRule(rule))) {
                    throw new IllegalArgumentException("Incompatible rule for mix");
                }
                synchronized (this.mCriteria) {
                    Iterator<AttributeMatchCriterion> crIterator = this.mCriteria.iterator();
                    while (crIterator.hasNext()) {
                        AttributeMatchCriterion criterion = (AttributeMatchCriterion) crIterator.next();
                        if (rule == AudioMixingRule.RULE_MATCH_ATTRIBUTE_USAGE || rule == AudioMixingRule.RULE_EXCLUDE_ATTRIBUTE_USAGE) {
                            if (criterion.mAttr.getUsage() == attrToMatch.getUsage()) {
                                if (criterion.mRule == rule) {
                                } else {
                                    throw new IllegalArgumentException("Contradictory rule exists for " + attrToMatch);
                                }
                            }
                        } else if (rule == AudioMixingRule.RULE_MATCH_ATTRIBUTE_CAPTURE_PRESET || rule == AudioMixingRule.RULE_EXCLUDE_ATTRIBUTE_CAPTURE_PRESET) {
                            if (criterion.mAttr.getCapturePreset() == attrToMatch.getCapturePreset()) {
                                if (criterion.mRule == rule) {
                                } else {
                                    throw new IllegalArgumentException("Contradictory rule exists for " + attrToMatch);
                                }
                            }
                        }
                    }
                    this.mCriteria.add(new AttributeMatchCriterion(attrToMatch, rule));
                }
                return this;
            } else {
                throw new IllegalArgumentException("Illegal rule value " + rule);
            }
        }

        Builder addRuleFromParcel(Parcel in) throws IllegalArgumentException {
            AudioAttributes attr;
            int rule = in.readInt();
            if (rule == AudioMixingRule.RULE_MATCH_ATTRIBUTE_USAGE || rule == AudioMixingRule.RULE_EXCLUDE_ATTRIBUTE_USAGE) {
                attr = new android.media.AudioAttributes.Builder().setUsage(in.readInt()).build();
            } else if (rule == AudioMixingRule.RULE_MATCH_ATTRIBUTE_CAPTURE_PRESET || rule == AudioMixingRule.RULE_EXCLUDE_ATTRIBUTE_CAPTURE_PRESET) {
                attr = new android.media.AudioAttributes.Builder().setInternalCapturePreset(in.readInt()).build();
            } else {
                in.readInt();
                throw new IllegalArgumentException("Illegal rule value " + rule + " in parcel");
            }
            return addRuleInt(attr, rule);
        }

        public AudioMixingRule build() {
            return new AudioMixingRule(this.mCriteria, null);
        }
    }

    private AudioMixingRule(int mixType, ArrayList<AttributeMatchCriterion> criteria) {
        this.mCriteria = criteria;
        this.mTargetMixType = mixType;
    }

    int getTargetMixType() {
        return this.mTargetMixType;
    }

    ArrayList<AttributeMatchCriterion> getCriteria() {
        return this.mCriteria;
    }

    public int hashCode() {
        Object[] objArr = new Object[RULE_MATCH_ATTRIBUTE_CAPTURE_PRESET];
        objArr[0] = Integer.valueOf(this.mTargetMixType);
        objArr[RULE_MATCH_ATTRIBUTE_USAGE] = this.mCriteria;
        return Objects.hash(objArr);
    }

    private static boolean isValidSystemApiRule(int rule) {
        switch (rule) {
            case RULE_MATCH_ATTRIBUTE_USAGE /*1*/:
            case RULE_MATCH_ATTRIBUTE_CAPTURE_PRESET /*2*/:
                return true;
            default:
                return false;
        }
    }

    private static boolean isValidIntRule(int rule) {
        switch (rule) {
            case RULE_MATCH_ATTRIBUTE_USAGE /*1*/:
            case RULE_MATCH_ATTRIBUTE_CAPTURE_PRESET /*2*/:
            case RULE_EXCLUDE_ATTRIBUTE_USAGE /*32769*/:
            case RULE_EXCLUDE_ATTRIBUTE_CAPTURE_PRESET /*32770*/:
                return true;
            default:
                return false;
        }
    }

    private static boolean isPlayerRule(int rule) {
        return rule == RULE_MATCH_ATTRIBUTE_USAGE || rule == RULE_EXCLUDE_ATTRIBUTE_USAGE;
    }
}
