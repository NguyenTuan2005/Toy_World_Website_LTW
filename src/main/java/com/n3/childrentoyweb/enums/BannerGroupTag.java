package com.n3.childrentoyweb.enums;

public enum BannerGroupTag {
    HOME("TRANG_CHU"),PROMOTION("KHUYEN_MAI"),HANDBOOK("CAM_NANG");

    private String tag;

    BannerGroupTag(String tag) {
        this.tag = tag;
    }
    public String getTag() {
        return tag;
    }
}
