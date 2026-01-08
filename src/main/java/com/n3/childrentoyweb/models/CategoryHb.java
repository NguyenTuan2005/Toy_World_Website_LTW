package com.n3.childrentoyweb.models;


import java.time.LocalDateTime;

public class CategoryHb extends BaseModel {
    private String name;

    public CategoryHb(Long id, Boolean isActive, LocalDateTime createdAt, String name) {
        super(id, isActive, createdAt);
        this.name = name;
    }

    public CategoryHb(){}

    public CategoryHb(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
