package android.text.style;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Parcel;
import android.text.ParcelableSpan;
import android.view.View;

public class URLSpan extends ClickableSpan implements ParcelableSpan {
    private final String mURL;

    public URLSpan(String url) {
        this.mURL = url;
    }

    public URLSpan(Parcel src) {
        this.mURL = src.readString();
    }

    public int getSpanTypeId() {
        return 11;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(this.mURL);
    }

    public String getURL() {
        return this.mURL;
    }

    public void onClick(View widget) {
        Uri uri = Uri.parse(getURL());
        Context context = widget.getContext();
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        intent.putExtra("com.android.browser.application_id", context.getPackageName());
        context.startActivity(intent);
    }
}
