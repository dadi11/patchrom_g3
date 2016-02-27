package android.service.voice;

import android.app.AppGlobals;
import android.content.ComponentName;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ServiceInfo;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.os.RemoteException;
import android.util.AttributeSet;
import android.util.Log;
import android.util.Xml;
import android.view.accessibility.AccessibilityNodeInfo;
import com.android.internal.R;
import java.io.IOException;
import org.xmlpull.v1.XmlPullParserException;

public class VoiceInteractionServiceInfo {
    static final String TAG = "VoiceInteractionServiceInfo";
    private String mParseError;
    private String mRecognitionService;
    private ServiceInfo mServiceInfo;
    private String mSessionService;
    private String mSettingsActivity;

    public VoiceInteractionServiceInfo(PackageManager pm, ComponentName comp) throws NameNotFoundException {
        this(pm, pm.getServiceInfo(comp, AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS));
    }

    public VoiceInteractionServiceInfo(PackageManager pm, ComponentName comp, int userHandle) throws NameNotFoundException, RemoteException {
        this(pm, AppGlobals.getPackageManager().getServiceInfo(comp, AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS, userHandle));
    }

    public VoiceInteractionServiceInfo(PackageManager pm, ServiceInfo si) {
        if ("android.permission.BIND_VOICE_INTERACTION".equals(si.permission)) {
            XmlResourceParser parser = null;
            try {
                parser = si.loadXmlMetaData(pm, VoiceInteractionService.SERVICE_META_DATA);
                if (parser == null) {
                    this.mParseError = "No android.voice_interaction meta-data for " + si.packageName;
                    if (parser != null) {
                        parser.close();
                        return;
                    }
                    return;
                }
                Resources res = pm.getResourcesForApplication(si.applicationInfo);
                AttributeSet attrs = Xml.asAttributeSet(parser);
                int type;
                do {
                    type = parser.next();
                    if (type == 1) {
                        break;
                    }
                } while (type != 2);
                if ("voice-interaction-service".equals(parser.getName())) {
                    TypedArray array = res.obtainAttributes(attrs, R.styleable.VoiceInteractionService);
                    this.mSessionService = array.getString(1);
                    this.mRecognitionService = array.getString(2);
                    this.mSettingsActivity = array.getString(0);
                    array.recycle();
                    if (this.mSessionService == null) {
                        this.mParseError = "No sessionService specified";
                        if (parser != null) {
                            parser.close();
                            return;
                        }
                        return;
                    }
                    if (parser != null) {
                        parser.close();
                    }
                    this.mServiceInfo = si;
                    return;
                }
                this.mParseError = "Meta-data does not start with voice-interaction-service tag";
                if (parser != null) {
                    parser.close();
                }
            } catch (XmlPullParserException e) {
                this.mParseError = "Error parsing voice interation service meta-data: " + e;
                Log.w(TAG, "error parsing voice interaction service meta-data", e);
                if (parser != null) {
                    parser.close();
                }
            } catch (IOException e2) {
                this.mParseError = "Error parsing voice interation service meta-data: " + e2;
                Log.w(TAG, "error parsing voice interaction service meta-data", e2);
                if (parser != null) {
                    parser.close();
                }
            } catch (NameNotFoundException e3) {
                this.mParseError = "Error parsing voice interation service meta-data: " + e3;
                Log.w(TAG, "error parsing voice interaction service meta-data", e3);
                if (parser != null) {
                    parser.close();
                }
            } catch (Throwable th) {
                if (parser != null) {
                    parser.close();
                }
            }
        } else {
            this.mParseError = "Service does not require permission android.permission.BIND_VOICE_INTERACTION";
        }
    }

    public String getParseError() {
        return this.mParseError;
    }

    public ServiceInfo getServiceInfo() {
        return this.mServiceInfo;
    }

    public String getSessionService() {
        return this.mSessionService;
    }

    public String getRecognitionService() {
        return this.mRecognitionService;
    }

    public String getSettingsActivity() {
        return this.mSettingsActivity;
    }
}
