package com.android.server.am;

import android.app.ActivityManager;
import android.app.ActivityManager.TaskDescription;
import android.app.ActivityManager.TaskThumbnail;
import android.app.ActivityOptions;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.graphics.Bitmap;
import android.os.ParcelFileDescriptor;
import android.os.UserHandle;
import android.service.voice.IVoiceInteractionSession;
import android.util.Slog;
import com.android.internal.app.IVoiceInteractor;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

final class TaskRecord {
    private static final String ATTR_AFFINITY = "affinity";
    private static final String ATTR_ASKEDCOMPATMODE = "asked_compat_mode";
    private static final String ATTR_AUTOREMOVERECENTS = "auto_remove_recents";
    private static final String ATTR_CALLING_PACKAGE = "calling_package";
    private static final String ATTR_CALLING_UID = "calling_uid";
    private static final String ATTR_EFFECTIVE_UID = "effective_uid";
    private static final String ATTR_FIRSTACTIVETIME = "first_active_time";
    private static final String ATTR_LASTACTIVETIME = "last_active_time";
    private static final String ATTR_LASTDESCRIPTION = "last_description";
    private static final String ATTR_LASTTIMEMOVED = "last_time_moved";
    private static final String ATTR_NEVERRELINQUISH = "never_relinquish_identity";
    private static final String ATTR_NEXT_AFFILIATION = "next_affiliation";
    private static final String ATTR_ORIGACTIVITY = "orig_activity";
    private static final String ATTR_PREV_AFFILIATION = "prev_affiliation";
    static final String ATTR_REALACTIVITY = "real_activity";
    private static final String ATTR_ROOTHASRESET = "root_has_reset";
    private static final String ATTR_ROOT_AFFINITY = "root_affinity";
    static final String ATTR_TASKID = "task_id";
    private static final String ATTR_TASKTYPE = "task_type";
    static final String ATTR_TASK_AFFILIATION = "task_affiliation";
    private static final String ATTR_TASK_AFFILIATION_COLOR = "task_affiliation_color";
    private static final String ATTR_USERID = "user_id";
    static final boolean IGNORE_RETURN_TO_RECENTS = true;
    static final int INVALID_TASK_ID = -1;
    static final String TAG_ACTIVITY = "activity";
    private static final String TAG_AFFINITYINTENT = "affinity_intent";
    private static final String TAG_INTENT = "intent";
    private static final String TASK_THUMBNAIL_SUFFIX = "_task_thumbnail";
    String affinity;
    Intent affinityIntent;
    boolean askedCompatMode;
    boolean autoRemoveRecents;
    int creatorUid;
    int effectiveUid;
    long firstActiveTime;
    boolean hasBeenVisible;
    boolean inRecents;
    Intent intent;
    boolean isAvailable;
    boolean isPersistable;
    long lastActiveTime;
    CharSequence lastDescription;
    TaskDescription lastTaskDescription;
    final ArrayList<ActivityRecord> mActivities;
    int mAffiliatedTaskColor;
    int mAffiliatedTaskId;
    String mCallingPackage;
    int mCallingUid;
    private final String mFilename;
    private Bitmap mLastThumbnail;
    private final File mLastThumbnailFile;
    long mLastTimeMoved;
    boolean mNeverRelinquishIdentity;
    TaskRecord mNextAffiliate;
    int mNextAffiliateTaskId;
    TaskRecord mPrevAffiliate;
    int mPrevAffiliateTaskId;
    boolean mReuseTask;
    final ActivityManagerService mService;
    private int mTaskToReturnTo;
    int maxRecents;
    int numFullscreen;
    ComponentName origActivity;
    ComponentName realActivity;
    String rootAffinity;
    boolean rootWasReset;
    ActivityStack stack;
    String stringName;
    final int taskId;
    int taskType;
    int userId;
    final IVoiceInteractor voiceInteractor;
    final IVoiceInteractionSession voiceSession;

    TaskRecord(ActivityManagerService service, int _taskId, ActivityInfo info, Intent _intent, IVoiceInteractionSession _voiceSession, IVoiceInteractor _voiceInteractor) {
        this.lastTaskDescription = new TaskDescription();
        this.isPersistable = false;
        this.mLastTimeMoved = System.currentTimeMillis();
        this.mTaskToReturnTo = 0;
        this.mNeverRelinquishIdentity = IGNORE_RETURN_TO_RECENTS;
        this.mReuseTask = false;
        this.mPrevAffiliateTaskId = INVALID_TASK_ID;
        this.mNextAffiliateTaskId = INVALID_TASK_ID;
        this.mService = service;
        this.mFilename = String.valueOf(_taskId) + TASK_THUMBNAIL_SUFFIX + ".png";
        this.mLastThumbnailFile = new File(TaskPersister.sImagesDir, this.mFilename);
        this.taskId = _taskId;
        this.mAffiliatedTaskId = _taskId;
        this.voiceSession = _voiceSession;
        this.voiceInteractor = _voiceInteractor;
        this.isAvailable = IGNORE_RETURN_TO_RECENTS;
        this.mActivities = new ArrayList();
        setIntent(_intent, info);
    }

    TaskRecord(ActivityManagerService service, int _taskId, ActivityInfo info, Intent _intent, TaskDescription _taskDescription) {
        this.lastTaskDescription = new TaskDescription();
        this.isPersistable = false;
        this.mLastTimeMoved = System.currentTimeMillis();
        this.mTaskToReturnTo = 0;
        this.mNeverRelinquishIdentity = IGNORE_RETURN_TO_RECENTS;
        this.mReuseTask = false;
        this.mPrevAffiliateTaskId = INVALID_TASK_ID;
        this.mNextAffiliateTaskId = INVALID_TASK_ID;
        this.mService = service;
        this.mFilename = String.valueOf(_taskId) + TASK_THUMBNAIL_SUFFIX + ".png";
        this.mLastThumbnailFile = new File(TaskPersister.sImagesDir, this.mFilename);
        this.taskId = _taskId;
        this.mAffiliatedTaskId = _taskId;
        this.voiceSession = null;
        this.voiceInteractor = null;
        this.isAvailable = IGNORE_RETURN_TO_RECENTS;
        this.mActivities = new ArrayList();
        setIntent(_intent, info);
        this.taskType = 0;
        this.isPersistable = IGNORE_RETURN_TO_RECENTS;
        this.mCallingUid = info.applicationInfo.uid;
        this.mCallingPackage = info.packageName;
        this.maxRecents = Math.min(Math.max(info.maxRecents, 1), ActivityManager.getMaxAppRecentsLimitStatic());
        this.taskType = 0;
        this.mTaskToReturnTo = 1;
        this.userId = UserHandle.getUserId(info.applicationInfo.uid);
        this.lastTaskDescription = _taskDescription;
        this.mCallingUid = info.applicationInfo.uid;
        this.mCallingPackage = info.packageName;
    }

    TaskRecord(ActivityManagerService service, int _taskId, Intent _intent, Intent _affinityIntent, String _affinity, String _rootAffinity, ComponentName _realActivity, ComponentName _origActivity, boolean _rootWasReset, boolean _autoRemoveRecents, boolean _askedCompatMode, int _taskType, int _userId, int _effectiveUid, String _lastDescription, ArrayList<ActivityRecord> activities, long _firstActiveTime, long _lastActiveTime, long lastTimeMoved, boolean neverRelinquishIdentity, TaskDescription _lastTaskDescription, int taskAffiliation, int prevTaskId, int nextTaskId, int taskAffiliationColor, int callingUid, String callingPackage) {
        this.lastTaskDescription = new TaskDescription();
        this.isPersistable = false;
        this.mLastTimeMoved = System.currentTimeMillis();
        this.mTaskToReturnTo = 0;
        this.mNeverRelinquishIdentity = IGNORE_RETURN_TO_RECENTS;
        this.mReuseTask = false;
        this.mPrevAffiliateTaskId = INVALID_TASK_ID;
        this.mNextAffiliateTaskId = INVALID_TASK_ID;
        this.mService = service;
        this.mFilename = String.valueOf(_taskId) + TASK_THUMBNAIL_SUFFIX + ".png";
        this.mLastThumbnailFile = new File(TaskPersister.sImagesDir, this.mFilename);
        this.taskId = _taskId;
        this.intent = _intent;
        this.affinityIntent = _affinityIntent;
        this.affinity = _affinity;
        this.rootAffinity = _affinity;
        this.voiceSession = null;
        this.voiceInteractor = null;
        this.realActivity = _realActivity;
        this.origActivity = _origActivity;
        this.rootWasReset = _rootWasReset;
        this.isAvailable = IGNORE_RETURN_TO_RECENTS;
        this.autoRemoveRecents = _autoRemoveRecents;
        this.askedCompatMode = _askedCompatMode;
        this.taskType = _taskType;
        this.mTaskToReturnTo = 1;
        this.userId = _userId;
        this.effectiveUid = _effectiveUid;
        this.firstActiveTime = _firstActiveTime;
        this.lastActiveTime = _lastActiveTime;
        this.lastDescription = _lastDescription;
        this.mActivities = activities;
        this.mLastTimeMoved = lastTimeMoved;
        this.mNeverRelinquishIdentity = neverRelinquishIdentity;
        this.lastTaskDescription = _lastTaskDescription;
        this.mAffiliatedTaskId = taskAffiliation;
        this.mAffiliatedTaskColor = taskAffiliationColor;
        this.mPrevAffiliateTaskId = prevTaskId;
        this.mNextAffiliateTaskId = nextTaskId;
        this.mCallingUid = callingUid;
        this.mCallingPackage = callingPackage;
    }

    void touchActiveTime() {
        this.lastActiveTime = System.currentTimeMillis();
        if (this.firstActiveTime == 0) {
            this.firstActiveTime = this.lastActiveTime;
        }
    }

    long getInactiveDuration() {
        return System.currentTimeMillis() - this.lastActiveTime;
    }

    void setIntent(ActivityRecord r) {
        setIntent(r.intent, r.info);
        this.mCallingUid = r.launchedFromUid;
        this.mCallingPackage = r.launchedFromPackage;
    }

    private void setIntent(Intent _intent, ActivityInfo info) {
        int intentFlags;
        if (this.intent == null) {
            this.mNeverRelinquishIdentity = (info.flags & DumpState.DUMP_VERSION) == 0 ? IGNORE_RETURN_TO_RECENTS : false;
        } else if (this.mNeverRelinquishIdentity) {
            return;
        }
        this.affinity = info.taskAffinity;
        if (this.intent == null) {
            this.rootAffinity = this.affinity;
        }
        this.effectiveUid = info.applicationInfo.uid;
        this.stringName = null;
        if (info.targetActivity == null) {
            if (!(_intent == null || (_intent.getSelector() == null && _intent.getSourceBounds() == null))) {
                Intent _intent2 = new Intent(_intent);
                _intent2.setSelector(null);
                _intent2.setSourceBounds(null);
                _intent = _intent2;
            }
            this.intent = _intent;
            this.realActivity = _intent != null ? _intent.getComponent() : null;
            this.origActivity = null;
        } else {
            ComponentName targetComponent = new ComponentName(info.packageName, info.targetActivity);
            if (_intent != null) {
                Intent targetIntent = new Intent(_intent);
                targetIntent.setComponent(targetComponent);
                targetIntent.setSelector(null);
                targetIntent.setSourceBounds(null);
                this.intent = targetIntent;
                this.realActivity = targetComponent;
                this.origActivity = _intent.getComponent();
            } else {
                this.intent = null;
                this.realActivity = targetComponent;
                this.origActivity = new ComponentName(info.packageName, info.name);
            }
        }
        if (this.intent == null) {
            intentFlags = 0;
        } else {
            intentFlags = this.intent.getFlags();
        }
        if ((2097152 & intentFlags) != 0) {
            this.rootWasReset = IGNORE_RETURN_TO_RECENTS;
        }
        this.userId = UserHandle.getUserId(info.applicationInfo.uid);
        if ((info.flags & DumpState.DUMP_INSTALLS) != 0) {
            this.autoRemoveRecents = IGNORE_RETURN_TO_RECENTS;
        } else if ((532480 & intentFlags) != 524288) {
            this.autoRemoveRecents = false;
        } else if (info.documentLaunchMode != 0) {
            this.autoRemoveRecents = false;
        } else {
            this.autoRemoveRecents = IGNORE_RETURN_TO_RECENTS;
        }
    }

    void setTaskToReturnTo(int taskToReturnTo) {
        if (taskToReturnTo == 2) {
            taskToReturnTo = 1;
        }
        this.mTaskToReturnTo = taskToReturnTo;
    }

    int getTaskToReturnTo() {
        return this.mTaskToReturnTo;
    }

    void setPrevAffiliate(TaskRecord prevAffiliate) {
        this.mPrevAffiliate = prevAffiliate;
        this.mPrevAffiliateTaskId = prevAffiliate == null ? INVALID_TASK_ID : prevAffiliate.taskId;
    }

    void setNextAffiliate(TaskRecord nextAffiliate) {
        this.mNextAffiliate = nextAffiliate;
        this.mNextAffiliateTaskId = nextAffiliate == null ? INVALID_TASK_ID : nextAffiliate.taskId;
    }

    void closeRecentsChain() {
        if (this.mPrevAffiliate != null) {
            this.mPrevAffiliate.setNextAffiliate(this.mNextAffiliate);
        }
        if (this.mNextAffiliate != null) {
            this.mNextAffiliate.setPrevAffiliate(this.mPrevAffiliate);
        }
        setPrevAffiliate(null);
        setNextAffiliate(null);
    }

    void removedFromRecents() {
        disposeThumbnail();
        closeRecentsChain();
        if (this.inRecents) {
            this.inRecents = false;
            this.mService.notifyTaskPersisterLocked(this, false);
        }
    }

    void setTaskToAffiliateWith(TaskRecord taskToAffiliateWith) {
        closeRecentsChain();
        this.mAffiliatedTaskId = taskToAffiliateWith.mAffiliatedTaskId;
        this.mAffiliatedTaskColor = taskToAffiliateWith.mAffiliatedTaskColor;
        while (taskToAffiliateWith.mNextAffiliate != null) {
            TaskRecord nextRecents = taskToAffiliateWith.mNextAffiliate;
            if (nextRecents.mAffiliatedTaskId != this.mAffiliatedTaskId) {
                Slog.e("ActivityManager", "setTaskToAffiliateWith: nextRecents=" + nextRecents + " affilTaskId=" + nextRecents.mAffiliatedTaskId + " should be " + this.mAffiliatedTaskId);
                if (nextRecents.mPrevAffiliate == taskToAffiliateWith) {
                    nextRecents.setPrevAffiliate(null);
                }
                taskToAffiliateWith.setNextAffiliate(null);
                taskToAffiliateWith.setNextAffiliate(this);
                setPrevAffiliate(taskToAffiliateWith);
                setNextAffiliate(null);
            }
            taskToAffiliateWith = nextRecents;
        }
        taskToAffiliateWith.setNextAffiliate(this);
        setPrevAffiliate(taskToAffiliateWith);
        setNextAffiliate(null);
    }

    boolean setLastThumbnail(Bitmap thumbnail) {
        if (this.mLastThumbnail == thumbnail) {
            return false;
        }
        this.mLastThumbnail = thumbnail;
        if (thumbnail != null) {
            this.mService.mTaskPersister.saveImage(thumbnail, this.mFilename);
        } else if (this.mLastThumbnailFile != null) {
            this.mLastThumbnailFile.delete();
        }
        return IGNORE_RETURN_TO_RECENTS;
    }

    void getLastThumbnail(TaskThumbnail thumbs) {
        thumbs.mainThumbnail = this.mLastThumbnail;
        thumbs.thumbnailFileDescriptor = null;
        if (this.mLastThumbnail == null) {
            thumbs.mainThumbnail = this.mService.mTaskPersister.getImageFromWriteQueue(this.mFilename);
        }
        if (thumbs.mainThumbnail == null && this.mLastThumbnailFile.exists()) {
            try {
                thumbs.thumbnailFileDescriptor = ParcelFileDescriptor.open(this.mLastThumbnailFile, 268435456);
            } catch (IOException e) {
            }
        }
    }

    void freeLastThumbnail() {
        this.mLastThumbnail = null;
    }

    void disposeThumbnail() {
        this.mLastThumbnail = null;
        this.lastDescription = null;
    }

    Intent getBaseIntent() {
        return this.intent != null ? this.intent : this.affinityIntent;
    }

    ActivityRecord getRootActivity() {
        for (int i = 0; i < this.mActivities.size(); i++) {
            ActivityRecord activityRecord = (ActivityRecord) this.mActivities.get(i);
            if (!activityRecord.finishing) {
                return activityRecord;
            }
        }
        return null;
    }

    ActivityRecord getTopActivity() {
        for (int i = this.mActivities.size() + INVALID_TASK_ID; i >= 0; i += INVALID_TASK_ID) {
            ActivityRecord activityRecord = (ActivityRecord) this.mActivities.get(i);
            if (!activityRecord.finishing) {
                return activityRecord;
            }
        }
        return null;
    }

    ActivityRecord topRunningActivityLocked(ActivityRecord notTop) {
        for (int activityNdx = this.mActivities.size() + INVALID_TASK_ID; activityNdx >= 0; activityNdx += INVALID_TASK_ID) {
            ActivityRecord r = (ActivityRecord) this.mActivities.get(activityNdx);
            if (!r.finishing && r != notTop && this.stack.okToShowLocked(r)) {
                return r;
            }
        }
        return null;
    }

    final void setFrontOfTask() {
        boolean foundFront = false;
        int numActivities = this.mActivities.size();
        for (int activityNdx = 0; activityNdx < numActivities; activityNdx++) {
            ActivityRecord r = (ActivityRecord) this.mActivities.get(activityNdx);
            if (foundFront || r.finishing) {
                r.frontOfTask = false;
            } else {
                r.frontOfTask = IGNORE_RETURN_TO_RECENTS;
                foundFront = IGNORE_RETURN_TO_RECENTS;
            }
        }
        if (!foundFront && numActivities > 0) {
            ((ActivityRecord) this.mActivities.get(0)).frontOfTask = IGNORE_RETURN_TO_RECENTS;
        }
    }

    final void moveActivityToFrontLocked(ActivityRecord newTop) {
        this.mActivities.remove(newTop);
        this.mActivities.add(newTop);
        updateEffectiveIntent();
        setFrontOfTask();
    }

    void addActivityAtBottom(ActivityRecord r) {
        addActivityAtIndex(0, r);
    }

    void addActivityToTop(ActivityRecord r) {
        addActivityAtIndex(this.mActivities.size(), r);
    }

    void addActivityAtIndex(int index, ActivityRecord r) {
        if (!this.mActivities.remove(r) && r.fullscreen) {
            this.numFullscreen++;
        }
        if (this.mActivities.isEmpty()) {
            this.taskType = r.mActivityType;
            this.isPersistable = r.isPersistable();
            this.mCallingUid = r.launchedFromUid;
            this.mCallingPackage = r.launchedFromPackage;
            this.maxRecents = Math.min(Math.max(r.info.maxRecents, 1), ActivityManager.getMaxAppRecentsLimitStatic());
        } else {
            r.mActivityType = this.taskType;
        }
        this.mActivities.add(index, r);
        updateEffectiveIntent();
        if (r.isPersistable()) {
            this.mService.notifyTaskPersisterLocked(this, false);
        }
    }

    boolean removeActivity(ActivityRecord r) {
        if (this.mActivities.remove(r) && r.fullscreen) {
            this.numFullscreen += INVALID_TASK_ID;
        }
        if (r.isPersistable()) {
            this.mService.notifyTaskPersisterLocked(this, false);
        }
        if (!this.mActivities.isEmpty()) {
            updateEffectiveIntent();
            return false;
        } else if (this.mReuseTask) {
            return false;
        } else {
            return IGNORE_RETURN_TO_RECENTS;
        }
    }

    boolean autoRemoveFromRecents() {
        return (this.autoRemoveRecents || (this.mActivities.isEmpty() && !this.hasBeenVisible)) ? IGNORE_RETURN_TO_RECENTS : false;
    }

    final void performClearTaskAtIndexLocked(int activityNdx) {
        int numActivities = this.mActivities.size();
        while (activityNdx < numActivities) {
            ActivityRecord r = (ActivityRecord) this.mActivities.get(activityNdx);
            if (!r.finishing) {
                if (this.stack == null) {
                    r.takeFromHistory();
                    this.mActivities.remove(activityNdx);
                    activityNdx += INVALID_TASK_ID;
                    numActivities += INVALID_TASK_ID;
                } else if (this.stack.finishActivityLocked(r, 0, null, "clear", false)) {
                    activityNdx += INVALID_TASK_ID;
                    numActivities += INVALID_TASK_ID;
                }
            }
            activityNdx++;
        }
    }

    final void performClearTaskLocked() {
        this.mReuseTask = IGNORE_RETURN_TO_RECENTS;
        performClearTaskAtIndexLocked(0);
        this.mReuseTask = false;
    }

    final ActivityRecord performClearTaskLocked(ActivityRecord newR, int launchFlags) {
        int numActivities = this.mActivities.size();
        for (int activityNdx = numActivities + INVALID_TASK_ID; activityNdx >= 0; activityNdx += INVALID_TASK_ID) {
            ActivityRecord r = (ActivityRecord) this.mActivities.get(activityNdx);
            if (!r.finishing && r.realActivity.equals(newR.realActivity)) {
                ActivityRecord ret = r;
                activityNdx++;
                while (activityNdx < numActivities) {
                    r = (ActivityRecord) this.mActivities.get(activityNdx);
                    if (!r.finishing) {
                        ActivityOptions opts = r.takeOptionsLocked();
                        if (opts != null) {
                            ret.updateOptionsLocked(opts);
                        }
                        if (this.stack.finishActivityLocked(r, 0, null, "clear", false)) {
                            activityNdx += INVALID_TASK_ID;
                            numActivities += INVALID_TASK_ID;
                        }
                    }
                    activityNdx++;
                }
                if (ret.launchMode != 0 || (536870912 & launchFlags) != 0 || ret.finishing) {
                    return ret;
                }
                this.stack.finishActivityLocked(ret, 0, null, "clear", false);
                return null;
            }
        }
        return null;
    }

    public TaskThumbnail getTaskThumbnailLocked() {
        if (this.stack != null) {
            ActivityRecord resumedActivity = this.stack.mResumedActivity;
            if (resumedActivity != null && resumedActivity.task == this) {
                setLastThumbnail(this.stack.screenshotActivities(resumedActivity));
            }
        }
        TaskThumbnail taskThumbnail = new TaskThumbnail();
        getLastThumbnail(taskThumbnail);
        return taskThumbnail;
    }

    public void removeTaskActivitiesLocked() {
        performClearTaskAtIndexLocked(0);
    }

    boolean isHomeTask() {
        return this.taskType == 1 ? IGNORE_RETURN_TO_RECENTS : false;
    }

    boolean isApplicationTask() {
        return this.taskType == 0 ? IGNORE_RETURN_TO_RECENTS : false;
    }

    boolean isOverHomeStack() {
        return (this.mTaskToReturnTo == 1 || this.mTaskToReturnTo == 2) ? IGNORE_RETURN_TO_RECENTS : false;
    }

    final ActivityRecord findActivityInHistoryLocked(ActivityRecord r) {
        ComponentName realActivity = r.realActivity;
        for (int activityNdx = this.mActivities.size() + INVALID_TASK_ID; activityNdx >= 0; activityNdx += INVALID_TASK_ID) {
            ActivityRecord candidate = (ActivityRecord) this.mActivities.get(activityNdx);
            if (!candidate.finishing && candidate.realActivity.equals(realActivity)) {
                return candidate;
            }
        }
        return null;
    }

    void updateTaskDescription() {
        boolean relinquish = false;
        int numActivities = this.mActivities.size();
        if (!(numActivities == 0 || (((ActivityRecord) this.mActivities.get(0)).info.flags & DumpState.DUMP_VERSION) == 0)) {
            relinquish = IGNORE_RETURN_TO_RECENTS;
        }
        int activityNdx = Math.min(numActivities, 1);
        while (activityNdx < numActivities) {
            ActivityRecord r = (ActivityRecord) this.mActivities.get(activityNdx);
            if (!relinquish || (r.info.flags & DumpState.DUMP_VERSION) != 0) {
                if (r.intent != null && (r.intent.getFlags() & 524288) != 0) {
                    break;
                }
                activityNdx++;
            } else {
                activityNdx++;
                break;
            }
        }
        if (activityNdx > 0) {
            String label = null;
            String iconFilename = null;
            int colorPrimary = 0;
            for (activityNdx += INVALID_TASK_ID; activityNdx >= 0; activityNdx += INVALID_TASK_ID) {
                r = (ActivityRecord) this.mActivities.get(activityNdx);
                if (r.taskDescription != null) {
                    if (label == null) {
                        label = r.taskDescription.getLabel();
                    }
                    if (iconFilename == null) {
                        iconFilename = r.taskDescription.getIconFilename();
                    }
                    if (colorPrimary == 0) {
                        colorPrimary = r.taskDescription.getPrimaryColor();
                    }
                }
            }
            this.lastTaskDescription = new TaskDescription(label, colorPrimary, iconFilename);
            if (this.taskId == this.mAffiliatedTaskId) {
                this.mAffiliatedTaskColor = this.lastTaskDescription.getPrimaryColor();
            }
        }
    }

    int findEffectiveRootIndex() {
        int effectiveNdx = 0;
        int topActivityNdx = this.mActivities.size() + INVALID_TASK_ID;
        for (int activityNdx = 0; activityNdx <= topActivityNdx; activityNdx++) {
            ActivityRecord r = (ActivityRecord) this.mActivities.get(activityNdx);
            if (!r.finishing) {
                effectiveNdx = activityNdx;
                if ((r.info.flags & DumpState.DUMP_VERSION) == 0) {
                    break;
                }
            }
        }
        return effectiveNdx;
    }

    void updateEffectiveIntent() {
        setIntent((ActivityRecord) this.mActivities.get(findEffectiveRootIndex()));
    }

    void saveToXml(XmlSerializer out) throws IOException, XmlPullParserException {
        out.attribute(null, ATTR_TASKID, String.valueOf(this.taskId));
        if (this.realActivity != null) {
            out.attribute(null, ATTR_REALACTIVITY, this.realActivity.flattenToShortString());
        }
        if (this.origActivity != null) {
            out.attribute(null, ATTR_ORIGACTIVITY, this.origActivity.flattenToShortString());
        }
        if (this.affinity != null) {
            out.attribute(null, ATTR_AFFINITY, this.affinity);
            if (!this.affinity.equals(this.rootAffinity)) {
                out.attribute(null, ATTR_ROOT_AFFINITY, this.rootAffinity != null ? this.rootAffinity : "@");
            }
        } else if (this.rootAffinity != null) {
            out.attribute(null, ATTR_ROOT_AFFINITY, this.rootAffinity != null ? this.rootAffinity : "@");
        }
        out.attribute(null, ATTR_ROOTHASRESET, String.valueOf(this.rootWasReset));
        out.attribute(null, ATTR_AUTOREMOVERECENTS, String.valueOf(this.autoRemoveRecents));
        out.attribute(null, ATTR_ASKEDCOMPATMODE, String.valueOf(this.askedCompatMode));
        out.attribute(null, ATTR_USERID, String.valueOf(this.userId));
        out.attribute(null, ATTR_EFFECTIVE_UID, String.valueOf(this.effectiveUid));
        out.attribute(null, ATTR_TASKTYPE, String.valueOf(this.taskType));
        out.attribute(null, ATTR_FIRSTACTIVETIME, String.valueOf(this.firstActiveTime));
        out.attribute(null, ATTR_LASTACTIVETIME, String.valueOf(this.lastActiveTime));
        out.attribute(null, ATTR_LASTTIMEMOVED, String.valueOf(this.mLastTimeMoved));
        out.attribute(null, ATTR_NEVERRELINQUISH, String.valueOf(this.mNeverRelinquishIdentity));
        if (this.lastDescription != null) {
            out.attribute(null, ATTR_LASTDESCRIPTION, this.lastDescription.toString());
        }
        if (this.lastTaskDescription != null) {
            this.lastTaskDescription.saveToXml(out);
        }
        out.attribute(null, ATTR_TASK_AFFILIATION_COLOR, String.valueOf(this.mAffiliatedTaskColor));
        out.attribute(null, ATTR_TASK_AFFILIATION, String.valueOf(this.mAffiliatedTaskId));
        out.attribute(null, ATTR_PREV_AFFILIATION, String.valueOf(this.mPrevAffiliateTaskId));
        out.attribute(null, ATTR_NEXT_AFFILIATION, String.valueOf(this.mNextAffiliateTaskId));
        out.attribute(null, ATTR_CALLING_UID, String.valueOf(this.mCallingUid));
        out.attribute(null, ATTR_CALLING_PACKAGE, this.mCallingPackage == null ? "" : this.mCallingPackage);
        if (this.affinityIntent != null) {
            out.startTag(null, TAG_AFFINITYINTENT);
            this.affinityIntent.saveToXml(out);
            out.endTag(null, TAG_AFFINITYINTENT);
        }
        out.startTag(null, TAG_INTENT);
        this.intent.saveToXml(out);
        out.endTag(null, TAG_INTENT);
        ArrayList<ActivityRecord> activities = this.mActivities;
        int numActivities = activities.size();
        int activityNdx = 0;
        while (activityNdx < numActivities) {
            ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
            if (r.info.persistableMode != 0 && r.isPersistable()) {
                if ((r.intent.getFlags() & 524288) == 0 || activityNdx <= 0) {
                    out.startTag(null, TAG_ACTIVITY);
                    r.saveToXml(out);
                    out.endTag(null, TAG_ACTIVITY);
                    activityNdx++;
                } else {
                    return;
                }
            }
            return;
        }
    }

    static TaskRecord restoreFromXml(XmlPullParser in, ActivityStackSupervisor stackSupervisor) throws IOException, XmlPullParserException {
        return restoreFromXml(in, stackSupervisor, INVALID_TASK_ID);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    static com.android.server.am.TaskRecord restoreFromXml(org.xmlpull.v1.XmlPullParser r49, com.android.server.am.ActivityStackSupervisor r50, int r51) throws java.io.IOException, org.xmlpull.v1.XmlPullParserException {
        /*
        r8 = 0;
        r9 = 0;
        r21 = new java.util.ArrayList;
        r21.<init>();
        r12 = 0;
        r13 = 0;
        r10 = 0;
        r11 = 0;
        r43 = 0;
        r14 = 0;
        r15 = 0;
        r16 = 0;
        r17 = 0;
        r18 = 0;
        r19 = -1;
        r20 = 0;
        r22 = -1;
        r24 = -1;
        r26 = 0;
        r28 = 1;
        r7 = r51;
        r45 = r49.getDepth();
        r29 = new android.app.ActivityManager$TaskDescription;
        r29.<init>();
        r30 = -1;
        r33 = 0;
        r31 = -1;
        r32 = -1;
        r34 = -1;
        r35 = "";
        r6 = r49.getAttributeCount();
        r39 = r6 + -1;
    L_0x003e:
        if (r39 < 0) goto L_0x021c;
    L_0x0040:
        r0 = r49;
        r1 = r39;
        r38 = r0.getAttributeName(r1);
        r0 = r49;
        r1 = r39;
        r40 = r0.getAttributeValue(r1);
        r6 = "task_id";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x0068;
    L_0x005a:
        r6 = -1;
        if (r7 != r6) goto L_0x0065;
    L_0x005d:
        r6 = java.lang.Integer.valueOf(r40);
        r7 = r6.intValue();
    L_0x0065:
        r39 = r39 + -1;
        goto L_0x003e;
    L_0x0068:
        r6 = "real_activity";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x0077;
    L_0x0072:
        r12 = android.content.ComponentName.unflattenFromString(r40);
        goto L_0x0065;
    L_0x0077:
        r6 = "orig_activity";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x0086;
    L_0x0081:
        r13 = android.content.ComponentName.unflattenFromString(r40);
        goto L_0x0065;
    L_0x0086:
        r6 = "affinity";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x0093;
    L_0x0090:
        r10 = r40;
        goto L_0x0065;
    L_0x0093:
        r6 = "root_affinity";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x00a2;
    L_0x009d:
        r11 = r40;
        r43 = 1;
        goto L_0x0065;
    L_0x00a2:
        r6 = "root_has_reset";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x00b5;
    L_0x00ac:
        r6 = java.lang.Boolean.valueOf(r40);
        r14 = r6.booleanValue();
        goto L_0x0065;
    L_0x00b5:
        r6 = "auto_remove_recents";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x00c8;
    L_0x00bf:
        r6 = java.lang.Boolean.valueOf(r40);
        r15 = r6.booleanValue();
        goto L_0x0065;
    L_0x00c8:
        r6 = "asked_compat_mode";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x00db;
    L_0x00d2:
        r6 = java.lang.Boolean.valueOf(r40);
        r16 = r6.booleanValue();
        goto L_0x0065;
    L_0x00db:
        r6 = "user_id";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x00ef;
    L_0x00e5:
        r6 = java.lang.Integer.valueOf(r40);
        r18 = r6.intValue();
        goto L_0x0065;
    L_0x00ef:
        r6 = "effective_uid";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x0103;
    L_0x00f9:
        r6 = java.lang.Integer.valueOf(r40);
        r19 = r6.intValue();
        goto L_0x0065;
    L_0x0103:
        r6 = "task_type";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x0117;
    L_0x010d:
        r6 = java.lang.Integer.valueOf(r40);
        r17 = r6.intValue();
        goto L_0x0065;
    L_0x0117:
        r6 = "first_active_time";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x012b;
    L_0x0121:
        r6 = java.lang.Long.valueOf(r40);
        r22 = r6.longValue();
        goto L_0x0065;
    L_0x012b:
        r6 = "last_active_time";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x013f;
    L_0x0135:
        r6 = java.lang.Long.valueOf(r40);
        r24 = r6.longValue();
        goto L_0x0065;
    L_0x013f:
        r6 = "last_description";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x014d;
    L_0x0149:
        r20 = r40;
        goto L_0x0065;
    L_0x014d:
        r6 = "last_time_moved";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x0161;
    L_0x0157:
        r6 = java.lang.Long.valueOf(r40);
        r26 = r6.longValue();
        goto L_0x0065;
    L_0x0161:
        r6 = "never_relinquish_identity";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x0175;
    L_0x016b:
        r6 = java.lang.Boolean.valueOf(r40);
        r28 = r6.booleanValue();
        goto L_0x0065;
    L_0x0175:
        r6 = "task_description_";
        r0 = r38;
        r6 = r0.startsWith(r6);
        if (r6 == 0) goto L_0x018a;
    L_0x017f:
        r0 = r29;
        r1 = r38;
        r2 = r40;
        r0.restoreFromXml(r1, r2);
        goto L_0x0065;
    L_0x018a:
        r6 = "task_affiliation";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x019e;
    L_0x0194:
        r6 = java.lang.Integer.valueOf(r40);
        r30 = r6.intValue();
        goto L_0x0065;
    L_0x019e:
        r6 = "prev_affiliation";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x01b2;
    L_0x01a8:
        r6 = java.lang.Integer.valueOf(r40);
        r31 = r6.intValue();
        goto L_0x0065;
    L_0x01b2:
        r6 = "next_affiliation";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x01c6;
    L_0x01bc:
        r6 = java.lang.Integer.valueOf(r40);
        r32 = r6.intValue();
        goto L_0x0065;
    L_0x01c6:
        r6 = "task_affiliation_color";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x01da;
    L_0x01d0:
        r6 = java.lang.Integer.valueOf(r40);
        r33 = r6.intValue();
        goto L_0x0065;
    L_0x01da:
        r6 = "calling_uid";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x01ee;
    L_0x01e4:
        r6 = java.lang.Integer.valueOf(r40);
        r34 = r6.intValue();
        goto L_0x0065;
    L_0x01ee:
        r6 = "calling_package";
        r0 = r38;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x01fc;
    L_0x01f8:
        r35 = r40;
        goto L_0x0065;
    L_0x01fc:
        r6 = "ActivityManager";
        r47 = new java.lang.StringBuilder;
        r47.<init>();
        r48 = "TaskRecord: Unknown attribute=";
        r47 = r47.append(r48);
        r0 = r47;
        r1 = r38;
        r47 = r0.append(r1);
        r47 = r47.toString();
        r0 = r47;
        android.util.Slog.w(r6, r0);
        goto L_0x0065;
    L_0x021c:
        r42 = r49.next();
        r6 = 1;
        r0 = r42;
        if (r0 == r6) goto L_0x0291;
    L_0x0225:
        r6 = 3;
        r0 = r42;
        if (r0 != r6) goto L_0x0232;
    L_0x022a:
        r6 = r49.getDepth();
        r0 = r45;
        if (r6 >= r0) goto L_0x0291;
    L_0x0232:
        r6 = 2;
        r0 = r42;
        if (r0 != r6) goto L_0x021c;
    L_0x0237:
        r44 = r49.getName();
        r6 = "affinity_intent";
        r0 = r44;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x024a;
    L_0x0245:
        r9 = android.content.Intent.restoreFromXml(r49);
        goto L_0x021c;
    L_0x024a:
        r6 = "intent";
        r0 = r44;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x0259;
    L_0x0254:
        r8 = android.content.Intent.restoreFromXml(r49);
        goto L_0x021c;
    L_0x0259:
        r6 = "activity";
        r0 = r44;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x026f;
    L_0x0263:
        r4 = com.android.server.am.ActivityRecord.restoreFromXml(r49, r50);
        if (r4 == 0) goto L_0x021c;
    L_0x0269:
        r0 = r21;
        r0.add(r4);
        goto L_0x021c;
    L_0x026f:
        r6 = "ActivityManager";
        r47 = new java.lang.StringBuilder;
        r47.<init>();
        r48 = "restoreTask: Unexpected name=";
        r47 = r47.append(r48);
        r0 = r47;
        r1 = r44;
        r47 = r0.append(r1);
        r47 = r47.toString();
        r0 = r47;
        android.util.Slog.e(r6, r0);
        com.android.internal.util.XmlUtils.skipCurrentTag(r49);
        goto L_0x021c;
    L_0x0291:
        if (r43 != 0) goto L_0x0316;
    L_0x0293:
        r11 = r10;
    L_0x0294:
        if (r19 > 0) goto L_0x02f6;
    L_0x0296:
        if (r8 == 0) goto L_0x0321;
    L_0x0298:
        r41 = r8;
    L_0x029a:
        r19 = 0;
        if (r41 == 0) goto L_0x02be;
    L_0x029e:
        r46 = android.app.AppGlobals.getPackageManager();
        r6 = r41.getComponent();	 Catch:{ RemoteException -> 0x0326 }
        r6 = r6.getPackageName();	 Catch:{ RemoteException -> 0x0326 }
        r47 = 8704; // 0x2200 float:1.2197E-41 double:4.3003E-320;
        r0 = r46;
        r1 = r47;
        r2 = r18;
        r37 = r0.getApplicationInfo(r6, r1, r2);	 Catch:{ RemoteException -> 0x0326 }
        if (r37 == 0) goto L_0x02be;
    L_0x02b8:
        r0 = r37;
        r0 = r0.uid;	 Catch:{ RemoteException -> 0x0326 }
        r19 = r0;
    L_0x02be:
        r6 = "ActivityManager";
        r47 = new java.lang.StringBuilder;
        r47.<init>();
        r48 = "Updating task #";
        r47 = r47.append(r48);
        r0 = r47;
        r47 = r0.append(r7);
        r48 = " for ";
        r47 = r47.append(r48);
        r0 = r47;
        r1 = r41;
        r47 = r0.append(r1);
        r48 = ": effectiveUid=";
        r47 = r47.append(r48);
        r0 = r47;
        r1 = r19;
        r47 = r0.append(r1);
        r47 = r47.toString();
        r0 = r47;
        android.util.Slog.w(r6, r0);
    L_0x02f6:
        r5 = new com.android.server.am.TaskRecord;
        r0 = r50;
        r6 = r0.mService;
        r5.<init>(r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r24, r26, r28, r29, r30, r31, r32, r33, r34, r35);
        r6 = r21.size();
        r36 = r6 + -1;
    L_0x0305:
        if (r36 < 0) goto L_0x0325;
    L_0x0307:
        r0 = r21;
        r1 = r36;
        r6 = r0.get(r1);
        r6 = (com.android.server.am.ActivityRecord) r6;
        r6.task = r5;
        r36 = r36 + -1;
        goto L_0x0305;
    L_0x0316:
        r6 = "@";
        r6 = r6.equals(r11);
        if (r6 == 0) goto L_0x0294;
    L_0x031e:
        r11 = 0;
        goto L_0x0294;
    L_0x0321:
        r41 = r9;
        goto L_0x029a;
    L_0x0325:
        return r5;
    L_0x0326:
        r6 = move-exception;
        goto L_0x02be;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.TaskRecord.restoreFromXml(org.xmlpull.v1.XmlPullParser, com.android.server.am.ActivityStackSupervisor, int):com.android.server.am.TaskRecord");
    }

    void dump(PrintWriter pw, String prefix) {
        pw.print(prefix);
        pw.print("userId=");
        pw.print(this.userId);
        pw.print(" effectiveUid=");
        UserHandle.formatUid(pw, this.effectiveUid);
        pw.print(" mCallingUid=");
        UserHandle.formatUid(pw, this.mCallingUid);
        pw.print(" mCallingPackage=");
        pw.println(this.mCallingPackage);
        if (!(this.affinity == null && this.rootAffinity == null)) {
            pw.print(prefix);
            pw.print("affinity=");
            pw.print(this.affinity);
            if (this.affinity == null || !this.affinity.equals(this.rootAffinity)) {
                pw.print(" root=");
                pw.println(this.rootAffinity);
            } else {
                pw.println();
            }
        }
        if (!(this.voiceSession == null && this.voiceInteractor == null)) {
            pw.print(prefix);
            pw.print("VOICE: session=0x");
            pw.print(Integer.toHexString(System.identityHashCode(this.voiceSession)));
            pw.print(" interactor=0x");
            pw.println(Integer.toHexString(System.identityHashCode(this.voiceInteractor)));
        }
        if (this.intent != null) {
            StringBuilder sb = new StringBuilder(DumpState.DUMP_PROVIDERS);
            sb.append(prefix);
            sb.append("intent={");
            this.intent.toShortString(sb, false, IGNORE_RETURN_TO_RECENTS, false, IGNORE_RETURN_TO_RECENTS);
            sb.append('}');
            pw.println(sb.toString());
        }
        if (this.affinityIntent != null) {
            sb = new StringBuilder(DumpState.DUMP_PROVIDERS);
            sb.append(prefix);
            sb.append("affinityIntent={");
            this.affinityIntent.toShortString(sb, false, IGNORE_RETURN_TO_RECENTS, false, IGNORE_RETURN_TO_RECENTS);
            sb.append('}');
            pw.println(sb.toString());
        }
        if (this.origActivity != null) {
            pw.print(prefix);
            pw.print("origActivity=");
            pw.println(this.origActivity.flattenToShortString());
        }
        if (this.realActivity != null) {
            pw.print(prefix);
            pw.print("realActivity=");
            pw.println(this.realActivity.flattenToShortString());
        }
        if (!(!this.autoRemoveRecents && !this.isPersistable && this.taskType == 0 && this.mTaskToReturnTo == 0 && this.numFullscreen == 0)) {
            pw.print(prefix);
            pw.print("autoRemoveRecents=");
            pw.print(this.autoRemoveRecents);
            pw.print(" isPersistable=");
            pw.print(this.isPersistable);
            pw.print(" numFullscreen=");
            pw.print(this.numFullscreen);
            pw.print(" taskType=");
            pw.print(this.taskType);
            pw.print(" mTaskToReturnTo=");
            pw.println(this.mTaskToReturnTo);
        }
        if (this.rootWasReset || this.mNeverRelinquishIdentity || this.mReuseTask) {
            pw.print(prefix);
            pw.print("rootWasReset=");
            pw.print(this.rootWasReset);
            pw.print(" mNeverRelinquishIdentity=");
            pw.print(this.mNeverRelinquishIdentity);
            pw.print(" mReuseTask=");
            pw.println(this.mReuseTask);
        }
        if (!(this.mAffiliatedTaskId == this.taskId && this.mPrevAffiliateTaskId == INVALID_TASK_ID && this.mPrevAffiliate == null && this.mNextAffiliateTaskId == INVALID_TASK_ID && this.mNextAffiliate == null)) {
            pw.print(prefix);
            pw.print("affiliation=");
            pw.print(this.mAffiliatedTaskId);
            pw.print(" prevAffiliation=");
            pw.print(this.mPrevAffiliateTaskId);
            pw.print(" (");
            if (this.mPrevAffiliate == null) {
                pw.print("null");
            } else {
                pw.print(Integer.toHexString(System.identityHashCode(this.mPrevAffiliate)));
            }
            pw.print(") nextAffiliation=");
            pw.print(this.mNextAffiliateTaskId);
            pw.print(" (");
            if (this.mNextAffiliate == null) {
                pw.print("null");
            } else {
                pw.print(Integer.toHexString(System.identityHashCode(this.mNextAffiliate)));
            }
            pw.println(")");
        }
        pw.print(prefix);
        pw.print("Activities=");
        pw.println(this.mActivities);
        if (!(this.askedCompatMode && this.inRecents && this.isAvailable)) {
            pw.print(prefix);
            pw.print("askedCompatMode=");
            pw.print(this.askedCompatMode);
            pw.print(" inRecents=");
            pw.print(this.inRecents);
            pw.print(" isAvailable=");
            pw.println(this.isAvailable);
        }
        pw.print(prefix);
        pw.print("lastThumbnail=");
        pw.print(this.mLastThumbnail);
        pw.print(" lastThumbnailFile=");
        pw.println(this.mLastThumbnailFile);
        if (this.lastDescription != null) {
            pw.print(prefix);
            pw.print("lastDescription=");
            pw.println(this.lastDescription);
        }
        pw.print(prefix);
        pw.print("hasBeenVisible=");
        pw.print(this.hasBeenVisible);
        pw.print(" firstActiveTime=");
        pw.print(this.lastActiveTime);
        pw.print(" lastActiveTime=");
        pw.print(this.lastActiveTime);
        pw.print(" (inactive for ");
        pw.print(getInactiveDuration() / 1000);
        pw.println("s)");
    }

    public String toString() {
        StringBuilder sb = new StringBuilder(DumpState.DUMP_PROVIDERS);
        if (this.stringName != null) {
            sb.append(this.stringName);
            sb.append(" U=");
            sb.append(this.userId);
            sb.append(" sz=");
            sb.append(this.mActivities.size());
            sb.append('}');
            return sb.toString();
        }
        sb.append("TaskRecord{");
        sb.append(Integer.toHexString(System.identityHashCode(this)));
        sb.append(" #");
        sb.append(this.taskId);
        if (this.affinity != null) {
            sb.append(" A=");
            sb.append(this.affinity);
        } else if (this.intent != null) {
            sb.append(" I=");
            sb.append(this.intent.getComponent().flattenToShortString());
        } else if (this.affinityIntent != null) {
            sb.append(" aI=");
            sb.append(this.affinityIntent.getComponent().flattenToShortString());
        } else {
            sb.append(" ??");
        }
        this.stringName = sb.toString();
        return toString();
    }
}
