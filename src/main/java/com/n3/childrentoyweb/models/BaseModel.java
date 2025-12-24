package com.n3.childrentoyweb.models;



import org.apache.taglibs.standard.lang.jstl.UnaryMinusOperator;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.io.Serializable;
import java.time.LocalDateTime;


public abstract class BaseModel implements Serializable {
    @ColumnName("id")
    protected Long id;

    @ColumnName("is_active")
    protected Boolean isActive;

    @ColumnName("created_at")
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

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }


    public Boolean getActive() {
        return isActive;
    }

    public void setActive(Boolean active) {
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
        return "BaseModel{" +
                "id=" + id +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                '}';
    }
}
