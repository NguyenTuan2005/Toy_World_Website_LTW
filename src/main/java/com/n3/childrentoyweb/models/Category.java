package com.n3.childrentoyweb.models;

import java.time.LocalDateTime;

public class Category extends BaseModel{
    private String name;

    public Category(Long id, Boolean isActive, LocalDateTime createdAt, String name) {
        super(id, isActive, createdAt);
        this.name = name;
    }

    public Category() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
