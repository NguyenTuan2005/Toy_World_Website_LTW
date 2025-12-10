package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class UserComment extends BaseModel {
    private String content;
    private Long userId;
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

    public UserComment( String content, Long userId, Long productId) {
        this.content = content;
        this.userId = userId;
        this.productId = productId;
    }
    
    
}
