package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class Handbook extends BaseModel {
    private Long userId;
    private String title;
    private Long views;
    private String status;
    private Long categoryHandBookId;

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

    public Long getCategoryHandBookId() {
        return categoryHandBookId;
    }
}
