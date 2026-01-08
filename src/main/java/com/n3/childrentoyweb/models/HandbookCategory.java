package com.n3.childrentoyweb.models;

import java.time.LocalDateTime;

public class HandbookCategory extends BaseModel{
    private Long categoryId;
    private Long handbookId;

    public HandbookCategory(Long id, Boolean isActive, LocalDateTime createdAt, Long categoryId, Long handbookId) {
        super(id, isActive, createdAt);
        this.categoryId = categoryId;
        this.handbookId = handbookId;
    }

    public HandbookCategory(Long categoryId, Long handbookId) {
        this.categoryId = categoryId;
        this.handbookId = handbookId;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public Long getHandbookId() {
        return handbookId;
    }

    public void setHandbookId(Long handbookId) {
        this.handbookId = handbookId;
    }
}
