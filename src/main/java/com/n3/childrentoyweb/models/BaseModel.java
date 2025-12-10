package com.n3.childrentoyweb.models;



import java.time.LocalDateTime;


public abstract class BaseModel {
    protected Long id;
    protected Boolean isActive;
    protected LocalDateTime createdAt;

    public BaseModel(Long id, Boolean isActive, LocalDateTime createdAt) {
        this.id = id;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    public BaseModel() {
        this.isActive = true;
        this.createdAt = LocalDateTime.now();
    }

    public Long getId() {
        return id;
    }

    public Boolean getActive() {
        return isActive;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
}
