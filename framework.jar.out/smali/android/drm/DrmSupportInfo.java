package android.drm;

import android.net.ProxyInfo;
import java.util.ArrayList;
import java.util.Iterator;

public class DrmSupportInfo {
    private String mDescription;
    private final ArrayList<String> mFileSuffixList;
    private final ArrayList<String> mMimeTypeList;

    public DrmSupportInfo() {
        this.mFileSuffixList = new ArrayList();
        this.mMimeTypeList = new ArrayList();
        this.mDescription = ProxyInfo.LOCAL_EXCL_LIST;
    }

    public void addMimeType(String mimeType) {
        if (mimeType == null) {
            throw new IllegalArgumentException("mimeType is null");
        } else if (mimeType == ProxyInfo.LOCAL_EXCL_LIST) {
            throw new IllegalArgumentException("mimeType is an empty string");
        } else {
            this.mMimeTypeList.add(mimeType);
        }
    }

    public void addFileSuffix(String fileSuffix) {
        if (fileSuffix == ProxyInfo.LOCAL_EXCL_LIST) {
            throw new IllegalArgumentException("fileSuffix is an empty string");
        }
        this.mFileSuffixList.add(fileSuffix);
    }

    public Iterator<String> getMimeTypeIterator() {
        return this.mMimeTypeList.iterator();
    }

    public Iterator<String> getFileSuffixIterator() {
        return this.mFileSuffixList.iterator();
    }

    public void setDescription(String description) {
        if (description == null) {
            throw new IllegalArgumentException("description is null");
        } else if (description == ProxyInfo.LOCAL_EXCL_LIST) {
            throw new IllegalArgumentException("description is an empty string");
        } else {
            this.mDescription = description;
        }
    }

    public String getDescriprition() {
        return this.mDescription;
    }

    public String getDescription() {
        return this.mDescription;
    }

    public int hashCode() {
        return (this.mFileSuffixList.hashCode() + this.mMimeTypeList.hashCode()) + this.mDescription.hashCode();
    }

    public boolean equals(Object object) {
        if (!(object instanceof DrmSupportInfo)) {
            return false;
        }
        DrmSupportInfo info = (DrmSupportInfo) object;
        if (this.mFileSuffixList.equals(info.mFileSuffixList) && this.mMimeTypeList.equals(info.mMimeTypeList) && this.mDescription.equals(info.mDescription)) {
            return true;
        }
        return false;
    }

    boolean isSupportedMimeType(String mimeType) {
        if (!(mimeType == null || mimeType.equals(ProxyInfo.LOCAL_EXCL_LIST))) {
            for (int i = 0; i < this.mMimeTypeList.size(); i++) {
                if (((String) this.mMimeTypeList.get(i)).startsWith(mimeType)) {
                    return true;
                }
            }
        }
        return false;
    }

    boolean isSupportedFileSuffix(String fileSuffix) {
        return this.mFileSuffixList.contains(fileSuffix);
    }
}
