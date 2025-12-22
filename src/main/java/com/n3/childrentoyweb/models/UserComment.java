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

    public String getContent() {
        return content;
    }

    public Long getUserId() {
        return userId;
    }

    public Long getProductId() {
        return productId;
    }

    public UserComment(Long id, String content, Long userId, Long productId,Boolean isActive,LocalDateTime createdAt) {
        super(id,isActive,createdAt);
        this.content = content;
        this.userId = userId;
        this.productId = productId;
    }

    public UserComment( String content, Long userId, Long productId) {
        this.content = content;
        this.userId = userId;
        this.productId = productId;
    }
    
    
}
