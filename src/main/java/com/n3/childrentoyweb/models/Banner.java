package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class Banner extends BaseModel {
    private String title;
    private String imgPath;
    private String groupTag;
    private Integer sortOrder;
    private Long eventId;

    public Banner( String title, String imgPath, String groupTag, Integer sortOrder, Long eventId) {
        this.title = title;
        this.imgPath = imgPath;
        this.groupTag = groupTag;
        this.sortOrder = sortOrder;
        this.eventId = eventId;
    }

    public String getTitle() {
        return title;
    }

    public String getImgPath() {
        return imgPath;
    }

    public String getGroupTag() {
        return groupTag;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public Long getEventId() {
        return eventId;
    }
}
