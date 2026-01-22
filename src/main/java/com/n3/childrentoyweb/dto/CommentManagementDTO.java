package com.n3.childrentoyweb.dto;

import java.time.LocalDateTime;

public class CommentManagementDTO {
    private long commentId;
    private String user;
    private String product;
    private String content;
    private boolean isActive;
    private LocalDateTime createdAt;

    public CommentManagementDTO() {}

    public CommentManagementDTO(long commentId, String user, String product, String content, boolean isActive, LocalDateTime createdAt) {
        this.commentId = commentId;
        this.user = user;
        this.product = product;
        this.content = content;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    public long getCommentId() {
        return commentId;
    }

    public void setCommentId(long commentId) {
        this.commentId = commentId;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "CommentManagementDTO{" +
                "commentId=" + commentId +
                ", user='" + user + '\'' +
                ", product='" + product + '\'' +
                ", content='" + content + '\'' +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                '}';
    }
}
