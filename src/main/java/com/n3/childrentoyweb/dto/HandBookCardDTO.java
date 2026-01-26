package com.n3.childrentoyweb.dto;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

public class HandBookCardDTO {
    private Long id;
    private Long userId;
    private Long views;
    private String title;
    private String description;
    private String firstImage;
    private String status;
    private LocalDateTime createdAt;
    private String username;

    public HandBookCardDTO() {
    }

    public HandBookCardDTO(Long id, Long userId, Long views, String title, String description, String firstImage) {
        this.id = id;
        this.userId = userId;
        this.views = views;
        this.title = title;
        this.description = description;
        this.firstImage = firstImage;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Date getCreatedAtAsDate() {
        return createdAt != null ? Timestamp.valueOf(createdAt) : null;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getViews() {
        return views;
    }

    public void setViews(Long views) {
        this.views = views;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "HandBookCardDTO{" +
                "id=" + id +
                ", userId=" + userId +
                ", views=" + views +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", firstImage='" + firstImage + '\'' +
                ", status='" + status + '\'' +
                '}';
    }

    public String getFirstImage() {
        return firstImage;
    }

    public void setFirstImage(String firstImage) {
        this.firstImage = firstImage;
    }
}
