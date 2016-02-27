package com.android.server.job;

import com.android.server.job.controllers.JobStatus;

public interface StateChangedListener {
    void onControllerStateChanged();

    void onRunJobNow(JobStatus jobStatus);
}
