package com.n3.childrentoyweb.models;


import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;


public class Banner extends BaseModel {
    @ColumnName("title")
    private String title;

    @ColumnName("img_path")
    private String imgPath;

    @ColumnName("group_tag")
    private String groupTag;

    @ColumnName("sort_order")
    private Integer sortOrder;

    @ColumnName("event_id")
    private Long eventId;

    public Banner() {}

    public Banner(String imgPath){
        this.imgPath = imgPath;
    }

    public Banner(Long id, String title, String imgPath, String groupTag, Integer sortOrder, Long eventId, Boolean isActive, LocalDateTime createdAt) {
        super(id, isActive, createdAt);
        this.title = title;
        this.imgPath = imgPath;
        this.groupTag = groupTag;
        this.sortOrder = sortOrder;
        this.eventId = eventId;
    }

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

    public void setTitle(String title) {
        this.title = title;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public void setGroupTag(String groupTag) {
        this.groupTag = groupTag;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public void setEventId(Long eventId) {
        this.eventId = eventId;
    }

    public Long getEventId() {
        return eventId;
    }

    @Override
    public String toString() {
        return "Banner{" +
                "title='" + title + '\'' +
                ", imgPath='" + imgPath + '\'' +
                ", groupTag='" + groupTag + '\'' +
                ", sortOrder=" + sortOrder +
                ", eventId=" + eventId +
                ", "+super.toString()+
                '}';
    }
}
