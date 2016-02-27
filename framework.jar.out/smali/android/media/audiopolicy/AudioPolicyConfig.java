package android.media.audiopolicy;

import android.media.AudioFormat;
import android.media.audiopolicy.AudioMix.Builder;
import android.net.ProxyInfo;
import android.os.BatteryStats.HistoryItem;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;
import android.widget.Toast;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Objects;

public class AudioPolicyConfig implements Parcelable {
    public static final Creator<AudioPolicyConfig> CREATOR;
    private static final String TAG = "AudioPolicyConfig";
    protected int mDuckingPolicy;
    protected ArrayList<AudioMix> mMixes;
    private String mRegistrationId;

    /* renamed from: android.media.audiopolicy.AudioPolicyConfig.1 */
    static class C04141 implements Creator<AudioPolicyConfig> {
        C04141() {
        }

        public AudioPolicyConfig createFromParcel(Parcel p) {
            return new AudioPolicyConfig(null);
        }

        public AudioPolicyConfig[] newArray(int size) {
            return new AudioPolicyConfig[size];
        }
    }

    protected AudioPolicyConfig(AudioPolicyConfig conf) {
        this.mDuckingPolicy = 0;
        this.mRegistrationId = null;
        this.mMixes = conf.mMixes;
    }

    AudioPolicyConfig(ArrayList<AudioMix> mixes) {
        this.mDuckingPolicy = 0;
        this.mRegistrationId = null;
        this.mMixes = mixes;
    }

    public void addMix(AudioMix mix) throws IllegalArgumentException {
        if (mix == null) {
            throw new IllegalArgumentException("Illegal null AudioMix argument");
        }
        this.mMixes.add(mix);
    }

    public int hashCode() {
        return Objects.hash(new Object[]{this.mMixes});
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mMixes.size());
        Iterator it = this.mMixes.iterator();
        while (it.hasNext()) {
            AudioMix mix = (AudioMix) it.next();
            dest.writeInt(mix.getRouteFlags());
            dest.writeInt(mix.getFormat().getSampleRate());
            dest.writeInt(mix.getFormat().getEncoding());
            dest.writeInt(mix.getFormat().getChannelMask());
            ArrayList<AttributeMatchCriterion> criteria = mix.getRule().getCriteria();
            dest.writeInt(criteria.size());
            Iterator i$ = criteria.iterator();
            while (i$.hasNext()) {
                ((AttributeMatchCriterion) i$.next()).writeToParcel(dest);
            }
        }
    }

    private AudioPolicyConfig(Parcel in) {
        this.mDuckingPolicy = 0;
        this.mRegistrationId = null;
        this.mMixes = new ArrayList();
        int nbMixes = in.readInt();
        for (int i = 0; i < nbMixes; i++) {
            Builder mixBuilder = new Builder();
            mixBuilder.setRouteFlags(in.readInt());
            int sampleRate = in.readInt();
            mixBuilder.setFormat(new AudioFormat.Builder().setSampleRate(sampleRate).setChannelMask(in.readInt()).setEncoding(in.readInt()).build());
            int nbRules = in.readInt();
            AudioMixingRule.Builder ruleBuilder = new AudioMixingRule.Builder();
            for (int j = 0; j < nbRules; j++) {
                ruleBuilder.addRuleFromParcel(in);
            }
            mixBuilder.setMixingRule(ruleBuilder.build());
            this.mMixes.add(mixBuilder.build());
        }
    }

    static {
        CREATOR = new C04141();
    }

    public String toLogFriendlyString() {
        String textDump = new String("android.media.audiopolicy.AudioPolicyConfig:\n") + this.mMixes.size() + " AudioMix: " + this.mRegistrationId + "\n";
        Iterator it = this.mMixes.iterator();
        while (it.hasNext()) {
            AudioMix mix = (AudioMix) it.next();
            textDump = ((((textDump + "* route flags=0x" + Integer.toHexString(mix.getRouteFlags()) + "\n") + "  rate=" + mix.getFormat().getSampleRate() + "Hz\n") + "  encoding=" + mix.getFormat().getEncoding() + "\n") + "  channels=0x") + Integer.toHexString(mix.getFormat().getChannelMask()).toUpperCase() + "\n";
            Iterator i$ = mix.getRule().getCriteria().iterator();
            while (i$.hasNext()) {
                AttributeMatchCriterion criterion = (AttributeMatchCriterion) i$.next();
                switch (criterion.mRule) {
                    case Toast.LENGTH_LONG /*1*/:
                        textDump = (textDump + "  match usage ") + criterion.mAttr.usageToString();
                        break;
                    case Action.MERGE_IGNORE /*2*/:
                        textDump = (textDump + "  match capture preset ") + criterion.mAttr.getCapturePreset();
                        break;
                    case HistoryItem.EVENT_PROC_START /*32769*/:
                        textDump = (textDump + "  exclude usage ") + criterion.mAttr.usageToString();
                        break;
                    case HistoryItem.EVENT_FOREGROUND_START /*32770*/:
                        textDump = (textDump + "  exclude capture preset ") + criterion.mAttr.getCapturePreset();
                        break;
                    default:
                        textDump = textDump + "invalid rule!";
                        break;
                }
                textDump = textDump + "\n";
            }
        }
        return textDump;
    }

    protected void setRegistration(String regId) {
        boolean currentRegNull;
        boolean newRegNull = false;
        if (this.mRegistrationId == null || this.mRegistrationId.isEmpty()) {
            currentRegNull = true;
        } else {
            currentRegNull = false;
        }
        if (regId == null || regId.isEmpty()) {
            newRegNull = true;
        }
        if (currentRegNull || newRegNull || this.mRegistrationId.equals(regId)) {
            if (regId == null) {
                regId = ProxyInfo.LOCAL_EXCL_LIST;
            }
            this.mRegistrationId = regId;
            int mixIndex = 0;
            Iterator i$ = this.mMixes.iterator();
            while (i$.hasNext()) {
                AudioMix mix = (AudioMix) i$.next();
                if (this.mRegistrationId.isEmpty()) {
                    mix.setRegistration(ProxyInfo.LOCAL_EXCL_LIST);
                } else {
                    int mixIndex2 = mixIndex + 1;
                    mix.setRegistration(this.mRegistrationId + "mix" + mixTypeId(mix.getMixType()) + ":" + mixIndex);
                    mixIndex = mixIndex2;
                }
            }
            return;
        }
        Log.e(TAG, "Invalid registration transition from " + this.mRegistrationId + " to " + regId);
    }

    private static String mixTypeId(int type) {
        if (type == 0) {
            return TtmlUtils.TAG_P;
        }
        if (type == 1) {
            return "r";
        }
        return "i";
    }

    protected String getRegistration() {
        return this.mRegistrationId;
    }
}
