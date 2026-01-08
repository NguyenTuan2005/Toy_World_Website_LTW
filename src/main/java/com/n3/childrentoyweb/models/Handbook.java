package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class Handbook extends BaseModel {
    private Long userId;
    private String title;
    private Long views;
    private String status;
    private Long categoryHandBookId;

    public Handbook(){}

    public Handbook( Long userId, String title, Long views, String status, Long categoryHandBookId) {
        this.userId = userId;
        this.title = title;
        this.views = views;
        this.status = status;
        this.categoryHandBookId = categoryHandBookId;
    }

    public Handbook(Long id, Long userId, String title, Long views, String status, Long categoryHandBookId, Boolean isActive,LocalDateTime createdAt) {
        super(id,isActive,createdAt);
        this.userId = userId;
        this.title = title;
        this.views = views;
        this.status = status;
        this.categoryHandBookId = categoryHandBookId;
    }

    public Long getUserId() {
        return userId;
    }

    public String getTitle() {
        return title;
    }

    public Long getViews() {
        return views;
    }

    public String getStatus() {
        return status;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setViews(Long views) {
        this.views = views;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void revertStatus(){
        this.status = ( "POSTED".equals(this.status) ? "HIDDEN":"POSTED");
    }

    public void setCategoryHandBookId(Long categoryHandBookId) {
        this.categoryHandBookId = categoryHandBookId;
    }

    public Long getCategoryHandBookId() {
        return categoryHandBookId;
    }

    @Override
    public String toString() {
        return "Handbook{" +
                "userId=" + userId +
                ", title='" + title + '\'' +
                ", views=" + views +
                ", status='" + status + '\'' +
                ", categoryHandBookId=" + categoryHandBookId +
                ", id=" + id +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                '}';
    }
}
