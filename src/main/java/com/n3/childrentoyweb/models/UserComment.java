package com.n3.childrentoyweb.models;


import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class UserComment extends BaseModel {

    @ColumnName("content")
    private String content;

    @ColumnName("user_id")
    private Long userId;

    @ColumnName("product_id")
    private Long productId;

    public UserComment(Long id, Boolean isActive, LocalDateTime createdAt, Long productId, String content, Long userId) {
        super(id, isActive, createdAt);
        this.productId = productId;
        this.content = content;
        this.userId = userId;
    }

    public UserComment(){}

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
