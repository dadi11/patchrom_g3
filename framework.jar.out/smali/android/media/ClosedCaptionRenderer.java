package android.media;

import android.content.Context;
import android.media.SubtitleController.Renderer;

public class ClosedCaptionRenderer extends Renderer {
    private final Context mContext;
    private ClosedCaptionWidget mRenderingWidget;

    public ClosedCaptionRenderer(Context context) {
        this.mContext = context;
    }

    public boolean supports(MediaFormat format) {
        if (format.containsKey(MediaFormat.KEY_MIME)) {
            return format.getString(MediaFormat.KEY_MIME).equals(MediaPlayer.MEDIA_MIMETYPE_TEXT_CEA_608);
        }
        return false;
    }

    public SubtitleTrack createTrack(MediaFormat format) {
        if (this.mRenderingWidget == null) {
            this.mRenderingWidget = new ClosedCaptionWidget(this.mContext);
        }
        return new ClosedCaptionTrack(this.mRenderingWidget, format);
    }
}
