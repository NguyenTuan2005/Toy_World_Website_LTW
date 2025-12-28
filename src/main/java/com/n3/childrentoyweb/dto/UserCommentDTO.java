package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.utils.LocalDateTimeConverterUtil;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class UserCommentDTO {
    private Long id;

    @ColumnName("content")
    private String content;

    @ColumnName("user_id")
    private Long userId;

    private String userName;

    @ColumnName("created_at")
    private LocalDateTime createdAt;

    @ColumnName("product_id")
    private Long productId;


    public UserCommentDTO(Long id, String content, Long userId, String userName, LocalDateTime createdAt, Long productId) {
        this.id = id;
        this.content = content;
        this.userId = userId;
        this.userName = userName;
        this.createdAt = createdAt;
        this.productId = productId;
    }

    public UserCommentDTO(){}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public String getCreatedAtToString() {
        return LocalDateTimeConverterUtil.convertToTimeAgo(createdAt);
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    @Override
    public String toString() {
        return "UserCommentDTO{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", userId=" + userId +
                ", userName='" + userName + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
