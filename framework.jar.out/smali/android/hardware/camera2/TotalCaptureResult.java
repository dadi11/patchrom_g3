package android.hardware.camera2;

import android.hardware.camera2.impl.CameraMetadataNative;
import android.hardware.camera2.impl.CaptureResultExtras;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public final class TotalCaptureResult extends CaptureResult {
    private final List<CaptureResult> mPartialResults;

    public TotalCaptureResult(CameraMetadataNative results, CaptureRequest parent, CaptureResultExtras extras, List<CaptureResult> partials) {
        super(results, parent, extras);
        if (partials == null) {
            this.mPartialResults = new ArrayList();
        } else {
            this.mPartialResults = partials;
        }
    }

    public TotalCaptureResult(CameraMetadataNative results, int sequenceId) {
        super(results, sequenceId);
        this.mPartialResults = new ArrayList();
    }

    public List<CaptureResult> getPartialResults() {
        return Collections.unmodifiableList(this.mPartialResults);
    }
}
